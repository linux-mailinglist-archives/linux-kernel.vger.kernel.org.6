Return-Path: <linux-kernel+bounces-218599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 995A990C271
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2997D1F25C3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA6719B3E4;
	Tue, 18 Jun 2024 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfxKFsCU"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C877290F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681247; cv=none; b=NdQ0iVm3s7hVnK5y8x2dXoEpIbU3CEKFYvVsgr7gt3093Qu08vIyGwzRrb2YgtMtWl6zBY9va9WdeBDNxTeurwmM4yZWdiM2wUrftJdFwXEI18Th13s74rvtCuVUrZZM3eOBrVegyunEH/RuDRungOIvgRrs62rTC/OH86DffLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681247; c=relaxed/simple;
	bh=PwDvEKGQMUTBUQzlloS8yAuNoq2NFOFRvpzH/kHqa7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a4gXTkH69RqS1SpuyWRxXhluy4smP4fW1htAcVsBI4YQRQotyLP58hMnmFNa5MUjj50zzWb8YAzRyHN8KVodhXqPyB/Xha5zUnnyTrFL+VffOT3rW8tHKwo5JoOq9+sDxH+9m/UryYxPkdecpBDyPY5Tu+6A7BANQjfPWBfeheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfxKFsCU; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52cc10b5978so1124846e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 20:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718681244; x=1719286044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z9a+aiDWUAko5EXHgSDmbWHvqSyfSRuPyb/I8NtUUo=;
        b=kfxKFsCUjbwIXJNsly+S9sHubvLQsUJBZAOhURu35IjWr4Xh32LwhiiEkC7Ll164A1
         EyxB3y4OYTsg4J4lQBsfGiB8YsKlUZbZ+7A4meKrgu561Ifb+kloT3/6UM2PIOKsXubN
         1hAzEKva2kj7fLi/64uxgYCqSGPn1mNJa+LCa5vtnR+i9Erg3k0ldHGmyMkJm1Vfzgib
         rcpuaTJcLF1xJq4aybASVVBV9s75PEl/RK+jG/ovKvd0VH8iWdHyruA3LwEwlmUVlLbX
         1PVuGh8jlN6vvYLt7y6VaOOEH7fD5layRKSMzkExlFE4gtBxoNc3h0ImewerTf3ie8B3
         yGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718681244; x=1719286044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z9a+aiDWUAko5EXHgSDmbWHvqSyfSRuPyb/I8NtUUo=;
        b=P9znhc6WJtZ+74fBQNtkIMeMWVEY02OwoW1Vno63sMCLciOWyo0EkicDlTkAq5QQdm
         CTn6M8OqUiluIoFz5bzsf6R8pqKTHB9+mV4OKU73+hc74AP0b6HYpE4CuNM5Jg51CtM1
         CAvRxu+0CFUBCr4wYRVRghCom+CNo1oBaKYuD+f9Mi5Kfj38ZLh+EXF6sx0v2PUoe0bf
         hP5m7FUZ8PhaosEqJkTtjXRkeoAJ9Vyvog8B9wb40Fs9oSvD3qzaN3jeYEWCPqQCHjkl
         Gz/10NqBJTux9kuUNmk+A7d4JnO7rFyrx9tOqegqlqUTrhJdmdP2GL3mAMZXGBD/JiWR
         FQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEhRaRwbrcMI5cMtG2EZkLI7F9SKZPDwF6f7zqE8uu8Eh3qfhnF7dLvGV4Tgzlt7SMozn0chRgsUMA1h5Icwrly9uiYav5vYqfFeE6
X-Gm-Message-State: AOJu0YzNGzQpBCyIOh66CQFxYBdTafJO7EeOm1G8SV500tU3UyBPsuBV
	uJHG3kiT4n/OQ/uqVh8Ef99Tk4ed+B6tl2mJT+6zJukPYQEA7V5M/nSJZglGK/TDix4vptS6UC4
	xt+iTXc31KyYqRg18cFOJeM6ARto=
X-Google-Smtp-Source: AGHT+IFE6sEWcgvPtU6BxDzi44k5FkUo5xfBn+1t17DgiU8KOfxx1qHZQB3r/9XpjTBjKJcFefu4EI0T/L2jQJY9Tnc=
X-Received: by 2002:a19:2d06:0:b0:52c:8fba:e2a6 with SMTP id
 2adb3069b0e04-52ca6e6e32cmr6856603e87.41.1718681243979; Mon, 17 Jun 2024
 20:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618020926.1911903-1-zhaoyang.huang@unisoc.com> <ZnD8qYvpyhYtWeHd@casper.infradead.org>
In-Reply-To: <ZnD8qYvpyhYtWeHd@casper.infradead.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Tue, 18 Jun 2024 11:27:12 +0800
Message-ID: <CAGWkznG2Ts0khArZ_X5EYKG7n9=HmcO8d16KVUZ+uQffEc3vrw@mail.gmail.com>
Subject: Re: [PATCH] mm: fix hard lockup in __split_huge_page
To: Matthew Wilcox <willy@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 11:19=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Tue, Jun 18, 2024 at 10:09:26AM +0800, zhaoyang.huang wrote:
> > Hard lockup[2] is reported which should be caused by recursive
> > lock contention of lruvec->lru_lock[1] within __split_huge_page.
> >
> > [1]
> > static void __split_huge_page(struct page *page, struct list_head *list=
,
> >                 pgoff_t end, unsigned int new_order)
> > {
> >         /* lock lru list/PageCompound, ref frozen by page_ref_freeze */
> > //1st lock here
> >         lruvec =3D folio_lruvec_lock(folio);
> >
> >         for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
> >                 __split_huge_page_tail(folio, i, lruvec, list, new_orde=
r);
> >                 /* Some pages can be beyond EOF: drop them from page ca=
che */
> >                 if (head[i].index >=3D end) {
> >                         folio_put(tail);
> >                             __page_cache_release
> > //2nd lock here
> >                                folio_lruvec_relock_irqsave
>
> Why doesn't lockdep catch this?
It is reported by a regression test of the fix patch which aims at the
find_get_entry livelock issue as below. I don't know the details of
the kernel configuration.

https://lore.kernel.org/linux-mm/5f989315-e380-46aa-80d1-ce8608889e5f@marci=
nwanat.pl/

>
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 9859aa4f7553..ea504df46d3b 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -2925,7 +2925,9 @@ static void __split_huge_page(struct page *page, =
struct list_head *list,
> >                               folio_account_cleaned(tail,
> >                                       inode_to_wb(folio->mapping->host)=
);
> >                       __filemap_remove_folio(tail, NULL);
> > +                     unlock_page_lruvec(lruvec);
> >                       folio_put(tail);
> > +                     folio_lruvec_lock(folio);
>
> Why is it safe to drop & reacquire this lock?  Is there nothing we need
> to revalidate?
My stupid. I will take that into consideration in the next version.
>


Return-Path: <linux-kernel+bounces-370217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2249A2999
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41266B25A9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189451DF744;
	Thu, 17 Oct 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUDGmctc"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED151DED5B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183718; cv=none; b=PmxOHxTxDwqMgtCjsmYbU3kP106zdKDgBKFOYqVTQWRKB6dJFP6oxhu+nS343QNnGs3sYoVTTvX9vIALLEIjfzQep9u1f+FKM+4XOL+nfmextbQ4kRrTu/rHsKFNFnpwFLxSJsgHH/gTTXOAy0QuGUDLpEiJmeIKYYFbDMhNZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183718; c=relaxed/simple;
	bh=WbfX/WWn6YqaqAQEqZQwDN8MBV7HVQ4mGkVrDyEGXGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFBKcw/pbupEP8CnP+xjxMku4KFMMI4dkAfAZi+XE+iHWDqNg/7ef3rGQpGrDoWXz0GAzkyB0xk9H7BXTwsUDRJCVsEpWJm2C8TG3cp2M1lYVeFnfNbsvxwwWfM3UeTWQ0jbFPGSdEJFTSvfHXvtdYv924mh8wMoeZsrmRmFWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUDGmctc; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so12589891fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729183711; x=1729788511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNBXnF8EkGs9XWZGSpqQKc9Q7hAXIsj1MCkuRykAZ18=;
        b=OUDGmctc3hosNOLxkICsTKqWEZS2kmB9aRAT1EBt+nUktAF97imZ18gw0PwU/LamIQ
         4hfhHH34GsQGYfqOVbXBrGbQcwBFBwZgezA+bZ45JRW8MrVxW3VLLXr/0JbRKloJhG5f
         Ejl4sy+wFfsf1i74nY2FqW003CLhk7Cv4l2PPJcvgKr2kVXpftg7eg47h0irFbapo+Au
         7xROjpeqKha3re+hs+GblRSGTbS0PRL5A3zHgPrpwBtTazaUu3LPr2xAGkYRDpk0MZsA
         /kuQtnmHTMENxi92Vwrs+9BTBud2lm4FcpiX9FQ4q7INWKKIE+zKzGcAgHtPMWW1Qudf
         KoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183711; x=1729788511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNBXnF8EkGs9XWZGSpqQKc9Q7hAXIsj1MCkuRykAZ18=;
        b=uxI0mezgwdeVuLi70ja00jt4sXgJ8IJpGbRkyClsy+6fex4ar42TEeW1s1IjmRKV+p
         hRyoHKdSef+xmboNFMeFk/zdKixKf0AtLy6pZfAOzCNwldzFELNCf4XO7D+Mh/zbuout
         LjwI2fLErq4eFjlkVdR1ydYhcqlHIbMDT1pauQ+ddhqmRf6ZacXpdO3hv9eWpGbuCytK
         9Nf6AS6HM9qS7QMJUotTrthqO9fB1PIKxuZbIwISU2BXrc5eUKQkz1ujvz6f1Mm1V07w
         M6NzgfD0bMDxE3N8Fn9ye2mSrMgGMDgkH2uniIWa3W2Lkq4Ko9YOU2LzMeT9jxgnKOgT
         L4yw==
X-Forwarded-Encrypted: i=1; AJvYcCXmnefRPmZW4Xnx0nigUidlreiCj8M/w+QZ/wy6rNrTr5kFqsRu6EBTIdgBtIVkbr4RzoTgPnA/ohOskAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpd7DHLQtgpiRl/nbovLUXkgHT5gPm65KN6GKy+E0WgCJImh8H
	Bocdg+iZTiFlXjPWSeUaMgclRrRxn5YckKxyklJknn1OYXzLILK5mMdwuYzOkCtW7uIbZmfuzsu
	EBOSsAWP4jmw6ZV6VFxESfthdHpaXlQ==
X-Google-Smtp-Source: AGHT+IEJsS4W5f1GczZB+/LvZjg6YfvKNdugAQyCCU/NTwLHwhbwS6l83b1W/j4XP1p9dBB5Y5YkawAzZ2DFHu7MyNw=
X-Received: by 2002:a2e:b88b:0:b0:2fa:de52:f03c with SMTP id
 38308e7fff4ca-2fb61b3e705mr58631141fa.5.1729183710963; Thu, 17 Oct 2024
 09:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
 <Zw_d0EVAJkpNJEbA@casper.infradead.org> <CAHbLzkogrubD_rPH7zf1T454r-BsxL951YH=rGAfNqPZJSCGow@mail.gmail.com>
 <2b3572e1-a618-4f86-979d-87f59282fe8f@linux.alibaba.com>
In-Reply-To: <2b3572e1-a618-4f86-979d-87f59282fe8f@linux.alibaba.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 17 Oct 2024 09:48:19 -0700
Message-ID: <CAHbLzkooj5JPbxkgFNWrxkpjaEzYH++DAFRGr87b7jc_WphYQQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read performance
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, hughd@google.com, 
	david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:25=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/10/17 01:33, Yang Shi wrote:
> > On Wed, Oct 16, 2024 at 8:38=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> >>
> >> On Wed, Oct 16, 2024 at 06:09:30PM +0800, Baolin Wang wrote:
> >>> @@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kioc=
b *iocb, struct iov_iter *to)
> >>>                if (folio) {
> >>>                        folio_unlock(folio);
> >>>
> >>> -                     page =3D folio_file_page(folio, index);
> >>> -                     if (PageHWPoison(page)) {
> >>> +                     if (folio_test_hwpoison(folio) ||
> >>> +                         (folio_test_large(folio) &&
> >>> +                          folio_test_has_hwpoisoned(folio))) {
> >>
> >> Hm, so if we have hwpoison set on one page in a folio, we now can't re=
ad
> >> bytes from any page in the folio?  That seems like we've made a bad
> >> situation worse.
> >
> > Yeah, I agree. I think we can fallback to page copy if
> > folio_test_has_hwpoisoned is true. The PG_hwpoison flag is per page.
> >
> > The folio_test_has_hwpoisoned is kept set if the folio split is failed
> > in memory failure handler.
>
> Right. I can still keep the page size copy if
> folio_test_has_hwpoisoned() is true. Some sample changes are as follow.
>
> Moreover, I noticed shmem splice_read() and write() also simply return
> an error if the folio_test_has_hwpoisoned() is true, without any
> fallback to page granularity. I wonder if it is worth adding page
> granularity support as well?

I think you should do the same.

>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7e79b6a96da0..f30e24e529b9 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3111,9 +3111,11 @@ static ssize_t shmem_file_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>
>          for (;;) {
>                  struct folio *folio =3D NULL;
> +               struct page *page =3D NULL;
>                  unsigned long nr, ret;
>                  loff_t end_offset, i_size =3D i_size_read(inode);
>                  size_t fsize;
> +               bool fallback_page_copy =3D false;
>
>                  if (unlikely(iocb->ki_pos >=3D i_size))
>                          break;
> @@ -3127,13 +3129,16 @@ static ssize_t shmem_file_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>                  if (folio) {
>                          folio_unlock(folio);
>
> -                       if (folio_test_hwpoison(folio) ||
> -                           (folio_test_large(folio) &&
> -                            folio_test_has_hwpoisoned(folio))) {
> +                       page =3D folio_file_page(folio, index);
> +                       if (PageHWPoison(page)) {
>                                  folio_put(folio);
>                                  error =3D -EIO;
>                                  break;
>                          }
> +
> +                       if (folio_test_large(folio) &&
> +                           folio_test_has_hwpoisoned(folio))
> +                               fallback_page_copy =3D true;
>                  }
>
>                  /*
> @@ -3147,7 +3152,7 @@ static ssize_t shmem_file_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>                          break;
>                  }
>                  end_offset =3D min_t(loff_t, i_size, iocb->ki_pos +
> to->count);
> -               if (folio)
> +               if (folio && likely(!fallback_page_copy))
>                          fsize =3D folio_size(folio);
>                  else
>                          fsize =3D PAGE_SIZE;
> @@ -3160,8 +3165,13 @@ static ssize_t shmem_file_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>                           * virtual addresses, take care about potential
> aliasing
>                           * before reading the page on the kernel side.
>                           */
> -                       if (mapping_writably_mapped(mapping))
> -                               flush_dcache_folio(folio);
> +                       if (mapping_writably_mapped(mapping)) {
> +                               if (unlikely(fallback_page_copy))
> +                                       flush_dcache_page(page);
> +                               else
> +                                       flush_dcache_folio(folio);
> +                       }
> +
>                          /*
>                           * Mark the page accessed if we read the beginni=
ng.
>                           */
> @@ -3171,7 +3181,10 @@ static ssize_t shmem_file_read_iter(struct kiocb
> *iocb, struct iov_iter *to)
>                           * Ok, we have the page, and it's up-to-date, so
>                           * now we can copy it to user space...
>                           */
> -                       ret =3D copy_folio_to_iter(folio, offset, nr, to)=
;
> +                       if (unlikely(fallback_page_copy))
> +                               ret =3D copy_page_to_iter(page, offset,
> nr, to);
> +                       else
> +                               ret =3D copy_folio_to_iter(folio, offset,
> nr, to);
>                          folio_put(folio);
>                  } else if (user_backed_iter(to)) {
>                          /*

The change seems fine to me.


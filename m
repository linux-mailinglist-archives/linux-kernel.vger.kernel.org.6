Return-Path: <linux-kernel+bounces-516042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CDFA36C56
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 07:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3C4188E5E5
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 06:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0644186E54;
	Sat, 15 Feb 2025 06:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/Ug+r6l"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59202C2ED
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739601656; cv=none; b=HcDRvYioil+un/qCdPzZPw8D1Q2sHIH7gdUO9yqtrwUBcoOBWRpEvDTo50/Gs4lc8Fq/BTp2nmINp47dq+fR/D9FZnWdBf+RkGj7qfw3LADFyZCK3lDxxig4BvVBQt3hoOfyb0+AqoGuUwexLa/St0GJp/9sZOfKi0GwLZcvHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739601656; c=relaxed/simple;
	bh=1B16/QmwXupdbJOh2/6GHlTVnwvcIfluxQE0EXjJ0UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FH8wn/rxV9i9/Mtw6V2b/WYJL5SzwC4wrrrgID0Rl8leouw8w/RGaB5wI1R2naKr2tSGk0VF69Lxg8Crl933VALxxrWYWDcgVJ7fyEkbxVp8nS4Q+iMlTfE01gVHri9ktgRaSK1ouP87Y7dVBmhai7A6qy1jBafsPUxQPx6rdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/Ug+r6l; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30227c56b11so28970041fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 22:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739601651; x=1740206451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gWBi6Up6x11HbmT+6x2x0ByauKGWbJI59pwdHZK+CQ=;
        b=X/Ug+r6l0x/Jt9Gj+Eu6gnWErqauSMUykUPxWg9QNc1HArCr5Yn4LprUANUWeI4SQZ
         nJiNBPB28KjAAhM1mPnjq+Pa0363dNbIWpXRPzeVjTS+7cj925gBQ+YK8C7jbXD8bMyZ
         Js1wPKyLwXBWVc3dCAGrbtv1dhB+XMLsqXUeXDO404kkRj3xG/Su5Hp832dMAk1YDOfG
         OIjyMYABBrOjaOToZpZb4dRheFmKNA+oBEK4Aq6QTAQHs9puZTo8y6HyHA3HxuiKRMFj
         wzZExOceNyjSSTSVqnSRzMdP7Ivs6rArnJ6YW/AoGuW7MLkTOcFwGjgsn2N7WX5jfxAV
         FaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739601651; x=1740206451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gWBi6Up6x11HbmT+6x2x0ByauKGWbJI59pwdHZK+CQ=;
        b=vra3RGBw67eFSlWV2HtXgIzAiWwiX971EMleI+TQ/EYJW86w0001/y31spJXKbs1Yw
         4x84L2U2Fq7MivyT2LRSXxIBOZtZHBliQE5wppHiFCLt3A99boeNtuhDv7vxHXBrhvTV
         XvxiCvpD5uBH/z8lHxo0AoMIekvshij9CEtYCM94Yq6KsL3smLxt8PP9jpH+6x9mGb7a
         gh8xeGifUyYN3fo0Pt1XCyJsKj3peQChTcTB+BlrhxMkuepJfjyAhfwSQB6tnNHJze3O
         ElS07u4TGlPZAN928cEbEHfIKLKyRhCsLL37pTX6lMK+EdmXzWhPGjf7PDZDfrQQDQm8
         wBgw==
X-Forwarded-Encrypted: i=1; AJvYcCXOhySX8HTKZP+HLqKgXFDqW6stYnu3SgajqbSkkTO+p3OM9TL3rjY1rItAyhS0ufftsIQSiUBo2XcH4hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylvjv3pErelnOPKI840a3nRYkoSVqdueJeByzdY+XkOvOCTHrx
	J0WcoCqzhl52DsSpBAPt7EuBiANTj7P4qoA3EuSgUBpPwURiuJWXiO4Uu2UJAwjmRq197Mf4GdB
	pIEC1c1aO61fJNrd168ZrT+IWZ/U=
X-Gm-Gg: ASbGncs1ZsFGQ6ymYtHQ+MGNfDi+9cCurMZ3MRco3xeoJ1SkuB1cSnLd0cBGp0RxHtu
	XLfyoGIjo0YUdk6E7aJMXoNhqutRHrv6Ogrc4VIM/Wxe+rKFaTYPVx8dhW4tdwO+feeuYKX8z
X-Google-Smtp-Source: AGHT+IFIh2TfvlG1XjoarCicPaxFsb1M8Rn7NNRcEkYSI4lbCLi77OuXLc7EnDahiUIR+Ky4xpF9gHMN0Ve7crgXE74=
X-Received: by 2002:a2e:97d1:0:b0:308:f75f:459 with SMTP id
 38308e7fff4ca-30927ad674bmr7409061fa.26.1739601651075; Fri, 14 Feb 2025
 22:40:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214175709.76029-1-ryncsn@gmail.com> <20250214175709.76029-8-ryncsn@gmail.com>
 <Z6-j924RCEBuDFHO@casper.infradead.org>
In-Reply-To: <Z6-j924RCEBuDFHO@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Sat, 15 Feb 2025 14:40:34 +0800
X-Gm-Features: AWEUYZmOBJ3hBox8YCWZIuZ9QNORd9bHkz-xbOw959EXpHWu4CoYewgEBVyrWyg
Message-ID: <CAMgjq7CRU8gkbC-ehjyMOZmS=bkXiKFKa1YUdgwLUdPXXJuVYg@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm, swap: simplify folio swap allocation
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Hugh Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	"Huang, Ying" <ying.huang@linux.alibaba.com>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 4:13=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Feb 15, 2025 at 01:57:09AM +0800, Kairui Song wrote:
> > @@ -1648,20 +1639,20 @@ static int shmem_writepage(struct page *page, s=
truct writeback_control *wbc)
> >       if (list_empty(&info->swaplist))
> >               list_add(&info->swaplist, &shmem_swaplist);
> >
> > -     if (add_to_swap_cache(folio, swap,
> > -                     __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
> > -                     NULL) =3D=3D 0) {
> > +     if (folio_alloc_swap(folio, __GFP_HIGH | __GFP_NOMEMALLOC | __GFP=
_NOWARN)) {
>
> add_to_swap_cache() returns 0 on success or -errno.
>
> folio_alloc_swap returns true on success.
>
> That would seem to indicate you should change the polarity of this test?

I think I already did? It was (add_to_swap_cache(...) =3D=3D 0), now it's
(folio_alloc_swap(...))

>
> Or should folio_alloc_swap() return an errno?  Is there value in
> distinguishing why we couldn't alloc swap (ENOMEM vs ENOSPC, perhaps?)
>

Good idea, return an error value might be more helpful in the future,
will update this part.


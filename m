Return-Path: <linux-kernel+bounces-368517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01079A10B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42F6FB21CCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567EA2101B7;
	Wed, 16 Oct 2024 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDb4nTyY"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E92D520
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100036; cv=none; b=DK9cvO1d76OF4B+GvMtRdQGN4fwjGwths9VhwYw/IsSgvVBEPIZZsvCE9b2a36JVbOAHiPcto0lZeVKKRi/hfiv69UO15HF8gQ7lJ1oX9OaAd3KxoHCowWaXjXlxhhCkndmGdanX47AEC3rcK+iUm0F30MAxGlEYv2UDGSPTGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100036; c=relaxed/simple;
	bh=gyJH/Ci+RPSQVaEOaWZV2qr9zXN5fKe6fan5uW4cN8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ApiavAva7gPG4ehXjsC9Jz6uK7F0S4p08X1EWsTTSn/ZILx823kQuT93ZGF1WggAzYAJ1UmAIvg7miaZ5fXpyUSxzivUYazfmMiDs3Hr6caz/s6vYYsg+F7r9aDCybwExWbZRGmHvV69Br7eDVDzaBncTdHt7KwjbkbSqtDJ+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CDb4nTyY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so7722966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729100033; x=1729704833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IOikhW/mkeClxBwUKE9q02/XVbq9Al3HpYKbaOM8oc=;
        b=CDb4nTyYPneqSrT74iU/9J2xJYQGDo15pTLwqTMZvEsMQIczEMfEkdYUWHgxho8xtV
         MtHDsHNrghw/RFoNwaX5ssYJcp4bLoR94ckMD/5k9XY9aase7G+edyJhja6mdYzXJdtd
         mMdq3QwOlqr4OVlER+cRxYQ6mb35dz6u0HMps26PMzWMrKbuudvhGeOKqMAn5kbLstrw
         c+8iCBK+tPeLD0RwiTWWS3mUQ7Gne8UTSS0UmcDofkdo74Vp1Dp4MdeumEK+OrubCHCc
         /iUKH6mdBqBdSjyF4MTMLFSwasP5NWkbLFQWwwhMFkzSf9r6AZ1El/h5WK39OMUW8prQ
         7QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729100033; x=1729704833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IOikhW/mkeClxBwUKE9q02/XVbq9Al3HpYKbaOM8oc=;
        b=Vv3DQfW+dpv47roXB7SrjnwhnAm4i1+ucHIbSrGPVTBLvl0rQEoXL7Hx1xuvas2Z0H
         3N9etr/jpBKH0eZxqpKJqarfVbLy8/R6Ui3Ms7HnMxm7Fctx8FwSGibk3CYF0MKSWrbk
         wkQsLVVXi5zuGxYAwOkeMIeU+mL4F0971oFg7hFFIwGAyIyxtJHCV0VPPfR/KkWeAgr1
         fPqIAdwo30W3X6lS91DwIsMFheLLLPv9OcSi0cWzMHrvyAyM1p4hItB3ySxqe3N1zoX4
         cjCZRdCuHnRDzTvlunMMcjFgMaPqErx/c8a3IDxE5Xxa5RP7TFsJIJkSzuSQ9N7Tqh4f
         gWDw==
X-Forwarded-Encrypted: i=1; AJvYcCWtAtQB62Xv6V4Wz+GSjZYmY3viXJag9M+9PLK6Jx0KqqwuFg9h7zIiAglB6l04Ga41BUoCebvc1oSpbFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxELznYyuozuN/iVKSMeMReNdD5mrhCTnLdzdtwvFutFH6Zxb4U
	L+wC101TZKnUOa90lFvhxum4slQwdKOyx18gmfTzRPU5dpn5uk47+pHnjFmuy7LZM3bWDwfJAy2
	7w0vmgcs+w6wUfFKCJSbMyWhoEFVBmQ==
X-Google-Smtp-Source: AGHT+IFP8z26q8+zMFhY0n7+zyhNFca/ubEfFS0Oeu7VoKL4Qp8i/zfK/GxAwwiqYj8Gwo/u0cRynUmK0xLGDPsGNaI=
X-Received: by 2002:a17:907:ea6:b0:a9a:230b:ff2c with SMTP id
 a640c23a62f3a-a9a230bffe4mr694507166b.30.1729100033305; Wed, 16 Oct 2024
 10:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729072803.git.baolin.wang@linux.alibaba.com>
 <df801bca5026c4b06cb843b9366fba21f0d45981.1729072803.git.baolin.wang@linux.alibaba.com>
 <Zw_d0EVAJkpNJEbA@casper.infradead.org>
In-Reply-To: <Zw_d0EVAJkpNJEbA@casper.infradead.org>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 16 Oct 2024 10:33:41 -0700
Message-ID: <CAHbLzkogrubD_rPH7zf1T454r-BsxL951YH=rGAfNqPZJSCGow@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: shmem: improve the tmpfs large folio read performance
To: Matthew Wilcox <willy@infradead.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hughd@google.com, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 8:38=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Oct 16, 2024 at 06:09:30PM +0800, Baolin Wang wrote:
> > @@ -3128,8 +3127,9 @@ static ssize_t shmem_file_read_iter(struct kiocb =
*iocb, struct iov_iter *to)
> >               if (folio) {
> >                       folio_unlock(folio);
> >
> > -                     page =3D folio_file_page(folio, index);
> > -                     if (PageHWPoison(page)) {
> > +                     if (folio_test_hwpoison(folio) ||
> > +                         (folio_test_large(folio) &&
> > +                          folio_test_has_hwpoisoned(folio))) {
>
> Hm, so if we have hwpoison set on one page in a folio, we now can't read
> bytes from any page in the folio?  That seems like we've made a bad
> situation worse.

Yeah, I agree. I think we can fallback to page copy if
folio_test_has_hwpoisoned is true. The PG_hwpoison flag is per page.

The folio_test_has_hwpoisoned is kept set if the folio split is failed
in memory failure handler.

>
>


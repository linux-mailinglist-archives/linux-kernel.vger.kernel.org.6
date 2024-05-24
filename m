Return-Path: <linux-kernel+bounces-188557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9EB8CE38B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69771C22172
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878EE85284;
	Fri, 24 May 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXa5hjJ4"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D3785266;
	Fri, 24 May 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716543181; cv=none; b=oByPVDjrhrvhbQiUk9E7Tb80eF8RkCt4ZC7OeeZsWRKfE4AeuUcntbDecQlLrgXk9x9MMH6CU4M8ruCF+LX1QKnS9HwgUiL33pTvM6x/acarT1tD+DMX9ceR69eAtQK6T6QuMLzrXjLRrSrP2bxBN5qI+oQX/xi0H7vfMRlea8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716543181; c=relaxed/simple;
	bh=2RrLOS91XoKFHAFTx+37jUWVutB0E1TVUDdeeyeIG+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4iS/+QZHofND7L8WbfiEdb3/kyC+5PTr3D2Y00hrUVvdM+X066hkFZZz/g3JQx05tniMqZbEzNj+uia4bewfm1X4JlXT8mx8ne9cpDWOVgZyS6RkzreE2pfkBqLIk/rUEc0C83Y+9xTGJW8iaavi4xHkHQkulgwV6rWM3wjUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXa5hjJ4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-354b722fe81so2868349f8f.3;
        Fri, 24 May 2024 02:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716543178; x=1717147978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/N78wdGhHYwk+WAeb4KOPaNgXTFF+oTiWHimI1zWv+w=;
        b=PXa5hjJ4VjtXOoGgCwLJsPS7JST1LDz/u/O6lVprqdn0FvY34tX0Qm1vvvzyR0CWku
         IDfheT6oKWL5/DI60/ibcZZ18atZuBQvtC9fyZIUr8mKCki4F2drjc7Iethf6aQcwsZ8
         RDMUo8WgyP6Gv+pMPUHCHtKXUgVFygFQ2oDyvBa7NZLxFW9oI4HsKZhKDIGJVWVMtQoM
         dNX7ipU2nLDrfNrZYUnoOA2lPPly3JQsGoSBkKJ5HrHf3kSM0ef1O2UiOdXvZ7BO+eSe
         G3D+fYgMb0C3K7m7wSp+tnFtZOSh2PSZuy0ZHH9zc6PzKUh4SNYitL+YSGrTAvs5DxZJ
         uzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716543178; x=1717147978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N78wdGhHYwk+WAeb4KOPaNgXTFF+oTiWHimI1zWv+w=;
        b=m2lCVhGKYGThFmyhQZr0pT/yHSA9wZ/pIuXgUkLyD/El3YxYwqhBvoPmWxhGHD0Zby
         +92XoJyKTSlOOKpUdovxIY01sMwYO1dZ3pRlLL4iRQTWuUVx31lL/gr6oy1+dNmt+IFn
         XmugtJrymPWSSYN+jU5yUBFgPMud/8RpBEWvIkeeNYNJukBI43609tK/AZSaSPLlJPNu
         RE2iu/tEYcmMpOKA23RjDkZ/rrRPFRWEzjM9S1KmdGWGXzk14qVPPZRXsIYiKWUO7FJx
         bgYCll29RvetQ3O38ehs3Oo9R8BBBZ/ihLlmTChoqrv9Qr9AwbT0pbd2FZWYg8JEE7Mb
         IRNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrkq47UdZtstFoTN6VAT29MEYHhMnobhM5sgCheWk7KvcbS2jS9KyDHwGfB6jY9942K54ly0R9jf7cJt0RE8V4VeZQd+e5Rcwk5lBHQZELJVCkUYL57DaDE3sUthSXZogZBme7Zq2bZQ==
X-Gm-Message-State: AOJu0YywrgATUyd6K6kwirFTuwlemovGSRvwt4Ngy4d8ne/UPAsZ39e4
	Uce6Qu15+m4ee5X0ES9kZyNdgx8dlMQ1WiSBLaUaP3IjvcItynGDPK4vLh2bkvqzYhNPH0+YSE6
	b8YHDg4fD62Z4H5SawQmAzhm/ygYzdi3Z
X-Google-Smtp-Source: AGHT+IG85r6fzf+Rn3oq43J6zk37pMjCk/MUQ1CH01rTPdQh47I++Z/WHoEVeJOT8Si3w4cgr4HsmuiiPelOESdHSTI=
X-Received: by 2002:a5d:6983:0:b0:354:fb81:19d7 with SMTP id
 ffacd0b85a97d-3552fdc86e4mr1000287f8f.44.1716543178271; Fri, 24 May 2024
 02:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405011208.qsZQwChO-lkp@intel.com> <20240501132359.488616-1-skseofh@gmail.com>
 <20240522143129.GA3244910-robh@kernel.org>
In-Reply-To: <20240522143129.GA3244910-robh@kernel.org>
From: DaeRo Lee <skseofh@gmail.com>
Date: Fri, 24 May 2024 18:32:46 +0900
Message-ID: <CAATEi5=pe+A8bUp=JqoMUcqQWp9uZ+4b0A92QxVRmsNj0H0ayw@mail.gmail.com>
Subject: Re: [PATCH v2] of: of_reserved_mem: clean-up reserved memory with no-map
To: Rob Herring <robh@kernel.org>
Cc: lkp@intel.com, daero_le.lee@samsung.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, rppt@kernel.org, saravanak@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 11:31, =
Rob Herring <robh@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, May 01, 2024 at 10:23:59PM +0900, skseofh@gmail.com wrote:
> > From: Daero Lee <daero_le.lee@samsung.com>
> >
> > In early_init_dt_reserve_memory we only add memory w/o no-map flag to
> > memblock.reserved. But we need to add memory w/ no-map flag to
> > memblock.reserved, because NOMAP and memblock.reserved are semantically
> > different.
> >
> > Signed-off-by: Daero Lee <daero_le.lee@samsung.com>
> > ---
> >  drivers/of/of_reserved_mem.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.=
c
> > index 8236ecae2953..d00a17a9cebc 100644
> > --- a/drivers/of/of_reserved_mem.c
> > +++ b/drivers/of/of_reserved_mem.c
> > @@ -81,6 +81,7 @@ static void __init fdt_reserved_mem_save_node(unsigne=
d long node, const char *un
> >  static int __init early_init_dt_reserve_memory(phys_addr_t base,
> >                                              phys_addr_t size, bool nom=
ap)
> >  {
> > +     int err =3D 0;
> >       if (nomap) {
> >               /*
> >                * If the memory is already reserved (by another region),=
 we
> > @@ -91,7 +92,10 @@ static int __init early_init_dt_reserve_memory(phys_=
addr_t base,
> >                   memblock_is_region_reserved(base, size))
> >                       return -EBUSY;
> >
> > -             return memblock_mark_nomap(base, size);
> > +
> > +             err =3D memblock_mark_nomap(base, size);
>
> The last time this was touched, it was to make the handling aligned with
> EFI memory map handling. Is that still going to be the case with this
> change? Or does EFI memory map handling have the same issue?
Can I get more information about EFI memory map handling that you're saying=
?

1) Are you talking about uefi_mem in the reserved-memory node like below?
 ex) arm64/boot/dts/qcom/qcs404.dtsi
                uefi_mem: memory@9f800000 {
                        reg =3D <0 0x9f800000 0 0x800000>;
                        no-map;
                };

2) Or, about handling EFI memory map function efi_init() -> reserve_regions=
()?

>
> > +             if (err)
> > +                     return err;
> >       }
> >       return memblock_reserve(base, size);
> >  }
> > --
> > 2.25.1
> >


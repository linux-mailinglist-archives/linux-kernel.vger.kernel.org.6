Return-Path: <linux-kernel+bounces-244957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0BD92AC37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 00:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D711F22C7C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FA61509BE;
	Mon,  8 Jul 2024 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3t06DR49"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA1BA46
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 22:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720478644; cv=none; b=LniI9d4OWR8be4GJoWetJChzbXD9Y4rRxhgvzYnC30gHslHPszG9bsmRPYRk7ox/h67z7nJzp721IbeXLJB7qZL/x5A+YiwV7xiHZRfVWIqeVt/eLW/FVtz7WL5heOjGp8BXF+dGnpzypL4dma9+JfhNMynyBWy6lOIMwDJ9gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720478644; c=relaxed/simple;
	bh=dJq286KMLgldYxo460eQVxqQYl1tn6syuAmbab68A+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjZxNAQB+24nRpnUzdeVO/NzXkgj9Iwn3mPbdbRa0VDDJFySVtZTVOu8FNTYGpuTYtyKfqbay6GmwSgPuUmpo3aq5QzW0RdELsLWKxJ5G+T+0AmDpzDAPlhtQJg0EmhlhTBO1e7FpnsOFIf3mgV8C/3fYukfPXqrgUuGezBGpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3t06DR49; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-447df43324fso58841cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720478642; x=1721083442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P8A4X3IBFyOUfo0+rybI3w9Hk1k2r9r7vpCeIBNUdA=;
        b=3t06DR49OvorMS83W4uDoQfsZHDl1Z1Rh9/mtXT5idcJ7V79oG5OndxavXzpPRcUTR
         kvy/p3lBC5aiYhYb1l93/8HGwNaFgeJmTbUwVu+yKwLn2x4FeL9g2sdJyhdImB6d3SY5
         6ACjDSMSv2EfzogdV2ay+hQKd5ImUdXx4qNWgR2QM42YS9dFnSp4/Mpe+QLRVF/hXZNV
         h4tZsETSEGR+djLkCnG522/8wLXSieoIdY3n0XO+GQE/HmKLiw9BsmL1mRgChA76hcAF
         xFG3GObKQJ3we3EVlJPbGzQwuxtDufrmStNONXdjszZ4A9kgLkOF+/mleuFCGDnf1QFk
         NvOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720478642; x=1721083442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P8A4X3IBFyOUfo0+rybI3w9Hk1k2r9r7vpCeIBNUdA=;
        b=hpziGImj/0+qV73xjJTsHOoX2W3JEjnIXqxIYsPUjF0dWLwJj23UhgQdGn1wQ8lfiX
         x/1hXGKFjZBwhz7o5F7tqN17g/97tkRt4RUPObSInLJontAMAHUGCYHnTGoo4D+mNKab
         m6N9iCWtVI8DnlsOkBB+6WRe1GnPKYuBfdFv6ge9jFcBw1TGsw4EwSEkLXULP6M5rUR8
         dG0y7epz4J6hBskgyreecAGurHpnrcRcip2FV4tYU14gzhldQ1t5M+g3MuiA+98iGNvR
         hj5jbwjvxSm625etU2uwUiInnkDOR+/d+BIdfLEug1AgtsVMUcZVVbm+dg2UuBWd6QIv
         fK7A==
X-Forwarded-Encrypted: i=1; AJvYcCVT7n1Dabj9PzkOKIyDklb+1L5PI1YAj71k8imLbkrF2CaLoLh2OPtWRpDS5edy0D9qb2QjkOAg24gerfSGmEEPmozvPN7C5AZ8focw
X-Gm-Message-State: AOJu0Yx+/Mr7nmC/ZyBiefGsDWvXHa8RJi1cDtb1cERjBvGqjAAp/1HV
	xxWOsdrxeOLNFM+mmc7J3Y+FtdqeFW0kFri7tZ5Xo2k0+MCnbrshl/rAWLrategkf6cNoHfn3lj
	Ym2a+AK4DC1aVF/i6y3jEzTkbkM7OD4Cx0YMk
X-Google-Smtp-Source: AGHT+IHdc0GOCY8qlvUTy0Oh8PX2V21ovQ6f+p1xBk/t7KTXMDvoKeJlrqGhvlTEWgp0BX/kn1TzPPj47zHm/g7cHRc=
X-Received: by 2002:ac8:6993:0:b0:447:db2d:1f95 with SMTP id
 d75a77b69052e-447fba688f2mr1184971cf.28.1720478641825; Mon, 08 Jul 2024
 15:44:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707-devlink_fix-v1-1-623acb431cd8@quicinc.com>
In-Reply-To: <20240707-devlink_fix-v1-1-623acb431cd8@quicinc.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 8 Jul 2024 15:43:26 -0700
Message-ID: <CAGETcx8YwD-cWYFJ72rfSfmrnoY=rv9oc_2KCK9_AF34Evw7wg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix size calculation of symlink name for devlink_(add|remove)_symlinks()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 6:24=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrote=
:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> devlink_(add|remove)_symlinks() wants to kzalloc() memory to save symlink
> name for either supplier or consumer, but forget to consider consumer
> prefix when calclulate memory size, fixed by considering prefix for both
> supplier and consumer.

No, I didn't forget to take "consumer" into account :) Both supplier
and consumer are the same length. So I didn't bother doing both. I
don't see a point behind this patch.

>
> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")

It's definitely not "Fixing" anything because nothing is broken.

Nack.

If you really want this in, remove this tag and send it again. I won't
ack or review it though as I don't think it adds much value. Greg can
take it if he thinks he likes it.

-Saravana

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 2b4c0624b704..f14cfe5c97b7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -572,7 +572,7 @@ static int devlink_add_symlinks(struct device *dev)
>         len =3D max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>         len +=3D strlen(":");
> -       len +=3D strlen("supplier:") + 1;
> +       len +=3D max(strlen("supplier:"), strlen("consumer:")) + 1;
>         buf =3D kzalloc(len, GFP_KERNEL);
>         if (!buf)
>                 return -ENOMEM;
> @@ -623,7 +623,7 @@ static void devlink_remove_symlinks(struct device *de=
v)
>         len =3D max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
>                   strlen(dev_bus_name(con)) + strlen(dev_name(con)));
>         len +=3D strlen(":");
> -       len +=3D strlen("supplier:") + 1;
> +       len +=3D max(strlen("supplier:"), strlen("consumer:")) + 1;
>         buf =3D kzalloc(len, GFP_KERNEL);
>         if (!buf) {
>                 WARN(1, "Unable to properly free device link symlinks!\n"=
);
>
> ---
> base-commit: c6653f49e4fd3b0d52c12a1fc814d6c5b234ea15
> change-id: 20240707-devlink_fix-0fa46dedfe95
>
> Best regards,
> --
> Zijun Hu <quic_zijuhu@quicinc.com>
>


Return-Path: <linux-kernel+bounces-232516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B76291AA22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4C3BB24B39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D798198A03;
	Thu, 27 Jun 2024 15:01:35 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247319885B
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500494; cv=none; b=ZipkvdJ5CBEolxtAKAyArULuBHNPQ5bYepQ3IKjIdbPh8S55V8fo5AgP0SF+LjcPV5ZSeWoNcdpMHatz9bOzJhuNMyXE/FmRZZIDy/ndC0psqBjcXFl1SyraZ5u0YxA8ukQdHThdIZjYSxg6klD6QyWfm7YosFwoyqs81kPm2Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500494; c=relaxed/simple;
	bh=Ls8TWf7Ls4rDuQM9C/rkvoWcEbirlUYvbabBwsFNNA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TpKT/YQpwdTHYRotyE/JH+dVe5DJDq6reC0R7Zw1B1CW5gkP+p7Ujof42F2Cj7XcA9gwKQv/AEzPfRArgK+hRIhHzbwBBa9JOpBxSkz1for5Txvs52HacFn5SrGOkvF9YBqIz+eH4j+kIRp4zDw2TbHQBuG27i63XQAiEMEbxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-630640c1e14so84858497b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719500491; x=1720105291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zg4w7tXCY7d1fGix7mfUzMIgqJ5X93RyC1ZsNDKryqU=;
        b=wjBioOle3HDpkU5HAZxobupzycVjOpU8bVQ3MIFbm+5/+oIHJowx1g1Zwed3GunJCo
         4n7GlNbsjQvzmDtGFFFu9LFb4s5LAA9PF2Vmx60FcpCWMSUyBuAMcYzwlD+7++kRIIum
         95oEm9YpfGAa8c9HNMsjkUCRCmpjOZMNT2Bzp2VX5+hDAABdLcxyPAMbl1vuKTPDbhq9
         lbEyoa5BWE/gfw0W+6q1V+jd2+5w8Ne0HPybx6uH0oOrFuqD8huULKoJgFu/YvwGOifp
         3GpKipLhXhAYiKX8njlK5ScV97REdhNQSdNMxl2In5eDF2TXue89q0kpPJhSN7783gpw
         vxkA==
X-Forwarded-Encrypted: i=1; AJvYcCVZoMcnYC8DoSHDgTOMkzOQI8yB3nDBrya+c/sx+FSYIjN+9ekMULlkaTUcQ9TnnSZKWCMHjDGh26+LTbg1Z3phKZ6cbq60pzoWQBtN
X-Gm-Message-State: AOJu0YxlkXh8XSOxar6gqQIVHAWPtqZAoNOnkdf7ZDhWwp/PgA9S4VQ1
	CX7FBKpIwN7IoU//ROSm6q2Gw1ILUnlHZQxkZ8jn4qvQVum2pcIw/tu0JrUM
X-Google-Smtp-Source: AGHT+IHyhfwqJy8PFDQDtGAXJcSvwyD2tedqtNZrop5DDDjUmTt1wKf3NGr3XcJVLmtMk7NVXHxIDg==
X-Received: by 2002:a05:690c:6f8b:b0:63b:f6c1:6068 with SMTP id 00721157ae682-643ac323ac6mr156569117b3.32.1719500491273;
        Thu, 27 Jun 2024 08:01:31 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64979418ea9sm2737247b3.62.2024.06.27.08.01.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 08:01:30 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6325b04c275so82165757b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 08:01:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWqERSVhtIgtW9nID15RigbtTjRcbmtYDL0tNgpvm6sqoc98XgorLhwziOG2iz7bHohXsUUwzIiRsIafNJXjz2Rk4GI9H08YJpnJyYx
X-Received: by 2002:a05:690c:f0a:b0:63b:d0df:ffe5 with SMTP id
 00721157ae682-643ac81d7b3mr161262737b3.45.1719500490444; Thu, 27 Jun 2024
 08:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>
In-Reply-To: <20240620-upstream-nfc-mcf5441x-v1-1-69b64807d7a6@yoseli.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Jun 2024 17:01:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6z6OST=U3cvt3NRe3nj7DKCf+0O4v9s14ZV-j2v=qrA@mail.gmail.com>
Message-ID: <CAMuHMdV6z6OST=U3cvt3NRe3nj7DKCf+0O4v9s14ZV-j2v=qrA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: Add support for M5441x NFC
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Stefan Agner <stefan@agner.ch>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jean-Michel,

On Thu, Jun 20, 2024 at 6:25=E2=80=AFPM Jean-Michel Hautbois
<jeanmichel.hautbois@yoseli.org> wrote:
> The vf610_nfc driver is also the one which should be used for the
> coldfire series. Sadly, these device don't support device-tree and so we
> need to do a few modifications:
> - Adapt the probe to use pdata if available
> - Add a new variant as there is a small part to adapt in
>   vf610_nfc_select_target()
> - Add the corresponding missing register definitions
>
> Tested successfully on a 54418 custom board with a raw NAND:
> [    2.640000] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0xdc
> [    2.650000] nand: Micron MT29F4G08ABADAWP
> [    2.650000] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048, =
OOB size: 64
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>

Thanks for your patch!

> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -810,6 +840,7 @@ static int vf610_nfc_probe(struct platform_device *pd=
ev)
>         struct vf610_nfc *nfc;
>         struct mtd_info *mtd;
>         struct nand_chip *chip;
> +       struct nand_chip *pdata;
>         struct device_node *child;

As reported by the robot, this is now unused.

>         int err;
>         int irq;
> @@ -820,30 +851,53 @@ static int vf610_nfc_probe(struct platform_device *=
pdev)
>
>         nfc->dev =3D &pdev->dev;
>         chip =3D &nfc->chip;
> +       pdata =3D dev_get_platdata(&pdev->dev);
> +       if (pdata)
> +               *chip =3D *pdata;
> +
>         mtd =3D nand_to_mtd(chip);
>
>         mtd->owner =3D THIS_MODULE;
>         mtd->dev.parent =3D nfc->dev;
> -       mtd->name =3D DRV_NAME;
> +
> +       /*
> +        * We keep the MTD name unchanged to avoid breaking platforms
> +        * where the MTD cmdline parser is used and the bootloader
> +        * has not been updated to use the new naming scheme.
> +        */
> +       if (!nfc->dev->of_node)
> +               mtd->name =3D "NAND";
> +       else
> +               mtd->name =3D DRV_NAME;
>
>         irq =3D platform_get_irq(pdev, 0);
>         if (irq < 0)
>                 return irq;
>
>         nfc->regs =3D devm_platform_ioremap_resource(pdev, 0);
> -       if (IS_ERR(nfc->regs))
> +       if (IS_ERR(nfc->regs)) {
> +               dev_err(nfc->dev, "Unable to map registers!\n");
>                 return PTR_ERR(nfc->regs);
> +       }
>
> +#ifdef CONFIG_OF

Do you need all the #ifdeffery?

>         nfc->clk =3D devm_clk_get_enabled(&pdev->dev, NULL);

Perhaps replace by devm_clk_get_optional_enabled() instead?

>         if (IS_ERR(nfc->clk)) {
>                 dev_err(nfc->dev, "Unable to get and enable clock!\n");
>                 return PTR_ERR(nfc->clk);
>         }
>
> -       nfc->variant =3D (enum vf610_nfc_variant)device_get_match_data(&p=
dev->dev);
> -       if (!nfc->variant)
> -               return -ENODEV;
> +       const void *data =3D device_get_match_data(&pdev->dev);
>
> +       nfc->variant =3D (enum vf610_nfc_variant)data;
> +       if (!nfc->variant) {
> +               dev_err(nfc->dev, "No variant data found!\n");
> +               return -ENODEV;
> +       }
> +#else
> +       nfc->variant =3D (enum vf610_nfc_variant)platform_get_device_id(p=
dev)->driver_data;
> +#endif
> +#ifdef CONFIG_OF
>         for_each_available_child_of_node(nfc->dev->of_node, child) {

for_each_available_child_of_node_scoped(...), so the child variable
no longer needs to be declared at the top.

>                 if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs"=
)) {
>
> @@ -862,6 +916,10 @@ static int vf610_nfc_probe(struct platform_device *p=
dev)
>                 dev_err(nfc->dev, "NAND chip sub-node missing!\n");
>                 return -ENODEV;
>         }
> +#else
> +       nfc->clk =3D NULL;
> +       mtd->dev.parent =3D &pdev->dev;
> +#endif
>
>         chip->options |=3D NAND_NO_SUBPAGE_WRITE;
>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


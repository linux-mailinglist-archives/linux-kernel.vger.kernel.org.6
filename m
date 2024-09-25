Return-Path: <linux-kernel+bounces-339710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6303A98695A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 01:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638AA1C23816
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5510187FF7;
	Wed, 25 Sep 2024 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0S48Zc8y"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EB4158557
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305445; cv=none; b=bv5znU9rmQuJVX7IG19Bwri9yAf6iKVwinizHmp5kmCXEtlcYVZfPiJ83jQO8vyF8CQryVlCuIbeNiTKFrDx+TutjvkhgFmOKFHiLuu+ZcLkNFShH2UDK5QZ7h4LMmCPGksTVeRBsH6cPcVF7fnAppr9k+73fiG8nrNBcUcZRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305445; c=relaxed/simple;
	bh=UtgSIc5cniEHjWop7tU9MXrn3Xh86AAWCjbZj7WZ/Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ+2HPHyLFI43sWJONYWa3xogiEXr52lRYfGNyIuLr0pUIYCiyGcfHnNrdLVhkMB2L9fPq7QjSmsGTQeql5JcKvJP19pOTYFMn9YC6Bkijkna2JBQxwOjn4WEfMylFnxtRfBTcDlUx64djjhLx66e0wHaGQ2BVb9WApiSp+3X7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0S48Zc8y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71798a15ce5so1132626b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727305443; x=1727910243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WvIefjQov9JCz8XM01rQ8zNCbgW7i1WmqdmswgEu/E=;
        b=0S48Zc8yRrMTS+60EKnRPIi1u9GA3LkHnpj7b7TQfWgUoa7Cop2c8r4dDqBm5N8MD1
         zGtdijfdeLLak5iXeLmz1hEPvb3nab9RX0qhXhqsiQL3W6oZ5WLLwpcpgptSFql4TWdD
         BJ11NBVEV0Gg2AYSPD+ArViM5sOkrEC13fF65kEYstrII7I5E7LxccvkIxji5lmttB3m
         IiP6qSfNHlFUCGE3cBjPvOmaolQmvH99p+fNY85HiJw1nQ0Vg3XcGyDKEssmJOBAACgt
         xXWJCZOA20vXrc1KoQ6jpb3cYKRp88v+RcpcsyTbfIJ3Xc2xQoN/1X80qzcgioF/lV+x
         uNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727305443; x=1727910243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WvIefjQov9JCz8XM01rQ8zNCbgW7i1WmqdmswgEu/E=;
        b=oxhTgXz+qb2A7Lvl3gjXmRRzY72Km1tq+7a9zNsyCwVQcSv+CoiqKU+NnTZCF3Xotk
         fP3ouKR1VSRXr/tL+JuhX5n5/FDoyJDjUqpokAxLu+cZV+SYwGD0OXWEfj69xSDMFl0B
         Z1S1kArN+PJWx1MYNhrnwkjp+SgLKuKLCBP1CUD3/sKtzBPE7EsU7trIyHREjwZQ+7ak
         kmvMNnrMEfw86FDQTfyorZKFpzbuVsXUwamXcZNrAU0e7weyfT1kB++DXP573xJT1AMM
         u79GPGkU3Y+Qo00IEn6GNUguRsVXTEMyI6eg0KLT/VJ+nyMA++1dKjxhwbiN88MYd8cE
         HzmA==
X-Forwarded-Encrypted: i=1; AJvYcCXr6Yjwq8pibN4Z9mcTSJgO6g4CJfYblSb/n+D2SSThl56Pf7sdUl1aqtqsI5Afmq4QohFYF68dF5//SpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0KAYYJdgkCF+auSooHqUdBjir/P67B5SUkEq2zL/JNGiRN0Sa
	ST4TKGJWjg8acSfMvdpp64JVZtGIGA4ulkhP/JKvNBD3JlNcWVVbavqA13nqOtDOyhVNvo5Vsxf
	Vk6lR7RJr0iS2BCasPt7oYA9pTPInQC0DCMOf
X-Google-Smtp-Source: AGHT+IG2KJ9V2g4jraQ+AtHtEnvxUA1/Dd8zwDHYubnZQC3Pih2whD3FIclGFy6tO3dBbBpV6+LFmzwwlU3MrDl4om0=
X-Received: by 2002:a05:6a21:398f:b0:1ce:f6dc:2ba8 with SMTP id
 adf61e73a8af0-1d4ebead45fmr1939396637.24.1727305442056; Wed, 25 Sep 2024
 16:04:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925220552.149551-1-marex@denx.de>
In-Reply-To: <20240925220552.149551-1-marex@denx.de>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 25 Sep 2024 16:03:22 -0700
Message-ID: <CAGETcx9Gnbtt8m+tKZrw6fU_jM1idJ2wJZuz_EyOPq5wpm3Z1w@mail.gmail.com>
Subject: Re: [PATCH v2] soc: imx8m: Probe the SoC driver as platform driver
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Fabio Estevam <festevam@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 3:06=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> With driver_async_probe=3D* on kernel command line, the following trace i=
s
> produced because on i.MX8M Plus hardware because the soc-imx8m.c driver
> calls of_clk_get_by_name() which returns -EPROBE_DEFER because the clock
> driver is not yet probed. This was not detected during regular testing
> without driver_async_probe.
>
> Convert the SoC code to platform driver and instantiate a platform device
> in its current device_initcall() to probe the platform driver. Rework
> .soc_revision callback to always return valid error code and return SoC
> revision via parameter. This way, if anything in the .soc_revision callba=
ck
> return -EPROBE_DEFER, it gets propagated to .probe and the .probe will ge=
t
> retried later.

I'm assuming you tested this patch and it works? Did you see any other
issues with driver_async_probe=3D* ?

Does this improve your probe/boot time? Some stats on that would be nice.

>
> "
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 1 at drivers/soc/imx/soc-imx8m.c:115 imx8mm_soc_revi=
sion+0xdc/0x180
> CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-next-20240924-000=
02-g2062bb554dea #603
> Hardware name: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3)=
 (DT)
> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : imx8mm_soc_revision+0xdc/0x180
> lr : imx8mm_soc_revision+0xd0/0x180
> sp : ffff8000821fbcc0
> x29: ffff8000821fbce0 x28: 0000000000000000 x27: ffff800081810120
> x26: ffff8000818a9970 x25: 0000000000000006 x24: 0000000000824311
> x23: ffff8000817f42c8 x22: ffff0000df8be210 x21: fffffffffffffdfb
> x20: ffff800082780000 x19: 0000000000000001 x18: ffffffffffffffff
> x17: ffff800081fff418 x16: ffff8000823e1000 x15: ffff0000c03b65e8
> x14: ffff0000c00051b0 x13: ffff800082790000 x12: 0000000000000801
> x11: ffff80008278ffff x10: ffff80008209d3a6 x9 : ffff80008062e95c
> x8 : ffff8000821fb9a0 x7 : 0000000000000000 x6 : 00000000000080e3
> x5 : ffff0000df8c03d8 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : fffffffffffffdfb x0 : fffffffffffffdfb
> Call trace:
>  imx8mm_soc_revision+0xdc/0x180
>  imx8_soc_init+0xb0/0x1e0
>  do_one_initcall+0x94/0x1a8
>  kernel_init_freeable+0x240/0x2a8
>  kernel_init+0x28/0x140
>  ret_from_fork+0x10/0x20
> ---[ end trace 0000000000000000 ]---
> SoC: i.MX8MP revision 1.1
> "
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: imx@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V2: Use the platform device approach instead of late_initcall
> ---
>  drivers/soc/imx/soc-imx8m.c | 92 ++++++++++++++++++++++++++++---------
>  1 file changed, 70 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index fe111bae38c8e..170970d4955c6 100644
> --- a/drivers/soc/imx/soc-imx8m.c
> +++ b/drivers/soc/imx/soc-imx8m.c
> @@ -30,7 +30,7 @@
>
>  struct imx8_soc_data {
>         char *name;
> -       u32 (*soc_revision)(void);
> +       int (*soc_revision)(u32 *socrev);
>  };
>
>  static u64 soc_uid;
> @@ -51,24 +51,29 @@ static u32 imx8mq_soc_revision_from_atf(void)
>  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
>  #endif
>
> -static u32 __init imx8mq_soc_revision(void)
> +static int imx8mq_soc_revision(u32 *socrev)
>  {
>         struct device_node *np;
>         void __iomem *ocotp_base;
>         u32 magic;
>         u32 rev;
>         struct clk *clk;
> +       int ret;
>
>         np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
>         if (!np)
> -               return 0;
> +               return -EINVAL;
>
>         ocotp_base =3D of_iomap(np, 0);
> -       WARN_ON(!ocotp_base);
> +       if (!ocotp_base) {
> +               ret =3D -EINVAL;
> +               goto err_iomap;
> +       }
> +
>         clk =3D of_clk_get_by_name(np, NULL);
>         if (IS_ERR(clk)) {
> -               WARN_ON(IS_ERR(clk));
> -               return 0;
> +               ret =3D PTR_ERR(clk);
> +               goto err_clk;
>         }
>
>         clk_prepare_enable(clk);
> @@ -88,32 +93,45 @@ static u32 __init imx8mq_soc_revision(void)
>         soc_uid <<=3D 32;
>         soc_uid |=3D readl_relaxed(ocotp_base + OCOTP_UID_LOW);
>
> +       *socrev =3D rev;
> +
>         clk_disable_unprepare(clk);
>         clk_put(clk);
>         iounmap(ocotp_base);
>         of_node_put(np);
>
> -       return rev;
> +       return 0;
> +
> +err_clk:
> +       iounmap(ocotp_base);
> +err_iomap:
> +       of_node_put(np);
> +       return ret;
>  }
>
> -static void __init imx8mm_soc_uid(void)
> +static int imx8mm_soc_uid(void)
>  {
>         void __iomem *ocotp_base;
>         struct device_node *np;
>         struct clk *clk;
> +       int ret =3D 0;
>         u32 offset =3D of_machine_is_compatible("fsl,imx8mp") ?
>                      IMX8MP_OCOTP_UID_OFFSET : 0;
>
>         np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
>         if (!np)
> -               return;
> +               return -EINVAL;
>
>         ocotp_base =3D of_iomap(np, 0);
> -       WARN_ON(!ocotp_base);
> +       if (!ocotp_base) {
> +               ret =3D -EINVAL;
> +               goto err_iomap;
> +       }
> +
>         clk =3D of_clk_get_by_name(np, NULL);
>         if (IS_ERR(clk)) {
> -               WARN_ON(IS_ERR(clk));
> -               return;
> +               ret =3D PTR_ERR(clk);
> +               goto err_clk;
>         }
>
>         clk_prepare_enable(clk);
> @@ -124,31 +142,41 @@ static void __init imx8mm_soc_uid(void)
>
>         clk_disable_unprepare(clk);
>         clk_put(clk);
> +
> +err_clk:
>         iounmap(ocotp_base);
> +err_iomap:
>         of_node_put(np);
> +
> +       return ret;
>  }
>
> -static u32 __init imx8mm_soc_revision(void)
> +static int imx8mm_soc_revision(u32 *socrev)
>  {
>         struct device_node *np;
>         void __iomem *anatop_base;
> -       u32 rev;
> +       int ret;
>
>         np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
>         if (!np)
> -               return 0;
> +               return -EINVAL;
>
>         anatop_base =3D of_iomap(np, 0);
> -       WARN_ON(!anatop_base);
> +       if (!anatop_base) {
> +               ret =3D -EINVAL;
> +               goto err_iomap;
> +       }
>
> -       rev =3D readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
> +       *socrev =3D readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
>
>         iounmap(anatop_base);
>         of_node_put(np);
>
> -       imx8mm_soc_uid();
> +       return imx8mm_soc_uid();
>
> -       return rev;
> +err_iomap:
> +       of_node_put(np);
> +       return ret;
>  }
>
>  static const struct imx8_soc_data imx8mq_soc_data =3D {
> @@ -184,7 +212,7 @@ static __maybe_unused const struct of_device_id imx8_=
soc_match[] =3D {
>         kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0=
xf) : \
>         "unknown"
>
> -static int __init imx8_soc_init(void)
> +static int imx8m_soc_probe(struct platform_device *pdev)
>  {
>         struct soc_device_attribute *soc_dev_attr;
>         struct soc_device *soc_dev;
> @@ -212,8 +240,11 @@ static int __init imx8_soc_init(void)
>         data =3D id->data;
>         if (data) {
>                 soc_dev_attr->soc_id =3D data->name;
> -               if (data->soc_revision)
> -                       soc_rev =3D data->soc_revision();
> +               if (data->soc_revision) {
> +                       ret =3D data->soc_revision(&soc_rev);
> +                       if (ret)
> +                               goto free_soc;
> +               }
>         }
>
>         soc_dev_attr->revision =3D imx8_revision(soc_rev);
> @@ -251,6 +282,23 @@ static int __init imx8_soc_init(void)
>         kfree(soc_dev_attr);
>         return ret;
>  }
> +
> +static struct platform_driver imx8m_soc_driver =3D {
> +       .probe =3D imx8m_soc_probe,
> +       .driver =3D {
> +               .name =3D "imx8m-soc",
> +       },
> +};
> +module_platform_driver(imx8m_soc_driver);

This just translates to a module_init() when compiled as a module.

>
> +
> +static int __init imx8_soc_init(void)
> +{
> +       struct platform_device *pdev;
> +
> +       pdev =3D platform_device_register_simple("imx8m-soc", -1, NULL, 0=
);
> +
> +       return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;
> +}
>  device_initcall(imx8_soc_init);

This also translates to a module_init() when compiled as a module.

I've never seen a module with two module_init()s and I'm pretty sure
that doesn't work. I'm guessing this driver doesn't support tristate
in its current state. But with this patch, it should work as a module
too. Why not add support for that too?

Why not just do both of these things in one initcall?
platform_create_bundle() doesn't work with deferred probing though. So
just do one initcall that adds the device and registers the platform
driver.

-Saravana


>  MODULE_DESCRIPTION("NXP i.MX8M SoC driver");
>  MODULE_LICENSE("GPL");
> --
> 2.45.2
>


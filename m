Return-Path: <linux-kernel+bounces-341167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA883987BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C72B26D76
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092701B07BC;
	Thu, 26 Sep 2024 23:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAOkNjgl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC281B07B2
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393996; cv=none; b=lwItuvtOSrf3JQDN9iYIMa7hRQgKmaFH9xNhE2uNPzQBZp8aeN/sxjaj8E2UsM90bTr4i7xPfnSsncchrti2WPSGdzId2fz2LE9n5l5N09m0Wlq7AlVAHFngKCWRtHu3jImid8D3DABKZX+Fn9pQf9rTtHHirIlQokq30TQa6cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393996; c=relaxed/simple;
	bh=rvG9Y+VE2uJz21bebRqq+26qa85yn7OvmU1Z1RNAoC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ls7tmMmRNAAwqpYbraCdJdKqy2aeoIN4qezAlyz/ty/k4EiKHATlItWc93V8XCXMdi29fLjQhbbq3Ekjk3B4dDJsq3kbWFtYvQD50Ptz6whSBNgVP7pankXIAFcHy/ITbNo3ZOyYAfbJ3O9OhT5e8FHIxCjn4CTJIGSJPZmTqaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAOkNjgl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e082bf1c7fso1184098a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393993; x=1727998793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n0AACIwskMhO84x1V3Wxwj8ckxEzrQQ271STnP2J2o=;
        b=PAOkNjglYNeSbY90u9wWTbSHIWwDX2hLBJmslzeHI26gsGW2088Y6+3FxOqpuTSSFI
         Wh3L4osXffukjVO3efxANJnmxf9QDo5OM1Dbmw96MwdWEBKRMACve1EV0mf2ayKst01E
         OSoCNDFRt2Tibx2h2nOEo1ES/ApENXFwsB4a5zTMs2N4WdL+HM/9WfCmkmh6XPu6z3js
         yI7BTUX5Y48UcoTb9LI4ogaOX6e536A2FOEewphGMMqYKUScOeqXMxYY2NcC9WhL2lCp
         pfW8d1XettyFz2/NqocvQVS2mmeFRb0EUjd5479o36CXT36ulS1KFZB3IEUdJp7/kOpZ
         kOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393993; x=1727998793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n0AACIwskMhO84x1V3Wxwj8ckxEzrQQ271STnP2J2o=;
        b=TWrMpJQZpN8/Jh/hI8wvGq34tanRIxOhRCU1BYcb26uoTFF2W24uR9WeXLtRSNC5C+
         pu0PWM/xoln1I2NByW7l3QTL6HONfXQv2wIAuJFtsqt2hzCngfjnsq8gDeoSYuZQV00E
         3tel2XEi+ttaUx4OU+u1OFQqFYyU2lSVt5FHagSdSshT2ewPANqI9r28LHbswOOwAMn0
         y2A0pzsLWgxDL8AMoDuyK8TXtH3pfUGCnbCwcjTngDZ+KQ4vuhujZPT7m5QlbWwkQ7PF
         6fI8t7GQoWA7JsWtDfOEBLKjYaWcjK04POQIxFMNZTKBOKAeVONJdt4dB/ccGYlAxBhw
         0yfg==
X-Forwarded-Encrypted: i=1; AJvYcCWinqFKDx9wqyWrdi4j9qkgPkppPSEnzcax+cjr23ndgzlyzeo+UhBfY3TIqA5Zgo0h9Fac9Z/IJJ5eym0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzm5bCBbx/ijzAfcQyHYRYyBvAt0DwxwnRu5b7vFGvOM9lxgmm
	BJkVfFq1GkvlUwkxzOIPASCrUZYYXYfTgz/INCySi0p+AbSOJ1gjz3i8QRQqy5uw+IxgLYKCVLH
	uIFBiT/DHoBjjVDXtpV7wy6Zuo2B+vlV+dFHl
X-Google-Smtp-Source: AGHT+IFAONtajDwPUKUuelFyzTqTy1Ae+k0tfENJbdYCetByfJeZMPyLvb4F4LzlAxFX/nkBc6B+uW6jzk/0TCkqiuI=
X-Received: by 2002:a17:90a:c08a:b0:2d6:1981:bbf7 with SMTP id
 98e67ed59e1d1-2e0b8ebc48cmr1767297a91.32.1727393992964; Thu, 26 Sep 2024
 16:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926213729.2882045-1-marex@denx.de>
In-Reply-To: <20240926213729.2882045-1-marex@denx.de>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 26 Sep 2024 16:39:13 -0700
Message-ID: <CAGETcx-q7+DGhPYd3QrsPh7O_0HU7T=NhaJYp0Fu7YW2zwbo7Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: imx8m: Probe the SoC driver as platform driver
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org, kernel@dh-electronics.com, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Fabio Estevam <festevam@gmail.com>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:37=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
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
> V3: Do not register imx8m_soc_driver on non-iMX8M hardware
> ---
>  drivers/soc/imx/soc-imx8m.c | 107 ++++++++++++++++++++++++++++--------
>  1 file changed, 85 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> index fe111bae38c8e..5ea8887828c06 100644
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

Using devm_of_iomap() and scoped "whatever it's called" might help
simplify the error handling.

So something like this for np:
struct device_node *np __free(device_node) =3D np =3D
of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");

And this for ocotp_base:
ocotp_base =3D devm_of_iomap(dev, np, 0);

Would mean you can delete all the error handling parts

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

If you use devm_of_iomap() then you should use devm_iounmap() here and
not just delete this part. devm_* is mainly to skip freeing when probe
fails.

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

I'm glad it's working for you, but I think there might still be a race
that you are just lucky enough to not hit. I think you still need to
fix up drivers/base/soc.c to return -EPROBE_DEFER when
soc_device_match() is called but soc_bus_type has no devices
registered. That way any drivers that try to use that API will defer
probe until this device gets to probe.

And then you'll have to look at all the callers of that API for the
boards this driver is meant for and make sure they don't ignore the
error return value. Just add a WARN() on the API to figure out all the
callers in your board.

Also, you might want to check that your list of probed devices doesn't
change without any async probing or this patch vs with async probing
and this patch. Quick way to get list of successfully probed devices
is:
# find /sys/devices -name driver

Arnd,

Why is soc_device_match() doing a bus_for_each_dev(&soc_bus_type,...)?
Are the real use cases where more than one soc device can be
registered with soc_device_register()?

-Saravana

>
>         soc_dev_attr->revision =3D imx8_revision(soc_rev);
> @@ -251,6 +282,38 @@ static int __init imx8_soc_init(void)
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
> +
> +static int __init imx8_soc_init(void)
> +{
> +       struct platform_device *pdev;
> +       int ret;
> +
> +       /* No match means this is non-i.MX8M hardware, do nothing. */
> +       if (!of_match_node(imx8_soc_match, of_root))
> +               return 0;
> +
> +       ret =3D platform_driver_register(&imx8m_soc_driver);
> +       if (ret) {
> +               pr_err("Failed to register imx8m-soc platform driver: %d\=
n", ret);
> +               return ret;
> +       }
> +
> +       pdev =3D platform_device_register_simple("imx8m-soc", -1, NULL, 0=
);
> +       if (IS_ERR(pdev)) {
> +               pr_err("Failed to register imx8m-soc platform device: %ld=
\n", PTR_ERR(pdev));
> +               platform_driver_unregister(&imx8m_soc_driver);
> +               return PTR_ERR(pdev);
> +       }
> +
> +       return 0;
> +}
>  device_initcall(imx8_soc_init);
>  MODULE_DESCRIPTION("NXP i.MX8M SoC driver");
>  MODULE_LICENSE("GPL");
> --
> 2.45.2
>


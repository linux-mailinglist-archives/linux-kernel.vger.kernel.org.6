Return-Path: <linux-kernel+bounces-415193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F69D32C2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D95D284EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 03:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C7E450EE;
	Wed, 20 Nov 2024 03:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdswonzX"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CDF28EC;
	Wed, 20 Nov 2024 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732074373; cv=none; b=uSh+lHF80ohKu26rziAJhx8Zt3dpKY4sITTpatiHbX5BCqLWpRxF/CT1i45PbGJL1oatgk0ux/uNo1MTsbAuO2F/3pymmguabOLAU3v4/l+sD9qnsGVvpk4vjz2R06J0yPzmMqFmx/VrzCy3x+akF2gv6VML59yLA6UjSUMlTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732074373; c=relaxed/simple;
	bh=yRv/tKkIxw7/PgCT7gTfrWds7b10frLZZ6468UJWe/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Su88kiL1HQFlYqZFM1aiStxjeNN53196iYazDO52QUdO0B3bOgnp7Dg5u99PypmBcyR7QFnDh6ehcxfpWkSXHFfyGgccf4eC6yQxR776Wkx4KmtpgByS4Qk3cGfCKqpCSLvfEyzD0X9oBmNAD7lQAYOS5a15vRQdDePCyV9xRbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdswonzX; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a76df43746so10439525ab.1;
        Tue, 19 Nov 2024 19:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732074371; x=1732679171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jtk1zl4aSk9+lvWPZY5UumKAQmiBiNYz2jEHrbWkiE=;
        b=EdswonzXe6QRK+A6IDUDcD5mdCbbLVhcZ1eMrYcGMRHmMTOhzMHLPK6qqrRRurSaMx
         kN/h556ZUA1PL5p3qoYkfNxWt2Pop0wAQvI20c4GOtREGCLmC1AfxMpH3H/R6zfPBhJ+
         g0Y4veoaNpULWJepbmfI3teXE/bYuYvabXxit69V8uMvTar/Q9RPdGnTlMHgDv5orqx9
         698e9R5cJPZuR8PPHQVxnrnB6PxgggIVI8jeqvlIBMnswApMshgBKSuy107rir3xG+9r
         MBKla8OCYsTc7R7h9K6xlm1FsPuu/3i1ioKTQ0bdwLCnt4oQuw1W5cs/s32B6mH9kJ0D
         qBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732074371; x=1732679171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jtk1zl4aSk9+lvWPZY5UumKAQmiBiNYz2jEHrbWkiE=;
        b=R30Scue2mob6ZRrWIyNBP3NoPOvpluqxQ/reZgCKZoYXS40aaGU5CHKO2y2Ojyzp28
         omuqijksqacT9Zgrwaz+1g94focFHaHGVyDrgqB+Gi2SY1e3Lf+xWC5EImXlkvc9Af9p
         DgP1bURbZDsWzeBHR/95dfjvqcRfaoydFTC6o1wA0vTiXPhtHw8aF2bBJMRspIDzVX3o
         LcecYTIyPalqPoK/ocuWdazzEwXmZGsEj0vaNwzHETR73X2UKNWYyee4+FBWizzCTddv
         VsxkkBMuyPe3BwtmQH8J/nIQSH6rP6R8woXFIbX0YHMrxQb4/+n/naXmmYbK0qE5Fugq
         2/gw==
X-Forwarded-Encrypted: i=1; AJvYcCVjXaCuBoSp27A6ILrzX4qbzITlpZq+iJzx6Sg9umxFxUPzOLCsm4Cnh9ibvkUWQy1y4ypPd2QvKw==@vger.kernel.org, AJvYcCWfTibfsQPpQnTbU+J0avlevqwi1Hph1faRc7KiBDPBFJ/LPMgDt9Dq68PcNNQPpJpdVDMwI+orT8jwaOvb@vger.kernel.org, AJvYcCXvpM/U1ZBU0t6eTgQXs7ZeukIlU1u1A0s3boUoq5DY+oCihHG/a0Q48QZGTajxfuPvb+1/odN9RBJ4I/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4/Wm4wE5b28/L8MX/5/lZaWa1d8u5kheD/+78+8lruEmT5lpo
	bLmI+UNwkoKcgGNr1ioECe4ERKbMlbNWiWBmR2oe6zXZsE+DJFwPClNuV0Y9nK8UNL+wuvTdh/x
	vophmbvPtkeBJKac3YNbnok78Dp8=
X-Google-Smtp-Source: AGHT+IGhh4aSgpURVT3OET61N9X1zKakDzkHXxCrO7/9x2Fw8GYnbqDbAbC3nVPeDgWEHh7NOxcLBWPVrQEE4C9TbXU=
X-Received: by 2002:a05:6602:1645:b0:82c:d768:aa4d with SMTP id
 ca18e2360f4ac-83eb5fefbefmr225028639f.9.1732074371282; Tue, 19 Nov 2024
 19:46:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115230555.2435004-1-arnd@kernel.org>
In-Reply-To: <20241115230555.2435004-1-arnd@kernel.org>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Wed, 20 Nov 2024 11:45:59 +0800
Message-ID: <CAA+D8AO8=NaNM0jPuSa68yvNa5pJQ7r207_-y06sxB__kqWdGw@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix i.MX build dependency
To: Arnd Bergmann <arnd@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Cristian Marussi <cristian.marussi@arm.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Peng Fan <peng.fan@nxp.com>, arm-scmi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 7:08=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly added SCMI vendor driver references functions in the
> protocol driver but needs a Kconfig dependency to ensure it can link,
> essentially the Kconfig dependency needs to be reversed to match the
> link time dependency:
>
> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_wr=
ite':
> fsl_mqs.c:(.text+0x1aa): undefined reference to `scmi_imx_misc_ctrl_set'
> arm-linux-gnueabi-ld: sound/soc/fsl/fsl_mqs.o: in function `fsl_mqs_sm_re=
ad':
> fsl_mqs.c:(.text+0x1ee): undefined reference to `scmi_imx_misc_ctrl_get'
>
> This however only works after changing the dependency in the SND_SOC_FSL_=
MQS
> driver as well, which uses 'select IMX_SCMI_MISC_DRV' to turn on a
> driver it depends on. This is generally a bad idea, so the best solution
> is to change that into a dependency.
>
> To allow the ASoC driver to keep building with the SCMI support, this
> needs to be an optional dependency that enforces the link-time
> dependency if IMX_SCMI_MISC_DRV is a loadable module but not
> depend on it if that is disabled.
>
> Fixes: 61c9f03e22fc ("firmware: arm_scmi: Add initial support for i.MX MI=
SC protocol")
> Fixes: 101c9023594a ("ASoC: fsl_mqs: Support accessing registers by scmi =
interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
> I'm not sure this is the version we want to go with in the end, without
> having read the code in detail, but the version in linux-next is clearly
> wrong in multiple ways and this is the best I could come up with so far.
>
> If we can agree on this approach, it needs to go through the ASoC tree
> as that contains the 101c9023594a commit at the moment.
> ---
>  drivers/firmware/arm_scmi/vendors/imx/Kconfig | 1 +
>  drivers/firmware/imx/Kconfig                  | 1 -
>  sound/soc/fsl/Kconfig                         | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firm=
ware/arm_scmi/vendors/imx/Kconfig
> index 2883ed24a84d..a01bf5e47301 100644
> --- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
> +++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
> @@ -15,6 +15,7 @@ config IMX_SCMI_BBM_EXT
>  config IMX_SCMI_MISC_EXT
>         tristate "i.MX SCMI MISC EXTENSION"
>         depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
> +       depends on IMX_SCMI_MISC_DRV
>         default y if ARCH_MXC
>         help
>           This enables i.MX System MISC control logic such as gpio expand=
er
> diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
> index 477d3f32d99a..907cd149c40a 100644
> --- a/drivers/firmware/imx/Kconfig
> +++ b/drivers/firmware/imx/Kconfig
> @@ -25,7 +25,6 @@ config IMX_SCU
>
>  config IMX_SCMI_MISC_DRV
>         tristate "IMX SCMI MISC Protocol driver"
> -       depends on IMX_SCMI_MISC_EXT || COMPILE_TEST
>         default y if ARCH_MXC
>         help
>           The System Controller Management Interface firmware (SCMI FW) i=
s
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 8e88830e8e57..678540b78280 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -29,8 +29,8 @@ config SND_SOC_FSL_SAI
>  config SND_SOC_FSL_MQS
>         tristate "Medium Quality Sound (MQS) module support"
>         depends on SND_SOC_FSL_SAI
> +       depends on IMX_SCMI_MISC_DRV || !IMX_SCMI_MISC_DRV
>         select REGMAP_MMIO
> -       select IMX_SCMI_MISC_DRV if IMX_SCMI_MISC_EXT !=3Dn
>         help
>           Say Y if you want to add Medium Quality Sound (MQS)
>           support for the Freescale CPUs.
> --
> 2.39.5
>
>


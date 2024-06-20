Return-Path: <linux-kernel+bounces-222905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40991097E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B28B1C21325
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604C119B3EC;
	Thu, 20 Jun 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLrfSJwk"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE7A26AE8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896502; cv=none; b=nydYZP4jPt6gT5ye+mXA21fq6PXVQvYulNcFSI0c7pemyxd/wYMLSUnS8pPR4W4YkXxj7Iigl1xNgzflQorbmXKR+caIIon67+gW6JsY+qpUB1X1VtoMj8tgjgbvx3jHv3bUMX8W8KhKARH43/x+ErkublzI2a/CdR9ef5WR25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896502; c=relaxed/simple;
	bh=lz3BOHPbrV9ue2IQ/GjEc7GK+aOqkc6HCQO4gNYk5xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ahTMlJyb2nIZ1qjudnEJ75tgFB3rPRVpHecF3InU8s8e82MIVwMzsNsyVcTzHCeU+5WId0c+AHEc+bHlnCzGn+k6m/8FDPQzSbP+0ANR2DmmBcK8Q5+SKyVkpQ2qyODhSfMK0tBZ2/2w1foRpvZxKWS0eR4QGwEdjXMvvEIvD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLrfSJwk; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e02748b2402so1130705276.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896498; x=1719501298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9guc84Gchla6fWBOTCy+Mf9QLNavuevhtReJrUxDmLY=;
        b=XLrfSJwkdg+puXlRQOcaraTiVymhfdyXMnZq11jSIleLrKpqTojHmtjdPlu6LuOhyx
         3wWl0c4BWTb9OM0g+GqMvRXVTsXCTNwT8HpM222f4t13h4Ev/icUUR5jfynrDJs/6z1g
         nZpDFGyoVaZrvEW20MnTv0Gj5CtJIf7OSLy8MX3Vlid6pw35EoWqgpDCGLVFLgzLU/c9
         TF80SqsDxBrY13ut3MUzncJbDnGabppr7P82COFr8l4mYEQUu/c1Fucpm/NabLZeCvbC
         3PbSlQvB0Kgdl/QxBFBrCg/QfrzFoOJj6Zz8tJR9lOnCs/72HuUe7JPRwbbQ8jpfHn8J
         gfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896498; x=1719501298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9guc84Gchla6fWBOTCy+Mf9QLNavuevhtReJrUxDmLY=;
        b=sTJOAAdL+OyNdGeCAfi+ayxOumweGfWnfRR9gTv/gclZZcpGTeLINKiZ+S5J0eho7w
         f6pEiX2+v2OBvNzPTIpVJmq0jPvfH3LPoTNERJPLcONzqMpQuqFAMMloqVuP4A2Cj0Qb
         maZf8WAhvWww7ShiF6VyXovbjUu5u94KEJY5DaVIUGWraBpb6z6VukEpk5K199shWbMy
         eBFMAiNPbopDxH+yICMArPhW+c4MeCVFChUmjOlgDiEdlbSkkJR6Jgunc/ofUt65NyCM
         ISpiT7hVh+N4T41YMLIZorlaPU4eF+ghpx6dgp00GdFprZAXhk42nPcld8dethovvwcu
         QWHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsDquPv9sqkWP62TYwXYiBVyfH3IHbxc6Hdg86edjqPwAJHgFLi6jszcfwSGY/O7AM/fhayRgBaH/N2txmeIw4iO+CpTX3C2+DvZ0G
X-Gm-Message-State: AOJu0YyXdYTGJIxqowacJpwOkkjz+gj7cXq3MQIStTb5+rKOFkBHeVte
	+2Z04PVDfKEYGK1nt3UC+K8WMcSEi5reSJCt9jD2vk6RV2EVo728Eb3GjyOisN3roJ62xtQMchC
	UJa/wyTf4qcCqW3tDN9eqXaAwdGbvBQNNL64uGKREAXFTzUMF
X-Google-Smtp-Source: AGHT+IH6LIN/vpcDotvk+Oh6j6vDVI1v3GEU01qU7DJ8PJNlH9KlHTY/JAb+18RbHiWT8y0dyadEsog30/o2UAJ03Zo=
X-Received: by 2002:a25:824a:0:b0:e02:b65d:6e11 with SMTP id
 3f1490d57ef6-e02be13b4c8mr6144708276.5.1718896498312; Thu, 20 Jun 2024
 08:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611-md-drivers-mmc-v2-1-2ef2cbcdc061@quicinc.com>
In-Reply-To: <20240611-md-drivers-mmc-v2-1-2ef2cbcdc061@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 17:14:22 +0200
Message-ID: <CAPDyKFqniea558arz-9tJm26Rx_KyOROtpwShq6MHUXsww=ptg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 17:50, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
>
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/of_mmc_spi.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/tmio_mmc_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/host/renesas_sdhi_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/mmc_core.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_simple.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_sd8787.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/pwrseq_emmc.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/mmc/core/sdio_uart.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for TMIO and SDHI
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Corrections to these descriptions are welcomed. I'm not an expert in
> this code so in most cases I've taken these descriptions directly from
> code comments, Kconfig descriptions, or git logs.  History has shown
> that in some cases these are originally wrong due to cut-n-paste
> errors, and in other cases the drivers have evolved such that the
> original information is no longer accurate.
> ---
> Changes in v2:
> - Updated descriptions in core/pwrseq_emmc.c, core/pwrseq_simple.c, and
>   host/renesas_sdhi_core.c per guidance from Dragan.
> - Link to v1: https://lore.kernel.org/r/20240610-md-drivers-mmc-v1-1-c2a2593e4121@quicinc.com
> ---
>  drivers/mmc/core/core.c              | 1 +
>  drivers/mmc/core/pwrseq_emmc.c       | 1 +
>  drivers/mmc/core/pwrseq_sd8787.c     | 1 +
>  drivers/mmc/core/pwrseq_simple.c     | 1 +
>  drivers/mmc/core/sdio_uart.c         | 1 +
>  drivers/mmc/host/of_mmc_spi.c        | 1 +
>  drivers/mmc/host/renesas_sdhi_core.c | 1 +
>  drivers/mmc/host/tmio_mmc_core.c     | 1 +
>  8 files changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a8c17b4cd737..d6c819dd68ed 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2362,4 +2362,5 @@ static void __exit mmc_exit(void)
>  subsys_initcall(mmc_init);
>  module_exit(mmc_exit);
>
> +MODULE_DESCRIPTION("MMC core driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
> index 3b6d69cefb4e..96fa4c508900 100644
> --- a/drivers/mmc/core/pwrseq_emmc.c
> +++ b/drivers/mmc/core/pwrseq_emmc.c
> @@ -115,4 +115,5 @@ static struct platform_driver mmc_pwrseq_emmc_driver = {
>  };
>
>  module_platform_driver(mmc_pwrseq_emmc_driver);
> +MODULE_DESCRIPTION("Hardware reset support for eMMC");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/core/pwrseq_sd8787.c b/drivers/mmc/core/pwrseq_sd8787.c
> index 0c5808fc3206..f24bbd68e251 100644
> --- a/drivers/mmc/core/pwrseq_sd8787.c
> +++ b/drivers/mmc/core/pwrseq_sd8787.c
> @@ -130,4 +130,5 @@ static struct platform_driver mmc_pwrseq_sd8787_driver = {
>  };
>
>  module_platform_driver(mmc_pwrseq_sd8787_driver);
> +MODULE_DESCRIPTION("Power sequence support for Marvell SD8787 BT + Wifi chip");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
> index df9588503ad0..154a8921ae75 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -159,4 +159,5 @@ static struct platform_driver mmc_pwrseq_simple_driver = {
>  };
>
>  module_platform_driver(mmc_pwrseq_simple_driver);
> +MODULE_DESCRIPTION("Simple power sequence management for MMC");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
> index 575ebbce378e..6b7471dba3bf 100644
> --- a/drivers/mmc/core/sdio_uart.c
> +++ b/drivers/mmc/core/sdio_uart.c
> @@ -1162,4 +1162,5 @@ module_init(sdio_uart_init);
>  module_exit(sdio_uart_exit);
>
>  MODULE_AUTHOR("Nicolas Pitre");
> +MODULE_DESCRIPTION("SDIO UART/GPS driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index bf54776fb26c..05939f30a5ae 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -19,6 +19,7 @@
>  #include <linux/mmc/core.h>
>  #include <linux/mmc/host.h>
>
> +MODULE_DESCRIPTION("OpenFirmware bindings for the MMC-over-SPI driver");
>  MODULE_LICENSE("GPL");
>
>  struct of_mmc_spi {
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
> index 12f4faaaf4ee..58536626e6c5 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1162,4 +1162,5 @@ void renesas_sdhi_remove(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
>
> +MODULE_DESCRIPTION("Renesas SDHI core driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 93e912afd3ae..c1a4ade5f949 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1319,4 +1319,5 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
>  #endif
>
> +MODULE_DESCRIPTION("TMIO MMC core driver");
>  MODULE_LICENSE("GPL v2");
>
> ---
> base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
> change-id: 20240610-md-drivers-mmc-cb5f273b5b33
>


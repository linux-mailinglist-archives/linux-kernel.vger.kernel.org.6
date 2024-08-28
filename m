Return-Path: <linux-kernel+bounces-305265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF3962C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E352B2203E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344951A2C0E;
	Wed, 28 Aug 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S0/EV+rw"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F551A00F4
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858643; cv=none; b=gkYx17sSF3RP49Sy/08WWAK2KpTaNMXWCpW6o9ELsjnP9/KCvw3SyRFgWjO8Hko164VbQdFvhX6aXEztVtQJQUAueVlywqpxirTS3Q8ywv4Q+teRFfGuwLYZUR0gsaVAJn+LgCyeHiTYrUKPSJ5KP7KAA7rxbmkUh1e9D/DSKeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858643; c=relaxed/simple;
	bh=BvSMw8yg2LkQSKywm9vpxy8LiwnELHUOuZT6XhNtUTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5FtzkIhItZDKihHpAsb6RMpb67dd+onaLcGKke9ye4BVmZAhzTXrS09dbhyh4/zIMkwReF95LkoikciiYaxbuaEnJywkZYDsWsnXhLYLrvFv/s9gL64FUBHrKsPHyz4AFTlBFk4DQ7MlgAj0Fklz4Vrtize0C5wt/3x/+pMIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S0/EV+rw; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso7385752276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858641; x=1725463441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4dyecj1atvVOzm4XdX1oXkqk42toDzs0yGLdIhqTNSc=;
        b=S0/EV+rwIyeUfUwWYCUIyZBIUivxeVUq2gPhhfPfXxlR9/TDY1bM+BqSoYLRsc4WKc
         wLGKQ8S/e//1Jujt+Md3ZGQ4cHhMWpMRlYHww4nU9CwX/S3lV+uushrnVSPi6H6HfNia
         YToChovOCJLS663BixUyEYy80sJpRYNpGpoXJIJ6FBgEllTXkVIfRI8hnwi1mBBbqDBQ
         FaocWSULENAi5B7yNYnlOoYt49DTppTqjfBFnuXuHFTHtg/tsN4+SoQ1HNOH/NFg7S8Z
         SUzmJgAoeCX6lyuP5tJa3spK9ynxd/tYuCAvnYQrTJkGekuliAokQqQN1MrGJ21dLQbv
         LOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858641; x=1725463441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4dyecj1atvVOzm4XdX1oXkqk42toDzs0yGLdIhqTNSc=;
        b=bvzog/4cZ5/F8EodU3AGbdJAoHJqRnb/pRyL+JBsVP4ZogGtfK1kUtuENMA6jsOU5N
         x8s/kgm4sJsoZimb281BYJhdeCbFv9JEe+wNGndWm7lgrnJjWuGNU8V6RrEsVNyEfkVy
         aDa+bYyB7JNlreAO+s/v+bIomhILIOvO4HgClZbfN8tFWqECjVOdEs3JB7s9WU+qk/W/
         KpRbPkE3SOiRwIpHmaNNbjw4ezx51qEYc/+BRepAmkr96p2tXE9vWEeoeBPn1puGxUul
         Mb1i168vMEZlJ45QESSvOmdb/zHGRpEESkYWKAeiM3Ak4PkqKYpGxGO/gPYGiXDCRLEd
         wMPA==
X-Forwarded-Encrypted: i=1; AJvYcCVuMQaeP5uijwBoyw9lPYBCgZ9AR4kqyNBiQ3JMBBMK9yWvWsl0xPGV3O69D32PHGQ7nodiHjyekB1UnEM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf1LwdV7iPzvHQYr0UD2QqJWrgga3HzptApySz4+nJLAx5vYAI
	SWy9CdnToDPolXG5apI4XVIRD4n0stN0+WUESoBszvCCnfUF5mOsJiffINwUX17mViFDJXpYF1p
	IV7I2lTWGZdf4D2ekosa5a+R6Usd12Fx0c9JHXQ==
X-Google-Smtp-Source: AGHT+IEOy2MkQVBEysNvyZMAM2fTzxX+1tGLn7Vroz2+sN8rIgjVDzd6/CyoHDrg0kcF5TFkzOmjVMOmjASdfqlh6RI=
X-Received: by 2002:a05:6902:1026:b0:e13:c984:d7cf with SMTP id
 3f1490d57ef6-e17a8682365mr17694339276.50.1724858640776; Wed, 28 Aug 2024
 08:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <73703c853e36f3cd61114e4ac815926d94a1a802.1724695127.git.limings@nvidia.com>
 <20240827164016.237617-1-limings@nvidia.com>
In-Reply-To: <20240827164016.237617-1-limings@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Aug 2024 17:23:24 +0200
Message-ID: <CAPDyKFohKt0E7zjnq0c9MkOLEEKZPtonWeDfz4w4Pw23=+uNtQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Add hw_reset() support for
 BlueField-3 SoC
To: Liming Sun <limings@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, David Thompson <davthompson@nvidia.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Aug 2024 at 18:40, Liming Sun <limings@nvidia.com> wrote:
>
> The eMMC RST_N register is implemented as secure register on
> the BlueField-3 SoC and controlled by TF-A. This commit adds the
> hw_reset() support which sends an SMC call to TF-A for the eMMC
> HW reset.
>
> Reviewed-by: David Thompson <davthompson@nvidia.com>
> Signed-off-by: Liming Sun <limings@nvidia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v1->v2:
>     Fixed a typo reported by test robot.
> v1: Initial version.
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index ba8960d8b2d4..8999b97263af 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> @@ -201,6 +202,9 @@
>                                          SDHCI_TRNS_BLK_CNT_EN | \
>                                          SDHCI_TRNS_DMA)
>
> +/* SMC call for BlueField-3 eMMC RST_N */
> +#define BLUEFIELD_SMC_SET_EMMC_RST_N   0x82000007
> +
>  enum dwcmshc_rk_type {
>         DWCMSHC_RK3568,
>         DWCMSHC_RK3588,
> @@ -1111,6 +1115,29 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .irq                    = dwcmshc_cqe_irq_handler,
>  };
>
> +#ifdef CONFIG_ACPI
> +static void dwcmshc_bf3_hw_reset(struct sdhci_host *host)
> +{
> +       struct arm_smccc_res res = { 0 };
> +
> +       arm_smccc_smc(BLUEFIELD_SMC_SET_EMMC_RST_N, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +       if (res.a0)
> +               pr_err("%s: RST_N failed.\n", mmc_hostname(host->mmc));
> +}
> +
> +static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
> +       .set_clock              = sdhci_set_clock,
> +       .set_bus_width          = sdhci_set_bus_width,
> +       .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> +       .get_max_clock          = dwcmshc_get_max_clock,
> +       .reset                  = sdhci_reset,
> +       .adma_write_desc        = dwcmshc_adma_write_desc,
> +       .irq                    = dwcmshc_cqe_irq_handler,
> +       .hw_reset               = dwcmshc_bf3_hw_reset,
> +};
> +#endif
> +
>  static const struct sdhci_ops sdhci_dwcmshc_rk35xx_ops = {
>         .set_clock              = dwcmshc_rk3568_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
> @@ -1163,7 +1190,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_pdata = {
>  #ifdef CONFIG_ACPI
>  static const struct dwcmshc_pltfm_data sdhci_dwcmshc_bf3_pdata = {
>         .pdata = {
> -               .ops = &sdhci_dwcmshc_ops,
> +               .ops = &sdhci_dwcmshc_bf3_ops,
>                 .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>                 .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>                            SDHCI_QUIRK2_ACMD23_BROKEN,
> --
> 2.30.1
>


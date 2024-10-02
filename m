Return-Path: <linux-kernel+bounces-348394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9A98E71D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 01:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5116F287265
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2C31A0AF8;
	Wed,  2 Oct 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5iqB3AX"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4DF1A073A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912201; cv=none; b=cRCBZ+BqnHA6pIoIvrCjg16Jg8SugAWpeH5k1WomclAYmTOxodHIXa2iTXWygyRI6mP8Osfm8umeGVyeyvurPv/O2YbimBEK4er7bmwahEcs00vguyIN2tL6wAQJXfDEQ3SKEmV43pm7WMCIC6LIVFm0ncvTou8ysSFrOBbQJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912201; c=relaxed/simple;
	bh=5s9fgEJJm3vIqJWWqzj827Opu4XIE8ALgS6t+bs8cdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DA9bPx/gdHA55EL9SyEaSJgI98uIrHoNo5Jd3+mD+TNDawKb2Iy6aYobFeTnzR42FBvzy2iQhiAJDJOeNzbtNMdjZ8yxlQDerbPFGxxomztO24dDl6C/dFvdq5akRKiDyTbCrfsHh0fsUmwF6ZJ/AUsVkA9167EHonu4858/Ces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5iqB3AX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso348538276.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727912198; x=1728516998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CpxVnqiBvGUz/tZ0CRcfx8m431yx70f+LHljar+QbKE=;
        b=g5iqB3AXFiGAKb2jSh8B88vA9GaZ3xmwQs4eXyXp1d+IZzfQsRRA9LBkXZWdL9ElbZ
         lJFjfYPnAiGm8BLNs0cbJ3uXPmqjzkZmu0OEWC7/0UX3cp95PT4VNIG+cMk7iksGO3vN
         YOK2buUr38GJg8Mh0kCZLMNLPvGAfLkDC2Rzbg3MN7mZMdqGJ2ABAYb+/VS9UCUfJuTH
         qVBw2fFx+z8qVRW030ZNHvpp7nnUcZbz0biZt9ZzDFukrP2Z9LveSdTo9KZ5OGpRj4IK
         VwKq3RENDE0FeqBUfaRxo6wtbCqi0loucwmMXz+JraPBZ1pFu0xpDvz9yxW18Nn+mzJi
         eH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727912198; x=1728516998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpxVnqiBvGUz/tZ0CRcfx8m431yx70f+LHljar+QbKE=;
        b=sEUJ91nJYpET57jgVwpUN6pIG5rXoyxq/kpdPXjFPCqgVnrBjxDb3WJHHdoGcbw1z+
         gKoD1roKGHPyHy7Z4aGgN8lt/z/AEpxRNBvGa236VSBRubzR5Rqv/3Vnum00eBHWDDl8
         s8WPnZzhHa8BZNKaQwFVmkTJTJWZFld55uWw+pG/oAWplbwySyBJP0OJUZPEVzuMC6CQ
         CRLDU2/EWMjpw27J9MtyOvjNKgLlLu6ljsDNJRWbup0wuGqtthfyES+4DKQq58kTbfOt
         cjypLMFqR5jEnX2Ttz33+PZ2XckGT549pyb+GYADoFDFxQ1HqRMnFFZXGbS0lBCes4HI
         yYnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPg3H0NAPhMvdeHWpTVfHaty2vEgiwqSiLzhGKBD5R2TKhCm/s1DLJhPyMS43ymAj9j7LzAvRzcznTmcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBl1tF/olf6MKh/FC9onKco/ZuGfJTav8AEUPr4LJLvDtSw3K
	VCxAMdHGr8DfWPSiSDKjFjwJl7YnDMdTtzBBKATvuAQZ6+3PqQn66R0E6+/Q7HloVT3NmwdJdZO
	/VVU6GsDbSZ0Ie4XOOS2jtFos880x5CMK3f68kQ==
X-Google-Smtp-Source: AGHT+IH76/6CNpsmHNwM+J2W33bu6H3fzHw03x8vBTe5b7vd4XavJEUFRNUtBXeEFfIHN2Lb52888Jci5N0uiu6ms6I=
X-Received: by 2002:a05:6902:2209:b0:e1d:9338:a4d7 with SMTP id
 3f1490d57ef6-e2638416e6dmr3933856276.44.1727912198556; Wed, 02 Oct 2024
 16:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913185403.1339115-1-jm@ti.com>
In-Reply-To: <20240913185403.1339115-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 01:36:02 +0200
Message-ID: <CAPDyKFrPWdNWoG5uxdH3yE8uT1KKV-mZ7iSfw57sinm909xeBg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 20:54, Judith Mendez <jm@ti.com> wrote:
>
> The sdhci_start_signal_voltage_switch function sets
> V1P8_SIGNAL_ENA by default after switching to 1v8 signaling.
> V1P8_SIGNAL_ENA determines whether to launch cmd/data on neg
> edge or pos edge of clock.
>
> Due to some eMMC and SD failures seen across am62x platform,
> do not set V1P8_SIGNAL_ENA by default, only enable the bit
> for devices that require this bit in order to switch to 1v8
> voltage for uhs modes.
>
> Signed-off-by: Judith Mendez <jm@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - Invert quirk logic
> - Simplify sdhci_am654_start_signal_voltage_switch() and call
>   sdhci_start_signal_voltage_switch() when the quirk does not apply
> - Simply logic when detecting when quirk should be applied
> ---
>  drivers/mmc/host/sdhci_am654.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 0aa3c40ea6ed8..9ff07aadb2d91 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>         u32 tuning_loop;
>
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> +#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>
>  struct window {
> @@ -356,6 +357,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         sdhci_set_clock(host, clock);
>  }
>
> +static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> +           ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       ret = mmc_regulator_set_vqmmc(mmc, ios);
> +                       if (ret < 0) {
> +                               pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> +                                      mmc_hostname(mmc));
> +                               return -EIO;
> +                       }
> +               }
> +               return 0;
> +       }
> +
> +       return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>         writeb(val, host->ioaddr + reg);
> @@ -844,6 +868,11 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>         if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>                 sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>
> +       /* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
> +       if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
> +           !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
> +               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> +
>         sdhci_get_of_property(pdev);
>
>         return 0;
> @@ -940,6 +969,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>                 goto err_pltfm_free;
>         }
>
> +       host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
>         pm_runtime_get_noresume(dev);
>
> base-commit: cf6444ba528f043398b112ac36e041a4d8685cb1
> --
> 2.46.0
>


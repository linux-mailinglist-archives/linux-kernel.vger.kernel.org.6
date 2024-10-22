Return-Path: <linux-kernel+bounces-376263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498309AA265
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2EA21F23033
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EF19D8AC;
	Tue, 22 Oct 2024 12:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQIBf1zF"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57541E885
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601164; cv=none; b=cCHWChbON6tdes3QHY2HJPGOrUAZhYYl9qR2JgRLvyzTcZwnlTGhn95MDvdODnc5NeqCGOAf9YIl8Rtt82A2X/nBYTRUQiAiOCtkvY7kTnviyeiMiqC2Lp1RwM2ZNgXpzeNST4MPLwOMX2fP+6l6nvi+FVYS3KEdJ2xyMQ6JD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601164; c=relaxed/simple;
	bh=1SMYQWnLF9fBxUsd+Xxv1cJstIYM3ZDaItV2t3AHS9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrVdf4neRKxiJnbKe7y2UdpBQlg5Fk7yGDl6wFyLqr74Uk+5lA7mKF9HAjHyvnOZsBZOdWFPTUXycXZRls/0QYRF1qLzTfchk6A6CghpISUJK9LrtKFp4cuAF28sc+/iegOCz8vY/SsB4pgL5bDgkouNOPAD46cEXSBPlBpBP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aQIBf1zF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso5419047276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729601162; x=1730205962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oJkHJf4mh9HqwTqqQRLQ5SRsn4jSs4uDzYtNQyv524Q=;
        b=aQIBf1zFVMeYywDWIgm9rQE7K/UyarYTTKcWjumtjfMZVoAwxxTuoBM6k8n+799ky9
         0JuAIWBvO9TSd7mh5/0UwxMJHEALSoU290bwyx1g7GKXHdjiBd221uF/q84LLN/6tioS
         yvpIinip6vU7/EOsD7Fdanlt/OS8KtGI+01JWI71+/pBc+4KCjG6YSI5FMjOy2Owcwdy
         eVVfH5+h+8DVjiCbYq36lYIG5XUeRRdXaoRsugqyjMbCO5vB/GhdHxRFEwHrPtiOniu0
         0v2hyJkzuNayeTiV/OZ29vNY5rYRLOEyxt7MqxO32gKGtm1tv1KtbhJAHuGKpDafAJOr
         ZDDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729601162; x=1730205962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJkHJf4mh9HqwTqqQRLQ5SRsn4jSs4uDzYtNQyv524Q=;
        b=qBSezRmsimgqGMYodUJPwHw0CPzWZSYnjveS3+kUbFxiLw3Tlg6wtRZLpQaUejpEDI
         XabprND6btgAtTSAmEZETRXkqP38tTeWISucAPpt4NyJorzrBw9ayFEIV/WNAZTzb0q1
         WVhDUFOJRYxGG/5Wenf0yG2m99r49ZPDG1e2edy5OgsgnoElg7tE2WYR+ArDCj+xseR+
         VeGAsFp2f4ezLmKc8V0+PQjYO4zPl6CsVXTw25unEE5sgx5ACnyX0nW2jmEMuBujq5Ja
         +TW4pV/tanhOnXvO2Ust+FuJ+ax7uzEOUH3hoFXqhuIrQBrGuySj3EcVLF6Slqi/a2jG
         Cdog==
X-Forwarded-Encrypted: i=1; AJvYcCXXau1i1TDnN4Y+GO+KN0mWsoIbNJ5JxfezQYXTa+NA+9AvhlVXjntDNH915cmbL0Zk/bcxkS5Y2q+GAaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8Cv6n4uJeoRdyNiOwNcb+A6608kgHit51Smz/1EQ1WRil2T7C
	KYC2wdSJvt2ELVL87Fs5c+a4ZFl0twQdva1M6hh4ZYfmFnPR1KHf+SZ6aZmQpWd4+FLJWD6eWEK
	dANZOF8B7gYh+xl9JvcwkcqcfTHfqRL/5jKwHsw==
X-Google-Smtp-Source: AGHT+IEtF7himK3SEPJA6zWJJocdJtciidCCJzEsFWdUth1AlWMqMwsMhdBf5wluQG8tEgKhptAenRDinPNyvE734vU=
X-Received: by 2002:a05:6902:a87:b0:e26:2b76:9f94 with SMTP id
 3f1490d57ef6-e2bb16910c3mr11545004276.40.1729601161876; Tue, 22 Oct 2024
 05:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022111025.25157-1-quic_rampraka@quicinc.com>
In-Reply-To: <20241022111025.25157-1-quic_rampraka@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 14:45:26 +0200
Message-ID: <CAPDyKFr8EhLU8EhydypLwL_PZH0+KMTqAU_D7AFdNmRac5R=vg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-msm: Toggle the FIFO write clock after ungate
To: Ram Prakash Gupta <quic_rampraka@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_pragalla@quicinc.com, 
	quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_narepall@quicinc.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Oct 2024 at 13:10, Ram Prakash Gupta
<quic_rampraka@quicinc.com> wrote:
>
> For Qualcomm SoCs with sdcc minor version 6B and more, command path
> state machine is getting corrupted post clock ungate which is leading
> to software timeout.
>
> Toggle the write fifo clock to reset the async fifo to fix this issue.
>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>

Seems like we should add a stable tag, but do we have a fixes tag that
we can use too?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-msm.c | 41 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e113b99a3eab..c2ccdac21232 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -146,6 +146,7 @@
>  /* CQHCI vendor specific registers */
>  #define CQHCI_VENDOR_CFG1      0xA00
>  #define CQHCI_VENDOR_DIS_RST_ON_CQ_EN  (0x3 << 13)
> +#define RCLK_TOGGLE BIT(1)
>
>  struct sdhci_msm_offset {
>         u32 core_hc_mode;
> @@ -290,6 +291,7 @@ struct sdhci_msm_host {
>         u32 dll_config;
>         u32 ddr_config;
>         bool vqmmc_enabled;
> +       bool toggle_fifo_clk;
>  };
>
>  static const struct sdhci_msm_offset *sdhci_priv_msm_offset(struct sdhci_host *host)
> @@ -1162,6 +1164,39 @@ static int sdhci_msm_restore_sdr_dll_config(struct sdhci_host *host)
>         return ret;
>  }
>
> +/*
> + * After MCLK ugating, toggle the FIFO write clock to get
> + * the FIFO pointers and flags to valid state.
> + */
> +static void sdhci_msm_toggle_fifo_write_clk(struct sdhci_host *host)
> +{
> +       u32 config;
> +       struct mmc_ios ios = host->mmc->ios;
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       const struct sdhci_msm_offset *msm_offset = msm_host->offset;
> +
> +       if ((msm_host->tuning_done || ios.enhanced_strobe) &&
> +               host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
> +               /*
> +                * Select MCLK as DLL input clock.
> +                */
> +               config = readl_relaxed(host->ioaddr + msm_offset->core_dll_config_3);
> +               config |= RCLK_TOGGLE;
> +               writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config_3);
> +
> +               /* ensure above write as toggling same bit quickly */
> +               wmb();
> +               udelay(2);
> +
> +               /*
> +                * Select RCLK as DLL input clock
> +                */
> +               config &= ~RCLK_TOGGLE;
> +               writel_relaxed(config, host->ioaddr + msm_offset->core_dll_config_3);
> +       }
> +}
> +
>  static void sdhci_msm_set_cdr(struct sdhci_host *host, bool enable)
>  {
>         const struct sdhci_msm_offset *msm_offset = sdhci_priv_msm_offset(host);
> @@ -2587,6 +2622,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>         if (core_major == 1 && core_minor >= 0x71)
>                 msm_host->uses_tassadar_dll = true;
>
> +       if (core_major == 1 && core_minor >= 0x6B)
> +               msm_host->toggle_fifo_clk = true;
> +
>         ret = sdhci_msm_register_vreg(msm_host);
>         if (ret)
>                 goto clk_disable;
> @@ -2720,6 +2758,9 @@ static __maybe_unused int sdhci_msm_runtime_resume(struct device *dev)
>                                        msm_host->bulk_clks);
>         if (ret)
>                 return ret;
> +
> +       if (msm_host->toggle_fifo_clk)
> +               sdhci_msm_toggle_fifo_write_clk(host);
>         /*
>          * Whenever core-clock is gated dynamically, it's needed to
>          * restore the SDR DLL settings when the clock is ungated.
> --
> 2.17.1
>


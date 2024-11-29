Return-Path: <linux-kernel+bounces-425883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5395D9DEC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C112B22FA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D41A08C5;
	Fri, 29 Nov 2024 18:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4tQWCg4"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D614D430
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732905884; cv=none; b=C2Y+vNAJXxN1v7kRrPtBPPn8iM+je1Jl6DqQ/IU/kQ84V08BgIaV/mIUBdgVeo7fXU6fITjWiiBMptejSl8hwDtMSpOwDCqWP+EC0F4E2gzVelVzncrS9jxhBywhqqJB+p8+8asHBJAyUAd64AS2u2TqimF0Rq/vBwsd6PM8nFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732905884; c=relaxed/simple;
	bh=hQcFmzIN5wiJjr7Uxk8hCjS0qmPcjwZE/5VgFTHdzxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtUpgZfAAYanBVhlEq9zLVUVPI3fdhmAVz6wQUKIN+EI1ZkaVCvjoHiI7ZN13o6RVIYGBpqLLX+hhOQT5wrddJQ/09tpoI8ucK3oO66zcMXCjfhd6k0AKiLK0sLjN2joOnCIEKyYBB5SK2RVlXolxrkr+iTkmeWBdLLkj8L7OB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4tQWCg4; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53df63230d0so2677756e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732905881; x=1733510681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOiKspxipILPKcvO1wYQ1RT/mi2iBB8R5lFWNQVT9HM=;
        b=F4tQWCg4i1fiZXctSRhDvfpfkTzIWDHaO8p+BAqiSxK+8W1HJFVKC8SrMwcNSnzHhl
         uh2jBR+h+W90dfvigUOa5MO+ty+ynAkUtvuTKepqHnOgkZulHqO9rM9/CQc79h/BtFnZ
         c/wE7nENYOUmXbbbSqN8epcFft0hXS+ZBnQIBipH1Rk8KZqshhvHjDjbXrQM98zcEC1Z
         pRNvFteTlwIIEtTZ9VS2euzbxgSESqXQ6oXQUcBoDEFnheELpnKucKWny3ch5Ow+VXD5
         xru4Pro/nlgzZcdSj+5EsR4eVUNczhrY0u3IV4vAbSwiL8OWlB/pc6yRfKf5+JlmGRK+
         QbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732905881; x=1733510681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOiKspxipILPKcvO1wYQ1RT/mi2iBB8R5lFWNQVT9HM=;
        b=a5D3U4JGt1LUf81F79wFGkepK3fvgNPxoZqV7e5+pXGfBLwiE6eegq1KL7aAQA1hC3
         35iIGSBrm9Atn3tQP05qnYFsObktBu2FiGizi0NXrqi7i49F4G5Qs3Tbr+h9mVTT+7K6
         ZBWY8ZXOxKylKo7X+Bu1ZJbWehqmlg6CvILbKCVxa6ueCEiPScfDzNc9SUahNh2lzOjt
         ITruVRB7v5nQuiPaE0XcYYo6//SkzRWeyHxmG60hJmNa40nwadg+X1PYO+zLmzAZOxcY
         1tfrS8a16R08qyGJO7NhEXowXm2GND4zAmQJaKAQaRvYr4GlDUhjj72h0lemk7GhLNk2
         U2dw==
X-Forwarded-Encrypted: i=1; AJvYcCVMoEx6Z6bi3Vy+m0N7dK+ws9r4JfZ7BwERUWt+1Rt1+DwiXjdWqRnOWKRX5ZiltrQRdLUgdpC0iy//EcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUjLm4JqxEyhWmdCeRjr7Kimlfy9ILc62/KzOGmmos2ZxIJUB
	FHjuHQ9d6ZwqcZqUcmUi9TgdPRk1cc8+lTnIBNk/0unRF0HKLbPYnpVyrdd/g44=
X-Gm-Gg: ASbGncvNPHKEUA2fTNac/gC8VeoSuBxS4FVbGZ6syRSQz8rp4BECyYqAuBDGMusIKng
	vj0455YKPPvPcroIwQ90iXRN3Qj0ukUX+y5e68NvKW8Ds3WE/SNPVft9LRU45XSfnCA9n9r8hlk
	VKP0B2k0CdWmBNFkflvX5FFDp28Ug8MeoL8RoQ6a+oSl0MEdmy8j2/Qm7JkIi/ulkFAsBgHv82A
	/1HT5C8wtuzzCGMYOJ6pZYHQ9gz60XgU3Re8acU6p+fuM+aNee/BQJxeVT7MH6IwxByvly7nSuY
	pGlIUAkxRWy/7KQiG8BbJtjEAA+PSw==
X-Google-Smtp-Source: AGHT+IGU+Gk14+Fy7vKtqK+f88i86zD4DWOjZyAi4B5JlY1q48Z1pc3ZNJuAseKpBn27HIL/89ZZ7w==
X-Received: by 2002:a05:6512:3c89:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53df00c5ebamr8555719e87.4.1732905880726;
        Fri, 29 Nov 2024 10:44:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df643110asm553346e87.32.2024.11.29.10.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 10:44:39 -0800 (PST)
Date: Fri, 29 Nov 2024 20:44:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_tingweiz@quicinc.com, quic_zhgao@quicinc.com
Subject: Re: [PATCH v2] mmc: sdhci-msm: Correctly set the load for the
 regulator
Message-ID: <cj7nsn2xphd4ftnhtp6ztor4cqyjsdwkubjgancfd3xojddj4s@m3pb4qc645sn>
References: <20241127095029.3918290-1-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127095029.3918290-1-quic_yuanjiey@quicinc.com>

On Wed, Nov 27, 2024 at 05:50:29PM +0800, Yuanjie Yang wrote:
> Qualcomm regulator supports two power supply modes: HPM and LPM.
> Currently, the sdhci-msm.c driver does not set the load to adjust
> the current for eMMC and SD. Therefore, if the regulator set load
> in LPM state, it will lead to the inability to properly initialize
> eMMC and SD.
> 
> Set the correct regulator current for eMMC and SD to ensure that the
> device can work normally even when the regulator is in LPM.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---
> Changes in v2:
> - Add enum msm_reg_type to optimize the code
> - Delete redundant emmc type judgment
> - Link to v1: https://lore.kernel.org/linux-arm-msm/20241122075048.2006894-1-quic_yuanjiey@quicinc.com/
> 
> ---
>  drivers/mmc/host/sdhci-msm.c | 92 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 90 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e00208535bd1..fc13ef60ab61 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -134,9 +134,22 @@
>  /* Timeout value to avoid infinite waiting for pwr_irq */
>  #define MSM_PWR_IRQ_TIMEOUT_MS 5000
>  
> +/* Max load for eMMC Vdd supply */
> +#define MMC_VMMC_MAX_LOAD_UA	570000
> +
>  /* Max load for eMMC Vdd-io supply */
>  #define MMC_VQMMC_MAX_LOAD_UA	325000
>  
> +/* Max load for SD Vdd supply */
> +#define SD_VMMC_MAX_LOAD_UA	800000
> +
> +/* Max load for SD Vdd-io supply */
> +#define SD_VQMMC_MAX_LOAD_UA	22000
> +
> +#define MAX_MMC_SD_VMMC_LOAD_UA  max(MMC_VMMC_MAX_LOAD_UA, SD_VMMC_MAX_LOAD_UA)
> +
> +#define MAX_MMC_SD_VQMMC_LOAD_UA max(MMC_VQMMC_MAX_LOAD_UA, SD_VQMMC_MAX_LOAD_UA)
> +
>  #define msm_host_readl(msm_host, host, offset) \
>  	msm_host->var_ops->msm_readl_relaxed(host, offset)
>  
> @@ -147,6 +160,11 @@
>  #define CQHCI_VENDOR_CFG1	0xA00
>  #define CQHCI_VENDOR_DIS_RST_ON_CQ_EN	(0x3 << 13)
>  
> +enum msm_reg_type {
> +	VMMC_REGULATOR,
> +	VQMMC_REGULATOR,

Please drop enum completely, then...

> +};
> +
>  struct sdhci_msm_offset {
>  	u32 core_hc_mode;
>  	u32 core_mci_data_cnt;
> @@ -1403,11 +1421,71 @@ static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
>  	return ret;
>  }
>  
> -static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
> +static int sdhci_msm_get_regulator_load(struct mmc_host *mmc, int max_current,
> +					enum msm_reg_type type)
> +{
> +	int load = 0;
> +
> +	/*
> +	 * When eMMC and SD are powered on for the first time, select a higher
> +	 * current value from the corresponding current for eMMC and SD to
> +	 * ensure that the eMMC and SD cards start up properly and complete
> +	 * initialization. After the initialization process is finished, use
> +	 * the corresponding current to set the eMMC and SD to ensure the
> +	 * normal work of the device.
> +	 */
> +
> +	if (!mmc->card)
> +		return max_current;
> +
> +	if (mmc_card_mmc(mmc->card))
> +		load = (type == VMMC_REGULATOR) ? MMC_VMMC_MAX_LOAD_UA : MMC_VQMMC_MAX_LOAD_UA;
> +	else if (mmc_card_sd(mmc->card))
> +		load = (type == VMMC_REGULATOR) ? SD_VMMC_MAX_LOAD_UA : SD_VQMMC_MAX_LOAD_UA;

... split this into two functions, one for vmmc and another one for
vqmmc...

> +
> +	return load;
> +}
> +
> +static int msm_config_regulator_load(struct sdhci_msm_host *msm_host, struct mmc_host *mmc,
> +				     bool hpm, int max_current, enum msm_reg_type type)

Then this becomes two functions too, each of those can be inlined in the
proper place.

> +{
> +	int ret;
> +	int load = 0;
> +
> +	/*
> +	 * After the initialization process is finished, Once the type of card
> +	 * is determined, only set the corresponding current for SD and eMMC.
> +	 */
> +
> +	if (mmc->card && !(mmc_card_mmc(mmc->card) || mmc_card_sd(mmc->card)))
> +		return 0;

This goes into sdhci_msm_get_regulator_load().

> +
> +	if (hpm)
> +		load = sdhci_msm_get_regulator_load(mmc, max_current, type);
> +
> +	if (type == VMMC_REGULATOR)
> +		ret = regulator_set_load(mmc->supply.vmmc, load);
> +	else
> +		ret = regulator_set_load(mmc->supply.vqmmc, load);
> +	if (ret)
> +		dev_err(mmc_dev(mmc), "%s: set load failed: %d\n",
> +			mmc_hostname(mmc), ret);
> +	return ret;
> +}
> +
> +static int sdhci_msm_set_vmmc(struct sdhci_msm_host *msm_host,
> +			      struct mmc_host *mmc, bool hpm)
>  {
> +	int ret;
> +
>  	if (IS_ERR(mmc->supply.vmmc))
>  		return 0;
>  
> +	ret = msm_config_regulator_load(msm_host, mmc, hpm,
> +					MAX_MMC_SD_VMMC_LOAD_UA, VMMC_REGULATOR);
> +	if (ret)
> +		return ret;
> +
>  	return mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, mmc->ios.vdd);
>  }
>  
> @@ -1435,6 +1513,15 @@ static int msm_toggle_vqmmc(struct sdhci_msm_host *msm_host,
>  				goto out;
>  			}
>  		}
> +
> +		ret = msm_config_regulator_load(msm_host, mmc, level,
> +						MAX_MMC_SD_VQMMC_LOAD_UA, VQMMC_REGULATOR);
> +		if (ret < 0) {
> +			dev_err(mmc_dev(mmc), "%s: vqmmc set regulator load failed: %d\n",
> +				mmc_hostname(mmc), ret);
> +			goto out;
> +		}
> +
>  		ret = regulator_enable(mmc->supply.vqmmc);
>  	} else {
>  		ret = regulator_disable(mmc->supply.vqmmc);
> @@ -1642,7 +1729,8 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>  	}
>  
>  	if (pwr_state) {
> -		ret = sdhci_msm_set_vmmc(mmc);
> +		ret = sdhci_msm_set_vmmc(msm_host, mmc,
> +					 pwr_state & REQ_BUS_ON);
>  		if (!ret)
>  			ret = sdhci_msm_set_vqmmc(msm_host, mmc,
>  					pwr_state & REQ_BUS_ON);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


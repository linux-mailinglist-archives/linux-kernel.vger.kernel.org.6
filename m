Return-Path: <linux-kernel+bounces-312458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805179696E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44EE1C2382B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E060205E0E;
	Tue,  3 Sep 2024 08:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojWCK3ge"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F064200129
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351677; cv=none; b=Gqakfj3HvbbUagoaB+iGsRGf26oghNwkJTrPQ9wm7ltFrInC/utsofQzM4NI8u9OvDg6xw+4nKtZbz0OttMbDFix+aa6AZsEwClpE4vrmcZjKVg8CSo9xvN809uW7jrVaEHzXyRJLlSgUtmdIa7oGomF/9ATCCwwcB7/kW1WLAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351677; c=relaxed/simple;
	bh=t2uElG1UK7zGOXOdANo6HBHL05Iu62CvkB2IzapWh/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blj5X+jLEFgaqbozDHGnR3Bm4+WVTn9efzoAEQ9BZut1cArmU/AiECShlNB1btT52QOqT0udQOyBd8Jn2kcCPjcoBCiO7BTm4dH5SBQxn2AEIkoBCWB5DDnnqlSqwJ/6t9uaEhWEA8brYwRGQ4YyjOsczs1QyalDQ9k9qWXqK7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojWCK3ge; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c251ba0d1cso1866907a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725351673; x=1725956473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pZcio87ennCUdjC0f4MKryrOHwDABuKmwz1MwT09K9M=;
        b=ojWCK3gePPobEUGeYGvo1cn1OwlL4zsmUpYfeOVY6ki5O9f5c2zTXtz3nCI3wnHUQ2
         gG3VKtQ8t8+97vjW8l2NJ8qZlhl7T3x3mrn4v7vHFySvL7vrFoDgsbTSbRMjsIfYRybq
         +OSxjxLZbezkhjZwq7aYtaYA2xdvUBJEE6NLrTAVObtfjeTFe9kLDhiY8XNVcwflPKqk
         R/db1w+8mOqHsy5t+DGf1pxIvGdVVJKrF7Rcxp/6Cn6HteLxRXVc/I4hWBpojNMZ7n0n
         AcJUpbdDgK9/KXNxAVA3jzVKlV+IUDbZn26DxSNHBKcYeHz5lhHfk4SwNL0W/v0ZnGj/
         d3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725351673; x=1725956473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZcio87ennCUdjC0f4MKryrOHwDABuKmwz1MwT09K9M=;
        b=VW6OK9EDYTZQpC3J50pMmi0UJE7ZfwQAXEA/vX+0MaOp/Zzs5WvMQ7DcqihNh1NWGc
         zFjBJbZj32+W/5Id9frsmkP71kSwQ/D2DdEEQP5dNhKjrD7KxbEcT3OhDJly/Z8zWVja
         CoxbMRAE0zMROlhTnD1kPkpqir1rgpZCXSFWG839WFSntUqc36/YzFaxdnCqXV4ZWhz5
         yjLV7b65B39WfbUsuOJhOxHPtTk45nR4h5z5AIH+3enV06ZYyQvPEvpVtsu84cVt3TRN
         X3muRa/PDUC1VTsqghaKDI4daoLW4ZNbHFD4EbcSBj7PlriFU1AYK/NxXhr0WsxFtxAV
         aokg==
X-Forwarded-Encrypted: i=1; AJvYcCUVkK2N9tk0/mNRsz9Qok2A+mmdqMm3r74RdsyPqSk0UN7hvPWEji3Va5tYHcjaH7ca0WcSWC+LbMee/1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2YjFTyMBb2On/NT9TOXjo1V/UZ/nQ771IEGJTU8IFhXpWZWO4
	PrDycFs28k9YNR0ofh7ILs0GtahjxvBGECwqVf5O69cxqRINMBFE3jr4OVaWQQ8=
X-Google-Smtp-Source: AGHT+IFK4ReG5d3sIJBlmn00nlPQVDKF/zmBxySerd96MPqipESzFCODE7t6BJAhXV+TzgvkpJlbLQ==
X-Received: by 2002:a17:907:97d3:b0:a7a:97ca:3056 with SMTP id a640c23a62f3a-a8a1d2c7373mr219981166b.16.1725351672746;
        Tue, 03 Sep 2024 01:21:12 -0700 (PDT)
Received: from linaro.org ([84.232.173.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3d60sm652771466b.123.2024.09.03.01.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 01:21:12 -0700 (PDT)
Date: Tue, 3 Sep 2024 11:21:10 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, bp@alien8.de, tony.luck@intel.com,
	mchehab@kernel.org, rric@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, quic_sibis@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/qcom: Make irq configuration optional
Message-ID: <ZtbG9plGQfUqVvXo@linaro.org>
References: <20240903060138.3191160-1-quic_rjendra@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903060138.3191160-1-quic_rjendra@quicinc.com>

On 24-09-03 11:31:38, Rajendra Nayak wrote:
> On most modern qualcomm SoCs, the configuration necessary to enable the
> Tag/Data RAM realted irqs being propagated to the SoC irq controller is

Nitpick: s/realted/related/

> already done in firmware (in DSF or 'DDR System Firmware')
> 
> On some like the x1e80100, these registers aren't even accesible to the
> kernel causing a crash when edac device is probed.
> 
> Hence, make the irq configuration optional in the driver and mark x1e80100
> as the SoC on which this should be avoided.
> 
> Fixes: af16b00578a7 ("arm64: dts: qcom: Add base X1E80100 dtsi and the QCP dts")

Not sure about this fixes tag though.

> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  drivers/edac/qcom_edac.c           | 8 +++++---
>  drivers/soc/qcom/llcc-qcom.c       | 3 +++
>  include/linux/soc/qcom/llcc-qcom.h | 2 ++
>  3 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/qcom_edac.c b/drivers/edac/qcom_edac.c
> index d3cd4cc54ace..96611ca09ac5 100644
> --- a/drivers/edac/qcom_edac.c
> +++ b/drivers/edac/qcom_edac.c
> @@ -342,9 +342,11 @@ static int qcom_llcc_edac_probe(struct platform_device *pdev)
>  	int ecc_irq;
>  	int rc;
>  
> -	rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> -	if (rc)
> -		return rc;
> +	if (!llcc_driv_data->ecc_irq_configured) {
> +		rc = qcom_llcc_core_setup(llcc_driv_data, llcc_driv_data->bcast_regmap);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	/* Allocate edac control info */
>  	edev_ctl = edac_device_alloc_ctl_info(0, "qcom-llcc", 1, "bank",
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 8fa4ffd3a9b5..b1c0ae9991d6 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -139,6 +139,7 @@ struct qcom_llcc_config {
>  	int size;
>  	bool need_llcc_cfg;
>  	bool no_edac;
> +	bool irq_configured;
>  };
>  
>  struct qcom_sct_config {
> @@ -718,6 +719,7 @@ static const struct qcom_llcc_config x1e80100_cfg[] = {
>  		.need_llcc_cfg	= true,
>  		.reg_offset	= llcc_v2_1_reg_offset,
>  		.edac_reg_offset = &llcc_v2_1_edac_reg_offset,
> +		.irq_configured = true,
>  	},
>  };
>  
> @@ -1345,6 +1347,7 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  	drv_data->cfg = llcc_cfg;
>  	drv_data->cfg_size = sz;
>  	drv_data->edac_reg_offset = cfg->edac_reg_offset;
> +	drv_data->ecc_irq_configured = cfg->irq_configured;
>  	mutex_init(&drv_data->lock);
>  	platform_set_drvdata(pdev, drv_data);
>  
> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
> index 9e9f528b1370..acad1f4cf854 100644
> --- a/include/linux/soc/qcom/llcc-qcom.h
> +++ b/include/linux/soc/qcom/llcc-qcom.h
> @@ -125,6 +125,7 @@ struct llcc_edac_reg_offset {
>   * @num_banks: Number of llcc banks
>   * @bitmap: Bit map to track the active slice ids
>   * @ecc_irq: interrupt for llcc cache error detection and reporting
> + * @ecc_irq_configured: 'True' if firmware has already configured the irq propagation
>   * @version: Indicates the LLCC version
>   */
>  struct llcc_drv_data {
> @@ -139,6 +140,7 @@ struct llcc_drv_data {
>  	u32 num_banks;
>  	unsigned long *bitmap;
>  	int ecc_irq;
> +	bool ecc_irq_configured;
>  	u32 version;
>  };
>  
> -- 
> 2.34.1
> 


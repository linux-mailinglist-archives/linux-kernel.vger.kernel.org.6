Return-Path: <linux-kernel+bounces-236636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0591E535
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A14E283D84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114916DC14;
	Mon,  1 Jul 2024 16:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIBXlwvG"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978016D9BF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719850881; cv=none; b=oXqBBV+YECFR5VokGuDv4c7zu45vXJrcO6zWQAo+IemWwfIpehMvaRdIDnPq1AoZyovkg8ObZGkurM301gx/45bksIGbVBK76w1FxQ1XpJWEOjQjYtiatLFLW/MN/O7G+lKUMLioweCaugLqQHE1ytI+K7iUMWo1RU8u40Za8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719850881; c=relaxed/simple;
	bh=bPWwqei6jWrE5Jr9kgBDF9MkeajeJQ2zwc+WvnfYERE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im468COz6cQAL9wwL6KmGXbbKyaUvt0r3gfhd6a/2EL0xUoqpeC4vCJ0fygmzMEObiDcwBjcDhqSSgeBIxWM+DVw20W1fpwInOKE4bE8W1QuWrrDZ7xPvhCkKXg8eaGZU8gDm3jFOC8tuU27SqxzXLK8IavWflJeMmfNFwSTmi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bIBXlwvG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f9de13d6baso18157195ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719850876; x=1720455676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C4gxJ4vSXPzGYatbBqyhF5IDCVllp/DdXAW8fjEoy3I=;
        b=bIBXlwvGYSB3w3iaqEAsaq0bzIz54NmreQJk0fqlzEZl3FZTYkbkrVk5eC7nPb1wfp
         rdZBRfGYY+eKsjLWQx8sU4CwefThfMl98fruJg/S+tg0u5XS6GR08kGsU/xCR4nIL9t2
         IS2x+XEPgACOFRHU3FdoGbC+xSO2DT/KzF4ZColqTf9/6ceMyxi5qd0YJZBQ/iwKh4sU
         p5/JJYt21uMSh//79X/i+93q21ktmMI3zFO2+P4TTiRRJHmvhTRrWE+V1K6IbMGncWgm
         CpAoa/o0PeiuV0reZqZC+ORTUOFcnIxJ+5ShSBfAGk30fYaXTZhKbczgEUN1EOJVnmOw
         87Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719850876; x=1720455676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4gxJ4vSXPzGYatbBqyhF5IDCVllp/DdXAW8fjEoy3I=;
        b=Y9p/BslNzSAyEeuCu3YSIYebhlOD8BmR8zCbyiqZXaAbQJpoHyyrGRoOPTFqwEQ7IX
         l1SkSvaQVhWlFXw4SjFBjVJO4vyJ8yo0PVd5R/fa7RuIAVPXVjHYb+LPtOOHLMGXsYVC
         l3xNp/rYe5rkkRhY95SefbMspF5TYYHfLIkKgpx3r0So04Kda/LNJpCEG+wJDF7cFUqc
         eRn7NydsuJBfQmVM92KJKm7di8nCTPMVMuHNkCZLNpqjwOcwDAFg2Q7SS5LyRfWPvTLA
         ud1L7qVOoqospEDJJMNhBp5NZ2Vltz3eZfmMlXVqTCz8uEeU7wO+YK6w5PJfJF6z9kKj
         T8pg==
X-Forwarded-Encrypted: i=1; AJvYcCWhD1onVSBL6bn40qv6IL+uuCKuZO8SpyS4o+ITdtbhasDidZ9RxJs/Kk0BCQlMNx0k6/NRt0noPTkQw3ZTxwSngNZXJAmoRdiajFax
X-Gm-Message-State: AOJu0Yzr4To/XOhyjUm2eYD1bDAtO0aP13m+d/yocDSfxsspu4JntCs3
	DUltBszrOM9xYrU3pOl8w1omtQ3Wqwzv2JpqtSEaAqc6knxCDC4VUArjdFHisHGBANMjmnOGFyE
	=
X-Google-Smtp-Source: AGHT+IHAc7i73eCE5OJ85flXtikavJFK+SnqbPI2t4qhNV+2Wl+l1VEvytK3rd5TID2DkSju3Cncbw==
X-Received: by 2002:a17:903:32cc:b0:1fa:1274:946c with SMTP id d9443c01a7336-1fadbc5c1f5mr35130695ad.2.1719850876293;
        Mon, 01 Jul 2024 09:21:16 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d2282sm66725305ad.44.2024.07.01.09.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:21:15 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:51:11 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mhi@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Slark Xiao <slark_xiao@163.com>
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Use unique
 'mhi_pci_dev_info' for product families
Message-ID: <20240701162111.GB133366@thinkpad>
References: <20240626053237.4227-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240626053237.4227-1-manivannan.sadhasivam@linaro.org>

On Wed, Jun 26, 2024 at 11:02:37AM +0530, Manivannan Sadhasivam wrote:
> Currently, a single 'mhi_pci_dev_info' is shared across different product
> families. Even though it makes the device functional, it misleads the users
> by sharing the common product name.
> 
> For instance, below message will be printed for Foxconn SDX62 modem during
> boot:
> 
> "MHI PCI device found: foxconn-sdx65"
> 
> But this is quite misleading to the users since the actual modem plugged in
> could be 'T99W373' which is based on SDX62.
> 
> So fix this issue by using a unique 'mhi_pci_dev_info' for product
> families. This allows us to specify a unique product name for each product
> family. Also, once this name is exposed to client drivers, they may use
> this name to identify the modems and use any modem specific configuration.
> 
> Modems of unknown product families are not impacted by this change.
> 
> CC: Slark Xiao <slark_xiao@163.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Applied to mhi-next!

- Mani

> ---
> 
> Changes in v2:
> 
> * Used 'mhi_foxconn_t99w175_info' for HP variant as well
> 
>  drivers/bus/mhi/host/pci_generic.c | 78 ++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 08844ee79654..35ae7cd0711f 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -419,8 +419,10 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
>  	.event_cfg = mhi_foxconn_sdx55_events,
>  };
>  
> -static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
> -	.name = "foxconn-sdx24",
> +static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> +	.name = "foxconn-sdx55",
> +	.fw = "qcom/sdx55m/sbl1.mbn",
> +	.edl = "qcom/sdx55m/edl.mbn",
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -428,8 +430,8 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
>  	.sideband_wake = false,
>  };
>  
> -static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
> -	.name = "foxconn-sdx55",
> +static const struct mhi_pci_dev_info mhi_foxconn_t99w175_info = {
> +	.name = "foxconn-t99w175",
>  	.fw = "qcom/sdx55m/sbl1.mbn",
>  	.edl = "qcom/sdx55m/edl.mbn",
>  	.config = &modem_foxconn_sdx55_config,
> @@ -439,8 +441,46 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.sideband_wake = false,
>  };
>  
> -static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
> -	.name = "foxconn-sdx65",
> +static const struct mhi_pci_dev_info mhi_foxconn_dw5930e_info = {
> +	.name = "foxconn-dw5930e",
> +	.fw = "qcom/sdx55m/sbl1.mbn",
> +	.edl = "qcom/sdx55m/edl.mbn",
> +	.config = &modem_foxconn_sdx55_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_foxconn_t99w368_info = {
> +	.name = "foxconn-t99w368",
> +	.config = &modem_foxconn_sdx55_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_foxconn_t99w373_info = {
> +	.name = "foxconn-t99w373",
> +	.config = &modem_foxconn_sdx55_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_foxconn_t99w510_info = {
> +	.name = "foxconn-t99w510",
> +	.config = &modem_foxconn_sdx55_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
> +	.name = "foxconn-dw5932e",
>  	.config = &modem_foxconn_sdx55_config,
>  	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
>  	.dma_data_width = 32,
> @@ -646,40 +686,40 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
>  	/* DW5930e (sdx55), With eSIM, It's also T99W175 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b0),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5930e_info },
>  	/* DW5930e (sdx55), Non-eSIM, It's also T99W175 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0b1),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5930e_info },
>  	/* T99W175 (sdx55), Based on Qualcomm new baseline */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0bf),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
>  	/* T99W175 (sdx55) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0c3),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
>  	/* T99W368 (sdx65) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d8),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w368_info },
>  	/* T99W373 (sdx62) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w373_info },
>  	/* T99W510 (sdx24), variant 1 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f0),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w510_info },
>  	/* T99W510 (sdx24), variant 2 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f1),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w510_info },
>  	/* T99W510 (sdx24), variant 3 */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f2),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx24_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w510_info },
>  	/* DW5932e-eSIM (sdx62), With eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f5),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
>  	/* DW5932e (sdx62), Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> @@ -694,7 +734,7 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
>  	/* T99W175 (sdx55), HP variant */
>  	{ PCI_DEVICE(0x03f0, 0x0a6c),
> -		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
>  	{  }
>  };
>  MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


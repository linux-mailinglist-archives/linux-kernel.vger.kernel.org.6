Return-Path: <linux-kernel+bounces-236642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F46A91E545
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F157B26C38
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759A016D9CB;
	Mon,  1 Jul 2024 16:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTL4ZWXz"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7BF16D4F1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 16:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851134; cv=none; b=LWobT4bWK8yZCFiRNEh0L5jbvHK86PNr93D73FXMR/4HgKmM3QmpFmFdNq0d8rDiZekFtYmlF5wpwP192Vq7ETtIX4vJ62u540gljPC+R/BPdHUrpQQBvAdzyI4cqEynPWhSSiBaL2DNTF0yTuAcDZBBnUG//XMv3gz/Q8/Q5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851134; c=relaxed/simple;
	bh=XDu/zULtFMJ3ubnoRSGQdHATwdrFiKjInl6qOvhSlYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USCbFNEJF4An+TeQVjzN25NySRuc4j0fczk3bA5h3hHXmE1m6/JuKcntYX8YHpKN5pLkSc/9Jbu1rnB76D3RxYIE5BAbc15DRdDHIbxzAtAF9UZW+LxvXlyqNOedO1Bl3ttzGu1abNHRqlxh034Lm9kMEd3DwPt9tvX6uMGEKDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTL4ZWXz; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d55ed47cc6so2127666b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 09:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719851131; x=1720455931; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QykNWiH+wRG8kjVO3tnbHTnsuvhtcPFuk3wpjRJiWvI=;
        b=QTL4ZWXzJUwYQ+cTibi9qWfTw1pxEQjWoLAL/SChn6JA0miDhHQihYCeogFjWoTBiG
         LYOyfA5l9xSXOFmvs9iG8b8X6yMtOW3An00mTjoAYzHexze5Z3w113YcbjLhEdhS9fCr
         YKBLPscxw6PaYLQgEPQI3kdtu0WPLBwFada7oSQz01hA7ANn3XlgQ3BTb3vALym0n8Fa
         4DHCili12K+7dSMvhiDeXsRj2S73AxntfScfJ8DkTejIpQCUsLaCCFJZtb8DI90fhaiT
         GV85O052HjQ8b3P/mQ5ySQyRCirFDujGJ8sVVj6jwARRXM9mipU98Ze+hv3tgeJyDCX5
         WPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719851131; x=1720455931;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QykNWiH+wRG8kjVO3tnbHTnsuvhtcPFuk3wpjRJiWvI=;
        b=WJsYY1qyVpjgfw5PQkT4VTvM+HxKxacxV4nsGADPURDgrRmq7g9e9ZBLmpsnsBVsZh
         jskrL7SwS1XCxVVKop9wzZBGqoe+4zf2lhPmV3kySjGiXT3lKI2aRY3oSY8qqwleAN6K
         v03/pshpYOW7l5OqkbyGLGNHF+J5XQHh8iOvXW9zw3cyQnFxb2EXUXnJktwGWT6PLdbB
         9MlWHW/WXMtayEYoUHCIWKBT6WiTe6yoCBS+MLzULbGq85BRtGsAGBEiDyiAniDv6UHt
         cxNCE3enWe6Rr9xyA16d7su12/VIOrFer34B3TlY69PFrxJYesZ3KZ6HPLNu4sXuWHDC
         qQCA==
X-Forwarded-Encrypted: i=1; AJvYcCWryIAbk0uoRAQtHuKHJD50In3NXsf/LjR/a/2AlfRnCJq12FHvVCZQ9QCEHFAUH4Thhi15Vs6Mv9RdwvBwfiYc0G3O9u/pzwR5Lqam
X-Gm-Message-State: AOJu0YyB38juGnix+BMDAAdhrG0/LoknzShvr5F4rqtXwwkWV2XexKvY
	Wa/mC/KxxYeiwWLMEbV6T9vrWCe4VWFhN1GdoVAEuQ1+QtHb38G0CmkXKVaWpw==
X-Google-Smtp-Source: AGHT+IFg2hBkT1DtGiTlxRWpXwmILRxn6yyO/VcGgIs2uJ+We7PMQdTwOt9t0CH4OW/Vn3qq11rVKQ==
X-Received: by 2002:a05:6808:2011:b0:3d5:6332:7077 with SMTP id 5614622812f47-3d6b3c86b03mr9116638b6e.33.1719851130016;
        Mon, 01 Jul 2024 09:25:30 -0700 (PDT)
Received: from thinkpad ([220.158.156.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246bcacsm6722521b3a.55.2024.07.01.09.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 09:25:28 -0700 (PDT)
Date: Mon, 1 Jul 2024 21:55:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, quic_jhugo@quicinc.com,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <20240701162523.GC133366@thinkpad>
References: <20240701021216.17734-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701021216.17734-1-slark_xiao@163.com>

On Mon, Jul 01, 2024 at 10:12:14AM +0800, Slark Xiao wrote:
> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> And also, add firehose support since SDX72.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: (1). Update the edl file path and name (2). Set SDX72 support
> trigger edl mode by default
> v3: Divide into 2 parts for Foxconn sdx72 platform
> ---
>  drivers/bus/mhi/host/pci_generic.c | 43 ++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 35ae7cd0711f..1fb1c2f2fe12 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -399,6 +399,8 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
>  	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>  	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>  	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> +	MHI_CHANNEL_CONFIG_UL_FP(34, "FIREHOSE", 32, 0),
> +	MHI_CHANNEL_CONFIG_DL_FP(35, "FIREHOSE", 32, 0),
>  	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
>  	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
>  };
> @@ -419,6 +421,16 @@ static const struct mhi_controller_config modem_foxconn_sdx55_config = {
>  	.event_cfg = mhi_foxconn_sdx55_events,
>  };
>  
> +static const struct mhi_controller_config modem_foxconn_sdx72_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 20000,
> +	.ready_timeout_ms = 50000,
> +	.num_channels = ARRAY_SIZE(mhi_foxconn_sdx55_channels),
> +	.ch_cfg = mhi_foxconn_sdx55_channels,
> +	.num_events = ARRAY_SIZE(mhi_foxconn_sdx55_events),
> +	.event_cfg = mhi_foxconn_sdx55_events,

Weird. Why this modem is using all SDX55 configs? Reusing is fine, but it is
strange to see only this SDX72 modem using different config than the others
added below.

- Mani

> +};
> +
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx55_info = {
>  	.name = "foxconn-sdx55",
>  	.fw = "qcom/sdx55m/sbl1.mbn",
> @@ -488,6 +500,28 @@ static const struct mhi_pci_dev_info mhi_foxconn_dw5932e_info = {
>  	.sideband_wake = false,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_foxconn_t99w515_info = {
> +	.name = "foxconn-t99w515",
> +	.edl = "fox/sdx72m/edl.mbn",
> +	.edl_trigger = true,
> +	.config = &modem_foxconn_sdx72_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_foxconn_dw5934e_info = {
> +	.name = "foxconn-dw5934e",
> +	.edl = "fox/sdx72m/edl.mbn",
> +	.edl_trigger = true,
> +	.config = &modem_foxconn_sdx72_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = false,
> +};
> +
>  static const struct mhi_channel_config mhi_mv3x_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 64, 0),
>  	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 64, 0),
> @@ -720,6 +754,15 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* DW5932e (sdx62), Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5932e_info },
> +	/* T99W515 (sdx72) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe118),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w515_info },
> +	/* DW5934e(sdx72), With eSIM */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11d),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5934e_info },
> +	/* DW5934e(sdx72), Non-eSIM */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11e),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_dw5934e_info },
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


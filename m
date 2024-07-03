Return-Path: <linux-kernel+bounces-239549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC1926203
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F7CB272DE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C19E17A920;
	Wed,  3 Jul 2024 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxmmgfzQ"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B81E891
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014278; cv=none; b=Muwb2e0f7F0/MBPPgDHtbhd09ldfTW2PAY88rVNbANsDo96SAeDlfpS4ACCg07Ggqdc0MktyIqnk8z+LeydPKvEyKP4KGJTV0ylqp8g54cpTpognyLV51QrRW8nevq0lfKHSXRUsyGc6ouQyZCON2EK9NukU29OO+A8xRj6oHr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014278; c=relaxed/simple;
	bh=nhPgTJmso4P9z5HaQ17nlgFYzce76vz/kE6INpmWF48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNx3olu8KevIc8wmb0KA7G+8TYsIir1sIpSV1fqVbqZUA/8AgIYorB/rUbacHgXAGiQhyEObZoTukuAhIWqfDp/h5Xvft3FRoEw0P/mFQYSOuC6CyBKVB7aZfmm3hZzExH4TaGaXApXjoZKSEWhDPG6mnkYO7GKejuGWwGW2iSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cxmmgfzQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa2782a8ccso28435845ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720014276; x=1720619076; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aw4OBzovSG3PPvJmkq+sEwfmyTaxbxw9mSwITjQ8wFU=;
        b=cxmmgfzQ8WRoMy41GHhftfkROeVG3CwN2BAvJbJDmNn1qgGY1nzpWY5gcRvfnuv3pG
         naX6sF40CHM1gGic3nWO/90pPQzAtc+jwKY5Wd4VTObRQ+Ki73fdOZUOq0kQ2EhUWyCq
         A6801QEg02INOzEcsCNjXC2CaqapWVjehTaRomXudKb/63OCcc/H+DsXasypQlxdAjqx
         H2A0GGNC1AWT0UmpdxnjlT8Lff4XAvsTrsNgYUuRZ+RIYw7cfAvIxcgjCTKfUb2NK3ZA
         /JF30KrKLgFN4kPiIVBPdgp01AYvmICcckJbqlDvACT+Nu9lsjQY9Bq3khPUOEQOQRzZ
         Zb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014276; x=1720619076;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aw4OBzovSG3PPvJmkq+sEwfmyTaxbxw9mSwITjQ8wFU=;
        b=iHfQO8+/JO7n9JIKcBM5x3xv4AWifkUYvH/7YIkwi1nJb+rGhDrClRhbKWb6a8dXge
         8pA4JGr1+xqFYNAw0Npf7kpDID3VcPpn1+um8HV57qOUl1G6RzFWpFSlfRG+SlF+pxB+
         Mh2CuJwqatvfj5GFxo5sOr/VQhJIrNVJ6agddZ1LaJ4e6WmC76vJn+7QtrRzB/0Opmru
         4TLDmK92xNJl975468gaGHA7hKGN0TlGQYJFEFNtQfgsmeKwF0GPO1CjObhwTBNjsYja
         VkTLkOw9/19rS4xvWElWSWBmbtoKXvIkraW5AmEBXTj3WgfaZK/eQ/4GOYUaLxS8yW01
         AnWw==
X-Forwarded-Encrypted: i=1; AJvYcCUa7n83Lrmx/aFq0Bu3Pn5nP6in4gf7MbiJ1ABjKB0cWnsf1YT8ApgpFBsKXwIf48nzg+f8Dl3GiLdPdQJVnAbx6ue6aAnqmzCQ8+Ca
X-Gm-Message-State: AOJu0YyWgx7oBh3DrW4S+/TMIDaqhjVDY7tanPnuIPkMjGkXLgTsMpxj
	57lf6Pzyz+My9LXCWT7ZW+ZwCaNKW1ZHrZo5xJ2SnpltmQonYCwEvHOIdVQvuA==
X-Google-Smtp-Source: AGHT+IHqEnHI7Rj1hL7gUGi81gJe1aYQUJCuyxycj4mUXdiddpUKauXt0eXIlBtc37Zl8NAwCjn/2w==
X-Received: by 2002:a17:90b:1fcf:b0:2c8:b576:2b7e with SMTP id 98e67ed59e1d1-2c93d771fa4mr6663084a91.46.1720014275964;
        Wed, 03 Jul 2024 06:44:35 -0700 (PDT)
Received: from thinkpad ([220.158.156.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce72abdsm10650855a91.32.2024.07.03.06.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:44:35 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:14:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, quic_jhugo@quicinc.com,
	netdev@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <20240703134430.GB4342@thinkpad>
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

Applied to mhi-next with fixup to commit subject and description!

- Mani

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


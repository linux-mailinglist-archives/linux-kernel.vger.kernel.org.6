Return-Path: <linux-kernel+bounces-201790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8C8FC32F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9164B26E2A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7D821C189;
	Wed,  5 Jun 2024 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F4NJbHCB"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC921C178
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566904; cv=none; b=TdZQYEAO5dT9WmTk4LVdvJw+hT840hgXbXlnavgb925TcHK0aa3d24FXTLxzpgYC08dqrMMGzE58yxasSdQ6Z1QtljUg+hlHwVA2afGIH4mXH8nIkIZRxLNFygxJFyG44j1TNWEcJ23fiKEhxzzmwzA2628DxHctTm/G4He32Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566904; c=relaxed/simple;
	bh=pT0vlRe1rncAiEJWLGJWVVrADwh3b6o5yFLYE0LLUGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1LcLrmbYgVOUtTd5TwkluMvw1P3MBAyNz80p+7r5YJ+yiL8QO+208cyfiYDzGZnk8FdVsOyrJgeQeR6DmyLrXOCgKHQ0AP/MEeZdCQ989zCjCksWAccIOS+pwk5uEg6y/i4kSU1SHBMsNfZSNiHghOJGTnMavqk5BgVo/6VjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F4NJbHCB; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f6559668e1so28642525ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717566902; x=1718171702; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBxfUq6WQmeXfNg09rhVdjOvmMp9FrtYAbzQqMG7sgI=;
        b=F4NJbHCBtZGM+0r/gm+OdhaFMx9EL7h0unndxXMoE10oVUsKN3ZsMkZa6xxQ0w1ckQ
         h7k3hPC/Eoldn+EGn0fmS40uFFRB9PAeFaNy4Y92fnUJzgQ6Xh7v1RcavybYgZInpZDc
         GlO49rVK4EXpqq0HOeM5BQvAIV4BZvdD3xXgb0FnuCCChAEJdKOaOizypmPPh06mw6nU
         nVLO+imG0HVsQk1Zao0zW/q3iG6wr0zRZXnfzkgvLnSCPMuT/s/DUKNvUilriYJGw3Ed
         h+LJH9zHn6xVVu2+n1+yiU4sxWOnZIe3kaiDIs9wxlcFYlDPavq4a7TqTbp6fclei2Ek
         hsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717566902; x=1718171702;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBxfUq6WQmeXfNg09rhVdjOvmMp9FrtYAbzQqMG7sgI=;
        b=QzXDbACY01QoUdCrJdLq+Sl9GLwXZb1z/sUYfrxa4F/9sCsMMf/9SJk5NNhaHjxeaa
         9ObCbCFFBYoUW6T2dIefFhlAnyAA6yXpq8o/AwN9pAAWmASRTR0avcDt5vSXHPYorhMl
         5NjXcY6u1lGfY6eNWcEKAVsDoIeiFw91Tl0S/v7W4DNyR4CfKwAHGAugejGpCcPuB40y
         eq5Flxtgpp7UL8AqogC5/+gB86Yrd5hQzYbSDAXXWjXPuPelRG7FHAjxKh6cP758IeQs
         MOn1Gzhg1COAr4MNU3hKqJsSZrQFlm8uopJw8l9aE9KTtd5wE3sb9sMPGsJBHplNi4hn
         RKjw==
X-Forwarded-Encrypted: i=1; AJvYcCXBlXdONaZmHXOTw49akT0Bp/Hfu5YTv2M4+fysrTK1QxLN6eMGXPziY1YZunMvav40S2Uh+stZUj2cw+aVXh3MkYVRrIMQIBjeC3Pr
X-Gm-Message-State: AOJu0YzRVFfvYT8oMT8ywoaxlw8W3Eget+VrmGtHLnHNdyOCHw3OxduN
	WKjP/DcnxdvgpLNP5lelY/MZsaLy39WlMN2ck0EXeH1NvE83XKaMfeSEiG2nwg==
X-Google-Smtp-Source: AGHT+IHScUtk14Z1Yr2g0W5IQ/gHXNWp09PycuN+tvMzWowATHARRRe4GJC2SYoiN+/nkoD9jS6KRg==
X-Received: by 2002:a17:903:a0c:b0:1f6:87c:6f with SMTP id d9443c01a7336-1f6a5a84956mr15315165ad.62.1717566902118;
        Tue, 04 Jun 2024 22:55:02 -0700 (PDT)
Received: from thinkpad ([120.60.137.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632339066sm96044795ad.22.2024.06.04.22.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 22:55:01 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:24:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Slark Xiao <slark_xiao@163.com>
Cc: loic.poulain@linaro.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: mhi: host: Add Foxconn SDX72 related support
Message-ID: <20240605055458.GD2417@thinkpad>
References: <20240520070633.308913-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240520070633.308913-1-slark_xiao@163.com>

On Mon, May 20, 2024 at 03:06:33PM +0800, Slark Xiao wrote:
> Align with Qcom SDX72, add ready timeout item for Foxconn SDX72.
> And also, add firehose support since SDX72.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v2: (1). Update the edl file path and name (2). Set SDX72 support
> trigger edl mode by default
> ---
>  drivers/bus/mhi/host/pci_generic.c | 32 ++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 08844ee79654..0b483c7c76a1 100644
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
>  static const struct mhi_pci_dev_info mhi_foxconn_sdx24_info = {
>  	.name = "foxconn-sdx24",
>  	.config = &modem_foxconn_sdx55_config,
> @@ -448,6 +460,17 @@ static const struct mhi_pci_dev_info mhi_foxconn_sdx65_info = {
>  	.sideband_wake = false,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_foxconn_sdx72_info = {
> +	.name = "foxconn-sdx72",
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
> @@ -680,6 +703,15 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* DW5932e (sdx62), Non-eSIM */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0f9),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> +	/* T99W515 (sdx72) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe118),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx72_info },
> +	/* DW5934e(sdx72), With eSIM */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11d),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx72_info },
> +	/* DW5934e(sdx72), Non-eSIM */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe11e),
> +		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx72_info },
>  	/* MV31-W (Cinterion) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்


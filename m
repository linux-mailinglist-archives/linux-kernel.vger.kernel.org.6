Return-Path: <linux-kernel+bounces-440831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1029EC4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9089E188746C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37FB1C548D;
	Wed, 11 Dec 2024 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C6lNLLYu"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0F1C07E4
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733899328; cv=none; b=GOn4e0lmTkt+NdwNsrO+UKRo7VTlHpI7XEej7U6HbVqfFAxqaROJY/EYS+OzgALTWJU8Gy3/s9KeTwS0siuSXp0stxgXV3IQeRj29bSlCSCRjb8bvio6LcmH8jEY/Wuul/dD3Kocr2bDhWItuOWXGzgLnT8u/EZ5R4ksl4ARMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733899328; c=relaxed/simple;
	bh=fFveP77bj++EtRJvy3YCVpCGVLLJJ20B4rPICaCeOGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/NG9Smavsf4711lzNKAdBOc5cpokSj8MbBXFnJi3jJj1TWyyhGnfjt6XpL69oEHNWVHSVtJ/SCxmXciGRlRgXkGlRam83nGJWAF/FhdpZHMYYt2P1bsyPMmV6KOtiTyxejyj4z6kMI2y0DLTHzRZeJyw7BGJUlVQbIQmmbZmoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C6lNLLYu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2156e078563so47997135ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 22:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733899325; x=1734504125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SH3wSIT4qOX2QKfL+TrwrsCejAN9yTnzSj4WW/yKpJg=;
        b=C6lNLLYuAi3iOkTWhHraGef9VKzoFa2fR73ZBzgK2WoDEYteR2UNmNFvBAdr0KjT96
         CJP1UcaTA1cT6eqPBdY8+mZbTMX01MGuYbfjbYCPM9ezwTLtg1btDEbnrbC14bM1zvz+
         YumdvNHhM0zhY2Qlo60fizSY7rl/xXowIwff9aF6dvwsxH6pcMICig24vNeo3Q2q+N89
         u9XI5Z9KZ2BtdgSZPUeKcltSutLBubeTxnKYVBn1H7V5U5yCou+/9XJoOoXIYYRq7wA/
         aQEVc2c6v3XiKvxYeflBAjubag1r/e9NXl/ps+W9XVKkHkhgaG18LIAkmCz0v4AuBTmB
         akLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733899325; x=1734504125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SH3wSIT4qOX2QKfL+TrwrsCejAN9yTnzSj4WW/yKpJg=;
        b=iyHBVuwwNUS4UTOnhs02X7OBKQ+k4cURd40KqllE5KKvmqLYtYrSLCx7TLDPNx3uh6
         Fwff8A1C1xmkmAojzLiaOOZzL9qPmT8+OkjN5452e8c9eXCgM3OXD0wu3RTYx0USJh9b
         IJQK1l3TWLjYZ8Y2xQhFuZvG/EEGZ0G+t4sj+/kks8UmXsA6JVDbMdlUk+YegSSlIZxj
         i73eGO2fT8buhvU7AgXb5QTNDQIHMbq4zj0K6VyjmW52myI7YSJInjOFxqiAhJCCYbu0
         dYB512CSy6VSlZqZ0kXsjfSP+KYw0L6MOz+QyYe3/HXssrj3EGcdhU95j4XFf0RzEtxB
         M+bg==
X-Forwarded-Encrypted: i=1; AJvYcCVwxn4ffrKoLlXr+b2w/ZuFsQVkGwuKtVZGZFP9PCuuwxE/nhT97LQhQ1by+ksmwoh+JsytnTIWQocDubE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7WIJgrXqkBZTDEcdzSoeUP7DiL81Cd+cyZSGojs2oTWWXFuO
	fubtMlFp2H+5MWvemrdLhQL4LUVHGxpWqaNhQqkA5EaN/ykKIHUvsi4Dk97MLg==
X-Gm-Gg: ASbGncuNVhbHpwQkUTXaY4vwPO9MEdHJS42g9IonaJe6DFYQiFYwyAm6GvJ0SlMSIs7
	zOSLE+/Lhb421PdbTPFc2EbNE5XdkFQoLs93WmG6NspqygWSI0Lrj+dt7rGhI7XBsuFL2fxevgv
	sdfdW0xo15IJvdeJmL4tVH6HJCpAIGxwYBS0xujeXloYtz7He2iOqgkxiibxhioGrkUrrOV5N6H
	IITopPoIf1/Ms1UtpgEQg7A7uxnBz33FM2/UInm5Ey+62JnTH71UuZj84I5/LY=
X-Google-Smtp-Source: AGHT+IH9UlXRucX87GfmhnSoQKYdfmBeTDDM2mlEgeF1Kko5nxbNbCHi9DSPm8qDL6kLUq2gp73FUQ==
X-Received: by 2002:a17:903:32c3:b0:216:48f4:4f1a with SMTP id d9443c01a7336-2177851dc1fmr29082555ad.16.1733899324633;
        Tue, 10 Dec 2024 22:42:04 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21618d9beafsm82495805ad.6.2024.12.10.22.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 22:42:04 -0800 (PST)
Date: Wed, 11 Dec 2024 12:11:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc: quic_krichai@quicinc.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] bus: mhi: host: pci_generic: Add support for QDU100
 device
Message-ID: <20241211064155.gqlbi3leoaaz3w6b@thinkpad>
References: <20241209-qdu100_us-v4-1-f9010b2a09a2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241209-qdu100_us-v4-1-f9010b2a09a2@quicinc.com>

On Mon, Dec 09, 2024 at 11:09:50AM +0530, Vivek Pernamitta wrote:
> Add MHI controller configuration for QDU100 device.
> 
> The Qualcomm X100 5G RAN Accelerator card is designed to enhance Open vRAN
> servers by offloading CPUs from intensive 5G baseband functions.
> 
> Link: https://docs.qualcomm.com/bundle/publicresource/87-79371-1_REV_A_Qualcomm_X100_5G_RAN_Accelerator_Card_Product_Brief.pdf
> 
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> ---
> changes from V3:
> - Removed IP_SW1 and IP_SW2 support currently, will add once
>   SW_IP1/2 channels support are added to mhi-net driver.
> - Removed qdu100 edl images, as EDL images are not needed.
> - Added space inbetween kernel_ulong_t and mhi_qcom_qdu100_info.
> - QDU100 XBL FW images were pushed to linux-firmware git repo
>   https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/qcom/qdu100
> 
> changes from V2:
> - updated commit text.
> 
> changes from V1:
> - Changing naming convention from modem_qcom_qdu100*
>   to mhi_qcom_qdu100*.
> - Updated commit text.
> - Fixed and corrected by passing mhi_pci_dev_info struct
>   instead of mhi_controller_config.
> ---
> 
> ---
>  drivers/bus/mhi/host/pci_generic.c | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 07645ce2119a71c9277356e962252b840379cd81..dee9fa9e7ae441fbc9a86e53694568c0ba192002 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -245,6 +245,58 @@ struct mhi_pci_dev_info {
>  		.channel = ch_num,		\
>  	}
>  
> +static const struct mhi_channel_config mhi_qcom_qdu100_channels[] = {
> +	MHI_CHANNEL_CONFIG_UL(0, "LOOPBACK", 32, 2),
> +	MHI_CHANNEL_CONFIG_DL(1, "LOOPBACK", 32, 2),
> +	MHI_CHANNEL_CONFIG_UL_SBL(2, "SAHARA", 128, 1),
> +	MHI_CHANNEL_CONFIG_DL_SBL(3, "SAHARA", 128, 1),
> +	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 64, 3),
> +	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 64, 3),
> +	MHI_CHANNEL_CONFIG_UL(9, "QDSS", 64, 3),
> +	MHI_CHANNEL_CONFIG_UL(14, "NMEA", 32, 4),
> +	MHI_CHANNEL_CONFIG_DL(15, "NMEA", 32, 4),
> +	MHI_CHANNEL_CONFIG_UL(16, "CSM_CTRL", 32, 4),
> +	MHI_CHANNEL_CONFIG_DL(17, "CSM_CTRL", 32, 4),
> +	MHI_CHANNEL_CONFIG_UL(40, "MHI_PHC", 32, 4),
> +	MHI_CHANNEL_CONFIG_DL(41, "MHI_PHC", 32, 4),
> +	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 256, 5),
> +	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 256, 5),
> +};
> +
> +static struct mhi_event_config mhi_qcom_qdu100_events[] = {
> +	/* first ring is control+data ring */
> +	MHI_EVENT_CONFIG_CTRL(0, 64),
> +	/* SAHARA dedicated event ring */
> +	MHI_EVENT_CONFIG_SW_DATA(1, 256),
> +	/* Software channels dedicated event ring */
> +	MHI_EVENT_CONFIG_SW_DATA(2, 64),
> +	MHI_EVENT_CONFIG_SW_DATA(3, 256),
> +	MHI_EVENT_CONFIG_SW_DATA(4, 256),
> +	/* Software IP channels dedicated event ring */
> +	MHI_EVENT_CONFIG_SW_DATA(5, 512),
> +	MHI_EVENT_CONFIG_SW_DATA(6, 512),
> +	MHI_EVENT_CONFIG_SW_DATA(7, 512),
> +};
> +
> +static const struct mhi_controller_config mhi_qcom_qdu100_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 120000,
> +	.num_channels = ARRAY_SIZE(mhi_qcom_qdu100_channels),
> +	.ch_cfg = mhi_qcom_qdu100_channels,
> +	.num_events = ARRAY_SIZE(mhi_qcom_qdu100_events),
> +	.event_cfg = mhi_qcom_qdu100_events,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_qcom_qdu100_info = {
> +	.name = "qcom-qdu100",
> +	.fw = "qcom/qdu100/xbl_s.melf",

Can you first push this fw to linux-firmware? I haven't enforced this
requirement earlier, but that was my mistake.

> +	.edl_trigger = true,
> +	.config = &mhi_qcom_qdu100_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.sideband_wake = false,
> +};
> +
>  static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>  	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> @@ -822,6 +874,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* NETPRISMA FCUN69 (SDX6X) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_NETPRISMA, 0x1001),
>  		.driver_data = (kernel_ulong_t) &mhi_netprisma_fcun69_info },
> +	/* QDU100, x100-DU */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0601),
> +		.driver_data = (kernel_ulong_t) &mhi_qcom_qdu100_info },

Did you read the comment on top of mhi_pci_id_table[]?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


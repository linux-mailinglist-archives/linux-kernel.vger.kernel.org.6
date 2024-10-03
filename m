Return-Path: <linux-kernel+bounces-348583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16498E95B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 929B51C21F9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1A42110E;
	Thu,  3 Oct 2024 05:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cgo0caG9"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA53AC2B
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933180; cv=none; b=nw5+2Gx/FvbI407GQDwPbwc9Zoup3yLixgs1Er6MYDiJQ3UTnRYXMc16adW5gPacUT67RHFmI/FEqYWoKNwkbWwQkcMhlS4FWnq8qBtr0qT2/k+PbLj2jFBnRYh11T5mlJmWe8DQdBZ3bb71Qhndt/zIQcGsKjEf49KnwVEqFfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933180; c=relaxed/simple;
	bh=sszam0YJeq9hUJhsVD5JKzOxSjLqkB4+aZQNF4yGZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+nlrkf3uy18/RwlALiM/kB5a/7o0Oiqnz3qGUhIUvoWXJQ6IFzna5ZNTDwgDJYD6cXShGlOKKlvUosqNGf2fRD7OMzpNVduE2tgVy23oHaoBXCG/fNOqwgxRxNbu13Ap/1ccR494ccotOfV+ejhmVUwgzabG55GYdYihqHimko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cgo0caG9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20bcae5e482so4327785ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727933177; x=1728537977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oR5QvxRn7I4F+X0gW6UsQkOXeRecGwMqfBoqqmAEfrA=;
        b=Cgo0caG9ZjDYK2iEoxEsPqyj+eLv0pJC+Vi3A59SfHQD/CstoRRa+KYEbXU1A0elA0
         XRqbhZGvK+hAfyeP6b+TLW65jbDIxwGZqy6Ed3dnZNGBO3UmMePk90cFWSshDb390jlN
         x3Y7S6BKbthdEtyLMGLmSBQBgr915vU75DBoU+xW7+UWL5qZ2iQL85wcrn8yjrHMm1Ls
         yZwjDxGnvqP9oK7yZ8bmd5k84/HJ+hf/4E7BMM0NxYdYjuHSqLMforBnFfUMgHZ4tUMt
         ApuGYlOxe5HtGaKPNKV2gjHO322bDI39XGWa+c0h0k0C+BHSIuJ6uoezEDXwpgjOQ+Si
         oKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727933177; x=1728537977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oR5QvxRn7I4F+X0gW6UsQkOXeRecGwMqfBoqqmAEfrA=;
        b=nAgZlH4feIcxlLQCMQENJNxNSLuwDfLMRzgUVxTiUJ6s4dd70aLe8MYRRMsdZdsUsa
         ezgWL92CDav6QwPAPg2c328T0AgVVrcvMC8ADYpb/xaoac6CIpLvHIYBDbmoM5sFp4j1
         4Xu7XUx2a7sDuq7LkXkFRqLhFuEQUlKW4wo39s5I6OJow1KKsINuiEZxCuCZLkGACCLa
         WB99+YldooyRcH7LpzRS9ShbLhKWov4QBEX9rRfarLSI4g9XTyX+xgC+Z/62YA0Untcc
         bmZJzJFN3Nv4V5vSYoULOkv9jjxCY4Kf6iqqHD4YduycnXjZmTc2b19X12QtVJnJZ0MT
         f8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCU2/CRdeWqhpJZgyZ4n77AjcFJqMmU4iz1hlqE1QmQnD6K6vHcynqKV64y2nrnegtoqH+ZTsehK0S4Yujw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwjmyYooi1Pms7Ci0kjcAM5QrOBkLu7pMUp0BlXmYdhLwxvfNo
	HXSadjmmDUR3sMXxbQWMNsCQDUzt00nLTeTZbn/ImUFpQwdnOWLm7AGxLCIj+g==
X-Google-Smtp-Source: AGHT+IHEB1f8pGBuMcmPniimBQ09DleIhVDkzWJXmfPcSVMS6VW9PbLiP5upj1emW3YT7FrlKFEBug==
X-Received: by 2002:a17:903:2451:b0:20b:983c:f0a0 with SMTP id d9443c01a7336-20bc59fc2f7mr71658925ad.31.1727933177496;
        Wed, 02 Oct 2024 22:26:17 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead255asm2102975ad.15.2024.10.02.22.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:26:17 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:56:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc: mhi@lists.linux.dev, quic_qianyu@quicinc.com, quic_vbadigan@quicinc.com,
	quic_krichai@quicinc.com, quic_skananth@quicinc.com,
	mrana@quicinc.com, Slark Xiao <slark_xiao@163.com>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Mank Wang <mank.wang@netprisma.us>,
	"open list:MHI BUS" <linux-arm-msm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Add support for QDU100
 device
Message-ID: <20241003052612.o5lbgw274yopmpx6@thinkpad>
References: <20241001113738.152467-1-quic_vpernami@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001113738.152467-1-quic_vpernami@quicinc.com>

On Tue, Oct 01, 2024 at 05:07:35PM +0530, Vivek Pernamitta wrote:
> Add MHI controller configuration for QDU100 device.
> 
> This Qualcomm QDU100 device is inline accelerator card
> which is an extension to QRU100 5G RAN platform.
> which is designed to simplify 5G deployments by offering
> a turnkey solution for ease of deployment with O-RAN
> fronthaul and 5G NR layer 1 High (L1 High) processing,
> and to accelerate operator and infrastructure vendor
> adoption of virtualized RAN platforms.
> 
> https://docs.qualcomm.com/bundle/publicresource/87-79371-1_REV_A_Qualcomm_X100_5G_RAN_Accelerator_Card_Product_Brief.pdf
> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 49 ++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 9938bb034c1c..1153697fa858 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -245,6 +245,52 @@ struct mhi_pci_dev_info {
>  		.channel = ch_num,		\
>  	}
>  
> +static const struct mhi_channel_config modem_qcom_qdu100_mhi_channels[] = {
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
> +	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
> +	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
> +	MHI_CHANNEL_CONFIG_UL(50, "IP_SW2", 256, 7),
> +	MHI_CHANNEL_CONFIG_DL(51, "IP_SW2", 256, 7),

I believe you are going to add support for these channels in mhi_net driver. If
so, it would be good to mention that in the commit message as these channels
won't be useable for now.

> +};
> +
> +static struct mhi_event_config modem_qcom_qdu100_mhi_events[] = {
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
> +static const struct mhi_controller_config modem_qcom_qdu100_mhi_config = {
> +	.max_channels = 128,
> +	.timeout_ms = 120000,
> +	.num_channels = ARRAY_SIZE(modem_qcom_qdu100_mhi_channels),
> +	.ch_cfg = modem_qcom_qdu100_mhi_channels,
> +	.num_events = ARRAY_SIZE(modem_qcom_qdu100_mhi_events),
> +	.event_cfg = modem_qcom_qdu100_mhi_events,
> +};
> +

Where is the 'mhi_pci_dev_info' struct?

>  static const struct mhi_channel_config modem_qcom_v1_mhi_channels[] = {
>  	MHI_CHANNEL_CONFIG_UL(4, "DIAG", 16, 1),
>  	MHI_CHANNEL_CONFIG_DL(5, "DIAG", 16, 1),
> @@ -822,6 +868,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* NETPRISMA FCUN69 (SDX6X) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_NETPRISMA, 0x1001),
>  		.driver_data = (kernel_ulong_t) &mhi_netprisma_fcun69_info },
> +	/* QDU100, x100-DU */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0601),
> +		.driver_data = (kernel_ulong_t)&modem_qcom_qdu100_mhi_config },

Why are you passing 'mhi_controller_config' instead of 'mhi_pci_dev_info'?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


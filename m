Return-Path: <linux-kernel+bounces-353454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2A7992E08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD6F1F242BC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7285E1D47B3;
	Mon,  7 Oct 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FILTEH8L"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EFC1D417C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309556; cv=none; b=JmqEHcohhYMLNLvYsxgISo7zVl2WSrjxG4xoSIL0l7zP0SLnVapESkY7zlbj/zs7w7iRQIWRMEs0K5A+Mw1F4D+SjynqLu/UGihbf3ERBTWfkmY9L0rquu0iBRbbo7EJgLgCVX3J1rOxRTeoQ2i+MY8sV6+AfVUHvL6nBRC1IIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309556; c=relaxed/simple;
	bh=n4oG5LTAxLA3y2xDimyibVs2v/zqS3TxXWLrkbSEufY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmcEgXwp4bppuOw53jNSMD+WDOdVLIxKaxiiZek9ItSojC0HC6Wh3aAzltQs9z2vUsOE1GjIjr2OOXr1Y6hTh4edUK8eAZlgNhYwS5WrM2XppAXRdZXSqKGbAYoZHd9iLo21VoYyyve+xpfEqIZzdloHOa2ABCG9dOwT7Q1I/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FILTEH8L; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso48009381fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728309552; x=1728914352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1uBnw43piXXI7n4DTLKHOMAEK5UpUIcRTL2fHxKrp9w=;
        b=FILTEH8LPbb4STNWT7CFXKXtPIRbS+Gn2hjkTcNRgw1QN8PZnXwbbynpchmzob3tbI
         9n0DNJvRhkQshocgo+WkJxzqgAcwR8shQcXydsjVGxhUWHdK5SS5eqQf5ebKImpCExln
         tNRNup+ug8UJUxaV3YE4OEgNvJumCdVvOuo7OPc18rcSkjSFO2IiKQD5ngBLcUA7TsMz
         bXYdZPCejyT6IpR9ijnI+exv7B7jfxZTid/8slDBHmsru+yv1ulyBywuJq/u1DrTTgRp
         tQL8cWi/JCc9KmU3RK9EAc/XeTN/NRsUfOSrMbjB5mnmBQmBk/KDMx4MBR9GG6AJRG+E
         EhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309552; x=1728914352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uBnw43piXXI7n4DTLKHOMAEK5UpUIcRTL2fHxKrp9w=;
        b=RJpJs9SiA4VPc7LIrZmOWg0wFULOr1EEvnUyDvq3xQJ3VzpysJmpKovpi+Mz9fOA99
         0tseWBNCKfj3jizLwIoSzJnGbjc5yl++aSQr9rV57HHt/Lh/bme3DD6YfU0ma4noSbt3
         h6XS7PYwMU3wdx8US4nuM73ALTGsWqLvkz64DUcxlgc8N5Ys4rGCYXLNxmu1y2A5vFxE
         o2H4Of+ealrzEh6sM9JprIHrFBwpAj+5ng+xLG6ibHqGtQ7oyDQVTWlKqRA0JZVlosOL
         8ylQyON4TpfO+fUWp6J+8jyIF+KWqvyMXrKb32WgTffdhbjsjw5a+xfnIpTRJC6XZ5Cx
         rDFA==
X-Forwarded-Encrypted: i=1; AJvYcCXLNR+t38CDYLLxi9YDdepcD+sC6P+t939gVQrNP1Yf19uqEb4K+u/ijRf5VCYXzbiaFwmA7ff2+Bq2xYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY2d8h3OsDanvZT6IpfLSV14BFwavGr+LAHnQmAjoxwy3Jmpci
	4xAoRHbBm4roxgOow3fgsMRgzY+LJ8hLlGSUXyX8oAuCdheafpqx7kinP+5j0PMFcXhiC6XdDDv
	Tfa2lVzPI
X-Google-Smtp-Source: AGHT+IFYsE5/TCR+Rx1O7DTrCu76UULZ5EhjsnIt4QmOaZn1KvQoOZfaRPVgfvAAqetrCt3ywPY3Rg==
X-Received: by 2002:a2e:bc21:0:b0:2fa:d534:3ee7 with SMTP id 38308e7fff4ca-2faf3d724dfmr57178661fa.35.1728309552125;
        Mon, 07 Oct 2024 06:59:12 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2faf9adcdd3sm7887201fa.69.2024.10.07.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 06:59:10 -0700 (PDT)
Date: Mon, 7 Oct 2024 16:59:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vivek Pernamitta <quic_vpernami@quicinc.com>
Cc: mhi@lists.linux.dev, quic_qianyu@quicinc.com, 
	manivannan.sadhasivam@linaro.org, quic_vbadigan@quicinc.com, quic_krichai@quicinc.com, 
	quic_skananth@quicinc.com, quic_mrana@quicinc.com, Slark Xiao <slark_xiao@163.com>, 
	Mank Wang <mank.wang@netprisma.us>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Fabio Porcedda <fabio.porcedda@gmail.com>, "open list:MHI BUS" <linux-arm-msm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] bus: mhi: host: pci_generic: Add support for QDU100
 device
Message-ID: <kukqsg4dpvfa2i53fssqsdihud3qy3w6le5srf2a7yiiwsbmob@se44vnmgbbye>
References: <20241007091622.3497928-1-quic_vpernami@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007091622.3497928-1-quic_vpernami@quicinc.com>

On Mon, Oct 07, 2024 at 02:46:20PM GMT, Vivek Pernamitta wrote:
> Add MHI controller configuration for QDU100 device
> 
> The Qualcomm X100 5G RAN Accelerator Card is designed to
> enhance Open vRAN servers by offloading CPUs from intensive
> 5G baseband functions.
> 
> Currently IP_SW1/2 channel support is not present in
> mhi_net driver, will be supporting them in future.

When? Can we get corresponding support as a part of the same patch
series?

> 
> Link: https://docs.qualcomm.com/bundle/publicresource/87-79371-1_REV_A_Qualcomm_X100_5G_RAN_Accelerator_Card_Product_Brief.pdf
> 

No empty lines between tags.

> Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
> 
> ---
> changs from V2:
> - updated commit text.
> 
> changes from V1:
> - Changing naming convention from modem_qcom_qdu100*
>   to mhi_qcom_qdu100*.
> - Updated commit text.
> - Fixed and corrected by passing mhi_pci_dev_info struct
>   instead of mhi_controller_config.
> ---
>  drivers/bus/mhi/host/pci_generic.c | 60 ++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 9938bb034c1c..b9b7dd8d9411 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -245,6 +245,63 @@ struct mhi_pci_dev_info {
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
> +	MHI_CHANNEL_CONFIG_UL(48, "IP_SW1", 256, 6),
> +	MHI_CHANNEL_CONFIG_DL(49, "IP_SW1", 256, 6),
> +	MHI_CHANNEL_CONFIG_UL(50, "IP_SW2", 256, 7),
> +	MHI_CHANNEL_CONFIG_DL(51, "IP_SW2", 256, 7),
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
> +	.name = "qcom-lassen",
> +	.fw = "qcom/lassen/xbl_s.melf",
> +	.edl = "qcom/lassen/edl.mbn",
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
> @@ -822,6 +879,9 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* NETPRISMA FCUN69 (SDX6X) */
>  	{ PCI_DEVICE(PCI_VENDOR_ID_NETPRISMA, 0x1001),
>  		.driver_data = (kernel_ulong_t) &mhi_netprisma_fcun69_info },
> +	/* QDU100, x100-DU */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0601),
> +		.driver_data = (kernel_ulong_t)&mhi_qcom_qdu100_info },
>  	{  }
>  };
>  MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


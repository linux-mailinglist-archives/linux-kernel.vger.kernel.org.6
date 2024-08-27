Return-Path: <linux-kernel+bounces-302865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B396046D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965DF28235E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE119885D;
	Tue, 27 Aug 2024 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LP35UPxJ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC715B541
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724747439; cv=none; b=YYVDdVwl+dMUCqY+pk+BGPv+la9yWMmwJBIr76c4osxi+tw6kTXOT9Xhy3P8GwPQYGBCBNv8lK+v4kvLuXDNW5hFEZegx/TOM9pLpWgtCXcAMTvVGOdlWkLZdC2GIrGh3uUPe9x/EHIUtBFyU2jAkTwI3BfVRCrbpeiOiBkAVqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724747439; c=relaxed/simple;
	bh=cvZH7fUYaeL9wrWckMOUxPYywvVUJJ7wNoFeMasAFh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQTCtqlKT1Cw8npMs/r5ShPxwg6kKk9fu4f3N6Fo8p61gKcSqyFY4eEwC3yEbDYYHDVesAOWXfACEY8+EB7aIZurHIFRkJPmFyhGNe95bVf1zHMYRwo4zdrQbG7PwTBPTDmZ8tWof6LlZflcEC8ohBWlKaC9a6TCPh549kz0G5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LP35UPxJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201fba05363so41728735ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724747437; x=1725352237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4PG1MKybPmHFMME9V8dY/+bhiqIyDMUmzSsge0xRow8=;
        b=LP35UPxJv4rW/rUKGq8i9eSrncCMGUrPMnYRXC9hxS3/RES3YtV8CLglw7Gu2L7MJR
         A6HsySUrhV14sXRGcycYZ+CGulmKWDnfQPD3MnI4YLcjxfV9zGZ2gVKpwkg81G3wKdjo
         QaomjzMXg0quQtSLpAIcwtoY3zKEJzMCkt1gIp/hue7IOi2E4cW+gAFo7LlrQhMFk9CN
         Nh+QNspArm7XtKtKF7FqHmtn1GT0uXO4FFrbKIIgJdEO1jCvYd6RkezvXuIoNNJxc+3d
         r7QB/tBmiXKKSxDX3bUI4kXp6TBJjtiAl72o12BwSIpiTnW48Oni9GMNEnnNwyO7f3PH
         T/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724747437; x=1725352237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PG1MKybPmHFMME9V8dY/+bhiqIyDMUmzSsge0xRow8=;
        b=NLDINL2XEgxYF5hEtUMXIaAxnRTpIZ/0e1l1L3P9ixt+/SQ9AvQjZmlgfE2Xj867pG
         KQfmqpFKChHOYzwmryQYdazD2XddjJFmTwJ20qOh720bCLGtu2erwvWpWy9jyBYwLcaC
         lmQA36z/ekdwhouWBMbmfkIQ4+lX1GaD2KCXngTI9DMqQJZezQI3Uuqw0c1SmrAtUrVk
         UxIFGJMWbGUKQSk7lhsW7SyTIQ/QFD8yTpGAbAk1Dt5yDMkMFAaujt0WMoDOfsfm0rRn
         h8UGgr0ShLgXVTEUUywDnLbpiOyb+dcDU1GqgV9ebaHmKTvnVyHjjlONxY0OVk8DI21Q
         H7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG/X1wjZlsy2GBE9Devzdmphqa+apYcbtIsh0DqLxB01bOCIaVQpWT7EqA2+DXJSueFV0lVyflUGjS2t4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVmNWqjjfEkU65F1VLHn3J5OD/cqBVEZhk2yC0brXmBoJu+hGf
	vVNq2ihCI24Mlku9pkgyBoj3ljfAhLr80OEEdWKWkrIb0jRdIYOGctxrMuh6tg==
X-Google-Smtp-Source: AGHT+IHduWJQyUiCIAY3p1Zf9ALxilUWiklFzc/QeC53bqPhevbARPCSsJCvuo+QiSMorgPzFKWzHg==
X-Received: by 2002:a17:903:11c3:b0:1fd:67c2:f975 with SMTP id d9443c01a7336-204df46c2bamr23997865ad.29.1724747437246;
        Tue, 27 Aug 2024 01:30:37 -0700 (PDT)
Received: from thinkpad ([117.213.96.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-203855df8d0sm78923245ad.130.2024.08.27.01.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 01:30:36 -0700 (PDT)
Date: Tue, 27 Aug 2024 14:00:31 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: Mank Wang <mank.wang@netprisma.us>
Cc: "duke_xinanwen@163.com" <duke_xinanwen@163.com>,
	"loic.poulain@linaro.org" <loic.poulain@linaro.org>,
	"quic_qianyu@quicinc.com" <quic_qianyu@quicinc.com>,
	"mhi@lists.linux.dev" <mhi@lists.linux.dev>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] bus: mhi: host: pci_generic: Add support for
 Netprisma LCUR57 and FCUN69
Message-ID: <20240827083031.pmo4627wizsnp2pf@thinkpad>
References: <PH7PR22MB30386647BE2D813B502226CF81942@PH7PR22MB3038.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR22MB30386647BE2D813B502226CF81942@PH7PR22MB3038.namprd22.prod.outlook.com>

On Tue, Aug 27, 2024 at 01:58:33AM +0000, Mank Wang wrote:
> Add Netprisma LCUR57 and FCUN69 hardware revision:
> 
> LCUR57:
> 02:00.0 Unassigned class [ff00]: Device 203e:1000
> 	Subsystem: Device 203e:1000
> 
> FCUN69:
> 02:00.0 Unassigned class [ff00]: Device 203e:1001
> 	Subsystem: Device 203e:1001
> 
> Both of these modules create IP interfaces through MBIM.
> And these modules can be checked for successful recognition through the
> following command:
> $ mmcli -L
>     /org/freedesktop/ModemManager1/Modem/0 [NetPrisma] LCUR57-WWD
> 
> $ mmcli -L
>     /org/freedesktop/ModemManager1/Modem/0 [NetPrisma] FCUN69-WWD
> 
> Signed-off-by: Mank Wang <mank.wang@netprisma.us>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> 
> ---
> V1 -> V2:
> 1.Add comments to provide testing methods and IP interface creation methods.
> 2.Remove unnecessary comments.
> 
> Signed-off-by: Mank Wang <mank.wang@netprisma.us>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 14a11880bcea..2c44aab8695a 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -26,6 +26,7 @@
>  /* PCI VID definitions */
>  #define PCI_VENDOR_ID_THALES	0x1269
>  #define PCI_VENDOR_ID_QUECTEL	0x1eac
> +#define PCI_VENDOR_ID_NETPRISMA	0x203e
>  
>  #define MHI_EDL_DB			91
>  #define MHI_EDL_COOKIE			0xEDEDEDED
> @@ -680,6 +681,26 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
>  	.mru_default = 32768,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_netprisma_lcur57_info = {
> +	.name = "netprisma-lcur57",
> +	.edl = "qcom/prog_firehose_sdx24.mbn",
> +	.config = &modem_quectel_em1xx_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = true,
> +};
> +
> +static const struct mhi_pci_dev_info mhi_netprisma_fcun69_info = {
> +	.name = "netprisma-fcun69",
> +	.edl = "qcom/prog_firehose_sdx6x.elf",
> +	.config = &modem_quectel_em1xx_config,
> +	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
> +	.dma_data_width = 32,
> +	.mru_default = 32768,
> +	.sideband_wake = true,
> +};
> +
>  /* Keep the list sorted based on the PID. New VID should be added as the last entry */
>  static const struct pci_device_id mhi_pci_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0304),
> @@ -778,6 +799,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* T99W175 (sdx55), HP variant */
>  	{ PCI_DEVICE(0x03f0, 0x0a6c),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_t99w175_info },
> +	/* NETPRISMA LCUR57 (SDX24) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NETPRISMA, 0x1000),
> +		.driver_data = (kernel_ulong_t) &mhi_netprisma_lcur57_info },
> +	/* NETPRISMA FCUN69 (SDX6X) */
> +	{ PCI_DEVICE(PCI_VENDOR_ID_NETPRISMA, 0x1001),
> +		.driver_data = (kernel_ulong_t) &mhi_netprisma_fcun69_info },
>  	{  }
>  };
>  MODULE_DEVICE_TABLE(pci, mhi_pci_id_table);
> -- 
> 2.34.1
> 



-- 
மணிவண்ணன் சதாசிவம்


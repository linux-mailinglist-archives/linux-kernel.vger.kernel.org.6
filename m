Return-Path: <linux-kernel+bounces-201863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991A68FC45A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5633128838C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CA18FDD2;
	Wed,  5 Jun 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4+oO2Us"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C88E13B286
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571816; cv=none; b=mxXXc5qGPJIioPrbtQG4qVl48qoDPlLfUqPnsAXpeZV+m+jpEgxKng5Ir6fjg7SDUew0jqyjnTEYVNYqXvybudLldvGO0ruxwWR0Y4PJZ+NVqu5NztcvYiMONSnEEwnKD4JeoQhEIRxheyF08G3ZHb64MN1Mp6Zztcf4QBGfccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571816; c=relaxed/simple;
	bh=LA7fFwtJTUSwn2dkZM8K68mfKZKK2dTySLuN6I/FshY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKQuO//O2tmThfWJ3NfUDRZdacGH7z+S/YtbYrZ/IqKc2KWZIeGHZzZQbq+uDxGpsQEoc475Ejwxg8MqWiol4E/zbvtEPE+z0yiKwA9iooLRLghKdE/nNM6e8xVZjjH8OIIkTSaoCJagfyL6wy3CngBagj5XI/bv78jaz+IoSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4+oO2Us; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70264bcb631so2747659b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717571813; x=1718176613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4vfzJjKeGHGpUgDcno/RVJLd5UySDu362eov994HPLk=;
        b=T4+oO2UsUftB22d5j3IQn51wJNCsFO69plIPDn5z0HHJJakX3PVPR8inbnzkJBL+Dw
         86bZWIIWxet2Br8stEDW7w69EYdAudke4F2Jl+pVBLQ2NMTrJ+pRuiB6yy4Xlu2xIbfb
         TLNRkkad+zkh/ANwFl1m21WPb1/C0p/Z5WJllfCHh63P/mLrRrv+j52FDBwxT2C2sPEn
         gHuMvK1+r+fU8NM8H4LeWIGE58yhNPHVo4ska24HzPWGpuQ52AwwEuXz1UtGi2Deoj0S
         FkFkwrWA62Vna4dOfwAIQ55Lk8zTHJ9tT+gyI+RD0CYGGNUywTLq3qm0FcH5x8jG2Jg3
         qW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571813; x=1718176613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vfzJjKeGHGpUgDcno/RVJLd5UySDu362eov994HPLk=;
        b=MDLVTL3nVBhvZu8IsGl+p3VH+POgNqRNzDHsFw7vUksQ4dQC9qsFgrNOUcJ1ifExto
         rHiJnqG+o1k3sEvgWJRTlgD7fKynPbEqgTk7D9WTH/dl5ttr17NIjVe7IZb0pzTBzo1v
         k0ndKHfwrYDpZowO+4B0oIX12hBfXUfphVCGSzDjFYsz80qWOhgkLtYRRAUwTh8yvaw7
         uKJLLVWSR1jQB0uPgaxfa6fxPSNrhsls6jUjF5GNE0m/rj+mCZQGRVQR0c9GBbK6GkwX
         s9x5lr1d4iIxvlWgKuwoQz94iPmfAYwrk8XE8nLK42dMwxhCLlzal2fsJbYaAwgvybFv
         9wLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoa1A7cfSxXQQQKM/Y9tn9p+6BnMX5e2c6eSJ9tdE6cvi73fweA8RbRqRnOgOucWxQLyj6FyhPc400BfmtXY4q+hmoljAMape5sxVQ
X-Gm-Message-State: AOJu0YyPwUfNb/pJz9FJBhz1fiFa7tqT+ny7BEK1kszmXx5rlyK03VTv
	12VF15loutwV2aIFTGj/fwnwh4aSgZ79FEowtFTw5d5ERcdMW486cotRYIL+pA==
X-Google-Smtp-Source: AGHT+IHgMOU9oCWpJwVlXnUxs6AfoCJ5z42b5im/p4607Z9+iJGsyRo1YafudQB8bl9exf3bkKTmeg==
X-Received: by 2002:a05:6a20:12cf:b0:1b2:b4d6:2729 with SMTP id adf61e73a8af0-1b2b70026famr1926898637.30.1717571813204;
        Wed, 05 Jun 2024 00:16:53 -0700 (PDT)
Received: from thinkpad ([120.60.137.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ff9f3sm97438795ad.247.2024.06.05.00.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:16:52 -0700 (PDT)
Date: Wed, 5 Jun 2024 12:46:48 +0530
From: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>
To: mank <mank@netprisma.us>
Cc: "duke_xinanwen@163.com" <duke_xinanwen@163.com>,
	"loic.poulain@linaro.org" <loic.poulain@linaro.org>,
	"quic_qianyu@quicinc.com" <quic_qianyu@quicinc.com>,
	"mhi@lists.linux.dev" <mhi@lists.linux.dev>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] bus: mhi: host: pci_generic: Add support for
 Netprisma LCUR57 and FCUN69
Message-ID: <20240605071648.GA5085@thinkpad>
References: <LV3PR22MB5104E2E4AD0A22D1B8FD2AAAB0F92@LV3PR22MB5104.namprd22.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3PR22MB5104E2E4AD0A22D1B8FD2AAAB0F92@LV3PR22MB5104.namprd22.prod.outlook.com>

On Wed, Jun 05, 2024 at 07:01:17AM +0000, mank wrote:
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
> ---
> V1 -> V2:
> 1.Change 0x203E to 0x203e
> 2.Remove redundant code and use existing config:modem_quectel_em1xx_config
> 
> Signed-off-by: Mank Wang <mank@netprisma.us>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 29 +++++++++++++++++++++++++++++

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 08844ee79654..21c1d750274c 100644
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
> @@ -606,6 +607,28 @@ static const struct mhi_pci_dev_info mhi_telit_fn990_info = {
>  	.mru_default = 32768,
>  };
>  
> +static const struct mhi_pci_dev_info mhi_netprisma_lcur57_info = {
> +	.name = "netprisma-lcur57",
> +	.edl = "qcom/prog_firehose_sdx24.mbn",
> +	/* LCUR57 uses the same controller configuration as quectel_em1xx */
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
> +	/* FCUN69 uses the same controller configuration as quectel_em1xx */
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
> @@ -695,6 +718,12 @@ static const struct pci_device_id mhi_pci_id_table[] = {
>  	/* T99W175 (sdx55), HP variant */
>  	{ PCI_DEVICE(0x03f0, 0x0a6c),
>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx55_info },
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


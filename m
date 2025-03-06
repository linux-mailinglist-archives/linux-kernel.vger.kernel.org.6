Return-Path: <linux-kernel+bounces-548188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E978AA54158
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254F23A9FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374D01993B2;
	Thu,  6 Mar 2025 03:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrjwQWM0"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C71991B2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232709; cv=none; b=C0jZM7bQSTKdDJ6o0Rh+nBf70kytaQakD+sKVz5wvN7Nmozk4YRRhi2FKkIsZkXbYzlzoEP6zPCobLxqaB7ydCH/d3UCNnZevfXN6r5ARhVMZaLsZShbYVzSHFrhR1i+rVBMfw/qUHB16aWO3/heTZTljaX5cCTOrrQJgpm5d4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232709; c=relaxed/simple;
	bh=s8ihgNf+/lTzOH0KKqwJ/Y6ngXzFB3uo/jmic8WGk6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvkejXTf4yd0F9HcNi5wb6Se6mYbc/c90NBHMs+8tlHxAkwRu83fjqrSOcj2NWS/aSC1disMKm/t/XwkckdYO5tkT63GnUKTX5Me3pK4Wg48QvsuhWLFXf3OU+GvDAq0iC0XVVIc+LT68OknWPhfu9o8YKlmBpFiHJp/JNL49Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MrjwQWM0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2234e4b079cso2288275ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 19:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741232706; x=1741837506; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RR/3Sh2yGD8FYmZXDeG1gkp5RyyAVqAwHMabcS8vVWU=;
        b=MrjwQWM0VX3Jkcruam4NVPBR16WsJoRYMa0CjdvL4UYun9QCTk2m4aqQPSRkj1+n2P
         /knF4wCdb4mOK83r9Fap7jwKcjg+5V/qC0UZsSotPj78tcLSPRQ/e2SxzWdzqnz3YciC
         lJhC/6+cEErpTC5tI3Cyx4X77zvJn16VB1dxDvnDECDLneeKc9gWwiP8KXNbkEzx07HO
         i1BZ151IiHp15Kgmig0jY3ms1nXCJuYhfClKv3X5e7tnetOGJgviimem3UWco5JNIq/q
         xRow5enu1vkgQRboZC2/8yhRipERSf+iy3fLz1FA2U6Guyd0tRFSO4GSeBxjzdOSHs/e
         7aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741232706; x=1741837506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RR/3Sh2yGD8FYmZXDeG1gkp5RyyAVqAwHMabcS8vVWU=;
        b=kDj6vxga241aaKpErhpUffpyPcKWM1Vt4w1jVDHFuPMU2tjK+Bc5SbZnd/4K2EqFbD
         WNR35rWyhmnFUDB7AwYVICfRuHgUI1T/mDDl41dhU854YgFlqoG9UX7lGYp7df7en2sC
         4v+EjNPSE9XvvBsa03i0yPnbu9zSvoLNxnwnICxOeZmnQYFGW4BoHHrsdk+IvSSfWYyx
         9BRazSIpCy4itxVpVpAoouk6qBz6tEiKZQHCEysHJrNYFiRiMxUAD+eLNVME0ksHoHLN
         XpUImZ6o4FZksh9COeJX/NPWj5+MueQskC55Uq11rAVGxwzgzZDuswpKLr0QMSvExpoi
         5aAw==
X-Forwarded-Encrypted: i=1; AJvYcCVTKjwOoH1tNhud6A4/FfHdvTTAYfH9jG1++ulyRh3k14+vd8GHvqGq7m729S/z+DFTk7S+l0BYKVOb9xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ7oVApfac1Ro74SWmTHfNJZLNeo4t5lK7SJHJoBIEDKYONhIn
	x6pblkZTNUVs/rUocNzbv/QLq9eb/nmRdUEjgGMz8MCwsGobUMsTp0RQxL6ZsQ==
X-Gm-Gg: ASbGncvwWWUnmeCM4MnKTXfOSN9ZQKo+9NO+LFiBm04daqoxpdMG14+SP9P8UYv/z1K
	E7ZKek6XMP4JiuVDGX6fsI8Bp0/Mjx6tsqRQoakp2EDcBejFJ895nf3fvd6WDarT2pJjcZ60OHY
	4HquJdQ90PO1J3/cUexG35UjiS0WXDsLMrqeEMgzWDaKlpqCIgCxBoVsVLbSNl3jUCuzBFe8Wyd
	AbWQt13tCW921jE5wmkAtYquGWKAP/AsPncbEHMdW0rqgLGL5+PYpWgQeyq/n02Efr8zlMtfm9Y
	YMM66VOImrdz/Hdc5nErtm1xi0eS/gayij0Pz5e4gBzjYTLZr7AlqPI=
X-Google-Smtp-Source: AGHT+IGKJttGqJWItASqbCKDIt2tzUlENZ2HliebcQ18gZfjLIkLG4+OaRrcXjLUk9Kxrd+AX1YZIg==
X-Received: by 2002:a05:6a00:338d:b0:736:755b:8311 with SMTP id d2e1a72fcca58-73682c89e14mr8508343b3a.16.1741232706353;
        Wed, 05 Mar 2025 19:45:06 -0800 (PST)
Received: from thinkpad ([120.56.193.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698206c6dsm243250b3a.9.2025.03.05.19.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:45:05 -0800 (PST)
Date: Thu, 6 Mar 2025 09:14:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	quic_mrana@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Message-ID: <20250306034459.uc4qlnsnxijotplo@thinkpad>
References: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
 <20250225-preset_v6-v7-3-a593f3ef3951@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250225-preset_v6-v7-3-a593f3ef3951@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 05:15:06PM +0530, Krishna Chaitanya Chundru wrote:
> Currently even if the number of lanes hardware supports is equal to
> the number lanes provided in the devicetree, the driver is trying to
> configure again the maximum number of lanes which is not needed.
> 
> Update number of lanes only when it is not equal to hardware capability.
> 

'Update max link width only...'

> And also if the num-lanes property is not present in the devicetree
> update the num_lanes with the maximum hardware supports.

'...update 'pci->num_lanes' with the hardware supported maximum link width using
the newly introduced dw_pcie_link_get_max_link_width() API.'

> 
> Introduce dw_pcie_link_get_max_link_width() to get the maximum lane
> width the hardware supports.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
>  drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..dd56cc02f4ef 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -504,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	if (pci->num_lanes < 1)
> +		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 145e7f579072..9fc5916867b6 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -737,12 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
>  
>  }
>  
> +int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
> +{
> +	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
> +
> +	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
> +}
> +
>  static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  {
> +	int max_lanes = dw_pcie_link_get_max_link_width(pci);
>  	u32 lnkcap, lwsc, plc;
>  	u8 cap;
>  
> -	if (!num_lanes)
> +	if (max_lanes == num_lanes)

This gives the assumption that the link width in PCIE_PORT_LINK_CONTROL and
PCIE_LINK_WIDTH_SPEED_CONTROL registers are same as MLW. Is it really true as
per the DWC spec?

- Mani

-- 
மணிவண்ணன் சதாசிவம்


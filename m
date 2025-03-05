Return-Path: <linux-kernel+bounces-547449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E053A50937
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643B1175996
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE1252910;
	Wed,  5 Mar 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZKKp6wS1"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4962528E0
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198494; cv=none; b=KKKEsNDDnvlhOIjS3EHb5bitSC2RPiBekxLzZUpCTriHJD4wNKNjn7grczJusMYe44SpbBLkyxSUdu9F8oEp6P67ys77XPU0Fmqplbb1PMUGaaKvp673hwMOuovd+ovop2fqk1WcvuaO/oPaa7UvZklL47F1QAmG6kq7YEAZoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198494; c=relaxed/simple;
	bh=ul8sDPmVIBMYaIuM/ep9OTRkTM4OCXHhN3IN3R3wVwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8bFbAKjAxVf0nWPhIMyd4ZEHzdoc/N03lee90ursJq1zsVtbAQHb6bcExAJQidimkjBC1LNQRfAFhhYw8yRZPWWcDP85lYcq2UuYkUirvvA6H+/fnVn0s8/m990NpvaV7okVAvadHoxi0acNnsepRCXrGkzEFlg7OVdEgi4Xqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZKKp6wS1; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223785beedfso96293595ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741198492; x=1741803292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i6MBTqEjrPhqT7NQz2LhiFoqvbZCZMQa9JAre3ZYDSc=;
        b=ZKKp6wS1SmA4eo2U9SRsvICEpxKlOKANEYSKAJ/uJ+Rw0wIMlClLE5qZndxcDAeXtx
         Cm1qLzQAWmEAzikKsuCj+/ThlKbp74aPO2tQI9rw1hDGbaWRNqAoJa/NARr/4E8GGn6l
         gjebwrTT7VhwH7XVUDvN7YrG1aVAKRXg2mmciswPvt8jDyQnvsXfLHXQ0JvSfgglv7JY
         JMMatPazbtWAQa/QEA3yarZeRA56DCnEO5eMjg58/6/SjEaOXtPg0q7mKmJigNtLvshf
         rWOICPJIgdAIgEu8sxpGTkEgxBHe+bNmof7zVs0hTpvooopKeAAHXUmX5XAIfZ7Fsg/Y
         Kl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741198492; x=1741803292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6MBTqEjrPhqT7NQz2LhiFoqvbZCZMQa9JAre3ZYDSc=;
        b=LeI8nieiNJOLLMjj9jjFVvJORoysJgDyC/CaFFoTM2LxXfxYGm+Y2AKh8PlHoaUUR8
         EqLDjmAwmQlhT8t5fqGh/+MoHlg7X3HalDuO5n+yoisrYKJte7a6Qm5HJ7rjbMXwGUZf
         ydEumrz/0E/V1zFoWweX0Qdq8gEIHAnOwi0yrzkUOrVBqf7wgq2IBnp3QyInICCOFgF1
         w8RupLBuJdgH/m99TxV356WlSkwvHT5EmWGtBVW1Pu51KiPtf6EgBsoHMojMJ9HjCUSD
         sSyTAAcqnXMtM6y/dlQAm4Rm5X/z7AMygi+4OsLr0PmQLr3aKC2eLMen/qV3Oj9AqjL8
         PwMg==
X-Forwarded-Encrypted: i=1; AJvYcCXAA9AqEMmjHgOrEQLG5zAGiKj1249lqOPyUvRZVz5NI8rmMyUspPwECyZslzHztAreLBc6fr72LtgQ2Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpiMelNpPc+Biyp6v0SWmhynBw67i/7WLNsSR/L3ltUV7igoC
	b76/3epyOvj+H/biTxzYbKoL25p+wzf8LGzoYWF3dJLSoKO/2H8Fen5L+lPfTw==
X-Gm-Gg: ASbGncvmHAO+2gx4FjTvn1+dJjJGMCcxcJUvg7uUK7/Nb/hcsvXIFaU4Mv8DncJSxoB
	JnSIeFZGTYd1aZV1eBBw8uOTCzzpmvMddMkutCf25A9PFSiPwceK2+1cNOjDTkO5VIipXHU7rB0
	mLuCjLLitlqqatrCClWWyF+B1Q5d/QljkIKKe45JqSJ2Kg9PfkMtqcaTiM06Gq8OJAf1bAd/v9F
	2E5vq1XeLYlscG0X/kuOUiMxoh4z8s0fFUoZ19XWAinvTJK3RIM/gqxVjGMcWsPw5LMhhWsehHm
	CzsQPpxn/dKZZBA5WlfcUXlR+AVLfxr3K9W+5Dh5861H/V/VDPuXuu7P
X-Google-Smtp-Source: AGHT+IEzcJn1LsfQ6+F4shfozJf1rlCdLMZmUl3EDE20/7Zu4E6fNsmxwyidQhHgvhoE32oNOSexAA==
X-Received: by 2002:a17:902:ce82:b0:220:c34c:5760 with SMTP id d9443c01a7336-223f1d35ba2mr54246475ad.51.1741198491709;
        Wed, 05 Mar 2025 10:14:51 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501fb004sm116523775ad.64.2025.03.05.10.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:14:51 -0800 (PST)
Date: Wed, 5 Mar 2025 23:44:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com,
	mmareddy@quicinc.com
Subject: Re: [PATCH v4 2/4] PCI: dwc: Add ECAM support with iATU configuration
Message-ID: <20250305181444.3zteaxr6r4pq3lz4@thinkpad>
References: <20250207-ecam_v4-v4-0-94b5d5ec5017@oss.qualcomm.com>
 <20250207-ecam_v4-v4-2-94b5d5ec5017@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207-ecam_v4-v4-2-94b5d5ec5017@oss.qualcomm.com>

On Fri, Feb 07, 2025 at 04:58:57AM +0530, Krishna Chaitanya Chundru wrote:
> The current implementation requires iATU for every configuration
> space access which increases latency & cpu utilization.
> 
> Designware databook 5.20a, section 3.10.10.3 says about CFG Shift Feature,
> which shifts/maps the BDF (bits [31:16] of the third header DWORD, which
> would be matched against the Base and Limit addresses) of the incoming
> CfgRd0/CfgWr0 down to bits[27:12]of the translated address.
> 
> Configuring iATU in config shift feature enables ECAM feature to access the
> config space, which avoids iATU configuration for every config access.
> 
> Add "ctrl2" into struct dw_pcie_ob_atu_cfg  to enable config shift feature.
> 
> As DBI comes under config space, this avoids remapping of DBI space
> separately. Instead, it uses the mapped config space address returned from
> ECAM initialization. Change the order of dw_pcie_get_resources() execution
> to achieve this.
> 
> Enable the ECAM feature if the config space size is equal to size required
> to represent number of buses in the bus range property, add a function
> which checks this. The DWC glue drivers uses this function and decide to
> enable ECAM mode or not.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/Kconfig                |   1 +
>  drivers/pci/controller/dwc/pcie-designware-host.c | 133 +++++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c      |   2 +-
>  drivers/pci/controller/dwc/pcie-designware.h      |  11 ++
>  4 files changed, 132 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b6d6778b0698..73c3aed6b60a 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -9,6 +9,7 @@ config PCIE_DW
>  config PCIE_DW_HOST
>  	bool
>  	select PCIE_DW
> +	select PCI_HOST_COMMON
>  
>  config PCIE_DW_EP
>  	bool
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index ffaded8f2df7..826ff9338646 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,66 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_config_ecam_iatu(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct dw_pcie_ob_atu_cfg atu = {0};
> +	resource_size_t bus_range_max;
> +	struct resource_entry *bus;
> +	int ret;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +
> +	/*
> +	 * Root bus under the host bridge doesn't require any iATU configuration
> +	 * as DBI space will represent Root bus configuration space.

'as DBI region will be used to access root bus config space'

> +	 * Immediate bus under Root Bus, needs type 0 iATU configuration and
> +	 * remaining buses need type 1 iATU configuration.
> +	 */
> +	atu.index = 0;
> +	atu.type = PCIE_ATU_TYPE_CFG0;
> +	atu.cpu_addr = pp->cfg0_base + SZ_1M;
> +	atu.size = SZ_1M;
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +	ret = dw_pcie_prog_outbound_atu(pci, &atu);
> +	if (ret)
> +		return ret;
> +
> +	bus_range_max = resource_size(bus->res);
> +
> +	if (bus_range_max < 2)
> +		return 0;
> +
> +	/* Configure remaining buses in type 1 iATU configuration */
> +	atu.index = 1;
> +	atu.type = PCIE_ATU_TYPE_CFG1;
> +	atu.cpu_addr = pp->cfg0_base + SZ_2M;
> +	atu.size = (SZ_1M * (bus_range_max - 2));
> +	atu.ctrl2 = PCIE_ATU_CFG_SHIFT_MODE_ENABLE;
> +
> +	return dw_pcie_prog_outbound_atu(pci, &atu);
> +}
> +
> +static int dw_pcie_create_ecam_window(struct dw_pcie_rp *pp, struct resource *res)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct resource_entry *bus;
> +
> +	bus = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	pp->cfg = pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops);
> +	if (IS_ERR(pp->cfg))
> +		return PTR_ERR(pp->cfg);
> +
> +	pci->dbi_base = pp->cfg->win;
> +	pci->dbi_phys_addr = res->start;
> +
> +	return 0;
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -431,10 +491,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	raw_spin_lock_init(&pp->lock);
>  
> -	ret = dw_pcie_get_resources(pci);
> -	if (ret)
> -		return ret;
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
>  	if (!res) {
>  		dev_err(dev, "Missing \"config\" reg space\n");
> @@ -444,9 +500,28 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	pp->cfg0_size = resource_size(res);
>  	pp->cfg0_base = res->start;
>  
> -	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> -	if (IS_ERR(pp->va_cfg0_base))
> -		return PTR_ERR(pp->va_cfg0_base);
> +	if (pp->ecam_mode) {
> +		ret = dw_pcie_create_ecam_window(pp, res);
> +		if (ret)
> +			return ret;
> +
> +		bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +		pp->bridge->sysdata = pp->cfg;
> +		pp->cfg->priv = pp;
> +	} else {
> +		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
> +		if (IS_ERR(pp->va_cfg0_base))
> +			return PTR_ERR(pp->va_cfg0_base);
> +
> +		/* Set default bus ops */
> +		bridge->ops = &dw_pcie_ops;
> +		bridge->child_ops = &dw_child_pcie_ops;
> +		bridge->sysdata = pp;
> +	}

So you dereference 'bridge' that is allocated only below? It doesn't matter
whether the upcoming commits allocate it earlier or not. This commit alone is
going to cause NULL ptr dereference.

> +
> +	ret = dw_pcie_get_resources(pci);
> +	if (ret)
> +		return ret;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, 0);
>  	if (!bridge)
> @@ -462,14 +537,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>  
> -	/* Set default bus ops */
> -	bridge->ops = &dw_pcie_ops;
> -	bridge->child_ops = &dw_child_pcie_ops;
> -
>  	if (pp->ops->init) {
>  		ret = pp->ops->init(pp);
>  		if (ret)
> -			return ret;
> +			goto err_free_ecam;
>  	}
>  
>  	if (pci_msi_enabled()) {
> @@ -504,6 +575,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> +	if (pp->ecam_mode) {
> +		ret = dw_pcie_config_ecam_iatu(pp);
> +		if (ret) {
> +			dev_err(dev, "Failed to confuure iATU\n");

'configure'

> +			goto err_free_msi;
> +		}
> +	}
> +
>  	/*
>  	 * Allocate the resource for MSG TLP before programming the iATU
>  	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
> @@ -539,8 +618,6 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		/* Ignore errors, the link may come up later */
>  		dw_pcie_wait_for_link(pci);
>  
> -	bridge->sysdata = pp;
> -
>  	ret = pci_host_probe(bridge);
>  	if (ret)
>  		goto err_stop_link;
> @@ -564,6 +641,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (pp->ops->deinit)
>  		pp->ops->deinit(pp);
>  
> +err_free_ecam:
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_init);
> @@ -584,6 +665,9 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	if (pp->ops->deinit)
>  		pp->ops->deinit(pp);
> +
> +	if (pp->cfg)
> +		pci_ecam_free(pp->cfg);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
>  
> @@ -999,3 +1083,24 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> +
> +bool dw_pcie_ecam_supported(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct platform_device *pdev = to_platform_device(pci->dev);
> +	struct resource *config_res, *bus_range;
> +	u64 bus_config_space_count;
> +
> +	bus_range = resource_list_first_type(&pp->bridge->windows, IORESOURCE_BUS)->res;
> +	if (!bus_range)
> +		return false;
> +
> +	config_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
> +	if (!config_res)
> +		return false;
> +
> +	bus_config_space_count = resource_size(config_res) >> PCIE_ECAM_BUS_SHIFT;

s/bus_config_space_count/nr_buses

- Mani

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-kernel+bounces-348600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02AA98E987
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 07:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB9A1F24647
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83C94F1F2;
	Thu,  3 Oct 2024 05:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8Wr0n3n"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C54224D1
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727934676; cv=none; b=kYxuL69SrrxRF+bffJvEP4UHXYa5aQaRjndd/H2bZ9+wcQ2h59GtFv1jLKyB8+Ym5y9luUQvC6HUf4KTcq51uhEsIfk74Ebe0g/6UUuFlX645ZSZLYgCRtoc+dA6Wqw24IdyQyUzwsgw3tSwNnebQK6GEgwsoclducWfoNhElRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727934676; c=relaxed/simple;
	bh=VFmboQ0WFDlCkx5RluuKwpmBTCKDTSlVFQNe17ed6T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNs4VJqNV97X+d6Y5C8rW2pP8wRsE+lOVGuXrk3wsRq4NyGsbeQCR//qwP8CZsUOCyiTyC+iOQgHa0I6LXQyTkh9erqq39Nf891Xw3MPOW9jBb26s1+r83qs8TflYn8zk86KOZZKU9HFEak0aeJhFNdi5d0kWDp2b93TnrPYCZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H8Wr0n3n; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20b95359440so4158335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 22:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727934674; x=1728539474; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x+I/rurAYPkV9R/iih9/yeq0qeeCIBS1txmeO8x6Thc=;
        b=H8Wr0n3n0eqbienDjsLEJzdGLSHjK19vzW0aYMEnEg4uAsahRBMkbef+m+rAHtCqBM
         ZIjigmvAh5nD5aq2izYasH110RdisuOJ7NnraaYR9Yso8Bevzm8NZasp8mTf5ZPPPmsN
         eNDcdN/gBQKBUC0C5R+cNY+X3p+PJhRnQyMHEy+utlURoLIpZsuV7ThhX6461RSiWc92
         GpkJ43UenBjOPQ5DjHx0Dy+60M1FwG8VO1tHpKmrqHVVOpX401TktTtpKtKyQo8w9Cm8
         ElZO/oI/H025SYyDRcWXLVCjqxQVsJi3+z6EtVv6xWfP/PdIgFG1YGxPv3zF6yqin3RY
         AJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727934674; x=1728539474;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+I/rurAYPkV9R/iih9/yeq0qeeCIBS1txmeO8x6Thc=;
        b=FlIZE1JZZ1SonGY/sdDcrWKWt1iZHnSiHJ1k2+3kI9MF7HA1znJqNXEDUz4wVHxLXY
         cOjaK2Ip/gxuQJpv/8D9DZNIrRNVdU17L28AqTsKZpyE+4e6GHwFI08gEYPMrPHfvcrc
         LpAC0FcwLB8ZVplolWuc7ip+Vgpg+bRMkRTo3loYjCZfXDuFnZLU0DAbAQvKjecd8Uom
         /aVKqgAuRrlvVkH9X1ZgyPM5JhJ0isJXMs+7t/Zwd9gErMJTY5N/xBItR4p8l5w3lJgm
         jnfD7D8nquQLjQphHy+MeB2lOsbPUqGnt0ToaJ3CsZgnQepyhNMN2mPlEQPM6rcbk5RY
         +O0w==
X-Forwarded-Encrypted: i=1; AJvYcCXko5O7eJgFuhf1SppVOalyIFQu5XtQ7yXBWeUq/G8Z3yxKaIk4Dw7H6DltitJj3NpOlO8yk4vtKMYuj7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVOeYr080lA4plPga1JtWmS8tn/OzWnCLUcDJTCeDa5e82ory
	UK73ByPN0tATPhIb/dhdjDZ/Pjw2bDOfsBTv9DwfarMexmxrogCz6QZA4STbEg==
X-Google-Smtp-Source: AGHT+IH4jjkOJP1RtIXH+LBCTfHZBvB58vRfsRO3uSDukfy6Z2x05FLvSSpdy6l8f7b6/7D4/s/J2A==
X-Received: by 2002:a17:90b:1bc4:b0:2e0:a77e:8305 with SMTP id 98e67ed59e1d1-2e18496a8c7mr6423901a91.39.1727934673666;
        Wed, 02 Oct 2024 22:51:13 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1bfb2f2dfsm579483a91.31.2024.10.02.22.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:51:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:21:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 2/3] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Message-ID: <20241003055106.sm4x23sg4hh67els@thinkpad>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
 <20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-pci_fixup_addr-v3-2-80ee70352fc7@nxp.com>

On Mon, Sep 30, 2024 at 02:44:54PM -0400, Frank Li wrote:
> parent_bus_addr in struct of_range can indicate address information just
> ahead of PCIe controller. Most system's bus fabric use 1:1 map between
> input and output address. but some hardware like i.MX8QXP doesn't use 1:1
> map. See below diagram:
> 
>             ┌─────────┐                    ┌────────────┐
>  ┌─────┐    │         │ IA: 0x8ff0_0000    │            │
>  │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
>  └─────┘    │   │     │ IA: 0x8ff8_0000 │  │            │
>   CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
> 0x7ff0_0000─┼───┘  │  │             │   │  │            │
>             │      │  │             │   │  │            │   PCI Addr
> 0x7ff8_0000─┼──────┘  │             │   └──► CfgSpace  ─┼────────────►
>             │         │             │      │            │    0
> 0x7000_0000─┼────────►├─────────┐   │      │            │
>             └─────────┘         │   └──────► IOSpace   ─┼────────────►
>              BUS Fabric         │          │            │    0
>                                 │          │            │
>                                 └──────────► MemSpace  ─┼────────────►
>                         IA: 0x8000_0000    │            │  0x8000_0000
>                                            └────────────┘
> 
> bus@5f000000 {
> 	compatible = "simple-bus";
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
> 		 <0x80000000 0x0 0x70000000 0x10000000>;

Does this address translation apply to all peripherals in the bus or just PCIe?
If it is just PCIe, why can't you encode the mapping in the below PCIe node
'ranges' property itself?

- Mani

> 
> 	pcie@5f010000 {
> 		compatible = "fsl,imx8q-pcie";
> 		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
> 		reg-names = "dbi", "config";
> 		#address-cells = <3>;
> 		#size-cells = <2>;
> 		device_type = "pci";
> 		bus-range = <0x00 0xff>;
> 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
> 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
> 	...
> 	};
> };
> 
> Term internal address (IA) here means the address just before PCIe
> controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
> be removed.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - %s/cpu_untranslate_addr/parent_bus_addr/g
> - update diagram.
> - improve commit message.
> 
> Change from v1 to v2
> - update because patch1 change get untranslate address method.
> - add using_dtbus_info in case break back compatibility for exited platform.
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h      |  8 +++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 3e41865c72904..823ff42c2e2c9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
>  	}
>  }
>  
> +static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
> +					resource_size_t *i_addr)
> +{
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	int ret;
> +
> +	if (!pci->using_dtbus_info) {
> +		*i_addr = pci_addr;
> +		return 0;
> +	}
> +
> +	ret = of_range_parser_init(&parser, np);
> +	if (ret)
> +		return ret;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		if (pci_addr == range.bus_addr) {
> +			*i_addr = range.parent_bus_addr;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	struct resource_entry *win;
>  	struct pci_host_bridge *bridge;
>  	struct resource *res;
> +	int index;
>  	int ret;
>  
>  	raw_spin_lock_init(&pp->lock);
> @@ -440,6 +469,13 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->cfg0_size = resource_size(res);
>  		pp->cfg0_base = res->start;
>  
> +		if (pci->using_dtbus_info) {
> +			index = of_property_match_string(np, "reg-names", "config");
> +			if (index < 0)
> +				return -EINVAL;
> +			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
> +		}
> +
>  		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
>  		if (IS_ERR(pp->va_cfg0_base))
>  			return PTR_ERR(pp->va_cfg0_base);
> @@ -462,6 +498,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		pp->io_base = pci_pio_to_address(win->res->start);
>  	}
>  
> +	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
> +		return -ENODEV;
> +
>  	/* Set default bus ops */
>  	bridge->ops = &dw_pcie_ops;
>  	bridge->child_ops = &dw_child_pcie_ops;
> @@ -733,6 +772,9 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.cpu_addr = entry->res->start;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
> +		if (dw_pcie_get_untranslate_addr(pci, atu.pci_addr, &atu.cpu_addr))
> +			return -EINVAL;
> +
>  		/* Adjust iATU size if MSG TLP region was allocated before */
>  		if (pp->msg_res && pp->msg_res->parent == entry->res)
>  			atu.size = resource_size(entry->res) -
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index c189781524fb8..e22d32b5a5f19 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -464,6 +464,14 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +	/*
> +	 * Use device tree 'ranges' property of bus node instead using
> +	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
> +	 * reflect real hardware's behavior. In case break these platform back
> +	 * compatibility, add below flags. Set it true if dts already correct
> +	 * indicate bus fabric address convert.
> +	 */
> +	bool			using_dtbus_info;
>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்


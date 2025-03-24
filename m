Return-Path: <linux-kernel+bounces-573852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42835A6DD24
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A3B167A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE7725F997;
	Mon, 24 Mar 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m25GWIhD"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E731C469D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826969; cv=none; b=UpOOma/sT5xED54D7p0ZA0opBlN0oSbzkCl0PbXbx4UZTQ4V9QnzZSy4zi6Fv7G6oehBwnDvPa1QieAISho5ieEdjgvpccOCJtnH1uUOz8WV6NHybKcNW4p+cZiL7SJz0Oq3uyb3M02jcVDLT6egKGCxYX/V8W49e2Trvi3j6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826969; c=relaxed/simple;
	bh=GzU2khTy9edLOPP+nLp8NetDsg+HJrBHGDBGWsqgqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly/vjpKyjiXrdtwQdtEDd5peKVEfQAyM7lu3sDDpj4D9yphXy1/63mNcHNlURnrmKpOZocAl4Xmty8uhSfJQbx/2ByVrTEqfq7e1Ezgl0+j8jTn6LL4Vc7eMytW5b6Cd6iqcV0GAK6aNXhpxcQk3J8o21G+/vyjWkoOYawfG4Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m25GWIhD; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2241053582dso8663245ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742826967; x=1743431767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gfDNrOLDRsSoKnoiSnKZrCZ6ys+s/p6oKC6Xtt3UxnY=;
        b=m25GWIhDQjgL8i+adCWRZXt00ur0ACXROJu85JtK59EdJkSkczr1UEpzTUKrhK+KM/
         mQ9ygtAJs2z+YME3KGKgKl4Jg7McKOKjJoduJN3a+rEDQQneak8Aurt0Wdqc0dJXoOUS
         q0dAtBnvsSAyD+QrVmkeHMNDaXISVQKEOT+NgLXmIFPHNaVZQoCkys+wAVSba81hIz/S
         KX8/FCP9nquDZ9IFN5TiHmVW0931Uuw4/fIpSGaVPUUXbBXv/OEvtj5pgGVGgkhkauXF
         PPRG63iI/r2leYRZNJcLmNw3sKjcXsCjoQGneExCqbtTvQTZSgsD++UMPLyQ9FLJJ/AF
         MgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826967; x=1743431767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfDNrOLDRsSoKnoiSnKZrCZ6ys+s/p6oKC6Xtt3UxnY=;
        b=Sa7AMKJ89QwVS5u1wFnegbK5iIIHfULI0tSNAOqRnfm0cyXv/Lw4eJ/TNeNgh4uLyW
         nWX3L6ku5ACLiP5Ih+N2R4xooj7ysggukv3S3yucwnqYgLjcVM4wuajfMAljpH9YrYuk
         9Vp0kFthWp2ueanssLLfIti4KFjNYoS+MpnuxHXlpgNZ2NIWRQmpmPIw+i3Vr3PqzCKR
         8mKDWCsgp5kmaVV8nWsHVmu620tP6WvbVrJg9nT9R0bRsQialVVYfVLbuVtWhjzi/uHP
         ppWMKTwo0ekSYUj6qGshMK71SoXlKHUPI4TGNP+FKPXAhUMCE8g0Yepm3r4qBZxPDx2H
         NJDA==
X-Forwarded-Encrypted: i=1; AJvYcCUGNeAKSpglLtvMy7Pp5NKOjl8Ni8265psZt32cnB9+Xj6ZzP7pXIR3b85VFFHjnRywpU+Sui/I46WWtvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Qwb3c/CjXXEAMFlUbFTidJKDsCR1QoSXVmPb9kjwEDHwWneZ
	8pGMcGv+m48uQ6Dz+EhStxEyx3QFLHzVLJhe71v+8YoF9LjlBB3Qdl+e8GK92A==
X-Gm-Gg: ASbGncvt8Rv9CJEmW0p0sM7dfMVfZpnhjkM+dmbbrrqW8hW/8ytin2xkpZADzc73PyJ
	RyflK+B1J7YXvGJv4cd+j4Hb6AI51+hvoZY7FRDGoIBxltwLCywSjSQygya4LsO4WQkyIXS8Crr
	HBG3wARmLfVsar933Q6gJKTjphNgF4DxZF5I1KX82RkLAwXauFGNlJJ6i5NNLxseG5E/ovtOBhm
	Wnz2CyaDGXmTqz3B3n/skx97y9eqLc5NCgbYApyMF8wx2DOmK3kax0ftYZU8a9WhvTODsTsTXA1
	DJuSZPvQ7UsbVr+VGXb2T2THJoDQg1a2ifwmamjQP8cvyLXkZYbapWM=
X-Google-Smtp-Source: AGHT+IHosn533Honkxz5Gkn47lhA4z7ibid7YzujQ4Q5gGN1wmrSmuIZVipbX/6bHz2UT8zZDxLukA==
X-Received: by 2002:a05:6a00:1885:b0:736:ab1d:7ed5 with SMTP id d2e1a72fcca58-73905623ea3mr21273776b3a.0.1742826966908;
        Mon, 24 Mar 2025 07:36:06 -0700 (PDT)
Received: from thinkpad ([120.60.67.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905faa565sm8053740b3a.1.2025.03.24.07.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:36:06 -0700 (PDT)
Date: Mon, 24 Mar 2025 20:05:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Niklas Cassel <cassel@kernel.org>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 00/13] PCI: Use device bus range info to cleanup RC
 Host/EP pci_fixup_addr()
Message-ID: <brhtmymbntt7dk3bqgcwjb72ai4g2bn4b5emcaxntbizvu4i7f@ulvm37yyl4oq>
References: <20250315201548.858189-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250315201548.858189-1-helgaas@kernel.org>

On Sat, Mar 15, 2025 at 03:15:35PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a v12 based on Frank's v11 series.
> 

Mostly looks good to me. But I do have a few comments, that I'll share.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> v11 https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-0-01d2313502ab@nxp.com
>     
> Changes from v11:
>   - Call devm_pci_alloc_host_bridge() early in dw_pcie_host_init(), before
>     any devicetree-related code
>   - Call devm_pci_epc_create() early in dw_pcie_ep_init(), before any
>     devicetree-related code
>   - Consolidate devicetree-related code in dw_pcie_host_get_resources() and
>     dw_pcie_ep_get_resources()
>   - Integrate dw_pcie_cfg0_setup() into dw_pcie_host_get_resources()
>   - Convert dw_pcie_init_parent_bus_offset() to dw_pcie_parent_bus_offset()
>     which returns the offset rather than setting it internally
>   - Split the debug comparison of devicetree info with .cpu_addr_fixup() to
>     separate patch so we can easily revert it later
>   - Drop "cpu_addr_fixup() usage detected" warning since we always warn
>     about something in that case anyway
> 
> Any comments welcome.
> 
> 
> Bjorn Helgaas (3):
>   PCI: dwc: Consolidate devicetree handling in
>     dw_pcie_host_get_resources()
>   PCI: dwc: ep: Call epc_create() early in dw_pcie_ep_init()
>   PCI: dwc: ep: Consolidate devicetree handling in
>     dw_pcie_ep_get_resources()
> 
> Frank Li (10):
>   PCI: dwc: Use resource start as iomap() input in
>     dw_pcie_pme_turn_off()
>   PCI: dwc: Rename cpu_addr to parent_bus_addr for ATU configuration
>   PCI: dwc: Call devm_pci_alloc_host_bridge() early in
>     dw_pcie_host_init()
>   PCI: dwc: Add dw_pcie_parent_bus_offset()
>   PCI: dwc: Add dw_pcie_parent_bus_offset() checking and debug
>   PCI: dwc: Use devicetree 'reg[config]' to derive CPU -> ATU addr
>     offset
>   PCI: dwc: ep: Use devicetree 'reg[addr_space]' to derive CPU -> ATU
>     addr offset
>   PCI: dwc: ep: Ensure proper iteration over outbound map windows
>   PCI: dwc: Use parent_bus_offset to remove need for .cpu_addr_fixup()
>   PCI: imx6: Remove cpu_addr_fixup()
> 
>  drivers/pci/controller/dwc/pci-imx6.c         | 18 +---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 74 +++++++++++------
>  .../pci/controller/dwc/pcie-designware-host.c | 57 ++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.c  | 82 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  | 24 +++++-
>  5 files changed, 171 insertions(+), 84 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்


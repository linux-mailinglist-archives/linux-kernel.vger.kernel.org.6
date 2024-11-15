Return-Path: <linux-kernel+bounces-411153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57589CF480
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33C84B2FB2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCAC1DD0EC;
	Fri, 15 Nov 2024 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FI3wDWSf"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B21D5CEE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695120; cv=none; b=YiaG5l7MpS91pnbA+SZSpv75evfntaGnDgbotECLP3NQvqcQVowGIg82fXpHsUO9WY5jtr2q8fly9vGMEa6Sq3re97uKJJ3CsOpgypb2L5rZz2Mem151MXVv70FkkHWn6pllXQokll0Z5RBScbRG7WbKCYQfTM5FnDGyHopDbO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695120; c=relaxed/simple;
	bh=LofSGZKkR67hmKxCOYuJW1GjLBLX+NDv8iq7jtavsg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO9fkoK8dHmRcw6wUtoRCOdqH6gAKCdnWjY8v+qYVBrZGPUTZ5SOOgMo7kAFHVcpgboPDFC9R+c2bwSKef7xuVC8rr6AtqIBADl8IGDaa0P0J4+jxvPzB7si6F++sVPGj82fPDnKMBt2H4H0vBQ3bisndLy/jlCymiNwbt6ax54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FI3wDWSf; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20e6981ca77so11551195ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731695119; x=1732299919; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s9XJvqo1TjVxClmTuPUa2mnZBMZRL0LlNGR2vRqPsWA=;
        b=FI3wDWSfmiiVfJQplGc2BNvDs8TTGY6wmpj72MH3CwftL8HDpQJ46DZiUDjiFkGLbI
         bYIAhjCrKxgE7OgAQ1mj7sRjBu35lisAMRLyGhsD3PfuH9LWf2JhzJiySiW42fN/q/Ux
         NlW5PMHT+JTuu59XTIiyZPmis+Un7dY+ao2nB8Snw1jUBHxZ0CNwLRVxC4Wkr1T8epvo
         rkuecjO1htkOT+rx+R5GR5lUOuMkNk3GB3E0t5+o+m7w84xgls4rcBrY9FphgCfNgoTJ
         jq9DfDEbUMCqeVNj2le8aQ3Owo01jC+JXvl8BcIsYOIaGa4+hw5ACVr+Of5UFsmmImUz
         m+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731695119; x=1732299919;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9XJvqo1TjVxClmTuPUa2mnZBMZRL0LlNGR2vRqPsWA=;
        b=jzLu73uwyEj45E2rsjMZLT3dt18auQjp25ZmcbxagYdwrAJ3ACWQXL4NIr5m04OhLi
         VDuZ2ZnWY2HLopS6bFtiKgueI2SWFKq9LVfjniSfS5HaEkW7ilBF4d1I+NZ/QYe4Pyx9
         xSmnzY3SMGMUb8vKwceWSTDx7yODCy1CA/MMfovu7oHaouhQyLaDxEqnNVYU3Ck0jqic
         oUzt9M2vg+fsb8l0mRl3MIla9PqkSZVzjfSskHesWfDywhdEgZbhcIMIcH56DJkOYZsX
         fFajj1fL7IMdB8h8LN417FMshJ5yEXEMmk7Q5n+Jr6ns/M+o4YYEJyKKN94NqECiqv7j
         M8Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXXlxfC9VNc7bIDvO0WFA0ITqOXKUheH5d0ZP59P92XPkLbajLDtTDS6R955NUtHjx03aU/R48GtMu0PzM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypax8FfQ1EhCr/Yd9PGlbHtC//C6soD/s2/IOOiRl4FGH4eDE6
	im489/C2eC+UPammLBdUFBIue5xDyowMOq2S4VbrVXrygYlCFdIP6NDk2uqDEA==
X-Google-Smtp-Source: AGHT+IG8xYEUyxbkvzwvpJ9n8KCZIy6/ye3xoYrVPeMJNXB6RnHN6free7fMoWUZKt6qptIgJECrgA==
X-Received: by 2002:a17:902:dacd:b0:20e:986a:6e72 with SMTP id d9443c01a7336-211d0d92195mr50180975ad.30.1731695118780;
        Fri, 15 Nov 2024 10:25:18 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f61670sm14893285ad.281.2024.11.15.10.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 10:25:18 -0800 (PST)
Date: Fri, 15 Nov 2024 23:55:10 +0530
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
Subject: Re: [PATCH v7 4/7] PCI: imx6: Remove cpu_addr_fixup()
Message-ID: <20241115182510.zyaopwz4phl2szzi@thinkpad>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
 <20241029-pci_fixup_addr-v7-4-8310dc24fb7c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241029-pci_fixup_addr-v7-4-8310dc24fb7c@nxp.com>

On Tue, Oct 29, 2024 at 12:36:37PM -0400, Frank Li wrote:
> Remove cpu_addr_fixup() because dwc common driver already handle address
> translate.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Great work!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Change from v2 to v7
> - none
> Change from v1 to v2
> - set using_dtbus_info true
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f1054173..533905b3942a1 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -81,7 +81,6 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> -#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1012,22 +1011,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> -static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> -{
> -	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> -	struct dw_pcie_rp *pp = &pcie->pp;
> -	struct resource_entry *entry;
> -
> -	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> -		return cpu_addr;
> -
> -	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> -	if (!entry)
> -		return cpu_addr;
> -
> -	return cpu_addr - entry->offset;
> -}
> -
>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> @@ -1036,7 +1019,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = imx_pcie_start_link,
>  	.stop_link = imx_pcie_stop_link,
> -	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
>  };
>  
>  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> @@ -1446,6 +1428,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	pci->using_dtbus_info = true;
>  	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		ret = imx_add_pcie_ep(imx_pcie, pdev);
>  		if (ret < 0)
> @@ -1585,8 +1568,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8Q] = {
>  		.variant = IMX8Q,
> -		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
> -			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
> +		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
>  		.clk_names = imx8q_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8q_clks),
>  	},
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்


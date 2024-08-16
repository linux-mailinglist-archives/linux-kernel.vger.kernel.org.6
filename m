Return-Path: <linux-kernel+bounces-289140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698FC95425E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD91928D660
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6E785626;
	Fri, 16 Aug 2024 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mC7QMY6N"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055E81AB6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 07:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792053; cv=none; b=IfWHcFe3Gv6lne0ML/K1H6OnCT/UDAGCXt3B1+oyWyQKdQceaRhZGW1hac5ozjT9A5i+QjujGmFAjT8O7MJz8Y83jeIVP0opGZsYfcazy5HCOtA/25GJiGnDG3T4PyvHaRdQLCoPS6itxcVtWlNRJTxUheKSSnON5Dko5zktMPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792053; c=relaxed/simple;
	bh=fXgcrco1fosTB7VaQPkK50FCi2bb1sTEczfnQhaQohQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIogX9mqW5O4u+0+HHrwz0y4OxO9RWLercshOoN+ZfdlmQtQNGp+wyudAycnFr7vETFP0F+IJSiuURsLnU0o2KxJJ0HC3xPMNlm1/LS6ACplJfDJbGPW0E54AULwtYs8KzsikW2Fg4Ivt3HmtbvY2OunQqZCPICzcms6el9O01U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mC7QMY6N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc60c3ead4so15972635ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 00:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792050; x=1724396850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O0k8JzYHQaThRxAHYqkzcgQEmY5VY+g+3F3Xyn+HevI=;
        b=mC7QMY6NeGIgDlFGZ8MagJvuJ1SYMofDgsXsmN+urVzu47D/Z8SXe4QNYxKqxsuqEr
         Apvoew/9St9BPvCFLxF7T6Eaq4on97XHhg2vwXU6lJqlqNj6u9ijbpa05XXALYyrOdCr
         pkLE4Codm7vhSK/ZX5pLBFjfIlWZS9aqspBqRCWFLojxLoSEhny7TZSNv1zNXmSZC3bk
         ZMONFT/8Z9rLlWhgVFWu38SW/oS617QQAsDcH80cvykMCgQvuZjhsYsLyTWYDuFqJ/uK
         0SvXz9w6OJ6A3Ck7I9IPaGigPMk5UNtMkoL8LexzIHWDZnCgeTy9sUQJ+qMqg21WK3/C
         khQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792050; x=1724396850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0k8JzYHQaThRxAHYqkzcgQEmY5VY+g+3F3Xyn+HevI=;
        b=V9UcVtcayFER4GEzYC9GuntALbi0Okt2qwv9nf/C37FeMXxUb+gaXmkdd35mRwP93a
         EHT9YFErOXjU+72ps7x0p+hD+1I4LjFxbgwaDJN9FTaHKwu7q/nf2j1QiZ85hd4rMxGI
         PJLRo5w7MtRZvl9SNeVX0yDxv7X9FcKxkokZxM+Q2lczsacTj3NVfcz5oThMtoUNNV3F
         gh9ihRH2+2lfeFeCzIR+Jr0yZaXhsO+KDUJCbWfQ3UDAU40iWNbJ0/sHAcESjL8hfD1S
         fm4doRPjSLsm9lKEV6YxwH7Q0srkmqWoodBL6m7mOW9h0EyCubAlMp9uJNRO0SfHuWiF
         wGMg==
X-Forwarded-Encrypted: i=1; AJvYcCVUQZGYHfY8y4To9EF9fyRMAVmhgFHVF5Rnq0XRi/JP66gfYzcu7Xb/tIn6Iei1N5aJ5hp8ePi1WxrPJV7CRGRJvLjx8Ay2HrpbbIJs
X-Gm-Message-State: AOJu0YyCOUSGaTczuAYOFZSZyxtHl8DLE3QZUc+lH8pvST6BPd+94Wbk
	izuAmLGvpJbhqDuz1ZnC4oabwjf7GPkawx+luAFWKpODhb1hD5Rhi/RsUTfN2w==
X-Google-Smtp-Source: AGHT+IHKExLprs85qhO0U2PEP/08ew+AFLlzlNAEgq2CZoEQqhDB9QZy1dnL1kGwmhCct0aCPZ+DBg==
X-Received: by 2002:a17:90b:374a:b0:2d3:d7b9:2c7e with SMTP id 98e67ed59e1d1-2d3dfd9074bmr2315720a91.24.1723792050274;
        Fri, 16 Aug 2024 00:07:30 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3d97f97sm1053761a91.50.2024.08.16.00.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:07:29 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:37:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/13] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240816070724.GJ2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-6-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-6-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:18PM -0400, Jim Quinlan wrote:
> The 7712 SOC has a bridge reset which can be described in the device tree.
> Use it if present.  Otherwise, continue to use the legacy method to reset
> the bridge.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 790a149f6581..af14debd81d0 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -265,6 +265,7 @@ struct brcm_pcie {
>  	enum pcie_type		type;
>  	struct reset_control	*rescal;
>  	struct reset_control	*perst_reset;
> +	struct reset_control	*bridge_reset;
>  	int			num_memc;
>  	u64			memc_size[PCIE_BRCM_MAX_MEMC];
>  	u32			hw_rev;
> @@ -732,12 +733,19 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  
>  static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
> -	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> -	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +	if (val)
> +		reset_control_assert(pcie->bridge_reset);
> +	else
> +		reset_control_deassert(pcie->bridge_reset);
>  
> -	tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> -	tmp = (tmp & ~mask) | ((val << shift) & mask);
> -	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	if (!pcie->bridge_reset) {
> +		u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
> +		u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> +
> +		tmp = readl(pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +		tmp = (tmp & ~mask) | ((val << shift) & mask);
> +		writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
> +	}
>  }
>  
>  static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
> @@ -1621,10 +1629,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
>  
> +	pcie->bridge_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "bridge");
> +	if (IS_ERR(pcie->bridge_reset))
> +		return PTR_ERR(pcie->bridge_reset);
> +
>  	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
>  		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
>  
> +	pcie->bridge_sw_init_set(pcie, 0);
> +
>  	ret = reset_control_reset(pcie->rescal);
>  	if (ret) {
>  		clk_disable_unprepare(pcie->clk);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்


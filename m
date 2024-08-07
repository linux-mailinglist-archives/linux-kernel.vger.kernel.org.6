Return-Path: <linux-kernel+bounces-277217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA2B949DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 04:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA2F0B2330A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 02:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DD418FDAE;
	Wed,  7 Aug 2024 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rifdrsnQ"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E85D1E495
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999568; cv=none; b=b5DNbc7kwQEsveuvT9rdsCs3NCHJgmRdX3krTP30A3ys/Saz7pG666PPROWWsc1fLDDRzsVPuvyfmU2rdjqrOrl4k6w99k+RjFNIRm+iByh5FkCTPcoHURu1H0iTeRKjvXgLLNUFfqP7L+UQqMyFZepoSRRMhMzZmJBurS2lV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999568; c=relaxed/simple;
	bh=s6gtBRTcGW8IZIqoY2rd7fWLYDZCueKhRnGLw0igTkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaS/7fNuWQ7KXxokAA+oGyN1nhUtONFaZ6AjFs9nVkANh329a0N3GAEWeqoChxtyTFKtD+n4uSef5d7sb18iJTtBYp5E4cTxQX6W1S4lchhRbVR8fMuCyuk5pJhTOBrHbIHaZHzX9XHzWml60TBIJQJ6wsFLIqK9WKNJgNnvL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rifdrsnQ; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d18112b60so345407b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722999566; x=1723604366; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U1m00D/eRsR3sTtSAbUOk6Hp4zyD2ST919kFJY6iP6U=;
        b=rifdrsnQp1J/AhmkXEap/CdlUpbUQDNbdhxHwLQbKD+DgFET9ZMHX9PdB4uz16X6v8
         lHqSqrrKjbJ1YV1gwD+p4xZtG8tkuizOLIvEp62dwtiy+ksBgaKcW1hmFTuuBqrkPGeO
         pHiY7rOim5dv/ms/sVnK8KTKOPH2ykuxREANj6jmgbZJz0CxDsT43p2lMEp5nxLDVobD
         UOR/Mqd3muQ8WgAMq2wFyWmVcw1s3JD7SLaUp1QQU8t2QrseB4GNw5WlDMv5iaZdSPWS
         PkbZdZVW8mpIPstGZylWObjY0iGrHGesf4y1wfQvWg02+AEvcXQ9dNlzfGAW2pt5T28z
         l+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999566; x=1723604366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U1m00D/eRsR3sTtSAbUOk6Hp4zyD2ST919kFJY6iP6U=;
        b=kXZR+gaK3XWqnmH1M0beEY9tieVwDwdsgnNxz7hMD2MZCxVfloyJqmjV/g+JgkvNBl
         dpZYJ88H14Po+CMX6Rv3oDFc6NvbDSg///EVXcQeZ9a9kLUm6H7zgt/iT3L71u1XDNVo
         MGz9I+L2aoSjieM7IfTXg2wTKaSeZkEkbab2FbPjPfN5mSs1LkB2NdSnNggGEItIzJgh
         MZOFG24DpwiqmmVSEb6GTkO5MX1XdnwvuDwz6fPDmV6ULLxlvYEiTKg6D9Kf73MmrAIm
         fdZWqwKn0t/WySx60+mP9/vgQEH3cHn6seV8upxd6PO5xZGr24p1NDgo4LrtKjFKRNwi
         ZmSw==
X-Forwarded-Encrypted: i=1; AJvYcCVOx517WuCEG5OmOVU+iKFUPZHL/5r1rb02iRYq790sIlDANme3Tfa8rgasEqqXd95lZbFB00qo0SIiJYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5UPa53O7DyqzcSwtEP5Lq29RwHIb8faetwQdyLl77jEbLfJ/j
	jfmyM0LTLHH8uMG4Ac2P7r/69QwHxucB72w6Lqjvr9u8UGA6D07UY/zmMvXXbw==
X-Google-Smtp-Source: AGHT+IFT/iYT7B/31my5hbcrkTJerIDiFHN9YWyJe4xOGN7mYzxSxl23V8TqbGRxeAzEquMvFM8eRQ==
X-Received: by 2002:a05:6a00:2184:b0:707:fa61:1c6a with SMTP id d2e1a72fcca58-710bc89d6bfmr1262074b3a.10.1722999565598;
        Tue, 06 Aug 2024 19:59:25 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfe2dsm7580256b3a.114.2024.08.06.19.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:59:25 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:29:18 +0530
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
Subject: Re: [PATCH v5 04/12] PCI: brcmstb: Use bridge reset if available
Message-ID: <20240807025918.GG3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-5-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-5-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:18PM -0400, Jim Quinlan wrote:
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
> index 7595e7009192..4d68fe318178 100644
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
>  	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
>  		goto clk_disable_unprepare;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்


Return-Path: <linux-kernel+bounces-261755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633C493BBC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866101C219AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8AD12B95;
	Thu, 25 Jul 2024 04:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4kH/NIl"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E9187F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721881879; cv=none; b=m4kXGS3NipxgbyTkK3/pPTfp2TJNVAqmfCvQ07oX/YjAIRQBWlbAI1RksX9dNlibJGzw8M54ne1VhhmhTILfuLh+YvOlArNEfJCdtiaNapmwyd0b8UJdOc2gN/Aq+fhXKkR4OnJc8C504IQSSM9HdNOtekOGIakGpeXe3dTjFLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721881879; c=relaxed/simple;
	bh=X0LCLEP4obca1nLd4uqhOQvKIEY53jmMcqK3W3MSgRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVDM3A+PxE3KzBRvegW1wZY60a5a0k/sFRaV7ZMZMzfk05Pus/tXfV74V8SXw8zC3nLwKx/WTGyHtmRWJNexgcsyZ5kfVCvmj9LDMcXUzWv61NbBKL32IL/JfbdeZxRzO9NrDzQT3OijNPGt9BXSq8snU3Wrsp09maT3/LWir78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4kH/NIl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d2b921cdfso454260b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721881877; x=1722486677; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XXfannR0i35m+kTBwRZd8UAXF5c0K76k4L1K8mKl1Ek=;
        b=i4kH/NIldXSji/ilcniMrAQ97CA1IVs40pgk6sl5A/iIyJyoE/0Iaa6qnmwdAP1MsJ
         I7b0a5Ml2+cnJ9/0FXv44yguYL/2LoAWt2pRmYTQfWJW1WcOyrR/GDQfDaLYExkR6Rhm
         DQWiKMHZW+iSo+n3iIKH9o5N/gggwVdVyUAVE0no1byd2JKekv8eOdD7OPlIjh2z1onT
         /cDq4RmOpOHDTRsjy4EcsMKSRRg3/WC34nIz0lQbGkRY+dzTI0cRUhhLX9QdHs2N6lG8
         lK813LwsqW33VsTcudatAA2Qr7KeOxF5t2VForPD+wRI7bty6u2ab2WgisILKA2B7HUg
         aRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721881877; x=1722486677;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXfannR0i35m+kTBwRZd8UAXF5c0K76k4L1K8mKl1Ek=;
        b=vj+C9N9C8Uq5icsD1e4yjCXCiwSpp5pjrd6/rdK50jEf8lFoY2CVXyPH5j+m2q4Dch
         BfgZ+lcVzpydN6h5XpKbu0cB6CB5BM92hu7NA53hLMVP6DB4P7k+LKmcaOVsxiBOITXZ
         61XL4CfV0EEy9MvXnT8YbLwLMVefTFzdofyTobiVdUXrTUdLtK62sN/Iox/c/m217iDu
         9EsNAdCQUqY6b5ufDrZ+nBi1NeympCivejfsD2eflMR5GBFcPFtHkWUhBD3bDNwc4z6H
         c5DH5HtOLM6h9wo0AMSWGA4TE1jESzbaBuqqb73fq1ihYSLTmAVxYv3+jP0+4F3aQeF6
         f7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVinq6uc9bPASBhmkG26kbCj8jLPAPm6G0Hf3cr+9bYqBImrlzm6QNa6g9GyVUThrnldihEGKXYyGTVaMVPjLwuOPdsgT7CJFn9dMrQ
X-Gm-Message-State: AOJu0YyDefFYKTjjK9EUNPZDnFBHnYW+ZZ1NdTtesPyfYxtVVdb8FgCq
	+kp309QXW9Gf9a7UyJmnuDY84jOy0Y2veISDy9fzY320yeavsdPzqxOodFg/5g==
X-Google-Smtp-Source: AGHT+IGXP64T7aTAPdkei1RXlp7A5rssNN997hjPGJuJA94RsOXciUbGOuoAzAwhs2/QCXjvj/Qa8w==
X-Received: by 2002:a05:6a00:22d1:b0:70b:152:331 with SMTP id d2e1a72fcca58-70eaa936f64mr2043343b3a.21.1721881876962;
        Wed, 24 Jul 2024 21:31:16 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812300sm343213b3a.114.2024.07.24.21.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:31:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:01:11 +0530
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
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
Message-ID: <20240725043111.GD2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-4-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:18PM -0400, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Add a jump target (clk_out) so that a bit of exception handling can be
>   better reused at the end of this function implementation.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 29 +++++++++++++++------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..c257434edc08 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1613,31 +1613,30 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -	ret = clk_prepare_enable(pcie->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clock\n");
> -		return ret;
> -	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> -	if (IS_ERR(pcie->rescal)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->rescal))
>  		return PTR_ERR(pcie->rescal);
> -	}
> +
>  	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> -	if (IS_ERR(pcie->perst_reset)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
> +
> +	ret = clk_prepare_enable(pcie->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "could not enable clock\n");
> +		return ret;
>  	}
>  
>  	ret = reset_control_reset(pcie->rescal);
> -	if (ret)
> +	if (ret) {
>  		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		goto clk_out;

Please use a descriptive name for the err labels. Here this err path disables
and unprepares the clk, so use 'clk_disable_unprepare'.

> +	}
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);
> -		clk_disable_unprepare(pcie->clk);
> -		return ret;
> +		goto clk_out;
>  	}
>  
>  	ret = brcm_pcie_setup(pcie);
> @@ -1676,6 +1675,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +clk_out:
> +	clk_disable_unprepare(pcie->clk);
> +	return ret;
> +

This is leaking the resources. Move this new label below 'fail'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்


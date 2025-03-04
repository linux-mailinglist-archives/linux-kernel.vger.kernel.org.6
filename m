Return-Path: <linux-kernel+bounces-544596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB7A4E2DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D39421956
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45745253337;
	Tue,  4 Mar 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbFBCArO"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC94E25C6FF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100928; cv=none; b=o2Pr7roUT/3x74kqJ6z/EUJ3cMMFem7+npSS60pY78VRFKLeDDxY9f8C52aq2UezOJSwZLOH5zfuNqcXcPRpCtjZ6lJU4b4Dk+ix8JnrQaval+PXYGZyCt33S0WNiwDJBVEcp+FdWN3iFvVWyYB/U+C7JEvd7y8wqpMKyY464zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100928; c=relaxed/simple;
	bh=HYikrnmfxR4OjhgA7T8ks2wQr4gjl3QeN1hzLi7phwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia+8+44mG+RycpLT2hZ2o7duZiM3suehApPiAv2DTKwiupvhidXN3+yF2O/li4BC6anQcIbAR+iQs0+Zwe+qf90XEEWH7bOawQCQ91OLX1sQnd/Zz68Q7biN71DF7rjFDdhKAQDqwwmeo+a2mIwvfdE16oiOVzyaMyUIPhaseRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GbFBCArO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223959039f4so58667875ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741100925; x=1741705725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZjiljQTviEDPhmhXZgDQ4TTKjdmkRjmGdt5pKh0gNc8=;
        b=GbFBCArOPItUBayFzjYe2FC8cacucd/3inkKeBmSk2A7IKV3mLIZ8gjzTFJ/GR4YEE
         mFV1tO/KJVHBgh+bSQGkC2hOb4WdYQTgz1Z9k8IwWUPhNK3iummgbOMHYWnuq+5BDclo
         3uSUDF3G36yCcNt42UJ4vj05hQW3uAPa2z55uDdAiBWsi2gJvB14RY9rm1BEmuLN8GOx
         XzJ+7/ALGgHtv9JQ38/niN+r/Yvnu9wN6gl/ub8usUPQthKcH2gpYL3ej8eEa8ujcYpp
         cDiLXIYbAAZXhb1r5gIahgSB93ptPqPOnC/FxQl3xHINsMcjUcBjz4y+VMuoC+gjCegd
         Llhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741100925; x=1741705725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjiljQTviEDPhmhXZgDQ4TTKjdmkRjmGdt5pKh0gNc8=;
        b=Enqz+jK2zzAIoEGDa/PESXifVmmmojbLZSdtiwe/yAC4MPRDOzA5ypa7H4PEIs9Ors
         IyYAGJ7cl7JLWg5KdzUagOFudhIyYzE2vYAPdwnjvp6Vgf/X7c1AiZOi5fsBqq57Dgnw
         FChv9qtWr9uPPBJ8PZHjgyxdl1MtXq/I1vTDN4pAgq+scgQKEVWtEcQKOe+ram3DUyp6
         PaZ3v4Ycb4F7+glel2EwHATF8tOYkLimSkBRNahrHhEvFEQKEG6sbCl5sohw3HNZr2z5
         ong2Oy9QQfLkv+6pUAj/HnawgEWSGOYkWzCTO99C3ZxeR6PxpnOcoWihbezi2GieMjbZ
         W19A==
X-Forwarded-Encrypted: i=1; AJvYcCXby2Am7LpRrP787vUoRepuNOrfRlZCuxIWKTMkZrwPnHbqw75cJBXyoOonB6WIgxmS1Jwcen/EV5xAyIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXgjcXIDA6IxrsfFzlKdgaIL55rrcad+tgwjh2tf3IsWVUcb7
	kWyzxVVetupxG6sqGpyLY2pqhaBCsrue5J/tfbrVWLVnUqJq5LsLhQ9iCU6hGg==
X-Gm-Gg: ASbGncu3i1uSet13J4jSYj+EtMlnD8WuaS6JBkj9b/pZWxM1ennRNHm8+67zgYpL3wx
	L62eabaD1KwJuetdM7CfkUSWCx1r0MrLqyP8DXw2RXA/UQcyFG+hQ+SGJm7jL/fBHpR8l7S6HLK
	n/rUx+eqtcqfzQX2sLrNnUs+m0HJXpcPxACyn3tqTQJJ9tEVwvZUv4/KKGu0hhY7E1aJbS7uC5n
	RnSKHNXw2EXlvq9AS0Tje3Wb1AzY3+jjQJDAFe2zxsedvfSgs1BiSCyN3aIdl+jkxyx/30yypgV
	IrWBDT3GkH65tpNijv382luRu8KzCTHXJsXRU5+HKpe+isoHtLpvmGY=
X-Google-Smtp-Source: AGHT+IHrDiyu7JyyUaCpNZBRWqNi4l6xLSdCaNxkD7VzQLNr/sJguqTX3KZTI2raz26SwVrgNAG86w==
X-Received: by 2002:a05:6a21:8983:b0:1f3:1d13:969f with SMTP id adf61e73a8af0-1f31d13dec4mr15120281637.9.1741100925020;
        Tue, 04 Mar 2025 07:08:45 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af25bfb4a93sm1474563a12.31.2025.03.04.07.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:08:44 -0800 (PST)
Date: Tue, 4 Mar 2025 20:38:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/8] PCI: brcmstb: Use same constant table for config
 space access
Message-ID: <20250304150838.23ca5qbhm4yrpa3h@thinkpad>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
 <20250214173944.47506-7-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214173944.47506-7-james.quinlan@broadcom.com>

On Fri, Feb 14, 2025 at 12:39:34PM -0500, Jim Quinlan wrote:
> The constants EXT_CFG_DATA and EXT_CFG_INDEX vary by SOC. One of the
> map_bus methods used these constants, the other used different constants.
> Fortunately there was no problem because the SoCs that used the latter
> map_bus method all had the same register constants.
> 
> Remove the redundant constants and adjust the code to use them.  In
> addition, update EXT_CFG_DATA to use the 4k-page based config space access
> system, which is what the second map_bus method was already using.
> 

What is the effect of this change? Why is it required? Sounds like it got
sneaked in.

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e1059e3365bd..923ac1a03f85 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -150,9 +150,6 @@
>  #define  MSI_INT_MASK_SET		0x10
>  #define  MSI_INT_MASK_CLR		0x14
>  
> -#define PCIE_EXT_CFG_DATA				0x8000
> -#define PCIE_EXT_CFG_INDEX				0x9000
> -
>  #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
>  #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
>  
> @@ -727,8 +724,8 @@ static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
>  
>  	/* For devices, write to the config space index register */
>  	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
> -	writel(idx, pcie->base + PCIE_EXT_CFG_INDEX);
> -	return base + PCIE_EXT_CFG_DATA + PCIE_ECAM_REG(where);
> +	writel(idx, base + IDX_ADDR(pcie));
> +	return base + DATA_ADDR(pcie) + PCIE_ECAM_REG(where);
>  }
>  
>  static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
> @@ -1711,7 +1708,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>  static const int pcie_offsets[] = {
>  	[RGR1_SW_INIT_1]	= 0x9210,
>  	[EXT_CFG_INDEX]		= 0x9000,
> -	[EXT_CFG_DATA]		= 0x9004,
> +	[EXT_CFG_DATA]		= 0x8000,
>  	[PCIE_HARD_DEBUG]	= 0x4204,
>  	[PCIE_INTR2_CPU_BASE]	= 0x4300,
>  };
> @@ -1719,7 +1716,7 @@ static const int pcie_offsets[] = {
>  static const int pcie_offsets_bcm7278[] = {
>  	[RGR1_SW_INIT_1]	= 0xc010,
>  	[EXT_CFG_INDEX]		= 0x9000,
> -	[EXT_CFG_DATA]		= 0x9004,
> +	[EXT_CFG_DATA]		= 0x8000,
>  	[PCIE_HARD_DEBUG]	= 0x4204,
>  	[PCIE_INTR2_CPU_BASE]	= 0x4300,
>  };
> @@ -1733,8 +1730,9 @@ static const int pcie_offsets_bcm7425[] = {
>  };
>  
>  static const int pcie_offsets_bcm7712[] = {
> +	[RGR1_SW_INIT_1]	= 0x9210,
>  	[EXT_CFG_INDEX]		= 0x9000,
> -	[EXT_CFG_DATA]		= 0x9004,
> +	[EXT_CFG_DATA]		= 0x8000,
>  	[PCIE_HARD_DEBUG]	= 0x4304,
>  	[PCIE_INTR2_CPU_BASE]	= 0x4400,
>  };
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்


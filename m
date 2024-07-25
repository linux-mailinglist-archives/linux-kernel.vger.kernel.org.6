Return-Path: <linux-kernel+bounces-261770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9785A93BBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E71F281F79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124B1C6B7;
	Thu, 25 Jul 2024 04:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KDUsENMV"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB1218C22
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883577; cv=none; b=DiEZ7j4wKXr//rl9Mqc7sx0LQGWIgRdWhU2HiPVTh5HZr766soLLcQ/NvoEuVwW0nSR/wO2GGtp0MFbBJaIHaELJ6YT9PdZ/rxPDpI8fHjWVll6KH3duQs/SxYJ7BqY+jS4+N/He3B6tE6SkHtvkKt5CUFO6nAp1yGNQObx0a0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883577; c=relaxed/simple;
	bh=lYCeW558nXoKbT0/XRIvKC2MyCW8u8hryqq2BNBKUCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpoESXLAaVptVpm1lcNHIDs9cnCY1FeM6hdA5sIzPAzIaf91bxX5XZKuD4z0dRbw5nRJcGdtropajHFRyvFudqyMBcW9pPKKyVu/bXZjb2tRF4Gw1eBpKolSCAaOq8vlrUjBaI/pc1Yy97OtFHeOmkePj8fMMalreZttOglN3Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KDUsENMV; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc4fcbb131so4421135ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 21:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721883574; x=1722488374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5dcA9JBHUbgUtUGlvPZ+d1i2R/fvuDGRFExDVQlZWo=;
        b=KDUsENMVpzRLGNm4OXFpPiE+T8wl5ghS+mLqTXtLG9X8M2O62UX8sfdbxPI0wHyvZy
         Bm08WYaxp2ptPfjMLe7XLQWS72no8OF8ypYIWtPbk5t7hmlcumaXpd+klzPgGuHmOJse
         hD1i/BzefevTS64UQBWBhRlX+hrBEMrjQHSv4mbCKVrmgAu6ZAMt8LOnUXLnHOuCwuCS
         WOF7PrqYZrrQfmLfpXyniLLAJHF8lkiSC55uAytyqb4gZkw/KpQEy4asgRZyCIiMYML7
         fmPyGYwJ8lnWAzxN8x2ky4frR1SKIbI7VZbFeckSu8cn/jOh+HBxYZ3umrrVZXKl4uMq
         AsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883574; x=1722488374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5dcA9JBHUbgUtUGlvPZ+d1i2R/fvuDGRFExDVQlZWo=;
        b=e5/KAc1KA+hTRFE9B+ob97xhStdzU5A1QOekSfhgmVLqcfb0cB49rITOF8Gxqle7Lg
         W4DOJ+ZpyPaG2v4Hf0GQ9847FacHd+NqHitKdbxVrb/L9Ecmx/nY/Mu+SJmij5pPhooF
         D3zibwdGuM+enN5EE3YX4tArFXPzOqlt8GnDLXJZ24uYdu0zeGubIbF817t+HmbC6qwl
         80e8XnCjM8k+m5SnkubC1/LrePaRbV5A3OirYZXh6XWR7cXSeUtXlNyvRXmCotZPs/Lr
         NY/gVfAFSM2pcQ+PccKQTGJMeA0TitCmYJe1YcNc40TxIaNC3Iswo8L/hFw35X8jjEu7
         LBtA==
X-Forwarded-Encrypted: i=1; AJvYcCWMQy+1Mb9ZuMnrLadPeggqQefEQv7XoDlyKtzqktj2XYW6YUkUvTaNZ119fx7fiXgShRWBAf2DgVg9z27CIT9i5BQhPmtnPhHyc2NT
X-Gm-Message-State: AOJu0YyI/rj769BestbnJW36RHPJh1lupRfJTfdExg1BYWDDWeO4mA2t
	76DYYQxfO7V0q3KatvMXRGJ3CKb3EVpEWIby06m2/kt9LtoviW53CWisjWDDWg==
X-Google-Smtp-Source: AGHT+IGMEfl9npbHWomGeCCHNpA8vlU7101iyR/8qjyjEaFN2MiYxoZZQdRxZ22z7VT+wFZkyHbdoA==
X-Received: by 2002:a17:903:2349:b0:1fb:8890:16b4 with SMTP id d9443c01a7336-1fed933a089mr8658505ad.48.1721883573726;
        Wed, 24 Jul 2024 21:59:33 -0700 (PDT)
Received: from thinkpad ([103.244.168.26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f9e8fcsm4398215ad.249.2024.07.24.21.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 21:59:33 -0700 (PDT)
Date: Thu, 25 Jul 2024 10:29:28 +0530
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
Subject: Re: [PATCH v4 12/12] PCI: brcmstb: Enable 7712 SOCs
Message-ID: <20240725045928.GL2317@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-13-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716213131.6036-13-james.quinlan@broadcom.com>

On Tue, Jul 16, 2024 at 05:31:27PM -0400, Jim Quinlan wrote:
> The Broadcom STB 7712 is the sibling chip of the RPi 5 (2712).
> 

Could you please add more info about this SoC? What PCIe Gen it supports, lanes,
IP revision etc...

- Mani

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index fa5616a56383..7debb3599789 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1193,6 +1193,10 @@ static void brcm_extend_rbus_timeout(struct brcm_pcie *pcie)
>  	const unsigned int REG_OFFSET = PCIE_RGR1_SW_INIT_1(pcie) - 8;
>  	u32 timeout_us = 4000000; /* 4 seconds, our setting for L1SS */
>  
> +	/* 7712 does not have this (RGR1) timer */
> +	if (pcie->model == BCM7712)
> +		return;
> +
>  	/* Each unit in timeout register is 1/216,000,000 seconds */
>  	writel(216 * timeout_us, pcie->base + REG_OFFSET);
>  }
> @@ -1664,6 +1668,13 @@ static const int pcie_offsets_bmips_7425[] = {
>  	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
> +static const int pcie_offset_bcm7712[] = {
> +	[EXT_CFG_INDEX]  = 0x9000,
> +	[EXT_CFG_DATA]   = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4304,
> +	[PCIE_INTR2_CPU_BASE] = 0x4400,
> +};
> +
>  static const struct pcie_cfg_data generic_cfg = {
>  	.offsets	= pcie_offsets,
>  	.model		= GENERIC,
> @@ -1729,6 +1740,14 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  	.num_inbound	= 3,
>  };
>  
> +static const struct pcie_cfg_data bcm7712_cfg = {
> +	.offsets	= pcie_offset_bcm7712,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.model		= BCM7712,
> +	.num_inbound	= 10,
> +};
> +
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
> @@ -1738,6 +1757,7 @@ static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> +	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
>  	{},
>  };
>  
> -- 
> 2.17.1
> 



-- 
மணிவண்ணன் சதாசிவம்


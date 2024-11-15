Return-Path: <linux-kernel+bounces-410310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74E9CD9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37421282B7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852FE1891A9;
	Fri, 15 Nov 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yvB6UEgy"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D01174EE4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731654978; cv=none; b=Ge+SlzZMjjnsyqNz6hqf/C95TLVQVnGs8t4tLeil7x4xndGUzvgpEb2EcXAe6k6eL5jKGgL23ezIFoiKCwx9xsLA6INSnyKs0ZAd6bVn2bkadmRNuv6HfukfZEMAlxxS075yYgQrJGnsTGGoIIKFUTX595+rEN9hFPNMrM15NNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731654978; c=relaxed/simple;
	bh=/BFAzfbNwNggHRas2O0NhAg3XSMOblIbua33XQGyfkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2WDygNK0G+iEyZZrMMBHqy0IXVnJlW/NQbUaREqxoN+5bR9pD+awNZlacV+gGntZTypvrcV4mW3nKChmvLrtlBIy1hBYwMevaC6weRLX/UGxRGRg+4fGEK577F+bnVOP0JXjSJWNb7CBPgIur6i51wyA0qdQbW43Z8/7ASonaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yvB6UEgy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7240fa50694so375750b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 23:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731654976; x=1732259776; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LiTwGr+7x8eq6OawzeIifFURDeSsU/2WLtRWg3Kwch8=;
        b=yvB6UEgy27lmSHNaw+JuHQhhvR0bbgF7exeXNK2Hc2MPJilqLYsqidJKKtdLjd1yGh
         xErbOzYFNW6ANFC2pG9XXlTcAQ0yXNblgNgu2IVVPkw3I3d2dG0j/kWm7vGJyJYpZmRQ
         CgnDDeJ507DqIiUW+nEOBwSClW3WQqPlXfVMfk2Nldz7nejSuNxtRvbeQGzEqROXpsIY
         rSi2MxFsgVHdzniAXVeaQE/kvjBezzzpmC1Ikq/eGjVhpbJb+/8nIxb6OrNq5lGPLMJo
         WFp81mVnf7WQZqpsMkovHVuFgrP6QWsgiziAKz/EKcdaamY7/cvOxAx7Mme4dUihknXw
         UhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731654976; x=1732259776;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiTwGr+7x8eq6OawzeIifFURDeSsU/2WLtRWg3Kwch8=;
        b=KZh0H23iBv/Lt7Abr5I8zlshLoiOEHF4QYiZW3TqUIMBelfH0yecDjoKeGyuleY2BW
         SLPfESJgQF0xjPRMi5hZ388yj9S102J4cNJHfxscQb2fQhOmi5BENtwMoCKWytK+Ue+7
         Xj0KfgdDnzFBNQqqfGnoWQ73QI3+d5B1LG8RQULTevIqLkickOqrGlpMPmf2BXyKQibX
         RmchRubTbnclN3cihxXgrWSOC3bC1hb7Nuebb7O1anny7U3JyEJeVOYkp0xpEry5Jbqc
         bd8bO3swpCG01V+4JKyWGJofCzdjXM9s7n4Cj37HLcle3vgd4QLe8NCWMcR4kqRPZV5X
         4kLg==
X-Forwarded-Encrypted: i=1; AJvYcCWOV0nPzt7JZWXzWBb/sC8ed/azSYSOy98nECLGhla/1d67WJxZOCRycbmRSgD27JD0W5mnoyuFSJWHNw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg8N9RfFotMMWYEvtsnjqFPednTBlEe6XQZAHUOTIIumWTCZrC
	kGEmhrsgGDZ00ucsU4dI4NvnJ3I/mHGozwPX6Wg95wJQ6v5iaAqZu/BFXaKqig==
X-Google-Smtp-Source: AGHT+IFUGFVKPN4BKyWiSKTekpGzXkV6s3Ozr7ZGuoQIwQMzFc7uRDlF/nAJCTwPmnCNLPy5shFpNg==
X-Received: by 2002:a05:6a00:c91:b0:71e:693c:107c with SMTP id d2e1a72fcca58-72476baf03bmr2003025b3a.11.1731654975730;
        Thu, 14 Nov 2024 23:16:15 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee9dfsm718640b3a.9.2024.11.14.23.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:16:15 -0800 (PST)
Date: Fri, 15 Nov 2024 12:46:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, shawnguo@kernel.org, frank.li@nxp.com,
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Message-ID: <20241115071605.qwy4hfqmrnaknokl@thinkpad>
References: <20241101070610.1267391-1-hongxing.zhu@nxp.com>
 <20241101070610.1267391-11-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241101070610.1267391-11-hongxing.zhu@nxp.com>

On Fri, Nov 01, 2024 at 03:06:10PM +0800, Richard Zhu wrote:
> Add ref clock for i.MX95 PCIe here, when the internal PLL is used as
> PCIe reference clock.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
> index 03661e76550f..5cb504b5f851 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1473,6 +1473,14 @@ smmu: iommu@490d0000 {
>  			};
>  		};
>  
> +		hsio_blk_ctl: syscon@4c0100c0 {
> +			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
> +			reg = <0x0 0x4c0100c0 0x0 0x4>;
> +			#clock-cells = <1>;
> +			clocks = <&dummy>;

What does this 'dummy' clock do? Looks like it doesn't have a frequency at all.
Is bootloader updating it? But the name looks wierd.

- Mani

> +			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
> +		};
> +
>  		pcie0: pcie@4c300000 {
>  			compatible = "fsl,imx95-pcie";
>  			reg = <0 0x4c300000 0 0x10000>,
> @@ -1500,8 +1508,9 @@ pcie0: pcie@4c300000 {
>  			clocks = <&scmi_clk IMX95_CLK_HSIO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> @@ -1528,8 +1537,9 @@ pcie0_ep: pcie-ep@4c300000 {
>  			clocks = <&scmi_clk IMX95_CLK_HSIO>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
> -				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
> +				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
> +				 <&hsio_blk_ctl 0>;
> +			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
>  			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
>  					 <&scmi_clk IMX95_CLK_HSIOPLL>,
>  					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்


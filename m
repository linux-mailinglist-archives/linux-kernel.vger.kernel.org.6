Return-Path: <linux-kernel+bounces-422318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F79D97E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7A20B27CAE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707A61D4613;
	Tue, 26 Nov 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tUZNBKqo"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FE21D4340
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625785; cv=none; b=fm6nbZ71pV3MQLhaeX8IV8M53F88fsVumfxV4GrfE2L/65qpCxbR89LVCrxJSlGPX4ibJqoJn1QR48ED4jYjxa1oJmDJ9hCPm11qgvDLHazwjDXmocqOam09+Hb5JDf7DH3JpE2fuOmsMj8ZuPIuVLnjNM5dcT3pi8OPkE4IJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625785; c=relaxed/simple;
	bh=TfjTGWQaDFmp9+wS6+9ipI5j9jCprYMO03bsaV8msQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fArYyvnd48PSrfqbngv/lTvGfudNJijdgdE6G1nBYb3QRz0ncABHIH6rgJgfUBNWwzZHwcrQIEPaX8eHtRjNcWWcnqJ3GVWW+YeouHQat6vtTGbd+THlBPJDkE+THgqqZ028FvWdfcJ8dFM2YZE+E7+lugNEuf/f780Sud2MQKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tUZNBKqo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21269c8df64so56754135ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 04:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732625783; x=1733230583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YY215mVBF/BsyIyjPcQ5YdAmE/7mcXahP/kNz5RyMwA=;
        b=tUZNBKqoYN5o9F2YcDoN5qwCVmv5Leka0vhz1kNI1bZLv13ecMRELbhRCZZ3XUi/jp
         HUqytxkeMOtxdO801G1fYdEC1Auy8x9BMlbqp/uCMBbPAjwl/c1iFDdypFHUTvJhRbAD
         6uNSTiUfOCRGL2lL0eoymokAJTVataOZvUSg3XfdtCNxN3wzi+foKhfzG5ZG5yI33Lpj
         Y6g08Lc1PQ4NpwAH41U0qLfDAN+evzz+rrGfi+CoZw8X94/j52kwKh3R1TRxgI2ryfzb
         bJkyTo1vURXOJew30cq87YH1R8usbHFAu+bsmzDDypXFjxshJX8Bb1rsJwnsNfyy7gQ5
         5MWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732625783; x=1733230583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YY215mVBF/BsyIyjPcQ5YdAmE/7mcXahP/kNz5RyMwA=;
        b=Sb7tB0JR3LJxWOsfNH0g7OU9RXa/HVtOhA6p6FiNQw0DIpmT5NHrRQr7aqSnCXU/sE
         Rw9sv/E9dSuBeqUfy90fyus7fovLVfXDmEUgTbwPf2iYICCtw87xaL0PFL7FaC8/6Ljl
         bvRmzU+lhmVyirfR2yuZGtCuTqsw01lcRGduDPIgnU5b31uaAlf7GLj5m+uhqMc6vvb2
         OCAwAHw0CzGbahMOD9vc4mpFw26ypWpl5XtaMnwLq6agJoyluxC/LJC4XoC0xRkxtXFO
         9B4/xuYm9pPtNU2qCQWi09NmtE8EB5vFBKP7jpg4c2zgshVMm4cyWwGsINtFB/zJuHWO
         Fr/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEcmrckyrKyzVD0NVvLCWmXpfl1wk5Gn8aaqlFGsGU9rWcdLCJWTFblchb8KODPK/2LcHry2HzzGc8Q3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS7IfH6s57ZbyXigvzDLzq0IOnK7tDKqJrxS6gDhcjmW90ivVA
	UB5h9zXLFMIyaffAZSaY1q3hyJVYygTIIsJWxApTdXOTctyp3an2IyTta0ohbw==
X-Gm-Gg: ASbGnctTyOU87io8kf7BHkXCTUwnoB7XzU9+kNE8/pEWd28Gbn+QAaunqNbLCuKQgYN
	PIYv5IUu/4V9BK/EDuH2nkl5BoiUFOBgsuiCQPxA9n92eil+USAgC8fVXwFK2on3ZVzDfcY1q6u
	wH3xHqAfQKPfc1WNvXhqg+XH/xNRVT+jI/HyiFdhoFDKh2ipHuMbw+io5M726ha1gafTJ5La5Il
	d7tEgcwMnCLI4wWGlM5SQcVVNsW/ZUO2vcLCp69ypiyhqoOEfhexgm+JlGt
X-Google-Smtp-Source: AGHT+IFGZO6YwIydzhnaKn6anetOGg2+48yG+FxdkhfkcKfSo66F6npaVl3d/51tMhwslnENrkjuQA==
X-Received: by 2002:a17:902:fc4f:b0:20c:9821:69af with SMTP id d9443c01a7336-2129f797977mr204224095ad.45.1732625783658;
        Tue, 26 Nov 2024 04:56:23 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc2210dsm83601765ad.245.2024.11.26.04.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 04:56:23 -0800 (PST)
Date: Tue, 26 Nov 2024 18:26:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <20241126125618.v7spvqvm4cdqpa5g@thinkpad>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:51AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 01ac3769ffa62ffb83c5c51878e2823e1982eb67..f394fadf11f9ac1f781d31f514946bd5060fa56f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -2233,7 +2233,8 @@ pcie0: pcie@1c00000 {
>  				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -2241,7 +2242,8 @@ pcie0: pcie@1c00000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  
>  			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
>  				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> @@ -2365,7 +2367,8 @@ pcie1: pcie@1c08000 {
>  				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
> -				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
> +				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "msi0",
>  					  "msi1",
>  					  "msi2",
> @@ -2373,7 +2376,8 @@ pcie1: pcie@1c08000 {
>  					  "msi4",
>  					  "msi5",
>  					  "msi6",
> -					  "msi7";
> +					  "msi7",
> +					  "global";
>  
>  			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
>  				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்


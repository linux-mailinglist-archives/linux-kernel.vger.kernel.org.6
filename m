Return-Path: <linux-kernel+bounces-359432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BDA998CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B2F7B35AA7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17001CC886;
	Thu, 10 Oct 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="criQrlcX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B15E1CBEBB
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728573801; cv=none; b=ZdEtKo1IuMaSXiX57y0Fx7dQRo9CeYU0NHEYsviZhRxlMPhdU0G9lgpp1/ddq4C7ncskwZT1NPHb8Zj0GKZyWIRSp1lkEj7E3u6/YnIQa49i5CBBucCtAJt8dQ5P2GDMTm4h1zcwDtSW2Qr68TCJNcluSWLAPbsAFr3LMsE3baE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728573801; c=relaxed/simple;
	bh=DRKgFKv94g5YAPgj5pxf8fO74OXv4fm6MAmTKKGF5e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCUCNepEcrJ+wbNGTsUaguQW5++5+nu7XtV1efnbhsX7jPFAsOQHh6oZ/egjVMMbURKwSrcj979/BC1qKPPvGhIlvQctf3toux9DBOYaKjdYuRSfNLOkXdsilTGYT9hhp+mdXkjMmnQO26JS6f464fMV0G782tomewZLWm50Zcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=criQrlcX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso10700911fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 08:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728573798; x=1729178598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OOD5DwUqAaTqFWYMU+ma6xf+DD2ITHdyJRhnL7XRons=;
        b=criQrlcXTyAuof5P2YjJh2oWbV9d0zSu2l+BCOlgWrLlRyhvsaROAub/XmREJv1mG3
         /lYRxI+3ntgiOIi2Rp3cdv2ISfNchhSJAdb6yVfNC4otH5xB8Y1Uppwc/LfSnqNdKy+c
         dHNSVkI6gUsZpTMpXW0FjaDOfU7dZrSrPGVQI0D3xJd1tyOmKXPtN5MS9WV5sJgE/ofs
         8wQd6lTLAVQcPU/qWd54T3787fqlaCSj7jhcvwKPxiVrHyCXIqZPTEkZO/KiI0kRSRrg
         xqENiUFnif9wiKJUPpjWUArXMk1jreCKELo9+wsTEG4PXr/jPuT60eTQ7sMhSP7AWYUw
         TG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728573798; x=1729178598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOD5DwUqAaTqFWYMU+ma6xf+DD2ITHdyJRhnL7XRons=;
        b=eJomEWR1KScmn/qjBCGjMBIxYBVJHL3lfAPa9eW0CRymIUhTr43Yo8lgVFbgNIk01R
         RbCgg6x0JoqOqPVQaGlGqxWvhArI3LebMbo/teH9xvRiUDLPEGjJfg89urzGKwRI+4K5
         D4QzC0CzVbKnR93RDAApCsEhGxAl19xqvro6BjN9AL3YU/hHFpBubROEFISl6KmMfBee
         lMJ/CVxPqJyPGYwQUrDQhsXa91GgBBFv6qxbx0IT3onQ8z/2EKDdxWLMxgyP+hxs5HLk
         VlFdKZcy6LC7TYlMoXsGiBvGoWjs5hBhkm1IM5dNP64BhxcG/tqmvcyPiuC2xetj1lSd
         HOjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXyOJ6uH5I6OxdJb93qseJk+BzK+INYYTr6qkfBXk7GevFk1S2Cv0aQ4NPjC9xu954OuR6XK7IFmwKUhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpszikEclZ1SRqM7HRdVKWZSo1HA9jBF7zHSH1kW9KSqcctT/P
	V8cx3C5cdGeG2kyulRj9Jc0//6y04k7cvULTIPA9A5teZee7f8ZZlzF3wdvvzzo=
X-Google-Smtp-Source: AGHT+IEa5hpavgqgZqGFwEHuAsxoJBx3cVv/1siI/qnLJ973fo+Si2V4A3zYjPXD22esXxAAbTEQUg==
X-Received: by 2002:a05:651c:1992:b0:2f5:2ba:2c99 with SMTP id 38308e7fff4ca-2fb187121d1mr44544341fa.9.1728573797764;
        Thu, 10 Oct 2024 08:23:17 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2470646dsm2329581fa.85.2024.10.10.08.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 08:23:16 -0700 (PDT)
Date: Thu, 10 Oct 2024 18:23:13 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jianhua Lu <lujianhua000@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ath11k@lists.infradead.org
Subject: Re: [PATCH v3 2/3] arm64: dts: qcom: sm8250-xiaomi-elish: Add wifi
 node
Message-ID: <pbsooimr6l65hgyxezyp6ha3zqibgdlphmeb7vtghgy2wti66b@fsmptbss2zvi>
References: <20241010072243.10227-1-lujianhua000@gmail.com>
 <20241010072243.10227-2-lujianhua000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010072243.10227-2-lujianhua000@gmail.com>

On Thu, Oct 10, 2024 at 03:22:42PM GMT, Jianhua Lu wrote:
> Add wifi node and this wifi module is connected to PCIe port.
> The following is qca6390 probe message:
>   ath11k_pci 0000:01:00.0: Adding to iommu group 12
>   ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
>   ath11k_pci 0000:01:00.0: enabling device (0000 -> 0002)
>   ath11k_pci 0000:01:00.0: MSI vectors: 32
>   ath11k_pci 0000:01:00.0: qca6390 hw2.0
>   ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0xff soc_id 0xffffffff
>   ath11k_pci 0000:01:00.0: fw_version 0x10121492 fw_build_timestamp 2021-11-04 11:23 fw_build_id
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> changes in v3:
> 1. fix commit message typo (pice -> PCIe).
> 
> changes in v2:
> 1. add qcom,ath11k-calibration-variant property.
> 
>  .../dts/qcom/sm8250-xiaomi-elish-common.dtsi  | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> index ebea283f56ea..7a55e271c3ac 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
> @@ -680,6 +680,25 @@ &pcie0_phy {
>  	status = "okay";
>  };
>  
> +&pcieport0 {
> +	wifi@0 {
> +		compatible = "pci17cb,1101";
> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
> +
> +		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> +		vddaon-supply = <&vreg_pmu_aon_0p59>;
> +		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> +		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> +		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> +		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> +		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
> +		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> +		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> +
> +		qcom,ath11k-calibration-variant = "Xiaomi_Pad_5Pro";

Let's wait for Kalle's response.

Nevertheless,


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


> +	};
> +};
> +
>  &pm8150_gpios {
>  	vol_up_n: vol-up-n-state {
>  		pins = "gpio6";
> -- 
> 2.46.1
> 

-- 
With best wishes
Dmitry


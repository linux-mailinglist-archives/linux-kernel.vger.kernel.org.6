Return-Path: <linux-kernel+bounces-352578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 380FB9920FA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EA7F1F21083
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84F18B46D;
	Sun,  6 Oct 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uV7/reSG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004518A933
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244633; cv=none; b=uwHMLZ6NyycB3B/e9PUcif5E39QtC0XFZdNaO/6/qE45XAM5ieFngV7HlCPsHBnIyn/cND+YktKjmqUvRAus/gM3fK5oXvb7e70hTeNZ1gF89Ysg2PmHc6LzS39RqFjQf2fNLpzlRDfC4n4lwxrKqvd2wiMVHVqtFEYlgF8Abdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244633; c=relaxed/simple;
	bh=8DRimgxNdtIN/4mLZTCZmneY+Dw4q4NdRx1t1mJgnzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT7Q1NvkHstx1VWm0v9stdP4+j6FijShyC63sTtFOUmvZOm7xQr2xA1C6MpBiEBYsHIEQudQGlOEgFzXH9S4vlHEI7fW8AY/Q02mKR0V95L7qwXs4wQM/zVt1ZtNriVij64jYZIdRS3rc7tziAtL7imUF4yOy+mSeIFIuKSQw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uV7/reSG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e4ae9efso3915213e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728244630; x=1728849430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EYkwmsJ0j71axhzqGqfqxybrMCFv/QSQ7yFzGdI7k5g=;
        b=uV7/reSGenw/zmNiAIw+PNmkjmN+iGiBR5+CZ+E1zOe+ZRwy2ISt/bEzdGPipJUsAE
         uUfV8sv0Dd5zYMth7Eq0ViVoWl6a0CtegCgMyTKVCX0eNfIu/3cE4A/JOAhZUKs4iQFS
         dqJiAXKcwmOeQA2JgsWND7KTzBMWB2g1ce0VDXRcnQ9TnR0LCslOrc2KSzCvrVPgwa+h
         ZzZFNwcXJerisjd3cdNP/+6+CpXhgMge4F0dptbTBbXyrOeqqnfjfEHDLX2NuTxFVT3X
         ybW04bY8l5arqQiGKDdmKbs2MAQ4QYcQdjKTaBoHnGen79lO8Vnixt4DjwTr/E0enwgM
         iTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728244630; x=1728849430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYkwmsJ0j71axhzqGqfqxybrMCFv/QSQ7yFzGdI7k5g=;
        b=GasbdQrSeKWef1GNARdn4CRRWCNqrCj6VZnbrNdhLkix5tModRKnwZSqdf6WqzK5ZQ
         EEBp0XTd/UbPvr2jbq0zo97LFd/j4OCItYx9+bi5v+uVV2F+JTKdFF3D5SqWLmecpKK0
         qT0yEsRmyVys1dD4yB4hBE8toB6EzFfgoGkdLxZXhi8yJ2v9jSuIBHcYKb4mg2B2uDPb
         VLsnl5T+PgL107gpDkEADtB2uFLBH2mUHmtDO+PcsOuAlR8ezwDrIxK7zFWL2NZZRdh0
         hzpucm3c3X1nH9HBjGmtKEG/3zJ1g+RMxzcd5f2UHBBKxjWVn10O6fuqTvSUXGCOFdJ9
         qhgA==
X-Forwarded-Encrypted: i=1; AJvYcCWIno7vWtKARTi8TlFeRtLBWKNWh6JhQFFXZ7Oc8+y5r2GYTbZYjCHpWNfEUC+WFB1W4mgaKk2K0GOqLWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQtQf+B0sNTFMy2Vpxi98wn7rejlU4pl+AeOm8FI5j29ZSDCy
	ClSCoRRpqOgYyPj+jM9Ro0ZSCOXoDtU56O08Igg9ZrNMaV8zvMXUnzHTX0h7Yic=
X-Google-Smtp-Source: AGHT+IEaZomuBq7Db8qwiwk66Sa/zOtXnytt8AXtk0jinDih3wlSM8ujA/YCpXqnUb5Xlr2h2Msu0w==
X-Received: by 2002:a05:6512:b94:b0:539:8f4d:a7c9 with SMTP id 2adb3069b0e04-539ab9de2fcmr4730504e87.41.1728244629570;
        Sun, 06 Oct 2024 12:57:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec124esm597079e87.1.2024.10.06.12.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:57:08 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:57:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: x1e80100: Switch PCIe 6a to 4 lanes
 mode
Message-ID: <lxojjl6pm6yyblbaa3rczomczo7uqn76coai6a7gg6aehflq2j@4w5b7oegrc6p>
References: <20241004-x1e80100-dts-fixes-pcie6a-v2-1-3af9ff7a5a71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-x1e80100-dts-fixes-pcie6a-v2-1-3af9ff7a5a71@linaro.org>

On Fri, Oct 04, 2024 at 12:06:33PM GMT, Abel Vesa wrote:
> The PCIe 6a controller and PHY can be configured in 4-lanes mode or
> 2-lanes mode. For 4-lanes mode, it fetches the lanes provided by PCIe 6b.
> For 2-lanes mode, PCIe 6a uses 2 lanes and then PCIe 6b uses the other 2
> lanes. Configure it in 4-lane mode and then each board can configure it
> depending on the design. Both the QCP and CRD boards, currently upstream,
> use PCIe 6a for NVMe in 4-lane mode. Mark the controller as 4-lane as
> well. This is the last change needed in order to support NVMe with Gen4
> 4-lanes on all existing X Elite boards.

What about other X1E80100 devices supported upstream? Do they also use
this controller in 4 lane mode?

> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Re-worded the commit message according to Johan's suggestions
> - Dropped the clocks changes.
> - Dropped the fixes tag as this relies on the Gen4 4-lanes stability
>   patchset which has been only merged in 6.12, so backporting this patch
>   would break NVMe support for all platforms.
> - Link to v1: https://lore.kernel.org/r/20240531-x1e80100-dts-fixes-pcie6a-v1-2-1573ebcae1e8@linaro.org
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index a36076e3c56b5b8815eb41ec55e2e1e5bd878201..4ec712cb7a26d8fe434631cf15949524fd22c7d9 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -2931,7 +2931,7 @@ pcie6a: pci@1bf8000 {
>  			dma-coherent;
>  
>  			linux,pci-domain = <6>;
> -			num-lanes = <2>;
> +			num-lanes = <4>;
>  
>  			interrupts = <GIC_SPI 773 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 774 IRQ_TYPE_LEVEL_HIGH>,
> @@ -2997,8 +2997,9 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
>  		};
>  
>  		pcie6a_phy: phy@1bfc000 {
> -			compatible = "qcom,x1e80100-qmp-gen4x2-pcie-phy";
> -			reg = <0 0x01bfc000 0 0x2000>;
> +			compatible = "qcom,x1e80100-qmp-gen4x4-pcie-phy";

Oh...

> +			reg = <0 0x01bfc000 0 0x2000>,
> +			      <0 0x01bfe000 0 0x2000>;
>  
>  			clocks = <&gcc GCC_PCIE_6A_PHY_AUX_CLK>,
>  				 <&gcc GCC_PCIE_6A_CFG_AHB_CLK>,
> @@ -3021,6 +3022,8 @@ pcie6a_phy: phy@1bfc000 {
>  
>  			power-domains = <&gcc GCC_PCIE_6_PHY_GDSC>;
>  
> +			qcom,4ln-config-sel = <&tcsr 0x1a000 0>;
> +
>  			#clock-cells = <0>;
>  			clock-output-names = "pcie6a_pipe_clk";
>  
> 
> ---
> base-commit: c02d24a5af66a9806922391493205a344749f2c4
> change-id: 20241003-x1e80100-dts-fixes-pcie6a-b9f1171e8d5b
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
With best wishes
Dmitry


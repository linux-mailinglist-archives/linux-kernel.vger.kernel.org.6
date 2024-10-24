Return-Path: <linux-kernel+bounces-380633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E59AF3E2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 22:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806961F21D09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D6218312;
	Thu, 24 Oct 2024 20:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xw/MjzwT"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F52170D9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729802553; cv=none; b=aKPCsguMT9w/mgEZWrZsLd9POw4wm2ANYMyx4F6xn2kAwz/xkK9LIiKh9sVUH3pOYJxJWiFHlBqL6QasymMjpyUKt/EB4Rw+bKel48YE2nnquVuL9t1KYaybWiykP6PfLf3Q7adi1d02tMgI/aVdPVr1a9bi0Hv+MwiNpfir6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729802553; c=relaxed/simple;
	bh=a4gTfnCJi732yoDCqTQUqO4Mk7Pmo1OqSE6yXObwo7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ9AaHce5tDMWXxd/neGVAV/J7+DTkOzkdQWVIVEeThMQTGqO8yxl5pSu4Vegbd0ZgPhgn+H0lSudzJj0o3TmhqNRliucX3VWP2G/Np1CJVwwkITUXppeq2YMQWoRQDSvpWMNWTn+GDC0875hML/SRtYsojvF/OasY2k6E58HDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xw/MjzwT; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e13375d3so1627659e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729802549; x=1730407349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EiRse2pWkVFItuZf5sRm9MGvUV4h+zSWNVGTjIlgHco=;
        b=xw/MjzwTSncxWnhUzuIV/vx/NQ5zTACcFHjohVBU+iDRFh+rHNGtks59S1dp0a4p82
         dg6ntuQQsaH/POBjGOLSEO3lOtQDOLXYSRKmSefAAKkBAJz0dzlsxa2MtNZwew7BYhoF
         0kVnCmqv++H7hQI86BNQi5U/xHQXA64PEs65Sar4ef+FwvQw38Jtsd5vvsp35weDU01h
         l5wHCLFq05b3v/rCvJuIE3jbc4fkwMhdq3eHYgaSIFsre++e5HOnHUsI6gbfgrgy3E/7
         h/dirgpefgI+X8kEN3n4UC+N+EJPtcz1mkcRxL4UYZgd9LaKakgRLU1MxrC3QvcW2VwE
         bJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729802549; x=1730407349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiRse2pWkVFItuZf5sRm9MGvUV4h+zSWNVGTjIlgHco=;
        b=F58jw3Ea17QGuPLkzKVDlQLrhaIMqZLOuRxZ9S1G/b+6ERTIAfRjNO8RX+K/AyvDU/
         3VksJYQKx4h3hLQGZONu81InlcA7ysVOHF8IW5OJZgNQ/850V8GLLC+3PZ0j41IzoPW3
         Ew3wdSQvaCMwdcGVhnXr2OXWnKMsVte9nUP12cGNbqX68IRj0Freq7ZIvQLZGVfBfTbg
         NSCjcSh7E1vqEY6d7UsZusrspFWSinQATwKEVljT7nicv5kbgPb17tM7rVfcVS4rdmuP
         uEuQ5KR3/wCbM29Eoj1ZDUOHdGIvTw/o9TQsLu/b02vbweEakxTRmOS14Vy9dxoKmBYh
         S9qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+sW5Ws6mrMIzA9i2HenFz0P6JqrGFpmCovdIHxKujbz0U1QQaCzYwx0n8qj/s7npe8vKTPgdGDH7BWy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJjmMN5FsR0iyCxx56OEq980p2RjrhDqx4Wx1AiZjAPL4V9RY
	lz0IKuMcrDyr8mH/npuVtlWR7IzBS0b1W1u6ZyX3GpXHX4LLBRGNsO5YCcwECyg=
X-Google-Smtp-Source: AGHT+IGeFHoQQweBzqV0wKkNtdHWmKUzLDRu4ioeHEAp3OSo3ZTq8jbUi/HBFWlMN4UDv0+wbg+SFg==
X-Received: by 2002:a05:6512:1594:b0:533:4689:973c with SMTP id 2adb3069b0e04-53b1a33312amr4232769e87.23.1729802548636;
        Thu, 24 Oct 2024 13:42:28 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223e599esm1468652e87.49.2024.10.24.13.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 13:42:27 -0700 (PDT)
Date: Thu, 24 Oct 2024 23:42:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Yuanjie Yang <quic_yuanjiey@quicinc.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, bhupesh.sharma@linaro.org, andersson@kernel.org, 
	konradybcio@kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: qcs615: add SD and emmc node
Message-ID: <xfy335jzh5t5a7fdrjfswerjdze3vaybf7rvkxnae3cv3xaii7@rn7iqwga2p62>
References: <20241023092708.604195-1-quic_yuanjiey@quicinc.com>
 <20241023092708.604195-3-quic_yuanjiey@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023092708.604195-3-quic_yuanjiey@quicinc.com>

On Wed, Oct 23, 2024 at 05:27:07PM +0800, Yuanjie Yang wrote:
> Add SD and emmc support to the QCS615 Ride platform. The SD controller
> and emmc controller of QCS615 are derived from SM6115. Include the
> relevant binding documents accordingly. Additionally, configure
> emmc-related and SD-related opp, power, and interconnect settings
> in the device tree.
> 
> Signed-off-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 198 +++++++++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index fcba83fca7cf..3840edf13fe8 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -399,6 +399,65 @@ qfprom: efuse@780000 {
>  			#size-cells = <1>;
>  		};
>  
> +		sdhc_1: mmc@7c4000 {
> +			compatible = "qcom,qcs615-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0 0x7c4000 0 0x1000>,
> +			      <0 0x7c5000 0 0x1000>;

 <0x0 0x007c4000 0x0 0x1000> (this applies to all address nodes, so
 sdhc_2 too.


> +			reg-names = "hc",
> +				    "cqhci";
> +
> +			interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 644 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq",
> +					  "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&rpmhcc RPMH_CXO_CLK>,
> +				 <&gcc GCC_SDCC1_ICE_CORE_CLK>;
> +			clock-names = "iface",
> +				      "core",
> +				      "xo",
> +				      "ice";
> +
> +			resets = <&gcc GCC_SDCC1_BCR>;
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +			iommus = <&apps_smmu 0x02c0 0x0>;
> +			interconnects = <&aggre1_noc MASTER_SDCC_1 QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
> +					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &config_noc SLAVE_SDCC_1 QCOM_ICC_TAG_ALWAYS>;
> +			interconnect-names = "sdhc-ddr",
> +					     "cpu-sdhc";
> +
> +			bus-width = <8>;
> +			qcom,dll-config = <0x000f642c>;
> +			qcom,ddr-config = <0x80040868>;
> +			supports-cqe;
> +			dma-coherent;
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			mmc-hs400-enhanced-strobe;

Are these board properties or SoC properties?

> +			status = "disabled";
> +

-- 
With best wishes
Dmitry


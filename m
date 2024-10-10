Return-Path: <linux-kernel+bounces-359260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8AB998978
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C82A1C24B88
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804DC1CC15B;
	Thu, 10 Oct 2024 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UDy+P/gm"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1405C1CB511
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570170; cv=none; b=LILrhEOWWUtdD90WEfmD8GztsawZAZRtWGu12cBT61D++AcTIxIMJCFInoYoR4erbPmorkglDfWJdSPoBP7QlvRSXRhnmEIgBQ0blRvC2d8UrNgO9gP8CZBXEc9fNXeoBnEmbAhf2YDaCe0oeGYIX3VF/Y0xEe6dBf3YyLF1iU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570170; c=relaxed/simple;
	bh=pc8gV4huGZDoUca8YffQfxAWHm148iLaPYTVWk1l2jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgXK3ruPCNitDywlTxiiBu49U1I4RR0fz7IXCFNmyUlgwOUvXuoxGGMm85VqcN5ZMrK+Hf+h5yip+FFSg5fUoMjScbW3kehFoTYXKBZ4WnRknbcwq8DEovpdAJiqRpfqvDU5dxJX4dn0s+nw9bjqyIuy0zP9lp2UA4wBuhDZohw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UDy+P/gm; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fac787f39fso10600801fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728570167; x=1729174967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9AJcZVNqCADPxVrB/UoMC81RGbypBJxweSdqf11Fz4=;
        b=UDy+P/gmM3DlA9/uyy+ivLTEbKxgexXSBHV3yKb8r0nZjcOFsz0rj4jA+pAJAPskYD
         U3bOLH+N913gviSD0KOZXH9AnBISVxaKRs3daqwBRJLuZ+q4U9Dwo1sYTLkn1GMkQdtl
         B4ze5wsciOOLXMECnyNcqMBOLPHpi2+1zLPfyL7au3Dz4DOTK385WRAVPvQE34OLgizp
         Rr/LTUpUzCN5jzvPKdXgFvNAfG9y252bnc8yJYmlN10LMM69sCV+s7eBfmWoi2L4jtif
         5qmZNYK+sMvK1mFIVrGMA2FG4CzA/v/YlI/aCC51gHPy4GK7s+SBqDFIuKSLO2AxbFZN
         6nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570167; x=1729174967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9AJcZVNqCADPxVrB/UoMC81RGbypBJxweSdqf11Fz4=;
        b=NaLTThvapmVA3Ukd6+nFEfttNtFsmzDHPjrVx0osCOI0eLOU4yHMT/pxJEAoF141NN
         8nu0w1xYhon4kXCN57mGZT2xzL2lIjVoRc2kQRY0s/ru23sZWWZiJmOBvZdN+JbJMZYT
         Ms4s48GunpnBkupL5Uoa4HLxlI1opH9M5MnT4HZ/Qsb40V0z2e2EoCOBDkBqE62jou/Q
         28oM01zAIoYz/LebDXahUVi/thDlUfoScZGsTSlPKdeWkjn9pzKSRt/fEq25BsMBb7Cd
         /hvtgcDTCatmtMB2b5uUFQAfH/Ava7V2B5qalKgHaGkF8gNSZTrl1zitiLIn0lVVBmvR
         ZxMw==
X-Forwarded-Encrypted: i=1; AJvYcCWs+C4B0wQbtG4njGFX4Xmuc8OwcDGAyL1s4ZR4KdzXWk+7nWJSskPMJGEGIeEv2AHdakuCEA3DEZi24Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu/pS+rcNpWYZ79JD/MHWf/K8nubij5QbaKg/jlCr3uKLc4BjW
	E3PO90mFG/5FhOVdRZ0uzsQ2LvzB0WIFLjGjvK9PDC4db6rh4UpaQaak0M/GhdU=
X-Google-Smtp-Source: AGHT+IF6rZ3MD8nH2vuXY8H2os5uX0/oGgjx49wYPUe6Dm++/RdT24HNnJYcg/TCT0rhnTNfVYjUEg==
X-Received: by 2002:a2e:b8c1:0:b0:2fa:fe0c:4967 with SMTP id 38308e7fff4ca-2fb1873e465mr41125211fa.20.1728570167037;
        Thu, 10 Oct 2024 07:22:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2474c85esm2097331fa.115.2024.10.10.07.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:22:45 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:22:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, quic_ppratap@quicinc.com, 
	quic_jackp@quicinc.com
Subject: Re: [PATCH 1/2] arm64: dts: qcom: Add support for usb nodes on
 QCS8300
Message-ID: <xwidjnw3fqc2slwl3vftw7yi4j7juiw6rwszjhtxepqd6zz33s@ncoi4aikbb4e>
References: <20241009195636.2649952-1-quic_kriskura@quicinc.com>
 <20241009195636.2649952-2-quic_kriskura@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009195636.2649952-2-quic_kriskura@quicinc.com>

On Thu, Oct 10, 2024 at 01:26:35AM GMT, Krishna Kurapati wrote:
> Add support for USB controllers on QCS8300. The second
> controller is only High Speed capable.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 165 ++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)

[...]

> +
> +		usb_2: usb@a4f8800 {
> +			compatible = "qcom,qcs8300-dwc3", "qcom,dwc3";
> +			reg = <0x0 0x0a4f8800 0x0 0x400>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_CFG_NOC_USB2_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB20_MASTER_CLK>,
> +				 <&gcc GCC_AGGRE_USB2_PRIM_AXI_CLK>,
> +				 <&gcc GCC_USB20_SLEEP_CLK>,
> +				 <&gcc GCC_USB20_MOCK_UTMI_CLK>;
> +			clock-names = "cfg_noc",
> +				      "core",
> +				      "iface",
> +				      "sleep",
> +				      "mock_utmi";
> +
> +			assigned-clocks = <&gcc GCC_USB20_MOCK_UTMI_CLK>,
> +					  <&gcc GCC_USB20_MASTER_CLK>;
> +			assigned-clock-rates = <19200000>, <120000000>;
> +
> +			interrupts-extended = <&intc GIC_SPI 444 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&intc GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>,
> +					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>,
> +					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
> +			interrupt-names = "pwr_event",
> +					  "hs_phy_irq",
> +					  "dp_hs_phy_irq",
> +					  "dm_hs_phy_irq";
> +
> +			power-domains = <&gcc GCC_USB20_PRIM_GDSC>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +
> +			resets = <&gcc GCC_USB20_PRIM_BCR>;
> +
> +			interconnects = <&aggre1_noc MASTER_USB2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_USB2 0>;
> +			interconnect-names = "usb-ddr", "apps-usb";

As this is a USB2-only host, shouldn't it also have qcom,select-utmi-as-pipe-clk ?

> +
> +			status = "disabled";
> +
> +			usb_2_dwc3: usb@a400000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x0a400000 0x0 0xe000>;
> +				interrupts = <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>;
> +				iommus = <&apps_smmu 0x20 0x0>;
> +				phys = <&usb_2_hsphy>;
> +				phy-names = "usb2-phy";
> +				snps,dis_u2_susphy_quirk;
> +				snps,dis_enblslpm_quirk;
> +			};
> +		};
>  	};
>  
>  	arch_timer: timer {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


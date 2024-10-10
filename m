Return-Path: <linux-kernel+bounces-359011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E05998645
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FA71C224EE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C771C463A;
	Thu, 10 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3NDY4lg"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1BD1BD00B
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563990; cv=none; b=Op7PqZG6GP7pKMVUwkmECwbDfA6B3i8kyZ6zqWdafvOGGjvkDn6a5vdTl5ZMgyEA1+R8l5P+QxagJT33hbbtmGXLXC0tXo2ndR4UdXHxoMsbhKXwUZNuwMqMiGGSr90VpN3b86usmxEDp+klW+Y6uFLFFNdrX14f3ea8gWNRRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563990; c=relaxed/simple;
	bh=kOTWF+30GX46M6cKu9EXkCbB9ti6bbQkmxVM29oR6Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2y+FnBpajYqG+IgyikCcGmGX+LzHyKFtLznAtbfSkfxRgFkeGngC/rMMhE0r5wp34tajhpSpySt6TTh33Bq7j+M+TOgDMStuP7EXwbVBgDpncpXp8POsFQb0zrAPGyKCljX2Dvfg75Q5Z/c2yb0DL8rNSUbBz47W3OeAFiXxe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z3NDY4lg; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2facf481587so6648641fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728563986; x=1729168786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fllGaPiFDX1GPppBwnupuskiI6YmkbaMpB+vYL9kQrY=;
        b=z3NDY4lgJdgvCjk+hqRdyxbccUMCsidlBYT+9cm5tFRsN5XCU6MQDZ4wy3xFgXaUeM
         UyS3qGhvoS9psp3Nz3i297D4WYmRXkNPxNkJl0hGdIX3pg55yiW5NTKyThGX/bLrQUjK
         M8ELcd1E+P5vgzE3RAhPseEAhVba/XmcJC/n4ewp12D2gb+aSHX55nAJaXBjYrd3gsZ1
         a5VzYu3loz/pfmwxj0T94K65hruRM/AD1x4TwYMaU7Tt2uD4hy2E6rLD1P73dVsX0fnR
         x9hOKPPFaT+ht5FNFrspabph9PX+KwoprsaFLyFB9OAc3n79rlk6nZ+mKCcSBBCrt3to
         o45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563986; x=1729168786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fllGaPiFDX1GPppBwnupuskiI6YmkbaMpB+vYL9kQrY=;
        b=lgI8U2ThrIIPKuBSWnU2JhmCMa+GCVQRqH1Al54QNE62KI33GqXDRFKZlAePwFrEfs
         4Hn6QxbcfZhT4Pyg2SMuMsTurnFmFF34rbygZEZ9l8BVAq7jH2whH+1+7NLtTb/+ycj1
         LhTIbW3H/4xBWvgbkTePI8L6zust3qujHv8KUNqEvvqiuyPwvVj/Y8Uxb9xfPI++osD3
         P6msXt5fdmTS4rYTZHCvhQ095cuhlaVWXEVZTfsxRuVNrGN08zFtIhLLmRvP/A+w0nhd
         X1fmBOwEZAl2updcNstRQc+KiAO1QAjdsTK3fMbj/Ig2Xlt7530TeI8Ii1ZAPZujYjPD
         mP2w==
X-Forwarded-Encrypted: i=1; AJvYcCUFdO68f9i06lpEEVB0fkB0+DKlcdmyEvehUEgsn9WaxcyYaiq6JPfuBdm0DtWGNAwgjmP7JPfxf89InRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQsIWLuZ0lKT80qPpXBBbpOIjZsbDdxPCWTc7JhWt+cEg5tk9V
	j/xNmzScXzAO+hCzHKQAt86jMQOfrIVptjriPliph35IjnTz8S8lGmKIM2VPEOk=
X-Google-Smtp-Source: AGHT+IHgdq/p+lygUk/bOoqHoWtGwuOMvdMrEnCkOWVXUfSpuBhUTiVlqtD/3ZNjFf4vv5FFBL3BQg==
X-Received: by 2002:a05:651c:546:b0:2fa:bba7:2699 with SMTP id 38308e7fff4ca-2fb1873e645mr37879391fa.16.1728563986046;
        Thu, 10 Oct 2024 05:39:46 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb2474d255sm1963011fa.119.2024.10.10.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:39:44 -0700 (PDT)
Date: Thu, 10 Oct 2024 15:39:41 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
Message-ID: <jywgmxfhzwvoknpar7hr4ekfnajauzgk5q3bewgpdv2ghpemtw@4vvhit4jb3tm>
References: <20241010105107.30118-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010105107.30118-1-quic_janathot@quicinc.com>

On Thu, Oct 10, 2024 at 04:21:07PM GMT, Janaki Ramaiah Thota wrote:
> Add Bluetooth and UART7 support for qcs6490-rb3gen2.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 122 ++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 0d45662b8028..c0bc44be7dd4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: BSD-3-Clause
>  /*
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  /dts-v1/;
> @@ -32,6 +32,8 @@
>  
>  	aliases {
>  		serial0 = &uart5;
> +		bluetooth0 = &bluetooth;
> +		serial1 = &uart7;
>  	};
>  
>  	chosen {
> @@ -688,6 +690,39 @@
>  	status = "okay";
>  };
>  

Please review the file carefully and find the right spot for these
parts.

> +&qup_uart7_cts {
> +	/*
> +	 * Configure a bias-bus-hold on CTS to lower power
> +	 * usage when Bluetooth is turned off. Bus hold will
> +	 * maintain a low power state regardless of whether
> +	 * the Bluetooth module drives the pin in either
> +	 * direction or leaves the pin fully unpowered.
> +	 */
> +	bias-bus-hold;
> +};
> +
> +&qup_uart7_rts {
> +	/* We'll drive RTS, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&qup_uart7_rx {
> +	/*
> +	 * Configure a pull-up on RX. This is needed to avoid
> +	 * garbage data when the TX pin of the Bluetooth module is
> +	 * in tri-state (module powered off or not driving the
> +	 * signal yet).
> +	 */
> +	bias-pull-up;
> +};
> +
> +&qup_uart7_tx {
> +	/* We'll drive TX, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
> @@ -719,12 +754,97 @@
>  &tlmm {
>  	gpio-reserved-ranges = <32 2>, /* ADSP */
>  			       <48 4>; /* NFC */
> +	bt_en: bt-en-state {
> +		pins = "gpio85";
> +		function = "gpio";
> +		output-low;
> +		bias-disable;
> +	};
> +
> +	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
> +		pins = "gpio28";
> +		function = "gpio";
> +		/*
> +		 * Configure a bias-bus-hold on CTS to lower power
> +		 * usage when Bluetooth is turned off. Bus hold will
> +		 * maintain a low power state regardless of whether
> +		 * the Bluetooth module drives the pin in either
> +		 * direction or leaves the pin fully unpowered.
> +		 */
> +		bias-bus-hold;
> +	};
> +
> +	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
> +		pins = "gpio29";
> +		function = "gpio";
> +		/*
> +		 * Configure pull-down on RTS. As RTS is active low
> +		 * signal, pull it low to indicate the BT SoC that it
> +		 * can wakeup the system anytime from suspend state by
> +		 * pulling RX low (by sending wakeup bytes).
> +		 */
> +		bias-pull-down;
> +	};
> +
> +	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
> +		pins = "gpio31";
> +		function = "gpio";
> +		/*
> +		 * Configure a pull-up on RX. This is needed to avoid
> +		 * garbage data when the TX pin of the Bluetooth module
> +		 * is floating which may cause spurious wakeups.
> +		 */
> +		bias-pull-up;
> +	};
> +
> +	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
> +		pins = "gpio30";
> +		function = "gpio";
> +		/*
> +		 * Configure pull-up on TX when it isn't actively driven
> +		 * to prevent BT SoC from receiving garbage during sleep.
> +		 */
> +		bias-pull-up;
> +	};
> +
> +	sw_ctrl: sw-ctrl-state {
> +		pins = "gpio86";
> +		function = "gpio";
> +		bias-pull-down;
> +	};
>  };
>  
>  &uart5 {
>  	status = "okay";
>  };
>  
> +&uart7 {
> +	status = "okay";
> +	/delete-property/interrupts;
> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;

Why? Is it a UART interrupt? Or a BT-related interrupt?

> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>,
> +			<&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,wcn6750-bt";

Please use pwrseq and define the PMU unit.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_en>, <&sw_ctrl>;
> +		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
> +		vddaon-supply = <&vreg_s7b_0p972>;
> +		vddbtcxmx-supply = <&vreg_s7b_0p972>;
> +		vddrfacmn-supply = <&vreg_s7b_0p972>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p972>;
> +		vddrfa1p7-supply = <&vreg_s1b_1p872>;
> +		vddrfa1p2-supply = <&vreg_s8b_1p272>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p19>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
>  &usb_1 {
>  	status = "okay";
>  };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
With best wishes
Dmitry


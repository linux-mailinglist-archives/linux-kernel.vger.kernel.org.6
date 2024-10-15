Return-Path: <linux-kernel+bounces-366076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC8999F082
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DE1B218BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164DA1D514B;
	Tue, 15 Oct 2024 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvpjX7ln"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911FD1CBA03
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004247; cv=none; b=YaYM/jbk1uMRdDZHTmnF2clRsWddNYl+HVHT6PMCvTEwHLuyzxLjbZEQZMJZTtk8AjyTbjvBWF1/xJivqQbFFhcyT8Wq72sg3pJzQl8znTxJXA9Cb/r5b4tklY0GKnXUvIryl7ICfuFMEcouAvmI1GVufgBV4jUbP4ZmkiG2AKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004247; c=relaxed/simple;
	bh=SlICqBZXrQRrlbYBRBFsm9lw6h24q5u37vave91lLI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuHT7Q20O1Wn4Q14CrAq6v0+K8EN3VifmKYj+s4kdKezcdnDOa382giJ8+SS3Alxp60Fy3R2XkZzkTBVs+RLyT/bhTpAiK2i2BK4rLTLsZqRaYINanCsAMXxR5rh2Rs0a730HSv6crB9WYNmMnRciOmkZOXDamIRwFavbWx7/wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fvpjX7ln; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-430576ff251so47949395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729004244; x=1729609044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dd/y4e5VLsv45xhA5HVGa4kwa+DBg+30cli4MtlNzRs=;
        b=fvpjX7lni4jFERnsxFhJLjlaA2tYfaisIdv2ofeLfwqm1FZ3u8xxSqHOkrTbjjdRNe
         vJCw502B0oTuVIltcLp0T/cSWSWjnZecR3f9TJhFwGnXhxiuPDI3syE5NpLvyasgKCEJ
         DGM7hWFSWCcWiWL9RiHpCVR99PyWf17grU+jAC65DpyP+JAiXrlduh2dXfrdeFvHZobF
         tZdHyt1RdI1Upmu2ImdZJfHzsu8hCGOGVgvNrMqVhoZC3qaKN/9lblSwm6zmPiqgHJ/w
         YYjfQL7tyPATZgXogZpGfRK0QLFN/OerkPE0yyxK4bxtAZsqb7sLzwJCca1dlsPMhkyd
         y5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729004244; x=1729609044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd/y4e5VLsv45xhA5HVGa4kwa+DBg+30cli4MtlNzRs=;
        b=D6Q/gAUd7De2JHsOpKT9YNzEnH77nJMPvpUTbLV916xklE4D3eBxgk6odTNl8kjpkt
         d7/f/TZWtyy+S5ZIUhBQI/RyY3cAMkMya+4RXZK8Bn14Jg+Z5wWH9pl29g6+dRtbXc6y
         knX+fMgtjpGug5AMip9jndksNP5SVc29TNjITVqnlpPV89g7hsQX6H0KknOuh3jr2v6c
         YCt+3QYwU4FfvtXYNGkIsgotXB2NsTrI4BpaH42vwmBhNA3Zq9U0WmRXOfbw252PsAe9
         hzQ/Sy+qoQxeZthQfbiWegOhkGo/ur/IfCIDwj8q8M+Y+7jUoRg1j4cLepLAK98brs6a
         I41g==
X-Forwarded-Encrypted: i=1; AJvYcCWvCLi3WHveYS7Cn9C9dzjHC12DRafbUQUYFO8xBifM6CWg9Y7p/So2TliFz3LK4z8kLEEyWSKvtzq7i/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YziV0BiHlRSQs3wOTYQpZJOzQZAYNwBm4KG2xUljg8NJzLs/fKk
	kaQSAZ65xdYRrKo85d0K3TcYk4rzFO3AGSnE1EEXygmsREfnP26Nar1+vVH1aFc=
X-Google-Smtp-Source: AGHT+IHQ7R4nBExzm5obkauib5uoXD+Q+dcoKzQHxjHFC5ayr61rq+06s4us4vX2nYJ7a6xxImhbzA==
X-Received: by 2002:a05:600c:4e46:b0:42c:b8cc:205a with SMTP id 5b1f17b1804b1-4311df5644amr149049145e9.32.1729004243748;
        Tue, 15 Oct 2024 07:57:23 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff21:ef80:d7:7e1e:c886:6f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc11aefsm1765066f8f.93.2024.10.15.07.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:57:23 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:57:18 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: x1e80100-crd: describe HID supplies
Message-ID: <Zw6CzgluMauSdl2j@linaro.org>
References: <20241015122427.15995-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015122427.15995-1-johan+linaro@kernel.org>

On Tue, Oct 15, 2024 at 02:24:27PM +0200, Johan Hovold wrote:
> Add the missing HID supplies to avoid relying on other consumers to keep
> them on.
> 
> This also avoids the following warnings on boot:
> 
> 	i2c_hid_of 0-0010: supply vdd not found, using dummy regulator
> 	i2c_hid_of 0-0010: supply vddl not found, using dummy regulator
> 	i2c_hid_of 1-0015: supply vdd not found, using dummy regulator
> 	i2c_hid_of 1-0015: supply vddl not found, using dummy regulator
> 	i2c_hid_of 1-003a: supply vdd not found, using dummy regulator
> 	i2c_hid_of 1-003a: supply vddl not found, using dummy regulator
> 
> Note that VREG_MISC_3P3 is also used for things like the fingerprint
> reader which are not yet fully described so mark the regulator as always
> on for now.
> 
> Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 34 +++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> index 10b28d870f08..4ab7078f76e0 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
> @@ -288,6 +288,23 @@ vreg_edp_3p3: regulator-edp-3p3 {
>  		regulator-boot-on;
>  	};
>  
> +	vreg_misc_3p3: regulator-misc-3p3 {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_MISC_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pm8550ve_8_gpios 6 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>  	vreg_nvme: regulator-nvme {
>  		compatible = "regulator-fixed";
>  
> @@ -689,6 +706,9 @@ touchpad@15 {
>  		hid-descr-addr = <0x1>;
>  		interrupts-extended = <&tlmm 3 IRQ_TYPE_LEVEL_LOW>;
>  
> +		vdd-supply = <&vreg_misc_3p3>;
> +		vddl-supply = <&vreg_l12b_1p2>;
> +
>  		pinctrl-0 = <&tpad_default>;
>  		pinctrl-names = "default";
>  
> @@ -702,6 +722,9 @@ keyboard@3a {
>  		hid-descr-addr = <0x1>;
>  		interrupts-extended = <&tlmm 67 IRQ_TYPE_LEVEL_LOW>;
>  
> +		vdd-supply = <&vreg_misc_3p3>;
> +		vddl-supply = <&vreg_l12b_1p2>;
> +
>  		pinctrl-0 = <&kybd_default>;
>  		pinctrl-names = "default";
>  
> @@ -721,6 +744,9 @@ touchscreen@10 {
>  		hid-descr-addr = <0x1>;
>  		interrupts-extended = <&tlmm 51 IRQ_TYPE_LEVEL_LOW>;
>  
> +		vdd-supply = <&vreg_misc_3p3>;
> +		vddl-supply = <&vreg_l15b_1p8>;
> +
>  		pinctrl-0 = <&ts0_default>;
>  		pinctrl-names = "default";
>  	};
> @@ -854,6 +880,14 @@ &pcie6a_phy {
>  	status = "okay";
>  };
>  
> +&pm8550ve_8_gpios {
> +	misc_3p3_reg_en: misc-3p3-reg-en-state {
> +		pins = "gpio6";
> +		function = "normal";
> +		bias-disable;

Can we add a "power-source" here? PMIC GPIOs can be either ~3.7V
(VPH_PWR) or 1.8V, depending on which power-source is selected. Without
that, we rely on the firmware to set the voltage level for the GPIO
during boot.

I'm not sure which one would be suitable here. I guess we can just
replicate what the firmware configures during boot.

Thanks,
Stephan


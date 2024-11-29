Return-Path: <linux-kernel+bounces-422258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D13C9D96D7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E7FDB2A41A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC401D4358;
	Tue, 26 Nov 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgty/1G3"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E721D2F54
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621807; cv=none; b=D5Eeg4zV2tSZaT0xmx+dOdpYDZj5qXqd2tcv0biZOqqUgpSkwUxphFRnt/TO1E3dmWuvI8lAMd8a0cv1bnmHsi7NCxEnoc7+iWxH2dpj58vj28jrYdktT2e0c25GGaWh+aU2TnEg+n0i4u21FEAKKTN2M0wYZQjGt3CHOiuIQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621807; c=relaxed/simple;
	bh=GYAzIZYJriJDarwMYPy3fKsBjVIGPFVq3v3Ist4Cv34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coqSWh+3ZQqpwXaTCLbYv6Hka0BZLTk/YYmdufong5iVqt5gF5tTx3ZN8UfTAqpFNZfu6Hg73/4zN6NKO79gwaiu+Hfl9MKGpIgfNQihZqPRXSbdkpyrkJei4iVRpMZrF58ZzOuiknp53HvSoSq9cGxIwWj24JC7fI0+XA2r1sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fgty/1G3; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dde5262fdso3289584e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732621804; x=1733226604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqYIWnr/9c6FYDv/gsnp+xSAjuU0BBzGVs1Fhk5SJV0=;
        b=fgty/1G3+JduMg/z5XrvcG6pDVwmtIDfGUNOGd8Kjf3RZ6zbC0wu8VkV0Gjy/tcQJt
         ZxF1am5GU4QFXHKHXQ4YMs+iu9fqe6z7e0TWM3n/OEUPDb+ClLdT5TtjZDR8bXeorkne
         lLw1QxRAenMTEkBptsWaZgdkET+iwbVLwd4wZEQ1TnL9ihaosJSXE8sLcRfegmKPoWAL
         iCVN3II+CBlm5tUy0vpwIneOtFBF96UAHuSmDyEkbDABCfr4Ldx0gd1Vlqz1LkcTCFwZ
         LRDILU2bGJN7Es1R2ePeyxsL+1qP52HSP+VLrznRCsBTjGeeMkRdUmEaxlkd92Sv2wIU
         IQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732621804; x=1733226604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqYIWnr/9c6FYDv/gsnp+xSAjuU0BBzGVs1Fhk5SJV0=;
        b=JG71ZPiYE1bb+1TAUBYkc2QKQ8sa7LAIqXYN4S7MzY2UM6/bVMZKbDP9Za0V9ogFm/
         EHroXoKcvWI85tTUaYBhQdv1a+I0JUkGEaCKJY0b4IqeV/hmvChMnPOWVtuuNUpShDeU
         f4M7IhnqyxqeNFNtxJlN+TCQKYHbIsrKL7DhCDhGynRmrY3fDxzGRMxq/DeeYXVfWqcV
         TIFSRu1z0Qyw2FkJcK6CG043UOtzCSDVsHq8skq7nUwM8VT7OJXlaZvOW43LC8SFrDeW
         6z0K2KqUbQx/G/pu/Ay99VZEIejKLPNBRA40+mPUeCdYsgvBgrxh3U537G2BKuDCumbO
         p/5w==
X-Forwarded-Encrypted: i=1; AJvYcCUsSA7TnQ34UwvhVxe3GJio7+DzMkko+GaIDPuTMc8tzeUEL2Mf/xBdVNhhhq4AezFjYoAd4lH7SAKP9CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr3alrDdiOqHrphYCwf2/oaKMKfmLNxDGNphFYtxhdpxWJ590+
	eMTgkMPmTyBQ8nHdtWV7Exr9Kw7RIR0/0wuHDzSnzdvfuHqXlsue/per9EnlPGA=
X-Gm-Gg: ASbGnctgcaeVeDobcWFCE0wIDjIHordF149aud7UH2ZfHLD6H9sj8BbtlqIU5iuhvA+
	6x9gQ8Azv5/jHUVQw2OkMCuBj/BYRm+c9dDsWAef5EBiGtvxAUpr3mj0J/3noAKzSM+On0LY86Q
	ch5UKdbyqIasGfiDjIQrZZ31ysKcal0OiobIgI5uKqqlb+ndNuvZbqNY3VDOgE3gmfyHOHF0S56
	2PHsVfv5Ncv51+rpiEArcyq8UNQ5FYnEyPdryjG4aUrWX7j/TfEtTyJb/mHxWwuhccF1hDiyCvq
	YgX8vPxAN9uiOfh5X/sZj/TWty2mNQ==
X-Google-Smtp-Source: AGHT+IEwf7KXQVYfNFV+slWuA7VhV7yv3ijg8DCFUFvdFn5VXpHwrc27agE1AMv36gPa8ClDyuq3tQ==
X-Received: by 2002:a05:6512:3e1f:b0:53d:d45d:a1f3 with SMTP id 2adb3069b0e04-53dd45da218mr7996168e87.22.1732621803839;
        Tue, 26 Nov 2024 03:50:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd5d22347sm1807939e87.28.2024.11.26.03.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:50:02 -0800 (PST)
Date: Tue, 26 Nov 2024 13:50:00 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tingguo Cheng <quic_tingguoc@quicinc.com>
Cc: quic_fenglinw@quicinc.com, quic_tingweiz@quicinc.com, 
	kernel@quicinc.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qcs8300: Adds SPMI support
Message-ID: <wtnsepmoulfhm5ydbu7udtsrexaogaiqjyt737g6a2bhf4drnv@jwmktibj2swd>
References: <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-0-28af84cb86f8@quicinc.com>
 <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-1-28af84cb86f8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-adds-spmi-pmic-peripherals-for-qcs8300-v1-1-28af84cb86f8@quicinc.com>

On Tue, Nov 26, 2024 at 05:35:05PM +0800, Tingguo Cheng wrote:
> Add the SPMI bus arbiter node for QCS8300 SoC which connected
> with PMICs on QCS8300 boards.

Could you please comment, what is the version of the SPMI controller /
arbiter?

> 
> Signed-off-by: Tingguo Cheng <quic_tingguoc@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8300.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs8300.dtsi b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> index 2c35f96c3f289d5e2e57e0e30ef5e17cd1286188..03bf72d6ec5c9ec92f6f53df9253c8c5953e13c4 100644
> --- a/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs8300.dtsi
> @@ -939,6 +939,28 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  			#clock-cells = <0>;
>  		};
>  
> +		spmi_bus: spmi@c440000 {
> +			compatible = "qcom,spmi-pmic-arb";
> +			reg = <0x0 0x0c440000 0x0 0x1100>,
> +			      <0x0 0x0c600000 0x0 0x2000000>,
> +			      <0x0 0x0e600000 0x0 0x100000>,
> +			      <0x0 0x0e700000 0x0 0xa0000>,
> +			      <0x0 0x0c40a000 0x0 0x26000>;
> +			reg-names = "core",
> +				    "chnls",
> +				    "obsrvr",
> +				    "intr",
> +				    "cnfg";
> +			qcom,channel = <0>;
> +			qcom,ee = <0>;
> +			interrupts-extended = <&pdc 1 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "periph_irq";
> +			interrupt-controller;
> +			#interrupt-cells = <4>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
>  		tlmm: pinctrl@f100000 {
>  			compatible = "qcom,qcs8300-tlmm";
>  			reg = <0x0 0x0f100000 0x0 0x300000>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-231299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F93918AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 19:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D427B23C67
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41D2190056;
	Wed, 26 Jun 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp6IClgU"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EA18FC7C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719424309; cv=none; b=ly+ikW+LkylMkK5aTSlJEw5EFBXmNbrtUCCzsVs99FRM5vgD/0imGNS3/ygTMJ7D1elLqQd7fBfd1finpfLkcT9nvTy5uk4p0w/VcDXZ3ys9wm8/wX1xG25sh3ILShyk+RUVtffGmZNbZzOtr263HJEDC0vqA4O2dpmfUMdlp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719424309; c=relaxed/simple;
	bh=U6HpPBSY8P5Pzvook2HFO9PxASjQfsBIGnm0macVpuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r33aC6FCT0D0hEzqlPy4fmtAP1Wuo6OrJ8QIEAZ6E1pzfpWGaCuJKPuLhruoNIuA15X8cYuZS+nGqtPcGdi0zF3fpQrUUOMJDIF02s4pJ/s9Zjg1rD0+UYWoQ4Ut8gWGVF+gcr3CEhT19wewwx/viH8z9t789i4Ejs0AebF+RUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp6IClgU; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec6635aa43so31994531fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719424305; x=1720029105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAZdGTk7c+/UeUa9h1az0pLQAHQQ1DT8dk5SUgRPldk=;
        b=fp6IClgUBeyBVpBUAr/Ep0Z9LUopejqa6ucySEvlVkPeaR8F1NTrpKcEhEpvxR7Wdb
         MusbLqbnrBONmgEFhyQYemsX+lpmwvt3l3XLo7pzt6hs85VKrwiwNQ1XMgUsYEUdLxzz
         mH9Ho2IaaT+jxKk8Gwz9IMyFGXDFtMzfEUczADpGZiwr+UlUjIUObkOIq8RE0O4n5hm1
         0tCAH8VH1GeM4SX+SN4eqYmJQL1cDOhgQh/HTVuutm4cuSr3VRRydwmLY32ZvvdHJp45
         WXN4qVGpGf6tg4E3/OcKtGn9YOqsbFyLgB9i/Z4wQij+bfOmSNU/13DSsFU4V7xF49MJ
         7E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719424305; x=1720029105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAZdGTk7c+/UeUa9h1az0pLQAHQQ1DT8dk5SUgRPldk=;
        b=AsbCPbz73CL/eCxxORtf7lQa0voM67ecl1XE7wRNTl1DRiha7eq1/KgyvtYxr9qmEL
         eMPJOeIjebdNom0F8C4B9ro6lx1tEAHDoP3iyAHoV9qbV7qjopE2EHIuHHYUJ6DfCeUg
         fvW895afFdG0DeZvmVLcaQiDZ3KGamHdMf3gSv+SwIJEeentEGg7x0PjGSipuo22sblF
         hjf6p7d7IfsVts7A6C1Nbi4Xe/wVP3U7XmaC8ovV99WMRvNjZdNX9OWM0l37B/SMlDFm
         PsLshEypqQwnXjQQTj55Io3qVenc0smBb9uNRbVgWiHKPv4JoJ4rQw3KPUA1e3ADwJrK
         qiwg==
X-Forwarded-Encrypted: i=1; AJvYcCXEpsoY45EYFSZXWJ770vV9IRPLsCvezkJWNfsvVvPr4br3+YeZ612ZoB+2SkH/6KzjwXxCMVIFJdNX4q1iaTnC0fZWXscFgIDHaVrr
X-Gm-Message-State: AOJu0YxHFzt3AtIdtKQY7Ws0GTeHQSk5kZYYOI7xVufcJpvvoHSKDPHO
	H+J61pF3vVECTiwakg2G7Pi3EdGzmogIGNAthHfhhgQvwQZ7fvh3uhcsWjZPevN2ewsubilc2aN
	8H1k=
X-Google-Smtp-Source: AGHT+IFSoBa3hNn7VZ8j/fymDz1W8BzHyOztv/TWTbsZhpyFaqy9xHiyV+cypP3cb7r0lPSTcGcf4Q==
X-Received: by 2002:a2e:998e:0:b0:2ec:4d5b:3d03 with SMTP id 38308e7fff4ca-2ec579845dbmr74815321fa.31.1719424305512;
        Wed, 26 Jun 2024 10:51:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec4d7e7906sm14973611fa.121.2024.06.26.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 10:51:44 -0700 (PDT)
Date: Wed, 26 Jun 2024 20:51:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com, 
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] arm64: dts: qcom: qcs6490-rb3gen2: Add qps615
 node
Message-ID: <34pn6bnhbsx3mlqcvqdjcpepf4kr255jwnm64ksynxu5xnlrpg@hw3ks7n65r63>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
 <20240626-qps615-v1-2-2ade7bd91e02@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-2-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:50PM GMT, Krishna chaitanya chundru wrote:
> QPS615 switch power is controlled by GPIO's. Once the GPIO's are
> enabled, switch power will be on.
> 
> Make all GPIO's as fixed regulators and inter link them so that
> enabling the regulator will enable power to the switch by enabling
> GPIO's.
> 
> Enable i2c0 which is required to configure the switch.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 55 ++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index a085ff5b5fb2..5b453896a6c9 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -511,6 +511,61 @@ vreg_bob_3p296: bob {
>  			regulator-max-microvolt = <3960000>;
>  		};
>  	};
> +
> +	qps615_0p9_vreg: qps615-0p9-vreg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "qps615_0p9_vreg";
> +		gpio = <&pm8350c_gpios 2 0>;
> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1000000>;
> +		enable-active-high;
> +		regulator-enable-ramp-delay = <4300>;
> +	};
> +
> +	qps615_1p8_vreg: qps615-1p8-vreg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "qps615_1p8_vreg";
> +		gpio = <&pm8350c_gpios 3 0>;
> +		vin-supply = <&qps615_0p9_vreg>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		regulator-enable-ramp-delay = <10000>;
> +	};
> +
> +	qps615_rsex_vreg: qps615-rsex-vreg {
> +		compatible = "regulator-fixed";
> +		regulator-name = "qps615_rsex_vreg";
> +		gpio = <&pm8350c_gpios 1 0>;
> +		vin-supply = <&qps615_1p8_vreg>;
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		enable-active-high;
> +		regulator-enable-ramp-delay = <10000>;
> +	};
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&pcie1 {
> +	pcie@0 {
> +		device_type = "pci";
> +		reg = <0x0 0x0 0x0 0x0 0x0>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +
> +		bus-range = <0x01 0xff>;
> +
> +		qps615@0 {
> +			compatible = "pci1179,0623";
> +			reg = <0x1000 0x0 0x0 0x0 0x0>;
> +			vdda-supply = <&qps615_rsex_vreg>;
> +			switch-i2c-cntrl = <&i2c0>;

We already have proper bindings for I2C devices. The QPS615 obviously
has and I2C device inside. Please add it to DT instead of referencing
the whole bus.

> +		};
> +	};
>  };
>  
>  &gcc {
> 
> -- 
> 2.42.0
> 

-- 
With best wishes
Dmitry


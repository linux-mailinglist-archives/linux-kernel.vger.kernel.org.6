Return-Path: <linux-kernel+bounces-313099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C196A031
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65BA1C23544
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A907581A;
	Tue,  3 Sep 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nqIMqQ+o"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34B4AEE5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373143; cv=none; b=ExnY268lu/nigR/NMy49NBKnQM0w7qDY4rMsZiukYltbPHEQU1YWgGWRRoavScM1OGX26+aKapyKyiHO63WbAwGh2sSyL36aCKGOQjaeblFtK8jtt8I4Il1VpSQzdHvWk0sRvVvIkmVavGfBfdvV5nOU4kojVYQKj7l48Sq2KG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373143; c=relaxed/simple;
	bh=JwoFLtmiHB0vGJBDZLNJoX5O9X2F3uy18O6cDHfaUf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKu+d6XH5l0ZuGBW8DAf3WLl+zjo/D+UQgUnlC6DTCaQTR9TRS5TgN7Krfc+/pakxBMLcjgQSGxe5wFGszYTxUCvo8XnhaMfX1NdRbzbvD4b6ursqT9oHltflsKQ77ra2o5zfM1wcoWrJvmgdbaT54qSoPRnnTXHVY//NaDIqTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nqIMqQ+o; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53438aa64a4so6550965e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725373139; x=1725977939; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KepiccpFwkqXd5tVMI+pBVOSG6xuqKDIl0113tPAKCs=;
        b=nqIMqQ+oZsyq8leeHpMrGK3qiT303gfPtycNzCiVO49yTHW2HMBDmyq9rqVWukImlD
         1yYoCPF09TI3wFoDfWZCCpxB6FCNDZBIfNGOYjgedntTUNN8818k7toOrQQ8SJjiuYLr
         pN7YIkl6M7rnysU/9fIDt9f5EKC+UMX5GXORbsXd8oqJVpggGzhsr/GxH11nIfiEwOWG
         nrTAlDxPQ1DkpUy9rhMFZHoWeKrFDPSCFuzkdsrtWOMh5dzedP80M0GcKuCFNgglr8+s
         3S8kUiKRjpEMXWlGAtez+PqJ/7QrVS39rzAOy1fRXyL/6PsV4yixiD5gSsZcCB7zmvpB
         0bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725373139; x=1725977939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KepiccpFwkqXd5tVMI+pBVOSG6xuqKDIl0113tPAKCs=;
        b=DR81QbVC+FlkNFiSdF05jfICLVF4J65PhirGCI2IRH9e32E2J70XcyZKLPD65CuPyS
         L0j/FMcMLhGys07cIvBJ/7GOp/HyVAiSGJUP+zRcyp30k1ZHfPW6mz4slq9n7h0zKpTL
         UZeduYyFHFEfqYXTrOwy/co6NZJY5rwI01OsCL0PyeFFZFV89AbRoupDlui6Ef5yPbUa
         g8RvhR78XQy7bY2i/4P5p5eupgu0GWa5yF38yEhkEyxwKPuJrYhoumZOozdYfLtaZlpW
         FqxZtrt5gnqulHjh+hoN1ZSURyMhhVVKBBdJL2D2XguzLhD4DWSczCwAca3G4i2avieX
         3GGg==
X-Forwarded-Encrypted: i=1; AJvYcCUY581g0a//f1sqEKmI4dcsbMNoVaKOB1TC4MMzQkqMFgN4NwA8iqtqlTcoLlUqOxVIFBkufY4R0+kNeZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71QCgQ2U8EDfbSEZK8GRCYTpw6i6hghmUdcXPaW0R/XW4HAC1
	B/XIpSVQdtGbkHzKxCLhNZ1q4XmX2aBRxBYqdAdMjQwAU17qWFan2SrSbiZwKHI=
X-Google-Smtp-Source: AGHT+IGa7iewx+m1EFUVsi6uOCG9xPLARStlVhGzTaMrBX0FXhho7dhM3jPzffOKL7Lbxz3HfcQPvw==
X-Received: by 2002:a05:6512:238b:b0:533:4668:8b86 with SMTP id 2adb3069b0e04-53546b69204mr9904421e87.41.1725373138321;
        Tue, 03 Sep 2024 07:18:58 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bb9dsm2029316e87.21.2024.09.03.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 07:18:57 -0700 (PDT)
Date: Tue, 3 Sep 2024 17:18:56 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
Message-ID: <lpjfpgnbhrp3u4rqczoouf2kvktdigisi3sjhfstanw4t5g2sc@fvqana5gftds>
References: <20240903093629.16242-1-brgl@bgdev.pl>
 <20240903093629.16242-4-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903093629.16242-4-brgl@bgdev.pl>

On Tue, Sep 03, 2024 at 11:36:28AM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
> and bluetooth nodes to consume the PMU's outputs.
> 
> Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 98 ++++++++++++++++---
>  1 file changed, 86 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> index 6a28cab97189..88b31550f9df 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
> @@ -400,6 +400,67 @@ usb1_sbu_mux: endpoint {
>  			};
>  		};
>  	};
> +
> +	wcn6855-pmu {
> +		compatible = "qcom,wcn6855-pmu";
> +
> +		pinctrl-0 = <&wlan_en>;
> +		pinctrl-names = "default";
> +
> +		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
> +		bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
> +
> +		vddio-supply = <&vreg_s10b>;
> +		vddaon-supply = <&vreg_s12b>;
> +		vddpmu-supply = <&vreg_s12b>;
> +		vddrfa0p95-supply = <&vreg_s12b>;
> +		vddrfa1p3-supply = <&vreg_s11b>;
> +		vddrfa1p9-supply = <&vreg_s1c>;
> +		vddpcie1p3-supply = <&vreg_s11b>;
> +		vddpcie1p9-supply = <&vreg_s1c>;

As the WiFi is now properly using the PMU, should we also remove some of
the regulator-always-on properties?

> +

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-306173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FC7963A31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDAF0B249C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835614D430;
	Thu, 29 Aug 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZvnxxBpO"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF5614B967
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724911225; cv=none; b=ZUl7Rh4tFmC+Sh499xsA7eQhmlc3x8GOpmlWWASpsADp4DXUkbp5X1nXaqTJHlEuxc6ynRDPs+sRqxZdMhDY+zBnKuifXhsS5JzcEYTIX3TEPimQ2qATgn1AGbU3lzC+6ZDY1qfS61g0Ovdfxph8kwbdsyK50UZIXgULjkYoNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724911225; c=relaxed/simple;
	bh=WRovSsFb3viMJP1+7gt1wh7OTJ7bpB47jGCWeWqBsmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+F18Zix38jjtzGwd70ofxBgyLGGdOyVcrhWAEsZtCmZxf/x43/C6xRVyXgDtYkekjiJRRipvcIoABYona6a78uk9S7rPVqTJ8pCKA7+FK1sA7WkSSfQf346jkTlHdXkE5O6SQB4+oOpQhHSLsJs4gx9j0v7ZeKwhrjgmSHeYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZvnxxBpO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f2868710so2651841fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 23:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724911221; x=1725516021; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnOK2TYMaWELnE4idQcQe1AdbrADVuE0o4HHsQzwTKw=;
        b=ZvnxxBpOJ7mkrxHC38N7ZKqTogao4CGfnEuy1kQ0T4qninMU/IEyMm3nSpeEp1l/DB
         7bwy1O2epk3Z+z+SqYHtWgzZ6rnQy9ScVgBxpVK/DK/5uMsfDI4E5EfRyyVwPRJEIqJ+
         WveAze+u+9Fp9Z0xexdQ5LqOXsm0ZSAbXwyA78CS+S7ixKviyHy4cMpZKBvbdsYaAh7U
         oGnj+M3TQFaixZ8/x7KGTxDzF/e32QxKLs2RFO8jJACCtEyer7TvzX2W1DsVh1AiwoeM
         XPxMDPccUvv1N3VMghw/pXI1lLdhPYgAheBcwnGbbAqn+RiA42X7xcJO41rIJjyef3ze
         Vb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724911221; x=1725516021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnOK2TYMaWELnE4idQcQe1AdbrADVuE0o4HHsQzwTKw=;
        b=fLXsddFdDnz2n2pyRQ2zU69Qf0oWVW9NU1rqErKKxt6OsHruAnDqIlocsfxWL9s/1L
         wp3T0hRISuitQaZjfJ4sKcUP+F/+gyor8+88fnp4jrtfbftMhAYZvUK/Qh9oslBvcZUa
         F7juVhnHP4QeYnjbT5F0VORuTeg3BMQwNOnSx1r6Apnb7KqVzMXBRF40i5xW4nTkZNAr
         c/y4LGgLrpYntCuwqRd8WP8R0m3DU5wkRTdJHIix4PGSNSOJzGXOKBjLaFRhovluvS92
         r9oqjOJ3SHe+4tMR0NroaIOIMqfYV013IFLO2OLaDPFZE4sp4tnaMFz5IPM0Uk4LTmm3
         PSOA==
X-Forwarded-Encrypted: i=1; AJvYcCW+68IwnV7SyYT+5Cr7B5kQQ3iam3J7Y6TMKqdfTg6XHwiLvrrConf0+GPwFokV0sLtT8FV6j67MpHc5Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeos+AqNx5KTv0t4VSytDgbQ4p1jTJFjoRe0zzm/uhSbm4ZxVx
	U/eIbVowX77xzGDvD3Y/wly2wiWIY9sZ6TpNR4JpJCUa6QN1d3/1GyZNqq6fQkE=
X-Google-Smtp-Source: AGHT+IEZJ0Xay4Q5VI/dj2OkQocLJ0ZjPYqboWNH/ZAekYaebpy9ExCBfHLt35EujSqhL4pJ5USegw==
X-Received: by 2002:a2e:bc18:0:b0:2f3:e2fd:7dcd with SMTP id 38308e7fff4ca-2f610877095mr13306261fa.6.1724911220473;
        Wed, 28 Aug 2024 23:00:20 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615183134sm916871fa.122.2024.08.28.23.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:00:20 -0700 (PDT)
Date: Thu, 29 Aug 2024 09:00:17 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: ipq6018: move mp5496 regulator
 out of soc dtsi
Message-ID: <xmvtbib3q72tnfpcaic3vbgwilpo7yjnqimr5uk2myjgtslbgm@mlp2kqvljayc>
References: <20240821101025.858961-1-amadeus@jmu.edu.cn>
 <20240821101025.858961-4-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821101025.858961-4-amadeus@jmu.edu.cn>

On Wed, Aug 21, 2024 at 06:10:24PM GMT, Chukun Pan wrote:
> Some IPQ60xx SoCs don't come with the mp5496 pmic chip. The mp5496
> pmic was never part of the IPQ60xx SoC, it's optional, so we moved
> it out of the soc dtsi.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts |  1 +
>  arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi    | 32 ++++++++++++++++++++

Please follow existing examples (msm8916-pm8916.dtsi,
msm8916-pm9816.dtsi) and add ipq6018-mp5496.dtsi inheriting ipq6018.dtsi.

>  arch/arm64/boot/dts/qcom/ipq6018.dtsi        | 14 ---------
>  3 files changed, 33 insertions(+), 14 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> index f5f4827c0e17..e71e8c851246 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> +++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>  
>  #include "ipq6018.dtsi"
> +#include "ipq6018-rdp.dtsi"
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. IPQ6018/AP-CP01-C1";
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi b/arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi
> new file mode 100644
> index 000000000000..bb56c1245f92
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq6018-rdp.dtsi
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * IPQ6018 RDP board common device tree source
> + */
> +
> +&rpm_requests {
> +	regulators {
> +		compatible = "qcom,rpm-mp5496-regulators";
> +
> +		ipq6018_s2: s2 {
> +			regulator-min-microvolt = <725000>;
> +			regulator-max-microvolt = <1062500>;
> +			regulator-always-on;
> +		};
> +	};
> +};
> +
> +&CPU0 {
> +	cpu-supply = <&ipq6018_s2>;
> +};
> +
> +&CPU1 {
> +	cpu-supply = <&ipq6018_s2>;
> +};
> +
> +&CPU2 {
> +	cpu-supply = <&ipq6018_s2>;
> +};
> +
> +&CPU3 {
> +	cpu-supply = <&ipq6018_s2>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> index 33062417781a..6f365705e2d8 100644
> --- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
> @@ -43,7 +43,6 @@ CPU0: cpu@0 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq6018_s2>;
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -56,7 +55,6 @@ CPU1: cpu@1 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq6018_s2>;
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -69,7 +67,6 @@ CPU2: cpu@2 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq6018_s2>;
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -82,7 +79,6 @@ CPU3: cpu@3 {
>  			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
>  			clock-names = "cpu";
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cpu-supply = <&ipq6018_s2>;
>  			#cooling-cells = <2>;
>  		};
>  
> @@ -184,16 +180,6 @@ glink-edge {
>  			rpm_requests: rpm-requests {
>  				compatible = "qcom,rpm-ipq6018", "qcom,glink-smd-rpm";
>  				qcom,glink-channels = "rpm_requests";
> -
> -				regulators {
> -					compatible = "qcom,rpm-mp5496-regulators";
> -
> -					ipq6018_s2: s2 {
> -						regulator-min-microvolt = <725000>;
> -						regulator-max-microvolt = <1062500>;
> -						regulator-always-on;
> -					};
> -				};
>  			};
>  		};
>  	};
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry


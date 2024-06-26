Return-Path: <linux-kernel+bounces-231319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EAA918E07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDAD1C20EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0796190491;
	Wed, 26 Jun 2024 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LO6etVeU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFE9190478
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719425611; cv=none; b=VP/C5X2X12xdV/WjIYedpBvjzlYGkNMJB6hl8sSXMdsO9VoQ+lnIAfeMV0WTltuW4mstJWBG9t0r4wH900n9eFsb/qR45OUrtChqYD/EAt5YGMNOUYRULBKnzgFu0plo3TFxFRqHmzZiW3wmlaFxCY7UW1BVQaMOx6E0szDCK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719425611; c=relaxed/simple;
	bh=OmD93Q25ADpMFRu+xE36H+6K7ZcseHViUUMx1qwfFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDIkVYMEMavLg0yiEdMIpwbuukTrIwTlrE6ab9N0BbDH3R3QaP4WKKAKBFRrjKMTlR33gHX2HLhXqDDDaePhXWG/UaoX9VE+sqah8BHWhPUGu4oBM4M47EfYzpkTiZpbEw3d03aSMW3x4u2TMB7sANdq/RwFH9LdDgrHlKPLy80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LO6etVeU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52cdea1387eso4787541e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719425607; x=1720030407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=98WqR+TIhgNWb50xP723naTMSf8HssIbDDAOYEhWpZA=;
        b=LO6etVeUT7kyZnKY5RwPsbRe4LIgl/Rg/F1tC2Yo7x+0oF7ZeFZXqHyeWqTB2JDCkk
         wvIK83QojDSOulwXbD2pSEKfIweIG/HruEeGD6fTjPnGKBms9hB1wRd4ts50Xf0Il5uU
         W6AOWwneCjLSwXklpeGMU+ROOkWzggEcV8Bz9ghbsLQxwqAJ47lqr17RRzzDG3FH4eV1
         6NdfgJtOSjF04cQzQGfceovRHPy3J5kg72Uoh05rtqoNoFgDJFxOQLxRZpuK56ezRbW5
         xpStS7seYecOnWAy50BrzYF2ldkngWqUoSIXeMl/hsHxzzg0m/6OMN8bVCMPzFso6u9f
         ipvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719425607; x=1720030407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98WqR+TIhgNWb50xP723naTMSf8HssIbDDAOYEhWpZA=;
        b=owCu01tuceZNKpfr95Qlcw9aKOhz2hZcn1mar7uMPiewlBDnb9tIwbNG+Kb7tM9IOw
         UsDwwibV3EO2MlrJgpBqyeZcSihQWoJIgWYiYsZnbnkIb2e8Fdecm2NLnPcWyOnN1GXC
         n0C6cL4sgerOZPjIkUfYm78HsyzNR15xpKHBw+GXNxDKUz4+lGKzzV2rXRAjzB8h05Bl
         o6wBdFNnVGCuz2xaifWaTVnxY8XWnOsCNjzFNU11VDwKoDy7Y0wE62jVkM7jqr/GYhYO
         Hv0LCBiCCxYbS2aVpFkscdHVuiB/QZOXC78bpM7LwYsnySvADZpUouM1OYyCqpzKt+y8
         jMbg==
X-Forwarded-Encrypted: i=1; AJvYcCUR5zn6zp6gjWx570EpxR7DUQn62RQLhIpC/0AhMnOf7eNVVdOYGhuAdvxGOsownBEgDP9X/ZQi3YARRB0Zpj1Cv3BT1smbhvPypNJ7
X-Gm-Message-State: AOJu0Yyji5ozzwrDxpFvw3/UrUmqY1mL6lPv7JJYlqLFeX6cWw0OrZAj
	+o4k7sggNtD1i7UYMmI7Ot0+9GzLevfM+9JbN+HnOAk+4MVY0Aytc4oo0IfNPts=
X-Google-Smtp-Source: AGHT+IHb4sBoQRn1fFcD1XojJf4lKn8EBbJIOhFkvUcsAWULMwiAUT7Lh4FrjhFG7Z2wX/StRwYc0Q==
X-Received: by 2002:a05:6512:3b91:b0:52d:141:153c with SMTP id 2adb3069b0e04-52d014118a1mr3551111e87.59.1719425606462;
        Wed, 26 Jun 2024 11:13:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b47b2sm1657580e87.50.2024.06.26.11.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:13:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 21:13:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Devi Priya <quic_devipriy@quicinc.com>
Cc: andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	konrad.dybcio@linaro.org, catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, 
	richardcochran@gmail.com, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	arnd@arndb.de, m.szyprowski@samsung.com, nfraprado@collabora.com, 
	u-kumar1@ti.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH V5 6/7] arm64: dts: qcom: ipq9574: Add support for nsscc
 node
Message-ID: <imkcmkqocsyrykaetnl4arxzn5q3x6zavs3ivyaf7mtdai2czz@yplf3jjjpex5>
References: <20240626143302.810632-1-quic_devipriy@quicinc.com>
 <20240626143302.810632-7-quic_devipriy@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626143302.810632-7-quic_devipriy@quicinc.com>

On Wed, Jun 26, 2024 at 08:03:01PM GMT, Devi Priya wrote:
> Add a node for the nss clock controller found on ipq9574 based devices.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V5:
> 	- Dropped interconnects from nsscc node and added 
> 	  interconnect-cells to NSS clock provider so that it can be used
> 	  as icc provider.
> 
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi | 41 +++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> index 48dfafea46a7..b6f8800bf63c 100644
> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -11,6 +11,8 @@
>  #include <dt-bindings/interconnect/qcom,ipq9574.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/clock/qcom,ipq9574-nsscc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-nsscc.h>
>  #include <dt-bindings/thermal/thermal.h>
>  
>  / {
> @@ -19,6 +21,24 @@ / {
>  	#size-cells = <2>;
>  
>  	clocks {
> +		bias_pll_cc_clk: bias-pll-cc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <1200000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		bias_pll_nss_noc_clk: bias-pll-nss-noc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <461500000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <353000000>;
> +			#clock-cells = <0>;
> +		};

What is the source for these clocks? Is it really an on-board crystal?

> +
>  		sleep_clk: sleep-clk {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
d

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel+bounces-402509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612769C2881
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 01:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CC2B22433
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A513232;
	Sat,  9 Nov 2024 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQxvI5rN"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322E638B
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731110443; cv=none; b=fjjUQWESZHQ3TJuR2miOoquNt6XE1YFJdGKjP6S/zm5/8l2c5h8FxSHa/0JjsUP0N69dhbG3UcSFdC5ipadzl0dsO23UUGlb+1M7flVLqlAZazMcep6cf8aQHdEzQiUy/vEnt+fqcMV/narcv1su12meCbxS1QIc0qIYWRlcD3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731110443; c=relaxed/simple;
	bh=vxH3oFr8Xr5P6wErHPZrSCLndBwskA3VsB1BHiwg8BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoUFQUynQQuFdGhxwRZtLB6M0l/c4YkSFyGA5GYNs0zTdzVuqyWq5Ib2obYfwxrWPkigMofOcaIruVAtkjs7ouo+wHKcsnPtPnSypyFdMa8fxg9yOfGnkP2Phxirz6JJ3VhfFeJ5vrkz1m/w0mF/KPRJYvis+UOshl4zpto0LWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQxvI5rN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539f8490856so3593665e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 16:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731110439; x=1731715239; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sGjtUh0znXcv3zo3s1FOaz4RxJY9SE96hqHHvOZDdNo=;
        b=KQxvI5rNztfRk8uiXpRQY+nL6944nLZdU35q2aRtsCddUsHCHs9pL2JpQGefhPjz+C
         ChxayKJkMsDgHKYHuuKpiCWBkcrBtSug7tt4oiCM76rKZV45IIPZdkvxRcSAZdaT+QWj
         7ON74ocK1uoxlrDuMHBceU8HKoV7megH/KLuw4O1tBU75W2MSzfUc8Nh8me4nNCh1Ub6
         DjBn96DJpUmy+b9BcRsjOVAIfyyrvy7EO2cFvYVn8cL3ngWhx/D/ci+HrnoBeMuF50vp
         TiaVYnlZyAsNkBxsS0Vh8IEkLv2vJk/+y7g7OdzsiSbVplGoR0+mLam0E2SxrD8vSZbM
         O43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731110439; x=1731715239;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGjtUh0znXcv3zo3s1FOaz4RxJY9SE96hqHHvOZDdNo=;
        b=aUzc5ii3u5IonqhD0FZ2Y6zoM4Ni3djw2QpdFjNq39/djGoXD9RRf48JtPRIRdkcwN
         Sk/TE10yTq5Fz84r5lj3C5SkC44d/FTqqCuPSewrSSyl1/JpHAM8d8zVNvLe5FuwYdWw
         H/JLL+GDWSCxJc+all4amvqCsDyPwmy5iIjGHFgvsBvhe2kslPME3zHr7gMTqE2UXg4H
         Ntt2WGuqdpqD5J7X3l11OD1Q3simAvH79uTSlFwI9/wKifTrUDOSTOiiUr7d6e54y4NQ
         P9cXfyw8Vcuji3HuVifApijGCYvToV9ZMBv5lKFxoeW82bi+yAQ/raZlnDvTb6Rn8fZR
         IlIg==
X-Forwarded-Encrypted: i=1; AJvYcCXcSCk/aLZmiVArAcMdxkpY46ZWVPBk9RCYdQ+oOLsVCo6drVzgRMgCSNk7dfIB9jE690p+j19RK9VmemM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyME85p4uEphg97ZyXbVglBXxTnkyRVwPhFIWBYyG/mHugCmQ3b
	408/NVxzk0H3gnlSUMrmF3m1f+FnYv0Cg+tupyW4dZc5H7aXGvjHIpa7Kj+I19s=
X-Google-Smtp-Source: AGHT+IHOBh0pIbDna94eEWpY2YyV6LePTuGaWTzGTKtgHigBzh0lazHI8XTB/eGLvTtkZVvI8l3XHg==
X-Received: by 2002:ac2:4c4a:0:b0:539:ea49:d163 with SMTP id 2adb3069b0e04-53d8628a2eamr2978804e87.21.1731110439277;
        Fri, 08 Nov 2024 16:00:39 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826785e1sm795612e87.32.2024.11.08.16.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:00:37 -0800 (PST)
Date: Sat, 9 Nov 2024 02:00:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Taniya Das <quic_tdas@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ajit Pandey <quic_ajipan@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add cpu scaling clock node
Message-ID: <cgg3s6f555eb4jl5segz7irwx2kkza7w6zucfyo7myrbjhng3v@2qmyrobzakhd>
References: <20241108-qcs615-mm-dt-nodes-v1-0-b2669cac0624@quicinc.com>
 <20241108-qcs615-mm-dt-nodes-v1-2-b2669cac0624@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-qcs615-mm-dt-nodes-v1-2-b2669cac0624@quicinc.com>

On Fri, Nov 08, 2024 at 11:54:05AM +0530, Taniya Das wrote:
> Add cpufreq-hw node to support cpu frequency scaling.

CPU, not cpu.
Also the prefix is incorrect for both patches.

> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> index 8c98ac77dc5c665ef296e65ac76c1b59be485abb..2c61da790e78b131e454991c968ece40dd5ca56d 100644
> --- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -33,6 +33,8 @@ cpu0: cpu@0 {
>  			power-domains = <&cpu_pd0>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_0>;
> +			clocks = <&cpufreq_hw 0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  			#cooling-cells = <2>;
>  
>  			l2_0: l2-cache {
> @@ -51,6 +53,8 @@ cpu1: cpu@100 {
>  			power-domains = <&cpu_pd1>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_100>;
> +			clocks = <&cpufreq_hw 0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  
>  			l2_100: l2-cache {
>  			      compatible = "cache";
> @@ -68,6 +72,8 @@ cpu2: cpu@200 {
>  			power-domains = <&cpu_pd2>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_200>;
> +			clocks = <&cpufreq_hw 0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  
>  			l2_200: l2-cache {
>  			      compatible = "cache";
> @@ -85,6 +91,8 @@ cpu3: cpu@300 {
>  			power-domains = <&cpu_pd3>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_300>;
> +			clocks = <&cpufreq_hw 0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  
>  			l2_300: l2-cache {
>  			      compatible = "cache";
> @@ -102,6 +110,8 @@ cpu4: cpu@400 {
>  			power-domains = <&cpu_pd4>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_400>;
> +			clocks = <&cpufreq_hw 0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  
>  			l2_400: l2-cache {
>  			      compatible = "cache";
> @@ -119,6 +129,8 @@ cpu5: cpu@500 {
>  			power-domains = <&cpu_pd5>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_500>;
> +			clocks = <&cpufreq_hw 0>;
> +			qcom,freq-domain = <&cpufreq_hw 0>;
>  
>  			l2_500: l2-cache {
>  			      compatible = "cache";
> @@ -136,6 +148,8 @@ cpu6: cpu@600 {
>  			power-domains = <&cpu_pd6>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_600>;
> +			clocks = <&cpufreq_hw 1>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  			#cooling-cells = <2>;
>  
>  			l2_600: l2-cache {
> @@ -154,6 +168,8 @@ cpu7: cpu@700 {
>  			power-domains = <&cpu_pd7>;
>  			power-domain-names = "psci";
>  			next-level-cache = <&l2_700>;
> +			clocks = <&cpufreq_hw 1>;
> +			qcom,freq-domain = <&cpufreq_hw 1>;
>  
>  			l2_700: l2-cache {
>  			      compatible = "cache";
> @@ -729,6 +745,19 @@ rpmhpd_opp_turbo_l1: opp-9 {
>  		};
>  	};
>  
> +	cpufreq_hw: cpufreq@18323000 {
> +		compatible = "qcom,cpufreq-hw";

This doesn't follow the bindings, does it?

> +		reg = <0 0x18323000 0 0x1400>,
> +		      <0 0x18325800 0 0x1400>;
> +		reg-names = "freq-domain0", "freq-domain1";
> +
> +		clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
> +		clock-names = "xo", "alternate";

Are the DCVSH interrupts?

> +
> +		#freq-domain-cells = <1>;
> +		#clock-cells = <1>;
> +	};
> +
>  	arch_timer: timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> 
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry


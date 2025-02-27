Return-Path: <linux-kernel+bounces-536657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 743A8A482B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187C91629E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098D2356D2;
	Thu, 27 Feb 2025 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HUFP87Dt"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109725CC95
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669100; cv=none; b=TZ7v39EJLybxLiy0wRtJgCmpBg9OXkzh74hrX0eIgVkVev+LqwAvWWwx/9MetafkM3Z/+jUDmvY1qmt2nS+Pfp9/ERv/hLk4i+z2St0IRpTWmbMAQOOmMMYPmVIdpG9AM1iqFcT3+kgu/fI46IMkY9w768Y/q7LBD+UMUxHhag8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669100; c=relaxed/simple;
	bh=44BNYiLW2yCxONzcBxyBR7IADrkxuDTkruh9GOEQ0ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QTgTvGX+v7tut3eWuLMLkvZEHBHmfXdVe82rYJNcV1GxjXpr6MMcBur8znxeN6+f8EYunoWVYjqdwO0NZD1qrhy//Fsz5EuXxrpJHqRgIIf1NKk/r5rz92bUwD6qddNig6p4T5/ruKNsX0hjvK0znlQuB6XVng0xHBCuJdJ1Bz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HUFP87Dt; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30a69c1a8d3so12151841fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740669096; x=1741273896; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+t6Tt0jg0KxPZB1LakHJIKAhXRLp/GXu0dW03Mj8Cwo=;
        b=HUFP87DtG5S7EZtQzX8Cjegv3hPOwOBNRbcQQTozETOtBvwfTBbp1o5uOjlJhrxoip
         +jY9VjlDCXKeEGWRl71rQW8OsmpyEpQ/hBA7JefYCsXQiGXyb9RvfOBcEBTxWj6AExKD
         MOCl17/0YxbPFVxlfPWIDHL+DReP0U3wYrGspRDzel5DBLuKowBxx7xwE1gQEUVXrtyl
         /7ikhJC4gOpvE6Ieg12l+nd6f8xHHyRyVoWoJK9u2iCAT0+L8vNL6OeSiDzFkj2ngkEI
         8HZuFxwWx9P/ewIdlGhABDABc9RXnVcemAtNep2aNuX+5YO+HgzS5cUI18iKMWW3lZWn
         CzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669096; x=1741273896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+t6Tt0jg0KxPZB1LakHJIKAhXRLp/GXu0dW03Mj8Cwo=;
        b=vyy1pr+Exij1jzfUMoUMdREFzTQKoPylNj6+1a/E00cDjuTZmIZ+vt6c4tcB5TD3SJ
         YDM6JnH7hvwsRYxzabCJqNLCbmCuys6LVGNGwzDsXl3sPS+IbBgh6gw2DEdKjNvJrj85
         EW0zJ0C6BdeKMDLZTTeQN1xKHBYQVMlEgNEu8rsIAWA4i0YRbPBBvRFiMdzQgrF3aZ4x
         vx9EIaVypb+2OunLAo0LMiWudcBO8kvYSougnqMQ6P2TrcRll9YxfuYP28dHhimHGCi3
         I7wdt4uQNc9sJmcPXnp37g2tBpFi1G3DURnc4r72n86tm5Phth6sfUpO4gri/uPRs8Bn
         zMMA==
X-Forwarded-Encrypted: i=1; AJvYcCUedHYgkanvVGjouMcftmIhjavDcX+biTin6jMAw2CdWxQeb9AZygDyZkVpaVWY3p9SGHF1edtXY0jmAVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRALKVzmL4lEZVjWbAPtWjUfl+hC+m3zAV2PCFixOd6XB4LNne
	J87anuOCJmsgNT5pc1+KaaxCGkvmQUILZB5sCAjGKBOQrmXr01rUdLt5DTZwkUbu99/gP254yTd
	xW4M=
X-Gm-Gg: ASbGnctzvfVujLhR4/XUnHfjHinM8VH4Z6px0HtpCRB1/rlCe5GwOGxg4BKyH1avtql
	RbCkjNGgkc/eavLjTL73IE75e+rZb6r5Uc+eaYv8KT/VpqNSfX2yRTvy9dWySrARv1sTssaAA4g
	ZkV99hBXf5HKmeum5Z7KrLRLP3Dou7s0JQSObmtqa4V2Tgyn8YxghYgSg9i/7nYUdnAlNBvWyAQ
	wdn+jFsOHHWkuSh7BfdpLpDZ+11wwmysj8n1Wvxzu64ksbbeep2nwYd+QzynNh0F34OmLqJl6Fy
	Q+W1Hdud7qDjOl4cjlJUitZcXi8ALqMgd8kbfHJgV+0RT/9VI6FLvfq4tTXtKEd9E8PuYAxSuvd
	Xbz/haw==
X-Google-Smtp-Source: AGHT+IGgnwEjREgD/grYv1CY7G2mqND2p+JVQ6PM1HUjMevqU6xFcdofK3dLNsfRSqBL6gSR90jkvw==
X-Received: by 2002:a05:6512:6ce:b0:545:441:52d2 with SMTP id 2adb3069b0e04-54838ef4c73mr13673229e87.23.1740669096378;
        Thu, 27 Feb 2025 07:11:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5494417a491sm182907e87.78.2025.02.27.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 07:11:35 -0800 (PST)
Date: Thu, 27 Feb 2025 17:11:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: sm8650: switch to
 interrupt-cells 4 to add PPI partitions
Message-ID: <fdlsw6mctzfutashmlve7eubgbx6nfzwsft2mnslmgsdrrwuve@pudlwja2y6g5>
References: <20250227-topic-sm8650-pmu-ppi-partition-v2-0-b93006a65037@linaro.org>
 <20250227-topic-sm8650-pmu-ppi-partition-v2-1-b93006a65037@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-topic-sm8650-pmu-ppi-partition-v2-1-b93006a65037@linaro.org>

On Thu, Feb 27, 2025 at 10:04:39AM +0100, Neil Armstrong wrote:
> The ARM PMUs shares the same per-cpu (PPI) interrupt, so we need to switch
> to interrupt-cells = <4> in the GIC node to allow adding an interrupt
> partition map phandle as the 4th cell value for GIC_PPI interrupts.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 542 +++++++++++++++++------------------
>  1 file changed, 271 insertions(+), 271 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index de960bcaf3ccf6e2be47bf63a02effbfb75241bf..273170a2e9499b900b3348307f13c9bc1a9a7345 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -1417,17 +1417,17 @@ opp-3302400000 {
>  
>  	pmu-a520 {
>  		compatible = "arm,cortex-a520-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH 0>;

Why are you changing the interrupt type? Should that be coming as a part
of the next patch?

>  	};
>  
>  	pmu-a720 {
>  		compatible = "arm,cortex-a720-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH 0>;
>  	};
>  
>  	pmu-x4 {
>  		compatible = "arm,cortex-x4-pmu";
> -		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH 0>;
>  	};
>  
>  	psci {

-- 
With best wishes
Dmitry


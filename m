Return-Path: <linux-kernel+bounces-548096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37444A53FC2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66297189288E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5515C14B;
	Thu,  6 Mar 2025 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLnHnJcm"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33562156F39;
	Thu,  6 Mar 2025 01:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741224059; cv=none; b=DRoWlqJrp5YNaP0/HT9RKt7J9ayJFhIlMiOvrNczKUaGF/aFJAmmJ1cgTNDn5bm+TRnlP0pm6PVWg9YtHLVSwkpT/hIM3vGNL07ycR3oOzirQbTYJD2JltKCe10mnSGnM8MTLqFwPZ+5wlkJsPENwdPogcD7x0JkrWa2uEXr3KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741224059; c=relaxed/simple;
	bh=qChrOs8Y7o3tEDCaxcShduGkeVGkFSi1RvOK1nsdh0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/bssauEWRw60WKc98tHg39KczwekzsmgPeYjag74UdSj34GMoDbWD6ubwNt0XkOndzgYBj8YYQeZD19OZZZ1dp24UVMsHqR8CdhyBu/ysysel7d9s9qZahsbWx8jzCgtQLEOFWhg8HCNM1MOg9oNJ2tePJDyS170JyxXRL0JN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLnHnJcm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2feb9078888so305723a91.3;
        Wed, 05 Mar 2025 17:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741224057; x=1741828857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ply0/CzY0yvzBEfEzCiDMoXMyvQu4tZWubmfbiISKOM=;
        b=JLnHnJcm8nJ8VtMpBfw3F/YNjtlJTcaMddQQmobF9RJXGHecw4fHbO1LMsDRV7it/4
         2vIwfxEuOMUhaqIN7DR4UsoAbkG/k2g5UBh00yPGyQoZxzdfDttmh/akPNWZKapv6bG9
         BPThudb4KcBzI7n09NTfe2ltldNqheNVFZtamuoL0H+Om2NiIIjgpUERyD7m9bgxAQND
         qp6o2Xv7Hst/UKHbnCWZO/uxfJfKK5LFHNFlZuX0hJ3Bi9dBRq//El1uY4WuDx+mdb8B
         ecyCH6pzhfzhp+AIpDJ8/SI3G8caSfX/k5eim+ZmIrpqHgJntMB6mYEEjeMcoI0/DT4J
         J/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741224057; x=1741828857;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ply0/CzY0yvzBEfEzCiDMoXMyvQu4tZWubmfbiISKOM=;
        b=NRK6maAvloE2O1Mx+QuNqGFDdj6RrR3rbN+xPCE6yYF88JLdZcx4KoDSqrjwHCc1QR
         N/j9aisfL/HcG5Jip0xyTy0Ex77Ba/4yc2ZsuGZU+N+MHr0YTbedxAemFfj/R7qopZyX
         z7Glv/5N8/69cYpvLWWXEBAgGz8KU+D8nE9aYVen9TBrPr5CsaiCDmLos8Ce23HNDcCG
         C+0+rK1o0T8ThQco2ch89E0q3rDqL+uh30MDTr9Gd+Kjqb/PvGx4u4nWTLnBjziJR3a9
         8wz/egtQi6iKU+DdC4rVIr8ponjnaLjKnlSt4DzNvXBUrsTMp/JHUOUTc9DzEGf+UgjC
         gx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpuT7dT8wZ8+tXW0sHtVI0iDbiFrGJ0gI5h9po5cvhD7tCQeNPQKEnX3gmGqE+y7+bIQDYVkWAhxcU0ns3@vger.kernel.org, AJvYcCX5k4KZeu5M9HtlwMguApwOaKwATJgGxtEIyXzuaLSCX2M3Zj5sQeTUWMEXis38V+xv3UHgw/sKe+W+@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXBHnEuJwVV414RCi48bZ+mbL3fN/4ZgfzY15KEQe3fGePytK
	2OaK6eJvC3Q1SEyxL1d6Z7LS7zkMzxuo/5C6pPh3Mc+5VncZsPXe
X-Gm-Gg: ASbGncvObVgMH9ifsHibx5vwO2LPMoIYYkMG4BnIOY3YoJb1iIngVkhua1J7VgWdWMG
	nosCNzK+zdwu/E1yuMOTMmrxdj29JZ0KymyD2lUyk+UxPo4D47lTq34uJT0zDklwdkXljLJacky
	l33PztzUk20VNpnyUse/RfPTNdiwpsBojF8crxyEgVTezLKPUitazgtZswnpuK+pqQ7rZAtfyzW
	EaRPR6I74l3KOuy8mOntNxVfk9fWwJCDyyL/U7VdQ2J4vbl8kVPYglUBcfJIezExmDEC/YSHiZW
	16L9V9MkYS+i+fx/E1wqzrIhoVjy1lRrQwRgw51dIF+X+WwEjaI6c+69i6rkrPWi85Oar9mehQQ
	kpXZ2
X-Google-Smtp-Source: AGHT+IFojcpy6KUP4bTQSiEwcKBMBi3P0iygm73XtFG4pDDpmIlmVKc+itvV/UD4VcBCJUi2g4g2pw==
X-Received: by 2002:a17:90b:3c41:b0:2fa:ba3:5457 with SMTP id 98e67ed59e1d1-2ff497cce9amr10138543a91.17.1741224057323;
        Wed, 05 Mar 2025 17:20:57 -0800 (PST)
Received: from [10.89.236.32] (wf126-032.ust.hk. [175.159.126.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfc7sm730455ad.22.2025.03.05.17.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 17:20:56 -0800 (PST)
Message-ID: <b13f29b8-2906-489d-b955-3f94a9bcb231@gmail.com>
Date: Thu, 6 Mar 2025 09:20:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: apple: Add SPMI controller nodes
To: fnkl.kernel@gmail.com, Sven Peter <sven@svenpeter.dev>,
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250305-spmi-v1-0-c98f561fa99f@gmail.com>
 <20250305-spmi-v1-3-c98f561fa99f@gmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250305-spmi-v1-3-c98f561fa99f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Sasha Finkelstein via B4 Relay 於 2025/3/6 凌晨4:26 寫道:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Add device tree entries for the SPMI controller
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t600x-die0.dtsi | 7 +++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi      | 8 ++++++++
>  arch/arm64/boot/dts/apple/t8112.dtsi      | 8 ++++++++
>  3 files changed, 23 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> index b1c875e692c8fb9c0af46a23568a7b0cd720141b..d544a35c8af414c583d38b040e1aa753902f1c93 100644
> --- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> +++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
> @@ -53,6 +53,13 @@ wdt: watchdog@2922b0000 {
>  		interrupts = <AIC_IRQ 0 631 IRQ_TYPE_LEVEL_HIGH>;
>  	};
>  
> +	nub_spmi0: spmi@2920a1300 {
> +		compatible = "apple,t6000-spmi", "apple,spmi";
> +		reg = <0x2 0x920a1300 0x0 0x100>;
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +	};
> +
>  	sio_dart_0: iommu@39b004000 {
>  		compatible = "apple,t6000-dart";
>  		reg = <0x3 0x9b004000 0x0 0x4000>;
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 9b0dad6b618444ac6b1c9735c50cccfc3965f947..0f03dc808cf7c6b7d71afc79dd29d368f957f979 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/interrupt-controller/apple-aic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/pinctrl/apple.h>
> +#include <dt-bindings/spmi/spmi.h>
>  
>  / {
>  	compatible = "apple,t8103", "apple,arm-platform";
> @@ -604,6 +605,13 @@ pcie_pins: pcie-pins {
>  			};
>  		};
>  
> +		nub_spmi: spmi@23d0d9300 {
> +			compatible = "apple,t8103-spmi", "apple,spmi";
> +			reg = <0x2 0x3d0d9300 0x0 0x100>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
>  		pinctrl_nub: pinctrl@23d1f0000 {
>  			compatible = "apple,t8103-pinctrl", "apple,pinctrl";
>  			reg = <0x2 0x3d1f0000 0x0 0x4000>;
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..4b3730c46c4d14a582627f69094b458ec7481da9 100644
> --- a/arch/arm64/boot/dts/apple/t8112.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -641,6 +641,14 @@ pcie_pins: pcie-pins {
>  			};
>  		};
>  
> +
> +		nub_spmi: spmi@23d714000 {
> +			compatible = "apple,t8112-spmi", "apple,spmi";
> +			reg = <0x2 0x3d714000 0x0 0x100>;
> +			#address-cells = <2>;
> +			#size-cells = <0>;
> +		};
> +
>  		pinctrl_nub: pinctrl@23d1f0000 {
>  			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
>  			reg = <0x2 0x3d1f0000 0x0 0x4000>;
>
Reviewed-by: Nick Chan <towinchenmi@gmail.com>


Return-Path: <linux-kernel+bounces-420598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FBD9D7D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C93B22668
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348418C018;
	Mon, 25 Nov 2024 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hps3RqUp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9D18B475;
	Mon, 25 Nov 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732523988; cv=none; b=m4f0wQYVBdS/oKf365QDiuqVNwvqZrFZB76qXbCU7c20JwKdPt0a4paEJJiB73/f4sGyN40JmSTbMPG4h8vaoMqh6P7CMTLcdF7KNtS4OQKhifh7+WWNVSj3317LSzt4LZ4wsobNuCRhvnIJjMNni6SzKNk2jmonY9SFUUxhuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732523988; c=relaxed/simple;
	bh=ig8emEzPWioOsYmGSaXyq1eJQNLNTFvuW4Z5UDhK6t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dz4Rj/CB5Zj9Y0NfFPq9a2MMcf+3PmpONju3nGCAQU8hdGw2ytrgYh7v1EZMOSmnH1WNlJjxwjqNBur17+AfLj8DRlswAS47S8c6GOhZMzmK2N0iCa9RFzDnh5EgkIFkSW/hFce9Oe0ayr+Pq+rUC90Apxpzzf5kMvmX3QFavfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hps3RqUp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7250844b0ecso667521b3a.1;
        Mon, 25 Nov 2024 00:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732523986; x=1733128786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0KGuZp0wmnF7hzmfITp90xIKhOfwwLfqha6id3DNJEw=;
        b=hps3RqUpcFP8uqBms6b/RssrA3M2unF50cIOtnYZny+vKMXQIBnvoyLGDaf+6/jlbY
         +L2zR8k8Aju80daFh8WzPd4jLOEyA5iCni0HDW4O6Yv6zL1PbpmWSgaqSsafBbl0zz+j
         r//r6bb4u+cF2MAepkIrmq40Es1L/xESz5vR8Gp6fAGcX+BsJsxOM1qAAuRcqAJD8PxS
         kYaEUsaWkax4qMnOkMjk0eyrmgAaYD10PnUKzhEtiNoLoVfKUdytGhMqmeEiE7ZOpNBT
         hCtAR4UFa8ckhE1ddj82+DrqdywRQ/sy1q6sjbNN8nKq2QwrhUh2KbJbyspZEMYyGjaA
         gE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732523986; x=1733128786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0KGuZp0wmnF7hzmfITp90xIKhOfwwLfqha6id3DNJEw=;
        b=mExYkRz4Lo1H2h4peG4Px/jcx9qAF5EKB0SO9ziuEaMy5PuYgUPzf0MdUIEU9E7YN5
         gIGrmcBZ2nFh0UNpgRzQmjxXxoZh9GobkPzg+/WPODR4RooAWKEdqxlfhnG7V/FS3GwF
         y6zFKiTMNvXHi8Q6lFwHpYSoDkb82EeWiC9TzbrVrwaEVfC1Ei/8LzxyGI89LPmSF+Je
         EP6qTyuUv/ndod44LjpRBHaR80aAjNx42VEoli78zd5KBfTbCsYuqx+f4daSHHiVHd62
         P4rgua2p8Cp1uNML66AzslJgACeFtRLjy2Udu7gehePnJQYNu9M9POtqMC0+/54UG9tn
         8ztg==
X-Forwarded-Encrypted: i=1; AJvYcCX9RnMvqeG57f4fcwMt6ncU3V7fiqGIiFVTRabzRGsw0oz2JFBpOO5c7916Rbw+llCsVeGFXOxWPTUrtKX8@vger.kernel.org, AJvYcCXO4VMg8KJzQ4Hc28FUmxv/JATuiXhFQHcqmB4IcN0wS/1jR9ilobNDu/nRtPyeHpP8a7ta8QRbntEg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TgOGNPjQnV+sVx0bNlTMJHCTz8yFcrbL59uPkzNO8Sl2bSN/
	Yu2hQ+UyS/uQftQuJMwQBhsnpQt/u/YCNgZ5U6avyb/3JOzC1qve
X-Gm-Gg: ASbGncsCkC40+FaD/ncH+pf9RZHUT7sMHxibYXx1iwQ+cU8/mFzg+8zPrhw1CQz45Hy
	JiTfoIcbwA2/3wGdDXLJbEZVOjHba9WiC5l6RD85Kui+SBT0fxKhFyctIwrlWy4+e3WQ6YTOcQR
	IC7KO0bYOr/YBD+h1akohwMQwNsxzhcyBn2VvdsgaYpe8xYhbAN3eOIveTtJpUYcsEvRTkhwfKE
	me3OtIU2YES7Y9vHZB8qEI65w/INdd3ShnbOQu7uP8fAFa7s1G1M7UG5fpQjv7TPLu3
X-Google-Smtp-Source: AGHT+IHU1nyBULHIR2177tUcXa0ze8GqotcNDT6gsNhsvTrJblPUvYHMUa+RMDMyUkRWs6wbq9n4YA==
X-Received: by 2002:a05:6a00:1251:b0:71e:cb:e7bf with SMTP id d2e1a72fcca58-724df66a8abmr14741216b3a.18.1732523985898;
        Mon, 25 Nov 2024 00:39:45 -0800 (PST)
Received: from [192.168.0.115] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454c55sm5838914b3a.35.2024.11.25.00.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:39:45 -0800 (PST)
Message-ID: <4381e1ef-6113-4fe5-a48a-ea4c163dd103@gmail.com>
Date: Mon, 25 Nov 2024 16:39:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: apple: Add touchbar screen nodes
To: fnkl.kernel@gmail.com, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Janne Grunau <j@jannau.net>
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-4-3191d8e6e49a@gmail.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20241124-adpdrm-v1-4-3191d8e6e49a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Sasha Finkelstein via B4 Relay 於 2024/11/25 早上6:29 寫道:
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> 
> Adds device tree entries for the touchbar screen
> 
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  arch/arm64/boot/dts/apple/t8103-j293.dts |  8 ++++++++
>  arch/arm64/boot/dts/apple/t8103.dtsi     | 26 ++++++++++++++++++++++++++
>  arch/arm64/boot/dts/apple/t8112-j493.dts | 15 +++++++++++++++
>  arch/arm64/boot/dts/apple/t8112.dtsi     | 25 +++++++++++++++++++++++++
>  4 files changed, 74 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
> index 56b0c67bfcda321b60c621de092643017693ff91..349a8fce6b0b8ccf3305f940ba7242e2c1a67754 100644
> --- a/arch/arm64/boot/dts/apple/t8103-j293.dts
> +++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
> @@ -49,3 +49,11 @@ &i2c4 {
>  &fpwm1 {
>  	status = "okay";
>  };
> +
> +&display_dfr {

Inconsistent placement of #address-cells and #size-cells.
> +	status = "okay";

There should be a blank line here.
> +	dfr_panel: panel@0 {
> +		compatible = "apple,summit";
> +		reg = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
> index 9b0dad6b618444ac6b1c9735c50cccfc3965f947..b377c92c5db3cb4fea53ae2c5dd85acf038429a3 100644
> --- a/arch/arm64/boot/dts/apple/t8103.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8103.dtsi
> @@ -356,6 +356,32 @@ cpufreq_p: performance-controller@211e20000 {
>  			#performance-domain-cells = <0>;
>  		};
>  
> +		display_dfr: display-pipe@228200000 {
> +			compatible = "apple,t8103-display-pipe", "apple,h7-display-pipe";
> +			reg-names = "be", "fe", "mipi";
> +			reg = <0x2 0x28200000 0x0 0xc000>,
> +				<0x2 0x28400000 0x0 0x4000>,
> +				<0x2 0x28600000 0x0 0x100000>;
> +			power-domains = <&ps_dispdfr_fe>, <&ps_dispdfr_be>, <&ps_mipi_dsi>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 502 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 506 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "be", "fe";
> +			status = "disabled";
> +			iommus = <&displaydfr_dart 0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Inconsistent placement of #address-cells and #size-cells.
> +		};
> +
> +		displaydfr_dart: iommu@228304000 {
> +			compatible = "apple,t8103-dart";
> +			reg = <0x2 0x28304000 0x0 0x4000>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 504 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			power-domains = <&ps_dispdfr_fe>;
Not every M1 (T8103) device has a touch bar. Disable it here and
then enable it in t8103-j293.dts.

> +		};
> +
>  		sio_dart: iommu@235004000 {
>  			compatible = "apple,t8103-dart";
>  			reg = <0x2 0x35004000 0x0 0x4000>;
> diff --git a/arch/arm64/boot/dts/apple/t8112-j493.dts b/arch/arm64/boot/dts/apple/t8112-j493.dts
> index 0ad908349f55406783942735a2e9dad54cda00ec..80e371495f3e097f91e94549c7ac2949609f566f 100644
> --- a/arch/arm64/boot/dts/apple/t8112-j493.dts
> +++ b/arch/arm64/boot/dts/apple/t8112-j493.dts
> @@ -35,6 +35,21 @@ led-0 {
>  	};
>  };
>  
> +&display_dfr {
> +	status = "okay";
status should be after other properties, before child nodes.

> +	#address-cells = <1>;
> +	#size-cells = <0>;

Inconsistent placement of #address-cells and #size-cells. I would place
them in
t8112.dtsi.
> +
> +	dfr_panel: panel@0 {
> +		compatible = "apple,summit";
> +		reg = <0>;
> +	};
> +};
> +
> +&displaydfr_dart {
> +	status = "okay";
> +};
> +
>  /*
>   * Force the bus number assignments so that we can declare some of the
>   * on-board devices and properties that are populated by the bootloader
> diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
> index 1666e6ab250bc0be9b8318e3c8fc903ccd3f3760..726b11376692580abb129b9be35107bee1550a93 100644
> --- a/arch/arm64/boot/dts/apple/t8112.dtsi
> +++ b/arch/arm64/boot/dts/apple/t8112.dtsi
> @@ -379,6 +379,31 @@ cpufreq_p: cpufreq@211e20000 {
>  			#performance-domain-cells = <0>;
>  		};
>  
> +		display_dfr: display-pipe@228200000 {
> +			compatible = "apple,t8112-display-pipe", "apple,h7-display-pipe";
> +			reg-names = "be", "fe", "mipi";
> +			reg = <0x2 0x28200000 0x0 0xc000>,
> +				<0x2 0x28400000 0x0 0x4000>,
> +				<0x2 0x28600000 0x0 0x100000>;
> +			power-domains = <&ps_dispdfr_fe>, <&ps_dispdfr_be>, <&ps_mipi_dsi>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 614 IRQ_TYPE_LEVEL_HIGH>,
> +				<AIC_IRQ 618 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "be", "fe";
> +			status = "disabled";
> +			iommus = <&displaydfr_dart 0>;
> +		};
> +
> +		displaydfr_dart: iommu@228304000 {
> +			compatible = "apple,t8110-dart";
> +			reg = <0x2 0x28304000 0x0 0x4000>;
> +			interrupt-parent = <&aic>;
> +			interrupts = <AIC_IRQ 616 IRQ_TYPE_LEVEL_HIGH>;
> +			#iommu-cells = <1>;
> +			power-domains = <&ps_dispdfr_fe>;
> +			status = "disabled";
> +		};
> +
>  		sio_dart: iommu@235004000 {
>  			compatible = "apple,t8110-dart";
>  			reg = <0x2 0x35004000 0x0 0x4000>;
> 

Nick Chan


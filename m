Return-Path: <linux-kernel+bounces-550266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADAFA55D57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905D17A3487
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15D71632C8;
	Fri,  7 Mar 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmAnwr0l"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF867155C87;
	Fri,  7 Mar 2025 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312545; cv=none; b=pF8M8vCs38SktadPu2u2wk/u4y6QbroRtW8OtFF0YZpAO7E4YYiO9AEu3Z0S7CiVzBwU86k1zuttq+SB4Aerln/w5BZFGfvPJZC3gTndkp34WZP8QS+whVRLjNBP+KLNMf5WtLBYZ+p0FheOZZokWgkb3W7jxeSGcyrBoVB5o7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312545; c=relaxed/simple;
	bh=RHtN3iGjMgWiluyrwelfjYAaPkmhPTQUo75CvgJ0QEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC2rEccQu4bdMp5OyV6CNpds4IKoE389dbs53XLr5jSXYcrtpg7jrfdF2vl+m+MU19QeQHpf/XMVGvkRfHKmYT1cLAuwWs41IUE2jE+FAFlWLaib6k1+h4CB/r7525HCvNEsPfNOQlKlMULwVam/xCVRJ6wzAvB45B8X0+9mQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmAnwr0l; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c3cb761402so258446485a.0;
        Thu, 06 Mar 2025 17:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741312542; x=1741917342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnB820XmRIOqOOR99gcezJiiPyY61vMTKT3r5Ay3K/8=;
        b=RmAnwr0lSqm7JG/V+f6Ab7L3YXm8cgIHoJLVJ+Yhc5bQUAnaetwzRWQaxAxxElz5SK
         ch8Cx7KRw4m1fzGF1xWc+VhC6F46SfElqaMGg1pZ22A/p3kWfW3BGwQrCaRZXvAUxSD6
         WIO7UNSazQ9b6uWI1wPq2+aFF3ytRpxOzW1QbFeQF8xVLLwcFQfkBfqiA2dAp718B03R
         TujwE1XAo/yGOQjXzvYcB6uB75jsbFDSNij32VKdKFVAylgl2j4euYx7Av0VnYp3/2oq
         gR0uCac5oviE/dKejui6VqlT91gIOsdu+JwiknVjE6ic8ZoJ2w2mptSYdZHAoSybvqdv
         FkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741312542; x=1741917342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnB820XmRIOqOOR99gcezJiiPyY61vMTKT3r5Ay3K/8=;
        b=kCvpwaPpYdGcMKSIIRRmyZu3oSlW9L6HXWGuC99nNnOFKgBJuu7UrludSC7pdmdkDp
         uxv9oo1dQJwAsoWHs3DRefWlpI+7SxjGSABCWsEVBvJQ2q334YLswKwM52vqJS64jYnt
         lMnkMLxEsK/xiAtrBO8ITqFAddiV1WdJmcyw4aPMKDvY8pXT1wSTHrQI98aOuMO/FTK3
         fVVuTvqDUpAADo4UBGtsW9BjwIohZjYzBYgvfN5189kJQiZ+daHTizbwjjifYMyF+SS2
         Hy1rIcsVN5Ql7sy8x0mlPhFcogK1+E/jfOr0zQhhv2oz8A0LDiMRnsxHVeVGOGc3KKy5
         JfKg==
X-Forwarded-Encrypted: i=1; AJvYcCV6pKKJPd21S8xZO/Ajj/1nDb//QdyRbOYB34Q08l+/zR5NvK5hG+wSJBoynIKsK1hVOnZWKcRt/IOfwlh0@vger.kernel.org, AJvYcCXKA6YRX2Fw8h7ZrWGoyMBWboVWf272e93x4BEZ2oD1kxgWSBZDFpyiCgxoqqOB322zv/IHYTbguAfh@vger.kernel.org, AJvYcCXalO1QckfR95XYUEJUKd6/7a58/ZUg3wGan5Xc1xBgelIgYZFRkVaS2i0x4/BDfkvGSkbitQENsNh7@vger.kernel.org
X-Gm-Message-State: AOJu0YypNnyqwIadvgghFpqBD8zXW5Mc+cPgclwDzrgKESmOcPszlet3
	pR54Co2gHKy8FTGuE+GWOJUD7Cq0sK3blZ/R7DylB3awQompSxs3
X-Gm-Gg: ASbGnctBTVOaGC0a01RUH12SAfowt0PxrU6nxzp3EVBCs5IllSrnizKQ7M8mz5700b3
	RX9oZ6Fe/+3LGHjAe+pYBBJwdKRM9SLEg96WEVcSNwixOjv290so0Zbf/iELhO70yomGJXOU1Tk
	RNVkXaWSUWw3a7aZt+DnIFF0SGNh+w40qCbSZDbQa/9JVZMm1qOm8n5g+4Jta776hvivGWY9Anb
	gxgREZwdUsXzoOmJZMLbB5n6gA0vjMkL+++db5y4k6fwil5zLWkQRct7B2dbYhHxaD+iLJJXmxM
	tPB3uHF3CGO9v2oBB3S7
X-Google-Smtp-Source: AGHT+IEhk9cw6y94YXFfzejXMM/qsbiaq30VZ1R51o4YMU4MUQ3DOSzkmoemtDhtTBQwJetuR8isjg==
X-Received: by 2002:a05:620a:8719:b0:7c3:d6a7:6eea with SMTP id af79cd13be357-7c4e168b8b7mr226719685a.21.1741312542344;
        Thu, 06 Mar 2025 17:55:42 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c3e551102csm168635885a.101.2025.03.06.17.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:55:41 -0800 (PST)
Date: Fri, 7 Mar 2025 09:55:15 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Haylen Chu <heylenay@4d2.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Haylen Chu <heylenay@outlook.com>, Yixun Lan <dlan@gentoo.org>
Cc: linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicornxdotw@foxmail.com>, 
	Jisheng Zhang <jszhang@kernel.org>, Meng Zhang <zhangmeng.kevin@linux.spacemit.com>
Subject: Re: [PATCH v5 5/5] riscv: dts: spacemit: Add clock tree for Spacemit
 K1
Message-ID: <2isaev6ys2fn2u6lnyudvnjam34fggr5tqh7afajwdjbdp5rvr@ajokoevhqq4p>
References: <20250306175750.22480-2-heylenay@4d2.org>
 <20250306175750.22480-7-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306175750.22480-7-heylenay@4d2.org>

On Thu, Mar 06, 2025 at 05:57:51PM +0000, Haylen Chu wrote:
> Describe the PLL and system controllers that're capable of generating
> clock signals in the devicetree.
> 
> Signed-off-by: Haylen Chu <heylenay@4d2.org>
> ---
>  arch/riscv/boot/dts/spacemit/k1.dtsi | 79 ++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
> index c670ebf8fa12..09a9100986b1 100644
> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
> @@ -3,6 +3,8 @@
>   * Copyright (C) 2024 Yangyu Chen <cyy@cyyself.name>
>   */
>  
> +#include <dt-bindings/clock/spacemit,k1-ccu.h>
> +
>  /dts-v1/;
>  / {
>  	#address-cells = <2>;
> @@ -306,6 +308,40 @@ cluster1_l2_cache: l2-cache1 {
>  		};
>  	};
>  
> +	clocks {

> +		#address-cells = <0x2>;
> +		#size-cells = <0x2>;
> +		ranges;

why setting this?

> +
> +		vctcxo_1m: clock-1m {
> +			compatible = "fixed-clock";

> +			clock-frequency = <1000000>;

Should the frequency this move to the board file?
I do not think these clock are in the soc.
This applys to all clock below.

> +			clock-output-names = "vctcxo_1m";
> +			#clock-cells = <0>;
> +		};
> +
> +		vctcxo_24m: clock-24m {
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
> +			clock-output-names = "vctcxo_24m";
> +			#clock-cells = <0>;
> +		};
> +
> +		vctcxo_3m: clock-3m {
> +			compatible = "fixed-clock";
> +			clock-frequency = <3000000>;
> +			clock-output-names = "vctcxo_3m";
> +			#clock-cells = <0>;
> +		};
> +
> +		osc_32k: clock-32k {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			clock-output-names = "osc_32k";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		interrupt-parent = <&plic>;
> @@ -314,6 +350,17 @@ soc {
>  		dma-noncoherent;
>  		ranges;
>  
> +		syscon_apbc: system-control@d4015000 {
> +			compatible = "spacemit,k1-syscon-apbc";
> +			reg = <0x0 0xd4015000 0x0 0x1000>;
> +			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
> +				 <&vctcxo_24m>;
> +			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
> +				      "vctcxo_24m";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
>  		uart0: serial@d4017000 {
>  			compatible = "spacemit,k1-uart", "intel,xscale-uart";
>  			reg = <0x0 0xd4017000 0x0 0x100>;
> @@ -409,6 +456,38 @@ pinctrl: pinctrl@d401e000 {
>  			reg = <0x0 0xd401e000 0x0 0x400>;
>  		};
>  
> +		syscon_mpmu: system-controller@d4050000 {
> +			compatible = "spacemit,k1-syscon-mpmu";
> +			reg = <0x0 0xd4050000 0x0 0x209c>;
> +			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
> +				 <&vctcxo_24m>;
> +			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
> +				      "vctcxo_24m";
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		pll: system-control@d4090000 {
> +			compatible = "spacemit,k1-pll";
> +			reg = <0x0 0xd4090000 0x0 0x1000>;
> +			clocks = <&vctcxo_24m>;
> +			spacemit,mpmu = <&syscon_mpmu>;
> +			#clock-cells = <1>;
> +		};
> +
> +		syscon_apmu: system-control@d4282800 {
> +			compatible = "spacemit,k1-syscon-apmu";
> +			reg = <0x0 0xd4282800 0x0 0x400>;
> +			clocks = <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>,
> +				 <&vctcxo_24m>;
> +			clock-names = "osc", "vctcxo_1m", "vctcxo_3m",
> +				      "vctcxo_24m";
> +			#clock-cells = <1>;
> +			#power-domain-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
>  		plic: interrupt-controller@e0000000 {
>  			compatible = "spacemit,k1-plic", "sifive,plic-1.0.0";
>  			reg = <0x0 0xe0000000 0x0 0x4000000>;
> -- 
> 2.48.1
> 


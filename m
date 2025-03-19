Return-Path: <linux-kernel+bounces-567488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF60A686C0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED975173E15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B71825178D;
	Wed, 19 Mar 2025 08:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iD1Q8F9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F1D250C06;
	Wed, 19 Mar 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372796; cv=none; b=FpRAFuPCkec9lfCpCFKNySO9YJ99eTwrxJfoNmCJJ8LbeR5cNLh5xJxhlRXbBjpNAbIyC/b4tW71o0C1Hhj4PmKtnws8pqlVNrTFvg0xIWO2JsNi0XrpoJLD5nobsZEp6dCj5IEwmduxicKD/x97kelsmI0NLXEt/vM+5YHu67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372796; c=relaxed/simple;
	bh=rU8+WkMYfMbYGpZkfzJ96Y2lKsnKTuKpexBprl+FdL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvh8T5LIpmlZpAqX7UP4papMtyybnYUxKpzEGchb004ispHSxWlClxaG9UXNjfUNhQTN6ErgqcgSwXFvwfhdkNdUZuddL1r87oRNHrP/8uAbTtzbYK7Vri6Yga/3L+QVZJu0+l3pP5+ZPKVkK95p4zrq0q1ADZU8fkKhPujdC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iD1Q8F9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42ACEC4CEEF;
	Wed, 19 Mar 2025 08:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742372796;
	bh=rU8+WkMYfMbYGpZkfzJ96Y2lKsnKTuKpexBprl+FdL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iD1Q8F9SxEXHSwXQ1X2w7c3ld3gV/mL5RfjN7hAaqzoyXEImk03FucbmYTiLOF1/u
	 g0fDh1IbMn0C8FwiWcxb/EVy9hblcEpfUSERUkgftXppqOrI26KCxrxi/f4encpSJE
	 vVBtTaghWd6YD+YWKqSCoeI9lETXJDXCxyzYdAnXOZ0I09UGvtdtJ//Ch0jlfZb/cL
	 VptXpjYUTop3ncVYD+Q6+AdCzFpDdTmlMGrhklmSFIIL51TDTpf7dwZGN3mIOHj4v9
	 h6E6qIHTl4iiQ+29rBXbzKFnpGKPNtIP30R6+FpchxFascpfS0oQvCg5VleMat6kAr
	 9tEn9ZYUSRPPw==
Date: Wed, 19 Mar 2025 09:26:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: jiebing chen <jiebing.chen@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, jian.xu@amlogic.com, 
	shuai.li@amlogic.com, zhe.wang@amlogic.com
Subject: Re: [PATCH v4 6/6] arm64: dts: amlogic: Add Amlogic S4 Audio
Message-ID: <20250319-quizzical-coyote-of-assurance-d4c91d@krzk-bin>
References: <20250319-audio_drvier-v4-0-686867fad719@amlogic.com>
 <20250319-audio_drvier-v4-6-686867fad719@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319-audio_drvier-v4-6-686867fad719@amlogic.com>

On Wed, Mar 19, 2025 at 03:04:49PM +0800, jiebing chen wrote:
> Add basic audio driver support for the Amlogic S4 based
> Amlogic AQ222 board. use hifipll pll (1179648000) to
> support 768k sample rate and 24 bit (s24_le), 24bit sclk
> is 48fs, use mpll0 (270950400) to support 705.6k sample
> rate and 32bit, use mpll1 (338688000) to support 705.6k
> and 24bit.

Please wrap commit message according to Linux coding style / submission
process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

> 
> Signed-off-by: jiebing chen <jiebing.chen@amlogic.com>

...

> +
> +		dai-link-12 {
> +			sound-dai = <&toacodec TOACODEC_OUT>;
> +
> +			codec {
> +				sound-dai = <&acodec>;
> +			};
> +		};
> +	};
> +

Do not add stray blank lines.

>  };
>  
>  &pwm_ef {
> diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> index 957577d986c0675a503115e1ccbc4387c2051620..83edafc2646438e3e6b1945fa1c4b327254a4131 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
> @@ -11,7 +11,11 @@
>  #include <dt-bindings/clock/amlogic,s4-peripherals-clkc.h>
>  #include <dt-bindings/power/meson-s4-power.h>
>  #include <dt-bindings/reset/amlogic,meson-s4-reset.h>
> -

Why?

> +#include <dt-bindings/clock/axg-audio-clkc.h>
> +#include <dt-bindings/reset/amlogic,meson-axg-audio-arb.h>
> +#include <dt-bindings/reset/amlogic,meson-g12a-audio-reset.h>
> +#include <dt-bindings/sound/meson-g12a-toacodec.h>
> +#include <dt-bindings/sound/meson-g12a-tohdmitx.h>

Old style was correct.

>  / {
>  	cpus {
>  		#address-cells = <2>;
> @@ -46,6 +50,36 @@ cpu3: cpu@3 {
>  		};
>  	};
>  
> +	tdmif_a: audio-controller-0 {
> +		compatible = "amlogic,axg-tdm-iface";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TDM_A";
> +		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_A_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_A_MCLK>;
> +		clock-names = "sclk", "lrclk","mclk";
> +	};
> +
> +	tdmif_b: audio-controller-1 {
> +		compatible = "amlogic,axg-tdm-iface";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TDM_B";
> +		clocks = <&clkc_audio AUD_CLKID_MST_A_SCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_B_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_B_MCLK>;
> +		clock-names = "sclk", "lrclk","mclk";
> +	};
> +
> +	tdmif_c: audio-controller-2 {
> +		compatible = "amlogic,axg-tdm-iface";
> +		#sound-dai-cells = <0>;
> +		sound-name-prefix = "TDM_C";
> +		clocks = <&clkc_audio AUD_CLKID_MST_C_SCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_C_LRCLK>,
> +			 <&clkc_audio AUD_CLKID_MST_C_MCLK>;
> +		clock-names = "sclk", "lrclk","mclk";
> +	};
> +
>  	timer {
>  		compatible = "arm,armv8-timer";
>  		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> @@ -101,7 +135,6 @@ apb4: bus@fe000000 {
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
> -

Why? What is happening in this patch - why are you changing so many
other pieces?

>  			clkc_periphs: clock-controller@0 {
>  				compatible = "amlogic,s4-peripherals-clkc";
>  				reg = <0x0 0x0 0x0 0x49c>;
> @@ -134,6 +167,17 @@ clkc_pll: clock-controller@8000 {
>  				#clock-cells = <1>;
>  			};
>  
> +			acodec: audio-controller@1a000 {
> +				compatible = "amlogic,t9015";
> +				reg = <0x0 0x1A000 0x0 0x14>;
> +				#sound-dai-cells = <0>;
> +				sound-name-prefix = "ACODEC";
> +				clocks = <&clkc_periphs CLKID_ACODEC>;
> +				clock-names = "pclk";
> +				resets = <&reset RESET_ACODEC>;
> +				AVDD-supply = <&vddio_ao1v8>;
> +			};
> +
>  			watchdog@2100 {
>  				compatible = "amlogic,s4-wdt", "amlogic,t7-wdt";
>  				reg = <0x0 0x2100 0x0 0x10>;
> @@ -850,3 +894,327 @@ emmc: mmc@fe08c000 {
>  		};
>  	};
>  };
> +
> +&apb4 {
> +	audio: bus@330000 {
> +		compatible = "simple-bus";
> +		reg = <0x0 0x330000 0x0 0x1000>;

That's not a simple bus in such case.

NAK


Best regards,
Krzysztof



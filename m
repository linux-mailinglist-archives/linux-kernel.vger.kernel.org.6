Return-Path: <linux-kernel+bounces-343612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C923B989D42
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9AA1C21C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FB917F505;
	Mon, 30 Sep 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zGAnHetR"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568F13D531;
	Mon, 30 Sep 2024 08:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686208; cv=none; b=nPrPwrF1Ln3/fuzgVbIEezI/EgiTZMscs/CEdPyC/FWbJ2g/7wa3jWhuXEABAxaYd2HZLyxN3sTFH7YLnr09j29AyLBhkRnfR2UaPpPAIj7fDr4WpZZVNLpS02DEUKMt7oOX2RZUzu4ajMU3FkFT0LZdxrEHmJlKAPApw0ESte8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686208; c=relaxed/simple;
	bh=f5AxsC392i8EIHuBCSxVTm1FtkBX856hy/Rie/U83Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U6ADSFR22JZMNZkgNjG4tcxrvZpeHamF2IO90xnuB/eWE48pKKM0qDeBHOeyF1hAcXrzUGq8pCjiYcSy/pzzwF3YoqbXJT0T8dswf6tO6QG6Qf5Oc8EKdbQ6weDPW3UtUmjFDJVgV8LV4LBqIzoiQfZLh2dzh5evSQROlFkvhko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zGAnHetR; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BZhvBdz24UU/9na5K2urGxf2dHFtMLDWkuqh0tEIars=; b=zGAnHetRD6a16YnCi2N/2hdaJU
	EonkVFH9akA6WSXZ1EDQfZeelFXDEKOpFmwx33yf/5aMHMMSqowRVhdcRkYEz/HI3GKMm/krCwNDB
	sIlYA6FzqIsV78RGjLoUbufl4NtJz2jUtaNKFrK++86caCIx9Sl/Pb8+omZgmWLabUOCfSxPLo2/T
	3XnvMh92z9Cl/9C+T5uMQ6QlLWk7ec+/VHu3Nq2kEfI5wodaoNm20gb2Mavc4ETc+9YqVRVyp8TWB
	4nQ1z691ioNDznXSPqMVzez0B85z84dNl6V6uMNwJA0VjIwIr4k6CQ9BOieh9gY4LqKEmcC6U/Zif
	USI+6blg==;
Received: from i5e861925.versanet.de ([94.134.25.37] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1svC6H-0003lg-7C; Mon, 30 Sep 2024 10:49:49 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Daniel Semkowicz <dse@thaumatec.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Farouk Bouabid <farouk.bouabid@theobroma-systems.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Vahe Grigoryan <vahe.grigoryan@theobroma-systems.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add power button for RK3399 Puma
Date: Mon, 30 Sep 2024 10:49:48 +0200
Message-ID: <4620941.LvFx2qVVIh@diego>
In-Reply-To: <54c49375-cb2a-40fe-abcd-fc56c04d0c53@cherry.de>
References:
 <20240925072945.18757-1-dse@thaumatec.com>
 <54c49375-cb2a-40fe-abcd-fc56c04d0c53@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hey Quentin, Daniel,

Am Donnerstag, 26. September 2024, 14:34:30 CEST schrieb Quentin Schulz:
> On 9/25/24 9:28 AM, Daniel Semkowicz wrote:
> > There is a PWRBTN# input pin exposed on a Q7 connector. The pin
> > is routed to a GPIO0_A1 through a diode. Q7 specification describes
> > the PWRBTN# pin as a Power Button signal.
> > Configure the pin as KEY_POWER, so it can function as power button and
> > trigger device shutdown.
> > Add the pin definition to RK3399 Puma dts, so it can be reused
> > by derived platforms, but keep it disabled by default.
> > 
> > Enable the power button input on Haikou development board.
> > 
> > Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
> 
> This works, thanks.
> 
> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Now I have some questions I wasn't able to answer myself, maybe someone 
> can provide some feedback on those :)
> 
> We already have a gpio-keys for buttons on Haikou, c.f. 
> https://elixir.bootlin.com/linux/v6.11/source/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts#L22. 
> Those signals are directly routed to the SoM and follow the Qseven standard.
> 
> The same applies to PWRBTN# signal.
> 
> However, here we have one gpio-keys for PWRBTN# in Puma DTSI and one 
> gpio-keys for the buttons and sliders on Haikou devkit in Haikou DTS.
> 
> I'm a bit undecided on where this should go.
> 
> Having all button/slider signals following the Qseven standard in Puma 
> DTSI and enable the gpio-keys only in the devkit would make sense to me, 
> so that other baseboards could easily make use of it. However, things 
> get complicated if the baseboard manufacturer decides to only implement 
> **some** of the signals, for which we then need to remove some nodes 
> from gpio-keys (and pinctrl entries) since gpio-keys doesn't check the 
> "status" property in its child nodes (though that could be fixed). At 
> which point, it's not entirely clear if having it in Puma DTSI is 
> actually beneficial.
> 
> Someone has an opinion/recommendation on that?

I guess from a platform perspective nobody really cares, so as that is
"your" board, it comes down to a policy decision on your part ;-) .

While pins follow the q7 standard, there may very well be some lax
handling of that standard in some places, and I guess gpio lines could
be re-used for something else if needed, as something like the lid-switch
is probably non-essential.

Also a gpio-key input does not create that much code-overhead if
replicated, so personally I'd just stick the power-button with the other
buttons in the haikou dts.

Which is also a way better thing than having multiple gpio-keys instances
that userspace then has to handle.


Heiko


> > ---
> > 
> >   .../boot/dts/rockchip/rk3399-puma-haikou.dts  |  4 ++++
> >   arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 22 +++++++++++++++++++
> >   2 files changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> > index f6f15946579e..0999026b16d0 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
> > @@ -143,6 +143,10 @@ vddd_codec: vddd-codec {
> >   	};
> >   };
> >   
> > +&gpio_key_power {
> > +	status = "okay";
> > +};
> > +
> >   &hdmi {
> >   	ddc-i2c-bus = <&i2c3>;
> >   	status = "okay";
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > index 650b1ba9c192..389ffe604e74 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> > @@ -3,6 +3,7 @@
> >    * Copyright (c) 2017 Theobroma Systems Design und Consulting GmbH
> >    */
> >   
> > +#include <dt-bindings/input/input.h>
> >   #include <dt-bindings/pwm/pwm.h>
> >   #include "rk3399.dtsi"
> >   
> > @@ -39,6 +40,19 @@ clkin_gmac: external-gmac-clock {
> >   		#clock-cells = <0>;
> >   	};
> >   
> > +	gpio_key_power: gpio-key-power {
> > +		compatible = "gpio-keys";
> > +		pinctrl-0 = <&pwrbtn_pin>;
> > +		pinctrl-names = "default";
> > +		status = "disabled";
> > +
> > +		button-pwrbtn-n {
> > +			gpios = <&gpio0 RK_PA1 GPIO_ACTIVE_LOW>;
> > +			label = "PWRBTN#";
> > +			linux,code = <KEY_POWER>;
> > +		};
> > +	};
> > +
> >   	vcc1v2_phy: vcc1v2-phy {
> >   		compatible = "regulator-fixed";
> >   		regulator-name = "vcc1v2_phy";
> > @@ -475,6 +489,14 @@ &pinctrl {
> >   	pinctrl-names = "default";
> >   	pinctrl-0 = <&q7_thermal_pin &bios_disable_override_hog_pin>;
> >   
> > +	buttons {
> > +		pwrbtn_pin: pwrbtn-pin {
> > +			rockchip,pins =
> > +				/* PWRBTN# */
> > +				<0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
> > +		};
> > +	};
> > +
> >   	gpios {
> >   		bios_disable_override_hog_pin: bios-disable-override-hog-pin {
> >   			rockchip,pins =
> 
> 






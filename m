Return-Path: <linux-kernel+bounces-364172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5258099CC37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082C81F239C5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052521AC427;
	Mon, 14 Oct 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2Abom9p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5691ABEC6;
	Mon, 14 Oct 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728914731; cv=none; b=azzGysZ8nsKYCct8fAbMTAQoKV6NO+o1sfa0uiy2ZCgWwBd6/ya6LU53k1MvyEOqAwBPDj+JVoU0dWBRKhBWysmqWAPv3KlNBHFVA7oktF7iRHrPwRnVydfhZLBuCLxWJlVWK9HwEZ0Y1r8f8o4I2y9uQKrXXZnBZazQopfNuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728914731; c=relaxed/simple;
	bh=UR9QzHv4Tlg7eSv5ldrag2JVOWLwv94dSbZYXgs2ksU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=nCse3PtMHBNNJ6utcdJgZxhhd1d+MT0vNwPaxP8EAZ+A3aDRNu4hZ+hHn0mOoELYqzQegpc8vebAjb1ADLYZ1NHreUwedo+KQauo051So+kT8vqtzJUWTmw6Cdt4N6zhCGlG0BZk7sDeIiiYDAbjtwzr5k7M7y2uSlU0vL1gfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2Abom9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BE5C4CEC3;
	Mon, 14 Oct 2024 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728914731;
	bh=UR9QzHv4Tlg7eSv5ldrag2JVOWLwv94dSbZYXgs2ksU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c2Abom9pwOo7M9hucnFxshR0LFAqMccXdVJbY+51XHlhOIRIVXYfURw0W9DZkGLmx
	 DVpKsnz1kc6twZG7MuX5BuCjV0pymh2GxrM2HPLjMs/bhelLMQs/x0Lcc5ZIPe2cFt
	 ZUfKvTy/Fqw0ag2nVZN+6RDJSCl0/72vRuxiygyW30NVPksesxCxW1NHXb8iEtDziP
	 q0b6uxtrV4052ZNNzdQy/mOc5NjGVv2wlFGk0YqqGa/z9xrkC4FIENaJEUJN/HHtTl
	 OxpZfWnGTavRpk3xCbms6WW0iVEsl8+s6jj6jao+Rl0kW6f4UFFtSU4NYcCuM6JNkq
	 WFbkkdDTuO+NA==
Date: Mon, 14 Oct 2024 09:05:30 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cenk Uluisik <cenk.uluisik@googlemail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>, Chris Morgan <macromorgan@hotmail.com>, 
 Andy Yan <andyshrk@163.com>, Jagan Teki <jagan@edgeble.ai>, 
 linux-arm-kernel@lists.infradead.org, Tim Lunn <tim@feathertop.org>, 
 linux-rockchip@lists.infradead.org, Dragan Simic <dsimic@manjaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, 
 Michael Riesch <michael.riesch@wolfvision.net>, Jing Luo <jing@jing.rocks>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jimmy Hon <honyuenkwun@gmail.com>
In-Reply-To: <20241014113026.78853-1-cenk.uluisik@googlemail.com>
References: <20241014113026.78853-1-cenk.uluisik@googlemail.com>
Message-Id: <172891445477.1127378.13874736914700071280.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] arm64: dts: rockchip: Add rk3588-orangepi-5b
 device tree and refactor


On Mon, 14 Oct 2024 13:29:55 +0200, Cenk Uluisik wrote:
> Implements a slightly modified rk3588s-orangepi-5b.dts
> from the vendor. Unfortunately the &wireless_bluetooth
> and &wireless_wlan are not implemented yet.
> 
> Bigger parts of the rk3588s-orangepi-5.dts file were
> moved into a new rk3588s-orangepi-5.dtsi file, so
> that both device trees from the orangepi-5 and 5b
> include from it and avoid including from the .dts.
> 
> This changes the Orange Pi 5's sdmmc alias to be mmc1,
> breaking existing users if they used the /dev/mmc0 device
> file, so it's consistent with all the other rk3588 DTS,
> which, is also the new default that rockchip wants to use.
> https://github.com/orangepi-xunlong/linux-orangepi/commit/bce92d16b230b8e93c2831fb7768839fd7bbab04
> Therefore also add the sdhc alias to be mmc0 on the
> rk3588s-orangepi-5b.dts.
> 
> How does this board differ from the original Orange Pi 5?
>   - the Orange Pi 5 has a M.2 NVMe M-key PCI 2.0x1
>     slot (hooked to combphy0_ps) whereas the Orange Pi 5b uses combphy0_ps
>     for the WiFi.
>   - The Orange Pi 5 with the M.2 socket has a regulator defined hooked to
>     "GPIO0_C5" (i.e. PCIE_PWREN_H) whereas the Orange Pi 5B has GPIO0_C5
>     hooked to BT_WAKE_HOST.
>   - builtin eMMC storage
>   - no SPI NOR flash (u-boot, preboot etc. initiates
>       from within the eMMC
>       storage)
>   - ap6275p Wifi module (like the Orange Pi 5 Plus)
>   - builtin BlueTooth module
> 
> Signed-off-by: Cenk Uluisik <cenk.uluisik@googlemail.com>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dts  | 798 +-----------------
>  ...orangepi-5.dts => rk3588s-orangepi-5.dtsi} |  36 +-
>  .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |  27 +
>  4 files changed, 73 insertions(+), 789 deletions(-)
>  rewrite arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts (95%)
>  copy arch/arm64/boot/dts/rockchip/{rk3588s-orangepi-5.dts => rk3588s-orangepi-5.dtsi} (96%)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dts
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-orangepi-5.dtb rockchip/rk3588s-orangepi-5b.dtb' for 20241014113026.78853-1-cenk.uluisik@googlemail.com:

arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dtb: gpio-func: leds-gpio: {'rockchip,pins': [[0, 2, 0, 245]], 'phandle': 253} is not of type 'array'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-consumer.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5b.dtb: vcc-3v3-sd-s0-regulator: Unevaluated properties are not allowed ('enable-active-low' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/fixed-regulator.yaml#







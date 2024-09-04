Return-Path: <linux-kernel+bounces-315157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500296BEAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4937E284923
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A021D9D97;
	Wed,  4 Sep 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Icl/vu/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2996E1DB929;
	Wed,  4 Sep 2024 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457005; cv=none; b=aGYsdfER0jcYnVi2sey7fq9yR9LppPKyel/5wf0c1oFtS/r9aLpOtMD4LWnJvVLkNCbruNhuHQQqjwIZK6b5l2iUsvpg+eNB5DcqEWh5/AJiJQtmq8xccAMoCvDLSfcth0K+v6qINBD6ewpjrBXSWGrUjYBGKOQqs7782tizrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457005; c=relaxed/simple;
	bh=oDjE+vXredknBm8QeGQHFI6cPwk2C9o9aiXVHeKEOvk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ngf7sSMpZGHuL2rT8bgpbIhpmu+Grhw7U30bChGtOZxLl7MQVMZAbIRm+OlN/90InnYNG//tapFPrSSPVNPSwUzm4Nc6kLOgis2ANTV/T589sNRD/rlkAKHBJ2YzfvzH9AAEKJQ3yGOwW/WLraDC5dkC/+hsoW+G7eks1CaZFqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Icl/vu/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78628C4CEC6;
	Wed,  4 Sep 2024 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725457004;
	bh=oDjE+vXredknBm8QeGQHFI6cPwk2C9o9aiXVHeKEOvk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Icl/vu/Wf1RLsvO9UJzE8rJ+8YBop70OmuI36qqXKJKayH+tv06QweaS4bP4ZvccR
	 1YpdAc+scFoqqiX/xBm0XAyYbGeDTFAecogVLZftdiSLbwaCxrdSoGtP8d0vytpA4p
	 YFYgN0Luj2eR0ivVh/AC3uVrDdBhPZv4qVatD526JlS/6PwprLTOw9G0K/T12uMhSz
	 RtnRGU7SAsdLnWeUVlXGNKDdFOBVMtylOpBC+UwEM364bx7Z2nw2b+XxF1NQjwlvkM
	 0JwhukaJMDDZ8lucNpvIa/B+i2aG04xpYOGtFFpnWpk+gnh4N/Ij9eVnv11gq5vlxX
	 t2Pj2hishU32A==
Date: Wed, 04 Sep 2024 08:36:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Jonas Karlman <jonas@kwiboo.se>, 
 linux-kernel@vger.kernel.org, FUKAUMI Naoki <naoki@radxa.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Dragan Simic <dsimic@manjaro.org>, Chukun Pan <amadeus@jmu.edu.cn>
In-Reply-To: <20240904111456.87089-1-bigfoot@classfun.cn>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
Message-Id: <172545685977.2410524.10394848640957143488.robh@kernel.org>
Subject: Re: [PATCH 0/3] Add support for Ariaboard Photonicat RK3568


On Wed, 04 Sep 2024 19:14:53 +0800, Junhao Xie wrote:
> Add dts for Ariaboard Photonicat RK3568.
> 
> This series bring support for:
> * Debug UART
> * SDIO QCA9377 WiFi and Bluetooth
> * M.2 E-Key PCIe WiFi and Bluetooth
> * M.2 B-Key USB Modem WWAN
> * Ethernet WAN Port
> * MicroSD Card slot
> * eMMC
> * HDMI Output
> * Mali GPU
> * USB Type-A
> 
> 
> Junhao Xie (3):
>   dt-bindings: vendor-prefixes: Add Shanghai Novotech Ariaboard
>   dt-bindings: arm: rockchip: Add Ariaboard Photonicat RK3568
>   arm64: dts: rockchip: add dts for Ariaboard Photonicat RK3568
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../rockchip/rk3568-ariaboard-photonicat.dts  | 598 ++++++++++++++++++
>  4 files changed, 606 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dts
> 
> --
> 2.46.0
> 
> 
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3568-ariaboard-photonicat.dtb' for 20240904111456.87089-1-bigfoot@classfun.cn:

arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dtb: phy@fe8c0000: 'phy-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/rockchip,pcie3-phy.yaml#
arch/arm64/boot/dts/rockchip/rk3568-ariaboard-photonicat.dtb: rfkill-modem: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/rfkill-gpio.yaml#







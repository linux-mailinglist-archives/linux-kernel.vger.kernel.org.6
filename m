Return-Path: <linux-kernel+bounces-170404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F087C8BD65D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54E01F22940
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E9115D5AB;
	Mon,  6 May 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYlx/Ohz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA515CD6B;
	Mon,  6 May 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028030; cv=none; b=NBlKAZrvG/41syyQprQmWF7Pn4B+5N/lF15Jn+iVy5XFxonyjUfLfgAJbaLSC/S4OPOcL6F/7EtO9kQSIFFwfJ3PCeq8LDGkfSafJUPyI7Abf3hyfFj5QigRQf27nHYTkZsyYZ+HpmpVcOolmrp1J8FeDv4S7zHQu6a2dVO/LRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028030; c=relaxed/simple;
	bh=W8JyiNuyGZ1ybRJ7NFoFHEw6kBYOtJo8wyxLY7egqCo=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jt874yNKzYVi96Ic71bTwoaXq40XdD+OsWGBJqMGEhp54UJfg2OyzthVNsvyXprISif0SZJBnt93TrjBJfEmOWkqhrGfmVPy2D/O16WJRxNB1PtGpRg6BeOpY5juDd/F0PVhs5YgrAocZCZHXe493l9XzaqPypGZJB7xOwxmJoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYlx/Ohz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320EFC3277B;
	Mon,  6 May 2024 20:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028029;
	bh=W8JyiNuyGZ1ybRJ7NFoFHEw6kBYOtJo8wyxLY7egqCo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EYlx/Ohz1LjUbmhzjGNEQ5sRbyH5aqCD1S0QtP44gkn0/P9SXLR2AxFTke0JWlI7m
	 p3qH3dZQ9pg/ScHDWSfZSkFM1S//fgw8EF8GyiX+YAZRZQHBk+nUw2fGZJtisZncPd
	 Di0rPOqMqWv9HG7ewBP7SrC2v+A37ppHeNveZEU6hAaaxaZqNCuel1L1in+GkGN7Uh
	 XhlDPVa2FrDGwkUcz6F9WMONkx/wEvc57gQTfbxmXeNpm7vitY1Pjhxx2JLooxaobs
	 GJA0gGzPwclTy1I2qveq6U5M8oZFEXjV9BXu7RkwOplVq3b4JpUM554v9XQg0A7xz/
	 He6ZOW75cC5DA==
Date: Mon, 06 May 2024 15:40:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Heiko Stuebner <heiko@sntech.de>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20240505202522.2999503-1-jonas@kwiboo.se>
References: <20240505202522.2999503-1-jonas@kwiboo.se>
Message-Id: <171502764382.89564.9287218118633077994.robh@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: rockchip: Add Xunlong Orange Pi 3B


On Sun, 05 May 2024 20:25:15 +0000, Jonas Karlman wrote:
> This series adds initial support for the Xunlong Orange Pi 3B board.
> 
> The Xunlong Orange Pi 3B is a single-board computer based on the
> Rockchip RK3566 SoC.
> 
> Schematic for Orange Pi 3B can be downloaded from:
> http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/service-and-support/Orange-Pi-3B.html
> 
> Jonas Karlman (2):
>   dt-bindings: arm: rockchip: Add Xunlong Orange Pi 3B
>   arm64: dts: rockchip: Add Xunlong Orange Pi 3B
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  .../boot/dts/rockchip/rk3566-orangepi-3b.dts  | 694 ++++++++++++++++++
>  2 files changed, 699 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b.dts
> 
> --
> 2.43.2
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3566-orangepi-3b.dtb' for 20240505202522.2999503-1-jonas@kwiboo.se:

arch/arm64/boot/dts/rockchip/rk3566-orangepi-3b.dtb: pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks', 'clock-names', 'clocks', 'codec' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk809.yaml#







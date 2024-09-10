Return-Path: <linux-kernel+bounces-323218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3795897399E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2CF281639
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3866E194C85;
	Tue, 10 Sep 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byP36he8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B1D192B74;
	Tue, 10 Sep 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977712; cv=none; b=cMcHp7hCK/21mtsUR97sgoEs1yutHrwuWPvyTDWsFVNducR7sJnySGbEI8+ako8p7uboFlD9DeJ3cfxCMB+N2msG5A7K2f2NIpojxzbhRkQFZpfNGLiVyeEdhpuhNFYsOO1pBVcp058ggH/pn+HGkKMCWUjXxWfMTaF9iqj087o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977712; c=relaxed/simple;
	bh=D9wCXUH6EHNFkoCXW6xHD/3H2QQ1E3dncGMC+EQoPrw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=UEu32gytiQo0xNygSF7o2VQ2uQSVdCQbRB5wxj719BkXe2QdXCRYV/zGwEgJiZ/QGvOiTWndPXAW8Ob2NrcF7HKYgibHw0MUS4bneWjBig2p8BokNuctXR6GEK510+IGe5bRGmCmvwLNCwaBH5zdmrSqAjvDoJWqcF1X3sTYDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byP36he8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4D2C4CED0;
	Tue, 10 Sep 2024 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725977712;
	bh=D9wCXUH6EHNFkoCXW6xHD/3H2QQ1E3dncGMC+EQoPrw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=byP36he8QtLLM7MQmE01OnnmZis9rGdU4JJt/aKur//gbNBk1IezoOt+JUwpNFyAB
	 2hdc5K1s+Q40Et0jB3L9L7ef3qtyUKoeqEsCFM/gwVqZQL9Yrv2LjfH0uB29HUxsHX
	 EunEuBr4WV/6AGetUHIkFq7uhPqy9+X6lwot/jS/fNlL76YK0NeaqSiGuS1af3v1fZ
	 4s/3C+gEVJ7ivlxW6vVst+4E+RRC4+v41Eopo5qYYREUmcPprRl2vmNq/IKAtNR8GI
	 ujd/+pblnYm5lah4yG7GkE98HNFGmPLIJiLwgjuXmtBo6GvsDPg0GV2ebtF1fdooHX
	 7P6hhNTBgmwiQ==
Date: Tue, 10 Sep 2024 09:15:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: sebastian.reichel@collabora.com, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, megi@xff.cz, linux-rockchip@lists.infradead.org, 
 efectn@protonmail.com, jonas@kwiboo.se, tim@feathertop.org, heiko@sntech.de, 
 macromorgan@hotmail.com, linux-arm-kernel@lists.infradead.org, 
 andyshrk@163.com, jagan@edgeble.ai, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, dsimic@manjaro.org, knaerzche@gmail.com, 
 alchark@gmail.com, boris.brezillon@collabora.com
In-Reply-To: <20240910124055.3981648-1-damon.ding@rock-chips.com>
References: <20240910124055.3981648-1-damon.ding@rock-chips.com>
Message-Id: <172597760954.3917281.2039520203138306566.robh@kernel.org>
Subject: Re: [PATCH v2 0/2] Add support for RK3588S Evaluation board


On Tue, 10 Sep 2024 20:40:53 +0800, Damon Ding wrote:
> Specification:
> - Rockchip RK3588S
> - RK806-2x2pcs + DiscretePower
> - eMMC5.1 + SPI Flash
> - Micro SD Card3.0
> - 1 x Typec3.0 + 2 x USB2 HOST
> - 1 x 1Lane PCIE2.0 Connector(RC Mode)
> - Headphone output
> - Array Key(MENU/VOL+/VOL-/ESC), Reset, Power on/off Key
> - 6 x SARADC
> 
> Damon Ding (2):
>   dt-bindings: arm: rockchip: Add rk3588s evb1 board
>   arm64: dts: rockchip: Add support for rk3588s evb1 board
> 
> Changes in v2:
> - rename amplifier nodes to amplifier-headphone and amplifier-speaker
> - sort audio and backlight nodes by node name
> - format names of regulator nodes to regulator-*
> - add CPU/memory regulator coupling
> - fix "VOP-" to "VOL-" in commit message
> - remove bootargs property in chosen node
> 
>  .../devicetree/bindings/arm/rockchip.yaml     |    5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |    1 +
>  .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 1131 +++++++++++++++++
>  3 files changed, 1137 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
> 
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588s-evb1-v10.dtb' for 20240910124055.3981648-1-damon.ding@rock-chips.com:

arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pcie@fe190000: Unevaluated properties are not allowed ('rockchip,skip-scan-in-resume' was unexpected)
	from schema $id: http://devicetree.org/schemas/pci/rockchip-dw-pcie.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: regulators:dcdc-reg1: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: regulators:dcdc-reg2: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: regulators:dcdc-reg3: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: regulators:dcdc-reg5: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: regulators:dcdc-reg6: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: regulators:dcdc-reg8: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: pmic@1: Unevaluated properties are not allowed ('regulators' was unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/rockchip,rk806.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: phy@fed80000: 'svid' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/phy/phy-rockchip-usbdp.yaml#







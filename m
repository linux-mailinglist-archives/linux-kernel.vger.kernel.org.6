Return-Path: <linux-kernel+bounces-447694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A49F3623
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D5E18813F4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04A207A19;
	Mon, 16 Dec 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goyJCFvz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8711885A5;
	Mon, 16 Dec 2024 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366567; cv=none; b=bWLhYyYlQ3OeFYoF2CpXzsBcprg6CkHT0aIpGo1pHlpZq954WY4gO7n4ULvTL7RfVD442xcr2mqCoiSDLgQNbxIkFT7/6dEPttP0vrI0PllBdQDCSV3JqXhzRi37/XeJYHnS6MtTKCscpAFhNd0Oenk3GWxvonsltpsgE+LI6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366567; c=relaxed/simple;
	bh=WswVB2hWDdgnFxBdwaN5lvCh0kjPGoHeFg1ZvRO82ZI=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=oYxhI5wMJdXiZfna1PV1WoKH83b1KBm2Qg3xxxFIYLKs0stoLVjh6ZQqLo/B7bKc33ZolodxPoeHygx4bjvvIWUGgxGJO60pcvBxcI4UkeEol2gRkv2yxh/v/6ecqQRe2D5JoJ2Rd0eYNjFkD2QJs4o1kXE3moDzedqB9OJQuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goyJCFvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0439C4CED0;
	Mon, 16 Dec 2024 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366567;
	bh=WswVB2hWDdgnFxBdwaN5lvCh0kjPGoHeFg1ZvRO82ZI=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=goyJCFvzUTX39mOU8MHSaApke2XyeTfNV6Q146PhWb1vXEyAm/vIcuEYSX+TivDlm
	 vR5zdoblHDb6unXxksGbUZaEmzSFCjvOMS3hEuQtnQ2ARS5oruE+tg+LgW3rX4jrt9
	 YXVnEE/kNjHuTUZH7nM6Hay2mTOTj0Fg+xRIIfRKC3w1Tr+G2UyWEfgiYJJmvhpCc8
	 uV2y0loOiftcx8ARDlOlXtqeQydoPMRBRw/1UgBw6/oR2XM66lpLyHDkcTjPUYcRkF
	 4cfCiacfWVBBbWJYJ2Sy+WwmV5ZLO+L1r8c5Og9u4CsTavf3djCk/pYAcsYfhU/M6n
	 3nux341egmGSg==
Date: Mon, 16 Dec 2024 10:29:22 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, vkoul@kernel.org, 
 sebastian.reichel@collabora.com, krzk+dt@kernel.org, 
 devicetree@vger.kernel.org, andy.yan@rock-chips.com, 
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org, 
 rfoss@kernel.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org, algea.cao@rock-chips.com, 
 conor+dt@kernel.org, heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 hjc@rock-chips.com, cristian.ciocaltea@collabora.com, 
 l.stach@pengutronix.de
To: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20241216031225.3746-1-damon.ding@rock-chips.com>
References: <20241216031225.3746-1-damon.ding@rock-chips.com>
Message-Id: <173436598997.265439.13057492933592323468.robh@kernel.org>
Subject: Re: [PATCH v2 00/11] Add eDP support for RK3588


On Mon, 16 Dec 2024 11:12:14 +0800, Damon Ding wrote:
> These patchs have been tested with a 1536x2048p60 eDP panel on
> RK3588S EVB1 board, and HDMI 1080P/4K display also has been verified
> on RK3588 EVB1 board.
> 
> Patch 1~3 are the RK3588 eDP support of Rockchip analogix_dp driver.
> Patch 4   is the eDP mode support of samsung hdptx phy driver.
> Patch 5~6 are the Rk3588 eDP support of Aanalogix DP driver. Add phy
>           interfaces is to configure the HDMI/eDP TX Combo PHY.
> Patch 7~8 are the renaming of hdptxphy node. It is not only used by
>           HDMI display but also for the eDP display.
> Patch 9   is the addition of RK3588 eDP0 node.
> Patch 10  is to enable the eDP0 display on RK3588S EVB1 board.
> Patch 11  is to add the eDP1 related nodes for RK3588 SoC.
> 
> Damon Ding (11):
>   drm/rockchip: analogix_dp: Use formalized struct definition for grf
>     field
>   dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
>   drm/rockchip: analogix_dp: Add support for RK3588
>   phy: phy-rockchip-samsung-hdptx: Add support for eDP mode
>   drm/bridge: analogix_dp: add support for RK3588
>   drm/bridge: analogix_dp: Add support for phy configuration.
>   dt-bindings: display: rockchip: Fix label name of hdptxphy for RK3588
>     HDMI TX Controller
>   arm64: dts: rockchip: Fix label name of hdptxphy for RK3588
>   arm64: dts: rockchip: Add eDP0 node for RK3588
>   arm64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board
>   arm64: dts: rockchip: Add nodes related to eDP1 for RK3588
> 
>  .../rockchip/rockchip,analogix-dp.yaml        |   1 +
>  .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml  |   2 +-
>  arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  33 +-
>  .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    |   2 +-
>  .../rockchip/rk3588-coolpi-cm5-genbook.dts    |   2 +-
>  .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   2 +-
>  .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |  55 +
>  .../rk3588-friendlyelec-cm3588-nas.dts        |   2 +-
>  .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   2 +-
>  .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   |   2 +-
>  .../dts/rockchip/rk3588-orangepi-5-plus.dts   |   2 +-
>  .../boot/dts/rockchip/rk3588-rock-5b.dts      |   2 +-
>  .../boot/dts/rockchip/rk3588-tiger-haikou.dts |   2 +-
>  .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   2 +-
>  .../boot/dts/rockchip/rk3588s-evb1-v10.dts    |  50 +
>  .../dts/rockchip/rk3588s-indiedroid-nova.dts  |   2 +-
>  .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  |   2 +-
>  .../boot/dts/rockchip/rk3588s-odroid-m2.dts   |   2 +-
>  .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi |   2 +-
>  .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   2 +-
>  .../boot/dts/rockchip/rk3588s-rock-5c.dts     |   2 +-
>  .../drm/bridge/analogix/analogix_dp_core.c    |   5 +
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  56 ++
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 149 ++-
>  .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 937 +++++++++++++++++-
>  include/drm/bridge/analogix_dp.h              |   3 +-
>  26 files changed, 1223 insertions(+), 100 deletions(-)
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


New warnings running 'make CHECK_DTBS=y rockchip/rk3588-coolpi-cm5-evb.dtb rockchip/rk3588-coolpi-cm5-genbook.dtb rockchip/rk3588-evb1-v10.dtb rockchip/rk3588-friendlyelec-cm3588-nas.dtb rockchip/rk3588-jaguar.dtb rockchip/rk3588-orangepi-5-plus.dtb rockchip/rk3588-rock-5b.dtb rockchip/rk3588-tiger-haikou.dtb rockchip/rk3588s-coolpi-4b.dtb rockchip/rk3588s-evb1-v10.dtb rockchip/rk3588s-indiedroid-nova.dtb rockchip/rk3588s-odroid-m2.dtb rockchip/rk3588s-rock-5a.dtb rockchip/rk3588s-rock-5c.dtb' for 20241216031225.3746-1-damon.ding@rock-chips.com:

arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: edp@fdec0000: resets: [[28, 469], [28, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dtb: edp@fdec0000: Unevaluated properties are not allowed ('#sound-dai-cells', 'reset-names', 'resets' were unexpected)
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-jaguar.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-friendlyelec-cm3588-nas.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-tiger-haikou.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-odroid-m2.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dtb: edp@fdec0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dtb: edp@fdec0000: resets: [[31, 469], [31, 468]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588s-rock-5c.dtb: edp@fdec0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: edp@fded0000: clock-names:2: 'grf' was expected
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: edp@fded0000: resets: [[31, 471], [31, 470]] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#
arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-genbook.dtb: edp@fded0000: reset-names: ['dp', 'apb'] is too long
	from schema $id: http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.yaml#







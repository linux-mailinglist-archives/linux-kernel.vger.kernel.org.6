Return-Path: <linux-kernel+bounces-332832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27C97BF6C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1211C220DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6401C9DDD;
	Wed, 18 Sep 2024 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onyM3H4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3378510A1C;
	Wed, 18 Sep 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726679220; cv=none; b=cUAhVeDWDhQjUqxJnUgOKwBZ8KMJfKwtDuwgj8NOD+ASHSq+erCfutxxu3Uxfbz6cuw4HlIIEFVoxlegSJubM+oZyY3zy0x/9tKG7DYqME8tEVBMa7Iq1dKu4ePyQTOxMA5I6byCk3QPytr0pv2M8CxAFTCFBdrd15iyDUlL5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726679220; c=relaxed/simple;
	bh=+HDf3q+sbF310Cwhvi+S25url1iCzDjqXFzg0SppkeE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GJlXBYcuGl6W9nvZSq/czSpzRR/JNUDGJc43m7Zxie0D8+DDKLEf68CI75/q9xVf7k5UFuW9dL9NHd30lzq6GQ87usQV5XNJySjfqucaUlEyYJTJc7XMkNhnPum4APgenQhOijlhTJ2J6iN6nNmLKC3FxW3J+AxUMissz/gFPLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onyM3H4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48176C4CEC2;
	Wed, 18 Sep 2024 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726679219;
	bh=+HDf3q+sbF310Cwhvi+S25url1iCzDjqXFzg0SppkeE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=onyM3H4RQSAqQlguwsZ001WuaWLCXtP0w9nmu0T1/MVSdhqguFeXjfjTYTcoUFtsB
	 r25dX3qg/FhS1Flk0t5o7acuwDJ2BN5kdBW3iE/Dr8UPpX8vubzwKNUkqonhK0B1iB
	 bsMKQjEf/bXnTEGoSthc2r1SWVNlVBkShpl/XEGGSSQjzk1B+WCzErkPkC6f8sHZRB
	 arfADccvYmQnMm6lEkCuPQ1w8O+sZps5/q5Nd33MiK14MOfWZl9t2SJmaJCQyt775T
	 p5bYrKW1Hxn3b8xdgRswJkuXhRIEHIjcuVMEeqpS2cmQvzpsXb4owP7mIGTe3cEBpI
	 ju6mNZsEGZUSQ==
Date: Wed, 18 Sep 2024 12:06:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Michal_Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Petr Benes <petr.benes@ysoft.com>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, linux-usb@vger.kernel.org, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Michael Walle <mwalle@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Herburger <gregor.herburger@ew.tq-group.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, imx@lists.linux.dev
In-Reply-To: <20240917151001.1289399-1-michal.vokac@ysoft.com>
References: <20240917151001.1289399-1-michal.vokac@ysoft.com>
Message-Id: <172667917680.1807230.4131958018210713774.robh@kernel.org>
Subject: Re: [PATCH 0/4] Add support for new IMX8MP based board


On Tue, 17 Sep 2024 17:09:57 +0200, Michal Vokáč wrote:
> Hi,
> 
> this series adds support for a new member in our IOTA platform.
> The board is based on the i.MX8MP SoC. The first two patches
> add support for most of the board functionality except USB Type-C
> port and some other minor things.
> 
> [PATCH 3] adds new device tree binding for a Diodes Incorporated
> PI5USB30213A Type-C Controller and [PATCH 4] enables that port on
> the IOTA2 Lumpy board.
> 
> We also wrote a driver for that Type-C port controller. I would like
> to get that driver upstream as well but I expect it will take much
> more iterations and effort to get it into mainline-ready shape so
> I intentionally excluded it from this series. AFAIK it should not
> be a problem to accept a device tree binding for a HW that does not
> have a driver in the kernel yet.
> 
> Michal Vokáč (2):
>   dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
>   arm64: dts: imx: Add imx8mp-iota2-lumpy board
> 
> Petr Benes (2):
>   dt-bindings: usb: Add Diodes Incorporated PI5USB30213A Type-C
>     Controller
>   arm64: dts: imx8mp-iota2: Enable the USB Type-C port
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  .../bindings/usb/diodes,pi5usb30213a.yaml     |  95 ++++
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 521 ++++++++++++++++++
>  4 files changed, 618 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/diodes,pi5usb30213a.yaml
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dts
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-iota2-lumpy.dtb' for 20240917151001.1289399-1-michal.vokac@ysoft.com:

arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pwm@30690000: 'pwm-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pwm/imx-pwm.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: usb@38200000: 'pinctrl-0' is a dependency of 'pinctrl-names'
	from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#







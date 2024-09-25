Return-Path: <linux-kernel+bounces-337895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E39850C5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEEA1C22C49
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890D114A4E2;
	Wed, 25 Sep 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khom1fzU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993B149C7B;
	Wed, 25 Sep 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229417; cv=none; b=oS4b2yBNCw+TH3j4RQtOcbE3Hjr8P1PV94s7o2lHICT4fYLQCCnxaQX3WpZxIR7F+sSyLydsiizeuf96tFh+yj9uvld8eV09RCrQ21DsE/XA8gdNHZq5wG/iqskAvVRLqpOpnfoGEIa5BRpEsre/Xl4+X1lgeZYCqVsJegFEP7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229417; c=relaxed/simple;
	bh=6gwL+zL2Lrbl0+gRCIRbQNsZBY+xx4uea05tk+MSwSQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Mi1qelIierVW8t5cr50eower5Gt68daNcsstr9Bu7tbs45O1Mwtx05mlrCv6yeJ8ilXmagAxgC7RbOG3O/fnRKDttSSn1zexgi5jt+Y7xNHkk5Mep61+JhWlleZMEZFW3nPfaey1PHxxMLb/hVn/cTt2XOHgTn+GgIxUtUeF4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khom1fzU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B35EC4CEC7;
	Wed, 25 Sep 2024 01:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727229416;
	bh=6gwL+zL2Lrbl0+gRCIRbQNsZBY+xx4uea05tk+MSwSQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=khom1fzUYKcHkLgiCMdtDYo7yOM98yuKAWTlEbtJLlvD8wDZg+3sTuxTIKZy5rhRe
	 4tr/20MP7unjCvghIfLopev2tylM3rpiNuTpB+mV/Q0XZxR4irOSdZeFjqXF2qtldp
	 ymapN5mgJNp7CdroiCQaVX4rEUFxQAuhf1VUdv9uyij9a6gOaqYv8k8NVY2Y9X3qyW
	 slzPfJok8fElj5Jc5VorNmQ553bai7gNut4upaUwtPixXHHed+G8Q940uukkHN3FSY
	 kVRc6ZEvbVkwB9ZhDVacB2fZdP7q1/nZLRYfwu9izn7ihSkaEl8yKfR7xtzMneFX9E
	 n5AW2NbQ0raoA==
Date: Tue, 24 Sep 2024 20:56:55 -0500
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
Cc: imx@lists.linux.dev, Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Herburger <gregor.herburger@ew.tq-group.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 Hiago De Franco <hiago.franco@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Petr Benes <petr.benes@ysoft.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-usb@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
 Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <20240924103941.1729061-1-michal.vokac@ysoft.com>
References: <20240924103941.1729061-1-michal.vokac@ysoft.com>
Message-Id: <172722910586.836022.2066040703589041608.robh@kernel.org>
Subject: Re: [PATCH v4 0/2] Add support for new IMX8MP based board


On Tue, 24 Sep 2024 12:39:39 +0200, Michal Vokáč wrote:
> Hi,
> this series adds support for a new member in our IOTA platform.
> The board is based on the i.MX8MP SoC. It adds support for most
> of the board functionality except USB Type-C port and some other
> minor things.
> 
> This series originally included the dt-binding for that Type-C
> port controller but I finally removed it based on a good comment
> from Krzysztof. I will post the Type-C binding including the driver
> in a followup series.
> 
> Michal
> 
> Michal Vokáč (2):
>   dt-bindings: arm: Add i.MX8MP IOTA2 Lumpy board
>   arm64: dts: imx: Add imx8mp-iota2-lumpy board
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mp-iota2-lumpy.dts | 423 ++++++++++++++++++
>  3 files changed, 425 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-iota2-lumpy.dtb' for 20240924103941.1729061-1-michal.vokac@ysoft.com:

arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#







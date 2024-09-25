Return-Path: <linux-kernel+bounces-339260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1091298640B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E664CB31131
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2F18DF76;
	Wed, 25 Sep 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FuMy2Gdi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8499418D65D;
	Wed, 25 Sep 2024 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727275001; cv=none; b=ABZRqJhO/1uWw6A4w+LdkOKJupNcgkF5FtFH65x7DdnEc3u8nKOlCS8Zpyyps3YtSMkHOKZJUdB+doB1zHzV5hb8Jjx7KQ8gWdDFliTBqam4Rlc1YYRShmUbA8KFCDg69nyon80DLwWOsFERRSnLP0KUT1179otZe94GmXmfciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727275001; c=relaxed/simple;
	bh=IRWh34M9eLXn2sq7ps5dZpSuJotvBM24SKsU7Cln6A4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Oa6hyqqR/gUwtgGp7ksT3KNvXWgM4Cm+GJ8vQeEluokJbWHPs90oB5b1uxySAlAFAPdpDIYcdfna4Y2pPEa7WOyXYlUb1hmaPQeWwsJDmt5nZvLvBj7TEHZxugnsDPZIdKrBImZCnIRSQdpYE3yw5f4Bz+ISFjgQsF2digdCAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FuMy2Gdi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16B4C4CEC7;
	Wed, 25 Sep 2024 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727275001;
	bh=IRWh34M9eLXn2sq7ps5dZpSuJotvBM24SKsU7Cln6A4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=FuMy2Gdi2xZhtaAjCok4TyOR1e3AHrcBxcbEfwcuNW83WBV6jQuFJjiXMGjoN7ctk
	 gaTBEnfoeUp6d7mgie3TcBqBDoPctPCoDYGX35Ozskt0ml67i7ZIBUl3icOAlLqxOS
	 AedfPM/Ji5si+wMnUBD42Uhsw3BRSiRucgb3ms8JXCydPLxkbpqLNJZremaBFgQmYS
	 CzN+YmRV12NpR+e1O/KOitU8+zRw14Rwaw7fSaE7h70yF1X7dNtdDExdzCwTdrnhau
	 xLOHk6boUuRky+qbYiIeQfPf7+FUpO4GQCuOirREWyo1cJQeWNHVu74P5X4HxQpwjG
	 B+RgNJYV23+0Q==
Date: Wed, 25 Sep 2024 09:36:40 -0500
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
Cc: Michael Walle <mwalle@kernel.org>, 
 Herburger <gregor.herburger@ew.tq-group.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-usb@vger.kernel.org, 
 Mathieu Othacehe <m.othacehe@gmail.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Petr Benes <petr.benes@ysoft.com>, Shawn Guo <shawnguo@kernel.org>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Hiago De Franco <hiago.franco@toradex.com>
In-Reply-To: <20240925124903.1837869-1-michal.vokac@ysoft.com>
References: <20240925124903.1837869-1-michal.vokac@ysoft.com>
Message-Id: <172727480975.1214083.15009186129806772241.robh@kernel.org>
Subject: Re: [PATCH v5 0/2] Add support for new IMX8MP based board


On Wed, 25 Sep 2024 14:49:01 +0200, Michal Vokáč wrote:
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-iota2-lumpy.dtb' for 20240925124903.1837869-1-michal.vokac@ysoft.com:

arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-iota2-lumpy.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#







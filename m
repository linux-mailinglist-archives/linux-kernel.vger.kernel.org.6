Return-Path: <linux-kernel+bounces-380317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C39AEC42
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C631F22816
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A721FC7F6;
	Thu, 24 Oct 2024 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8SZNPBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34921FC7C6;
	Thu, 24 Oct 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787597; cv=none; b=i2VtRA1UM+2VPDOw++sqnBcelkwMEWME14ao+dDAibebW5K1Oijlzemwx9gpDn62FZMvip+lM3qVtK5Tv9sUjYtUZGCiP8abi9BY6L75xqZWw0s1vqFFADsVeHGXa7WDFG9ViX8qDAtOC+r4oPWmZ3GaDz1+BoOAgV2ET7kBPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787597; c=relaxed/simple;
	bh=wcSvy++2WK9K7K4DB2BwQXIdYratvHoDhVpZn+pTHkE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=oUVM56Q8YbUKGlBGBbbJy8PmoEPJD7ZlkL0jlwvm0flwFvOgbm0h8mEfZys+sNtXtIzRZzZodxMYcI+qObekAS96GaFWBfpM+b149rDVZDgE883d2nE7d+jchWCid7XWR7ucSVA/B8dsFcWrdbPnRVKsoo8WPI5Yh+nK7JenE5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8SZNPBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C83C4CEC7;
	Thu, 24 Oct 2024 16:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787596;
	bh=wcSvy++2WK9K7K4DB2BwQXIdYratvHoDhVpZn+pTHkE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=K8SZNPBRMnGyYzoTxbLEDtIHajP6leNlRwDJRr7KVuXBS948RtOWKQXUbsdcHwuI3
	 Pyk87iQWjay5aijI06KAE6bn302HswGqSkyTsFEn03azdQVQRIN0kfVJfeUyIrpunZ
	 aR1XztGV2ldUuqslrYTLN2lmOcKMFq5SXG5hFx1703Pe60kbnWEZdHdpnrGsFaOnPy
	 PUeM7XoHibxYxzYewW2IIY25q4N3KTyaLth1xGduH+Qf7lW0f3agTCzAJwtkR86wPF
	 u758EkhJDrEjLH197/jpXci2SDFeC+V+7HjqD3ZV1KbOD3f9yACNDTuaFKlCfifgKW
	 aH7gfUWtvyL/w==
Date: Thu, 24 Oct 2024 11:33:16 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
Cc: Hiago De Franco <hiago.franco@toradex.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Michael Walle <mwalle@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Conor Dooley <conor+dt@kernel.org>, shawnguo@kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, imx@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 linux-kernel@vger.kernel.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
References: <20241023091231.10050-1-bhavin.sharma@siliconsignals.io>
Message-Id: <172978739819.623555.106741073057492931.robh@kernel.org>
Subject: Re: [PATCH v3 0/2] Add support Boundary Device Nitrogen8MP
 Universal SMARC Carrier Board


On Wed, 23 Oct 2024 14:41:13 +0530, Bhavin Sharma wrote:
> Add initial support for Nitrogen8MP Universal SMARC Carrier Board with
> Nitrogen8MP SMARC System on Module.
> 
> Change in V2:
> 
> in patch 1/2:
>         - Drop Unneeded line
>         - Correct the indentation
> 
> in patch 2/2:
>         - Add Acked-by tag
> 
> CHange in V3:
> 
> in patch 1/2:
> 	- In version 2, I forgot to add the Makefile. Adding it now.
> 
> Bhavin Sharma (2):
>   arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC
>     Carrier Board
>   dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC
>     Carrier Board
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   6 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 348 ++++++++++++++++++
>  .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
>  4 files changed, 372 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-som.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dts
> 
> --
> 2.43.0
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-nitrogen-smarc-universal-board.dtb' for 20241023091231.10050-1-bhavin.sharma@siliconsignals.io:

arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dtb: /soc@0/bus@30800000/i2c@30ae0000/gpio@20: failed to match any schema with compatible: ['microchip,mcp23018']







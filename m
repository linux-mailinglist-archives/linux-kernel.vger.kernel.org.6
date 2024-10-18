Return-Path: <linux-kernel+bounces-371705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78999A3EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24392B237E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B531D27BE;
	Fri, 18 Oct 2024 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTduBSeM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20B18EFD4;
	Fri, 18 Oct 2024 12:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255949; cv=none; b=IF9Y639luXcPQr/HNOwvHgiWkx+BV3JJhcF04U/bIZU+5swawA2PvFIuExk1jOOq/j7NUHqHy7qvtGmzq3A8r1tNROddlRyUj5wKj1cR5CWix65mx3//CJZOlAkaztyu2eWoYvWz0iuH+H9PJo253q2J8X8JzV6n5x2D7n71MHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255949; c=relaxed/simple;
	bh=zLhGtq2kJG928zd4YJeFVl0IvPVNahC24fHAKUF0Dgc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jooPon5dV3ylNfBeeNdhuAS6MPCkKt0RKa2cgIZIzkXfItaoeOJuPxfPmM2TIoubH3TKXngirltm/xDuQGXWVSYs2OmEF35McpcK0/dDPREzumO/kL4I4iJZzjOThN7guHIZ/upWfAPJDTP5otoaO0NNCeEnyUR1UjRPzbq5aN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTduBSeM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C693C4CED2;
	Fri, 18 Oct 2024 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729255948;
	bh=zLhGtq2kJG928zd4YJeFVl0IvPVNahC24fHAKUF0Dgc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aTduBSeM3EdRwNx+UqrtVxZmOm/mfIwcO+MtLFSbrNt3SpNqol86MwCpTFxzo3x1V
	 lQxDYeP8x/zD4HwYuLfbHFKcnPGFRQgS1ZaV+GEVl1bSPQ8OxnfVXB1iHClWpEPSSl
	 /mxajpq0vXz5nfg3UShvj3C8zRQqAhrmGMmTdxfJDgGYuuCMk0DS8cmYQdtN7Ia/7C
	 h88Mbc3Yzb6sSo0dZSuPOF5bF6AwMSYewLB8VtjVBpSAfaWJFeY8KHLMhkUcMCrlH5
	 UE0ki3QziMmfQIrJBTxOCT3rgJpydPnlyLIVTYz16nliuih2OvJTzmeLP90e/9P3Ua
	 RoC64uQsdHIGw==
Date: Fri, 18 Oct 2024 07:52:27 -0500
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
Cc: shawnguo@kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Peng Fan <peng.fan@nxp.com>, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, Hiago De Franco <hiago.franco@toradex.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Tim Harvey <tharvey@gateworks.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, imx@lists.linux.dev, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Michael Walle <mwalle@kernel.org>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
References: <20241018091023.29286-1-bhavin.sharma@siliconsignals.io>
Message-Id: <172925539932.17706.4264141268818363923.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add support Boundary Device Nitrogen8MP Universal
 SMARC Carrier Board


On Fri, 18 Oct 2024 14:39:26 +0530, Bhavin Sharma wrote:
> Add initial support for Nitrogen8MP Universal SMARC Carrier Board with
> Nitrogen8MP SMARC System on Module.
> 
> Bhavin Sharma (2):
>   arm64: dts: imx8mp: Add Boundary Device Nitrogen8MP Universal SMARC
>     Carrier Board
>   dt-bindings: arm: fsl: Add Boundary Device Nitrogen8MP Universal SMARC
>     Carrier Board
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   6 +
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../freescale/imx8mp-nitrogen-smarc-som.dtsi  | 349 ++++++++++++++++++
>  .../imx8mp-nitrogen-smarc-universal-board.dts |  17 +
>  4 files changed, 373 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-nitrogen-smarc-universal-board.dtb' for 20241018091023.29286-1-bhavin.sharma@siliconsignals.io:

arch/arm64/boot/dts/freescale/imx8mp-nitrogen-smarc-universal-board.dtb: /soc@0/bus@30800000/i2c@30ae0000/gpio@20: failed to match any schema with compatible: ['microchip,mcp23018']







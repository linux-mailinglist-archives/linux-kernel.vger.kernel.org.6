Return-Path: <linux-kernel+bounces-232503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEC891A9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27D031C229B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4788B1990BC;
	Thu, 27 Jun 2024 14:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ9QjJY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84410198A0A;
	Thu, 27 Jun 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499729; cv=none; b=R9fCZ6jTxQUyl0tKFzIBLk/nFNLO0XaLVTU3VSDS/3bT6Ox/tjq0nLRbYWO7Iygc+cQYI4JYpFxL3GTQCmwEwWbbtrheSxi4ullE1nvEZvGREiXhC4+74GkrL8cUS6yGm00F5Lv9gAT9G0FXnFTOmerntu/CIy85GKnTgqsy/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499729; c=relaxed/simple;
	bh=d8LbeMrXrnMpFcQld1fOek1N8Ag6qgXMrlSDVv0fOsQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rfPPP1my2Gr37JPT2BxEVGr1QtzJ7JHzSmxG8+FHOQ5twLcEaZJCfYBdyDWOP78im8KAtYhGNVQfRNGMRBKSjvWM28SOAFDxOzV3XFmcMMHDKQ+uVJAMX8okiXM2l8rzJoK+xU/RBWR7NkE1GsaYcOf5TbnjF0y5O+95wsIHND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ9QjJY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F2FC2BBFC;
	Thu, 27 Jun 2024 14:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719499729;
	bh=d8LbeMrXrnMpFcQld1fOek1N8Ag6qgXMrlSDVv0fOsQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UZ9QjJY26Q6BUnNdFz/EQvNr44kfvbyZqopalZ5LEWXrUykasUFhm6ooxqHC64iJd
	 1fisXuT/ZmKLKUrSuCCEb+CcixBy3ce3eHkO6EJipIPFeHbXb4CjDXMBJWpAJoY7BE
	 63SXgkCp1cyi+5EROFfBvEwxNRMvXpU4bSbZqdGVPFEMzIECpB+mOmSMoerW16IQPT
	 bZ7V+c8+mX7CDEm1Ss8Cf6a/Lm5TQprByolMrAb60N7nBs8E+mo+FTnu2w2zODqQU9
	 oTXWiu8SFJAwJVth3KOiM9drTaOethNl/tYVIX8Im8G8+rbZjDlB/16pP9JMtPo6tD
	 cz50r3MP26lBg==
Date: Thu, 27 Jun 2024 08:48:47 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, patrick@stwcx.xyz, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-aspeed@lists.ozlabs.org, amithash@meta.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
In-Reply-To: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
References: <20240627070013.2509150-1-peteryin.openbmc@gmail.com>
Message-Id: <171949936638.3312359.3954253966631367606.robh@kernel.org>
Subject: Re: [PATCH v2 00/10] Revise Meta(Facebook) Harma BMC(AST2600)


On Thu, 27 Jun 2024 15:00:02 +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
> 
> Base on: https://lore.kernel.org/all/CAPSyxFRj0twCJG6Lr5UZpznrUHyd_L0Reo=kZSFwCw3FNQ+x+A@mail.gmail.com/
> 
> Change log:
> 
> v1 -> v2
>   - Patch 0007  - add fru device
>   - Patch 0008  - add temperature device
>   - Patch 0009  - enable mctp controller
>   - Patch 00010 - fixed dtb_check warning
> 
> v1
>   - Patch 0001 - revise hsc chip
>   - Patch 0002 - add VR device
>   - Patch 0003 - add sgpio name
>   - Patch 0004 - add ina238
>   - Patch 0005 - add power monitor xdp710
>   - Patch 0006 - remove multi-host property
>   - Patch 0007 - remove pca9546
> 
> Peter Yin (10):
>   ARM: dts: aspeed: Harma: revise hsc chip
>   ARM: dts: aspeed: Harma: add VR device
>   ARM: dts: aspeed: Harma: add sgpio name
>   ARM: dts: aspeed: Harma: add ina238
>   ARM: dts: aspeed: Harma: add power monitor xdp710
>   ARM: dts: aspeed: Harma: remove multi-host property
>   ARM: dts: aspeed: Harma: add fru device
>   ARM: dts: aspeed: Harma: add temperature device
>   ARM: dts: aspeed: Harma: enable mctp controller
>   ARM: dts: aspeed: Harma: fixed dtb_check warning
> 
>  .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 146 ++++++++++++++++--
>  1 file changed, 132 insertions(+), 14 deletions(-)
> 
> --
> 2.25.1
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


New warnings running 'make CHECK_DTBS=y aspeed/aspeed-bmc-facebook-harma.dtb' for 20240627070013.2509150-1-peteryin.openbmc@gmail.com:

arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: ftgmac@1e690000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/faraday,ftgmac100.yaml#
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c@700/i2c-mux@70/i2c@0/power-monitor@61: failed to match any schema with compatible: ['isil,isl69260']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c@700/i2c-mux@70/i2c@0/power-monitor@62: failed to match any schema with compatible: ['isil,isl69260']
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dtb: /ahb/apb/bus@1e78a000/i2c@700/i2c-mux@70/i2c@0/power-monitor@63: failed to match any schema with compatible: ['isil,isl69260']







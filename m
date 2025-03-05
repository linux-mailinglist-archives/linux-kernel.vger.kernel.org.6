Return-Path: <linux-kernel+bounces-547121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9118A50332
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A137A2F30
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81324EF9F;
	Wed,  5 Mar 2025 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Foc64VcC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFDE24887F;
	Wed,  5 Mar 2025 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187396; cv=none; b=JMubI5+bc2YKLtQNaPtjWHLPx8CoPhZkjZOxpUCcLo4LPI+HDao0nRJwGW+Xbl5RyU/ADi0G2O+itCGJVDrwztDWdg+1D/1zEjdjtF8BgHiRwl6Vl9N21axovH+iOh+ZYUY9WSotyebq9jIN8mcPvCE9cUU0Q8enjFA5JQx0wQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187396; c=relaxed/simple;
	bh=KJ2n6qqivS8cfT5p3ck5BACWcFxyQHKwuyUCKJ1adwc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dQEXAdOizSu65HgMiW5I8kgUeHp2hq/1ZirQ2Ei/x83zO5W5oxIA3Yb+wnOv5GDI3xRsxMLemmlX1sruyxgcwNsBzgS87Vl8kp4NbG5dB4VPVo0gmSaBxGBGAsJnQlVpzdqYdxPROpwwK0EWLfOyPg3kRUBQGu+qAfE9EayR5CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Foc64VcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918C9C4CED1;
	Wed,  5 Mar 2025 15:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741187395;
	bh=KJ2n6qqivS8cfT5p3ck5BACWcFxyQHKwuyUCKJ1adwc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Foc64VcCsjkJX2XPNYKFjY/rY2tvFkBx0fPMjxxPmRCBlO0CPbiBAO2sQTT9/PPsp
	 3q0uYHmklJDSBvLK+//XKlnRBks0W0Q2t9WQ7gwiTXdZxHNluVSRsaGCnf2FgXgsI7
	 KmMy5XTgk+Xqqn1tplWiJW7P2JQ5Dvrv92EXS4XbP6Mh8JUXLP811GLMafGBWP2Kqw
	 fbunbDryDW70o3KzLjVJFgQzmWIAv70+qjGluGgBh+eubjHQTttDA5P0PtVlF8ZCHq
	 2KnArDxFlTKOjQhlUnjQBJ3R832yX+LEKuBZF1GYvifbdnnxLsNAY1GRLlCWg83uUP
	 pzWEOXoz5oNjQ==
Date: Wed, 05 Mar 2025 09:09:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: nicolas.ferre@microchip.com, mwalle@kernel.org, richard@nod.at, 
 vigneshr@ti.com, tudor.ambarus@linaro.org, alexandre.belloni@bootlin.com, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 claudiu.beznea@tuxon.dev, pratyush@kernel.org, 
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
To: Manikandan Muralidharan <manikandan.m@microchip.com>
In-Reply-To: <20250305100134.1171124-1-manikandan.m@microchip.com>
References: <20250305100134.1171124-1-manikandan.m@microchip.com>
Message-Id: <174118733199.1974433.9410395684855092118.robh@kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM
 framework to read MAC Address


On Wed, 05 Mar 2025 15:31:33 +0530, Manikandan Muralidharan wrote:
> From: Varshini Rajendran <varshini.rajendran@microchip.com>
> 
> EUI identifier and the MAC Address of the Ethernet Interface is stored
> after the SFDP table of contents starting at address 0x260 in the
> QSPI memory.
> Register the entire SFDP region read by the spi-nor (nor->sfdp) into the
> NVMEM framework and read the MAC Address when requested using the nvmem
> properties in the DT by the net drivers.
> 
> In kernel the Ethernet MAC address relied on U-Boot env variables or
> generated a random address, which posed challenges for boards without
> on-board EEPROMs or with multiple Ethernet ports.
> This change ensures consistent and reliable MAC address retrieval from QSPI,
> benefiting boards like the sama5d29 curiosity and sam9x75 curiosity.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> [manikandan.m@microchip.com: Integrate the nvmem->read callback framework]
> Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
> ---
>  drivers/mtd/spi-nor/sst.c | 62 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for 20250305100134.1171124-1-manikandan.m@microchip.com:

arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dtb: flash@0: Unevaluated properties are not allowed ('nvmem-layout' was unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/jedec,spi-nor.yaml#







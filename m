Return-Path: <linux-kernel+bounces-303305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E57B960A77
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6148B1C22BBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6501C0DE5;
	Tue, 27 Aug 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7+Z18bE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FBF1C0DC1;
	Tue, 27 Aug 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761905; cv=none; b=iY62kYqfLVNWWe1SW4zaoeqp9IfiSEx6Si/R4juMTAs9oyu+aue1QE1T4ugHHsH49FAhry9ePzYFj/HV7lYwkFkYbdGxo53M55N6YSQgVC6ksIefldxevU5lcyKUMraq4XxGTUy7vugO4E1DQtQme7A4Ro9xp360WltQxxJFNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761905; c=relaxed/simple;
	bh=QwZ9hyqHjmnVtoFMR5NhGSiqDvaaD2fnq6yLs9HobqM=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=izuzDJ62m/4aogzgOlilb3m2kbYZC3Hn7uu0aMdWBuqZASb0SNg4A0ysMyf2AOkyj2GfUNY+c2fgQstxk9filM0cn4FmmeeO9cjOV+mTIIqoST/+B0OO10dCelLUxyP8qb1r6yIhGq5/wspjk2dDqLcQHBosCt+VaTKcFnQy90Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7+Z18bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC06FC61050;
	Tue, 27 Aug 2024 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724761905;
	bh=QwZ9hyqHjmnVtoFMR5NhGSiqDvaaD2fnq6yLs9HobqM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=k7+Z18bExU1tPqXtk2zDlwID1vHuzCFTEBlveWrUDFthD/wsEmBzgdyc5gsBL9XFg
	 II/saCqySNAwtpA5jyaK/kTMdey5UGemndfnzrcrVZysCuBNmNAir7v6bDrQ7Xb2ue
	 euuKQS7E+sCGkhjPUMJb3y/B77Q4oMSo2FKYpUs/kocqyNa2G5OT/0VjcGxcqC5RYW
	 XxErVZr2BK3uS3zK3X0r416n5wAoZmevCKbeB72GVxs3+w6tl1XjWoz72kzThtEtmq
	 QWjsukuGNsii3SzlRQxO+4oEzU8C255d2rnAmxk+V9n4PCy3gqjg5hTx52+0L6gFjd
	 xbTRPCIDcJQxQ==
Date: Tue, 27 Aug 2024 07:31:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Chester Lin <chester62515@gmail.com>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Matthias Brugger <mbrugger@suse.com>, imx@lists.linux.dev, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240827084815.1931169-1-ciprianmarian.costea@oss.nxp.com>
References: <20240827084815.1931169-1-ciprianmarian.costea@oss.nxp.com>
Message-Id: <172476183961.3553344.11483964192483268443.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: s32g: Add S32G2/S32G3 uSDHC pinmux


On Tue, 27 Aug 2024 11:48:15 +0300, Ciprian Costea wrote:
> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> 
> Adding 100mhz & 200mhz pinmux support for uSDHC helps to support
> higher speed modes for SD (SDR50, DDR50, SDR104) and
> eMMC (such as HS200, HS400/HS400ES).
> 
> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi      | 153 ++++++++++++++++++
>  .../arm64/boot/dts/freescale/s32g274a-evb.dts |   4 +
>  .../boot/dts/freescale/s32g274a-rdb2.dts      |   4 +
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      | 153 ++++++++++++++++++
>  .../boot/dts/freescale/s32g399a-rdb3.dts      |   4 +
>  5 files changed, 318 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/s32g274a-evb.dtb freescale/s32g274a-rdb2.dtb freescale/s32g399a-rdb3.dtb' for 20240827084815.1931169-1-ciprianmarian.costea@oss.nxp.com:

arch/arm64/boot/dts/freescale/s32g274a-rdb2.dtb: pinctrl@4009c240: 'usdhc0-100mhzgrp', 'usdhc0-200mhzgrp', 'usdhc0grp' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
arch/arm64/boot/dts/freescale/s32g274a-evb.dtb: pinctrl@4009c240: 'usdhc0-100mhzgrp', 'usdhc0-200mhzgrp', 'usdhc0grp' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#
arch/arm64/boot/dts/freescale/s32g399a-rdb3.dtb: pinctrl@4009c240: 'usdhc0-100mhzgrp', 'usdhc0-200mhzgrp', 'usdhc0grp' do not match any of the regexes: '-pins$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/pinctrl/nxp,s32g2-siul2-pinctrl.yaml#







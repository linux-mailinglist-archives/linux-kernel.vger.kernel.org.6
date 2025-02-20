Return-Path: <linux-kernel+bounces-524746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5E6A3E695
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5EB84244C5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53C26563B;
	Thu, 20 Feb 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FcuzNLQ5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A73265624;
	Thu, 20 Feb 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086961; cv=none; b=rHUN1YkL7ybNAn1379dvyNxn827uTsnpuiE+4C47nDmWRkyyhzLRhno2L+TVlrMYjhgbscXp3RdP0XBWE/QGCbqkXeYX5xdnzwId8xnqr9UAkNNMv+3PlcgF8x4tMsI42/7UM3G8d/KqnktbUhiKDRit5oc0cgrisHfYxsBgqaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086961; c=relaxed/simple;
	bh=kfvzeMKrGQuu+01M2Wgm2/ThWI4eKODKRyAcGfYZ6CQ=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PPuIyM8Psjjg4Rvn7JKKjjqOyCsQY4tsqXdLnrBOM2wQyZbUh1V/BRUt4XefGbToTPSC3rXWSOWGJfr2IfDn3SZHi0WmFJRtfDudZ0cXNxPQv4x8pj6j/8Fs0fRsvfzAcv4V6sSvgxVizZYr0aNr6e4z/+pG60UeKkSdEATcKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FcuzNLQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77EAC4CED1;
	Thu, 20 Feb 2025 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086961;
	bh=kfvzeMKrGQuu+01M2Wgm2/ThWI4eKODKRyAcGfYZ6CQ=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=FcuzNLQ5WVZKv5WbLvImuWazV+d2CjJj4FpNf2RmqYN5Pbk75kP9Ya65yAVAbjKZa
	 gxHuAWlMv74eZZ7ppU+Covz7UaFB8yPn9Ct56a2D/umtfcSGwW1Y9PNgmScip66FIi
	 +Xnmq//rBAfzsMy34TuL8OjC7cXjSt9YEJMEElTBdzij3aWIpIRq7bwU31hjD44K0z
	 f40deeAqSSHnw5oW/SfU1VLyrB6TFNNWN85Ui0atgu4Giap4uUN6uJdaPZ72v+Rdph
	 +sYOCJVDNG5xNOGP9dd3/YUUbUWZzYVm0eKQgUgk1FOHI/4aauIuLvmDZDmep0eaGK
	 WBLFoUJYHtXvQ==
Date: Thu, 20 Feb 2025 15:29:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, imx@lists.linux.dev, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
References: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
Message-Id: <174008661875.4046844.10682813158644154393.robh@kernel.org>
Subject: Re: [PATCH v3 0/4] arm64: dts: add imx95_15x15_evk boards support


On Thu, 20 Feb 2025 11:11:15 -0500, Frank Li wrote:
> Add related binding doc.
> 
> Add imx95_15x15_evk boards, which have big difference with imx95_19x19_evk
> boards.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v3:
> - Add Rob and Conor's ack tags
> - Remove undocument property (need doube check why dtb-check have not
> report warning).
> 
> - Link to v2: https://lore.kernel.org/r/20250114-imx95_15x15-v2-0-2457483bc99d@nxp.com
> 
> Changes in v2:
> - fixed typo 'inctrl-names'.
> - Link to v1: https://lore.kernel.org/r/20250113-imx95_15x15-v1-0-8c20cbaab9ed@nxp.com
> 
> ---
> Frank Li (4):
>       dt-bindings: arm: fsl: add i.MX95 15x15 EVK board
>       arm64: dts: imx95: Add #io-channel-cells = <1> for adc node
>       arm64: dts: imx95: Add i3c1 and i3c2
>       arm64: dts: imx95: Add imx95-15x15-evk support
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml    |    1 +
>  arch/arm64/boot/dts/freescale/Makefile            |    1 +
>  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1062 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi          |   27 +
>  4 files changed, 1091 insertions(+)
> ---
> base-commit: 50a0c754714aa3ea0b0e62f3765eb666a1579f24
> change-id: 20250110-imx95_15x15-6a64db8c0187
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com:

arch/arm64/boot/dts/freescale/imx95-15x15-evk.dtb: pcie@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml#
arch/arm64/boot/dts/freescale/imx95-15x15-evk.dtb: pcie@4c380000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml#







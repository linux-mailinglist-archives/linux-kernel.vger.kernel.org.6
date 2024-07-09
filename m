Return-Path: <linux-kernel+bounces-246167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE40592BE6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFA91F257A9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEC619D099;
	Tue,  9 Jul 2024 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7AFXYQg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FD1514DE;
	Tue,  9 Jul 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539011; cv=none; b=bNYgkjDc89EWYhy+KeB0G/L+CGVicYQS36JstB0+6ht9XtiR8oCeTQWkSubEtipDnNTiwKPC2L5WqqZN1KqzD/HVThYx99lVsJta/ccgJOQN+0jbX6vWs/LTxB+EPABp1YOhvF5W3QMBx5ep8rC8XCDSUA+3KpQTWA6BpIcb780=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539011; c=relaxed/simple;
	bh=+ZQqls9Ki3eLB72qUlI4VM01dYMXVStw5ak0Hd2lE+M=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ebpCBcAkMbcCs7UdROeGXfsp2aDa2IZV78zg3K4awIOsgIRqFmDswJmIWpZUpWoRwqTiX0PLCf/APcGH4e5AXr5BJvjPMm8BmtAD0IQrbWhXA2pRm5dEeQdkEhoP31x0WYSBzzMaqLwlqpm5ntt/v5N1S+mq2B9tTyTyNT/12SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7AFXYQg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE69AC3277B;
	Tue,  9 Jul 2024 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720539011;
	bh=+ZQqls9Ki3eLB72qUlI4VM01dYMXVStw5ak0Hd2lE+M=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=i7AFXYQguJeWjmOqz9Ncvilo/H7LDSdis3d86F0w4rZI+EeJPxk4CNR2fPFxI6DQt
	 E6TVsVGY+Jg0ZbgkUWIxisxs3vxApiAKTu8tBZyJ4HQ1U57IkfHImWKsHkwPyIHnxY
	 4eK4M0qupkxLG9e6jP1KoXwb9ezFoxNwj5aElhzELn4YN/Hc0bo++eKPg2XmNeL4dK
	 DpU8XcM1iwRXblkDKcy5YP1EVgh0J/76imAX3vRGhpxGtHY7qdGHpuEGFna+Scve5D
	 9p1B/fGT/cditH56ZHavrfxnyVKqLCGa9O0ZM/2GOog1lft1YcsR07sBeFL3Ljr6h0
	 WtZwQD/ZPxy2g==
Date: Tue, 09 Jul 2024 09:30:09 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Inochi Amaoto <inochiama@outlook.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Thomas Gleixner <tglx@linutronix.de>, 
 Chao Wei <chao.wei@sophgo.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Chen Wang <unicorn_wang@outlook.com>, 
 Samuel Holland <samuel.holland@sifive.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
References: <20240709-sg2002-v3-0-af779c3d139d@bootlin.com>
Message-Id: <172053886159.3452537.17376675816752046144.robh@kernel.org>
Subject: Re: [PATCH v3 0/5] Add board support for Sipeed LicheeRV Nano


On Tue, 09 Jul 2024 12:07:15 +0200, Thomas Bonnefille wrote:
> The LicheeRV Nano is a RISC-V SBC based on the Sophgo SG2002 chip. Adds
> minimal device tree files for this board to make it boot to a basic
> shell.
> 
> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> ---
> Changes in v3:
> - Remove /dts-v1/ directive from sg2002.dtsi file
> - Add disable-wp property to sdhci node to avoid having a write
>   protected SD card
> - Drop changes in cv18xx.dtsi and cv1800b.dtsi
> - Add fallback compatible to cv1800b in SDHCI node of sg2002.dtsi
> - Link to v2: https://lore.kernel.org/r/20240612-sg2002-v2-0-19a585af6846@bootlin.com
> 
> Changes in v2:
> - Add SDHCI support
> - Change device tree name to match the Makefile
> - Add oscillator frequency
> - Add aliases to other UARTs
> - Add aliases to GPIOs
> - Move compatible for SDHCI from common DT to specific DT
> - Link to v1: https://lore.kernel.org/r/20240527-sg2002-v1-0-1b6cb38ce8f4@bootlin.com
> 
> ---
> Thomas Bonnefille (5):
>       dt-bindings: interrupt-controller: Add SOPHGO SG2002 plic
>       dt-bindings: timer: Add SOPHGO SG2002 clint
>       dt-bindings: riscv: Add Sipeed LicheeRV Nano board compatibles
>       riscv: dts: sophgo: Add initial SG2002 SoC device tree
>       riscv: dts: sophgo: Add LicheeRV Nano board device tree
> 
>  .../interrupt-controller/sifive,plic-1.0.0.yaml    |  1 +
>  .../devicetree/bindings/riscv/sophgo.yaml          |  5 ++
>  .../devicetree/bindings/timer/sifive,clint.yaml    |  1 +
>  arch/riscv/boot/dts/sophgo/Makefile                |  1 +
>  .../boot/dts/sophgo/sg2002-licheerv-nano-b.dts     | 54 ++++++++++++++++++++++
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi             | 32 +++++++++++++
>  6 files changed, 94 insertions(+)
> ---
> base-commit: d20f6b3d747c36889b7ce75ee369182af3decb6b
> change-id: 20240515-sg2002-93dce1d263be
> 
> Best regards,
> --
> Thomas Bonnefille <thomas.bonnefille@bootlin.com>
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


New warnings running 'make CHECK_DTBS=y sophgo/sg2002-licheerv-nano-b.dtb' for 20240709-sg2002-v3-0-af779c3d139d@bootlin.com:

arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dtb: mmc@4310000: compatible: ['sophgo,sg2002-dwcmshc', 'sophgo,cv1800b-dwcmshc'] is too long
	from schema $id: http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#
arch/riscv/boot/dts/sophgo/sg2002-licheerv-nano-b.dtb: mmc@4310000: Unevaluated properties are not allowed ('compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/mmc/snps,dwcmshc-sdhci.yaml#







Return-Path: <linux-kernel+bounces-564325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72FA652B2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BD7188401B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6426241C8C;
	Mon, 17 Mar 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRliIwH7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E598D2417D2;
	Mon, 17 Mar 2025 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221114; cv=none; b=eEJo+TmzXci4yDpqfGRYZ53qgVd0eLJ7Oh0I65dy8g4Gb9xBJgh1dDLtToqVQE3mtY8Z1UW6v87H/BgVuBj/1D6WosXCGGQlDiACOOtJSrLrDGNTvSH4UIFWlIcuvD3yM0gJIWGn7Vy7sJFJiH7DlsyzDCsmfcYBhfbOiG7/u1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221114; c=relaxed/simple;
	bh=IM+geYv9I4lQxYv0svGAAXnD8Yh3yBQXBX8Re0+OfXM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=FeHhgMhkzFK0vqoTSS/+LDafrS3Klc7T4U0fABybsVCa8v5Vpqq3v+ZfjASnK1Ovao72Z9oE07C5VVzJkIO+t+VBL/2f0Qt6vBZHCTZMim7O0lwSxZmo9MfXyXYR0eSJghyirLyTnRcu0WMNtdA6fHxn/UBTVuD8V4pigQtiSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRliIwH7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24269C4CEE3;
	Mon, 17 Mar 2025 14:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742221113;
	bh=IM+geYv9I4lQxYv0svGAAXnD8Yh3yBQXBX8Re0+OfXM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=KRliIwH7lSQSVNuW+ytxs9t6HzgpmCdyYfcBuuG66XAYWMXDfzzPeYg9smYtzYSJJ
	 EqT3VAUhiER8BL3KBHhXTobwuDcW4YO3sDtbxbQNuk1gdlv0X5Pz7F3nhdGLoKdy/F
	 ynbGCHoE/8sXyWvmBbjPPE1ei2m1zElzgiEt8MElHokxrirbwDTYsBmzV1IRpGESr9
	 obhvyRMy4SWlp7XvhAGSnp9CtEl3Dtx9CcA/+mrubYkjxd7pelEXVqtylWrUsLS3C6
	 QamIHJAMQ/j5QUGXn4YxZTJDCDkvlQ+GWqueeU+cxLg5V6RmfZOYfa9T4Mxx67HyOq
	 MabOTKrqjVelQ==
Date: Mon, 17 Mar 2025 09:18:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: sophgo@lists.linux.dev, Will Deacon <will@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, Chao Wei <chao.wei@sophgo.com>, 
 Chen Wang <unicorn_wang@outlook.com>, soc@lists.linux.dev, 
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Haylen Chu <heylenay@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 linux-riscv@lists.infradead.org, Inochi Amaoto <inochiama@gmail.com>, 
 devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
 Palmer Dabbelt <palmer@dabbelt.com>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
References: <20250316185640.3750873-1-alexander.sverdlin@gmail.com>
Message-Id: <174221818050.3957183.18032992749339066585.robh@kernel.org>
Subject: Re: [PATCH v5 0/7] arm64 support for Milk-V Duo Module 01 EVB


On Sun, 16 Mar 2025 19:56:30 +0100, Alexander Sverdlin wrote:
> This series adds very basic support for Milk-V Duo Module 01 EVB [1] in
> arm64 mode. The SoC (SG2000) is dual-arch, RiscV and ARM64, the latter has
> been chosen because the upstream toolchain can be utilized.
> 
> Sophgo SG2000 seems to be a continuation of the Cvitek CV18xx series, same
> peripherals with an addition of ARM64 core. Therefore it would be
> beneficial not to copy-paste the peripherals' device-tree, but rather split
> the most suitable riscv DT into ARCH-specific and peripherals parts and
> just include the latter on the arm64 side.
> 
> This series adds the device-tree for Milk-V Duo Module 01 EVB, which
> in turn contains Milk-V Duo Module 01 (separate .dtsi) on it, which has
> SG2000 SoC inside (separate .dtsi).
> 
> This series has been tested with Sophgo-provided U-Boot binary [2]: it
> boots from SD card; pinctrl, serial, GPIO drivers are functional (same
> as for RiscV-based CV18xx SoCs).
> 
> Partial SoC documentation is available [3].
> 
> This series lacks the support of:
> - USB
> - Audio
> - Ethernet
> - WiFi
> - Bluetooth
> - eMMC
> - Video
> 
> Changelog:
> v5:
> - PSCI node in DT
> v4:
> - minimized patch 1/7 (cleanups dropped)
> - cv18xx-cpu-intc.dtsi instead of cv18xx-cpu.dtsi+cv18xx-intc.dtsi in
> patch 1/7
> v3:
> - &cpus node has been moved into cv18xx-cpu.dtsi, &plic and &clint nodes
> were moved into cv18xx-intc.dtsi to reduce code duplication;
> v2:
> - dropped all patches related to the new reboot driver and corresponding DT
> and bindings;
> - grouped DT-related and config-related patches together;
> - added patch moving sophgo.yaml from riscv into soc (to share it with
> ARM); added SG2000 SoC and Milk-V Duo Module 01 EVB into it;
> - other changes are documented in the corresponding patches;
> 
> [1] https://milkv.io/docs/duo/getting-started/duo-module-01
> [2] https://github.com/milkv-duo/duo-buildroot-sdk-v2/releases/
> [3] https://github.com/sophgo/sophgo-doc/releases/download/sg2000-trm-v1.01/sg2000_trm_en.pdf
> 
> Alexander Sverdlin (7):
>   riscv: dts: sophgo: cv18xx: Move RiscV-specific part into SoCs' .dtsi
>     files
>   dt-bindings: soc: sophgo: Move SoCs/boards from riscv into soc, add
>     SG2000
>   arm64: dts: sophgo: Add initial SG2000 SoC device tree
>   arm64: dts: sophgo: Add Duo Module 01
>   arm64: dts: sophgo: Add Duo Module 01 Evaluation Board
>   arm64: Add SOPHGO SOC family Kconfig support
>   arm64: defconfig: Enable rudimentary Sophgo SG2000 support
> 
>  .../{riscv => soc/sophgo}/sophgo.yaml         |  7 +-
>  arch/arm64/Kconfig.platforms                  |  6 ++
>  arch/arm64/boot/dts/Makefile                  |  1 +
>  arch/arm64/boot/dts/sophgo/Makefile           |  2 +
>  .../sophgo/sg2000-milkv-duo-module-01-evb.dts | 31 +++++++
>  .../sophgo/sg2000-milkv-duo-module-01.dtsi    | 85 +++++++++++++++++
>  arch/arm64/boot/dts/sophgo/sg2000.dtsi        | 81 +++++++++++++++++
>  arch/arm64/configs/defconfig                  |  4 +
>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi       |  5 +
>  arch/riscv/boot/dts/sophgo/cv1812h.dtsi       |  5 +
>  arch/riscv/boot/dts/sophgo/cv181x.dtsi        |  2 +-
>  .../boot/dts/sophgo/cv18xx-cpu-intc.dtsi      | 54 +++++++++++
>  arch/riscv/boot/dts/sophgo/cv18xx.dtsi        | 91 +++++--------------
>  arch/riscv/boot/dts/sophgo/sg2002.dtsi        |  5 +
>  14 files changed, 309 insertions(+), 70 deletions(-)
>  rename Documentation/devicetree/bindings/{riscv => soc/sophgo}/sophgo.yaml (80%)
>  create mode 100644 arch/arm64/boot/dts/sophgo/Makefile
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dts
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01.dtsi
>  create mode 100644 arch/arm64/boot/dts/sophgo/sg2000.dtsi
>  create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-cpu-intc.dtsi
> 
> --
> 2.48.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/sophgo/' for 20250316185640.3750873-1-alexander.sverdlin@gmail.com:

arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dtb: psci: 'cpu_off' is a required property
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#
arch/arm64/boot/dts/sophgo/sg2000-milkv-duo-module-01-evb.dtb: psci: 'cpu_on' is a required property
	from schema $id: http://devicetree.org/schemas/arm/psci.yaml#







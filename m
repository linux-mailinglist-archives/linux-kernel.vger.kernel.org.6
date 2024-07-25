Return-Path: <linux-kernel+bounces-262302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBE193C3DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0BD1C20D61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5B19D06D;
	Thu, 25 Jul 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="FH2QxFUX"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01886FC2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916974; cv=none; b=Q9aFjKjNSDDFsjuAxeb7TYi1Dnxign0uus6/vsgQ/U/cI444uxxeJxXvulEY6n9hWe3LQbMjV+CgFTvoqifPFqxbKChFzGRKfMZF1Y9DIUDLh7ldZZCa6jcc87aPlvYiW68X9VAn5c6xF4jLMx+isF+BoBdHw1HU4kiLOpuGbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916974; c=relaxed/simple;
	bh=2jcVa9xd9EmD3N2PXwb84USFwACIUjUTVK9yXnsV46o=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0yRugVzEDobIU6x1oDqX5ec+GBl7MOU3fUZ4AooureG01XQN7vLD/0N1KXjZjt61JGyEC0Z9icEK0Ss0x0QlXDnInv7bYjnibhxDf7BXgHEY4lVKYfmu/BsadXCXqXKmcvci+fyquhV60QnyQEnG6TYfeX9D9CRkeZA6bxWHRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=FH2QxFUX; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6EA033F0B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1721916962;
	bh=YhBQIvhWVUOSgz5qZ7v7tT/CXtJTvBfA9fOVs7NBbOM=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=FH2QxFUXBy4vjHpbfYTw2RAwv2pbK8Uo/Gn+vK0JJCSagejOvtblZfHFYbuxdLiWH
	 01GL2atqg9GDBnIKQtLQAPoVE6n/UNIhXQrdFoE4lPh2aCgIVTlG9zYbPNbIQ4ApBw
	 ofh6fIXesKMbVODkt5hpG5CFOwbxhVV0o7PocvisfaExoSKwZmYZIBJwV08s4pdGTC
	 r/ShnDHahhaj3crQDMqsfPlQ8aj+y8kbnzSWoiF5/M+d/Z1Sovi8Wd9aHfA2f4igap
	 nsRcbis0kHYCY/Ocbs8UDbCgmWlbo/BloAoolEt3Fh64XUUbTcKWMbL3T3976TAmb0
	 t2CqJ6OWpG4Pg==
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5ce44027232so836152eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721916961; x=1722521761;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhBQIvhWVUOSgz5qZ7v7tT/CXtJTvBfA9fOVs7NBbOM=;
        b=gLfmEuIcrFM5Rf2AVPCVzEkrbkLIOKx+5FcAjXVj0dkCDMd/a2Bda+rseJhxE1DtZa
         PL7bD/w5DTArlb4NM0XTx9sh+RLYtt2xrl+oWECzlf9fyEMy5C45RgZ5g8TBwXknGHAg
         Q8su3JlqUmgNd2INcReKgUFmFDEc9LZC5ec/8kn2nWw+vqNSJGZ/1XDw+xya/mg6vQc/
         WUmbpGqRZoMJdWn5NpnwoFoHlzsrcD1olsMzzqV7YLOnE7hzmNCY5z/NZ1ESBN769Sq+
         pMWjWdQpRa+BhBV1QwOzkA8pvVBRCeqqtePzyUhkoWLOhPaB9UTKFxqVjrIQJHb3tTqi
         8I4g==
X-Forwarded-Encrypted: i=1; AJvYcCX3anHVbTxYH6z4dXz3MmTOfB9nqXNIb3m70SvPJjs3HJPNsAOLrrxi8hUUAJG+/Bkm8rVKw5kHr/k5RzvINGhDp++N0jX/b91mtY/0
X-Gm-Message-State: AOJu0Yz5SFthbhwRf6heQY3FXkcQcQHopXtnO+jTy9vSk2Lhnl8rLFwY
	Wx35E3NXoBxCxQW4FWdSjeNCJUBux47Wo9O8WCdgUvVDdPe9HKFJ7AboyqyaZVlRhhGzLBXYM2p
	KYZuCGi6CF/BzZYCDid+0z3dEJBurKq7CYegVvWGTk/fcQI8F+aPOe7gNzSmUDyvgzGE32ZJIpB
	uQoThG7KQJcfHXzro3fXTWflaDBg9PeV0aD6VnAmN+DUG5HKvRqay3
X-Received: by 2002:a05:6820:4b83:b0:5d5:bce7:677 with SMTP id 006d021491bc7-5d5bce7099dmr603256eaf.7.1721916960872;
        Thu, 25 Jul 2024 07:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv6nhl6mc/RaX9i/B6VHta/s2PL8UQ//pLghIaWGKAvpevHb84N9ylBjlF6GAJyBCi8T3JT4wKMh1W1ef+DK0=
X-Received: by 2002:a05:6820:4b83:b0:5d5:bce7:677 with SMTP id
 006d021491bc7-5d5bce7099dmr603201eaf.7.1721916960273; Thu, 25 Jul 2024
 07:16:00 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jul 2024 10:15:59 -0400
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20240725121609.13101-18-pierre-henry.moussay@microchip.com>
References: <20240725121609.13101-1-pierre-henry.moussay@microchip.com> <20240725121609.13101-18-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Thu, 25 Jul 2024 10:15:59 -0400
Message-ID: <CAJM55Z-4wbE8FCELpiaUJ4c_S4CqhP2w8Ube8c_b2uz3JpkRyg@mail.gmail.com>
Subject: Re: [PATCH 17/17] riscv: dts: microchip: add PIC64GX Curiosity Kit dts
To: pierre-henry.moussay@microchip.com, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

pierre-henry.moussay@ wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>
> The Curiosity-GX10000 (PIC64GX SoC Curiosity Kit) is a compact SoC
> prototyping board featuring a Microchip PIC64GX SoC
> PIC64GC-1000. Features include:
> - 1 GB DDR4 SDRAM
> - Gigabit Ethernet
> - microSD-card slot
>
> Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
> ---
>  arch/riscv/boot/dts/microchip/Makefile        |   1 +
>  .../dts/microchip/pic64gx-curiosity-kit.dts   | 114 ++++
>  arch/riscv/boot/dts/microchip/pic64gx.dtsi    | 616 ++++++++++++++++++
>  3 files changed, 731 insertions(+)
>  create mode 100644 arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts
>  create mode 100644 arch/riscv/boot/dts/microchip/pic64gx.dtsi
>
> diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
> index e177815bf1a2..78ba2952a164 100644
> --- a/arch/riscv/boot/dts/microchip/Makefile
> +++ b/arch/riscv/boot/dts/microchip/Makefile
> @@ -4,3 +4,4 @@ dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-m100pfsevp.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-polarberry.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-sev-kit.dtb
>  dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += mpfs-tysom-m.dtb
> +dtb-$(CONFIG_ARCH_MICROCHIP_POLARFIRE) += pic64gx-curiosity-kit.dtb
> diff --git a/arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts b/arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts
> new file mode 100644
> index 000000000000..2eda33689893
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/pic64gx-curiosity-kit.dts
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2020-2021 Microchip Technology Inc */
> +
> +/dts-v1/;
> +
> +#include "pic64gx.dtsi"
> +
> +/* Clock frequency (in Hz) of the rtcclk */
> +#define RTCCLK_FREQ	1000000
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "Microchip Pic64GX Curiosity Kit";

Hi Pierre-Henry,

Thanks for the patches! It looks like you forgot to add Ivan's fixup to the
model name so it matches the name in the HSS and u-boot. Eg.

  model = "Microchip PIC64GX Curiosity Kit";

/Emil

> +	compatible = "microchip,pic64gx-curiosity-kit", "microchip,pic64gx";
> +
> +	aliases {
> +		ethernet0 = &mac0;
> +		serial1 = &mmuart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	cpus {
> +		timebase-frequency = <RTCCLK_FREQ>;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x0 0x40000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hss: hss-buffer@bfc00000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x0 0xbfc00000 0x0 0x400000>;
> +			no-map;
> +		};
> +	};
> +};
> +
> +
> +&mac0 {
> +	status = "okay";
> +	phy-mode = "sgmii";
> +	phy-handle = <&phy0>;
> +
> +	phy0: ethernet-phy@b {
> +		reg = <0xb>;
> +	};
> +};
> +
> +&mbox {
> +	status = "okay";
> +};
> +
> +&mmc {
> +	bus-width = <4>;
> +	disable-wp;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +	sd-uhs-sdr12;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	no-1-8-v;
> +	status = "okay";
> +};
> +
> +&mmuart1 {
> +	status = "okay";
> +};
> +
> +&refclk {
> +	clock-frequency = <125000000>;
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&syscontroller {
> +	status = "okay";
> +};
> +
> +&gpio0 {
> +	status ="okay";
> +	gpio-line-names =
> +		"", "", "", "", "", "", "", "",
> +		"", "", "", "", "MIPI_CAM_RESET", "MIPI_CAM_STANDBY";
> +};
> +
> +&gpio1 {
> +	status ="okay";
> +	gpio-line-names =
> +		"", "", "LED1", "LED2", "LED3", "LED4", "LED5", "LED6",
> +		"LED7", "LED8", "", "", "", "", "", "",
> +		"", "", "", "", "HDMI_HPD", "", "", "GPIO_1_23";
> +};
> +
> +&gpio2 {
> +	status ="okay";
> +	gpio-line-names =
> +		"", "", "", "", "", "", "SWITCH2", "USR_IO12",
> +		"DIP1", "DIP2", "", "DIP3", "USR_IO1", "USR_IO2", "USR_IO7", "USR_IO8",
> +		"USR_IO3", "USR_IO4", "USR_IO5", "USR_IO6", "", "", "USR_IO9", "USR_IO10",
> +		"DIP4", "USR_IO11", "", "", "SWITCH1", "", "", "";
> +};
> diff --git a/arch/riscv/boot/dts/microchip/pic64gx.dtsi b/arch/riscv/boot/dts/microchip/pic64gx.dtsi
> new file mode 100644
> index 000000000000..2cf42e741ba9
> --- /dev/null
> +++ b/arch/riscv/boot/dts/microchip/pic64gx.dtsi
> @@ -0,0 +1,616 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/* Copyright (c) 2024 Microchip Technology Inc */
> +
> +/dts-v1/;
> +#include "dt-bindings/clock/microchip,pic64gx-clock.h"
> +
> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	model = "Microchip PIC64GX SoC";
> +	compatible = "microchip,pic64gx";
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		timebase-frequency = <1000000>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "sifive,e51", "sifive,rocket0", "riscv";
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <128>;
> +			i-cache-size = <16384>;
> +			reg = <0>;
> +			riscv,isa = "rv64imac";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "c", "zicntr",
> +					       "zicsr", "zifencei", "zihpm";
> +			clocks = <&clkcfg CLK_CPU>;
> +			status = "disabled";
> +
> +			cpu0_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "sifive,u54-mc", "sifive,rocket0",
> +				     "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <1>;
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm";
> +			clocks = <&clkcfg CLK_CPU>;
> +			tlb-split;
> +			next-level-cache = <&cctrllr>;
> +			status = "okay";
> +
> +			cpu1_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu2: cpu@2 {
> +			compatible = "sifive,u54-mc", "sifive,rocket0",
> +				     "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <2>;
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm";
> +			clocks = <&clkcfg CLK_CPU>;
> +			tlb-split;
> +			next-level-cache = <&cctrllr>;
> +			status = "okay";
> +
> +			cpu2_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu3: cpu@3 {
> +			compatible = "sifive,u54-mc", "sifive,rocket0",
> +				     "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <3>;
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm";
> +			clocks = <&clkcfg CLK_CPU>;
> +			tlb-split;
> +			next-level-cache = <&cctrllr>;
> +			status = "okay";
> +
> +			cpu3_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu4: cpu@4 {
> +			compatible = "sifive,u54-mc", "sifive,rocket0",
> +				     "riscv";
> +			d-cache-block-size = <64>;
> +			d-cache-sets = <64>;
> +			d-cache-size = <32768>;
> +			d-tlb-sets = <1>;
> +			d-tlb-size = <32>;
> +			device_type = "cpu";
> +			i-cache-block-size = <64>;
> +			i-cache-sets = <64>;
> +			i-cache-size = <32768>;
> +			i-tlb-sets = <1>;
> +			i-tlb-size = <32>;
> +			mmu-type = "riscv,sv39";
> +			reg = <4>;
> +			riscv,isa = "rv64imafdc";
> +			riscv,isa-base = "rv64i";
> +			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
> +					       "zicntr", "zicsr", "zifencei",
> +					       "zihpm";
> +			clocks = <&clkcfg CLK_CPU>;
> +			tlb-split;
> +			next-level-cache = <&cctrllr>;
> +			status = "okay";
> +			cpu4_intc: interrupt-controller {
> +				#interrupt-cells = <1>;
> +				compatible = "riscv,cpu-intc";
> +				interrupt-controller;
> +			};
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +			};
> +		};
> +	};
> +
> +	refclk: mssrefclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	syscontroller: syscontroller {
> +		compatible = "microchip,pic64gx-sys-controller",
> +			     "microchip,mpfs-sys-controller";
> +		mboxes = <&mbox 0>;
> +	};
> +
> +	scbclk: mssclkclk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <80000000>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		cctrllr: cache-controller@2010000 {
> +			compatible = "microchip,pic64gx-ccache",
> +				     "microchip,mpfs-ccache",
> +				     "sifive,fu540-c000-ccache", "cache";
> +			reg = <0x0 0x2010000 0x0 0x1000>;
> +			cache-block-size = <64>;
> +			cache-level = <2>;
> +			cache-sets = <1024>;
> +			cache-size = <2097152>;
> +			cache-unified;
> +			interrupt-parent = <&plic>;
> +			interrupts = <1>, <3>, <4>, <2>;
> +		};
> +
> +		clint: clint@2000000 {
> +			compatible = "sifive,fu540-c000-clint",
> +				     "sifive,clint0";
> +			reg = <0x0 0x2000000 0x0 0xC000>;
> +			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
> +					      <&cpu1_intc 3>, <&cpu1_intc 7>,
> +					      <&cpu2_intc 3>, <&cpu2_intc 7>,
> +					      <&cpu3_intc 3>, <&cpu3_intc 7>,
> +					      <&cpu4_intc 3>, <&cpu4_intc 7>;
> +		};
> +
> +		plic: interrupt-controller@c000000 {
> +			compatible = "sifive,fu540-c000-plic",
> +				     "sifive,plic-1.0.0";
> +			reg = <0x0 0xc000000 0x0 0x4000000>;
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			interrupts-extended = <&cpu0_intc 11>,
> +					      <&cpu1_intc 11>, <&cpu1_intc 9>,
> +					      <&cpu2_intc 11>, <&cpu2_intc 9>,
> +					      <&cpu3_intc 11>, <&cpu3_intc 9>,
> +					      <&cpu4_intc 11>, <&cpu4_intc 9>;
> +			riscv,ndev = <186>;
> +		};
> +
> +		pdma: dma-controller@3000000 {
> +			compatible = "microchip,pic64gx-pdma",
> +				     "microchip,mpfs-pdma",
> +				     "sifive,pdma0";
> +			reg = <0x0 0x3000000 0x0 0x8000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <5 6>, <7 8>, <9 10>, <11 12>;
> +			dma-channels = <4>;
> +			#dma-cells = <1>;
> +		};
> +
> +		clkcfg: clkcfg@20002000 {
> +			compatible = "microchip,pic64gx-clkcfg",
> +				     "microchip,mpfs-clkcfg";
> +			reg = <0x0 0x20002000 0x0 0x1000>,
> +			      <0x0 0x3E001000 0x0 0x1000>;
> +			clocks = <&refclk>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		ccc_se: clock-controller@38010000 {
> +			compatible = "microchip,pic64gx-ccc",
> +				     "microchip,mpfs-ccc";
> +			reg = <0x0 0x38010000 0x0 0x1000>,
> +			      <0x0 0x38020000 0x0 0x1000>,
> +			      <0x0 0x39010000 0x0 0x1000>,
> +			      <0x0 0x39020000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ccc_ne: clock-controller@38040000 {
> +			compatible = "microchip,pic64gx-ccc",
> +				     "microchip,mpfs-ccc";
> +			reg = <0x0 0x38040000 0x0 0x1000>,
> +			      <0x0 0x38080000 0x0 0x1000>,
> +			      <0x0 0x39040000 0x0 0x1000>,
> +			      <0x0 0x39080000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ccc_nw: clock-controller@38100000 {
> +			compatible = "microchip,pic64gx-ccc",
> +				     "microchip,mpfs-ccc";
> +			reg = <0x0 0x38100000 0x0 0x1000>,
> +			      <0x0 0x38200000 0x0 0x1000>,
> +			      <0x0 0x39100000 0x0 0x1000>,
> +			      <0x0 0x39200000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		ccc_sw: clock-controller@38400000 {
> +			compatible = "microchip,pic64gx-ccc",
> +				     "microchip,mpfs-ccc";
> +			reg = <0x0 0x38400000 0x0 0x1000>,
> +			      <0x0 0x38800000 0x0 0x1000>,
> +			      <0x0 0x39400000 0x0 0x1000>,
> +			      <0x0 0x39800000 0x0 0x1000>;
> +			#clock-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		mmuart0: serial@20000000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20000000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <90>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg CLK_MMUART0>;
> +			status = "disabled"; /* Reserved for the HSS */
> +		};
> +
> +		mmuart1: serial@20100000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20100000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <91>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg CLK_MMUART1>;
> +			status = "disabled";
> +		};
> +
> +		mmuart2: serial@20102000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20102000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <92>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg CLK_MMUART2>;
> +			status = "disabled";
> +		};
> +
> +		mmuart3: serial@20104000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20104000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <93>;
> +			current-speed = <115200>;
> +			clocks = <&clkcfg CLK_MMUART3>;
> +			status = "disabled";
> +		};
> +
> +		mmuart4: serial@20106000 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x20106000 0x0 0x400>;
> +			reg-io-width = <4>;
> +			reg-shift = <2>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <94>;
> +			clocks = <&clkcfg CLK_MMUART4>;
> +			current-speed = <115200>;
> +			status = "disabled";
> +		};
> +
> +		/* Common node entry for emmc/sd */
> +		mmc: mmc@20008000 {
> +			compatible = "microchip,pic64gx-sd4hc", "cdns,sd4hc";
> +			reg = <0x0 0x20008000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <88>;
> +			clocks = <&clkcfg CLK_MMC>;
> +			max-frequency = <200000000>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi@20108000 {
> +			compatible = "microchip,pic64gx-spi",
> +				     "microchip,mpfs-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20108000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <54>;
> +			clocks = <&clkcfg CLK_SPI0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@20109000 {
> +			compatible = "microchip,pic64gx-spi",
> +				     "microchip,mpfs-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20109000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <55>;
> +			clocks = <&clkcfg CLK_SPI1>;
> +			status = "disabled";
> +		};
> +
> +		qspi: spi@21000000 {
> +			compatible = "microchip,pic64gx-qspi",
> +				     "microchip,coreqspi-rtl-v2";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x21000000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <85>;
> +			clocks = <&clkcfg CLK_QSPI>;
> +			status = "disabled";
> +		};
> +
> +		i2c0: i2c@2010a000 {
> +			compatible = "microchip,pic64gx-i2c",
> +				     "microchip,mpfs-i2c",
> +				     "microchip,corei2c-rtl-v7";
> +			reg = <0x0 0x2010a000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <58>;
> +			clocks = <&clkcfg CLK_I2C0>;
> +			clock-frequency = <100000>;
> +			status = "disabled";
> +		};
> +
> +		i2c1: i2c@2010b000 {
> +			compatible = "microchip,pic64gx-i2c",
> +				     "microchip,mpfs-i2c",
> +				     "microchip,corei2c-rtl-v7";
> +			reg = <0x0 0x2010b000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <61>;
> +			clocks = <&clkcfg CLK_I2C1>;
> +			clock-frequency = <100000>;
> +			status = "disabled";
> +		};
> +
> +		can0: can@2010c000 {
> +			compatible = "microchip,pic64gx-can",
> +				     "microchip,mpfs-can";
> +			reg = <0x0 0x2010c000 0x0 0x1000>;
> +			clocks = <&clkcfg CLK_CAN0>, <&clkcfg CLK_MSSPLL3>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <56>;
> +			status = "disabled";
> +		};
> +
> +		can1: can@2010d000 {
> +			compatible = "microchip,pic64gx-can",
> +				     "microchip,mpfs-can";
> +			reg = <0x0 0x2010d000 0x0 0x1000>;
> +			clocks = <&clkcfg CLK_CAN1>, <&clkcfg CLK_MSSPLL3>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <57>;
> +			status = "disabled";
> +		};
> +
> +		mac0: ethernet@20110000 {
> +			compatible = "microchip,pic64gx-macb",
> +				     "microchip,mpfs-macb",
> +				     "cdns,macb";
> +			reg = <0x0 0x20110000 0x0 0x2000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <64>, <65>, <66>, <67>, <68>, <69>;
> +			local-mac-address = [00 00 00 00 00 00];
> +			clocks = <&clkcfg CLK_MAC0>, <&clkcfg CLK_AHB>;
> +			clock-names = "pclk", "hclk";
> +			resets = <&clkcfg CLK_MAC0>;
> +			status = "disabled";
> +		};
> +
> +		mac1: ethernet@20112000 {
> +			compatible = "microchip,pic64gx-macb",
> +				     "microchip,mpfs-macb",
> +				     "cdns,macb";
> +			reg = <0x0 0x20112000 0x0 0x2000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <70>, <71>, <72>, <73>, <74>, <75>;
> +			local-mac-address = [00 00 00 00 00 00];
> +			clocks = <&clkcfg CLK_MAC1>, <&clkcfg CLK_AHB>;
> +			clock-names = "pclk", "hclk";
> +			resets = <&clkcfg CLK_MAC1>;
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio@20120000 {
> +			compatible = "microchip,pic64gx-gpio",
> +				     "microchip,mpfs-gpio";
> +			reg = <0x0 0x20120000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <51>, <51>, <51>, <51>,
> +				     <51>, <51>, <51>, <51>,
> +				     <51>, <51>, <51>, <51>,
> +				     <51>, <51>;
> +			clocks = <&clkcfg CLK_GPIO0>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <14>;
> +			status = "disabled";
> +		};
> +
> +		gpio1: gpio@20121000 {
> +			compatible = "microchip,pic64gx-gpio",
> +				     "microchip,mpfs-gpio";
> +			reg = <0x0 0x20121000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <52>, <52>, <52>, <52>,
> +				     <52>, <52>, <52>, <52>,
> +				     <52>, <52>, <52>, <52>,
> +				     <52>, <52>, <52>, <52>,
> +				     <52>, <52>, <52>, <52>,
> +				     <52>, <52>, <52>, <52>;
> +			clocks = <&clkcfg CLK_GPIO1>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <24>;
> +			status = "disabled";
> +		};
> +
> +		gpio2: gpio@20122000 {
> +			compatible = "microchip,pic64gx-gpio",
> +				     "microchip,mpfs-gpio";
> +			reg = <0x0 0x20122000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			interrupts = <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>,
> +				     <53>, <53>, <53>, <53>;
> +			clocks = <&clkcfg CLK_GPIO2>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			ngpios = <32>;
> +			status = "disabled";
> +		};
> +
> +		rtc: rtc@20124000 {
> +			compatible = "microchip,pic64gx-rtc",
> +				     "microchip,mpfs-rtc";
> +			reg = <0x0 0x20124000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <80>, <81>;
> +			clocks = <&clkcfg CLK_RTC>, <&clkcfg CLK_RTCREF>;
> +			clock-names = "rtc", "rtcref";
> +			status = "disabled";
> +		};
> +
> +		usb: usb@20201000 {
> +			compatible = "microchip,pic64gx-musb",
> +				     "microchip,mpfs-musb";
> +			reg = <0x0 0x20201000 0x0 0x1000>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <86>, <87>;
> +			clocks = <&clkcfg CLK_USB>;
> +			interrupt-names = "dma", "mc";
> +			status = "disabled";
> +		};
> +
> +		mbox: mailbox@37020000 {
> +			compatible = "microchip,pic64gx-mailbox",
> +				     "microchip,mpfs-mailbox";
> +			reg = <0x0 0x37020000 0x0 0x58>,
> +			      <0x0 0x2000318C 0x0 0x40>,
> +			      <0x0 0x37020800 0x0 0x100>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <96>;
> +			#mbox-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		syscontroller_qspi: spi@37020100 {
> +			compatible = "microchip,pic64gx-qspi",
> +				     "microchip,coreqspi-rtl-v2";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x37020100 0x0 0x100>;
> +			interrupt-parent = <&plic>;
> +			interrupts = <110>;
> +			clocks = <&scbclk>;
> +			status = "disabled";
> +		};
> +	};
> +};
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


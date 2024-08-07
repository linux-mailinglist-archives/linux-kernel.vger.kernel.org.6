Return-Path: <linux-kernel+bounces-277673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5910994A498
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA4D1F22328
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A841D0DE9;
	Wed,  7 Aug 2024 09:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C/C4fUa8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7A811E2;
	Wed,  7 Aug 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023703; cv=none; b=ueYSJulptumkhWTZWuLyAd6/m9v9b7Y44gUGcWfMUcAG8NBtnZo0UVixF4X9ig8L6rDGDgAx/OS48/cg51mVAp1TXuVRw1yS+ZhveWWDRsGkBpWkvXtlWRAzlM8Uu10dloriXG1tDvAkxREOekZ6F9XbFy678RF5ZO9mSjNUnEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023703; c=relaxed/simple;
	bh=vOdbbYqJjIlX1z7AQRTRNcyslPCdx+GgY/OyY+E+usY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L/7eI17Z95TmotXShDmzeOqWCDVQsef736wKN8K1E8xAq7U7RQu90m3DY/FJwLYYdrH+j8gxnbtpvJqnGm5DkH1ecToP5BM9t1TG1DUXWQ2hlhyH1VQ6Vi+fuGbNwkD6OY5dCXX1QfAximiqGwWJ/rfWWsypCh/Rrf/OKDxDfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C/C4fUa8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4779fYYL070264;
	Wed, 7 Aug 2024 04:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723023694;
	bh=J7C1bnDUwzXCr6cdigNI7HQc0LqSmsEEZKhpcHQnXFk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=C/C4fUa8c+0WL31dbIR8UIBRY1hv4FYaF4baY9YHexamNWT9KsLgVyc8A4L/cq3af
	 Twat4jCXexMRj2I4FLviQS+hVIz4HtMQYBJIHVQxabiHXts25++S88HVL3S9fsv/K0
	 ST8Xj0ldwYN8AFkB+6koBAbTniaaEdZMZfrNB0Nk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4779fYbE121762
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Aug 2024 04:41:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 04:41:33 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 04:41:33 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4779fT5T049762;
	Wed, 7 Aug 2024 04:41:30 -0500
Message-ID: <489a9116-0e13-456f-992f-3e265acd9253@ti.com>
Date: Wed, 7 Aug 2024 15:11:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] arm64: dts: ti: Add support for J742S2 EVM board
To: Manorit Chawdhry <m-chawdhry@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Udit Kumar <u-kumar1@ti.com>,
        Neha Malcom
 Francis <n-francis@ti.com>,
        Aniket Limaye <a-limaye@ti.com>
References: <20240731-b4-upstream-j742s2-v3-0-da7fe3aa9e90@ti.com>
 <20240731-b4-upstream-j742s2-v3-9-da7fe3aa9e90@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <20240731-b4-upstream-j742s2-v3-9-da7fe3aa9e90@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Manorit,

On 31/07/24 22:40, Manorit Chawdhry wrote:
> J742S2 EVM board is designed for TI J742S2 SoC. It supports the following
> interfaces:
> * 16 GB DDR4 RAM
> * x2 Gigabit Ethernet interfaces capable of working in Switch and MAC mode
> * x1 Input Audio Jack, x1 Output Audio Jack
> * x1 USB2.0 Hub with two Type A host and x1 USB 3.1 Type-C Port
> * x1 4L PCIe connector
> * x1 UHS-1 capable micro-SD card slot
> * 512 Mbit OSPI flash, 1 Gbit Octal NAND flash, 512 Mbit QSPI flash,
>    UFS flash.
> * x6 UART through UART-USB bridge
> * XDS110 for onboard JTAG debug using USB
> * Temperature sensors, user push buttons and LEDs
> * x1 GESI expander, x2 Display connector
> * x1 15-pin CSI header
> * x6 MCAN instances
>
> Link: https://www.ti.com/lit/ug/sprujd8/sprujd8.pdf (EVM user guide)
> Link: https://www.ti.com/lit/zip/SPAC001 (Schematics)
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>


For series,
Reviewed-By: Beleswar Padhi <b-padhi@ti.com>

> ---
>   arch/arm64/boot/dts/ti/Makefile                    |  4 ++++
>   arch/arm64/boot/dts/ti/k3-j742s2-evm.dts           | 26 ++++++++++++++++++++++
>   .../boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi   |  3 ++-
>   3 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index e20b27ddf901..1bf645726a10 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -119,6 +119,9 @@ dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-pcie0-pcie1-ep.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-quad-port-eth-exp1.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-j784s4-evm-usxgmii-exp1-exp2.dtbo
>   
> +# Boards with J742S2 SoC
> +dtb-$(CONFIG_ARCH_K3) += k3-j742s2-evm.dtb
> +
>   # Build time test only, enabled by CONFIG_OF_ALL_DTBS
>   k3-am625-beagleplay-csi2-ov5640-dtbs := k3-am625-beagleplay.dtb \
>   	k3-am625-beagleplay-csi2-ov5640.dtbo
> @@ -240,3 +243,4 @@ DTC_FLAGS_k3-j721e-common-proc-board += -@
>   DTC_FLAGS_k3-j721e-sk += -@
>   DTC_FLAGS_k3-j721s2-common-proc-board += -@
>   DTC_FLAGS_k3-j784s4-evm += -@
> +DTC_FLAGS_k3-j742s2-evm += -@
> diff --git a/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
> new file mode 100644
> index 000000000000..ac683bcbfe97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j742s2-evm.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/*
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * EVM Board Schematics: https://www.ti.com/lit/zip/SPAC001
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-j742s2.dtsi"
> +#include "k3-j784s4-j742s2-evm-common.dtsi"
> +
> +/ {
> +	model = "Texas Instruments J742S2 EVM";
> +	compatible = "ti,j742s2-evm", "ti,j742s2";
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		bootph-all;
> +		/* 16G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000003 0x80000000>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> index 068ceed4ea15..a7bb1857b4e8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-common.dtsi
> @@ -2,7 +2,8 @@
>   /*
>    * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
>    *
> - * EVM Board Schematics: https://www.ti.com/lit/zip/sprr458
> + * EVM Board Schematics(j784s4): https://www.ti.com/lit/zip/sprr458
> + * EVM Board Schematics(j742s2): https://www.ti.com/lit/zip/SPAC001
>    */
>   / {
>   	chosen {
>


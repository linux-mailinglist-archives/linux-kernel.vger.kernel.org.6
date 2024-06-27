Return-Path: <linux-kernel+bounces-233141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7568991B2C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA197283EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8F1A2FC6;
	Thu, 27 Jun 2024 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QOnWX2yz"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6013B58F;
	Thu, 27 Jun 2024 23:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531117; cv=none; b=I3oPrtNTaMMfFqRhx/kYV4/vhz5V1CJXd3AFgUa1T85FMwaY0Q9AYut9gzbXL/LNnagVVquN0f2tcyRUwoveFJEIPuO7hj14V7ftJrdM/6zdrhyaWiT6lTHCcvaYkT1J6WZ0Hg8pj8nvjB1zLbA7iM9PxMTDaPbXeegLhNZ0ajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531117; c=relaxed/simple;
	bh=C1+gA2ucMLJw1a2m+bqLiPYk8Bc88v6KLPaII+YyvYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tmk2b0H5+B8NTVFbD9fe3osVqQahPD97OUV2pCuAV1tboXBwymP2xl17fshZhX9wUQJ/rBSYNV2HnV1nYdDXNPTOuLlBtgDV/0vvAXIe44vEopRFMvHhulvc1KjDMn8Dkt5yzm6sGT7wYhHLQsw4uu0TaZn28kLIBBlB5tYu7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QOnWX2yz; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45RNVl3R064876;
	Thu, 27 Jun 2024 18:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719531107;
	bh=w5mZuuNcE7Xkp1x76DIFUq6yfiTcBZqMgG4awABhgIs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QOnWX2yzPKlly3Qr3lKqihyM26enXc+BpHRq/3hYu9quam6rduLCtLbEEqjSRzbr6
	 zAgZKs+KnSL1EQBmSjbaqJo+5uAf9Tb8nO3Bz2qnpu13LOeXWYjZQ1oY3TSbZrKfMT
	 sMg3piJFwoGq08L3XDvIe5r/u1PjjT81n030bvSk=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45RNVlGB007030
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Jun 2024 18:31:47 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jun 2024 18:31:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jun 2024 18:31:47 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45RNVkj3063647;
	Thu, 27 Jun 2024 18:31:46 -0500
Message-ID: <a53569ee-dc73-4f8f-8941-882ce9a648d9@ti.com>
Date: Thu, 27 Jun 2024 18:31:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm64: dts: ti: k3-j72xx-mcu-wakeup: add dedicated
 wakeup controller compatible
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>
References: <cover.1719210050.git.jan.kiszka@siemens.com>
 <f868fb7c0f26c464468e2e574bc5aaacdef06e2a.1719210050.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <f868fb7c0f26c464468e2e574bc5aaacdef06e2a.1719210050.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/24/24 1:20 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Each syscon node must come with a dedicated/specific compatible, which
> is also reported by dtbs_check:
> 
>    k3-j7200-common-proc-board.dtb: scm-conf@40f00000: compatible: ['syscon', 'simple-mfd'] is too short
> 
> Add one for the TI K3 AM654 MCU wakeup system controller used in J72xx
> SoCs.

Unfortunately this is not correct, this region is not an AM654 MCU system
controller, it is a J721e MCU system controller. Some registers are the same,
but others are not. So if labeled as a "ti,am654-system-controller" we would
not be able to add the rest of the child nodes only found on the J7x devices.

A more correct fix for the warning would be the following:

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index fccaabfb13482..5097d192c2b20 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -164,12 +164,16 @@ mcu_timer9: timer@40490000 {
                 ti,timer-pwm;
         };
  
-       mcu_conf: syscon@40f00000 {
-               compatible = "syscon", "simple-mfd";
-               reg = <0x00 0x40f00000 0x00 0x20000>;
+       mcu_conf: bus@40f00000 {
+               compatible = "simple-bus";
                 #address-cells = <1>;
                 #size-cells = <1>;
-               ranges = <0x00 0x00 0x40f00000 0x20000>;
+               ranges = <0x0 0x0 0x40f00000 0x20000>;
+
+               cpsw_mac_syscon: ethernet-mac-syscon@200 {
+                       compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
+                       reg = <0x200 0x8>;
+               };
  
                 phy_gmii_sel: phy@4040 {
                         compatible = "ti,am654-phy-gmii-sel";
@@ -420,7 +424,7 @@ cpsw_port1: port@1 {
                                 reg = <1>;
                                 ti,mac-only;
                                 label = "port1";
-                               ti,syscon-efuse = <&mcu_conf 0x200>;
+                               ti,syscon-efuse = <&cpsw_mac_syscon 0x0>;
                                 phys = <&phy_gmii_sel 1>;
                         };
                 };

I'll clean this up and post it for the other J7x devices tomorrow.

Andrew

> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi  | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi  | 2 +-
>   arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> index fccaabfb1348..3a78a3c1676d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
> @@ -165,7 +165,7 @@ mcu_timer9: timer@40490000 {
>   	};
>   
>   	mcu_conf: syscon@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
>   		reg = <0x00 0x40f00000 0x00 0x20000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> index 9349ae07c046..d68e33d71eb3 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
> @@ -35,7 +35,7 @@ k3_reset: reset-controller {
>   	};
>   
>   	mcu_conf: syscon@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
>   		reg = <0x0 0x40f00000 0x0 0x20000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> index 5ccb04c7c462..1edb71f4a1bb 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
> @@ -140,7 +140,7 @@ wkup_gpio_intr: interrupt-controller@42200000 {
>   	};
>   
>   	mcu_conf: syscon@40f00000 {
> -		compatible = "syscon", "simple-mfd";
> +		compatible = "ti,am654-system-controller", "syscon", "simple-mfd";
>   		reg = <0x0 0x40f00000 0x0 0x20000>;
>   		#address-cells = <1>;
>   		#size-cells = <1>;


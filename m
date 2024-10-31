Return-Path: <linux-kernel+bounces-390946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0D89B8057
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C14B1C21C11
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D681BD519;
	Thu, 31 Oct 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q6pixFk4"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FBD1BC07D;
	Thu, 31 Oct 2024 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392776; cv=none; b=H/Bi+2lDL0NI/etjq1E1dAdoFjTvHh5lS9PVJAg1NLhneSuWHZnUPhEsrR4I+jtePbDecQP/K0Wm/nZzCVLFC6ZMeIwHx8OCZTRzfHhIEDHfKpuqhum+y9q9RgDZ4J8GlQ3ZVAcvVfl8E8azR67zJTEnP+5jyZj07mUq/u/o3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392776; c=relaxed/simple;
	bh=luEuhY2NHbh+W5Mf5hekJwKMw2+9BoSebFMTzw2KDHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MEKBz9NsLmxejmWrEro2780q/p7rXeF6GKymDR6RH0U5Tcmdn/MEw0SAP2uJW3o41VSylkD39UgSPzjlWF+UOdsQ3r8FcsOupkMzk3A23nHiTKjfT8eUIAbaqSTfMlD92Z04gr6TwQLqL/WX9AI7PtDV2H4pSrIMyKbwUa4XstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q6pixFk4; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49VGdB8b075269;
	Thu, 31 Oct 2024 11:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730392751;
	bh=bXLrbm4rNgCxySzqegyMFNcdkSquFq5CB9anD4WpKE8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Q6pixFk4owkW+oYSI/1SbFcgjnq4y3gomOrgV3Jk/764nSfOhCcS+zvCfEegpMZRd
	 fr/2tvb2OCuOe8teDxxyyjx4XqVhCcZFNYMfj2AWBTzPylADq2Q4ZrSaK+SuyCj3bq
	 BXL3qHLX/Zxty7/yJ36oRszdpyTeCmkkmF2dlJYk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49VGdBvQ029782;
	Thu, 31 Oct 2024 11:39:11 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 31
 Oct 2024 11:39:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 31 Oct 2024 11:39:11 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49VGdAW7096539;
	Thu, 31 Oct 2024 11:39:10 -0500
Message-ID: <9b30cb03-8334-48ce-b23b-19df8e9f89f9@ti.com>
Date: Thu, 31 Oct 2024 11:39:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-evm: Add dt overlay to disable
 icssg for Linux
To: MD Danish Anwar <danishanwar@ti.com>, <vigneshr@ti.com>, <nm@ti.com>
CC: <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kristo@kernel.org>, <srk@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20241030114458.1358800-1-danishanwar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241030114458.1358800-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/30/24 6:44 AM, MD Danish Anwar wrote:
> Add k3-am642-evm-icssg1-disable.dtso overlay file that disables
> icssg1-eth from Linux so that icssg peripherals can be used by
> RTOS or some other OS running on R5 core.
> 

That was the point of putting icssg1-eth in its own overlay,
if you don't want to use ICSSG1 for Ethernet, just don't apply
k3-am642-evm-icssg1-dualemac.dtbo.

Andrew

> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>   arch/arm64/boot/dts/ti/Makefile               |  7 +--
>   .../dts/ti/k3-am642-evm-icssg1-disable.dtso   | 49 +++++++++++++++++++
>   2 files changed, 53 insertions(+), 3 deletions(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index 6bd06bd76b68..0fd95b7df5a8 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -76,6 +76,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am642-evm.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-nand.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-dualemac-mii.dtbo
> +dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-icssg1-disable.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-evm-pcie0-ep.dtbo
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-phyboard-electra-rdk.dtb
>   dtb-$(CONFIG_ARCH_K3) += k3-am642-sk.dtb
> @@ -235,8 +236,8 @@ k3-am62p5-sk-microtips-mf103hie-lcd2-dtbs := k3-am62p5-sk.dtb \
>   	k3-am62p5-sk-microtips-mf103hie-lcd2.dtbo
>   k3-am642-evm-icssg1-dualemac-dtbs := \
>   	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac.dtbo
> -k3-am642-evm-icssg1-dualemac-mii-dtbs := \
> -	k3-am642-evm.dtb k3-am642-evm-icssg1-dualemac-mii.dtbo
> +k3-am642-evm-icssg1-disable-dtbs := \
> +	k3-am642-evm.dtb k3-am642-evm-icssg1-disable.dtbo
>   k3-am642-evm-pcie0-ep-dtbs := \
>   	k3-am642-evm.dtb k3-am642-evm-pcie0-ep.dtbo
>   k3-am642-tqma64xxl-mbax4xxl-sdcard-dtbs := \
> @@ -323,7 +324,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
>   	k3-am62p5-sk-microtips-mf101hie-panel.dtb \
>   	k3-am62p5-sk-microtips-mf103hie-lcd2.dtb \
>   	k3-am642-evm-icssg1-dualemac.dtb \
> -	k3-am642-evm-icssg1-dualemac-mii.dtb \
> +	k3-am642-evm-icssg1-disable.dtb \
>   	k3-am642-evm-pcie0-ep.dtb \
>   	k3-am642-tqma64xxl-mbax4xxl-sdcard.dtb \
>   	k3-am642-tqma64xxl-mbax4xxl-wlan.dtb \
> diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso
> new file mode 100644
> index 000000000000..dc04e2999e97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am642-evm-icssg1-disable.dtso
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT overlay for enabling 2nd ICSSG1 port on AM642 EVM
> + *
> + * Copyright (C) 2020-2024 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "k3-pinctrl.h"
> +
> +&oc_sram {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	r5f0_0_sram: r5f0_0_sram@0 {
> +		reg = <0x0 0x180000>;
> +	};
> +};
> +
> +&main_r5fss0_core0 {
> +	sram = <&r5f0_0_sram>;
> +};
> +
> +&cpsw_port2 {
> +	status = "disabled";
> +};
> +
> +&icssg0 {
> +	status = "disabled";
> +};
> +
> +&icssg1 {
> +	status = "disabled";
> +};
> +
> +&ospi0 {
> +	status = "disabled";
> +};
> +
> +&mdio_mux_1 {
> +	status = "disabled";
> +};
> +
> +&icssg1_eth {
> +	status = "disabled";
> +};


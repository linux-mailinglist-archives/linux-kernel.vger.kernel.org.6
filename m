Return-Path: <linux-kernel+bounces-528972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453C7A41E83
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D87B169F98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1F233720;
	Mon, 24 Feb 2025 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H3N+dfyp"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7EF2571A0;
	Mon, 24 Feb 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740398759; cv=none; b=E4/Z3JyuM1kL3vLcqfx8g//aX659syWl+XMhOlehDQZV7GS+84YwXMv5widlmE718bwSqgVOSrWhH5OzK0NgW6x8AsUkPj42wUY0ZMnpDO+KG+R7g0G86o6sOaeE+wX1sSKBo2qvqqYLL5cfZcxjSfL4J05LRAbIDlLv8b6yKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740398759; c=relaxed/simple;
	bh=gbZMK59y7FwxsHSgwP+la5nktZVZ3d+fKs4Iy+HNUg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sNfIBHiGAEj7FbGg+IvqTOnQtJu8G3WGgAQTtAGlvYoErycEwRQEeQACnQVDruyP3XLp5wpu4NiHXiZcZD0qA7GYlWu8uzyjti8H6vuwYmStxl8HrxLsqDp1I22CtszbklOy4RoOTgLiISYaO9BD/u7/gfNOsfkPDA3MURorHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=H3N+dfyp; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51OC5pXW1484803
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Feb 2025 06:05:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740398751;
	bh=dKGBWYRfknZ7iK1RC8/+7OFUWMWukeU3pmJqdL1AngY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=H3N+dfypXQjQfq0xw7E48JTWB+hcyrs/gUd1D+jA6AACEWXNnA+ec9GO8nE7hWI4S
	 JBjQMfKEtgDPqKWgmGpvP1a8Py0FGmjeoy2YkF+k6P+ZZOMf7w6m2j+TjRiseRT8Yu
	 Avdu8dGhdl4Nf1izFiwKFbochlWOCAUiWo357940=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51OC5pJA008018
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 24 Feb 2025 06:05:51 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 24
 Feb 2025 06:05:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 24 Feb 2025 06:05:51 -0600
Received: from [172.24.227.245] (uda0132425.dhcp.ti.com [172.24.227.245])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51OC5lcd073883;
	Mon, 24 Feb 2025 06:05:48 -0600
Message-ID: <d6440feb-ea23-49f8-9886-82d0e2145f12@ti.com>
Date: Mon, 24 Feb 2025 17:35:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j784s4-j742s2-evm: Add overlay for
 PCIe NTB
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <kristo@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>
References: <20250202093636.2699064-1-s-vadapalli@ti.com>
 <20250202093636.2699064-3-s-vadapalli@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20250202093636.2699064-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 02/02/25 15:06, Siddharth Vadapalli wrote:
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso
> new file mode 100644
> index 000000000000..e44173f670fa
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-j742s2-evm-pcie-ntb.dtso
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-only OR MIT
> +/**
> + * DT Overlay for enabling NTB functionality using PCIE0 and PCIE1 instances of
> + * PCIe on the J784S4 EVM and the J742S2 EVM.
> + *
> + * J784S4 EVM Product Link: https://www.ti.com/tool/J784S4XEVM
> + * J742S2 EVM Product Link: https://www.ti.com/tool/J742S2XH01EVM
> + *
> + * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +/plugin/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +#include "k3-pinctrl.h"
> +
> +&{/} {
> +	epf_bus {


no underscore in node name please

> +		compatible = "pci-epf-bus";
> +
> +		ntb {
> +			compatible = "pci-epf-ntb";
> +			epcs = <&pcie0_ep>, <&pcie1_ep>;
> +			epc-names = "primary", "secondary";
> +			vendor-id = /bits/ 16 <0x104c>;
> +			device-id = /bits/ 16 <0xb012>;
> +			num-mws = <4>;
> +			mws-size = <0x100000>, <0x100000>, <0x100000>, <0x100000>;
> +		};
> +	};
> +};
> +

-- 
Regards
Vignesh
https://ti.com/opensource



Return-Path: <linux-kernel+bounces-413343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFCE9D17B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEEE281347
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA51DED5B;
	Mon, 18 Nov 2024 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KVXN7OIZ"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5A1A00F0;
	Mon, 18 Nov 2024 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953395; cv=none; b=PWgQF2+ZMq9SWlsDWCC/Ach+eF5oZr3XK8Kai8SzdCTu2xgDHEVCxfmPdBVssaBl6hR6xkpXOH8bMYuexc53Ahi2qEvRFHpteA9jilt94CAFu1feQjIcPWHYudNtq/YbY+upa9zrBGudF93Ei1lvEVdKsCsM80DcC9nYr+eOOrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953395; c=relaxed/simple;
	bh=H4oSE7HVUyoKj+vUHfuI0RA7wmaFbP8ILUIEuKzhu3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dbEbCn9isL7b0A/Ym7Bg7XxSYZqPa6al81gnMgMUyoaNwamefL097oVGb9i5Qw+cAPa7+wgri8MTOSZL05cf+y7QV3IabBec5gnbwtCBFhLJ4I2yRgiNFCuJzcr5AhV+pTAm87JMvtQnAkV6yUWTxKOegvedFE6ZYi633uMSzVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KVXN7OIZ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AII9l4v037017;
	Mon, 18 Nov 2024 12:09:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1731953387;
	bh=W3DiIdbG2eycU7DWHnoYve2Ov7P3w0dVTbef9Pr2ElA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=KVXN7OIZuIq2nVMjIP0ikWPXhBF8RrN6lsWz0oaTrNd3qg+KGsx4Tuz8Mopp3mY5B
	 DxF3TxkUBaRCJjND5ix4Rs13uXbDHMCERB/EwIqn2iclAuLHkn1H5qcAvgx5ACkkjJ
	 5wz0pMiBG/hrnwD0oyEum7hnYznUm2FZyRDt6REA=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AII9lId103887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Nov 2024 12:09:47 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 12:09:46 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 12:09:46 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AII9kl1073277;
	Mon, 18 Nov 2024 12:09:46 -0600
Message-ID: <c8834352-75a7-446e-95eb-809aaa5cb18b@ti.com>
Date: Mon, 18 Nov 2024 12:09:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am62l: add initial reference board
 file
To: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20241117-am62lx-v1-0-4e71e42d781d@ti.com>
 <20241117-am62lx-v1-2-4e71e42d781d@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20241117-am62lx-v1-2-4e71e42d781d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 11/17/24 11:34 PM, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add the initial board file for the AM62L3's Evaluation Module.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am62l3-evm.dts | 54 ++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
> new file mode 100644
> index 0000000000000..2d59389765cab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-am62l3-evm.dts
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0-only or MIT
> +/*
> + * Device Tree file for the AM62L3 Evaluation Module
> + * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
> + *
> + * Technical Reference Manual: https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-am62l3.dtsi"
> +
> +/ {
> +	compatible = "ti,am62l3-evm", "ti,am62l3";
> +	model = "Texas Instruments AM62L3 Evaluation Module";
> +
> +	aliases {
> +		serial2 = &main_uart0;

We usually have WKUP and MCU UARTs as serial0 and serial1, we don't
have that many, so we would never have serial1, only 0 and 2. Might
be time we drop this odd numbering convention, at least for AM62L
class parts..

> +	};
> +
> +	chosen {
> +		stdout-path = &main_uart0;
> +	};
> +
> +	memory@80000000 {
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> +		device_type = "memory";
> +		bootph-all;
> +	};
> +
> +	reserved-memory {

Not needed until you have something to reserve.

> +		ranges;
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +	};
> +};
> +
> +&pmx0 {
> +	main_uart0_pins_default: main_uart0-default-pins {
> +		pinctrl-single,pins = <
> +			AM62LX_IOPAD(0x01d4, PIN_INPUT, 1)	  /* (D7)  UART0_RXD */
> +			AM62LX_IOPAD(0x01d8, PIN_OUTPUT, 1)	  /* (A6)  UART0_TXD */
> +		>;
> +		bootph-all;
> +	};
> +};
> +
> +&main_uart0 {
> +	current-speed = <115200>;

current-speed is only for UARTs that can't detect their current speed,
our UART and driver can, so this line isn't needed.

Andrew

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&main_uart0_pins_default>;
> +	status = "okay";
> +	bootph-all;
> +};
> 


Return-Path: <linux-kernel+bounces-206204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD29005AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AE11F23AC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD01974F7;
	Fri,  7 Jun 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QjdSMNLT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9B319149E;
	Fri,  7 Jun 2024 13:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768447; cv=none; b=Rw5EUvZeyJ3QA8UGehkY+bt/dfB+03wIfyr3omxv/DgLzmZ6gUM1HNzetu/6Cz1WWWZW89eeNvBU6/uGhvFOzHaIcm+9cIgjfhUao68B1/dyNnxOLQEjf+yGW/Z1UHKcBZw34huaH6GBLLrZ40A+6hMyniwx5/NWWXn6z23VH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768447; c=relaxed/simple;
	bh=JVyDe9RXOoTpH8UhUIf8WoCT32z5wEtggQ1u8PWzvEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dxu3Al9abYr5AVI9iaaCPbaTLLi/ochfaqNxqhEBdXSfmQmpR9WscsUcRxEy9jpx7gwMb8MUsk3M5vxdbiq/MBxWY4+Sf7qSFhzvmMaOr65O2pkq5aTyGtiudMN4/3ekrsYhcMoYPXPrK7cvwa5Cp4RQBxxZd+K1ak13A8lRFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QjdSMNLT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 457Drxun008437;
	Fri, 7 Jun 2024 08:53:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717768439;
	bh=iQI4I7tJW6P7UMx0wD5pKAZVtrPk222xYrbCwWOHk+c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=QjdSMNLTI+pIF88P2kWcT9ZSZi20wqDp88oQDbv80GL3MZFszp4q08kxoytQ8SkeE
	 aF1Dzww5wEUSDhKxJdBHHc1pH8WClRUvLu7Pfr/fRyO+spf4oX0nnNQPQ1VadIezmV
	 u1dFj4wEQ9u6KWMKLw8DIUEkOlpqW15hsqZXX9Ao=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 457DrxhX030901
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Jun 2024 08:53:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Jun 2024 08:53:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Jun 2024 08:53:59 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 457DrwHu018908;
	Fri, 7 Jun 2024 08:53:59 -0500
Message-ID: <5b18692c-c98f-4183-a9f1-5fc264983dfe@ti.com>
Date: Fri, 7 Jun 2024 08:53:58 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: ti: k3-j722s-evm: Add memory carveouts
 for R5F and C7x
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vaishnav.a@ti.com>, <j-choudhary@ti.com>, <u-kumar1@ti.com>
References: <20240607090433.488454-1-b-padhi@ti.com>
 <20240607090433.488454-4-b-padhi@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240607090433.488454-4-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/7/24 4:04 AM, Beleswar Padhi wrote:
> From: Apurva Nandan <a-nandan@ti.com>
> 
> The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
> of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
> in MAIN voltage domain.
> 
> The Inter-Processor communication between the main A72 cores and these
> R5F and DSP remote cores is achieved through shared memory and
> Mailboxes. Thus, add the memory carveouts required for communication.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 103 ++++++++++++++++++++++++
>   1 file changed, 103 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index a51925deb43b8..b0b5b6c97b92d 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -49,12 +49,71 @@ secure_ddr: optee@9e800000 {
>   			no-map;
>   		};
>   
> +		wkup_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa0000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
>   		wkup_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>   			compatible = "shared-dma-pool";
>   			reg = <0x00 0xa0100000 0x00 0xf00000>;
>   			no-map;
>   		};
>   
> +		mcu_r5fss0_core0_dma_memory_region: mcu-r5fss-dma-memory-region@a1000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		mcu_r5fss0_core0_memory_region: mcu-r5fss-memory-region@a1100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa1100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_dma_memory_region: main-r5fss-dma-memory-region@a2000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		main_r5fss0_core0_memory_region: main-r5fss-memory-region@a2100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa2100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		c7x_0_dma_memory_region: c7x-dma-memory@a3000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c7x_0_memory_region: c7x-memory@a3100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa3100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		c7x_1_dma_memory_region: c7x-dma-memory@a4000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4000000 0x00 0x100000>;
> +			no-map;
> +		};
> +
> +		c7x_1_memory_region: c7x-memory@a4100000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x00 0xa4100000 0x00 0xf00000>;
> +			no-map;
> +		};
> +
> +		rtos_ipc_memory_region: ipc-memories@a5000000 {
> +			reg = <0x00 0xa5000000 0x00 0x1c00000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
>   	};
>   
>   	vmain_pd: regulator-0 {
> @@ -421,3 +480,47 @@ mbox_c7x_1: mbox-c7x-1 {
>   		ti,mbox-tx = <3 0 0>;
>   	};
>   };
> +
> +&wkup_r5fss0 {
> +	status = "okay";
> +};
> +
> +&wkup_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster0 &mbox_r5_0>;

These mboxes where added in the previous patch, why not add these
references in that patch? Or you could probably just merge the two
patches together as they are doing the same logical thing: enabling
remote cores for J722s-EVM.

Andrew

> +	memory-region = <&wkup_r5fss0_core0_dma_memory_region>,
> +			<&wkup_r5fss0_core0_memory_region>;
> +};
> +
> +&mcu_r5fss0 {
> +	status = "okay";
> +};
> +
> +&mcu_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5_0>;
> +	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
> +			<&mcu_r5fss0_core0_memory_region>;
> +};
> +
> +&main_r5fss0 {
> +	status = "okay";
> +};
> +
> +&main_r5fss0_core0 {
> +	mboxes = <&mailbox0_cluster3 &mbox_main_r5_0>;
> +	memory-region = <&main_r5fss0_core0_dma_memory_region>,
> +			<&main_r5fss0_core0_memory_region>;
> +};
> +
> +&c7x_0 {
> +	status = "okay";
> +	mboxes = <&mailbox0_cluster2 &mbox_c7x_0>;
> +	memory-region = <&c7x_0_dma_memory_region>,
> +			<&c7x_0_memory_region>;
> +};
> +
> +&c7x_1 {
> +	status = "okay";
> +	mboxes = <&mailbox0_cluster3 &mbox_c7x_1>;
> +	memory-region = <&c7x_1_dma_memory_region>,
> +			<&c7x_1_memory_region>;
> +};


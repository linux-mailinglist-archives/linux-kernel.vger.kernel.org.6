Return-Path: <linux-kernel+bounces-199269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB7D8D849F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9154F28D0E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100212EBE9;
	Mon,  3 Jun 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SoSDEYSE"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CE512E1ED;
	Mon,  3 Jun 2024 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717423796; cv=none; b=J6CGxCcCtxlesXGN/5KDh/lVqKlYqx5Wr6ageBJrAyJ3hJUaFaglI8ay5XX1Ty+iXBjN94N+Xb7kBERakRsELQ38PQIG8YpMWeqLnlMgmHhqW9aXcHN6FKQb3cTw1WUq9xdwPG5EDKPcla7KgGsaa2tbNTgXBv1QP5YMboiV+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717423796; c=relaxed/simple;
	bh=FQqaLmBaWDtSGtOuMjx2GHg2BieXKhdlIDZ/Msf5qAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q6n4zrZ59ltp1l1C2G9mMDvISU9zxIOmY4ZfO3InCj5wmU+arSJCP85WW/w64ZsL2WNWIhCPVUZiNDZeZEUOv4aTd3dT1/dYk5SHlV3nin2pZj2MLzVo05PBUnOmrSoqQ1PwreUBHBH2jVk6ErHEbDyXhDiEQzz4nZgofO7jBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SoSDEYSE; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453E9eWu022117;
	Mon, 3 Jun 2024 09:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717423780;
	bh=Eu5Np3YTXow4+O3qauwSXf1yWRKJT2/WJoEK+Fr2qT4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SoSDEYSEB4y9WCt03kIYLxW+qF3qz0VPuMvYL2j7DSGut2hm8B07jZpNdEx5M/2H+
	 t6bM2i38QmO1MaDgooomUib6pk7OV5w7wG1Aye5F/7gj0EbGYXUn6oNj7ApUFTU0SM
	 WviVJZ9cGJm1An9pPYsIozEny4foNJB8MxB100rU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453E9eKU003858
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 09:09:40 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 09:09:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 09:09:40 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453E9doE020923;
	Mon, 3 Jun 2024 09:09:39 -0500
Message-ID: <086fa11e-10f8-463d-8966-1a33a52a3146@ti.com>
Date: Mon, 3 Jun 2024 09:09:39 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rogerq@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>,
        <danishanwar@ti.com>, <srk@ti.com>
References: <20240601121554.2860403-1-s-vadapalli@ti.com>
 <20240601121554.2860403-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240601121554.2860403-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 6/1/24 7:15 AM, Siddharth Vadapalli wrote:
> The AM62P and J722S SoCs share most of the peripherals. With the aim of
> reusing the existing k3-am62p-{mcu,main,wakeup}.dtsi files for J722S SoC,
> rename them to indicate that they are shared with J722S SoC.
> 
> The peripherals that are not shared will be moved in the upcoming patches
> to the respective k3-{soc}-{mcu,main,wakeup}.dtsi files without "common" in
> the filename, emphasizing that they are not shared.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> No changelog since this patch is introduced in this version of the
> series.
> 
>   .../{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} | 2 +-
>   .../{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi}   | 2 +-
>   ...-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} | 2 +-
>   .../dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi}    | 6 +++---
>   arch/arm64/boot/dts/ti/k3-am62p5.dtsi                       | 2 +-
>   5 files changed, 7 insertions(+), 7 deletions(-)
>   rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
>   rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
>   rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
>   rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> similarity index 99%
> rename from arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index 900d1f9530a2..ea214f649ebd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
> - * Device Tree file for the AM62P main domain peripherals
> + * Device Tree file for the main domain peripherals shared by AM62P and J722S
>    * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> similarity index 98%
> rename from arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> index b973b550eb9d..a5dbaf3ff41b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
> - * Device Tree file for the AM62P MCU domain peripherals
> + * Device Tree file for the mcu domain peripherals shared by AM62P and J722S

s/mcu/MCU

Same for the other domains (WAKEUP, MAIN, MCU), makes it more clear these are names,
and not just adjectives for the domains.

>    * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> similarity index 97%
> rename from arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> index c71d9624ea27..ca493f4e1acd 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>   /*
> - * Device Tree file for the AM62P wakeup domain peripherals
> + * Device Tree file for the wakeup domain peripherals shared by AM62P and J722S

While we are here, might be good to add a newline here between the description
and the copyright line to match the other SoCs DT files.

Otherwise,

Acked-by: Andrew Davis <afd@ti.com>

>    * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>    */
>   
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
> similarity index 97%
> rename from arch/arm64/boot/dts/ti/k3-am62p.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
> index 94babc412575..d85d05e0792a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
> @@ -120,6 +120,6 @@ cbass_wakeup: bus@b00000 {
>   };
>   
>   /* Now include peripherals for each bus segment */
> -#include "k3-am62p-main.dtsi"
> -#include "k3-am62p-mcu.dtsi"
> -#include "k3-am62p-wakeup.dtsi"
> +#include "k3-am62p-j722s-common-main.dtsi"
> +#include "k3-am62p-j722s-common-mcu.dtsi"
> +#include "k3-am62p-j722s-common-wakeup.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> index 41f479dca455..b7bb04a7968f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> @@ -8,7 +8,7 @@
>   
>   /dts-v1/;
>   
> -#include "k3-am62p.dtsi"
> +#include "k3-am62p-j722s-common.dtsi"
>   
>   / {
>   	cpus {


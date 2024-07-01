Return-Path: <linux-kernel+bounces-235806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FD191D9EA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C2D1C20C64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BD18287D;
	Mon,  1 Jul 2024 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EDBJAGpq"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A9882498;
	Mon,  1 Jul 2024 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822431; cv=none; b=Xm0K44g1bFICnapdkJ8OZOdU2uexR73ZfhxFO3NdJhiIJaxrA/8ix1HxKJFOVlVXiqQaaRwOO9kdsRPuA0Mt93TMsSlRiEYe5xNromH13ijOf0F5mXqNs3EqrKe394bwaeSOVpgBC0CR4byU/cjEzBeqoFh3XvYBhu1NmGh7eTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822431; c=relaxed/simple;
	bh=xd/U9dyUy2ulluTXx0L+6mSovqdM0nN4dV3wEoXcDZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uOcSMC82ctfgyTy4K9HGwHxlbdPYyIwbxJgcBwa3Fq/T9hUswdpyqj08XJGQxbRnLXn9/JfdG1H4yAoTFT+U1eG4bkpBckcmGCt4PtTCZjw35suyvxEHvYpOmX99y5JAfs9ieKW5wavlSJ9odpCO54oh6TgKBV8mQlHKnML4SNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EDBJAGpq; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4618QwSb061709;
	Mon, 1 Jul 2024 03:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719822418;
	bh=dx5fKViDD8JtZlIf9rrAs7DN7RjC9vagC2aDKjhaS8k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=EDBJAGpqEWuazqRsVqXrcWMS+3vlkLnrfKrFvuXpbnXKULs8J2y480q0sKHy1z+5A
	 WCJfxaM0MqoWxgDXy9kOgmqJhnisTxM7USVMJbOFH/NTKz/Mi0rUoGE1dDS0IhX8Jq
	 E/AgxCU9tEUqm7W34UdUS2Dy5IP8N4iogDCsfcn0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4618Qvn6037759
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Jul 2024 03:26:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 03:26:57 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 03:26:57 -0500
Received: from [172.24.29.211] (lt5cd2489kgj.dhcp.ti.com [172.24.29.211])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4618Qr8G105771;
	Mon, 1 Jul 2024 03:26:54 -0500
Message-ID: <7bde6ad9-11c6-46ca-af92-9860dfbbbe3c@ti.com>
Date: Mon, 1 Jul 2024 13:56:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j7xx: Change timer nodes status to
 reserved
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <tony@atomide.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240607105559.771080-1-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240607105559.771080-1-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 6/7/2024 4:25 PM, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. Therefore, change the status of the timer nodes to
> "reserved" to avoid any clash.
>
> This change is already incorporated for timer nodes in the MCU voltage
> domain.
>
> Fixes: 835d04422f9d ("arm64: dts: ti: k3-j721s2: Add general purpose timers")
>
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  |  2 ++
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi  |  7 +++++++
>   arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi |  6 ++++++
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 10 ++++++++++
>   4 files changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index 9386bf3ef9f68..22351a4f3da6e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -1254,6 +1254,7 @@ main_timer0: timer@2400000 {
>   		assigned-clock-parents = <&k3_clks 49 2>;
>   		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
>   		ti,timer-pwm;
> +		status = "reserved";
>   	};
>   
>   	main_timer1: timer@2410000 {
> @@ -1266,6 +1267,7 @@ main_timer1: timer@2410000 {
>   		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 313 1>;
>   		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
>   		ti,timer-pwm;
> +		status = "reserved";
>   	};
>   
>   	main_timer2: timer@2420000 {

checked only on J7200, for Main MCU 1-0, Looks you need main_timer2 as 
well to get it working

Please verify on other SOCs as well for all firmwares, if some extra 
nodes needs to be added


> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 0da785be80ff4..944bdbb98e910 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> [..]


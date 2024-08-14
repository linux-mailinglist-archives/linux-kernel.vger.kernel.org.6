Return-Path: <linux-kernel+bounces-286808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B79951F3C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E061F22739
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CC71B8E9C;
	Wed, 14 Aug 2024 15:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LQUEMZ/X"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F821B86D6;
	Wed, 14 Aug 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651002; cv=none; b=e79bFxKig6ZtiIfqkOKvkr3rDhw9FX6qgdUWL8DQRj4erKh91PcR6Dp4dWyxDD3xsIGOkx0PZaW2DaeVCnUsnPQ7aAlHvA0a1zDYN+wQxAEk/NPHp23rRtCF+Mt14FCJAS8K0qk2Lto4ggCPCIYzVx82gWw16fkc5RVo+i5Vwac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651002; c=relaxed/simple;
	bh=vYX1a1MmqMr8/X+YQoiHlaqZccJOOMuyAUMSW2FO3Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WY9JnE2BX8vqmD0F2quAa6rZGIW2EEAW9MLlGUEU/LG9LnDr6DKrwH4L2d5RYlPB3ZeVIpV9ByX9SHDcDdF52s9pe3QnqdIBoNFPcLyevYmqd4aAXaZazkpMW+tcur4HcB6hpDZz2s4QU1uMuiToeDkkOiPXCMpt4BHJa5Hfofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=LQUEMZ/X; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47EFuW1v083903;
	Wed, 14 Aug 2024 10:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723650992;
	bh=YRT8ehnV3o4I8flR6HSeR9+yqpIGmlMs9sl5d5CY6cE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=LQUEMZ/XDJeJdgad4A4V1BAgQ85/cjWOuKJZ84H7V7GSlAn/2AksIWoOs6jP9j7Ak
	 vQTAWO6MKUoK5K1zFhKkzDv+FdF/3+bOp+RttEvzCCLk0EGFNAWApq07lKQ21msg+T
	 lfMTiQIiXZFYCuwuTA0RTQ/FHvyNzQh1EYhUqY/M=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47EFuW7O012859
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Aug 2024 10:56:32 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 10:56:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 10:56:32 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47EFuRN4122507;
	Wed, 14 Aug 2024 10:56:28 -0500
Message-ID: <6216b2b4-f745-4183-8454-374d77a15379@ti.com>
Date: Wed, 14 Aug 2024 21:26:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] arm64: dts: ti: k3-j722s: Change timer nodes
 status to reserved
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <tony@atomide.com>, <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240814104151.2038457-1-b-padhi@ti.com>
 <20240814104151.2038457-6-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240814104151.2038457-6-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/14/2024 4:11 PM, Beleswar Padhi wrote:
> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
> use timers. Therefore, change the status of the timer nodes to
> "reserved" to avoid any clash. Usage is described as below:
>
> 	+===================+=============+
> 	|  Remoteproc Node  | Timer Node  |
> 	+===================+=============+
> 	| main_r5fss0_core0 | main_timer0 |
> 	+-------------------+-------------+
> 	| c7x_0             | main_timer1 |
> 	+-------------------+-------------+
> 	| c7x_1             | main_timer2 |
> 	+-------------------+-------------+
>
> This change is already incorporated for timer nodes in the MCU voltage
> domain.
>
> Fixes: 3308a31c507c ("arm64: dts: ti: k3-am62: Add general purpose timers for am62")

Please check Fixes tag once.

AFAIR, J722S uses am62p not am62


> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index dd3b5f7039d7..e03beb0b5aad 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -566,3 +566,16 @@ &mcasp1 {
>   	       0 0 0 0
>   	>;
>   };
> +
> +/* Timers are used by Remoteproc firmware */
> +&main_timer0 {
> +	status = "reserved";
> +};
> +
> +&main_timer1 {
> +	status = "reserved";
> +};
> +
> +&main_timer2 {
> +	status = "reserved";
> +};


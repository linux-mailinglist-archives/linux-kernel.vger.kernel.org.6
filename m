Return-Path: <linux-kernel+bounces-308905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDC5966388
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4251F24C90
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B727D1B1D5D;
	Fri, 30 Aug 2024 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ODIyyxfR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB4179652;
	Fri, 30 Aug 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026251; cv=none; b=jXsdOfjpn1FYQdbTPpRNB607MJzSadBCPMQmTSZ6utDNCK99rJAPgryrBuYNo2CHB6wzKtseif4KYR4aCTHT1mcEcdtN1NTRgMh4LynMQiwPQcqugVIwMOnZOeu44kU0OSMEO1/RGZA788U/tHmbjQkPPExxBrRWK+KzDCo3AP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026251; c=relaxed/simple;
	bh=zbsxPfwaGioyk3vzNd7TZ+fws8QWWmM/wVKo78ysYUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CuuzuiH/DHfJ/f0kbHZ0ge8Y/XIP5B3lo9oVWthakOLeiuQHP+pxT5eyEbJhAlxTQCTSVA9p5iliVYH+D8U3jHSQ+sBKujOeHSWLrWEdSFTnYt4M8/vPY/cU0y8xQIseJ25t41ROO64jetLNt0cR8AgnYr1SVBnUNBCT7RzmTXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ODIyyxfR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UDvNB7017791;
	Fri, 30 Aug 2024 08:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725026243;
	bh=mNEeyjy6cbgjkLcIEQVWG1qzIGE7ZhsXUJX1Fa/WPKs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ODIyyxfR7uX7Dfan2+bQNRmiDnbmqPOxfe4WIuGzSKUA141jJFHHQh2sn/8OhOFhC
	 bxse8Fr89RXhj7oSB5GA5q1pDLAi98sLOSVtRRYByDmdz0WzbzpGFixfa2zkn0BS9e
	 Op/czvKxwfIZT96IdzisBepOSXuJfu/HSpBW50I0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UDvMgS113506;
	Fri, 30 Aug 2024 08:57:22 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 08:57:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 08:57:22 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UDvIYT083496;
	Fri, 30 Aug 2024 08:57:18 -0500
Message-ID: <bb36b4e1-c8c3-45aa-a2d2-056ef4a6e448@ti.com>
Date: Fri, 30 Aug 2024 19:27:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: k3-j722s-evm: Enable
 Inter-Processor Communication
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20240829060932.3441295-1-b-padhi@ti.com>
 <20240829060932.3441295-3-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240829060932.3441295-3-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/29/2024 11:39 AM, Beleswar Padhi wrote:
> From: Apurva Nandan <a-nandan@ti.com>
>
> The K3 J722S-EVM platform is based on the J722S SoC which has one
> single-core Arm Cortex-R5F processor in each of the WAKEUP, MCU and MAIN
> voltage domain, and two C71x DSP subsystems in MAIN voltage domain.
>
> The Inter-Processor communication between the A72 cores and these R5F

Should be A53 core not A72

> and DSP remote cores is achieved through shared memory and Mailboxes.
> Thus, add the memory carveouts and enable the mailbox clusters required
> for communication.
>
> Also, The remoteproc firmware like of R5F and DSPs in the MAIN voltage
> domain use timers. Therefore, change the status of the timer nodes to
> "reserved" to avoid any clash during booting of remotecores. Usage is
> described as below:
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
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> [ Enabled mailbox instances and Reserved timer nodes ]
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> [..]
>   
> +&mailbox0_cluster0 {
> +	status = "okay";
> +
> +	mbox_r5_0: mbox-r5-0 {

Could you choose name like mbox_wkup_r5_0 like other name of mbox


> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> +	};
> +};
> +
> +&mailbox0_cluster1 {
> +	status = "okay";
> +
> +	mbox_mcu_r5_0: mbox-mcu-r5-0 {
> +		ti,mbox-rx = <0 0 0>;
> +		ti,mbox-tx = <1 0 0>;
> [..]


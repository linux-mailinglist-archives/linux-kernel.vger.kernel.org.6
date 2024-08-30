Return-Path: <linux-kernel+bounces-309238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23989667F1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838421F22354
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADFC1BAEF1;
	Fri, 30 Aug 2024 17:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="akRed3gr"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3937E1B2EC8;
	Fri, 30 Aug 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725038657; cv=none; b=lKfjM7XLa2PIm17EmCI/SuECAnc67omeglzldL/SG3aO270ZP5ThrV2eFJFuEVdtq/KpRcBUj12YxrWmcz8Ufn/y3b1JR/enj7ZQ0nxZsTsprItCSChvQZOnuflwOdGu8eNx0BBjeRYCto4qGPyfmfwfqzV5jTVCQLGw/OgVH6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725038657; c=relaxed/simple;
	bh=PMa1w9wViDROucA4Q9WgZ/QMB8a6JVGkNlXnhoxUWTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TtqUw7ULDsUx7FIWbglJRrWo4CmAVDyOjiE6QN4PtFUAB0NBAX6uI2coeUPsh+vmN7eNntmVytZeHp8Q8xUcRX+W2L/8zyjoNMm+S+Y4azf11VC0ptjLY3Mk0FcsOlrWe1LVFQldays7AWIh14gABpVIN9YtsEOfVLbuMp3rRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=akRed3gr; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47UHO7Dd022963;
	Fri, 30 Aug 2024 12:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1725038647;
	bh=6bj066I79BDcrPxQSOA/Xu2j4XxdgGo59tSZOuTfsiM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=akRed3grc+8B2sGrj59mVS/EBOA/u1r+3Vhdey0kD0Ha2HiCaAu5Sfa23YIYPHMbz
	 kj/S1GzVQsklfSZDgZOqa/OJ13Jv5Fu9cNbzCd0BblxhLDgj1bqNdyTsLZFtWMqkeI
	 AxaOidwQtZ/w3t88pip29taPLWNygXeOoJR9xkhk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47UHO7Rs062114
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 30 Aug 2024 12:24:07 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 30
 Aug 2024 12:24:06 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 30 Aug 2024 12:24:06 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47UHO00N041951;
	Fri, 30 Aug 2024 12:24:01 -0500
Message-ID: <6fe3da57-d93b-4782-a9b1-91833abb6d77@ti.com>
Date: Fri, 30 Aug 2024 22:53:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] arm64: dts: ti: k3-j722s-evm: Enable
 Inter-Processor Communication
To: Beleswar Padhi <b-padhi@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <j-choudhary@ti.com>, <vaishnav.a@ti.com>, <afd@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <u-kumar1@ti.com>
References: <20240830161742.925145-1-b-padhi@ti.com>
 <20240830161742.925145-3-b-padhi@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240830161742.925145-3-b-padhi@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 8/30/2024 9:47 PM, Beleswar Padhi wrote:
> From: Apurva Nandan <a-nandan@ti.com>
>
> The K3 J722S-EVM platform is based on the J722S SoC which has one
> single-core Arm Cortex-R5F processor in each of the WAKEUP, MCU and MAIN
> voltage domain, and two C71x DSP subsystems in MAIN voltage domain.
>
> The Inter-Processor communication between the A53 cores and these R5F
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


Reviewed-by: Udit Kumar<u-kumar1@ti.com>

> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> [ Enabled mailbox instances and Reserved timer nodes ]
> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> ---
> v5: Changelog:
> 1) Updated commit message to correctly reflect the host core name (A53
> not A72).
> 2) Updated mbox DT node label and name to "mbox_wkup_r5_0" from
> "mbox_r5_0" for clarity.
>
> [..]


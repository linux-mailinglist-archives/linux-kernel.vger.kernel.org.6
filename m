Return-Path: <linux-kernel+bounces-289158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A81A954287
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5611F22968
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023F84FA0;
	Fri, 16 Aug 2024 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R824LC1C"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF1E20E3;
	Fri, 16 Aug 2024 07:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792604; cv=none; b=klDbYXbNHo5sOnDn8jvNgfOdYyctFMEIeI9kscZExGo6ZxnhEB+2UBzwDY7LWey/aQr7ZIpA5FvOO1w62lOD86+YMZ3oWX5lbHSUKwv6Hpnhb93GNN4ie0lkaU208zWsiXvH0ArFkZVtfqW5McqenOP7/FC/+ZpQpNqWf7F71PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792604; c=relaxed/simple;
	bh=Ha0j0MJC/iUKHPEr4BASzwOQAFvfQbIeZL7AJtPi+iY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vg6U96/UIbvQjxS8iQDkBXpM4OAPauD7gzy3VqxP1UNd/vge+MGLHJSYXI4wk2xx10C2JwlJX/ocYTMHrvGtOHekqMGWpPPN1qjFmuzr8Og8gGHQ7liVlYGX/9t22r7T8vzZ7IBYlXQ01wSfggrP7CzPSKR3/Kx4Yj5p1IIU+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R824LC1C; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47G7GTYa000539;
	Fri, 16 Aug 2024 02:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723792589;
	bh=9V83JmdIa0gI6xlkvnZRJUkajPWKDvKKKK1U1S2Lk+0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=R824LC1CRJPBdi4jtLjG+e0jfhRJggYqPszvJTPg1CvEI2/vR7g762o2oZMjAknz5
	 8rI6lvzekibk0giEGGcGFT9UIBgSve97JVRs/p0oVaWv0e80XHw6vlR91eVK7PFBlA
	 YmyFcxIYi05Wr15hzmNlnjISh5ktp+U80O+FDwok=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47G7GTmm012877
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Aug 2024 02:16:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Aug 2024 02:16:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Aug 2024 02:16:28 -0500
Received: from [10.249.130.61] ([10.249.130.61])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47G7GMk6062232;
	Fri, 16 Aug 2024 02:16:23 -0500
Message-ID: <50277a8a-e08c-486f-98c3-870562a91c20@ti.com>
Date: Fri, 16 Aug 2024 12:46:21 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm64: dts: ti: k3-j7200: Change timer nodes
 status to reserved
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <tony@atomide.com>, <g-vlaev@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240814104151.2038457-1-b-padhi@ti.com>
 <20240814104151.2038457-2-b-padhi@ti.com>
 <8394ab04-5e5c-4e06-b1d1-7eb64bacedbe@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <8394ab04-5e5c-4e06-b1d1-7eb64bacedbe@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit,

On 14-08-2024 20:41, Kumar, Udit wrote:
>
> On 8/14/2024 4:11 PM, Beleswar Padhi wrote:
>> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
>
> There is no DSP on this SOC.
>
> Please consider to re-word commit message


Thanks for catching this! Will fix in revision.

>
>
>> use timers. Therefore, change the status of the timer nodes to
>> "reserved" to avoid any clash. Usage is described as below:
>>
>>     +===================+==========================+
>>     |  Remoteproc node  |        Timer Node        |
>>     +===================+==========================+
>>     | main_r5fss0_core0 | main_timer0, main_timer2 |
>>     +-------------------+--------------------------+
>>     | main_r5fss0_core1 | main_timer1              |
>>     +-------------------+--------------------------+
>
>
>> This change is already incorporated for timer nodes in the MCU voltage
>> domain.
>
> For whole series,  on MCU domain R5 we have device-manager firmware,
>
> which is needed to get SOC functional. So MCU domain timers are reserved.


Understood. Will fix in revision.

>
> So my suggestion will be to avoid above message
>
>
>>
>> Fixes: c8a28ed4837c ("arm64: dts: ti: k3-j7200: Add general purpose 
>> timers")
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   .../boot/dts/ti/k3-j7200-common-proc-board.dts      | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts 
>> b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 6593c5da82c0..a65066bd7f09 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -471,3 +471,16 @@ &main_mcan3 {
>>       pinctrl-0 = <&main_mcan3_pins_default>;
>>       phys = <&transceiver3>;
>>   };
>> +
>> +/* Timers are used by Remoteproc firmware */
>> +&main_timer0 {
>> +    status = "reserved";
>> +};
>> +
>> +&main_timer1 {
>> +    status = "reserved";
>> +};
>> +
>> +&main_timer2 {
>> +    status = "reserved";
>> +};


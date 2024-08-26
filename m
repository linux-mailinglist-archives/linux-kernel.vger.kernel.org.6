Return-Path: <linux-kernel+bounces-301324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B301095EF05
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 12:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAEF1F24652
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D27187554;
	Mon, 26 Aug 2024 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bfAGM7FD"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC7186E40;
	Mon, 26 Aug 2024 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669483; cv=none; b=s0dcIgD2fxVQTJltej2vYY+MjvDMUJh7iP6AoIlpJmWK3gpB4ob/0xpJ9C979L9MaextLzp6RqIJQPhFm29HZXvHFx34IF77moqr/JNvAKJdj8NPoe6FS6RzdSr+UAG3YE0Q7R3AD3EnBBqh1bzR10ZdvQNaftY7X9DpEvWNu5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669483; c=relaxed/simple;
	bh=WdHE5XNtr7z+xsQwvBKiZd4K93n2CNswyZieBtNIAn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qg6/YUyfk8fr2U46vYfo9dvT9yTp9XybDchCfsyZQr0SFy1PiFiAr4a+i++ppnhz8gpqEW/XhiRpanLL6AYV2Ja3ASzhU5+tUHTfA6nS9j5n6rCOldu9MfvvWyylgFdM8QUTtrNFlOf4o6bsoXA/DDxdoGrzMbVXbIPqlikLNSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bfAGM7FD; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47QApFh2099595;
	Mon, 26 Aug 2024 05:51:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724669475;
	bh=Rvq2ct4Moc9Ce/57oqN5CygPi0v+qZNmXjSDiXW5OUA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bfAGM7FDGJR4/810DEuVfY2T1OkSvPCrg82LAFy9KOGZctK1I2XLYPYl/JVXF6BB/
	 XB9m9n0BmTudgRzXnTfgrNjjSYYfLrZNEmq2aFgRtSb20WBOKSWe+kpZB/7CUeCVI4
	 rcjilP5dA7vdqED+GwvSSgz/Jd/KC+W19Ga9a9J4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47QApEsV039050
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 26 Aug 2024 05:51:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 26
 Aug 2024 05:51:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 26 Aug 2024 05:51:14 -0500
Received: from [172.24.227.151] (uda0510294.dhcp.ti.com [172.24.227.151])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47QApAhS065986;
	Mon, 26 Aug 2024 05:51:10 -0500
Message-ID: <7926115d-6111-4ea4-af04-3cc51c89c5f8@ti.com>
Date: Mon, 26 Aug 2024 16:21:09 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] arm64: dts: ti: k3-j722s: Change timer nodes
 status to reserved
To: "Kumar, Udit" <u-kumar1@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <tony@atomide.com>, <bb@ti.com>, <d-gole@ti.com>, <afd@ti.com>,
        <hnagalla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816073908.2343650-1-b-padhi@ti.com>
 <20240816073908.2343650-6-b-padhi@ti.com>
 <3f0002df-7ff0-4fd8-b8df-105ae9a5b051@ti.com>
Content-Language: en-US
From: Beleswar Prasad Padhi <b-padhi@ti.com>
In-Reply-To: <3f0002df-7ff0-4fd8-b8df-105ae9a5b051@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 26/08/24 10:30, Kumar, Udit wrote:
>
> On 8/16/2024 1:09 PM, Beleswar Padhi wrote:
>> The remoteproc firmware like of R5F and DSPs in the MAIN voltage domain
>> use timers. Therefore, change the status of the timer nodes to
>> "reserved" to avoid any clash. Usage is described as below:
>>
>>     +===================+=============+
>>     |  Remoteproc Node  | Timer Node  |
>>     +===================+=============+
>>     | main_r5fss0_core0 | main_timer0 |
>>     +-------------------+-------------+
>>     | c7x_0             | main_timer1 |
>>     +-------------------+-------------+
>>     | c7x_1             | main_timer2 |
>>     +-------------------+-------------+
>>
>> Fixes: 29075cc09f43 ("arm64: dts: ti: Introduce AM62P5 family of SoCs")
>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts 
>> b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> index dd3b5f7039d7..e03beb0b5aad 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
>> @@ -566,3 +566,16 @@ &mcasp1 {
>>              0 0 0 0
>>       >;
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
>
>
> Since IPC is not up-streamed for J722S , So I suggest to drop this 
> patch from this series
Thanks for catching this! I have dropped this patch in v4 revision of 
this series.
>
> and include this when you upstream IPC support for J722S board .
>
>


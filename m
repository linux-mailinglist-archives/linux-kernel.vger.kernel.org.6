Return-Path: <linux-kernel+bounces-172769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6098BF688
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAE41C218A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BE6224D6;
	Wed,  8 May 2024 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VoQkSm3k"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2F1B676;
	Wed,  8 May 2024 06:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715150960; cv=none; b=QJ05N/0WmXdi0VWIhVDSpP0LOm/cQ6pTrQqKXisXIyeNQmugmr0vrVJET+AXpedyXEYITAQxW13x9FfiCYib9ndOPqCgltf9NdJb0tMx4E0HOyq8lUwUoHBfX+oqeaioFsGQYsha08S8XQAF37uli11r3aYxVBZsODt+yS5IiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715150960; c=relaxed/simple;
	bh=5RxUq8AaYJl2089Gir6TbXsMF4z4d+QPL4Xq0UTRyiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OSgMogF9FqFsmK7PCwa8Jd3kMDkqJfrQzghf3U1pzVYl9cWI5fmdtajQsX0TVktQR2c8vGo71UMBkU9HZx0YxXOrY7A9lZej5Ym80YBCvw6DEoOycG7e4ub1MpqlaZJup8xDR9+H3/di8FKjLrNtUOxAdXrUXMzb+Sqg4GG3lOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VoQkSm3k; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4486n0IX041531;
	Wed, 8 May 2024 01:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715150940;
	bh=xmUCTSYBX0Mui+FqKpbKHo9xPbDuKJ0O8lwtHyub0IM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VoQkSm3kmOlogc6mbHigX9Vx03J6JHqHAkkXg3WcFjjrfNsQOF+6aXWqazt745jJH
	 ifHPVsl3uCWP3bk9EEkpunemukOG0Tb9LYMBSOjmQDLcMIVKMBciq1ntC173V7C89d
	 Q1Ah5ypOuRckZgBGVj034PF9BGwCxgohcK5WI46c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4486n01B015613
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 May 2024 01:49:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 8
 May 2024 01:49:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 8 May 2024 01:49:00 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4486ms9h069593;
	Wed, 8 May 2024 01:48:55 -0500
Message-ID: <5678773e-1150-48ed-9c70-ba402602274e@ti.com>
Date: Wed, 8 May 2024 12:18:53 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: boot: dts: ti: k3-am68-sk-base-board: Add
 LP8733 and TPS6287 nodes
To: "Kumar, Udit" <u-kumar1@ti.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <krzk+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <marten.lindahl@axis.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240507122158.3739291-1-n-francis@ti.com>
 <20240507122158.3739291-4-n-francis@ti.com>
 <dc369d86-2a67-423e-a020-8e7ff58b6029@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <dc369d86-2a67-423e-a020-8e7ff58b6029@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Udit

On 08/05/24 10:25, Kumar, Udit wrote:
> Hi Neha
> 
> On 5/7/2024 5:51 PM, Neha Malcom Francis wrote:
>> Add DTS node for LP87334E PMIC and two TPS6287x high current buck
>> converters.
>>
>> LP87334E is responsible for supplying power to the MCU and MAIN domains
>> as well as to LPDDR4. The two TPS6287x supply power to the MAIN
>> domain for AVS and other core supplies.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> Link: https://www.ti.com/lit/pdf/slda060
>> ---
>> [..]
>> +    tps62873b: tps62873@43 {
>> +        compatible = "ti,tps6287x";
>> +        bootph-pre-ram;
> 
> I think,  we don;t need bootph-pre-ram for fixed regulator,
> 
> Please check once, if really bootph-pre-ram needed here
> 

Yeah, there's no need for the bootloader needing this regulator at present. Will 
make the change, thanks!

> 
>> +        reg = <0x43>;
>> +        regulator-name = "VDD_CORE_0V8";
>> +        regulator-min-microvolt = <800000>;
>> +        regulator-max-microvolt = <800000>;
>> +        regulator-boot-on;
>> +        regulator-always-on;
>> +    };
>> +};
>> +
>>   &mcu_uart0 {
>>       status = "okay";
>>       pinctrl-names = "default";

-- 
Thanking You
Neha Malcom Francis


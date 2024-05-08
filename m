Return-Path: <linux-kernel+bounces-172628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248058BF494
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 04:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCDB1F25288
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560A712E74;
	Wed,  8 May 2024 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GQ0Dx2Js"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC1385;
	Wed,  8 May 2024 02:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135586; cv=none; b=j1cTlR+0cQ5Dd5OsW3bnCaNUVczD1AGL3XMRegvb1AvR9jOxOZDrVvf6wFNObHH9vCAXL/J4j6WH/BECQXJf6pARatY4fV0EQBJSigBuBAtPjov3Fz+fq7hJtyxawlJpntnW0cilg4HQ4AHr6I5ytcsrRKc7DXtz1vU7tQp/gxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135586; c=relaxed/simple;
	bh=GQI3foM1aUdeD/8j61M4OYXqveWJZjDJO4QquolCYoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sy7kImm5I/rLcnogeENGmKmpJuuwqtg8AskKa+xinLwvjfxBC++5las8ujAuz9JzIKvjScLOwFx21F6dJnpyncJ56DZy/RjMx/EJQsXoO/2qc1zoVVUgej4rOhq33AW1H0EXDLzdg4fZEs76bjRPmaHTiwrXTgRade+wAfhgrNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GQ0Dx2Js; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4482WeoM059096;
	Tue, 7 May 2024 21:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715135560;
	bh=f/D3yLYXWBhynQURe0LWuItpjtu/UWwQJZrmRPe4JS0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=GQ0Dx2Js3uYQxFXGB+BldZJqEvDh7IMQQPy2gFM4GFcgiUhrnHmXkjeLucNQHDAua
	 AvJ94QwxcQkDmRRF6fIerRv9E2nA7ipNHs6IsxU6hAfxFRcULcfw9EP4gFcDq5VEFv
	 LDA9DXiz48Ccnhv5/OKk36cbIW7g4pTm3VEEPEp8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4482We7G008452
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 May 2024 21:32:40 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 May 2024 21:32:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 May 2024 21:32:40 -0500
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4482WZek088709;
	Tue, 7 May 2024 21:32:36 -0500
Message-ID: <a78d1d27-1d29-4031-9d4f-3f1e2dd47d76@ti.com>
Date: Wed, 8 May 2024 08:02:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] regulator: dt-bindings: Unify compatible
To: Rob Herring <robh@kernel.org>
CC: <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <kristo@kernel.org>,
        <vigneshr@ti.com>, <nm@ti.com>, <broonie@kernel.org>,
        <lgirdwood@gmail.com>, <marten.lindahl@axis.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240507122158.3739291-1-n-francis@ti.com>
 <20240507122158.3739291-2-n-francis@ti.com>
 <20240507211112.GA1053164-robh@kernel.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240507211112.GA1053164-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Rob

On 08/05/24 02:41, Rob Herring wrote:
> On Tue, May 07, 2024 at 05:51:54PM +0530, Neha Malcom Francis wrote:
>> TPS62870/1/2/3 devices have different output currents (6A/9A/12A/15A) of
>> the TPS6287x family. The I2C addresses are the same between them. There
>> is no need for different compatibles for each for these devices so drop
>> them and add a unified "ti,tps6287x" compatible.
> 
> And s/w will never need to know what the max output current is?
> 

Not really, as per understanding from the hardware teams.

> Same i2c address has no bearing. That's usually not even fixed for 1
> device.
> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   .../devicetree/bindings/regulator/ti,tps62870.yaml         | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>> index 386989544dac..2998773db990 100644
>> --- a/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
>> @@ -15,10 +15,7 @@ allOf:
>>   properties:
>>     compatible:
>>       enum:
>> -      - ti,tps62870
>> -      - ti,tps62871
>> -      - ti,tps62872
>> -      - ti,tps62873
>> +      - ti,tps6287x
> 
> You just broke the existing users.
> 
> Wildcards in compatible names are generally discouraged. Maybe if this
> was a new binding and had sufficient justification why we don't need to
> distinguish parts, but this is an ABI and we're stuck with them.
> 
> If you are doing this to support more versions, then feel free to use
> an existing string. It's just a unique identifier. You have 4 to choose
> from.

Thanks for the review, Rob! I should have known better than to remove 
compatibles, excuse the noise!

> 
> Rob
> 

-- 
Thanking You
Neha Malcom Francis


Return-Path: <linux-kernel+bounces-567527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45744A6875F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75AD7A4B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265722512D4;
	Wed, 19 Mar 2025 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Dhg1JDMX"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D592AEE2;
	Wed, 19 Mar 2025 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742374968; cv=none; b=i4/3X4DyBrShViGKxaCdZygg4fqL//N4iltq0L3SKYuMw855lnsAmCrjsG7ltYphYHPBNaJF8GZ4DmHMbjfWPCyC4do4QpSjNgr4gxA+VxWucvyMjE1AmM+mnCKUdMce9LdjjUDJ/IybLZeIblVaqfdjg6nYgkGubH57b0+ucjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742374968; c=relaxed/simple;
	bh=FaDGkUM7O3V9JbJ1fr2mDI2TsD7nM+uBH0BFX4oHm6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ISiSCXwyW+eV+u0UDldh9Sha44kRrAwvik2RFMjsA269pInzPDLPnNHUpnNDx2fYTdROZByz06i0t2cVAerGSfbvZ0qrEpYdP5/5uTfZ1sTtcdvX9DLDMDMxkyuc3u41viY88YTJLdmGccsSqIshpxjT55jvr3Z90nMq8mw9/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Dhg1JDMX; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52J92arR2837347
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 04:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1742374956;
	bh=dhfmhsW+i263CPGxl5ZbKPZxA7KWrhbh+yl1EcVWbs8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Dhg1JDMXRpPhxzYrjNdzhVNSp7yTR0IJ1MsAGt4QERkayKpJIsFzjnKB9HEUKTe2C
	 k4/Y/rwrxDhBeD+yF/NTv93GNRcQibursRg2ftdH6IVD1HdE0ZfZEr7gcrxdS9Rizt
	 UUrj2SMbzd8zzE+xRALXs8Lcd3+DC5rYOz0Aw7xE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52J92aET023442
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 19 Mar 2025 04:02:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 19
 Mar 2025 04:02:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 19 Mar 2025 04:02:36 -0500
Received: from [10.24.69.37] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52J92Jco075062;
	Wed, 19 Mar 2025 04:02:21 -0500
Message-ID: <f39d80fc-3600-4c2c-b09c-980288f86fa2@ti.com>
Date: Wed, 19 Mar 2025 14:32:10 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: bist: Add BIST dt-binding for TI
 K3 devices
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>
References: <20241128140825.263216-1-n-francis@ti.com>
 <20241128140825.263216-2-n-francis@ti.com>
 <ho7ktcnbtl7mvamfthqho23co2fc4z7bgjha7pu4wivxm6ndhu@tfbpveonhckz>
 <837d329b-bcdd-4c3b-b508-e916b110ce25@ti.com>
 <e57dfc3e-b702-4803-b776-20c6dbd98fef@kernel.org>
 <8e58b093-1c64-45b9-a9d3-9835a3bbc4fd@ti.com>
 <1da4e402-62f3-4bad-9129-1f5a08148987@kernel.org>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <1da4e402-62f3-4bad-9129-1f5a08148987@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof,

On 19/03/25 13:16, Krzysztof Kozlowski wrote:
> On 13/03/2025 12:14, Neha Malcom Francis wrote:
>> Hi Krzysztof
>>
>> On 29/11/24 14:45, Krzysztof Kozlowski wrote:
>>> On 29/11/2024 08:43, Neha Malcom Francis wrote:
>>>>>> +
>>>>>> +  power-domains:
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  ti,bist-instance:
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    description:
>>>>>> +      the BIST instance in the SoC represented as an integer
>>>>>
>>>>> No instance indices are allowed. Drop.
>>>>>
>>>>
>>>> Question on this, this is not a property that is driven by software but rather 
>>>> indicates which register sequences have to be picked up for triggering this test 
>>>> from this instance. So I don't see how I can workaround this without getting 
>>>> this number. Or maybe call it ID rather than instance?
>>>
>>> I don't understand how the device operates, so what is exactly behind
>>> some sequences of registers for triggering this test. You described
>>> property as index or ID of one instance of the block. That's not what we
>>> want in the binding. That's said maybe other, different hardware
>>> characteristic is behind, who knows. Or maybe it's about callers... or
>>> maybe that's not hardware property at all, but runtime OS, who knows.
>>>
>>
>> Sorry for such a late reply, but I was hoping to get more details on
>> this "ID" and never got back to the thread...
>>
>> The best way I can describe is this device (BIST) runs a safety
>> diagnostic test on a bunch of processors/blocks (let's call them
>> targets). There's a mapping between the instance of this device and the
>> targets it will run the test. This ID was essentially letting the BIST
>> driver know which are these targets.
> 
> 
> So you want to configure some target? Then this is your property. If you
> want to configure 'foo' difference in DT, you do not write 'bar'...
> 

So the difficulty in doing this is, what I mentioned in the earlier
email just copying it over again:

"Yet another way would be the BIST points out the targets it controls via
their phandles in its node... but this approach would trigger the probe
of these targets before the test runs on them. And in hardware, the test
must run only one before the device is used, else we see indefinite
behavior."

Property that has a list of strings (targets) instead of phandles maybe?
Would that be acceptable?

> Anyway, no clue, original emails are long time not in my inbox. Context
> disappeared also long time ago.
> 

Completely understand, delay from my end, sorry!

> 
> Best regards,
> Krzysztof

-- 
Thanking You
Neha Malcom Francis


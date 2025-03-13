Return-Path: <linux-kernel+bounces-559298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AB6A5F217
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999E43B8877
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C79F265CD9;
	Thu, 13 Mar 2025 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MJXz7tr9"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A394266183;
	Thu, 13 Mar 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864459; cv=none; b=qGWQ8THWEVDJA5pRQRb61Kmsnh2z68gSbf3bfkYzJg5awbNoxAHfKZg0lyFhUk1yy5ZIGwTeVxdHfMWkIfDQHf34/f3zSa2BvRNTB0BW2NHF/ttlbbk2O29dGf57tRZO2Z0+apk/ajPw+ptHkDdBmmWG7Uu6xD5HevjVkUdw/3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864459; c=relaxed/simple;
	bh=1Ry7KePRqIwKg1gp1qMl4hqEkDK/oQLqKLvRIEIBNAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cp+G76UJcGj4LPeYcBRRCbafdP3Y2hoVSUAz+FmYX+w39GkYSEEO/0FyAGQIeFB9o42f6eH02l79L4SkTxiPZXAwaalNSTx+kFVIMez0DxH6edqcFe7aYifwE0n5ZgpXOXL/OeG09MtyFooieQ/L9mLgqhgZeN4Qkda/N/505Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MJXz7tr9; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52DBEATZ1856319
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 06:14:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741864450;
	bh=/TF/F6lXdjR8IB4UYkLtUXrENiAwln8Gi9GSzblYrCw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=MJXz7tr9nyecpy7QjTkOLn6IkrbZKqEAzsHPRXduyv7sFMykNvgyjwzP7o7tpEFu9
	 bcle+02bf266ZgS0wooko5Stcm49XrXP2lQ/8qy9LoVYoXwl+jCBi7uxIh17tV1RpU
	 DnYE10eJD+cS8qLmsGhRYcKvLQtMNa9Tm9uaBJhA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52DBEAu7041226
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Mar 2025 06:14:10 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 06:14:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 06:14:10 -0500
Received: from [10.24.69.37] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52DBE60E053638;
	Thu, 13 Mar 2025 06:14:07 -0500
Message-ID: <8e58b093-1c64-45b9-a9d3-9835a3bbc4fd@ti.com>
Date: Thu, 13 Mar 2025 16:44:06 +0530
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
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <e57dfc3e-b702-4803-b776-20c6dbd98fef@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Krzysztof

On 29/11/24 14:45, Krzysztof Kozlowski wrote:
> On 29/11/2024 08:43, Neha Malcom Francis wrote:
>>>> +
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +  ti,bist-instance:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>> +    description:
>>>> +      the BIST instance in the SoC represented as an integer
>>>
>>> No instance indices are allowed. Drop.
>>>
>>
>> Question on this, this is not a property that is driven by software but rather 
>> indicates which register sequences have to be picked up for triggering this test 
>> from this instance. So I don't see how I can workaround this without getting 
>> this number. Or maybe call it ID rather than instance?
> 
> I don't understand how the device operates, so what is exactly behind
> some sequences of registers for triggering this test. You described
> property as index or ID of one instance of the block. That's not what we
> want in the binding. That's said maybe other, different hardware
> characteristic is behind, who knows. Or maybe it's about callers... or
> maybe that's not hardware property at all, but runtime OS, who knows.
> 

Sorry for such a late reply, but I was hoping to get more details on
this "ID" and never got back to the thread...

The best way I can describe is this device (BIST) runs a safety
diagnostic test on a bunch of processors/blocks (let's call them
targets). There's a mapping between the instance of this device and the
targets it will run the test. This ID was essentially letting the BIST
driver know which are these targets.

Should I perhaps trigger it the other way around; a target driver asks
for it's safety test to be run by pointing to the BIST instance? However
the issue with this approach is, the architecture of this safety test
device is that once triggered, it will run the test on all the targets
it controls and that should be reflected in the software arch as well right?

Yet another way would be the BIST points out the targets it controls via
their phandles in its node... but this approach would trigger the probe
of these targets before the test runs on them. And in hardware, the test
must run only one before the device is used, else we see indefinite
behavior.


> Best regards,
> Krzysztof

-- 
Thanking You
Neha Malcom Francis


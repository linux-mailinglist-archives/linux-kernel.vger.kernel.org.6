Return-Path: <linux-kernel+bounces-288100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A68C95349E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477A0285B3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B51A01DA;
	Thu, 15 Aug 2024 14:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fTyaTxso"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB963C;
	Thu, 15 Aug 2024 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732084; cv=none; b=uHtqpVgqp02D8bYKnsDMmAFDbW73wbE8SMGbxbxa3MC+pTip0NqCRPweTyKQKRq8uM+tV3lveVQoDp/1AN6fQqy+53X1Isfvpcdv1sP/9Ozy2Br8PyaJeI5oIagqwUvuC9fmPk3VNyb6xgoDz0TCXoiNkl8Ar2VkmvJsoNIpXus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732084; c=relaxed/simple;
	bh=N6W+kdsRIJgs6BgWYIx1Fmb+FrqcQji/yE9Gm23xVqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mnM0x/0I698exyEzrc2rciBXLVsK+WfrU6dm+wvS4f9JDC9sk5L6kUEHqC+TZYEMrFOGc7yRxxxucN7BV1Qt5DKI74hXN69AMa6xoYq3IUrPBi3cpz70KNb54BqOT4IyghZWlJRT/gaBJ5X7ajmOCkrDEBBUHYjw8CHLtfJSXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fTyaTxso; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47FERjpC107604;
	Thu, 15 Aug 2024 09:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723732065;
	bh=NqGks5ZmmaFD2NYgflpmv3wLE/YC3/eEbp1rSchg8og=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=fTyaTxsoNRJhlTniYomZCMf9fDBVZwr5+ODtSfRpE++A7yzI4YgAy6qrpBzbucp6i
	 NmpbUtsHReAfyYm1w9+4dHqkPVRXrczkB2YbG8DJCpkAVy/85c8hAK4RjYj995tlu0
	 lc4VwPTM8w5xsjIaTx7Keebp7xQWtlJxo2CM8WuQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47FERjdt055511
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Aug 2024 09:27:45 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Aug 2024 09:27:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Aug 2024 09:27:44 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47FERixs037874;
	Thu, 15 Aug 2024 09:27:44 -0500
Message-ID: <440c9c5b-85ca-47f1-ac05-498ec9a1911b@ti.com>
Date: Thu, 15 Aug 2024 09:27:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Add and fix ESM nodes
To: Nishanth Menon <nm@ti.com>
CC: Jan Kiszka <jan.kiszka@siemens.com>, <devicetree@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>
References: <20240813230312.3289428-1-jm@ti.com>
 <4295a15a-6285-4005-bc40-328e52addc2b@siemens.com>
 <6134b3c1-f7ea-4cca-8777-56e5705aadf6@ti.com>
 <20240815122928.4i2yob5aj5ssqhzw@reply>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240815122928.4i2yob5aj5ssqhzw@reply>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 8/15/24 7:29 AM, Nishanth Menon wrote:
> On 08:59-20240814, Judith Mendez wrote:
>> Hi Jan,
>>
>> On 8/13/24 11:04 PM, Jan Kiszka wrote:
>>> On 14.08.24 01:03, Judith Mendez wrote:
>>>> The following patch adds ESM nodes and fixes ESM source
>>>> interrupts for Sitara K3 platforms. Currently watchdog cannot
>>>> reset the CPU because of misconfiguration or missing ESM node
>>>> in DT.
>>>>
>>>> ESM node was added for am62ax and am65x. For am62px ESM source
>>>> interrupts are fixed. Comments were also added for clarity on what
>>>> source interrupts are routed to ESM based on device TRM.
>>>>
>>>> ESM nodes like MCU ESM for am65x are added for device completion,
>>>> currently, some ESM0 events are not routed to MCU ESM, so watchdog
>>>> cannot reset the CPU using the current implementation.
>>>
>>> Yes, that's why there is https://github.com/siemens/k3-rti-wdt and
>>> probably similar bits in other R5 firmware. I was always told that is
>>> the only way to reset the /system/ (CPU alone would not help). That
>>> information is still correct?
>>
>> If you look at 9.4.14 MCU_ESM0 Interrupt Map, ESM0_ESM_INT_CFG_LVL_0,
>> ESM0_ESM_INT_HI_LVL_0, and ESM0_ESM_INT_LOW_LVL_0 are not routed to
>> MCU_ESM0. So the current implementation to route events from ESM0 to
>> MCU_ESM0 to reset the CPU will not work for AM65x, this is the
>> implementation on other K3 Sitara platforms and how watchdog can reset
>> the cpu.
>>
>> I did find MAIN_ESM_ERROR_INT which should be SOC_SAFETY_ERRORn, look
>> at Figure 12-3690. Perhaps the ESMs could be configured to use
>> SOC_SAFETY_ERRORn instead, not sure.
>>
>> The above should apply to both SR1 and SR2 devices according to the TRM.
> 
> Thanks for clarifying - you should add that in the commit message.
> 

Sure, I can send v3 with another commit message fixup.

~ Judith



Return-Path: <linux-kernel+bounces-199509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056B68D87EF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627F6B21388
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DC7136E3F;
	Mon,  3 Jun 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GBYRi3yR"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA225622
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435800; cv=none; b=tJ4C/Ga6gzmQul9XMHaGs/wKOTLm5DXFmzy0bnJiWtxfO1EGCkRkXs/U0jFsWUSmGVHN6v91YEQvLKyEAfB6VKB0K3tRW06zCqZMRwTFnryxD1KoLIE09/wtgaHw4DGssl5V97pS0NYFSwQlU1d+36tV9TGRek4KhvQu+rb/JjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435800; c=relaxed/simple;
	bh=ZzxnOGtNW2O6ExH3FSlj2NRoSMcCTYIZdCNOd3pEuL8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=T5FbgHA3+Br3GMLX+Vcu3i0U16cwWnm17ObAZwCpGJxAu2Uhj2dOQhxgW+mQvXV7mcJTNZVw/2vHr5KdX7gvHhDijryhyW4K1FAEwye4O/d4q7YN7aneqN/yQetgp0TM9cwna7LNce2nlyag93RGIFJnvN/HHdLIE7xa3R0Sn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GBYRi3yR; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 453HTptp088167;
	Mon, 3 Jun 2024 12:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717435791;
	bh=z08zoGQqJpPUnrI4i9x8DARfEvuyIUnb5LgFpYgkjSo=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=GBYRi3yRVlEAURYpY2oeVWEcdnWvJxWwLclB7yeetOv1mYoIa86VzmcZaE7GhFdhe
	 IJOlt0e2XrC0cc9Ub4XmS1qvIu5bi9kQ38s1drkYdMcLHRfaCIahmTwcNh+Xu7RHiz
	 xXHrfvizIDh/TNWjVLYmAjEEPL7hm7I0A/I4KcSo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 453HTp40060965
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Jun 2024 12:29:51 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Jun 2024 12:29:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Jun 2024 12:29:50 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 453HTljl009267;
	Mon, 3 Jun 2024 12:29:48 -0500
Message-ID: <b88a7dda-da4d-48df-b878-9dd88ff487e6@ti.com>
Date: Mon, 3 Jun 2024 22:59:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Correct nr_types assignment for TPS6594/3 and
 TPS65224
From: "Kumar, Udit" <u-kumar1@ti.com>
To: Shree Ramamoorthy <s-ramamoorthy@ti.com>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC: <m-leonard@ti.com>, <n-francis@ti.com>, <bhargav.r@ltts.com>,
        <m.nirmaladevi@ltts.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20240603170524.643010-1-s-ramamoorthy@ti.com>
 <20240603170524.643010-2-s-ramamoorthy@ti.com>
 <63167c3f-f583-4b2d-83c8-632827594ebb@ti.com>
Content-Language: en-US
In-Reply-To: <63167c3f-f583-4b2d-83c8-632827594ebb@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


Please ignore below response .

Sent by mistake.


Thanks

Udit


On 6/3/2024 10:46 PM, Kumar, Udit wrote:
>
> On 6/3/2024 10:35 PM, Shree Ramamoorthy wrote:
>> Swap nr_types assignment for TPS6594/3 and TPS65224.
>> Issue detected with v6.10-rc1 and tested using a TI J7200 EVM board.
>
>
> Please prefix line, where you want this patch to go
>
> like tiL6.6 or so
>
>
>> Log:
>> [   13.974024] Call trace:
>> [   13.974025]  _regulator_put.part.0+0x40/0x48
>> [   13.974028]  regulator_register+0x2b0/0xa00
>> [   13.974031]  devm_regulator_register+0x58/0xa0
>> [   13.974035]  tps6594_regulator_probe+0x4e0/0x5f0 [tps6594_regulator]
>> ...
>> [   13.974178] Unable to handle kernel NULL pointer dereference at 
>> virtual address 0000000000000004
>>
>> Signed-off-by: Shree Ramamoorthy <s-ramamoorthy@ti.com>
>> ---
>>   drivers/regulator/tps6594-regulator.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/regulator/tps6594-regulator.c 
>> b/drivers/regulator/tps6594-regulator.c
>> index 4a859f4c0f83..b66608ab2546 100644
>> --- a/drivers/regulator/tps6594-regulator.c
>> +++ b/drivers/regulator/tps6594-regulator.c
>> @@ -660,11 +660,11 @@ static int tps6594_regulator_probe(struct 
>> platform_device *pdev)
>>       } else if (tps->chip_id == TPS65224) {
>>           nr_buck = ARRAY_SIZE(tps65224_buck_regs);
>>           nr_ldo = ARRAY_SIZE(tps65224_ldo_regs);
>> -        nr_types = REGS_INT_NB;
>> +        nr_types = TPS65224_REGS_INT_NB;
>>       } else {
>>           nr_buck = ARRAY_SIZE(buck_regs);
>>           nr_ldo = ARRAY_SIZE(tps6594_ldo_regs);
>> -        nr_types = TPS65224_REGS_INT_NB;
>> +        nr_types = REGS_INT_NB;
>>       }
>>         reg_irq_nb = nr_types * (nr_buck + nr_ldo);
>> -- 


Return-Path: <linux-kernel+bounces-291933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDE95690E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AFC1F22EE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A92166318;
	Mon, 19 Aug 2024 11:10:58 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FFE15B12B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065858; cv=none; b=c0OqwPyfdr1jPx4KPdOS+yLZliRmIV1S/WT/QhSn5oogKfYnB+f6ncYyn2PsNBqr0meojcgG0SMmfGSXEt5QoZspOWXZNsSsnxUL10iafizl08rXU3r/rse0dQJY/s45BPJUSIZzRUCWXnSoYn8adqWS16VmMQUQF66Oiop6Wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065858; c=relaxed/simple;
	bh=H4OKQ5TqcR6QQEOCrCSTgksuDNkl0f3l3Xg4DSYN6Z4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=b9Bv0zCiqnt/CDbJXateFYnYgRZd2W/pl2xcshgMpTnRIzvzi3k152WLavxW3A0poRGp3+T39eqIGyaNBWD5n+JRJALYdNB98N3MBuCUvpIQKXI1Z+AIEPwqQGASYMRjCWXDLdCfJRGKtOGJiWhzBOlHu2rOe5YgosUoq+JWKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WnVBg48WQz1S8DW;
	Mon, 19 Aug 2024 19:05:47 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 5BBD21A0188;
	Mon, 19 Aug 2024 19:10:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 19 Aug 2024 19:10:45 +0800
Message-ID: <414af857-30b5-d844-3e7a-15b425c4db51@huawei.com>
Date: Mon, 19 Aug 2024 19:10:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] firmware: arm_ffa: Fix beyond size of field warning
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240816100258.2159447-1-ruanjinjie@huawei.com>
 <ZsMf1jIfbwwmqe1m@bogus> <5979b3b7-cd42-d01a-6c8f-5df7b698b324@huawei.com>
In-Reply-To: <5979b3b7-cd42-d01a-6c8f-5df7b698b324@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/19 19:01, Jinjie Ruan wrote:
> 
> 
> On 2024/8/19 18:35, Sudeep Holla wrote:
>> On Fri, Aug 16, 2024 at 06:02:58PM +0800, Jinjie Ruan wrote:
>>> An allmodconfig build of arm64 resulted in following warning:
>>>
>>> 	In function ‘fortify_memcpy_chk’,
>>> 	    inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
>>> 	    inlined from ‘ffa_msg_send_direct_req2’ at ./drivers/firmware/arm_ffa/driver.c:488:2:
>>> 	./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>> 	  571 |                         __write_overflow_field(p_size_field, size);
>>> 	      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> 	In function ‘fortify_memcpy_chk’,
>>> 	    inlined from ‘ffa_msg_send_direct_req2’ at ./drivers/firmware/arm_ffa/driver.c:489:2:
>>> 	./linux-next/include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>> 	  571 |                         __write_overflow_field(p_size_field, size);
>>> 	      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Because ffa_msg_send_direct_req2() memcpy uuid_t and struct
>>> ffa_send_direct_data2 data to unsigned long dst, the copy size is 2 or
>>> or 14 unsigned long which beyond size of dst size, fix it by using a temp
>>> array for memcpy.
>>>
>>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>>> ---
>>>  drivers/firmware/arm_ffa/driver.c | 14 ++++++++++++--
>>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
>>> index 1e3764852118..674fbe008ea6 100644
>>> --- a/drivers/firmware/arm_ffa/driver.c
>>> +++ b/drivers/firmware/arm_ffa/driver.c
>>> @@ -480,13 +480,23 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *buf, size_t sz)
>>>  static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
>>>  				    struct ffa_send_direct_data2 *data)
>>>  {
>>> +	unsigned long args_data[14];
>>> +	unsigned long args_uuid[2];
>>> +	unsigned long *data_ptr;
>>> +
>>>  	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
>>>  	ffa_value_t ret, args = {
>>>  		.a0 = FFA_MSG_SEND_DIRECT_REQ2, .a1 = src_dst_ids,
>>>  	};
>>>  
>>> -	export_uuid((u8 *)&args.a2, uuid);
>>> -	memcpy(&args.a4, data, sizeof(*data));
>>> +	memcpy(args_uuid, uuid, sizeof(uuid_t));
>>> +	args.a2 = args_uuid[0];
>>> +	args.a3 = args_uuid[1];
>>> +
>>> +	memcpy(args_data, data, sizeof(*data));
>>> +	data_ptr = &args.a4;
>>> +	for (int i = 0; i < 14; i++)
>>> +		*data_ptr++ = args_data[i];
>>>
>>
>> So we end up with double copy for both uuid and ffa_send_direct_data2 ?
>> This is not correct and not needed.
>>
>> Which toolchain are you using ? I got error only for memcpy which I forgot
>> to push to -next, now fixed. It must appear in -next soon.
> 
> Use the newest linux-next and  `make Image ARCH=arm64
> CROSS_COMPILE=aarch64-linux-gnu-`, the above compile error occurs.

`make allmodconfig ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-` at first.

> 
>>


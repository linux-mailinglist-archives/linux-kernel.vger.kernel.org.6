Return-Path: <linux-kernel+bounces-331396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D152A97AC57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C381F24CB6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CE14A62E;
	Tue, 17 Sep 2024 07:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qJENIK7F"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCCC155C87
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559120; cv=none; b=XCtZ3syBAxHELwTba0SfpYmLIBB/+Ov63oiI3EEaKe8ZMAzbQLPhxsAE6VaX+hQO59UC83qgA3kzlcA3t8rC6MuE7y8nIYksfpSSqhIa1AnAeF/Wr50l9XndZovv3F28y7sbjAD4ZHj2N8WBm6+TVM7/KKtGllMAN7DQWmexsMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559120; c=relaxed/simple;
	bh=Kg0JnlHYirBEVjju1bmjj9PUGi8EPxwDtGdrTCPQ+rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUrufz/hkpG7xEokMF89owUgsEDfKYuTUQ990jFwq2hy1t1F2NXCwfuym5CF8sZuxSC7W5DElCsE8sOdqpsFtqnsRhow1CnV0QN2fjr0EUGRqeaAg0vTzxjHb33iidIYH726bAi5863hHYs5qxu873oFIkpV9DCITSkx8xipznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qJENIK7F; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97805e86-8d1e-49a7-983b-7b93f8f86c89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726559114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2fCaZzxGqRxSfhRi1EfCnvb4oColukFzxySsICo1/U=;
	b=qJENIK7F+G33NrwjOxng+/VHeZtqyjOkH6qMk9F/+Z+pVzD41xI74YphLHug+UfF7HKMHP
	IGnBhQl3XB6//xy+yadKWq+28BIsIOmMDsvRi1II2MR1PigR9Ay3iUdG74C8Gs3CRdr5kI
	6e3PfbdvW1XWP04KA6Oojr7r9nU0dwc=
Date: Tue, 17 Sep 2024 15:44:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nullb: Adjust device size calculation in null_alloc_dev()
To: Damien Le Moal <dlemoal@kernel.org>, Aleksandr Mishin
 <amishin@t-argos.ru>, Shaohua Li <shli@fb.com>
Cc: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Chengming Zhou <zhouchengming@bytedance.com>,
 John Garry <john.g.garry@oracle.com>, Yu Kuai <yukuai3@huawei.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240917070729.15752-1-amishin@t-argos.ru>
 <c50f7ca2-8f3d-4b7e-bd50-1957e4a09b7b@kernel.org>
 <e1aad556-eab1-4ac4-aec3-1706e302cfb1@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <e1aad556-eab1-4ac4-aec3-1706e302cfb1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/9/17 15:24, Damien Le Moal 写道:
> On 2024/09/17 16:21, Damien Le Moal wrote:
>> On 2024/09/17 16:07, Aleksandr Mishin wrote:
>>> In null_alloc_dev() device size is a subject to overflow because 'g_gb'
>>> (which is module parameter, may have any value and is not validated
>>> anywhere) is not cast to a larger data type before performing arithmetic.
>>>
>>> Cast 'g_gb' to unsigned long to prevent overflow.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 2984c8684f96 ("nullb: factor disk parameters")
>>> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
>>> ---
>>>   drivers/block/null_blk/main.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>>> index 2f0431e42c49..5edbf9c0aceb 100644
>>> --- a/drivers/block/null_blk/main.c
>>> +++ b/drivers/block/null_blk/main.c
>>> @@ -762,7 +762,7 @@ static struct nullb_device *null_alloc_dev(void)
>>>   		return NULL;
>>>   	}
>>>   
>>> -	dev->size = g_gb * 1024;
>>> +	dev->size = (unsigned long)g_gb * 1024;
>> This still does not prevent overflows... So what about doing a proper check ?
> This still does not prevent overflows on 32-bits architectures.

The max value of "unsigned long" is 2^64 - 1 while the max value of int 
is 2^31 -1.

(2^64 - 1) / (2^31-1) is about 2^33 while 1024 is 2^10.

2^33 is greater than 2^10.

So in the above, it seems that it is difficult to overflow.

If I am missing something, please let me know.

Thanks,

Zhu Yanjun

>
>>>   	dev->completion_nsec = g_completion_nsec;
>>>   	dev->submit_queues = g_submit_queues;
>>>   	dev->prev_submit_queues = g_submit_queues;

-- 
Best Regards,
Yanjun.Zhu



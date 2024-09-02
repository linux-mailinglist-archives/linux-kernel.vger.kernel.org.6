Return-Path: <linux-kernel+bounces-310496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAA9967DBB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A731C219FE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 02:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD8028683;
	Mon,  2 Sep 2024 02:17:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEA7125DB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 02:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725243452; cv=none; b=YP3nUnR4AZ3IwBtoil0D5JgSuZQigDFCdy5fK6iTgwqh1w2quBh7vOprblQXt7a6/7HyjDr3Raq6JU60mZHb32ZLSWxoxRB6DvK7iHH4eeRoK/+ojXMbEMWPN50H85l0lSVTduqUPH/s+trv+6fzqI+YkvQukndr3MRLZs2bHcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725243452; c=relaxed/simple;
	bh=IfZPLAXAPgf8RLEd2qYXb6OFh8IbfAwj0VWWXRUCvx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=memuQc39Jz1q4TUZvJCRS681dDU9PTaoZ3GVtB+d4ig98XrPfc63RVv6qxsAJKAasbQKYZ6e2DBVuztB4gqZ/ttj5sQw4hmuMo4ZNsE1NVdNJ/V3zSTG/JEQCIAvGIt5NGNZv9sMrwVWxdWzGNd4YDGA5KBCe0ffZ7M5cDP/Hcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wxshq3nYFz20nL7;
	Mon,  2 Sep 2024 10:12:27 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 050631A016C;
	Mon,  2 Sep 2024 10:17:22 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 2 Sep 2024 10:17:21 +0800
Message-ID: <b493404f-9f7e-6f90-893e-84ff2bcb0170@huawei.com>
Date: Mon, 2 Sep 2024 10:17:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] drm/imagination: Use memdup_user() helper
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<frank.binns@imgtec.com>, <matt.coster@imgtec.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240831103047.99499-1-ruanjinjie@huawei.com>
 <74dfe952-2055-4152-90c6-ac9cc42fcad9@wanadoo.fr>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <74dfe952-2055-4152-90c6-ac9cc42fcad9@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/31 18:48, Christophe JAILLET wrote:
> Le 31/08/2024 à 12:30, Jinjie Ruan a écrit :
>> Switching to memdup_user(), which combines kmalloc() and
>> copy_from_user(),
>> and it can simplfy code.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>   drivers/gpu/drm/imagination/pvr_context.c | 22 +++++++---------------
>>   1 file changed, 7 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/imagination/pvr_context.c
>> b/drivers/gpu/drm/imagination/pvr_context.c
>> index eded5e955cc0..e75fd50a4d9f 100644
>> --- a/drivers/gpu/drm/imagination/pvr_context.c
>> +++ b/drivers/gpu/drm/imagination/pvr_context.c
>> @@ -69,27 +69,19 @@ process_static_context_state(struct pvr_device
>> *pvr_dev, const struct pvr_stream
>>       void *stream;
>>       int err;
>>   -    stream = kzalloc(stream_size, GFP_KERNEL);
>> -    if (!stream)
>> -        return -ENOMEM;
>> -
>> -    if (copy_from_user(stream, u64_to_user_ptr(stream_user_ptr),
>> stream_size)) {
>> -        err = -EFAULT;
>> -        goto err_free;
>> -    }
>> +    stream = memdup_user(u64_to_user_ptr(stream_user_ptr), stream_size);
>> +    if (IS_ERR(stream))
>> +        return PTR_ERR(stream);
>>         err = pvr_stream_process(pvr_dev, cmd_defs, stream,
>> stream_size, dest);
>> -    if (err)
>> -        goto err_free;
>> +    if (err) {
>> +        kfree(stream);
>> +        return err;
>> +    }
>>         kfree(stream);
>>         return 0;
>> -
>> -err_free:
>> -    kfree(stream);
>> -
>> -    return err;
>>   }
> 
> It could also be:
>      err = pvr_stream_process(...);
> 
>      kfree(stream);
> 
>      return err;
> 
> as you did for drivers/gpu/drm/imagination/pvr_job.c.

You are right! that will be more clean.

> 
> CJ
> 
>>     static int init_render_fw_objs(struct pvr_context *ctx,
> 
> 


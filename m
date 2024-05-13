Return-Path: <linux-kernel+bounces-177109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4C98C3A31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 04:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98662B20D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175E12FF86;
	Mon, 13 May 2024 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi2AP+f0"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1158AD0
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 02:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715567293; cv=none; b=OHPclXtet7WOWURZ98WVkL5ol40gA6rpkvOFjfOCmHBqft8jh4rM6VBD1yKv7mnO6EmSWupOsfQjspSsU3bWfijQtc+af74xzNO1SyhRZUjizkc64dGK7mJ/vAFwCm3fo2fLHPdpKMVx4El3UeGkVQ+2Q2qTE5jxCv5jTqAVg8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715567293; c=relaxed/simple;
	bh=VVJQvreLx6s9u8vLQEuJyIbyO++p6lsDkyO6FRNMN5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBiWz3akSXmcVnaWpXNnU1/bNzTAEFqnReORtP1HT2QyeVDiBaE6dI3jkPKVdDD1xG5DliacqYGDlFvNjA9A3EbRhF3/tyILPc+co2jXA1sCW7+SbwOSeCskUtJVexpp4l5La2c2HuVFxJm9KUpRqINRnAaYBhOMaN4Tg+m9+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi2AP+f0; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9a604e367so645955b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2024 19:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715567291; x=1716172091; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TI7IZ9gghuk7hqBECtJ5oqLF42xtO8DCN/xg2xle6Xg=;
        b=Fi2AP+f0YtplM3/i8w2TZjWu0g5cW88ceNMIu4fBngSgRhMrgB7ywecDsqIgW3lzuw
         4GfNqpXQdiStYXJKKXGQ+mqffDbH+fV5F7AdgP5exfm/5Mq8DVdixIVxJYeHKDL3FIYI
         MC+t+mpb3hU49ZvyK5q6sbAuxaDuypB7UIZiu2i9q1ocEc3KCIB0CeFk8fL0vfQRA+fZ
         91LDpsh/MjGKoaiy2uIDJqFzPzTPKUhuAa7J6FLvPUr7s97KZpsoxHUSe+HzNlOJuzCF
         BrXgOhlx4imYyNOcFPk3oXphs+o+xF8bCZS5QoyUINvSI4tcRbwUUzP3g4XZHh0gl8wh
         Q54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715567291; x=1716172091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TI7IZ9gghuk7hqBECtJ5oqLF42xtO8DCN/xg2xle6Xg=;
        b=Fu3zBIiXfVa8RcqXOOqFD0nALYY4lhBF6TtwjwJFKQ7cSB42nhOdKLGSmeeFsoHbpx
         MIRYqfx0jdy50//FggSWgdCyV757kYnJp2cbSEwyMqgR0Y/jvMqGoPg+9bihmIrxJuUm
         UeXO7/Sgu7M1jk0bwtl2tyPF/09TtWeMxAzrvWJWJVkK85WevpoBPCZ3oVWaT8rf+aLt
         tXkQVYubX52kizjzoWHVHFW449tADeW//CHmKPsHkDH3P4rROQKMx3vPsth8SJ4tKC1B
         22swmXnGWtF3KU1LMezE7TdmenpKQQUeEl9Kwyc+hAfkFNOxs014XUHCnyLr+xLBJrKX
         mAaA==
X-Forwarded-Encrypted: i=1; AJvYcCUIOQjRHjXdSX4fXeJNJrdnvnBUsWv0fJ2ACMDHIE8+XNt0urXQoiHiwRYX7kWc7FJqPG3St7vXT5oFXdLTChsJvYuTxMLLvZG3kO/M
X-Gm-Message-State: AOJu0YwxhdkOp4j7caVDnhxyfD1/dyiFMesxnnTXRgIrr/UKpvvyQVmA
	oSjR5tJkImcTn3FS2+uNNKOFS/u9snFR9jWbo6OdM3NTpoX0AK/+
X-Google-Smtp-Source: AGHT+IG1G/ieE63cEjKy9sfCQl2ZXgf9sh06Q4LaRnrEGqMQPgGQhcOYcXMpTyJJ+2CGRVbYPQlAXw==
X-Received: by 2002:a05:6808:4407:b0:3c9:7057:e8b2 with SMTP id 5614622812f47-3c9970ba8bfmr10012295b6e.44.1715567291446;
        Sun, 12 May 2024 19:28:11 -0700 (PDT)
Received: from [0.0.0.0] (74.211.104.32.16clouds.com. [74.211.104.32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af58b8sm6519618b3a.142.2024.05.12.19.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 19:28:11 -0700 (PDT)
Message-ID: <ed780193-98b4-43ec-8062-be26681f6161@gmail.com>
Date: Mon, 13 May 2024 10:28:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Content-Language: en-US
To: Aaron Tomlin <atomlin@atomlin.com>, Wenchao Hao <haowenchao2@huawei.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 linux-kernel@vger.kernel.org, neelx@redhat.com
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
 <uo54qjyy7zts6nyxb2sfsxnh6lma4ezoybr7qc7da5k77rwoig@sj2a4wgfmcgu>
From: Wenchao Hao <haowenchao22@gmail.com>
In-Reply-To: <uo54qjyy7zts6nyxb2sfsxnh6lma4ezoybr7qc7da5k77rwoig@sj2a4wgfmcgu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/11 22:15, Aaron Tomlin wrote:
> On Wed, Apr 24, 2024 at 02:21:04AM GMT, Wenchao Hao wrote:
>> Task comm of task is limitted to 16, prefix "kworker/R-" is added for
>> rescuer worker's task, which cause most task name is truncated as
>> following:
>>
>> root   81  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xprti]
>> root   82  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-cfg80]
>> root   85  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-nfsio]
>> root   86  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfsal]
>> root   87  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-xfs_m]
>> root   88  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-acpi_]
>> root   93  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-iscsi]
>> root   95  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
>> root   97  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
>> root   99  0.0  0.0  0  0 ?   I<   11:18   0:00 [kworker/R-scsi_]
>>
>> I want to fix this issue by split rescuer name to 2 part like other
>> kworker, the normal part is "kworker/R" which is set to task_struct's comm,
>> another part is wq->name which is added to kworker's desc. These 2 parts
>> would be merged in wq_worker_comm().
>>
>> Fixes: b6a46f7263bd ("workqueue: Rename rescuer kworker")
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>   kernel/workqueue.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
>> index 0066c8f6c154..0ce9e8597a4d 100644
>> --- a/kernel/workqueue.c
>> +++ b/kernel/workqueue.c
>> @@ -5430,7 +5430,7 @@ static int init_rescuer(struct workqueue_struct *wq)
>>   	}
>>   
>>   	rescuer->rescue_wq = wq;
>> -	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R-%s", wq->name);
>> +	rescuer->task = kthread_create(rescuer_thread, rescuer, "kworker/R");
>>   	if (IS_ERR(rescuer->task)) {
>>   		ret = PTR_ERR(rescuer->task);
>>   		pr_err("workqueue: Failed to create a rescuer kthread for wq \"%s\": %pe",
>> @@ -5439,6 +5439,8 @@ static int init_rescuer(struct workqueue_struct *wq)
>>   		return ret;
>>   	}
>>   
>> +	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
>> +
>>   	wq->rescuer = rescuer;
>>   	if (wq->flags & WQ_UNBOUND)
>>   		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
>> @@ -6289,6 +6291,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
>>   						  worker->desc);
>>   			}
>>   			raw_spin_unlock_irq(&pool->lock);
>> +		} else if (worker->desc[0] != '\0') {
>> +			scnprintf(buf + off, size - off, "-%s", worker->desc);
>>   		}
>>   	}
>>   
>> -- 
> 
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> 
Thanks for your review, I would add your Reviewed-by and remove the RFC 
tags, then post again.


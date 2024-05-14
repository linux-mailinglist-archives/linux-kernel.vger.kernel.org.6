Return-Path: <linux-kernel+bounces-178242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F111D8C4AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 03:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DAFA1C21509
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 01:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365244687;
	Tue, 14 May 2024 01:37:12 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024CD17C2
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650631; cv=none; b=OkoHmrLCO35GHpM8HvMGMAEG4x9Q8RqRWw0gKH2MvCfIN2AQnL8hgBVse8JMxbnGfuxI8hog5MYCD25/Ks03q4Yxg8N65Gq/NCO5Agbt0jFSW3k5QXUdeNRSS/SJ6KDRpU1WGpWaA05lcOC79a4DUvNMKp0dO1MQPyYZ3pPWgX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650631; c=relaxed/simple;
	bh=A2U/djugEBDOHauwKBNAyF3tapz9//vAYIvi2ZU25FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LgezF4sZ3cW4vFslwqiDwLZ+FtQi1Ccm08qNLgBCB0o06DGrSkTLiJa6SL1KG6+LL33RAdjX7qdfp5J0HqNWHP2jFbbtQEMDF07jthx5MGfCoHCQIGCYDHNXSBcVhJz6GvU438OCBwpg1hV5yXsbYZwl+IANsAnbYhHo6kBh9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vdf5H1CCYz1S5kH;
	Tue, 14 May 2024 09:33:39 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 471BA1402CA;
	Tue, 14 May 2024 09:37:06 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 09:37:05 +0800
Message-ID: <185e1d7a-719d-4fec-8e4f-e7cf0bea1573@huawei.com>
Date: Tue, 14 May 2024 09:37:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] workqueue: Fix rescuer task's name truncated
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>
CC: Lai Jiangshan <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
	Wenchao Hao <haowenchao22@gmail.com>, <neelx@redhat.com>
References: <20240423182104.1812150-1-haowenchao2@huawei.com>
 <uo54qjyy7zts6nyxb2sfsxnh6lma4ezoybr7qc7da5k77rwoig@sj2a4wgfmcgu>
 <ZkJLHtiGb6XM4iMO@slm.duckdns.org>
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <ZkJLHtiGb6XM4iMO@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/5/14 1:17, Tejun Heo wrote:
> Hello
> 
> On Sat, May 11, 2024 at 03:15:11PM +0100, Aaron Tomlin wrote:
>>> @@ -5439,6 +5439,8 @@ static int init_rescuer(struct workqueue_struct *wq)
>>>   		return ret;
>>>   	}
>>>   
>>> +	snprintf(rescuer->desc, sizeof(rescuer->desc), "%s", wq->name);
> 
> Can you please address the testbot reported warning?
> 

Of course.

The warning is also reported here: https://lore.kernel.org/all/20240513030639.3772468-1-haowenchao2@huawei.com/

It's caused because commit 31c89007285d ("workqueue.c: Increase workqueue name length") increase
WQ_NAME_LEN from 24 to 32, but forget to increase WORKER_DESC_LEN which should equalto WQ_NAME_LEN.
Same usage can be found in process_one_work(), it called strscpy() which would not WARNING.

I sent a V2 patch with following changes appended for this warning, maybe you missed them.

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 158784dd189a..72031fa80414 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -92,7 +92,7 @@ enum wq_misc_consts {
         WORK_BUSY_RUNNING       = 1 << 1,
  
         /* maximum string length for set_worker_desc() */
-       WORKER_DESC_LEN         = 24,
+       WORKER_DESC_LEN         = 32,
  };
  
  /* Convenience constants - of type 'unsigned long', not 'enum'! */

>>>   	wq->rescuer = rescuer;
>>>   	if (wq->flags & WQ_UNBOUND)
>>>   		kthread_bind_mask(rescuer->task, wq_unbound_cpumask);
>>> @@ -6289,6 +6291,8 @@ void wq_worker_comm(char *buf, size_t size, struct task_struct *task)
>>>   						  worker->desc);
>>>   			}
>>>   			raw_spin_unlock_irq(&pool->lock);
>>> +		} else if (worker->desc[0] != '\0') {
>>> +			scnprintf(buf + off, size - off, "-%s", worker->desc);
>>>   		}
>>>   	}
>>>   
>>> -- 
>>
>> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> 
> The patch looks fine to me otherwise.
> 
> Thanks.
> 



Return-Path: <linux-kernel+bounces-367099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CD99FE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7731F24E18
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 02:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4495478E;
	Wed, 16 Oct 2024 02:00:27 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCEF2AD05
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044026; cv=none; b=TkyS2wXgzWZmQwvI3rNAl5UO3ikQdPvbVfg2dC/bUKLMDXlD/w94BKmcVWSBK09SdMUPQmvxkL85CqUfinwR1mAhe/+f1a4GYwk6z+xSOHts5RcRT4yDiMWFwQ3zUBfqo3Wg5Wrep5TmOG1eI8Ifo4mpNYjE3mTbTxW3GvqG+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044026; c=relaxed/simple;
	bh=9FMzClU/AcjjO0CF/XY9029NuFGqMslcDz4Zvw6Uimk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bdBx5yJGsgIIume5Z6HN86kflewSEnO+bDVKd7J8i9Dg/Rg2j43GLfNY2SGgKLUpCN3NKvgfT68fe4imdKRz3QmNKwqZE7M6u21UrAX9lv4z/YD2IoB4lrZEtlRTXsj0td0t0uMngnHZmfxz+mrkp4MrR0tVuwmixloRoeZtrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XSvHc1f8jzfdCx;
	Wed, 16 Oct 2024 09:57:48 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F41C1402C8;
	Wed, 16 Oct 2024 10:00:15 +0800 (CST)
Received: from [10.48.175.103] (10.48.175.103) by
 kwepemg200007.china.huawei.com (7.202.181.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 10:00:13 +0800
Message-ID: <b32e3d87-acd8-478e-a953-8e6ef18b1e75@huawei.com>
Date: Wed, 16 Oct 2024 10:00:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched_ext: Fix missing unlock in consume_dispatch_q()
To: Tejun Heo <tj@kernel.org>
CC: David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20241015142917.83397-1-zhangqiao22@huawei.com>
 <Zw7MpoDcKmX9mGlK@slm.duckdns.org>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <Zw7MpoDcKmX9mGlK@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200007.china.huawei.com (7.202.181.34)

hello

在 2024/10/16 4:12, Tejun Heo 写道:
> Hello,
> 
> On Tue, Oct 15, 2024 at 10:29:17PM +0800, Zhang Qiao wrote:
>> When the function consume_dispatch_q() returns true, the dsq lock may
>> remains held and is not unlocked.
>>
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> ---
>>  kernel/sched/ext.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 410a4df8a121..4d80aa3de00e 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -2377,7 +2377,8 @@ static inline bool consume_remote_task(struct rq *this_rq, struct task_struct *p
>>  static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
>>  {
>>  	struct task_struct *p;
>> -retry:
>> +	bool ret = false;
>> +
>>  	/*
>>  	 * The caller can't expect to successfully consume a task if the task's
>>  	 * addition to @dsq isn't guaranteed to be visible somehow. Test
>> @@ -2394,19 +2395,20 @@ static bool consume_dispatch_q(struct rq *rq, struct scx_dispatch_q *dsq)
>>  		if (rq == task_rq) {
>>  			task_unlink_from_dsq(p, dsq);
>>  			move_local_task_to_local_dsq(p, 0, dsq, rq);
>> -			raw_spin_unlock(&dsq->lock);
>> -			return true;
>> +			ret = true;
>> +			break;
>>  		}
>>  
>>  		if (task_can_run_on_remote_rq(p, rq, false)) {
>> -			if (likely(consume_remote_task(rq, p, dsq, task_rq)))
>> -				return true;
>> -			goto retry;
>> +			if (likely(consume_remote_task(rq, p, dsq, task_rq))) {
>> +				ret = true;
>> +				break;
>> +			}
>>  		}
>>  	}
>>  
>>  	raw_spin_unlock(&dsq->lock);
>> -	return false;
>> +	return ret;
> 
> Has this change been tested at all? There's quite a bit of lock dancing

I tested this patch using scx_simple scheduler.

> happening in the remote consumption path because the task needs to get
> hot-migrated to the local CPU - consume_remote_task() calls
> unlink_dsq_and_lock_src_rq() which drops the DSQ lock among other things.

Yes, i missed it.

Thanks.

> 
> Thanks.
> 


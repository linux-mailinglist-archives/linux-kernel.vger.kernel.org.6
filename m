Return-Path: <linux-kernel+bounces-408757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB99B9C8338
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563B7B2443C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED821E884D;
	Thu, 14 Nov 2024 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uvtdBRnf"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA65470818
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731566228; cv=none; b=UFO1b3Pk7d4jODIX4zAVXATj/V1zhdASgw3JMjSSBlWwXHWxyeG+zQs7SYRduuWfaaaiIXcvpqh0SBlsBdOH0E3DCnSZ0YCX14WbFfdw8FfQDsGqG7NGCMgnR2/qJr1LN1aYBstRc9B3faO511cBvX4TfflxsPRFevia1zbZaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731566228; c=relaxed/simple;
	bh=4StQgQw8IKE8JG0p5HIfweaJkBgC4aCPZGe1hoEtB3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBBNYU7NgtgyHaCefhGJwkX+q1YWlIFt6ZA/DbInVge2KcaaAxDEXttJWIA+C7OVgB00Fo11q5zbup/45R86jfLUiVCGyUs/5sPI7zlnZ8ai/vID1ts0lmyqxDP8lS8qIOsV1i2c8ED5X5+c55YF6smWBQutAmp4bOuO9HxUdMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uvtdBRnf; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731566216; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=S7mhr259zLDOx1yQQbSy6FIrfLCTQItWfhy5j8KtU0M=;
	b=uvtdBRnffIYwyWY2OPDTzshkxVRKh9+y6frLV58sxxOuhyTOpgY1HFEJ8zJ+YWouOZ4w+APk9wR3RnYvQ8mXdE/K5tqVuVhDJPve9bamh9bxPdhLuxdyjMM80nGewFXXoKpLaca1B5JDqK++w2/wqpLrVWGH+6hf90n9TKILnPA=
Received: from 30.74.129.177(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0WJNcAAM_1731566214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 14:36:55 +0800
Message-ID: <a903d0dc-1d88-4ae7-ac81-3eed0445654d@linux.alibaba.com>
Date: Thu, 14 Nov 2024 14:36:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/eevdf: Force propagating min_slice of cfs_rq
 when a task changing slice
To: =?UTF-8?B?6KejIOWSj+aihQ==?= <xieym_ict@hotmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241028063313.8039-2-dtcccc@linux.alibaba.com>
 <20241031094822.30531-1-dtcccc@linux.alibaba.com>
 <2c4654d1-f212-43ac-abf9-de6d08c85387@linux.alibaba.com>
 <ME0P300MB04148C8F736D90AC822CE3678E5A2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
 <d83e1631-237e-4743-b067-6cc54771eee7@linux.alibaba.com>
 <ME0P300MB04142599FB1D9BBF8AFECE7F8E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <ME0P300MB04142599FB1D9BBF8AFECE7F8E5B2@ME0P300MB0414.AUSP300.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/11/14 14:06, 解 咏梅 wrote:
> Let analyze it case by case:P
> 
> say cgroup A has 3 tasks: task A, task B, task C
> 
> 1) assign taskA's slice to 0.1 ms, task B, tack C, task C all have the default slice (0.75ms)
> 
> 2) task A is picked by __schedule as next task, because task A is still on rq,
> so the cfs_rq hierarchical doesn't have to change cfs_rq's min_slice, it will report it to the root cgroup
> 
> 3)  task A is preempted by other task, it's still runnable. it will be requeued cgroup A's cfs_rq. similar as case 2
> 
> 4) task A is preempted since it's blocked, task A's se will be retained in cgroup A's cfs_rq until it reach 0-lag state.
> 4.1 before 0-lag, I guess it's similar as case 2
>       the logic is based on cfs_rq's avg_runtime, it supposed task A won't be pick as next task before it reach 0-lag state.
>       If my understanding is wrong, pls correct me. Thanks.
> 4.2 After it reached 0-lag state, If it's picked by pick_task_fair, it will be removed from cgroup A cfs_rq ultimately.
>       pick_next_entity->dequeue_entities(DEQUEUE_SLEEP | DEQUEUE_DELAYED)->__dequeue_entity (taskA)
>      so, cgroup A's cfs_rq min_slice will be re-calculated. So the cfs_rq hierarchical  will modify their own min_slice bottom up.
> 4.3 After it reached 0-lag state, it will waked up. Because, the current __schedule() split the path for block/sleep from migration path. only migration path will call deactivate. so p->on_rq is still 1, ttwu_runnable will work for it to just call requeue_delayed_entity. similar as case 2
> 
> I think only case 1 has such problem.
> 
> Regards,
> Yongmei.
> 

I think you misunderstood the case. We're not talking about the DELAY_DEQUEUE 
feature. We're simply talking about enqueue(waking up) and dequeue(sleeping).
For convenience, let's turn DELAY_DEQUEUE off.

Consider the following cgroup hierarchy on one cpu:


                     root_cgroup
                         |
              ------------------------
              |                      |
          cgroup_A(curr)      other_cgroups...
              |
        --------------
        |            |
    any_se(curr)   cgroup_B(runnable)
                     |
                ------------
                |          |
           task_A(sleep)  task_B(runnable)

Assume task_A has a smaller slice(0.1ms) and all other tasks have default 
slice(0.75ms).

Because task_A is sleeping, it is not actually on the tree.

Now task_A is woken up. It is enqueued to cgroup_B. So slice of cgroup_B is 
updated to 0.1ms. This is ok.

However, Since cgroup_B is already on_rq, it cannot be "enqueued" again to 
cgroup_A. The code is running to the bottom half.(the second 
for_each_sched_entity loop in enqueue_task_fair)

So the slice of cgroup_A is not updated. It is still 0.75ms.

Thanks.


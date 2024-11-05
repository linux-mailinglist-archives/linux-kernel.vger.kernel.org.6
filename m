Return-Path: <linux-kernel+bounces-395757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499819BC278
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAFFF1F22CFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199918643;
	Tue,  5 Nov 2024 01:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ysCUfXmZ"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD35168BD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730769692; cv=none; b=QeQW8cbsH7V92cAnD6FBLwTpPyTNTYfEA5+HXnM4UQyxnB6HwSOCH/ZY61NgLnIK0b6Ui0deQzejjIF3syZ2xAqazjcZCzwP/Elnm0lonuATq6/3h3oP77L0pUwRv9YKUpBgn6ObVtG/91eHwPXd3SBsqez0OWRcj+2tO+OTMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730769692; c=relaxed/simple;
	bh=Abg9E5PbyN8zKFJE/eaP+QX3ulRxErnGHnbUjLh4laA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MM8FyWwH5jF7UlhtjgjDYRaSKXb4cwRU0j283xr8/zldXWNZfExzBwoQ6V8tqJPwyVUGLXoy3bs+avkNwDlToV7vaLgLcn5gBh+yt2nn1rhoLoQ8A6x/UDBDW1YkE+BEXGsRZfMM5pjcN7JPS5W7CftwbTLobhIt0FG8U51JbrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ysCUfXmZ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730769685; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7hmXB0YjoavMhOzKtGXpOjuxd+fLP7nuhjWqR0OFL7k=;
	b=ysCUfXmZP1Yb7llTzxsg6FcLzrTz/iZgdFk1QVmDv2jnVhNa4ecJJhIagqc5TYE2rAAS0vqivlDqDpQc9pxEHkXmYF6EnLAJdtCOU0bU/NXlkAd8aCiANIB7EkXdIn2dE6zSIR8UkBE88GbUsTScul0hZ0ATY2fgyedIwhZjn7c=
Received: from 30.178.65.199(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0WIkzzBP_1730769684 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 09:21:24 +0800
Message-ID: <10b8fc5b-fa72-4772-939b-7b43b7861eca@linux.alibaba.com>
Date: Tue, 5 Nov 2024 09:21:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] sched: Remove unnecessary initialization in
 init_cfs_bandwidth() function
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 linux-kernel@vger.kernel.org
References: <20241104121443.86468-1-yaoma@linux.alibaba.com>
 <20241104121847.GE24862@noisy.programming.kicks-ass.net>
From: yaoma <yaoma@linux.alibaba.com>
In-Reply-To: <20241104121847.GE24862@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/4 20:18, Peter Zijlstra 写道:
> On Mon, Nov 04, 2024 at 08:14:43PM +0800, Bitao Hu wrote:
>> The root task group is statically defined, and non-root task groups
>> are allocated memory using kmem_cache_alloc() with the __GFP_ZERO
>> flag. In both cases, the corresponding 'struct cfs_bandwidth' is a
>> block of all-zero memory. Therefore, it is unnecessary to explicitly
>> set zeros in the init_cfs_bandwidth() function.
>>
>> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
>> ---
>>   kernel/sched/fair.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2d16c8545c71..2fd96641164f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6573,10 +6573,8 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
>>   void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
>>   {
>>   	raw_spin_lock_init(&cfs_b->lock);
>> -	cfs_b->runtime = 0;
>>   	cfs_b->quota = RUNTIME_INF;
>>   	cfs_b->period = ns_to_ktime(default_cfs_period());
>> -	cfs_b->burst = 0;
>>   	cfs_b->hierarchical_quota = parent ? parent->hierarchical_quota : RUNTIME_INF;
>>   
>>   	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
> 
> But this shows someone thought about it and 0 is the right value, and
> not an oversight.

Okay, I got it.



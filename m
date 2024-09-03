Return-Path: <linux-kernel+bounces-313045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C9F969F77
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D94011F21A38
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD029D06;
	Tue,  3 Sep 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiZgS6Yx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E833F21373
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725371640; cv=none; b=PDOzj1+i6a7mZt3m64LDPTcFh9giMOHhQPIispqH6o/B/FH5juE+yD6vDLTCGcswoMssZrkTYR0w2xr8wjzzL/L5zn1nPZvihj4lGwrhKOAZkpmr4LQ96AKnZ3PlPY/MRMuB2pxAT1gL3xn03fPFvjaI7ICPMmkYrE4vYMpy0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725371640; c=relaxed/simple;
	bh=jsbhdYxUrE8lxh3QgMyMAmd1c/nI7x4iyZVAU8yHiDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=picIztS12xlSIiFhxVI7+Pnmf97TcLxQMzmSiTy5XD7ml6DFhDrT72xdojW+AR8vj1DkLu1IOzFFOcOTKhnO/Gqw0jno7wrmjRjpboSqenPevGZmJW+Q2dhXGP9mT5qMSwTb0oDMdYP7jnYc0OcsUF9vH+L3lkw8SFTzemOJZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiZgS6Yx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725371637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TzGiZvAUzaN7cLUP2IZjvPC3yppTfdnWfzQd1HxbtGQ=;
	b=QiZgS6YxFn1ePrdIz3lcoXSJEVbPy7ZyVRGf3BaJl3Uc/n3XfHE9VUSzDGoaR/z35rz2RM
	uWydO3kVQWUBMRKEoofngCpP7ltadZc9p36wcRYIbBYz3QWh65LsDKAp5D+zTSLxnWQf4+
	IxnQDucR4SamZv+QfadAy8omnzx5yS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-YMAg_PAfPD2P7ub1qgjJAw-1; Tue,
 03 Sep 2024 09:53:52 -0400
X-MC-Unique: YMAg_PAfPD2P7ub1qgjJAw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C71251979056;
	Tue,  3 Sep 2024 13:53:49 +0000 (UTC)
Received: from [10.2.16.89] (unknown [10.2.16.89])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 163EC19560AA;
	Tue,  3 Sep 2024 13:53:46 +0000 (UTC)
Message-ID: <d43165ae-9124-4034-b816-d09c9a48ecec@redhat.com>
Date: Tue, 3 Sep 2024 09:53:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] sched/fair: Use HK_TYPE_SCHED housekeeping CPUs
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-3-longman@redhat.com>
 <ZtcLUcJvqSV3vXd2@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZtcLUcJvqSV3vXd2@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


On 9/3/24 09:12, Frederic Weisbecker wrote:
> Le Sun, Aug 18, 2024 at 07:45:19PM -0400, Waiman Long a écrit :
>> As the previous commit has enabled the setting of HK_TYPE_SCHED
>> housekeeping CPUs in nohz_full setup, we can now use the more aptly
>> named HK_TYPE_SCHED housekeeping CPUs instead of HK_TYPE_MISC.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Can we instead merge HK_FLAG_TICK, HK_FLAG_WQ, HK_FLAG_TIMER, HK_FLAG_RCU,
> HK_FLAG_MISC and HK_FLAG_KTHREAD into a single
> HK_FLAG_KERNEL_NOISE / HK_TYPE_KERNEL_NOISE ?

Sure. I am open to new name as I am not good on that. 
HK_FLAG_KERNEL_NOISE does make sense.

Cheers,
Longman

>
> Thanks.
>
>> ---
>>   kernel/sched/fair.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6be618110885..0350667f5ce8 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -12128,16 +12128,13 @@ static inline int on_null_domain(struct rq *rq)
>>    * - When one of the busy CPUs notices that there may be an idle rebalancing
>>    *   needed, they will kick the idle load balancer, which then does idle
>>    *   load balancing for all the idle CPUs.
>> - *
>> - * - HK_TYPE_MISC CPUs are used for this task, because HK_TYPE_SCHED is not set
>> - *   anywhere yet.
>>    */
>>   static inline int find_new_ilb(void)
>>   {
>>   	const struct cpumask *hk_mask;
>>   	int ilb_cpu;
>>   
>> -	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
>> +	hk_mask = housekeeping_cpumask(HK_TYPE_SCHED);
>>   
>>   	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
>>   
>> @@ -12155,7 +12152,7 @@ static inline int find_new_ilb(void)
>>    * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
>>    * SMP function call (IPI).
>>    *
>> - * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
>> + * We pick the first idle CPU in the HK_TYPE_SCHED housekeeping set (if there is one).
>>    */
>>   static void kick_ilb(unsigned int flags)
>>   {
>> -- 
>> 2.43.5
>>



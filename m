Return-Path: <linux-kernel+bounces-315721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB8596C636
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD241B21442
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A411E1A36;
	Wed,  4 Sep 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcCtCQhh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271B11D6790
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474034; cv=none; b=fsGpLyjMQHWCn19tXU4EJE4+lukLZ2BIGq9Eb7WrOcvnMA3PGunk6v/xuR296QP5h1crv5sIP9cxqdB4uk+1/+UfJbjEcUK1WmATyQDACM6dT8kvUSzQ9TDimBuq4otr0TIlgNLRGMpAkf4AuVa1YGHN7ME2GtU8tc6uLEReB/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474034; c=relaxed/simple;
	bh=I5buvN7KzSdrH21KWSFM58HNRbGIaailfbRnExnRvFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tfxvqL26428JG0Exs63bys1Hf2Y9+TgkYwcpNxP2Vei7e4tGdyE8aJqnvu1WYoN3U99KjsrQf9p1FlT4XVTSHRcVgfsSh36ca+nuTcmJntqA+0z7xoR2oPA6Hnox4LRimEmfm678GsDXk2ELmCO4tvtZX29iv5j4Q/Yuxr49xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcCtCQhh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725474031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Q33KHwOo6WRVj9CXRGFVD9EbJuDLyRsvydPmGRP2tk=;
	b=LcCtCQhhyyUZ3LtNKHi8D6e04e2XtSM1tMxe0iy29qLs/wQLmCL7thDmY45NRUwMcl5bvz
	xKfItESwfdSp4amgVbtCxR1p/6XJJk5j2IgE+O5F/zVlmXtd42dQ+DRBiJ7ULZNg/2Jgqq
	RX/mmSDf4+u0+Ma89yuttPzD8uKsjmM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-21ntd6BuNselRYYcTaw1fg-1; Wed,
 04 Sep 2024 14:20:30 -0400
X-MC-Unique: 21ntd6BuNselRYYcTaw1fg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B61B419560A2;
	Wed,  4 Sep 2024 18:20:28 +0000 (UTC)
Received: from [10.2.16.172] (unknown [10.2.16.172])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 489BD1956052;
	Wed,  4 Sep 2024 18:20:26 +0000 (UTC)
Message-ID: <560fdd10-f12b-4ce8-a628-c4952eff93ec@redhat.com>
Date: Wed, 4 Sep 2024 14:20:25 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] sched/isolation: Consolidate housekeeping cpumasks
 that are always identical
To: Phil Auld <pauld@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org
References: <20240904171441.1048072-1-longman@redhat.com>
 <20240904171441.1048072-3-longman@redhat.com>
 <20240904171949.GC136544@pauld.westford.csb>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240904171949.GC136544@pauld.westford.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/4/24 13:19, Phil Auld wrote:
> On Wed, Sep 04, 2024 at 01:14:41PM -0400 Waiman Long wrote:
>> The housekeeping cpumasks are only set by two boot commandline
>> parameters: "nohz_full" and "isolcpus". When there is more than one of
>> "nohz_full" or "isolcpus", the extra ones must have the same CPU list
>> or the setup will fail partially.
>>
>> The HK_TYPE_TICK, HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are
>> settable by "isolcpus" and they can be set individually. The other
>> housekeeping types are all set by "nohz_full" without a way to set them
>> individually. So they all have identical cpumasks.
>>
>> There is actually no point in having different cpumasks for these
>> "nohz_full" only housekeeping types. Consolidate these types to use the
>> same cpumask by aliasing them to the same value. If there is a need to
>> set any of them independently in the future, we can break them out to
>> their own cpumasks again.
>>
>> With this change, the number of cpumasks in the housekeeping structure
>> drops from 9 to 4.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   include/linux/sched/isolation.h | 18 ++++++++++++------
>>   kernel/sched/isolation.c        |  9 ++-------
>>   2 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
>> index 499d5e480882..e2c42172de82 100644
>> --- a/include/linux/sched/isolation.h
>> +++ b/include/linux/sched/isolation.h
>> @@ -7,15 +7,21 @@
>>   #include <linux/tick.h>
>>   
>>   enum hk_type {
>> -	HK_TYPE_TIMER,
>> -	HK_TYPE_RCU,
>> -	HK_TYPE_MISC,
>>   	HK_TYPE_TICK,
>>   	HK_TYPE_DOMAIN,
>> -	HK_TYPE_WQ,
>>   	HK_TYPE_MANAGED_IRQ,
>> -	HK_TYPE_KTHREAD,
>> -	HK_TYPE_MAX
>> +	HK_TYPE_KERNEL_NOISE,
>> +	HK_TYPE_MAX,
>> +
>> +	/*
>> +	 * The following housekeeping types are only set by the nohz_full
>> +	 * boot commandline option. So they can share the same value.
>> +	 */
>> +	HK_TYPE_TIMER   = HK_TYPE_KERNEL_NOISE,
>> +	HK_TYPE_RCU     = HK_TYPE_KERNEL_NOISE,
>> +	HK_TYPE_MISC    = HK_TYPE_KERNEL_NOISE,
>> +	HK_TYPE_WQ      = HK_TYPE_KERNEL_NOISE,
>> +	HK_TYPE_KTHREAD = HK_TYPE_KERNEL_NOISE
>>   };
>>   
>>   #ifdef CONFIG_CPU_ISOLATION
>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>> index 5345e11f3d44..2b654272edcd 100644
>> --- a/kernel/sched/isolation.c
>> +++ b/kernel/sched/isolation.c
>> @@ -9,14 +9,10 @@
>>    */
>>   
>>   enum hk_flags {
>> -	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
>> -	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
>> -	HK_FLAG_MISC		= BIT(HK_TYPE_MISC),
>>   	HK_FLAG_TICK		= BIT(HK_TYPE_TICK),
>>   	HK_FLAG_DOMAIN		= BIT(HK_TYPE_DOMAIN),
>> -	HK_FLAG_WQ		= BIT(HK_TYPE_WQ),
>>   	HK_FLAG_MANAGED_IRQ	= BIT(HK_TYPE_MANAGED_IRQ),
>> -	HK_FLAG_KTHREAD		= BIT(HK_TYPE_KTHREAD),
>> +	HK_FLAG_KERNEL_NOISE	= BIT(HK_TYPE_KERNEL_NOISE),
>>   };
>>   
>>   DEFINE_STATIC_KEY_FALSE(housekeeping_overridden);
>> @@ -194,8 +190,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
>>   {
>>   	unsigned long flags;
>>   
>> -	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
>> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
>> +	flags = HK_FLAG_KERNEL_NOISE;
>>
> This does not look equivalent. HK_FLAG_TICK seems to be lost?

You are right. I will send out v3 to correct that.

Cheers,
Longman



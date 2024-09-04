Return-Path: <linux-kernel+bounces-316117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D48D96CB75
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 01:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C49282707
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF9188A0B;
	Wed,  4 Sep 2024 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4Pfirss"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23618893C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 23:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725494244; cv=none; b=lA/WKQjRIGk648cviK4OGaNfxL0SDqLge/JUPK0ir0j/FkuPrdWg86vC/xumLyyLr/HXO5nXaE/Hhu53KzuprwmdZep0syejKPkQY3Z3EBWkqq9ApGWY823HxTpaRG1A/L2YzmfDFp6BfTsCFcoxo45vhZCtFNjLwvWn3SGIYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725494244; c=relaxed/simple;
	bh=xQIh9b7pC3cTB5SqLSynWF90v5l+hyMDOkTeuRzx/ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p//6LbKA3XsV7/mzArJpCtPUTe28aASfUVOVPpoPOCwfB4zoWTSBjhP21VkLGQ8IKJMvvSDnJJMJDDWmsg3zGb1q6nJEBso4daWaCCXBWktxHjjX7TQwqCcgeP6VWDH6bfwmj7QXequvZmAJopO/YVJ4Vo6cyqs/vUuOq19mkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4Pfirss; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725494241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7aL90vYu8QHdUKl/PZ1JzwewxfNGVvwgyFz2+FKAv4=;
	b=I4Pfirsswa+PPyeLO1L0OYHM4YXwzsObokSHry9ddHeY776HgNU5Uwt9iPprZiGvClb8X3
	XzC9xVjquprfr1Zifwg8Uy51gyzG9n1pZYNpYLAyqCl8v5A0mQyi+jNlndeRFQLqMrXppR
	JoP56/RftV8zNdJUEfzbNcWCnY1iGek=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-u4ezL74cMOedqbzHYlvvIQ-1; Wed,
 04 Sep 2024 19:57:18 -0400
X-MC-Unique: u4ezL74cMOedqbzHYlvvIQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 527B4195394A;
	Wed,  4 Sep 2024 23:57:16 +0000 (UTC)
Received: from [10.2.16.172] (unknown [10.2.16.172])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8F961956088;
	Wed,  4 Sep 2024 23:57:13 +0000 (UTC)
Message-ID: <4b976f7c-b105-4093-8838-eae26fc7de85@redhat.com>
Date: Wed, 4 Sep 2024 19:57:13 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sched/isolation: Consolidate housekeeping cpumasks
 that are always identical
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20240904183650.1053708-1-longman@redhat.com>
 <20240904183650.1053708-3-longman@redhat.com>
 <ZtjOmPV0V7jbYqfO@pavilion.home>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZtjOmPV0V7jbYqfO@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 9/4/24 17:18, Frederic Weisbecker wrote:
> Le Wed, Sep 04, 2024 at 02:36:50PM -0400, Waiman Long a écrit :
>> The housekeeping cpumasks are only set by two boot commandline
>> parameters: "nohz_full" and "isolcpus". When there is more than one of
>> "nohz_full" or "isolcpus", the extra ones must have the same CPU list
>> or the setup will fail partially.
>>
>> The HK_TYPE_TICK, HK_TYPE_DOMAIN and HK_TYPE_MANAGED_IRQ types are
>> settable by "isolcpus" and they can be set individually. The other
>> housekeeping types are all set by "nohz_full" without a way to set them
>> individually. So they all have identical cpumasks.
> And HK_TYPE_TICK is part of them, so it should become HK_TYPE_KERNEL_NOISE.
HK_TYPE_TICK can also be set with "isolcpus=tick,...". That is the 
reason why it is still a separate type.
>
>> There is actually no point in having different cpumasks for these
>> "nohz_full" only housekeeping types. Consolidate these types to use the
>> same cpumask by aliasing them to the same value. If there is a need to
>> set any of them independently in the future, we can break them out to
>> their own cpumasks again.
>>
>> With this change, the number of cpumasks in the housekeeping structure
>> drops from 9 to 4. There is no other functional change.
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
> Why not removing them entirely and only keep HK_TYPE_KERNEL_NOISE ?

All these HK_TYPE_* types are still used in other parts of kernel. We 
need to clean them all up before we can remove them, but that is outside 
the scope of this series.

Cheers,
Longman




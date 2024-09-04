Return-Path: <linux-kernel+bounces-314022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6C196ADC7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4607A284B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4F8837;
	Wed,  4 Sep 2024 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNiLabc2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596563C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413045; cv=none; b=rVjzc5yh/rvc25q2eBzVrQf5dX+dLqQIbZsVs7sacyqIkuzZXxHHTTLyf9hIZ+Oa9Lxb2qyFsYJcaGxZgpQXvyi6++rW0Xw4Ih0IAJA7wYK8MQiWxolxmaGTjZ/ichnOLaApmZrnjGK5TshwcUfMuCuK0C7Qs5ZQUJ5hlGhgA7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413045; c=relaxed/simple;
	bh=ym0g2ldCvqFHcYL0k8jV0LIqMVa7ibH8q/4jSSfV6kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzehzUnQiSxHK8L8HIR8oyo2dlA+n+ODMmg60XDityvbw86KgNKAKVXuF2Z/kVxNPV/iTwZG8wK4F8lb8xV7sDaDmi7Q5gN03x0kP/rCB+vmJxDaK+roa3dHhw2b8WAdU3u8vRH3LAL57kA0v2rH6uoo4PMw/DPTIxyQIxkVsZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNiLabc2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725413041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkQ0aAYQuFCZfM3+ImRSL4QWKBJSdm/d9nMc/0fAAL8=;
	b=UNiLabc2B6v8LMaHYE+G/8MfcAwzheMkY0jqOSvaq/btwdRz5a7/1zSmB7detrDa6YL4XC
	9lHBLnYQee+tRiDnuMCvlD1AB1xnC4dNr49UzfvXKFU5Hm6bJTTzd7CWMBq0oFtltgGtLu
	8PWDqfYyKuPZ09clEQSsCCihWl/g5uA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-tAAl5DCwPW2gpNULPSIJZA-1; Tue,
 03 Sep 2024 21:23:58 -0400
X-MC-Unique: tAAl5DCwPW2gpNULPSIJZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 805A91955BEF;
	Wed,  4 Sep 2024 01:23:56 +0000 (UTC)
Received: from [10.2.16.89] (unknown [10.2.16.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F193D1956048;
	Wed,  4 Sep 2024 01:23:53 +0000 (UTC)
Message-ID: <4822d111-b02d-469a-a457-46392c35021f@redhat.com>
Date: Tue, 3 Sep 2024 21:23:53 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sched/isolation: Add HK_FLAG_SCHED to nohz_full
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240818234520.90186-1-longman@redhat.com>
 <20240818234520.90186-2-longman@redhat.com>
 <ZtcK3aF_d3BUhiVz@localhost.localdomain>
 <7fa3dbd5-7c2e-4614-a5f4-258546cb090b@redhat.com>
 <ZteAfUXZd1TgIwiL@pavilion.home>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ZteAfUXZd1TgIwiL@pavilion.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 9/3/24 17:32, Frederic Weisbecker wrote:
> Le Tue, Sep 03, 2024 at 09:24:08AM -0400, Waiman Long a écrit :
>> On 9/3/24 09:10, Frederic Weisbecker wrote:
>>> Le Sun, Aug 18, 2024 at 07:45:18PM -0400, Waiman Long a écrit :
>>>> The HK_FLAG_SCHED/HK_TYPE_SCHED flag is defined and is also used
>>>> in kernel/sched/fair.c since commit de201559df87 ("sched/isolation:
>>>> Introduce housekeeping flags"). However, the corresponding cpumask isn't
>>>> currently updated anywhere. So the mask is always cpu_possible_mask.
>>>>
>>>> Add it in nohz_full setup so that nohz_full CPUs will now be removed
>>>> from HK_TYPE_SCHED cpumask.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    kernel/sched/isolation.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
>>>> index 5891e715f00d..a514994af319 100644
>>>> --- a/kernel/sched/isolation.c
>>>> +++ b/kernel/sched/isolation.c
>>>> @@ -196,7 +196,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
>>>>    	unsigned long flags;
>>>>    	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
>>>> -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
>>>> +		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_SCHED;
>>>>    	return housekeeping_setup(str, flags);
>>>>    }
>>> find_new_ilb() already has HK_FLAG_MISC to prevent an isolated CPU
>>> from being elected as an ilb. So I think we should simply remove HK_FLAG_SCHED.
>> There is a check for HK_TYPE_SCHED in nohz_balance_enter_idle() and
>> nohz_newidle_balance(), though it is essentially a no-op as the cpumask has
>> all the CPUs. If we remove HK_TYPE_SCHED, the question now will be whether
>> we should remove the checks at these 2 functions or change them to
>> HK_TYPE_MISC.
> Just remove those two. They are dead code and the nohz_full handling
> of load balancing needs a rethink anyway.
OK, I will modified the patch to remove the dead code.
>
> After discussing with Peter lately, the rules should be:
>
> 1) If a nohz_full CPU is part of a multi-CPU domain, then it should
>     be part of load balancing. Peter even says that nohz_full should be
>     forbidden in this case, because the tick plays a role in the
>     load balancing.

My understand is that most users will use nohz_full together with 
isolcpus. So nohz_full CPUs are also isolated and not in a sched domain. 
There may still be user setting nohz_full without isolcpus though, but 
that should be relatively rare.

Anyway, all these nohz_full/kernel_nose setting will only apply to CPUs 
in isolated cpuset partitions which will not be in a sched domain.

>
> 2) Otherwise, if CPU is not part of a domain or it is the only CPU of all its
>     domains, then it can be out of the load balancing machinery.
I am aware that a single-cpu domain is the same as being isolated with 
no load balancing.
>
> I'm a bit scared about rule 1) because I know there are existing users of
> nohz_full on multi-CPU domains... So I feel a bit trapped.

As stated before, this is not a common use case.

The isolcpus boot option is deprecated, as stated in 
kernel-parameters.txt. My plan is to deprecate nohz_full as well once we 
are able to make dynamic CPU isolation via cpuset works almost as good 
as isolcpus + nohz_full.

Cheers,
Longman



Return-Path: <linux-kernel+bounces-551302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35EA56AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133AE1896061
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D690321C17F;
	Fri,  7 Mar 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvoAxtQ6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254018DF65
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741358970; cv=none; b=ss9oMA34NSgHrHO2EBK+hHsYldTsDS0fBw0N7C8w4rAIxPxmjzOooS4vz6fTnrF3FAAeWBHq7bpyI+1t7jzrdMzT1teQsO7Mj+TVijUn3ltm22are2Gh4GlbUolKAG1TmkZwpsmO3zLiRw8mRznkViSpsB3ohJzROvf8sGutcf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741358970; c=relaxed/simple;
	bh=Xa2M8Oyedov9CzqqA7BF7t/94FZyWBABxwxUgWROkEw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cIZFNuy7Wb6hx5NCI7P0WfZpfVZ5NmaL72Y+9g95OR/ZrkEeEASEKKiRaF2Mm+Y/Dhu6k+ARZmZVp4DBrA8ipKj7JDXB4TmAAOPg73EcqAJ19grAhJWm1yaL4Xg4AlWUHv6qw8OPul4jnIhFcQ/91Po3Vvpu1VhMsiLe7N5Mads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvoAxtQ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741358967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7GrLAwNqj5jFzi2OEhzW73LTthkA0zlXjXOPgivA9E=;
	b=LvoAxtQ6Y/lOQ2HwxJK4VirOqY3ozNJAQjYm6xcxCaLNQooPPnO3N6347ETxvkSbyDL3Az
	V66/VfbjIj0fK1XdEpywP8rYOJeLdNU/tQ7qLwzmNpL5mnHLmNhovJFbYAWVpngXIYY5Tk
	IcAYoPAwW3i3pudR0OsCgLYWPneRPsg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-ACrSEq3AN4e5087AGoZZ3w-1; Fri, 07 Mar 2025 09:49:25 -0500
X-MC-Unique: ACrSEq3AN4e5087AGoZZ3w-1
X-Mimecast-MFC-AGG-ID: ACrSEq3AN4e5087AGoZZ3w_1741358964
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4753df7b9c5so26682651cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 06:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741358964; x=1741963764;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7GrLAwNqj5jFzi2OEhzW73LTthkA0zlXjXOPgivA9E=;
        b=kdo1PqPd5WKvRUogHBvcoR1+SA8E+Ma3CpUZh1Lg+RrP/ySbshmL2U8ilGfJE1E0sX
         Fy60CmM/bkSlE0PrYDatpQzEYH0lr88wAWF1RakljYoc2vUFdlumOmLlJebQ2DLXhpGA
         BxDl9XwViz/7tWAw0SKRByylcL50Fy/8402Bna3W5Bybct+VF/uaAZu2ARUr9LMwUXQa
         0FQxrUTnL5K3Jq8MdjmB/SaHVymWeSdHy4cSMfs7v4KQf9WhqgNgSe3nT7ceFwxsvIt4
         gC4RW2Nqz2WQVkQDL6W+4lP5ruubC1lb0doD4SSfV51BhNafl1F/qUP8UlhICvYxDFns
         qirg==
X-Gm-Message-State: AOJu0YwxrN6VGA8v+qKiKGJUoNoF1EwY6Vewwq2SN4VnML6BXKMEIGNw
	MzP96pxPUo9q6VIjMv8NLsSUM1WYh7tsYLyJ9KRSfEdyxneYG660RbQguGWus+uJ7dNwwfdMdKf
	WUVaOEvym9Tnwtj1/THhilVr4KbkhBcsMM2D3pbHR6OeAksmxn9/mwJr1wzPm1A==
X-Gm-Gg: ASbGncv7h0eekFlZuUM09q2ZYbsdVFwpM5D5FG0PvHv4PNWSHKbhK5gPmuUHl6WH6Rh
	lMjgu7q/iLbxGP2dxYM0qlhIW3F3XIYRvHYFmwxhYATiu9AY6c3WepT00X98mzrGWG2PmxW290K
	DWlR7w+CBj9lqfSIu2FkfZJ0714X6/tObO9ZKr73/ltIbQ+MeEs9Se70Vr05ucJjIS9+ewdsLTL
	GLfYq7d+to2h1GS7u5souDJHIYKyxxWPlokPeRnK40DcQALJaDYrUKBYKxtu9n7KUAxnoloEAgK
	mwToP93hHL6f0NxmDS3iq70rk9fUbHbN99X24IHTcg3Y9oRWm71KyCT4L0c=
X-Received: by 2002:ac8:570e:0:b0:472:ebe:a77b with SMTP id d75a77b69052e-47618af12damr41166421cf.44.1741358964532;
        Fri, 07 Mar 2025 06:49:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGg9MxvBXoC3gaq1yh5f/W9EOwo7B4E+ECIQgPORqxDkN9vSCfNrZ6OdIusa+XHvw8DvZX0wA==
X-Received: by 2002:ac8:570e:0:b0:472:ebe:a77b with SMTP id d75a77b69052e-47618af12damr41166131cf.44.1741358964162;
        Fri, 07 Mar 2025 06:49:24 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9b14c7sm21530021cf.45.2025.03.07.06.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 06:49:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0d7a9d03-3eb7-42c7-bc6b-20283c2ceee5@redhat.com>
Date: Fri, 7 Mar 2025 09:49:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
 <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
 <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>
 <Z8q9E6j6cMX3jTi8@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Z8q9E6j6cMX3jTi8@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/25 4:32 AM, Juri Lelli wrote:
> On 05/03/25 10:52, Juri Lelli wrote:
>> On 04/03/25 11:01, Waiman Long wrote:
>>> On 3/4/25 10:05 AM, Waiman Long wrote:
>>>>> --- a/kernel/sched/topology.c
>>>>> +++ b/kernel/sched/topology.c
>>>>> @@ -6,6 +6,19 @@
>>>>>    #include <linux/bsearch.h>
>>>>>      DEFINE_MUTEX(sched_domains_mutex);
>>>>> +#ifdef CONFIG_SMP
>>>>> +void sched_domains_mutex_lock(void)
>>>>> +{
>>>>> +    mutex_lock(&sched_domains_mutex);
>>>>> +}
>>>>> +void sched_domains_mutex_unlock(void)
>>>>> +{
>>>>> +    mutex_unlock(&sched_domains_mutex);
>>>>> +}
>>>>> +#else
>>>>> +void sched_domains_mutex_lock(void) { }
>>>>> +void sched_domains_mutex_unlock(void) { }
>>>>> +#endif
>>>>>      /* Protected by sched_domains_mutex: */
>>>>>    static cpumask_var_t sched_domains_tmpmask;
>>>>> @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int
>>>>> ndoms_new, cpumask_var_t doms_new[],
>>>>>    void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
>>>>>                     struct sched_domain_attr *dattr_new)
>>>>>    {
>>>>> -    mutex_lock(&sched_domains_mutex);
>>>>> +    sched_domains_mutex_lock();
>>>>>        partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
>>>>> -    mutex_unlock(&sched_domains_mutex);
>>>>> +    sched_domains_mutex_unlock();
>>>>>    }
>>>> There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
>>>> topology.c file and one in cpuset.c. That can be problematic in the
>>>> non-SMP case. Maybe another wrapper to do the assert?
>>> Ignore that as both topology.c and cpuset.c will only be compiled if
>>> CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP"
>>> above.
>> Indeed!
> Ah, actually I believe next patch (3/5) introduce usage for the !SMP
> case in sched_rt_handler()
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4b8e33c615b1..8cebe71d2bb1 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>          int ret;
>
>          mutex_lock(&mutex);
> +       sched_domains_mutex_lock();
>          old_period = sysctl_sched_rt_period;
>          old_runtime = sysctl_sched_rt_runtime;
>
> @@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
>                  sysctl_sched_rt_period = old_period;
>                  sysctl_sched_rt_runtime = old_runtime;
>          }
> +       sched_domains_mutex_unlock();
>          mutex_unlock(&mutex);
>
>          return ret;
>
> So, I will need to add the ifdef back I guess (I removed it on v2). Do
> you agree?

You are right. That change does introduce the need to define the 
!CONFIG_SMP case. I was looking the existing uses o domains_mutex when 
making that suggestions.

It is a good catch.

Cheers,
Longman



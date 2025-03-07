Return-Path: <linux-kernel+bounces-551383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68437A56BC3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26811788AC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ABE21D001;
	Fri,  7 Mar 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfOIidRX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD121C179
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360774; cv=none; b=WgLIhKMQS0y9yQHKaCfOxdzPq6hbhkgdhutdz8j5zrczkiFnb+BAbm/9a12D1mPO+ajnAof2a9KuRwjwUXmbIv79H4K+dUZ2cGSuXrJR6uuQVZkSmazxQFh4cn3mrJGUrQ/HacPNCMGvoi9rlqT3sUA5ioauspSCODS2NqPvhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360774; c=relaxed/simple;
	bh=gYhaNaVy80cladvz8VcRr5nT9/6t+nPTFWqppoCVnOU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oPIdSKyEQ6H042gBxgLUCMKAlmSGOUCHVyZQ6gaGhi6hPqjfgAXDgLbjjOsGAAexmAmaZUdGajhH1VSJUhZjKQpE0xp8gCdQHg3j4wrO6uyqAUK24mPm7/TkdW3TvJCeGRwGUGw97XRSXdA2zouwREa/pZbHCe1MGN/NKSodG7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfOIidRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/voaY1C+JOHxKM+JbIxct2yY2wAsdgT0ed4f25T51P4=;
	b=LfOIidRXqnb2POzHfRn9Pvvp8qD/7+qOO2SE7F/NUyUNtBHJ5m0Kt06UaroZP6ZJB+vvCX
	jr3HYBgkB9Dnk/xWEdm0nIXwJ6haTchjD1obA0+5iLnSqVSFGmillb9dvqd8MPA03oCoVH
	O45ZzU2RbYNLgXlW3E76RUB3GHfneyg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-2CpJviUaO9aAU-9rN_nbOg-1; Fri, 07 Mar 2025 10:19:31 -0500
X-MC-Unique: 2CpJviUaO9aAU-9rN_nbOg-1
X-Mimecast-MFC-AGG-ID: 2CpJviUaO9aAU-9rN_nbOg_1741360770
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e8f6443ed5so34504286d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360770; x=1741965570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/voaY1C+JOHxKM+JbIxct2yY2wAsdgT0ed4f25T51P4=;
        b=xOcaqjwWFb8jw15svSWwHnhzCx858hSCyqT3GVUy/PaWwC/6bwwhoZ4c5TlS1mvYAn
         gCMoMJ+9nzY4RdNM8Jl8Q/TNa6LvUrBZKRDQ6DytlB+AwoBoszYjn7TXx/FPEL/nzIzz
         Wz/roVtM3rpfrv7w8MeLZPntUaS/WJt8ARs7VcTEyBarsEKOVFJeFNbgmNvRVrkrRHTh
         DRl1ZXK6pjzMepD64GdhUhQ3RIuyqiERjvV3Y5Iahn5VL3AaSzGCpazJNkfVdFY+4Q3Q
         B0mZ6oOYM+Kug1xqulcfqH/msaoskiM913jdWqf5Rjho9ONUnNmVXnsqtNchI2YhBOl0
         y1tA==
X-Forwarded-Encrypted: i=1; AJvYcCViXH+WEASiocVSUCQAvPJ8CEh6sf+KpeWz+HDsjhieiBzLitiLa656dVoI/cWpB9WaYiML20C6JSVHvWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMin6cdO58pyeoQJZsRGzxNwu0eLh6ugBEkgw1b1HRUc6lSgLX
	oRY+bwD7QXEkd+SqLldGHuMf6VJBLgp8yG83FIVfxTN88lCX1MJza01KZicd8Km+z6hjHyM+1Bf
	PV90R4q3wwSQRJavhEF4qg3NQZExytC8+Qw9sEmTI1kqBNUAtHJDdvuZ+15Nw8w==
X-Gm-Gg: ASbGncsNH59ETp9fjdlh1Aa73+l9rsb/9YgPePjWrLs3JxGqn5jGL0yDjhOEbfukRAf
	ZeX2UR+cIW75aCRMTVg79Guxe5Hisk2HGKXNqeHvywLSNwCUbAFrZhTc6MEb4RqzxZKjrITSM9A
	t1ndx/S9aav4mxXb01kkHu//BRSFk+gtzhHrRaZJetmofoCQ6PYfMyfRR5XYNThEiaX8QNPi//z
	ANbtsZvJ58Sqq/wL2srKY16I0BrfjqRvrj0zSUgHxXtCeAoV+4ooePh3zSJnfqCt2owyu7jk8O0
	/8nXeAe2w3KBKCX5zAn1IQzst8tmttUopR9hy0G81QHyULs/oiSjv3K2ap8=
X-Received: by 2002:ad4:5be2:0:b0:6e8:af23:b6f1 with SMTP id 6a1803df08f44-6e8ff738403mr48320796d6.10.1741360770545;
        Fri, 07 Mar 2025 07:19:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7vgy3SRMmsojlqsMkxhqU/1Y5Pf8CiqlPcyisxnRS9jhc3xrWLOs4SjjO+5bclG8zm4TyGA==
X-Received: by 2002:ad4:5be2:0:b0:6e8:af23:b6f1 with SMTP id 6a1803df08f44-6e8ff738403mr48320296d6.10.1741360770032;
        Fri, 07 Mar 2025 07:19:30 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b6acsm20401296d6.74.2025.03.07.07.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:19:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>
Date: Fri, 7 Mar 2025 10:19:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Content-Language: en-US
In-Reply-To: <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/25 10:11 AM, Waiman Long wrote:
> On 3/6/25 9:10 AM, Juri Lelli wrote:
>> Create wrappers for sched_domains_mutex so that it can transparently be
>> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
>> do.
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow 
>> earlier for hotplug")
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> ---
>> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>>            either in that case
>> ---
>>   include/linux/sched.h   |  2 ++
>>   kernel/cgroup/cpuset.c  |  4 ++--
>>   kernel/sched/core.c     |  4 ++--
>>   kernel/sched/debug.c    |  8 ++++----
>>   kernel/sched/topology.c | 12 ++++++++++--
>>   5 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 9632e3318e0d..d5f8c161d852 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -383,6 +383,8 @@ enum uclamp_id {
>>   extern struct root_domain def_root_domain;
>>   extern struct mutex sched_domains_mutex;
>>   #endif
>> +extern void sched_domains_mutex_lock(void);
>> +extern void sched_domains_mutex_unlock(void);
>
> As discussed in the other thread, move the 
> sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block 
> and define the else part so that it can be used in code block that 
> will also be compiled in the !CONFIG_SMP case.
>
> Other than that, the rest looks good to me.

Actually, you can also remove sched_domains_mutex from the header and 
make it static as it is no longer directly accessed.

Cheers,
Longman



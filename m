Return-Path: <linux-kernel+bounces-544730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3DA4E484
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC244227B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA403279353;
	Tue,  4 Mar 2025 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuBC0/+r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B204278154
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102446; cv=none; b=qZ72mpnApVAWbJKcqi5WCshCFwOiA9Wc0kumtuDrROVZUL7PAe+fr5CktTrYLbccODRPB7A2Qvy+YN34irknD43FNMD5u5Etu4awa3DYlkBaWaZ7Q1QY+BV9hlXsOBeIFeT8rTq7l6TZ3AeD1gtTauVvRR7an6cCW2jOaXsjQW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102446; c=relaxed/simple;
	bh=g9/2udOETvmToZrTCGb+qEZ+kSThEsu8wt6yi5lFMWo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bpeIOHnH4ZhW2FGT6/+Gi6DM+S8QZL0ThTwtyH28C0yhCrAqBPehdZBgHSK/XbrS4z//KqpXP5jAH5oxCPtyBZkJ+ovLyHTfJnQ4S42XmG4iddCUXpb+sitLym5dImc7LMYwcWopOvOFKSh+nU1HEcck3gVHZn6Sl9QlJW0T1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuBC0/+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741102443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwJDnZ8tY9IELE2tx6CxJ71JiDXg4oK+AyaLx02RRac=;
	b=YuBC0/+rTOz36YW8eq/rHcdKVscZDPACpA6nGO6gfDx5yH5WuvlKhiutzIJTEa+FS042tE
	aXpjxvhncjVIoj4ooG+Nv6Z12i4bR1FOswZpLzrpInHAQe5Xb26C6nhZZ3EuvRa4ICdh8Z
	6sbtTZUeHrlTmq3RWh2KLTRqtjqsHZE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-qAJCmSWZO4aRZ1PKyFGvAQ-1; Tue, 04 Mar 2025 10:33:56 -0500
X-MC-Unique: qAJCmSWZO4aRZ1PKyFGvAQ-1
X-Mimecast-MFC-AGG-ID: qAJCmSWZO4aRZ1PKyFGvAQ_1741102436
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4721d9703ecso125608551cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741102436; x=1741707236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwJDnZ8tY9IELE2tx6CxJ71JiDXg4oK+AyaLx02RRac=;
        b=lJg/vZbk9PeEic2FdRjSRACltyUFaYUUBJp+TttHeZNN4oh3yrkIg+RYtF1FTm3DrT
         tkS7Y9eLViLR5xsgjGDQA+5Mo/Wu3Wcd06iguDgN4l+DlTFte6NLe8NocMlmdzSEzs16
         +8aQ4NHhcaPJ/r8rTmOAgtkGvjIgyRBbP0Hbinda1qN4fHrQS3sLKVdPuYnfSp3ycui+
         rvZ3sZ9q67pRPPIndS+NsO7Zw4VCHuzg5pOoHqXjaHPxUgUlOA/P/ARuviXkccC+wnru
         KGeqaWd8rf1Y7jJuz7eIwTp9C6+JpgwS6WM+Osxhkh2sa1KQWsw00Xu6cIibkEsUyAs9
         MmZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmcLXBRJhIL9bOqxcYpWuDQbyU4BBmi77aDTuk+Xq15tPVEB5HO7sub9mC5XCWZ4NjDk1mXImutYhCokM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBDUA1X/YYyqIqCeAxE4AjBCKqJywnZPg8GOUBGJR3eJz3+vX2
	5e0CCOPkJtdI5fog2qn8kCofzcR04yd+uBNnZiNbhFvwsP7EXNthsNSluwimWkOvx3Ebd7ATxwg
	51TkTHT2sHTNEGe3q3fO5AwfzWiGNgIg8L0R+EVFd8I/DefGlbLYuGzGABWHWEw==
X-Gm-Gg: ASbGncuBdjX4TkoNXWcLhkY97nI4rsU81sLl9N2HgXlcS2YANsxxtMNTIyy/wtLqNhX
	KR9Dce8Oi1ZQzReYwbB49W86bZ+onSKRrPFRNhI9Web3VKwr4aOEzkZwAIr39/yJHkactGvEiHi
	3o7+ieZZPNOg/PrVFq7CrFF82O8nAPgyeG0yEQoFHX2BAgm4bCOtB3AjSTeajYZVThtqsxXhJ4w
	Em0zv4njEofUkxClCscEXlegUY68lh2sY5FvKlxtcUpdlHDrNGWkE7stZ2iA2ePmSvXI6d1igJs
	gsyMbhaBrYJVvsHHjpQ60fYxZ9JgwopPtju9qq62M+q4Up/HpkLuleKBZ+Q=
X-Received: by 2002:a05:622a:1825:b0:474:b753:e262 with SMTP id d75a77b69052e-474bc04731emr188722421cf.9.1741102435727;
        Tue, 04 Mar 2025 07:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG/dfjVxJtyP8MAwXmEMza87tPVSQuOFN0UMpAqo6ILEemgvwl18p7DpTuFQl8dUDghKTziBA==
X-Received: by 2002:a05:622a:1825:b0:474:b753:e262 with SMTP id d75a77b69052e-474bc04731emr188722211cf.9.1741102435420;
        Tue, 04 Mar 2025 07:33:55 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474691a22f4sm74434221cf.5.2025.03.04.07.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:33:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a53c1601-81e7-439c-b0dd-ec009227a040@redhat.com>
Date: Tue, 4 Mar 2025 10:33:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] sched/deadline: Rebuild root domain accounting after
 every update
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
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-5-juri.lelli@redhat.com>
 <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Content-Language: en-US
In-Reply-To: <e78c0d2d-c5bf-41f1-9786-981c60b7b50c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/25 10:17 AM, Waiman Long wrote:
> On 3/4/25 3:40 AM, Juri Lelli wrote:
>> Rebuilding of root domains accounting information (total_bw) is
>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
>> is that the way we keep track of domain changes and try to add bandwidth
>> back is convoluted and fragile.
>>
>> Fix it by simplify things by making sure bandwidth accounting is cleared
>> and completely restored after root domains changes (after root domains
>> are again stable).
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow 
>> earlier for hotplug")
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> ---
>>   include/linux/sched/deadline.h |  4 ++++
>>   include/linux/sched/topology.h |  2 ++
>>   kernel/cgroup/cpuset.c         | 16 +++++++++-------
>>   kernel/sched/deadline.c        | 16 ++++++++++------
>>   kernel/sched/topology.c        |  1 +
>>   5 files changed, 26 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/sched/deadline.h 
>> b/include/linux/sched/deadline.h
>> index 6ec578600b24..a780068aa1a5 100644
>> --- a/include/linux/sched/deadline.h
>> +++ b/include/linux/sched/deadline.h
>> @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
>>   struct root_domain;
>>   extern void dl_add_task_root_domain(struct task_struct *p);
>>   extern void dl_clear_root_domain(struct root_domain *rd);
>> +extern void dl_clear_root_domain_cpu(int cpu);
>> +
>> +extern u64 dl_cookie;
>> +extern bool dl_bw_visited(int cpu, u64 gen);
>>     #endif /* CONFIG_SMP */
>>   diff --git a/include/linux/sched/topology.h 
>> b/include/linux/sched/topology.h
>> index 7f3dbafe1817..1622232bd08b 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -166,6 +166,8 @@ static inline struct cpumask 
>> *sched_domain_span(struct sched_domain *sd)
>>       return to_cpumask(sd->span);
>>   }
>>   +extern void dl_rebuild_rd_accounting(void);
>> +
>>   extern void partition_sched_domains_locked(int ndoms_new,
>>                          cpumask_var_t doms_new[],
>>                          struct sched_domain_attr *dattr_new);

BTW, dl_rebuild_rd_accounting() is defined only if CONFIG_CPUSETS is 
defined. I think you should move that declaration to cpuset.h and define 
a proper wrapper in the else part.

Cheers,
Longman



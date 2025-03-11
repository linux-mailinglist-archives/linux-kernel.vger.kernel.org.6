Return-Path: <linux-kernel+bounces-555285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6571CA5B21C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 01:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED1A7A6C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 00:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57035FBF6;
	Tue, 11 Mar 2025 00:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRA07OU8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FA4322E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741652175; cv=none; b=cGLmQGJKLcDeAxjTQEU/tz/l94u2skBYqv0SURg6lkfA66ogbKlODqBsVpktcvDCWF1gIFyQ68bxxCOcWF1V3KJK/nFkgDCf7wtRmixXmzJa7KSDmK+4DFy9JdK0fdkDeTWPIhANaIX33A+GkT70K4va6mEoasQU8q9hyCrTK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741652175; c=relaxed/simple;
	bh=Ey6JwDGKnsBMava30DtiyH1F5pVTlJSO/weiq6Cy+yE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aiSWsxYpyOAxnZ0E1LXWaoSNGsvJ1gB64Oknd5lAn6+wm2GKxImBCxtNqQkQHoL5+G0yvXIKUD6yKx95o7VrJGIXTa0sQcNZOSpkyDP+jQwdHQBIQfIm4obgLLu1pXslOXz50lwoJsbQeYVpZ17nV8h3S5hYrt5NSEXBnP12thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRA07OU8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741652172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=236a/XneA0NJVrGstNl+HaEyiafUIjCWkYDwdiIp5UY=;
	b=XRA07OU8ciMUnftHUriScz+dgGTN8oADX9OWDCM+omKI7M5NySijKSP4yYy5/6gXzo+IS0
	FfidXLQdtOgHDHNLpqFkLn+NprDF4dI4f8dk77pBPecYNi/RE+JJW+y3oN/VW//FYM5wWZ
	3lcQkYb/P8UWXRLKmX/mh5CVmniAfEI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-7-yDAzJJOp-Cua2z4Weiig-1; Mon, 10 Mar 2025 20:16:11 -0400
X-MC-Unique: 7-yDAzJJOp-Cua2z4Weiig-1
X-Mimecast-MFC-AGG-ID: 7-yDAzJJOp-Cua2z4Weiig_1741652171
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e90b13f5c3so48864376d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741652171; x=1742256971;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=236a/XneA0NJVrGstNl+HaEyiafUIjCWkYDwdiIp5UY=;
        b=K5iW/O/k4gmoyjDmkT1Zo/K4BJ8K7zMA58haUiDEm0pUWUQmO83GZbMXMwsEzCnuKP
         HBUAofRxKr1S1HjLVPOzaddcycinFw3jVPR22PX+Ykg/MXedws38Hx3PfXeMbnj28RgF
         tfhV2KuFWy69ILhhPeqMLBazPn2C4g3jOm5PBPrwXlQfXmnwg8FekxpAVNOiE966UcyC
         SorVo7MYxhVMp42G6vYOdp0sPI0W5e5dgBxbKhwenlwUKpIsovaAk1pn/YavIo3qCl1z
         kdScBo8QUmh/lP5XctnN8/3CGgk2F6Ri95I/w7pi9vQjVCKB1DYuLw8Itci4y7YFKbgW
         30aw==
X-Forwarded-Encrypted: i=1; AJvYcCUzkeafflYM9ccZgZL94fqt9vvsP3FOIXePMl/jG5a1FbVjUKh7RkRjgkrp1wQ+vegfopFUQuJTktroP/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4P3wEWL+jEfxKo4mzj9bxdm5kCIkE6QXEUeEYnAyhT5W8Nhv
	9HU4LAwUqLKKyJrJDfKJ5Xf+pkvaoZ6Aq+0HxiYenj2u0QrIBdIFoGfi4RxngjjBbVKtnE0pl28
	2goB5+9FPq3W7n2balw+SfuEDJfxBcQowNQ1qL1Vuk+vQ8QVOL7xnFIHdFA1qig==
X-Gm-Gg: ASbGncumJpwXQYQS4eaWa7uDLxld0jG5BKWpvGkiWBRPYFYLAwUlWj6Gaja6MRq2uKh
	qQLtxYmwaQEbIiFJSvoCvYvJlcfehZeYp+jL+UCQoxNxVY2Mq8Gr4eDN3bagdvNqlhLSVP/BtwT
	NhIgaArdQJ07L6+Q6o8K7H1HDzG+tI4W6TgzS4j48Q5ZL+PXtLpbWWcbNDr7ItoXBA1jbY1032g
	XgDKzgis1e4zTprKf8Hfn+wmP3HB2oEUgdo64byT0nddLu34/459GKM5n0dnSljsO8gcwT3RqPY
	mzZTDf+NARNmSmZOO8h06hZH0RQfv5e1bF0PCdUdnjOuV6qxBSoTC6OozKPpsA==
X-Received: by 2002:a05:6214:250e:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e900693d5cmr243734356d6.38.1741652171065;
        Mon, 10 Mar 2025 17:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWcI9s5pAmz4x20etgpOydCiO3vtCen7TrgltEqQDA01TRQzGQLBKhlzBXzVBLM06ntNbtVA==
X-Received: by 2002:a05:6214:250e:b0:6d8:9872:adc1 with SMTP id 6a1803df08f44-6e900693d5cmr243734086d6.38.1741652170777;
        Mon, 10 Mar 2025 17:16:10 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b650sm64118486d6.89.2025.03.10.17.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 17:16:10 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
Date: Mon, 10 Mar 2025 20:16:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
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
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
Content-Language: en-US
In-Reply-To: <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/10/25 3:18 PM, Waiman Long wrote:
>
> On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
>> On 10/03/2025 10:37, Juri Lelli wrote:
>>> Rebuilding of root domains accounting information (total_bw) is
>>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
>> Nit: Couldn't spot any arch dependency here. I guess it was just tested
>> on Arm64 platforms so far.
>>
>> [...]
>>
>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>> index 44093339761c..363ad268a25b 100644
>>> --- a/kernel/sched/topology.c
>>> +++ b/kernel/sched/topology.c
>>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int 
>>> ndoms_new, cpumask_var_t doms_new[],
>>>       ndoms_cur = ndoms_new;
>>>         update_sched_domain_debugfs();
>>> +    dl_rebuild_rd_accounting();
>> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
>> barf when called via cpuhp's:
>>
>> sched_cpu_deactivate()
>>
>>    cpuset_cpu_inactive()
>>
>>      partition_sched_domains()
>>
>>        partition_sched_domains_locked()
>>
>>          dl_rebuild_rd_accounting()
>>
>> ?
>>
>> [...]
>
> Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will 
> be called without holding cpuset mutex.
>
> Well, I think we will need an additional wrapper in cpuset.c that 
> acquires the cpuset_mutex first before calling 
> partition_sched_domains() and use the new wrapper in these cases.

Actually, partition_sched_domains() is called with the special arguments 
(1, NULL, NULL) to reset the domain to a single one. So perhaps 
something like the following will be enough to avoid this problem.

BTW, we can merge partition_sched_domains_locked() into 
partition_sched_domains() as there is no other caller.

Cheers,
Longman

------------------------------------------------------------------------------------------------

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 95bde793651c..39b9ffa6a39a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2692,6 +2692,7 @@ static void partition_sched_domains_locked(int 
ndoms_new, cpumask_var_t doms_new
                                     struct sched_domain_attr *dattr_new)
  {
         bool __maybe_unused has_eas = false;
+       bool reset_domain = false;
         int i, j, n;
         int new_topology;

@@ -2706,6 +2707,7 @@ static void partition_sched_domains_locked(int 
ndoms_new, cpumask_var_t doms_new
         if (!doms_new) {
                 WARN_ON_ONCE(dattr_new);
                 n = 0;
+               reset_domain = true;
                 doms_new = alloc_sched_domains(1);
                 if (doms_new) {
                         n = 1;
@@ -2778,7 +2780,8 @@ static void partition_sched_domains_locked(int 
ndoms_new, cpumask_var_t doms_new
         ndoms_cur = ndoms_new;

         update_sched_domain_debugfs();
-       dl_rebuild_rd_accounting();
+       if (!reset_domain)
+               dl_rebuild_rd_accounting();
  }

  /*



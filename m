Return-Path: <linux-kernel+bounces-567734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C015A689BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08E1D3A4A38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 10:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6554253B77;
	Wed, 19 Mar 2025 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YPHKWwxT"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB220E31B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380591; cv=none; b=PNQgkDNfCjSDLH+eJv1eghB1I8WzIvq8Fyb5zjmv+ImoAp0hmRjnWhdgxNjlWnYYjLQE4BsFZDtaMeTlgDb2xXMa4PtkzHJeygok8hOxDo8BEsXtDOoXfPKCU5wVedDQbU3B/ih3eO72EXSxmskifdqeioQoQkeWsAv6tlS6qu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380591; c=relaxed/simple;
	bh=DBKezS1yDWS3rgUuoxRE1g7/fV7ryVKATtW6l64sT6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G0ZccIgJ9bEAKKb0Kr/miWnrvP0MITQGfdC7LoH+xT+BVmE4x+aYm616Plwh0mwDVDF03fYB/MBhnJYcaSdWlpWVE1TsTVC4wrIlbMvLSIOxbujZw6BHICNMmux4U8bsVKqaEHJuw24ImCVZrD6RebLmWZQFx7THvw9JyP3KcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YPHKWwxT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240d930f13so15243345ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742380589; x=1742985389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KgcvADP1L17ZlBRUuSGgGPutzZVrK9Crwo5m3uBh8XQ=;
        b=YPHKWwxTBxGASiuxJpb0ibQgI3lX9UlwWWU2QRxsTn3A6e9ltJkKhcfxbjD2LmWtdy
         dRo5VzImt/yklU2ibKofrCz1bQ57rIZUniY9m1hZ21fSCPqM4YXxiydBsJxqTfsq0ci6
         J0jcb8r2rZ7l4kDcyxfwWr4XJZ/wyhEdHwegt3JdWTHAJl6wbD8rZDNviNZFVLotoEQ0
         AJ6MnEsV8R/0c7plvSYrmfEmrGm5a8zTNoxL1SAgBwZKVMVq9RYUbBHiD+S8Pe7yiDNU
         o/oIwPB08M8RQBm4NoHGV2oxMzY96N6i3a7g9L7keDDZOLeA8dpBX/UeuJYEBakX9qvp
         M8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380589; x=1742985389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgcvADP1L17ZlBRUuSGgGPutzZVrK9Crwo5m3uBh8XQ=;
        b=o71YBO/RvoPjz8HJnd5JJESGlZ6mycIZ0u6MP0+Oq1kQBz/iYCuR6apxPaXke3r2Sb
         fGnDAMryrNbunmBxIVs0shJcuVS9lhm+/PPJGURhZzCdH9ZpDQtQWaVLQNIr9wINg/iv
         fAcvLx6xRJy7Mwv3agQqke2iPz21FAYIKTDM/z4qhR/WD5UuL5lcuzBFEJowGInqntg4
         AJK4Ao5Dxi9PekdTRC3dsdUH0L6+5ZLzzTVXicTSo0R2OiTw916BfRVDHZxv6kXkhTic
         4t4zcM1YWoT1rVPEE9+C/RErcNTPZlhF3hC/ON2vjARovY0Cmyx6s/zfvzBl7khXHbb1
         iPSg==
X-Forwarded-Encrypted: i=1; AJvYcCXNddZMYGlDHeXVuUa/o1TAxD6ARg5+RamWMNv7zC7LZ7KHpd/hT33ZfBDT5YrLtXaWnlG2IpqlRlffE0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE+mTCF4+LwGrujE524QUr4mGzzHzcaG+QFx74kkovw4lWEOEV
	ZTnExOnmL6SVsRmtTUTcr/Bw/dep+S8YZ9TR5ibGLxj1JcVwEN+XrFTeD0qNA2w=
X-Gm-Gg: ASbGncubtb7HCikWWEZqfrqkAhrWkvQNOL0fq2+o/Z2ANraKzDyuQ0iI++QCFzwbSTJ
	oCi1x7+G0J75RcjzWF0y6eVgf0IBaV5+mSn8nkNjrInBD2xi/qTibH9gqwFrYpNXCHr3qNojWTF
	C1wnDu7hRFCyW/+gT65JDb3Zq8YCZYvl2O4VivBtTPXcLjv5jy7rlxjAvuaF2Zu5EXkGEGDpjOB
	/hG/dDdTp8qIt+i6yyDTABGWXOYulY2fLRSSeekdWfzWl7+HbprAUEdJBpL9k2pl4y0hUtBC5uF
	K5CW4SH7uaL8uTTFK4aR0nbJRum+caFwzF1gHcoqbts/jMizoSNkEjIlLXk3lJi4CIc=
X-Google-Smtp-Source: AGHT+IG0FSWVoeByTFbw+SzQxV6lBBKhXfLTbOHKB9i4f9zhoVUhJtA4ZduuhJn0z5UJA/PzAzfZ5Q==
X-Received: by 2002:a17:903:8cd:b0:224:88c:9253 with SMTP id d9443c01a7336-2264c5e23a7mr11559955ad.6.1742380588759;
        Wed, 19 Mar 2025 03:36:28 -0700 (PDT)
Received: from [10.68.122.94] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c688866asm111009165ad.50.2025.03.19.03.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:36:28 -0700 (PDT)
Message-ID: <31574ba7-a04f-49fa-aea8-a0a751915ecc@bytedance.com>
Date: Wed, 19 Mar 2025 18:36:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [RFC PATCH 1/2] Revert "sched/fair: Make sched-idle CPU
 selection consistent throughout"
Content-Language: en-US
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Josh Don <joshdon@google.com>, Tianchen Ding <dtcccc@linux.alibaba.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
References: <20250310074044.3656-1-wuyun.abel@bytedance.com>
 <20250310074044.3656-2-wuyun.abel@bytedance.com>
 <CAKfTPtA3k7oXqKjX6bNsjG1BCjq4TB6fWvTH1RV425iK01xA2A@mail.gmail.com>
 <e4ad9841-5ba2-4704-95f2-3d8affee9afa@bytedance.com>
 <CAKfTPtAqBgCAoTaMv3_7Xguo+jtpBgg5EXOeUBWfMyPY8YDkJw@mail.gmail.com>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtAqBgCAoTaMv3_7Xguo+jtpBgg5EXOeUBWfMyPY8YDkJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/25 5:17 PM, Vincent Guittot wrote:
> On Thu, 13 Mar 2025 at 08:18, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Hi Vincent,
>>
>> On 3/12/25 12:58 AM, Vincent Guittot wrote:
>>> On Mon, 10 Mar 2025 at 08:41, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>>>
>>>> This reverts commit 17346452b25b98acfb395d2a82ec2e4ad0cb7a01.
>>>>
>>>> The above commit tried to unify selection policy between idle cpus
>>>> and SCHED_IDLE ones in fast- and slow-path of select_task_rq_fair()
>>>> by treating them equally (although the SCHED_IDLE cpus are turned
>>>> to be given more preference in slowpath). The test results seemed
>>>> solid, but the setup didn't take cgroup hierarchy into account,
>>>> which actually made some of our important services get affected.
>>>>
>>>> The cgroup hierarchy in our production environment looks like below,
>>>> which might be common in modern containerized setup:
>>>>
>>>>                             root
>>>>                           /       \
>>>>                   kubepods        system.slice
>>>>                   /       \\              \
>>>>           guaranteed      besteffort      containerd
>>>>
>>>>           (where 'X=A' means A is SCHED_IDLE cgroup)
>>>>
>>>> The cpu is treated as SCHED_IDLE if only besteffort is running, which
>>>> is given at least equal preference as the idle cpus when deciding where
>>>> to run a newly woken task. But the SCHED_IDLE cpus do not necessarily
>>>> mean they can be preempted soon enough to start serving the wakee, and
>>>
>>> Could you give us more details why the SCHED_IDLE cpu which runs only
>>> besteffort can't be preempted soon enough ?
>>>
>>> because kubepods vs system.slice is not sched_idle when comparing the
>>
>> Yes, exactly. What's worse is that kubepods.weight is the sum of all its
>> children and can easily reach ~3000, while system.weight is default to
>> 100. The weight configuration can be optimized, but it's another topic.
>>
>>> entities ? some maybe the definition of sched_idle_cpu should be fixed
>>> instead
>>
>> Yes, there are at least two ways to fix it:
>>
>>    1) Let sched_idle_cpu() depends on a specific task, just like Josh
>>       mentioned in the reply of 2nd patch. So if sched_idle_cpu(cpu, p)
>>       returns true, then
>>
>>          a) this rq only contains hierarchical idle tasks, and
>>          b) p can preempt current immediately
>>
>>       Please see my reply to Josh to check the details.
> 
> yeah, that should be the solution which covers all cases but at the
> cost of walking cgroup hierarchy which is far from being ideal

Only comparing curr vs wakee doesn't solve the problem. A cpu can be
treated as SCHED_IDLE iff *all* its SCHED_IDLE entities can be preempted
by the wakee.

> 
> Could we change h_nr_idle to only track fully sched idle tasks; I mean
> tasks with a full sched_idle cgroup hierarchy ? so we would be sure to
> preempt those sched idle cpus
> 
> Then, for other case of sched idle task or sched idle group childs of
> a non sched idle group then we don't consider those cpu as sched idle
> cpu

Ahthough this is correct, I think it would be too much since this kind
of setup is rare to the best of my knowledge.

> 
> 
>>
>>    2) Or get rid of sched_idle_cpu() entirely. This needs some careful
>>       rework. Now the users of cfs_rq::h_nr_idle are two parts:
>>
>>          a) select_task_rq, including sched_balance_find_dst_group_cpu()
>>             and select_idle_*(). The former is handled by this series by
>>             simply ignoring sched_idle_cpus, which should be safe since
>>             sched_idle_cpus do not always follow the goal of the slowpath
>>             to find a least loaded cpu to help load balancing. While the
>>             latter is roughly designed as following:
>>
>>             - Must search within target LLC domain, since L3$ miss is
>>               much more costly than L1/L2$
>>             - To use cache more wisely, start searching from the L1/L2$
>>               cache hot cpus like prev/recent_used/..
>>             - Cheers if found an idle cpu that can preempt immediately.
>>               This helps maximize using cpu bandwidth, hence improving
>>               total throughput
>>             - (?)
>>             - Return target anyway, at least it might be cache hot
>>
>>             It could be less optimal if simply remove sched_idle_cpu and
>>             return @target if no idle cpu available, because @target can
>>             be heavy loaded and the cache may not hot any longer when the
>>             wakee finally hit cpu. So in order not to fight with the load
>>             balancing, shall we tiebreak on cpu_load() for the non-idle
>>             cpus?

What do you think to choose a less loaded cpu if no idle ones available?
So the wakee will probably get better served, and also helps load balance.

>>
>>          b) load balance: sched_balance_domains() and dequeue_entities().
>>             We could leave this as-is, but I would propose using h_idle
>>             instead: if the on_cpu task is hierarchically idle when
>>             triggering normal load balancing, then we guess it's a less
>>             loaded cpu and can reduce balance interval. The rationale
>>             behind is that the idle entities usually get very limited
>>             bandwidth if any hierarchically non-idle tasks available.
>>             The heuristics may have false positives which can generally
>>             be divided into 3 cases:
>>
>>                  (The numbers represents hierarchical shares%)
>>
>>                                                     C
>>                     A               B              / \
>>                   /  \\           /  \\           80  20
>>                  99    1         50   50         // \
>>                                                100  (X)
> 
> 
> How the sched_idle group in B can have the same share/weight as the
> not sched idle one in case B ?

It can't, but theoretically several SCHED_IDLE siblings can be summed up
to match a niced SCHED_NORMAL entity.

				    B
				    |
		 ---------------------------------------
		 |     ||      ||      ||      ||      ||
		15	3	3	3	3	3

> 
> 
>>
>>             - Case A) The hierarchical share of h_idle tasks is indeed
>>               small. So in this case they are just get scheduled to take
>>               some breath, and the possibility of false positive is low
>>               enough to be safely ignored.
>>
>>             - Case B) The h_idle & !h_idle tasks equally share bandwidth
>>               which usually means the !h_idle part becomes less loaded
>>               and pulling some load might be preferred.
>>
>>             - Case C) The hierarchical share of h_idle tasks dominates
>>               which usually means their !h_idle parents are allowed to
>>               use a big portion of bandwidth. In this case speedup the
>>               balance is still fine because we could pull some !h_idle
>>               tasks for the most 'important' cgroup.
>>
>>             So the heuristics of using rq->curr's h_idle to judge the need
>>             of pulling (load balancing) seems fine.
>>
>>       And as a result cfs_rq::h_nr_idle can be removed and its maintenance
>>       cost in hotpath can be saved.
>>
>> Which way do you prefer? It would be much appreciated if you can shed some
>> light on this.
>>
>>>
>>> a sched_idle_cpu should be preempted immediately otherwise it's not a
>>> sched idle cpu and the definition is meaningless
>>
>> Agree.
>>
>> Thanks!
>>          Abel
>>



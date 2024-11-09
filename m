Return-Path: <linux-kernel+bounces-402617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6E9C29B4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A692284143
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65141C71;
	Sat,  9 Nov 2024 03:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YirEbC3h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574828F3
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123049; cv=none; b=IjRWjm+i4hHWThGwHfQzYAaIiOrHtxKEBnFKiIb9xtXXX/F8M8DLZmRV1WqWxmsI4HVWtzuzYPxUZJjFi7jhkGxNZZE5CfFXZK0Q+4xAm2cYt8d8vpummutN/4sfgwuLxCiB6W/++QxiQzehgqogpYbF1l+ZZ6gk+D/bfWfKRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123049; c=relaxed/simple;
	bh=ugCp0MXUleZimEjgX1WlZcU+QZ4JUqHa3VxLOMG/otM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oGek2Z7VT6YzN/k8bPbJ8Zju442Y9772fhvSc8Rv/qbFyuHuR/1Lo0cOBs0D+pq5BnMupCoKtc+KngrKu2QDMlsiti67Mi1aCuqfS6289lpRhXeUCA9vYuM8rMHDFoFhLN1XsLQlvjgBNEWsdjQ2cEeRAmsaKHnNw1B+UFLgIgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YirEbC3h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731123046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+obXJn8PoRlFY/asEnfpqJ82R8xq9pSnKlD206Nh5u0=;
	b=YirEbC3h90OuFyd/ngIt5/4rLiruLK/Oq5azJa8p1K3M2xMkDqHP73RNsW79kEjCjkM3I/
	RC1HswYDX1atVwB53PfYlPRm43kl4yrpme3v5Eyzg7TL9tZPib9/V2EgHzM3a6Izt113Q0
	Qp2v6y6cRrlKDCFmxHoBjoT2yklPF0I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-Qz1-HugBOTWtlY7wGezIjw-1; Fri, 08 Nov 2024 22:30:44 -0500
X-MC-Unique: Qz1-HugBOTWtlY7wGezIjw-1
X-Mimecast-MFC-AGG-ID: Qz1-HugBOTWtlY7wGezIjw
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-460b07774a7so43857001cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 19:30:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731123044; x=1731727844;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+obXJn8PoRlFY/asEnfpqJ82R8xq9pSnKlD206Nh5u0=;
        b=qRK2K9UlUOIeUTeeuNBVJeAhhScI//AQPjwU2uyBfvx1ulso/iDcCF9B+v/QyN2hHa
         uO84+V8Kmi1KO/UFedmvmZDVnVdM9t8FktPoE6/YGhAMv4cPPGWdG0vknAiexF8Wxahu
         jOTwlSpeDdYyagQv8jpQO4/MP1t1f9lLUUW7VgtCeIresX4xHdRjpJ277jzjaWViWCiA
         7c00rIMoFCAPbwhVvdEncpyDO1Ne7ZdJUpmJLCeKBJ24euCFNn07BGu1X2iDgs+lX4pp
         E7gtIH1aUDj8fZnWGUn/nGHsUqrluZQlSFnwmjUMikY5wzTxj27sq9IGmhQxp9/1Cmrr
         Q+rA==
X-Gm-Message-State: AOJu0Yxr3Se9aVVG3FY96BHwDlnDrwZIo6HpglLc1CDzeJJvC4fTuL6u
	/1KTE5B6VnE2EffiQiTpK3xBXQOQ60a8kcHX3CGkWjMd4XwO4h8nkdMAkKooCQEdhQ+kKGbD+Zx
	yJrnSLAGQTZ0DPXRpqpN/EC24E2xuBiNQcLgANi4N8mhbH2A0Et5CsWOZnPmylw==
X-Received: by 2002:a05:622a:1a92:b0:460:39be:10a8 with SMTP id d75a77b69052e-463093755d9mr56576421cf.32.1731123044208;
        Fri, 08 Nov 2024 19:30:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxc/M04De9Xu4Pj0d3d5PsU0EFfdv5bykS2ssG8S9FNeIuuABcJjlv+34QDwCD1AMzc0UXOw==
X-Received: by 2002:a05:622a:1a92:b0:460:39be:10a8 with SMTP id d75a77b69052e-463093755d9mr56576231cf.32.1731123043824;
        Fri, 08 Nov 2024 19:30:43 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff57e8b4sm27666211cf.60.2024.11.08.19.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 19:30:43 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5259772c-527b-4ab2-9606-2d1f0d93862a@redhat.com>
Date: Fri, 8 Nov 2024 22:30:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
To: Juri Lelli <juri.lelli@redhat.com>,
 Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
 <20241104174109.GA1044726@google.com>
 <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
 <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
 <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
Content-Language: en-US
In-Reply-To: <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/24 11:40 PM, Waiman Long wrote:
> On 11/6/24 1:05 PM, Waiman Long wrote:
>> On 11/6/24 11:08 AM, Juri Lelli wrote:
>>> On 04/11/24 17:41, Joel Fernandes wrote:
>>>> On Mon, Nov 04, 2024 at 11:54:36AM +0100, Juri Lelli wrote:
>>> ...
>>>
>>>>> I added a printk in __dl_server_attach_root which is called after the
>>>>> dynamic rd is built to transfer bandwidth to it.
>>>>>
>>>>> __dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
>>>>> server interface"), do you have this change in your backport?
>>>> You nailed it! Our 5.15 backport appears to be slightly older and 
>>>> is missing
>>>> this from topology.c as you mentioned. Thanks for clarifying!
>>>>
>>>>
>>>>          /*
>>>>           * Because the rq is not a task, dl_add_task_root_domain() 
>>>> did not
>>>>           * move the fair server bw to the rd if it already started.
>>>>           * Add it now.
>>>>           */
>>>>          if (rq->fair_server.dl_server)
>>>> __dl_server_attach_root(&rq->fair_server, rq);
>>>>
>>>>>> So if rd changes during boot initialization, the correct dl_bw 
>>>>>> has to be
>>>>>> updated AFAICS. Also if cpusets are used, the rd for a CPU may 
>>>>>> change.
>>>>> cpusets changes are something that I still need to double check. Will
>>>>> do.
>>>>>
>>>> Sounds good, that would be good to verify.
>>> So, I played a little bit with it and came up with a simple set of ops
>>> that point out an issue (default fedora server install):
>>>
>>> echo Y >/sys/kernel/debug/sched/verbose
>>>
>>> echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control
>>>
>>> echo 0-7 > /sys/fs/cgroup/user.slice/cpuset.cpus
>>> echo 6-7 > /sys/fs/cgroup/user.slice/cpuset.cpus.exclusive
>>> echo root >/sys/fs/cgroup/user.slice/cpuset.cpus.partition
>>>
>>> The domains are rebuilt correctly, but we end up with a null total_bw.
>>>
>>> The conditional call above takes care correctly of adding back 
>>> dl_server
>>> per-rq bandwidth when we pass from the single domain to the 2 exclusive
>>> ones, but I noticed that we go through partition_sched_domains_locked()
>>> twice for a single write of 'root' and the second one, since it's not
>>> actually destroying/rebuilding anything, is resetting total_bw w/o
>>> addition dl_server contribution back.
>>>
>>> Now, not completely sure why we need to go through partition_sched_
>>> domains_locked() twice, as we have (it also looked like a pattern from
>>> other call paths)
>>>
>>> update_prstate()
>>> -> update_cpumasks_hier()
>>>     -> rebuild_sched_domains_locked() <- right at the end
>>> -> update_partition_sd_lb()
>>>     -> rebuild_sched_domains_locked() <- right after the above call
>>>
>>> Removing the first call does indeed fix the issue and domains look OK,
>>> but I'm pretty sure I'm missing all sort of details and corner cases.
>>>
>>> Waiman (now Cc-ed), maybe you can help here understanding why the two
>>> back to back calls are needed?
>>
>> Thanks for letting me know about this case.
>>
>> I am aware that rebuild_sched_domains_locked() can be called more 
>> than once. I have addressed the hotplug case, but it can happen in 
>> some other corner cases as well. The problem with multiple 
>> rebuild_sched_domains_locked() calls is the fact that intermediate 
>> ones may be called where the internal states may not be consistent. I 
>> am going to work on a fix to this issue by making sure that 
>> rebuild_sched_domains_locked() will only be called once.
>
> I am working on a set of cpuset patches to eliminate redundant 
> rebuild_sched_domains_locked() calls. However, my cpuset test script 
> fails after the change due to the presence of test cases where the 
> only CPU in a 1-cpu partition is being offlined. So I sent out a 
> sched/deadline patch [1] to work around this particular corner case.
>
> [1] 
> https://lore.kernel.org/lkml/20241108042924.520458-1-longman@redhat.com/T/#u
>
> Apparently, the null total_bw bug caused by multiple 
> rebuild_sched_domains_locked() calls masks this problem.
>
> Anyway, I should be able to post the cpuset patch series next week 
> after further testing. Please review my sched/deadline patch to see if 
> you are OK with this minor change.

I have the patchset to enforce that rebuild_sched_domains_locked() will 
only be called at most once per cpuset operation.

By adding some debug code to further study the null total_bw issue when 
cpuset.cpus.partition is being changed, I found that eliminating the 
redundant rebuild_sched_domains_locked() reduced the chance of hitting 
null total_bw, it did not eliminate it. By running my cpuset test 
script, I hit 250 cases of null total_bw with the v6.12-rc6 kernel. With 
my new cpuset patch applied, it reduces it to 120 cases of null total_bw.

I will try to look further for the exact condition that triggers null 
total_bw generation.

Cheers,
Longman





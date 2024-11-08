Return-Path: <linux-kernel+bounces-401067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AF19C158F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2922832AC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219BD13AA5D;
	Fri,  8 Nov 2024 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiknQ9kR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243D322E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731040838; cv=none; b=rMYUTyxJ2XP9nzfZRrj3hccqpGvBrXe5BpI7y8agzFrZ1J0QGZ0Z0EzHInxQh0g1vvZ4GiDzbvwPwzXVmQizVVVOsiRKqGsD0Z8udD8aH9UV3/x/cyl5ctYZUBmwYl6uZO3wq7pF+3NxlaLqSmPavz7j0ZaYhxYrIdsBD6XnupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731040838; c=relaxed/simple;
	bh=ykXSli+P9UB1NMP7FhFJbpcQqM366M+Ncs33Bg6D7uk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eyfxGjt1c1Sf4I1u1C80p9a4NWrYjazmFx5dkVBVYI2gQPOcuDRulbdJraRoG3j1lty7MwAag4roPy/wgjIw0U43+uycqMiKjMxhHNeUKdjanXo/S9QrwUDYlmchF78oaUpGgoBSRgzrcrHCr3PQMeUgwhRif5WFCgq5yv5jELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiknQ9kR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731040835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHk6TOORYsXHcLs4w+bspOOLb+VxriS86bXm+ofivo8=;
	b=SiknQ9kR2WNkLSLhEjiqf1z0MKn4RnoATNxig4MNk8IZXs3aYJnwVMwGOpPFf74D42G7/y
	4tNHD7Xw5iugd8frbwwDZzcBEoBr/fUc1heoQQx226YVr/TsTxtrt4xfdUYJyYrh2EoK8G
	QM0f6Hy4xxoTZggxLBLt0E8DEXbVjfs=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-jjwgP711MHiNzTYVZclQcg-1; Thu, 07 Nov 2024 23:40:33 -0500
X-MC-Unique: jjwgP711MHiNzTYVZclQcg-1
X-Mimecast-MFC-AGG-ID: jjwgP711MHiNzTYVZclQcg
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-28f4d9c29bfso1322073fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731040832; x=1731645632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHk6TOORYsXHcLs4w+bspOOLb+VxriS86bXm+ofivo8=;
        b=IRSUSiIHYw6k1Ny6pwTCyFtFDdhw3lPSDzllkvZyfZIzs4ts4JRTrh7bPYeOkLWeCa
         1+78gF+JF8UZuv+w6pmPoTqo+/u9fFRu9gqKYMD/7Y+T5cbHiU2eS4T2E41QQnhVs8mG
         KeGpQeeN7FDwDbxSfVOTQT6ux1nVs9kRz46vZMIewFIhGOSO0U7DiiscxB6euSKXDG31
         QUFDMnABPL0unD4ZaMpQ0z4mxUMGMrPr/C8U5BgsQF+/yJ1SvunkGhS6a7Tp4gSym40h
         9EaCaWJhiTv+i/I13jWZfGb62bi2dComNOag56JLhrDHHjAjw5k+DbuhmM/Ax/xa9kTC
         a0Ew==
X-Gm-Message-State: AOJu0YxuEhtTe8B/svpdHfcjH720fJmjlIvkK0qFQiO6EcLpPmD40eo2
	6/1l1kf6geo0bj3QXrr+VW3YgncdPosk3nQNlnkQwYYPoV6FJuoy67FsSv/dzXaVRGzONr50Ctg
	SXC5tVwJpdtSz01VWHpWslhtSIdEMZnigsKkKIC5fiTjSbE5Q8FfJ0lyGdMmivQ==
X-Received: by 2002:a05:6870:3127:b0:278:65c:3c14 with SMTP id 586e51a60fabf-295600013ffmr1599881fac.5.1731040832307;
        Thu, 07 Nov 2024 20:40:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz0yn62s2LQrCpQUwFPvz0da1Ps74Gz7CdhSoJYJfgqxxo9FdzO4J53340jc7P7UfAbogHlQ==
X-Received: by 2002:a05:6870:3127:b0:278:65c:3c14 with SMTP id 586e51a60fabf-295600013ffmr1599863fac.5.1731040831971;
        Thu, 07 Nov 2024 20:40:31 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546eddc9csm823156fac.36.2024.11.07.20.40.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 20:40:31 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
Date: Thu, 7 Nov 2024 23:40:29 -0500
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
Content-Language: en-US
In-Reply-To: <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/24 1:05 PM, Waiman Long wrote:
> On 11/6/24 11:08 AM, Juri Lelli wrote:
>> On 04/11/24 17:41, Joel Fernandes wrote:
>>> On Mon, Nov 04, 2024 at 11:54:36AM +0100, Juri Lelli wrote:
>> ...
>>
>>>> I added a printk in __dl_server_attach_root which is called after the
>>>> dynamic rd is built to transfer bandwidth to it.
>>>>
>>>> __dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
>>>> server interface"), do you have this change in your backport?
>>> You nailed it! Our 5.15 backport appears to be slightly older and is 
>>> missing
>>> this from topology.c as you mentioned. Thanks for clarifying!
>>>
>>>
>>>          /*
>>>           * Because the rq is not a task, dl_add_task_root_domain() 
>>> did not
>>>           * move the fair server bw to the rd if it already started.
>>>           * Add it now.
>>>           */
>>>          if (rq->fair_server.dl_server)
>>> __dl_server_attach_root(&rq->fair_server, rq);
>>>
>>>>> So if rd changes during boot initialization, the correct dl_bw has 
>>>>> to be
>>>>> updated AFAICS. Also if cpusets are used, the rd for a CPU may 
>>>>> change.
>>>> cpusets changes are something that I still need to double check. Will
>>>> do.
>>>>
>>> Sounds good, that would be good to verify.
>> So, I played a little bit with it and came up with a simple set of ops
>> that point out an issue (default fedora server install):
>>
>> echo Y >/sys/kernel/debug/sched/verbose
>>
>> echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control
>>
>> echo 0-7 > /sys/fs/cgroup/user.slice/cpuset.cpus
>> echo 6-7 > /sys/fs/cgroup/user.slice/cpuset.cpus.exclusive
>> echo root >/sys/fs/cgroup/user.slice/cpuset.cpus.partition
>>
>> The domains are rebuilt correctly, but we end up with a null total_bw.
>>
>> The conditional call above takes care correctly of adding back dl_server
>> per-rq bandwidth when we pass from the single domain to the 2 exclusive
>> ones, but I noticed that we go through partition_sched_domains_locked()
>> twice for a single write of 'root' and the second one, since it's not
>> actually destroying/rebuilding anything, is resetting total_bw w/o
>> addition dl_server contribution back.
>>
>> Now, not completely sure why we need to go through partition_sched_
>> domains_locked() twice, as we have (it also looked like a pattern from
>> other call paths)
>>
>> update_prstate()
>> -> update_cpumasks_hier()
>>     -> rebuild_sched_domains_locked() <- right at the end
>> -> update_partition_sd_lb()
>>     -> rebuild_sched_domains_locked() <- right after the above call
>>
>> Removing the first call does indeed fix the issue and domains look OK,
>> but I'm pretty sure I'm missing all sort of details and corner cases.
>>
>> Waiman (now Cc-ed), maybe you can help here understanding why the two
>> back to back calls are needed?
>
> Thanks for letting me know about this case.
>
> I am aware that rebuild_sched_domains_locked() can be called more than 
> once. I have addressed the hotplug case, but it can happen in some 
> other corner cases as well. The problem with multiple 
> rebuild_sched_domains_locked() calls is the fact that intermediate 
> ones may be called where the internal states may not be consistent. I 
> am going to work on a fix to this issue by making sure that 
> rebuild_sched_domains_locked() will only be called once.

I am working on a set of cpuset patches to eliminate redundant 
rebuild_sched_domains_locked() calls. However, my cpuset test script 
fails after the change due to the presence of test cases where the only 
CPU in a 1-cpu partition is being offlined. So I sent out a 
sched/deadline patch [1] to work around this particular corner case.

[1] 
https://lore.kernel.org/lkml/20241108042924.520458-1-longman@redhat.com/T/#u

Apparently, the null total_bw bug caused by multiple 
rebuild_sched_domains_locked() calls masks this problem.

Anyway, I should be able to post the cpuset patch series next week after 
further testing. Please review my sched/deadline patch to see if you are 
OK with this minor change.

Cheers,
Longman




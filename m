Return-Path: <linux-kernel+bounces-398696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3499BF4CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 19:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 094BFB248A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 18:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ACB207A1D;
	Wed,  6 Nov 2024 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pnb8AN/L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4A8C11
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730916359; cv=none; b=kdEzLQg8k+MyumKWNQOwJOmSFAewB7wR/LS6jb+lKHsBDFZZg/3wl9DO4vnxDPzVd6bl2KUfbyrF0eInPE94G67r+ZmuoSDu2lxUKYC1uaGJDB6KK6t7Jg6Qn7KKC3/wWIUNfSwbIwdMI6aL2vWLnjVf6ZFaPPOhYlAuzVghzkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730916359; c=relaxed/simple;
	bh=GV7Zwy7mK9/jhbh8hdPlZq62mgng4qNRiVfnkdCsQLQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o0CRYh/hIPTnLgLMz2B3/7DWtxhK0Fb5csfMpbl7ksJXgbDP42ELJT646K+08t2ntlTl6Y/EKFrfh5Xs6b683uwmraT2N0Ax7RsLgubiQZc7je5nAr/w8J1ppppfJKYy0XAGIZYIVMr6RW5XfDycn/ngW8o4bfO3losbYBfkv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pnb8AN/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730916356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EH2mk6tfXrsChIRVB3f5ZeTVrowPBXnHWr9Q970bTFM=;
	b=Pnb8AN/LYar989Yp2aDBnI6qG7LI/NrdtjGAmq9vrW73rcok75Os+osXOs2YOoY0ez9kdx
	A89GAzTGjWAbv0hwLwTjRH0ioF5Y0mmaTaxoBaFErMxFnKh+qpUI08y8/n5jAT1ewDnRGA
	myWHK1C/MgPnFMlMxqiKEtRR6zUTkbQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-eGOm3q1UNWmW3JLH_FCdsg-1; Wed, 06 Nov 2024 13:05:55 -0500
X-MC-Unique: eGOm3q1UNWmW3JLH_FCdsg-1
X-Mimecast-MFC-AGG-ID: eGOm3q1UNWmW3JLH_FCdsg
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-460aaa683eeso872311cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 10:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730916355; x=1731521155;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EH2mk6tfXrsChIRVB3f5ZeTVrowPBXnHWr9Q970bTFM=;
        b=IGocJjhAi/4vWtOTNR3+khlZ03qM8KFQH1D7/fKKOnhoBSG6znvT/kXvWhunM7v3XT
         5fbEz4pDa2aFuxllK9J2ApcjQCy5GnVHQPVyyikE3gfPzrXwZLMBGamuR5TdGMzaci79
         Z7s39hTtuFbeT0CaL0EBW957uOIFKlIXlRgQWSLnYsHkSbigR6Rl4QYsPvCwgtX07owK
         o7bpaqC9ICQ1no6A+Qsy54N9ykX8Io4p/W++L2L39IiXESRWLZqv+yF0K/yvzqm3gcsk
         s61LIZrLDqd3jNCSgyvNlf2wzTLilNcd5Ugf1HYLMnw+us6663mBGmTK5mEOpDcKBzJY
         3Adw==
X-Gm-Message-State: AOJu0YzP8CLpIkuUUvW18vnLn1SvGROv/dsnf7TWs0/cs4QSLGIi1Du8
	Bb5Tswgss7AWK6d0T4CxMkCZycjvnEjwzrmupcIj7upbZdnLtxM/eg8hbV+tZL8CZpCG0sb3u5L
	AaIQUN6ZKqdKlLsZhx/FlUctOYXNTzzIMw4fYEcIcNvJMWx5/sct+R01ojLDOKA==
X-Received: by 2002:a05:622a:50:b0:460:ad8e:f5ae with SMTP id d75a77b69052e-462ab26f61fmr307486391cf.19.1730916354473;
        Wed, 06 Nov 2024 10:05:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGGB/rr3rb9KVr8J164nn5/VzqvU40xNUz5CyU5xxF6VgXUKpFUv+LBuTQPl7f9QLlBO1HVRA==
X-Received: by 2002:a05:622a:50:b0:460:ad8e:f5ae with SMTP id d75a77b69052e-462ab26f61fmr307485881cf.19.1730916353949;
        Wed, 06 Nov 2024 10:05:53 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ad086df0sm74298431cf.5.2024.11.06.10.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 10:05:53 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
Date: Wed, 6 Nov 2024 13:05:52 -0500
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
Content-Language: en-US
In-Reply-To: <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/6/24 11:08 AM, Juri Lelli wrote:
> On 04/11/24 17:41, Joel Fernandes wrote:
>> On Mon, Nov 04, 2024 at 11:54:36AM +0100, Juri Lelli wrote:
> ...
>
>>> I added a printk in __dl_server_attach_root which is called after the
>>> dynamic rd is built to transfer bandwidth to it.
>>>
>>> __dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
>>> server interface"), do you have this change in your backport?
>> You nailed it! Our 5.15 backport appears to be slightly older and is missing
>> this from topology.c as you mentioned. Thanks for clarifying!
>>
>>
>>          /*
>>           * Because the rq is not a task, dl_add_task_root_domain() did not
>>           * move the fair server bw to the rd if it already started.
>>           * Add it now.
>>           */
>>          if (rq->fair_server.dl_server)
>>                  __dl_server_attach_root(&rq->fair_server, rq);
>>
>>>> So if rd changes during boot initialization, the correct dl_bw has to be
>>>> updated AFAICS. Also if cpusets are used, the rd for a CPU may change.
>>> cpusets changes are something that I still need to double check. Will
>>> do.
>>>
>> Sounds good, that would be good to verify.
> So, I played a little bit with it and came up with a simple set of ops
> that point out an issue (default fedora server install):
>
> echo Y >/sys/kernel/debug/sched/verbose
>
> echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control
>
> echo 0-7 > /sys/fs/cgroup/user.slice/cpuset.cpus
> echo 6-7 > /sys/fs/cgroup/user.slice/cpuset.cpus.exclusive
> echo root >/sys/fs/cgroup/user.slice/cpuset.cpus.partition
>
> The domains are rebuilt correctly, but we end up with a null total_bw.
>
> The conditional call above takes care correctly of adding back dl_server
> per-rq bandwidth when we pass from the single domain to the 2 exclusive
> ones, but I noticed that we go through partition_sched_domains_locked()
> twice for a single write of 'root' and the second one, since it's not
> actually destroying/rebuilding anything, is resetting total_bw w/o
> addition dl_server contribution back.
>
> Now, not completely sure why we need to go through partition_sched_
> domains_locked() twice, as we have (it also looked like a pattern from
> other call paths)
>
> update_prstate()
> -> update_cpumasks_hier()
>     -> rebuild_sched_domains_locked() <- right at the end
> -> update_partition_sd_lb()
>     -> rebuild_sched_domains_locked() <- right after the above call
>
> Removing the first call does indeed fix the issue and domains look OK,
> but I'm pretty sure I'm missing all sort of details and corner cases.
>
> Waiman (now Cc-ed), maybe you can help here understanding why the two
> back to back calls are needed?

Thanks for letting me know about this case.

I am aware that rebuild_sched_domains_locked() can be called more than 
once. I have addressed the hotplug case, but it can happen in some other 
corner cases as well. The problem with multiple 
rebuild_sched_domains_locked() calls is the fact that intermediate ones 
may be called where the internal states may not be consistent. I am 
going to work on a fix to this issue by making sure that 
rebuild_sched_domains_locked() will only be called once.

Cheers,
Longman



Return-Path: <linux-kernel+bounces-558881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD8CA5ECAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC637A699D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C321FBEA9;
	Thu, 13 Mar 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="gGKltulN"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE831FBE8B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741850286; cv=none; b=FzfA04MzMkM+XNs/s7XsTWlWIZdtbVbSApDnA+5QxSBODgk01z6TMUp6z5b9D2UZBQuT/4b2Xu1DToAunzn8hGpPG0UKf+DDOBDA1ogrPZWeY+K50nJNibRNEZPtGhc1+gGLya8rLaknSFEpXlg6VPzYFnpxqyHq8VHpvXgJu4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741850286; c=relaxed/simple;
	bh=GTnODKllfbkIpy4mE21uawSsrtvqe6QZjdMD5c1tN+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcCPGaRvWcgUMLlfKdr0MitsAiCjEAb6W+FmdE+iNDnIMeDF9Z4lMC2dB8IRn2MAr0NmYuSKzlQLOxyFzfj+vd9eYuz2DMGCi9o+HQ4c4I9YAG2is2NbNL8caMOS72DBnmE24WlJwViwAUghN71po9NfcryoyvhCY2Rp8ZxXGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=gGKltulN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff7cf59a8fso170677a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 00:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741850284; x=1742455084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGjKqsO6HawZIpt2W9rS9J2PwQQ3cuTohX7JJbhwEv8=;
        b=gGKltulNbrzaxF1RCGZdGRblJWxuDzRqLdA3mYsOvjSrAh1JyLnbIFcgjNfdFLG8Nn
         1/jGFGtoOYMutfx+1IkMgsnx221rNN9j8FbP9fQZYTEhV6mlH3gpmeIhOYVfxwv2BV8G
         VgnyShWCVsVE/QzjTIE6JHFe/aChCozNBz9Cw0NFl0E6SOkWwaqofiqEBBN8lLzc6Cg9
         AYGqcUs6NcGKDrW+01SLaYXoOnJLTcbhTeiex+lZQnoErdSPEpQCul3SDKWx+WPLVJwk
         w2SlgqSOXGu5CfKpf1TCWsGG+N84HdRdfsUfpel5IQKuFXK93bYljtkmxyrklGU4shAd
         CvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741850284; x=1742455084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGjKqsO6HawZIpt2W9rS9J2PwQQ3cuTohX7JJbhwEv8=;
        b=qSC1dSqx7P+K7yG+Ga3yLmCJJTQIxLrF2i9W4qfWAmeLgemtlm5sNFRgNdxn3lfS+U
         rztTNkxwe0vpbQq5oXmTuP2Mac/SRW9yE+2toLO4MlBjy5CM2JtsiV0bk1eZSfy9ivq3
         8hFxlaBZwzLEibZB7IPvoCLOLreLTEqaNetGUj027VNtdeV7LaoryjxH9LIsnhZhPLdM
         z8wWW40Xs24aTPeFtfGuPU+OB74hT8f4hUBl6ra2RnQ5HwwdPkCKFr3AaCHah3RkJVR7
         4sahrtv+q871LvFog/e3QEowgH4HeJEU/4tmpapMsreLP4dvu3+uz3N91UIre9/JZYcQ
         Sakg==
X-Forwarded-Encrypted: i=1; AJvYcCXt/f9jTVjbGpZoUeUUIUSYvMM2qPmggUCx0QB5xsNV18cR7YFV00s/A+0r0Wc10/SQCzF1G1a9F6jiZzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQVm3AAQGdcGyyZLeSC3+Do+NTdoclUNy5syUfp0EuxZQ2/TO
	khlfjK9f7yn9ZAaGR6qsRlAzUFS7FooZL3Eva7QmeqopaU5G4GuWeP8VJQFPH3g=
X-Gm-Gg: ASbGnctfMfctLdNwSSSPduwl47K4InfASsdvLgNRxMHusvrWizmZRcTuqmZwbOQQipr
	/6e/8jtmIcX58hSj40y4MN6hz8ZRsWJNaRj0y1J2/6uDiPpC+WlXi/qGE2ZGE3AXVYSC9Pe7f3P
	UsDxOEVnJF8YTYGZ5vhWDXj6x44V4P6urUXKCXRuu8hmhtg6osjdwtocoB1LYSp4ZDqt3X4i9eo
	B+Tp4PfoBcV2Ony5FSS+dF7dIZ527qQCKrDJGvevduUwXTd7XxKpDXzAftplh2Vf0eozS4obPLw
	tz2Cf7ZEFdhqIdoNo55ZARUKAo/cwfcHmkfGQBwGV8hqb1p70BKSApi//ynolmKTC7jCLqr/bGQ
	svw==
X-Google-Smtp-Source: AGHT+IHdDANhdEWHZICUDuI7pdvt5musG+Bo7/VcGat/Im47ZMPB3pItJC3DdH15KGUifr9jRQLbMg==
X-Received: by 2002:a17:90b:1649:b0:2ff:5759:549a with SMTP id 98e67ed59e1d1-300ff7245bdmr5271939a91.1.1741850283863;
        Thu, 13 Mar 2025 00:18:03 -0700 (PDT)
Received: from [10.254.33.33] ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30102718e71sm3142267a91.0.2025.03.13.00.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 00:18:03 -0700 (PDT)
Message-ID: <e4ad9841-5ba2-4704-95f2-3d8affee9afa@bytedance.com>
Date: Thu, 13 Mar 2025 15:17:56 +0800
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
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CAKfTPtA3k7oXqKjX6bNsjG1BCjq4TB6fWvTH1RV425iK01xA2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 3/12/25 12:58 AM, Vincent Guittot wrote:
> On Mon, 10 Mar 2025 at 08:41, Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> This reverts commit 17346452b25b98acfb395d2a82ec2e4ad0cb7a01.
>>
>> The above commit tried to unify selection policy between idle cpus
>> and SCHED_IDLE ones in fast- and slow-path of select_task_rq_fair()
>> by treating them equally (although the SCHED_IDLE cpus are turned
>> to be given more preference in slowpath). The test results seemed
>> solid, but the setup didn't take cgroup hierarchy into account,
>> which actually made some of our important services get affected.
>>
>> The cgroup hierarchy in our production environment looks like below,
>> which might be common in modern containerized setup:
>>
>>                            root
>>                          /       \
>>                  kubepods        system.slice
>>                  /       \\              \
>>          guaranteed      besteffort      containerd
>>
>>          (where 'X=A' means A is SCHED_IDLE cgroup)
>>
>> The cpu is treated as SCHED_IDLE if only besteffort is running, which
>> is given at least equal preference as the idle cpus when deciding where
>> to run a newly woken task. But the SCHED_IDLE cpus do not necessarily
>> mean they can be preempted soon enough to start serving the wakee, and
> 
> Could you give us more details why the SCHED_IDLE cpu which runs only
> besteffort can't be preempted soon enough ?
> 
> because kubepods vs system.slice is not sched_idle when comparing the

Yes, exactly. What's worse is that kubepods.weight is the sum of all its
children and can easily reach ~3000, while system.weight is default to
100. The weight configuration can be optimized, but it's another topic.

> entities ? some maybe the definition of sched_idle_cpu should be fixed
> instead

Yes, there are at least two ways to fix it:

  1) Let sched_idle_cpu() depends on a specific task, just like Josh
     mentioned in the reply of 2nd patch. So if sched_idle_cpu(cpu, p)
     returns true, then

	a) this rq only contains hierarchical idle tasks, and
	b) p can preempt current immediately

     Please see my reply to Josh to check the details.

  2) Or get rid of sched_idle_cpu() entirely. This needs some careful
     rework. Now the users of cfs_rq::h_nr_idle are two parts:

	a) select_task_rq, including sched_balance_find_dst_group_cpu()
	   and select_idle_*(). The former is handled by this series by
	   simply ignoring sched_idle_cpus, which should be safe since
	   sched_idle_cpus do not always follow the goal of the slowpath
	   to find a least loaded cpu to help load balancing. While the
	   latter is roughly designed as following:

	   - Must search within target LLC domain, since L3$ miss is
	     much more costly than L1/L2$
	   - To use cache more wisely, start searching from the L1/L2$
	     cache hot cpus like prev/recent_used/..
	   - Cheers if found an idle cpu that can preempt immediately.
	     This helps maximize using cpu bandwidth, hence improving
	     total throughput
	   - (?)
	   - Return target anyway, at least it might be cache hot

	   It could be less optimal if simply remove sched_idle_cpu and
	   return @target if no idle cpu available, because @target can
	   be heavy loaded and the cache may not hot any longer when the
	   wakee finally hit cpu. So in order not to fight with the load
	   balancing, shall we tiebreak on cpu_load() for the non-idle
	   cpus?

	b) load balance: sched_balance_domains() and dequeue_entities().
	   We could leave this as-is, but I would propose using h_idle
	   instead: if the on_cpu task is hierarchically idle when
	   triggering normal load balancing, then we guess it's a less
	   loaded cpu and can reduce balance interval. The rationale
	   behind is that the idle entities usually get very limited
	   bandwidth if any hierarchically non-idle tasks available.
	   The heuristics may have false positives which can generally
	   be divided into 3 cases:

		(The numbers represents hierarchical shares%)

						   C
		   A		   B		  / \
		 /  \\		 /  \\		 80  20
		99    1		50   50		// \
					      100  (X)

	   - Case A) The hierarchical share of h_idle tasks is indeed
	     small. So in this case they are just get scheduled to take
	     some breath, and the possibility of false positive is low
	     enough to be safely ignored.

	   - Case B) The h_idle & !h_idle tasks equally share bandwidth
	     which usually means the !h_idle part becomes less loaded
	     and pulling some load might be preferred.

	   - Case C) The hierarchical share of h_idle tasks dominates
	     which usually means their !h_idle parents are allowed to
	     use a big portion of bandwidth. In this case speedup the
	     balance is still fine because we could pull some !h_idle
	     tasks for the most 'important' cgroup.

	   So the heuristics of using rq->curr's h_idle to judge the need
	   of pulling (load balancing) seems fine.

     And as a result cfs_rq::h_nr_idle can be removed and its maintenance
     cost in hotpath can be saved.

Which way do you prefer? It would be much appreciated if you can shed some
light on this.

> 
> a sched_idle_cpu should be preempted immediately otherwise it's not a
> sched idle cpu and the definition is meaningless

Agree.

Thanks!
	Abel



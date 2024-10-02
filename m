Return-Path: <linux-kernel+bounces-347278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F498D06E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 11:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299C3B22B32
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F6E1E2016;
	Wed,  2 Oct 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3znMoKA"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7D1A2561
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862629; cv=none; b=rPdSMjC2eSB3lZUXfm2OhhPcIxBYg0ytrGIRLqZ/y1M9acZ3VRMTo/GQMJYBp4kPMI+F94oP+yZPsW7e8g4rqxdrncEeIG6VjbQLK+YfFC84n1KQc+Wkgf7GRjwVv22fVWrdKWwW9ErQTQ8rgjqXpVRWj1drLcl39EVA6ewgtpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862629; c=relaxed/simple;
	bh=r/7hUHPmuVIhErMLyExpThQEuUPPTXk+5PS7kXucbzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGJIHFFfKX757g8UNSYaq1NtPJ8HgCCBLh4+hvf8J+1Qu0/tdexmBJHekX7uekHe/8CQTOu8vQIRHPUnT9iYBjclATEMX6OdXjIkAT22xOvxdYZfdRvod7L33YiuLJY01WMGqn50d4WMnVOUNYApvtoLp4nFxXyGYkzanMP1YLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3znMoKA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ba733b904so21121945ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 02:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727862627; x=1728467427; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tUyCShMA8adao/8Qfi85pwmiC0PNhXETIKd3lc+vUUY=;
        b=O3znMoKALNFv+Y7R2R9yXfvIGEgG2YDg796akjv4R0tpb+vfAOZDJq94es5nxrf4wc
         Os9HfGI8MlDuFDvxcR4eyCiZb/srzxYmYiLlmnmszLfiKggMmVkr69HJKU/fmQecAyIp
         oUSIRugtWIZkjVsmrbEOPGY8mN08AKSVAvec37byuw7gBgw8b7tG4yb1w8SL8VSnqQJq
         MimjJ4bIkHKf0B3kHVf6X5cIp+q0tNCQXJ7Isjdkrvkv1LmVNG3oJSGZG9dXYBD1KY21
         KDMTnjYe7uwHy6Nv0hjcclZ4WXIXgRIG7KsMPD7aTtaSGPczMrDt83pLkqbEm7Vx+WQu
         FokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727862627; x=1728467427;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUyCShMA8adao/8Qfi85pwmiC0PNhXETIKd3lc+vUUY=;
        b=A+t//rMy+e4X52Q0ey/zxXgRTO/d1EAbQMBUyu0wm6rJl+1exTCj2PfOwwxIKdqZcp
         VSGfF9gxlnDmHGubRBH8NV+6fzqOEWYFdNag0ayxgvlweKZdPT0C+TrPl+1GxLWIgusk
         ZwuDk5ULmdyvOe9XSEr5gzlbzou3syb9t36S4zf2fjfhs0bhyysecIIAO8H6O0Ei+bcY
         5cq01XXXPwkXH3+nubLnVVfvcHG4STeiiK7ANMWtmJZPRkmfbF1fVtsFqrrteXlOvqd0
         esdZnhwZYbwpdfcJK7YE1yfTK5fu4i3Dc8DEeRQbC0o+2FsXlu+cfkb9FEJqN/HfAn2T
         Xw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgfXml91oMqfz9V8I5cRfpb3pgznni7ZNJLb3b6Qrm2mK0TKrtunnX4wAOOVSndwhygJlbjDu1Oo0erQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFgdaQsS02W1itDEESG6+4+5pSOC3q6eoGNOviMJEI0gBVoBGj
	UuTDdz8sYMi4OFlkSQ+x+eskZ/fvGHF3AyF97gLS6WpyytPP+iQWR8wQXZDeBsi/Bo7xDMOXMDF
	yV2BOzFrTK0mWh/9+O9tDujbN092DeKEd947723YIxKLR/hwA8oB2
X-Google-Smtp-Source: AGHT+IFaA0eBqDMOTobLIj8alX//026MTUGzQDiolrWJDxP8bf17guHQKqYceFySLy5sCfZUOQs0P49Y05dDaY4jLjk=
X-Received: by 2002:a17:902:d2ca:b0:20b:b26e:c143 with SMTP id
 d9443c01a7336-20bc5ac1213mr39750875ad.57.1727862626805; Wed, 02 Oct 2024
 02:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930185920.1149002-1-mathieu.desnoyers@efficios.com> <20240930185920.1149002-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240930185920.1149002-2-mathieu.desnoyers@efficios.com>
From: Marco Elver <elver@google.com>
Date: Wed, 2 Oct 2024 11:49:48 +0200
Message-ID: <CANpmjNOstLxnMOfHy85_tCCrt4PAuZBhzuTbY5OOxG91tEcrjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched: Improve cache locality of RSEQ concurrency
 IDs for intermittent workloads
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	Valentin Schneider <vschneid@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 21:01, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> commit 223baf9d17f25 ("sched: Fix performance regression introduced by mm_cid")
> introduced a per-mm/cpu current concurrency id (mm_cid), which keeps
> a reference to the concurrency id allocated for each CPU. This reference
> expires shortly after a 100ms delay.
>
> These per-CPU references keep the per-mm-cid data cache-local in
> situations where threads are running at least once on each CPU within
> each 100ms window, thus keeping the per-cpu reference alive.
>
> However, intermittent workloads behaving in bursts spaced by more than
> 100ms on each CPU exhibit bad cache locality and degraded performance
> compared to purely per-cpu data indexing, because concurrency IDs are
> allocated over various CPUs and cores, therefore losing cache locality
> of the associated data.
>
> Introduce the following changes to improve per-mm-cid cache locality:
>
> - Add a "recent_cid" field to the per-mm/cpu mm_cid structure to keep
>   track of which mm_cid value was last used, and use it as a hint to
>   attempt re-allocating the same concurrency ID the next time this
>   mm/cpu needs to allocate a concurrency ID,
>
> - Add a per-mm CPUs allowed mask, which keeps track of the union of
>   CPUs allowed for all threads belonging to this mm. This cpumask is
>   only set during the lifetime of the mm, never cleared, so it
>   represents the union of all the CPUs allowed since the beginning of
>   the mm lifetime. (note that the mm_cpumask() is really arch-specific
>   and tailored to the TLB flush needs, and is thus _not_ a viable
>   approach for this)
>
> - Add a per-mm nr_cpus_allowed to keep track of the weight of the
>   per-mm CPUs allowed mask (for fast access),
>
> - Add a per-mm nr_cids_used to keep track of the highest concurrency
>   ID allocated for the mm. This is used for expanding the concurrency ID
>   allocation within the upper bound defined by:
>
>     min(mm->nr_cpus_allowed, mm->mm_users)
>
>   When the next unused CID value reaches this threshold, stop trying
>   to expand the cid allocation and use the first available cid value
>   instead.
>
> Spreading allocation to use all the cid values within the range
>
>   [ 0, min(mm->nr_cpus_allowed, mm->mm_users) - 1 ]
>
> improves cache locality while preserving mm_cid compactness within the
> expected user limits.
>
> - In __mm_cid_try_get, only return cid values within the range
>   [ 0, mm->nr_cpus_allowed ] rather than [ 0, nr_cpu_ids ]. This
>   prevents allocating cids above the number of allowed cpus in
>   rare scenarios where cid allocation races with a concurrent
>   remote-clear of the per-mm/cpu cid. This improvement is made
>   possible by the addition of the per-mm CPUs allowed mask.
>
> - In sched_mm_cid_migrate_to, use mm->nr_cpus_allowed rather than
>   t->nr_cpus_allowed. This criterion was really meant to compare
>   the number of mm->mm_users to the number of CPUs allowed for the
>   entire mm. Therefore, the prior comparison worked fine when all
>   threads shared the same CPUs allowed mask, but not so much in
>   scenarios where those threads have different masks (e.g. each
>   thread pinned to a single CPU). This improvement is made
>   possible by the addition of the per-mm CPUs allowed mask.
>
> * Benchmarks
>
> Each thread increments 16kB worth of 8-bit integers in bursts, with
> a configurable delay between each thread's execution. Each thread run
> one after the other (no threads run concurrently). The order of
> thread execution in the sequence is random. The thread execution
> sequence begins again after all threads have executed. The 16kB areas
> are allocated with rseq_mempool and indexed by either cpu_id, mm_cid
> (not cache-local), or cache-local mm_cid. Each thread is pinned to its
> own core.
>
> Testing configurations:
>
> 8-core/1-L3:        Use 8 cores within a single L3
> 24-core/24-L3:      Use 24 cores, 1 core per L3
> 192-core/24-L3:     Use 192 cores (all cores in the system)
> 384-thread/24-L3:   Use 384 HW threads (all HW threads in the system)
>
> Intermittent workload delays between threads: 200ms, 10ms.
>
> Hardware:
>
> CPU(s):                   384
>   On-line CPU(s) list:    0-383
> Vendor ID:                AuthenticAMD
>   Model name:             AMD EPYC 9654 96-Core Processor
>     Thread(s) per core:   2
>     Core(s) per socket:   96
>     Socket(s):            2
> Caches (sum of all):
>   L1d:                    6 MiB (192 instances)
>   L1i:                    6 MiB (192 instances)
>   L2:                     192 MiB (192 instances)
>   L3:                     768 MiB (24 instances)
>
> Each result is an average of 5 test runs. The cache-local speedup
> is calculated as: (cache-local mm_cid) / (mm_cid).
>
> Intermittent workload delay: 200ms
>
>                      per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
>                          (ns)      (ns)                  (ns)
> 8-core/1-L3             1374      19289                  1336            14.4x
> 24-core/24-L3           2423      26721                  1594            16.7x
> 192-core/24-L3          2291      15826                  2153             7.3x
> 384-thread/24-L3        1874      13234                  1907             6.9x
>
> Intermittent workload delay: 10ms
>
>                      per-cpu     mm_cid    cache-local mm_cid    cache-local speedup
>                          (ns)      (ns)                  (ns)
> 8-core/1-L3               662       756                   686             1.1x
> 24-core/24-L3            1378      3648                  1035             3.5x
> 192-core/24-L3           1439     10833                  1482             7.3x
> 384-thread/24-L3         1503     10570                  1556             6.8x
>
> [ This deprecates the prior "sched: NUMA-aware per-memory-map concurrency IDs"
>   patch series with a simpler and more general approach. ]
>
> Link: https://lore.kernel.org/lkml/20240823185946.418340-1-mathieu.desnoyers@efficios.com/
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Acked-by: Marco Elver <elver@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Changes since v0:
> - On migration, do not move the source cid to the destination cpu if the
>   destination cpu has a recent cid value set.
>
> Changes since v2:
> - Rebase on v6.11.1.

I think the versioning and changelog got confused. I see the changes
from [1] which was already v2 are included in this one.

[1] https://lore.kernel.org/all/5cf2c0a5-7a99-4294-b316-eee07896ddf6@efficios.com/T/#u

In any case, I'll reiterate my Ack as this looks like an improvement
for the common case.

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco


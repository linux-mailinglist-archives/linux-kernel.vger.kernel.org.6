Return-Path: <linux-kernel+bounces-326945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17938976EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF6E28253A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843FD1B6541;
	Thu, 12 Sep 2024 16:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwPTkUjf"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D91AD256
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159150; cv=none; b=mvxdhwIWYwXYb8equ+yVkjeBiCxhxxyTDnhPd5ajVdaV3RYLOE+m6ZvdNCC1Gh0vujNyLuaQR8cA0LAApoQdXrombFNjpth7M4aAWB1v1Cb8noHeRyPMrX+EZ3lhos3BfNj9VWY37/wnxA/qUgwL/GRgHxIwxD8Rei4cQaZU72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159150; c=relaxed/simple;
	bh=LCcvfp4PKWBAe5vkmrgHGg3k0mb48S6KmY86tDUVi10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwQlAALycyT6W4AIaEMAftjtdnPLLcVvtNumu0hsLqq58x82Q1xyzFY1se2NCg6wyOA+/F8e1/PhRYTffVwNUmaR7qhoiJh8BtJwBTW8UbQ+F985yiv+xgdvxpbjzM/ic5Z0TR8BgDnWmeIIGTZaluqPjTHeLlZ0cHpp9cg3nG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwPTkUjf; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1007533a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726159147; x=1726763947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTdYHyLuK9WbShZPmPpgg2pgyB5zwJlMRqpYXdQHj1M=;
        b=NwPTkUjfo1cWFR/xKHTxpzlhcRFBDpr/kWvm34gjpyY7ODNX6AyjKqQqsJ8Z1g/tqw
         mspF5exZs/8mjv88QuBoG1YYX63TjFixEP+aIG9ZM+6TYACyLzk9CnXHmjL7yHL2zr0C
         eDhnDy3eikEHQPYL9+YXfZjzvUBPVZNqOAH7pF5D0O7/5IiB6Mrj6AXWEBWUBHr5aSOb
         lGJTx0QVAOMVyzA/7AkDIIIh+u8PZXE9elJLJOPcQT/CRGRYLdauPaEsRbTW8YpsrgmC
         bI2TCcsZ5MDlVDqFJibxQDPDAmfYRvLkYEqpKsM1mmN6kmrwI8huLy7mV47XqM8M04uc
         WqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726159147; x=1726763947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTdYHyLuK9WbShZPmPpgg2pgyB5zwJlMRqpYXdQHj1M=;
        b=ojCRm+F1BecBExiuhQ4Jk87mASDnfagw9GCfJFeWHgDqDihoqruBLeau8LA4ARzWPs
         q1uvrwnOyJ4y60HOtoMYmicA9rvmQQO5OXJTe8z1EUENH3CHKfkJ5DTZQ4R9babMb5kw
         fooEKUdXQ5CJ68ifLwXDhjsTpVzcotPQN6+0l8HSmlq4yT1HivqxwmONOZhtbQrkN9RS
         rtAD73yMw2EUzn6r5qQFfSJJpIxpjcE247JS0QTE/acIgaENeLVmD3sluu0K8v7An3Hf
         72ScY6KE0ZAZREoJEMw/oHYqgu5NUwKVBVzFnqjhMyAWjFWhZthHIAivyscnHWTZztUt
         aQhg==
X-Forwarded-Encrypted: i=1; AJvYcCU6epLntPs1flM3h0djWwqhqtK2MGZiJK9+Zbef6BlQeGDCNbuDOLRcJRJYdQg61t6s8Cq6MCExnFG+euU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4po65wYFCgKnE9T/IJaU2KcGHZ1lZh9rZ3Sm+Wq2piAkkNmxG
	A5cfQ6L0/4w8BEqkr9XV8OlBxSJ70rbW0qJ5579QHM6V8m9RsA6cLRoNbIGidwFS1HAYKN6N5vH
	6CKGtaSoRV2s1TY+PryQRE4rovbQ1oQ87xXiU
X-Google-Smtp-Source: AGHT+IHmj3RIvbxM6xjvZYqt+Axa65vhzwgFtEgYDzUs8CNhZSgik8WA7/WWnX3cFoy4kkpIUX9/m+T3JnrpwbFMDis=
X-Received: by 2002:a17:902:e884:b0:205:8a8b:bd2a with SMTP id
 d9443c01a7336-2074c6df0bemr132694585ad.22.1726159146402; Thu, 12 Sep 2024
 09:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909211506.326648-1-mathieu.desnoyers@efficios.com> <20240909211506.326648-2-mathieu.desnoyers@efficios.com>
In-Reply-To: <20240909211506.326648-2-mathieu.desnoyers@efficios.com>
From: Marco Elver <elver@google.com>
Date: Thu, 12 Sep 2024 18:38:30 +0200
Message-ID: <CANpmjNMjndyBAO3HKHkC+v7zNZv1XHvH5Fjd9S5q0Jj-sEkx-w@mail.gmail.com>
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

On Mon, 9 Sept 2024 at 23:15, Mathieu Desnoyers
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

One orthogonal idea that I recall: If a thread from a different thread
group (i.e. another process) was scheduled on that CPU, the CID can
also be invalidated because the caches are likely polluted. Fixed
values like 100ms seem rather arbitrary and it may work for one system
but not another.

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

I like the simpler and more general approach vs. the NUMA-only
approach! Attempting to reallocate the previously assigned CID seems
to go a long way.

However, this doesn't quite do L3-awareness as mentioned in [1], right?
What I can tell is that this patch improves cache locality for threads
scheduled back on the _same CPU_, but not if those threads are
scheduled on a _set of CPUs_ sharing the _same L3_ cache. So if e.g. a
thread is scheduled from CPU2 to CPU3, but those 2 CPUs share the same
L3 cache, that thread will get a completely new CID and is unlikely to
hit in the L3 cache when accessing the per-CPU data.

[1] https://github.com/google/tcmalloc/issues/144#issuecomment-2307739715

Maybe I missed it, or you are planning to add it in future?

In any case, the current patch is definitely an improvement:

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco


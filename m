Return-Path: <linux-kernel+bounces-572166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1ACA6C789
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 04:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAA6189C0EF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA93139D1B;
	Sat, 22 Mar 2025 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rCazm9xl"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A033D8
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 03:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742615786; cv=none; b=cWoJIB58b+PJB0KA82HNalnLD08N6mLrClQQ/U+sXVeCFPXpKAs78L/0I82hP3ZOF4oooUMKCJm6Vkur5GWWFXqKdOZSxyR8dxPwJy83aztXCAlw9icbiXYMdNLVZVse+MCHbhPWkFmGm6iKftnNjJdgxyD/4Monv9SRIHsjDiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742615786; c=relaxed/simple;
	bh=nIYWf15vv5E0x/3uwmuWi7JPfer+ZYHV68waadUgpOE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=vCoJJTn4Q75yyjIUHSPYZFvW7LH6ylry9H3jvKiSE3XAACmKTh2G3io2mHw+v3cHhciuai+DdthclGnclufoVFzECiiFobay9GunqFildhXv6qfnESxXrvtypnAsFIY8x5r60yfy2bLAw6AuWLqyuOb0TuQH83jxABPOPq7B1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rCazm9xl; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KuX9Ur+ayfgLDPbRVgVWN0FplUcmGVU65jPJPXW+Xx8=; b=rCazm9xleZdU2OB7rYZqSETj18
	KG1ngybgICKvU+Xo/pq0ZcHSZtC6mAZEbWmr+isVu8mOAxKbacu4TCtg3swnEuaD7cSeCLY8bcU5r
	c1K2m9dfApVSlSS3sRhWuYTxmDYDc2rAju0Gm2LB2Fcu3GOWhvi4gg+TwwHdXVbJxcCl5zOQXaMhk
	YrVZgV92Yf80GTkZWAFfTKVNCosPAAVfO0aO6RSYhb+OmT4BGJwUIrkU+auGq9pM8Zt2wpyZXtAGX
	QmP/N9KUB0caaj1O3BrkoFx146z03mSVueAIQP44sGR94Qh/AHHrkc1CCKv46tIbabn0Tq4X15nWt
	LPWuc00Q==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tvpy2-004WFo-0u; Sat, 22 Mar 2025 04:56:14 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1tvpy0-0067lJ-3i; Sat, 22 Mar 2025 04:56:13 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <changwoo@igalia.com>)
	id 1tvpxo-00AUp3-1R;
	Sat, 22 Mar 2025 04:56:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 22 Mar 2025 12:56:11 +0900
From: Changwoo Min <changwoo@igalia.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v6 sched_ext/for-6.15] sched_ext: Enhance built-in idle
 selection with allowed CPUs
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Message-ID: <36366fd3e9bc730300cc2262687c890f@igalia.com>
X-Sender: changwoo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,AWL=0.000,BAYES_50=0.8
X-Spam-Score: -21
X-Spam-Bar: --

Hi Andrea,

Looks great to me.

Thanks!
Changwoo Min

On 2025-03-22 07:10, Andrea Righi wrote:
> Many scx schedulers implement their own hard or soft-affinity rules to
> support topology characteristics, such as heterogeneous architectures
> (e.g., big.LITTLE, P-cores/E-cores), or to categorize tasks based on
> specific properties (e.g., running certain tasks only in a subset of CPUs).
> 
> Currently, there is no mechanism that allows to use the built-in idle CPU
> selection policy to an arbitrary subset of CPUs. As a result, schedulers
> often implement their own idle CPU selection policies, which are typically
> similar to one another, leading to a lot of code duplication.
> 
> To address this, extend the built-in idle CPU selection policy introducing
> ]the concept of allowed CPUs.
> 
> With this concept, BPF schedulers can apply the built-in idle CPU selection
> policy to a subset of allowed CPUs, allowing them to implement their own
> hard/soft-affinity rules while still using the topology optimizations of
> the built-in policy, preventing code duplication across different
> schedulers.
> 
> To implement this introduce a new helper kfunc scx_bpf_select_cpu_and()
> that accepts a cpumask of allowed CPUs:
> 
> s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu,
> 			   u64 wake_flags,
> 			   const struct cpumask *cpus_allowed, u64 flags);
> 
> Example usage
> =============
> 
> s32 BPF_STRUCT_OPS(foo_select_cpu, struct task_struct *p,
> 		   s32 prev_cpu, u64 wake_flags)
> {
> 	const struct cpumask *cpus = task_allowed_cpus(p) ?: p->cpus_ptr;
> 	s32 cpu;
> 
> 	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, cpus, 0);
> 	if (cpu >= 0) {
> 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> 		return cpu;
> 	}
> 
> 	return prev_cpu;
> }
> 
> Results
> =======
> 
> Load distribution on a 4 sockets / 4 cores per socket system, simulated
> using virtme-ng, running a modified version of scx_bpfland that uses the
> new helper scx_bpf_select_cpu_and() and 0xff00 as allowed domain:
> 
>      $ vng --cpu 16,sockets=4,cores=4,threads=1
>      ...
>      $ stress-ng -c 16
>      ...
>      $ htop
>      ...
>        0[                         0.0%]   8[||||||||||||||||||||||||100.0%]
>        1[                         0.0%]   9[||||||||||||||||||||||||100.0%]
>        2[                         0.0%]  10[||||||||||||||||||||||||100.0%]
>        3[                         0.0%]  11[||||||||||||||||||||||||100.0%]
>        4[                         0.0%]  12[||||||||||||||||||||||||100.0%]
>        5[                         0.0%]  13[||||||||||||||||||||||||100.0%]
>        6[                         0.0%]  14[||||||||||||||||||||||||100.0%]
>        7[                         0.0%]  15[||||||||||||||||||||||||100.0%]
> 
> With scx_bpf_select_cpu_dfl() tasks would be distributed evenly across all
> the available CPUs.
> 
> ChangeLog v5 -> v6:
>  - prevent redundant cpumask_subset() + cpumask_equal() checks in all
>    patches
>  - remove cpumask_subset() + cpumask_and() combo with local cpumasks, as
>    cpumask_and() alone is generally more efficient
>  - cleanup patches to prevent unnecessary function renames
> 
> ChangeLog v4 -> v5:
>  - simplify code to compute the temporary task's cpumasks (and)
> 
> ChangeLog v3 -> v4:
>  - keep p->nr_cpus_allowed optimizations (skip cpumask operations when the
>    task can run on all CPUs)
>  - allow to call scx_bpf_select_cpu_and() also from ops.enqueue() and
>    modify the kselftest to cover this case as well
>  - rebase to the latest sched_ext/for-6.15
> 
> ChangeLog v2 -> v3:
>  - incrementally refactor scx_select_cpu_dfl() to accept idle flags and an
>    arbitrary allowed cpumask
>  - build scx_bpf_select_cpu_and() on top of the existing logic
>  - re-arrange scx_select_cpu_dfl() prototype, aligning the first three
>    arguments with select_task_rq()
>  - do not use "domain" for the allowed cpumask to avoid potential ambiguity
>    with sched_domain
> 
> ChangeLog v1 -> v2:
>   - rename scx_bpf_select_cpu_pref() to scx_bpf_select_cpu_and() and always
>     select idle CPUs strictly within the allowed domain
>   - rename preferred CPUs -> allowed CPU
>   - drop %SCX_PICK_IDLE_IN_PREF (not required anymore)
>   - deprecate scx_bpf_select_cpu_dfl() in favor of scx_bpf_select_cpu_and()
>     and provide all the required backward compatibility boilerplate
> 
> Andrea Righi (6):
>       sched_ext: idle: Extend topology optimizations to all tasks
>       sched_ext: idle: Explicitly pass allowed cpumask to scx_select_cpu_dfl()
>       sched_ext: idle: Accept an arbitrary cpumask in scx_select_cpu_dfl()
>       sched_ext: idle: Introduce scx_bpf_select_cpu_and()
>       selftests/sched_ext: Add test for scx_bpf_select_cpu_and()
>       sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
> 
>  Documentation/scheduler/sched-ext.rst              |  11 +-
>  kernel/sched/ext.c                                 |   6 +-
>  kernel/sched/ext_idle.c                            | 196 ++++++++++++++++-----
>  kernel/sched/ext_idle.h                            |   3 +-
>  tools/sched_ext/include/scx/common.bpf.h           |   5 +-
>  tools/sched_ext/include/scx/compat.bpf.h           |  37 ++++
>  tools/sched_ext/scx_flatcg.bpf.c                   |  12 +-
>  tools/sched_ext/scx_simple.bpf.c                   |   9 +-
>  tools/testing/selftests/sched_ext/Makefile         |   1 +
>  .../testing/selftests/sched_ext/allowed_cpus.bpf.c | 121 +++++++++++++
>  tools/testing/selftests/sched_ext/allowed_cpus.c   |  57 ++++++
>  .../selftests/sched_ext/enq_select_cpu_fails.bpf.c |  12 +-
>  .../selftests/sched_ext/enq_select_cpu_fails.c     |   2 +-
>  tools/testing/selftests/sched_ext/exit.bpf.c       |   6 +-
>  .../sched_ext/select_cpu_dfl_nodispatch.bpf.c      |  13 +-
>  .../sched_ext/select_cpu_dfl_nodispatch.c          |   2 +-
>  16 files changed, 404 insertions(+), 89 deletions(-)
>  create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.bpf.c
>  create mode 100644 tools/testing/selftests/sched_ext/allowed_cpus.c


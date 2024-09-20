Return-Path: <linux-kernel+bounces-334024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486797D17C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 09:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82081C20EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4484317C;
	Fri, 20 Sep 2024 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hH7cR0Lt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D467533985
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 07:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726815970; cv=none; b=VZ8I02LRJbfsVJ6YQejxq55mpSRnmnZDmiVsaiNz8Dt+bDzpZP6tLjCyB0SgaE1azBpffowXuawQ3tFZLRSPPdX5XNV3Z6/4o5TCHIUzD/nWUn0trCZfn4hWUds8HBmrIyOiUKCSiVh1+k9s7QMAz8S513NVIn61wchFCPLY99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726815970; c=relaxed/simple;
	bh=CUaHdcr+YeGCm5WfQwO0BxY5FYqe+pRN4TWzd/tcsQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuiMUFi2QmFZ6pJdtgYnIOsjQ1uODLGIqaxJrLPvGWmVHh1eTDr0B+2xgMlvDqsdkKWDiU8ObN041Wy8GEEH4zhgXxwDuhtPGEp27RbL9IYvSVt3P6jv0yC9apFAajTjZyKrq984oVOxyQy3gq0N3xZrUR7tTAVEqF4igUiaGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hH7cR0Lt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726815966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMLi26Ot/09hw308XgpmDQ1bhpqjNzpxindTAL542qA=;
	b=hH7cR0LtAH9/CHO5cFJwngeEM6KesPVWmrejzoqk2pQ2XYig1LXOqbOiMatJPeZE7P0mx5
	tbeAIT4ACsWzt2PH9/rRGTH/b+KhJrMPvR85c7dxDqUPfPs+GAutpFSTTdgNBkGl9IxewS
	aergRFEi33JYeW+XNLA2vfXljGIkqdw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-1agu7WBaNGmaoxCAhPFrgQ-1; Fri,
 20 Sep 2024 03:06:05 -0400
X-MC-Unique: 1agu7WBaNGmaoxCAhPFrgQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19C9F1979044;
	Fri, 20 Sep 2024 07:06:03 +0000 (UTC)
Received: from [10.45.224.224] (unknown [10.45.224.224])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2CF3F19560A3;
	Fri, 20 Sep 2024 07:05:58 +0000 (UTC)
Message-ID: <5f48073d-8b4e-4569-af4f-3a9b5586d7ad@redhat.com>
Date: Fri, 20 Sep 2024 03:05:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] cpu/bugs: cgroup: Add a cgroup knob to bypass CPU
 mitigations
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Kaplan <David.Kaplan@amd.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20240919-selective-mitigation-v1-0-1846cf41895e@linux.intel.com>
 <20240919-selective-mitigation-v1-2-1846cf41895e@linux.intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240919-selective-mitigation-v1-2-1846cf41895e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 9/19/24 17:52, Pawan Gupta wrote:
> For cases where an admin wanting to bypass CPU mitigations for a specific
> workload that they trust. Add a cgroup attribute "cpu.skip_mitigation" that
> can only be set by a privileged user. When set, the CPU mitigations are
> bypassed for all tasks in that cgroup.
>
> Before setting this knob, the admin should be aware of possible security
> risks like confused deputy attack on trusted interpreters, JIT engine,
> etc.
>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>   arch/x86/include/asm/switch_to.h | 10 ++++++++++
>   arch/x86/kernel/cpu/bugs.c       | 21 ++++++++++++++++++++
>   include/linux/cgroup-defs.h      |  3 +++
>   kernel/cgroup/cgroup.c           | 42 ++++++++++++++++++++++++++++++++++++++++
>   kernel/sched/core.c              |  2 +-
>   5 files changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/switch_to.h b/arch/x86/include/asm/switch_to.h
> index c3bd0c0758c9..7f32fd139644 100644
> --- a/arch/x86/include/asm/switch_to.h
> +++ b/arch/x86/include/asm/switch_to.h
> @@ -46,6 +46,16 @@ struct fork_frame {
>   	struct pt_regs regs;
>   };
>   
> +extern inline void cpu_mitigation_skip(struct task_struct *prev, struct task_struct *next);
> +
> +#define prepare_arch_switch prepare_arch_switch
> +
> +static inline void prepare_arch_switch(struct task_struct *prev,
> +				       struct task_struct *next)
> +{
> +	cpu_mitigation_skip(prev, next);
> +}
> +
>   #define switch_to(prev, next, last)					\
>   do {									\
>   	((last) = __switch_to_asm((prev), (next)));			\
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 45675da354f3..77eb4f6dc5c9 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -128,6 +128,27 @@ DEFINE_STATIC_KEY_FALSE(switch_mm_cond_l1d_flush);
>   DEFINE_STATIC_KEY_FALSE(mmio_stale_data_clear);
>   EXPORT_SYMBOL_GPL(mmio_stale_data_clear);
>   
> +inline void cpu_mitigation_skip(struct task_struct *prev,
> +				struct task_struct *next)
> +{
> +	bool prev_skip = false, next_skip = false;
> +
> +	if (prev->mm)
> +		prev_skip = task_dfl_cgroup(prev)->cpu_skip_mitigation;
> +	if (next->mm)
> +		next_skip = task_dfl_cgroup(next)->cpu_skip_mitigation;
> +
> +	if (!prev_skip && !next_skip)
> +		return;
> +	if (prev_skip == next_skip)
> +		return;
I believe the first (!prev_skip && !next_skip) check is redundant.
> +
> +	if (next_skip)
> +		wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64_unmitigated);
> +	else
> +		wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64_mitigated);
> +}
> +
>   void __init cpu_select_mitigations(void)
>   {
>   	/*
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index ae04035b6cbe..6a131a62f43c 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -546,6 +546,9 @@ struct cgroup {
>   	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>   #endif
>   
> +	/* Used to bypass the CPU mitigations for tasks in a cgroup */
> +	bool cpu_skip_mitigation;
> +
>   	/* All ancestors including self */
>   	struct cgroup *ancestors[];
>   };
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index c8e4b62b436a..b745dbcb153e 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2045,6 +2045,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
>   	cgrp->dom_cgrp = cgrp;
>   	cgrp->max_descendants = INT_MAX;
>   	cgrp->max_depth = INT_MAX;
> +	cgrp->cpu_skip_mitigation = 0;
>   	INIT_LIST_HEAD(&cgrp->rstat_css_list);
>   	prev_cputime_init(&cgrp->prev_cputime);
>   
> @@ -3751,6 +3752,41 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
>   	return ret;
>   }
>   
> +static int cpu_skip_mitigation_show(struct seq_file *seq, void *v)
> +{
> +	struct cgroup *cgrp = seq_css(seq)->cgroup;
> +	int ret = 0;
> +
> +	seq_printf(seq, "%d\n", cgrp->cpu_skip_mitigation);
> +
> +	return ret;
> +}
> +
> +static ssize_t cgroup_skip_mitigation_write(struct kernfs_open_file *of,
> +					    char *buf, size_t nbytes,
> +					    loff_t off)
> +{
> +	struct cgroup *cgrp = of->kn->parent->priv;
> +	struct cgroup_file_ctx *ctx = of->priv;
> +	u64 skip_mitigation;
> +	int ret;
> +
> +	/* Only privileged user in init namespace is allowed to set skip_mitigation */
> +	if ((ctx->ns != &init_cgroup_ns) || !capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	ret = kstrtoull(buf, 0, &skip_mitigation);
> +	if (ret)
> +		return -EINVAL;
> +
> +	if (skip_mitigation > 1)
> +		return -EINVAL;
> +
> +	cgrp->cpu_skip_mitigation = skip_mitigation;
> +
> +	return nbytes;
> +}
> +
>   static int cpu_local_stat_show(struct seq_file *seq, void *v)
>   {
>   	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
> @@ -5290,6 +5326,12 @@ static struct cftype cgroup_base_files[] = {
>   		.name = "cpu.stat.local",
>   		.seq_show = cpu_local_stat_show,
>   	},
> +	{
> +		.name = "cpu.skip_mitigation",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.seq_show = cpu_skip_mitigation_show,
> +		.write = cgroup_skip_mitigation_write,
> +	},
>   	{ }	/* terminate */
>   };
Since this control knob is effective only for x86_64, should we enable 
this only for this architecture? However, cgroup never has architecture 
specific control knob like that before, it will be the first if we 
decide to do that.
>   
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f3951e4a55e5..4b4109afbf7c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4994,7 +4994,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
>   	fire_sched_out_preempt_notifiers(prev, next);
>   	kmap_local_sched_out();
>   	prepare_task(next);
> -	prepare_arch_switch(next);
> +	prepare_arch_switch(prev, next);
>   }
>   
>   /**
>
The sparc and m68k arches have their own prepare_arch_switch() calls. So 
you will need to modify those places as well.

Cheers,
Longman



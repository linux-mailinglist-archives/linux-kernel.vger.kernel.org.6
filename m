Return-Path: <linux-kernel+bounces-182671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2A8C8E4B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 00:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958E92828D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 22:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A5141991;
	Fri, 17 May 2024 22:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpNhztp8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5S9VG70i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194865C;
	Fri, 17 May 2024 22:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715985571; cv=none; b=bqDr/pEebSJqz0/KhmbLJ2VJtf5efMpX7LYEb25KrmA7R891X6AABHc43OSdUIggm+Av06qd6oghIK99q0SMNpsPpPapFCqwmuWX72n/8kXqXpnQTXLMvrwWy+SxirbJrauWZvj8PGfcxlxkBo0QvYuZojrCWHfW5B5B84jA9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715985571; c=relaxed/simple;
	bh=dwmkQqzGxr+vKWc9tJgSZlFbof9gSL93+XoSgZarOmw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P65/LeNPsbRLJa8BMcr5hQD1qD96dehqqzTCtmCNw/BTljGnR0p889L2UsWXXmPP9k6scH2BGxZ8N+Ogc3C/hfFAg9hwB4SnDm38/JbusUVM+N5X0wGm9oXEwZXQBEszbWtT6hxXdLDW1y2xrcP+x22C2shi4UJKqwqhQydq3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpNhztp8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5S9VG70i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715985567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBFizUSXRil+6EkB+kbveF+jyT7vc6UIxG6Rr+IVgSM=;
	b=ZpNhztp8WiiGG1WJu4hfGYPNQa9RTUUem35SsE064vSJKiwq6Q63LSDdue16xrd7WkNq6h
	80jQlEQW2EwBPSZwErBbTrlN+NVKOKSuIZq7xXENWZ/rLhOZoM6SfieQpxnVd8rmzzDHqU
	+K1ycT9ERA1wloa7I/bKsCy5OSuj8rnrS0vxGKiAi5CDbspg+HcwhrUtHVooWE+YQ50d8x
	fS8DjZtv1Oyg3pVGzQ/S3/19PW7KiTXOtwYQSfDqmc2EyWsHydSAl30KJkCYuaVezQW0rT
	tNulzy6nLWQaLZYW1Wazlw5JTs/eQk8i7mYhfj1t/8WT6bY8ORSlVm9qlcp81w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715985567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BBFizUSXRil+6EkB+kbveF+jyT7vc6UIxG6Rr+IVgSM=;
	b=5S9VG70i0irONM7GUfW/ZJlq8YLA6JMYMr7fJ3g2FMqfAH2ipGNV2Eq0NhqYcr1zdwIag/
	VwGSVfvdjLggSdCg==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 pauld@redhat.com, juri.lelli@redhat.com, prarit@redhat.com,
 vschneid@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Costa
 Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v1 2/7] sched/isolation: Adjust affinity of timers
 according to change of housekeeping cpumask
In-Reply-To: <20240516190437.3545310-3-costa.shul@redhat.com>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-3-costa.shul@redhat.com>
Date: Sat, 18 May 2024 00:39:26 +0200
Message-ID: <875xvcjc69.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, May 16 2024 at 22:04, Costa Shulyupin wrote:
> Adjust affinity timers and watchdog_cpumask according to
> change of housekeeping.cpumasks[HK_TYPE_TIMER] during runtime.

Timers and watchdog are two different things. It's clearly documented
that a patch should change one thing and not combine random stuff.

> watchdog_cpumask is initialized during boot in lockup_detector_init()
> from housekeeping_cpumask(HK_TYPE_TIMER).
>
> lockup_detector_reconfigure() utilizes updated watchdog_cpumask
> via __lockup_detector_reconfigure().

You describe WHAT the patch is doing, but there is no WHY and zero
rationale why this is correct.

> timers_resettle_from_cpu() is blindly prototyped from timers_dead_cpu().
> local_irq_disable is used because cpuhp_thread_fun uses it before
> cpuhp_invoke_callback() call.

I have no idea what this word salad is trying to tell me.

The local_irq_disable() in cpuhp_thread_fun() has absolutely nothing to
do with timers_dead_cpu().

> Core test snippets without infrastructure:
>
> 1. Create timer on specific cpu with:
>
> 	timer_setup(&test_timer, test_timer_cb, TIMER_PINNED);
>         test_timer.expires = KTIME_MAX;
>         add_timer_on(&test_timer, test_cpu);
>
> 2. Call housekeeping_update()
>
> 3. Assure that there is no timers on specified cpu at the end
> of timers_resettle_from_cpu() with:
>
> static int count_timers(int cpu)
> {
> 	struct timer_base *base;
> 	int b, v, count = 0;
>
> 	for (b = 0; b < NR_BASES; b++) {
> 		base = per_cpu_ptr(&timer_bases[b], cpu);
> 		raw_spin_lock_irq(&base->lock);
>
> 		for (v = 0; v < WHEEL_SIZE; v++) {
> 			struct hlist_node *c;
>
> 			hlist_for_each(c, base->vectors + v)
> 				count++;
> 		}
> 		raw_spin_unlock_irq(&base->lock);
> 	}
>
> 	return count;
> }

And that snippet in the change log is magically providing a unit test or what?

> diff --git a/init/Kconfig b/init/Kconfig
> index 72404c1f21577..fac49c6bb965a 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -682,6 +682,7 @@ config CPU_ISOLATION
>  	bool "CPU isolation"
>  	depends on SMP || COMPILE_TEST
>  	default y
> +	select HOTPLUG_CPU

Why?

> +#ifdef CONFIG_LOCKUP_DETECTOR

That ifdef is required because?

> +#include <linux/nmi.h>
> +#endif
> +
>  enum hk_flags {
>  	HK_FLAG_TIMER		= BIT(HK_TYPE_TIMER),
>  	HK_FLAG_RCU		= BIT(HK_TYPE_RCU),
> @@ -116,6 +120,19 @@ static void __init housekeeping_setup_type(enum hk_type type,
>  		     housekeeping_staging);
>  }
>  
> +static void resettle_all_timers(cpumask_var_t enable_mask, cpumask_var_t disable_mask)
> +{
> +	unsigned int cpu;
> +
> +	for_each_cpu(cpu, enable_mask)	{

Pointless bracket

> +		timers_prepare_cpu(cpu);

Seriously? You reset the timer base of an online CPU?

What's the point of this excercise? The timer base is initialized and in
consistent state. The timer base of an isolated CPU can have active
pinned timers on it.

So going there and resetting state without locking is definitely a
brilliant idea.

> +	for_each_cpu(cpu, disable_mask) {
> +		timers_resettle_from_cpu(cpu);
> +	}
> +}
> +
>  /*
>   * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
>   * change.
> @@ -144,6 +161,16 @@ static int housekeeping_update(enum hk_type type, cpumask_var_t update)
>  	if (!static_branch_unlikely(&housekeeping_overridden))
>  		static_key_enable_cpuslocked(&housekeeping_overridden.key);
>  
> +	switch (type) {
> +	case HK_TYPE_TIMER:
> +		resettle_all_timers(&masks->enable, &masks->disable);
> +#ifdef CONFIG_LOCKUP_DETECTOR
> +		cpumask_copy(&watchdog_cpumask, housekeeping_cpumask(HK_TYPE_TIMER));
> +		lockup_detector_reconfigure();
> +#endif

What's wrong with adding a function

void lockup_detector_update_mask(const struct cpumask *msk);

and having an empty stub for it when CONFIG_LOCKUP_DETECTOR=n?

That spares all the ugly ifdeffery and the nmi.h include in one go.

> +		break;
> +	default:
> +	}
>  	kfree(masks);
>  
>  	return 0;
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 48288dd4a102f..2d15c0e7b0550 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -51,6 +51,7 @@
>  #include <asm/div64.h>
>  #include <asm/timex.h>
>  #include <asm/io.h>
> +#include <linux/sched/isolation.h>

What needs this include?
  
>  #include "tick-internal.h"
>  #include "timer_migration.h"
> @@ -2657,6 +2658,47 @@ int timers_prepare_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> +/**
> + * timers_resettle_from_cpu - resettles timers from
> + * specified cpu to housekeeping cpus.
> + */
> +void timers_resettle_from_cpu(unsigned int cpu)
> +{
> +	struct timer_base *old_base;
> +	struct timer_base *new_base;
> +	int b, i;
> +
> +	local_irq_disable();

What for?

> +	for (b = 0; b < NR_BASES; b++) {

You cannot blindly move pinned timers away from a CPU. That's the last
resort which is used in the CPU hotplug case, but the CPU is not going
out in the dynamic change case and the pinned timer might be there for a
reason.

> +		old_base = per_cpu_ptr(&timer_bases[b], cpu);
> +		new_base = per_cpu_ptr(&timer_bases[b],
> +				cpumask_any_and(cpu_active_mask,
> +					housekeeping_cpumask(HK_TYPE_TIMER)));

The cpumask needs to be reevaluted for every base because you blindly
copied the code from timers_dead_cpu(), right?

> +		/*
> +		 * The caller is globally serialized and nobody else
> +		 * takes two locks at once, deadlock is not possible.
> +		 */
> +		raw_spin_lock_irq(&new_base->lock);

Here you disable interrupts again and further down you enable them again
when dropping the lock. So on loop exit this does an imbalanced
local_irq_enable(), no? What's the point of this local_irq_dis/enable()
pair around the loop?



> +		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
> +
> +		/*
> +		 * The current CPUs base clock might be stale. Update it

What guarantees that this is the current CPUs timer base? Nothing...

> +		 * before moving the timers over.
> +		 */
> +		forward_timer_base(new_base);
> +
> +		WARN_ON_ONCE(old_base->running_timer);
> +		old_base->running_timer = NULL;
> +
> +		for (i = 0; i < WHEEL_SIZE; i++)
> +			migrate_timer_list(new_base, old_base->vectors + i);
> +
> +		raw_spin_unlock(&old_base->lock);
> +		raw_spin_unlock_irq(&new_base->lock);
> +	}
> +	local_irq_enable();
> +}

It's absolutely not rocket science to reuse timers_dead_cpu() for this.

The only requirement timers_dead_cpu() has is that the CPU to which the
timers are migrated is not going away. That's already given due to the
hotplug context.

The reason why it uses get_cpu_ptr(), which disables preemption and
therefore migration, is that it want's to avoid moving the timers to a
remote CPU as that has implications vs. NOHZ because it might end up
kicking the remote CPU out of idle.

timers_dead_cpu() could be simply modified to:

void timers_dead_cpu(unsigned int cpu)
{
    migrate_disable();
    timers_migrate_from_cpu(cpu, BASE_LOCAL);
    migrate_enable();
}

and have

#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_ISOLATION)
static void timers_migrate_from_cpu(unsigned int cpu, unsigned int base)
{
        lockdep_assert(migration_disabled());

        for (; base < NR_BASES; base++) {
		old_base = per_cpu_ptr(&timer_bases[b], cpu);
		new_base = this_cpu_ptr(&timer_bases[b]);
        	....
	}
}
#endif

Now that isolation muck just has to do:

    1) Ensure that the CPU it runs on is a housekeeping CPU

    2) Invoke timers_migrate_to_hkcpu(cpu) which is in timer.c

       #ifdef CONFIG_ISOLATION
       void timers_migrate_to_hkcpu(unsigned int cpu)
       {
       		timers_migrate_from_cpu(cpu, BASE_GLOBAL);
       }
       #endif

No?

Thanks,

        tglx


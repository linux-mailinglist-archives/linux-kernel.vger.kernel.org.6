Return-Path: <linux-kernel+bounces-354368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E92993CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F061F24DE4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF2A1DFF8;
	Tue,  8 Oct 2024 02:11:33 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B81388
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728353492; cv=none; b=mSaw/DcGy2m7jCCMF6+NSToPedqEHL8XBC1GjpIzhPL3mGJWdHg0HvbXWr8rIS/qyeuvb2YOYlMTz6OCdHhaN50vmJGrQmbt6Ap1JxmLfY1a5mTng9Gj7yp0DD081ti2zopDKBhASMGIsIsxMnso2Sb8TBFRM4huCMmmd4FA3m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728353492; c=relaxed/simple;
	bh=DckLMg34XwwEYUsi8S0z48K2tISnckvx7UlSqxAWSKk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MfTJgX8Za+S0MdWLvwYDHqvyW/TTqXUtTe9y2OsZcrkrNAfihgtPb0qGU4sRQknzo2/gorsYPta6tMTjbP4CBejrTlb9rtPJfqpg2wm1Ij8DWb4+JJod57rTL3jY8kSdFPgHDZ38COynaf7vZjA0xjmTjEucbLitrjtQXJiTb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XMzwc61FGzpWfl;
	Tue,  8 Oct 2024 10:09:20 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id DF96F14035F;
	Tue,  8 Oct 2024 10:11:20 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Oct 2024 10:11:20 +0800
Subject: Re: [PATCH 1/2] watchdog/hardlockup/perf: Fix perf_event memory leak
To: <tglx@linutronix.de>, <peterz@infradead.org>
CC: <akpm@linux-foundation.org>, <linux@weissschuh.net>, <song@kernel.org>,
	<dianders@chromium.org>, <j.granados@samsung.com>,
	<liusong@linux.alibaba.com>, <lizhe.67@bytedance.com>,
	<yaoma@linux.alibaba.com>, <dzickus@redhat.com>, <mingo@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240913174554.2759064-1-lihuafei1@huawei.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <b7b4f188-d43a-64e3-81c7-00a4ea8f8c57@huawei.com>
Date: Tue, 8 Oct 2024 10:11:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240913174554.2759064-1-lihuafei1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500004.china.huawei.com (7.202.181.242)


Kindly ping, thanks!

On 2024/9/14 1:45, Li Huafei wrote:
> During the stress test, we found a kmemleak report for perf_event:
> 
>   unreferenced object 0xff110001410a33e0 (size 1328):
>     comm "kworker/4:11", pid 288, jiffies 4294916004
>     hex dump (first 32 bytes):
>       b8 be c2 3b 02 00 11 ff 22 01 00 00 00 00 ad de  ...;....".......
>       f0 33 0a 41 01 00 11 ff f0 33 0a 41 01 00 11 ff  .3.A.....3.A....
>     backtrace (crc 24eb7b3a):
>       [<00000000e211b653>] kmem_cache_alloc_node_noprof+0x269/0x2e0
>       [<000000009d0985fa>] perf_event_alloc+0x5f/0xcf0
>       [<00000000084ad4a2>] perf_event_create_kernel_counter+0x38/0x1b0
>       [<00000000fde96401>] hardlockup_detector_event_create+0x50/0xe0
>       [<0000000051183158>] watchdog_hardlockup_enable+0x17/0x70
>       [<00000000ac89727f>] softlockup_start_fn+0x15/0x40
>       ...
> 
> Our stress test includes CPU online and offline, and updating the
> watchdog configuration.  After reading the code, I found that there may
> be a race between cleaning up perf_event after updating watchdog and
> disabling event when the CPU goes offline:
> 
>   CPU0                          CPU1                           CPU2
>   (update watchdog)                                            (hotplug offline CPU1)
> 
>   ...                                                          _cpu_down(CPU1)
>   cpus_read_lock()                                             // waiting for cpu lock
>     softlockup_start_all
>       smp_call_on_cpu(CPU1)
>                                 softlockup_start_fn
>                                 ...
>                                   watchdog_hardlockup_enable(CPU1)
>                                     perf create E1
>                                     watchdog_ev[CPU1] = E1
>   cpus_read_unlock()
>                                                                cpus_write_lock()
>                                                                cpuhp_kick_ap_work(CPU1)
>                                 cpuhp_thread_fun
>                                 ...
>                                   watchdog_hardlockup_disable(CPU1)
>                                     watchdog_ev[CPU1] = NULL
>                                     dead_event[CPU1] = E1
>   __lockup_detector_cleanup
>     for each dead_events_mask
>       release each dead_event
>       /*
>        * CPU1 has not been added to
>        * dead_events_mask, then E1
>        * will not be released
>        */
>                                     CPU1 -> dead_events_mask
>     cpumask_clear(&dead_events_mask)
>     // dead_events_mask is cleared, E1 is leaked
> 
> In this case, the leaked perf_event E1 matches the perf_event leak
> reported by kmemleak. Due to the low probability of problem recurrence
> (only reported once), I added some hack delays in the code:
> 
>   static void __lockup_detector_reconfigure(void)
>   {
>     ...
>           watchdog_hardlockup_start();
>           cpus_read_unlock();
>   +       mdelay(100);
>           /*
>            * Must be called outside the cpus locked section to prevent
>            * recursive locking in the perf code.
>     ...
>   }
> 
>   void watchdog_hardlockup_disable(unsigned int cpu)
>   {
>     ...
>                   perf_event_disable(event);
>                   this_cpu_write(watchdog_ev, NULL);
>                   this_cpu_write(dead_event, event);
>   +               mdelay(100);
>                   cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
>                   atomic_dec(&watchdog_cpus);
>     ...
>   }
> 
>   void hardlockup_detector_perf_cleanup(void)
>   {
>     ...
>                           perf_event_release_kernel(event);
>                   per_cpu(dead_event, cpu) = NULL;
>           }
>   +       mdelay(100);
>           cpumask_clear(&dead_events_mask);
>   }
> 
> Then, simultaneously performing CPU on/off and switching watchdog, it is
> almost certain to reproduce this leak.
> 
> The problem here is that releasing perf_event is not within the CPU
> hotplug read-write lock. The commit 941154bd6937
> ("watchdog/hardlockup/perf: Prevent CPU hotplug deadlock") introduced
> deferred release to solve the deadlock caused by calling
> get_online_cpus() when releasing perf_event. Later, the commit
> efe951d3de91 ("perf/x86: Fix perf,x86,cpuhp deadlock") removed the
> get_online_cpus() call on the perf_event release path to solve another
> deadlock problem.
> 
> Therefore, it is now possible to move the release of perf_event back
> into the CPU hotplug read-write lock, and release the event immediately
> after disabling it.
> 
> Fixes: 941154bd6937 ("watchdog/hardlockup/perf: Prevent CPU hotplug deadlock")
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  include/linux/nmi.h    |  4 ----
>  kernel/cpu.c           |  5 -----
>  kernel/watchdog.c      | 25 -------------------------
>  kernel/watchdog_perf.c | 28 +---------------------------
>  4 files changed, 1 insertion(+), 61 deletions(-)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index a8dfb38c9bb6..e78fa535f61d 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -17,7 +17,6 @@
>  void lockup_detector_init(void);
>  void lockup_detector_retry_init(void);
>  void lockup_detector_soft_poweroff(void);
> -void lockup_detector_cleanup(void);
>  
>  extern int watchdog_user_enabled;
>  extern int watchdog_thresh;
> @@ -37,7 +36,6 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
>  static inline void lockup_detector_init(void) { }
>  static inline void lockup_detector_retry_init(void) { }
>  static inline void lockup_detector_soft_poweroff(void) { }
> -static inline void lockup_detector_cleanup(void) { }
>  #endif /* !CONFIG_LOCKUP_DETECTOR */
>  
>  #ifdef CONFIG_SOFTLOCKUP_DETECTOR
> @@ -104,12 +102,10 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
>  #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
>  extern void hardlockup_detector_perf_stop(void);
>  extern void hardlockup_detector_perf_restart(void);
> -extern void hardlockup_detector_perf_cleanup(void);
>  extern void hardlockup_config_perf_event(const char *str);
>  #else
>  static inline void hardlockup_detector_perf_stop(void) { }
>  static inline void hardlockup_detector_perf_restart(void) { }
> -static inline void hardlockup_detector_perf_cleanup(void) { }
>  static inline void hardlockup_config_perf_event(const char *str) { }
>  #endif
>  
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index b1fd2a3db91a..19d9ddb61e0d 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1452,11 +1452,6 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>  
>  out:
>  	cpus_write_unlock();
> -	/*
> -	 * Do post unplug cleanup. This is still protected against
> -	 * concurrent CPU hotplug via cpu_add_remove_lock.
> -	 */
> -	lockup_detector_cleanup();
>  	arch_smt_update();
>  	return ret;
>  }
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 830a83895493..1935b40813bc 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -347,8 +347,6 @@ static int __init watchdog_thresh_setup(char *str)
>  }
>  __setup("watchdog_thresh=", watchdog_thresh_setup);
>  
> -static void __lockup_detector_cleanup(void);
> -
>  #ifdef CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM
>  enum stats_per_group {
>  	STATS_SYSTEM,
> @@ -878,11 +876,6 @@ static void __lockup_detector_reconfigure(void)
>  
>  	watchdog_hardlockup_start();
>  	cpus_read_unlock();
> -	/*
> -	 * Must be called outside the cpus locked section to prevent
> -	 * recursive locking in the perf code.
> -	 */
> -	__lockup_detector_cleanup();
>  }
>  
>  void lockup_detector_reconfigure(void)
> @@ -932,24 +925,6 @@ static inline void lockup_detector_setup(void)
>  }
>  #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
>  
> -static void __lockup_detector_cleanup(void)
> -{
> -	lockdep_assert_held(&watchdog_mutex);
> -	hardlockup_detector_perf_cleanup();
> -}
> -
> -/**
> - * lockup_detector_cleanup - Cleanup after cpu hotplug or sysctl changes
> - *
> - * Caller must not hold the cpu hotplug rwsem.
> - */
> -void lockup_detector_cleanup(void)
> -{
> -	mutex_lock(&watchdog_mutex);
> -	__lockup_detector_cleanup();
> -	mutex_unlock(&watchdog_mutex);
> -}
> -
>  /**
>   * lockup_detector_soft_poweroff - Interface to stop lockup detector(s)
>   *
> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
> index 59c1d86a73a2..2fdb96eaf493 100644
> --- a/kernel/watchdog_perf.c
> +++ b/kernel/watchdog_perf.c
> @@ -21,8 +21,6 @@
>  #include <linux/perf_event.h>
>  
>  static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
> -static DEFINE_PER_CPU(struct perf_event *, dead_event);
> -static struct cpumask dead_events_mask;
>  
>  static atomic_t watchdog_cpus = ATOMIC_INIT(0);
>  
> @@ -181,36 +179,12 @@ void watchdog_hardlockup_disable(unsigned int cpu)
>  
>  	if (event) {
>  		perf_event_disable(event);
> +		perf_event_release_kernel(event);
>  		this_cpu_write(watchdog_ev, NULL);
> -		this_cpu_write(dead_event, event);
> -		cpumask_set_cpu(smp_processor_id(), &dead_events_mask);
>  		atomic_dec(&watchdog_cpus);
>  	}
>  }
>  
> -/**
> - * hardlockup_detector_perf_cleanup - Cleanup disabled events and destroy them
> - *
> - * Called from lockup_detector_cleanup(). Serialized by the caller.
> - */
> -void hardlockup_detector_perf_cleanup(void)
> -{
> -	int cpu;
> -
> -	for_each_cpu(cpu, &dead_events_mask) {
> -		struct perf_event *event = per_cpu(dead_event, cpu);
> -
> -		/*
> -		 * Required because for_each_cpu() reports  unconditionally
> -		 * CPU0 as set on UP kernels. Sigh.
> -		 */
> -		if (event)
> -			perf_event_release_kernel(event);
> -		per_cpu(dead_event, cpu) = NULL;
> -	}
> -	cpumask_clear(&dead_events_mask);
> -}
> -
>  /**
>   * hardlockup_detector_perf_stop - Globally stop watchdog events
>   *
> 


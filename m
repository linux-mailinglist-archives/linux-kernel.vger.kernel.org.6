Return-Path: <linux-kernel+bounces-273786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBEE946E12
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 11:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BFBEB2199D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791692E3EB;
	Sun,  4 Aug 2024 09:48:50 +0000 (UTC)
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB42D225A8
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722764929; cv=none; b=MRlyCgWo0zJ9FZy1W2LFCtQtCXlQjkfoWgPRWM2iAQHjqC2JWA1/ZN8XWokUfP+sNS88fD130WZKSWWeAQYfBMerAktUmMViLXhgEvBqwODfIsIrO4KOnY2yH9vMiCIlwFbKyW8qm5Aqgs68HFOT4FDbnFHmtiSdq/63lyom06E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722764929; c=relaxed/simple;
	bh=0wwXUbBMf2EYodd3WDlVkTkV/vISnnhDv7ar/WjH+Tg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=riEQa+w2eX6W6yu9MAa3Tmlf3NvJAvuk1HYG9YLV2QK/4KIphq8lz6bQjuqOtSsDV711HIIaV4lvw2dcA3EBDe9s31p4sjHKZJU9uBi1S3+u/G1DzUywtRNzZeIgCnOWUzuhNIn0TlkN7v3vqE4Mu8GS1OlhoszVk09SKuf0/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4749mAQ6003904;
	Sun, 4 Aug 2024 18:48:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sun, 04 Aug 2024 18:48:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4749mApD003899
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 4 Aug 2024 18:48:10 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <74cdf283-cc4f-40e7-9cee-a90939eba38d@I-love.SAKURA.ne.jp>
Date: Sun, 4 Aug 2024 18:48:10 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] profiling: remove profile=sleep support
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The kernel sleep profile is no longer working due to a recursive locking
bug introduced by commit 42a20f86dc19 ("sched: Add wrapper for get_wchan()
to keep task blocked"); either booting with

  profile=sleep

kernel command line option added or executing

  # echo -n sleep > /sys/kernel/profiling

after boot causes the system to lock up.


  ============================================
  WARNING: possible recursive locking detected
  5.15.0-rc4+ #104 Not tainted
  --------------------------------------------
  kthreadd/3 is trying to acquire lock:
  ffff93ac82e08d58 (&p->pi_lock){....}-{2:2}, at: get_wchan+0x32/0x70

  but task is already holding lock:
  ffff93ac82e08d58 (&p->pi_lock){....}-{2:2}, at: try_to_wake_up+0x53/0x370

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&p->pi_lock);
    lock(&p->pi_lock);

   *** DEADLOCK ***

   May be due to missing lock nesting notation

  3 locks held by kthreadd/3:
   #0: ffffae5ac2833d68 (&x->wait){....}-{2:2}, at: complete+0x18/0x40
   #1: ffff93ac82e08d58 (&p->pi_lock){....}-{2:2}, at: try_to_wake_up+0x53/0x370
   #2: ffff93ad29fe9458 (&rq->__lock){-...}-{2:2}, at: try_to_wake_up+0x19f/0x370

  stack backtrace:
  CPU: 0 PID: 3 Comm: kthreadd Not tainted 5.15.0-rc4+ #104
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
  Call Trace:
   dump_stack_lvl+0x57/0x72
   validate_chain.cold+0x122/0x127
   __lock_acquire+0x4d2/0x930
   lock_acquire+0xc8/0x2f0
   ? get_wchan+0x32/0x70
   ? rcu_read_lock_sched_held+0x3f/0x80
   _raw_spin_lock_irq+0x47/0x90
   ? get_wchan+0x32/0x70
   get_wchan+0x32/0x70
   __update_stats_enqueue_sleeper+0x151/0x430
   enqueue_entity+0x4b0/0x520
   enqueue_task_fair+0x92/0x6b0
   ? lock_is_held_type+0xa7/0x120
   ttwu_do_activate+0x73/0x140
   try_to_wake_up+0x213/0x370
   swake_up_locked+0x20/0x50
   complete+0x2f/0x40
   ? __cancel_work_timer+0x1b0/0x1b0
   kthread+0xfb/0x180
   ? set_kthread_struct+0x40/0x40
   ret_from_fork+0x22/0x30


However, since nobody noticed this regression for more than 2 years, let's
remove profile=sleep support based on an assumption that nobody needs this
functionality.

Fixes: 42a20f86dc19 ("sched: Add wrapper for get_wchan() to keep task blocked")
Cc: stable@vger.kernel.org # v5.16+
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Some distro kernel (e.g. 5.14.0-427.28.1.el9_4.x86_64) includes that commit.
I hope that distro agrees with removing this functionality...

 Documentation/admin-guide/kernel-parameters.txt |  4 +---
 include/linux/profile.h                         |  1 -
 kernel/profile.c                                | 11 +----------
 kernel/sched/stats.c                            | 10 ----------
 4 files changed, 2 insertions(+), 24 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1384c7b59c9..09126bb8cc9f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4798,11 +4798,9 @@
 
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			Format: [<profiletype>,]<number>
-			Param: <profiletype>: "schedule", "sleep", or "kvm"
+			Param: <profiletype>: "schedule" or "kvm"
 				[defaults to kernel profiling]
 			Param: "schedule" - profile schedule points.
-			Param: "sleep" - profile D-state sleeping (millisecs).
-				Requires CONFIG_SCHEDSTATS
 			Param: "kvm" - profile VM exits.
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
diff --git a/include/linux/profile.h b/include/linux/profile.h
index 2fb487f61d12..3f53cdb0c27c 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -10,7 +10,6 @@
 
 #define CPU_PROFILING	1
 #define SCHED_PROFILING	2
-#define SLEEP_PROFILING	3
 #define KVM_PROFILING	4
 
 struct proc_dir_entry;
diff --git a/kernel/profile.c b/kernel/profile.c
index ff68d3816182..1fcf1adcf4eb 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -50,20 +50,11 @@ EXPORT_SYMBOL_GPL(prof_on);
 int profile_setup(char *str)
 {
 	static const char schedstr[] = "schedule";
-	static const char sleepstr[] = "sleep";
 	static const char kvmstr[] = "kvm";
 	const char *select = NULL;
 	int par;
 
-	if (!strncmp(str, sleepstr, strlen(sleepstr))) {
-#ifdef CONFIG_SCHEDSTATS
-		force_schedstat_enabled();
-		prof_on = SLEEP_PROFILING;
-		select = sleepstr;
-#else
-		pr_warn("kernel sleep profiling requires CONFIG_SCHEDSTATS\n");
-#endif /* CONFIG_SCHEDSTATS */
-	} else if (!strncmp(str, schedstr, strlen(schedstr))) {
+	if (!strncmp(str, schedstr, strlen(schedstr))) {
 		prof_on = SCHED_PROFILING;
 		select = schedstr;
 	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 78e48f5426ee..eb0cdcd4d921 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -92,16 +92,6 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
 
 			trace_sched_stat_blocked(p, delta);
 
-			/*
-			 * Blocking time is in units of nanosecs, so shift by
-			 * 20 to get a milliseconds-range estimation of the
-			 * amount of time that the task spent sleeping:
-			 */
-			if (unlikely(prof_on == SLEEP_PROFILING)) {
-				profile_hits(SLEEP_PROFILING,
-					     (void *)get_wchan(p),
-					     delta >> 20);
-			}
 			account_scheduler_latency(p, delta >> 10, 0);
 		}
 	}
-- 
2.43.5


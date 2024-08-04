Return-Path: <linux-kernel+bounces-273860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41955946EF0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585CDB21FA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03813D88E;
	Sun,  4 Aug 2024 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cmT8DpDu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ba5f2GzD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B413D529
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722776580; cv=none; b=S3upjntQSxc2cLl427Y9+hWD5zrSGkEX+IkkhzklWbbzTznrvsWztPPAyXzQNbi9CicjmiPF2V55qVtGbqO1B5sAWjkVMtbAPCgp39hh7RmX83N5RQQUoGhhFwD31iOFItxtu4EiPCkfRfPfmHoHC9i1MZQ/qjeqAs+ZkZOi7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722776580; c=relaxed/simple;
	bh=uSpiyX9WQ3ij3WnRCaJJnQl0eVJv17GWwxWE1Y7lkc8=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=WyggVYvOZyrxO61U3IKLjhigRmmtCyyUin0T+Mf21zNqZ+apzKXbbg9pKJE5xAfzjRRKy5FPocpO3YEEOGcp9gt4bciXNwxwYXLU/P0VoiLwNJYJsqBv3xzDvrfEK0Bhoe4FBJ8yuNI9TFqpzug6JTuD5kbEIn5GVQYKF+81tXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cmT8DpDu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ba5f2GzD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722776577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=RaWAqx8f0PseViWtkNAwU8w6sMCjrkZvibn03CFbUoA=;
	b=cmT8DpDu/dXknZDfzlUbmQrgnz5SO3smFbQRkX+4M1CIcLnu+/LlfErOglUIjun1RG+Api
	Qmbi89q7K0vXKsVQnPiApRl9fcgnDuaTM2IuP4xFFLXvhWQ61WeDwNShXPFZbx/EAxHEwE
	zkTsls1s1RSU7KA7EQ4aNCMAfTFOELLq7VYWcAQr6Hqm9fXAARiAEgTAzF+dKWkHYEmvVR
	vESKZsYKqSeJNh+yDCduaHwd5b41DPqM+fd+d6kFN2530AkW/hfnlaTAFdFpjAe8/tDxo8
	nsXE2R54Zdm8mQmz+tQCQXRx2J7d88JB5HJMPepAPYHFTpDCuzvSCVNYsnEBkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722776577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=RaWAqx8f0PseViWtkNAwU8w6sMCjrkZvibn03CFbUoA=;
	b=Ba5f2GzDV/AhhYqasb8kd48ROaEqlwGGqLhsuB/SBOPWuaH0Lh0ejj6GiXI/2iofl26qlF
	j8CH60fj3bZXmrCw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v6.11-rc2
References: <172277654174.866296.10517632866315552419.tglx@xen13>
Message-ID: <172277654633.866296.14995229844387120847.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun,  4 Aug 2024 15:02:57 +0200 (CEST)

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
4-08-04

up to:  fe7a11c78d2a: sched/core: Fix unbalance set_rq_online/offline() in sc=
hed_cpu_deactivate()


Scheduler fixes:

   - When stime is larger than rtime due to accounting imprecision, then
     utime =3D rtime - stime becomes negative. As this is unsigned math, the
     result becomes a huge positive number. Cure it by resetting stime to
     rtime in that case, so utime becomes 0.

   - Restore consistent state when sched_cpu_deactivate() fails.

     When offlining a CPU fails in sched_cpu_deactivate() after the SMT
     present counter has been decremented, then the function aborts but
     fails to increment the SMT present counter and leaves it imbalanced.
     Consecutive operations cause it to underflow. Add the missing fixup
     for the error path.

     As SMT accounting the runqueue needs to marked online again in the
     error exit path to restore consistent state.

Thanks,

	tglx

------------------>
Yang Yingliang (4):
      sched/smt: Introduce sched_smt_present_inc/dec() helper
      sched/smt: Fix unbalance sched_smt_present dec/inc
      sched/core: Introduce sched_set_rq_on/offline() helper
      sched/core: Fix unbalance set_rq_online/offline() in sched_cpu_deactiva=
te()

Zheng Zucheng (1):
      sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime


 kernel/sched/core.c    | 68 ++++++++++++++++++++++++++++++++++--------------=
--
 kernel/sched/cputime.c |  6 +++++
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a9f655025607..f3951e4a55e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7845,6 +7845,30 @@ void set_rq_offline(struct rq *rq)
 	}
 }
=20
+static inline void sched_set_rq_online(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_online(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
+static inline void sched_set_rq_offline(struct rq *rq, int cpu)
+{
+	struct rq_flags rf;
+
+	rq_lock_irqsave(rq, &rf);
+	if (rq->rd) {
+		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
+		set_rq_offline(rq);
+	}
+	rq_unlock_irqrestore(rq, &rf);
+}
+
 /*
  * used to mark begin/end of suspend/resume:
  */
@@ -7895,10 +7919,25 @@ static int cpuset_cpu_inactive(unsigned int cpu)
 	return 0;
 }
=20
+static inline void sched_smt_present_inc(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) =3D=3D 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
+#endif
+}
+
+static inline void sched_smt_present_dec(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) =3D=3D 2)
+		static_branch_dec_cpuslocked(&sched_smt_present);
+#endif
+}
+
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq =3D cpu_rq(cpu);
-	struct rq_flags rf;
=20
 	/*
 	 * Clear the balance_push callback and prepare to schedule
@@ -7906,13 +7945,10 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	balance_push_set(cpu, false);
=20
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) =3D=3D 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
-#endif
+	sched_smt_present_inc(cpu);
 	set_cpu_active(cpu, true);
=20
 	if (sched_smp_initialized) {
@@ -7930,12 +7966,7 @@ int sched_cpu_activate(unsigned int cpu)
 	 * 2) At runtime, if cpuset_cpu_active() fails to rebuild the
 	 *    domains.
 	 */
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_online(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_online(rq, cpu);
=20
 	return 0;
 }
@@ -7943,7 +7974,6 @@ int sched_cpu_activate(unsigned int cpu)
 int sched_cpu_deactivate(unsigned int cpu)
 {
 	struct rq *rq =3D cpu_rq(cpu);
-	struct rq_flags rf;
 	int ret;
=20
 	/*
@@ -7974,20 +8004,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 	 */
 	synchronize_rcu();
=20
-	rq_lock_irqsave(rq, &rf);
-	if (rq->rd) {
-		BUG_ON(!cpumask_test_cpu(cpu, rq->rd->span));
-		set_rq_offline(rq);
-	}
-	rq_unlock_irqrestore(rq, &rf);
+	sched_set_rq_offline(rq, cpu);
=20
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) =3D=3D 2)
-		static_branch_dec_cpuslocked(&sched_smt_present);
+	sched_smt_present_dec(cpu);
=20
+#ifdef CONFIG_SCHED_SMT
 	sched_core_cpu_deactivate(cpu);
 #endif
=20
@@ -7997,6 +8021,8 @@ int sched_cpu_deactivate(unsigned int cpu)
 	sched_update_numa(cpu, false);
 	ret =3D cpuset_cpu_inactive(cpu);
 	if (ret) {
+		sched_smt_present_inc(cpu);
+		sched_set_rq_online(rq, cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index a5e00293ae43..0bed0fa1acd9 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -582,6 +582,12 @@ void cputime_adjust(struct task_cputime *curr, struct pr=
ev_cputime *prev,
 	}
=20
 	stime =3D mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	/*
+	 * Because mul_u64_u64_div_u64() can approximate on some
+	 * achitectures; enforce the constraint that: a*b/(b+c) <=3D a.
+	 */
+	if (unlikely(stime > rtime))
+		stime =3D rtime;
=20
 update:
 	/*



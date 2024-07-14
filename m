Return-Path: <linux-kernel+bounces-251922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE68A930BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E02391C21838
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF511411E9;
	Sun, 14 Jul 2024 20:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VXzyt86m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8RmzXdp4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E913D601
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990212; cv=none; b=BtxAJ2dpe87cyMPTthvwXonU0E3JkjXhrlz/Q1EOcE4g/U06/tggeUVO+8xbd8NNHLArh0nO5pYeCoKYNn5L2Sje3JNqzciojU4oreNwA3dGyrnBs8uwUI9qK/qa0yLE5nUMbFbpSRl9gazIG413HBx2Bln5rLlsHL7WE92CnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990212; c=relaxed/simple;
	bh=tW0YPM1eYLzYbyUKaaq/Wt4ukCBacXs7oEzPzIXl8O8=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=iBAa6KpTFfE5dO+32MPBxhU+ljNHvMlCTGzaME/a3UhGvulogvEhLoSSTwY9nuVLcLT1aN1TWNdKHm8xa0ers+8ZPZZndNuk3etMe7yJRL3jfwwgJOKuV5VhmMwdcX5UkyhRv6+SJNgtKSo2r8k3nopxn5kSW0ZeKdcIQP/8p54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VXzyt86m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8RmzXdp4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720990209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gEa0FWTL9RtU5AtpSTge7k5FKqImAG72dTxW6+843kg=;
	b=VXzyt86mY7Jugf3O8A/KcP390vOuETzSfjQqu/Y6Vsozf7W7N+fYDsRkaR3zOPMzPNf0BP
	gv5yWkp91MOFJ68+DkkG7K8zgw4geMN/q6NVGTGpw1Z3muoP6zY/qKYvXs2JeRVOQrpie+
	3UvwAHF0A1VViW+CYmxE7HHukkKBKbjkTAfc3dkG1gMmXZriU+bgS20l1DHbUVKfzaKYZe
	zQcO6LYEiHUUD0EtXcdGR5cmZIHhe3TPHCIIkbfUdWJeiQxl9z5dkcGlCFOK1a4mYsFqOV
	GIcqlsKhcA8U/WG9tcC7AMVwfrCVri8ScX8RbsgQSaNPjcGJ7fG2RElxyhjnXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720990209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=gEa0FWTL9RtU5AtpSTge7k5FKqImAG72dTxW6+843kg=;
	b=8RmzXdp4fyp2cCbsYq+NGJmGuhejWHG2SqVznqjIdXFpftPsX2C9Q6Wl0dwSeqJpYcXtCR
	/DIfdur84H+Dq2Bg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.11-rc1
References: <172099001487.1942258.17671805941963584080.tglx@xen13>
Message-ID: <172099001823.1942258.3381470277418419084.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 14 Jul 2024 22:50:08 +0200 (CEST)

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-07=
-14

up to:  77aeb1b685f9: smp: Add missing destroy_work_on_stack() call in smp_ca=
ll_on_cpu()

A small set of SMP/CPU hotplug updates:

  - Reverse the order of iteration when freezing secondary CPUs for
    hibernation.

    This avoids that drivers like the Intel uncore performance counter have
    to transfer the assignement of handling the per package uncore events
    for every CPU in a package, which is a considerable speedup on larger
    systems.

  - Add a missing destroy_work_on_stack() invocation in smp_call_on_cpu()
    to prevent debug objects to emit a false positive warning when the
    stack is freed.

  - Small cleanups in comments and a str_plural() conversion

Thanks,

	tglx

------------------>
Costa Shulyupin (1):
      cpu/hotplug: Fix typo in comment

Stanislav Spassov (1):
      cpu/hotplug: Reverse order of iteration in freeze_secondary_cpus()

Thorsten Blum (1):
      smp: Use str_plural() to fix Coccinelle warnings

Zqiang (1):
      smp: Add missing destroy_work_on_stack() call in smp_call_on_cpu()


 include/linux/cpuhotplug.h | 2 +-
 kernel/cpu.c               | 4 ++--
 kernel/smp.c               | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 7a5785f405b6..7f6c820c12eb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -27,7 +27,7 @@
  * startup callbacks sequentially from CPUHP_OFFLINE + 1 to CPUHP_ONLINE
  * during a CPU online operation. During a CPU offline operation the
  * installed teardown callbacks are invoked in the reverse order from
- * CPU_ONLINE - 1 down to CPUHP_OFFLINE.
+ * CPUHP_ONLINE - 1 down to CPUHP_OFFLINE.
  *
  * The state space has three sections: PREPARE, STARTING and ONLINE.
  *
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d6c28b..1979a9935719 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1891,8 +1891,8 @@ int freeze_secondary_cpus(int primary)
 	cpumask_clear(frozen_cpus);
=20
 	pr_info("Disabling non-boot CPUs ...\n");
-	for_each_online_cpu(cpu) {
-		if (cpu =3D=3D primary)
+	for (cpu =3D nr_cpu_ids - 1; cpu >=3D 0; cpu--) {
+		if (!cpu_online(cpu) || cpu =3D=3D primary)
 			continue;
=20
 		if (pm_wakeup_pending()) {
diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..aaffecdad319 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -25,6 +25,7 @@
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
 #include <linux/jump_label.h>
+#include <linux/string_choices.h>
=20
 #include <trace/events/ipi.h>
 #define CREATE_TRACE_POINTS
@@ -982,8 +983,7 @@ void __init smp_init(void)
 	num_nodes =3D num_online_nodes();
 	num_cpus  =3D num_online_cpus();
 	pr_info("Brought up %d node%s, %d CPU%s\n",
-		num_nodes, (num_nodes > 1 ? "s" : ""),
-		num_cpus,  (num_cpus  > 1 ? "s" : ""));
+		num_nodes, str_plural(num_nodes), num_cpus, str_plural(num_cpus));
=20
 	/* Any cleanup work */
 	smp_cpus_done(setup_max_cpus);
@@ -1119,6 +1119,7 @@ int smp_call_on_cpu(unsigned int cpu, int (*func)(void =
*), void *par, bool phys)
=20
 	queue_work_on(cpu, system_wq, &sscs.work);
 	wait_for_completion(&sscs.done);
+	destroy_work_on_stack(&sscs.work);
=20
 	return sscs.ret;
 }



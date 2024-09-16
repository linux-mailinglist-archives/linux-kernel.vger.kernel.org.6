Return-Path: <linux-kernel+bounces-330346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F76979CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AFD281D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F0E1474BF;
	Mon, 16 Sep 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+rw9OBV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tppv5E2a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59D1448C7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726475927; cv=none; b=NO2CB1pO1jaSSabhxofVfrKFy1Y/cpXWNppWnO6VmaNzWIFhZRhlq2iPm/3GgjV1RJLJ+jWgkhPcvqMLyKVPkw3X1rPnxfBpBvkA43MTtjXxmzjJ1awtmBCShMQBdzPAw2veAKDQq/vlIdcza710qU4Wf8bJtOX6GEpEixBXzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726475927; c=relaxed/simple;
	bh=AvdhLwulxq6k/+YWHP0A33LQAY0l7PceU50OcuY5XkU=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=uZkB/plqEKtMw0wIKu8QUWnkWvT1qj+J6d7nPZjy97ztGBgVCbKzsuN8X5d3GVB2neUSzSA21QMeSAkI33nLIydVfl+vmHCL6NG6pzunbWlaSEYmXgPnYnxoQsBINARWTJhyW4oVGMSPl6nbVKpYuvMBLk866rl46tsQiaSWiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+rw9OBV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tppv5E2a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726475918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=s+WeCSPpvK8tuxW5BLctlt7CA+xrWMFzPPDJy66ZJiI=;
	b=g+rw9OBVd2eaaRzDGDcSNoH4NEXWCvVhaUzA9KTcpg+nsKJC62t9iaBpsLnulVUMmobxPd
	4nXuC8c/c5Oq5OZK0lI+8cfjvHwnHb5BAIUb6A2xZzDltn4tz8egpWZ8T3KhscsHpvi2IB
	wE0suNUPEEdeIcwR0cSFqVxexO6YC6wVJi+eJ2hKZgAM5KNFw+J4JqOOUlydS5rrI3k8Ti
	ZHwQYI3ajhOyDkIGRgWcEfww2vM5HO7fDDkbRXJGl2+tMWhpqRFobAa9ZWY+LLFV3wKcVI
	Avv1c5qDL54cuTVAc+cJ4TBibEPathX8unNEKeMMKnwPqzfczPK1CZt9PPtyAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726475918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=s+WeCSPpvK8tuxW5BLctlt7CA+xrWMFzPPDJy66ZJiI=;
	b=Tppv5E2aMYaDr5XPDf+eyvfw5f1PWLUumQZXvluVL8LyfSSgbBRhDoM7eOuAkfHa6GPYXM
	dc6WhC2DEkahoiAw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v6.12-rc1
References: <172647588843.2450257.3544233832195550173.tglx@xen13>
Message-ID: <172647589238.2450257.17734472985835252214.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Sep 2024 10:38:37 +0200 (CEST)

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2024-09=
-16

up to:  1d07085402d1: smp: Mark smp_prepare_boot_cpu() __init

A set of updates for CPU hotplug:

  - Prepare the core for supporting parallel hotplug on loongarch

  - A small set of cleanups and enhancements


Thanks,

	tglx

------------------>
Bibo Mao (1):
      smp: Mark smp_prepare_boot_cpu() __init

Jiaxun Yang (2):
      cpu/hotplug: Make HOTPLUG_PARALLEL independent of HOTPLUG_SMT
      cpu/hotplug: Provide weak fallback for arch_cpuhp_init_parallel_bringup=
()

Thorsten Blum (1):
      cpu: Fix W=3D1 build kernel-doc warning


 arch/loongarch/kernel/smp.c |  2 +-
 arch/mips/kernel/smp.c      |  2 +-
 arch/powerpc/kernel/smp.c   |  2 +-
 include/linux/smp.h         |  2 +-
 kernel/cpu.c                | 20 +++++++++++++++++---
 5 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aae..be2655c4c414 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -476,7 +476,7 @@ core_initcall(ipi_pm_init);
 #endif
=20
 /* Preload SMP state for boot cpu */
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	unsigned int cpu, node, rr_node;
=20
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 0362fc5df7b0..39e193cad2b9 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -439,7 +439,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 }
=20
 /* preload SMP state for boot cpu */
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	if (mp_ops->prepare_boot_cpu)
 		mp_ops->prepare_boot_cpu();
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 46e6d2cd7a2d..4ab9b8cee77a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1166,7 +1166,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	cpu_smt_set_num_threads(num_threads, threads_per_core);
 }
=20
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() !=3D boot_cpuid);
 #ifdef CONFIG_PPC64
diff --git a/include/linux/smp.h b/include/linux/smp.h
index fcd61dfe2af3..6a0813c905d0 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -109,7 +109,7 @@ static inline void on_each_cpu_cond(smp_cond_func_t cond_=
func,
  * Architecture specific boot CPU setup.  Defined as empty weak function in
  * init/main.c. Architectures can override it.
  */
-void smp_prepare_boot_cpu(void);
+void __init smp_prepare_boot_cpu(void);
=20
 #ifdef CONFIG_SMP
=20
diff --git a/kernel/cpu.c b/kernel/cpu.c
index b1fd2a3db91a..0c9c5dfc8ddd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1808,6 +1808,7 @@ static int __init parallel_bringup_parse_param(char *ar=
g)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
=20
+#ifdef CONFIG_HOTPLUG_SMT
 static inline bool cpuhp_smt_aware(void)
 {
 	return cpu_smt_max_threads > 1;
@@ -1817,6 +1818,21 @@ static inline const struct cpumask *cpuhp_get_primary_=
thread_mask(void)
 {
 	return cpu_primary_thread_mask;
 }
+#else
+static inline bool cpuhp_smt_aware(void)
+{
+	return false;
+}
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_none_mask;
+}
+#endif
+
+bool __weak arch_cpuhp_init_parallel_bringup(void)
+{
+	return true;
+}
=20
 /*
  * On architectures which have enabled parallel bringup this invokes all BP
@@ -2689,9 +2705,7 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	return ret;
 }
=20
-/**
- * Check if the core a CPU belongs to is online
- */
+/* Check if the core a CPU belongs to is online */
 #if !defined(topology_is_core_online)
 static inline bool topology_is_core_online(unsigned int cpu)
 {



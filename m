Return-Path: <linux-kernel+bounces-274253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E119475B1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 09:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C05C280EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 07:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A0E149002;
	Mon,  5 Aug 2024 07:04:27 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE31109
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 07:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722841467; cv=none; b=KL8yuxelR5bTOShvuMwl3wGR4+0V11WkPZsacevgyRunChuIBWIq3mHOMPYrL4inMgCF/gA5Ub+n2jAW/yq7IH0lMc7yZ6+Xbmkk/yANQ0pqA4Q2289iEsXt5aQwu0JfJOdup0KeVRViCokaWqu/2LD7VjmiM2Jq+IhiLh72pOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722841467; c=relaxed/simple;
	bh=2mNWrBMK3046AA0XIucMZqgzSwWAIoN1FJargcgfnfI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nsFPnv0CeGCswigjSSS9/MuCqBzuPfM48jPtZC2VK/H+DhOVorB14q4BzHQ+Lbv5qS/yFgmDrAkmSoOD9dVuWLMJndkv6I8kBV85EyABlET5fn+EgKhqwFykPJJRDXUE0dAQmlzTaAmx3zMeZMBVcsbW+y7ceo69W8wVw0Lr7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxSup2ebBmx+EHAA--.26978S3;
	Mon, 05 Aug 2024 15:04:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCxwuF1ebBmfhwEAA--.21706S2;
	Mon, 05 Aug 2024 15:04:21 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v2] LoongArch: Revert qspinlock to test-and-set simple lock on VM
Date: Mon,  5 Aug 2024 15:04:21 +0800
Message-Id: <20240805070421.574500-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxwuF1ebBmfhwEAA--.21706S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Similar with x86, when VM is detected, revert to a simple test-and-set
lock to avoid the horrors of queue preemption.

Tested on 3C5000 Dual-way machine with 32 cores and 2 numa nodes,
test case is kcbench on kernel mainline 6.10, the detailed command is
"kcbench --src /root/src/linux"

Performance on host machine
                      kernel compile time       performance impact
   Original           150.29 seconds
   With patch         150.19 seconds            almost no impact

Performance on virtual machine:
1. 1 VM with 32 vCPUs and 2 numa node, numa node pinned
                      kernel compile time       performance impact
   Original           170.87 seconds
   With patch         171.73 seconds            almost no impact

2. 2 VMs, each VM with 32 vCPUs and 2 numa node, numa node pinned
                      kernel compile time       performance impact
   Original           2362.04 seconds
   With patch         354.73  seconds            +565%

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Define static key virt_spin_lock_key as false by default
  2. Add prefix __init with function smp_prepare_boot_cpu(), since there
is prefix __init with called function pv_spinlock_init().
---
 arch/loongarch/include/asm/Kbuild      |  1 -
 arch/loongarch/include/asm/paravirt.h  |  3 ++
 arch/loongarch/include/asm/qspinlock.h | 40 ++++++++++++++++++++++++++
 arch/loongarch/kernel/paravirt.c       |  9 ++++++
 arch/loongarch/kernel/setup.c          |  5 ++++
 arch/loongarch/kernel/smp.c            |  4 ++-
 6 files changed, 60 insertions(+), 2 deletions(-)
 create mode 100644 arch/loongarch/include/asm/qspinlock.h

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 2bb3676429c0..4635b755b2b4 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -6,7 +6,6 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
-generic-y += qspinlock.h
 generic-y += user.h
 generic-y += ioctl.h
 generic-y += statfs.h
diff --git a/arch/loongarch/include/asm/paravirt.h b/arch/loongarch/include/asm/paravirt.h
index dddec49671ae..dcc2b46d31fe 100644
--- a/arch/loongarch/include/asm/paravirt.h
+++ b/arch/loongarch/include/asm/paravirt.h
@@ -19,6 +19,7 @@ static inline u64 paravirt_steal_clock(int cpu)
 
 int __init pv_ipi_init(void);
 int __init pv_time_init(void);
+void __init pv_spinlock_init(void);
 
 #else
 
@@ -31,5 +32,7 @@ static inline int pv_time_init(void)
 {
 	return 0;
 }
+
+static inline void pv_spinlock_init(void) { }
 #endif // CONFIG_PARAVIRT
 #endif
diff --git a/arch/loongarch/include/asm/qspinlock.h b/arch/loongarch/include/asm/qspinlock.h
new file mode 100644
index 000000000000..7dd6d961dc79
--- /dev/null
+++ b/arch/loongarch/include/asm/qspinlock.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LOONGARCH_QSPINLOCK_H
+#define _ASM_LOONGARCH_QSPINLOCK_H
+
+#include <linux/jump_label.h>
+
+#ifdef CONFIG_PARAVIRT
+
+DECLARE_STATIC_KEY_FALSE(virt_spin_lock_key);
+
+#define virt_spin_lock virt_spin_lock
+static inline bool virt_spin_lock(struct qspinlock *lock)
+{
+	int val;
+
+	if (!static_branch_unlikely(&virt_spin_lock_key))
+		return false;
+
+	/*
+	 * On hypervisors without PARAVIRT_SPINLOCKS support we fall
+	 * back to a Test-and-Set spinlock, because fair locks have
+	 * horrible lock 'holder' preemption issues.
+	 */
+
+__retry:
+	val = atomic_read(&lock->val);
+
+	if (val || !atomic_try_cmpxchg(&lock->val, &val, _Q_LOCKED_VAL)) {
+		cpu_relax();
+		goto __retry;
+	}
+
+	return true;
+}
+
+#endif /* CONFIG_PARAVIRT */
+
+#include <asm-generic/qspinlock.h>
+
+#endif // _ASM_LOONGARCH_QSPINLOCK_H
diff --git a/arch/loongarch/kernel/paravirt.c b/arch/loongarch/kernel/paravirt.c
index 9c9b75b76f62..78b551f375ef 100644
--- a/arch/loongarch/kernel/paravirt.c
+++ b/arch/loongarch/kernel/paravirt.c
@@ -9,6 +9,7 @@
 #include <linux/static_call.h>
 #include <asm/paravirt.h>
 
+DEFINE_STATIC_KEY_FALSE(virt_spin_lock_key);
 static int has_steal_clock;
 struct static_key paravirt_steal_enabled;
 struct static_key paravirt_steal_rq_enabled;
@@ -300,3 +301,11 @@ int __init pv_time_init(void)
 
 	return 0;
 }
+
+void __init pv_spinlock_init(void)
+{
+	if (!cpu_has_hypervisor)
+		return;
+
+	static_branch_enable(&virt_spin_lock_key);
+}
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 0f0740f0be27..70a670efe3cf 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -599,6 +599,11 @@ void __init setup_arch(char **cmdline_p)
 	parse_early_param();
 	reserve_initrd_mem();
 
+	/*
+	 * Initialise the static keys early as they may be enabled by the
+	 * cpufeature code and early parameters.
+	 */
+	jump_label_init();
 	platform_init();
 	arch_mem_init(cmdline_p);
 
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index ca405ab86aae..482b3c7e3042 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -476,7 +476,7 @@ core_initcall(ipi_pm_init);
 #endif
 
 /* Preload SMP state for boot cpu */
-void smp_prepare_boot_cpu(void)
+void __init smp_prepare_boot_cpu(void)
 {
 	unsigned int cpu, node, rr_node;
 
@@ -509,6 +509,8 @@ void smp_prepare_boot_cpu(void)
 			rr_node = next_node_in(rr_node, node_online_map);
 		}
 	}
+
+	pv_spinlock_init();
 }
 
 /* called from main before smp_init() */

base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
-- 
2.39.3



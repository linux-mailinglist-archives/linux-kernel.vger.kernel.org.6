Return-Path: <linux-kernel+bounces-246041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5D092BCFD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C25B1C22CA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E419D089;
	Tue,  9 Jul 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgjacNEy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F5119CCE1;
	Tue,  9 Jul 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535638; cv=none; b=JGhtnw6NSibmOdGhAZIMJXJa1A6Ln6ZXCIWDCq2UMF1TF8moZU5CZAruOthKGp+2t3VrcdyJ6US93QQ6lcXbAvqP5i0FFt3cQCQV3xrJrICGo5Ims0kXSOU7O3zKEjAGSAO9KfW56OHXnyXK8XSwdrR3kd8AslbyC98lQVYcWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535638; c=relaxed/simple;
	bh=AKQnRLnIj/MysjQXWgU9rZo1Vmzl4vUovXBOlODaRgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=opap2AZVMI5TtToLdZpAFajCEJpZW3xFBd4W2TCc/1SNfRPb5vI+Rh2h7CvPaK1TsVQQeCc/QCpZjiIo9CYGk+BioTylPqqB7G37PCJM05Mm0gUr6frDD+ZzsE2t+LzNGXCdOVOx41HrE3btASVDvaNGcgpV02MqIt8OIc85dzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgjacNEy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720535636; x=1752071636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AKQnRLnIj/MysjQXWgU9rZo1Vmzl4vUovXBOlODaRgc=;
  b=kgjacNEysB2aMdzdj8x0/KNstkz+JnuNJ2vu7llfZPQ+zESvDdACiGBH
   lFODIiDzN2E0CSDcrcnXTtcLBUQZuzPHQF/53f7K4iD06Uds0rjqJGjJq
   KaHoEY1kvAoAi0ZdmLCqNJnl9Qc/uPaxjC67y6VF1GWjI406eC3Q9EZ0j
   bsTi07S3d75iNvODHx0Gwk6IHwgciLXlcTNgpQ6/qzEcTZQWmeoLRVhnC
   CXRSsBBs0O+fAT6qX8OflMGYMuoPgVsom40NS8FNSf0m9+5DDLENj+a49
   9GnjSDSv6cRNtgkdH81uL5nqwVK3/TC54JKHgDiNJhJ3rVrWvGK197NBl
   g==;
X-CSE-ConnectionGUID: fTlIv+DATSS/O5mnoj17yQ==
X-CSE-MsgGUID: 515wzMLoRAqejZeWD2Iz4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="35331357"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="35331357"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2024 07:33:54 -0700
X-CSE-ConnectionGUID: U6BWXfk6T5K+QMw8TScXkg==
X-CSE-MsgGUID: UljmqpUtTGC/lKxmV2/+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="52272088"
Received: from jacob-builder.jf.intel.com ([10.54.39.125])
  by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2024 07:33:54 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: X86 Kernel <x86@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Ingo Molnar" <mingo@redhat.com>,
	"Borislav Petkov" <bp@alien8.de>,
	"Xin Li" <xin3.li@intel.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	acme@kernel.org,
	kan.liang@linux.intel.com,
	Andi Kleen <andi.kleen@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v4 03/11] x86/irq: Extend NMI handler registration interface to include source
Date: Tue,  9 Jul 2024 07:38:58 -0700
Message-Id: <20240709143906.1040477-4-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
References: <20240709143906.1040477-1-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a source vector argument to register_nmi_handler() such that designated
NMI originators can leverage NMI source reporting feature. For those who
do not use NMI-source reporting, 0 (unknown) is used as the source vector.
NMI-source vectors (up to 16) are pre-defined.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

---
v4:
   - Tweak commit message
v3:
   - Move NMI source vector definitions to a separate patch (Sohil)

v2:(address review comments from HPA, not including optimizations"
   - Reserve IDT NMI vector 2 in case of devices use hardcoded vector 2
   - Sort NMI source vector by priority in descending order

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 arch/x86/events/amd/ibs.c         |  2 +-
 arch/x86/events/core.c            |  3 ++-
 arch/x86/include/asm/nmi.h        |  4 +++-
 arch/x86/kernel/apic/hw_nmi.c     |  2 +-
 arch/x86/kernel/cpu/mce/inject.c  |  2 +-
 arch/x86/kernel/cpu/mshyperv.c    |  2 +-
 arch/x86/kernel/kgdb.c            |  4 ++--
 arch/x86/kernel/nmi.c             | 22 ++++++++++++++++++++++
 arch/x86/kernel/nmi_selftest.c    |  5 +++--
 arch/x86/kernel/reboot.c          |  2 +-
 arch/x86/kernel/smp.c             |  2 +-
 arch/x86/platform/uv/uv_nmi.c     |  4 ++--
 drivers/acpi/apei/ghes.c          |  2 +-
 drivers/char/ipmi/ipmi_watchdog.c |  2 +-
 drivers/edac/igen6_edac.c         |  2 +-
 drivers/watchdog/hpwdt.c          |  6 +++---
 16 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e91970b01d62..20989071f59a 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1246,7 +1246,7 @@ static __init int perf_event_ibs_init(void)
 	if (ret)
 		goto err_op;
 
-	ret = register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
+	ret = register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs", 0);
 	if (ret)
 		goto err_nmi;
 
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 5b0dd07b1ef1..1ef2201e48ac 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2100,7 +2100,8 @@ static int __init init_hw_perf_events(void)
 		x86_pmu.intel_ctrl = (1 << x86_pmu.num_counters) - 1;
 
 	perf_events_lapic_init();
-	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI");
+
+	register_nmi_handler(NMI_LOCAL, perf_event_nmi_handler, 0, "PMI", NMI_SOURCE_VEC_PMI);
 
 	unconstrained = (struct event_constraint)
 		__EVENT_CONSTRAINT(0, (1ULL << x86_pmu.num_counters) - 1,
diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 41a0ebb699ec..6fe26fea30eb 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -39,15 +39,17 @@ struct nmiaction {
 	u64			max_duration;
 	unsigned long		flags;
 	const char		*name;
+	unsigned int		source_vec;
 };
 
-#define register_nmi_handler(t, fn, fg, n, init...)	\
+#define register_nmi_handler(t, fn, fg, n, src, init...)	\
 ({							\
 	static struct nmiaction init fn##_na = {	\
 		.list = LIST_HEAD_INIT(fn##_na.list),	\
 		.handler = (fn),			\
 		.name = (n),				\
 		.flags = (fg),				\
+		.source_vec = (src),			\
 	};						\
 	__register_nmi_handler((t), &fn##_na);		\
 })
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 45af535c44a0..9f0125d3b8b0 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -54,7 +54,7 @@ NOKPROBE_SYMBOL(nmi_cpu_backtrace_handler);
 static int __init register_nmi_cpu_backtrace_handler(void)
 {
 	register_nmi_handler(NMI_LOCAL, nmi_cpu_backtrace_handler,
-				0, "arch_bt");
+				0, "arch_bt", NMI_SOURCE_VEC_IPI_BT);
 	return 0;
 }
 early_initcall(register_nmi_cpu_backtrace_handler);
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 94953d749475..365a03f11d06 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -769,7 +769,7 @@ static int __init inject_init(void)
 
 	debugfs_init();
 
-	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
+	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify", NMI_SOURCE_VEC_IPI_MCE);
 	mce_register_injector_chain(&inject_nb);
 
 	setup_inj_struct(&i_mce);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..2fb9408a8ba9 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -486,7 +486,7 @@ static void __init ms_hyperv_init_platform(void)
 	}
 
 	register_nmi_handler(NMI_UNKNOWN, hv_nmi_unknown, NMI_FLAG_FIRST,
-			     "hv_nmi_unknown");
+			     "hv_nmi_unknown", 0);
 #endif
 
 #ifdef CONFIG_X86_IO_APIC
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..d167eb23cf13 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -603,12 +603,12 @@ int kgdb_arch_init(void)
 		goto out;
 
 	retval = register_nmi_handler(NMI_LOCAL, kgdb_nmi_handler,
-					0, "kgdb");
+					0, "kgdb", NMI_SOURCE_VEC_IPI_KGDB);
 	if (retval)
 		goto out1;
 
 	retval = register_nmi_handler(NMI_UNKNOWN, kgdb_nmi_handler,
-					0, "kgdb");
+					0, "kgdb", 0);
 
 	if (retval)
 		goto out2;
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index ed163c8c8604..5491b460f32b 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -86,6 +86,12 @@ static DEFINE_PER_CPU(struct nmi_stats, nmi_stats);
 
 static int ignore_nmis __read_mostly;
 
+/*
+ * Contains all actions registered by originators with source vector,
+ * excluding UNKNOWN NMI-source vector 0.
+ */
+static struct nmiaction *nmiaction_src_table[NR_NMI_SOURCE_VECTORS - 1];
+
 int unknown_nmi_panic;
 /*
  * Prevent NMI reason port (0x61) being accessed simultaneously, can
@@ -163,6 +169,12 @@ static int nmi_handle(unsigned int type, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(nmi_handle);
 
+static inline bool use_nmi_source(unsigned int type, struct nmiaction *a)
+{
+	return (cpu_feature_enabled(X86_FEATURE_NMI_SOURCE) &&
+		type == NMI_LOCAL && a->source_vec);
+}
+
 int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 {
 	struct nmi_desc *desc = nmi_to_desc(type);
@@ -173,6 +185,11 @@ int __register_nmi_handler(unsigned int type, struct nmiaction *action)
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
+	if (use_nmi_source(type, action)) {
+		rcu_assign_pointer(nmiaction_src_table[action->source_vec], action);
+		pr_info("NMI source %d registered for %s\n", action->source_vec, action->name);
+	}
+
 	/*
 	 * Indicate if there are multiple registrations on the
 	 * internal NMI handler call chains (SERR and IO_CHECK).
@@ -210,6 +227,11 @@ void unregister_nmi_handler(unsigned int type, const char *name)
 		if (!strcmp(n->name, name)) {
 			WARN(in_nmi(),
 				"Trying to free NMI (%s) from NMI context!\n", n->name);
+			if (use_nmi_source(type, n)) {
+				rcu_assign_pointer(nmiaction_src_table[n->source_vec], NULL);
+				pr_info("NMI source %d unregistered for %s\n", n->source_vec, n->name);
+			}
+
 			list_del_rcu(&n->list);
 			found = n;
 			break;
diff --git a/arch/x86/kernel/nmi_selftest.c b/arch/x86/kernel/nmi_selftest.c
index e93a8545c74d..f014c8a66b0c 100644
--- a/arch/x86/kernel/nmi_selftest.c
+++ b/arch/x86/kernel/nmi_selftest.c
@@ -44,7 +44,7 @@ static void __init init_nmi_testsuite(void)
 {
 	/* trap all the unknown NMIs we may generate */
 	register_nmi_handler(NMI_UNKNOWN, nmi_unk_cb, 0, "nmi_selftest_unk",
-			__initdata);
+			0, __initdata);
 }
 
 static void __init cleanup_nmi_testsuite(void)
@@ -67,7 +67,8 @@ static void __init test_nmi_ipi(struct cpumask *mask)
 	unsigned long timeout;
 
 	if (register_nmi_handler(NMI_LOCAL, test_nmi_ipi_callback,
-				 NMI_FLAG_FIRST, "nmi_selftest", __initdata)) {
+				 NMI_FLAG_FIRST, "nmi_selftest", NMI_SOURCE_VEC_IPI_TEST,
+				 __initdata)) {
 		nmi_fail = FAILURE;
 		return;
 	}
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f3130f762784..acc19c1d3b4f 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -910,7 +910,7 @@ void nmi_shootdown_cpus(nmi_shootdown_cb callback)
 	atomic_set(&waiting_for_crash_ipi, num_online_cpus() - 1);
 	/* Would it be better to replace the trap vector here? */
 	if (register_nmi_handler(NMI_LOCAL, crash_nmi_callback,
-				 NMI_FLAG_FIRST, "crash"))
+				 NMI_FLAG_FIRST, "crash", NMI_SOURCE_VEC_IPI_REBOOT))
 		return;		/* Return what? */
 	/*
 	 * Ensure the new callback function is set before sending
diff --git a/arch/x86/kernel/smp.c b/arch/x86/kernel/smp.c
index 18266cc3d98c..f27469e40141 100644
--- a/arch/x86/kernel/smp.c
+++ b/arch/x86/kernel/smp.c
@@ -143,7 +143,7 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_reboot)
 static int register_stop_handler(void)
 {
 	return register_nmi_handler(NMI_LOCAL, smp_stop_nmi_callback,
-				    NMI_FLAG_FIRST, "smp_stop");
+				    NMI_FLAG_FIRST, "smp_stop", NMI_SOURCE_VEC_IPI_SMP_STOP);
 }
 
 static void native_stop_other_cpus(int wait)
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index 5c50e550ab63..473c34eb264c 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -1029,10 +1029,10 @@ static int uv_handle_nmi_ping(unsigned int reason, struct pt_regs *regs)
 
 static void uv_register_nmi_notifier(void)
 {
-	if (register_nmi_handler(NMI_UNKNOWN, uv_handle_nmi, 0, "uv"))
+	if (register_nmi_handler(NMI_UNKNOWN, uv_handle_nmi, 0, "uv", 0))
 		pr_warn("UV: NMI handler failed to register\n");
 
-	if (register_nmi_handler(NMI_LOCAL, uv_handle_nmi_ping, 0, "uvping"))
+	if (register_nmi_handler(NMI_LOCAL, uv_handle_nmi_ping, 0, "uvping", 0))
 		pr_warn("UV: PING NMI handler failed to register\n");
 }
 
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 623cc0cb4a65..393dca95d2b3 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1318,7 +1318,7 @@ static void ghes_nmi_add(struct ghes *ghes)
 {
 	mutex_lock(&ghes_list_mutex);
 	if (list_empty(&ghes_nmi))
-		register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes");
+		register_nmi_handler(NMI_LOCAL, ghes_notify_nmi, 0, "ghes", 0);
 	list_add_rcu(&ghes->list, &ghes_nmi);
 	mutex_unlock(&ghes_list_mutex);
 }
diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
index 9a459257489f..61bb5dcade5a 100644
--- a/drivers/char/ipmi/ipmi_watchdog.c
+++ b/drivers/char/ipmi/ipmi_watchdog.c
@@ -1272,7 +1272,7 @@ static void check_parms(void)
 	}
 	if (do_nmi && !nmi_handler_registered) {
 		rv = register_nmi_handler(NMI_UNKNOWN, ipmi_nmi, 0,
-						"ipmi");
+						"ipmi", 0);
 		if (rv) {
 			pr_warn("Can't register nmi handler\n");
 			return;
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index dbe9fe5f2ca6..891278245d8b 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -1321,7 +1321,7 @@ static int register_err_handler(void)
 	}
 
 	rc = register_nmi_handler(NMI_SERR, ecclog_nmi_handler,
-				  0, IGEN6_NMI_NAME);
+				  0, IGEN6_NMI_NAME, 0);
 	if (rc) {
 		igen6_printk(KERN_ERR, "Failed to register NMI handler\n");
 		return rc;
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ae30e394d176..5246706afcf6 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -242,13 +242,13 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 	/*
 	 * Only one function can register for NMI_UNKNOWN
 	 */
-	retval = register_nmi_handler(NMI_UNKNOWN, hpwdt_pretimeout, 0, "hpwdt");
+	retval = register_nmi_handler(NMI_UNKNOWN, hpwdt_pretimeout, 0, "hpwdt", 0);
 	if (retval)
 		goto error;
-	retval = register_nmi_handler(NMI_SERR, hpwdt_pretimeout, 0, "hpwdt");
+	retval = register_nmi_handler(NMI_SERR, hpwdt_pretimeout, 0, "hpwdt", 0);
 	if (retval)
 		goto error1;
-	retval = register_nmi_handler(NMI_IO_CHECK, hpwdt_pretimeout, 0, "hpwdt");
+	retval = register_nmi_handler(NMI_IO_CHECK, hpwdt_pretimeout, 0, "hpwdt", 0);
 	if (retval)
 		goto error2;
 
-- 
2.25.1



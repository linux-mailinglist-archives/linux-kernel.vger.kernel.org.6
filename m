Return-Path: <linux-kernel+bounces-177579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8E8C40FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71E0A1C22D33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6B61509B5;
	Mon, 13 May 2024 12:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D1emCD5u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TbR/FkQA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6328B14F9C6
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604605; cv=none; b=BNbGEPIxBqTf0E1IAWctm09Kg4VcBXaMIx//7Q40w9TWbRLtegxCHzCZg2XRTzKqKE2B4xt6dPPOaex0xoaeZL0AVJSKEsM9IgkoMJrXXAWeLUuMufC02+5krGkKT14x48IcjvJ4ClSogEHTRN/ZoDVMnJcPriu+CxuBMlTMp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604605; c=relaxed/simple;
	bh=kmtYbZWl+xfrtc4xe3zGUCbHbgRdzlVTC2oD/0JjAGA=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=kTKGwgxl+m7IOjGLBW26iHWTQLp66DwGYVOvwqF691wzhwvW2FgY/CVYXBLYzE5YDGDIkOrJWSyZPxIHA19mDM176Y/Dmwzzegxf1Hsn+UE2b/M5tRjSknimqNo9TE5DbDBrCWRBiRDID8qTSWX14xy/BhjAWNLnLZ2nmDBnQeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D1emCD5u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TbR/FkQA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715604601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=24Mgspsal6ptukw4WFZLBAkz0UsUKiHW2uNbmI39UnE=;
	b=D1emCD5ugH2wEqoVFxHROiRw6RfkwJ19skHk3PnxDfWdgnRUxEBwynuLTiyh201qp034V7
	BDg5EdQVptCKIa2j5RKIopPZZzY+0RiNaW5wE/6wV0H3JaZHe52iNRtQSmwvVzU2mmv7zy
	LBuei9wixOQkiscucoZ7bkj/LHV9K69eNzgIXRkJPiTvjGmdnZ1NH5go3GYRyCsQaPY68d
	pqpHpB46I3Ge+SBzN96Gcypgh0D/NVc8ShZGfQt8px63L5uTAJxT1JIy4020qMS1qvbCI5
	I0iGlkBxBZd3pPKFswttGqts2R7Vx/UZPh2blKb88dNqtmoyHsp9OhjydH1KyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715604601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=24Mgspsal6ptukw4WFZLBAkz0UsUKiHW2uNbmI39UnE=;
	b=TbR/FkQAJRqUYJj67d5qA0P6InVG1knkd3b8xGVhYVQPJMpgIuEUYCmJVkcZLD8ImEq2ID
	Ep7dqG7LEjbQ0UDQ==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/irq for v6.10-rc1
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <171560454884.3871325.5522975131804736634.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 May 2024 14:50:01 +0200 (CEST)

Linus,

please pull the latest x86/irq branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2024-05-=
12

up to:  6ecc2e7932fe: x86/irq: Use existing helper for pending vector check

X86 interrupt handling update:

  Support for posted interrupts on bare metal

    Posted interrupts is a virtualization feature which allows to inject
    interrupts directly into a guest without host interaction. The VT-d
    interrupt remapping hardware sets the bit which corresponds to the
    interrupt vector in a vector bitmap which is either used to inject the
    interrupt directly into the guest via a virtualized APIC or in case
    that the guest is scheduled out provides a host side notification
    interrupt which informs the host that an interrupt has been marked
    pending in the bitmap.

    This can be utilized on bare metal for scenarios where multiple
    devices, e.g. NVME storage, raise interrupts with a high frequency.  In
    the default mode these interrupts are handles independently and
    therefore require a full roundtrip of interrupt entry/exit.

    Utilizing posted interrupts this roundtrip overhead can be avoided by
    coalescing these interrupt entries to a single entry for the posted
    interrupt notification. The notification interrupt then demultiplexes
    the pending bits in a memory based bitmap and invokes the corresponding
    device specific handlers.

    Depending on the usage scenario and device utilization throughput
    improvements between 10% and 130% have been measured.

    As this is only relevant for high end servers with multiple device
    queues per CPU attached and counterproductive for situations where
    interrupts are arriving at distinct times, the functionality is opt-in
    via a kernel command line parameter.

Thanks,

	tglx

------------------>
Jacob Pan (13):
      KVM: VMX: Move posted interrupt descriptor out of VMX code
      x86/irq: Unionize PID.PIR for 64bit access w/o casting
      x86/irq: Remove bitfields in posted interrupt descriptor
      x86/irq: Add a Kconfig option for posted MSI
      x86/irq: Reserve a per CPU IDT vector for posted MSIs
      x86/irq: Set up per host CPU posted interrupt descriptors
      x86/irq: Factor out handler invocation from common_interrupt()
      x86/irq: Install posted MSI notification handler
      x86/irq: Factor out common code for checking pending interrupts
      x86/irq: Extend checks for pending vectors to posted interrupts
      iommu/vt-d: Make posted MSI an opt-in command line option
      iommu/vt-d: Enable posted mode for device MSIs
      x86/irq: Use existing helper for pending vector check


 Documentation/admin-guide/kernel-parameters.txt |   2 +
 arch/x86/Kconfig                                |  11 ++
 arch/x86/entry/entry_fred.c                     |   2 +
 arch/x86/include/asm/apic.h                     |   6 +
 arch/x86/include/asm/hardirq.h                  |   6 +
 arch/x86/include/asm/idtentry.h                 |   6 +
 arch/x86/include/asm/irq_remapping.h            |   7 +
 arch/x86/include/asm/irq_vectors.h              |   8 +-
 arch/x86/include/asm/posted_intr.h              | 118 ++++++++++++++++
 arch/x86/kernel/apic/vector.c                   |   5 +-
 arch/x86/kernel/cpu/common.c                    |   3 +
 arch/x86/kernel/idt.c                           |   3 +
 arch/x86/kernel/irq.c                           | 172 ++++++++++++++++++++++=
--
 arch/x86/kvm/vmx/posted_intr.c                  |   4 +-
 arch/x86/kvm/vmx/posted_intr.h                  |  93 +------------
 arch/x86/kvm/vmx/vmx.c                          |   3 +-
 arch/x86/kvm/vmx/vmx.h                          |   2 +-
 drivers/iommu/intel/irq_remapping.c             | 113 +++++++++++++++-
 drivers/iommu/irq_remapping.c                   |   5 +-
 19 files changed, 450 insertions(+), 119 deletions(-)
 create mode 100644 arch/x86/include/asm/posted_intr.h

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index 902ecd92a29f..dfbe9fdf97e4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2251,6 +2251,8 @@
 			no_x2apic_optout
 				BIOS x2APIC opt-out request will be ignored
 			nopost	disable Interrupt Posting
+			posted_msi
+				enable MSIs delivered as posted interrupts
=20
 	iomem=3D		Disable strict checking of access to MMIO memory
 		strict	regions from userspace.
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4474bf32d0a4..fed22fc66217 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -464,6 +464,17 @@ config X86_X2APIC
=20
 	  If you don't know what to do here, say N.
=20
+config X86_POSTED_MSI
+	bool "Enable MSI and MSI-x delivery by posted interrupts"
+	depends on X86_64 && IRQ_REMAP
+	help
+	  This enables MSIs that are under interrupt remapping to be delivered as
+	  posted interrupts to the host kernel. Interrupt throughput can
+	  potentially be improved by coalescing CPU notifications during high
+	  frequency bursts.
+
+	  If you don't know what to do here, say N.
+
 config X86_MPPARSE
 	bool "Enable MPS table" if ACPI
 	default y
diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 89c1476fcdd9..f004a4dc74c2 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -117,6 +117,8 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_af=
ter_init =3D {
 	SYSVEC(POSTED_INTR_VECTOR,		kvm_posted_intr_ipi),
 	SYSVEC(POSTED_INTR_WAKEUP_VECTOR,	kvm_posted_intr_wakeup_ipi),
 	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
+
+	SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,	posted_msi_notification),
 };
=20
 static bool fred_setup_done __initdata;
diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index e6ab0cf15ed5..467532b3e070 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -14,6 +14,7 @@
 #include <asm/msr.h>
 #include <asm/hardirq.h>
 #include <asm/io.h>
+#include <asm/posted_intr.h>
=20
 #define ARCH_APICTIMER_STOPS_ON_C3	1
=20
@@ -500,6 +501,11 @@ static inline bool lapic_vector_set_in_irr(unsigned int =
vector)
 	return !!(irr & (1U << (vector % 32)));
 }
=20
+static inline bool is_vector_pending(unsigned int vector)
+{
+	return lapic_vector_set_in_irr(vector) || pi_pending_this_cpu(vector);
+}
+
 /*
  * Warm reset vector position:
  */
diff --git a/arch/x86/include/asm/hardirq.h b/arch/x86/include/asm/hardirq.h
index fbc7722b87d1..c67fa6ad098a 100644
--- a/arch/x86/include/asm/hardirq.h
+++ b/arch/x86/include/asm/hardirq.h
@@ -44,10 +44,16 @@ typedef struct {
 	unsigned int irq_hv_reenlightenment_count;
 	unsigned int hyperv_stimer0_count;
 #endif
+#ifdef CONFIG_X86_POSTED_MSI
+	unsigned int posted_msi_notification_count;
+#endif
 } ____cacheline_aligned irq_cpustat_t;
=20
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
=20
+#ifdef CONFIG_X86_POSTED_MSI
+DECLARE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+#endif
 #define __ARCH_IRQ_STAT
=20
 #define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 749c7411d2f1..d4f24499b256 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -751,6 +751,12 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysve=
c_kvm_posted_intr_nested
 # define fred_sysvec_kvm_posted_intr_nested_ipi		NULL
 #endif
=20
+# ifdef CONFIG_X86_POSTED_MSI
+DECLARE_IDTENTRY_SYSVEC(POSTED_MSI_NOTIFICATION_VECTOR,	sysvec_posted_msi_no=
tification);
+#else
+# define fred_sysvec_posted_msi_notification		NULL
+# endif
+
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
 DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlig=
htenment);
diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_=
remapping.h
index 7a2ed154a5e1..5036f13ab69f 100644
--- a/arch/x86/include/asm/irq_remapping.h
+++ b/arch/x86/include/asm/irq_remapping.h
@@ -50,6 +50,13 @@ static inline struct irq_domain *arch_get_ir_parent_domain=
(void)
 	return x86_vector_domain;
 }
=20
+extern bool enable_posted_msi;
+
+static inline bool posted_msi_supported(void)
+{
+	return enable_posted_msi && irq_remapping_cap(IRQ_POSTING_CAP);
+}
+
 #else  /* CONFIG_IRQ_REMAP */
=20
 static inline bool irq_remapping_cap(enum irq_remap_cap cap) { return 0; }
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_ve=
ctors.h
index d18bfb238f66..13aea8fc3d45 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -97,10 +97,16 @@
=20
 #define LOCAL_TIMER_VECTOR		0xec
=20
+/*
+ * Posted interrupt notification vector for all device MSIs delivered to
+ * the host kernel.
+ */
+#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
+
 #define NR_VECTORS			 256
=20
 #ifdef CONFIG_X86_LOCAL_APIC
-#define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
+#define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
 #else
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
diff --git a/arch/x86/include/asm/posted_intr.h b/arch/x86/include/asm/posted=
_intr.h
new file mode 100644
index 000000000000..de788b400fba
--- /dev/null
+++ b/arch/x86/include/asm/posted_intr.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_POSTED_INTR_H
+#define _X86_POSTED_INTR_H
+#include <asm/irq_vectors.h>
+
+#define POSTED_INTR_ON  0
+#define POSTED_INTR_SN  1
+
+#define PID_TABLE_ENTRY_VALID 1
+
+/* Posted-Interrupt Descriptor */
+struct pi_desc {
+	union {
+		u32 pir[8];     /* Posted interrupt requested */
+		u64 pir64[4];
+	};
+	union {
+		struct {
+			u16	notifications; /* Suppress and outstanding bits */
+			u8	nv;
+			u8	rsvd_2;
+			u32	ndst;
+		};
+		u64 control;
+	};
+	u32 rsvd[6];
+} __aligned(64);
+
+static inline bool pi_test_and_set_on(struct pi_desc *pi_desc)
+{
+	return test_and_set_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_and_clear_on(struct pi_desc *pi_desc)
+{
+	return test_and_clear_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->contro=
l);
+}
+
+static inline bool pi_test_and_clear_sn(struct pi_desc *pi_desc)
+{
+	return test_and_clear_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->contro=
l);
+}
+
+static inline bool pi_test_and_set_pir(int vector, struct pi_desc *pi_desc)
+{
+	return test_and_set_bit(vector, (unsigned long *)pi_desc->pir);
+}
+
+static inline bool pi_is_pir_empty(struct pi_desc *pi_desc)
+{
+	return bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS);
+}
+
+static inline void pi_set_sn(struct pi_desc *pi_desc)
+{
+	set_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+static inline void pi_set_on(struct pi_desc *pi_desc)
+{
+	set_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline void pi_clear_on(struct pi_desc *pi_desc)
+{
+	clear_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline void pi_clear_sn(struct pi_desc *pi_desc)
+{
+	clear_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_on(struct pi_desc *pi_desc)
+{
+	return test_bit(POSTED_INTR_ON, (unsigned long *)&pi_desc->control);
+}
+
+static inline bool pi_test_sn(struct pi_desc *pi_desc)
+{
+	return test_bit(POSTED_INTR_SN, (unsigned long *)&pi_desc->control);
+}
+
+/* Non-atomic helpers */
+static inline void __pi_set_sn(struct pi_desc *pi_desc)
+{
+	pi_desc->notifications |=3D BIT(POSTED_INTR_SN);
+}
+
+static inline void __pi_clear_sn(struct pi_desc *pi_desc)
+{
+	pi_desc->notifications &=3D ~BIT(POSTED_INTR_SN);
+}
+
+#ifdef CONFIG_X86_POSTED_MSI
+/*
+ * Not all external vectors are subject to interrupt remapping, e.g. IOMMU's
+ * own interrupts. Here we do not distinguish them since those vector bits in
+ * PIR will always be zero.
+ */
+static inline bool pi_pending_this_cpu(unsigned int vector)
+{
+	struct pi_desc *pid =3D this_cpu_ptr(&posted_msi_pi_desc);
+
+	if (WARN_ON_ONCE(vector > NR_VECTORS || vector < FIRST_EXTERNAL_VECTOR))
+		return false;
+
+	return test_bit(vector, (unsigned long *)pid->pir);
+}
+
+extern void intel_posted_msi_init(void);
+#else
+static inline bool pi_pending_this_cpu(unsigned int vector) { return false; }
+
+static inline void intel_posted_msi_init(void) {};
+#endif /* X86_POSTED_MSI */
+
+#endif /* _X86_POSTED_INTR_H */
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c72766..9eec52925fa3 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -965,7 +965,7 @@ static void __vector_cleanup(struct vector_cleanup *cl, b=
ool check_irr)
 	lockdep_assert_held(&vector_lock);
=20
 	hlist_for_each_entry_safe(apicd, tmp, &cl->head, clist) {
-		unsigned int irr, vector =3D apicd->prev_vector;
+		unsigned int vector =3D apicd->prev_vector;
=20
 		/*
 		 * Paranoia: Check if the vector that needs to be cleaned
@@ -979,8 +979,7 @@ static void __vector_cleanup(struct vector_cleanup *cl, b=
ool check_irr)
 		 * fixup_irqs() was just called to scan IRR for set bits and
 		 * forward them to new destination CPUs via IPIs.
 		 */
-		irr =3D check_irr ? apic_read(APIC_IRR + (vector / 32 * 0x10)) : 0;
-		if (irr & (1U << (vector % 32))) {
+		if (check_irr && is_vector_pending(vector)) {
 			pr_warn_once("Moved interrupt pending in old target APIC %u\n", apicd->ir=
q);
 			rearm =3D true;
 			continue;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 605c26c009c8..25ef145586c6 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -68,6 +68,7 @@
 #include <asm/traps.h>
 #include <asm/sev.h>
 #include <asm/tdx.h>
+#include <asm/posted_intr.h>
=20
 #include "cpu.h"
=20
@@ -2227,6 +2228,8 @@ void cpu_init(void)
 		barrier();
=20
 		x2apic_setup();
+
+		intel_posted_msi_init();
 	}
=20
 	mmgrab(&init_mm);
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index fc37c8d83daf..f445bec516a0 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -163,6 +163,9 @@ static const __initconst struct idt_data apic_idts[] =3D {
 # endif
 	INTG(SPURIOUS_APIC_VECTOR,		asm_sysvec_spurious_apic_interrupt),
 	INTG(ERROR_APIC_VECTOR,			asm_sysvec_error_interrupt),
+# ifdef CONFIG_X86_POSTED_MSI
+	INTG(POSTED_MSI_NOTIFICATION_VECTOR,	asm_sysvec_posted_msi_notification),
+# endif
 #endif
 };
=20
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 35fde0107901..385e3a5fc304 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -22,6 +22,8 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 #include <asm/thermal.h>
+#include <asm/posted_intr.h>
+#include <asm/irq_remapping.h>
=20
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
@@ -181,6 +183,13 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ",
 			   irq_stats(j)->kvm_posted_intr_wakeup_ipis);
 	seq_puts(p, "  Posted-interrupt wakeup event\n");
+#endif
+#ifdef CONFIG_X86_POSTED_MSI
+	seq_printf(p, "%*s: ", prec, "PMN");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ",
+			   irq_stats(j)->posted_msi_notification_count);
+	seq_puts(p, "  Posted MSI notification event\n");
 #endif
 	return 0;
 }
@@ -240,24 +249,16 @@ static __always_inline void handle_irq(struct irq_desc =
*desc,
 		__handle_irq(desc, regs);
 }
=20
-/*
- * common_interrupt() handles all normal device IRQ's (the special SMP
- * cross-CPU interrupts have their own entry points).
- */
-DEFINE_IDTENTRY_IRQ(common_interrupt)
+static __always_inline int call_irq_handler(int vector, struct pt_regs *regs)
 {
-	struct pt_regs *old_regs =3D set_irq_regs(regs);
 	struct irq_desc *desc;
-
-	/* entry code tells RCU that we're not quiescent.  Check it. */
-	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
+	int ret =3D 0;
=20
 	desc =3D __this_cpu_read(vector_irq[vector]);
 	if (likely(!IS_ERR_OR_NULL(desc))) {
 		handle_irq(desc, regs);
 	} else {
-		apic_eoi();
-
+		ret =3D -EINVAL;
 		if (desc =3D=3D VECTOR_UNUSED) {
 			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
 					     __func__, smp_processor_id(),
@@ -267,6 +268,23 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 		}
 	}
=20
+	return ret;
+}
+
+/*
+ * common_interrupt() handles all normal device IRQ's (the special SMP
+ * cross-CPU interrupts have their own entry points).
+ */
+DEFINE_IDTENTRY_IRQ(common_interrupt)
+{
+	struct pt_regs *old_regs =3D set_irq_regs(regs);
+
+	/* entry code tells RCU that we're not quiescent.  Check it. */
+	RCU_LOCKDEP_WARN(!rcu_is_watching(), "IRQ failed to wake up RCU");
+
+	if (unlikely(call_irq_handler(vector, regs)))
+		apic_eoi();
+
 	set_irq_regs(old_regs);
 }
=20
@@ -334,12 +352,139 @@ DEFINE_IDTENTRY_SYSVEC_SIMPLE(sysvec_kvm_posted_intr_n=
ested_ipi)
 }
 #endif
=20
+#ifdef CONFIG_X86_POSTED_MSI
+
+/* Posted Interrupt Descriptors for coalesced MSIs to be posted */
+DEFINE_PER_CPU_ALIGNED(struct pi_desc, posted_msi_pi_desc);
+
+void intel_posted_msi_init(void)
+{
+	u32 destination;
+	u32 apic_id;
+
+	this_cpu_write(posted_msi_pi_desc.nv, POSTED_MSI_NOTIFICATION_VECTOR);
+
+	/*
+	 * APIC destination ID is stored in bit 8:15 while in XAPIC mode.
+	 * VT-d spec. CH 9.11
+	 */
+	apic_id =3D this_cpu_read(x86_cpu_to_apicid);
+	destination =3D x2apic_enabled() ? apic_id : apic_id << 8;
+	this_cpu_write(posted_msi_pi_desc.ndst, destination);
+}
+
+/*
+ * De-multiplexing posted interrupts is on the performance path, the code
+ * below is written to optimize the cache performance based on the following
+ * considerations:
+ * 1.Posted interrupt descriptor (PID) fits in a cache line that is frequent=
ly
+ *   accessed by both CPU and IOMMU.
+ * 2.During posted MSI processing, the CPU needs to do 64-bit read and xchg
+ *   for checking and clearing posted interrupt request (PIR), a 256 bit fie=
ld
+ *   within the PID.
+ * 3.On the other side, the IOMMU does atomic swaps of the entire PID cache
+ *   line when posting interrupts and setting control bits.
+ * 4.The CPU can access the cache line a magnitude faster than the IOMMU.
+ * 5.Each time the IOMMU does interrupt posting to the PIR will evict the PID
+ *   cache line. The cache line states after each operation are as follows:
+ *   CPU		IOMMU			PID Cache line state
+ *   ---------------------------------------------------------------
+ *...read64					exclusive
+ *...lock xchg64				modified
+ *...			post/atomic swap	invalid
+ *...-------------------------------------------------------------
+ *
+ * To reduce L1 data cache miss, it is important to avoid contention with
+ * IOMMU's interrupt posting/atomic swap. Therefore, a copy of PIR is used
+ * to dispatch interrupt handlers.
+ *
+ * In addition, the code is trying to keep the cache line state consistent
+ * as much as possible. e.g. when making a copy and clearing the PIR
+ * (assuming non-zero PIR bits are present in the entire PIR), it does:
+ *		read, read, read, read, xchg, xchg, xchg, xchg
+ * instead of:
+ *		read, xchg, read, xchg, read, xchg, read, xchg
+ */
+static __always_inline bool handle_pending_pir(u64 *pir, struct pt_regs *reg=
s)
+{
+	int i, vec =3D FIRST_EXTERNAL_VECTOR;
+	unsigned long pir_copy[4];
+	bool handled =3D false;
+
+	for (i =3D 0; i < 4; i++)
+		pir_copy[i] =3D pir[i];
+
+	for (i =3D 0; i < 4; i++) {
+		if (!pir_copy[i])
+			continue;
+
+		pir_copy[i] =3D arch_xchg(&pir[i], 0);
+		handled =3D true;
+	}
+
+	if (handled) {
+		for_each_set_bit_from(vec, pir_copy, FIRST_SYSTEM_VECTOR)
+			call_irq_handler(vec, regs);
+	}
+
+	return handled;
+}
+
+/*
+ * Performance data shows that 3 is good enough to harvest 90+% of the benef=
it
+ * on high IRQ rate workload.
+ */
+#define MAX_POSTED_MSI_COALESCING_LOOP 3
+
+/*
+ * For MSIs that are delivered as posted interrupts, the CPU notifications
+ * can be coalesced if the MSIs arrive in high frequency bursts.
+ */
+DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
+{
+	struct pt_regs *old_regs =3D set_irq_regs(regs);
+	struct pi_desc *pid;
+	int i =3D 0;
+
+	pid =3D this_cpu_ptr(&posted_msi_pi_desc);
+
+	inc_irq_stat(posted_msi_notification_count);
+	irq_enter();
+
+	/*
+	 * Max coalescing count includes the extra round of handle_pending_pir
+	 * after clearing the outstanding notification bit. Hence, at most
+	 * MAX_POSTED_MSI_COALESCING_LOOP - 1 loops are executed here.
+	 */
+	while (++i < MAX_POSTED_MSI_COALESCING_LOOP) {
+		if (!handle_pending_pir(pid->pir64, regs))
+			break;
+	}
+
+	/*
+	 * Clear outstanding notification bit to allow new IRQ notifications,
+	 * do this last to maximize the window of interrupt coalescing.
+	 */
+	pi_clear_on(pid);
+
+	/*
+	 * There could be a race of PI notification and the clearing of ON bit,
+	 * process PIR bits one last time such that handling the new interrupts
+	 * are not delayed until the next IRQ.
+	 */
+	handle_pending_pir(pid->pir64, regs);
+
+	apic_eoi();
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+#endif /* X86_POSTED_MSI */
=20
 #ifdef CONFIG_HOTPLUG_CPU
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
 void fixup_irqs(void)
 {
-	unsigned int irr, vector;
+	unsigned int vector;
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
@@ -366,8 +511,7 @@ void fixup_irqs(void)
 		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
 			continue;
=20
-		irr =3D apic_read(APIC_IRR + (vector / 32 * 0x10));
-		if (irr  & (1 << (vector % 32))) {
+		if (is_vector_pending(vector)) {
 			desc =3D __this_cpu_read(vector_irq[vector]);
=20
 			raw_spin_lock(&desc->lock);
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index af662312fd07..ec08fa3caf43 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -107,7 +107,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 		 * handle task migration (@cpu !=3D vcpu->cpu).
 		 */
 		new.ndst =3D dest;
-		new.sn =3D 0;
+		__pi_clear_sn(&new);
=20
 		/*
 		 * Restore the notification vector; in the blocking case, the
@@ -157,7 +157,7 @@ static void pi_enable_wakeup_handler(struct kvm_vcpu *vcp=
u)
 		      &per_cpu(wakeup_vcpus_on_cpu, vcpu->cpu));
 	raw_spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, vcpu->cpu));
=20
-	WARN(pi_desc->sn, "PI descriptor SN field set before blocking");
+	WARN(pi_test_sn(pi_desc), "PI descriptor SN field set before blocking");
=20
 	old.control =3D READ_ONCE(pi_desc->control);
 	do {
diff --git a/arch/x86/kvm/vmx/posted_intr.h b/arch/x86/kvm/vmx/posted_intr.h
index 26992076552e..6b2a0226257e 100644
--- a/arch/x86/kvm/vmx/posted_intr.h
+++ b/arch/x86/kvm/vmx/posted_intr.h
@@ -1,98 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __KVM_X86_VMX_POSTED_INTR_H
 #define __KVM_X86_VMX_POSTED_INTR_H
-
-#define POSTED_INTR_ON  0
-#define POSTED_INTR_SN  1
-
-#define PID_TABLE_ENTRY_VALID 1
-
-/* Posted-Interrupt Descriptor */
-struct pi_desc {
-	u32 pir[8];     /* Posted interrupt requested */
-	union {
-		struct {
-				/* bit 256 - Outstanding Notification */
-			u16	on	: 1,
-				/* bit 257 - Suppress Notification */
-				sn	: 1,
-				/* bit 271:258 - Reserved */
-				rsvd_1	: 14;
-				/* bit 279:272 - Notification Vector */
-			u8	nv;
-				/* bit 287:280 - Reserved */
-			u8	rsvd_2;
-				/* bit 319:288 - Notification Destination */
-			u32	ndst;
-		};
-		u64 control;
-	};
-	u32 rsvd[6];
-} __aligned(64);
-
-static inline bool pi_test_and_set_on(struct pi_desc *pi_desc)
-{
-	return test_and_set_bit(POSTED_INTR_ON,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_and_clear_on(struct pi_desc *pi_desc)
-{
-	return test_and_clear_bit(POSTED_INTR_ON,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_and_clear_sn(struct pi_desc *pi_desc)
-{
-	return test_and_clear_bit(POSTED_INTR_SN,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_and_set_pir(int vector, struct pi_desc *pi_desc)
-{
-	return test_and_set_bit(vector, (unsigned long *)pi_desc->pir);
-}
-
-static inline bool pi_is_pir_empty(struct pi_desc *pi_desc)
-{
-	return bitmap_empty((unsigned long *)pi_desc->pir, NR_VECTORS);
-}
-
-static inline void pi_set_sn(struct pi_desc *pi_desc)
-{
-	set_bit(POSTED_INTR_SN,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline void pi_set_on(struct pi_desc *pi_desc)
-{
-	set_bit(POSTED_INTR_ON,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline void pi_clear_on(struct pi_desc *pi_desc)
-{
-	clear_bit(POSTED_INTR_ON,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline void pi_clear_sn(struct pi_desc *pi_desc)
-{
-	clear_bit(POSTED_INTR_SN,
-		(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_on(struct pi_desc *pi_desc)
-{
-	return test_bit(POSTED_INTR_ON,
-			(unsigned long *)&pi_desc->control);
-}
-
-static inline bool pi_test_sn(struct pi_desc *pi_desc)
-{
-	return test_bit(POSTED_INTR_SN,
-			(unsigned long *)&pi_desc->control);
-}
+#include <asm/posted_intr.h>
=20
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu);
 void vmx_vcpu_pi_put(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 22411f4aff53..becefaf95cab 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -70,6 +70,7 @@
 #include "x86.h"
 #include "smm.h"
 #include "vmx_onhyperv.h"
+#include "posted_intr.h"
=20
 MODULE_AUTHOR("Qumranet");
 MODULE_LICENSE("GPL");
@@ -4844,7 +4845,7 @@ static void __vmx_vcpu_reset(struct kvm_vcpu *vcpu)
 	 * or POSTED_INTR_WAKEUP_VECTOR.
 	 */
 	vmx->pi_desc.nv =3D POSTED_INTR_VECTOR;
-	vmx->pi_desc.sn =3D 1;
+	__pi_set_sn(&vmx->pi_desc);
 }
=20
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 90f9e4434646..7e483366b31e 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -7,10 +7,10 @@
 #include <asm/kvm.h>
 #include <asm/intel_pt.h>
 #include <asm/perf_event.h>
+#include <asm/posted_intr.h>
=20
 #include "capabilities.h"
 #include "../kvm_cache_regs.h"
-#include "posted_intr.h"
 #include "vmcs.h"
 #include "vmx_ops.h"
 #include "../cpuid.h"
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_re=
mapping.c
index 566297bc87dd..712ebfc9870c 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -19,6 +19,7 @@
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
+#include <asm/posted_intr.h>
=20
 #include "iommu.h"
 #include "../irq_remapping.h"
@@ -49,6 +50,7 @@ struct irq_2_iommu {
 	u16 sub_handle;
 	u8  irte_mask;
 	enum irq_mode mode;
+	bool posted_msi;
 };
=20
 struct intel_ir_data {
@@ -1118,6 +1120,14 @@ static void prepare_irte(struct irte *irte, int vector=
, unsigned int dest)
 	irte->redir_hint =3D 1;
 }
=20
+static void prepare_irte_posted(struct irte *irte)
+{
+	memset(irte, 0, sizeof(*irte));
+
+	irte->present =3D 1;
+	irte->p_pst =3D 1;
+}
+
 struct irq_remap_ops intel_irq_remap_ops =3D {
 	.prepare		=3D intel_prepare_irq_remapping,
 	.enable			=3D intel_enable_irq_remapping,
@@ -1126,6 +1136,47 @@ struct irq_remap_ops intel_irq_remap_ops =3D {
 	.enable_faulting	=3D enable_drhd_fault_handling,
 };
=20
+#ifdef CONFIG_X86_POSTED_MSI
+
+static phys_addr_t get_pi_desc_addr(struct irq_data *irqd)
+{
+	int cpu =3D cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+
+	if (WARN_ON(cpu >=3D nr_cpu_ids))
+		return 0;
+
+	return __pa(per_cpu_ptr(&posted_msi_pi_desc, cpu));
+}
+
+static void intel_ir_reconfigure_irte_posted(struct irq_data *irqd)
+{
+	struct intel_ir_data *ir_data =3D irqd->chip_data;
+	struct irte *irte =3D &ir_data->irte_entry;
+	struct irte irte_pi;
+	u64 pid_addr;
+
+	pid_addr =3D get_pi_desc_addr(irqd);
+
+	if (!pid_addr) {
+		pr_warn("Failed to setup IRQ %d for posted mode", irqd->irq);
+		return;
+	}
+
+	memset(&irte_pi, 0, sizeof(irte_pi));
+
+	/* The shared IRTE already be set up as posted during alloc_irte */
+	dmar_copy_shared_irte(&irte_pi, irte);
+
+	irte_pi.pda_l =3D (pid_addr >> (32 - PDA_LOW_BIT)) & ~(-1UL << PDA_LOW_BIT);
+	irte_pi.pda_h =3D (pid_addr >> 32) & ~(-1UL << PDA_HIGH_BIT);
+
+	modify_irte(&ir_data->irq_2_iommu, &irte_pi);
+}
+
+#else
+static inline void intel_ir_reconfigure_irte_posted(struct irq_data *irqd) {}
+#endif
+
 static void intel_ir_reconfigure_irte(struct irq_data *irqd, bool force)
 {
 	struct intel_ir_data *ir_data =3D irqd->chip_data;
@@ -1139,8 +1190,9 @@ static void intel_ir_reconfigure_irte(struct irq_data *=
irqd, bool force)
 	irte->vector =3D cfg->vector;
 	irte->dest_id =3D IRTE_DEST(cfg->dest_apicid);
=20
-	/* Update the hardware only if the interrupt is in remapped mode. */
-	if (force || ir_data->irq_2_iommu.mode =3D=3D IRQ_REMAPPING)
+	if (ir_data->irq_2_iommu.posted_msi)
+		intel_ir_reconfigure_irte_posted(irqd);
+	else if (force || ir_data->irq_2_iommu.mode =3D=3D IRQ_REMAPPING)
 		modify_irte(&ir_data->irq_2_iommu, irte);
 }
=20
@@ -1194,7 +1246,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *=
data, void *info)
 	struct intel_ir_data *ir_data =3D data->chip_data;
 	struct vcpu_data *vcpu_pi_info =3D info;
=20
-	/* stop posting interrupts, back to remapping mode */
+	/* stop posting interrupts, back to the default mode */
 	if (!vcpu_pi_info) {
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 	} else {
@@ -1233,6 +1285,49 @@ static struct irq_chip intel_ir_chip =3D {
 	.irq_set_vcpu_affinity	=3D intel_ir_set_vcpu_affinity,
 };
=20
+/*
+ * With posted MSIs, all vectors are multiplexed into a single notification
+ * vector. Devices MSIs are then dispatched in a demux loop where
+ * EOIs can be coalesced as well.
+ *
+ * "INTEL-IR-POST" IRQ chip does not do EOI on ACK, thus the dummy irq_ack()
+ * function. Instead EOI is performed by the posted interrupt notification
+ * handler.
+ *
+ * For the example below, 3 MSIs are coalesced into one CPU notification. On=
ly
+ * one apic_eoi() is needed.
+ *
+ * __sysvec_posted_msi_notification()
+ *	irq_enter();
+ *		handle_edge_irq()
+ *			irq_chip_ack_parent()
+ *				dummy(); // No EOI
+ *			handle_irq_event()
+ *				driver_handler()
+ *		handle_edge_irq()
+ *			irq_chip_ack_parent()
+ *				dummy(); // No EOI
+ *			handle_irq_event()
+ *				driver_handler()
+ *		handle_edge_irq()
+ *			irq_chip_ack_parent()
+ *				dummy(); // No EOI
+ *			handle_irq_event()
+ *				driver_handler()
+ *	apic_eoi()
+ *	irq_exit()
+ */
+
+static void dummy_ack(struct irq_data *d) { }
+
+static struct irq_chip intel_ir_chip_post_msi =3D {
+	.name			=3D "INTEL-IR-POST",
+	.irq_ack		=3D dummy_ack,
+	.irq_set_affinity	=3D intel_ir_set_affinity,
+	.irq_compose_msi_msg	=3D intel_ir_compose_msi_msg,
+	.irq_set_vcpu_affinity	=3D intel_ir_set_vcpu_affinity,
+};
+
 static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
 {
 	memset(msg, 0, sizeof(*msg));
@@ -1274,6 +1369,11 @@ static void intel_irq_remapping_prepare_irte(struct in=
tel_ir_data *data,
 		break;
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
+		if (posted_msi_supported()) {
+			prepare_irte_posted(irte);
+			data->irq_2_iommu.posted_msi =3D 1;
+		}
+
 		set_msi_sid(irte,
 			    pci_real_dma_dev(msi_desc_to_pci_dev(info->desc)));
 		break;
@@ -1361,7 +1461,12 @@ static int intel_irq_remapping_alloc(struct irq_domain=
 *domain,
=20
 		irq_data->hwirq =3D (index << 16) + i;
 		irq_data->chip_data =3D ird;
-		irq_data->chip =3D &intel_ir_chip;
+		if (posted_msi_supported() &&
+		    ((info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSI) ||
+		     (info->type =3D=3D X86_IRQ_ALLOC_TYPE_PCI_MSIX)))
+			irq_data->chip =3D &intel_ir_chip_post_msi;
+		else
+			irq_data->chip =3D &intel_ir_chip;
 		intel_irq_remapping_prepare_irte(ird, irq_cfg, info, index, i);
 		irq_set_status_flags(virq + i, IRQ_MOVE_PCNTXT);
 	}
diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
index ee59647c2050..056fec6991bc 100644
--- a/drivers/iommu/irq_remapping.c
+++ b/drivers/iommu/irq_remapping.c
@@ -24,6 +24,8 @@ int no_x2apic_optout;
=20
 int disable_irq_post =3D 0;
=20
+bool enable_posted_msi __ro_after_init;
+
 static int disable_irq_remap;
 static struct irq_remap_ops *remap_ops;
=20
@@ -70,7 +72,8 @@ static __init int setup_irqremap(char *str)
 			no_x2apic_optout =3D 1;
 		else if (!strncmp(str, "nopost", 6))
 			disable_irq_post =3D 1;
-
+		else if (IS_ENABLED(CONFIG_X86_POSTED_MSI) && !strncmp(str, "posted_msi", =
10))
+			enable_posted_msi =3D true;
 		str +=3D strcspn(str, ",");
 		while (*str =3D=3D ',')
 			str++;



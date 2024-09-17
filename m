Return-Path: <linux-kernel+bounces-331481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A5F97AD62
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 10:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E951F2131F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C918800E;
	Tue, 17 Sep 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1m1b7tM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/xWVgwnN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35791607BD
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 08:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726563261; cv=none; b=R49IiK5jGHWYetY7soA7ztew3mhKKbdoJ/oDD9h2sFV6s/+YJxeNrxPpKCJ4EuZOLSOcuPybXlyD5pkQJ6xobzlzLgmI08zPu1zegZzjfBfhUh/e9YCHZYZlfHzYSrbhvN+R9FuAHZmiXjYcoEXnuMex1bg2/zkRSaDZdwfybAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726563261; c=relaxed/simple;
	bh=xYJZoYe31JJQ5/e3BK5mdy06EkRai1wLIAntYYN80Bk=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=KMNDSRMUR3MC3JoZESIpULyMWtZM2akZ5VoQxI9aOZBtqetfl0UY9NjWkK/vQGBnuj1Nfb8VtqukukHWcWaluUyE0u86h4dSa9ijHSTBdOWt6X6W91PA1TB6vFV5eNslhq+mRJqAht90JfUVZW+lIe6kqFgqz4R7x0ODP6EOt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1m1b7tM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/xWVgwnN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726563256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=kHFPmUTSuZGStloUNiIFtF34lCrILlC03j/UmHX3CT8=;
	b=n1m1b7tMol1aN2k9/AbiSDZq0BfsxKRw3DaWsaycUnVgV8yy+MuvcdPtvFFYlvP1ODYNii
	vm/NVUI+zjDPGpifs2KlZPcYCG8H/TCbFk4FwGgOCDxM77gEeTkXft4YR8kQHQo0z5PCDf
	pi+FukP/dPCo0gT5FuvdmEd9h2/IL9yUZyYPhqdeHYEU2Io+Qyl12Y1ZZeFlIOjIWyBa56
	SsgIKZtpXMXlieraSIDwvwaPaH/ii9XkfaqJIvZolKQVQCHwlaeffWlwBE3zEAVaV4vW+F
	FjTZxfml0qnjylerznAvbnRECVL+HcNkHfqdZvxdkt9fnKGNy63ekBFaU/25xQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726563256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=kHFPmUTSuZGStloUNiIFtF34lCrILlC03j/UmHX3CT8=;
	b=/xWVgwnNeMdLoThtlfUN80L1RbyBObAcW2WN1b5le3wf5DnTcFd6xmv/MXO3V5sAIfle0o
	3+77L9EeJuyxxaBg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/mm for v6.12-rc1
References: <172656198112.2471820.6226852046770294674.tglx@xen13>
Message-ID: <172656199227.2471820.13578261908219597067.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 10:54:15 +0200 (CEST)

Linus,

please pull the latest x86/mm branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2024-09-17

up to:  50c6dbdfd16e: x86/ioremap: Improve iounmap() address range checks

Updates for x86 memory management:

 - Make LAM enablement safe vs. kernel threads using a process mm
   temporarily as switching back to the process would not update CR3 and
   therefore not enable LAM causing faults in user space when using tagged
   pointers. Cure it by synchronizing LAM enablement via IPIs to all CPUs
   which use the related mm.

 - Cure a LAM harmless inconsistency between CR3 and the state during
   context switch. It's both confusing and prone to lead to real bugs

 - Handle alt stack handling for threads which run with a non-zero
   protection key. The non-zero key prevents the kernel to access the
   alternate stack. Cure it by temporarily enabling all protection keys for
   the alternate stack setup/restore operations.

 - Provide a EFI config table identity mapping for kexec kernel to prevent
   kexec fails because the new kernel cannot access the config table array

 - Use GB pages only when a full GB is mapped in the identity map as
   otherwise the CPU can speculate into reserved areas after the end of
   memory which causes malfunction on UV systems.

 - Remove the noisy and pointless SRAT table dump during boot

 - Use is_ioremap_addr() for iounmap() address range checks instead of
   high_memory. is_ioremap_addr() is more precise.


Thanks,

	tglx

------------------>
Aruna Ramakrishna (4):
      x86/pkeys: Add PKRU as a parameter in signal handling functions
      x86/pkeys: Add helper functions to update PKRU on the sigframe
      x86/pkeys: Update PKRU to enable all pkeys before XSAVE
      x86/pkeys: Restore altstack access in sigreturn()

Keith Lucas (1):
      selftests/mm: Add new testcases for pkeys

Li RongQing (1):
      x86/mm: Don't print out SRAT table information

Max Ramanouski (1):
      x86/ioremap: Improve iounmap() address range checks

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Tao Liu (1):
      x86/kexec: Add EFI config table identity mapping for kexec kernel

Yosry Ahmed (4):
      x86/mm: Use IPIs to synchronize LAM enablement
      x86/mm: Fix LAM inconsistency during context switch
      x86/mm: Cleanup prctl_enable_tagged_addr() nr_bits error checking
      x86/mm: Remove unused CR3_HW_ASID_BITS

Yue Haibing (1):
      x86/mm: Remove unused NX related declarations

Yuntao Wang (1):
      x86/mm: Remove duplicate check from build_cr3()


 arch/x86/include/asm/fpu/signal.h                  |   2 +-
 arch/x86/include/asm/mmu_context.h                 |   8 +-
 arch/x86/include/asm/pgtable_types.h               |   2 -
 arch/x86/include/asm/tlbflush.h                    |   9 +-
 arch/x86/kernel/fpu/signal.c                       |  27 +-
 arch/x86/kernel/fpu/xstate.c                       |  13 +
 arch/x86/kernel/fpu/xstate.h                       |   2 +
 arch/x86/kernel/machine_kexec_64.c                 |  27 ++
 arch/x86/kernel/process_64.c                       |  42 +-
 arch/x86/kernel/signal.c                           |  29 +-
 arch/x86/kernel/signal_64.c                        |   6 +-
 arch/x86/mm/ident_map.c                            |  23 +-
 arch/x86/mm/ioremap.c                              |   3 +-
 arch/x86/mm/srat.c                                 |   6 +-
 arch/x86/mm/tlb.c                                  |  19 +-
 include/linux/ioremap.h                            |   1 +
 tools/testing/selftests/mm/Makefile                |   1 +
 tools/testing/selftests/mm/pkey-helpers.h          |  13 +-
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 481 +++++++++++++++++++=
++
 tools/testing/selftests/mm/protection_keys.c       |  10 -
 20 files changed, 664 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c

diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/sig=
nal.h
index 611fa41711af..eccc75bc9c4f 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -29,7 +29,7 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
=20
 unsigned long fpu__get_fpstate_size(void);
=20
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int =
size);
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int =
size, u32 pkru);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
=20
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_co=
ntext.h
index 8dac45a2c7fc..19091ebb8633 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -88,7 +88,13 @@ static inline void switch_ldt(struct mm_struct *prev, stru=
ct mm_struct *next)
 #ifdef CONFIG_ADDRESS_MASKING
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
-	return mm->context.lam_cr3_mask;
+	/*
+	 * When switch_mm_irqs_off() is called for a kthread, it may race with
+	 * LAM enablement. switch_mm_irqs_off() uses the LAM mask to do two
+	 * things: populate CR3 and populate 'cpu_tlbstate.lam'. Make sure it
+	 * reads a single value for both.
+	 */
+	return READ_ONCE(mm->context.lam_cr3_mask);
 }
=20
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgta=
ble_types.h
index 2f321137736c..6f82e75b6149 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -517,8 +517,6 @@ typedef struct page *pgtable_t;
=20
 extern pteval_t __supported_pte_mask;
 extern pteval_t __default_kernel_pte_mask;
-extern void set_nx(void);
-extern int nx_enabled;
=20
 #define pgprot_writecombine	pgprot_writecombine
 extern pgprot_t pgprot_writecombine(pgprot_t prot);
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 25726893c6f4..69e79fff41b8 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -399,11 +399,10 @@ static inline  u64 tlbstate_lam_cr3_mask(void)
 	return lam << X86_CR3_LAM_U57_BIT;
 }
=20
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
-	this_cpu_write(cpu_tlbstate.lam,
-		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
-	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
+	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, untag_mask);
 }
=20
 #else
@@ -413,7 +412,7 @@ static inline u64 tlbstate_lam_cr3_mask(void)
 	return 0;
 }
=20
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
 }
 #endif
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 247f2225aa9f..1065ab995305 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -63,6 +63,16 @@ static inline bool check_xstate_in_sigframe(struct fxregs_=
state __user *fxbuf,
 	return true;
 }
=20
+/*
+ * Update the value of PKRU register that was already pushed onto the signal=
 frame.
+ */
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u3=
2 pkru)
+{
+	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
+		return 0;
+	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFE=
ATURE_PKRU));
+}
+
 /*
  * Signal frame handlers.
  */
@@ -156,10 +166,17 @@ static inline bool save_xstate_epilog(void __user *buf,=
 int ia32_frame,
 	return !err;
 }
=20
-static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
+static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u3=
2 pkru)
 {
-	if (use_xsave())
-		return xsave_to_user_sigframe(buf);
+	int err =3D 0;
+
+	if (use_xsave()) {
+		err =3D xsave_to_user_sigframe(buf);
+		if (!err)
+			err =3D update_pkru_in_sigframe(buf, pkru);
+		return err;
+	}
+
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
@@ -185,7 +202,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_st=
ate __user *buf)
  * For [f]xsave state, update the SW reserved fields in the [f]xsave frame
  * indicating the absence/presence of the extended state to the user.
  */
-bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int siz=
e)
+bool copy_fpstate_to_sigframe(void __user *buf, void __user *buf_fx, int siz=
e, u32 pkru)
 {
 	struct task_struct *tsk =3D current;
 	struct fpstate *fpstate =3D tsk->thread.fpu.fpstate;
@@ -228,7 +245,7 @@ bool copy_fpstate_to_sigframe(void __user *buf, void __us=
er *buf_fx, int size)
 		fpregs_restore_userregs();
=20
 	pagefault_disable();
-	ret =3D copy_fpregs_to_sigframe(buf_fx);
+	ret =3D copy_fpregs_to_sigframe(buf_fx, pkru);
 	pagefault_enable();
 	fpregs_unlock();
=20
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026fee5e0..fa7628bb541b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -993,6 +993,19 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfea=
ture_nr)
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
=20
+/*
+ * Given an xstate feature nr, calculate where in the xsave buffer the state=
 is.
+ * The xsave buffer should be in standard format, not compacted (e.g. user m=
ode
+ * signal frames).
+ */
+void __user *get_xsave_addr_user(struct xregs_state __user *xsave, int xfeat=
ure_nr)
+{
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
+	return (void __user *)xsave + xstate_offsets[xfeature_nr];
+}
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
=20
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c53dcc..5f057e50df81 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -54,6 +54,8 @@ extern int copy_sigframe_from_user_to_xstate(struct task_st=
ruct *tsk, const void
 extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
=20
+extern void __user *get_xsave_addr_user(struct xregs_state __user *xsave, in=
t xfeature_nr);
+
 static inline u64 xfeatures_mask_supervisor(void)
 {
 	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kex=
ec_64.c
index cc0f7f70b17b..9c9ac606893e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/cpu.h>
+#include <asm/efi.h>
=20
 #ifdef CONFIG_ACPI
 /*
@@ -87,6 +88,8 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4=
p)
 {
 #ifdef CONFIG_EFI
 	unsigned long mstart, mend;
+	void *kaddr;
+	int ret;
=20
 	if (!efi_enabled(EFI_BOOT))
 		return 0;
@@ -102,6 +105,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *lev=
el4p)
 	if (!mstart)
 		return 0;
=20
+	ret =3D kernel_ident_mapping_init(info, level4p, mstart, mend);
+	if (ret)
+		return ret;
+
+	kaddr =3D memremap(mstart, mend - mstart, MEMREMAP_WB);
+	if (!kaddr) {
+		pr_err("Could not map UEFI system table\n");
+		return -ENOMEM;
+	}
+
+	mstart =3D efi_config_table;
+
+	if (efi_enabled(EFI_64BIT)) {
+		efi_system_table_64_t *stbl =3D (efi_system_table_64_t *)kaddr;
+
+		mend =3D mstart + sizeof(efi_config_table_64_t) * stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl =3D (efi_system_table_32_t *)kaddr;
+
+		mend =3D mstart + sizeof(efi_config_table_32_t) * stbl->nr_tables;
+	}
+
+	memunmap(kaddr);
+
 	return kernel_ident_mapping_init(info, level4p, mstart, mend);
 #endif
 	return 0;
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6d3d20e3e43a..226472332a70 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -798,6 +798,32 @@ static long prctl_map_vdso(const struct vdso_image *imag=
e, unsigned long addr)
=20
 #define LAM_U57_BITS 6
=20
+static void enable_lam_func(void *__mm)
+{
+	struct mm_struct *mm =3D __mm;
+	unsigned long lam;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) =3D=3D mm) {
+		lam =3D mm_lam_cr3_mask(mm);
+		write_cr3(__read_cr3() | lam);
+		cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
+	}
+}
+
+static void mm_enable_lam(struct mm_struct *mm)
+{
+	mm->context.lam_cr3_mask =3D X86_CR3_LAM_U57;
+	mm->context.untag_mask =3D  ~GENMASK(62, 57);
+
+	/*
+	 * Even though the process must still be single-threaded at this
+	 * point, kernel threads may be using the mm.  IPI those kernel
+	 * threads if they exist.
+	 */
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_b=
its)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
@@ -814,25 +840,21 @@ static int prctl_enable_tagged_addr(struct mm_struct *m=
m, unsigned long nr_bits)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
+	/*
+	 * MM_CONTEXT_LOCK_LAM is set on clone.  Prevent LAM from
+	 * being enabled unless the process is single threaded:
+	 */
 	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags)) {
 		mmap_write_unlock(mm);
 		return -EBUSY;
 	}
=20
-	if (!nr_bits) {
-		mmap_write_unlock(mm);
-		return -EINVAL;
-	} else if (nr_bits <=3D LAM_U57_BITS) {
-		mm->context.lam_cr3_mask =3D X86_CR3_LAM_U57;
-		mm->context.untag_mask =3D  ~GENMASK(62, 57);
-	} else {
+	if (!nr_bits || nr_bits > LAM_U57_BITS) {
 		mmap_write_unlock(mm);
 		return -EINVAL;
 	}
=20
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
-	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+	mm_enable_lam(mm);
=20
 	mmap_write_unlock(mm);
=20
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 31b6f5dddfc2..5f441039b572 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -60,6 +60,24 @@ static inline int is_x32_frame(struct ksignal *ksig)
 		ksig->ka.sa.sa_flags & SA_X32_ABI;
 }
=20
+/*
+ * Enable all pkeys temporarily, so as to ensure that both the current
+ * execution stack as well as the alternate signal stack are writeable.
+ * The application can use any of the available pkeys to protect the
+ * alternate signal stack, and we don't know which one it is, so enable
+ * all. The PKRU register will be reset to init_pkru later in the flow,
+ * in fpu__clear_user_states(), and it is the application's responsibility
+ * to enable the appropriate pkey as the first step in the signal handler
+ * so that the handler does not segfault.
+ */
+static inline u32 sig_prepare_pkru(void)
+{
+	u32 orig_pkru =3D read_pkru();
+
+	write_pkru(0);
+	return orig_pkru;
+}
+
 /*
  * Set up a signal frame.
  */
@@ -84,6 +102,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, s=
ize_t frame_size,
 	unsigned long math_size =3D 0;
 	unsigned long sp =3D regs->sp;
 	unsigned long buf_fx =3D 0;
+	u32 pkru;
=20
 	/* redzone */
 	if (!ia32_frame)
@@ -138,9 +157,17 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs,=
 size_t frame_size,
 		return (void __user *)-1L;
 	}
=20
+	/* Update PKRU to enable access to the alternate signal stack. */
+	pkru =3D sig_prepare_pkru();
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, p=
kru)) {
+		/*
+		 * Restore PKRU to the original, user-defined value; disable
+		 * extra pkeys enabled for the alternate signal stack, if any.
+		 */
+		write_pkru(pkru);
 		return (void __user *)-1L;
+	}
=20
 	return (void __user *)sp;
 }
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c5444..ee9453891901 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
=20
 	set_current_blocked(&set);
=20
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
=20
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
=20
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
=20
 	return regs->ax;
diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index c45127265f2f..437e96fb4977 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -99,18 +99,31 @@ static int ident_pud_init(struct x86_mapping_info *info, =
pud_t *pud_page,
 	for (; addr < end; addr =3D next) {
 		pud_t *pud =3D pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
=20
 		next =3D (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next =3D end;
=20
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_leaf(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage =3D info->direct_gbpages;
=20
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &=3D ((addr & ~PUD_MASK) =3D=3D 0);
+		/* ... or at the end: */
+		use_gbpage &=3D ((next & ~PUD_MASK) =3D=3D 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &=3D !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
=20
-			addr &=3D PUD_MASK;
 			pudval =3D __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index aa7d279321ea..70b02fc61d93 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/ioremap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mmiotrace.h>
@@ -457,7 +458,7 @@ void iounmap(volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;
=20
-	if ((void __force *)addr <=3D high_memory)
+	if (WARN_ON_ONCE(!is_ioremap_addr((void __force *)addr)))
 		return;
=20
 	/*
diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
index 9c52a95937ad..6f8e0f21c710 100644
--- a/arch/x86/mm/srat.c
+++ b/arch/x86/mm/srat.c
@@ -57,8 +57,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_=
affinity *pa)
 	}
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%04x -> Node %u\n",
-	       pxm, apic_id, node);
+	pr_debug("SRAT: PXM %u -> APIC 0x%04x -> Node %u\n", pxm, apic_id, node);
 }
=20
 /* Callback for Proximity Domain -> LAPIC mapping */
@@ -98,8 +97,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affi=
nity *pa)
=20
 	set_apicid_to_node(apic_id, node);
 	node_set(node, numa_nodes_parsed);
-	printk(KERN_INFO "SRAT: PXM %u -> APIC 0x%02x -> Node %u\n",
-	       pxm, apic_id, node);
+	pr_debug("SRAT: PXM %u -> APIC 0x%02x -> Node %u\n", pxm, apic_id, node);
 }
=20
 int __init x86_acpi_numa_init(void)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f3a047..86593d1b787d 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -11,6 +11,7 @@
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
=20
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -85,9 +86,6 @@
  *
  */
=20
-/* There are 12 bits of space for ASIDS in CR3 */
-#define CR3_HW_ASID_BITS		12
-
 /*
  * When enabled, MITIGATION_PAGE_TABLE_ISOLATION consumes a single bit for
  * user/kernel switches
@@ -160,7 +158,6 @@ static inline unsigned long build_cr3(pgd_t *pgd, u16 asi=
d, unsigned long lam)
 	unsigned long cr3 =3D __sme_pa(pgd) | lam;
=20
 	if (static_cpu_has(X86_FEATURE_PCID)) {
-		VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
 		cr3 |=3D kern_pcid(asid);
 	} else {
 		VM_WARN_ON_ONCE(asid !=3D 0);
@@ -503,9 +500,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct =
mm_struct *next,
 {
 	struct mm_struct *prev =3D this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid =3D this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam =3D mm_lam_cr3_mask(next);
 	bool was_lazy =3D this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu =3D smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -619,9 +616,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct =
mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
=20
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next !=3D &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
@@ -633,7 +628,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct =
mm_struct *next,
 		barrier();
 	}
=20
-	set_tlbstate_lam_mode(next);
+	new_lam =3D mm_lam_cr3_mask(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -652,6 +647,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct =
mm_struct *next,
=20
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
=20
 	if (next !=3D prev) {
 		cr4_update_pce_mm(next);
@@ -698,6 +694,7 @@ void initialize_tlbstate_and_flush(void)
 	int i;
 	struct mm_struct *mm =3D this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen =3D atomic64_read(&init_mm.context.tlb_gen);
+	unsigned long lam =3D mm_lam_cr3_mask(mm);
 	unsigned long cr3 =3D __read_cr3();
=20
 	/* Assert that CR3 already references the right mm. */
@@ -705,7 +702,7 @@ void initialize_tlbstate_and_flush(void)
=20
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
+	WARN_ON(lam);
=20
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -724,7 +721,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
=20
 	for (i =3D 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);
diff --git a/include/linux/ioremap.h b/include/linux/ioremap.h
index f0e99fc7dd8b..2bd1661fe9ad 100644
--- a/include/linux/ioremap.h
+++ b/include/linux/ioremap.h
@@ -4,6 +4,7 @@
=20
 #include <linux/kasan.h>
 #include <asm/pgtable.h>
+#include <asm/vmalloc.h>
=20
 #if defined(CONFIG_HAS_IOMEM) || defined(CONFIG_GENERIC_IOREMAP)
 /*
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm=
/Makefile
index 901e0d07765b..1f176fff7054 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -88,6 +88,7 @@ CAN_BUILD_X86_64 :=3D $(shell ./../x86/check_cc.sh "$(CC)" =
../x86/trivial_64bit_pr
 CAN_BUILD_WITH_NOPIE :=3D $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivia=
l_program.c -no-pie)
=20
 VMTARGETS :=3D protection_keys
+VMTARGETS +=3D pkey_sighandler_tests
 BINARIES_32 :=3D $(VMTARGETS:%=3D%_32)
 BINARIES_64 :=3D $(VMTARGETS:%=3D%_64)
=20
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selfte=
sts/mm/pkey-helpers.h
index 1af3156a9db8..4d31a309a46b 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -79,7 +79,18 @@ extern void abort_hooks(void);
 	}					\
 } while (0)
=20
-__attribute__((noinline)) int read_ptr(int *ptr);
+#define barrier() __asm__ __volatile__("": : :"memory")
+#ifndef noinline
+# define noinline __attribute__((noinline))
+#endif
+
+noinline int read_ptr(int *ptr)
+{
+	/* Keep GCC from optimizing this away somehow */
+	barrier();
+	return *ptr;
+}
+
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testi=
ng/selftests/mm/pkey_sighandler_tests.c
new file mode 100644
index 000000000000..a8088b645ad6
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests Memory Protection Keys (see Documentation/core-api/protection-keys.=
rst)
+ *
+ * The testcases in this file exercise various flows related to signal handl=
ing,
+ * using an alternate signal stack, with the default pkey (pkey 0) disabled.
+ *
+ * Compile with:
+ * gcc -mxsave      -o pkey_sighandler_tests -O2 -g -std=3Dgnu99 -pthread -W=
all pkey_sighandler_tests.c -I../../../../tools/include -lrt -ldl -lm
+ * gcc -mxsave -m32 -o pkey_sighandler_tests -O2 -g -std=3Dgnu99 -pthread -W=
all pkey_sighandler_tests.c -I../../../../tools/include -lrt -ldl -lm
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <limits.h>
+
+#include "pkey-helpers.h"
+
+#define STACK_SIZE PTHREAD_STACK_MIN
+
+void expected_pkey_fault(int pkey) {}
+
+pthread_mutex_t mutex =3D PTHREAD_MUTEX_INITIALIZER;
+pthread_cond_t cond =3D PTHREAD_COND_INITIALIZER;
+siginfo_t siginfo =3D {0};
+
+/*
+ * We need to use inline assembly instead of glibc's syscall because glibc's
+ * syscall will attempt to access the PLT in order to call a library function
+ * which is protected by MPK 0 which we don't have access to.
+ */
+static inline __always_inline
+long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a=
6)
+{
+	unsigned long ret;
+#ifdef __x86_64__
+	register long r10 asm("r10") =3D a4;
+	register long r8 asm("r8") =3D a5;
+	register long r9 asm("r9") =3D a6;
+	asm volatile ("syscall"
+		      : "=3Da"(ret)
+		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
+		      : "rcx", "r11", "memory");
+#elif defined __i386__
+	asm volatile ("int $0x80"
+		      : "=3Da"(ret)
+		      : "a"(n), "b"(a1), "c"(a2), "d"(a3), "S"(a4), "D"(a5)
+		      : "memory");
+#else
+# error syscall_raw() not implemented
+#endif
+	return ret;
+}
+
+static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+}
+
+static void sigusr1_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+}
+
+static void sigusr2_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	/*
+	 * pkru should be the init_pkru value which enabled MPK 0 so
+	 * we can use library functions.
+	 */
+	printf("%s invoked.\n", __func__);
+}
+
+static void raise_sigusr2(void)
+{
+	pid_t tid =3D 0;
+
+	tid =3D syscall_raw(SYS_gettid, 0, 0, 0, 0, 0, 0);
+
+	syscall_raw(SYS_tkill, tid, SIGUSR2, 0, 0, 0, 0);
+
+	/*
+	 * We should return from the signal handler here and be able to
+	 * return to the interrupted thread.
+	 */
+}
+
+static void *thread_segv_with_pkey0_disabled(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+	/* Segfault (with SEGV_MAPERR) */
+	*(int *) (0x1) =3D 1;
+	return NULL;
+}
+
+static void *thread_segv_pkuerr_stack(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+	/* After we disable MPK 0, we can't access the stack to return */
+	return NULL;
+}
+
+static void *thread_segv_maperr_ptr(void *ptr)
+{
+	stack_t *stack =3D ptr;
+	int *bad =3D (int *)1;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+	/* Disable MPK 0.  Only MPK 1 is enabled. */
+	__write_pkey_reg(0x55555551);
+
+	/* Segfault */
+	*bad =3D 1;
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0.
+ */
+static void test_sigsegv_handler_with_pkey0_disabled(void)
+{
+	struct sigaction sa;
+	pthread_attr_t attr;
+	pthread_t thr;
+
+	sa.sa_flags =3D SA_SIGINFO;
+
+	sa.sa_sigaction =3D sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) =3D=3D -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_with_pkey0_disabled, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo =3D=3D 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo =3D=3D SIGSEGV &&
+			 siginfo.si_code =3D=3D SEGV_MAPERR &&
+			 siginfo.si_addr =3D=3D (void *)1,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0, which renders them inaccessible when MPK 0
+ * is disabled. So just the return from the thread should cause a
+ * segfault with SEGV_PKUERR.
+ */
+static void test_sigsegv_handler_cannot_access_stack(void)
+{
+	struct sigaction sa;
+	pthread_attr_t attr;
+	pthread_t thr;
+
+	sa.sa_flags =3D SA_SIGINFO;
+
+	sa.sa_sigaction =3D sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) =3D=3D -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_pkuerr_stack, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo =3D=3D 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo =3D=3D SIGSEGV &&
+			 siginfo.si_code =3D=3D SEGV_PKUERR,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler that uses an alternate signal stack
+ * is correctly invoked for a thread which uses a non-zero MPK to protect
+ * its own stack, and disables all other MPKs (including 0).
+ */
+static void test_sigsegv_handler_with_different_pkey_for_stack(void)
+{
+	struct sigaction sa;
+	static stack_t sigstack;
+	void *stack;
+	int pkey;
+	int parent_pid =3D 0;
+	int child_pid =3D 0;
+
+	sa.sa_flags =3D SA_SIGINFO | SA_ONSTACK;
+
+	sa.sa_sigaction =3D sigsegv_handler;
+
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) =3D=3D -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack =3D mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack !=3D MAP_FAILED);
+
+	/* Allow access to MPK 0 and MPK 1 */
+	__write_pkey_reg(0x55555550);
+
+	/* Protect the new stack with MPK 1 */
+	pkey =3D pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+	/* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp =3D mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags =3D 0;
+	sigstack.ss_size =3D STACK_SIZE;
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	/* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret =3D syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long) ((char *)(stack) + STACK_SIZE),
+			       (long) &parent_pid,
+			       (long) &child_pid, 0, 0);
+
+	if (ret < 0) {
+		errno =3D -ret;
+		perror("clone");
+	} else if (ret =3D=3D 0) {
+		thread_segv_maperr_ptr(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo =3D=3D 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo =3D=3D SIGSEGV &&
+			 siginfo.si_code =3D=3D SEGV_MAPERR &&
+			 siginfo.si_addr =3D=3D (void *)1,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the PKRU value set by the application is correctly
+ * restored upon return from signal handling.
+ */
+static void test_pkru_preserved_after_sigusr1(void)
+{
+	struct sigaction sa;
+	unsigned long pkru =3D 0x45454544;
+
+	sa.sa_flags =3D SA_SIGINFO;
+
+	sa.sa_sigaction =3D sigusr1_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL) =3D=3D -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	__write_pkey_reg(pkru);
+
+	raise(SIGUSR1);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo =3D=3D 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	/* Ensure the pkru value is the same after returning from signal. */
+	ksft_test_result(pkru =3D=3D __read_pkey_reg() &&
+			 siginfo.si_signo =3D=3D SIGUSR1,
+			 "%s\n", __func__);
+}
+
+static noinline void *thread_sigusr2_self(void *ptr)
+{
+	/*
+	 * A const char array like "Resuming after SIGUSR2" won't be stored on
+	 * the stack and the code could access it via an offset from the program
+	 * counter. This makes sure it's on the function's stack frame.
+	 */
+	char str[] =3D {'R', 'e', 's', 'u', 'm', 'i', 'n', 'g', ' ',
+		'a', 'f', 't', 'e', 'r', ' ',
+		'S', 'I', 'G', 'U', 'S', 'R', '2',
+		'.', '.', '.', '\n', '\0'};
+	stack_t *stack =3D ptr;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+	syscall(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+	/* Disable MPK 0.  Only MPK 2 is enabled. */
+	__write_pkey_reg(0x55555545);
+
+	raise_sigusr2();
+
+	/* Do something, to show the thread resumed execution after the signal */
+	syscall_raw(SYS_write, 1, (long) str, sizeof(str) - 1, 0, 0, 0);
+
+	/*
+	 * We can't return to test_pkru_sigreturn because it
+	 * will attempt to use a %rbp value which is on the stack
+	 * of the main thread.
+	 */
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that sigreturn is able to restore altstack even if the thread had
+ * disabled pkey 0.
+ */
+static void test_pkru_sigreturn(void)
+{
+	struct sigaction sa =3D {0};
+	static stack_t sigstack;
+	void *stack;
+	int pkey;
+	int parent_pid =3D 0;
+	int child_pid =3D 0;
+
+	sa.sa_handler =3D SIG_DFL;
+	sa.sa_flags =3D 0;
+	sigemptyset(&sa.sa_mask);
+
+	/*
+	 * For this testcase, we do not want to handle SIGSEGV. Reset handler
+	 * to default so that the application can crash if it receives SIGSEGV.
+	 */
+	if (sigaction(SIGSEGV, &sa, NULL) =3D=3D -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	sa.sa_flags =3D SA_SIGINFO | SA_ONSTACK;
+	sa.sa_sigaction =3D sigusr2_handler;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(SIGUSR2, &sa, NULL) =3D=3D -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack =3D mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack !=3D MAP_FAILED);
+
+	/*
+	 * Allow access to MPK 0 and MPK 2. The child thread (to be created
+	 * later in this flow) will have its stack protected by MPK 2, whereas
+	 * the current thread's stack is protected by the default MPK 0. Hence
+	 * both need to be enabled.
+	 */
+	__write_pkey_reg(0x55555544);
+
+	/* Protect the stack with MPK 2 */
+	pkey =3D pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+	/* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp =3D mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags =3D 0;
+	sigstack.ss_size =3D STACK_SIZE;
+
+	/* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret =3D syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long) ((char *)(stack) + STACK_SIZE),
+			       (long) &parent_pid,
+			       (long) &child_pid, 0, 0);
+
+	if (ret < 0) {
+		errno =3D -ret;
+		perror("clone");
+	}  else if (ret =3D=3D 0) {
+		thread_sigusr2_self(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	child_pid =3D  ret;
+	/* Check that thread exited */
+	do {
+		sched_yield();
+		ret =3D syscall_raw(SYS_tkill, child_pid, 0, 0, 0, 0, 0);
+	} while (ret !=3D -ESRCH && ret !=3D -EINVAL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static void (*pkey_tests[])(void) =3D {
+	test_sigsegv_handler_with_pkey0_disabled,
+	test_sigsegv_handler_cannot_access_stack,
+	test_sigsegv_handler_with_different_pkey_for_stack,
+	test_pkru_preserved_after_sigusr1,
+	test_pkru_sigreturn
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(pkey_tests));
+
+	for (i =3D 0; i < ARRAY_SIZE(pkey_tests); i++)
+		(*pkey_tests[i])();
+
+	ksft_finished();
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/sel=
ftests/mm/protection_keys.c
index eaa6d1fc5328..cc6de1644360 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -950,16 +950,6 @@ void close_test_fds(void)
 	nr_test_fds =3D 0;
 }
=20
-#define barrier() __asm__ __volatile__("": : :"memory")
-__attribute__((noinline)) int read_ptr(int *ptr)
-{
-	/*
-	 * Keep GCC from optimizing this away somehow
-	 */
-	barrier();
-	return *ptr;
-}
-
 void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 {
 	int i, err;



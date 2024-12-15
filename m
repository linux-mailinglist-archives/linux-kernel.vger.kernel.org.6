Return-Path: <linux-kernel+bounces-446473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D799F24C1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5DD1884965
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8AC21922D4;
	Sun, 15 Dec 2024 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWPQVLTD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB36148FE6
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734279220; cv=none; b=JJzq2vtZfIc60iPAzumJs3uPFRI6SgjADSmf54GQWlBzpHm1W/kJSjxWc97x9REE0kA8UMZG0MmQ0mc5uCG/dH5jQjAv0+79QVsgg98V35ixrIJSQWHRcnDeoTu3aErm5N+Ihp9CZtGov4sEe6xcyMImMZOdhUxZoj/UP1lbQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734279220; c=relaxed/simple;
	bh=IKAxgRIJnhSSWOi/XLmBHOVDaXtl12q5iO+oDI9X5I8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvLheCAWUr2ClN/Lgw6tExlfB3WOil90kRUw+0S4Y3aeFB5taxgnuBsXwlEzL/EC3JOkGO3Y0t5mqGp0/oeaYp0x+S7pUFiYWgiNwL0cvHORIjnwKd3/6LaCTXXjcSMlcPdHfKsOQvqojrnC9zja4RMQlEsbtacOIoeGAb3thCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWPQVLTD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24B0C4CECE;
	Sun, 15 Dec 2024 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734279219;
	bh=IKAxgRIJnhSSWOi/XLmBHOVDaXtl12q5iO+oDI9X5I8=;
	h=From:To:Cc:Subject:Date:From;
	b=aWPQVLTDU8gXqxvvYbQ5od/w0EQywkHpDG4rtm4EszdZxE075eDxq9RmsvbeBVXBZ
	 ekn6e6H46FE57EqBSUsBCURP+i56daD7e7cy4m6H0CLi7WHPH1DWUkZ4PIpcUnPGKH
	 m0F35PWJgpFf2hAdid+CfPFZ0imenjMT3hntU+bZ4Yme13KI7omNyTaoc3YKNf/IPC
	 9jkZxk15ZY93qM8bFGCqvcA6JtpuMUHB7AHrRV3d0yXt0WUrU/hYxcGoFZsDjCp4wV
	 yD5IVSwT4mwA4Lt0rlQkwy5L4ijkw27aO/otTlRNqgO1McX9I47fT7xNWZGienKu10
	 V/K48J1JO2vQA==
From: guoren@kernel.org
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	guoren@kernel.org,
	bjorn@rivosinc.com,
	conor@kernel.org,
	leobras@redhat.com,
	alexghiti@rivosinc.com,
	atishp@rivosinc.com,
	apatel@ventanamicro.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	parri.andrea@gmail.com,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: qspinlock: Add virt_spin_lock() support for KVM guests
Date: Sun, 15 Dec 2024 11:13:22 -0500
Message-Id: <20241215161322.460832-1-guoren@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

Add a static key controlling whether virt_spin_lock() should be
called or not. When running on bare metal set the new key to
false.

The VM guests should fall back to a Test-and-Set spinlock,
because fair locks have horrible lock 'holder' preemption issues.
The virt_spin_lock_key would shortcut for the queued_spin_lock_-
slowpath() function that allow virt_spin_lock to hijack it.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/sbi.h      | 16 ++++++++++++++++
 arch/riscv/include/asm/spinlock.h | 25 +++++++++++++++++++++++++
 arch/riscv/kernel/sbi.c           |  2 +-
 arch/riscv/kernel/setup.c         | 17 +++++++++++++++++
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6c82318065cf..076ae2eb15a1 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -55,6 +55,21 @@ enum sbi_ext_base_fid {
 	SBI_EXT_BASE_GET_MIMPID,
 };
 
+enum sbi_ext_base_impl_id {
+	SBI_EXT_BASE_IMPL_ID_BBL = 0,
+	SBI_EXT_BASE_IMPL_ID_OPENSBI,
+	SBI_EXT_BASE_IMPL_ID_XVISOR,
+	SBI_EXT_BASE_IMPL_ID_KVM,
+	SBI_EXT_BASE_IMPL_ID_RUSTSBI,
+	SBI_EXT_BASE_IMPL_ID_DIOSIX,
+	SBI_EXT_BASE_IMPL_ID_COFFER,
+	SBI_EXT_BASE_IMPL_ID_XEN,
+	SBI_EXT_BASE_IMPL_ID_POLARFIRE,
+	SBI_EXT_BASE_IMPL_ID_COREBOOT,
+	SBI_EXT_BASE_IMPL_ID_OREBOOT,
+	SBI_EXT_BASE_IMPL_ID_BHYVE,
+};
+
 enum sbi_ext_time_fid {
 	SBI_EXT_TIME_SET_TIMER = 0,
 };
@@ -444,6 +459,7 @@ static inline int sbi_console_getchar(void) { return -ENOENT; }
 long sbi_get_mvendorid(void);
 long sbi_get_marchid(void);
 long sbi_get_mimpid(void);
+long sbi_get_firmware_id(void);
 void sbi_set_timer(uint64_t stime_value);
 void sbi_shutdown(void);
 void sbi_send_ipi(unsigned int cpu);
diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/asm/spinlock.h
index e5121b89acea..bcbb38194237 100644
--- a/arch/riscv/include/asm/spinlock.h
+++ b/arch/riscv/include/asm/spinlock.h
@@ -42,6 +42,31 @@ SPINLOCK_BASE_DECLARE(value_unlocked, int, arch_spinlock_t)
 
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/jump_label.h>
+
+/*
+ * The KVM guests fall back to a Test-and-Set spinlock, because fair locks
+ * have horrible lock 'holder' preemption issues. The test_and_set_spinlock_key
+ * would shortcut for the queued_spin_lock_slowpath() function that allow
+ * virt_spin_lock to hijack it.
+ */
+DECLARE_STATIC_KEY_FALSE(test_and_set_spinlock_key);
+
+#define virt_spin_lock test_and_set_spinlock
+static inline bool test_and_set_spinlock(struct qspinlock *lock)
+{
+	if (!static_branch_likely(&test_and_set_spinlock_key))
+		return false;
+
+	do {
+		smp_cond_load_relaxed((s32 *)&lock->val, VAL == 0);
+	} while (atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL) != 0);
+
+	return true;
+}
+#endif
+
 #include <asm/qrwlock.h>
 
 #endif /* __ASM_RISCV_SPINLOCK_H */
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1989b8cade1b..2cbacc345e5d 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -488,7 +488,7 @@ static inline long sbi_get_spec_version(void)
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
 }
 
-static inline long sbi_get_firmware_id(void)
+long sbi_get_firmware_id(void)
 {
 	return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
 }
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 45010e71df86..7e98c1c8ff0d 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -249,6 +249,16 @@ DEFINE_STATIC_KEY_TRUE(qspinlock_key);
 EXPORT_SYMBOL(qspinlock_key);
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+DEFINE_STATIC_KEY_FALSE(test_and_set_spinlock_key);
+
+static void __init virt_spin_lock_init(void)
+{
+	if (sbi_get_firmware_id() == SBI_EXT_BASE_IMPL_ID_KVM)
+		static_branch_enable(&test_and_set_spinlock_key);
+}
+#endif
+
 static void __init riscv_spinlock_init(void)
 {
 	char *using_ext = NULL;
@@ -274,10 +284,17 @@ static void __init riscv_spinlock_init(void)
 	}
 #endif
 
+#ifdef CONFIG_QUEUED_SPINLOCKS
+	virt_spin_lock_init();
+
+	if (sbi_get_firmware_id() == SBI_EXT_BASE_IMPL_ID_KVM)
+		using_ext = "using test and set\n";
+
 	if (!using_ext)
 		pr_err("Queued spinlock without Zabha or Ziccrse");
 	else
 		pr_info("Queued spinlock %s: enabled\n", using_ext);
+#endif
 }
 
 extern void __init init_rt_signal_env(void);
-- 
2.40.1



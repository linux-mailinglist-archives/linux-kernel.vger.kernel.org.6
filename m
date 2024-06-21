Return-Path: <linux-kernel+bounces-224657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E194912569
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B2EB25246
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14683155CA6;
	Fri, 21 Jun 2024 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LPzZdzJq"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69703155758
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973170; cv=none; b=ryNboNE9RwLy10v5d1oWpkyLmqAJWCqpYHrRCW1HBTuztkFI0Wi0DVO7GxTNmmLe/O7l6eaxhDua/jNpldl9EcpLvc8G8zx3ZVTFJSZWoDE8pwT0CAKbBhR/iUh2GXD7AxZ1KqMbuFaXg+bkDZmELzRq0im7gILpgvtuasDhPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973170; c=relaxed/simple;
	bh=gZiZQA10hsX/A8UdCM913FUy2l9+6hDOMmJ2u3LLsII=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IHtgtGlBXPzRKcfoc6gBgI/r9v6e3Fd99XUjHRL1A/0RrHuAphPYi7agYS3s7NvKb2TrroreS6B9+OTTuOb4g3agZecBRArgXIHUVTK72P2nmPxbzz9bQCn/ufdmbaGnvyiK/eMh1YqARKglCpQ31DC/5zXx5gQzPw2oNfU6130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LPzZdzJq; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42476eda16cso17273785e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718973167; x=1719577967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9U3k9tuiLiLPQI9AWIU2sX6N77nYvdH988sCBf+PvC0=;
        b=LPzZdzJqgBFwWb6lTnaepoUDXuzhCe/ETdq/4OC5VDVmXEIvJFZEeJZBPLKpOx+6M6
         M0heA690Cf7cyYKe2qnYCc3BlAiRO6dzhC3r8lnHk1DAAvg/8b09tSqZy8tDj/M/1lse
         TV9gj1OBoFTEPPNI6L1nBov1CsnzYdGrFh0B1Kodio27OEg3ZSdR4hNszAwzN+WPgLek
         4T0NfSm7K+T3aFPsWB6qg5hh5NWedhM1DMSSa/Ia+lPF1cQVcES6GLeCZG119nhSLU4M
         jmZQ0q8oU2oHX0pGF1JZLmuloYiC+WE2SROPXS8g8IVeajjemsak7racaplXgVeCoDu1
         kyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973167; x=1719577967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9U3k9tuiLiLPQI9AWIU2sX6N77nYvdH988sCBf+PvC0=;
        b=llLFf6K1GhhqeUd5XwTv5afKfs9BTTXk9oq+vIrQU/3nnwTTQwbXGpPHmX7GMIMLeZ
         WK58Xq6v62pWaYo47OUBCabMe0H9ShXf2Z8tSW1t9Lc7M8PupLmTQPrbuLF4hCSiJUI/
         VGJmgAD4ZtKnTaPhU5A6EhfT0AuyqeMYegXP+J9Y5M1CrzvpAFx1z47xmaHYGNKHl0gA
         hcDKQCudo22EXPRHQhIv1Eds6T/U/BEnSaot0QKO2xFleOf9AZAx3tQmT6zbYknmJImN
         FWLY3y1fWifGNjKRFZ/IG6BGBP0zLwlNfQHBUGWUiPBcadzyKEYXPYcTSIbzzUkKlnUQ
         CEZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqkgt+1V6reEN/JUQx1h03knlKRuT7RVyMtR3Vt4PWqEs/LkasJKyVxuz1PCiw1Sjheht+ALw9YKOEubAP4QEgeRTEKu8ygn4fh5bc
X-Gm-Message-State: AOJu0YxontPNsZ8PhPoIMekl5Ea6sj4bca339E2cZMnd1hPGSEA1YfW8
	wB2n2y9Z5PoNpB5c6N3EwnfVM1GtdADEAtx3ycfZ1YeqNblOFbUU7JmEiIh90oWaE3MLbpkWKxg
	vaGt5xvg2Jki9XeQbN6Q/DwSLlQ==
X-Google-Smtp-Source: AGHT+IG3jjLLcKVegMc4vyKOfpAyq0Mm/2rzRvjshonLnHB/hIPzh7SyEtIPV2JFArbLo1dzzIgE39ZKxihe/rCGybM=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:1c01:b0:424:813e:73c7 with
 SMTP id 5b1f17b1804b1-424813e750emr123495e9.2.1718973166688; Fri, 21 Jun 2024
 05:32:46 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:32:28 +0000
In-Reply-To: <20240621123230.1085265-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621123230.1085265-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621123230.1085265-5-sebastianene@google.com>
Subject: [PATCH v7 4/6] KVM: arm64: Register ptdump with debugfs on guest creation
From: Sebastian Ene <sebastianene@google.com>
To: akpm@linux-foundation.org, alexghiti@rivosinc.com, ankita@nvidia.com, 
	ardb@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, 
	james.morse@arm.com, vdonnefort@google.com, mark.rutland@arm.com, 
	maz@kernel.org, oliver.upton@linux.dev, rananta@google.com, 
	ryan.roberts@arm.com, sebastianene@google.com, shahuang@redhat.com, 
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

While arch/*/mem/ptdump handles the kernel pagetable dumping code,
introduce KVM/ptdump which shows the guest stage-2 pagetables. The
separation is necessary because most of the definitions from the
stage-2 pagetable reside in the KVM path and we will be invoking
functionality **specific** to KVM.

When a guest is created, register a new file entry under the guest
debugfs dir which allows userspace to show the contents of the guest
stage-2 pagetables when accessed.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/Kconfig      | 14 ++++++
 arch/arm64/kvm/Makefile     |  1 +
 arch/arm64/kvm/arm.c        |  2 +
 arch/arm64/kvm/kvm_ptdump.h | 20 ++++++++
 arch/arm64/kvm/ptdump.c     | 91 +++++++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+)
 create mode 100644 arch/arm64/kvm/kvm_ptdump.h
 create mode 100644 arch/arm64/kvm/ptdump.c

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 58f09370d17e..99e4a82e141d 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -65,4 +65,18 @@ config PROTECTED_NVHE_STACKTRACE
 
 	  If unsure, or not using protected nVHE (pKVM), say N.
 
+config PTDUMP_STAGE2_DEBUGFS
+       bool "Present the stage-2 pagetables to debugfs"
+       depends on KVM
+       select PTDUMP_CORE
+       default n
+       help
+         Say Y here if you want to show the stage-2 kernel pagetables
+         layout in a debugfs file. This information is only useful for kernel developers
+         who are working in architecture specific areas of the kernel.
+         It is probably not a good idea to enable this feature in a production
+         kernel.
+
+         If in doubt, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index a6497228c5a8..f6ef4140b20a 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -24,6 +24,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
+kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 59716789fe0f..310abc612965 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -45,6 +45,7 @@
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
+#include <kvm_ptdump.h>
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
 
@@ -216,6 +217,7 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
 void kvm_arch_create_vm_debugfs(struct kvm *kvm)
 {
 	kvm_sys_regs_create_debugfs(kvm);
+	kvm_ptdump_guest_register(kvm);
 }
 
 static void kvm_destroy_mpidr_data(struct kvm *kvm)
diff --git a/arch/arm64/kvm/kvm_ptdump.h b/arch/arm64/kvm/kvm_ptdump.h
new file mode 100644
index 000000000000..0a62b0e2908c
--- /dev/null
+++ b/arch/arm64/kvm/kvm_ptdump.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) Google, 2024
+ * Author: Sebastian Ene <sebastianene@google.com>
+ */
+
+#ifndef __KVM_PTDUMP_H
+#define __KVM_PTDUMP_H
+
+#include <linux/kvm_host.h>
+#include <asm/ptdump.h>
+
+
+#ifdef CONFIG_PTDUMP_STAGE2_DEBUGFS
+void kvm_ptdump_guest_register(struct kvm *kvm);
+#else
+static inline void kvm_ptdump_guest_register(struct kvm *kvm) {}
+#endif /* CONFIG_PTDUMP_STAGE2_DEBUGFS */
+
+#endif /* __KVM_PTDUMP_H */
diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
new file mode 100644
index 000000000000..36dc7662729f
--- /dev/null
+++ b/arch/arm64/kvm/ptdump.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Debug helper used to dump the stage-2 pagetables of the system and their
+ * associated permissions.
+ *
+ * Copyright (C) Google, 2024
+ * Author: Sebastian Ene <sebastianene@google.com>
+ */
+#include <linux/debugfs.h>
+#include <linux/kvm_host.h>
+#include <linux/seq_file.h>
+
+#include <asm/kvm_pgtable.h>
+#include <kvm_ptdump.h>
+
+
+static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
+			      enum kvm_pgtable_walk_flags visit)
+{
+	struct pg_state *st = ctx->arg;
+	struct ptdump_state *pt_st = &st->ptdump;
+
+	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
+	return 0;
+}
+
+static int kvm_ptdump_show_common(struct seq_file *m,
+				  struct kvm_pgtable *pgtable,
+				  struct pg_state *parser_state)
+{
+	struct kvm_pgtable_walker walker = (struct kvm_pgtable_walker) {
+		.cb     = kvm_ptdump_visitor,
+		.arg	= parser_state,
+		.flags	= KVM_PGTABLE_WALK_LEAF,
+	};
+
+	parser_state->level = -1;
+	parser_state->start_address = 0;
+
+	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
+}
+
+static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
+{
+	struct kvm *kvm = m->private;
+	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
+	struct pg_state parser_state = {0};
+	int ret;
+
+	write_lock(&kvm->mmu_lock);
+	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
+	write_unlock(&kvm->mmu_lock);
+
+	return ret;
+}
+
+static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+	int ret;
+
+	if (!kvm_get_kvm_safe(kvm))
+		return -ENOENT;
+
+	ret = single_open(file, kvm_ptdump_guest_show, m->i_private);
+	if (ret < 0)
+		kvm_put_kvm(kvm);
+
+	return ret;
+}
+
+static int kvm_ptdump_guest_close(struct inode *m, struct file *file)
+{
+	struct kvm *kvm = m->i_private;
+
+	kvm_put_kvm(kvm);
+	return single_release(m, file);
+}
+
+static const struct file_operations kvm_ptdump_guest_fops = {
+	.open		= kvm_ptdump_guest_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= kvm_ptdump_guest_close,
+};
+
+void kvm_ptdump_guest_register(struct kvm *kvm)
+{
+	debugfs_create_file("stage2_page_tables", 0400, kvm->debugfs_dentry,
+			    kvm, &kvm_ptdump_guest_fops);
+}
-- 
2.45.2.741.gdbec12cfda-goog



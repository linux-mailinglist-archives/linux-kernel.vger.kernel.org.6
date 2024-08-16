Return-Path: <linux-kernel+bounces-289665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E48C9548E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E251C24047
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC681BB68D;
	Fri, 16 Aug 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z/zksaoL"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73771AE87B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811966; cv=none; b=mAmah2o6cM1IU4YkBEvK/h5JTAfqADiculW3kv1GCdW9dIG0yZ75JoJUtx4PnYe4gz7asVOr00q8DfPLYuRqFOfaN3QyDDY51tnCaqokeYZ4QZn0WSb/IXWJb5l383ociNVuaTpptFcCfpravkHBKsuf8Ayyxk9XTKBGTSfrF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811966; c=relaxed/simple;
	bh=8Cexea0dzRdr47M50Br5yJsGcLhFPUvBxCXJPUnZwzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nvALs+EgRwVK1rFEybjb7Kmtc1Nc9TM5Yq00EIcW58VZ46OoZS3nucnbCSzzNsztg/TrEyCRw6XSfraFdfJevb6Vcm73tg3rGqwusA/sJfXSUIDWPAPdK0c/jqso1sq2MZobGZBOFRqcep8kdjaS37BqeYRdxMvXxHyKkcOEqhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z/zksaoL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1159fb161fso2892523276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723811964; x=1724416764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czjtgk0THntC/xnLf2aWE5vi1aKv5GZ9fmo01l7czSk=;
        b=z/zksaoLlv50W6c9qqfYFfBbplZ6GGQ9Orkil5kBlIycOjcF9sil3H3a0F5ssdCns3
         Sv4CWxx7j2h/jN3PpWj2S+ua0VemDDpvoHD0LWuZ4zi/Sc2Rouug8b3BQSGlv39irpAb
         ppH1KjvNjK6s4r6q5adsTl0XiL2zXfuPXbDNAWVQAJ9HenTBoc2DzAdtN0SgBLKTyWuq
         3WmwQQDtf+ZrkYmsRqWrauGE820/sdKPLOHxXDtfLczA86rvjfIBNL+om+3lIQRDlTA2
         KTma1FeEA2/60+wJa+PCnJ1eG+DkZcD2cQswWACqLkuKoteOAgu3iTlrzQjfs3UoDyQt
         mbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811964; x=1724416764;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czjtgk0THntC/xnLf2aWE5vi1aKv5GZ9fmo01l7czSk=;
        b=agMgq1OwkT64hFxNIVfT/F+ZdkzJFqpYKvVOTmTfYN8YcA+75e73+snDvJquLIzzH0
         VaBxBU1VaDpA838hUNoSmLLMLunPiiRNy1HsGOJGPJSnS5Hy1HDw+dfpra5XOwrMka3q
         EbUiH7EKdJn13HszKoM9glRM+E8md88grZBRk0KCLwTYEFXGq+wzSp74lYiMo9nNfxp/
         u+PqIemXpPO4E0pVCsU8FXqKYNhpPUXqvClE/GrWYHJvNinSumzXZiEhiaIg4OhePymv
         7WK2vHb1cnOD9rXkO167v+lsG2TEayAD/JPWftV8PnZcABqS+1PJfXIDO6krspRJYEO1
         OTjA==
X-Forwarded-Encrypted: i=1; AJvYcCX6D9TZZMmPaH5EVoFVhAZG2f8ykc1Y78XLxo6e+GL4+WNaBymIlT7+h042gAy9VYw9ckW4hZ+fAaR5KqpK1A9Vi+ErM2LHHywROITh
X-Gm-Message-State: AOJu0YxfpSa/4x+5fuqMN7dAywVFdSKE+NZVTAbDAkQi3TEljT5M6OsR
	wrDML0xs1eVk/xA9LwZiwn4piusylpMa+H2P0TcZKxaqL7sMT+KlFp6dCqwPEKobMJDdoCu4fC/
	HGsNL4mLcsoXeeZicI14fbDM1nw==
X-Google-Smtp-Source: AGHT+IEBl2Jwr492NkaB67XJngVIdAPNlygBC/0Vw/Bc+AHOUtSwJrRm/7vBBySziaJP1f/tml+FbOFt7tZsvUVVL0c=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a25:910e:0:b0:e03:59e2:e82 with SMTP
 id 3f1490d57ef6-e1180fb2b4dmr4115276.10.1723811963785; Fri, 16 Aug 2024
 05:39:23 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:39:04 +0000
In-Reply-To: <20240816123906.3683425-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816123906.3683425-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816123906.3683425-5-sebastianene@google.com>
Subject: [PATCH v8 4/6] KVM: arm64: Register ptdump with debugfs on guest creation
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
index 8304eb342be9..fcc41e58ede6 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -66,4 +66,18 @@ config PROTECTED_NVHE_STACKTRACE
 
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
index 86a629aaf0a1..e4233b323a73 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -27,6 +27,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 
 kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
 kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
+kvm-$(CONFIG_PTDUMP_STAGE2_DEBUGFS) += ptdump.o
 
 always-y := hyp_constants.h hyp-constants.s
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 9bef7638342e..60fed2146763 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -45,6 +45,7 @@
 #include <kvm/arm_hypercalls.h>
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_psci.h>
+#include <kvm_ptdump.h>
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
 
@@ -228,6 +229,7 @@ vm_fault_t kvm_arch_vcpu_fault(struct kvm_vcpu *vcpu, struct vm_fault *vmf)
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
index 000000000000..52483d56be2e
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
+	struct ptdump_pg_state *st = ctx->arg;
+	struct ptdump_state *pt_st = &st->ptdump;
+
+	note_page(pt_st, ctx->addr, ctx->level, ctx->old);
+	return 0;
+}
+
+static int kvm_ptdump_show_common(struct seq_file *m,
+				  struct kvm_pgtable *pgtable,
+				  struct ptdump_pg_state *parser_state)
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
+	struct ptdump_pg_state parser_state = {0};
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
2.46.0.184.g6999bdac58-goog



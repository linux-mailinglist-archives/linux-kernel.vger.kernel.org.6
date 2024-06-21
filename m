Return-Path: <linux-kernel+bounces-224658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1143D91256A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1F102811EF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028215625B;
	Fri, 21 Jun 2024 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JhCMMFTu"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB56155C9E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973172; cv=none; b=P/2K45ttskR3m9syXwliiUAPbmspCzlMEAznJwFk3pu9rsIlj7RTJurSLBAgiNmiMH7q5nZ83UMvCUyr6LdhII0FuRVSuP2ZUi9vnuJbX9o5a9iaaeiSSz8j3RJ3XRAwcNcHRCZGQYeb8X/S62wCDd9OqX6s2nEhk84uvZGAZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973172; c=relaxed/simple;
	bh=q7cmS7gvGT06Vyut3Tk2BvR446OmDqE4CKGPTHaUrAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iStV9W1Mcj91t70u6cgsbS9TZgKo8w/U0tX2U73IT/dgBbZ+zwtvQWwsB7nJcs7g8BiAEqcbwt0pwcAuIK3DLvtUNLQpUi0C6HWgznt6vZy/LfaD8Ee3q+93rEEGC17DnGlJqp73XUKFLBgmeBBa4yTEoxLm6hPfk7RTTDxK2T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JhCMMFTu; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-421eed70e30so15577315e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718973169; x=1719577969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=deelu2OWT9FEv+OHF2wJoMlx2ZjM7Mxt+Yz0Us1bWBA=;
        b=JhCMMFTu8uGAVKYIfPAOScUST3VkjxWfMogbkVcaYPn8+/xeJdWcREXCZICnChKfSD
         +uubgsVZgKpaIoZm/YzGNKjQlTqgq7929QDBS6IuMVDqo4IGnETVapvRLhIGbueXQOYc
         5cELOedO0IS3kxZGTylZBuB/OnFloRCMcsplFoTwdX/c0TL99aFg/oa58RVlPtw487NF
         agHOwM5B+TVNsCNU9L7+c7oUkAJ5xa+S0O5IxXTcZi6Btlki1DeWEvUQ4lRr67rOL16T
         wKYZYUVHRgaSuZ/oz7ltq50+F7cq8YCPobUgpE+MA2oofqmH1q+Am+wtbWtgCLbMKO9n
         GQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718973169; x=1719577969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=deelu2OWT9FEv+OHF2wJoMlx2ZjM7Mxt+Yz0Us1bWBA=;
        b=HejWuDzCdTMXfGPDZCEIjoDDGUi1vgSn+/3P5aEr+yN55kJox1z9+ixmN9xybFBN0F
         nhnWI6vNArQ1CBNlmREmqsr2BT0fheZtdJuixkVcpEaoWLIMgqzVRADMoYHDWiSOrC4A
         NDj+cUl+aQQpFA9yQOt6s2fFpNcV6x354D+VbMs82epLXY7zDq8xyDIFxgqe/Z4MwOxb
         4mEpwmbbMqyoe//tfbLx4xQVTea9mhcS2ZdgSg+QOYUg57wM/8K8wCJgtesvl+jaWBvE
         sd7eewoTTFZtw4Dsp7DmIuZ1rsGNvdgrAPKgwY66bcP9szOQ/Bpq8G/M5dHAI6IDNHEh
         9r6g==
X-Forwarded-Encrypted: i=1; AJvYcCVtAWtkMzPTNplKuLLZ1aiM0Et2rbWk8/7JazUhzv2gOhlXUbqTWMiHZqWTJE5o+6uig8eHbUx9hIo9085QTaQcWveoJ3g1/Zfd0M4X
X-Gm-Message-State: AOJu0YwIG6xxqdOAjvqdq700HltAhRE3uCSgVWsd+vTBBodKk4oQpytb
	hjgOGac8BU1htpgPQoThoYwzLrnOroBxK/JRzsm2sRHzdU8k3tDsztoWXZNfCDLZuedytTjrzlH
	xUKtAUTZVa50UyY6cQYAEMsEdug==
X-Google-Smtp-Source: AGHT+IHdWV0c0tNGcbnVQuL2QhywOpmCGIzwP0O008XRxIGeQJFB+pSrOMj5h9yiI1GGvgsz9dT8lw3c+AUlnHcJArc=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a05:600c:3582:b0:424:7669:910a with
 SMTP id 5b1f17b1804b1-4247669952amr1919215e9.2.1718973169043; Fri, 21 Jun
 2024 05:32:49 -0700 (PDT)
Date: Fri, 21 Jun 2024 12:32:29 +0000
In-Reply-To: <20240621123230.1085265-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621123230.1085265-1-sebastianene@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240621123230.1085265-6-sebastianene@google.com>
Subject: [PATCH v7 5/6] KVM: arm64: Initialize the ptdump parser with stage-2 attributes
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

Define a set of attributes used by the ptdump parser to display the
properties of a guest memory region covered by a pagetable descriptor.
Build a description of the pagetable levels and initialize the parser
with this configuration.

Signed-off-by: Sebastian Ene <sebastianene@google.com>
---
 arch/arm64/kvm/ptdump.c | 143 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 137 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 36dc7662729f..cc1d4fdddc6e 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -14,6 +14,61 @@
 #include <kvm_ptdump.h>
 
 
+#define MARKERS_LEN		(2)
+#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
+
+struct kvm_ptdump_guest_state {
+	struct kvm		*kvm;
+	struct pg_state		parser_state;
+	struct addr_marker	ipa_marker[MARKERS_LEN];
+	struct pg_level		level[KVM_PGTABLE_MAX_LEVELS];
+	struct ptdump_range	range[MARKERS_LEN];
+};
+
+static const struct prot_bits stage2_pte_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
+		.set	= "XN",
+		.clear	= "  ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | PTE_VALID,
+		.set	= "R",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | PTE_VALID,
+		.set	= "W",
+		.clear	= " ",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_NG,
+		.val	= PTE_NG,
+		.set	= "FnXS",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_CONT | PTE_VALID,
+		.val	= PTE_CONT | PTE_VALID,
+		.set	= "CON",
+		.clear	= "   ",
+	}, {
+		.mask	= PTE_TABLE_BIT,
+		.val	= PTE_TABLE_BIT,
+		.set	= "   ",
+		.clear	= "BLK",
+	},
+};
+
 static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
 			      enum kvm_pgtable_walk_flags visit)
 {
@@ -40,15 +95,79 @@ static int kvm_ptdump_show_common(struct seq_file *m,
 	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
 }
 
+static int kvm_ptdump_build_levels(struct pg_level *level, u32 start_lvl)
+{
+	static const char * const level_names[] = {"PGD", "PUD", "PMD", "PTE"};
+	u32 i = 0;
+	u64 mask = 0;
+
+	if (start_lvl > 2) {
+		pr_err("invalid start_lvl %u\n", start_lvl);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(stage2_pte_bits); i++)
+		mask |= stage2_pte_bits[i].mask;
+
+	for (i = start_lvl; i < KVM_PGTABLE_MAX_LEVELS; i++) {
+		strscpy(level[i].name, level_names[i], sizeof(level[i].name));
+
+		level[i].num	= ARRAY_SIZE(stage2_pte_bits);
+		level[i].bits	= stage2_pte_bits;
+		level[i].mask	= mask;
+	}
+
+	if (start_lvl > 0)
+		strscpy(level[start_lvl].name, level_names[0], sizeof(level_names[0]));
+
+	return 0;
+}
+
+static struct kvm_ptdump_guest_state
+*kvm_ptdump_parser_init(struct kvm *kvm)
+{
+	struct kvm_ptdump_guest_state *st;
+	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
+	struct kvm_pgtable *pgtable = mmu->pgt;
+	int ret;
+
+	st = kzalloc(sizeof(struct kvm_ptdump_guest_state), GFP_KERNEL_ACCOUNT);
+	if (!st)
+		return NULL;
+
+	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
+	if (ret)
+		goto free_with_state;
+
+	st->ipa_marker[0].name		= "Guest IPA";
+	st->ipa_marker[1].start_address = BIT(pgtable->ia_bits);
+	st->range[0].end		= BIT(pgtable->ia_bits);
+
+	st->kvm				= kvm;
+	st->parser_state = (struct pg_state) {
+		.marker		= &st->ipa_marker[0],
+		.level		= -1,
+		.pg_level	= &st->level[0],
+		.ptdump.range	= &st->range[0],
+	};
+
+	return st;
+free_with_state:
+	kfree(st);
+	return NULL;
+}
+
 static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
 {
-	struct kvm *kvm = m->private;
+	struct kvm_ptdump_guest_state *st = m->private;
+	struct kvm *kvm = st->kvm;
 	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
-	struct pg_state parser_state = {0};
 	int ret;
 
+	st->parser_state.seq = m;
+
 	write_lock(&kvm->mmu_lock);
-	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
+	ret = kvm_ptdump_show_common(m, mmu->pgt, &st->parser_state);
 	write_unlock(&kvm->mmu_lock);
 
 	return ret;
@@ -57,22 +176,34 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
 static int kvm_ptdump_guest_open(struct inode *m, struct file *file)
 {
 	struct kvm *kvm = m->i_private;
+	struct kvm_ptdump_guest_state *st;
 	int ret;
 
 	if (!kvm_get_kvm_safe(kvm))
 		return -ENOENT;
 
-	ret = single_open(file, kvm_ptdump_guest_show, m->i_private);
-	if (ret < 0)
-		kvm_put_kvm(kvm);
+	st = kvm_ptdump_parser_init(kvm);
+	if (!st) {
+		ret = -ENOMEM;
+		goto free_with_kvm_ref;
+	}
+
+	ret = single_open(file, kvm_ptdump_guest_show, st);
+	if (!ret)
+		return 0;
 
+	kfree(st);
+free_with_kvm_ref:
+	kvm_put_kvm(kvm);
 	return ret;
 }
 
 static int kvm_ptdump_guest_close(struct inode *m, struct file *file)
 {
 	struct kvm *kvm = m->i_private;
+	void *st = ((struct seq_file *)file->private_data)->private;
 
+	kfree(st);
 	kvm_put_kvm(kvm);
 	return single_release(m, file);
 }
-- 
2.45.2.741.gdbec12cfda-goog



Return-Path: <linux-kernel+bounces-289666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCDA9548E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611CF1F250DB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B4D1BBBCE;
	Fri, 16 Aug 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWF8zlFi"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5941BB694
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811969; cv=none; b=e6DoLD+okYhJCMExP3LN9R55nipcjf4FrMd6TP+by3vrcFchpnhUrPNzKQbxzfpUWR+Sn297fmSpbUBjqDJTaEA5SW5qEvxZaXT+mRuTkXVuShsPg3gHhhZQ6tFEYQMqlVhzpKB/2uBtypXGm4eGnfR/g68SRqEe6d46T0gk68Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811969; c=relaxed/simple;
	bh=rUTR5Uw2CU6HdDslJgJgvaaNW9+0iMJMSD2PvX3S4Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8z/MzZ/zVZyw0b/OiGOFaXiDODpdMX3YB24o9B4PmviqmG311mOCLcINTZ7UOSk9qZagHOEp+tJq7YiNZQgwV5dhhUiAQBgjRG4rqO3bMNJ2dwOdQ/vM26nOkeXs3NmihpASeXTiVmXTDi1zmqegnlF4buB1FaOSwPsVbVz1EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWF8zlFi; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sebastianene.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4280e1852f3so14598915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723811966; x=1724416766; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5eauNhTcQzE72bplFQ4XGy8D3RpEmD9MyGnD7LBaN4=;
        b=RWF8zlFiG6Rbc+VGZHS+uUhNi7AGrgFGm58vDUzPdRfs4UHIWH53uEFbNUkqGBNdwS
         sIeCRH+2fCpfd7h13ZZ1l39C0lR5MD0AICVsAt33OCfCsj2NJLAmShDPhexSunowaeiF
         ODd5k+fYvIQBYNOochkOJGdJcYmHhPXJfxjK/hVX1EXAqhcEpSvIRuS8Ik7bSs2uAtsY
         gAKcxyc8IOtaSdhucgV/rsCd7nDqPksUiLyebNs9gX+7ku1srwHzgRs+dtAa10LDrKV9
         IaPntptI6s3/UlZl9bIooaD+LTzB0h1w40oFdxIZ6NX74p2SNcaWcqYkRImnSdOeD8j0
         TLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811966; x=1724416766;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5eauNhTcQzE72bplFQ4XGy8D3RpEmD9MyGnD7LBaN4=;
        b=At6gRTCyglU8vIzSRByQpExLTAUCxNFeWLt/WNeKfpHcVbiJbMTRQO3pW8gPd2XW2e
         GT324y88XBYR5T3NZyZzoZi7Cjd2JNbhj8v89Go0qRbKds0R4NpAWNnveojB2af8vsL6
         fY0DG9UGP2JZZkjrlWl4lsog1K9YvGt11ELTKCdfEbin2oSGUUBGCL+NyZT2tsUY09Xc
         Doq2nkBIq4yVYLo9Hf2Tw4Q6WzcL9HVUCaZVYpSol5eHRzb0XrIWYypxqtuz4xUTIz7K
         0n+xyvsWnFvij/v5PCQTfleOZwBecymLwv+DB+qVtAFZl7EkRWzTTw/4AO7FbSDrwsl8
         ZA0A==
X-Forwarded-Encrypted: i=1; AJvYcCWMMZXxY/3TeiRJIC7pZuRKDhJ/cc7V9B8GkX87HSIGyDI4ld1jwiWIM2o2xSWc22Ulqbyg1p19qT/qrjxR/OoTiUlDWOuYC2+OoGZO
X-Gm-Message-State: AOJu0YwvBge5RjDAbpFXyxqnZJmGq9iQt6qTJEzAsvWTAIAwqKFzX+W0
	5cln1ef2Lf9Uo6091SBO9WgCXrQFPZ4lA7J/a/PoPVV6Iw48aJbBfqop02yuBcc5GLW7GZe8PXA
	WiR3ssC94UM9MT9NyEr+hYr3dNg==
X-Google-Smtp-Source: AGHT+IG1VARFxBSm1/RC48H0ZjztqDQmLfmamJgW5HCygZC+rMZkIMsZGB0I2wgNiB3LORe0b8lZmKSxQJdbF5eeByQ=
X-Received: from sebkvm.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:cd5])
 (user=sebastianene job=sendgmr) by 2002:a5d:6691:0:b0:366:ec30:add3 with SMTP
 id ffacd0b85a97d-37194314665mr4594f8f.1.1723811966138; Fri, 16 Aug 2024
 05:39:26 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:39:05 +0000
In-Reply-To: <20240816123906.3683425-1-sebastianene@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240816123906.3683425-1-sebastianene@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240816123906.3683425-6-sebastianene@google.com>
Subject: [PATCH v8 5/6] KVM: arm64: Initialize the ptdump parser with stage-2 attributes
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
 arch/arm64/kvm/ptdump.c | 135 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
index 52483d56be2e..79be07ec3c3c 100644
--- a/arch/arm64/kvm/ptdump.c
+++ b/arch/arm64/kvm/ptdump.c
@@ -14,6 +14,51 @@
 #include <kvm_ptdump.h>
 
 
+#define MARKERS_LEN		(2)
+#define KVM_PGTABLE_MAX_LEVELS	(KVM_PGTABLE_LAST_LEVEL + 1)
+
+struct kvm_ptdump_guest_state {
+	struct kvm		*kvm;
+	struct ptdump_pg_state	parser_state;
+	struct addr_marker	ipa_marker[MARKERS_LEN];
+	struct ptdump_pg_level	level[KVM_PGTABLE_MAX_LEVELS];
+	struct ptdump_range	range[MARKERS_LEN];
+};
+
+static const struct ptdump_prot_bits stage2_pte_bits[] = {
+	{
+		.mask	= PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "F",
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
+		.mask	= KVM_PTE_LEAF_ATTR_HI_S2_XN | PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= " ",
+		.clear	= "X",
+	}, {
+		.mask	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.val	= KVM_PTE_LEAF_ATTR_LO_S2_AF | PTE_VALID,
+		.set	= "AF",
+		.clear	= "  ",
+	}, {
+		.mask	= PTE_TABLE_BIT | PTE_VALID,
+		.val	= PTE_VALID,
+		.set	= "BLK",
+		.clear	= "   ",
+	},
+};
+
 static int kvm_ptdump_visitor(const struct kvm_pgtable_visit_ctx *ctx,
 			      enum kvm_pgtable_walk_flags visit)
 {
@@ -40,15 +85,81 @@ static int kvm_ptdump_show_common(struct seq_file *m,
 	return kvm_pgtable_walk(pgtable, 0, BIT(pgtable->ia_bits), &walker);
 }
 
+static int kvm_ptdump_build_levels(struct ptdump_pg_level *level, u32 start_lvl)
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
+	if (WARN_ON_ONCE(start_lvl >= KVM_PGTABLE_LAST_LEVEL))
+		return -EINVAL;
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
+		strscpy(level[start_lvl].name, "PGD", sizeof(level[start_lvl].name));
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
+	if (ret) {
+		kfree(st);
+		return ERR_PTR(ret);
+	}
+
+	st->ipa_marker[0].name		= "Guest IPA";
+	st->ipa_marker[1].start_address = BIT(pgtable->ia_bits);
+	st->range[0].end		= BIT(pgtable->ia_bits);
+
+	st->kvm				= kvm;
+	st->parser_state = (struct ptdump_pg_state) {
+		.marker		= &st->ipa_marker[0],
+		.level		= -1,
+		.pg_level	= &st->level[0],
+		.ptdump.range	= &st->range[0],
+	};
+
+	return st;
+}
+
 static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
 {
-	struct kvm *kvm = m->private;
+	struct kvm_ptdump_guest_state *st = m->private;
+	struct kvm *kvm = st->kvm;
 	struct kvm_s2_mmu *mmu = &kvm->arch.mmu;
-	struct ptdump_pg_state parser_state = {0};
 	int ret;
 
+	st->parser_state.seq = m;
+
 	write_lock(&kvm->mmu_lock);
-	ret = kvm_ptdump_show_common(m, mmu->pgt, &parser_state);
+	ret = kvm_ptdump_show_common(m, mmu->pgt, &st->parser_state);
 	write_unlock(&kvm->mmu_lock);
 
 	return ret;
@@ -57,22 +168,34 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
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
+	if (IS_ERR(st)) {
+		ret = PTR_ERR(st);
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
2.46.0.184.g6999bdac58-goog



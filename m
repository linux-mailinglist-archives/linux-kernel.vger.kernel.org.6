Return-Path: <linux-kernel+bounces-281519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74EB94D7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FE8A283671
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6BD19CD1E;
	Fri,  9 Aug 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHwvgnkw"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D891684B0
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232662; cv=none; b=JG7n7EIiEUI1459qyV8g/BEcG7bvLS568mpdhXA++ISpSMnKTJDk61Eeh/v15a2tDXDXuf86LFz3r0PJyea2iw9LDS3NwIC7NRIu7KgroOIZFOxHbcBF6aKFUivLRVzG4x3goYSZr6FUr9mr4FZJqLZHWlDIl78nHWkWePFyyW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232662; c=relaxed/simple;
	bh=Asf1nEQnWkrE4726hXYeTADyaj7scYaajKYH4kYYdl0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sAEzAcAvH2GPhDhNM1fkRoDFfaE9Vhnq7ogtXcZiacVQq6L3srpGB2aAs1cgvoeYLgNOEPQD/NhlHvS21W5hOL1OkovfpGCY2g9WwNPpDwDC8O+51oWYRCY/+m39+01nz8EB/FB2rq8ceLKMJbUKNVTd+ZwFVfnbJ3Sz8uZrEvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHwvgnkw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1c28cd89so2270837b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232661; x=1723837461; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mm5+yuh4XjI5vBcow3bFf5ciAXmemsZ5SboXxBoCy4Q=;
        b=lHwvgnkwEOcCOyfLX4TbZy3ZzhtRRG5E2K+HBQ2UV26ory3BHqVB+UC48r5lTei6IH
         CtssaU9bCLPu/GGQYC1hcUNdwHyC59GMiBcWoQXPJoCFdVMLgGt5IFj8HKFs6f4zaz4h
         9irWYwagwJ7GVsPLjzbPn6R8h8cxkJoQMoE+3q/NIgnVLAvjio4uGxArss8qWTx1cQ1f
         IGsVCls9f93fLoBzQ5NReP5b51ZiFuMT44l5pFMW9dImqDhm3o+x4tehBuSU6rdOZn/u
         tlG8G3s5ueQrc9dZD2uqvgNnl02y7Nfomt0div4WempbIeDM+5z6fg0VgneiXW1g0lVW
         A9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232661; x=1723837461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mm5+yuh4XjI5vBcow3bFf5ciAXmemsZ5SboXxBoCy4Q=;
        b=mWc9zP0U4yvE/aieUtaSYSxnYHv0kMtkUV5fO5rmMhTCidWiDFWP0Plb/6H9MkC7rw
         uP/Xkb7P/zL4gLr6PKsRXCaHAfpPbVrTW2Z1KQbY9BzBSNivNAA9Usar9VerlJNcNvEe
         eDTTzvMsHYFubGLmViQ2VBxNxsxPnsfdWko5EOrUc02vT5w0CzqK15ZgZTC4MlUxiTjX
         heDwicik2NPyBTUjb7q3O/b0NMgQgs457jy/8a/dTKPo601ZSmzt/rPpcvax2dAnWVHb
         l/vEyDfHn+6aBTKxQz2vE/Kq8ML+dHXXKsRdqKVZbSPSFCHueHm0y9nS8ln7BFTgHe81
         d7fA==
X-Forwarded-Encrypted: i=1; AJvYcCUINW4PeWZHQRcv/aotcQMNAUXzpbKSPtw9PUEfEyk1x7pxc4IBrF5U/8k2K70acAo692Vz8Z2pK/InTuEyatyuTaTAD21CHuBSNaCi
X-Gm-Message-State: AOJu0YzEzuiMw/kvlFdJuUXrUCEgxk33Jh/d/eG0lvFvtGR0qaChbhDd
	Lz5zNz5Hw5eis0Yl/7cpbFrixcKtWE6fAszW4ic1cQ4Io6Bvrq4BFZdtRBYuiFE0Oki3ciBhDOG
	VQA==
X-Google-Smtp-Source: AGHT+IF/O6pTeFfoAlWjuVv6pzCpox1wsfwaTSxqhna+jt0NCRVn34Qv+aJ7MSoWohdt3Pb9tXUIOw8xzCs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:91e4:b0:710:4d6c:a504 with SMTP id
 d2e1a72fcca58-710dcb27574mr83474b3a.4.1723232660388; Fri, 09 Aug 2024
 12:44:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:33 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-22-seanjc@google.com>
Subject: [PATCH 21/22] KVM: x86/mmu: Support rmap walks without holding
 mmu_lock when aging gfns
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

DO NOT MERGE, yet...

Cc: James Houghton <jthoughton@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 63 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 48e8608c2738..9df6b465de06 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -995,13 +995,11 @@ static void kvm_rmap_unlock(struct kvm_rmap_head *rmap_head,
  * locking is the same, but the caller is disallowed from modifying the rmap,
  * and so the unlock flow is a nop if the rmap is/was empty.
  */
-__maybe_unused
 static unsigned long kvm_rmap_lock_readonly(struct kvm_rmap_head *rmap_head)
 {
 	return __kvm_rmap_lock(rmap_head);
 }
 
-__maybe_unused
 static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
 				     unsigned long old_val)
 {
@@ -1743,8 +1741,53 @@ static void rmap_add(struct kvm_vcpu *vcpu, const struct kvm_memory_slot *slot,
 	__rmap_add(vcpu->kvm, cache, slot, spte, gfn, access);
 }
 
-static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
-				   struct kvm_gfn_range *range, bool test_only)
+static bool kvm_rmap_age_gfn_range_lockless(struct kvm *kvm,
+					    struct kvm_gfn_range *range,
+					    bool test_only)
+{
+	struct kvm_rmap_head *rmap_head;
+	struct rmap_iterator iter;
+	unsigned long rmap_val;
+	bool young = false;
+	u64 *sptep;
+	gfn_t gfn;
+	int level;
+	u64 spte;
+
+	for (level = PG_LEVEL_4K; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
+		for (gfn = range->start; gfn < range->end;
+		     gfn += KVM_PAGES_PER_HPAGE(level)) {
+			rmap_head = gfn_to_rmap(gfn, level, range->slot);
+			rmap_val = kvm_rmap_lock_readonly(rmap_head);
+
+			for_each_rmap_spte_lockless(rmap_head, &iter, sptep, spte) {
+				if (!is_accessed_spte(spte))
+					continue;
+
+				if (test_only) {
+					kvm_rmap_unlock_readonly(rmap_head, rmap_val);
+					return true;
+				}
+
+				/*
+				 * Marking SPTEs for access tracking outside of
+				 * mmu_lock is unsupported.  Report the page as
+				 * young, but otherwise leave it as-is.
+				 */
+				if (spte_ad_enabled(spte))
+					clear_bit((ffs(shadow_accessed_mask) - 1),
+						  (unsigned long *)sptep);
+				young = true;
+			}
+
+			kvm_rmap_unlock_readonly(rmap_head, rmap_val);
+		}
+	}
+	return young;
+}
+
+static bool __kvm_rmap_age_gfn_range(struct kvm *kvm,
+				     struct kvm_gfn_range *range, bool test_only)
 {
 	struct slot_rmap_walk_iterator iterator;
 	struct rmap_iterator iter;
@@ -1783,6 +1826,18 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 	return young;
 }
 
+
+static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
+				   struct kvm_gfn_range *range, bool test_only)
+{
+	/* FIXME: This also needs to be guarded with something like range->fast_only. */
+	if (kvm_ad_enabled())
+		return kvm_rmap_age_gfn_range_lockless(kvm, range, test_only);
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	return __kvm_rmap_age_gfn_range(kvm, range, test_only);
+}
+
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
 	bool young = false;
-- 
2.46.0.76.ge559c4bf1a-goog



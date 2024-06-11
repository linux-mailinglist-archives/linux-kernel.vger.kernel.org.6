Return-Path: <linux-kernel+bounces-209121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14880902D99
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCBE286D89
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FC836AE0;
	Tue, 11 Jun 2024 00:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6A9cfMA"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AD12E4A
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 00:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718065326; cv=none; b=HFuNoan9ZSKNQheXA8xIEyd2k6NryKdAESUJ6kmguJfrcc1605D+qfRw5hOAejI1B0WL1Dy3gpDYcpemp5GDkiz6cEYyg6tjh87EimejrMcJoSsts8B44KetNqOI9PQBEMyGafpo3HYhHU2siSxxAZ2tqhe4s7Ov9GtTyPX4748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718065326; c=relaxed/simple;
	bh=CwLkYcmzZttiwi369ZHLZf654OyS2he0I+I/bemyL94=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dST8EuZeELzks4f5Hga6EYIdfX1uzPtbN7kVOLBPe2e3+jFqJ75adWBvEEBrlMj3T8XwgG2jD1jZivstJCd7A3LmTyVor/6xtWbFaNyDPtv0vpq0tDzsb++mei/XK+dTZQIBqkr+MaXlM1Ns648iuSr5/lfQx0xtcL7HyIEe+Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6A9cfMA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629638f1cb0so82806597b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718065324; x=1718670124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HV93t1qtvLY2HqXeqD4WwNLQ267HOmhqjDYyVDwgnFc=;
        b=e6A9cfMACQYTv5MYQBEMRwPmkjEqjJdzdWgpxw1ozh+KpskoYaLqygOETxPJBREHWW
         pAKRAbc3+cQqnKz6dGelFnWJymnR6GgEhxAXlqvkif/L2GgpvbOo8Sy/dQ4lQLP53Gn6
         3VJ8uMIMm2P4YQCSfXpnDdSD+NgVbAQDJubLw06VCOxPdcJdoUaTd95pj52vZot2q5Lg
         S+h4Wk7gY89Wad0bhfCwBxWRdq8W6YnQZBiOp8EApfhfs2CpVQxpEp+clXy0uV5I0kcQ
         Y1AqfO4LObmhYZJp7r0p3a29lHj9HqwYqzQ5z5oQ9morwbMBG+cw+GFrR3ZbBHin/eRK
         nw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718065324; x=1718670124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HV93t1qtvLY2HqXeqD4WwNLQ267HOmhqjDYyVDwgnFc=;
        b=wmefefTkRoZg+m3NwwnvrwN4E5tCQceko6xg4WxJG34G3c/o52pKk97Sb8iQUE3gcv
         mUNcDQXIuh64Za227CXYGxxPXK5xEpwJme7gXAovTiJrvTqVQXjBNAJlLGyFXroLbmId
         cV87k/5aBtOLQeQZ512WFykPzf8P6PqxQuADneqcUuCr8MMMo7bmr8zuwuIglVv/3aV9
         4UCAQDlRIw5A6bVutgu9fpwvCJq5Ka4CWlzcR1djY6frPxidqsXeZRACGzR+24akZKBv
         Q0/EHmuvqgmgLxnWS3ZJx2C4hCDOqguKyVNhVH0PMlwBVETbtS26BfxEoAuQNK+7+FtD
         wtWg==
X-Forwarded-Encrypted: i=1; AJvYcCUr/UV01mXb4SowfdkoJ+2fbGPOKVvKCkgH9EMpM6Xo0MYSkZrJ8pG7XicQuU29HKbSnT8MiEwB629ebL7iItHHgIvzmrOFk9gaMaUm
X-Gm-Message-State: AOJu0YwCFS0kPHxCRzL3VQUIN0dr8lO7ZpDwOIoqXde0Pcbrd2ukGPiB
	0SSCIirCoGvsXLPqkC/dQqeyj4YjT4OycMalX2XhdN1zZGTwyw6pTAzUAkxVIK4OHbPeeNocq82
	GNcYp+Fyml8Sz+NmiBg==
X-Google-Smtp-Source: AGHT+IGdrDSzxMWV88JW0LA6UnAEJXd+QZJzNBe66poa1GZZ236cqaZmaxZKOwtkV9plz4I87xyLdQPCAlnoV8zg
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:690c:38b:b0:627:7563:95b1 with SMTP
 id 00721157ae682-62cd5652459mr33516247b3.5.1718065324168; Mon, 10 Jun 2024
 17:22:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 00:21:42 +0000
In-Reply-To: <20240611002145.2078921-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611002145.2078921-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611002145.2078921-7-jthoughton@google.com>
Subject: [PATCH v5 6/9] KVM: x86: Move tdp_mmu_enabled and shadow_accessed_mask
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Matlack <dmatlack@google.com>, 
	David Rientjes <rientjes@google.com>, James Houghton <jthoughton@google.com>, 
	James Morse <james.morse@arm.com>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Raghavendra Rao Ananta <rananta@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Wei Xu <weixugc@google.com>, Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

From: Yu Zhao <yuzhao@google.com>

tdp_mmu_enabled and shadow_accessed_mask are needed to implement
kvm_arch_young_notifier_likely_fast().

Signed-off-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ++++++
 arch/x86/kvm/mmu.h              | 6 ------
 arch/x86/kvm/mmu/spte.h         | 1 -
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 011c8eb7c8d3..0dc1fa99cdbb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1855,6 +1855,7 @@ struct kvm_arch_async_pf {
 
 extern u32 __read_mostly kvm_nr_uret_msrs;
 extern u64 __read_mostly host_efer;
+extern u64 __read_mostly shadow_accessed_mask;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
 extern struct kvm_x86_ops kvm_x86_ops;
@@ -1960,6 +1961,11 @@ void kvm_fire_mask_notifiers(struct kvm *kvm, unsigned irqchip, unsigned pin,
 			     bool mask);
 
 extern bool tdp_enabled;
+#ifdef CONFIG_X86_64
+extern bool tdp_mmu_enabled;
+#else
+#define tdp_mmu_enabled false
+#endif
 
 u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
 
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 2e454316f2a2..267f72b065f5 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -271,12 +271,6 @@ static inline bool kvm_shadow_root_allocated(struct kvm *kvm)
 	return smp_load_acquire(&kvm->arch.shadow_root_allocated);
 }
 
-#ifdef CONFIG_X86_64
-extern bool tdp_mmu_enabled;
-#else
-#define tdp_mmu_enabled false
-#endif
-
 static inline bool kvm_memslots_have_rmaps(struct kvm *kvm)
 {
 	return !tdp_mmu_enabled || kvm_shadow_root_allocated(kvm);
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 52fa004a1fbc..9ca6d80fb86c 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -172,7 +172,6 @@ extern u64 __read_mostly shadow_mmu_writable_mask;
 extern u64 __read_mostly shadow_nx_mask;
 extern u64 __read_mostly shadow_x_mask; /* mutual exclusive with nx_mask */
 extern u64 __read_mostly shadow_user_mask;
-extern u64 __read_mostly shadow_accessed_mask;
 extern u64 __read_mostly shadow_dirty_mask;
 extern u64 __read_mostly shadow_mmio_value;
 extern u64 __read_mostly shadow_mmio_mask;
-- 
2.45.2.505.gda0bf45e8d-goog



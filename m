Return-Path: <linux-kernel+bounces-281508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AFA94D79A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC8E1283598
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3149B198E78;
	Fri,  9 Aug 2024 19:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDHcY69F"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A2E194C65
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232640; cv=none; b=rtID3MF54IKQw7ZmrtDogw3vsq2KJ1/8bciPKamWZoqA8o0ey1dz7dEw+ZujCF/jz1SIv6Se5kQOAcW0hWGYsEbNOQaErJmuUp8G/0ZnJefgPdRw6KCDdedkyGNSGd/57+f7hPVcWdDLX1iX5WaayYPcNbyosWyTMqwJZ3SSvpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232640; c=relaxed/simple;
	bh=+GylkI/uIWrUOvqPBl8m0ev0LDK+4fi2QwLYgo7xKSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FX7QN8GZpbz2EZ+w5pGpzqaJpOLS552CFQE8quPIveotnI4nCTzEVCI8lcOkosGg8r2EwNt/x/FioHMdrlxW8qmr+g6tiNEOmpIH36Tif/Zf56kUhGceEa+3+enzGU/Mj91H+16CIktZKWZLAdsWJHrQdWPmeB0pfUyvApQ3Lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDHcY69F; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fc47634e3dso22959755ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232638; x=1723837438; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FfIoOq8ezL3lF0COKJQzO4R/UUZXUE0fWXr809zSI60=;
        b=pDHcY69FQBoDOpmgX9GU7Ao38U8UCZoRyRFL1OayPd0huY0pcxvBJuTkt0CslTH2wY
         O1EGGgK1qMUm2uoa5VPUydKHIg7jVq9xVdG4BjoWrhNkaG9IHT2Fr2s0PVUoZCrLYv5o
         W0ZUuBLoFPVsUuP6WBNrILPxBc3StUJN8q6ionxxWAqrbWsgHLO+kZHZEkK+e9kSgyd1
         G/wn9NGJu/WUI0SGZ6qYxbueDpz35n5JbqwrL+Uy+hANhKxZxQvsNH3qVasxHkvcYAC8
         46lsucWkoI1INjt10wLVyn//vGBcH9+sIlmMQ1wPuJq7spFdhw7d1qtQxnvmmpb+YL1X
         vF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232638; x=1723837438;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FfIoOq8ezL3lF0COKJQzO4R/UUZXUE0fWXr809zSI60=;
        b=VDZKYhFtIaQoYfT83R3wTJ99kh4+52P6584V8RFMIafkjggoBwpTdWlGGbzM7aAtp0
         gfkR8o0vPoKx+vZy+oD935iPVgbSZUFBnPovGj453RQBUHDelK+oy02Fk+eM20FYrbtX
         pJpvspMsoWc4nrJG8cu7ccgDx7XQ1gDoIVrOtyhXBm1IvnNNLubio0Z70DDfXJpwj7Pe
         RgdGIXcNUPNt2EKQZ+gvczGPgUEO7i6jQV6SsxEAY60OOx+vbnj0YqRevV4k/7UqQvMK
         PT0y0VVREt8VevvdLnz9/GYxVDTPv+fo8S4r3Kbq9HZUtExFTDUq0LeCS33WVgcvFpQ+
         YICw==
X-Forwarded-Encrypted: i=1; AJvYcCXo3E9A5uy918NgccBnNRha9cvlszF0VfKWiwzeAj5v8e4in13y3XlFYn4QFknahgN64jd4RgCm/OxFZ3nM9E3A6TFQ+/6d3cMrMKQ4
X-Gm-Message-State: AOJu0YwRcRrirnLrcFS+NiQcHf2BscbDywu4kpYXwJ82j6syCA8TCgmF
	S3NkAOs+piYRPZ79WIrPzHiauNjvInkcum9FqbUXTCQzG6aTFwps3cojt1CC+vpfNVuDrEqj/kG
	6Fg==
X-Google-Smtp-Source: AGHT+IHI2Sj/+82ITfhQRaMFsQWLje/k3ROR9iGp71RmEKU0cgVARHxIz4EvnVRZ5brISpMtlPzaid6nWq4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80b:b0:1fa:f9ac:8b4a with SMTP id
 d9443c01a7336-200ae4c9f0amr1621115ad.3.1723232638087; Fri, 09 Aug 2024
 12:43:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:22 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-11-seanjc@google.com>
Subject: [PATCH 10/22] KVM: x86/mmu: Move walk_slot_rmaps() up near for_each_slot_rmap_range()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Move walk_slot_rmaps() and friends up near for_each_slot_rmap_range() so
that the walkers can be used to handle mmu_notifier invalidations, and so
that similar function has some amount of locality in code.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 107 +++++++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 901be9e420a4..676cb7dfcbf9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1534,6 +1534,60 @@ static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 	     slot_rmap_walk_okay(_iter_);				\
 	     slot_rmap_walk_next(_iter_))
 
+
+/* The return value indicates if tlb flush on all vcpus is needed. */
+typedef bool (*slot_rmaps_handler) (struct kvm *kvm,
+				    struct kvm_rmap_head *rmap_head,
+				    const struct kvm_memory_slot *slot);
+
+static __always_inline bool __walk_slot_rmaps(struct kvm *kvm,
+					      const struct kvm_memory_slot *slot,
+					      slot_rmaps_handler fn,
+					      int start_level, int end_level,
+					      gfn_t start_gfn, gfn_t end_gfn,
+					      bool flush_on_yield, bool flush)
+{
+	struct slot_rmap_walk_iterator iterator;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	for_each_slot_rmap_range(slot, start_level, end_level, start_gfn,
+			end_gfn, &iterator) {
+		if (iterator.rmap)
+			flush |= fn(kvm, iterator.rmap, slot);
+
+		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
+			if (flush && flush_on_yield) {
+				kvm_flush_remote_tlbs_range(kvm, start_gfn,
+							    iterator.gfn - start_gfn + 1);
+				flush = false;
+			}
+			cond_resched_rwlock_write(&kvm->mmu_lock);
+		}
+	}
+
+	return flush;
+}
+
+static __always_inline bool walk_slot_rmaps(struct kvm *kvm,
+					    const struct kvm_memory_slot *slot,
+					    slot_rmaps_handler fn,
+					    int start_level, int end_level,
+					    bool flush_on_yield)
+{
+	return __walk_slot_rmaps(kvm, slot, fn, start_level, end_level,
+				 slot->base_gfn, slot->base_gfn + slot->npages - 1,
+				 flush_on_yield, false);
+}
+
+static __always_inline bool walk_slot_rmaps_4k(struct kvm *kvm,
+					       const struct kvm_memory_slot *slot,
+					       slot_rmaps_handler fn,
+					       bool flush_on_yield)
+{
+	return walk_slot_rmaps(kvm, slot, fn, PG_LEVEL_4K, PG_LEVEL_4K, flush_on_yield);
+}
+
 typedef bool (*rmap_handler_t)(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			       struct kvm_memory_slot *slot, gfn_t gfn,
 			       int level);
@@ -6199,59 +6253,6 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 }
 EXPORT_SYMBOL_GPL(kvm_configure_mmu);
 
-/* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_rmaps_handler) (struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head,
-				    const struct kvm_memory_slot *slot);
-
-static __always_inline bool __walk_slot_rmaps(struct kvm *kvm,
-					      const struct kvm_memory_slot *slot,
-					      slot_rmaps_handler fn,
-					      int start_level, int end_level,
-					      gfn_t start_gfn, gfn_t end_gfn,
-					      bool flush_on_yield, bool flush)
-{
-	struct slot_rmap_walk_iterator iterator;
-
-	lockdep_assert_held_write(&kvm->mmu_lock);
-
-	for_each_slot_rmap_range(slot, start_level, end_level, start_gfn,
-			end_gfn, &iterator) {
-		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap, slot);
-
-		if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
-			if (flush && flush_on_yield) {
-				kvm_flush_remote_tlbs_range(kvm, start_gfn,
-							    iterator.gfn - start_gfn + 1);
-				flush = false;
-			}
-			cond_resched_rwlock_write(&kvm->mmu_lock);
-		}
-	}
-
-	return flush;
-}
-
-static __always_inline bool walk_slot_rmaps(struct kvm *kvm,
-					    const struct kvm_memory_slot *slot,
-					    slot_rmaps_handler fn,
-					    int start_level, int end_level,
-					    bool flush_on_yield)
-{
-	return __walk_slot_rmaps(kvm, slot, fn, start_level, end_level,
-				 slot->base_gfn, slot->base_gfn + slot->npages - 1,
-				 flush_on_yield, false);
-}
-
-static __always_inline bool walk_slot_rmaps_4k(struct kvm *kvm,
-					       const struct kvm_memory_slot *slot,
-					       slot_rmaps_handler fn,
-					       bool flush_on_yield)
-{
-	return walk_slot_rmaps(kvm, slot, fn, PG_LEVEL_4K, PG_LEVEL_4K, flush_on_yield);
-}
-
 static void free_mmu_pages(struct kvm_mmu *mmu)
 {
 	if (!tdp_enabled && mmu->pae_root)
-- 
2.46.0.76.ge559c4bf1a-goog



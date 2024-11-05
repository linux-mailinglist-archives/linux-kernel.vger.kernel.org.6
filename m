Return-Path: <linux-kernel+bounces-396979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF29BD532
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C922F1F267AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 18:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146341F4707;
	Tue,  5 Nov 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L8/35Y/u"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6B1EBA1D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 18:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730832227; cv=none; b=dITFYY6C05/pXsmyhRQBWTO+pSXKFQuTcyl7hdhnB4YwyWViwWblrxeqRXmR6/OXlNG5hHYYKRf8vE4NawYZBoxiwSkFkRcMF+AF7mMRTqHB4q2mmeZCbFgXGbp08exKwmULMhySnXT73rMZ5nI6N3L2TFKbxCjXf8sTv73ueEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730832227; c=relaxed/simple;
	bh=vZrsRH2ZpnPhLUPg8HbhY2SRWoRuV7oD6Hdw4ccdV9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKLczXajSzDT22XqJPBFdjTTuHJaO0AJiqei4EKESuQmqD5TleS1V2nNG54SNm8loDSdXQLh7WDN5Rfp2fhjh2foZn8hqGj3qEaHtLU67aeaYu3ZC+9uG8NOxt+YnqB5L1n6ZzNTTNHGgd+7ckwepTC67WkdVLiV2ErEvzln5yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L8/35Y/u; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3314237b86so5405715276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730832224; x=1731437024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+gvy7h6VjHvEicxCxVK1KFes/YAEA42/v/7o2kAWKg=;
        b=L8/35Y/uOelzS74SMzl1a7NgpYVl7tdae1FqiRbXt9N0eJe5QyHskXmbFm734l52IP
         cISMidO+TxJzBEsyEkfh3Axwg9rDcTgvcMfgmvJLO1g08Rkzyi5OKFtt7cjHpyJVmoRO
         G+2bRzdzKy3IFa8W9XtfZjsVdGoqyP1Bz3qm4OxdJh3CZX3IY102MUsToC9sTocfGXWe
         g4cuIe9O2FklqLSALugniGMMzIYA61Vg+25AVeoq8RpPO0D9a8TrrEoElJvTg56FIxOY
         iMJriySEp7vZuzSKWv9snzMdTR7ikUz0vVpdtKAIBdJ8PGkq6JhMR8KGITY4sXi35trD
         ZpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730832224; x=1731437024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+gvy7h6VjHvEicxCxVK1KFes/YAEA42/v/7o2kAWKg=;
        b=cIrW5/VwfdtOKUtKJUtR5vVm5ulHbgjxrPs2ts0fRmcmciTNbIgAnKmgFnAvCW63MM
         jQCltDl3qElq3K+ndgVcCtLFLudANHeH6bbomc5LsAIEChpSo3iPbyNUNrrVScQTIW6h
         GFIvIXsFzW5W5pw6DFXwfcEZZ2PqBtRcyJ2u+/HmNw1L6yRfPWK75lgD+QWKG00peIkU
         HglHeR4B9JS7sc2yofr7jEj67vWL30lgkMqU4ZUzUtlQNopxGphbk5gxQxJR6KsnAnRi
         eHIjjPCyKF78fNUUmG6VP8pRDz+QFgA/tdDNNirEsh0oeqqsmH0gIiiCbv2gvdFlb9k6
         94AA==
X-Forwarded-Encrypted: i=1; AJvYcCW8IAcHM2mX9lUyK75YkFNcVP4lIgmJRPAt+ostyPm+iAshTfTSLzOlSIYsLkXA8jTzKtgLLnnqu3Dtc28=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZRkHNOW7RgRcXR5LiJPtDt9k9cxFArqxzCiqvTRaNN58obX8
	nTOrrd9cGv7dltsnNfz0zVCH4NYNlTvsKrJ03LztFiaYc22f0Vwhqhz8o4ykDzwBXIRo43dOOfJ
	S49jW0QEf8Gw4wNgrNA==
X-Google-Smtp-Source: AGHT+IFLgucFBeYmf4t35ZiwYH4jII1t3oDCRi+X7uizgjYi9k77iZE9V4CFoxH6sOGu/7XXObgmhbIRgb/aBbhF
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:13d:fb22:ac12:a84b])
 (user=jthoughton job=sendgmr) by 2002:a5b:bc7:0:b0:e16:68fb:f261 with SMTP id
 3f1490d57ef6-e33025817a8mr11632276.5.1730832224607; Tue, 05 Nov 2024 10:43:44
 -0800 (PST)
Date: Tue,  5 Nov 2024 18:43:24 +0000
In-Reply-To: <20241105184333.2305744-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105184333.2305744-1-jthoughton@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105184333.2305744-3-jthoughton@google.com>
Subject: [PATCH v8 02/11] KVM: Add lockless memslot walk to KVM
From: James Houghton <jthoughton@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, 
	James Houghton <jthoughton@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Provide flexibility to the architecture to synchronize as optimally as
they can instead of always taking the MMU lock for writing.

Architectures that do their own locking must select
CONFIG_KVM_MMU_NOTIFIER_YOUNG_LOCKLESS.

The immediate application is to allow architectures to implement the
test/clear_young MMU notifiers more cheaply.

Suggested-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: James Houghton <jthoughton@google.com>
Reviewed-by: David Matlack <dmatlack@google.com>
---
 include/linux/kvm_host.h |  1 +
 virt/kvm/Kconfig         |  2 ++
 virt/kvm/kvm_main.c      | 28 +++++++++++++++++++++-------
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 18a1672ffcbf..ab0318dbb8bd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -260,6 +260,7 @@ struct kvm_gfn_range {
 	gfn_t end;
 	union kvm_mmu_notifier_arg arg;
 	bool may_block;
+	bool lockless;
 };
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range);
 bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range);
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index 54e959e7d68f..b50e4e629ac9 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -102,6 +102,8 @@ config KVM_GENERIC_MMU_NOTIFIER
 
 config KVM_ELIDE_TLB_FLUSH_IF_YOUNG
        depends on KVM_GENERIC_MMU_NOTIFIER
+
+config KVM_MMU_NOTIFIER_YOUNG_LOCKLESS
        bool
 
 config KVM_GENERIC_MEMORY_ATTRIBUTES
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b234a9acdb3..218edf037917 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -517,6 +517,7 @@ struct kvm_mmu_notifier_range {
 	on_lock_fn_t on_lock;
 	bool flush_on_ret;
 	bool may_block;
+	bool lockless;
 };
 
 /*
@@ -571,6 +572,10 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 			 IS_KVM_NULL_FN(range->handler)))
 		return r;
 
+	/* on_lock will never be called for lockless walks */
+	if (WARN_ON_ONCE(range->lockless && !IS_KVM_NULL_FN(range->on_lock)))
+		return r;
+
 	idx = srcu_read_lock(&kvm->srcu);
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
@@ -602,15 +607,18 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 			gfn_range.start = hva_to_gfn_memslot(hva_start, slot);
 			gfn_range.end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, slot);
 			gfn_range.slot = slot;
+			gfn_range.lockless = range->lockless;
 
 			if (!r.found_memslot) {
 				r.found_memslot = true;
-				KVM_MMU_LOCK(kvm);
-				if (!IS_KVM_NULL_FN(range->on_lock))
-					range->on_lock(kvm);
-
-				if (IS_KVM_NULL_FN(range->handler))
-					goto mmu_unlock;
+				if (!range->lockless) {
+					KVM_MMU_LOCK(kvm);
+					if (!IS_KVM_NULL_FN(range->on_lock))
+						range->on_lock(kvm);
+
+					if (IS_KVM_NULL_FN(range->handler))
+						goto mmu_unlock;
+				}
 			}
 			r.ret |= range->handler(kvm, &gfn_range);
 		}
@@ -620,7 +628,7 @@ static __always_inline kvm_mn_ret_t kvm_handle_hva_range(struct kvm *kvm,
 		kvm_flush_remote_tlbs(kvm);
 
 mmu_unlock:
-	if (r.found_memslot)
+	if (r.found_memslot && !range->lockless)
 		KVM_MMU_UNLOCK(kvm);
 
 	srcu_read_unlock(&kvm->srcu, idx);
@@ -797,6 +805,8 @@ static int kvm_mmu_notifier_clear_flush_young(struct mmu_notifier *mn,
 		.flush_on_ret	=
 			!IS_ENABLED(CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG),
 		.may_block	= false,
+		.lockless	=
+			IS_ENABLED(CONFIG_KVM_MMU_NOTIFIER_YOUNG_LOCKLESS),
 	};
 
 	trace_kvm_age_hva(start, end);
@@ -817,6 +827,8 @@ static int kvm_mmu_notifier_clear_young(struct mmu_notifier *mn,
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= false,
+		.lockless	=
+			IS_ENABLED(CONFIG_KVM_MMU_NOTIFIER_YOUNG_LOCKLESS),
 	};
 
 	trace_kvm_age_hva(start, end);
@@ -849,6 +861,8 @@ static int kvm_mmu_notifier_test_young(struct mmu_notifier *mn,
 		.on_lock	= (void *)kvm_null_fn,
 		.flush_on_ret	= false,
 		.may_block	= false,
+		.lockless	=
+			IS_ENABLED(CONFIG_KVM_MMU_NOTIFIER_YOUNG_LOCKLESS),
 	};
 
 	trace_kvm_test_age_hva(address);
-- 
2.47.0.199.ga7371fff76-goog



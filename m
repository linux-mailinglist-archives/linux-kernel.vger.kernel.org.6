Return-Path: <linux-kernel+bounces-360370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9A8999A21
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6747E2833A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160721F940F;
	Fri, 11 Oct 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1hiLpfZW"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18281F8EF3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 02:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728612673; cv=none; b=YduD6BQ3YmDHhFmUxpIqH4Qq8pb3eNe7mU5zN2AzPO7UWBOzy1TljvDrwitSEcMUMf9qWhI3Awk3vFTGytryIL6Jdrk045GP2/0YY8WWvcX1+PCDTuh5sy0NVVDURm94VPDAlhAWCejT1ubBwBsNQWTEl+dW3DNIL9mvqaz9AFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728612673; c=relaxed/simple;
	bh=mBOjmFsYBYRAZuezuPUiDcUngPx/Y9dILWOQs8AcaTY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jv0iPpBtjtQgpcuKKIHC8HM0h+wtoTrf/lrJ+BHyV0eIQGHXdNbbTTl3Efg7604lthmM421YTaII2LFyb0NiwJIs7e7nCWtYmHeRVE/7VxnpLBPT9of2btjeBkCljvpYzbjld9TFaumOCiSCVd6w7TZwQK+Nv9GOAberWy0U7po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1hiLpfZW; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso1543138a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 19:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728612671; x=1729217471; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=dqtxSv3YnUUR/sJVpJRtlACnljXlzFu2kYd05eqQTN4=;
        b=1hiLpfZWchrYrZv3Zqh2nO5Np+MsGhlrPAUpvQO7p+Q9Zt5F9ARI4o7KLlttTzNdYp
         +nLQsX3D/xI7iQH19R8VITI1WZlqA6V7hi4e0AbytoPBloNt0uHbOB4N+nWeKvRMAmbj
         s2hHAOKRydMyHlj5TPizDj9losOV6Wh8CQpdVRzZAZTDv5HFJwTa0dQTvZbid7yC/Ubr
         jkiRdURF52kKTSR13uChX1JnUJq3bXR0QjEWdRpKPvLhe+zcmvj0jYyw3Vh+hF2U7YGz
         NCbytslkmmo+8B6+YJSmb4OsA2dS0vJctnPjSOrEdjUbhDwzv/YWwpRwM5LDVUielvZR
         CS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728612671; x=1729217471;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqtxSv3YnUUR/sJVpJRtlACnljXlzFu2kYd05eqQTN4=;
        b=d5C8FUXio1lcQ/SYIlrvh0urzgVeNw1bB+NDjArOXesbnFHLG/zPdJNVRamcN79pOX
         VSiN3sU9yzrp9YcWkQhnlUdHxHrBC3wfgyk0LxCi2/weBX7pXu3EP8FfxEmPT6woJBrc
         xQgM0I++Ypwjx1IUJfFS00zZJak3On/z6eFPaGHPXsH6ChHCE1jz5hVe0E5dWy20xjmW
         q/50wMwZEDGJp6uqlD2L7LoHjVl8utLafXelnRRTlYzVmKQOfAKY/6h7WyUB+aylCY8g
         d+AEVUmYr3xVMMXRFyTgxl15vp0+0yGON3THtvlOoUOqgvxz1uexmuGTalHQB96Oj3OL
         Kv3A==
X-Forwarded-Encrypted: i=1; AJvYcCWw+19LEZZtCpReuTfi0oTsPxVMr0OwvDGE3Tv/s9nd9SZWhXYbrlMiwY5Q/7D4zdV7YSPq1NWAOK2vyak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1w5Ok4MeW26po3itllUS6U0hC34WOKw+iQ9ybXKA7kGXkeop
	KsI1x3/5+n91dIUHx3rq8Y7JtnGuVn6NtgQ58a5ynb/qSts5nmQbskjjJq2B8K09dfTXsVps/0r
	ToQ==
X-Google-Smtp-Source: AGHT+IEmcasdM9fcYdzj9EuNpBTGwy71TY+RMspUAPymGIJ09fYw9nRXHwZTY0keRu/tRkUdRmkF481gS+Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a65:6917:0:b0:7ea:e28:b57e with SMTP id
 41be03b00d2f7-7ea535910c2mr902a12.8.1728612670912; Thu, 10 Oct 2024 19:11:10
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 10 Oct 2024 19:10:41 -0700
In-Reply-To: <20241011021051.1557902-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011021051.1557902-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011021051.1557902-10-seanjc@google.com>
Subject: [PATCH 09/18] KVM: x86/mmu: Add a dedicated flag to track if A/D bits
 are globally enabled
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sagi Shahar <sagis@google.com>, 
	"=?UTF-8?q?Alex=20Benn=C3=A9e?=" <alex.bennee@linaro.org>, David Matlack <dmatlack@google.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a dedicated flag to track if KVM has enabled A/D bits at the module
level, instead of inferring the state based on whether or not the MMU's
shadow_accessed_mask is non-zero.  This will allow defining and using
shadow_accessed_mask even when A/D bits aren't used by hardware.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c     |  6 +++---
 arch/x86/kvm/mmu/spte.c    |  6 ++++++
 arch/x86/kvm/mmu/spte.h    | 20 +++++++++-----------
 arch/x86/kvm/mmu/tdp_mmu.c |  4 ++--
 4 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index a72ecac63e07..06fb0fd3f87d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3350,7 +3350,7 @@ static bool page_fault_can_be_fast(struct kvm *kvm, struct kvm_page_fault *fault
 	 *    by setting the Writable bit, which can be done out of mmu_lock.
 	 */
 	if (!fault->present)
-		return !kvm_ad_enabled();
+		return !kvm_ad_enabled;
 
 	/*
 	 * Note, instruction fetches and writes are mutually exclusive, ignore
@@ -3485,7 +3485,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		 * uses A/D bits for non-nested MMUs.  Thus, if A/D bits are
 		 * enabled, the SPTE can't be an access-tracked SPTE.
 		 */
-		if (unlikely(!kvm_ad_enabled()) && is_access_track_spte(spte))
+		if (unlikely(!kvm_ad_enabled) && is_access_track_spte(spte))
 			new_spte = restore_acc_track_spte(new_spte);
 
 		/*
@@ -5462,7 +5462,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.efer_nx = true;
 	role.smm = cpu_role.base.smm;
 	role.guest_mode = cpu_role.base.guest_mode;
-	role.ad_disabled = !kvm_ad_enabled();
+	role.ad_disabled = !kvm_ad_enabled;
 	role.level = kvm_mmu_get_tdp_level(vcpu);
 	role.direct = true;
 	role.has_4_byte_gpte = false;
diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
index 030813781a63..c9543625dda2 100644
--- a/arch/x86/kvm/mmu/spte.c
+++ b/arch/x86/kvm/mmu/spte.c
@@ -24,6 +24,8 @@ static bool __ro_after_init allow_mmio_caching;
 module_param_named(mmio_caching, enable_mmio_caching, bool, 0444);
 EXPORT_SYMBOL_GPL(enable_mmio_caching);
 
+bool __read_mostly kvm_ad_enabled;
+
 u64 __read_mostly shadow_host_writable_mask;
 u64 __read_mostly shadow_mmu_writable_mask;
 u64 __read_mostly shadow_nx_mask;
@@ -414,6 +416,8 @@ EXPORT_SYMBOL_GPL(kvm_mmu_set_me_spte_mask);
 
 void kvm_mmu_set_ept_masks(bool has_ad_bits, bool has_exec_only)
 {
+	kvm_ad_enabled		= has_ad_bits;
+
 	shadow_user_mask	= VMX_EPT_READABLE_MASK;
 	shadow_accessed_mask	= has_ad_bits ? VMX_EPT_ACCESS_BIT : 0ull;
 	shadow_dirty_mask	= has_ad_bits ? VMX_EPT_DIRTY_BIT : 0ull;
@@ -447,6 +451,8 @@ void kvm_mmu_reset_all_pte_masks(void)
 	u8 low_phys_bits;
 	u64 mask;
 
+	kvm_ad_enabled = true;
+
 	/*
 	 * If the CPU has 46 or less physical address bits, then set an
 	 * appropriate mask to guard against L1TF attacks. Otherwise, it is
diff --git a/arch/x86/kvm/mmu/spte.h b/arch/x86/kvm/mmu/spte.h
index 574ca9a1fcab..908cb672c4e1 100644
--- a/arch/x86/kvm/mmu/spte.h
+++ b/arch/x86/kvm/mmu/spte.h
@@ -167,6 +167,15 @@ static_assert(!(SHADOW_NONPRESENT_VALUE & SPTE_MMU_PRESENT_MASK));
 #define SHADOW_NONPRESENT_VALUE	0ULL
 #endif
 
+
+/*
+ * True if A/D bits are supported in hardware and are enabled by KVM.  When
+ * enabled, KVM uses A/D bits for all non-nested MMUs.  Because L1 can disable
+ * A/D bits in EPTP12, SP and SPTE variants are needed to handle the scenario
+ * where KVM is using A/D bits for L1, but not L2.
+ */
+extern bool __read_mostly kvm_ad_enabled;
+
 extern u64 __read_mostly shadow_host_writable_mask;
 extern u64 __read_mostly shadow_mmu_writable_mask;
 extern u64 __read_mostly shadow_nx_mask;
@@ -285,17 +294,6 @@ static inline bool is_ept_ve_possible(u64 spte)
 	       (spte & VMX_EPT_RWX_MASK) != VMX_EPT_MISCONFIG_WX_VALUE;
 }
 
-/*
- * Returns true if A/D bits are supported in hardware and are enabled by KVM.
- * When enabled, KVM uses A/D bits for all non-nested MMUs.  Because L1 can
- * disable A/D bits in EPTP12, SP and SPTE variants are needed to handle the
- * scenario where KVM is using A/D bits for L1, but not L2.
- */
-static inline bool kvm_ad_enabled(void)
-{
-	return !!shadow_accessed_mask;
-}
-
 static inline bool sp_ad_disabled(struct kvm_mmu_page *sp)
 {
 	return sp->role.ad_disabled;
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index bc9e2f50dc80..f77927b57962 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1075,7 +1075,7 @@ static int tdp_mmu_map_handle_target_level(struct kvm_vcpu *vcpu,
 static int tdp_mmu_link_sp(struct kvm *kvm, struct tdp_iter *iter,
 			   struct kvm_mmu_page *sp, bool shared)
 {
-	u64 spte = make_nonleaf_spte(sp->spt, !kvm_ad_enabled());
+	u64 spte = make_nonleaf_spte(sp->spt, !kvm_ad_enabled);
 	int ret = 0;
 
 	if (shared) {
@@ -1491,7 +1491,7 @@ static bool tdp_mmu_need_write_protect(struct kvm_mmu_page *sp)
 	 * from level, so it is valid to key off any shadow page to determine if
 	 * write protection is needed for an entire tree.
 	 */
-	return kvm_mmu_page_ad_need_write_protect(sp) || !kvm_ad_enabled();
+	return kvm_mmu_page_ad_need_write_protect(sp) || !kvm_ad_enabled;
 }
 
 static void clear_dirty_gfn_range(struct kvm *kvm, struct kvm_mmu_page *root,
-- 
2.47.0.rc1.288.g06298d1525-goog



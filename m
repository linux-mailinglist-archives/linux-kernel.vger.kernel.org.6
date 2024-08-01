Return-Path: <linux-kernel+bounces-271743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16A29452D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D021F23FF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6C614D708;
	Thu,  1 Aug 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/AJ2u0i"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC4B14D2B7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537311; cv=none; b=MEuanbDQguW2psr7YP/4Ov+NJIXFzwUrOInrqUWZgEE/J9zqoQL7dvR/wnhjY+6yVT3svku8/DXyx0hVlhclJXMVD2G22ZzrRtXJJFE5LnmAmF5P9mEv2izWNIjzSGDleTkzB9VPCEMjTsl2j1NX4Gb9V8d5jze4vylOQmXLuME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537311; c=relaxed/simple;
	bh=kcyZHtFtSWTsZyQHZ3oFwxa1IXjn9+p3AjCTE5ktFqM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BYWWxWDYuJpUOVwx5Ha4/xZ3pSmblaypFNqRwwASwQJWc+sb27TA4R8VCrjv4kQxEuTZDMn3DzHCaP+iJAIspHane9JCkGn+z0gfxOCkTxm6QgEyQJvMsBCcUqLl/Axk8gBmP1f+CiWp5CIWGRee7TMCFBIkrvkKhWaf70DGJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/AJ2u0i; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70d1df50db2so2447996b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722537309; x=1723142109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MzTNDvjeVqrs7z6ZdAikXXC/sttVLmYnLoCNz/Cy7ro=;
        b=R/AJ2u0in/q7N5U13dxxbPnEoXpNcBME4V/loLgl8eYiNLb455O8l9sqEB4GPJa+xF
         5LOt4K98IAOjlX4JOv8O7uyVVB4mAliIgWKcMFqdjqS5m6rePZd8ZuI4dbTpB/Oyu2iM
         MXjtLD+C6DZBoCXTMByNLtWV3l+lFUD8tDIQlh0wsU7hNIoWG6yM+590HHzII+QDfkar
         VR12eVFGBcdFCvtzbiKME+HqEHawIOcyXzTcoFCS+gs0C5GinTiEYUFfjttPUyuduJzI
         U0vJIVJJXKcoRZbOzayOgcyXS2eVHowuJD0YpfX5jNjvq1LJke0KEFcCn6u5cVlQhr1z
         sFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537309; x=1723142109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzTNDvjeVqrs7z6ZdAikXXC/sttVLmYnLoCNz/Cy7ro=;
        b=vkGAYAlY1XiEGAtpXKb4eLTxCgOJ08WhLAzDKXr/kE+hgz9CKLHVgjIEFTlypSuH2r
         dfWbnE8wslh5lZrwwjJYEh5pSag33KwuDhfKH1hjOicQwZE4VfCrFQVIMup0zozYcRfO
         sK/vs5h5K46N2Ov+pNuvWdDFf+/kROQV0j4KaJVPg+2ZRLJFf4sW4a3iBsmjs4IHjaTU
         6iMXAGAbVJjUo2+Engeo3Oaax1SKl0rpzARUUx3X1ib9SImbkkKG9rQhmL4cDZGueS75
         eys3/STPlFkjUzwWrPe9wKm9OUP3RN1wH8n2/eNKBAGEWi0K2U4+Nka9JSP+FhcpvdfU
         4DCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA6+LaCyj2yU3D/mXZYdIihR0colCCWQk9pgoddpm/9SBhnms8ob0cNlBZmr/GBxEdxyFH93bSLX5JVwUrL7B/WHFknVV5cImWaCqU
X-Gm-Message-State: AOJu0YzKSoeolbEX9qcpxFc8YObYSCpFBh5dfHf6+iwz51Ap2Et4+FiS
	xQ8hgJPF5l5HIF6eODvkvHWl32/znC6Z0OREa+BCxftRxxdGvJFbSS8SVER6lAtke5G+7aW1zg6
	nhw==
X-Google-Smtp-Source: AGHT+IHBKWw5BAUfyMToUbh6nUKAFn26IAUUz572bHA0Rz/4Cn41vP3IxvpndgvHdAhxE1s8QOG25zRXuL0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:6f12:b0:710:4e4c:a4ad with SMTP id
 d2e1a72fcca58-71065b6f385mr40762b3a.0.1722537309268; Thu, 01 Aug 2024
 11:35:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  1 Aug 2024 11:34:51 -0700
In-Reply-To: <20240801183453.57199-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240801183453.57199-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240801183453.57199-8-seanjc@google.com>
Subject: [RFC PATCH 7/9] KVM: x86/mmu: Stop processing TDP MMU roots for
 test_age if young SPTE found
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Return immediately if a young SPTE is found when testing, but not updating,
SPTEs.  The return value is a boolean, i.e. whether there is one young SPTE
or fifty is irrelevant (ignoring the fact that it's impossible for there to
be fifty SPTEs, as KVM has a hard limit on the number of valid TDP MMU
roots).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 84 ++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index b358642890e1..ac3200ce00f9 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1189,35 +1189,6 @@ bool kvm_tdp_mmu_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range,
 	return flush;
 }
 
-typedef bool (*tdp_handler_t)(struct kvm *kvm, struct tdp_iter *iter,
-			      struct kvm_gfn_range *range);
-
-static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
-						   struct kvm_gfn_range *range,
-						   tdp_handler_t handler)
-{
-	struct kvm_mmu_page *root;
-	struct tdp_iter iter;
-	bool ret = false;
-
-	/*
-	 * Don't support rescheduling, none of the MMU notifiers that funnel
-	 * into this helper allow blocking; it'd be dead, wasteful code.  Note,
-	 * this helper must NOT be used to unmap GFNs, as it processes only
-	 * valid roots!
-	 */
-	for_each_valid_tdp_mmu_root(kvm, root, range->slot->as_id) {
-		rcu_read_lock();
-
-		tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
-			ret |= handler(kvm, &iter, range);
-
-		rcu_read_unlock();
-	}
-
-	return ret;
-}
-
 /*
  * Mark the SPTEs range of GFNs [start, end) unaccessed and return non-zero
  * if any of the GFNs in the range have been accessed.
@@ -1226,15 +1197,10 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
  * from the clear_young() or clear_flush_young() notifier, which uses the
  * return value to determine if the page has been accessed.
  */
-static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
-			  struct kvm_gfn_range *range)
+static void kvm_tdp_mmu_age_spte(struct tdp_iter *iter)
 {
 	u64 new_spte;
 
-	/* If we have a non-accessed entry we don't need to change the pte. */
-	if (!is_accessed_spte(iter->old_spte))
-		return false;
-
 	if (spte_ad_enabled(iter->old_spte)) {
 		iter->old_spte = tdp_mmu_clear_spte_bits(iter->sptep,
 							 iter->old_spte,
@@ -1250,23 +1216,53 @@ static bool age_gfn_range(struct kvm *kvm, struct tdp_iter *iter,
 
 	trace_kvm_tdp_mmu_spte_changed(iter->as_id, iter->gfn, iter->level,
 				       iter->old_spte, new_spte);
-	return true;
+}
+
+static bool __kvm_tdp_mmu_age_gfn_range(struct kvm *kvm,
+					struct kvm_gfn_range *range,
+					bool test_only)
+{
+	struct kvm_mmu_page *root;
+	struct tdp_iter iter;
+	bool ret = false;
+
+	/*
+	 * Don't support rescheduling, none of the MMU notifiers that funnel
+	 * into this helper allow blocking; it'd be dead, wasteful code.  Note,
+	 * this helper must NOT be used to unmap GFNs, as it processes only
+	 * valid roots!
+	 */
+	for_each_valid_tdp_mmu_root(kvm, root, range->slot->as_id) {
+		rcu_read_lock();
+
+		tdp_root_for_each_leaf_pte(iter, root, range->start, range->end) {
+			if (!is_accessed_spte(iter.old_spte))
+				continue;
+
+			ret = true;
+			if (test_only)
+				break;
+
+			kvm_tdp_mmu_age_spte(&iter);
+		}
+
+		rcu_read_unlock();
+
+		if (ret && test_only)
+			break;
+	}
+
+	return ret;
 }
 
 bool kvm_tdp_mmu_age_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	return kvm_tdp_mmu_handle_gfn(kvm, range, age_gfn_range);
-}
-
-static bool test_age_gfn(struct kvm *kvm, struct tdp_iter *iter,
-			 struct kvm_gfn_range *range)
-{
-	return is_accessed_spte(iter->old_spte);
+	return __kvm_tdp_mmu_age_gfn_range(kvm, range, false);
 }
 
 bool kvm_tdp_mmu_test_age_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	return kvm_tdp_mmu_handle_gfn(kvm, range, test_age_gfn);
+	return __kvm_tdp_mmu_age_gfn_range(kvm, range, true);
 }
 
 /*
-- 
2.46.0.rc1.232.g9752f9e123-goog



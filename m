Return-Path: <linux-kernel+bounces-562365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8777A624C3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA3342180A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12CB18C332;
	Sat, 15 Mar 2025 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XNAC9G4O"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36011F5EA
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742006416; cv=none; b=J6DGEyBESpwIfShvYYKMl5CQkxeCv8bB4H4XpWrKPM0D4qAShmsyijBSia38cuXiWv76sZE8UX2cVpAcP3NiZJJrenq+A4Ip13dp3annNQkwpQ6pvlIyv9DN3MVompYKvToYuNYskErUZzA5jnPs1nCtZX+N1Vplh6HHaRVNZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742006416; c=relaxed/simple;
	bh=hHQMhqoJXwkU2iQFu0bAessW5nDhl6z0kwwuyI+P114=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YfkbI5sxXwdQxspZK94nk+UcmYIS2FPoxR3v79rzNQUd+tBfsNmBhC7a2hheoghuNk+Of1i6snUVG8hkshNV6TRO/kT1af3GqioDLgJQgE1Ac+0Od1WKqeNbkFapSU+rn1tVXJci4ndzy+OJWhBWdbcjTLtPK7M5bbZzz24kBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XNAC9G4O; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2217a4bfcc7so44172565ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742006414; x=1742611214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8AnAaiMp1pogiyQq/P5ffzpAjmvR1I8H8po4dFjhB2Q=;
        b=XNAC9G4Oj7OlOkf8yfqTMuh05Pdg2+fSBDlx8HIkh3Gjq65VQvIev61W+TRcmFbnJp
         6v4GyPWctwnvTcsaQpSFnQHlXuNDY/qZHV5wsC2ZPnO9gjqyGk1UisJ828yPN/yJl2MT
         b2kL/AiGSjAZlTi22YTcrIle4pkvyE5SkYvRgT6+9kbiIT2YTr9pUjDIH7u739uK775d
         faxlXNuuvrU1aOA0WKgitMnURQY7VoEiqaxMg+Pgxji8lfO0d4w3c+evYXGodpQTlj84
         LvT6y4ICpCAYbIZlRd0ynecOE74iGtsos17PblTxcVyxFt0HNBJT/iGVcu4QuGmCWWq2
         Qpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742006414; x=1742611214;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AnAaiMp1pogiyQq/P5ffzpAjmvR1I8H8po4dFjhB2Q=;
        b=YGUwfHZuuwXBOLT1L/2ZHMizYIoMVKTL1T/FjBbRVeVJkVu8LOjapfBmcQrJbsDHF8
         l7oQehd9fC6RyKghLTBYLCZ4LcG5Say9D1Z0eTdipqwxj+kzzcs4yZjP28AAupfNHzWC
         KG4QDh/YfdBZWwm5b9/BFfBeKd1Yrga+qWbb/T2IL500Rf84HFON86kto0H/MuNj3Q97
         64JQdo3b4yzIJ9adLoqrI4v8UYY3RceOAea+adYGM67BaKGpg9vTlU/X2TOL0hSb+GxV
         ZkiT3XnpxStm3tBndp6A8ausHYjSr0KtUUWd27V63WAnbQ3ZeOovMgl6vbnuiDdKPSIJ
         5lag==
X-Forwarded-Encrypted: i=1; AJvYcCUbxeNsUtkgQan8F0jWos3xT6WpOPwtXIQnkqs+CBGtyOJuixfa39uCva7uBMJVNCDKfn0YXbgzDq2VFJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBPT9gz/H+/3+Ytgpo2zQDsIGDiBUvUAyrp9wWp3YgcCc08TSo
	BuhpDHRh1UPe9ftZoKE+mITzRc4+OZbToI2UqJ25w+5VdMYeRNvQYdiJ5SPQI8y4o1UgTxBePCI
	M6w==
X-Google-Smtp-Source: AGHT+IEuUNeaevdUXvWFAIJ8JsyZ358tix7OrYJ/fGDFTE4Ye0y79h20U/9yKG7qAiftx1GmhHfquVa3dWI=
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:2f8:4024:b59a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:190:b0:223:525b:2a7
 with SMTP id d9443c01a7336-225e0a4f8demr55785875ad.15.1742006414027; Fri, 14
 Mar 2025 19:40:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:40:08 -0700
In-Reply-To: <20250315024010.2360884-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250315024010.2360884-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315024010.2360884-2-seanjc@google.com>
Subject: [PATCH 1/3] KVM: x86/mmu: Dynamically allocate shadow MMU's hashed
 page list
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dynamically allocate the (massive) array of hashed lists used to track
shadow pages, as the array itself is 32KiB, i.e. is an order-3 allocation
all on its own, and is *exactly* an order-3 allocation.  Dynamically
allocating the array will allow allocating "struct kvm" using regular
kmalloc(), and will also allow deferring allocation of the array until
it's actually needed, i.e. until the first shadow root is allocated.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  4 ++--
 arch/x86/kvm/mmu/mmu.c          | 21 ++++++++++++++++++++-
 arch/x86/kvm/x86.c              |  5 ++++-
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d881e7d276b1..6ead9e57446a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1332,7 +1332,7 @@ struct kvm_arch {
 	bool has_private_mem;
 	bool has_protected_state;
 	bool pre_fault_allowed;
-	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
+	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
 	/*
 	 * A list of kvm_mmu_page structs that, if zapped, could possibly be
@@ -1984,7 +1984,7 @@ void kvm_mmu_vendor_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_init_vm(struct kvm *kvm);
+int kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 
 void kvm_mmu_init_memslot_memory_attributes(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 63bb77ee1bb1..b878f2e89dec 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3880,6 +3880,18 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+static int kvm_mmu_alloc_page_hash(struct kvm *kvm)
+{
+	typeof(kvm->arch.mmu_page_hash) h;
+
+	h = kcalloc(KVM_NUM_MMU_PAGES, sizeof(*h), GFP_KERNEL_ACCOUNT);
+	if (!h)
+		return -ENOMEM;
+
+	kvm->arch.mmu_page_hash = h;
+	return 0;
+}
+
 static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 {
 	struct kvm_memslots *slots;
@@ -6673,13 +6685,19 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
 		kvm_tdp_mmu_zap_invalidated_roots(kvm, true);
 }
 
-void kvm_mmu_init_vm(struct kvm *kvm)
+int kvm_mmu_init_vm(struct kvm *kvm)
 {
+	int r;
+
 	kvm->arch.shadow_mmio_value = shadow_mmio_value;
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
 	INIT_LIST_HEAD(&kvm->arch.possible_nx_huge_pages);
 	spin_lock_init(&kvm->arch.mmu_unsync_pages_lock);
 
+	r = kvm_mmu_alloc_page_hash(kvm);
+	if (r)
+		return r;
+
 	if (tdp_mmu_enabled)
 		kvm_mmu_init_tdp_mmu(kvm);
 
@@ -6690,6 +6708,7 @@ void kvm_mmu_init_vm(struct kvm *kvm)
 
 	kvm->arch.split_desc_cache.kmem_cache = pte_list_desc_cache;
 	kvm->arch.split_desc_cache.gfp_zero = __GFP_ZERO;
+	return 0;
 }
 
 static void mmu_free_vm_memory_caches(struct kvm *kvm)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69c20a68a3f0..a1d85740d6e7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -12704,7 +12704,9 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	if (ret)
 		goto out;
 
-	kvm_mmu_init_vm(kvm);
+	ret = kvm_mmu_init_vm(kvm);
+	if (ret)
+		goto out_cleanup_page_track;
 
 	ret = kvm_x86_call(vm_init)(kvm);
 	if (ret)
@@ -12757,6 +12759,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 
 out_uninit_mmu:
 	kvm_mmu_uninit_vm(kvm);
+out_cleanup_page_track:
 	kvm_page_track_cleanup(kvm);
 out:
 	return ret;
-- 
2.49.0.rc1.451.g8f38331e32-goog



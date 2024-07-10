Return-Path: <linux-kernel+bounces-248421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1112492DCF1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 01:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0008281674
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D6E16C6A3;
	Wed, 10 Jul 2024 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DWy7bWTF"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099516132B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720654972; cv=none; b=b12NfgIRYTLxcAUImABfsp8OcXjOlmxHE1VuXlJmbjJNMLDNRrD6PLb1nPMtpMtflKavdVywpPRPRu62JSGzBgNuGH6OMRs15gdKOC8YQmbclnXtT1N62V6EYplhGF51zWkvA3G+2pnwOq1KvYNIl8arM90CUBJYICxno7aGsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720654972; c=relaxed/simple;
	bh=51xqz35xJjNqxl6o9J1L1+yTufTjMwvN6j0qSUdwPuQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hh31mmcnjy7mGMJC75v20zH/SGLy4iPr7jHk2SMLbot1fFzq1LYK9oRI8c9gn2D1ClElOOfaYSMekJa0QQUCYtwVz/kST9/9O0J3XuMKwZUTZVTqpZYpz9D5J8o3/hRD0njAZBzIKf9oHBMBei6zrRSGsbndgJ1SRw40c746mZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DWy7bWTF; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e037c3d20a6so518299276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720654968; x=1721259768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+X5KVuFwrRiCUCCxSkgB4VRafKsM+RRSJ9rZMEadTc=;
        b=DWy7bWTFhe/KIs13Ct3SsUbD+oF93GBAGRkLqujDeMAfUYNC12irf/BXHA7+3oTOx4
         4Fpwge7jjhMAE+omuvcFPSamQ/Q+FundE26AFNHWZ+TyrVhXwEZgu5nASqzHrPmZQqBp
         jwNYETChRg+l0zLY/dduL+CRaYYdWCfHnTVFR/hr7speNuvW2qFeNXHgpjzatRI4Hljf
         B980UHG+z1+ukIYI+53h60THD/CUgre1E4gv0S5dmAI8kNFLoczV0HLOJIUu20HV0jhV
         nThjBZO8gAQL9cgx6a7vznQJQpk1IBIkPWTvDYbETqPveDo7579rtaQRFKFBoOvpoBuG
         fhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720654968; x=1721259768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m+X5KVuFwrRiCUCCxSkgB4VRafKsM+RRSJ9rZMEadTc=;
        b=efbefmMN8eqnsCNAwaJwX/+/10WKIX5ZQIEeaDpuDtct1Xnqk66TDuKxRA1RNlvTjT
         ZZMP1X50nYXjzWYmYRPdXcWTrC+iPDjlZcyOSXTyaTTa66YhLdkmf498RvOHLsdCCf9D
         9it0apSqFpq6TDcEE0U+gkOKhxOyBtuLyoE2bDhtIROltrs8jx9vaTxRIs6KybtZnwOI
         up8+Ky/VEc61xF6Tk6KkM26NU5txKF+tLkF8fM/v5544d++fiIYE9ryS0kG+pr7RMqTv
         Y9EP880fABAi+FW2ineR++/uPJzDT9hhUCkoYVw3r/MHjKOStIguqzWVWddatu0qWjwY
         pYbg==
X-Forwarded-Encrypted: i=1; AJvYcCVRvUzUHQAdjqVXBVAIxT3JcF44/Jb+UD16Tto8+/drowF73jyBzOait0i7dtZEanWEIVtmCIOsSGS7xI8J5CSI4xBQ/y5P660qsbMV
X-Gm-Message-State: AOJu0YweFs+Xl6X9LLT7O1hKCfcLd5Nxfwnl10ODCqo5IyMc/u/5166Y
	yMx55YsUQwVnh6biigUY/CV8SBWq5NujkaEWC1H1ECSkuxz+UBFZcKOnZdDCW93Cv5ezhN8Bom8
	Rf7weXYQ73NcKmOQgbQ==
X-Google-Smtp-Source: AGHT+IEiMSeqlL0E6QDriJWFXsS3O5CZdgADUq/m5UJK+f9Pzpz6qFNvBqMVhziD7REowA6fLBLwvMzZP6ooxfuZ
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6902:2089:b0:e03:2bfe:40c9 with
 SMTP id 3f1490d57ef6-e041b032f48mr13750276.3.1720654967914; Wed, 10 Jul 2024
 16:42:47 -0700 (PDT)
Date: Wed, 10 Jul 2024 23:42:14 +0000
In-Reply-To: <20240710234222.2333120-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710234222.2333120-1-jthoughton@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240710234222.2333120-11-jthoughton@google.com>
Subject: [RFC PATCH 10/18] KVM: arm64: Add KVM Userfault support
From: James Houghton <jthoughton@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	David Matlack <dmatlack@google.com>, James Houghton <jthoughton@google.com>, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Support comes in three parts:
1. When KVM Userfault is enabled, only install PAGE_SIZE PTEs. This
   prevents us from being able to map a userfault-enabled pfn with a
   huge PTE in response to a fault on a non-userfault pfn.
2. When we get KVM_PFN_ERR_USERFAULT from __gfn_to_pfn_memslot, return a
   memory fault to userspace.
3. When KVM Userfault is enabled for a particular kvm_gfn_range, unmap
   it, so that we can get faults on it.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/arm64/kvm/Kconfig |  1 +
 arch/arm64/kvm/mmu.c   | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 58f09370d17e..358153d91d58 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -37,6 +37,7 @@ menuconfig KVM
 	select HAVE_KVM_VCPU_RUN_PID_CHANGE
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select KVM_USERFAULT
 	help
 	  Support hosting virtualized guest machines.
 
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 8bcab0cc3fe9..ac283e606516 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1434,7 +1434,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	 * logging_active is guaranteed to never be true for VM_PFNMAP
 	 * memslots.
 	 */
-	if (logging_active) {
+	if (logging_active || kvm->userfault) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	} else {
@@ -1494,8 +1494,15 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		kvm_send_hwpoison_signal(hva, vma_shift);
 		return 0;
 	}
-	if (is_error_noslot_pfn(pfn))
+	if (is_error_noslot_pfn(pfn)) {
+		if (pfn == KVM_PFN_ERR_USERFAULT)
+			kvm_prepare_memory_fault_exit(vcpu, gfn << PAGE_SHIFT,
+						      PAGE_SIZE, write_fault,
+						      /*exec=*/false,
+						      /*private=*/false,
+						      /*userfault=*/true);
 		return -EFAULT;
+	}
 
 	if (kvm_is_device_pfn(pfn)) {
 		/*
@@ -2105,3 +2112,28 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
 
 	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
 }
+
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
+					struct kvm_gfn_range *range)
+{
+	unsigned long attrs = range->arg.attributes;
+
+	/*
+	 * We only need to unmap if we're enabling userfault. Disabling it
+	 * does not need an unmap. An unmap to get huge mappings will come
+	 * later.
+	 */
+	if (attrs & KVM_MEMORY_ATTRIBUTE_USERFAULT)
+		kvm_unmap_gfn_range(kvm, range);
+
+	return false;
+}
+
+bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
+					 struct kvm_gfn_range *range)
+{
+	/* Nothing to do! */
+	return false;
+}
+#endif
-- 
2.45.2.993.g49e7a77208-goog



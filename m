Return-Path: <linux-kernel+bounces-562379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4964DA62500
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 03:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112B319C5578
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 02:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B81718C031;
	Sat, 15 Mar 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIHyem9I"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9381F18A6AD
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007381; cv=none; b=s4dPhYk4Qer0xWjpghi93jWdtXR+DVtPPSeRaoLyLpKHjX3dsMiAEPyEgEIsNIWGRUbUU4yQkG7gmf7Rm8bbAG8gmUSsl0E8ff2nZMnUkzF1ddFclcBQDUvT5V/OiUyka9YVI8Mo42sYV3RHgVgsfAAIDGnRoq8pONhoLzdr4a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007381; c=relaxed/simple;
	bh=+ZZX7qNnfCLLvOhiQ9gHJeVtbxbDuqzZFOIXg6bI5cw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Bnh/BVAyey/zILRiCo8nRIvVUdMJOEoxhj/dZx1gYK6E57f5iD+9Hx6Sps0iSdauQbi/OvEtQNTT+0BSTLLL98Wb6YmoBxtL1d67i6jXBVJxAY95/6D2EW+rzdn3PoQzJZxvtBgAfUgRy3Y/j1+z2DzXQsCsy2dwnWzE9p5Cqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIHyem9I; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2233b764fc8so47358535ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007378; x=1742612178; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z62zBIuHLmtXad0Z5pdn1xvMGSFxR5nD2NTwFzgeqeI=;
        b=SIHyem9I/tewT0YmfB9bPyORS1krQQ8ZcpfxpGb763VrGWl/dSGhAEZLgtirelPzeN
         xfw14efMLtGu0fRrniezitc7cGjO86z0KAjHNo2775Xib4BRkf0GrRLUMkSnhBOPp8iJ
         oJ60m+BhGwjMKe3NTPuoyTos6JvsweZeZ2l742CYFmjns97ljT80BbHVNMY7Ud1ptdeE
         De09cOa5QSEO3UgFSKuQQ+dqJwBzhH/YWhkJde8SwRMgZfsswo5JJ3JLN1EOl1Nd7ivG
         fYbCeJlJ0uziDbZnN/f7rk8eU7vLO8sVVGzhz3GVM5Jq9EZGfyNnl1iOQW44wKAcJ7hx
         KiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007378; x=1742612178;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z62zBIuHLmtXad0Z5pdn1xvMGSFxR5nD2NTwFzgeqeI=;
        b=g4AjwpM41KqLwpZOMYb6Skvvkk+Vbj7wVz6+cgQ+XXO78vin+izd5J52c00dZU6QeO
         muU2AwPdAbIj42TC6Vx+pL2s5wIVeh5s106V1M1B/Jlb2SlJCjXOpCZ4nbPWVfxaf/Ov
         bKqvy41/u0jvTNPb01GRkR8rUiOvdBWuH0FlNscSOjTQy4VDfIsnHqdLstjzWOTZ7KHV
         12NF9XmPXtidku0QwMz2KH9qm9VNchEDBS8kbOnWHeoD7iaBD5MMSU2s/iJVPuWvtinM
         sVb+q3BQuxeFZ6ivznidnIUPjZQCeEPvk51TsVoGeziKHzYBXfwWCky7OnTzLxC5DogM
         eAnA==
X-Forwarded-Encrypted: i=1; AJvYcCU4BtTs6uj0u8DCwo4OVRRLU0AJaF8NjnxH/uT+Y+eLnOnw8y9tUGsidPeKI4eIO+Ckxtp1kDY/U+ALfes=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys5WfALKjy+1aFMoBnzQ/xZed3kHklzWvXRXhu718SzlLq6oq4
	VjTvZFUOQao0dXmdC/tHbAE8eCFmHpxeraQ7vUGPMwYvPvHyvPzbvYVHQDOAcSaRm3DqSjtdizg
	WoQ==
X-Google-Smtp-Source: AGHT+IGGn3fc2zoHlksKBIechNzdvEm7Uhf7t5xNZPQBPITxQ4BguguvN/F5A1Ol5OtNBXp+F53DF6fEjkA=
X-Received: from pfu10.prod.google.com ([2002:a05:6a00:a38a:b0:736:59f0:d272])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1950:b0:736:53bc:f1ab
 with SMTP id d2e1a72fcca58-737223b908dmr5473148b3a.12.1742007377854; Fri, 14
 Mar 2025 19:56:17 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:56:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315025615.2367411-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Add a module param to control and enumerate device
 posted IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a module param to allow disabling device posted interrupts without
having to sacrifice all of APICv/AVIC, and to also effectively enumerate
to userspace whether or not KVM may be utilizing device posted IRQs.
Disabling device posted interrupts is very desirable for testing, and can
even be desirable for production environments, e.g. if the host kernel
wants to interpose on device interrupts.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/svm/avic.c         | 3 +--
 arch/x86/kvm/vmx/posted_intr.c  | 7 +++----
 arch/x86/kvm/x86.c              | 9 ++++++++-
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d881e7d276b1..bf11c5ee50cb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1922,6 +1922,7 @@ struct kvm_arch_async_pf {
 extern u32 __read_mostly kvm_nr_uret_msrs;
 extern bool __read_mostly allow_smaller_maxphyaddr;
 extern bool __read_mostly enable_apicv;
+extern bool __read_mostly enable_device_posted_irqs;
 extern struct kvm_x86_ops kvm_x86_ops;
 
 #define kvm_x86_call(func) static_call(kvm_x86_##func)
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 65fd245a9953..e0f519565393 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -898,8 +898,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
 	struct kvm_irq_routing_table *irq_rt;
 	int idx, ret = 0;
 
-	if (!kvm_arch_has_assigned_device(kvm) ||
-	    !irq_remapping_cap(IRQ_POSTING_CAP))
+	if (!kvm_arch_has_assigned_device(kvm) || !enable_device_posted_irqs)
 		return 0;
 
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index ec08fa3caf43..a03988a138c5 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -134,9 +134,8 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
 static bool vmx_can_use_vtd_pi(struct kvm *kvm)
 {
-	return irqchip_in_kernel(kvm) && enable_apicv &&
-		kvm_arch_has_assigned_device(kvm) &&
-		irq_remapping_cap(IRQ_POSTING_CAP);
+	return irqchip_in_kernel(kvm) && enable_device_posted_irqs &&
+	       kvm_arch_has_assigned_device(kvm);
 }
 
 /*
@@ -254,7 +253,7 @@ bool pi_has_pending_interrupt(struct kvm_vcpu *vcpu)
  */
 void vmx_pi_start_assignment(struct kvm *kvm)
 {
-	if (!irq_remapping_cap(IRQ_POSTING_CAP))
+	if (!enable_device_posted_irqs)
 		return;
 
 	kvm_make_all_cpus_request(kvm, KVM_REQ_UNBLOCK);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 69c20a68a3f0..1b14319975b7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -227,6 +227,10 @@ EXPORT_SYMBOL_GPL(allow_smaller_maxphyaddr);
 bool __read_mostly enable_apicv = true;
 EXPORT_SYMBOL_GPL(enable_apicv);
 
+bool __read_mostly enable_device_posted_irqs = true;
+module_param(enable_device_posted_irqs, bool, 0444);
+EXPORT_SYMBOL_GPL(enable_device_posted_irqs);
+
 const struct _kvm_stats_desc kvm_vm_stats_desc[] = {
 	KVM_GENERIC_VM_STATS(),
 	STATS_DESC_COUNTER(VM, mmu_shadow_zapped),
@@ -9772,6 +9776,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (r != 0)
 		goto out_mmu_exit;
 
+	enable_device_posted_irqs = enable_device_posted_irqs && enable_apicv &&
+				    irq_remapping_cap(IRQ_POSTING_CAP);
+
 	kvm_ops_update(ops);
 
 	for_each_online_cpu(cpu) {
@@ -13552,7 +13559,7 @@ EXPORT_SYMBOL_GPL(kvm_arch_has_noncoherent_dma);
 
 bool kvm_arch_has_irq_bypass(void)
 {
-	return enable_apicv && irq_remapping_cap(IRQ_POSTING_CAP);
+	return enable_device_posted_irqs;
 }
 
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *cons,

base-commit: c9ea48bb6ee6b28bbc956c1e8af98044618fed5e
-- 
2.49.0.rc1.451.g8f38331e32-goog



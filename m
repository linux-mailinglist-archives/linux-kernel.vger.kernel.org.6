Return-Path: <linux-kernel+bounces-182461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680858C8B85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E86728A28E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BB15382C;
	Fri, 17 May 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qaYOrItN"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1243E1534E3
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967639; cv=none; b=esQOUVZ5wUH81IDj8OQM78bS4N1Rgn/LVBuA2BQMj8vjgZ49MMN/6wq0BRd9f/y4hbuiOh2w1V0qqq7Y0PU3hR+raqLY5P2647DRoSVIxpy1S1oeOMRsH+opWNXM9qMxrLsW68ONWjIwGIltGLSySOypPvJdlLXcmhhUfOe3adc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967639; c=relaxed/simple;
	bh=1IRai0+aXFZ2QtqlGpQR+RM2zfkTC9zymQOzYmLzRMQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0xoef3eDdGnYW7DDgQ/XQeRusBkUVW7ay60iPsTK7kGsrs1BtoSq192s3uTxmhQ9VcDI/gUdlphQYwwEbc8aEqiRzy4WdWFMbYfrOcv0NPUijapVsAFuIdswMI5ni1YB+rdQ49jdFMe1JJpl3YV4EwfiWWwccqMG2lTfwXwVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qaYOrItN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ece5eeb7c0so8264207b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967637; x=1716572437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hI7PMaxMkjPdVpVx4UN5/eTDElvZEk0CdO3dMQAX0L0=;
        b=qaYOrItNFaDzUmWF9ZUBWI74sDHdiFFdK4/eJbqkkMQqpvSIjInFSISg35gNeyoJRI
         qlDOfGOKCD1SBZFvDnIbtYvYzG4fqFCAbv9Au72X3RWur6xeBbPm7Qko0yRDGzofjWuV
         8MLDLp8NEsUUkjCljAjjLAEKQsTLetNJE2r+nacnhkciUMdejQBSnTQ2DVYYE1VxPTBa
         J4PTecy8v6IapyvKGvOZzoZDZuhvjICJpl/Qk6gfVRH9zizyopBTbCF87InPSx5Ve95m
         Ba9VAlncBMYbyhaltNDn98mRD8ouv6nn6Amkmp5w54PHmMF/HHwups7hD79nNRK3S0zQ
         k5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967637; x=1716572437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hI7PMaxMkjPdVpVx4UN5/eTDElvZEk0CdO3dMQAX0L0=;
        b=Fz6o+1B0exvWNchjK1eTKEv8rnikYEhcQ7yBim1VQoWQffhdaxjri++aI1c5JTsN79
         FL2hYz9y1BogC5Koz+Qs4q3XQASpNKGe4qSHouiUZbYaoLQ0Ti/Z3BSuT6c3JiUhvcSy
         C9El+HFaE3TY/d5reWRrQpPytxa6r1KRD1Dr+mitQK6kLPJMeKEg5zAIhz6xmitdK2/r
         I51QY2PLdLTXJ3RYjZFS4CJoHindQNCdjqSHBShlgd83N0h92PXb84plp2TPVFxOcMsv
         Y+ScHn4LZNKul492y7Pi71T1Gc1lJ2Sd/fWhhqkNhtFLe4eq2H6nXHM4Dcijh7l/caft
         ch6A==
X-Forwarded-Encrypted: i=1; AJvYcCWLKIFoJ6pWOSl2HxodQ19YS966LNTEFpBF6SPTZOsAqgi/imScElEmRHsmsl7my35UGiTE+efs3lsjtT1JvMYXRbUIVVWy044Jy7qE
X-Gm-Message-State: AOJu0Yx+mHFiGxSbZU7aDHzRAGY3b6qn8dAtftkyy6/c5Has4F3voj2n
	NhnZz+ctb74hxeClD/FvtLU36KBXB/05f8tkvMPpSLdIFYbl6Hh6yghzYeMAlwpR3jYIP6bm2S4
	0LA==
X-Google-Smtp-Source: AGHT+IHqNZx8gTjhUUjQ3MUoAVH2PUCVd/ZmIYbg18xAUn0QIEvVM7k5SXsVGFZQqkV++deHDX/xrKSOqhI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a0f:b0:6f3:8468:432f with SMTP id
 d2e1a72fcca58-6f4e0373b47mr1096964b3a.3.1715967637081; Fri, 17 May 2024
 10:40:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:05 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-29-seanjc@google.com>
Subject: [PATCH v2 28/49] KVM: x86: Clear PV_UNHALT for !HLT-exiting only when
 userspace sets CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Now that KVM disallows disabling HLT-exiting after vCPUs have been created,
i.e. now that it's impossible for kvm_hlt_in_guest() to change while vCPUs
are running, apply KVM's PV_UNHALT quirk only when userspace is setting
guest CPUID.

Opportunistically rename the helper to make it clear that KVM's behavior
is a quirk that should never have been added.  KVM's documentation
explicitly states that userspace should not advertise PV_UNHALT if
HLT-exiting is disabled, but for unknown reasons, commit caa057a2cad6
("KVM: X86: Provide a capability to disable HLT intercepts") didn't stop
at documenting the requirement and also massaged the incoming guest CPUID.

Unfortunately, it's quite likely that userspace has come to rely on KVM's
behavior, i.e. the code can't simply be deleted.  The only reason KVM
doesn't have an "official" quirk is that there is no known use case where
disabling the quirk would make sense, i.e. letting userspace disable the
quirk would further increase KVM's burden without any benefit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4ad01867cb8d..93a7399dc0db 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -287,18 +287,17 @@ static struct kvm_cpuid_entry2 *kvm_find_kvm_cpuid_features(struct kvm_vcpu *vcp
 					     vcpu->arch.cpuid_nent, base);
 }
 
-static void kvm_update_pv_runtime(struct kvm_vcpu *vcpu)
+static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best = kvm_find_kvm_cpuid_features(vcpu);
 
-	vcpu->arch.pv_cpuid.features = 0;
+	if (!best)
+		return 0;
 
-	/*
-	 * save the feature bitmap to avoid cpuid lookup for every PV
-	 * operation
-	 */
-	if (best)
-		vcpu->arch.pv_cpuid.features = best->eax;
+	if (kvm_hlt_in_guest(vcpu->kvm))
+		best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
+
+	return best->eax;
 }
 
 /*
@@ -320,7 +319,6 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 				       int nent)
 {
 	struct kvm_cpuid_entry2 *best;
-	struct kvm_hypervisor_cpuid kvm_cpuid;
 
 	best = cpuid_entry2_find(entries, nent, 1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
 	if (best) {
@@ -347,13 +345,6 @@ static void __kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu, struct kvm_cpuid_e
 		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
 		best->ebx = xstate_required_size(vcpu->arch.xcr0, true);
 
-	kvm_cpuid = __kvm_get_hypervisor_cpuid(entries, nent, KVM_SIGNATURE);
-	if (kvm_cpuid.base) {
-		best = __kvm_find_kvm_cpuid_features(entries, nent, kvm_cpuid.base);
-		if (kvm_hlt_in_guest(vcpu->kvm) && best)
-			best->eax &= ~(1 << KVM_FEATURE_PV_UNHALT);
-	}
-
 	if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
 		best = cpuid_entry2_find(entries, nent, 0x1, KVM_CPUID_INDEX_NOT_SIGNIFICANT);
 		if (best)
@@ -425,7 +416,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
-	kvm_update_pv_runtime(vcpu);
+	vcpu->arch.pv_cpuid.features = kvm_apply_cpuid_pv_features_quirk(vcpu);
 
 	vcpu->arch.is_amd_compatible = guest_cpuid_is_amd_or_hygon(vcpu);
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
@@ -508,6 +499,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 		 * stale data is ok because KVM will reject the change.
 		 */
 		kvm_update_cpuid_runtime(vcpu);
+		kvm_apply_cpuid_pv_features_quirk(vcpu);
 
 		r = kvm_cpuid_check_equal(vcpu, e2, nent);
 		if (r)
-- 
2.45.0.215.g3402c0e53f-goog



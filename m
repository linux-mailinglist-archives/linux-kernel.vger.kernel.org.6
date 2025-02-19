Return-Path: <linux-kernel+bounces-520760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FCDA3AEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 02:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048073AB003
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA915746F;
	Wed, 19 Feb 2025 01:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAMabYtP"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44C8248C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739928432; cv=none; b=mZ100m05ZX8L2WwGGlJjEEM48j2efD2VqbPLM/GKneUCfppSzuQcnj5nYBAWHbCBwTnAwQE+0pbwU9w+gcRaEW+eiE0nQCaCY+fmXp+YepIVWUbIT3136cFDKnHn5ca9sb8u6FKIaWeIdoiQw1sPSUqVt2Y9Y+1jC3XzPNk65cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739928432; c=relaxed/simple;
	bh=EOmp5p/eXKNkVg6WXQ/ZlC/uLiLJjAeM5pCz0GJMfmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LTvGFWa9P6NBLIRXmfShMw5WMurPyHlv5pQMn2k8Pa5ASaoM1AFhIqC2s4oq+c5pyslygMVZw6/MxHqpf3K10WutPdJkg0I/KRcysiL3AvRDTDVlYuzijFk8ZA5cc7JS5Ucson2M7p7NEDud2c0olRkX/4meKYO3bR4t9TD9JMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAMabYtP; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so13055409a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739928430; x=1740533230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VRgNhxb7FgTdN0Mx3pfakPm2/CieOGAIFcirrQsik3U=;
        b=LAMabYtPCc7buvrQyht+021WfVhihvJKw/xxWP71WlddBZfzQ/BtfYUaF9EEp3UeIq
         VblNMNeVWhOhJJhF9+05Y1PJuPhp2e0/5Ch3kuFK696IN6TqTntRFZWVLKC0ieMnB9hJ
         t1rKiZyzzXN4O+f+s1kNyhnexDNFCyUOyu3j82wdsNSmt6X2IaLX9oEYDK6m5KeKhg0U
         vmRlufkcBCYODreHuoJyZ4h6GgxZ4qHgOQsLNBsrZXsf61ZBK/Xn8nVp+h+dIULMUL8l
         NiAy3C/ywYnfzSXvo5g7+BPZqTFlfhDfuAuyF+z52gyarwgtQFnqJwgQnLZO4tHvFpcn
         LGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739928430; x=1740533230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRgNhxb7FgTdN0Mx3pfakPm2/CieOGAIFcirrQsik3U=;
        b=gtGjoMtwgA3cUOGSIn8ppWAp4gI33mfgAkdIEhuQbXaDKC3XAiFr+GjuGbxFjWA8hW
         CvKeORi4O32ZLdyDPK0ceNaDaW1Abpj3mJsF0UtGtio8b/yFOQH+Qk1iLKXOFQLHyqpz
         x3d5BsVUhapJwdFuJ4ffH5pJhFDmbjrxmBAHcmTwUN++nSKf0w+uDBWKMeW7KdVQzxYj
         dq/NqfDaP99P/F4DsX+ht4QvCNuhYA8PRDmlOfVWQCZlUTjlwg3no+LGTJiNZOqnsw26
         d6YQ73Ch9BGCM8XS5sw6vq01/8rGKzoViXrF3V6olf0lEKBe+lv7JSL23ANzgywgXsWB
         W0OA==
X-Forwarded-Encrypted: i=1; AJvYcCV22lJzU7TMHjHus+u4w0JOsG1jNPdCfQ6OY7NKbPENAYCmCwd80I51Owr1nGkRzT0whEwOnrUwxVXWIcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJwzsRUH3lAOfaKVV69yOxtTB2efke30v9GNkVfdKt9WbsRxVE
	8h8dLrB0/qTvTCGoSRSDCfQ487lD/SLxMvjycJkAZX1bXI5+N4C9PHxfqCmbz37vInKnmg5botB
	5tg==
X-Google-Smtp-Source: AGHT+IFSUmW3Pv37hBOcPGebWzOzBiwxgMgqtgIXN+HtyasCo2QrSGcjbna1nnb4kpL4ZFFfQj95yAFiK64=
X-Received: from pjbsn5.prod.google.com ([2002:a17:90b:2e85:b0:2ee:53fe:d0fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4b8c:b0:2ee:e18b:c1fa
 with SMTP id 98e67ed59e1d1-2fcb5a9a0c4mr2447828a91.28.1739928429817; Tue, 18
 Feb 2025 17:27:09 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 18 Feb 2025 17:26:56 -0800
In-Reply-To: <20250219012705.1495231-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219012705.1495231-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219012705.1495231-2-seanjc@google.com>
Subject: [PATCH 01/10] KVM: SVM: Save host DR masks but NOT DRs on CPUs with DebugSwap
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="UTF-8"

When running SEV-SNP guests on a CPU that supports DebugSwap, always save
the host's DR0..DR3 mask MSR values irrespective of whether or not
DebugSwap is enabled, to ensure the host values aren't clobbered by the
CPU.

SVM_VMGEXIT_AP_CREATE is deeply flawed in that it allows the *guest* to
create a VMSA with guest-controlled SEV_FEATURES.  A well behaved guest
can inform the hypervisor, i.e. KVM, of its "requested" features, but on
CPUs without ALLOWED_SEV_FEATURES support, nothing prevents the guest from
lying about which SEV features are being enabled (or not!).

If a misbehaving guest enables DebugSwap in a secondary vCPU's VMSA, the
CPU will load the DR0..DR3 mask MSRs on #VMEXIT, i.e. will clobber the
MSRs with '0' if KVM doesn't save its desired value.

Note, DR0..DR3 themselves are "ok", as DR7 is reset on #VMEXIT, and KVM
restores all DRs in common x86 code as needed via hw_breakpoint_restore().
I.e. there is no risk of host DR0..DR3 being clobbered (when it matters).
However, there is a flaw in the opposite direction; because the guest can
lie about enabling DebugSwap, i.e. can *disable* DebugSwap without KVM's
knowledge, KVM must not rely on the CPU to restore DRs.  Defer fixing
that wart, as it's more of a documentation issue than a bug in the code.

Note, KVM added support for DebugSwap on commit d1f85fbe836e ("KVM: SEV:
Enable data breakpoints in SEV-ES"), but that is not an appropriate Fixes,
as the underlying flaw exists in hardware, not in KVM.  I.e. all kernels
that support SEV-SNP need to be patched, not just kernels with KVM's full
support for DebugSwap (ignoring that DebugSwap support landed first).

Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74525651770a..e3606d072735 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4568,6 +4568,8 @@ void sev_es_vcpu_reset(struct vcpu_svm *svm)
 
 void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_area *hostsa)
 {
+	struct kvm *kvm = svm->vcpu.kvm;
+
 	/*
 	 * All host state for SEV-ES guests is categorized into three swap types
 	 * based on how it is handled by hardware during a world switch:
@@ -4592,9 +4594,14 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 	/*
 	 * If DebugSwap is enabled, debug registers are loaded but NOT saved by
 	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU both
-	 * saves and loads debug registers (Type-A).
+	 * saves and loads debug registers (Type-A).  Sadly, on CPUs without
+	 * ALLOWED_SEV_FEATURES, KVM can't prevent SNP guests from enabling
+	 * DebugSwap on secondary vCPUs without KVM's knowledge via "AP Create",
+	 * and so KVM must save DRs if DebugSwap is supported to prevent DRs
+	 * from being clobbered by a misbehaving guest.
 	 */
-	if (sev_vcpu_has_debug_swap(svm)) {
+	if (sev_vcpu_has_debug_swap(svm) ||
+	    (sev_snp_guest(kvm) && cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP))) {
 		hostsa->dr0 = native_get_debugreg(0);
 		hostsa->dr1 = native_get_debugreg(1);
 		hostsa->dr2 = native_get_debugreg(2);
-- 
2.48.1.601.g30ceb7b040-goog



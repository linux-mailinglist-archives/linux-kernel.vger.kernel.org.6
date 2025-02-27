Return-Path: <linux-kernel+bounces-535324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE5A47152
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E0B3B3217
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97394145B0B;
	Thu, 27 Feb 2025 01:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlIK2f0e"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475DF145B25
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619548; cv=none; b=ofjKNoQaRx0hVShJXfubBN422MrU9ngS3aGiOVvAgch3ljhwSZk4mDxdpQKjzbvHgomOQ9W4ekUE4ohPsWm+FPoYRldnHBgBRYWC4G/kzXWbzyk113rHv80Y+TsxfGe3fDCY6KNxUVppdRAjPaPVJ4yIPCrsxc2eVAFfvDWo4jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619548; c=relaxed/simple;
	bh=kEAizSXrh46aeFhOp+VD1iskoyu83eS9VfMafXdoPyw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g7g9k1+SrvcgtGQqEiFrYzI9bbmPCtpL6me8z/0Vs7yRzmQnnDb9Lu2NuaZQUpMD55BFLh+nTXISSH1/aZZ69MuDOugj49WnDGxyRofdGooMG/8/rVEOXF2NNC8sfdiWubfD3EpEG16IzhNIQT11vYSYXmS9stsIDZbV8/jkWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlIK2f0e; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c14d4so965126a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740619545; x=1741224345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WBxe6FmXCGOPrPFuVLhffc7/ElAQfUF91a/RZlH0SFI=;
        b=YlIK2f0ep01e3unET3wZ9cspamj371E0ovB/7pMWFyYyzcsx2b0dvYfYJg2J2/qVz4
         rcWLly3sQsO7/7Tm4yzQ+cDOmHrq1DwYFBpm75y03thRTCWzQiKDsKuIDjF4yuUkKql8
         A4jonxLdsvuTzuS+LUOzrJHhlaiKyG42XgwBzxjhSyuEj93lcv2lL2CketCFh3ET+4Ec
         u1ABhrE8qXWbFY2CJr3ju0HqyIOpREVCo0O56Cjua4kz4G9HA1BUckagflQfJxnn1Tl/
         2tf6z+1rRW3NxqBhyjf8EK94T08RlEpoxH2apQLWn9pb9qE9mrGWnk4Zw+6DMaCaMme0
         tFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619545; x=1741224345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBxe6FmXCGOPrPFuVLhffc7/ElAQfUF91a/RZlH0SFI=;
        b=GK5Ilg31fMWY+d5txVJ2yvo2+DyW5WMTAeF/7WsBTKXgqrDDDRmiVu6zt5fgZmVxiu
         CazCYEIOV7aHSLqxq5AZmqa7Ze23nlsMDpCyhDm5Ms3IT85blv/P6p27ELbEv4g1nTKf
         vNhqHZUVdmhS5MruJ4oYepTjAIVQ542jj3B2bhhJfsXSdRdRilZUpjLn9nz3gzpU8FzG
         +tA2+VMWRMJARYfYQiuj/spT/YaMMgo5kgR81mOZyW7kojXK2bne7CHEQTK0nXHADNML
         YsKvfaGf1EtmUNh7owX4hb88dZG4/dsQaiUaIF9eFgU/XFZc4NqqtMuHSektRN3gBa+U
         gpeg==
X-Forwarded-Encrypted: i=1; AJvYcCVDd24A2fd70kE3m91i5HLtfx+re2y/0yoDHz/679SolkJRZWQdfFw127yHUJCTO2ec5XRdHh6NLQoasoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVydOBXE2+nemAtfXP3gukRHrfSvwnIYOwx9GnTGNItmdqi3jf
	ghxCm8yfHh1P3bzB0ofGk5zK/+F+OZT63wZq8WJqzXURW3qowxoekXXI6L/6KA+p4hgEp3mpFCS
	bhw==
X-Google-Smtp-Source: AGHT+IFLLB2ah5LUDPH7+jBTjfbaA9q03uHcgdVTCPpDNBjOdpdUzsxjWAd40Su+shcjHt/50lC87iRJyZ0=
X-Received: from pjb3.prod.google.com ([2002:a17:90b:2f03:b0:2fa:a101:743])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ecf:b0:2ee:f19b:86e5
 with SMTP id 98e67ed59e1d1-2fe68ada443mr17254991a91.14.1740619545636; Wed, 26
 Feb 2025 17:25:45 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:25:32 -0800
In-Reply-To: <20250227012541.3234589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012541.3234589-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227012541.3234589-2-seanjc@google.com>
Subject: [PATCH v2 01/10] KVM: SVM: Save host DR masks on CPUs with DebugSwap
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

When running SEV-SNP guests on a CPU that supports DebugSwap, always save
the host's DR0..DR3 mask MSR values irrespective of whether or not
DebugSwap is enabled, to ensure the host values aren't clobbered by the
CPU.  And for now, also save DR0..DR3, even though doing so isn't
necessary (see below).

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

Opportunistically fix an incorrect statement in the comment; on CPUs
without DebugSwap, the CPU does NOT save or load debug registers, i.e.

Fixes: e366f92ea99e ("KVM: SEV: Support SEV-SNP AP Creation NAE event")
Cc: stable@vger.kernel.org
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Alexey Kardashevskiy <aik@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 74525651770a..5c3d8618b722 100644
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
@@ -4591,10 +4593,15 @@ void sev_es_prepare_switch_to_guest(struct vcpu_svm *svm, struct sev_es_save_are
 
 	/*
 	 * If DebugSwap is enabled, debug registers are loaded but NOT saved by
-	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU both
-	 * saves and loads debug registers (Type-A).
+	 * the CPU (Type-B). If DebugSwap is disabled/unsupported, the CPU does
+	 * not save or load debug registers.  Sadly, on CPUs without
+	 * ALLOWED_SEV_FEATURES, KVM can't prevent SNP guests from enabling
+	 * DebugSwap on secondary vCPUs without KVM's knowledge via "AP Create".
+	 * Save all registers if DebugSwap is supported to prevent host state
+	 * from being clobbered by a misbehaving guest.
 	 */
-	if (sev_vcpu_has_debug_swap(svm)) {
+	if (sev_vcpu_has_debug_swap(svm) ||
+	    (sev_snp_guest(kvm) && cpu_feature_enabled(X86_FEATURE_DEBUG_SWAP))) {
 		hostsa->dr0 = native_get_debugreg(0);
 		hostsa->dr1 = native_get_debugreg(1);
 		hostsa->dr2 = native_get_debugreg(2);
-- 
2.48.1.711.g2feabab25a-goog



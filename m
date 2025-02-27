Return-Path: <linux-kernel+bounces-535332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CA5A47155
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22CA57A587A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D211222FAFD;
	Thu, 27 Feb 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gISGwIj3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C622E3E6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619561; cv=none; b=U1NPF91YoAW1vvA8dhhnLm+1j1vwkYhROdlzS8h0zuR5noLa4WLhwj++zVGS3X2L0cjidD0KQYm0zxhqjvjJ18EKg92CCcs87kqVSE9SDIYia3F0N/nEO1LFvlam5gMuL395elAJ/HqOghpolN+VatqbqdJKhFkuNDdp9AlZjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619561; c=relaxed/simple;
	bh=SlIP7vUVEAl3Nff6A3KsmF5s6lnEtycCZy5mDlywOrM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nSo3Ygn3d8GgsnEwkF+gJL2veuD3A2Y8NNrjD9K0fxtJ0k9xncCpslBqdny9uWHVw1S93ky9pMAxxKw50JSNHV8BMpaM9NpW9cUlFs7Fj+m8h7pj/cH5bUQMClTpFbBpPrH52/LVoXg9Vw5aztYErnWpH5TkqohBhmfpB4u7oHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gISGwIj3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8c5dbdb0so960943a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 17:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740619559; x=1741224359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=IOWwEu0l/k3HhYntL/yg0gERPToOEmSlz8zTPMBWJgM=;
        b=gISGwIj3vhxdRYYF83elUi4DoTM6Y4ggEZPZtUJhMf4xfHehe3LNKkSQtpWVhpBBF4
         0N/86YkqRAaoW/xtpjwAhVDro6pDvS8WGJ+ubOAbeciuhkTBFtTqIyuHcH6S+CfsmbC4
         ahO1TJSJ+Aw2WHtsCijR4R5m7PlQI8WNIIrfrSIKjfhfuq40jypKHVSPwz5VHNIWG8s1
         jpBIKMx1YrO97yQrxZwRcDRT2suMMfJ5xxRlxPZ5T6i8TLmH2BBXqx4tAvSgN38arWf/
         ZdM9kJMEM77TBdtkjFNJXPpkozBAMYYAlrPBUV7rm3GGX6uEAftRyO6sx8O5veYVTgdg
         1U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619559; x=1741224359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOWwEu0l/k3HhYntL/yg0gERPToOEmSlz8zTPMBWJgM=;
        b=js3UmB+71tul40ZD7UW4UBmmiu2wkeNJdtXb1mZMOH+dUUERn5is0TgdfqhXpRshrU
         MwfAKWWCum8BWBYmgnvcmyvgbgGCm+TEn7jX+HtLLWn3EOBb9EjGzaF9k9x9ApwLg3BX
         3poKbZFXYiP0QhLFQTS1xxYCkzmYD6PCzkTuV/e7OYMsDT0pj0tLBne2ROPq4b0YHJK1
         9CONNRh9pXFDk3FejAPeiXCHCdtaBKt3KS2V8wzVnePXw+8Mw18G9UUhbc+LMw2ef+F4
         vv63eGQ/aQC70RPvOR/ki/U3pGWBALfbmyOGJ75L7OxcpEbzLeJ4UbJC9NpYuecIIx7X
         /4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOueKX98Kg6USlXAer8MBKrPdgCAcc89vGsV4aRu40d5HNawybq3tedeavY8LP9OwX3RCb2/clIrId7SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFrXNWue9f0Gr5SopE7sP8FXpjZhOipOlxo7MWGzNwgJl0LUs
	29f4+izT/i/FpyGPBPQekpZvz3pErYGcB8YcbOQt9bw8ofCHaaDJVUUaypAC3Smnk/XHGGQKMXY
	CIg==
X-Google-Smtp-Source: AGHT+IGFu8FDn0du2s+v5ekzGMy8fn8oWBPrPcbohW0kjuPN3LZYNucs2Vyp5314eaCBsaigs6BDRwkMzfU=
X-Received: from pja5.prod.google.com ([2002:a17:90b:5485:b0:2fa:1fac:2695])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2502:b0:2fe:9783:afd3
 with SMTP id 98e67ed59e1d1-2fe9783b117mr3818666a91.2.1740619558983; Wed, 26
 Feb 2025 17:25:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 17:25:40 -0800
In-Reply-To: <20250227012541.3234589-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227012541.3234589-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227012541.3234589-10-seanjc@google.com>
Subject: [PATCH v2 09/10] KVM: SVM: Use guard(mutex) to simplify SNP vCPU
 state updates
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Naveen N Rao <naveen@kernel.org>, Kim Phillips <kim.phillips@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>
Content-Type: text/plain; charset="UTF-8"

Use guard(mutex) in sev_snp_init_protected_guest_state() and pull in its
lock-protected inner helper.  Without an unlock trampoline (and even with
one), there is no real need for an inner helper.  Eliminating the helper
also avoids having to fixup the open coded "lockdep" WARN_ON().

Opportunistically drop the error message if KVM can't obtain the pfn for
the new target VMSA.  The error message provides zero information that
can't be gleaned from the fact that the vCPU is stuck.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 122 ++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 69 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c74cc64ceb81..3f85bd1cac37 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3837,11 +3837,26 @@ static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
 	BUG();
 }
 
-static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
+/*
+ * Invoked as part of svm_vcpu_reset() processing of an init event.
+ */
+void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct kvm_memory_slot *slot;
+	struct page *page;
+	kvm_pfn_t pfn;
+	gfn_t gfn;
 
-	WARN_ON(!mutex_is_locked(&svm->sev_es.snp_vmsa_mutex));
+	if (!sev_snp_guest(vcpu->kvm))
+		return;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (!svm->sev_es.snp_ap_waiting_for_reset)
+		return;
+
+	svm->sev_es.snp_ap_waiting_for_reset = false;
 
 	/* Mark the vCPU as offline and not runnable */
 	vcpu->arch.pv.pv_unhalted = false;
@@ -3856,78 +3871,47 @@ static int __sev_snp_update_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (VALID_PAGE(svm->sev_es.snp_vmsa_gpa)) {
-		gfn_t gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-		struct kvm_memory_slot *slot;
-		struct page *page;
-		kvm_pfn_t pfn;
-
-		slot = gfn_to_memslot(vcpu->kvm, gfn);
-		if (!slot)
-			return -EINVAL;
-
-		/*
-		 * The new VMSA will be private memory guest memory, so
-		 * retrieve the PFN from the gmem backend.
-		 */
-		if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
-			return -EINVAL;
-
-		/*
-		 * From this point forward, the VMSA will always be a
-		 * guest-mapped page rather than the initial one allocated
-		 * by KVM in svm->sev_es.vmsa. In theory, svm->sev_es.vmsa
-		 * could be free'd and cleaned up here, but that involves
-		 * cleanups like wbinvd_on_all_cpus() which would ideally
-		 * be handled during teardown rather than guest boot.
-		 * Deferring that also allows the existing logic for SEV-ES
-		 * VMSAs to be re-used with minimal SNP-specific changes.
-		 */
-		svm->sev_es.snp_has_guest_vmsa = true;
-
-		/* Use the new VMSA */
-		svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
-
-		/* Mark the vCPU as runnable */
-		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
-		svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
-
-		/*
-		 * gmem pages aren't currently migratable, but if this ever
-		 * changes then care should be taken to ensure
-		 * svm->sev_es.vmsa is pinned through some other means.
-		 */
-		kvm_release_page_clean(page);
-	}
-
-	return 0;
-}
-
-/*
- * Invoked as part of svm_vcpu_reset() processing of an init event.
- */
-void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
-{
-	struct vcpu_svm *svm = to_svm(vcpu);
-	int ret;
-
-	if (!sev_snp_guest(vcpu->kvm))
+	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
 		return;
 
-	mutex_lock(&svm->sev_es.snp_vmsa_mutex);
+	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
 
-	if (!svm->sev_es.snp_ap_waiting_for_reset)
-		goto unlock;
-
-	svm->sev_es.snp_ap_waiting_for_reset = false;
+	slot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!slot)
+		return;
 
-	ret = __sev_snp_update_protected_guest_state(vcpu);
-	if (ret)
-		vcpu_unimpl(vcpu, "snp: AP state update on init failed\n");
+	/*
+	 * The new VMSA will be private memory guest memory, so retrieve the
+	 * PFN from the gmem backend.
+	 */
+	if (kvm_gmem_get_pfn(vcpu->kvm, slot, gfn, &pfn, &page, NULL))
+		return;
 
-unlock:
-	mutex_unlock(&svm->sev_es.snp_vmsa_mutex);
+	/*
+	 * From this point forward, the VMSA will always be a guest-mapped page
+	 * rather than the initial one allocated by KVM in svm->sev_es.vmsa. In
+	 * theory, svm->sev_es.vmsa could be free'd and cleaned up here, but
+	 * that involves cleanups like wbinvd_on_all_cpus() which would ideally
+	 * be handled during teardown rather than guest boot.  Deferring that
+	 * also allows the existing logic for SEV-ES VMSAs to be re-used with
+	 * minimal SNP-specific changes.
+	 */
+	svm->sev_es.snp_has_guest_vmsa = true;
+
+	/* Use the new VMSA */
+	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
+
+	/* Mark the vCPU as runnable */
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
+
+	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+
+	/*
+	 * gmem pages aren't currently migratable, but if this ever changes
+	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
+	 * through some other means.
+	 */
+	kvm_release_page_clean(page);
 }
 
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
-- 
2.48.1.711.g2feabab25a-goog



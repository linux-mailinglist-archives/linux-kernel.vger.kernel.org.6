Return-Path: <linux-kernel+bounces-424057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863109DB025
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D36F282316
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284961991CA;
	Thu, 28 Nov 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gUsYxC5T"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39E6157E82
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732752022; cv=none; b=Jdz87KfYp5PHGvNBKpHhiQvr4vtAd4JaWtM+X1gZDyNpZNq7wGr3epEGDNLN4bFGMD71nMJcKfzqZNV0cp8qbbOtiPMUTZUj7/T6nttRqflTgfn7DLts18CKFGoojuyQqLKlX+Wwg+X946UYnWrGIZ8vMtbO6Dc7eUBAVohfyjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732752022; c=relaxed/simple;
	bh=Bl9YBE2svj+PNz1C/aoO6LFubVNyHfLcVRkyqL8L6ao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b86Al6gnr8XptOx6HZCSe61uYNzCfKqaJed52h/e1JSsjy3X7DgQ9PEcs2wo7exBDWiuXLD/QN5r9Kd+vbo/AU2pBy+2/nm8Ou78IEsfOkfqFRjq/Oiz9Nk8rDLtNb+bmcmk4kqGE02q7vkgaQwo9Qzyb15FlwmXW0cL+aoA7T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gUsYxC5T; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea0069a8b0so124172a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732752019; x=1733356819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+H2iSWdqRj5eAJy1r0kI7Xo89w48MESzlLl9jWX3kvs=;
        b=gUsYxC5TmWUSQRgxXGAgCNfzsxeQUGDIlAr/ywvHmQ3Z7UOPBMjCaJYoQTx0n7AM9i
         ++nVpllJnGl9hDdxp6EGTVl3e/63eVZ7Di1vBrMJbDvyGKM/vz6OQBytfunefSNNzk84
         bE+V4eIErHyuTjEEy9eNd1FlJwvLnTZItgB2fiViIs3hPIWaJF6bZQuXd03EHTMAsjgw
         tfZO+rYCzEZNQBPv055har8wpixiAznd0+EXdrjphknCxfdoiTLmrp286acn4libnU60
         sfFvo7DhsejoeOsa1VcMtnU2umcobtfCuoDDFD7xYainSr2cHFRqUSM3wB6JlkGPJVd4
         eVIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732752019; x=1733356819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+H2iSWdqRj5eAJy1r0kI7Xo89w48MESzlLl9jWX3kvs=;
        b=uUfz0XpFLGj/asYluxZK1OGmvJ+LPEpZDxt5M/KveQm8rglaCGcbEqpcOQQ47+unXD
         B1O6xHMnTR8KVaO21TI/XQIKmZZUyz3f0XqEddblhQWc/KvzBY1ytUamPA1M+uobDN4v
         FTzVnW6ucDXU+/xi7XcgI+uyZePKBomJtF63QxeeMmeAhTXbf2EGGFZfpqdanj7dIiGn
         jIzowmnpdRWCGd1hkn7plj1UD4E+e3ojPq0Xy0cdo+bI21NRMc2MMxNN4VqwFEU4FHhB
         i0KzIXMWZOna17bWnUY2gtZY5mamNjUzyb9kcoJZ/ggl5BH1wExqho1oTHQUmoKLLSes
         TMGA==
X-Forwarded-Encrypted: i=1; AJvYcCW+DTMhCeG6oMw25e8+kIJp89eEuOOaTt75V1yrGo2wSsXM/6mLfCrrDPsbjvhAE6N6TCgvqkPyE0bSwKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqd3C7rKb3OATDtbdv6cOahPwv0qq9qZzh3/HpHJp/1MU/XBpY
	NQGY4g3aBpgQ5rBKLhQaCOVAC7orWijtNEfOb5L33lyqs6jwe319exFTWnmkDJvdmxN0zphkdsX
	+2Q==
X-Google-Smtp-Source: AGHT+IEnhKnLTNnY6wu2VCIdO8CckiAJ2KH61nyu+EuExVAT6pK4GO2kObcoAN/7xl77VvVEEQEtoZT3aIU=
X-Received: from pjbqj5.prod.google.com ([2002:a17:90b:28c5:b0:2ea:9f2f:2ad9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4394:b0:1db:d8df:8c4e
 with SMTP id adf61e73a8af0-1e0e0afa6c0mr7417582637.12.1732752019145; Wed, 27
 Nov 2024 16:00:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:00:09 -0800
In-Reply-To: <20241128000010.4051275-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128000010.4051275-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128000010.4051275-2-seanjc@google.com>
Subject: [PATCH v2 1/2] KVM: x86: Plumb in the vCPU to kvm_x86_ops.hwapic_isr_update()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chao Gao <chao.gao@intel.com>, 
	"=?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?=" <mankku@gmail.com>, Janne Karhunen <janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Pass the target vCPU to the hwapic_isr_update() vendor hook so that VMX
can defer the update until after nested VM-Exit if an EOI for L1's vAPIC
occurs while L2 is active.

Note, commit d39850f57d21 ("KVM: x86: Drop @vcpu parameter from
kvm_x86_ops.hwapic_isr_update()") removed the parameter with the
justification that doing so "allows for a decent amount of (future)
cleanup in the APIC code", but it's not at all clear what cleanup was
intended, or if it was ever realized.

No functional change intended.

Cc: stable@vger.kernel.org
Reviewed-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/lapic.c            | 11 +++++------
 arch/x86/kvm/vmx/vmx.c          |  2 +-
 arch/x86/kvm/vmx/x86_ops.h      |  2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e159e44a6a1b..5aa50dfe0104 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1735,7 +1735,7 @@ struct kvm_x86_ops {
 	bool allow_apicv_in_x2apic_without_x2apic_virtualization;
 	void (*refresh_apicv_exec_ctrl)(struct kvm_vcpu *vcpu);
 	void (*hwapic_irr_update)(struct kvm_vcpu *vcpu, int max_irr);
-	void (*hwapic_isr_update)(int isr);
+	void (*hwapic_isr_update)(struct kvm_vcpu *vcpu, int isr);
 	void (*load_eoi_exitmap)(struct kvm_vcpu *vcpu, u64 *eoi_exit_bitmap);
 	void (*set_virtual_apic_mode)(struct kvm_vcpu *vcpu);
 	void (*set_apic_access_page_addr)(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 3c83951c619e..39ae2f5f9866 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -763,7 +763,7 @@ static inline void apic_set_isr(int vec, struct kvm_lapic *apic)
 	 * just set SVI.
 	 */
 	if (unlikely(apic->apicv_active))
-		kvm_x86_call(hwapic_isr_update)(vec);
+		kvm_x86_call(hwapic_isr_update)(apic->vcpu, vec);
 	else {
 		++apic->isr_count;
 		BUG_ON(apic->isr_count > MAX_APIC_VECTOR);
@@ -808,7 +808,7 @@ static inline void apic_clear_isr(int vec, struct kvm_lapic *apic)
 	 * and must be left alone.
 	 */
 	if (unlikely(apic->apicv_active))
-		kvm_x86_call(hwapic_isr_update)(apic_find_highest_isr(apic));
+		kvm_x86_call(hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));
 	else {
 		--apic->isr_count;
 		BUG_ON(apic->isr_count < 0);
@@ -2806,7 +2806,7 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 	if (apic->apicv_active) {
 		kvm_x86_call(apicv_post_state_restore)(vcpu);
 		kvm_x86_call(hwapic_irr_update)(vcpu, -1);
-		kvm_x86_call(hwapic_isr_update)(-1);
+		kvm_x86_call(hwapic_isr_update)(vcpu, -1);
 	}
 
 	vcpu->arch.apic_arb_prio = 0;
@@ -3121,9 +3121,8 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
 	kvm_apic_update_apicv(vcpu);
 	if (apic->apicv_active) {
 		kvm_x86_call(apicv_post_state_restore)(vcpu);
-		kvm_x86_call(hwapic_irr_update)(vcpu,
-						apic_find_highest_irr(apic));
-		kvm_x86_call(hwapic_isr_update)(apic_find_highest_isr(apic));
+		kvm_x86_call(hwapic_irr_update)(vcpu, apic_find_highest_irr(apic));
+		kvm_x86_call(hwapic_isr_update)(vcpu, apic_find_highest_isr(apic));
 	}
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 	if (ioapic_in_kernel(vcpu->kvm))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 893366e53732..22cb11ab8709 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6862,7 +6862,7 @@ void vmx_set_apic_access_page_addr(struct kvm_vcpu *vcpu)
 	read_unlock(&vcpu->kvm->mmu_lock);
 }
 
-void vmx_hwapic_isr_update(int max_isr)
+void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr)
 {
 	u16 status;
 	u8 old;
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index a55981c5216e..48dc76bf0ec0 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -48,7 +48,7 @@ void vmx_migrate_timers(struct kvm_vcpu *vcpu);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 void vmx_apicv_pre_state_restore(struct kvm_vcpu *vcpu);
 void vmx_hwapic_irr_update(struct kvm_vcpu *vcpu, int max_irr);
-void vmx_hwapic_isr_update(int max_isr);
+void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr);
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
 void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 			   int trig_mode, int vector);
-- 
2.47.0.338.g60cca15819-goog



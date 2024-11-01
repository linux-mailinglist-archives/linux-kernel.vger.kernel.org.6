Return-Path: <linux-kernel+bounces-392808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2629B985A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD431B218A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBE31D0413;
	Fri,  1 Nov 2024 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abiI+iDF"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA901CFECC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 19:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488882; cv=none; b=et9TQM7YG8hyv9KV56jGTccRDRlA6+3NnrwEJCK2oZzKUC8FEsxR5isSSqyk9ym77oCOxIIgDpru+AneYlRz9yWf8diJR1VZ6nZWjnk19PEYMwNSmTHRJMiINpE6geDJUWO8Ho/4a8xylNFwSixURiVBvadVo6oSADii0WstJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488882; c=relaxed/simple;
	bh=VNcFDJ/BfS8swfjaZOe+/CdaDzctcaVEvZ9LzvoVWGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Np3FdFKkWaP1FYwAwTkJslrFq46k7Do8KTo9EkqvumOvThARskcq7q98S/6QF/f9ZqPwPWLptknK/kvxKuoAh11a9SKyrFDCiupU4r9ecw3CZw1nJ3quroz2esDwd8sVExiBSJzAPCGCtxhHyCtsXXdq00y7Po/JiOnMiyuuU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abiI+iDF; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea7b3b056eso2234706a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 12:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730488879; x=1731093679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsWEN0kBrD1owmF1Hf4fam34LLlisqiiRf0es6GMZq0=;
        b=abiI+iDFqVTrmZYyWAK/o1Cc/YrD3NvhYelDm1NHHZfzBoEedkUqtqIqpHg7J4YA7e
         +HtK3WRYBNmbr/nleLoiy9KOk4IFN49Lj+StytkDiqI14MrH/08LmK+7D4aasc+K7xm2
         ZXViSg2Evo2UVasmIumJK2zguc81Mbp3e2rhI2+q8boS6H0bkvKHDMtFgDZeZYZOUZhf
         ObaUu/owpBoRT1RqgJpLol+A0JjHM9LBJfXQCO5WOg1yK+90jJCmio74OwdIiVgrEsYw
         MNil4ejhqgdfo/8NMJxUjor1vXVJ8e+XEvYUI0LUuGPsHd3cuWS1/0jJ0cXIvua2msr8
         dEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730488879; x=1731093679;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zsWEN0kBrD1owmF1Hf4fam34LLlisqiiRf0es6GMZq0=;
        b=ZBoDnEDcjOA70Remm1E2QjatD9W7scZvW03Oe5mKVsPVHiZLC4AW8TuxTYpg/7r7QY
         MHCF3SUcSqVziQtOqeLVrAMi7g7I0aJFGalHPS6wAVYDuViayP7Ys/9XJ9cJmhcR5zr8
         Bv5AyyHgvfEeRGAB1w2UC8utgq+fyXxX66JK+NudQeVQNNDtP9wFU1FSgmYJ0bBVZ8Uh
         R6heuBAPuz8vbTpN7207bhO4+P04bdapgTTdxK1LZCNjkomgg4S/MR7xk/OGHuTy4Iun
         izdalJ8IMLX5WgOj1AI8N9s+RWdEr6xalXJabGWZ/Hzn5bY42TdxcJbnfnCNytPdBb64
         J1AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO9JU3LuP5Ejk+gqpLc8LOuPrHVruL6NfOUF1efm7op7l8yvSzla/YFzg2ZOgLCSWz8dN5nIPUTItly5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfD5q642PLtr/YdK3aAUB3XMrL/wDIQQ3G+pii1+9vH0GOJ/XV
	PTQpHIIyt9PKoLJ+4VUHD+ApCjw9mJBvht3aA8g0mOTbpabB/AkWJkSHP36acN7n/wL8gWvL9zp
	kTQ==
X-Google-Smtp-Source: AGHT+IEd6tYZSc6WgovK45TENJxXNwUmxrJ7BFek2I1PttGA6PQ0mW/mRddLhh9jqcQP8SP4bvK4BtqnipI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90b:3717:b0:2e2:bd9a:4ff0 with SMTP id
 98e67ed59e1d1-2e94c53c2damr7112a91.7.1730488879319; Fri, 01 Nov 2024 12:21:19
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 12:21:14 -0700
In-Reply-To: <20241101192114.1810198-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101192114.1810198-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101192114.1810198-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: nVMX: Defer SVI update to vmcs01 on EOI when L2 is
 active w/o VID
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"=?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?=" <mankku@gmail.com>, Janne Karhunen <janne.karhunen@gmail.com>, 
	Chao Gao <chao.gao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Chao Gao <chao.gao@intel.com>

If KVM emulates an EOI for L1's virtual APIC while L2 is active, defer
updating GUEST_INTERUPT_STATUS.SVI, i.e. the VMCS's cache of the highest
in-service IRQ, until L1 is active, as vmcs01, not vmcs02, needs to track
vISR.  The missed SVI update for vmcs01 can result in L1 interrupts being
incorrectly blocked, e.g. if there is a pending interrupt with lower
priority than the interrupt that was EOI'd.

This bug only affects use cases where L1's vAPIC is effectively passed
through to L2, e.g. in a pKVM scenario where L2 is L1's depriveleged host,
as KVM will only emulate an EOI for L1's vAPIC if Virtual Interrupt
Delivery (VID) is disabled in vmc12, and L1 isn't intercepting L2 accesses
to its (virtual) APIC page (or if x2APIC is enabled, the EOI MSR).

WARN() if KVM updates L1's ISR while L2 is active with VID enabled, as an
EOI from L2 is supposed to affect L2's vAPIC, but still defer the update,
to try to keep L1 alive.  Specifically, KVM forwards all APICv-related
VM-Exits to L1 via nested_vmx_l1_wants_exit():

	case EXIT_REASON_APIC_ACCESS:
	case EXIT_REASON_APIC_WRITE:
	case EXIT_REASON_EOI_INDUCED:
		/*
		 * The controls for "virtualize APIC accesses," "APIC-
		 * register virtualization," and "virtual-interrupt
		 * delivery" only come from vmcs12.
		 */
		return true;

Fixes: c7c9c56ca26f ("x86, apicv: add virtual interrupt delivery support")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/kvm/20230312180048.1778187-1-jason.cj.chen@in=
tel.com
Reported-by: Markku Ahvenj=C3=A4rvi <mankku@gmail.com>
Closes: https://lore.kernel.org/all/20240920080012.74405-1-mankku@gmail.com
Cc: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
[sean: drop request, handle in VMX, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c      | 11 +++++++++++
 arch/x86/kvm/lapic.h      |  1 +
 arch/x86/kvm/vmx/nested.c |  5 +++++
 arch/x86/kvm/vmx/vmx.c    | 17 +++++++++++++++++
 arch/x86/kvm/vmx/vmx.h    |  1 +
 5 files changed, 35 insertions(+)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 5be2be44a188..66751bf9d4f4 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -816,6 +816,17 @@ static inline void apic_clear_isr(int vec, struct kvm_=
lapic *apic)
 	}
 }
=20
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu)
+{
+	struct kvm_lapic *apic =3D vcpu->arch.apic;
+
+	if (WARN_ON_ONCE(!lapic_in_kernel(vcpu)) || !apic->apicv_active)
+		return;
+
+	kvm_x86_call(hwapic_isr_update)(apic->vcpu, apic_find_highest_isr(apic));
+}
+EXPORT_SYMBOL_GPL(kvm_apic_update_hwapic_isr);
+
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu)
 {
 	/* This may race with setting of irr in __apic_accept_irq() and
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 1b8ef9856422..469a6f20e2db 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -122,6 +122,7 @@ int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr=
_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu);
+void kvm_apic_update_hwapic_isr(struct kvm_vcpu *vcpu);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
=20
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 746cb41c5b98..0111539fcea1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5036,6 +5036,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm=
_exit_reason,
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
=20
+	if (vmx->nested.update_vmcs01_hwapic_isr) {
+		vmx->nested.update_vmcs01_hwapic_isr =3D false;
+		kvm_apic_update_hwapic_isr(vcpu);
+	}
+
 	if ((vm_exit_reason !=3D -1) &&
 	    (enable_shadow_vmcs || nested_vmx_is_evmptr12_valid(vmx)))
 		vmx->nested.need_vmcs12_to_shadow_sync =3D true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index fe9887a5fa4a..a3513fc05a01 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6873,6 +6873,23 @@ void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, in=
t max_isr)
 	u16 status;
 	u8 old;
=20
+	/*
+	 * If L2 is active, defer the SVI update until vmcs01 is loaded, as SVI
+	 * is only relevant for if and only if Virtual Interrupt Delivery is
+	 * enabled in vmcs12, and if VID is enabled then L2 EOIs affect L2's
+	 * vAPIC, not L1's vAPIC.  KVM must update vmcs01 on the next nested
+	 * VM-Exit, otherwise L1 with run with a stale SVI.
+	 */
+	if (is_guest_mode(vcpu)) {
+		/*
+		 * KVM is supposed to forward intercepted L2 EOIs to L1 if VID
+		 * is enabled in vmcs12; as above, the EOIs affect L2's vAPIC.
+		 */
+		WARN_ON_ONCE(nested_cpu_has_vid(get_vmcs12(vcpu)));
+		to_vmx(vcpu)->nested.update_vmcs01_hwapic_isr =3D true;
+		return;
+	}
+
 	if (max_isr =3D=3D -1)
 		max_isr =3D 0;
=20
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 43f573f6ca46..892302022094 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -176,6 +176,7 @@ struct nested_vmx {
 	bool reload_vmcs01_apic_access_page;
 	bool update_vmcs01_cpu_dirty_logging;
 	bool update_vmcs01_apicv_status;
+	bool update_vmcs01_hwapic_isr;
=20
 	/*
 	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
--=20
2.47.0.163.g1226f6d8fa-goog



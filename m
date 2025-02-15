Return-Path: <linux-kernel+bounces-515949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C349A36AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1943B00E9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 01:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED4782D98;
	Sat, 15 Feb 2025 01:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zEkUcLjQ"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7DB7DA7F
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739582089; cv=none; b=JjkYrFuLGxuQTYx8dDUlaVD/J5lUwqEBlEoJ8a4S+ymf9ZkhRsq3KxdoMq69CVCafKtYf7bYlUmwNnbRxder3y4jdNh4tG7RID1WzakDX3GIlHXAHQ+LBYk2rEKUDzxOiqeaQde+CSEmI990f6aESF28spb/ZOiI1p9TIlj7dvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739582089; c=relaxed/simple;
	bh=6YMwVl8AMR0ctcpdu9pVBh/LS5yL2fIICMQwk/b3AWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m2Pzmrig4LB6FCH7n1up88O24JIRBTnh5prD/VNb5DjkD6yMNDlqcZzT5Bti3rQkYNE/k3IlJ+mfafF28ffdKUs/WicT7HsdploQNLdiysu+xr2PzvmUIQZ6VYD+iWIdqNwxNO1DXPo9VF5BR55JqowyHOQ3YH4EfYR7rV16dXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zEkUcLjQ; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso5359679a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 17:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739582088; x=1740186888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kBlYOtEQWFFXQTOIKSQhEAVmxuq5bgSQmqN3gKZONVw=;
        b=zEkUcLjQXq6+yzByxqLRisg6FrqGcDZ8A0zOiMP71/0gdl4tuEV//9HW3GSRUf03u/
         93ojFUVWD/SbwY0HA+2zs8EOCyhTqbVXaiIF6piswIilKTVihbAu3cs08igh55KMsgkL
         BU3KXrqxv1klykpnj5FTMCASHXF5bawtyD1SpLfjB2jpNxQdtVlm72GHV3WyDQJlPhrv
         3TonhrKjTz/OgdvfsO2PMe7woDAk+9hdm9kplw6oxJUUA5QsXhK8Xmm/RJ9OCqOwLcHR
         Hi3TZuXtWgixmEyeX9sp+EUgXoFyvSwJxjViu5xAu7f27ExMUuRMZvll5X3UK8VFkG2T
         aINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739582088; x=1740186888;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBlYOtEQWFFXQTOIKSQhEAVmxuq5bgSQmqN3gKZONVw=;
        b=WqcbOTeOnf1srhQDHo2VMXdVIzA4nH+D1qdl2QADnboL+Q3CbF+ZI76zobtp5I59D1
         ceh/JthMLcN6xEa1g1lfG4QckW7m3rheZwtvtX77rmgFFw3Ap9HeNROwYk2Pc1mZCDNS
         Sj2GN3CZ9gdJWynwrMPe2HszSoynmnvMgfrAlPwcd5iS9pSgDNjt5xs4J0/wdP/QKjZk
         JOOU7VElIbgdImbWudjzyPayfsWXdxf9um9uq23dc2y/mI+T9rHGCae+QtTSWYJOWNBe
         1714g0LDShzstgCqq+JAMCSz3HmKVt8Ezwg+4m8oMHsm6Ls02ugqBns19Lw54g60Br1u
         aChA==
X-Forwarded-Encrypted: i=1; AJvYcCUhEIxQ82JS9WnZYtTVS+kGnTkgByXKeXRnp/CxT1l7tFh7ec7aOWKBY+DBy95pV4qwXHPuzf+iSkVDgG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9UUHq7y6NfbNpOgw0jzYpMbfU1Etdz8b5J81p8SBvxDcrF07J
	afLFAsxaKStFKuRjtVu04HEzoSUU21DOPt8Mt70cX6c47Q6Q371aX5odyLtFNhy2RcQGbHRkigl
	KCA==
X-Google-Smtp-Source: AGHT+IF/7aRcBkLI8VIoVFuxAUKTg7k+HuZU+C7mws5yenQi6hifj9Ro1N+YIqcNVFadqp5WH7EEULpvZl4=
X-Received: from pjbeu15.prod.google.com ([2002:a17:90a:f94f:b0:2fc:1eb0:5743])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:38c6:b0:2ef:33a4:ae6e
 with SMTP id 98e67ed59e1d1-2fc40f10876mr2175339a91.12.1739582087929; Fri, 14
 Feb 2025 17:14:47 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Feb 2025 17:14:37 -0800
In-Reply-To: <20250215011437.1203084-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250215011437.1203084-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250215011437.1203084-6-seanjc@google.com>
Subject: [PATCH v2 5/5] KVM: x86/xen: Move kvm_xen_hvm_config field into kvm_xen
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Paul Durrant <paul@xen.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joao Martins <joao.m.martins@oracle.com>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Now that all KVM usage of the Xen HVM config information is buried behind
CONFIG_KVM_XEN=y, move the per-VM kvm_xen_hvm_config field out of kvm_arch
and into kvm_xen.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/x86.c              |  2 +-
 arch/x86/kvm/xen.c              | 20 ++++++++++----------
 arch/x86/kvm/xen.h              |  6 +++---
 4 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f31fca4c4968..9df725e528b1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1188,6 +1188,8 @@ struct kvm_xen {
 	struct gfn_to_pfn_cache shinfo_cache;
 	struct idr evtchn_ports;
 	unsigned long poll_mask[BITS_TO_LONGS(KVM_MAX_VCPUS)];
+
+	struct kvm_xen_hvm_config hvm_config;
 };
 #endif
 
@@ -1419,7 +1421,6 @@ struct kvm_arch {
 
 #ifdef CONFIG_KVM_XEN
 	struct kvm_xen xen;
-	struct kvm_xen_hvm_config xen_hvm_config;
 #endif
 
 	bool backwards_tsc_observed;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 12c60adb7349..f97d4d435e7f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3188,7 +3188,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 	 * problems if they observe PVCLOCK_TSC_STABLE_BIT in the pvclock flags.
 	 */
 	bool xen_pvclock_tsc_unstable =
-		ka->xen_hvm_config.flags & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE;
+		ka->xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_PVCLOCK_TSC_UNSTABLE;
 #endif
 
 	kernel_ns = 0;
diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
index 5b94825001a7..8aef7cd24349 100644
--- a/arch/x86/kvm/xen.c
+++ b/arch/x86/kvm/xen.c
@@ -1280,10 +1280,10 @@ int kvm_xen_write_hypercall_page(struct kvm_vcpu *vcpu, u64 data)
 		 * Note, truncation is a non-issue as 'lm' is guaranteed to be
 		 * false for a 32-bit kernel, i.e. when hva_t is only 4 bytes.
 		 */
-		hva_t blob_addr = lm ? kvm->arch.xen_hvm_config.blob_addr_64
-				     : kvm->arch.xen_hvm_config.blob_addr_32;
-		u8 blob_size = lm ? kvm->arch.xen_hvm_config.blob_size_64
-				  : kvm->arch.xen_hvm_config.blob_size_32;
+		hva_t blob_addr = lm ? kvm->arch.xen.hvm_config.blob_addr_64
+				     : kvm->arch.xen.hvm_config.blob_addr_32;
+		u8 blob_size = lm ? kvm->arch.xen.hvm_config.blob_size_64
+				  : kvm->arch.xen.hvm_config.blob_size_32;
 		u8 *page;
 		int ret;
 
@@ -1335,13 +1335,13 @@ int kvm_xen_hvm_config(struct kvm *kvm, struct kvm_xen_hvm_config *xhc)
 
 	mutex_lock(&kvm->arch.xen.xen_lock);
 
-	if (xhc->msr && !kvm->arch.xen_hvm_config.msr)
+	if (xhc->msr && !kvm->arch.xen.hvm_config.msr)
 		static_branch_inc(&kvm_xen_enabled.key);
-	else if (!xhc->msr && kvm->arch.xen_hvm_config.msr)
+	else if (!xhc->msr && kvm->arch.xen.hvm_config.msr)
 		static_branch_slow_dec_deferred(&kvm_xen_enabled);
 
-	old_flags = kvm->arch.xen_hvm_config.flags;
-	memcpy(&kvm->arch.xen_hvm_config, xhc, sizeof(*xhc));
+	old_flags = kvm->arch.xen.hvm_config.flags;
+	memcpy(&kvm->arch.xen.hvm_config, xhc, sizeof(*xhc));
 
 	mutex_unlock(&kvm->arch.xen.xen_lock);
 
@@ -1422,7 +1422,7 @@ static bool kvm_xen_schedop_poll(struct kvm_vcpu *vcpu, bool longmode,
 	int i;
 
 	if (!lapic_in_kernel(vcpu) ||
-	    !(vcpu->kvm->arch.xen_hvm_config.flags & KVM_XEN_HVM_CONFIG_EVTCHN_SEND))
+	    !(vcpu->kvm->arch.xen.hvm_config.flags & KVM_XEN_HVM_CONFIG_EVTCHN_SEND))
 		return false;
 
 	if (IS_ENABLED(CONFIG_64BIT) && !longmode) {
@@ -2300,6 +2300,6 @@ void kvm_xen_destroy_vm(struct kvm *kvm)
 	}
 	idr_destroy(&kvm->arch.xen.evtchn_ports);
 
-	if (kvm->arch.xen_hvm_config.msr)
+	if (kvm->arch.xen.hvm_config.msr)
 		static_branch_slow_dec_deferred(&kvm_xen_enabled);
 }
diff --git a/arch/x86/kvm/xen.h b/arch/x86/kvm/xen.h
index 1e3a913dfb94..d191103d8163 100644
--- a/arch/x86/kvm/xen.h
+++ b/arch/x86/kvm/xen.h
@@ -53,7 +53,7 @@ static inline void kvm_xen_sw_enable_lapic(struct kvm_vcpu *vcpu)
 static inline bool kvm_xen_msr_enabled(struct kvm *kvm)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
-		kvm->arch.xen_hvm_config.msr;
+		kvm->arch.xen.hvm_config.msr;
 }
 
 static inline bool kvm_xen_is_hypercall_page_msr(struct kvm *kvm, u32 msr)
@@ -61,13 +61,13 @@ static inline bool kvm_xen_is_hypercall_page_msr(struct kvm *kvm, u32 msr)
 	if (!static_branch_unlikely(&kvm_xen_enabled.key))
 		return false;
 
-	return msr && msr == kvm->arch.xen_hvm_config.msr;
+	return msr && msr == kvm->arch.xen.hvm_config.msr;
 }
 
 static inline bool kvm_xen_hypercall_enabled(struct kvm *kvm)
 {
 	return static_branch_unlikely(&kvm_xen_enabled.key) &&
-		(kvm->arch.xen_hvm_config.flags &
+		(kvm->arch.xen.hvm_config.flags &
 		 KVM_XEN_HVM_CONFIG_INTERCEPT_HCALL);
 }
 
-- 
2.48.1.601.g30ceb7b040-goog



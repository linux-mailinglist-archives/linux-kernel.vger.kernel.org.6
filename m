Return-Path: <linux-kernel+bounces-392750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725CD9B97B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9545B1C20431
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9101D0E2B;
	Fri,  1 Nov 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgfN+Q51"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372551D0DE8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486174; cv=none; b=Wqe7r+/g2O1anvgmXJtSYPrCJdrvTYdKdzLCAGcIlu/XS+MufLKViaeWQf99Bp1kGYdfJQl7NbTmGwcaTeRhv1kaDjbihNiOL3BHMJcSrWYGvhqaYQeT3wozaBNrMbKNoo9cmkUH5WcJhq0yXxN5b4mxq4B/Qh6oV6iGG8Ud1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486174; c=relaxed/simple;
	bh=/frGkRXoQlzrjkWvNh5KGw/1JeGin0TpI2B3D2X+sy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CpmJe53B0d81Gu9CGmP/TxHqQdfo3NNnCRqAKAlXfDBhK3w8AYJu7JeiIMAZSN21hgt1ZXwgKiUoDTRAOndfZZ8daxZXX2VDFP+7hRlQdZ7X30qU6gvXcklvU7c8gJmGWmmgQVKK0m3NgUkVttKzkOgPkP8kd7d2CrUMY4qHR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dgfN+Q51; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370d76c15so48670157b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486171; x=1731090971; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=o15oczZjLr65ny5I+TbaXC6dNA2ZMYul3o5wZUJGViI=;
        b=dgfN+Q51vS8AgcAnzRzp26kucDbAP5S5O0P9bbVJvLvU6Lzx2BTHWEurFjU9ywaM3S
         +BLOtYGSy0JGyKHt1oMNI9q3SH7vo2tXd3YcNtMqPdXPTC07usx1bKD6XL8kRz5ZaXXC
         PO1f0Ik+897lSmQR2Ki0bT6kVT2Ew0wqO1XWK2QgH/6Gjj1BSTQ77Z4JhZ2AJ99iuUM0
         4xIkXzwYH4AbDR46jXjqnmNTpZBNh7emm/zd8nvIfZTgYEMkJJ6endCQuw7EgWKym6U2
         3FAgAGbzGBuk03f3b+GDIQaRIQXwqD5KLuz/1qtTJDJTEeTbVr1LPMlun8jRNNiVjo1l
         8wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486171; x=1731090971;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o15oczZjLr65ny5I+TbaXC6dNA2ZMYul3o5wZUJGViI=;
        b=dTigU/EF6E1m7h7YGykJc2LaVGiEGJKqKzMZJyCwoBnRgT8aVjLdx48t/+y5zpx/zF
         RdLmxsba9glbH+mWr35wka862nLyxA3RFbi15iecgVXKFlKwEXh+373g1hA3120JNmqQ
         CZzoNGQI3xqsQjoY8mG7NySmt+PQlvmXssQ3ZqSW8skMbBH7UlUBL5BQRsaIUXxKTRc0
         AXelgAdwrG54VgAH0qsq5kBvLfiNgfotgCPyNfxxw7kPNXdTBryqB3HpJWghZmIzLMPj
         taJMyExJZ9y+0qHgiB62odhlwaJMigjRRixBbIg2EkNvus3Zcqh8bk6itSx7MO28XZW9
         NaLA==
X-Forwarded-Encrypted: i=1; AJvYcCXgzKlUP65CL5Vt32GdIhcHP581aSNlhQ9jKvsqDkcIbAwb0UiGq8Fxh8HtStCalpxKUJ3wrkPnHtT78Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMddBEki1ygvIFYye827Oks2DtHN9bXDDY+SjLfugNXHVsqME
	so6TQF0lHSYGIaJvGjrZ7+R9pWwvwht5jhTW6imR85tnX0vIUrspqELAIeiBtoAe5fnmnGENdJL
	E4g==
X-Google-Smtp-Source: AGHT+IFAnYY7eTRPwUDiTbrEgfBgDblXGdjqSKzoGufvhnLN4rVG8UxtuXTk54TsLBw0n2mqTw17pJu+pNo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4510:b0:6e2:371f:4afe with SMTP id
 00721157ae682-6e9d8b21492mr11215937b3.4.1730486171289; Fri, 01 Nov 2024
 11:36:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:52 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-7-seanjc@google.com>
Subject: [PATCH v2 6/9] KVM: x86: Rename APIC base setters to better capture
 their relationship
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_set_apic_base() and kvm_lapic_set_base() to kvm_apic_set_base()
and __kvm_apic_set_base() respectively to capture that the underscores
version is a "special" variant (it exists purely to avoid recalculating
the optimized map multiple times when stuffing the RESET value).

Opportunistically add a comment explaining why kvm_lapic_reset() uses the
inner helper.  Note, KVM deliberately invokes kvm_arch_vcpu_create() while
kvm->lock is NOT held so that vCPU setup isn't serialized if userspace is
creating multiple/all vCPUs in parallel.  I.e. triggering an extra
recalculation is not limited to theoretical/rare edge cases, and so is
worth avoiding.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241009181742.1128779-7-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 15 +++++++++++----
 arch/x86/kvm/lapic.h |  3 +--
 arch/x86/kvm/x86.c   |  4 ++--
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b4cc5b0e8796..0472a94e7b3b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2577,7 +2577,7 @@ u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu)
 	return (tpr & 0xf0) >> 4;
 }
 
-void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
+static void __kvm_apic_set_base(struct kvm_vcpu *vcpu, u64 value)
 {
 	u64 old_value = vcpu->arch.apic_base;
 	struct kvm_lapic *apic = vcpu->arch.apic;
@@ -2628,7 +2628,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 	}
 }
 
-int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+int kvm_apic_set_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
 	enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);
@@ -2644,7 +2644,7 @@ int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return 1;
 	}
 
-	kvm_lapic_set_base(vcpu, msr_info->data);
+	__kvm_apic_set_base(vcpu, msr_info->data);
 	kvm_recalculate_apic_map(vcpu->kvm);
 	return 0;
 }
@@ -2740,7 +2740,14 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
 		msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
 		if (kvm_vcpu_is_reset_bsp(vcpu))
 			msr_val |= MSR_IA32_APICBASE_BSP;
-		kvm_lapic_set_base(vcpu, msr_val);
+
+		/*
+		 * Use the inner helper to avoid an extra recalcuation of the
+		 * optimized APIC map if some other task has dirtied the map.
+		 * The recalculation needed for this vCPU will be done after
+		 * all APIC state has been initialized (see below).
+		 */
+		__kvm_apic_set_base(vcpu, msr_val);
 	}
 
 	if (!apic)
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index fc4bd36d44cf..0dd5055852ad 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -95,7 +95,6 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event);
 u64 kvm_lapic_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lapic_set_tpr(struct kvm_vcpu *vcpu, unsigned long cr8);
 void kvm_lapic_set_eoi(struct kvm_vcpu *vcpu);
-void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value);
 void kvm_recalculate_apic_map(struct kvm *kvm);
 void kvm_apic_set_version(struct kvm_vcpu *vcpu);
 void kvm_apic_after_set_mcg_cap(struct kvm_vcpu *vcpu);
@@ -117,7 +116,7 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 
-int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
+int kvm_apic_set_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 57dca2bdd40d..e01188dc82d1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3863,7 +3863,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	case MSR_MTRRdefType:
 		return kvm_mtrr_set_msr(vcpu, msr, data);
 	case MSR_IA32_APICBASE:
-		return kvm_set_apic_base(vcpu, msr_info);
+		return kvm_apic_set_base(vcpu, msr_info);
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
 		return kvm_x2apic_msr_write(vcpu, msr, data);
 	case MSR_IA32_TSC_DEADLINE:
@@ -11879,7 +11879,7 @@ static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs,
 
 	apic_base_msr.data = sregs->apic_base;
 	apic_base_msr.host_initiated = true;
-	if (kvm_set_apic_base(vcpu, &apic_base_msr))
+	if (kvm_apic_set_base(vcpu, &apic_base_msr))
 		return -EINVAL;
 
 	if (vcpu->arch.guest_state_protected)
-- 
2.47.0.163.g1226f6d8fa-goog



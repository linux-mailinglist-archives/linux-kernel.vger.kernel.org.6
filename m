Return-Path: <linux-kernel+bounces-185645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A39A8CB85F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0771F213E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48358537F8;
	Wed, 22 May 2024 01:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDbLjKPY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB0BA2F
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339788; cv=none; b=r0K/NK6GF0Q2lX2/nlvvhhSoOr7rgxPAPfLYIS9nmCOB2IUasR9iW9twn7VbwSV4KclvhPb7sQI5XO2+S7bw/SEYJNgiyYn4Ql+Jlf1blM5eTN3Hzhew4WjjIzIyTyGOnwlKrxRXShPosVZPl/UjFS2+/X4V3o3PYIUhse22haY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339788; c=relaxed/simple;
	bh=dt+HjkdjSlkJT9aF6qvhLbzVRK6aMxCNpDcmFRwXO/o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fKa08Q6MmDG5082lLrOIo9fNR9IoBrrdRr4HPs6jOg8dT/5JGAj3LOaxlWBMgH0oqMXU7oU84s2tBel0TBYeNLGtTyLKwHlt/GQ6mafwKaceYnYzmkzKidncsaU8ZJwoYdDTEwbsNRzjHkX0IfkkyJKRl0QB9dOigPwQRY+OCFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDbLjKPY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f475e364b7so7244117b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339786; x=1716944586; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwclbEARXJEfzAMj1ocJrX5kIt6/+X6ICBIFzrsnIj4=;
        b=jDbLjKPYekPJEm42JP5PWXMJIAQVwyNzq2TbD5IOSqVi7vj1/nJa0UyoXwFMIxE8S/
         91tuwQlZspP4+8YD9PWdpnx68AFYF5wGNJhNc/3jt2e08FAELxgSWpeOqVoLSaQwl5Is
         VHagWLuOV+b1RJeE0KHE9gdATTSewgsxPCIX9RzQHBuJ9fhVPvZnxjs7F6l3UNSYaqvI
         W4TzyWNi8bKtRwHSec9F3ADoYUJtSiypePT+lLbG0u+A5/QExs3YvS5qSYc0FpocA+ib
         IObwdOhLCjP9hY08NGYn75FYtJOBkftz2aQWdYRohb/Nfi7bkBofIUCTHKOnKuSoSIfc
         yOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339786; x=1716944586;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwclbEARXJEfzAMj1ocJrX5kIt6/+X6ICBIFzrsnIj4=;
        b=r0PdGfYLJZqhhI3WfUExf5dvV2rgfBBLtF6xCtnE9kxmxT3CkA9+UnRxcq10oaxWFU
         6YsRQMlWPvDW5zLR2jXJJrGS0iiDSwg5zetnlsmrnO9jsL1brH+ZVyLcPJaT9HD8poW7
         J88pqk28oyqdT2jkDpriqVSM2+GlRjW36kSftA+hIJng6cUONobnaLckW6FILfmYrgDq
         FTcEPqU0hsAn/jAZ7Exx6HXQi+KT7BgcRhWSBuQmiPUgdGkpvENcNlS9S1/gSox1yaH3
         2kXJDNTA4cd6ayklRqQXwsqHLqGAMB+C/Fr0OplX1UwxSKc2BfN080oHbZRNlqEmWris
         C2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Ghg+rOoavT9JcspdOkA9LX27kYHspOwXAS3UDIjYw3Zpa3hdm1n+8C1fLuNDCF9VjRp+CVCqjYgOzYpr/vNQDKegIuxjZ/5zoTi+
X-Gm-Message-State: AOJu0Yy7pcoDGG9BzWZroDXSTRcGo26LGJvDuHRXR8TyLGKtntPoy75t
	DDGv9fZFM+VVnjE9AOMWs+cY/AezA4aEHU4cti2Lde9l2sI15eaiZw4tu7jCIvAFQMgsjPAF+Zr
	1Ug==
X-Google-Smtp-Source: AGHT+IFdZeLXYEa7a5kPS3tjJMRfVxMjMYj5V/vemDMKNlWVJfsCOupgo8wNUUxaVEp5n/l+9BlMf8LeKKM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3915:b0:6ec:f266:d214 with SMTP id
 d2e1a72fcca58-6f6d6477b74mr22476b3a.4.1716339786070; Tue, 21 May 2024
 18:03:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 21 May 2024 18:03:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240522010304.1650603-1-seanjc@google.com>
Subject: [PATCH] KVM: x86: Drop support for hand tuning APIC timer advancement
 from userspace
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuling Zhou <zhoushuling@huawei.com>, Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Remove support for specifying a static local APIC timer advancement value,
and instead present a read-only boolean parameter to let userspace enable
or disable KVM's dynamic APIC timer advancement.  Realistically, it's all
but impossible for userspace to specify an advancement that is more
precise than what KVM's adaptive tuning can provide.  E.g. a static value
needs to be tuned for the exact hardware and kernel, and if KVM is using
hrtimers, likely requires additional tuning for the exact configuration of
the entire system.

Dropping support for a userspace provided value also fixes several flaws
in the interface.  E.g. KVM interprets a negative value other than -1 as a
large advancement, toggling between a negative and positive value yields
unpredictable behavior as vCPUs will switch from dynamic to static
advancement, changing the advancement in the middle of VM creation can
result in different values for vCPUs within a VM, etc.  Those flaws are
mostly fixable, but there's almost no justification for taking on yet more
complexity (it's minimal complexity, but still non-zero).

The only arguments against using KVM's adaptive tuning is if a setup needs
a higher maximum, or if the adjustments are too reactive, but those are
arguments for letting userspace control the absolute max advancement and
the granularity of each adjustment, e.g. similar to how KVM provides knobs
for halt polling.

Link: https://lore.kernel.org/all/20240520115334.852510-1-zhoushuling@huawei.com
Cc: Shuling Zhou <zhoushuling@huawei.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 39 +++++++++++++++++++++------------------
 arch/x86/kvm/lapic.h |  2 +-
 arch/x86/kvm/x86.c   | 11 +----------
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ebf41023be38..acd7d48100a1 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -59,7 +59,17 @@
 #define MAX_APIC_VECTOR			256
 #define APIC_VECTORS_PER_REG		32
 
-static bool lapic_timer_advance_dynamic __read_mostly;
+/*
+ * Enable local APIC timer advancement (tscdeadline mode only) with adaptive
+ * tuning.  When enabled, KVM programs the host timer event to fire early, i.e.
+ * before the deadline expires, to account for the delay between taking the
+ * VM-Exit (to inject the guest event) and the subsequent VM-Enter to resume
+ * the guest, i.e. so that the interrupt arrives in the guest with minimal
+ * latency relative to the deadline programmed by the guest.
+ */
+static bool lapic_timer_advance __read_mostly = true;
+module_param(lapic_timer_advance, bool, 0444);
+
 #define LAPIC_TIMER_ADVANCE_ADJUST_MIN	100	/* clock cycles */
 #define LAPIC_TIMER_ADVANCE_ADJUST_MAX	10000	/* clock cycles */
 #define LAPIC_TIMER_ADVANCE_NS_INIT	1000
@@ -1854,16 +1864,14 @@ static void __kvm_wait_lapic_expire(struct kvm_vcpu *vcpu)
 	guest_tsc = kvm_read_l1_tsc(vcpu, rdtsc());
 	trace_kvm_wait_lapic_expire(vcpu->vcpu_id, guest_tsc - tsc_deadline);
 
-	if (lapic_timer_advance_dynamic) {
-		adjust_lapic_timer_advance(vcpu, guest_tsc - tsc_deadline);
-		/*
-		 * If the timer fired early, reread the TSC to account for the
-		 * overhead of the above adjustment to avoid waiting longer
-		 * than is necessary.
-		 */
-		if (guest_tsc < tsc_deadline)
-			guest_tsc = kvm_read_l1_tsc(vcpu, rdtsc());
-	}
+	adjust_lapic_timer_advance(vcpu, guest_tsc - tsc_deadline);
+
+	/*
+	 * If the timer fired early, reread the TSC to account for the overhead
+	 * of the above adjustment to avoid waiting longer than is necessary.
+	 */
+	if (guest_tsc < tsc_deadline)
+		guest_tsc = kvm_read_l1_tsc(vcpu, rdtsc());
 
 	if (guest_tsc < tsc_deadline)
 		__wait_lapic_expire(vcpu, tsc_deadline - guest_tsc);
@@ -2812,7 +2820,7 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 		return HRTIMER_NORESTART;
 }
 
-int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
+int kvm_create_lapic(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic;
 
@@ -2845,13 +2853,8 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns)
 	hrtimer_init(&apic->lapic_timer.timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_ABS_HARD);
 	apic->lapic_timer.timer.function = apic_timer_fn;
-	if (timer_advance_ns == -1) {
+	if (lapic_timer_advance)
 		apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_NS_INIT;
-		lapic_timer_advance_dynamic = true;
-	} else {
-		apic->lapic_timer.timer_advance_ns = timer_advance_ns;
-		lapic_timer_advance_dynamic = false;
-	}
 
 	/*
 	 * Stuff the APIC ENABLE bit in lieu of temporarily incrementing
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 0a0ea4b5dd8c..a69e706b9080 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -85,7 +85,7 @@ struct kvm_lapic {
 
 struct dest_map;
 
-int kvm_create_lapic(struct kvm_vcpu *vcpu, int timer_advance_ns);
+int kvm_create_lapic(struct kvm_vcpu *vcpu);
 void kvm_free_lapic(struct kvm_vcpu *vcpu);
 
 int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d750546ec934..fa064864ad2c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -164,15 +164,6 @@ module_param(kvmclock_periodic_sync, bool, 0444);
 static u32 __read_mostly tsc_tolerance_ppm = 250;
 module_param(tsc_tolerance_ppm, uint, 0644);
 
-/*
- * lapic timer advance (tscdeadline mode only) in nanoseconds.  '-1' enables
- * adaptive tuning starting from default advancement of 1000ns.  '0' disables
- * advancement entirely.  Any other value is used as-is and disables adaptive
- * tuning, i.e. allows privileged userspace to set an exact advancement time.
- */
-static int __read_mostly lapic_timer_advance_ns = -1;
-module_param(lapic_timer_advance_ns, int, 0644);
-
 static bool __read_mostly vector_hashing = true;
 module_param(vector_hashing, bool, 0444);
 
@@ -12177,7 +12168,7 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (r < 0)
 		return r;
 
-	r = kvm_create_lapic(vcpu, lapic_timer_advance_ns);
+	r = kvm_create_lapic(vcpu);
 	if (r < 0)
 		goto fail_mmu_destroy;
 

base-commit: 4aad0b1893a141f114ba40ed509066f3c9bc24b0
-- 
2.45.0.215.g3402c0e53f-goog



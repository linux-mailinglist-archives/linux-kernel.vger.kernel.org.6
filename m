Return-Path: <linux-kernel+bounces-392747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 568969B97B1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159D3283CB9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5F1CFED2;
	Fri,  1 Nov 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KSDPFR6"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056531CDFDC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486165; cv=none; b=Uao02csc3HGGTc/gwuhnEbqLI2Ti3bEK8zKwcQqH8vcttVrVnU4Q5+39V4YZ53+MauCH/IJDXF3Tto8PnMpM5KBiXgdfTB+5jGaSPemTwYMkHxfx2eszsgUnBCxDBIlwkd2F6iIUAjr3d7hMLe91SAni9zElEYqavVUdhkV1KDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486165; c=relaxed/simple;
	bh=AQHWFIKx05Q6I0khQtg6qx7F98/ChoeEEBN+Jwsa0Kw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MG4sBx5KNlt2O0x1eFXwO33iUJ/0Xo3W0onjHbmoWIbV2DAoAZWJQcWZutDrkC3EllPYImpFaNTIY3r8BpHxHbGckleFsBE+81FRbhwI43EnaHmmxICZ8mO6jmlbgPB/+wh2IiQVJYAqJl3XzYyj2yKiX1dyi/8xyAv/6SQ6H9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KSDPFR6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e49bad8adso3030747b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486163; x=1731090963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=RrKAd/LcvqmweQgUO1Es4Qu822f05reWQBoEwGCwlQ0=;
        b=0KSDPFR6um5WtgOJ7qSEae2UXGBxY/TDQB/5vHKRrMMH/xh3mStNnYsO+xf0S+hDpD
         dfvy+NaDT4vx3JqfSU8/HlyGy2OuZ8IzoKivhc1CIeR/u0hKgTlsMSR90Fz+cq2TmXsz
         gQ01OTBqwrbEdoG2z/CUz2Sp3CtFMn9T+Dg208L0clmPXyTaHeF0jh0si6gCEGcVG4mc
         9C8wKRKYf6bn69IftvpM7LvZ1NFj5MpubuNDUfFmDjdaDx7wm3qpHMnG77hGbwjIIGjH
         TjqxLBfSlZpWrf6ZRofPlUbq3gKEVo5Rbi2Bl8PVPESU8wWqTCKvJB0SRXxx3esSx7ko
         dKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486163; x=1731090963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RrKAd/LcvqmweQgUO1Es4Qu822f05reWQBoEwGCwlQ0=;
        b=u3POWUbje2OofbbtjldkkDfZZyqFh08PkGvDqYaDYu0INKNcq2CNTpfCBza+fJ41P7
         AsG1qlpfeyBJxuowM3xL7YAAm/CEw/+JmIJMf0Y5IehuGtsnbEB6PIbjoNQ38xGBahUq
         uz0EJlK7EjKLBYQ83xrWt0ovd815cnw6FHIVzPMQimiqQjD6o2tTfYUzPRNMqG34OHUA
         D02Va93P+cMfEL4gMTYkv6JM7/xZ1ksIZr7y37eeJ/dYyQ9g76k4LXA/S6sLOrBjslMz
         peeZWl3IOB9A3Ko1VpBAs/zhlQmghLi+4W2dQawxLfO5vM7hgcqqTtV//ycg9G7uop0D
         +2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVfvWd8mr1Un+5uZgbW4AqcD1hjF72EmVRHoYnkndAIlmeMpysMAqYEJCnUYY0/+D0Qp/MEyKtXo6BKkmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6KYrcAN3NNXK/uyRu2UQTuKWTlt8zTJLGwQBEBCtBWTfOxLy
	Vfd1kYJSFgff6YK4GCWilIafrCfvooAHjfCfbdczq9yHDeTn8CRXbi63KIyK/QiP+iB7q/jikaC
	DFA==
X-Google-Smtp-Source: AGHT+IEfb7kN1e0CSUsCamBepUoGEaAPZKajSLl220fb2ebC5QNlJYvpwQhj814gCEnvIJyCqu1f9UL5Ir8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2790:b0:71e:6b3b:9f2d with SMTP id
 d2e1a72fcca58-720bc83e022mr26129b3a.1.1730486163504; Fri, 01 Nov 2024
 11:36:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:49 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-4-seanjc@google.com>
Subject: [PATCH v2 3/9] KVM: x86: Get vcpu->arch.apic_base directly and drop kvm_get_apic_base()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Access KVM's emulated APIC base MSR value directly instead of bouncing
through a helper, as there is no reason to add a layer of indirection, and
there are other MSRs with a "set" but no "get", e.g. EFER.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241009181742.1128779-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.h |  1 -
 arch/x86/kvm/x86.c   | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 1b8ef9856422..441abc4f4afd 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -117,7 +117,6 @@ bool kvm_irq_delivery_to_apic_fast(struct kvm *kvm, struct kvm_lapic *src,
 		struct kvm_lapic_irq *irq, int *r, struct dest_map *dest_map);
 void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 
-u64 kvm_get_apic_base(struct kvm_vcpu *vcpu);
 int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e45040c2bf03..118e6eba35ba 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -668,14 +668,9 @@ static void drop_user_return_notifiers(void)
 		kvm_on_user_return(&msrs->urn);
 }
 
-u64 kvm_get_apic_base(struct kvm_vcpu *vcpu)
-{
-	return vcpu->arch.apic_base;
-}
-
 enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu)
 {
-	return kvm_apic_mode(kvm_get_apic_base(vcpu));
+	return kvm_apic_mode(vcpu->arch.apic_base);
 }
 EXPORT_SYMBOL_GPL(kvm_get_apic_mode);
 
@@ -4315,7 +4310,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = 1 << 24;
 		break;
 	case MSR_IA32_APICBASE:
-		msr_info->data = kvm_get_apic_base(vcpu);
+		msr_info->data = vcpu->arch.apic_base;
 		break;
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
 		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
@@ -10173,7 +10168,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 
 	kvm_run->if_flag = kvm_x86_call(get_if_flag)(vcpu);
 	kvm_run->cr8 = kvm_get_cr8(vcpu);
-	kvm_run->apic_base = kvm_get_apic_base(vcpu);
+	kvm_run->apic_base = vcpu->arch.apic_base;
 
 	kvm_run->ready_for_interrupt_injection =
 		pic_in_kernel(vcpu->kvm) ||
@@ -11725,7 +11720,7 @@ static void __get_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->cr4 = kvm_read_cr4(vcpu);
 	sregs->cr8 = kvm_get_cr8(vcpu);
 	sregs->efer = vcpu->arch.efer;
-	sregs->apic_base = kvm_get_apic_base(vcpu);
+	sregs->apic_base = vcpu->arch.apic_base;
 }
 
 static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
-- 
2.47.0.163.g1226f6d8fa-goog



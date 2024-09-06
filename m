Return-Path: <linux-kernel+bounces-318118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A4D96E8A7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 06:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A031A286AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 04:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C858271B3A;
	Fri,  6 Sep 2024 04:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GSRoYNGE"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5D43ABC
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 04:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725597261; cv=none; b=EOvIAdbSQgE/VFCX1k2ExWP5rmy4VKRUiIV/Yxd1vO3sUJ3TDyujhW3meNT2eOfyM4mCs8xnqh1F19QYFOqw4EBeb0UBRDnqRijOet5Zhwmlcb3EElpSNJ7kA2I5zNv4z7NLAcMfHcEtJ6VX8iJqZpOrG2yUi0xnD2gz5bQ2LeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725597261; c=relaxed/simple;
	bh=IvNHY4s2sMwGIf0YtwnB+tocpqjPSUFN5NVhawuBXGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RpctkBdSELp4BYhdtZ+7i+h/cb+Tjs3LsRsMOU1ziOOGkHKEkns8nueCUclQfsROlf9SQNkFrScPbjk6w/zKeQ6ag6E4oQdYGhRXdMnYuk48lsJfF7vC6dSTuaBg9TRMC/Oia5RO7HKnsSPmhQNzbHAjJ6tI12k9XP97odx8hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GSRoYNGE; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so65772647b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 21:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725597258; x=1726202058; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mCaD0TEOBVOQwGb6+w3Vfrkr+Z/WBNGokOq9Bgi0c+0=;
        b=GSRoYNGEPKl/6E7LBNLR3g7V2gfPZG2wSWUEuMD+ZLeZpvpBBoRLHVx7xDraG1yfJH
         HH/um61pKQehkoU60FWYxt+91VhyGNalT5PkBXodSgO4EDIT4Bbn5ZNWuJMOzyVbUByN
         DuJXRuJEpTxALSodktKG5QPNjWtKk4FlJXN9AwLUkeH3PTunAQrirViLmQ/Z7/EBh0mu
         BndDgRh/ANP81IkGHfE9LsM52BW39zVMQbrWsNJGLpl5xZX0ZDa9cStj37AtdksvifFB
         nvC1/SmgbEdUNYd8PY+5S6M7sD9fdGocmERaIaPTiHN+6pS6y9L4sjJuwDmmmI/eLWoe
         gQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725597258; x=1726202058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCaD0TEOBVOQwGb6+w3Vfrkr+Z/WBNGokOq9Bgi0c+0=;
        b=HD/N8kdelt/aAM3khd4k9Nx0VORjivYcM51ysSQergDw1I+rOKabS9jr4xdmwE5tC+
         fNrh8caLtPITz6AwtUg/QuBGmndKDFY57xgQHVwCg+gs2QJUcwTndNYr2vlpLyUbyk6Y
         wFTylO8aIMnzY+NEoSScqkBAx5N4Oyws0jloNzCw54KqWyiTh9K9PrX5XAOgj8wcCwdT
         royw/qBCdyzkFBuW5PD6i29fPqE5iyc+wnMlOpX8VmXFLa0cAH5XM/3FknGjPoDm38rK
         AG6P26EeBvGXUI972Ne69rHq4A/YzzS+hWZM0X+hVxr9BmtmuUTZXQEIOOdIgkq/+KA7
         eswg==
X-Forwarded-Encrypted: i=1; AJvYcCWmAwmHyN0H0nBi7cKBbXsrNnlnPPMDol5OYelhj8VzCtbL3oW6t5mPKQ+mThmv4nbHZQMc/mA3W+DsthM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeQ1+DQnczON/ljOYS5wdVmbQtZ3vj6h+8suH5xbtADQZOHRLo
	cyyE4Qixb6cr+LRuKKoR2CmVeM3l1fpamr/uVeAyEh19Pp3Y7cC03NnOdaLv6lbyeASEM4ry5KJ
	9mQ==
X-Google-Smtp-Source: AGHT+IGCDgcglWhh/eqririlfxwRjfWcrURdZg+FkjDnBxo0+i6VcRR3gAjFm5Rm67GVxheJV7Gf0Avr2mM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fcf:b0:627:a671:8805 with SMTP id
 00721157ae682-6db4512db7bmr1018207b3.3.1725597258694; Thu, 05 Sep 2024
 21:34:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  5 Sep 2024 21:34:07 -0700
In-Reply-To: <20240906043413.1049633-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240906043413.1049633-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240906043413.1049633-2-seanjc@google.com>
Subject: [PATCH v2 1/7] KVM: x86: Move "ack" phase of local APIC IRQ delivery
 to separate API
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>, Chao Gao <chao.gao@intel.com>, 
	Zeng Guang <guang.zeng@intel.com>
Content-Type: text/plain; charset="UTF-8"

Split the "ack" phase, i.e. the movement of an interrupt from IRR=>ISR,
out of kvm_get_apic_interrupt() and into a separate API so that nested
VMX can acknowledge a specific interrupt _after_ emulating a VM-Exit from
L2 to L1.

To correctly emulate nested posted interrupts while APICv is active, KVM
must:

  1. find the highest pending interrupt.
  2. check if that IRQ is L2's notification vector
  3. emulate VM-Exit if the IRQ is NOT the notification vector
  4. ACK the IRQ in L1 _after_ VM-Exit

When APICv is active, the process of moving the IRQ from the IRR to the
ISR also requires a VMWRITE to update vmcs01.GUEST_INTERRUPT_STATUS.SVI,
and so acknowledging the interrupt before switching to vmcs01 would result
in marking the IRQ as in-service in the wrong VMCS.

KVM currently fudges around this issue by doing kvm_get_apic_interrupt()
smack dab in the middle of emulating VM-Exit, but that hack doesn't play
nice with nested posted interrupts, as notification vector IRQs don't
trigger a VM-Exit in the first place.

Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 17 +++++++++++++----
 arch/x86/kvm/lapic.h |  1 +
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index a7172ba59ad2..ff63ef8163a9 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2924,14 +2924,13 @@ void kvm_inject_apic_timer_irqs(struct kvm_vcpu *vcpu)
 	}
 }
 
-int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
+void kvm_apic_ack_interrupt(struct kvm_vcpu *vcpu, int vector)
 {
-	int vector = kvm_apic_has_interrupt(vcpu);
 	struct kvm_lapic *apic = vcpu->arch.apic;
 	u32 ppr;
 
-	if (vector == -1)
-		return -1;
+	if (WARN_ON_ONCE(vector < 0 || !apic))
+		return;
 
 	/*
 	 * We get here even with APIC virtualization enabled, if doing
@@ -2959,6 +2958,16 @@ int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
 		__apic_update_ppr(apic, &ppr);
 	}
 
+}
+EXPORT_SYMBOL_GPL(kvm_apic_ack_interrupt);
+
+int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu)
+{
+	int vector = kvm_apic_has_interrupt(vcpu);
+
+	if (vector != -1)
+		kvm_apic_ack_interrupt(vcpu, vector);
+
 	return vector;
 }
 
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 7ef8ae73e82d..db80a2965b9c 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -88,6 +88,7 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu);
 void kvm_free_lapic(struct kvm_vcpu *vcpu);
 
 int kvm_apic_has_interrupt(struct kvm_vcpu *vcpu);
+void kvm_apic_ack_interrupt(struct kvm_vcpu *vcpu, int vector);
 int kvm_apic_accept_pic_intr(struct kvm_vcpu *vcpu);
 int kvm_get_apic_interrupt(struct kvm_vcpu *vcpu);
 int kvm_apic_accept_events(struct kvm_vcpu *vcpu);
-- 
2.46.0.469.g59c65b2a67-goog



Return-Path: <linux-kernel+bounces-392748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808999B97B3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C241C2032A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F341D042A;
	Fri,  1 Nov 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCJeDBy8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEEB1CFED6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730486167; cv=none; b=E3fPRkM2YdV8KLXBf66Jaq5UbSguIcTYD/qyVMirB3MMPitxHezTJPHZvyCFcX4IKYO36ZFy7oeviXA5kfODRsBZvptzlVJgyYjTRLVEP6YUrdU0Czy6z9392fVP4cUWIENjU03sYNUoCgMVEXd3H4YXY472gQm57JFpRg5Xjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730486167; c=relaxed/simple;
	bh=ZvhPKlVHbgPPM+VoBwR5IIXoCb+DdIwR8vcjRgoEO1A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejwJq8u33SgkWZe14ntaIpzaYLKTetRGVePjgC+Mt3gpj6nR5uerga+ihzsJ4oY0BG98WtN8tFmCQadxyIQGyQsCM13IKapy4US40lXKyH1080mAQb7h6KxFNivVXcTyu2Q9z6/CEIl21BSRrWhiUeTZAOtdB9SpeRHYXpFmcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCJeDBy8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so3575906276.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730486165; x=1731090965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QM3s7U/z00nQJq1TtO3+CW97lZlfwpLmjD1tvhSkGao=;
        b=zCJeDBy8Y7Alyac/pvMt7u4ZZkwOrcgZi4vWHPGT1PJhrD2bzlQFa8jF07Wc2oMfKA
         83hMl1ldCzHpUNF3xsyzzoqEZsxseG9UCy0wjP3LFGBCoGne73blcmwHfX7KLCs+SBiD
         dMER9od0vs1OQ5CBxKIhnIs9cbuFAUqngNA4friNrtfq7D32WSlxnDF/Ykn4qRSiuaq2
         Mm5DEfp6jX8bNv2TnDpNR/eU+dEr88SZf6IXMGw3zBGUFC8diXKqqlJw7SA5tVLhnd27
         CRDpElF+OmF+RaxW5NlwZyCS2vA5mT1fht+IqeGrej9WqYwyU195ZCppic4JUWcK568V
         gWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730486165; x=1731090965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QM3s7U/z00nQJq1TtO3+CW97lZlfwpLmjD1tvhSkGao=;
        b=YiduDZtX19QLeY3TOqXFg2bwh0DgGmagELYjaZ5Ck/YeaapH1+cO/nE4XmYZyQQx8q
         Jf2KOBxWHyA+GP0nRvckprJtHB9CUsP8sAlXLlz/mzwxwxVbb4RUAACz7i8JIgjOq7kO
         dC0WStUXHjfzTBslyLWazGJaI1oYZC/ti+bFayf8NzvBeNNGex7EDuNqUDGyhvnI5YNr
         XZVx7fWvmacYE50oa3zC+MbNZEN9SpkKEnKNcvZKdAFMzElTCcYn85kyoan8ArSx/bWU
         fHoOIGfZcIqlLvqGehi5HZge1JMKlkQzJfkgT7++G9iW31pCTkN9ylJ3Y29+/sA753AD
         VDCA==
X-Forwarded-Encrypted: i=1; AJvYcCWfRuVYXIx3GZbcf9xTFdMb0cYGdFBm+tW6nU9i/k3Y/6srpX4k4sMH2bYA4B6jUl9VisO7G9hzM0h2BWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78kB/heIRveXpkvXCSfgFWKRnAtvfMQtVPS1G+UV263WCxR9l
	oUY9PyZXOn2QQ6fguzEn2dKePJ5feYUkipdlC+KRh+YvuEClWolKBOCieH7jqALY6gvNDV12qhj
	/zg==
X-Google-Smtp-Source: AGHT+IG3BgrIkNF6YeRzyo0VcV/pAm0pQUkv9rII4p7eMueQ7pEvcf2Etu5yQzbU5p84yZjVWLlKD1CGFP0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:83c3:0:b0:e30:c79e:16bc with SMTP id
 3f1490d57ef6-e30c79e1861mr13666276.8.1730486165271; Fri, 01 Nov 2024 11:36:05
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  1 Nov 2024 11:35:50 -0700
In-Reply-To: <20241101183555.1794700-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101183555.1794700-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101183555.1794700-5-seanjc@google.com>
Subject: [PATCH v2 4/9] KVM: x86: Inline kvm_get_apic_mode() in lapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"

Inline kvm_get_apic_mode() in lapic.h to avoid a CALL+RET as well as an
export.  The underlying kvm_apic_mode() helper is public information, i.e.
there is no state/information that needs to be hidden from vendor modules.

No functional change intended.

Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Link: https://lore.kernel.org/r/20241009181742.1128779-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.h | 6 +++++-
 arch/x86/kvm/x86.c   | 6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 441abc4f4afd..fc4bd36d44cf 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -120,7 +120,6 @@ void kvm_apic_send_ipi(struct kvm_lapic *apic, u32 icr_low, u32 icr_high);
 int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info);
 int kvm_apic_get_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
 int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s);
-enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu);
 int kvm_lapic_find_highest_irr(struct kvm_vcpu *vcpu);
 
 u64 kvm_get_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu);
@@ -270,6 +269,11 @@ static inline enum lapic_mode kvm_apic_mode(u64 apic_base)
 	return apic_base & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
 }
 
+static inline enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu)
+{
+	return kvm_apic_mode(vcpu->arch.apic_base);
+}
+
 static inline u8 kvm_xapic_id(struct kvm_lapic *apic)
 {
 	return kvm_lapic_get_reg(apic, APIC_ID) >> 24;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 118e6eba35ba..95af45542355 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -668,12 +668,6 @@ static void drop_user_return_notifiers(void)
 		kvm_on_user_return(&msrs->urn);
 }
 
-enum lapic_mode kvm_get_apic_mode(struct kvm_vcpu *vcpu)
-{
-	return kvm_apic_mode(vcpu->arch.apic_base);
-}
-EXPORT_SYMBOL_GPL(kvm_get_apic_mode);
-
 int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 {
 	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
-- 
2.47.0.163.g1226f6d8fa-goog



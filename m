Return-Path: <linux-kernel+bounces-357724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96C29974C0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C8E28ABB8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898411E22F5;
	Wed,  9 Oct 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6Rg2T90"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560F1E1A3D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497872; cv=none; b=Fqd+l9OIYWnvjXhzNxaoYg5Fc8pklt4vU+6hWG9Xrg/eGqJjD9Gt/NT0AWXQSQcSgx5/eZ+o611f6Ld8b7Xisxad3vUUcb2TaCAMOQ9oQVFEVZH3ttvAkkY9Pz47oPJMamBmalUN+8prawaOd3rHRkbQ0P1Q2iDEP9p4HbCGHVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497872; c=relaxed/simple;
	bh=aQegb2jJTwclP7J/2+nvzeBKDFmobcteHsPnTE7cqaE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k/yTz//HotFUANFvcEUTrBcEl/esh6585VK9Yx/ttgQj2u33TocXG75a5DtZSnE8UxLusd9+k0wyAgJhUD7HtXg2gisz5+yC8I49YpDC1lBcl6RbISRMQxfpjGhCacXgo7Ex+kyFz1cfMpITwhKkH0sOrbR1s3Vsu4gydgUnfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6Rg2T90; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c56938075so396925ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728497870; x=1729102670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=0EI8KqLxjBp63sDvxFB6h3mtXjGqieRpikapG45fsO0=;
        b=k6Rg2T90/OWcptAxi5HK3BXksYPC5YqquC88l0hMmBKDjjiICD0cIGmtiyEkAGnQaz
         eB5j2jdyRuGZYaVg90/HrOix4oV4vHUuugp4olL5K1BtEyO0KZHmZh+kw27TR9Q0fCOs
         yICmv8VFITNCOVScVBmNAHsIZburP3FVoHM6UkdhRcF7uLugFnsh4FmQUqzC5712rm7+
         KtHXe+JMxXGrONO6EIYvJjLkyMPSli0YAA/6uTiqc20aizsiodo4iyVXePo/jpV12nZH
         kl5fK7leY9NPmQ/soO58I1/PSuLQxIGDXHSjgwQ4rZI3H9vDGg67J0AB74akS72w8GVG
         s37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497870; x=1729102670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EI8KqLxjBp63sDvxFB6h3mtXjGqieRpikapG45fsO0=;
        b=FDieb09KJaY6jhr15h/or/Cr0opc1EcKSDIkbL126gJXEoEZxatNU79siy6t4PGwh1
         5RI6Wu/Meqe2MwfffJqB3ygl3weh/XZQDPLEW0z49CjqIG5Yqz2N+1mYmGTHGKECTEKI
         wkxtbGOx3AcmZZSJ1rhMe53HQMlXM14SPJv8hcsVKEY62cCyQXL1hOnj6P3MqWK0Y29/
         roxT+44+AuNX1R+I7FkA1iGYjUTI2/dVcUbR+c6hqAXm4wpmoYOk/gBeX9EpMbqlKLBc
         pfGyUHGXFPbCJl+8GNYlrMx1miypulIv1ji3pXNLz2wX42CkqKhKCts+pfDM8tcgd6Hy
         rBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf1Hkg9zn+OyQFZnyU5mSCj7AZFpgLD05hYca5lTa9AqbaRX9OOnqQBgzBCLnT+HQzwDYiBflVlH1qkeg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEN2WqVHmJxqb1x75siG4pg7cg3wkYNA2XzGLe/Hv/AdC0A70b
	D9wSz2JZuTJXxo6S5RMPBafC3G551F59+ANVcOylVsVOhamfhYL+M61lWTxexKltc20GB2uUNbY
	WpQ==
X-Google-Smtp-Source: AGHT+IGCHE/pJCSD+8XIOOuGuBub6Cuxazc+vzvdE8v2/ieW0mgwvDRyxLPmlm5mrBxuObiPc5iUxZ7oNo4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:d502:b0:20b:7ece:3225 with SMTP id
 d9443c01a7336-20c6358fdd3mr824545ad.0.1728497869626; Wed, 09 Oct 2024
 11:17:49 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 11:17:37 -0700
In-Reply-To: <20241009181742.1128779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009181742.1128779-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009181742.1128779-4-seanjc@google.com>
Subject: [PATCH 3/7] KVM: x86: Get vcpu->arch.apic_base directly and drop kvm_get_apic_base()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Access KVM's emulated APIC base MSR value directly instead of bouncing
through a helper, as there is no reason to add a layer of indirection, and
there are other MSRs with a "set" but no "get", e.g. EFER.

No functional change intended.

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
index 83fe0a78146f..046cb7513436 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -667,14 +667,9 @@ static void drop_user_return_notifiers(void)
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
 
@@ -4314,7 +4309,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		msr_info->data = 1 << 24;
 		break;
 	case MSR_IA32_APICBASE:
-		msr_info->data = kvm_get_apic_base(vcpu);
+		msr_info->data = vcpu->arch.apic_base;
 		break;
 	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
 		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
@@ -10159,7 +10154,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
 
 	kvm_run->if_flag = kvm_x86_call(get_if_flag)(vcpu);
 	kvm_run->cr8 = kvm_get_cr8(vcpu);
-	kvm_run->apic_base = kvm_get_apic_base(vcpu);
+	kvm_run->apic_base = vcpu->arch.apic_base;
 
 	kvm_run->ready_for_interrupt_injection =
 		pic_in_kernel(vcpu->kvm) ||
@@ -11711,7 +11706,7 @@ static void __get_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
 	sregs->cr4 = kvm_read_cr4(vcpu);
 	sregs->cr8 = kvm_get_cr8(vcpu);
 	sregs->efer = vcpu->arch.efer;
-	sregs->apic_base = kvm_get_apic_base(vcpu);
+	sregs->apic_base = vcpu->arch.apic_base;
 }
 
 static void __get_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
-- 
2.47.0.rc1.288.g06298d1525-goog



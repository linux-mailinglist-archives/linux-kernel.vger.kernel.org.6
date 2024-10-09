Return-Path: <linux-kernel+bounces-357726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C4D9974C3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA9928ABF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5D1E2848;
	Wed,  9 Oct 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8b4Ykvc"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789DC1C2DB8
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497876; cv=none; b=lO9sI2oxeFUD30D9AtA824oZPMylzKqqc6HqKMjQW7eOtALHEz8xGMlPtzerOdyMK8J9HWj7MlAHkB/G9Ah+PxPKMe6fjqsCAa+ghU527iezdfulvi594Uwn90kxdYuZjFiE+tWr4xHSORPchJEi51AfHE/U8HoprQDvXbgM1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497876; c=relaxed/simple;
	bh=GnpcuwMdkFaGr6O5Lmms01caFImUqZlbd0zCVFngLZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Av+o/eM2TjSKHIzWlZZPCBwKI1SKuGzWGn1iBBr4hdxaXO65h+9oQTNFEVp9AQGIHutU9B2VphGLTOqXzTGyZhBmdvb8n4PT6DCRydufVjf/u0U+FXraJUcY0PksY9p5J3NkGDHznbRTjMasVU91WW5ula069kAzUI7m8si1JoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o8b4Ykvc; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e02b5792baaso44285276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728497873; x=1729102673; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=rMwbZf1LmTNfEGZdnzInWLtMby5O9zhLRFRQddIF11U=;
        b=o8b4Ykvcjx+cVqgOjQ8unNtBY3JAXK9ySaWkuGvWmf2+TKp4Z/0EctnUX+4zyrI8eS
         ixTc8ALs0AsA7wKm8Gphuza9NRZoWX5d01kvlFm/EZErXsjfw+FQLlhmyZ4Fmh9CarOV
         vAk5LyKLsYvS9CMEhd1b9DPwDO4LJBkUqljrtM/zrn8oG7H0OATO+hDpsBfP4wBnjW9F
         UXi0rU71qz5HZDDyc5+R3DGsQJZKv8k/WQuIYOvCw5k0QLz5/bhWccaAiHFLPZ/WOc0V
         +6ZuOuCuFBHkRXQcZUlzGEMshW5hP9/W8nj7RUXHh8GNNMRlkgmrftREFFHKEfeuU4Rt
         qIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497873; x=1729102673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMwbZf1LmTNfEGZdnzInWLtMby5O9zhLRFRQddIF11U=;
        b=DekKlhraUSpHcbtkg956aH4hLyg+RvmRZPMhmxrUIH6cDpdofA33O3TPB+5lcJ5tGI
         EmaRnrb3bfr5zFgLzX0lNj6yb9kk0TbTkGLB8bIRSBGZv7v3aZrSmOPk4wbFKnJIcSHU
         ThxjL7nMmqomPnz5CFqoTRFQd+En0qmgvaOlLqRTNjp8Bwo2FOoNO3BUwOSU8vNw7ujl
         pQkiddRG5r2Pe4krjKUI8ydMT6lO6hrRlPfQlDMOcEh8pwkI7pKN2KnrMixkxrzgVnvW
         av466RqYPuc5eRU62KL78Wme9mbutaFm0BHms7OlLr5gIxie0qn+OX3vOnLSJmoxsmSE
         37Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVShMJUxQeXPSUquonT2/VDthtBNN3Shfb96bKU+5979ZSu9gmZrUVMnedB6RPS0B2g6y7L3A5N8fDRvJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXoehWBdmyMJyFun2dF3fK9R4Q0Cyu4mGVFYd8343BCEZmnzt
	BnHmGOxJK23u2Lf0ltRVqBaoyw3IzewFXTHNg7Wfqj5Ys/w8KFLKyBUpRCiEZj8NUA5TAX6n6Ju
	r6A==
X-Google-Smtp-Source: AGHT+IEvsS4c3s6n9g7x2z5D5H012XZQOsx3RuO4m9O7OjJK48IPzr0OmRE9xbrojGbugDgpO+45yxUumnA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:d84c:0:b0:e28:e9ea:8cca with SMTP id
 3f1490d57ef6-e28fe3fc233mr56043276.8.1728497873567; Wed, 09 Oct 2024 11:17:53
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 11:17:39 -0700
In-Reply-To: <20241009181742.1128779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009181742.1128779-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009181742.1128779-6-seanjc@google.com>
Subject: [PATCH 5/7] KVM: x86: Move kvm_set_apic_base() implementation to
 lapic.c (from x86.c)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Move kvm_set_apic_base() to lapic.c so that the bulk of KVM's local APIC
code resides in lapic.c, regardless of whether or not KVM is emulating the
local APIC in-kernel.  This will also allow making various helpers visible
only to lapic.c.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/lapic.c | 21 +++++++++++++++++++++
 arch/x86/kvm/x86.c   | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fe30f465611f..6239cfd89aad 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2628,6 +2628,27 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
 	}
 }
 
+int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
+{
+	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
+	enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);
+	u64 reserved_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu) | 0x2ff |
+		(guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);
+
+	if ((msr_info->data & reserved_bits) != 0 || new_mode == LAPIC_MODE_INVALID)
+		return 1;
+	if (!msr_info->host_initiated) {
+		if (old_mode == LAPIC_MODE_X2APIC && new_mode == LAPIC_MODE_XAPIC)
+			return 1;
+		if (old_mode == LAPIC_MODE_DISABLED && new_mode == LAPIC_MODE_X2APIC)
+			return 1;
+	}
+
+	kvm_lapic_set_base(vcpu, msr_info->data);
+	kvm_recalculate_apic_map(vcpu->kvm);
+	return 0;
+}
+
 void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c70ee3b33b93..a2a2a6126e67 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -667,27 +667,6 @@ static void drop_user_return_notifiers(void)
 		kvm_on_user_return(&msrs->urn);
 }
 
-int kvm_set_apic_base(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
-{
-	enum lapic_mode old_mode = kvm_get_apic_mode(vcpu);
-	enum lapic_mode new_mode = kvm_apic_mode(msr_info->data);
-	u64 reserved_bits = kvm_vcpu_reserved_gpa_bits_raw(vcpu) | 0x2ff |
-		(guest_cpuid_has(vcpu, X86_FEATURE_X2APIC) ? 0 : X2APIC_ENABLE);
-
-	if ((msr_info->data & reserved_bits) != 0 || new_mode == LAPIC_MODE_INVALID)
-		return 1;
-	if (!msr_info->host_initiated) {
-		if (old_mode == LAPIC_MODE_X2APIC && new_mode == LAPIC_MODE_XAPIC)
-			return 1;
-		if (old_mode == LAPIC_MODE_DISABLED && new_mode == LAPIC_MODE_X2APIC)
-			return 1;
-	}
-
-	kvm_lapic_set_base(vcpu, msr_info->data);
-	kvm_recalculate_apic_map(vcpu->kvm);
-	return 0;
-}
-
 /*
  * Handle a fault on a hardware virtualization (VMX or SVM) instruction.
  *
-- 
2.47.0.rc1.288.g06298d1525-goog



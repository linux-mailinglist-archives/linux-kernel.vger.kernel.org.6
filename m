Return-Path: <linux-kernel+bounces-357725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF2B9974C2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D371C226ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894501E2603;
	Wed,  9 Oct 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="imfZ9yF3"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B341E22FA
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497874; cv=none; b=RGlZFQyOmMPKfxuDPyATxS2Ajg5C6iNcPE/MZOIJq/C2vTLOyiDtExwNva2rbK7pelpElldEwO7eIezTGYgHs2cOIdb1fv/2QuZ7wsbN8zEbqNVwOrTdS7WjkJzinAb4I/bgMnDN7Wo4S0D8jSO0+3zmMrphZGOZ1DhZdQ9Z/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497874; c=relaxed/simple;
	bh=dr1ocippoTiMHINFoEKeoOJdkH3TJbfSreMvnI8POao=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NBWaldUhvwJYI3kB8S7YKz/MSfjd0csp56eH6czHqK8+RkXd+GfnAnZyeVYopeOnH8w+jdN8TePsy1gkczYZdmUNcDHWsfAIqj4OGRPo4lld6vY15r2tFlDojJhA6m1bHxw1uoE4Cc27kR827ftMCM4nLvdQ/u4DWgaqBakaF5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=imfZ9yF3; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e1346983c8so173154a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728497872; x=1729102672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=uFbHUh5HFyC0uY+uQnqYlSoSZ23sTgNwEXGQiV0ebm0=;
        b=imfZ9yF3F+EdM9ILJdDLnqX6xTls+cXhKaJb210JUWqIx6YrclGDxuyVRWGjuraXpU
         pUCz23QO17XNGOT9FPLBf+Hlg3mmvx1bRjlMIkMdBXdq0QZWbGquIeZgZJo2OMwBbaGS
         CVQC+VXdKm0TpE1hOGAwR7Cwcak2Wc6v7ouNXDt6lYdzis8S5SN221as6zYGTcOjJApM
         W8DMlWHNkwpASSelXror3xobdXWVz/OvqiXBvO2zSCH/HaahMnfACPN3VdCamhW5z/Fo
         RBIZYwWIWaufqsU7ELvS8YzDJJCxYYXAGXTddiOngyrq9z1GExhVGZinKHwWv8HET4k3
         BLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728497872; x=1729102672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFbHUh5HFyC0uY+uQnqYlSoSZ23sTgNwEXGQiV0ebm0=;
        b=vgKhCU8rDDFu79QK0MeMEOBxdl50XurMZ+v3u+UP/ScXBNJwD6Rv+9F3TdMe2/y2XH
         2m8PF0q5bEWjL587NrrrKgd9ywmV5lEnTT8g9yQTbFlprWrwp18jQAKshohBIy30Paa0
         kVOQ5d1kok/8uFEmfy3PafblHitrP+e0GmMeKtltdLS/gBfMKYevCN9ob2ZCFoTotC/c
         T1DKl/xRv/xEO/wN3gLzqmwHToY7Fa4WW0Qmk2OSVkLZ4bl419AHlKuGjQax7vpQp4e0
         3zZc9VvaZ+yqf0yksZoKX/hqAT0f2H1PpxKjqh8PTlXoqov2spELzsK4cHsWBNfVOoXm
         okWA==
X-Forwarded-Encrypted: i=1; AJvYcCUxBIMecOq43Z/RGjLmYTWK/pCXP2cTK//IR8HbNHr3BGPo/ITrhZg627U+GOUO5uZCFrBIga6k40O8OFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK+oV8jRslcLxKGfBYRswjbtZrZ3sVBHkZqg6XssdaYboSyGC+
	kV6G0SkAZRfC3S0E9kMZJU/yTrIb2sNXsbz1Vu8jbiqPU7+4jRWXY3s12B4eLAk3i7IH+DQg6XE
	JVA==
X-Google-Smtp-Source: AGHT+IFxgGjwSMcuXgjNkJ5HhITFq3whkXYGmzmgq9KCSPfSEZArwXJp8THUlfo6pQ76SR1lEIlfpReep/U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cf07:b0:2d8:8c74:7088 with SMTP id
 98e67ed59e1d1-2e2c7f4f80bmr1263a91.0.1728497871555; Wed, 09 Oct 2024 11:17:51
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 11:17:38 -0700
In-Reply-To: <20241009181742.1128779-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009181742.1128779-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241009181742.1128779-5-seanjc@google.com>
Subject: [PATCH 4/7] KVM: x86: Inline kvm_get_apic_mode() in lapic.h
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Inline kvm_get_apic_mode() in lapic.h to avoid a CALL+RET as well as an
export.  The underlying kvm_apic_mode() helper is public information, i.e.
there is no state/information that needs to be hidden from vendor modules.

No functional change intended.

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
index 046cb7513436..c70ee3b33b93 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -667,12 +667,6 @@ static void drop_user_return_notifiers(void)
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
2.47.0.rc1.288.g06298d1525-goog



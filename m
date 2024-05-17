Return-Path: <linux-kernel+bounces-182441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30A8C8B58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0AB23285
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C001420D4;
	Fri, 17 May 2024 17:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRxvpZO+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61E1419AD
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967601; cv=none; b=jUsdXGwCiUzPUyFM7EC0+Qj0wu0Cjap+naFhJsEuSznp6IPo0DZdIqL9cSVPOBZ7kLnADtkcvr0kIw0R7fU79xEhaqkpLy0KJ/t7b3yERaohFUYLatEPXDBPmtdS2KdUWljr8EpDDmm28RFpQsQfo4J83EKWbHaIXiF6QKiSxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967601; c=relaxed/simple;
	bh=laZKFsXjLB6k3TKhu7t99v7hDnzkfbuO6HPnpt9yaCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NfX3bCzn7Y8qzQWB2HhxwnDPNplnaMtAN+rB4YbcIS/sgojnHVBdkIKGPbEddfrdSiNQ4F6LQ4CqH1AdOg5fZ07hp9Is5S+RvppUg0IqDz08/BNGSKRq+91Fn2neX570E/yTn55H4G/VVWlcfVDo8fqpN4+g0GjtjEDqwmE8RAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRxvpZO+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be4b79115so182504137b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967599; x=1716572399; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cJS16Zy4jomaDCrDnpvskk8dKRRVP3ZQ5kOPgDcUpWE=;
        b=BRxvpZO+KD33aBejaJAk+lBl1GF50WRlDAn8GoJnQqzQt24vQ+zaBl+X3diFvx0EIS
         fSFmauaRthR8vBYD4w8uJWCj3OHhz/DlTCmvPoo0zR6YZ6eHxxE8tz5EcslHXHQNRHJw
         5Y30FAywWhJ4ZuEMvYnODfxWGgjPvH8XJIkyGmP4AqH0MlUztVGfapCySG5qRvxSKs05
         K6o+Ikn4eaEmbfg0BGFN64NCjV5EJSnC1lAe9pCXaj2rs+HAh7NT/0YHAn2XgmRmhZqK
         Ym3jm+HfPny3E1ZlxLNHjt7d5+7VBLxR2t1vlM7SxxnDYfMl1kMeKDQUFBZuVHOOP5CV
         O9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967599; x=1716572399;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJS16Zy4jomaDCrDnpvskk8dKRRVP3ZQ5kOPgDcUpWE=;
        b=FZqXjejogWCNUcQurgDgFjTWhzDH0NKQd8mu5L0QqLqVlDmutL4ox3fNKcNeEp/0wA
         BZ6mQJlptF2qmCvFFhZVfzsvkc0OHt+gdmosp80i9jfAAY7YJgfWkBBAxaRwflaq7/Dh
         kBGg2JzXFDFOQbLQHbJslH01fYofexPwZZMp+cqSIk/piwYmLpq7RkT8K9a2VrPCYTrG
         medKznsyNewRzXQ2GSiewaB9kvbbDC20aEyXOoqcxjp/vacfj9UwshXopkGRySG645TS
         48adHKWOiOqtsaoh1Yx+zi7RuBd13dM3kBrc74GAfqYOerLMR29TzSuksdFvbxhks07j
         uIaA==
X-Forwarded-Encrypted: i=1; AJvYcCX72lu1YnMf7dLuMiksjr08D+OcyMTynZ2wNFyfaeT8DVczNQ8xry2xg9HG6Yt2XY59ZOV/IxtLg+CTdD1qIRwi7YfekEJBeFNgue+Q
X-Gm-Message-State: AOJu0YxE62IuhuPGMnTekqrduHmqvVdeF8UgsDsXA5rydg/JMMqI20jU
	opXSVvJtqo2CRzhOXgu1HoJnsh5rM8PFAKIDppYcBiKyhBMS7YTvpjxSqRXgdnjuQb3ZE+a5Jlf
	MqQ==
X-Google-Smtp-Source: AGHT+IG6sDb+l7JQGlPZIrkJ7g7F2grqtg0n5NTQqlnhw/CCkoehSoqPccYLZqAwNK4SKFkmmia+KX5yuiA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:102d:b0:dee:6802:dc49 with SMTP id
 3f1490d57ef6-dee6802f337mr4772588276.1.1715967599568; Fri, 17 May 2024
 10:39:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:45 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-9-seanjc@google.com>
Subject: [PATCH v2 08/49] KVM: x86: Move __kvm_is_valid_cr4() definition to x86.h
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Let vendor code inline __kvm_is_valid_cr4() now x86.c's cr4_reserved_bits
no longer exists, as keeping cr4_reserved_bits local to x86.c was the only
reason for "hiding" the definition of __kvm_is_valid_cr4().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 9 ---------
 arch/x86/kvm/x86.h | 6 +++++-
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3f20de4368a6..2f6dda723005 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1130,15 +1130,6 @@ int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_xsetbv);
 
-bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
-{
-	if (cr4 & vcpu->arch.cr4_guest_rsvd_bits)
-		return false;
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(__kvm_is_valid_cr4);
-
 static bool kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	return __kvm_is_valid_cr4(vcpu, cr4) &&
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index d80a4c6b5a38..4a723705a139 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -491,7 +491,6 @@ static inline void kvm_machine_check(void)
 void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu);
 void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu);
 int kvm_spec_ctrl_test_value(u64 value);
-bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 int kvm_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
 			      struct x86_exception *e);
 int kvm_handle_invpcid(struct kvm_vcpu *vcpu, unsigned long type, gva_t gva);
@@ -505,6 +504,11 @@ bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type);
 #define  KVM_MSR_RET_INVALID	2	/* in-kernel MSR emulation #GP condition */
 #define  KVM_MSR_RET_FILTERED	3	/* #GP due to userspace MSR filter */
 
+static inline bool __kvm_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
+{
+	return !(cr4 & vcpu->arch.cr4_guest_rsvd_bits);
+}
+
 #define __cr4_reserved_bits(__cpu_has, __c)             \
 ({                                                      \
 	u64 __reserved_bits = CR4_RESERVED_BITS;        \
-- 
2.45.0.215.g3402c0e53f-goog



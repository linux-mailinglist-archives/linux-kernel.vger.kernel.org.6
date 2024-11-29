Return-Path: <linux-kernel+bounces-424165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED09DB12D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31681281DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4C1CF5C8;
	Thu, 28 Nov 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TrPJzA5U"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC441CEE88
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757765; cv=none; b=PmYzXPlom0K/tshufltJneiOIJdoWFe/1o1WwpqnbPgr29kMQ+tJSMsTEySUb6x1RIn1qEfU2WZH9V37AHpnQurQjlpbprZb7Cxk1qD7pumZUlwhYGxnBEZIJbvPtK9SkErOsNOZtnWEDl7N8D1CvFUKkiGr714AvqSKFRBwnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757765; c=relaxed/simple;
	bh=R+Jy+4BCnS+JqaVrYJvT66a9YrgXyVUkAuexl3Wd8eo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pQ63ePZWdIU6FiNNsyy8mmSeYPLunjZFF8kCOsa5F0jlaFC18ELto5TGzoZcJlogAEsgFKJUaJ4DG4CHDAr63UbtBtBtincgsPuQ1sCSEbMfwtQiETqKwMZCcOz7HAdjTK0vg13Bjac3WoHvJgdllr5uI60NhUsAx0YnYk8YJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TrPJzA5U; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2e5efb04da7so380439a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757763; x=1733362563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LnF7ynB4Px9kV74WJlG52B9/ebUeqESErE/aee+VqeA=;
        b=TrPJzA5U0yB9VEXElcPy9+ymvPZqo5yH4w4qRKGwkYF1czE0Ce7kCPT/FWitVrVZr7
         UdIGiNFOWJfWHJ3OzexecauDjTo9muPHKK9VSuO6Ghv4cOjH6k4a93wJW5LltBqWVZN4
         LFRIib2ntV8ADqpUmQ88/RE4Z6hJoxx6D7LT/e2qYm8Tq0Md/lPOCCIBgsAeZ4XkmPde
         1ke7XpSuBmAojBIdNA5vi+vnBT5pY45KTN3DCPjvHfdfGBZuYxa/T1zEA/fgiM2UFqWM
         QkNSbdcW3jyMN3mRVBPsjmiSmBVVw2a3q5Tacqcrt+9Qf75GXNqeuZ5i5sK7/Gqindxs
         Yang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757763; x=1733362563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnF7ynB4Px9kV74WJlG52B9/ebUeqESErE/aee+VqeA=;
        b=kREKWJRbH/qDAHAT6cMLvx7CiNndQ7p/ro6hBbWOr9eNAZ06hBZQ0KeWsi6tBFyadj
         ZVYCwGG8YSkCs/58a7rXCR1bWmA8RKvYbO6v0/TyxuLgAGC2Yxe5nVgG++0F9xpQ5Y3e
         Rg06Ua1lj8HVFxFPaqqrU847+63mFNQEe3w2p2yDsCAKS9BIsN9/z1kHRVQ7g6h40uQg
         Oe+TmeW1/Vw9MM+3x+WIM5nwRxWP2w1E9l34I/nJqxhHkcGBZSZHPspKbj03eqNMhYpU
         X7YscuthORAuT6s5iUlOatxOG8gxS5tZ2WO/i2f+uFRskL4vdA3+yqeAEAoyE1FLjV9w
         xg8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWDxtGilxxR2jwgfVFKZrnQrRkuw1QRr5HgZdQUsm9miYdh5M8p/tTkiIIKdgijrwKFDBS66T1b/+si06c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPNqqnpVfJwUonSJ8ejpVgmwFNerqsoGZfnVwkVUY9pf4BAwtM
	8IdCIZclH+pbTa6PTPoi54YJLSM9WpKu2ZizdaghKaEaL3cmKCMc2OSmqiS5fvq8iHexHtVfAA5
	AAQ==
X-Google-Smtp-Source: AGHT+IFaKmXX2SmUl85eulR6undd8wSLSTIU71ulzpYU7OrJRQuWYdazMGn7J2i6eG5vSRcVKgle9L91+VI=
X-Received: from pjbpd3.prod.google.com ([2002:a17:90b:1dc3:b0:2ea:543f:9b80])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3147:b0:2ea:5e0c:2852
 with SMTP id 98e67ed59e1d1-2ee08e9fd7bmr6856873a91.11.1732757763167; Wed, 27
 Nov 2024 17:36:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:19 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-53-seanjc@google.com>
Subject: [PATCH v3 52/57] KVM: x86: Add a macro for features that are
 synthesized into boot_cpu_data
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: kvm@vger.kernel.org, linux-sgx@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kechen Lu <kechenl@nvidia.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Add yet another CPUID macro, this time for features that the host kernel
synthesizes into boot_cpu_data, i.e. that the kernel force sets even in
situations where the feature isn't reported by CPUID.  Thanks to the
macro shenanigans of kvm_cpu_cap_init(), such features can now be handled
in the core CPUID framework, i.e. don't need to be handled out-of-band and
thus without as many guardrails.

Adding a dedicated macro also helps document what's going on, e.g. the
calls to kvm_cpu_cap_check_and_set() are very confusing unless the reader
knows exactly how kvm_cpu_cap_init() generates kvm_cpu_caps (and even
then, it's far from obvious).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 49 +++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8d088a888a0d..2b05a7e61994 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -665,6 +665,7 @@ do {									\
 	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);	\
 	const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;	\
 	u32 kvm_cpu_cap_passthrough = 0;				\
+	u32 kvm_cpu_cap_synthesized = 0;				\
 	u32 kvm_cpu_cap_emulated = 0;					\
 									\
 	if (leaf < NCAPINTS)						\
@@ -673,7 +674,8 @@ do {									\
 		kvm_cpu_caps[leaf] = (mask);				\
 									\
 	kvm_cpu_caps[leaf] |= kvm_cpu_cap_passthrough;			\
-	kvm_cpu_caps[leaf] &= raw_cpuid_get(cpuid);			\
+	kvm_cpu_caps[leaf] &= (raw_cpuid_get(cpuid) |			\
+			       kvm_cpu_cap_synthesized);		\
 	kvm_cpu_caps[leaf] |= kvm_cpu_cap_emulated;			\
 } while (0)
 
@@ -720,6 +722,17 @@ do {									\
 	F(name);						\
 })
 
+/*
+ * Synthesized Feature - For features that are synthesized into boot_cpu_data,
+ * i.e. may not be present in the raw CPUID, but can still be advertised to
+ * userspace.  Primarily used for mitigation related feature flags.
+ */
+#define SYNTHESIZED_F(name)					\
+({								\
+	kvm_cpu_cap_synthesized |= F(name);			\
+	F(name);						\
+})
+
 /*
  * Passthrough Feature - For features that KVM supports based purely on raw
  * hardware CPUID, i.e. that KVM virtualizes even if the host kernel doesn't
@@ -1084,35 +1097,32 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_init(CPUID_8000_0021_EAX,
 		F(NO_NESTED_DATA_BP) |
-		F(LFENCE_RDTSC) |
+		/*
+		 * Synthesize "LFENCE is serializing" into the AMD-defined entry
+		 * in KVM's supported CPUID, i.e. if the feature is reported as
+		 * supported by the kernel.  LFENCE_RDTSC was a Linux-defined
+		 * synthetic feature long before AMD joined the bandwagon, e.g.
+		 * LFENCE is serializing on most CPUs that support SSE2.  On
+		 * CPUs that don't support AMD's leaf, ANDing with the raw host
+		 * CPUID will drop the flags, and reporting support in AMD's
+		 * leaf can make it easier for userspace to detect the feature.
+		 */
+		SYNTHESIZED_F(LFENCE_RDTSC) |
 		0 /* SmmPgCfgLock */ |
 		F(NULL_SEL_CLR_BASE) |
 		F(AUTOIBRS) |
 		EMULATED_F(NO_SMM_CTL_MSR) |
 		0 /* PrefetchCtlMsr */ |
-		F(WRMSR_XX_BASE_NS)
+		F(WRMSR_XX_BASE_NS) |
+		SYNTHESIZED_F(SBPB) |
+		SYNTHESIZED_F(IBPB_BRTYPE) |
+		SYNTHESIZED_F(SRSO_NO)
 	);
 
-	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
-	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
-	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
-
 	kvm_cpu_cap_init(CPUID_8000_0022_EAX,
 		F(PERFMON_V2)
 	);
 
-	/*
-	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
-	 * KVM's supported CPUID if the feature is reported as supported by the
-	 * kernel.  LFENCE_RDTSC was a Linux-defined synthetic feature long
-	 * before AMD joined the bandwagon, e.g. LFENCE is serializing on most
-	 * CPUs that support SSE2.  On CPUs that don't support AMD's leaf,
-	 * kvm_cpu_cap_init() will unfortunately drop the flag due to ANDing
-	 * the mask with the raw host CPUID, and reporting support in AMD's
-	 * leaf can make it easier for userspace to detect the feature.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
-		kvm_cpu_cap_set(X86_FEATURE_LFENCE_RDTSC);
 	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
 		kvm_cpu_cap_set(X86_FEATURE_NULL_SEL_CLR_BASE);
 
@@ -1150,6 +1160,7 @@ EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
 #undef SF
 #undef X86_64_F
 #undef EMULATED_F
+#undef SYNTHESIZED_F
 #undef PASSTHROUGH_F
 #undef ALIASED_1_EDX_F
 
-- 
2.47.0.338.g60cca15819-goog



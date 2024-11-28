Return-Path: <linux-kernel+bounces-424142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1409F9DB0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE7416707F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9E1B392C;
	Thu, 28 Nov 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IOiuxo7N"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3076F1AE875
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757724; cv=none; b=ZaAXk2bbqaAntK3zsuHnovkmJ6uEMqDDS5W2XY1oXr/UZutIXwvyOciLdmnoPgH7KCSWRr1LrswAuNhkrnkgEUG6qWKT93AyVbmtvdV6tKXw9uUb7yCcj9Ipaegwwo7WPcq8YZmn7b7Er9+PVeNx+AjQIaOVy4rErkQszTXNACw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757724; c=relaxed/simple;
	bh=iparbKkxMUF353Y34z4B10W301N08LqLmil1yvKSLkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=teKqsUww15O4RqXldcbuF5286dwiUZwwCy9zNCu45ByEWuF0ApQFdnMDV3FXj7KnUIlk95otd8u+idqIuNnmBIp0nDTNM+8yF1G210eruYrLuSpmfibCt1JAgDvmFUcUURkeAMKPR8J0b5QXJUqEi+fvZPJEsjKM+GJGiIpCjA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IOiuxo7N; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eaef95f0d8so443010a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757723; x=1733362523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NZkn7uVX+fUFjolFig2q49G57BV4Dyx1JGLX/2AmIPM=;
        b=IOiuxo7NHB2mB4d7a+ycQxEb+dSKtToAGYncji8jgMfdMMlT17y3Ucg03qhJPymbka
         P9/Ii8q7WvMD1SG74dzuI9chLAflu3S0EBQjyk/OYIg95/Xgw4P8DHdTdHrHimSpE7Lf
         HiUrU+ekME8HtDo6+izv+jAgJO+hsttjHzP8MR6uQh6xipQ8ByZz4H0BMrihLWMqJsos
         eloD3UkUQYizf12KE7dVB5zBoOstFCB7wY82QjvU47ZHaHapGxiLpFfUVjtbbKCgE1rU
         2QyP9owM0IhowW/kiy5d86f9P3UysthYKs9PDaexd8RBqDscxmPk5RqXqrGvJ+KN8WfT
         +OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757723; x=1733362523;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZkn7uVX+fUFjolFig2q49G57BV4Dyx1JGLX/2AmIPM=;
        b=E9ywHbuues0ufV+TxW15rIPoC6Hu3F0+RPd2yDXp+euLaXDFbTTJOeVIk1cp8M83U/
         bHR9WMZcq7RwjJKb25y4j7HWhNsA3rvaHVMsXwCCNtHnPYR2Fl2Ea7bZ47eiRpQL8QX5
         xYwoT2ceetsN2WzSJVfYjrevFVJsrtywun2moUEeA6xpQfzyJWjarkpYxlSReKT+F6yx
         GXEJ1ukNWta2V+k4hT3inErvwvAVhMU2NCdKa/Qyb4p2CT+plL2Vyc1cJMvkkiIIpH8q
         iyGTnDGeok/CVhR/inggDOBlNR1Nwpex4dt10o0ctMNJE8FU78OC4FU59fxOo6Oc6gYa
         0MYA==
X-Forwarded-Encrypted: i=1; AJvYcCWtfecjrkCJcjiugBPC3kMiVRVWwL3cmF5TDrYt/vcchRyDSUx3IN8y5kAb4+4dycZvzEl8/R2NCWHpy3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtRq7l/Cu4JchRZIg6s/G07gAC0ebd6Jbf9T5G7v5GrtB/rbG
	Y1GdXQmCLGiEU4SZUbSQOJFG61jYez/wOeyDnlaDSMPM6IK3WX6lVN7ShfdoIHGaBxNQgobS7GV
	Lfg==
X-Google-Smtp-Source: AGHT+IGI8ND2VVwlZdDGAoDzV/xv9Z/3t6LJP6qC1wVUcOLzFmIaXT+GVqHfCqi9L4txvklzgu6maR67WTs=
X-Received: from pjbpq13.prod.google.com ([2002:a17:90b:3d8d:b0:2ea:3a1b:f493])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d0e:b0:2ea:61ac:a50b
 with SMTP id 98e67ed59e1d1-2ee097e4795mr5918633a91.31.1732757722708; Wed, 27
 Nov 2024 17:35:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:33:56 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-30-seanjc@google.com>
Subject: [PATCH v3 29/57] KVM: x86: Add a macro to init CPUID features that
 ignore host kernel support
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

Add a macro for use in kvm_set_cpu_caps() to automagically initialize
features that KVM wants to support based solely on the CPU's capabilities,
e.g. KVM advertises LA57 support if it's available in hardware, even if
the host kernel isn't utilizing 57-bit virtual addresses.

Track a features that are passed through to userspace (from hardware) in
a local variable, and simply OR them in *after* adjusting the capabilities
that came from boot_cpu_data.

Note, eliminating the open-coded call to cpuid_ecx() also fixes a largely
benign bug where KVM could incorrectly report LA57 support on Intel CPUs
whose max supported CPUID is less than 7, i.e. if the max supported leaf
(<7) happened to have bit 16 set.  In practice, barring a funky virtual
machine setup, the bug is benign as all known CPUs that support VMX also
support leaf 7.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c9a8513dbc30..9bf324aa5fae 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -610,12 +610,14 @@ static __always_inline u32 raw_cpuid_get(struct cpuid_reg cpuid)
 do {									\
 	const struct cpuid_reg cpuid = x86_feature_cpuid(leaf * 32);	\
 	const u32 __maybe_unused kvm_cpu_cap_init_in_progress = leaf;	\
+	u32 kvm_cpu_cap_passthrough = 0;				\
 									\
 	if (leaf < NCAPINTS)						\
 		kvm_cpu_caps[leaf] &= (mask);				\
 	else								\
 		kvm_cpu_caps[leaf] = (mask);				\
 									\
+	kvm_cpu_caps[leaf] |= kvm_cpu_cap_passthrough;			\
 	kvm_cpu_caps[leaf] &= raw_cpuid_get(cpuid);			\
 } while (0)
 
@@ -652,6 +654,18 @@ do {									\
 	(IS_ENABLED(CONFIG_X86_64) ? F(name) : 0);		\
 })
 
+/*
+ * Passthrough Feature - For features that KVM supports based purely on raw
+ * hardware CPUID, i.e. that KVM virtualizes even if the host kernel doesn't
+ * use the feature.  Simply force set the feature in KVM's capabilities, raw
+ * CPUID support will be factored in by kvm_cpu_cap_mask().
+ */
+#define PASSTHROUGH_F(name)					\
+({								\
+	kvm_cpu_cap_passthrough |= F(name);			\
+	F(name);						\
+})
+
 /*
  * Aliased Features - For features in 0x8000_0001.EDX that are duplicates of
  * identical 0x1.EDX features, and thus are aliased from 0x1 to 0x8000_0001.
@@ -777,7 +791,7 @@ void kvm_set_cpu_caps(void)
 
 	kvm_cpu_cap_init(CPUID_7_ECX,
 		F(AVX512VBMI) |
-		F(LA57) |
+		PASSTHROUGH_F(LA57) |
 		F(PKU) |
 		0 /*OSPKE*/ |
 		F(RDPID) |
@@ -796,9 +810,6 @@ void kvm_set_cpu_caps(void)
 		F(SGX_LC) |
 		F(BUS_LOCK_DETECT)
 	);
-	/* Set LA57 based on hardware capability. */
-	if (cpuid_ecx(7) & feature_bit(LA57))
-		kvm_cpu_cap_set(X86_FEATURE_LA57);
 
 	/*
 	 * PKU not yet implemented for shadow paging and requires OSPKE
@@ -1076,6 +1087,7 @@ EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
 #undef F
 #undef SF
 #undef X86_64_F
+#undef PASSTHROUGH_F
 #undef ALIASED_1_EDX_F
 
 struct kvm_cpuid_array {
-- 
2.47.0.338.g60cca15819-goog



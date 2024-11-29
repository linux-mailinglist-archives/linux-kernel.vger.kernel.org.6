Return-Path: <linux-kernel+bounces-424167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363C9DB133
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA37C161946
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742161D040B;
	Thu, 28 Nov 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hAj6xRB/"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403CD1CF5FE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757768; cv=none; b=AMufXGJyLzb9+4BpC9OTr8xcm/PE2z/O+16i5QGeZjUfru6zSWL4eIXPlgsI/ZVmKJRFPmV2wBEytnOofsDx75p6Pv1DP/NshWQoJgX07X0LLON5np5VlIxEjhNFASkatcW2fwtrDFr4j7MxVwG3RIhvL4Kkx58SSu8Js4VfuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757768; c=relaxed/simple;
	bh=q5H8RZZerYPgdqEFcd8kT3tJYeAQ3CKuWYeZf9ZTiZs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KuJUMdAR260x2xtTMyRrz2nGGhn+HbILAyueyDIdafeELjbrLvVY3IYKFEFaNIxZKLCdR/Pm1nCaMb8/xFBH7WUij9YALkb/95v4i/F/glUQ86EKY4CrceMSGt6+Fa24noDq0uvyC8LvkbMdRIadEd3nP+ohdYc7oHtY1otxKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hAj6xRB/; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fb96d3a3a8so241457a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757766; x=1733362566; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xHYO12itxHcKJOUKglurMkGD35vhPyRkzhMBE6y2ZKM=;
        b=hAj6xRB/py3l6uvfAVFljn/QhtKKKbrX/tmvX0F8g3pmHm2B6TTHCs6avIOgwEiupv
         iNmA/44nDoTI05Bg8eOVsGqYgrLbiO5XQVp04/tfRQFVIxlM6RSPVNKxQcVYjRPVo9go
         FUqyxvBFvFczQkaq5zAyvvrsCq7h73czHmAN4pIHfMbAuNaYI0J8nQ0mwqfIflI9Tr5V
         +EsxNw1MfHxjmfM5OdXwYusaX2kagfp57M0yhMMGT8vgUq6nJBeJ6MMCphMlG6hMlqTC
         00MB4CKtEAmtVBBzxzElo+dyQ48NiuCd7ytW1st87an/NtMWKwY6PLFUhVICN62AxVTs
         cD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757766; x=1733362566;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xHYO12itxHcKJOUKglurMkGD35vhPyRkzhMBE6y2ZKM=;
        b=uoFJ/quXxGpVXKR5Fg6n1Fu1lavLw+DtvdNaQdev53FM6rhW7vpYhWMM1YhuR5rHfn
         FeXSmXSpKuDAhPXUXMbIUNtx3zTyoLI25qsZ9sHnd6cNzM+hqU2/oD2WqMg1g4fug//+
         43NeDeBiv+Jf0iP45JRQOvzjICSpNJh9V2AMffjpaMvTbCY6XU+gOMx2cxVblycV0upH
         P700izF6CAxGZ8CLcC1xL1twH7TJ6oiWaipAyXeOUwsDCq+/ESIzA4r2fjpdkHVs4GJv
         OS/o7vdQF5OH/9UYiQzuS9APrP6s/aLgCPlK4hcT5BQANvieAxFWG2n+hSA3zV1ksnNq
         r7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXFFhaM4qGRuAR7xY34O17roJTdkxdn1/7kqdxsv7bBkDTe+zoGqKa3n0+v7czqqtiP4mCoDaHfBOvpjog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKFxcD7RKhhaL4x6syWfZdhP0GjvDZf5mSVgrBJSnKgqQkx7xi
	YKgVhn9Jy3pHZ0n3jAJBQ2Frq9+ijQMD0O+5Uq/4LSVVCOHJVLCmVAVFxcb6JjLIAKdT4/5fW6g
	oGg==
X-Google-Smtp-Source: AGHT+IFsZ7lUwr8xlH5j2a11OIwKwzMdkBSBsYNttISn1OXgnW6c5ZxkH8a1PS/+UB885szTzxPrrhkbuEE=
X-Received: from pfbjc31.prod.google.com ([2002:a05:6a00:6c9f:b0:71e:5a11:d86])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7485:b0:1e0:d8c1:4faf
 with SMTP id adf61e73a8af0-1e0e0b52b89mr8042361637.28.1732757766550; Wed, 27
 Nov 2024 17:36:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:21 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-55-seanjc@google.com>
Subject: [PATCH v3 54/57] KVM: x86: Rename "SF" macro to "SCATTERED_F"
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

Now that each feature flag is on its own line, i.e. brevity isn't a major
concern, drop the "SF" acronym and use the (almost) full name, SCATTERED_F.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3b8ec5e7e39a..a1a80f1f10ec 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -700,7 +700,7 @@ do {									\
 })
 
 /* Scattered Flag - For features that are scattered by cpufeatures.h. */
-#define SF(name)						\
+#define SCATTERED_F(name)					\
 ({								\
 	BUILD_BUG_ON(X86_FEATURE_##name >= MAX_CPU_FEATURES);	\
 	KVM_VALIDATE_CPU_CAP_USAGE(name);			\
@@ -966,9 +966,9 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init(CPUID_12_EAX,
-		SF(SGX1) |
-		SF(SGX2) |
-		SF(SGX_EDECCSSA)
+		SCATTERED_F(SGX1) |
+		SCATTERED_F(SGX2) |
+		SCATTERED_F(SGX_EDECCSSA)
 	);
 
 	kvm_cpu_cap_init(CPUID_24_0_EBX,
@@ -1035,7 +1035,7 @@ void kvm_set_cpu_caps(void)
 		kvm_cpu_cap_set(X86_FEATURE_GBPAGES);
 
 	kvm_cpu_cap_init(CPUID_8000_0007_EDX,
-		SF(CONSTANT_TSC)
+		SCATTERED_F(CONSTANT_TSC)
 	);
 
 	kvm_cpu_cap_init(CPUID_8000_0008_EBX,
@@ -1156,7 +1156,7 @@ void kvm_set_cpu_caps(void)
 EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
 
 #undef F
-#undef SF
+#undef SCATTERED_F
 #undef X86_64_F
 #undef EMULATED_F
 #undef SYNTHESIZED_F
-- 
2.47.0.338.g60cca15819-goog



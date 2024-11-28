Return-Path: <linux-kernel+bounces-424075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ACF9DB05F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4BA71656F3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69267136337;
	Thu, 28 Nov 2024 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm4qnYCo"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363BF83CC7
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732754639; cv=none; b=R7o+11QBObH/7BZtTfvsDtC0+PY8gX11RuPUZZOhCtclSo8awhT5oAaL6hkcuESPe6kEIH+Jp+6oY/TbQqSv00vy5ObjB4Jae9psPBkNxC77SuXPQ+NYd7qNJqJ2OKMWbo8vCxMb/4A3NCySv1VH8Gp9mZ39aF8Yen7GHahRD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732754639; c=relaxed/simple;
	bh=iMEWMeSgtpX2vDiZAZHNPxwDcscsHshHwaR+WGYfMz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ALFV+umhKMhrwwQjJDSovaNH16x3t568O/91h2Fib3zohnJl8TAj/q1SEV0AtjjRb7jRowHgbIbV01RICuDsAG37QlOj5FevjdnSq7Sk/SwsmGqUaXpnLk1aEaZohcsMGuRT4cb1oTriaQ6Dqb4DWkVg8UTH6xoibfsoRzpkI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dm4qnYCo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea69eeb659so196135a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 16:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732754637; x=1733359437; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb2dr0T5bp6rNnjcREbp+SqCdYs3HsUs4UOFpqH2Uio=;
        b=Dm4qnYCoQ441Mvab8cdSfmnRZWVfohDjPcUmSdbu3CGH5T+rzr0H/TNYK8pfLsIyPn
         9qyKQgNv1A28bdHGrAFS5t2DXlW6fkEKWu4fHfjf2Zr7rKQwFidhdpic+AB1cXVRiyS9
         P+8G754SxNVhIkU0YICN9NuNpmTecZIaoNEzbQj1WoZ5tnJRzd74K7xu5wySExxuxDH3
         kKXVYWRotgqYaO4rGcU7/wN328Reo7sMuIqT99csvMEH2+Ir7GmVaD1cj4M/Ws5ShoV3
         XLJQ4WFY2Ua+9oB1ksyEJ8tUyQ6vBPzkL9hXcX3UkNIKuHep3D3CjxkmVz7IhMCEQnK2
         6/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732754637; x=1733359437;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kb2dr0T5bp6rNnjcREbp+SqCdYs3HsUs4UOFpqH2Uio=;
        b=tZDbmDS8cIXeFuA5imbUQFLZ6Q17lAmhFtzwEkveT03GX6hU/O/NtwCXGMkb1wBU3l
         SsKXdMDIf/w5tkxpQLCpBZ4gKKUhJg6zFAW5NpwVQK6AtxeECky7DGKLJhjiJQzw+x3f
         4YvhCP4IiNR43g+I8Q47PlCYo9+w//5oluhWYB3yWxiQN6Dg1KYUgyfzY4KtPRgsrJ8K
         XCCdKZumumcOV7FJiJIIsG2B1d3lcqxkcaxObDuk0dGpm5hw0dhPsDy1RP0vOZhd5S7J
         d2wAPd5dQ/mDPzVHHsJaBE4+cXWn7YEG+OyeHobwX3YuTbjur4OaThRIQTDB2TMf7yaO
         VjSg==
X-Forwarded-Encrypted: i=1; AJvYcCVA7Dj0mrPAHqAz5kjvGinMUgXbDISR8gvZBhvTe5csl/lilrYIhgMBqPAaNvIeKIqS3aKVibNqxg6M8m8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGA4kRZercsVCt4isyP18oJnI/aKz07dfigBRmU+yn+8UxbtC
	noKWw0BwumPbvBhKST28RtXgjIQ8TR9Q+lDj8kdqXZ2Hq7NT3YcalUmHeqJytz8SPxiCEaoabcA
	lTA==
X-Google-Smtp-Source: AGHT+IFAR5YUseLMEmNyaxfAMVHlZLF3OQCHcVX3UaR+ESdLafctVjBieHniv07m1mzMJyd37ZzdGkN19OE=
X-Received: from pjd6.prod.google.com ([2002:a17:90b:54c6:b0:2ea:7174:2101])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:734a:b0:1d9:4837:ada2
 with SMTP id adf61e73a8af0-1e0e0b7e3a4mr7225792637.35.1732754637627; Wed, 27
 Nov 2024 16:43:57 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 16:43:44 -0800
In-Reply-To: <20241128004344.4072099-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128004344.4072099-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128004344.4072099-7-seanjc@google.com>
Subject: [PATCH v4 6/6] KVM: x86: Refactor __kvm_emulate_hypercall() into a macro
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Rework __kvm_emulate_hypercall() into a macro so that completion of
hypercalls that don't exit to userspace use direct function calls to the
completion helper, i.e. don't trigger a retpoline when RETPOLINE=y.

Opportunistically take the names of the input registers, as opposed to
taking the input values, to preemptively dedup more of the calling code
(TDX needs to use different registers).  Use the direct GPR accessors to
read values to avoid the pointless marking of the registers as available
(KVM requires GPRs to always be available).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 29 +++++++++--------------------
 arch/x86/kvm/x86.h | 25 ++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 39be2a891ab4..fef8b4e63d25 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9982,11 +9982,11 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
-int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
-			    unsigned long a0, unsigned long a1,
-			    unsigned long a2, unsigned long a3,
-			    int op_64_bit, int cpl,
-			    int (*complete_hypercall)(struct kvm_vcpu *))
+int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
+			      unsigned long a0, unsigned long a1,
+			      unsigned long a2, unsigned long a3,
+			      int op_64_bit, int cpl,
+			      int (*complete_hypercall)(struct kvm_vcpu *))
 {
 	unsigned long ret;
 
@@ -10073,32 +10073,21 @@ int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
 
 out:
 	vcpu->run->hypercall.ret = ret;
-	complete_hypercall(vcpu);
 	return 1;
 }
-EXPORT_SYMBOL_GPL(__kvm_emulate_hypercall);
+EXPORT_SYMBOL_GPL(____kvm_emulate_hypercall);
 
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
-	unsigned long nr, a0, a1, a2, a3;
-	int op_64_bit;
-	int cpl;
-
 	if (kvm_xen_hypercall_enabled(vcpu->kvm))
 		return kvm_xen_hypercall(vcpu);
 
 	if (kvm_hv_hypercall_enabled(vcpu))
 		return kvm_hv_hypercall(vcpu);
 
-	nr = kvm_rax_read(vcpu);
-	a0 = kvm_rbx_read(vcpu);
-	a1 = kvm_rcx_read(vcpu);
-	a2 = kvm_rdx_read(vcpu);
-	a3 = kvm_rsi_read(vcpu);
-	op_64_bit = is_64_bit_hypercall(vcpu);
-	cpl = kvm_x86_call(get_cpl)(vcpu);
-
-	return __kvm_emulate_hypercall(vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl,
+	return __kvm_emulate_hypercall(vcpu, rax, rbx, rcx, rdx, rsi,
+				       is_64_bit_hypercall(vcpu),
+				       kvm_x86_call(get_cpl)(vcpu),
 				       complete_hypercall_exit);
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_hypercall);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 28adc8ea04bf..ad6fe6159dea 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -617,11 +617,26 @@ static inline bool user_exit_on_hypercall(struct kvm *kvm, unsigned long hc_nr)
 	return kvm->arch.hypercall_exit_enabled & BIT(hc_nr);
 }
 
-int __kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
-			    unsigned long a0, unsigned long a1,
-			    unsigned long a2, unsigned long a3,
-			    int op_64_bit, int cpl,
-			    int (*complete_hypercall)(struct kvm_vcpu *));
+int ____kvm_emulate_hypercall(struct kvm_vcpu *vcpu, unsigned long nr,
+			      unsigned long a0, unsigned long a1,
+			      unsigned long a2, unsigned long a3,
+			      int op_64_bit, int cpl,
+			      int (*complete_hypercall)(struct kvm_vcpu *));
+
+#define __kvm_emulate_hypercall(_vcpu, nr, a0, a1, a2, a3, op_64_bit, cpl, complete_hypercall)	\
+({												\
+	int __ret;										\
+												\
+	__ret = ____kvm_emulate_hypercall(_vcpu,						\
+					  kvm_##nr##_read(_vcpu), kvm_##a0##_read(_vcpu),	\
+					  kvm_##a1##_read(_vcpu), kvm_##a2##_read(_vcpu),	\
+					  kvm_##a3##_read(_vcpu), op_64_bit, cpl,		\
+					  complete_hypercall);					\
+												\
+	if (__ret > 0)										\
+		complete_hypercall(_vcpu);							\
+	__ret;											\
+})
 
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu);
 
-- 
2.47.0.338.g60cca15819-goog



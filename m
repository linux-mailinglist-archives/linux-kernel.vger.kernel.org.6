Return-Path: <linux-kernel+bounces-203399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBB48FDA4F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A0811F25059
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CF4179954;
	Wed,  5 Jun 2024 23:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UYsFw4Ac"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CB616FF23
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629577; cv=none; b=q3WXM20UdFcRvmAsy3IwbDFPAeIIssgGyq7vLiXg6NDX7PzSlaP02Tc27ld22OeBDyjAAjDQ8cB8AYyt/kShXvvbMHpczd3xLWVm4NHMOvKP91IxSj7jMyVYNmou9LOu1o1edKv0hdlbgnNFLqo8WsrG50oZP6EPH7EV/4Lg0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629577; c=relaxed/simple;
	bh=5h1ApSWgEGpbWSOqPNdtnEs42lVvLBVakXdDFBScEX8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TZJ6bM/fAmhPYAecBFEkry9nWK6bVzq1pnUkAiIvyABMz7F6CkUS/si2rFRI9GpQ3tZftiFMLiLiapnCZbjWtv6n4m2eLQx89pieJcsCcq8xi3kDT8g3ml1VYsFfLGHFcLfgqSlyN9/GMRwMijaF2tR2o6+DCutJwY9BC64+uKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UYsFw4Ac; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1f624b473e3so3242855ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 16:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717629575; x=1718234375; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VV/Sjw//EJQTvIeLY5r8Wz3KZdB7TmofauSTUG8W0HE=;
        b=UYsFw4Acv9K2vm8W9h7xpiWGG2+YfoXwP8Nl9I4vY70CUs3F/VjzvuJDt0n6i95aDw
         xGHgnXChzZOTy91fX4cVYwLO2oIG+OwqG9r1ndt6NOKW5n60zxwAJFPDecu6i5/kxfvE
         tTABU5r2gktzFBNOWTrJyB+SZhZbV4jJlvAw6aWJJ4ViS3GHNOMyNB/5B4ZySUnV7cAD
         sSKQsFf1DWNBVFgVRYi4FHZNy7D+tQeLIOsHFfZrkgb6AQTOuuqeUvmZnvWULA/MGj7M
         klMc9F2cZ9GEoczYowXXL3pP8v8j2M2lGAtcDVO01mkLt13s156bDTo2f6RVfriGhoVd
         IA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629575; x=1718234375;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV/Sjw//EJQTvIeLY5r8Wz3KZdB7TmofauSTUG8W0HE=;
        b=BVzkrVdU+XaxPp9Ee5SRMnQXWiSna+zA6uZ4hq0XRyXX0v9IVu/ZxYc72+0UafsAzv
         0Us+0aB83XHdN4P4w2VMFPIT8t5O4H6s5HL686xoBHfOpN9wA6TJdSm5VzqJo/QQRDvE
         sV8i1glY1Z0zPF3ahvbzLDBHDLFLnoKWKGvPTRN7yx2KlijBwygB6XEmsF+SZB6VgLY0
         m2aW/ve7PkqcedBkKQayqcTtHswJoLquuuzvKQNvAEUwjFJ/AU4cWoKaDXgccWjYy5DH
         0ceqO9Xvnw+ucEMgk0xmgY7gVQCsG3NWD3aTE05/P6JuedlaiOsDbOQBvwP3FpMHDaUA
         hgFA==
X-Gm-Message-State: AOJu0YzZCzVooyq7ljiIZFkCi1C4Lphzyg+NHgyOlUy3J9k40QyoOKYy
	fg7ELeFG92gBA5k1EQbhDNEBBnOy7xa2A2pp/W0oENKFCifEOpGOcnYqgsaVGwWR6k+uWx+sQac
	A/Q==
X-Google-Smtp-Source: AGHT+IFl57quie19EWiUZk1dy0ky6k61IH/ZRAZo8VKLwCcyublpQmT60sT7YGd4MrPH91mTdL/TzVr+UXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e80d:b0:1f6:d4b:34ff with SMTP id
 d9443c01a7336-1f6a5901ce9mr1373775ad.3.1717629575068; Wed, 05 Jun 2024
 16:19:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  5 Jun 2024 16:19:15 -0700
In-Reply-To: <20240605231918.2915961-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240605231918.2915961-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240605231918.2915961-8-seanjc@google.com>
Subject: [PATCH v8 07/10] KVM: nVMX: Add a helper to encode VMCS info in MSR_IA32_VMX_BASIC
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Jim Mattson <jmattson@google.com>, Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, 
	Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"

Add a helper to encode the VMCS revision, size, and supported memory types
in MSR_IA32_VMX_BASIC, i.e. when synthesizing KVM's supported BASIC MSR
value, and delete the now unused VMCS size and memtype shift macros.

For a variety of reasons, KVM has shifted (pun intended) to using helpers
to *get* information from the VMX MSRs, as opposed to defined MASK and
SHIFT macros for direct use.  Provide a similar helper for the nested VMX
code, which needs to *set* information, so that KVM isn't left with a mix
of SHIFT macros and dedicated helpers.

Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h | 7 +++++--
 arch/x86/kvm/vmx/nested.c  | 8 +++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 90963b14afaa..65aaf0577265 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -135,10 +135,8 @@
 #define VMX_VMFUNC_EPTP_SWITCHING               VMFUNC_CONTROL_BIT(EPTP_SWITCHING)
 #define VMFUNC_EPTP_ENTRIES  512
 
-#define VMX_BASIC_VMCS_SIZE_SHIFT		32
 #define VMX_BASIC_32BIT_PHYS_ADDR_ONLY		BIT_ULL(48)
 #define VMX_BASIC_DUAL_MONITOR_TREATMENT	BIT_ULL(49)
-#define VMX_BASIC_MEM_TYPE_SHIFT		50
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
 
@@ -157,6 +155,11 @@ static inline u32 vmx_basic_vmcs_mem_type(u64 vmx_basic)
 	return (vmx_basic & GENMASK_ULL(53, 50)) >> 50;
 }
 
+static inline u64 vmx_basic_encode_vmcs_info(u32 revision, u16 size, u8 memtype)
+{
+	return revision | ((u64)size << 32) | ((u64)memtype << 50);
+}
+
 static inline int vmx_misc_preemption_timer_rate(u64 vmx_misc)
 {
 	return vmx_misc & VMX_MISC_PREEMPTION_TIMER_RATE_MASK;
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 6402def985af..bb346ca5b5a0 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7040,12 +7040,10 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
 	 * guest, and the VMCS structure we give it - not about the
 	 * VMX support of the underlying hardware.
 	 */
-	msrs->basic =
-		VMCS12_REVISION |
-		VMX_BASIC_TRUE_CTLS |
-		((u64)VMCS12_SIZE << VMX_BASIC_VMCS_SIZE_SHIFT) |
-		(X86_MEMTYPE_WB << VMX_BASIC_MEM_TYPE_SHIFT);
+	msrs->basic = vmx_basic_encode_vmcs_info(VMCS12_REVISION, VMCS12_SIZE,
+						 X86_MEMTYPE_WB);
 
+	msrs->basic |= VMX_BASIC_TRUE_CTLS;
 	if (cpu_has_vmx_basic_inout())
 		msrs->basic |= VMX_BASIC_INOUT;
 }
-- 
2.45.1.467.gbab1589fc0-goog



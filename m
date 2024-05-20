Return-Path: <linux-kernel+bounces-184038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3698CA1AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797EA2828E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60CC13A410;
	Mon, 20 May 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VO5CFxh7"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58813A26B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716227986; cv=none; b=VnRJR47KdmDdYALql6gaS8CfvgJo0MjtuweG0k29DHRSxql+bncp+lIHyWCnI8gGes77VRWv0m2xTuA1QkWD7xzPLPopzmUuV93NlJ87e67rx26kVOpAAI8k/JKfQvXkATBUWVTP7ixJRpmd/MQkQ4mDYvOgOvkxrS/xmboWYlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716227986; c=relaxed/simple;
	bh=ldVjB/9Nf/eosJ31hOJoXVuhi9LOKsRJDhIqc6QkXLo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/1AxuTvXoU4x/rwyDHdz6nlVGGcq+8TmEm5FIvKtKDgLmWNxaVr60Vw7dpd14Nz4wGOP5ivZ3FqAkWevK7KsBBl5af8Hsrr4ZeZdt2WTHI6TPrftU4nvrc5rcR6EtVyUq8MXzQ0O+AShDICtBC+WTTgMXmvpUjxNTFlYC+jHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VO5CFxh7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f454878591so7087239b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 10:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716227985; x=1716832785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AnKUYffxUupnV2i6nc3ktAl1iWhpGg7wTxn6UYJo9rA=;
        b=VO5CFxh7jY7jlsUaoHS8U7oGX2Sbg/hxJjSJMPNg8iNFrj9CGEKENKums72mDEALWx
         MuPoLOblQwOfdTQ1pYm1q8p12Wr40LH+cjmTHzJ0tcUfhZePMFzDQnZd8Lgl0JIRSWA9
         PR9LQHjhGn7x4J6gcEZcbe1LSukpgYuk7NhJu/PffafGYFvnuSpyXggvq0Rgro2MX43i
         q6R6cXUS2uQEq8dZmz3wIJJ9tC2cUyQv47wwp4anwTj2pnci+EzGg5ZTric1ISCzQURW
         rzQkq/U4E8L8a5+5TyzOdpra+eV5q5s4k3i5ZFMLIVqcE15sumZCo9iXnWvFhrpspPDE
         lZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716227985; x=1716832785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AnKUYffxUupnV2i6nc3ktAl1iWhpGg7wTxn6UYJo9rA=;
        b=ePgzEiR3VFkCvQsPrv97hdMYJMWXXpsKPaO/GHqt0EqRqK+vUN1VM891VfD17A7hKw
         grpuYi2T9QNhA34WWuIHxcnClKxCdkZZlsB9p8ktSNGA8GC3jEAUM6y6nyd3HwHDUn5N
         CYTQQXwo4cByR2jFRPzZUuWzGiGkFNRP3irLTm7Fkn27KE3lGM/LovBS35S0ZbGPpcyg
         adYwav2uoqUlUlsM4GldtTL7O1d49nY9X+uAylJnGfVdYHzTOvmTtDJsvpD/lwwnloUL
         RatJGce6Y+fgbl+e+uerJQa57y/5KIytLSIItheRXZlb50KE0L2SCpAdRBbHgv8ok+62
         Xtog==
X-Forwarded-Encrypted: i=1; AJvYcCXYALXZNnnkYZ6yJ8YuOclISDMVLNB1iAZeRLHL3SOsLyvDihOwtG1GxOjfuGBaX34mmLQ7gqbQP11+uwtq4OpUeB58mlhOVbFOSFbl
X-Gm-Message-State: AOJu0Yzqi0FIcxqx0bvxph8IhDVS4K+PQX8EkYqXhW4cHgPRy3arKudG
	rhJOfm3uNYUCusPcTTlomcNOxlqBt7AuAq3Xhh9JqBVufqmXWEWJXwt8aOrLzszJQ4ivM2hhviS
	FZw==
X-Google-Smtp-Source: AGHT+IEu0j0ZnyTpKVHxXgAPmEvDfIUQFsjiUybmV67zk83NDz6TWc2PEX9qzAzYd2fneBOPA4KW5uoM15M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:244d:b0:6ea:d61b:ec8d with SMTP id
 d2e1a72fcca58-6f4e03eb446mr1099134b3a.5.1716227984826; Mon, 20 May 2024
 10:59:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Mon, 20 May 2024 10:59:22 -0700
In-Reply-To: <20240520175925.1217334-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240520175925.1217334-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240520175925.1217334-8-seanjc@google.com>
Subject: [PATCH v7 07/10] KVM: nVMX: Add a helper to encode VMCS info in MSR_IA32_VMX_BASIC
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Shan Kang <shan.kang@intel.com>, Xin Li <xin3.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
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
index fbfd3c5cb541..d690fa720dcf 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -7035,12 +7035,10 @@ static void nested_vmx_setup_basic(struct nested_vmx_msrs *msrs)
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
2.45.0.215.g3402c0e53f-goog



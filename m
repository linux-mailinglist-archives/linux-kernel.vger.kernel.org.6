Return-Path: <linux-kernel+bounces-424169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5989DB140
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A5BB28551
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923A1D0DE7;
	Thu, 28 Nov 2024 01:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OIEvQn00"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AE01D043C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757772; cv=none; b=AySkL3PVHxRvKsILkUbPXfsJ9xpRWrki+Eh6ZKlrU+S0vs41/T+aY5aa45dYXVlzOkUAboo3iMJgPB62g+qXGmnGkphqb4mRuPCcri0PWbtyK2kq+QythRNHk0gHJIsbIITyqW6+3Sj1+6hd8GC9w+tKRRdzz4SAupfUezWRbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757772; c=relaxed/simple;
	bh=irc8Le9t/2+80quqPskqjkEtE694oI45PecCpS74YBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=O79zdjD3MGJkhyJtEBOKqKbK+t4X9IOjdosdDFtWbQFu1cPGDgucfMH1X2FIoC+/wO8z2olNyUrZcCKdTq355hZz6YAxTUcsgJohOnDVc2xnIuUb6ZdGd5/vStJkmZWvYIPJXkug0LDFlKKbxZj5LGbDpKDj2S0Z9obH5skPNaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OIEvQn00; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-212099b3f01so3172925ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757770; x=1733362570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=xiLgVENbF37xEr+aKdmhYet7DBz2tD95xIx77Ae2lio=;
        b=OIEvQn00827iLEQXgcIwh8NmxjnyWphh1J+qc7OFDnloylrYHz0nxSmg/UMCvwqh+g
         8PIEmmp4gGiGHKNnbYeClBhxIQxyA4TXedJNJLQDUI3VbKCZG+7QqAenG19ZS4oEzzRw
         bIaAZCaF8IGCfhPX6QnX9wjLuGtF7lYXabM/qbRT1B6x56aNK038btG1T5N0clSprLRy
         7W3JZ/f/sFK/u4XHQl0n/rEb2vG406uls/jN7VwbPzlmPNUynVoFqSpSHjWtj50TUDIh
         eRtpPDKUnMU8MpZ/QPVhVoeOAD66ykvi3/OnhTcEqezt+nl2L4AvHU4LBaneR6a+SSLq
         pAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757770; x=1733362570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiLgVENbF37xEr+aKdmhYet7DBz2tD95xIx77Ae2lio=;
        b=oSXDr95yhDdE4WWD6CfHYJ9vjknV7FQiHKJKE8KsKWrpOmtuaJMWiDn8WlxAjstJCL
         DjB2lC7kYSkiI19qS4WpdSutaCyPHWhgMRr4VeydbOdVpx7Blxl4Xd7PQzpy3ZGsdn5d
         uc8CMERpGu/EVFRtVw65Ktv+nozmpYqXcKDcMLc52Sf2fbZf1qH1yGMP0Xm/oSbrCEtW
         pJnj7ZTi2ft48PWVPzM7l2lC8zqaVp88Vmz3KvQ7trzkUwkuSwf4jV3tsQUVExGZH9Dx
         72o/hafmtgQcZWubDwinNsbX4LJTjqW2hAEbvepR/kjteVPLjUNU2CyfXzoveXGwWUKh
         9xHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHWcBpsMV53XYpWK8OVqTrWpGI/wsVJf/+3wfkjswwHLJRWsnW2/TCk8VN0XDo1JL9x0HkgV9nVwug1Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz/aiglJDqiVZpFG+YbDIq3l6RtlYyFD+idfeIaNSAD00zxaS6
	gERMbPBiFQiL4Uqa6kNPn8xlkCV1qNgRYgSNuQKDLoKJtweWYpITyvOhPBRsfeJHC3fqVC6cVBt
	mNw==
X-Google-Smtp-Source: AGHT+IEoKJQaztiJQlzcINhEIAOdgtyjmMRnP8Lc1kKByNnQDVZuqJkARQENGVuqU8UB1VFBKIBP49R5j7M=
X-Received: from plrj13.prod.google.com ([2002:a17:903:28d:b0:212:3bf9:5eb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f705:b0:212:4c71:fef1
 with SMTP id d9443c01a7336-21501f77c44mr68213195ad.56.1732757770039; Wed, 27
 Nov 2024 17:36:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:23 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-57-seanjc@google.com>
Subject: [PATCH v3 56/57] KVM: x86: Explicitly track feature flags that are
 enabled at runtime
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

Add one last (hopefully) CPUID feature macro, RUNTIME_F(), and use it
to track features that KVM supports, but that are only set at runtime
(in response to other state), and aren't advertised to userspace via
KVM_GET_SUPPORTED_CPUID.

Currently, RUNTIME_F() is mostly just documentation, but tracking all
KVM-supported features will allow for asserting, at build time, take),
that all features that are set, cleared, *or* checked by KVM are known to
kvm_set_cpu_caps().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 5ac5fe2febf7..e03154b9833f 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -768,6 +768,16 @@ do {									\
 	0;							\
 })
 
+/*
+ * Runtime Features - For features that KVM dynamically sets/clears at runtime,
+ * e.g. when CR4 changes, but which are never advertised to userspace.
+ */
+#define RUNTIME_F(name)						\
+({								\
+	KVM_VALIDATE_CPU_CAP_USAGE(name);			\
+	0;							\
+})
+
 /*
  * Undefine the MSR bit macro to avoid token concatenation issues when
  * processing X86_FEATURE_SPEC_CTRL_SSBD.
@@ -790,9 +800,11 @@ void kvm_set_cpu_caps(void)
 		VENDOR_F(DTES64) |
 		/*
 		 * NOTE: MONITOR (and MWAIT) are emulated as NOP, but *not*
-		 * advertised to guests via CPUID!
+		 * advertised to guests via CPUID!  MWAIT is also technically a
+		 * runtime flag thanks to IA32_MISC_ENABLES; mark it as such so
+		 * that KVM is aware that it's a known, unadvertised flag.
 		 */
-		0 /* MONITOR */ |
+		RUNTIME_F(MWAIT) |
 		VENDOR_F(VMX) |
 		0 /* DS-CPL, SMX, EST */ |
 		0 /* TM2 */ |
@@ -813,7 +825,7 @@ void kvm_set_cpu_caps(void)
 		EMULATED_F(TSC_DEADLINE_TIMER) |
 		F(AES) |
 		F(XSAVE) |
-		0 /* OSXSAVE */ |
+		RUNTIME_F(OSXSAVE) |
 		F(AVX) |
 		F(F16C) |
 		F(RDRAND) |
@@ -887,7 +899,7 @@ void kvm_set_cpu_caps(void)
 		F(AVX512VBMI) |
 		PASSTHROUGH_F(LA57) |
 		F(PKU) |
-		0 /*OSPKE*/ |
+		RUNTIME_F(OSPKE) |
 		F(RDPID) |
 		F(AVX512_VPOPCNTDQ) |
 		F(UMIP) |
@@ -1189,6 +1201,7 @@ EXPORT_SYMBOL_GPL(kvm_set_cpu_caps);
 #undef PASSTHROUGH_F
 #undef ALIASED_1_EDX_F
 #undef VENDOR_F
+#undef RUNTIME_F
 
 struct kvm_cpuid_array {
 	struct kvm_cpuid_entry2 *entries;
-- 
2.47.0.338.g60cca15819-goog



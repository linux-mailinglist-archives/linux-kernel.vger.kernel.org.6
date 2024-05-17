Return-Path: <linux-kernel+bounces-182477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C938C8BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECBAE282B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA1B158D7C;
	Fri, 17 May 2024 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WbuULUVq"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5D158A1D
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967669; cv=none; b=PVLsvV2hBXAG2jAYJjua1lorB9aO/z0O6ak0Tbk3BOGDit3pWY/pzI0ppNPxCVH0QClNZZMMblDD6ltOG2m4aKTkpCNOvvUwFPZttNUHEvbcS32AlS0jfhEyjMmaLM1KinmCdz2x3vLxwekglSpZLX31pMaeFNR5z8uFWcqE950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967669; c=relaxed/simple;
	bh=eMG2WsWhu9ThjQQ2IwLLxCdRs+hT7CZoTJFSN5es+mM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iaj7Ig04hvF6l9p9wGCl8YNbgXOpFK065aHBLfI+dp+gqz3lHwEZCBiOEu8wjveYkxeIRJ9rLxwTNPw6Q2zroCPwN29WZn/k5SrBy20uqpsXEFyvaz8eo68tEHg/UulqvaLVcYi2pNSVVgQWlqAlHA5VmukxaQ6s8QFdXgzNBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WbuULUVq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f07a648c69so51685595ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967667; x=1716572467; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=S3i279oR5A9gafV11HN493qtqu4ESN7N+2a1+zoKYv8=;
        b=WbuULUVqbXlxAXPTzPq5VF1YnA+ZvBqWpx51rR5N+tjTa7L9l35+/eP1Jq1hPBQCb0
         YO/aA+Q/7D7m0pCzlGp/94oKblUt0vhsscfmufuDcFbSbkBsnvs33VoeqT3D1XRgcBMP
         LR8f1x6IGdB1Q4JH7VxIkA2EG/yDPrN9alYC6hc49aO1svMKtDzpNC3dZnX+QnUbBmdB
         TI6RNuj8H4j1M/oV0PoYs45VPqPtXAp7xm2Je7HBWoEJjrFnxlBRl7AM/2ykIwzdJ8K6
         9ggqGVy9nd1zphTazagJhEaBnCKgofW+vqbe9zH6tbNJSPVlm9BY0Yh0RL32DgxXi3uV
         Ua1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967667; x=1716572467;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3i279oR5A9gafV11HN493qtqu4ESN7N+2a1+zoKYv8=;
        b=dy2ezh2UNj8S1vhZMF77o1mSSbzYEBjXuE1ixqwAdV9CPOOkLCAzOQ9jXpUv+KOrpJ
         aZk1b+xoTNl6rKOQr7py16iulxnXhGVHU8vP6wZfbgvzD4/OhzQBAEy4ICWT6Dws6C93
         L8PUTRkfJOnlDu+aRbXza2e9LRYyjwndy1Qn9bMwob2Dcq3aybip62DgEX0DIlcjZwTs
         GgxfvbH+MXQt085COLnXWr2JHJOpT2wppQ9ft3Jn+uoC+iImax5Cg2MjyTUFg9t6ArQG
         8vKwo1GF0/wKN5XxEavvzlI+W9Glpof0E1hjXlKWYwL/wCjQarH6CHG/Is6alfvi46Yj
         pC/g==
X-Forwarded-Encrypted: i=1; AJvYcCUwMg80NCAFtSIKZRqTTPLciwvalR93BYmX1pdAmkWeJ/T5ULkqN2ihbgygcdFkBRwf0cOBu568R0K0tJ3QEpLTYbyZRQnJoOc3efLL
X-Gm-Message-State: AOJu0Yy+8iDWt2OdjqEYJfpc5SVQWXAqs2W992+7wpvdQHzzGW1eA5Ur
	DFBNaMy61FG9a6SFBkyKSuuBo9hT/uxqgUP03z+jJLXgUJzCn0HcOtlFbjE7EZIPFXjTyLqeU67
	0EQ==
X-Google-Smtp-Source: AGHT+IGVMP3UivBCHH3nAj+aWK1z4JhAOs3LsZDkYlD+Ckt4fFCv9ZqenfvScHIqK4t8zX36pp6bk3n4Pn0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:120c:b0:1eb:4b30:b5c with SMTP id
 d9443c01a7336-1ef43c0720emr9706875ad.1.1715967666996; Fri, 17 May 2024
 10:41:06 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:21 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-45-seanjc@google.com>
Subject: [PATCH v2 44/49] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

When updating guest CPUID entries to emulate runtime behavior, e.g. when
the guest enables a CR4-based feature that is tied to a CPUID flag, also
update the vCPU's cpu_caps accordingly.  This will allow replacing all
usage of guest_cpuid_has() with guest_cpu_cap_has().

Note, this relies on kvm_set_cpuid() taking a snapshot of cpu_caps before
invoking kvm_update_cpuid_runtime(), i.e. when KVM is updating CPUID
entries that *may* become the vCPU's CPUID, so that unwinding to the old
cpu_caps is possible if userspace tries to set bogus CPUID information.

Note #2, none of the features in question use guest_cpu_cap_has() at this
time, i.e. aside from settings bits in cpu_caps, this is a glorified nop.

Cc: Yang Weijiang <weijiang.yang@intel.com>
Cc: Robert Hoo <robert.hoo.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 552e65ba5efa..1424a9d4eb17 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -330,28 +330,38 @@ static u64 cpuid_get_supported_xcr0(struct kvm_vcpu *vcpu)
 	return (best->eax | ((u64)best->edx << 32)) & kvm_caps.supported_xcr0;
 }
 
+static __always_inline void kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
+						       struct kvm_cpuid_entry2 *entry,
+						       unsigned int x86_feature,
+						       bool has_feature)
+{
+	cpuid_entry_change(entry, x86_feature, has_feature);
+	guest_cpu_cap_change(vcpu, x86_feature, has_feature);
+}
+
 void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
 
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best) {
-		cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
-				   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
+		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSXSAVE,
+					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
 
-		cpuid_entry_change(best, X86_FEATURE_APIC,
-			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
+		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_APIC,
+					   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
 
 		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
-			cpuid_entry_change(best, X86_FEATURE_MWAIT,
-					   vcpu->arch.ia32_misc_enable_msr &
-					   MSR_IA32_MISC_ENABLE_MWAIT);
+			kvm_update_feature_runtime(vcpu, best, X86_FEATURE_MWAIT,
+						   vcpu->arch.ia32_misc_enable_msr &
+						   MSR_IA32_MISC_ENABLE_MWAIT);
 	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
 	if (best)
-		cpuid_entry_change(best, X86_FEATURE_OSPKE,
-				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
+		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSPKE,
+					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
+
 
 	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 0);
 	if (best)
-- 
2.45.0.215.g3402c0e53f-goog



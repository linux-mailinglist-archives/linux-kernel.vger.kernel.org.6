Return-Path: <linux-kernel+bounces-424160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737EA9DB124
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BD7280E8F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E51CCB45;
	Thu, 28 Nov 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpjOdGjB"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8E31CC899
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757756; cv=none; b=SBbfd2vF/oixHAXNo5t4LqmnZHlzEj1+Jch8ZoaCHViUcGzTun5P9daCE95Kk7tU+0ixWZ0940+keps2X+xFl0dg7yDj28n0vRjtu9EOEFlpMdN/S2WBs72ozfdnazIDHs02KVJQP9I/xb0gp2MxFV0IYnnN7Ol1xPrPM1t14kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757756; c=relaxed/simple;
	bh=abV0OpWUpY5+yBAXoMXrcOmrPhWTKywAMUS8bJBf5tc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JdfxlqBw/Qglfrrva7g5hhtTbgmGWUK8yFv76eNFOk8SqeY1v/Forjr/5iphoEjoOVDImTmkb6FLow70rY7HW/Ph+x8P5nvuvToL1pKb92RNJ3B7SjDqyMZV3ZHT4PubZjwTLcKcXudNv52qdhURrGavLsZO+5RSZXth6S5upWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpjOdGjB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fbd9fd86d3so1092737a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757754; x=1733362554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=em2i6mSq/FSOswh2gZbHOe2+rj1ku/tF6R6GVHGz2Ss=;
        b=OpjOdGjBZgQj92uf/LUH4riGU4XxinF+ywWP4cNaFtc8UdEdQ3DjuAr67b4StyHrvK
         F6WF/7+UNJT2bH6eiT7J+caS5TgThNGs4b7T+5KT60Vx7qbAIOMIyOAiKpJFD84eFirp
         BunQJLh2/t5rCJPWyHW5L9Y2+eQkBk1qohjqYuL4FgZNhUGajZKtTi7GkGeg+N08Vo+o
         iLVHZfCKeOSqXCiJlPvJqzkP4bMrUKtlrXkSNcGEAIbNfV4v9mdYkTc/g+Z4JAW8/0lV
         JvcVbvNJEjwQICJwljaUZjZQ715j36OJl0xdV2Lc//QgpRomH8JLayb6sGb70OxOANmN
         72HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757754; x=1733362554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em2i6mSq/FSOswh2gZbHOe2+rj1ku/tF6R6GVHGz2Ss=;
        b=wnzxTJwCwzhF3FKHrG9lg58xWxTMvsxwGstRXVKJSA+gCZY/pQXQdhA7PbV9rQ3r2w
         dfZUNYN+PJimvtXLyAoPtxvv2o/KaSRSZm+2oXjFrAEKNoNq2iTl4ev/frJKNnaaO41N
         NJLz5aZ5YtpmxaCWfj+pwb0lFQCxUGO+uC8J4mnQPb4AH2eCXfGuz9Ns0A2XOiYxmH3H
         cTw76qXVyWpGIGxYtLu8NF6EaR0M+6C2CMtKiSKzDza98VcKdkhFBpA6C+MvxbZhGljs
         VoY7oTv4rUEAqOC4K3lE0DgmeG+no6vg8JSCML2xQdkrCDFyhWtuR/Ah/DUf2vrwQaxn
         2asg==
X-Forwarded-Encrypted: i=1; AJvYcCU+It+3P3gSrPmOEFgyyhqn502MnSFvP1P0iJNjfbkpZBhbTNfZ7KZqAJNoORRzIVv8PFNrVoQlwjHuDdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxosznVD1zwb3msJk+rr9JURJVPNIt4BWc13ZN8qmJ36dRPaJ7W
	74q5M4ojFkqHqwB0lzZpAotYHHPFMAjlVr7sQvw//7ixco146+VxP5o3T8+nsvd8TRU3mG8ybop
	cvA==
X-Google-Smtp-Source: AGHT+IGGOzmJ2vI9VhH/NTQdD7nksABJ8Xh80dxB6NRhbDSMvvAWKI3TKxcmA3cvwGD6/f7BGRgkpyNTX64=
X-Received: from pjbpb1.prod.google.com ([2002:a17:90b:3c01:b0:2e2:9021:cf53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4d0d:b0:2ea:5fed:4a32
 with SMTP id 98e67ed59e1d1-2ee25af2e0bmr2429796a91.11.1732757754067; Wed, 27
 Nov 2024 17:35:54 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:14 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-48-seanjc@google.com>
Subject: [PATCH v3 47/57] KVM: x86: Update OS{XSAVE,PKE} bits in guest CPUID
 irrespective of host support
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

When making runtime CPUID updates, change OSXSAVE and OSPKE even if their
respective base features (XSAVE, PKU) are not supported by the host.  KVM
already incorporates host support in the vCPU's effective reserved CR4 bits.
I.e. OSXSAVE and OSPKE can be set if and only if the host supports them.

And conversely, since KVM's ABI is that KVM owns the dynamic OS feature
flags, clearing them when they obviously aren't supported and thus can't
be enabled is arguably a fix.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 7481926a0291..be3357a408d4 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -276,10 +276,8 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best) {
-		/* Update OSXSAVE bit */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
-			cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
-					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
+		cpuid_entry_change(best, X86_FEATURE_OSXSAVE,
+				   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
 
 		cpuid_entry_change(best, X86_FEATURE_APIC,
 			   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
@@ -291,7 +289,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
-	if (best && boot_cpu_has(X86_FEATURE_PKU))
+	if (best)
 		cpuid_entry_change(best, X86_FEATURE_OSPKE,
 				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
 
-- 
2.47.0.338.g60cca15819-goog



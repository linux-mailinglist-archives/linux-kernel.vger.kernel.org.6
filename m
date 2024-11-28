Return-Path: <linux-kernel+bounces-424161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7019DB127
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D36165474
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0E91CCEE1;
	Thu, 28 Nov 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5mxKueN"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B46C1CCB3A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732757757; cv=none; b=TxbwgtQ+i+euORBpfU2+zb5mJ5OJ/XE4JT4fI9upmBSWSQ4aM+VjJe01iYG5B+RawpcLXg23Lp6EpWEDz0Tx0t5uTsHL/B9+ZS+lskrq6CmwbeNg+axR0fR1NA+laoMqz2eaigR84RKzeDoswkRB0DZdSYkKHuDKXPCdtynfOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732757757; c=relaxed/simple;
	bh=G2lBHRid3/4PtvinjWp7apmL9dW9V1G0uvD3pQ009AE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=laK3bdDweMIkr9Umq18B2HjYgLA743bl4xiXViElxMOQ+WsDEEJZvM6xbcxjUEVqv8mqyOsgTqopLJjwCLoWyKYBRVHJs3YcaYwmVKJRQIVtc4T0BksGxSCX98NWeUJRRlGHPKOPeOeJEaRHCVsMEbzlboXNhO2s+h4r7xd28Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z5mxKueN; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea69eeb659so230406a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 17:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732757756; x=1733362556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=q+2tj5qWfvzU/HpbeWp4U5fA1EnHQq5eiizkVcz8+0c=;
        b=z5mxKueNWyXHJWM59MSVLsWyfdugFOeKfhXvxI9Lb0GnPv7Nbxe+7V60/kqYMroiof
         jmmt4sKx4/Gcc06GYvEZFlweFMuQncjamE8GIUTZ59pgclIbFKUdQ73JWWbUJ9TSSOqv
         c9R0bM8NMldo5TmbRl0TJJCGTziVYEYfAzVi6MtuTcyFAlKQJQiFeHwUuDjM+/vQ3aW4
         PXODVxxW//zrsKZE08D/yXHaw54WIvzx+p9iHC3jNHtFvk+/RdLGQO7qCpr/QbKWN8R2
         0VRKFEObk/UwtpxhPIaVhQ3Y3axRqtzenoyfMzInjuMaZJkr+VaOOIsDJMI0rCevFEMH
         FMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732757756; x=1733362556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q+2tj5qWfvzU/HpbeWp4U5fA1EnHQq5eiizkVcz8+0c=;
        b=Q90idpiNVq0uwn5xK17E3OhrpN9XsAGQoNKfHYfS6lifjZc21DxCfRoC+cGY+gmDgi
         Q4Wwyn6VQ/Jhci7adLgD4/IdeoPeyo8QlBMcdCQkufYIAypAdhW3ky20iL4YMxOEbvZm
         0+6pvy4ujAJCTmm/IDCEv/rZ16Pxz0ctclz/BQbd92o5N/RLwl7rqFq7P+wuhoQd9+kg
         1fVyeq15xjx3B/NE7BTCA2eBEfW4N7hJIIxzeZV10oTK9nRbdD7mXkkAO7skH4L0RQR8
         6rCDFgwC6KrjXadJd10V71mM07ZlL4OkT+KWGtX9s/FCeijvWoTAVQQ+/zS5w9jCgACP
         l34w==
X-Forwarded-Encrypted: i=1; AJvYcCViPZmRsr7cYUYlLBTR6hsbOPj4+DybU1vGZ+SFDgp6x6E/p9n5pNZxuHBqtVDK3MCggcZLLbMn04Wx1z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlK8B+dXU5SAsoJX14+P69N0nScL8O6H+B0VNWGH2ijxYjZG2p
	zakkRfmOAA4yiIJ9qVbXnnVD1cA/3CvgJ62kPMnfFpczxAXIcCYKZ3nZM9HY19VRsC0s5ceCMae
	+dA==
X-Google-Smtp-Source: AGHT+IHXcOjcRyaYqAsQ/WhFIeBd1rOxVK/Pjg6BAsmcNSYYFDZz/HBtaBNpLPxQAzICmeIHgQkvhjU8kiw=
X-Received: from pgbfy18.prod.google.com ([2002:a05:6a02:2a92:b0:7fc:7dce:edb4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3944:b0:1e0:d632:b9e0
 with SMTP id adf61e73a8af0-1e0e0b0f127mr8764148637.13.1732757755865; Wed, 27
 Nov 2024 17:35:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Nov 2024 17:34:15 -0800
In-Reply-To: <20241128013424.4096668-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241128013424.4096668-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128013424.4096668-49-seanjc@google.com>
Subject: [PATCH v3 48/57] KVM: x86: Update guest cpu_caps at runtime for
 dynamic CPUID-based features
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
index be3357a408d4..d3c3e1327ca1 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -270,28 +270,38 @@ static u64 cpuid_get_supported_xcr0(struct kvm_vcpu *vcpu)
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
2.47.0.338.g60cca15819-goog



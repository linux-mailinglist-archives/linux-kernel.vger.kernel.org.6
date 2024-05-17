Return-Path: <linux-kernel+bounces-182439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2445C8C8B55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A013EB22874
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710F01411D8;
	Fri, 17 May 2024 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ElGEPxtB"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B54140386
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967597; cv=none; b=ITTRopoSzIr2HJaF4tsj2nSLA7kgMAfnPOkremvwYe2qK29DYEUG7hOrM2nnxf3i1vD+q6Ub0XzLYMt1IQNZD4WwAUZCMjAzX5/3R3RBbJCQYmCqUZvXgXHd+D13pSY2zq3Nn7Scmr3/31/lfHcgQRJ1YQc301ptwQRyu06NceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967597; c=relaxed/simple;
	bh=AbfLQhyF3OH5B997fpsklE0q8dPfOTJZLQGWldAmSWo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbPCtu9jaYyjGgPWvQzE1H9dDd0V3n6w9Wu9PgmedNhY0ekEfX/wOxuRlcPxJNg84QZyBeOmVXh1JuvmXdrc7ntioGBfNG+L92NqP2nzCy872M2lWD0ym3zlLCObeiiLedO6qdqbipoGEZSQjl6JgJ37vEq4jWtAPynqEigoHWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ElGEPxtB; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ec43465046so86986195ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967596; x=1716572396; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=n2pDz7/oTNEpqtQer1kZX15zeO+uHNcrWAzJZzhQ5SY=;
        b=ElGEPxtBLIRKCnvsx7fBDkE5gA923UJD1oi5+LRSkP1LYA+2gXzyceSOGMypl3WLvR
         Vh1VBb/tApFBTqJr3nDrOxS4hh4cSrJ6GJo+2qoqz3kmsAAurNZES02D46yZHi11ZHee
         ZZzjgN5EbiFnQBcqQKuvRkuS4d6E5jqXoy5kI7E/XHXNi6tP++wGpw9kCkzk78KmwOlM
         UX0wDGMjK3oaZNe2qCVfDiRMwG5C/TxgbAWPiCrJOOnNOkGexMZr1xvWuadK8Vi2u79g
         A4fUM0EhCne94vcNcghNU74v/0B2udcKGtihLprSLezajlm1Bhke4u5gT6qRCpfCN1Ic
         fKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967596; x=1716572396;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2pDz7/oTNEpqtQer1kZX15zeO+uHNcrWAzJZzhQ5SY=;
        b=BePcnQNXaXL2OH9Pd1Wcrbvosdxg2Rq5tccrd9l3pxpxvFwehKMGwWPac/mM2eiWFX
         cxpt62dof3c5deNrCLlCvEfMTKV+8sHRmoXKt49oZDDNE8CylR+e2n8GRrY/Xng5aNti
         g9n079IaO4f2WksYA/FbXQvlRuS+UDCWNOChCn+JyGfRKBbuqDWOslxnIm3xQ5TwCsHo
         idPswz3NBzD+2UVFYp9QzS5JVSteYMPY36O9dj9XPy/xyLgafPuMXDBfNCfM5Xrl+wG8
         0DS8nE64LFJF95+1I9EIYczxiygMnY6UQ5urZhDMhMlcAGvHwAGoNBLptI3qzjhL8If3
         MQNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOnsPHzOXceFjfJAqw2cBk1tk4n28d8+0HYK4pVyOlOMhUka7N08ZG1e//FK8m2rGHtLmr244UIrXXkBWkarvEGvSOJXuAMWJr211n
X-Gm-Message-State: AOJu0YwRv7HLqxvtFe1Pzi5VKqB2lsBcVHXYsxJXNXa0XkagqEPivZj3
	J1Xud/1m6l8bTISX5VesruLU1wtUs1W3PjvWnmXZc5VeuhYYd767Yk2Rlg2rE17dzfdPwfTT0Cw
	jKQ==
X-Google-Smtp-Source: AGHT+IHHJT9L7juixaqDq5aE+FqCbe9Hd6zC3NBYVhjtCHTrrsNtJXD+RNttaeuuiFjmdSa5oOeHG+DYsp8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c947:b0:1eb:50fd:c37a with SMTP id
 d9443c01a7336-1ef43d2e21fmr10094135ad.7.1715967595676; Fri, 17 May 2024
 10:39:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:38:43 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-7-seanjc@google.com>
Subject: [PATCH v2 06/49] KVM: selftests: Refresh vCPU CPUID cache in __vcpu_get_cpuid_entry()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Yang Weijiang <weijiang.yang@intel.com>, 
	Robert Hoo <robert.hoo.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Refresh selftests' CPUID cache in the vCPU structure when querying a CPUID
entry so that tests don't consume stale data when KVM modifies CPUID as a
side effect to a completely unrelated change.  E.g. KVM adjusts OSXSAVE in
response to CR4.OSXSAVE changes.

Unnecessarily invoking KVM_GET_CPUID is suboptimal, but vcpu->cpuid exists
to simplify selftests development, not for performance reasons.  And,
unfortunately, trying to handle the side effects in tests or other flows
is unpleasant, e.g. selftests could manually refresh if KVM_SET_SREGS is
successful, but that would still leave a gap with respect to guest CR4
changes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 8eb57de0b587..99aa3dfca16c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -992,10 +992,17 @@ static inline struct kvm_cpuid2 *allocate_kvm_cpuid2(int nr_entries)
 void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const struct kvm_cpuid2 *cpuid);
 void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
 
+static inline void vcpu_get_cpuid(struct kvm_vcpu *vcpu)
+{
+	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
+}
+
 static inline struct kvm_cpuid_entry2 *__vcpu_get_cpuid_entry(struct kvm_vcpu *vcpu,
 							      uint32_t function,
 							      uint32_t index)
 {
+	vcpu_get_cpuid(vcpu);
+
 	return (struct kvm_cpuid_entry2 *)get_cpuid_entry(vcpu->cpuid,
 							  function, index);
 }
@@ -1016,7 +1023,7 @@ static inline int __vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 		return r;
 
 	/* On success, refresh the cache to pick up adjustments made by KVM. */
-	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
+	vcpu_get_cpuid(vcpu);
 	return 0;
 }
 
@@ -1026,7 +1033,7 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu_ioctl(vcpu, KVM_SET_CPUID2, vcpu->cpuid);
 
 	/* Refresh the cache to pick up adjustments made by KVM. */
-	vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
+	vcpu_get_cpuid(vcpu);
 }
 
 void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
-- 
2.45.0.215.g3402c0e53f-goog



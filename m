Return-Path: <linux-kernel+bounces-182476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12B88C8BA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023481C2245E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 17:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F32158A2F;
	Fri, 17 May 2024 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tn+/7Arg"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18509158A02
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715967667; cv=none; b=aNYOWONCChumZ9Lh6xN+bG8CqvUVXVHZ9I7s9O/+6OTGgupMa3pf/36AJ+oG3iNk07n8lgW2v35ctmA5et6y4eL/S6t0IGETiTFxt4QgJZdCSOsaTeF+N81pQJSrFBEfXts9IhtdT6Clr59f0REHaU+d+8kd9bKny7pyZj6FOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715967667; c=relaxed/simple;
	bh=3zUzzzxucQZAbr71D0DmujeOsv7diMSfzYKvmLSrt/g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V50D+raw6vXcwXW5vZClKDIOwr5adyKrHTUgYyIfe94FkXH4w7BoGKt9JKAklX+U0IaZSg1rgJpw7kEIcvejQ5DoPSsAuq0IpeIGslFme5VfrJvScLERNOBxuVKpkp+C6JnCrJdjffwG59VJiiSc+jO4HVDBmIzkB92WYnerbBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tn+/7Arg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f9ca09so160793557b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715967665; x=1716572465; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=k9HN6+T1kQpxqp89cuzhx9jHoM7BiF89qZB9gdOCtKM=;
        b=Tn+/7ArggweaWW9nQLt3knMmriZ/g/+PyJbCtKEQk3l/a75rs0T7taGn7TYN/VCLJs
         F1f60XeG86uOESCVLl4hpWZ2/bcXqCc/iU+MdFhmvdeCgHHBQhN07heYquKCt6pcnrEo
         JnE5Q/2aDBwyqKd2FijWqV1/ZgDg8mYu0pPJZp8ibbY62PxkxBQwR0Kf9hLOLS3KpQ/v
         lZ9V7ArGSTTn0oK2ld1MjFLImbpwZQPvTDZyTAO09qfSU4hl5aMUBSn1aPD27YJdNLKd
         7E4hCrJ5R1i3L/GlpdNBdLPRtq6S9vemGQhwFOzsYKQIt7oSqEJNJJxPJVOY+4RAjUp4
         1G6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715967665; x=1716572465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9HN6+T1kQpxqp89cuzhx9jHoM7BiF89qZB9gdOCtKM=;
        b=syrkbR6SgtXeSaYoRYIGXZzhFS/O+EUuA/Uj2jKW9PX22N6a0fu1IfKqfETujeCqHY
         Efyi0aY+/vd1ZAMCs6nCWMpdVeXSybpuhwhi6sJmF69KEVKZFacTqU+aiRaCwz0CZzSY
         eoq9Vlg7hh0G1ndJ773TyxLVvUDBeFwzfcMrjd5+Hc2bH9zF9L1ZhSPoXtUl9imeGUmA
         4Sg9bwIYEgQw0E74nVSTB2i3oXiHkEVHl4fGwnvP9N3aGhVO4MaUFl3P8HbCLqKRMEMc
         4agKJTLiAKywUD8RZWfwYV18BImuwsdyHWdfXDOVq5ztp3uBA+ipHFjPYVCSrkUz5yNX
         Jiig==
X-Forwarded-Encrypted: i=1; AJvYcCWJdzz9mYDb5+heeMXi30FawVYTK9pS+Hf1uNpmwkj+3x1NziMfYf7LlbUOPwAAElNJ1U/z5hA/Qt4gkRpiY+J8Xp5IqaTuZU2GIgbl
X-Gm-Message-State: AOJu0YyXbHKlKVm7d0ydIXWMGo+1unDNa5pNMR+Ghk/1HBz6knOM6pyD
	DYhjjvxLq8uovq/hEfLfGj3Gp0UOZVzkaXL4QT60s88ktShxuP/n+WCfrUOhNfxHsnq/oEfpIli
	Q6Q==
X-Google-Smtp-Source: AGHT+IGHKMItbnVB37cVRqK29X+EjhtNIMWRmqgByCNxynwG28s4Mm9qr1xFC5xEY8Pk4mtu5ts0LMTnP54=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:c05:b0:de5:2b18:3b74 with SMTP id
 3f1490d57ef6-dee4f33cb2bmr6152009276.2.1715967665318; Fri, 17 May 2024
 10:41:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 17 May 2024 10:39:20 -0700
In-Reply-To: <20240517173926.965351-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240517173926.965351-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240517173926.965351-44-seanjc@google.com>
Subject: [PATCH v2 43/49] KVM: x86: Update OS{XSAVE,PKE} bits in guest CPUID
 irrespective of host support
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Maxim Levitsky <mlevitsk@redhat.com>, 
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8256fc657c6b..552e65ba5efa 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -336,10 +336,8 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 
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
@@ -351,7 +349,7 @@ void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
-	if (best && boot_cpu_has(X86_FEATURE_PKU))
+	if (best)
 		cpuid_entry_change(best, X86_FEATURE_OSPKE,
 				   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
 
-- 
2.45.0.215.g3402c0e53f-goog



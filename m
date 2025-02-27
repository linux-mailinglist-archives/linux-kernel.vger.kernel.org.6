Return-Path: <linux-kernel+bounces-537415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707C0A48B82
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468B63A9D24
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C06276D70;
	Thu, 27 Feb 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="abkAOfxW"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE5281354
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695064; cv=none; b=sRvbTclzJ8/qWEHUwBdvA+qBzD6/btD1mAh/Pv1c65/X8vq2QY2s4yTBIxP4kynq3DMpkxPkUywUi8swkGY1lcvwDgaxZmPewDXp57Xcv9gxZ/1QZ3Hu/f37ZblUalcmiQ1i4wh5WNy9IV53kfO7GKWkTyhnq/G1VsKdHRiaehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695064; c=relaxed/simple;
	bh=uaIIITJgUawWH54PuijoRuV64Rx6tfBFy6BV8graBMw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VTTuydgzjgQvtDcJZwbbgDmJLPbLofVB0M+QfU1Sodqgqr88WOtOMoRSKJytxPul1yLA4mm9pbRQMMaJSUkbltBhMppmRfWUlI+xEAIi80QWHToFg3SQeSrUPVwPaFB4ueH+mYL4kpvZOT4T42kvlQWfwR3Ff38tEyC0GJulFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=abkAOfxW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2235a1f8aadso15981535ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740695062; x=1741299862; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=4G+4qHSVJnaTG8aqakqnf5oS6XZxipCyWxhYCrPdMqU=;
        b=abkAOfxWRZcu4NRNZREt5bSe9KbvOD5QN5aQFG0qL8Aj9kos5xCL7mNITnpRu+1DbQ
         Wuvj33poeMCtoj8vXNAlClXU59J7czJkkcXGjW1XagJmaNq4n5e8igRiHARCcHk580h8
         bxRmoM4LPfDR/EJwx+fA3D2wHVdVmkwPRLLl+gdCHcWjy1Jt5XwTSv0yBC+L9QK/TfRM
         mnD8YdBzRp6q8MYROO5ttHF1icj33+aM/TLwtsSR/rEo17WRdHo7n5tqsFszGyzaT1Ak
         WrLJx/UnJAl4L1mk/F+2muHCDPtU05yjfkuBOjVnWIk9KquDQHrazosTus2qyJOaoWU2
         uEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695062; x=1741299862;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4G+4qHSVJnaTG8aqakqnf5oS6XZxipCyWxhYCrPdMqU=;
        b=kVPs0nzAtjt8887if44giLDjlilnbDy+VOobG8ol8X9DmJP65rr8I28RfGRiFsI/Bz
         sjSezMKkP1L5GDtO1FnuZZ/vIvETdAidiB1FRbtGLjgd/4o0RU6ePjJhBy3ybaCZmXHZ
         F0VIvKjAc+iOiJos86bMuR6T5jbmGM1bX3E/SEstowmWCiyDmITjCIk4UElrYRVlBgys
         d1EU5p3rOt1KqPg77dVbgHTN9jqt/bY/f5wJT3Ecs3uJ0jrru8pS4k4OTHikHx0V4JBi
         MhSWcPOrce5SO/4RF4bZEdRAC/BNyJA1hiGJRxsWumEVSj8sANvZi07Q52u+km0ZvqBa
         XWjw==
X-Forwarded-Encrypted: i=1; AJvYcCXIFIfs+CnQ68w70GE6BJeXNfBMb/LPtyqawHKGwRoLAbadTinD1kHb9/71E478//RLZtAwgB0PNXjCBkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlBQ6zwOZr021aazvNWNa3RJ5ULYn5Eynf/caq0yoxxhF2Jzd4
	tkz5Xfh7R8I9KISrg2dxcqzBl2g0lmfcB3JXx7nqDAYiNxPV0mC6qA2w3CVMvmKvV05gHrQHHKF
	JPg==
X-Google-Smtp-Source: AGHT+IEgwwtyjm9FH0NZoHUXAAKG79/J8WSFp39HQkew/kpXx6ars2ZD8qvS6jLycvRG3qg04LFPzNBgvnI=
X-Received: from pfjd20.prod.google.com ([2002:a05:6a00:2454:b0:730:8a55:44fd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:929b:b0:732:a24:7351
 with SMTP id d2e1a72fcca58-734ac35dbbbmr1768936b3a.6.1740695062583; Thu, 27
 Feb 2025 14:24:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Feb 2025 14:24:10 -0800
In-Reply-To: <20250227222411.3490595-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227222411.3490595-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227222411.3490595-6-seanjc@google.com>
Subject: [PATCH v3 5/6] KVM: x86: Snapshot the host's DEBUGCTL after disabling IRQs
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>, rangemachine@gmail.com, 
	whanos@sergal.fun
Content-Type: text/plain; charset="UTF-8"

Snapshot the host's DEBUGCTL after disabling IRQs, as perf can toggle
debugctl bits from IRQ context, e.g. when enabling/disabling events via
smp_call_function_single().  Taking the snapshot (long) before IRQs are
disabled could result in KVM effectively clobbering DEBUGCTL due to using
a stale snapshot.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09c3d27cc01a..a2cd734beef5 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4991,7 +4991,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	/* Save host pkru register if supported */
 	vcpu->arch.host_pkru = read_pkru();
-	vcpu->arch.host_debugctl = get_debugctlmsr();
 
 	/* Apply any externally detected TSC adjustments (due to suspend) */
 	if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
@@ -10984,6 +10983,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		set_debugreg(0, 7);
 	}
 
+	vcpu->arch.host_debugctl = get_debugctlmsr();
+
 	guest_timing_enter_irqoff();
 
 	for (;;) {
-- 
2.48.1.711.g2feabab25a-goog



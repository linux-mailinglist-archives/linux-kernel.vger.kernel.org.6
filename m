Return-Path: <linux-kernel+bounces-349742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2D498FADE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCF028211C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505901D1F57;
	Thu,  3 Oct 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CE0E4BAG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815B1D1E60
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 23:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999030; cv=none; b=f/42qyvZuuh6IRRa6kTQB2dqfJOd/98KO5V+LLeHXAdaGToved+TlvIJ1HE6+7SQdfTKnyDdosy5SpZV5lg9bVP6uYL9WI7xnYzSG1/aVfrc76roie0k1oxNt4E5DTuQYzjPzxwK1cSCVHl1LEw2h8Q9n1qkwRIyehON3G9hNY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999030; c=relaxed/simple;
	bh=xhRtPkgV9Q/H720xNEs74p9Eh3oxK2vk3t5Rc0CtUR8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y+j8sqdLtJtw+GspGw8OCOvY50mk7DTGy+nISPkrFJsxf/0t10DRou4w9nViUx3FLN8AdDAkZSXe9m3pl6KQFGAVSj5bYOHKmkrFcRzznTAy+Qcq5Ykd6DFFI9nluGm3hmIWaTZ0XTmfFQTrZ70iLgguDkLJ9Pi/bxge4+1zTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CE0E4BAG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d9e31e66eeso32169727b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 16:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727999028; x=1728603828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tfyRHkNYv2lBXqcBCE/BM0O93uGXVshEfgAZDAs1C7Y=;
        b=CE0E4BAGxZ1xJ/sXqMQxPm9zFG3FezML2GR8owJPTJUy+zqpNUnfeoRFQg2oUR7qUE
         H5hrtGlPfPkn8/7lM8RKK5lqEZBqTiAQLr8Fm37Ez2sem4wb37x7ABtIXIpQrcFuh7by
         TvkTFLGZ6cQUuKQVs0U2bMPnrvDplsNOTdq2NISCE1q0BYl9ACJq7lyr5WfpSWkcxRQS
         zLHHfPyKCsBpVRYFnEOCJONXjdakPXTZMGE7Bvca7V0sI4BTELDT3HjPAhxmNj3I4vff
         IcaZCL0fvnF9Hpm4zT1YIUc0e/PVVM7oiST4Pg7UQxgChSdmk0cvzbwG9ksYA7TMBUAt
         B++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727999028; x=1728603828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tfyRHkNYv2lBXqcBCE/BM0O93uGXVshEfgAZDAs1C7Y=;
        b=PxWAjb7h4osxLSKzS94HeORY7rTKqkhovNp0DMqBjJtF5/XQzCt4AmNJzXYSz0H1Kn
         nNKi1yzwgIMf4eW+kwWaTIgDRq4A8+Q5QX2CcUvVLWSq9v2JcJ2uy2sbTpTsvKWxC2ZQ
         kcqQhG/FaMh2Sq/zqeFue3W9NScGjHm3d/sYZjNAyIg3apqfVxgGC0Wgbi+qQ7MpRsGl
         WZ8+yd8BiuGjSdnaBOtGSjBFogmXusSUaf8PnCt03DyZGj4X23XRyP9So3WJ01NmUwHP
         qip8CTsiuE2XtQsR8yIQfeAI5cpyUE+oBAbdwSMfJAxzeBZ7fE/spFNF/t0U0CE+RYhv
         xhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFP9U1OFZHW+PjwkT4k1lr3KebY1RWfYd5xkRlteUFkPMmsyFZbxxvgiYUQIYkH98XSqMRo+DF/4/H89U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lR7kYcvV/wvrTdFzOIBZi+9uROhUF4nS7Lbeg9MKwGpROTG4
	HEYzd8CufxgwqdK8+uOR+jh+wywkgEHp3QFWZkR0HsxTI7pcaeifZDazXTc9jgQQuYWmIH/80Zf
	BnA==
X-Google-Smtp-Source: AGHT+IGfWN/im2Wj2GcFD7QkzpCS0bnI6+78rBQmlk913hbGcIabj1x9PvHCC5Bd0/hV07nZoZuOXxqSaCA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:ecd:b0:6e2:a129:161a with SMTP id
 00721157ae682-6e2c6fbefb5mr202067b3.2.1727999028278; Thu, 03 Oct 2024
 16:43:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  3 Oct 2024 16:43:30 -0700
In-Reply-To: <20241003234337.273364-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241003234337.273364-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241003234337.273364-5-seanjc@google.com>
Subject: [PATCH 04/11] KVM: selftests: Rework OSXSAVE CR4=>CPUID test to play
 nice with AVX insns
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Rework the CR4/CPUID sync test to clear CR4.OSXSAVE, do CPUID, and restore
CR4.OSXSAVE in assembly, so that there is zero chance of AVX instructions
being executed while CR4.OSXSAVE is disabled.  This will allow enabling
CR4.OSXSAVE by default for selftests vCPUs as a general means of playing
nice with AVX instructions.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../kvm/x86_64/cr4_cpuid_sync_test.c          | 46 +++++++++++++------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 624dc725e14d..da818afb7031 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -19,15 +19,14 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-static inline bool cr4_cpuid_is_sync(void)
-{
-	uint64_t cr4 = get_cr4();
-
-	return (this_cpu_has(X86_FEATURE_OSXSAVE) == !!(cr4 & X86_CR4_OSXSAVE));
-}
+#define MAGIC_HYPERCALL_PORT	0x80
 
 static void guest_code(void)
 {
+	u32 regs[4] = {
+		[KVM_CPUID_EAX] = X86_FEATURE_OSXSAVE.function,
+		[KVM_CPUID_ECX] = X86_FEATURE_OSXSAVE.index,
+	};
 	uint64_t cr4;
 
 	/* turn on CR4.OSXSAVE */
@@ -36,13 +35,29 @@ static void guest_code(void)
 	set_cr4(cr4);
 
 	/* verify CR4.OSXSAVE == CPUID.OSXSAVE */
-	GUEST_ASSERT(cr4_cpuid_is_sync());
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
 
-	/* notify hypervisor to change CR4 */
-	GUEST_SYNC(0);
+	/*
+	 * Notify hypervisor to clear CR4.0SXSAVE, do CPUID and save output,
+	 * and then restore CR4.  Do this all in  assembly to ensure no AVX
+	 * instructions are executed while OSXSAVE=0.
+	 */
+	asm volatile (
+		"out %%al, $" __stringify(MAGIC_HYPERCALL_PORT) "\n\t"
+		"cpuid\n\t"
+		"mov %%rdi, %%cr4\n\t"
+		: "+a" (regs[KVM_CPUID_EAX]),
+		  "=b" (regs[KVM_CPUID_EBX]),
+		  "+c" (regs[KVM_CPUID_ECX]),
+		  "=d" (regs[KVM_CPUID_EDX])
+		: "D" (get_cr4())
+	);
 
-	/* check again */
-	GUEST_ASSERT(cr4_cpuid_is_sync());
+	/* Verify KVM cleared OSXSAVE in CPUID when it was cleared in CR4. */
+	GUEST_ASSERT(!(regs[X86_FEATURE_OSXSAVE.reg] & BIT(X86_FEATURE_OSXSAVE.bit)));
+
+	/* Verify restoring CR4 also restored OSXSAVE in CPUID. */
+	GUEST_ASSERT(this_cpu_has(X86_FEATURE_OSXSAVE));
 
 	GUEST_DONE();
 }
@@ -62,13 +77,16 @@ int main(int argc, char *argv[])
 		vcpu_run(vcpu);
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 
-		switch (get_ucall(vcpu, &uc)) {
-		case UCALL_SYNC:
+		if (vcpu->run->io.port == MAGIC_HYPERCALL_PORT &&
+		    vcpu->run->io.direction == KVM_EXIT_IO_OUT) {
 			/* emulate hypervisor clearing CR4.OSXSAVE */
 			vcpu_sregs_get(vcpu, &sregs);
 			sregs.cr4 &= ~X86_CR4_OSXSAVE;
 			vcpu_sregs_set(vcpu, &sregs);
-			break;
+			continue;
+		}
+
+		switch (get_ucall(vcpu, &uc)) {
 		case UCALL_ABORT:
 			REPORT_GUEST_ASSERT(uc);
 			break;
-- 
2.47.0.rc0.187.ge670bccf7e-goog



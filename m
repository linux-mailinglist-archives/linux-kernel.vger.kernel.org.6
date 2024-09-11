Return-Path: <linux-kernel+bounces-325605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE810975BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42921F22387
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC661BD504;
	Wed, 11 Sep 2024 20:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MtGCBl3Z"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0EB1BD034
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726087357; cv=none; b=Vdmtdxf5d0uzzmDErBvuaViHYqItlvqm957eJE30XY9RiPKE2U755OiQ89l0fWKaDXLpzIys51jXJ/ts4UeMpnrPYSBqU7d6+S8zJezf7WjlyYmGB94Axp0bYt4EzT7vJhco7HRclxb6oZzzejk4+3CkmPkxxNAqg6iUYye6dto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726087357; c=relaxed/simple;
	bh=9BzyYeYR+XG9DqVDsSkYPxqvMFHUbhRYSHXP8tVaSKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GrRf2c/Vj1yO49QsCFGpQObdexZWpVmuSqEhJcqSv7lhT+XvvUIeAXBqbBQv8QNPAhG+o2CNt3yzMHPqaz4s8Qj6wW4ABJV0AGLdCCFjiTPSI8a8i/uy2XSKrDTWbXZDAu6OXdMHlSoDIbYO3SQlFwuWqrvlb1XTbLOQRW9ZgrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MtGCBl3Z; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1d3255f852so901463276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726087355; x=1726692155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=mDeUl+tBis0dtonBgnOqcF+rjd+/029ZvfofLpY6Be0=;
        b=MtGCBl3Z6W/CVToh1/SufPs65i7e3nmvVlQOyWOYUFBtnxZlyocSMPAz/tuPnYN+wK
         0dvGMnuQ6I38g+pcBfZlG4jgCA6IXkMDHnX83SG903fdlYH2hlzJhA4gB/lXuga528bC
         6kiW2XiNpllBm7wRi5UiBA1v5EM88ssIOdSvIN9D7GvhL1m8T811T5BJqnu7H9ZhV4T3
         aEJA8/7XJYMzxp9xrGIwC5N6dxoaFQWQYHm8/H+LSUr6VrI2zKd0RCvTmBGLABBvpJmy
         oK3EV+A4LIxBdWfok3DATc20YMm6BWHrAshaqMcx5LFrj56wa3TZ3JRl4X6DIIIBLJ14
         0I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726087355; x=1726692155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDeUl+tBis0dtonBgnOqcF+rjd+/029ZvfofLpY6Be0=;
        b=Bsk6CwUjWaeRCiTAuW8SZN+v5NinVW1KBff04NK1Nhxl/a7wac5beiEUACRhXTpsmt
         qC8TtgLLVfTfTIt0GtEu5N0jxRUrXKh22zIy9gzXpYt3HzRDa1rti/uSvXKCC3DdYL18
         sLG5C7m+O0XDGv73RxhWFeWAC+k6vXVXzKLRnv8AZurvaVVgLr8sGGV0e+vydwiZVUKy
         yznKkxPQXnzdYRFiORkTqY1uNphogAnrKs/IUgW5r3SItsT+WSdt8y5t3oTMXYhz9kXp
         WzIJrp+Ivb/SJrXLgUGfTw6V7UzNb1vm4Ksd6mtbtOmEFz5e4SfMzvSpJNLMn4k5PY4w
         RJ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3r2VEuZw/6d4JlFXyQwdwYgQd+Bk5o/7MchVF69S+6psH3ai1E7UDyTIrRmV65pabpagZuB5hIl2V+10=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhu33Iqk8QMFF/eB6lEkS7YAhI8BBiM6w6UMP/pyQS9ABQnvR/
	pzhLKziIPZw8f0O0Ko0IcCQRnF6q1QezA/rVOF0tIsK51uU/ytvM1xGHhQVk33V2rXw5/s4sSwy
	ANg==
X-Google-Smtp-Source: AGHT+IGxqix6H/PLMvvIcFrC3JMaLMXEJXlPHwcg40gW3P6CGrRnyhAhRYR7DkVEhB/fpO0WlA4G6vBj/5E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:9108:0:b0:e16:4e62:8a17 with SMTP id
 3f1490d57ef6-e1d9db9ca04mr3916276.2.1726087355066; Wed, 11 Sep 2024 13:42:35
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Sep 2024 13:41:52 -0700
In-Reply-To: <20240911204158.2034295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911204158.2034295-8-seanjc@google.com>
Subject: [PATCH v2 07/13] KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Try to get/set SREGS in mmu_stress_test only when running on x86, as the
ioctls are supported only by x86 and PPC, and the latter doesn't yet
support KVM selftests.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 0b9678858b6d..847da23ec1b1 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -59,10 +59,10 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 
 static void *vcpu_worker(void *data)
 {
+	struct kvm_sregs __maybe_unused sregs;
 	struct vcpu_info *info = data;
 	struct kvm_vcpu *vcpu = info->vcpu;
 	struct kvm_vm *vm = vcpu->vm;
-	struct kvm_sregs sregs;
 
 	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
 
@@ -70,12 +70,12 @@ static void *vcpu_worker(void *data)
 
 	run_vcpu(vcpu);
 	rendezvous_with_boss();
+#ifdef __x86_64__
 	vcpu_sregs_get(vcpu, &sregs);
-#ifdef __x86_64__
 	/* Toggle CR0.WP to trigger a MMU context reset. */
 	sregs.cr0 ^= X86_CR0_WP;
-#endif
 	vcpu_sregs_set(vcpu, &sregs);
+#endif
 	rendezvous_with_boss();
 
 	run_vcpu(vcpu);
-- 
2.46.0.598.g6f2099f65c-goog



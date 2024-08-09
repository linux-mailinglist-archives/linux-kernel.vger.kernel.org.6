Return-Path: <linux-kernel+bounces-281500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FF394D78B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14492281D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBDA16B75C;
	Fri,  9 Aug 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2+mwTNZ+"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A831684BA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232627; cv=none; b=glufCrXkQ9pAu/9pT0VZJUBNfmjoaZvDhpHDIZZgz8JCqI388A3KPY8zokrFMdJFABlkisZojFV7HEJGQZ/5kg+eCczQQ5nPvtXitmXixpbQElJZ85qN+tpc+Pb5bJAqgwT+MdV9abAma0OC6qDtc8cxIJQiREgNruN/nnhyWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232627; c=relaxed/simple;
	bh=i8/Z9P+b877HKYf3foOn3WZsd81L9lIIe5UnyEoK280=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VQf0laUYwgYsdjABYtFiPzSZ1+GffaathB+U2nhHpcScY9UTpvuFac9CMmNIBryZOMZxl17+dbogTldvhEXEuoEWAIXxu82CC4T2GJ1SAPKQ7xMVaZisprnP/H43ryULUYldHMHE6XixX1nl153aNPTnBwR45voSaSfFF0MSn1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2+mwTNZ+; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2cb5594a9f3so2735499a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232625; x=1723837425; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhbtdXG7GxIZJlUwxv6/PwIOZfF88Cf7tN+DbOKZy1o=;
        b=2+mwTNZ+PaQ22lVNLKw4Jx9yQ9nbPlrzD0GvqMLNbAJH+jPnGWDPgdyTRr3GNDIHUt
         vjAmVRB3ZE9KMFwZ81pKpHzIodwGcckOLyja9jacLw+Mq94dED4USn1ZNHz1uY8DpOZo
         79Gm5nrinALn9DsjNSu+G+2/5y2jfixyD2z+ACQzrJwWL1VpDEFdhVRFjTUlVhDv9Jdi
         FCFDX4jVuPhDDwtZWG36dgr6WV9tDkbZTKczflJBH3QVFlvXbRQFkHW9P7a5Jjq5Kp08
         mJoihL6PEwLRpNWFKMI6QfKqkyz8JjrYtc3typ3EN1hW5HrIWQ8u2y0wCi84JuItigKh
         G1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232625; x=1723837425;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhbtdXG7GxIZJlUwxv6/PwIOZfF88Cf7tN+DbOKZy1o=;
        b=RsN76qCjQ9EYyPULcVNf721J7vxTWVOqtWf6WmxL97mYaxXIJfahOZfRdw6ENU2ph2
         9GAmk3UvkC4kDjYji5uMW4H8xddS1XYJkLsIH8DWAAfg+QEXnEgVEFZwq9SsXtsh7kqP
         1ymxFpWHh2SBA5OrNuSin7CwiYySgJKzvX+lWrd9JjfHuZv/CmoMlfHdgA4ST+PSJ24N
         E8U+Yv8WvdVz8ogKNhCxqveQqtvh22CIQvONuOvm7u21W1sWaZcmq6xaJdm1kWuyHWgf
         mfxh0m48Rts/Rs90qqbsPBsZWie9PgSbZclDYQjdj0L9Tiov7iR8ZZSPbrIhGIFXGtHP
         oaUA==
X-Forwarded-Encrypted: i=1; AJvYcCVDOpRSVTfJ+uLoC5Vb7IjLttitArzTr0zpHBaLQQIxbLHcKH08aWu3hPbUPrqv2nigk3w7lBLUPwe+m4R4dWe94PK10/GdX6bODi/a
X-Gm-Message-State: AOJu0YxDvsdyVH/Tw0AKMXjVikcfdNHh55MNLa3kl2btUa1aYuCgIb8v
	5eni2d/tXd0xc6WFvDylMTcpKgPSp0fqd6cVKWwgZOtOlvIrSTDot3JtiTRWCLs+RlVJtMPPZrF
	Nlw==
X-Google-Smtp-Source: AGHT+IEJSGntFoEairVQfIondbRS/wPjqzJ9gWC9vEesMP0+8PhPR1ut4xtIPVXbgE0J+qJ9SIwm32dkTPA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:f81:b0:2c9:81a2:e8e4 with SMTP id
 98e67ed59e1d1-2d1e80605e9mr5545a91.5.1723232625089; Fri, 09 Aug 2024 12:43:45
 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:15 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-4-seanjc@google.com>
Subject: [PATCH 03/22] KVM: selftests: Only muck with SREGS on x86 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
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
2.46.0.76.ge559c4bf1a-goog



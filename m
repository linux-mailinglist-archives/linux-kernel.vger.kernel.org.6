Return-Path: <linux-kernel+bounces-273074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0044E94644E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745481F2289B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4103654652;
	Fri,  2 Aug 2024 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQIG0KjY"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BC033DF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722630086; cv=none; b=VogFaOjfCbB4hcwi0b/ldRZ+puBl0jO+JrOS+DOVM7fDnlKXGlYEps0aOHEoggb51Mka256IiTxWTB1zG+nlAhaEHp+ni6vuOJ9CEl+yevxJ6qkXo08MC4mb3a0qcXpCB6FfYrWuGkgTfE4Stz/PUS0ttS2VIs2v5Ns4ngSZqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722630086; c=relaxed/simple;
	bh=k3/t2Q1agwZ0l4VOh1yi6PwF8hdZItVhHkNDBShV5kA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CMuUT1N+d7o3d7gYpqoRaVFcwXY7w9bJvULiroSvw6GxqUHOVH0YHwKjwzSBgtJtGFZ20aq/AyCmexCoTcXZvkD1dS00v98gldsTm5/y11rkzTdZkFF8+J/LUd37zhKxv5Hh7oBHrcmWjoFel1Ez2JaDICO7OAkD2KsMHxW12L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gQIG0KjY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0bcd04741fso4668329276.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 13:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722630084; x=1723234884; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSbtzjQvQpAq1eRxKfGE8sitFVHQ69Ko3fhczaBymYk=;
        b=gQIG0KjY+G2BPF+zshS8BOlFSArITZgrryAHW4z+3cvf4ojbiTvVxni9Wai1UioXGr
         PS9z/CNtuyee6x6xhKemg2/RhLaP+3tJ5LhSzuKk7aHK9CU/YDErLtquwFMwBKvU5GOF
         516Cx2K/X8q/2wCxYNrM16G2wx1CWzfa1F5Hhx1oNUVDJHyiOzB9351pNHHmyJ5Kl+fJ
         UBzLDX6Dam9RVsHaxaE7s2Otsn2vwiZUnIwI8juljWlK9HWgD/RoY/Zb+pLkFSSz/oaY
         t3dsYs5hO7ySjY1LGpf70s6WKAwEeTwRbJQUdyIj+tcv23KA96FLidiBStRI7AbY3hDR
         KVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722630084; x=1723234884;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wSbtzjQvQpAq1eRxKfGE8sitFVHQ69Ko3fhczaBymYk=;
        b=Vpyb1Mh8MhfFbDcjkYjHR4sY8dqHxM+M4Q+71Gt0IdPCYSsP7WT5sVYWhHNMKkVlwk
         /BVESWv79bvebZQ9if5oAnGzvKHNuoODtQFBBZ3ds+o0MShy8UcBsww6aCxo/ClwuYkA
         FqLJOPhyiFBla1zO2sJYg1+PlXnKWcfei3IR/8ovjXBN+ciJ0ic1R0KEP5LXoI8t0Co2
         yO8MgXVgjhfOp9/nsTZUfFrKviyiMZNREyMYSkWBpB/nRytOZnwOscM3GKA1ZgNPvJqN
         ZH4JjIkqJtkt+jL2IIA/yGKpZM911xLO/17S1mANtGujPSGPtCuT14IYnJWDfCxHM8Vn
         I0ng==
X-Forwarded-Encrypted: i=1; AJvYcCVWUCpSSWeBaD2LF5bkf8wU0PevI7xdxZmorMvMqal4fu2mXqDyzjW6aUwHR4DddirZqWCtecpiHCwxqJPwvviFxH8VZPflMk0QZ+/Y
X-Gm-Message-State: AOJu0YyHz2+LZoh+H3bX+00cj8wTcm/LuShCutbt2jLiR0bv/qFHRjBs
	NZfz/CWQxCZ0fcGTVvo/XIYuoVLgcG4Mvf9a38OiLOHX/47j5SzH4oon8Ee8sS2pKJ4Xy8beR1W
	2Gw==
X-Google-Smtp-Source: AGHT+IGDiO151ypnhn4EaGGcDBfUrjdXSX4S344OxLk9bmjlh1hIj5LlSBITxT0ie316eWk6q2RSjw89xfs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:2b8b:b0:e0b:d729:ff8d with SMTP id
 3f1490d57ef6-e0bde21e302mr297332276.5.1722630083866; Fri, 02 Aug 2024
 13:21:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  2 Aug 2024 13:21:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240802202121.341348-1-seanjc@google.com>
Subject: [PATCH] KVM: Rework core loop of kvm_vcpu_on_spin() to use a single for-loop
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Rework kvm_vcpu_on_spin() to use a single for-loop instead of making "two"
passes over all vCPUs.  Given N=kvm->last_boosted_vcpu, the logic is to
iterate from vCPU[N+1]..vcpu[N-1], i.e. using two loops is just a kludgy
way of handling the wrap from the last vCPU to vCPU0 when a boostable vCPU
isn't found in vcpu[N+1]..vcpu[MAX].

Open code the xa_load() instead of using kvm_get_vcpu() to avoid reading
online_vcpus in every loop, as well as the accompanying smp_rmb(), i.e.
make it a custom kvm_for_each_vcpu(), for all intents and purposes.

Oppurtunistically clean up the comment explaining the logic.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 100 +++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 44 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index d0788d0a72cc..f357bec57d08 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4029,59 +4029,71 @@ bool __weak kvm_arch_dy_has_pending_interrupt(struct kvm_vcpu *vcpu)
 
 void kvm_vcpu_on_spin(struct kvm_vcpu *me, bool yield_to_kernel_mode)
 {
+	int nr_vcpus, start, i, idx, yielded;
 	struct kvm *kvm = me->kvm;
 	struct kvm_vcpu *vcpu;
-	int last_boosted_vcpu;
-	unsigned long i;
-	int yielded = 0;
 	int try = 3;
-	int pass;
 
-	last_boosted_vcpu = READ_ONCE(kvm->last_boosted_vcpu);
+	nr_vcpus = atomic_read(&kvm->online_vcpus);
+	if (nr_vcpus < 2)
+		return;
+
+	/* Pairs with the smp_wmb() in kvm_vm_ioctl_create_vcpu(). */
+	smp_rmb();
+
 	kvm_vcpu_set_in_spin_loop(me, true);
+
 	/*
-	 * We boost the priority of a VCPU that is runnable but not
-	 * currently running, because it got preempted by something
-	 * else and called schedule in __vcpu_run.  Hopefully that
-	 * VCPU is holding the lock that we need and will release it.
-	 * We approximate round-robin by starting at the last boosted VCPU.
+	 * The current vCPU ("me") is spinning in kernel mode, i.e. is likely
+	 * waiting for a resource to become available.  Attempt to yield to a
+	 * vCPU that is runnable, but not currently running, e.g. because the
+	 * vCPU was preempted by a higher priority task.  With luck, the vCPU
+	 * that was preempted is holding a lock or some other resource that the
+	 * current vCPU is waiting to acquire, and yielding to the other vCPU
+	 * will allow it to make forward progress and release the lock (or kick
+	 * the spinning vCPU, etc).
+	 *
+	 * Since KVM has no insight into what exactly the guest is doing,
+	 * approximate a round-robin selection by iterating over all vCPUs,
+	 * starting at the last boosted vCPU.  I.e. if N=kvm->last_boosted_vcpu,
+	 * iterate over vCPU[N+1]..vCPU[N-1], wrapping as needed.
+	 *
+	 * Note, this is inherently racy, e.g. if multiple vCPUs are spinning,
+	 * they may all try to yield to the same vCPU(s).  But as above, this
+	 * is all best effort due to KVM's lack of visibility into the guest.
 	 */
-	for (pass = 0; pass < 2 && !yielded && try; pass++) {
-		kvm_for_each_vcpu(i, vcpu, kvm) {
-			if (!pass && i <= last_boosted_vcpu) {
-				i = last_boosted_vcpu;
-				continue;
-			} else if (pass && i > last_boosted_vcpu)
-				break;
-			if (!READ_ONCE(vcpu->ready))
-				continue;
-			if (vcpu == me)
-				continue;
-			if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
-				continue;
+	start = READ_ONCE(kvm->last_boosted_vcpu) + 1;
+	for (i = 0; i < nr_vcpus; i++) {
+		idx = (start + i) % nr_vcpus;
+		if (idx == me->vcpu_idx)
+			continue;
 
-			/*
-			 * Treat the target vCPU as being in-kernel if it has a
-			 * pending interrupt, as the vCPU trying to yield may
-			 * be spinning waiting on IPI delivery, i.e. the target
-			 * vCPU is in-kernel for the purposes of directed yield.
-			 */
-			if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
-			    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
-			    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
-				continue;
-			if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
-				continue;
+		vcpu = xa_load(&kvm->vcpu_array, idx);
+		if (!READ_ONCE(vcpu->ready))
+			continue;
+		if (kvm_vcpu_is_blocking(vcpu) && !vcpu_dy_runnable(vcpu))
+			continue;
 
-			yielded = kvm_vcpu_yield_to(vcpu);
-			if (yielded > 0) {
-				WRITE_ONCE(kvm->last_boosted_vcpu, i);
-				break;
-			} else if (yielded < 0) {
-				try--;
-				if (!try)
-					break;
-			}
+		/*
+		 * Treat the target vCPU as being in-kernel if it has a pending
+		 * interrupt, as the vCPU trying to yield may be spinning
+		 * waiting on IPI delivery, i.e. the target vCPU is in-kernel
+		 * for the purposes of directed yield.
+		 */
+		if (READ_ONCE(vcpu->preempted) && yield_to_kernel_mode &&
+		    !kvm_arch_dy_has_pending_interrupt(vcpu) &&
+		    !kvm_arch_vcpu_preempted_in_kernel(vcpu))
+			continue;
+
+		if (!kvm_vcpu_eligible_for_directed_yield(vcpu))
+			continue;
+
+		yielded = kvm_vcpu_yield_to(vcpu);
+		if (yielded > 0) {
+			WRITE_ONCE(kvm->last_boosted_vcpu, i);
+			break;
+		} else if (yielded < 0 && !--try) {
+			break;
 		}
 	}
 	kvm_vcpu_set_in_spin_loop(me, false);

base-commit: 332d2c1d713e232e163386c35a3ba0c1b90df83f
-- 
2.46.0.rc2.264.g509ed76dc8-goog



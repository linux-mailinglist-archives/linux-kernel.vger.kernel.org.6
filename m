Return-Path: <linux-kernel+bounces-281507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D0894D798
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 21:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FEC1F25126
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F71198850;
	Fri,  9 Aug 2024 19:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gU6jeuVi"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7A193069
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 19:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232639; cv=none; b=OycwKFXedDVk6yYnkDd/pthYBWA8T7WESKz6PN6razokj7C50u3yjar/cexLM/dlRv8W03AM27EYk1PlAFNnW3g4UtMwbad5VaeeKSAy0sHSYy+pLVKQbjw+pSMRjhEWGxbwQtqx7sW3eKgjbnVU0nhyTlkBBKieiqc8sWc+pjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232639; c=relaxed/simple;
	bh=WbIw5XKazA4cY8kYGA63IriSB3FyI1oMjErI9b0li8o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UxSKzQy+1u/cEn5nL71PmJtwp5Exqn85SwZP/z/h4m0JTOTIErUbRCrvshxZsRwMi2s9uJoasXz1QY3z9cUXpN6IZryrsmOofJBpnU5lzu9ttd5InYMvbg3msawMz6OysYNh17KLgfcYNHgndSnmEGhGbAxblpGx4jj0gpWYaAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gU6jeuVi; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6902dc6d3ffso59920447b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 12:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723232636; x=1723837436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LA7LUE9c83FojgXGi3HkbRYYkaUFQd5wswdwV1F5jBI=;
        b=gU6jeuViOpEtFfoHDpTbdPptIImL9ZovcOCdszkOZsjx27gvFGSMuOaL1Nk4YRFdaW
         TBPjZo61b9A+tImg6G/19nlAI4Y1aXROj4xy04zWKcd7oKoqDVNUgVZ91wHiuLaoX3CX
         SET3qiE3+UqPd2JHDY8NxwAX2PEW2H8NjsqjPt8UWDCtXyL6EYu7EDlxQDL6UL2dWi7F
         ahB22lv6mIat8iSud9GoKZjbEsJEqBOfVhiY71XVAICbCw+u0u2Mh5vo8qkvNwPM0YdM
         lMcUBkQTSmFmBN6Toq8hGr2VFtCdcToPGgOwr4KQ5HiS9lRRHGsnlsISb1W/HihqFq2z
         c/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232636; x=1723837436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LA7LUE9c83FojgXGi3HkbRYYkaUFQd5wswdwV1F5jBI=;
        b=pKSo77ltlBTT7fnkoGeYeM+5hsjaLFvovu1oQHO55xMebTLfEMKzvZaloTahvJ8sej
         of+0GrShghq3gnyRccjfPmkWVQAaOW8JjG7Nx88RKc2Yz6OrGRaK1MyTQZG2R0X1anha
         2sdogYbQpD9O9tC5pF0NNLv2R5/HUuVwhhCiKW2XI0BAH/vfhSFMZiB/MYJLjtxTQ/Xi
         xNWhbs7dRN3S1yO9AC8XuywpXhtxqg4mR/Ah4qZYWM2pN6ZAX8MRQarCnu0gyhvnG/nr
         SS2L39x5ha72FcKLWoAAyvw2c4jQ/X/hFYFcF/h4UUtdNxD9vq/TWZpksbq7N/CxIfL3
         hbGw==
X-Forwarded-Encrypted: i=1; AJvYcCUCtynn7ycdViqNUfdXQt7KSXo9qq3mnl3TtnKGxuyIlWHR87tHypee0xDjwDj8H7zPWZjMGZIbx49QBFrASk2Mvm/Xy7zUoosw7PGR
X-Gm-Message-State: AOJu0YwjbbNN8EoCbYsyuhr+SeFEEz7W2vK0VU8M1u7yi9wk2k589ZIB
	eZCNW8rQPR8KMj5Nh6JGU2atavm2ptxC32Z0KMhW7p0x0F4bRyLvGSBjDBCiKW42hvyKGlLHrCf
	IsQ==
X-Google-Smtp-Source: AGHT+IHdm1tAiwdHoiER1evk1B2BVo/sVRdO+cs/X5rKSY/fp4P6+azgk/JjvaFk5hFSNW8l0gSAdoLXOSY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:f084:0:b0:697:9aae:1490 with SMTP id
 00721157ae682-69ec4a1937dmr228707b3.1.1723232636462; Fri, 09 Aug 2024
 12:43:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Aug 2024 12:43:21 -0700
In-Reply-To: <20240809194335.1726916-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240809194335.1726916-1-seanjc@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809194335.1726916-10-seanjc@google.com>
Subject: [PATCH 09/22] KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two phases to mmu_stress_test to verify that KVM correctly handles
guest memory that was writable, and then made read-only in the primary MMU,
and then made writable again.

Add bonus coverage for x86 to verify that all of guest memory was marked
read-only.  Making forward progress (without making memory writable)
requires arch specific code to skip over the faulting instruction, but the
test can at least verify each vCPU's starting page was made read-only.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 87 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 50c3a17418c4..98f9a4660269 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -16,6 +16,8 @@
 #include "guest_modes.h"
 #include "processor.h"
 
+static bool mprotect_ro_done;
+
 static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
 	uint64_t gpa;
@@ -31,6 +33,33 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 		*((volatile uint64_t *)gpa);
 	GUEST_SYNC(2);
 
+	/*
+	 * Write to the region while mprotect(PROT_READ) is underway.  Keep
+	 * looping until the memory is guaranteed to be read-only, otherwise
+	 * vCPUs may complete their writes and advance to the next stage
+	 * prematurely.
+	 */
+	do {
+		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+#ifdef __x86_64__
+			asm volatile(".byte 0xc6,0x40,0x0,0x0" :: "a" (gpa) : "memory");
+#else
+			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
+#endif
+	} while (!READ_ONCE(mprotect_ro_done));
+
+	/*
+	 * Only x86 can explicitly sync, as other architectures will be stuck
+	 * on the write fault.
+	 */
+#ifdef __x86_64__
+	GUEST_SYNC(3);
+#endif
+
+	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+		vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
+	GUEST_SYNC(4);
+
 	GUEST_ASSERT(0);
 }
 
@@ -78,6 +107,7 @@ static void *vcpu_worker(void *data)
 	struct vcpu_info *info = data;
 	struct kvm_vcpu *vcpu = info->vcpu;
 	struct kvm_vm *vm = vcpu->vm;
+	int r;
 
 	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
 
@@ -100,6 +130,49 @@ static void *vcpu_worker(void *data)
 
 	/* Stage 2, read all of guest memory, which is now read-only. */
 	run_vcpu(vcpu, 2);
+
+	/*
+	 * Stage 3, write guest memory and verify KVM returns -EFAULT for once
+	 * the mprotect(PROT_READ) lands.  Only architectures that support
+	 * validating *all* of guest memory sync for this stage, as vCPUs will
+	 * be stuck on the faulting instruction for other architectures.  Go to
+	 * stage 3 without a rendezvous
+	 */
+	do {
+		r = _vcpu_run(vcpu);
+	} while (!r);
+	TEST_ASSERT(r == -1 && errno == EFAULT,
+		    "Expected EFAULT on write to RO memory, got r = %d, errno = %d", r, errno);
+
+#ifdef __x86_64__
+	/*
+	 * Verify *all* writes from the guest hit EFAULT due to the VMA now
+	 * being read-only.  x86-only at this time as skipping the instruction
+	 * that hits the EFAULT requires advancing the program counter, which
+	 * is arch specific and currently relies on hand-coded assembly.
+	 */
+	vcpu->run->kvm_valid_regs = KVM_SYNC_X86_REGS;
+	for (;;) {
+		r = _vcpu_run(vcpu);
+		if (!r)
+			break;
+		TEST_ASSERT_EQ(errno, EFAULT);
+		WRITE_ONCE(vcpu->run->kvm_dirty_regs, KVM_SYNC_X86_REGS);
+		vcpu->run->s.regs.regs.rip += 4;
+	}
+	assert_sync_stage(vcpu, 3);
+#endif
+	rendezvous_with_boss();
+
+	/*
+	 * Stage 4.  Run to completion, waiting for mprotect(PROT_WRITE) to
+	 * make the memory writable again.
+	 */
+	do {
+		r = _vcpu_run(vcpu);
+	} while (r && errno == EFAULT);
+	TEST_ASSERT_EQ(r, 0);
+	assert_sync_stage(vcpu, 4);
 	rendezvous_with_boss();
 
 	return NULL;
@@ -182,7 +255,7 @@ int main(int argc, char *argv[])
 	const uint64_t start_gpa = SZ_4G;
 	const int first_slot = 1;
 
-	struct timespec time_start, time_run1, time_reset, time_run2, time_ro;
+	struct timespec time_start, time_run1, time_reset, time_run2, time_ro, time_rw;
 	uint64_t max_gpa, gpa, slot_size, max_mem, i;
 	int max_slots, slot, opt, fd;
 	bool hugepages = false;
@@ -287,19 +360,27 @@ int main(int argc, char *argv[])
 	rendezvous_with_vcpus(&time_run2, "run 2");
 
 	mprotect(mem, slot_size, PROT_READ);
+	usleep(10);
+	mprotect_ro_done = true;
+	sync_global_to_guest(vm, mprotect_ro_done);
+
 	rendezvous_with_vcpus(&time_ro, "mprotect RO");
+	mprotect(mem, slot_size, PROT_READ | PROT_WRITE);
+	rendezvous_with_vcpus(&time_rw, "mprotect RW");
 
+	time_rw    = timespec_sub(time_rw,     time_ro);
 	time_ro    = timespec_sub(time_ro,     time_run2);
 	time_run2  = timespec_sub(time_run2,   time_reset);
 	time_reset = timespec_sub(time_reset,  time_run1);
 	time_run1  = timespec_sub(time_run1,   time_start);
 
 	pr_info("run1 = %ld.%.9lds, reset = %ld.%.9lds, run2 = %ld.%.9lds, "
-		"ro = %ld.%.9lds\n",
+		"ro = %ld.%.9lds, rw = %ld.%.9lds\n",
 		time_run1.tv_sec, time_run1.tv_nsec,
 		time_reset.tv_sec, time_reset.tv_nsec,
 		time_run2.tv_sec, time_run2.tv_nsec,
-		time_ro.tv_sec, time_ro.tv_nsec);
+		time_ro.tv_sec, time_ro.tv_nsec,
+		time_rw.tv_sec, time_rw.tv_nsec);
 
 	/*
 	 * Delete even numbered slots (arbitrary) and unmap the first half of
-- 
2.46.0.76.ge559c4bf1a-goog



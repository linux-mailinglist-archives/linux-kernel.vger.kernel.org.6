Return-Path: <linux-kernel+bounces-357397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB809970D2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C68282F06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5805B206062;
	Wed,  9 Oct 2024 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lOOuUpio"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD7205E33
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489027; cv=none; b=KUTsU/P6VJ5KKzeUESoiBE0L0ApvElYaBNWddslYvnPROk4MnfQDHljJjqjWil08iYUugX3OShtzz2Kx3JPT19jTd9VPM5srr64vD6f+tfn8y2o2PjMk6sozpV3uzPlPF8F/kbqxv2W95m8tazA9DPhxHfuOcEFKTRkl8m4L4Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489027; c=relaxed/simple;
	bh=mY+b3Elc5MdSudJ5jMgcrdjdRtDcgJfJ1HtYD0SpHWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b3hBRX5ILlnKdMQ0cba/y7TxQTkQf7fkYCgPQmta1ZaiMWz6NPei2FnZ4RQIPJC3rnFBuCeJrftwqNfR3KGFkSgwa5q5l83HRaWUOYuF6XTQvRlyjtSmSWOwpVfXj98SCaaGGEUnLAtQ5H/ed4i4WVjs7DCZ4a7BTIpd1MsLC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOOuUpio; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20c61e4b890so14625405ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728489025; x=1729093825; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pdirxHCOZgZcScGJrji1f7MunRQ6Bg++3PkXMCIJLoA=;
        b=lOOuUpio2s6VhAEzmu5WisaBkuwwK4BsTXLQ0olhKvX1udM0w44/X002nQObplp8Di
         NCwNW3xXOwe/7za4IjQWLXgRqAUKncYst56DmlARYPWJutEwUfsijimRQcxFlji6ivWR
         XYN5Yy3iBLBjsUWREAgPr4uXzpBNgfP+sgaoL+jzkJZ6ci+/Qgs7NSKEdQ542v8+odlx
         MTZz3Fnw5/azYupC8k96MbAGEiec3veEMFge+c9OKmg/P9w4dtLMc/lfIijMjnYiQRA0
         vNwEZ65LMdQxaa4dmlA66VUxWerr1LtHDyKQqNEFEbFE5Res6wdSHdlk1dHY/l53c5AY
         Ipfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489025; x=1729093825;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdirxHCOZgZcScGJrji1f7MunRQ6Bg++3PkXMCIJLoA=;
        b=CPxrMOHhXV965nqrJ/2Z9ldQse1GM8gjYCKhkw+Ree+Tizag1lv2Sf3pIesSGHhXK3
         DvTjhXQxCZBumOqMjqmz2d1iJYZ2sxcMhBpzhdsWxmOdAbV+X+RqDC8Vaz/wMy5HEw2m
         dBj+BKzd1bH6EmLyB2o8xFY7RmcIJEuuOc0vd0XmF79aklT1AYVHBhfdK2QXdO2tmDo2
         7wwczUN7c6xoonAJxHY835D2BR20D49pSzjFXJ4R4UenhQQpp5oQb6XuYtp0dwV9nOHH
         zbev32fNW2T/CrYuCOaiiEqheZDhwNqtUrtbNLwUnfzdW2wlX1h5/X0jkutgY/5gyDSP
         NXKA==
X-Forwarded-Encrypted: i=1; AJvYcCWzONEGEMP3nXFyLB16EyhNPdjWSPVzMF0GXjQDNH6SPVQYTC9XTQILQfseI5DAp5okgWpl/bZ04+KBles=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQh2N+XImIHup0MCWH1vpmuLl7bFm193pPyfmWwrvyCJjjv7Kb
	2+oO9QH+GQd0xKBndKaHXXIKsn20BvP0zY3f3jWQaf7X/dGlNZZd+n2/DTsuq+lenBwF+tzRhU0
	MSQ==
X-Google-Smtp-Source: AGHT+IF06EOvabba1YpY/m+9TdddfKJv+phXMs6xFxlGn64HlbjifXqL0d0/QpkP5vVUJng9o1/hHhmQcTE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2c2:b0:20b:ad74:c83d with SMTP id
 d9443c01a7336-20c6377b2e8mr457555ad.8.1728489024593; Wed, 09 Oct 2024
 08:50:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  9 Oct 2024 08:49:53 -0700
In-Reply-To: <20241009154953.1073471-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009154953.1073471-1-seanjc@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009154953.1073471-15-seanjc@google.com>
Subject: [PATCH v3 14/14] KVM: selftests: Verify KVM correctly handles mprotect(PROT_READ)
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

Add two phases to mmu_stress_test to verify that KVM correctly handles
guest memory that was writable, and then made read-only in the primary MMU,
and then made writable again.

Add bonus coverage for x86 and arm64 to verify that all of guest memory was
marked read-only.  Making forward progress (without making memory writable)
requires arch specific code to skip over the faulting instruction, but the
test can at least verify each vCPU's starting page was made read-only for
other architectures.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 104 +++++++++++++++++-
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index 0918fade9267..d9c76b4c0d88 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -17,6 +17,8 @@
 #include "processor.h"
 #include "ucall_common.h"
 
+static bool mprotect_ro_done;
+
 static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
 	uint64_t gpa;
@@ -32,6 +34,42 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 		*((volatile uint64_t *)gpa);
 	GUEST_SYNC(2);
 
+	/*
+	 * Write to the region while mprotect(PROT_READ) is underway.  Keep
+	 * looping until the memory is guaranteed to be read-only, otherwise
+	 * vCPUs may complete their writes and advance to the next stage
+	 * prematurely.
+	 *
+	 * For architectures that support skipping the faulting instruction,
+	 * generate the store via inline assembly to ensure the exact length
+	 * of the instruction is known and stable (vcpu_arch_put_guest() on
+	 * fixed-length architectures should work, but the cost of paranoia
+	 * is low in this case).  For x86, hand-code the exact opcode so that
+	 * there is no room for variability in the generated instruction.
+	 */
+	do {
+		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+#ifdef __x86_64__
+			asm volatile(".byte 0x48,0x89,0x00" :: "a"(gpa) : "memory"); /* mov %rax, (%rax) */
+#elif defined(__aarch64__)
+			asm volatile("str %0, [%0]" :: "r" (gpa) : "memory");
+#else
+			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
+#endif
+	} while (!READ_ONCE(mprotect_ro_done));
+
+	/*
+	 * Only architectures that write the entire range can explicitly sync,
+	 * as other architectures will be stuck on the write fault.
+	 */
+#if defined(__x86_64__) || defined(__aarch64__)
+	GUEST_SYNC(3);
+#endif
+
+	for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+		vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
+	GUEST_SYNC(4);
+
 	GUEST_ASSERT(0);
 }
 
@@ -79,6 +117,7 @@ static void *vcpu_worker(void *data)
 	struct vcpu_info *info = data;
 	struct kvm_vcpu *vcpu = info->vcpu;
 	struct kvm_vm *vm = vcpu->vm;
+	int r;
 
 	vcpu_args_set(vcpu, 3, info->start_gpa, info->end_gpa, vm->page_size);
 
@@ -101,6 +140,57 @@ static void *vcpu_worker(void *data)
 
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
+#if defined(__x86_64__) || defined(__aarch64__)
+	/*
+	 * Verify *all* writes from the guest hit EFAULT due to the VMA now
+	 * being read-only.  x86 and arm64 only at this time as skipping the
+	 * instruction that hits the EFAULT requires advancing the program
+	 * counter, which is arch specific and relies on inline assembly.
+	 */
+#ifdef __x86_64__
+	vcpu->run->kvm_valid_regs = KVM_SYNC_X86_REGS;
+#endif
+	for (;;) {
+		r = _vcpu_run(vcpu);
+		if (!r)
+			break;
+		TEST_ASSERT_EQ(errno, EFAULT);
+#if defined(__x86_64__)
+		WRITE_ONCE(vcpu->run->kvm_dirty_regs, KVM_SYNC_X86_REGS);
+		vcpu->run->s.regs.regs.rip += 3;
+#elif defined(__aarch64__)
+		vcpu_set_reg(vcpu, ARM64_CORE_REG(regs.pc),
+			     vcpu_get_reg(vcpu, ARM64_CORE_REG(regs.pc)) + 4);
+#endif
+
+	}
+	assert_sync_stage(vcpu, 3);
+#endif /* __x86_64__ || __aarch64__ */
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
@@ -183,7 +273,7 @@ int main(int argc, char *argv[])
 	const uint64_t start_gpa = SZ_4G;
 	const int first_slot = 1;
 
-	struct timespec time_start, time_run1, time_reset, time_run2, time_ro;
+	struct timespec time_start, time_run1, time_reset, time_run2, time_ro, time_rw;
 	uint64_t max_gpa, gpa, slot_size, max_mem, i;
 	int max_slots, slot, opt, fd;
 	bool hugepages = false;
@@ -288,19 +378,27 @@ int main(int argc, char *argv[])
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
2.47.0.rc0.187.ge670bccf7e-goog



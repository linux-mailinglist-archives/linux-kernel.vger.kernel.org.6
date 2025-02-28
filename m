Return-Path: <linux-kernel+bounces-539614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53704A4A684
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 00:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E718F7A41D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 23:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CF31DEFD4;
	Fri, 28 Feb 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jC8clZoq"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4923F372
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740784090; cv=none; b=ZMY++BCuznT0DVOQsMEMw5QOMc4NRLp4JwK1lhu73tmhqodt0dUzHbrrpMxrXPZtxyTQamOwb3eP0EA+q8ug7mm4sX5/AvoGeypHhyNiQF/iYtEfwxRVACbYEGKm6UEusPpxCNBOqW3IPLjHJvJvo9WlESALFIPZvL97j00lrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740784090; c=relaxed/simple;
	bh=uXQPt8VZsErn0hUYO9Un8NhYWkFxMXU+WNaNm+q/hLI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UpQBHFiyHpiihhC4xjlyZDn1dft4qRF1DB50P9faMpxOe5BrmlPsghFuobEF+vlJY2tci95yXDlgUNkre7Ab6s9PvOfgn5EoJ2LqSBHkuq7LreyOWYeNh1wS3b+BvY2RrmlfoQFiA8H3tkeViEMzM8zGuex8VXuebufRKO+/q6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jC8clZoq; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fe8fdfdd94so5524775a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740784088; x=1741388888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwvKvZQdOqB/riyMfQK76I4rdRV8E0Twgp+TB8ZZDcQ=;
        b=jC8clZoqVVeq81d6JFtK5whAaPGE4Z+/1D5K538uR8RM3TE+xY6HVMggpPA1s317Wr
         3fW6ahwTsq3NJ6dK+y/xDpVm++yN/f2DhIbTxs2qM9DP6sxq1qww0fGaQuUKY00I6yPy
         TX5qt1eAODPT7ElaAn2dEgsGBxeBbJihi/Ba04mIHGCE76LBwsuNXW1I+OCvHtmUkorh
         BkZ3/kpt+GbhAVRfPq+cOVn6s0tns1bOHLLkU2gLitfskW3ZHrHIpvHYfjOOTQ48jXu+
         olqTSQRobLeCQ+M8XpDR1OOBs6MmnCQE1NVRyhePjIPNvTyj9ASW1EIwjkvrwfWquNKV
         SmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740784088; x=1741388888;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwvKvZQdOqB/riyMfQK76I4rdRV8E0Twgp+TB8ZZDcQ=;
        b=uQQddqCDNZl7JfjJNxCMMatyFTBRPltxcKXtA+3dwPO38n+0crJxyFHEPjjKfDAn9w
         cQ43tobPNqzJGj/lspWplhhx9XC4Gi57X2rn9enalW8G3UB7EabiQExes3YUdRGmVEgX
         75FeOc6aBBdQIpVZthDcD00DvW58mAdBV6qzA/E4EppzQ91EOe682aY3Ho3Tkqd2O6tV
         dEZowRXQ5EHOr41E7mQ+g1N0W+St6Muru4WxxWVhtDg6kqxW3xBENQLyPm7IJ65lO7Ph
         zQlJEg6VaJ/St8ImG7Z0x6VjI4zpm5LxnO32VtJMK3+oZzvCuhXNO9iefRoAUv81NWgP
         fo5w==
X-Forwarded-Encrypted: i=1; AJvYcCW966bShel5NzHnNiClUegA1qJEUyjgz0umJ0keAzEfEG7GBBSCRgY67sbndaawq36PtKv2tEbdCVigL9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8An56wyELl9DFY2arTfBAygGtVwGeC9LQlBaUgZ/iJ3aDVNKS
	B5dNWCnqP3zw2D3ZAXARVwoNjhG85e0sBXEDb/ogsavOyrEi/5OAsl3LolLr8nBFCiVpkvswOSD
	log==
X-Google-Smtp-Source: AGHT+IHtav6I9GvJCWlXa8teiyqwYsVwxbQq5DDBFhatDJUnYOVca3VZeno9NRz5PC5d3cEGv4aaIo8yNXc=
X-Received: from pjbom7.prod.google.com ([2002:a17:90b:3a87:b0:2fa:1b0c:4150])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2247:b0:2ee:863e:9ffc
 with SMTP id 98e67ed59e1d1-2febab7a555mr7136871a91.21.1740784088699; Fri, 28
 Feb 2025 15:08:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 28 Feb 2025 15:08:04 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250228230804.3845860-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Ensure all vCPUs hit -EFAULT during initial
 RO stage
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

During the initial mprotect(RO) stage of mmu_stress_test, keep vCPUs
spinning until all vCPUs have hit -EFAULT, i.e. until all vCPUs have tried
to write to a read-only page.  If a vCPU manages to complete an entire
iteration of the loop without hitting a read-only page, *and* the vCPU
observes mprotect_ro_done before starting a second iteration, then the
vCPU will prematurely fall through to GUEST_SYNC(3) (on x86 and arm64) and
get out of sequence.

Replace the "do-while (!r)" loop around the associated _vcpu_run() with
a single invocation, as barring a KVM bug, the vCPU is guaranteed to hit
-EFAULT, and retrying on success is super confusion, hides KVM bugs, and
complicates this fix.  The do-while loop was semi-unintentionally added
specifically to fudge around a KVM x86 bug, and said bug is unhittable
without modifying the test to force x86 down the !(x86||arm64) path.

On x86, if forced emulation is enabled, vcpu_arch_put_guest() may trigger
emulation of the store to memory.  Due a (very, very) longstanding bug in
KVM x86's emulator, emulate writes to guest memory that fail during
__kvm_write_guest_page() unconditionally return KVM_EXIT_MMIO.  While that
is desirable in the !memslot case, it's wrong in this case as the failure
happens due to __copy_to_user() hitting a read-only page, not an emulated
MMIO region.

But as above, x86 only uses vcpu_arch_put_guest() if the __x86_64__ guards
are clobbered to force x86 down the common path, and of course the
unexpected MMIO is a KVM bug, i.e. *should* cause a test failure.

Reported-by: Yan Zhao <yan.y.zhao@intel.com>
Debugged-by: Yan Zhao <yan.y.zhao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/mmu_stress_test.c | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index d9c76b4c0d88..6a437d2be9fa 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -18,6 +18,7 @@
 #include "ucall_common.h"
 
 static bool mprotect_ro_done;
+static bool all_vcpus_hit_ro_fault;
 
 static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 {
@@ -36,9 +37,9 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 
 	/*
 	 * Write to the region while mprotect(PROT_READ) is underway.  Keep
-	 * looping until the memory is guaranteed to be read-only, otherwise
-	 * vCPUs may complete their writes and advance to the next stage
-	 * prematurely.
+	 * looping until the memory is guaranteed to be read-only and a fault
+	 * has occurred, otherwise vCPUs may complete their writes and advance
+	 * to the next stage prematurely.
 	 *
 	 * For architectures that support skipping the faulting instruction,
 	 * generate the store via inline assembly to ensure the exact length
@@ -56,7 +57,7 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 #else
 			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
 #endif
-	} while (!READ_ONCE(mprotect_ro_done));
+	} while (!READ_ONCE(mprotect_ro_done) || !READ_ONCE(all_vcpus_hit_ro_fault));
 
 	/*
 	 * Only architectures that write the entire range can explicitly sync,
@@ -81,6 +82,7 @@ struct vcpu_info {
 
 static int nr_vcpus;
 static atomic_t rendezvous;
+static atomic_t nr_ro_faults;
 
 static void rendezvous_with_boss(void)
 {
@@ -148,12 +150,16 @@ static void *vcpu_worker(void *data)
 	 * be stuck on the faulting instruction for other architectures.  Go to
 	 * stage 3 without a rendezvous
 	 */
-	do {
-		r = _vcpu_run(vcpu);
-	} while (!r);
+	r = _vcpu_run(vcpu);
 	TEST_ASSERT(r == -1 && errno == EFAULT,
 		    "Expected EFAULT on write to RO memory, got r = %d, errno = %d", r, errno);
 
+	atomic_inc(&nr_ro_faults);
+	if (atomic_read(&nr_ro_faults) == nr_vcpus) {
+		WRITE_ONCE(all_vcpus_hit_ro_fault, true);
+		sync_global_to_guest(vm, all_vcpus_hit_ro_fault);
+	}
+
 #if defined(__x86_64__) || defined(__aarch64__)
 	/*
 	 * Verify *all* writes from the guest hit EFAULT due to the VMA now
@@ -378,7 +384,6 @@ int main(int argc, char *argv[])
 	rendezvous_with_vcpus(&time_run2, "run 2");
 
 	mprotect(mem, slot_size, PROT_READ);
-	usleep(10);
 	mprotect_ro_done = true;
 	sync_global_to_guest(vm, mprotect_ro_done);
 

base-commit: 557953f8b75fce49dc65f9b0f7e811c060fc7860
-- 
2.48.1.711.g2feabab25a-goog



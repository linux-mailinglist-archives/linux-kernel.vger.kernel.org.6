Return-Path: <linux-kernel+bounces-537385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46642A48B36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF033A8716
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F4A271829;
	Thu, 27 Feb 2025 22:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lw+pIYNH"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DAF225775
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694685; cv=none; b=oj552YEz7hQYJ3lK/I0mMmezFoaBozoCc3NnvMHeMHCCOifeCXr9dFewkfcYZiUoSusSHdEbEY8KCXz+WIXp/buGv8YsgzsoFwkjNM/dH27hGkBZ9Ze4Fa1I58/xJVgBB+uZUKXerKVIEw+8orKP/49NaRA9UKLsWATRhXGNQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694685; c=relaxed/simple;
	bh=2n2fTiECA/mEC2r42Aamsm1tkt+M3dx+N6nVkBuGQwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fGn0mpfRcfD3fhqQx2P23D6HEfdu45iMdut0JBUEXYHY4tavfD4AorNS9w3/fHMCa9jrE6usQtUAeqRnYthDwiNmRfdTbUSD1gOF+JXaEiYsERKfCQeULr6d+mLFBc6CSCX7iQDjcLgEquBAo4FAU0+vKiVzRoBVRbsxMq6URTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lw+pIYNH; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc4fc93262so3131540a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740694683; x=1741299483; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSsPdpeGhBimYxX2APmO2De1m7wFKDQe+ScdUPoNEQ4=;
        b=lw+pIYNHOd7Qy8nYRESUX222oPmhXYws5ugX8N+cyTGy0IRxVGMtWjp+4anUUs2jDV
         ckw29PfK3gS/04CsSsoYl/KoJ2vTuyBWX0rvDG1i7pFDzwfWSMQg5Rcks6gohFmOgm1E
         v1qJN0MBb+Y71FMYCsUxti3oa2ZOYOnydYSGFBHPKEdIcMYAHWEinfNLeAEmhYEipRgd
         mL5SERsrgxlaeuLKqWNnq/frgmE5gBMXfFI4baZpKXra4cI9ZgmGO1gtU4W2vkmzP5nN
         IqBn2QDGKAuHawvggw/oK11qkyHBA3qsO6Qby2N9JbZH1XvFiWKes21nX0VQ3L7+eV5C
         t4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740694683; x=1741299483;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fSsPdpeGhBimYxX2APmO2De1m7wFKDQe+ScdUPoNEQ4=;
        b=n+Dz2mLXXG169wFbyohaxq4b2dyL29WVEmx7KjLfb44SYBTi5KjYCy0qMUWwOtNvdy
         GyqmIBACk8TQA1GdNFMZeObP5klbYaXagftxgcbZi/PsukrQ0Q1yRabeAPTCp8siHe+Z
         C7UbhK4MBVytK5vQWXJbsceZlTwX0tc3JwZJsd6YeIwtgPqyGm/GgCXYvKpnqcKb1Bxq
         0JNGFLnDqBeUR/MY90PlHWKd1ox5YzJa2HsiNUXmS8ovgq0SAlRRs7PEJ6WKbXT2yc4d
         kr8pVRfYcYJT0ESsKCIGmdrIcd972jJ3pBihmdwwZX+or37xLYbs6klA1zW3vplGfXOZ
         cKUw==
X-Forwarded-Encrypted: i=1; AJvYcCVr8ZFDqkW5Ucq7AX/zdnRAmqhZnntLCdtvfJPeY1fN7ILhlkMO7pQ5uZeSwMDkl5DHfiL4JcmBtyR10TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0FTUHP1Bq4snUY8t7JszoA2fYT0mub6cLTNJw+vW02yVinjwN
	hfD+eIrJbz8nhzeQqPsvEm9vjaYpe4c+SeTi3kWvoYvbltTVD+yQvP9CCCI7Isz5HnEiHAsOras
	E3w==
X-Google-Smtp-Source: AGHT+IFnpP1BpVR7GZ6CP9sWZxTMoJZvy+ULPkUSf8TSQDyPduCxJg7da4iBH3B09xjNUba1kYGOHyf1Hy0=
X-Received: from pjyp16.prod.google.com ([2002:a17:90a:e710:b0:2f4:465d:5c61])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c07:b0:2ee:ab04:1037
 with SMTP id 98e67ed59e1d1-2febab78d2bmr1712771a91.17.1740694683655; Thu, 27
 Feb 2025 14:18:03 -0800 (PST)
Date: Thu, 27 Feb 2025 14:18:02 -0800
In-Reply-To: <Z7/8EOKH5Z1iShQB@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250208105318.16861-1-yan.y.zhao@intel.com> <Z75y90KM_fE6H1cJ@google.com>
 <Z76FxYfZlhDG/J3s@yzhao56-desk.sh.intel.com> <Z79rx0H1aByewj5X@google.com> <Z7/8EOKH5Z1iShQB@yzhao56-desk.sh.intel.com>
Message-ID: <Z8Dkmu_57EmWUdk5@google.com>
Subject: Re: [PATCH] KVM: selftests: Wait mprotect_ro_done before write to RO
 in mmu_stress_test
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, rick.p.edgecombe@intel.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 27, 2025, Yan Zhao wrote:
> On Wed, Feb 26, 2025 at 11:30:15AM -0800, Sean Christopherson wrote:
> > On Wed, Feb 26, 2025, Yan Zhao wrote:
> > > On Tue, Feb 25, 2025 at 05:48:39PM -0800, Sean Christopherson wrote:
> > > > On Sat, Feb 08, 2025, Yan Zhao wrote:
> > > > > The test then fails and reports "Unhandled exception '0xe' at guest RIP
> > > > > '0x402638'", since the next valid guest rip address is 0x402639, i.e. the
> > > > > "(mem) = val" in vcpu_arch_put_guest() is compiled into a mov instruction
> > > > > of length 4.
> > > > 
> > > > This shouldn't happen.  On x86, stage 3 is a hand-coded "mov %rax, (%rax)", not
> > > > vcpu_arch_put_guest().  Either something else is going on, or __x86_64__ isn't
> > > > defined?
> > > stage 3 is hand-coded "mov %rax, (%rax)", but stage 4 is with
> > > vcpu_arch_put_guest().
> > > 
> > > The original code expects that "mov %rax, (%rax)" in stage 3 can produce
> > > -EFAULT, so that in the host thread can jump out of stage 3's 1st vcpu_run()
> > > loop.
> > 
> > Ugh, I forgot that there are two loops in stage-3.  I tried to prevent this race,
> > but violated my own rule of not using arbitrary delays to avoid races.
> > 
> > Completely untested, but I think this should address the problem (I'll test
> > later today; you already did the hard work of debugging).  The only thing I'm
> > not positive is correct is making the first _vcpu_run() a one-off instead of a
> > loop.
> Right, making the first _vcpu_run() a one-off could produce below error:
> "Expected EFAULT on write to RO memory, got r = 0, errno = 4".

/facepalm

There are multiple vCPU, using a single flag isn't sufficient.  I also remembered
(well, re-discovered) why I added the weird looping on "!":

	do {                                                                    
		r = _vcpu_run(vcpu);                                            
	} while (!r);

On x86, with forced emulation, the vcpu_arch_put_guest() path hits an MMIO exit
due to a longstanding (like, forever longstanding) bug in KVM's emulator.  Given
that the vcpu_arch_put_guest() path is only reachable by disabling the x86 specific
code (which I did for testing those paths), and that the bug only manifests on x86,
I think it makes sense to drop that code as it's super confusing, gets in the way,
and is unreachable unless the user is going way out of their way to hit it.

I still haven't reproduced the failure without "help", but I was able to force
failure by doing a single write and dropping the mprotect_ro_done check:

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index a1f3f6d83134..3524dcc0dfcf 100644
--- a/tools/testing/selftests/kvm/mmu_stress_test.c
+++ b/tools/testing/selftests/kvm/mmu_stress_test.c
@@ -50,15 +50,15 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
         */
        GUEST_ASSERT(!READ_ONCE(all_vcpus_hit_ro_fault));
        do {
-               for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
+               // for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
 #ifdef __x86_64__
-                       asm volatile(".byte 0x48,0x89,0x00" :: "a"(gpa) : "memory"); /* mov %rax, (%rax) */
+                       asm volatile(".byte 0x48,0x89,0x00" :: "a"(end_gpa - stride) : "memory"); /* mov %rax, (%rax) */
 #elif defined(__aarch64__)
                        asm volatile("str %0, [%0]" :: "r" (gpa) : "memory");
 #else
                        vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
 #endif
-       } while (!READ_ONCE(mprotect_ro_done) && !READ_ONCE(all_vcpus_hit_ro_fault));
+       } while (!READ_ONCE(all_vcpus_hit_ro_fault));
 
        /*
         * Only architectures that write the entire range can explicitly sync,

The below makes everything happy, can you verify the fix on your end?

---
 tools/testing/selftests/kvm/mmu_stress_test.c | 22 ++++++++++++-------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/mmu_stress_test.c b/tools/testing/selftests/kvm/mmu_stress_test.c
index d9c76b4c0d88..a1f3f6d83134 100644
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
+	 * has occured, otherwise vCPUs may complete their writes and advance
+	 * to the next stage prematurely.
 	 *
 	 * For architectures that support skipping the faulting instruction,
 	 * generate the store via inline assembly to ensure the exact length
@@ -47,6 +48,7 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 	 * is low in this case).  For x86, hand-code the exact opcode so that
 	 * there is no room for variability in the generated instruction.
 	 */
+	GUEST_ASSERT(!READ_ONCE(all_vcpus_hit_ro_fault));
 	do {
 		for (gpa = start_gpa; gpa < end_gpa; gpa += stride)
 #ifdef __x86_64__
@@ -56,7 +58,7 @@ static void guest_code(uint64_t start_gpa, uint64_t end_gpa, uint64_t stride)
 #else
 			vcpu_arch_put_guest(*((volatile uint64_t *)gpa), gpa);
 #endif
-	} while (!READ_ONCE(mprotect_ro_done));
+	} while (!READ_ONCE(mprotect_ro_done) && !READ_ONCE(all_vcpus_hit_ro_fault));
 
 	/*
 	 * Only architectures that write the entire range can explicitly sync,
@@ -81,6 +83,7 @@ struct vcpu_info {
 
 static int nr_vcpus;
 static atomic_t rendezvous;
+static atomic_t nr_ro_faults;
 
 static void rendezvous_with_boss(void)
 {
@@ -148,12 +151,16 @@ static void *vcpu_worker(void *data)
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
@@ -378,7 +385,6 @@ int main(int argc, char *argv[])
 	rendezvous_with_vcpus(&time_run2, "run 2");
 
 	mprotect(mem, slot_size, PROT_READ);
-	usleep(10);
 	mprotect_ro_done = true;
 	sync_global_to_guest(vm, mprotect_ro_done);
 

base-commit: 557953f8b75fce49dc65f9b0f7e811c060fc7860
-- 


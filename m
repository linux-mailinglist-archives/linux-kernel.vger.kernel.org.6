Return-Path: <linux-kernel+bounces-233206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF291B44E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ECA1F21D48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F90B12E6D;
	Fri, 28 Jun 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6YXuVgC"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA98567F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719536165; cv=none; b=PzABqOMMCPtB8eobAvAyRQwb3XoXJoHhdR8KdyFTs5RIjTzUS68sp8QVxwxZTqh/8YRZmi1eubjhWH5YMG5CgtUzA3camRC6vS9JvbOTMw6ELbkl4lrDjFuHBYXSEhnnNVri3rGe/F7ynJ3K0zM6v8P4dKxjlIhYkmsIyxu3wHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719536165; c=relaxed/simple;
	bh=G3FSZ2tz9v6DPSa+Rx/FJ0rkt66HAzAfiU84cuLrcAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uczfSB0Y3pJlks1UD+LtPz76Xe4bzIGOcI+3QCfUlb7as8V0RP5KmCjFMMQOkZpJzPs59xU7wzF+9NzPz089y+Rmb49jViRmAe6G6X4l14EhdX3ZpwzwStLEAyuYXeLoJgLFdmKnhL2kzWYOQHTx2HzdrFEIWX57PASS9b+q8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6YXuVgC; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-649731dd35bso50772a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719536163; x=1720140963; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jFcIVUBPDaNQ4ydRxXF3Co9VGBxxxWoienflyNRcWVI=;
        b=s6YXuVgCmM1o+lTA9o/R3zen2blA+6XlkkYYJ92OM8ReEJygYUKNAypZXxCA9zzfRd
         +XIMEEz7aLQgrUUXfOBvGm2uO4RsbvBnMfk7VAd4qnXcXFjDXDxKMhe2q2kLxcsOD0rr
         Q3jH2UrP/6Jp0TCjzkwf8ZB4M9ZSU5oUaynQHK1vGMVFy2EMfs497zdX+iBxTI7KHPXC
         FiLsl3xOAqCfMHVHq3o4GYdzilsOhgtlUxQAGuvecPPb0tux+TQUK+8ffzuKBhuTYuc5
         UalTm8beqePPcEEii5vzmXfjTrD39LCs0bCKLP2tFZFZukXKwqyoEI3qLT4WcTzYmaWI
         nF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719536163; x=1720140963;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jFcIVUBPDaNQ4ydRxXF3Co9VGBxxxWoienflyNRcWVI=;
        b=S8CWrS7yKy/Do+MGSaXmfvoF8Ilj7yTe5csGEUptHyeSBLKU9xPz8IQqIkJMJDWGtN
         gF4qTcJ3HJTg639Bt0C2xLuuvFHuTYum82BUesGaMiWSutWrIk9zUDaCh7c4NPS/KH1x
         YlGBUscGCmou2QwcBOhkcq1OztbOKZl4No/A1w1U/o5fCL3vpCuUL3Nk+3Hvznf6Vbm+
         idwxIch4tj+Rz562I6G7KTadHcQsRNWv80/O/NkAV0sGLBN89SZ9iV7SGAoXrFqsY9DQ
         BI9HTkhShMMRj+P1TyMm9q+0+yzFYLiNuPuyoQKiQUllA8CEAQcUPxiIXbVdRmTYB3n1
         /+jg==
X-Forwarded-Encrypted: i=1; AJvYcCWWmxrhG+vKcP0ez1N+/8dqmXn+zU0NhVTrG9GAXljQZVbWlTLyo2/p8AIto9xCNYZ+R/K9gjYkV40uGc45lAdwNQ0UmT79f/HBmr/e
X-Gm-Message-State: AOJu0YxMdBAzcPpcDg5ikCPktUflzSngvgsPSQgKQupuJcncJ069vXFH
	fdwbY38V34nlqNMsbIc/E2cbBnzzb1hlX3iZKXgHfm5CDYj/2HKUaHIEIdxcpESpvCj4ezxscyt
	pzQ==
X-Google-Smtp-Source: AGHT+IHjjmpUvKhJXMjyFuGVSySwEJHs7zNrpePcsino/XOWJv/3CSojSuXT1I5dYXPGATxcKplhZskbdNc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:678f:0:b0:6e6:a51f:3c54 with SMTP id
 41be03b00d2f7-71b5afb981emr34080a12.6.1719536163250; Thu, 27 Jun 2024
 17:56:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 27 Jun 2024 17:55:56 -0700
In-Reply-To: <20240628005558.3835480-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240628005558.3835480-1-seanjc@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240628005558.3835480-2-seanjc@google.com>
Subject: [PATCH 1/2] KVM: selftests: Rework macros in PMU counters test to
 prep for multi-insn loop
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Tweak the macros in the PMU counters test to prepare for moving the
CLFLUSH+MFENCE instructions into the loop body, to fix an issue where
a single CLFUSH doesn't guarantee an LLC miss.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/pmu_counters_test.c  | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
index 96446134c00b..bb40d7c0f83e 100644
--- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
@@ -7,15 +7,25 @@
 #include "pmu.h"
 #include "processor.h"
 
-/* Number of LOOP instructions for the guest measurement payload. */
-#define NUM_BRANCHES		10
+/* Number of iterations of the loop for the guest measurement payload. */
+#define NUM_LOOPS			10
+
+/* Each iteration of the loop retires one branch instruction. */
+#define NUM_BRANCH_INSNS_RETIRED	(NUM_LOOPS)
+
+/* Number of instructions in each loop. */
+#define NUM_INSNS_PER_LOOP		1
+
 /*
  * Number of "extra" instructions that will be counted, i.e. the number of
- * instructions that are needed to set up the loop and then disabled the
+ * instructions that are needed to set up the loop and then disable the
  * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
  */
-#define NUM_EXTRA_INSNS		7
-#define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
+#define NUM_EXTRA_INSNS			7
+
+/* Total number of instructions retired within the measured section. */
+#define NUM_INSNS_RETIRED		(NUM_LOOPS * NUM_INSNS_PER_LOOP + NUM_EXTRA_INSNS)
+
 
 static uint8_t kvm_pmu_version;
 static bool kvm_has_perf_caps;
@@ -100,7 +110,7 @@ static void guest_assert_event_count(uint8_t idx,
 		GUEST_ASSERT_EQ(count, NUM_INSNS_RETIRED);
 		break;
 	case INTEL_ARCH_BRANCHES_RETIRED_INDEX:
-		GUEST_ASSERT_EQ(count, NUM_BRANCHES);
+		GUEST_ASSERT_EQ(count, NUM_BRANCH_INSNS_RETIRED);
 		break;
 	case INTEL_ARCH_LLC_REFERENCES_INDEX:
 	case INTEL_ARCH_LLC_MISSES_INDEX:
@@ -120,7 +130,7 @@ static void guest_assert_event_count(uint8_t idx,
 	}
 
 sanity_checks:
-	__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+	__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
 	GUEST_ASSERT_EQ(_rdpmc(pmc), count);
 
 	wrmsr(pmc_msr, 0xdead);
@@ -147,7 +157,7 @@ do {										\
 	__asm__ __volatile__("wrmsr\n\t"					\
 			     clflush "\n\t"					\
 			     "mfence\n\t"					\
-			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
+			     "1: mov $" __stringify(NUM_LOOPS) ", %%ecx\n\t"	\
 			     FEP "loop .\n\t"					\
 			     FEP "mov %%edi, %%ecx\n\t"				\
 			     FEP "xor %%eax, %%eax\n\t"				\
@@ -500,7 +510,7 @@ static void guest_test_fixed_counters(void)
 		wrmsr(MSR_CORE_PERF_FIXED_CTR0 + i, 0);
 		wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, FIXED_PMC_GLOBAL_CTRL_ENABLE(i));
-		__asm__ __volatile__("loop ." : "+c"((int){NUM_BRANCHES}));
+		__asm__ __volatile__("loop ." : "+c"((int){NUM_LOOPS}));
 		wrmsr(MSR_CORE_PERF_GLOBAL_CTRL, 0);
 		val = rdmsr(MSR_CORE_PERF_FIXED_CTR0 + i);
 
-- 
2.45.2.803.g4e1b14247a-goog



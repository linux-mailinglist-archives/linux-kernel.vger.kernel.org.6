Return-Path: <linux-kernel+bounces-529130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B3A4200B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B9D165940
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608F123BD03;
	Mon, 24 Feb 2025 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmng53Kl"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805A24888F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740402782; cv=none; b=SsL2w63ubkHskV23k7upicNZjGCdUDv+rSC6v+CADROiQG4xzvQFuE5oeo39Ih6R0rzEPsgeKK5FWRY3gx72ZSC8dw/Biu7xTxDwnH2iJN7V1J7deJgWk1leylY/65KqNRMbZICQWEPSIeGTpGF5OKK4XGD1iNnWmb9Cn5gkAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740402782; c=relaxed/simple;
	bh=w/6+V3WzV7WfT41SO7t/1M6oSg7jIobBlh33/jyiCKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Mnu/BJnkTuCoiCRm4XUznMpEIFV17cMEsjmLl4q4/WfcNbQmALvnDPCGaCfg5GK1hE9PqZodz9jFCyjVLuV9OldpKvN9/n0DPfzHFCSlA306CWQU4Hbv8fShhM87nP0hcB2Im3HBRtLBRS705s81hfjsCTxb9ZgRFcOLADCFjYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmng53Kl; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e058037b27so4222327a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740402779; x=1741007579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oFpPxyvDOth0HhLewFAODCmd7NewGGY5JD0OvJlhJu8=;
        b=rmng53KlQ1MBYXscouxCU0o6UQxKl0kPpfUYp8pDlrU8ItTfFRds9Y0TknU+idUkbX
         wI/+5x0sNOZH5dVhKmbHYA87KrqzypwYvGbsEz1S1/86kKhOzm7ecgiKQE6DqhnZ1S1X
         3G8HCrjZI0cfhqgPAcuKnoxw517LMILZwbCkxEDLrfdT7dINsc0LLi0J0TlP/1tsbeEk
         aLmBO/9PHasEznDVenMIlzfexhUywt+ysm1stz4kiMVQQO82W7rWyvzqtrO2l7VBzq8b
         H8RzWux3l1Zx5leHb2HpI/oHofO6xTp6PViCfBStFfk+YEKcqwO6JgVsWYanhskHa4jh
         Fojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740402779; x=1741007579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oFpPxyvDOth0HhLewFAODCmd7NewGGY5JD0OvJlhJu8=;
        b=LyWBr56vJkK5y7+oX/g2SSR/bcKa9YimTWw0QWRbqKWqXpFR+iFSO8Y5aqu3Sks0AI
         oyU2NLDqm8yqoNoF1/0Ybz2L+Eu2yWAvD2oH9AifV0+bW4wGOZspLsus2I8YtD+bDwQM
         kieAchrox44k9V1dqTF6YA8O5vB/5qzXFk5XYsPO1No3fUzWWPFmdbx9u0Bwq2Vpgc/F
         YiFsPUw7w73NSUjXlr5fAVa3p1fldBfBZ30fGKH1V6gUjleRbfHlru/5tTT5HvV3Mxzs
         7Pg/qm2jYiaP+q1NYaNVtHzzqWjj6StVzSEq1bOnUVMDjy0F+31SlWdcgZR4BFr4HJBC
         C1ng==
X-Forwarded-Encrypted: i=1; AJvYcCVonXqAgtyfyQ54h50t+fV0wYuKdnjQjeq96cKJ7PERFpyQQyw9grXROb5K9tPpRMuyhxamB80YARaJq0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcP4APlv5LOBFxjBQXUThs7AAoHIYGM9OF4e6Boph5ZVn2Md8k
	WCzG6TNEAQuV0L5jZzZSUUeyHqZtf2tL24Y6nouaI6EvaZsB0lS3ucQk0OtStPQFWEOSPojCUvU
	DkQfOiw==
X-Google-Smtp-Source: AGHT+IGZg2rT8td60W1UKeimFfaAceOU/oiypd2ZmuYT2lD01ebq/Rrh8ttrsLPZ9a6AAzWXSmXiNPOxNyx0
X-Received: from edbfj8.prod.google.com ([2002:a05:6402:2b88:b0:5de:cfb4:b04a])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2707:b0:5e0:6238:d72
 with SMTP id 4fb4d7f45d1cf-5e0b7237d39mr11243607a12.21.1740402779230; Mon, 24
 Feb 2025 05:12:59 -0800 (PST)
Date: Mon, 24 Feb 2025 14:12:31 +0100
In-Reply-To: <cover.1740402517.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740402517.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <55ed8b22855968526dfd1b05e7f249f66cebd25c.1740402517.git.dvyukov@google.com>
Subject: [PATCH v3 4/4] selftests/rseq: Add test for rseq+pkeys
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test that ensures that PKEY-protected struct rseq_cs
works and does not lead to process kills.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

---
Changes in v3:
 - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
 - rework the test to work when only pkey 0 is supported for rseq

Changes in v2:
 - change test to install protected rseq_cs instead of rseq
---
 tools/testing/selftests/rseq/Makefile    |  2 +-
 tools/testing/selftests/rseq/pkey_test.c | 99 ++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h      |  1 +
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432fceb586..9111d25fea3af 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
new file mode 100644
index 0000000000000..8752ecea21ba8
--- /dev/null
+++ b/tools/testing/selftests/rseq/pkey_test.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Ensure that rseq works when rseq data is inaccessible due to PKEYs.
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/syscall.h>
+#include <ucontext.h>
+#include <unistd.h>
+
+#include "rseq.h"
+#include "rseq-abi.h"
+
+int pkey;
+ucontext_t ucp0, ucp1;
+
+void coroutine(void)
+{
+	int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
+	/*
+	 * When we disable access to pkey 0, globals and TLS become
+	 * inaccessible too, so we need to tread carefully.
+	 * Pkey is global so we need to copy it to onto stack.
+	 * If ts is not volatile, then compiler may try to init it
+	 * by loading a global 16-byte value.
+	 */
+	volatile int pk = pkey;
+	volatile struct timespec ts;
+
+	orig_pk0 = pkey_get(0);
+	if (pkey_set(0, PKEY_DISABLE_ACCESS))
+		err(1, "pkey_set failed");
+	old_pk0 = pkey_get(0);
+	old_pk1 = pkey_get(pk);
+
+	/*
+	 * If the kernel misbehaves, context switches in the following loop
+	 * will terminate the process with SIGSEGV.
+	 */
+	ts.tv_sec = 0;
+	ts.tv_nsec = 10 * 1000;
+	/*
+	 * Trigger preemption w/o accessing TLS.
+	 * Note that glibc's usleep touches errno always.
+	 */
+	for (i = 0; i < 10; i++)
+		syscall(SYS_clock_nanosleep, CLOCK_MONOTONIC, 0, &ts, NULL);
+
+	pk0 = pkey_get(0);
+	pk1 = pkey_get(pk);
+	if (pkey_set(0, orig_pk0))
+		err(1, "pkey_set failed");
+
+	/*
+	 * Ensure that the kernel has restored the previous value of pkeys
+	 * register after changing them.
+	 */
+	if (old_pk0 != pk0)
+		errx(1, "pkey 0 changed %d->%d", old_pk0, pk0);
+	if (old_pk1 != pk1)
+		errx(1, "pkey 1 changed %d->%d", old_pk1, pk1);
+
+	swapcontext(&ucp1, &ucp0);
+	abort();
+}
+
+int main(int argc, char **argv)
+{
+	pkey = pkey_alloc(0, 0);
+	if (pkey == -1) {
+		printf("[SKIP]\tKernel does not support PKEYs: %s\n",
+			strerror(errno));
+		return 0;
+	}
+
+	if (rseq_register_current_thread())
+		err(1, "rseq_register_current_thread failed");
+
+	if (getcontext(&ucp1))
+		err(1, "getcontext failed");
+	ucp1.uc_stack.ss_size = getpagesize() * 4;
+	ucp1.uc_stack.ss_sp = mmap(NULL, ucp1.uc_stack.ss_size,
+		PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
+	if (ucp1.uc_stack.ss_sp == MAP_FAILED)
+		err(1, "mmap failed");
+	if (pkey_mprotect(ucp1.uc_stack.ss_sp, ucp1.uc_stack.ss_size,
+			PROT_READ | PROT_WRITE, pkey))
+		err(1, "pkey_mprotect failed");
+	makecontext(&ucp1, coroutine, 0);
+	if (swapcontext(&ucp0, &ucp1))
+		err(1, "swapcontext failed");
+	return 0;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index ba424ce80a719..65da4a727c550 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -8,6 +8,7 @@
 #ifndef RSEQ_H
 #define RSEQ_H
 
+#include <assert.h>
 #include <stdint.h>
 #include <stdbool.h>
 #include <pthread.h>
-- 
2.48.1.601.g30ceb7b040-goog



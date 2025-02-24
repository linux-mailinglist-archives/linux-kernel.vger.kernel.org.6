Return-Path: <linux-kernel+bounces-529148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B68A4206E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FFF189908C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131F24BBF3;
	Mon, 24 Feb 2025 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zemG9TFr"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75623BD1C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403275; cv=none; b=i9kSbWLRaZ2TuW62G0sA6Ckr9KbVmxsnCfcjiOU6XsuFc2EQ+A/nfRo1Fn2lfh3p3PrC7gPb0CVo+mrL1GAgs0377mzPA2Kym7nPBwogKrMAO/HmYpiajT2eTAEPvif696SHExkQ2Xpd4zEhWLvAxKVqqBDxc6bAoQ0lEb4/Xvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403275; c=relaxed/simple;
	bh=wOo2Z0Z9+bcfVAWs4A5IwGpGUwpENnGCJGgv4+HMa40=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jo6xv+KYmBP5p131naDLA+RnuvV5TwVKX82rEuRJ7diYiGk2p+NhzG+cAHqk89JBDAdaWoi64D+ET7405+dCfBQEvUKrYLOkjcyXOIectyOFflbR+UgjeaeANeXS8WbPdk7WcH0o5w84J/mPZj3Sq4XVejKeqdFykbZEmaUPYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zemG9TFr; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5e04de6583bso4069800a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 05:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403272; x=1741008072; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TICwl0nRJOC4h0ZewFihh1Nnwolltl1vhq1HJlojKh4=;
        b=zemG9TFrcdskt2rc+NxPercrpsaVvNo/Osr3QsAnQP51KK2HE8n67qZoWK+Cc9jB9Z
         RDIPIrJITkYZ49XTo6DYO0jD/Nrf58bcstkvbrQUUncGjs1DZ/YVnWsKMg7NHc8870z5
         BnaVZbZu3CNAlFu+E3K742yyeFf62TruFbuXJG6xGkmH/HJYIZgtbA0jFGNpn79o7Ok3
         j1EqbUaWp+mmAecbiUFdLcPxnJCGf7JFvRqpIVcpGfpJFefGYb+OIis1vm8vf3zLVT3e
         3kEYthrjxoQFoUPONIXg19h6ZGkeQx7KAmdEivUOiSCiDV8cpqwPqQ9Okvg0Usk9dR57
         MnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403272; x=1741008072;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TICwl0nRJOC4h0ZewFihh1Nnwolltl1vhq1HJlojKh4=;
        b=rHjXr2PRR6sMDqbmxYF+Jf3xCeGd0N96sqwV67BOIqiJDWXi41S4NW3lpN9CK8LBl5
         mm/roW7fwGLQj9gFdEIfZ6/G+FMmWTBJEtnT5XwDhp4XHgaCMmDO7ovSpjLJ1OqEczZO
         my4ZiZGO5I6e/9Rq0X805o/SH+J0vvPt4i/5UJMusoeodwqYfn1omJ3TJWR278MnwomV
         SFEjuoSLqj5LEhL45Of94AKEPHWuz/eQdT6/lPMHr0mdDhbMqXx59q9CvNW9dFPtQt9C
         ciV8TWneHvbEC54H62CgHe2+ZbAY9wUcODNq09zFVt8P6ouHIxM0Huf6cjXli768Pi+q
         wVFA==
X-Forwarded-Encrypted: i=1; AJvYcCW9sdXGlAaneQH7j9Y+T5+rq/B23PYqjiyuGYIOM9KW1AReHq0/p8tIG3Pr/o0feJW+9fqP089kvyeLXfY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Or0QWLFAoesT8v5IjuKBxOt41EH29iHJPj8qjt2UOcXtaBRI
	Kpu5G82EOWk4rm3pljbRxI8H6sPfIKGoU97XnG6uhWQweym9wLZrq7luDBWL7OvCaY2wG6IVDVQ
	uJC3TLw==
X-Google-Smtp-Source: AGHT+IF2liFbQwkZJS9KUI9htCxTOxVdhKUkW3WOYanm9morSPgFm6v2nqlxXWKw+ljThwFl0PDtYvozh/Sm
X-Received: from edbfi15.prod.google.com ([2002:a05:6402:550f:b0:5de:616a:fe63])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:360b:b0:5df:4181:d2c6
 with SMTP id 4fb4d7f45d1cf-5e0b70f9ff2mr12754982a12.19.1740403271882; Mon, 24
 Feb 2025 05:21:11 -0800 (PST)
Date: Mon, 24 Feb 2025 14:20:48 +0100
In-Reply-To: <cover.1740403209.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740403209.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <356f1e7b2c3c1dfee74f030bca603ffc9549ffb4.1740403209.git.dvyukov@google.com>
Subject: [PATCH v4 4/4] selftests/rseq: Add test for rseq+pkeys
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
Fixes: d7822b1e24f2 ("rseq: Introduce restartable sequences system call")

---
Changes in v4:
 - Added Fixes tag

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



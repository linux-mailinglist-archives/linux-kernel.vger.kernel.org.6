Return-Path: <linux-kernel+bounces-531527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD301A4418C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE63A41A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059BF270ED6;
	Tue, 25 Feb 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Goj85YWV"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65970271278
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491656; cv=none; b=K53KvEuSQZd3pzVgahvJj5niusdsR6EpDD3XoO/SPu0drSTUZZVYk7KB4vegpWvIb9Z25xUu9uqcSbK6s8GWhfZERLFH6elVYhJ5vobr327NUFfX1mXm/Z/Gt2FM1Ku3XvYqV0ZOCWLXmSI9Z3kFpRRfrcCTcjJiwN80sFZwn7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491656; c=relaxed/simple;
	bh=yRnlyHY5sj0nPolyHcCX0W1VmtYMVBh6HOo3S9R4zcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jBuV42zOSkg47Qi8XcUHA/nttNCeX8y55hTLRU/0f/ukREuFwG7MIrIBbxzADDlsHyM+VcpTD6ksFTbL0LtsI0SmBHGVQRoIdzVEh+kbeXdolCmLio97NHXBMn+euFVpW9tK6hS+vZYtyovjCqmWc3b30LF/b5cVe6sphfMwvGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Goj85YWV; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-abb8f65af3dso505112666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 05:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740491653; x=1741096453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/DXlVSjcMlIzI08dLupqZQFFeRwmRS51ToDVNdHuU=;
        b=Goj85YWVL8QmgeTATw+IbrC3/qeWtOTx//V68u7TjNv0n3FqMaS+Vsotz2hzM63HZl
         XlTEYwocKGrD1n07ZqGzfh+frCGmRAC02UGarbQmu4bvLdfuP5yFTMU3KmCCfPUXekb8
         YVF2cs2g/EU28I0uK4BlBhVVA38bOb/YwmWeLZxEjnKUHnPsuUHZNd2emN9xjdNpL4My
         Uw3XnsgL9Oa19S2JmFW5iPAv6Z5OFbwDYj8WJRhIO+oslPajK16XBmKiU9iHG9xekmrf
         xpHkMFFFBKEacHzIovnqLCpWwxbGpOOxzlQmNhLa8rKM7pkat1fPeE5rOcHPluJvpts/
         VPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740491653; x=1741096453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/DXlVSjcMlIzI08dLupqZQFFeRwmRS51ToDVNdHuU=;
        b=vHsIcdhVLRRZOhZeQ5bsJmANdAWpFrTxOKwBl24bc4eyCFhJvELt85t1rt8wX5vHwk
         kE9hFx3tzwchUfnFAXmn9BAlBW5PMB4/meIxspYX0+f+OJVPIOqTOQ3rLQJHEzZav7lM
         VHxS4UjvBvEsgRV0WHUBO0xM4SCRYytizXznu+34sMiIqVh9zGw8TGYDJ4b9JcZMUvyu
         CZyOXJ7Yq//xAcx869c+d3kvwcfAyWiNgqxd8gK5pt1qSawW0HKWVg0i6yC5uELrb+Cy
         L0LQEywCPRyRlWnYjL7+2Uefl2wRt9aNxOinfhVnB9av4A0RhspU6/pTxM/Pj2wE2F0P
         WsDg==
X-Forwarded-Encrypted: i=1; AJvYcCWS1wUg1S7FFKUxHAdt+20TNTSJ53w+GCttiM1sSduFjphb1gDtjed8nCkAO29bvLLys2xSZtRMP08GumM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvM6qIqQMUZ4IjTMPBcHOSz0NExCU547NrNtJ/datPS38zvdwv
	Km5IkfsiRXgU/fLmTgyfVA6Kq4JUth8QFvdqXMRsWDg/W/xUJSv/NlHkGlKLt8dwlJicax8aouk
	XPsyW2Q==
X-Google-Smtp-Source: AGHT+IGoDWk/TpcFuDY40DBypweVg4CXS82/Nz6prX7/2RhjV/lp4W5V7+glWTjinPnVUuy1Ux3dqkfPTmYt
X-Received: from ejcun1.prod.google.com ([2002:a17:907:cb81:b0:abb:8b18:27f3])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:314c:b0:ab7:ec8b:c642
 with SMTP id a640c23a62f3a-abc099e9473mr1556633066b.5.1740491652676; Tue, 25
 Feb 2025 05:54:12 -0800 (PST)
Date: Tue, 25 Feb 2025 14:53:46 +0100
In-Reply-To: <cover.1740491413.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740491413.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <d7d9de9f13eb105b38c4c7f6030d8a017e8fab34.1740491413.git.dvyukov@google.com>
Subject: [PATCH v5 4/4] selftests/rseq: Add test for rseq+pkeys
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
Changes in v5:
 - Use static for variables/functions
 - Use RSEQ_READ/WRITE_ONCE instead of volatile

Changes in v4:
 - Added Fixes tag

Changes in v3:
 - added Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
 - rework the test to work when only pkey 0 is supported for rseq

Changes in v2:
 - change test to install protected rseq_cs instead of rseq
---
 tools/testing/selftests/rseq/Makefile    |  2 +-
 tools/testing/selftests/rseq/pkey_test.c | 98 ++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h      |  1 +
 3 files changed, 100 insertions(+), 1 deletion(-)

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
index 0000000000000..cc4dd98190942
--- /dev/null
+++ b/tools/testing/selftests/rseq/pkey_test.c
@@ -0,0 +1,98 @@
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
+static int pkey;
+static ucontext_t ucp0, ucp1;
+
+static void coroutine(void)
+{
+	int i, orig_pk0, old_pk0, old_pk1, pk0, pk1;
+	/*
+	 * When we disable access to pkey 0, globals and TLS become
+	 * inaccessible too, so we need to tread carefully.
+	 * Pkey is global so we need to copy it onto the stack.
+	 */
+	int pk = RSEQ_READ_ONCE(pkey);
+	struct timespec ts;
+
+	orig_pk0 = pkey_get(0);
+	if (pkey_set(0, PKEY_DISABLE_ACCESS))
+		err(1, "pkey_set failed");
+	old_pk0 = pkey_get(0);
+	old_pk1 = pkey_get(pk);
+
+	/*
+	 * Prevent compiler from initializing it by loading a 16-global.
+	 */
+	RSEQ_WRITE_ONCE(ts.tv_sec, 0);
+	RSEQ_WRITE_ONCE(ts.tv_nsec, 10 * 1000);
+	/*
+	 * If the kernel misbehaves, context switches in the following loop
+	 * will terminate the process with SIGSEGV.
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
2.48.1.658.g4767266eb4-goog



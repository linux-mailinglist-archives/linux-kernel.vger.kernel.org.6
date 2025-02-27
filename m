Return-Path: <linux-kernel+bounces-536508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC324A480AD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D171189BCEC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670B230D3D;
	Thu, 27 Feb 2025 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fdirh3ZE"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87623E23D
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665014; cv=none; b=qbSno3dI59rUd+10GbrAngiosm5W87ADanWMN6LC8n1yxNmXm96fr0qIX21+EZgGmf5udWZsU08WxEotZt1HxE/S6v+fUZ8voCw9J9Q9Ei2ukIX7jSWOAIpS59MGM/e+9ej6Wn8NoHCqqA/O1nsC9gK69n8l0Qhs9QuZR4pR1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665014; c=relaxed/simple;
	bh=yRnlyHY5sj0nPolyHcCX0W1VmtYMVBh6HOo3S9R4zcs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u43OoarrrKZC7CseQPtwHGbrZ7Cnhsc/oCnTfAjl7eK5k6czHpbluGD3pbdKUBgD2AeJEdj4gkHPdhAb3nQiKLQZ+VEOhQyQj2EqYyzL7NKoqorHxGqrjIJlJYHXZXIQU1s98VCjmk2F65yMmH5sxDjn7/phP5+b1SkJfaqv82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fdirh3ZE; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5e04de6583bso1450661a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 06:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740665010; x=1741269810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/DXlVSjcMlIzI08dLupqZQFFeRwmRS51ToDVNdHuU=;
        b=Fdirh3ZEdalV0+7wHuajlCXKzTze1SRSXpZfh4JVKYSmOPwQkzBdwSZOwZIx6880aN
         5pvnkAeoShu7fw5MzU9lkkrrez9Q9m0eZvhgO5DbrajHlb62mz/JO3U52vEyFHrXQiD2
         p0+M6WngNCYlR6FyTSpIMNnIMBVtVnpnktCSb7R+cag2qb663s7b+eF+p+KNuyN21X+R
         8mAf9FZvpJOyzLXtyTunmVNNIcsVCyIcp/vUXEhYEbjsfQ1Oe3+U/kIRhCL1dX4gcWWd
         xXQRlU3dLgPF+qr0PZI7zl1ULuAW8ixGvPM5J2/T6CKCA/4AXMuHYE/r0iDhKeNgEUCG
         QzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740665010; x=1741269810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4/DXlVSjcMlIzI08dLupqZQFFeRwmRS51ToDVNdHuU=;
        b=IS1EcszletEs+KfIx5rT10On9hqlWDUkHjfQuF0gc/ncwocxHA9nHg8A6NKPkGzT3m
         jtjgrmy3jgCImcEiZOrxAC6OBOeOVjlsR0abB2KBU4WR/jB4Iwb1qmwpsyf4NoItvdhm
         ZuJOetMQERGhEppVbz6XOnej/xXIrCCmInZmscij2zuFtcd7L7nJPT0plKXb/7l20ZbJ
         +o9y4fVY3WoqjNG2lQ+QR9dkXHsAo68iTUCWE+/FKJSOE9VporsUIJmDC314/7a0hLDo
         EVFhxpBSwpk1Tw33/+R4M9KCoPNsjnvEUEfgwvv9uWfD+daorLZo9OO0QgzcModJQiwF
         AjJA==
X-Forwarded-Encrypted: i=1; AJvYcCUFwh6BRbp7SPVVZT8qxkV0iE81jW9FvYZitLvwzzTOS35WR76eLm6NdF6s4PCr7ghkwDjGyHyHcOxMS24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+iDPbe6q5VoWQSZ9B9jC6/RbTppspnRFvJfJcseBWVJEDL0ZQ
	duOOTaaZ4Gp0UvYzFE6+qrQ3v/e8pq7Cl6zH/MQaLpe+6DiwWtDGPG572BtKPgnBSTXMMxI9vR9
	tiF0Lkg==
X-Google-Smtp-Source: AGHT+IG0xgR9ZRyvJrlvb/HM8gvFnR13Z1NNItBXO7n+rEkXDOXpyEY7OA8LY4SlIHAbtZuRHfhGeU1RPkhp
X-Received: from edbes14.prod.google.com ([2002:a05:6402:380e:b0:5e4:cd36:2ddf])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:1ece:b0:5e0:3447:f6b7
 with SMTP id 4fb4d7f45d1cf-5e4455c2e30mr13256002a12.8.1740665010631; Thu, 27
 Feb 2025 06:03:30 -0800 (PST)
Date: Thu, 27 Feb 2025 15:03:15 +0100
In-Reply-To: <cover.1740664852.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1740664852.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <9a98ed5d655e9a0d66027779c75c3ba67601e1bf.1740664852.git.dvyukov@google.com>
Subject: [PATCH v6 4/4] selftests/rseq: Add test for rseq+pkeys
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



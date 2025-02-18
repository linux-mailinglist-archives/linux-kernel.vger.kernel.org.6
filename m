Return-Path: <linux-kernel+bounces-518757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A14BA3940B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 08:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAE173DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9551D6DC5;
	Tue, 18 Feb 2025 07:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3wiwOT1"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF501D88AC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864697; cv=none; b=gXdztn2yvUK0ai7DLIp5Ycd0ztuoS7kXEl/IG4ryNJ9zGiehK6/r9l2clwmGsnuBNBMZJqizx8jbiNsiRFOVIwjqQtMdmYEX0PAwur5MBHImg94qncLGQsP4KyP7vs4JH+NdgDni59BDJziVWoUr+YsuJCb2QUd6WaLbZ7rTm7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864697; c=relaxed/simple;
	bh=D29Ha3uTOHWbzNmnWPabAcBz5kVvTEIzOuVZCzL2ZGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y2tpwx6GBhlk/xHt7pPzsA2MixsJgZWVK5CPqIjFujIFRNwE6IREMgV7zjIlperJqtvbPBle9JByZOzDL5z4Q2+0iMMbePvu8zLa0ntpO4lKEgRU8L0qH6qjPsYCxfvKeEMLQpGsLxxUdHBGI+TASMxNTul/wQ35dSUrDrIwheE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3wiwOT1; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5ded4b4ff88so5430461a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739864693; x=1740469493; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=62LIsIaecTwmmmKIRFism52NcnoPuJ9j6NvnP0tlFig=;
        b=P3wiwOT1qqszMh+oRM150lnIN2aWs/71xOVNLcH0w8mkfakclqoheLjLMyvxL39UgY
         XveznKkyY9vsL+jUhtxrcHekk5L7IySQGKxVa2OjU8CLhrEF61xYGckKWILg0XNjQdlp
         NY3aSPb4Tcsi7zeGB6uwRwOM+tFas4l8fQnQi403c6GIuHyRhjJADduMIH+GRxryt0XZ
         NE3q8ljRiuQsy0b9umEj4E6kDT9NLPCiIpNRCJPmdCEbSzZm9wJXF9oxmKmGITm75+Ju
         EpRl4TKOVoYRex+soXTvvFkuEGY6CUw/qXkZu0wZokOgp+b2d7OziGlCaw0FT4YjJeZZ
         TnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739864693; x=1740469493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62LIsIaecTwmmmKIRFism52NcnoPuJ9j6NvnP0tlFig=;
        b=Q0z5WN7BDXK9NUqT1OQNEjgfCfcYGA8XI9+C4mZNj99TGlStwKHOH48AfC5t+GdPgy
         KkpNbND5K3yag/ezNADYAJ3OSJy8CLYQ2dQ6i+4r9ua4AbDFmYxTMKAOE78CYakTcI1u
         t95phnuia2qTyjzFQBXfosQeFZVzExRYWOBFG8qYwSc9tH9IjWgXoi2CKASz+wYU3H7x
         Kf+vaL6AqJF1QclrPHmM3b213TQkFN+pNx/6aQCeiekezkDenM5/PfxRqH+yzQsIWqYE
         WzJvnNRjXTFVgsG2NEK1PO4SEz7Worxv0Ha5h7ZpA+VcAEvlxSzlog7mOIktktPESJGn
         zM3A==
X-Forwarded-Encrypted: i=1; AJvYcCVDJrkwYyXM3rkX6Wv06kHuZHlCcjE7NqIGK+KTvttlhxIKzSQUfEFi4IMHFVAf2QL5e+/+HO9MfobHf+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy9DwCVkDur47swGko33nB+kOccNGu1qKupTa7diVqnyCNBdAJ
	HJoGNfQVuN9RweII1XvhUf7uZFvgnduA87fP3G5udwsArTnMvqdA2vMEQ6QR3v6f8F3VknoR2U/
	X9kpspw==
X-Google-Smtp-Source: AGHT+IE2djFnOBuu2HQ7EuYmRVJKA75+74QutFtUM5CGIPuMrseT/PH4COtI8KgzO34UZyqox2iFV8/pTydp
X-Received: from edfa69.prod.google.com ([2002:a50:9ecb:0:b0:5de:ce5e:35d7])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5246:b0:5d4:1ac2:277f
 with SMTP id 4fb4d7f45d1cf-5e0360f9617mr10419124a12.9.1739864693065; Mon, 17
 Feb 2025 23:44:53 -0800 (PST)
Date: Tue, 18 Feb 2025 08:43:48 +0100
In-Reply-To: <cover.1739864467.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739864467.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <886af241b1b809f149695489b0d8281a66cdde90.1739864467.git.dvyukov@google.com>
Subject: [PATCH v2 4/4] selftests/rseq: Add test for rseq+pkeys
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

---
Changes in v2:
 - change test to install protected rseq_cs instead of rseq
---
 tools/testing/selftests/rseq/Makefile    |  2 +-
 tools/testing/selftests/rseq/pkey_test.c | 66 ++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h      |  1 +
 3 files changed, 68 insertions(+), 1 deletion(-)

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
index 0000000000000..0bca8fda9aa92
--- /dev/null
+++ b/tools/testing/selftests/rseq/pkey_test.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Ensure that rseq works when rseq data is protected with PKEYs.
+ */
+
+#define _GNU_SOURCE
+#include <err.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "rseq.h"
+#include "rseq-abi.h"
+
+int main(int argc, char **argv)
+{
+	struct rseq_abi_cs *cs;
+	__u32 *sig;
+	unsigned long page_size;
+	int pkey, i;
+
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
+	page_size = getpagesize();
+	cs = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		MAP_ANON | MAP_PRIVATE, -1, 0);
+	if (cs == MAP_FAILED)
+		err(1, "mmap failed");
+	/* Create valid rseq_cs. */
+	sig = (__u32 *)(cs + 1);
+	*sig = RSEQ_SIG;
+	cs->abort_ip = (__u64)(sig + 1);
+	if (pkey_mprotect(cs, page_size, PROT_READ | PROT_WRITE, pkey))
+		err(1, "pkey_mprotect failed");
+	if (pkey_set(pkey, PKEY_DISABLE_ACCESS))
+		err(1, "pkey_set failed");
+
+	/* Install pkey-protected rseq_cs. */
+	rseq_get_abi()->rseq_cs.ptr64 = (__u64)cs;
+
+	/*
+	 * If the kernel misbehaves, context switches in the following loop
+	 * will terminate the process with SIGSEGV.
+	 */
+	for (i = 0; i < 10; i++)
+		usleep(100);
+
+	/*
+	 * Ensure that the kernel has restored the previous value of pkeys
+	 * register after changing it.
+	 */
+	if (pkey_get(pkey) != PKEY_DISABLE_ACCESS)
+		errx(1, "pkey protection has changed");
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



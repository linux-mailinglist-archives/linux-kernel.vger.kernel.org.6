Return-Path: <linux-kernel+bounces-517477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7044EA38157
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 441F716651B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB14217655;
	Mon, 17 Feb 2025 11:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9CmxqLc"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A52185AC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 11:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739790503; cv=none; b=Ymdl+DqqeVwKS2Fm18gRLDHcXiKofhqiJ6sZ+DHW4cHtT4Qi+FKObkHdEinKBnuDbOSrvKOQYe15Og0jvdrFVdPb6ReO6EXxkm7fF+z1FXO+2Jt4QhvCSN/boRwkwJQx9bxxquqLOi+CEsw7HSE9eBHanjbme81UzYMMVW8N1nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739790503; c=relaxed/simple;
	bh=WAzuzjM6Ks8dio2noXsYrHe/p04Duhc8IbDQx4wZxFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lG5XQOPXvRktRQWICTCoF+GH+XKno8F2la379darn7c7o7q4T1GKw19loYA7ofZH9kTsZCnobf7g2qArLdLLD5Vh9PFWd7uk0MvVZppi6XhZ+FFPaMBDfkwdZNswBeOucK5D4+8M/JwGtWMZ4FhmL6vyp3NCEC+7I0C4VT0sfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U9CmxqLc; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dvyukov.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5d9f21e17cfso3871628a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 03:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739790500; x=1740395300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb66uc443nDbWuK3toUJ0Z6Cs2Z06kbJxukaw4+lcIA=;
        b=U9CmxqLc8iU+y3NiVAsmY1ePTPkhFf/abf276VQBvNcee/ArCci8t08MHggtrN7Aek
         X2jMnEl+kvZ1kF2ONrgrmNxLUoUpMRsiCTHSvyALSIPaYMda9Dm/YtDhKiIIuDl5Kxxl
         O/QrgI59GKmlLWopxfaZ4bFdTIfM2eTUa114TKArMrZ4RlguWxkOaw/F1yTQrcGIBQQh
         oqpR4aUOP7vZMbbbkxE4Iq0c7swMC8yNsC3jg63LK9EI7HnQskX+tDjcxXD/Pw3wzxGN
         R8bohBF1zr01dPzzeRsLWsfhxfhvs0fTYafD4aP5pDT1/6ZhPgskbEF0akaUMxjrioeF
         Y9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739790500; x=1740395300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb66uc443nDbWuK3toUJ0Z6Cs2Z06kbJxukaw4+lcIA=;
        b=f7gVAupAKvN5Shbn8YJi2fwu89p+kUsWvgRPSvJ5tsN6SePzl7huIsAGn+KvR2mVkb
         xtn2rnU0J+bUp8j7bBcm+dYFxx+D8p6FjbJ8vonUigTa0PNuGIoxInZHcB/McYYeQKyq
         xreDud8si/WXldkLI39WXZskBMNc6IaotEisztdkPE7P5n8EW8izFJrlck3MeBFkNDQv
         w7oa2iZOSy4+UlB5sIkgm0y3YEtmTzAedTZIw+Egmyt3mk2J3sh2DJKao2VPklpxB1Ba
         PAOzwpkfv7b+cNkTkTFGmHpHFSEsia65/h1DAg6ejnHF9XVBD2szk8ZyTtbVWqeRg86y
         W5/g==
X-Forwarded-Encrypted: i=1; AJvYcCWnRvQCnm0hbZdNXvFHmkv8GjJaD6l3zm3NAImaPSMIexRahFZ/N52TgHxmeikZ8YghqbX5a0bBn2+q6rA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZancIJGipMWurvX7XpiYd1BmF3zDyWDDIkVnDDaYhU2xSHs6e
	MmojAHuND3aXyYHmr8Zw/AL0GS89oe+sIE7f9A3FgQCkTp5TzrquJg4HQES/0XO4Nly4LvkqDMM
	Uc2pzqQ==
X-Google-Smtp-Source: AGHT+IGTc8d+wdd82IxUEvpomANS1pvZvlByXVXhJSapi/R0WJN57yNtVnLq30jTjFuryoqlGhXiKlbNt10m
X-Received: from edwc19.prod.google.com ([2002:a05:6402:1213:b0:5dc:18c7:55df])
 (user=dvyukov job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5210:b0:5de:dc08:9cc5
 with SMTP id 4fb4d7f45d1cf-5e0360a1fb6mr8784483a12.7.1739790499947; Mon, 17
 Feb 2025 03:08:19 -0800 (PST)
Date: Mon, 17 Feb 2025 12:07:33 +0100
In-Reply-To: <cover.1739790300.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739790300.git.dvyukov@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <1f0cd73072eb321fb5f6993cbcb9b2e67ba6355d.1739790300.git.dvyukov@google.com>
Subject: [PATCH 4/4] selftests/rseq: Add test for rseq+pkeys
From: Dmitry Vyukov <dvyukov@google.com>
To: mathieu.desnoyers@efficios.com, peterz@infradead.org, boqun.feng@gmail.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com, 
	elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test that ensures that PKEY-protected struct rseq works
and does not lead to process kills.

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
 tools/testing/selftests/rseq/Makefile    |  2 +-
 tools/testing/selftests/rseq/pkey_test.c | 61 ++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)

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
index 0000000000000..ba5c1f6e99ab5
--- /dev/null
+++ b/tools/testing/selftests/rseq/pkey_test.c
@@ -0,0 +1,61 @@
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
+#include <sys/syscall.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	void *rseq;
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
+	/*
+	 * Prevent glibc from registering own struct rseq.
+	 * We need to know the rseq address to protect it, but also we need
+	 * it to be placed on own page that does not contain other data
+	 * (e.g. errno).
+	 */
+	if (!getenv("RSEQ_TEST_REEXECED")) {
+		setenv("RSEQ_TEST_REEXECED", "1", 1);
+		setenv("GLIBC_TUNABLES", "glibc.pthread.rseq=0", 1);
+		if (execvpe(argv[0], argv, environ))
+			err(1, "execvpe failed");
+	}
+
+	page_size = getpagesize();
+	rseq = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		MAP_ANON | MAP_PRIVATE, -1, 0);
+	if (rseq == MAP_FAILED)
+		err(1, "mmap failed");
+	if (pkey_mprotect(rseq, page_size, PROT_READ | PROT_WRITE, pkey))
+		err(1, "pkey_mprotect failed");
+	if (syscall(__NR_rseq, rseq, 32, 0, 0))
+		err(1, "rseq failed");
+	if (pkey_set(pkey, PKEY_DISABLE_ACCESS))
+		err(1, "pkey_set failed");
+
+	/*
+	 * If the kernel misbehaves, context switches in the following loop
+	 * will kill the process with SIGSEGV.
+	 */
+	for (i = 0; i < 10; i++)
+		usleep(100);
+	return 0;
+}
-- 
2.48.1.601.g30ceb7b040-goog



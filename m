Return-Path: <linux-kernel+bounces-537647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BBA48EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447BA3B6C2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5FF015A864;
	Fri, 28 Feb 2025 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EmykgpXy"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6617BA3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709869; cv=none; b=DWOHQuYUCF8G3Ik9DYA/V/F64eXMFzRZEKSRrNTJ6zCeG61JBpbLk+M2/sGr9nk3R5BxOdpROY4NhSEKHAnGI11LuBKN6TP0feffImdTeCqf9sbF1G+y3jadREW83H5253wYEio0LuIpZKT897HFQLQAL4uWZmazZ8LSqjEXJfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709869; c=relaxed/simple;
	bh=swtR6F88cbKVzdm+NrDTVhCXo1eYZDF79C/l4caSVJw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoHpx/0VaJefphwzM44wOY/ZEjxZ4Y8MirHqil7rIVxIyvzFKL6DxpOMr62e/G4FUYuoDzl0oBr3/q6FDAWLWy4/ZCCbT8YFjfLU6JPYIgyZDysWPYHWbUoiM6G0aFAr+lVzntnwHhBM0eVz27ZlAtJOiGkjDSP2q5znjLx8Uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=EmykgpXy; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1740709859;
	bh=swtR6F88cbKVzdm+NrDTVhCXo1eYZDF79C/l4caSVJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EmykgpXy1gGmyGYdH0Q9n3pB/kU2w6Z3jdYPyOvETkpaoGinxXvL1ftzDJpxQJPvK
	 j0oZXtAv7ioeBglEIpSY51zV/Ugg3IG1XhBIUIbChKCG24IjOUo5gB8Pe3b5qEsJM6
	 mSQmWfl8KVSZVxipAgi5zAaB1lzi3Kw9Sz0KTrC2f+p7aUSV8jSooEL7dJFXMpWp/v
	 tD+68xfXySOK4qj8Lt5VYmXRiIbHB4vHa2FV12bda8FqrgYT/k/moNPDvIC2OM892K
	 Yh/xEw1QfT5GF8M63m55tigugUQxVpqSx8GtIbXPkSJA35wcSCuUmd7eFgt+6W1XOa
	 K55eaNV4x+onA==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z3sdb69Mgzylf;
	Thu, 27 Feb 2025 21:30:59 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/2] selftests/kskm: Introduce SKSM basic test
Date: Thu, 27 Feb 2025 21:30:43 -0500
Message-Id: <20250228023043.83726-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a basic selftest for SKSM. See ./basic_test -h for
options.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Olivier Dion <odion@efficios.com>
Cc: linux-mm@kvack.org
---
 tools/testing/selftests/sksm/.gitignore   |   2 +
 tools/testing/selftests/sksm/Makefile     |  14 ++
 tools/testing/selftests/sksm/basic_test.c | 217 ++++++++++++++++++++++
 3 files changed, 233 insertions(+)
 create mode 100644 tools/testing/selftests/sksm/.gitignore
 create mode 100644 tools/testing/selftests/sksm/Makefile
 create mode 100644 tools/testing/selftests/sksm/basic_test.c

diff --git a/tools/testing/selftests/sksm/.gitignore b/tools/testing/selftests/sksm/.gitignore
new file mode 100644
index 000000000000..0f5b0baa91e7
--- /dev/null
+++ b/tools/testing/selftests/sksm/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+basic_test
diff --git a/tools/testing/selftests/sksm/Makefile b/tools/testing/selftests/sksm/Makefile
new file mode 100644
index 000000000000..ec1a10783bda
--- /dev/null
+++ b/tools/testing/selftests/sksm/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+ OR MIT
+
+top_srcdir = ../../../..
+
+CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
+	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
+LDLIBS += -lpthread
+
+TEST_GEN_PROGS = basic_test
+
+include ../lib.mk
+
+$(OUTPUT)/%: %.c
+	$(CC) $(CFLAGS) $< $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/sksm/basic_test.c b/tools/testing/selftests/sksm/basic_test.c
new file mode 100644
index 000000000000..1a7571a999d2
--- /dev/null
+++ b/tools/testing/selftests/sksm/basic_test.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Basic test for SKSM.
+ */
+
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+#include <poll.h>
+
+#ifndef MADV_MERGE
+#define MADV_MERGE	26
+#endif
+
+#define PAGE_SIZE	4096
+
+#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
+
+static int opt_stop_at = 0, opt_pause = 0;
+
+struct test_page {
+	char array[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+};
+
+struct test_page2 {
+	char array[2 * PAGE_SIZE] __attribute__((aligned(PAGE_SIZE)));
+};
+
+/* identical to zero page. */
+static struct test_page zero;
+
+/* a1 and a2 are identical. */
+static struct test_page a1 = {
+	.array[0] = 0x42,
+	.array[1] = 0x42,
+};
+
+static struct test_page a2 = {
+	.array[0] = 0x42,
+	.array[1] = 0x42,
+};
+
+/* b1 and b2 are identical. */
+static struct test_page2 b1 = {
+	.array[0] = 0x43,
+	.array[1] = 0x43,
+	.array[PAGE_SIZE] = 0x44,
+	.array[PAGE_SIZE + 1] = 0x44,
+};
+
+static struct test_page2 b2 = {
+	.array[0] = 0x43,
+	.array[1] = 0x43,
+	.array[PAGE_SIZE] = 0x44,
+	.array[PAGE_SIZE + 1] = 0x44,
+};
+
+static void touch_pages(void *p, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i += PAGE_SIZE)
+		WRITE_ONCE(((char *)p)[i], ((char *)p)[i]);
+}
+
+static void test_step(char step)
+{
+	printf("\nTest step: <%c>\n", step);
+	if (opt_pause) {
+		printf("Press ENTER to continue...\n");
+		getchar();
+	}
+	if (opt_stop_at == step) {
+		poll(NULL, 0, -1);
+		exit(0);
+	}
+}
+
+static void show_usage(int argc, char **argv)
+{
+	printf("Usage : %s <OPTIONS>\n",
+		argv[0]);
+	printf("OPTIONS:\n");
+	printf("	[-s stop_at] Stop test at step A, B, C, D, E, or F and wait forever.\n");
+	printf("	[-p] Pause test between steps (await newline from the console).\n");
+	printf("	[-h] Show this help.\n");
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (argv[i][0] != '-')
+			continue;
+		switch (argv[i][1]) {
+		case 's':
+			if (argc < i + 2) {
+				show_usage(argc, argv);
+				return -1;
+			}
+			opt_stop_at = *argv[i + 1];
+			switch (opt_stop_at) {
+			case 'A':
+			case 'B':
+			case 'C':
+			case 'D':
+			case 'E':
+			case 'F':
+				break;
+			default:
+				show_usage(argc, argv);
+				return -1;
+			}
+			i++;
+			break;
+		case 'p':
+			opt_pause = 1;
+			i++;
+			break;
+		case 'h':
+			show_usage(argc, argv);
+			return 0;
+		default:
+			show_usage(argc, argv);
+			return -1;
+		}
+	}
+
+
+	printf("PID: %d\n", getpid());
+	printf("Shared mapping (write-protected)\n");
+
+	test_step('A');
+
+	printf("madvise MADV_MERGE a1\n");
+	if (madvise(&a1, sizeof(a1), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE a2\n");
+	if (madvise(&a2, sizeof(a2), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE b1\n");
+	if (madvise(&b1, sizeof(b1), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE b2\n");
+	if (madvise(&b2, sizeof(b2), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE zero\n");
+	if (madvise(&zero, sizeof(zero), MADV_MERGE))
+		goto error;
+
+	test_step('B');
+
+	printf("Trigger COW\n");
+	touch_pages(&zero, sizeof(zero));
+	touch_pages(&a1, sizeof(a1));
+	touch_pages(&a2, sizeof(a2));
+	touch_pages(&b1, sizeof(b1));
+	touch_pages(&b2, sizeof(b2));
+
+	test_step('C');
+
+	printf("madvise MADV_MERGE a1\n");
+	if (madvise(&a1, sizeof(a1), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE a2\n");
+	if (madvise(&a2, sizeof(a2), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE b1\n");
+	if (madvise(&b1, sizeof(b1), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE b2\n");
+	if (madvise(&b2, sizeof(b2), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE zero\n");
+	if (madvise(&zero, sizeof(zero), MADV_MERGE))
+		goto error;
+
+	test_step('D');
+
+	printf("Trigger COW\n");
+	touch_pages(&zero, sizeof(zero));
+	touch_pages(&a1, sizeof(a1));
+	touch_pages(&a2, sizeof(a2));
+	touch_pages(&b1, sizeof(b1));
+	touch_pages(&b2, sizeof(b2));
+
+	test_step('E');
+
+	printf("madvise MADV_MERGE a1\n");
+	if (madvise(&a1, sizeof(a1), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE a2\n");
+	if (madvise(&a2, sizeof(a2), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE b1\n");
+	if (madvise(&b1, sizeof(b1), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE b2\n");
+	if (madvise(&b2, sizeof(b2), MADV_MERGE))
+		goto error;
+	printf("madvise MADV_MERGE zero\n");
+	if (madvise(&zero, sizeof(zero), MADV_MERGE))
+		goto error;
+
+	test_step('F');
+
+	return 0;
+
+error:
+	perror("madvise");
+	return -1;
+}
-- 
2.39.5



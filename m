Return-Path: <linux-kernel+bounces-440797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A29EC45E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B31167ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 05:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D157E1C1F34;
	Wed, 11 Dec 2024 05:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUfnmVmL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF6333993
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895196; cv=none; b=I0/CkwO5LmuJHyB40PEFIrjjtFdlMhsxWgA4IjjdOWf0htAz3yDvFuTNq57zfQqIhQs+vD8h4yCkC4HP1dmZ/1gjLlh4etIFn0pDnXn5jhViSd+l4e71HdgDDVA/WGPrxZPTtSPzJ28Kzt1PKPVD4Zg+jL+0d54O/jpI1DLWpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895196; c=relaxed/simple;
	bh=OF6oI5ueIyKXJT8qJr+f0gd7PmjRNdlzpvD5cy4jzzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JG1Vj1MEN/xLA3bEJ75dN0nA0NehJdD+sHm84CF2194DZ9lH1pngA02h5blra1GjV6iVajG84sXRRx6hAYw1wLLIrAFUvF9cOOG4X3igHoXPYKa9f2nL/tsfBLMsiFPn2aZnTUAzZerC4d1YL3TQn0yA7IjdXFaQuduz1mQ8uDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OUfnmVmL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21564262babso6755765ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 21:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733895194; x=1734499994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL0S77s8sue7wDSiMx9oEAzjFbMEM/4/98X0yr6AQos=;
        b=OUfnmVmLl523pj5fMGGCcK0Kq+135N2kwf1umg8GDvjQaOoNlZHi3e/uFu+cu4e45X
         4yDYJKg6YBDvEyWBVlLEsc5BpJ7yyOXxinWjbtiH588T+/Pv1RUVUGmEeL/+KpqKh7j+
         igflwiewZNQJs2iVv+4MqMriL8vv8GZBSveeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733895194; x=1734499994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL0S77s8sue7wDSiMx9oEAzjFbMEM/4/98X0yr6AQos=;
        b=osKcLk3lfw3C9pZyMlBt5HZW2mciAUu2SkVpbY42wPL2V29oRsKb/gsfvUt3mDtXml
         U9NZYpI/AE1L8zgzkGfvDyZareaaFlrGZ1xcG41DxKj7qjRq2x+A1hWjrv78AFn0BF5F
         dAynzCXR+68WL4M0Q+ce0yykTZzxjbQL/ow3QDc3guQimbLYY87lPB7HVks9MRk7g/fW
         +xpUCay3A2l892liPkwKwpOYV7Z22WnX8p21DtRD3jt/9G/jfOEF0/5rAxxk3DEkVOT5
         TZxowTp2znrpq/3UtzMJkiOz/HjWkmmvCM7dxo6Ht50g8kzbAnCAnd4+5qyZk8+xKnvI
         xJ3Q==
X-Gm-Message-State: AOJu0YybJdl85D2H6lpKkV9DwlE56DY9wOR/8APb8P6mg6cA4rjF8mYf
	HOKVZ2SqbnEvja/tvqN7dFrQIfwPiZHkkCRFZa9AZohFMXUDFdcT43M8Lrc3lQ==
X-Gm-Gg: ASbGnct6Ahsit17hsVq7Eyt9c7GU4gkeJeyKqbQR999D04HXN/1/BYCPsrcDfj1/m/Y
	bGpAzs0eXIRoNwgYEHfLLkGLTaSo4jbJlsn/Mm6JIWYkaLf9QPHGdJvPpwx5c9Iuj3KDSYeJbhl
	+ur4e8hQZkHfcSsMUPIZH4/RHAT9JTe6EsbZyBRGdqAkG1PSSgkHdb11r5FS42OJbHqCHVGHG5H
	spnEWejaIYzW89926yODF3Upo8E1s6mIJ/l9CnhWxQfrS63xFXDTnCB17mWCJ7djS2Prl3CUV4v
	PYd+83acgL7Q4eE=
X-Google-Smtp-Source: AGHT+IEodioB8WIDbacAHjqbGik1UB8Zl0dTrnRUlOKRwzSo0V/bCLKhgz9DK/mJjkSKbCn4PnTMlA==
X-Received: by 2002:a17:902:ec84:b0:215:5926:2db2 with SMTP id d9443c01a7336-2177851de76mr10375475ad.7.1733895194123;
        Tue, 10 Dec 2024 21:33:14 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2162b13d486sm66496625ad.191.2024.12.10.21.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 21:33:13 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	broonie@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	jannh@google.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 1/1] selftest/mm: refactor mseal_test
Date: Wed, 11 Dec 2024 05:33:11 +0000
Message-ID: <20241211053311.245636-2-jeffxu@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241211053311.245636-1-jeffxu@google.com>
References: <20241211053311.245636-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

This change creates the initial version of memorysealing.c.

The introduction of memorysealing.c, which replaces mseal_test.c and
uses the kselftest_harness, aims to initiate a discussion on using the
selftest harness for memory sealing tests. Upon approval of this
approach, the migration of tests from mseal_test.c to memorysealing.c
can be implemented in a step-by-step manner.

This tests addresses following feedback from previous reviews:

1> Use kselftest_harness instead of custom macro, such as EXPECT_XX,
ASSERT_XX, etc.  (Lorenzo Stoakes, Mark Brown) [1]

2> Use MAP_FAILED to check the return of mmap (Lorenzo Stoakes).

3>  Adding a check for vma size and prot bits. The discussion for
    this can be found in [2] [3], here is a brief summary:
    This is to follow up on Pedro’s in-loop change (from
    can_modify_mm to can_modify_vma). When mseal_test is initially
    created, they have a common pattern:  setup memory layout,
    seal the memory, perform a few mm-api steps, verify return code
    (not zero).  Because of the nature of out-of-loop,  it is sufficient
    to just verify the error code in a few cases.

    With Pedro's in-loop change, the sealing check happens later in the
    stack, thus there are more things and scenarios to verify. And there
    was feedbacks to me that mseal_test should be extensive enough to
    discover all regressions. Hence I'm adding check for vma size and prot
    bits.

In this change: we created two fixtures:

Fixture basic:   This creates a single VMA, the VMA has a
PROT_NONE page at each end to prevent auto-merging.

Fixture wo_vma: Two VMAs back to end, a PROT_NONE page at each
end to prevent auto-merging.

In addition, I add one test (mprotec) in each fixture to demo the tests.

[1] https://lore.kernel.org/all/20240830180237.1220027-5-jeffxu@chromium.org/
[2] https://lore.kernel.org/all/CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com/
[3] https://lore.kernel.org/all/2qywbjb5ebtgwkh354w3lj3vhaothvubjokxq5fhyri5jeeton@duqngzo3swjz/

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/.gitignore      |   1 +
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/memorysealing.c | 182 +++++++++++++++++++++
 tools/testing/selftests/mm/memorysealing.h | 116 +++++++++++++
 tools/testing/selftests/mm/mseal_test.c    |  67 +-------
 5 files changed, 301 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/mm/memorysealing.c
 create mode 100644 tools/testing/selftests/mm/memorysealing.h

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index a51a947b2d1d..982234a99f20 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -57,3 +57,4 @@ hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-pages
+memorysealing
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 93a46ac633df..08876624f46d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -67,6 +67,7 @@ TEST_GEN_FILES += map_populate
 ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
 TEST_GEN_FILES += memfd_secret
 endif
+TEST_GEN_FILES += memorysealing
 TEST_GEN_FILES += migration
 TEST_GEN_FILES += mkdirty
 TEST_GEN_FILES += mlock-random-test
diff --git a/tools/testing/selftests/mm/memorysealing.c b/tools/testing/selftests/mm/memorysealing.c
new file mode 100644
index 000000000000..e10032528b64
--- /dev/null
+++ b/tools/testing/selftests/mm/memorysealing.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <asm-generic/unistd.h>
+#include <errno.h>
+#include <syscall.h>
+#include "memorysealing.h"
+
+/*
+ * To avoid auto-merging, create a VMA with PROT_NONE pages at each end.
+ * If unsuccessful, return MAP_FAILED.
+ */
+static void *setup_single_address(int size, int prot)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+
+	ptr = mmap(NULL, size + 2 * page_size, prot,
+		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+
+	if (ptr == MAP_FAILED)
+		return MAP_FAILED;
+
+	/* To avoid auto-merging, change to PROT_NONE at each end. */
+	ret = sys_mprotect(ptr, page_size, PROT_NONE);
+	if (ret != 0)
+		return MAP_FAILED;
+
+	ret = sys_mprotect(ptr + size + page_size, page_size, PROT_NONE);
+	if (ret != 0)
+		return MAP_FAILED;
+
+	return ptr + page_size;
+}
+
+FIXTURE(basic)
+{
+	unsigned long page_size;
+	unsigned long size;
+	void *ptr;
+};
+
+/*
+ * Setup for basic:
+ * Single VMA with 4 pages, prot = (PROT_READ | PROT_WRITE).
+ */
+FIXTURE_SETUP(basic)
+{
+	int prot;
+
+	self->page_size = getpagesize();
+
+	if (!mseal_supported())
+		SKIP(return, "mseal is not supported");
+
+	/* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRITE. */
+	self->size = self->page_size * 4;
+	self->ptr = setup_single_address(self->size, PROT_READ | PROT_WRITE);
+	EXPECT_NE(self->ptr, MAP_FAILED);
+
+	EXPECT_EQ(self->size, get_vma_size(self->ptr, &prot));
+	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
+};
+
+FIXTURE_TEARDOWN(basic)
+{
+}
+
+FIXTURE(two_vma)
+{
+	unsigned long page_size;
+	unsigned long size;
+	void *ptr;
+};
+
+/*
+ * Setup for two_vma:
+ * Two consecutive VMAs, each with 2 pages.
+ * The first VMA:  prot = PROT_READ.
+ * The second VMA: prot = (PROT_READ | PROT_WRITE).
+ */
+FIXTURE_SETUP(two_vma)
+{
+	int prot;
+	int ret;
+
+	self->page_size = getpagesize();
+
+	if (!mseal_supported())
+		SKIP(return, "mseal is not supported");
+
+	/* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRITE. */
+	self->size = getpagesize() * 4;
+	self->ptr = setup_single_address(self->size, PROT_READ | PROT_WRITE);
+	EXPECT_NE(self->ptr, MAP_FAILED);
+
+	/* Use mprotect to split as two VMA. */
+	ret = sys_mprotect(self->ptr, self->page_size * 2, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify the first VMA is 2 pages and prot bits */
+	EXPECT_EQ(self->page_size * 2, get_vma_size(self->ptr, &prot));
+	EXPECT_EQ(PROT_READ, prot);
+
+	/* Verify the second VMA is 2 pages and prot bits */
+	EXPECT_EQ(self->page_size * 2,
+		get_vma_size(self->ptr + self->page_size * 2, &prot));
+	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
+};
+
+FIXTURE_TEARDOWN(two_vma)
+{
+}
+
+/*
+ * Verify mprotect is blocked.
+ */
+TEST_F(basic, mprotect_basic)
+{
+	int ret;
+	unsigned long size;
+	int prot;
+
+	/* Seal the mapping. */
+	ret = sys_mseal(self->ptr, self->size, 0);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify mprotect is blocked. */
+	ret = sys_mprotect(self->ptr, self->size, PROT_READ);
+	EXPECT_GT(0, ret);
+	EXPECT_EQ(EPERM, errno);
+
+	/* Verify the VMA (sealed) isn't changed */
+	size = get_vma_size(self->ptr, &prot);
+	EXPECT_EQ(self->size, size);
+	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
+}
+
+/*
+ * Seal both VMAs in one mseal call.
+ * Verify mprotect is blocked on both VMAs in various cases.
+ */
+TEST_F(two_vma, mprotect)
+{
+	int ret;
+	int prot;
+	unsigned long size;
+
+	/* Seal both VMAs in one mseal call. */
+	ret = sys_mseal(self->ptr, self->size, 0);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify mprotect is rejected on the first VMA. */
+	ret = sys_mprotect(self->ptr, self->page_size * 2,
+		PROT_READ | PROT_EXEC);
+	EXPECT_GT(0, ret);
+	EXPECT_EQ(EPERM, errno);
+
+	/* Verify mprotect is rejected on the second VMA. */
+	ret = sys_mprotect(self->ptr, self->page_size * 2,
+		PROT_READ | PROT_EXEC);
+	EXPECT_GT(0, ret);
+	EXPECT_EQ(EPERM, errno);
+
+	/* Attempt of mprotect two VMAs at the same call is blocked */
+	ret = sys_mprotect(self->ptr, self->size,
+		PROT_READ | PROT_EXEC);
+	EXPECT_GT(0, ret);
+	EXPECT_EQ(EPERM, errno);
+
+	/* Verify both VMAs aren't changed. */
+	size = get_vma_size(self->ptr, &prot);
+	EXPECT_EQ(self->page_size * 2, size);
+	EXPECT_EQ(PROT_READ, prot);
+
+	size = get_vma_size(self->ptr + self->page_size * 2, &prot);
+	EXPECT_EQ(self->page_size * 2, size);
+	EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/memorysealing.h b/tools/testing/selftests/mm/memorysealing.h
new file mode 100644
index 000000000000..aee6e6700028
--- /dev/null
+++ b/tools/testing/selftests/mm/memorysealing.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <syscall.h>
+
+/*
+ * Define sys_xyx to call syscall directly.
+ * This is needed because we want to avoid calling glibc and
+ * test syscall directly.
+ * The only exception is mmap, which _NR_mmap2 is not defined for
+ * some ARM architecture.
+ */
+static inline int sys_mseal(void *start, size_t len, unsigned long flags)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mseal, start, len, flags);
+	return sret;
+}
+
+static inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_mprotect, ptr, size, prot);
+	return sret;
+}
+
+static inline int sys_mprotect_pkey(void *ptr, size_t size,
+	unsigned long orig_prot, unsigned long pkey)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
+	return sret;
+}
+
+static inline int sys_munmap(void *ptr, size_t size)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_munmap, ptr, size);
+	return sret;
+}
+
+static inline int sys_madvise(void *start, size_t len, int types)
+{
+	int sret;
+
+	errno = 0;
+	sret = syscall(__NR_madvise, start, len, types);
+	return sret;
+}
+
+static inline void *sys_mremap(void *addr, size_t old_len, size_t new_len,
+	unsigned long flags, void *new_addr)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
+	return sret;
+}
+
+/*
+ * Parsing /proc/self/maps to get VMA's size and prot bit.
+ */
+static unsigned long get_vma_size(void *addr, int *prot)
+{
+	FILE *maps;
+	char line[256];
+	int size = 0;
+	uintptr_t  addr_start, addr_end;
+	char protstr[5];
+	*prot = 0;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!maps)
+		return 0;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) == 3) {
+			if (addr_start == (uintptr_t) addr) {
+				size = addr_end - addr_start;
+				if (protstr[0] == 'r')
+					*prot |= PROT_READ;
+				if (protstr[1] == 'w')
+					*prot |= PROT_WRITE;
+				if (protstr[2] == 'x')
+					*prot |= PROT_EXEC;
+				break;
+			}
+		}
+	}
+	fclose(maps);
+	return size;
+}
+
+static inline bool mseal_supported(void)
+{
+	int ret;
+	void *ptr;
+	unsigned long page_size = getpagesize();
+
+	ptr = mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (ptr == MAP_FAILED)
+		return false;
+
+	ret = sys_mseal(ptr, page_size, 0);
+	if (ret < 0)
+		return false;
+
+	return true;
+}
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index ad17005521a8..8dd20341de3d 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -517,30 +517,6 @@ static void test_seal_twice(void)
 	REPORT_TEST_PASS();
 }
 
-static void test_seal_mprotect(bool seal)
-{
-	void *ptr;
-	unsigned long page_size = getpagesize();
-	unsigned long size = 4 * page_size;
-	int ret;
-
-	setup_single_address(size, &ptr);
-	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
-
-	if (seal) {
-		ret = seal_single_address(ptr, size);
-		FAIL_TEST_IF_FALSE(!ret);
-	}
-
-	ret = sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
-	if (seal)
-		FAIL_TEST_IF_FALSE(ret < 0);
-	else
-		FAIL_TEST_IF_FALSE(!ret);
-
-	REPORT_TEST_PASS();
-}
-
 static void test_seal_start_mprotect(bool seal)
 {
 	void *ptr;
@@ -658,41 +634,6 @@ static void test_seal_mprotect_unalign_len_variant_2(bool seal)
 	REPORT_TEST_PASS();
 }
 
-static void test_seal_mprotect_two_vma(bool seal)
-{
-	void *ptr;
-	unsigned long page_size = getpagesize();
-	unsigned long size = 4 * page_size;
-	int ret;
-
-	setup_single_address(size, &ptr);
-	FAIL_TEST_IF_FALSE(ptr != (void *)-1);
-
-	/* use mprotect to split */
-	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
-	FAIL_TEST_IF_FALSE(!ret);
-
-	if (seal) {
-		ret = seal_single_address(ptr, page_size * 4);
-		FAIL_TEST_IF_FALSE(!ret);
-	}
-
-	ret = sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
-	if (seal)
-		FAIL_TEST_IF_FALSE(ret < 0);
-	else
-		FAIL_TEST_IF_FALSE(!ret);
-
-	ret = sys_mprotect(ptr + page_size * 2, page_size * 2,
-			PROT_READ | PROT_WRITE);
-	if (seal)
-		FAIL_TEST_IF_FALSE(ret < 0);
-	else
-		FAIL_TEST_IF_FALSE(!ret);
-
-	REPORT_TEST_PASS();
-}
-
 static void test_seal_mprotect_two_vma_with_split(bool seal)
 {
 	void *ptr;
@@ -1876,7 +1817,7 @@ int main(void)
 	if (!pkey_supported())
 		ksft_print_msg("PKEY not supported\n");
 
-	ksft_set_plan(88);
+	ksft_set_plan(84);
 
 	test_seal_addseal();
 	test_seal_unmapped_start();
@@ -1889,9 +1830,6 @@ int main(void)
 	test_seal_zero_length();
 	test_seal_twice();
 
-	test_seal_mprotect(false);
-	test_seal_mprotect(true);
-
 	test_seal_start_mprotect(false);
 	test_seal_start_mprotect(true);
 
@@ -1904,9 +1842,6 @@ int main(void)
 	test_seal_mprotect_unalign_len_variant_2(false);
 	test_seal_mprotect_unalign_len_variant_2(true);
 
-	test_seal_mprotect_two_vma(false);
-	test_seal_mprotect_two_vma(true);
-
 	test_seal_mprotect_two_vma_with_split(false);
 	test_seal_mprotect_two_vma_with_split(true);
 
-- 
2.47.1.613.gc27f4b7a9f-goog



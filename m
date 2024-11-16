Return-Path: <linux-kernel+bounces-411553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0523E9CFBD3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 01:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6891F2395C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 00:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A678979F6;
	Sat, 16 Nov 2024 00:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R4j8JudF"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C54F1854
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731718264; cv=none; b=A7KUC7PfapfdQutsuwGnsBHp3IU439573PbgUlVlo63Nuz/Ef8jEor+JGRoNCAku0X8fTXmLNRFVtAlyrZVHZY0Et4cmru6twEHo3HaqK9fZ/zYhWcEui7+VQ9eIXOB6d2SMFTssYVQGEBY9Vo1UzJ64z7sK6FftZThDJLIpgzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731718264; c=relaxed/simple;
	bh=MdHwW6XaTHg49BNo0eZKU/Fd58QGJzfP4e3gtbCFu8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CUmcUfnS4O3Tm10JB9RJVQAKBUo5ASB3UdMN0Dg+P1bVbOYY3G1RRNBm9u3xVY/5hRTAFF/SNpfsrNhsXc5ps5HtCy/w2eS1mXZuOOIDslwBolfkpuCvMJPtZgkxkaK5sqdswaE2iEYgRSUrPsKo5PfBC4LlxRrsbzXB1HhOSRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=R4j8JudF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72458778447so183931b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731718262; x=1732323062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OTklPY0QALxtPYDVAKnfGC6P1pEseSuX9K+uwN76nU=;
        b=R4j8JudFqrdCt/3Hs4YMCqq+q3Xt4jMX9IXqlzmch2mdNek+Fx0asVGOKMt9omJIPt
         /qMW3IloWaWkcDfgEN16YPFzZc02sbEDaTta8RtFYClLIyhyX6mVo/GeJB545Dk+IDz1
         VHoAjiCGdQYQMAn6lPw5cnagtYvl7MetFwZos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731718262; x=1732323062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OTklPY0QALxtPYDVAKnfGC6P1pEseSuX9K+uwN76nU=;
        b=qLafuLjvGCE0I48OBd5C+vy9IdwnPx6lnjPySQi97dmqn+8f9Pbjxo9iIsTsXXu2vm
         kAVUzmh6ResDiXpZZ5xU4vQ8J8B3MJgUTwOq1DGx/jhQwvb7KMKnxrG9AB2ki1FPsoic
         wvY4h2PXBtESryHgFzs7aMDVgj8uY65FX2k74K/FBaQgtao+FfAXorCRwnttGa686q9d
         UrZgF6XEXPI44elf3FsczWEXcQbZayHUqJBBE4UUwd/OpJjtKTURhiYU/gzgQprvqwQ8
         8u74O6BqPBXftlym16D7psFxI7khQqoZ9NXgdBF8SWGvXAGfdeLJF7w1/2/uugfDXmSh
         G3ZA==
X-Gm-Message-State: AOJu0YwbwkRWIeyJrCDETizG8kaF+yKD5PwuSmUFXIhXnya9GA+pPd/P
	3xohvf9VRKfjtlr3oNC3mBqfqJaFIilLkN6JUdh/oJSnwY+pBA/YWLyVQbKv/Q==
X-Google-Smtp-Source: AGHT+IHCFGFxXTdc5NmJ9A5WfB9TAKESidMsf663Up34gRIwCYJ4a4J9fqZkmA9zxB6fNDrOQFC97w==
X-Received: by 2002:a05:6a00:21d4:b0:71e:4bda:71ec with SMTP id d2e1a72fcca58-72476d42f3dmr2444731b3a.4.1731718261613;
        Fri, 15 Nov 2024 16:51:01 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-724771c0d29sm2063055b3a.122.2024.11.15.16.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:51:01 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v1] selftest/mm: remove seal_elf
Date: Sat, 16 Nov 2024 00:50:58 +0000
Message-ID: <20241116005058.69091-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Remove seal_elf, which is a demo of mseal, we
no longer need this.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 tools/testing/selftests/mm/.gitignore |   1 -
 tools/testing/selftests/mm/Makefile   |   1 -
 tools/testing/selftests/mm/seal_elf.c | 137 --------------------------
 3 files changed, 139 deletions(-)
 delete mode 100644 tools/testing/selftests/mm/seal_elf.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 8f01f4da1c0d..6a273bdbc70b 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -49,7 +49,6 @@ va_high_addr_switch
 hugetlb_fault_after_madv
 hugetlb_madv_vs_map
 mseal_test
-seal_elf
 droppable
 hugetlb_dio
 pkey_sighandler_tests_32
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 72ec4403032d..869b6a40f290 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -64,7 +64,6 @@ TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += mseal_test
-TEST_GEN_FILES += seal_elf
 TEST_GEN_FILES += on-fault-limit
 TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += thuge-gen
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
deleted file mode 100644
index d9f8ba8d5050..000000000000
--- a/tools/testing/selftests/mm/seal_elf.c
+++ /dev/null
@@ -1,137 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-#include <sys/mman.h>
-#include <stdint.h>
-#include <asm-generic/unistd.h>
-#include <string.h>
-#include <sys/time.h>
-#include <sys/resource.h>
-#include <stdbool.h>
-#include "../kselftest.h"
-#include <syscall.h>
-#include <errno.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <sys/ioctl.h>
-#include <sys/vfs.h>
-#include <sys/stat.h>
-#include "mseal_helpers.h"
-
-/*
- * define sys_xyx to call syscall directly.
- */
-static int sys_mseal(void *start, size_t len)
-{
-	int sret;
-
-	errno = 0;
-	sret = syscall(__NR_mseal, start, len, 0);
-	return sret;
-}
-
-static inline int sys_mprotect(void *ptr, size_t size, unsigned long prot)
-{
-	int sret;
-
-	errno = 0;
-	sret = syscall(__NR_mprotect, ptr, size, prot);
-	return sret;
-}
-
-static bool seal_support(void)
-{
-	int ret;
-	void *ptr;
-	unsigned long page_size = getpagesize();
-
-	ptr = mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (ptr == (void *) -1)
-		return false;
-
-	ret = sys_mseal(ptr, page_size);
-	if (ret < 0)
-		return false;
-
-	return true;
-}
-
-const char somestr[4096] = {"READONLY"};
-
-static void test_seal_elf(void)
-{
-	int ret;
-	FILE *maps;
-	char line[512];
-	uintptr_t  addr_start, addr_end;
-	char prot[5];
-	char filename[256];
-	unsigned long page_size = getpagesize();
-	unsigned long long ptr = (unsigned long long) somestr;
-	char *somestr2 = (char *)somestr;
-
-	/*
-	 * Modify the protection of readonly somestr
-	 */
-	if (((unsigned long long)ptr % page_size) != 0)
-		ptr = (unsigned long long)ptr & ~(page_size - 1);
-
-	ksft_print_msg("somestr = %s\n", somestr);
-	ksft_print_msg("change protection to rw\n");
-	ret = sys_mprotect((void *)ptr, page_size, PROT_READ|PROT_WRITE);
-	FAIL_TEST_IF_FALSE(!ret);
-	*somestr2 = 'A';
-	ksft_print_msg("somestr is modified to: %s\n", somestr);
-	ret = sys_mprotect((void *)ptr, page_size, PROT_READ);
-	FAIL_TEST_IF_FALSE(!ret);
-
-	maps = fopen("/proc/self/maps", "r");
-	FAIL_TEST_IF_FALSE(maps);
-
-	/*
-	 * apply sealing to elf binary
-	 */
-	while (fgets(line, sizeof(line), maps)) {
-		if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]",
-			&addr_start, &addr_end, prot, filename) == 4) {
-			if (strlen(filename)) {
-				/*
-				 * seal the mapping if read only.
-				 */
-				if (strstr(prot, "r-")) {
-					ret = sys_mseal((void *)addr_start, addr_end - addr_start);
-					FAIL_TEST_IF_FALSE(!ret);
-					ksft_print_msg("sealed: %lx-%lx %s %s\n",
-						addr_start, addr_end, prot, filename);
-					if ((uintptr_t) somestr >= addr_start &&
-						(uintptr_t) somestr <= addr_end)
-						ksft_print_msg("mapping for somestr found\n");
-				}
-			}
-		}
-	}
-	fclose(maps);
-
-	ret = sys_mprotect((void *)ptr, page_size, PROT_READ | PROT_WRITE);
-	FAIL_TEST_IF_FALSE(ret < 0);
-	ksft_print_msg("somestr is sealed, mprotect is rejected\n");
-
-	REPORT_TEST_PASS();
-}
-
-int main(int argc, char **argv)
-{
-	bool test_seal = seal_support();
-
-	ksft_print_header();
-	ksft_print_msg("pid=%d\n", getpid());
-
-	if (!test_seal)
-		ksft_exit_skip("sealing not supported, check CONFIG_64BIT\n");
-
-	ksft_set_plan(1);
-
-	test_seal_elf();
-
-	ksft_finished();
-}
-- 
2.47.0.338.g60cca15819-goog



Return-Path: <linux-kernel+bounces-576455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21232A70F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380357A5FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6066616C684;
	Wed, 26 Mar 2025 03:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iMVtPqA+"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D56514B96E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742960315; cv=none; b=oU/Zem2cAcewcb1o3/KwgEYPvyAMJjLPsc2eRkWLB3BUJ8W7sE7VZXQrUAKoicfr4j6xoOLm34mrun8ZwhkVIUziFITFinxRiJ94gjgx2YYebpzGXnr0xJUW6Rz1h+UrjCj6G1ARSc5s+NLHDvqF6Ol57amtigS1SRQSZkXulnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742960315; c=relaxed/simple;
	bh=UrQoTHRlyNlyNlMyojiO33lh4yHUrggD+W4DSvNq4tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRGDGF/wV7JW7Rmejo08yhfcKFgHrqkdf0PmJNPm0ZckfVBbNEMUZfFxKV//p8sMmQ3yUbsbi2DebHvG8AlIxOe+e2gZRyVfvvlRNyQ72yMNsu6A5xllHUsraodC46/iZwKC5YgHwMKkIyV/Ohg6Mw+vphIDRE/5Sp2uQ+mcwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iMVtPqA+; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742960304; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MAxRD8P9W2N0YRcf5gQPGY2DJk1Zq+bjVf3MR/WuNdQ=;
	b=iMVtPqA+QAQKgF5/QKYzL92sXBywrRPAUdtTIUa31zXHbU32Cqwg7Zd/i2uXGoUJXQS75y8BBju57mPl62eHMoSx9yifAmQH3yXoyCtG6Z1c0ECaHk3yXZRUOzzAIHwzCTmtE2OvKkonZb/K/Lvm8rTlOqsDfKbRdxXqF0lz4Kc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WT1p3wj_1742960303 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 26 Mar 2025 11:38:23 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: mincore: fix tmpfs mincore test failure
Date: Wed, 26 Mar 2025 11:38:10 +0800
Message-ID: <99a3e190d38b08a2b96ede952a29893bffdb3432.1742960003.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1742960003.git.baolin.wang@linux.alibaba.com>
References: <cover.1742960003.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running mincore test cases, I encountered the following failures:

"
mincore_selftest.c:359:check_tmpfs_mmap:Expected ra_pages (511) == 0 (0)
mincore_selftest.c:360:check_tmpfs_mmap:Read-ahead pages found in memory
check_tmpfs_mmap: Test terminated by assertion
          FAIL  global.check_tmpfs_mmap
not ok 5 global.check_tmpfs_mmap
FAILED: 4 / 5 tests passed
"

The reason for the test case failure is that my system automatically enabled
tmpfs large folio allocation by adding the 'transparent_hugepage_tmpfs=always'
cmdline. However, the test case still expects the tmpfs mounted on /dev/shm to
allocate small folios, which leads to assertion failures when verifying readahead
pages.

To fix this issue, remount tmpfs to a new test directory and set the 'huge=never'
parameter to avoid allocating large folios, which can pass the test.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 .../selftests/mincore/mincore_selftest.c      | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e8d7a3a4739f 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -12,6 +12,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/mman.h>
+#include <sys/mount.h>
 #include <string.h>
 #include <fcntl.h>
 
@@ -283,7 +284,7 @@ TEST(check_file_mmap)
 	free(vec);
 }
 
-
+#define INPUT_MAX 80
 /*
  * Test mincore() behavior on a page backed by a tmpfs file.  This test
  * performs the same steps as the previous one. However, we don't expect
@@ -291,6 +292,9 @@ TEST(check_file_mmap)
  */
 TEST(check_tmpfs_mmap)
 {
+	char tmpfs_template[] = "/tmp/check_tmpfs_XXXXXX";
+	const char *tmpfs_loc = mkdtemp(tmpfs_template);
+	char testfile[INPUT_MAX];
 	unsigned char *vec;
 	int vec_size;
 	char *addr;
@@ -300,6 +304,10 @@ TEST(check_tmpfs_mmap)
 	int i;
 	int ra_pages = 0;
 
+	ASSERT_NE(NULL, tmpfs_loc) {
+		TH_LOG("Can't mkdir tmpfs dentry\n");
+	}
+
 	page_size = sysconf(_SC_PAGESIZE);
 	vec_size = FILE_SIZE / page_size;
 	if (FILE_SIZE % page_size)
@@ -311,7 +319,18 @@ TEST(check_tmpfs_mmap)
 	}
 
 	errno = 0;
-	fd = open("/dev/shm", O_TMPFILE | O_RDWR, 0600);
+	/* Do not use large folios for tmpfs mincore testing */
+	retval = mount("tmpfs", tmpfs_loc, "tmpfs", 0, "huge=never,size=4M");
+	ASSERT_EQ(0, retval) {
+		TH_LOG("Unable to mount tmpfs for testing\n");
+	}
+
+	retval = snprintf(testfile, INPUT_MAX, "%s/test_file", tmpfs_loc);
+	ASSERT_GE(INPUT_MAX, retval) {
+		TH_LOG("Unable to create a tmpfs for testing\n");
+	}
+
+	fd = open(testfile, O_CREAT|O_RDWR, 0664);
 	ASSERT_NE(-1, fd) {
 		TH_LOG("Can't create temporary file: %s",
 			strerror(errno));
@@ -363,6 +382,8 @@ TEST(check_tmpfs_mmap)
 	munmap(addr, FILE_SIZE);
 	close(fd);
 	free(vec);
+	umount(tmpfs_loc);
+	rmdir(tmpfs_loc);
 }
 
 TEST_HARNESS_MAIN
-- 
2.43.5



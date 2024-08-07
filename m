Return-Path: <linux-kernel+bounces-278578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E527A94B218
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B80DB24E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7273155A24;
	Wed,  7 Aug 2024 21:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hX5hehzd"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA2C1553A7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065810; cv=none; b=r6lZnx4PN45eQftnu6nI+2nLJ0aIc1NViUbbyAkQLeMlkizy9l1ePQFUs83brIRivAl2zGYNcBGTjswEfNj4LNwHqm1eLn6bXqHVDvZmRZnSDjFBplbCzKkqMkby/PM5tmf0iMTTwFi+KRqows8aJSjgqMVN6apgaUB7Hfr2KeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065810; c=relaxed/simple;
	bh=RVL2ZRF4WUT/8v2zpcjyefjSqJV50mC/w2Dpk8L0aZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m01TwRmwmzY0/oB/Dk8WIZ2wydJjw6sKLiOz1cVUgUSkpHQ99Iw7KJGdXFarkvcVCp5bRLtfchHP/ZdId6BoUI2+buOi1I13ARpA2GByhR2TmViy7j7MXwjfJ+HNvsflf6/zrOvj2/3CmIP9YCRqf9YHjPVgkDs84rQ4EX2ZpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hX5hehzd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4fccdd78so3268185ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723065805; x=1723670605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RzngvWp9gQDLjMpg4qmJfCwDpEym+on+6/0H0Fu3rEY=;
        b=hX5hehzdWlV1ssWtyr6NUnbnnRhPYd3p6GbwVmF0TRreEjM4hTPYteapNvcjDdiC1o
         0ft4uyiOxDsJveVI+XHdrQQKZ60KpJbd3SFpUK7Q4QbI06PVuzGSohCzhwIJsUj3W7C1
         zaEGgspFoMdnLINH5abG65BQa7H7uSZ4LvdJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065805; x=1723670605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzngvWp9gQDLjMpg4qmJfCwDpEym+on+6/0H0Fu3rEY=;
        b=BVeurahu4MufMHYZWadbxq+rCG3eck7gtTDHhjco9C0V+MBn2n/VgpkPyi9OO6FLaO
         nQmWiY7ooR/ZdPdtS4/RgpF3/t9BpP5xJTEeK2YvqMvitjVpZq62SMsfcGgeOuFTZPKX
         bYKnBf+yGk4HEgl/jH+HlQiJDLe4lFCBpM6RmH1Rhi7VQi/ZecaoC+HqnMgUz2/oU+rl
         yGLXZmMkltpgVqu2zejL/n4UnSdhojFNlKQdEYSfuNdNJyT6I1D22HLb7Ykd8cI2YeN9
         sYmOAv3C7DgrNibTutm8gkaAuPyHyZVtFg7CbUA8l5DjqNZpX5NmIX0pgnmJYTj6s0YO
         TmIg==
X-Forwarded-Encrypted: i=1; AJvYcCXF7+yx9zLi0VfXxC9qxgX7tdSvhYF3v7ZQ10mXQopieNOpLIrRZDPNq+NqJEKOsL58JegK3UAMMTAbUxNWyr9TQQkV5saNamF1BWvZ
X-Gm-Message-State: AOJu0Ywf+IbOzeJ3oo7Yef5Bf9iUiYzlsoO3P7FarcyQHgsNeUMhE4TB
	8j+tJnbq6KGNeGqFU45JeBh86kj0/rLNQMTKAP2mRbXYndLm1M2IsofxGbNJqQ==
X-Google-Smtp-Source: AGHT+IGwzaAwKwkzWZfQJR7sQNT2BHUu0cPXPvgMKZvVP2Y4msVjXFqhIZz2Nbr0jImAy+2leat17g==
X-Received: by 2002:a17:903:32c9:b0:1ff:52c:34ce with SMTP id d9443c01a7336-1ff574cac78mr219351345ad.53.1723065804353;
        Wed, 07 Aug 2024 14:23:24 -0700 (PDT)
Received: from localhost (25.11.145.34.bc.googleusercontent.com. [34.145.11.25])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1ff5905ff30sm110338885ad.156.2024.08.07.14.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 14:23:23 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	willy@infradead.org,
	torvalds@linux-foundation.org,
	Liam.Howlett@oracle.com,
	pedro.falcato@gmail.com
Cc: jeffxu@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	dave.hansen@intel.com,
	linux-hardening@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mpe@ellerman.id.au,
	oliver.sang@intel.com,
	vbabka@suse.cz,
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v2] selftest mm/mseal: fix test_seal_mremap_move_dontunmap_anyaddr
Date: Wed,  7 Aug 2024 21:23:20 +0000
Message-ID: <20240807212320.2831848-1-jeffxu@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

the syscall remap accepts following:

mremap(src, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, dst)

when the src is sealed, the call will fail with error code:
EPERM

Previously, the test uses hard-coded 0xdeaddead as dst, and it
will fail on the system with newer glibc installed.

This patch removes test's dependency on glibc for mremap(), also
fix the test and remove the hardcoded address.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reported-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 tools/testing/selftests/mm/mseal_test.c | 57 ++++++++++++++++---------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index a818f010de47..5bce2fe102ab 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -110,6 +110,16 @@ static int sys_madvise(void *start, size_t len, int types)
 	return sret;
 }
 
+static void *sys_mremap(void *addr, size_t old_len, size_t new_len,
+	unsigned long flags, void *new_addr)
+{
+	void *sret;
+
+	errno = 0;
+	sret = (void *) syscall(__NR_mremap, addr, old_len, new_len, flags, new_addr);
+	return sret;
+}
+
 static int sys_pkey_alloc(unsigned long flags, unsigned long init_val)
 {
 	int ret = syscall(__NR_pkey_alloc, flags, init_val);
@@ -1115,12 +1125,12 @@ static void test_seal_mremap_shrink(bool seal)
 	}
 
 	/* shrink from 4 pages to 2 pages. */
-	ret2 = mremap(ptr, size, 2 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, size, 2 * page_size, 0, 0);
 	if (seal) {
-		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 == (void *) MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
+		FAIL_TEST_IF_FALSE(ret2 != (void *) MAP_FAILED);
 
 	}
 
@@ -1147,7 +1157,7 @@ static void test_seal_mremap_expand(bool seal)
 	}
 
 	/* expand from 2 page to 4 pages. */
-	ret2 = mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
+	ret2 = sys_mremap(ptr, 2 * page_size, 4 * page_size, 0, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1180,7 +1190,7 @@ static void test_seal_mremap_move(bool seal)
 	}
 
 	/* move from ptr to fixed address. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newPtr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1299,7 +1309,7 @@ static void test_seal_mremap_shrink_fixed(bool seal)
 	}
 
 	/* mremap to move and shrink to fixed address */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1330,7 +1340,7 @@ static void test_seal_mremap_expand_fixed(bool seal)
 	}
 
 	/* mremap to move and expand to fixed address */
-	ret2 = mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, page_size, size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
@@ -1361,7 +1371,7 @@ static void test_seal_mremap_move_fixed(bool seal)
 	}
 
 	/* mremap to move to fixed address */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_FIXED, newAddr);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
@@ -1390,14 +1400,13 @@ static void test_seal_mremap_move_fixed_zero(bool seal)
 	/*
 	 * MREMAP_FIXED can move the mapping to zero address
 	 */
-	ret2 = mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
+	ret2 = sys_mremap(ptr, size, 2 * page_size, MREMAP_MAYMOVE | MREMAP_FIXED,
 			0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
 		FAIL_TEST_IF_FALSE(ret2 == 0);
-
 	}
 
 	REPORT_TEST_PASS();
@@ -1420,13 +1429,13 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 	}
 
 	/* mremap to move, and don't unmap src addr. */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP, 0);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
+		/* kernel will allocate a new address */
 		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-
 	}
 
 	REPORT_TEST_PASS();
@@ -1434,7 +1443,7 @@ static void test_seal_mremap_move_dontunmap(bool seal)
 
 static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 {
-	void *ptr;
+	void *ptr, *ptr2;
 	unsigned long page_size = getpagesize();
 	unsigned long size = 4 * page_size;
 	int ret;
@@ -1449,24 +1458,30 @@ static void test_seal_mremap_move_dontunmap_anyaddr(bool seal)
 	}
 
 	/*
-	 * The 0xdeaddead should not have effect on dest addr
-	 * when MREMAP_DONTUNMAP is set.
+	 * The new address is any address that not allocated.
+	 * use allocate/free to similate that.
 	 */
-	ret2 = mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
-			0xdeaddead);
+	setup_single_address(size, &ptr2);
+	FAIL_TEST_IF_FALSE(ptr2 != (void *)-1);
+	ret = sys_munmap(ptr2, size);
+	FAIL_TEST_IF_FALSE(!ret);
+
+	/*
+	 * remap to any address.
+	 */
+	ret2 = sys_mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
+			(void *) ptr2);
 	if (seal) {
 		FAIL_TEST_IF_FALSE(ret2 == MAP_FAILED);
 		FAIL_TEST_IF_FALSE(errno == EPERM);
 	} else {
-		FAIL_TEST_IF_FALSE(ret2 != MAP_FAILED);
-		FAIL_TEST_IF_FALSE((long)ret2 != 0xdeaddead);
-
+		/* remap success and return ptr2 */
+		FAIL_TEST_IF_FALSE(ret2 ==  ptr2);
 	}
 
 	REPORT_TEST_PASS();
 }
 
-
 static void test_seal_merge_and_split(void)
 {
 	void *ptr;
-- 
2.46.0.76.ge559c4bf1a-goog



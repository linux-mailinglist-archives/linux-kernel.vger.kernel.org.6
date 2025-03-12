Return-Path: <linux-kernel+bounces-557087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57646A5D374
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 01:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B08317A63F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAE22F43;
	Wed, 12 Mar 2025 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBgmMVry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049F17C2;
	Wed, 12 Mar 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741737886; cv=none; b=pOcwiro6IsBf/HQBu6T3hUf+Q4GTK8qhr1ajkAxgBlN21g21btpmMZhKSjhrlRzhIi541Scuz/KPj0+2JzuP04vKIuLOEjCmLe+/wkBWJ0zidSn0ARb11uSlxurUyoIfH+n2rwnz/IidDQ5H26j2vQEsGYHayAA6aue87EBs7Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741737886; c=relaxed/simple;
	bh=G7WiqVAnNKWOz6sMNsSRttvx79bcWvs9CVs0vQxasa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+njTPhwEYRrTa5Mn5cGE7GQF/Liwi2RzGjOLOVrUpZf4OIoB4uQ09r87jC418QRN9Zl5pQupCpXHUm56VA1KBHDUmkY0l4oJHxBdT+7CdmcF4M1U4KgQQg3lKJjgZXuRCN5uQb0vuRN7V8AZGB6huc116WpOHEbsQWSK+xEmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBgmMVry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC900C4CEE9;
	Wed, 12 Mar 2025 00:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741737885;
	bh=G7WiqVAnNKWOz6sMNsSRttvx79bcWvs9CVs0vQxasa8=;
	h=From:To:Cc:Subject:Date:From;
	b=rBgmMVryMhnGy2J/6kOqSzzVTp7oDjoXZeKihPHV3jW0tM2+Ii7q17DZzDCfsoZ2G
	 uesRYA6JAgLBQMknjmqfprqoeT6T0mMWcBbq0h8rsYCL5j1ROZrcW7dVV3ZznnAPUB
	 lRGH5IGDDXPQyX477H6k/UhGSgBN/MpaIATga++DcOqPLuPuo6eKaMn2iXgTx83b7P
	 GmWBkrZpyBzxkBCJEHcrc5WzAVGiDFMwGzfqlKjqtmvG/tQqOssZt2I1TwHUYfArU6
	 HOcVX/oxxi1YMswoTRk1JyNjNtDPyiKKi0ta5gOlY1doNERFrSG4bE5DMJXqRbe4jw
	 MbC6728k3HrVA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] kunit/fortify: Replace "volatile" with OPTIMIZER_HIDE_VAR()
Date: Tue, 11 Mar 2025 17:04:40 -0700
Message-Id: <20250312000439.work.112-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13029; i=kees@kernel.org; h=from:subject:message-id; bh=G7WiqVAnNKWOz6sMNsSRttvx79bcWvs9CVs0vQxasa8=; b=owGbwMvMwCVmps19z/KJym7G02pJDOkXzk+34NV60ZAfvup+de6lKMktZ3bFG3MbSh9SSJsox JZz4ejkjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkc0GNkuK//1Hv1oTuCJ75H s93XNInadpnfwDB5atBdt8ZQhm62j4wM9+5sYU95aXzg0J5d+SwhBgtOB7Y7Lc1wi1OVfH2lsre VEwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

It does seem that using "volatile" isn't going to be sane compared to
using OPTIMIZER_HIDE_VAR() going forward. Some strange interactions[1]
with the sanitizers have been observed in the self-test code, so replace
the logic.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2075 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 lib/tests/fortify_kunit.c | 139 +++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 62 deletions(-)

diff --git a/lib/tests/fortify_kunit.c b/lib/tests/fortify_kunit.c
index 18dcdedf777f..29ffc62a71e3 100644
--- a/lib/tests/fortify_kunit.c
+++ b/lib/tests/fortify_kunit.c
@@ -411,8 +411,6 @@ struct fortify_padding {
 	char buf[32];
 	unsigned long bytes_after;
 };
-/* Force compiler into not being able to resolve size at compile-time. */
-static volatile int unconst;
 
 static void fortify_test_strlen(struct kunit *test)
 {
@@ -537,57 +535,56 @@ static void fortify_test_strncpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[] = "Copy me fully into a small buffer and I will overflow!";
+	size_t sizeof_buf = sizeof(pad.buf);
+
+	OPTIMIZER_HIDE_VAR(sizeof_buf);
 
 	/* Destination is %NUL-filled to start with. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 3], '\0');
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* Legitimate strncpy() 1 less than of max size. */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst - 1)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf - 1)
 				== pad.buf);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* Only last byte should be %NUL */
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 3], '\0');
 
 	/* Legitimate (though unterminated) max-size strncpy. */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf)
 				== pad.buf);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* No trailing %NUL -- thanks strncpy API. */
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* But we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* Now verify that FORTIFY is working... */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst + 1)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf + 1)
 				== pad.buf);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* And further... */
-	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src,
-					sizeof(pad.buf) + unconst + 2)
+	KUNIT_ASSERT_TRUE(test, strncpy(pad.buf, src, sizeof_buf + 2)
 				== pad.buf);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
@@ -596,55 +593,56 @@ static void fortify_test_strscpy(struct kunit *test)
 {
 	struct fortify_padding pad = { };
 	char src[] = "Copy me fully into a small buffer and I will overflow!";
+	size_t sizeof_buf = sizeof(pad.buf);
+	size_t sizeof_src = sizeof(src);
+
+	OPTIMIZER_HIDE_VAR(sizeof_buf);
+	OPTIMIZER_HIDE_VAR(sizeof_src);
 
 	/* Destination is %NUL-filled to start with. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_before, 0);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 3], '\0');
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* Legitimate strscpy() 1 less than of max size. */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(pad.buf) + unconst - 1),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_buf - 1),
 			-E2BIG);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* Keeping space for %NUL, last two bytes should be %NUL */
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 3], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 3], '\0');
 
 	/* Legitimate max-size strscpy. */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(pad.buf) + unconst),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_buf),
 			-E2BIG);
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);
 	/* A trailing %NUL will exist. */
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 
 	/* Now verify that FORTIFY is working... */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(pad.buf) + unconst + 1),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_buf + 1),
 			-E2BIG);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 
 	/* And much further... */
-	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src,
-				      sizeof(src) * 2 + unconst),
+	KUNIT_ASSERT_EQ(test, strscpy(pad.buf, src, sizeof_src * 2),
 			-E2BIG);
 	/* Should catch the overflow. */
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 2);
-	KUNIT_EXPECT_EQ(test, pad.buf[sizeof(pad.buf) - 1], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
-	KUNIT_EXPECT_NE(test, pad.buf[sizeof(pad.buf) - 2], '\0');
+	KUNIT_EXPECT_EQ(test, pad.buf[sizeof_buf - 1], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
+	KUNIT_EXPECT_NE(test, pad.buf[sizeof_buf - 2], '\0');
 	/* And we will not have gone beyond. */
 	KUNIT_EXPECT_EQ(test, pad.bytes_after, 0);
 }
@@ -784,7 +782,9 @@ static void fortify_test_strlcat(struct kunit *test)
 	struct fortify_padding pad = { };
 	char src[sizeof(pad.buf)] = { };
 	int i, partial;
-	int len = sizeof(pad.buf) + unconst;
+	int len = sizeof(pad.buf);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	/* Fill 15 bytes with valid characters. */
 	partial = sizeof(src) / 2 - 1;
@@ -874,28 +874,32 @@ struct fortify_zero_sized {
 #define __fortify_test(memfunc)					\
 static void fortify_test_##memfunc(struct kunit *test)		\
 {								\
-	struct fortify_zero_sized zero = { };			\
+	struct fortify_zero_sized empty = { };			\
 	struct fortify_padding pad = { };			\
 	char srcA[sizeof(pad.buf) + 2];				\
 	char srcB[sizeof(pad.buf) + 2];				\
-	size_t len = sizeof(pad.buf) + unconst;			\
+	size_t len = sizeof(pad.buf);				\
+	size_t zero = 0;					\
+								\
+	OPTIMIZER_HIDE_VAR(len);				\
+	OPTIMIZER_HIDE_VAR(zero);				\
 								\
 	memset(srcA, 'A', sizeof(srcA));			\
 	KUNIT_ASSERT_EQ(test, srcA[0], 'A');			\
 	memset(srcB, 'B', sizeof(srcB));			\
 	KUNIT_ASSERT_EQ(test, srcB[0], 'B');			\
 								\
-	memfunc(pad.buf, srcA, 0 + unconst);			\
+	memfunc(pad.buf, srcA, zero);				\
 	KUNIT_EXPECT_EQ(test, pad.buf[0], '\0');		\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	memfunc(pad.buf + 1, srcB, 1 + unconst);		\
+	memfunc(pad.buf + 1, srcB, zero + 1);			\
 	KUNIT_EXPECT_EQ(test, pad.buf[0], '\0');		\
 	KUNIT_EXPECT_EQ(test, pad.buf[1], 'B');			\
 	KUNIT_EXPECT_EQ(test, pad.buf[2], '\0');		\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	memfunc(pad.buf, srcA, 1 + unconst);			\
+	memfunc(pad.buf, srcA, zero + 1);			\
 	KUNIT_EXPECT_EQ(test, pad.buf[0], 'A');			\
 	KUNIT_EXPECT_EQ(test, pad.buf[1], 'B');			\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
@@ -921,10 +925,10 @@ static void fortify_test_##memfunc(struct kunit *test)		\
 	/* Reset error counter. */				\
 	fortify_write_overflows = 0;				\
 	/* Copy nothing into nothing: no errors. */		\
-	memfunc(zero.buf, srcB, 0 + unconst);			\
+	memfunc(empty.buf, srcB, zero);				\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 0);	\
-	memfunc(zero.buf, srcB, 1 + unconst);			\
+	memfunc(empty.buf, srcB, zero + 1);			\
 	KUNIT_EXPECT_EQ(test, fortify_read_overflows, 0);	\
 	KUNIT_EXPECT_EQ(test, fortify_write_overflows, 1);	\
 }
@@ -936,7 +940,9 @@ static void fortify_test_memscan(struct kunit *test)
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + strlen("Where oh where is ");
 	char needle = 'm';
-	size_t len = sizeof(haystack) + unconst;
+	size_t len = sizeof(haystack);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	KUNIT_ASSERT_PTR_EQ(test, memscan(haystack, needle, len),
 				  mem);
@@ -955,7 +961,9 @@ static void fortify_test_memchr(struct kunit *test)
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + strlen("Where oh where is ");
 	char needle = 'm';
-	size_t len = sizeof(haystack) + unconst;
+	size_t len = sizeof(haystack);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	KUNIT_ASSERT_PTR_EQ(test, memchr(haystack, needle, len),
 				  mem);
@@ -974,7 +982,9 @@ static void fortify_test_memchr_inv(struct kunit *test)
 	char haystack[] = "Where oh where is my memory range?";
 	char *mem = haystack + 1;
 	char needle = 'W';
-	size_t len = sizeof(haystack) + unconst;
+	size_t len = sizeof(haystack);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	/* Normal search is okay. */
 	KUNIT_ASSERT_PTR_EQ(test, memchr_inv(haystack, needle, len),
@@ -993,8 +1003,11 @@ static void fortify_test_memcmp(struct kunit *test)
 {
 	char one[] = "My mind is going ...";
 	char two[] = "My mind is going ... I can feel it.";
-	size_t one_len = sizeof(one) + unconst - 1;
-	size_t two_len = sizeof(two) + unconst - 1;
+	size_t one_len = sizeof(one) - 1;
+	size_t two_len = sizeof(two) - 1;
+
+	OPTIMIZER_HIDE_VAR(one_len);
+	OPTIMIZER_HIDE_VAR(two_len);
 
 	/* We match the first string (ignoring the %NUL). */
 	KUNIT_ASSERT_EQ(test, memcmp(one, two, one_len), 0);
@@ -1015,7 +1028,9 @@ static void fortify_test_kmemdup(struct kunit *test)
 {
 	char src[] = "I got Doom running on it!";
 	char *copy;
-	size_t len = sizeof(src) + unconst;
+	size_t len = sizeof(src);
+
+	OPTIMIZER_HIDE_VAR(len);
 
 	/* Copy is within bounds. */
 	copy = kmemdup(src, len, GFP_KERNEL);
-- 
2.34.1



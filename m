Return-Path: <linux-kernel+bounces-552403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA30A5798F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D337A8459
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645F71C5D63;
	Sat,  8 Mar 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxWUJv1Y"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871EA1B3952
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426522; cv=none; b=GOiNBeEagDC0J26iK8UTqu0eg0+bRVyffis/QwSyqgkJMnWSIGpndXRvWFOcoszPJOAktVwiVMj15Kd5VqOWdAUh/axKF3oa4jESpwFlzssYVxKA9A71MhiY+waAN4GYQh9aHve2Suw0j3Qyqrhf0itJIFXeLRggXB8p9qN0PCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426522; c=relaxed/simple;
	bh=/rrpX0Jd7AO0pLzNN/4r3XJG+AwFTV8rMFZQlcAimDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RKbh0nYpLTfvSO0XMIBuSqsfXZEt+PfxLRjp4ly26EN01I9gg4GlvWZBCUWBRZy4UBPpxg6Rk0YO6EZb0odTE4kK54ce/i0rP57x02MVnzhfsaXDxR5DN2NOO7MGgkHoiw4cL7fpjbcDiJ2Fq2LO6m0PoR8UJX4XKLzI0aWqrRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxWUJv1Y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so15698005e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426519; x=1742031319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=615WbshJLbjls5U3jeu6OdaXqEtsj7lJRi/IOdHuV80=;
        b=XxWUJv1YEB3P4n7nG0lX0CQenaGtutw41dXWwZTeYTLlQjRn5xubz0WTHWwCvoB2Aw
         dbmJc1Dqf5nI0kugydp8WxIsQc5qFM2gbINaUC0jBK1eNMIZKpZ94l0mC4srqmG8lgGP
         hnaXxZr3Y9QOlu2fi8a+U8RPE1b3cjgcsVad/q61b+Lzjw75fC/Y+TTtYwqlunzTxVse
         KADb6KJAvDc9VzOVNuD0BLj/LRVtQHZJFk/wRTyJDONIn3co8FqrbKM//D9aHa4TPj1g
         KTLL2kHSUVLcz7vFleDOzva0aDqcto/Wz8GjVdnM5N8KRptFFMLxahhdsvA4JnVCzFuu
         eJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426519; x=1742031319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=615WbshJLbjls5U3jeu6OdaXqEtsj7lJRi/IOdHuV80=;
        b=CHuExnnMOGucugzuKqEMDQQmDc/4N9c3eDzhHduZmzK6YP2NUTBl1dUW3ZgqQ251GK
         3OzeHvbMJrcgGqZzcfEB5WBbdMxT30s+AgsyHbKASZUvCxHEqayRj5u55LuAixjkk7nc
         KjxOyvgUMcwRbI6maWa1xin0ElamCEQItrWlEkpl7+z0lbjeQTEC8R1EXaUIQaKTzHLQ
         2GM87qDx9jP0w3zng4DdCdY6zCBhRPgOe3isoxNDrYyRGsv8Wc8KjCJkctDviXGAaruB
         58r29VEaSeQisIolC9rApRM9mkeI8auVxYIFYl2uKh/ZnUbDJXhkjFpDHydCKVyaJwqr
         exXw==
X-Gm-Message-State: AOJu0Yw9g5CsXIJq3CSgXDBsVByQDrjV6sntTfPDi3tuhe9a5pAyjNvU
	LbWO85G2byzWcN0FKYyiwEl01fQQK7YPC2GlQgCLhXeCyNP46VvzyOkpJw==
X-Gm-Gg: ASbGnctgdwf6/8P2ys5Jyw06oTUgHdkKNUttRCiuG1HNgxzSB8wFsquyvwUrbmR4of9
	gcbcZP19/XueSIWThaZEsG+mgc+OSprxxm6wS804cy1dWmBqZsUAjUsZ7nY7XqTf+iB0U9khebs
	TxDhY1D4BhXxgFYgLlHjvmYwnbn7/l8CClTgs6SHIBPe+PHHM+u+/kyUH0Vw0F/HTGDYov6IvFl
	WXwkODGVIphY2xHIsOWwoVr9Sl2v1ZDx+4rvw/HCV0ywQgZau1e//izHB5EimHGbUK49W+qPMXf
	qcBfpI9JIyaQWujnZDG1nsjYdHYqnWUDUOdJDbI9+fgpkgP4JTtt051ruD2cXES5evDobWjtlbZ
	D0UGHZANdlTX4RluJAQ7miaNvHQ==
X-Google-Smtp-Source: AGHT+IEIZS3vD8An/PeadukaTEKOvMV1HWmz7oRSz92Axe7UFQ9wmzlVQ7eX55TWhfAM5hWZlyZegw==
X-Received: by 2002:a05:600c:354b:b0:439:4b23:9e8e with SMTP id 5b1f17b1804b1-43ce4ab02eamr16863985e9.3.1741426518799;
        Sat, 08 Mar 2025 01:35:18 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:18 -0800 (PST)
From: David Laight <david.laight.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	nnac123@linux.ibm.com,
	horms@kernel.org
Subject: [PATCH next 7/8] test_hexdump: Run fixed not random tests
Date: Sat,  8 Mar 2025 09:34:51 +0000
Message-Id: <20250308093452.3742-8-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308093452.3742-1-david.laight.linux@gmail.com>
References: <20250308093452.3742-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For reproducibilty instead of running 16 random length with two
random 'rowsize' picked from 16 and 32, run the tests with rowsize
16 and 32 and all the lengths from 1 to rowsize.
(This still includes all the cases where groupsize gets forced to 1.)

For the overflow tests increase 'len' if the data fits and 'buflen'
if it doesn't.

The is more tests than really needed but covers all the interesting
cases without generating a very large number of tests.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 64 +++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 56c0dfbd075b..877033a570d4 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/random.h>
 #include <linux/string.h>
 
 static const unsigned char data_b[] = {
@@ -109,18 +108,19 @@ static void __init test_hexdump(size_t len, size_t rowsize, size_t groupsize,
 
 static void __init test_hexdump_set(size_t rowsize, bool ascii)
 {
-	size_t d = min(sizeof(data_b), rowsize);
-	size_t len = get_random_u32_inclusive(1, d);
+	size_t len;
 
-	test_hexdump(len, rowsize, 4, ascii);
-	test_hexdump(len, rowsize, 2, ascii);
-	test_hexdump(len, rowsize, 8, ascii);
-	test_hexdump(len, rowsize, 1, ascii);
+	for (len = 1; len <= rowsize; len++) {
+		test_hexdump(len, rowsize, 4, ascii);
+		test_hexdump(len, rowsize, 2, ascii);
+		test_hexdump(len, rowsize, 8, ascii);
+		test_hexdump(len, rowsize, 1, ascii);
+	}
 }
 
-static void __init test_hexdump_overflow(size_t buflen, size_t len,
-					 size_t rowsize, size_t groupsize,
-					 bool ascii)
+static bool __init test_hexdump_overflow(size_t buflen, size_t len,
+					   size_t rowsize, size_t groupsize,
+					   bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char buf[TEST_HEXDUMP_BUF_SIZE];
@@ -154,40 +154,40 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 		pr_err("Expect: %zd '%.*s'\n", expected, TEST_HEXDUMP_BUF_SIZE, test);
 		failed_tests++;
 	}
+
+	return expected < buflen;
 }
 
-static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
+static void __init test_hexdump_overflow_set(size_t rowsize, bool ascii)
 {
-	unsigned int i = 0;
-	size_t rowsize = get_random_u32_inclusive(1, 2) * 16;
-
-	do {
-		size_t groupsize = 1 << i;
-		size_t len = get_random_u32_below(rowsize) + groupsize;
-
-		test_hexdump_overflow(buflen, rounddown(len, groupsize),
-				      rowsize, groupsize, ascii);
-	} while (i++ < 3);
+	size_t groupsize, len, buflen;
+
+	for (groupsize = 1; groupsize <= 8; groupsize *= 2) {
+		len = 0;
+		buflen = 0;
+		for (; len <= rowsize && buflen <= TEST_HEXDUMP_BUF_SIZE;) {
+			if (test_hexdump_overflow(buflen, len, rowsize,
+						  groupsize, ascii))
+				len += groupsize;
+			else
+				buflen++;
+		}
+	}
 }
 
 static int __init test_hexdump_init(void)
 {
-	unsigned int i;
 	size_t rowsize;
 
-	rowsize = get_random_u32_inclusive(1, 2) * 16;
-	for (i = 0; i < 16; i++)
+	for (rowsize = 16; rowsize <= 32; rowsize += 16) {
 		test_hexdump_set(rowsize, false);
-
-	rowsize = get_random_u32_inclusive(1, 2) * 16;
-	for (i = 0; i < 16; i++)
 		test_hexdump_set(rowsize, true);
+	}
 
-	for (i = 0; i <= TEST_HEXDUMP_BUF_SIZE; i++)
-		test_hexdump_overflow_set(i, false);
-
-	for (i = 0; i <= TEST_HEXDUMP_BUF_SIZE; i++)
-		test_hexdump_overflow_set(i, true);
+	test_hexdump_overflow_set(16, false);
+	test_hexdump_overflow_set(16, true);
+	test_hexdump_overflow_set(32, false);
+	test_hexdump_overflow_set(32, true);
 
 	if (failed_tests == 0)
 		pr_info("all %u tests passed\n", total_tests);
-- 
2.39.5



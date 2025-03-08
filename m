Return-Path: <linux-kernel+bounces-552404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E85A57990
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC371893EA2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E441C701F;
	Sat,  8 Mar 2025 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jc1YG1fZ"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9121B415F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426523; cv=none; b=AZdNrgRm1zejTU3p6lEzS+IRPOchMlJW95wHB3m3niIWXUM87dlSGzrj67asd+NwK4/h/oaJD2wLia8TVIHWSWoMALiM25y9VgUwPaepWYxnkdi2/y66lpBp3iTOjv1znhtZEcTIqyobVHF61HkDWOviHtwX9FHkmFhV0grkq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426523; c=relaxed/simple;
	bh=rONEl4RfPQnnqrxuu2tf2lJ019DkcnnMas5SmS6HZrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fCcvjyzWlwntrHysNt7jgHNqaSQLFRCCoWJ0tNlDq402z3ouCKHKGu4XCsJXvDS3R03xkU/u5gQFKlOkaXSW0QenEYN9RGpOwQFTPqg8T5PvoKdVLlw/DShc9/oG3TfzEMaRrZkpzQFE+v7KDUHRcEJGJp5e4WLWnNtRBZ+QvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jc1YG1fZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bc0b8520cso15843255e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426519; x=1742031319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tkOJABZ+cpIWk2CuveFX94zFWy5fKj3p9VLpKdU0T9o=;
        b=jc1YG1fZnAl30r3B5zdLHOdSIrfZyTWhxoy3g+7szUniRZbWNWdiMXsAPBeQrMmBzI
         +Q6v4HzieeYN5LaOoJz2JzsXYcQeGPuqkz9dXiK9Q9ed1bHYZQzFr5ezW1h5T2Ruas9u
         MPLpHv6+9bi8HdceJaV9sAn9EbDjRRgTue9qgEFKY/ywrS2LYXcoCEL2iM/ESx4/diyG
         ve3H/RPBtgDkLMwwSYNP4luma6ms1JyAsF+llm07mINHdwXqkpZ9311CaqyD4A0PnMER
         0cWFBrW3Vh1r06hD9vi1PurjaSM5sZp3Us6mGZzagvRsSg8vqhc36jFUBnSYhzuyhCMH
         KlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426519; x=1742031319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkOJABZ+cpIWk2CuveFX94zFWy5fKj3p9VLpKdU0T9o=;
        b=HBi/9sfNmiH//FxSvduPFdaASKwgPM5PgKaPaCuEGxJLNTE/y8mzy0naPGZamLl59L
         cxalSY8KdJcoHxr+s9Bi6DGFCc0UPu9arNEFTqCBlATCx/Croh6NpmgEMDMlwDkkF3nl
         I/K1Mj+cxmBdknxqgBcBNwZ6QhwphEdNP8fZVVqoxOrafrCFyQwWFZUweoiRLRpDKYo8
         FUZ0oE7aE2Pe0d/n5Lb3cVSUlIZbDcbiwmoK1fUju1nrNNUCLwDRlVAmy2YgmKMMW7kA
         jjKwCy+XFeHKE7UDw+zUluu1wPwTlHLbDL7kWn466sh4j/RHMMsRXTl1KzsGreFHlwgJ
         AFCQ==
X-Gm-Message-State: AOJu0YwF83c1c7sLwSV2H33DMyUEnVVSfCot6hBaW8PNm/uyH470DtER
	6Ob85av1xw0c5N1KNwp6fN+gesA0ZpdK2yTrHaNcON8OTeLuQYYYFApJ4Q==
X-Gm-Gg: ASbGncuSzldu708HCZFW/Qr/lOJG9lwJzZQVs7jAGclr4ON1p4iOnVeELl5b1sYt+if
	tX7b3RD/ZOM4k9U11qQRgySWPDfR+PuW8TzG59M9tegvP8FvOtbzFrbPbmFrAxo/jwMJ2TX7PCy
	9h2D6F9j29CMV4Z9xs6a8BXdaioqC3RXiH2d4bJUleGVvJEHqeI4lYYFRroCV+obTRh60n6yQjP
	WdB+GTMyOvRE8R/LpdR/1czE1E/V1FljFoABmaxM+spBjrOJgvk1b0VxZu7yqevM/tb+Jigwh3K
	KnXwcVwloKOJJ8WUqHzNvJIAOnNB19+QrZpx4mG9vtKjgc3WWhv4bexQlVYyQodXpFBtPNLthLa
	2UJ7tA5ipyd5YLlYHtO8ZSw1K/uBueMeYSm2U
X-Google-Smtp-Source: AGHT+IFuBUzzXZb67a0ZGAawYBWfklfcHyBfOcWeCBnhkZLx72LdIH/x8ie86I6Ae/EJp/gw8DKnaw==
X-Received: by 2002:a05:600c:1d03:b0:43c:eacc:9d68 with SMTP id 5b1f17b1804b1-43ceacca125mr6148745e9.20.1741426519527;
        Sat, 08 Mar 2025 01:35:19 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:19 -0800 (PST)
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
Subject: [PATCH next 8/8] test_hexdump: Test all 256 byte values
Date: Sat,  8 Mar 2025 09:34:52 +0000
Message-Id: <20250308093452.3742-9-david.laight.linux@gmail.com>
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

Pass the hex data buffer as a parameter to test_hexdump_prepare_test()
and test_hexdump().
Add additional tests that pass all 256 byte values requesting 'ascii'.
Checks that unprintable characters are concerted to '.'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 46 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 877033a570d4..d2ed1870f869 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -21,9 +21,9 @@ static const unsigned char data_b[] = {
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
 
-static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
-					       size_t groupsize, char *test,
-					       size_t testlen, bool ascii)
+static size_t __init test_hexdump_prepare_test(const unsigned char *buf, size_t len,
+					       size_t rowsize, size_t groupsize,
+					       char *test, size_t testlen, bool ascii)
 {
 	char *p;
 	size_t byteswap, i, j;
@@ -54,7 +54,7 @@ static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 	/* hex dump */
 	p = test;
 	for (i = 0, j = 0; i < len; i++) {
-		unsigned char b = data_b[i ^ byteswap];
+		unsigned char b = buf[i ^ byteswap];
 		*p++ = "0123456789abcdef"[b >> 4];
 		*p++ = "0123456789abcdef"[b & 15];
 		if (++j == groupsize) {
@@ -71,7 +71,7 @@ static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 		} while (p < test + rowsize * 2 + rowsize / groupsize + 1);
 
 		for (i = 0; i < len; i++) {
-			unsigned char b = data_b[i];
+			unsigned char b = buf[i];
 			*p++ = (isascii(b) && isprint(b)) ? b : '.';
 		}
 	}
@@ -82,8 +82,8 @@ static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 
 #define TEST_HEXDUMP_BUF_SIZE		(32 * 3 + 2 + 32 + 1)
 
-static void __init test_hexdump(size_t len, size_t rowsize, size_t groupsize,
-				bool ascii)
+static void __init test_hexdump(const void *buf, size_t len, size_t rowsize,
+				size_t groupsize, bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char real[TEST_HEXDUMP_BUF_SIZE];
@@ -91,11 +91,11 @@ static void __init test_hexdump(size_t len, size_t rowsize, size_t groupsize,
 	total_tests++;
 
 	memset(real, FILL_CHAR, sizeof(real));
-	hex_dump_to_buffer(data_b, len, rowsize, groupsize, real, sizeof(real),
+	hex_dump_to_buffer(buf, len, rowsize, groupsize, real, sizeof(real),
 			   ascii);
 
 	memset(test, FILL_CHAR, sizeof(test));
-	test_hexdump_prepare_test(len, rowsize, groupsize, test, sizeof(test),
+	test_hexdump_prepare_test(buf, len, rowsize, groupsize, test, sizeof(test),
 				  ascii);
 
 	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
@@ -111,10 +111,10 @@ static void __init test_hexdump_set(size_t rowsize, bool ascii)
 	size_t len;
 
 	for (len = 1; len <= rowsize; len++) {
-		test_hexdump(len, rowsize, 4, ascii);
-		test_hexdump(len, rowsize, 2, ascii);
-		test_hexdump(len, rowsize, 8, ascii);
-		test_hexdump(len, rowsize, 1, ascii);
+		test_hexdump(data_b, len, rowsize, 4, ascii);
+		test_hexdump(data_b, len, rowsize, 2, ascii);
+		test_hexdump(data_b, len, rowsize, 8, ascii);
+		test_hexdump(data_b, len, rowsize, 1, ascii);
 	}
 }
 
@@ -136,7 +136,7 @@ static bool __init test_hexdump_overflow(size_t buflen, size_t len,
 				    buflen, ascii);
 
 	/* Test output is generated into a 'long enough' buffer */
-	expected = test_hexdump_prepare_test(len, rowsize, groupsize, test,
+	expected = test_hexdump_prepare_test(data_b, len, rowsize, groupsize, test,
 					     sizeof(test), ascii);
 
 	f = min(expected + 1, buflen);
@@ -175,6 +175,22 @@ static void __init test_hexdump_overflow_set(size_t rowsize, bool ascii)
 	}
 }
 
+static void __init test_hexdump_bytes(void)
+{
+	unsigned char buf[16];
+	size_t i, j;
+
+	for (i = 0; i < 256; i += 16) {
+		for (j = 0; j < 16; j++)
+			buf[j] = i + j;
+		test_hexdump(buf, 16, 16, 1, true);
+		test_hexdump(buf, 16, 16, 2, true);
+		test_hexdump(buf, 16, 16, 4, true);
+		test_hexdump(buf, 16, 16, 8, true);
+	}
+}
+
+
 static int __init test_hexdump_init(void)
 {
 	size_t rowsize;
@@ -189,6 +205,8 @@ static int __init test_hexdump_init(void)
 	test_hexdump_overflow_set(32, false);
 	test_hexdump_overflow_set(32, true);
 
+	test_hexdump_bytes();
+
 	if (failed_tests == 0)
 		pr_info("all %u tests passed\n", total_tests);
 	else
-- 
2.39.5



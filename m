Return-Path: <linux-kernel+bounces-552399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45946A5798B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A64517250F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EA1B3929;
	Sat,  8 Mar 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gr0ZmOmV"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849B1B041C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426519; cv=none; b=DMo0nsZboayQqSglA+i7iF/+eG3LxajsTlExm1nc0/1Rr53LFbFL6Q84MgffeIxWklkOPVQR9AFlCRvCxKcWRCdBtpX+euch1AjWnE7V0NVy/Y2UH0hU62EhyaerNsv1/pAytq/J2MoORH+SEVQvIAI0YNWHXkdrrLQYz3+6bbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426519; c=relaxed/simple;
	bh=MyZk6fSEEAU1j5j19Vgbj0IZIpCkG7MCb8+Wkev9LZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTia1o8etxEpau/udnN0pG1ObSybZAJhL4V8ULWTaffk9V7ugd6dHTUB5P8+IH1cJnIKF58di+CsAm9iyll7QlD9OLahZ/4jPEr/OLJBkbJDHGXdmxBSW5yf/AlHnG7Er+DDcurjvCnMvxBKrj4JZd9uTsEbxkRNsWMTE4HRwTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gr0ZmOmV; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43bd45e4d91so15697755e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426516; x=1742031316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTYbCZgZ62mscw+fPR883v5qEHUvINwlZxHSBDC1Mqs=;
        b=gr0ZmOmVvhOwNzFGwzlWr7Ppw7azhfhZC+1cDrDWrJfc/N6G1vztel0jJSPUH3zB/9
         k0BP05luLld9QaYhqAXpNsVXszJWSSQ67k6Bj4XSRjhI/Vjj+4RsqawfDMhWOzvKh8qo
         yOM4qUjXzb4w8CEPmYNBKVS9N4VymM703Z7RnyqewpLLZPJ2DfqcNfXj1isM9Qdc4YrF
         4wa3jeGuopwZcP2HqP5b36sg57/FTyvwN4D+uGmdwYMlJMOMgGQuucK32bkRqStnOpDj
         lQzMQyTLsNrA9uM7rv5CmkKQ05BQeLaBIxgOzGwPPObqZLYOkzLhZtcSjdtcPeF8eZbL
         xxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426516; x=1742031316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTYbCZgZ62mscw+fPR883v5qEHUvINwlZxHSBDC1Mqs=;
        b=pj4AeUH9RPRLFWUzShrP1Xe3CJfgKS66ocPrnpeH7qQEXXTdnDSeTrw7khhL5Bvhz4
         e2fBHidQd2Frzi/AQ7DJ/aOspM1gf4r1rcxT19icDv/AZE6Bh09qaQ628hbgXW4YKLUg
         p4V0fm3Tcwq1+eJxn+IWri0ZCFq9bmgngCBL0I96bf5hY3v94OZAt+iq6NCdN4HTst5r
         G+MNGd43kkbMEZT910vLwO9eg46hf+C5WXORSfKO1jXZA91vM1lAe2+2Urlc0DvHOyRj
         MAS4JoNJS1jbFH5m/+xp2GvmsRZ3h4nxgRJenY++hpdXqsrku5LFqjnF34e4qfh6Utfx
         Bb8Q==
X-Gm-Message-State: AOJu0YyF+17xsmLmg7/UzraLEqs69Jj3+9gcK3lIVPCnEKdVv6vM4POh
	ITw2nm7vJ63vUzI0kr5KUYPqgAXM07zRB7FdWQiqKMTbYmIaUlcnQhiTVA==
X-Gm-Gg: ASbGnctXTQ5sn/2vCeZPKTkdqwpZNT5BxhAt3Sjzp1GPIFmIRrLl2cA3IB0Ag+Pyfyl
	rRFHHRkSRjdNELviWvpOUNbONHe2KFmEFOGF/SVUw5BVB07nPmCOr3/lV1qobO8pY/S4W2BjxXs
	eYJecw1HzUKYwULfcoWYA//u+GZwk2984yB6iXIfhPflG9fn1B/XpA8UIwHcYF6vSM5zvIWhzbO
	lV+WblIj2Ar4E3V6+o3KS4Bof5v03o5BfTXYTKbkhJTPGkkbgLaNaozlPs6NSFice37KOuX4eWv
	qma5uCdVRXcmt4g8pdGSI3036zn8LtcQddpmtAyjMfx8B+Fa+1iFe7pDlZGllMbrQR2N42RuKXc
	yStOB0/jtTop8Aj45XuprUHIYBQ==
X-Google-Smtp-Source: AGHT+IHnB88p51a4UgLfQucwZzVz+7NxSdJc6jJsqBJrTOvWbxTsKy0T37alVMRdleosV9iswqBCgg==
X-Received: by 2002:a05:600c:a47:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-43ce4ad68a2mr14792855e9.8.1741426515603;
        Sat, 08 Mar 2025 01:35:15 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:15 -0800 (PST)
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
Subject: [PATCH next 3/8] test_hexdump: Use longer variable names
Date: Sat,  8 Mar 2025 09:34:47 +0000
Message-Id: <20250308093452.3742-4-david.laight.linux@gmail.com>
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

We're not so short of memory space for the compiler symbol table
that variable names have to be limited to 2 characters.
Use groupsize and rowsize (not gs and rs).
There is also no need to copy the function parameters to locals.
Change test_hexdump_prepare_test() (the function that gernerate the
sample output) to return the length - saves calculating it separately.

Test reports 'all 1184 tests passed'.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 81 +++++++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index e142b11c36c6..743ea5c78f9e 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -22,32 +22,30 @@ static const unsigned char data_b[] = {
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
 
-static void __init test_hexdump_prepare_test(size_t len, size_t rowsize,
-					     size_t groupsize, char *test,
-					     size_t testlen, bool ascii)
+static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
+					       size_t groupsize, char *test,
+					       size_t testlen, bool ascii)
 {
 	char *p;
-	size_t l = len;
-	size_t gs = groupsize, rs = rowsize;
-	size_t bs, i, j;
+	size_t byteswap, i, j;
 
-	if (rs != 16 && rs != 32)
-		rs = 16;
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
 
-	if (l > rs)
-		l = rs;
+	if (len > rowsize)
+		len = rowsize;
 
-	if (!is_power_of_2(gs) || gs > 8 || (len % gs != 0))
-		gs = 1;
-	bs = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ? 0 : gs - 1;
+	if (!is_power_of_2(groupsize) || groupsize > 8 || (len % groupsize != 0))
+		groupsize = 1;
+	byteswap = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ? 0 : groupsize - 1;
 
 	/* hex dump */
 	p = test;
-	for (i = 0, j = 0; i < l; i++) {
-		unsigned char b = data_b[i ^ bs];
+	for (i = 0, j = 0; i < len; i++) {
+		unsigned char b = data_b[i ^ byteswap];
 		*p++ = "0123456789abcdef"[b >> 4];
 		*p++ = "0123456789abcdef"[b & 15];
-		if (++j == gs) {
+		if (++j == groupsize) {
 			j = 0;
 			*p++ = ' ';
 		}
@@ -59,15 +57,16 @@ static void __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 	if (ascii) {
 		do {
 			*p++ = ' ';
-		} while (p < test + rs * 2 + rs / gs + 1);
+		} while (p < test + rowsize * 2 + rowsize / groupsize + 1);
 
-		for (i = 0; i < l; i++) {
+		for (i = 0; i < len; i++) {
 			unsigned char b = data_b[i];
 			*p++ = (isascii(b) && isprint(b)) ? b : '.';
 		}
 	}
 
 	*p = '\0';
+	return p - test;
 }
 
 #define TEST_HEXDUMP_BUF_SIZE		(32 * 3 + 2 + 32 + 1)
@@ -113,44 +112,35 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char buf[TEST_HEXDUMP_BUF_SIZE];
-	size_t rs = rowsize, gs = groupsize;
-	size_t ae, he, e, f, r;
-	bool a;
+	size_t expected;
+	size_t f, result;
+	bool ok;
 
 	total_tests++;
 
 	memset(buf, FILL_CHAR, sizeof(buf));
 
-	r = hex_dump_to_buffer(data_b, len, rs, gs, buf, buflen, ascii);
+	result = hex_dump_to_buffer(data_b, len, rowsize, groupsize, buf,
+				    buflen, ascii);
 
-	/*
-	 * Caller must provide the data length multiple of groupsize. The
-	 * calculations below are made with that assumption in mind.
-	 */
-	ae = rs * 2 /* hex */ + rs / gs /* spaces */ + 1 /* space */ + len /* ascii */;
-	he = (gs * 2 /* hex */ + 1 /* space */) * len / gs - 1 /* no trailing space */;
+	/* Test output is generated into a 'long enough' buffer */
+	expected = test_hexdump_prepare_test(len, rowsize, groupsize, test,
+					     sizeof(test), ascii);
 
-	if (ascii)
-		e = ae;
-	else
-		e = he;
-
-	f = min(e + 1, buflen);
-	if (buflen) {
-		test_hexdump_prepare_test(len, rs, gs, test, sizeof(test), ascii);
+	f = min(expected + 1, buflen);
+	if (f)
 		test[f - 1] = '\0';
-	}
 	memset(test + f, FILL_CHAR, sizeof(test) - f);
 
-	a = r == e && !memcmp(test, buf, TEST_HEXDUMP_BUF_SIZE);
+	ok = result == expected && !memcmp(test, buf, TEST_HEXDUMP_BUF_SIZE);
 
 	buf[sizeof(buf) - 1] = '\0';
 
-	if (!a) {
+	if (!ok) {
 		pr_err("Len: %zu buflen: %zu strlen: %zu\n",
 			len, buflen, strnlen(buf, sizeof(buf)));
-		pr_err("Result: %zu '%s'\n", r, buf);
-		pr_err("Expect: %zu '%s'\n", e, test);
+		pr_err("Result: %zu '%s'\n", result, buf);
+		pr_err("Expect: %zu '%s'\n", expected, test);
 		failed_tests++;
 	}
 }
@@ -158,13 +148,14 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
-	size_t rs = get_random_u32_inclusive(1, 2) * 16;
+	size_t rowsize = get_random_u32_inclusive(1, 2) * 16;
 
 	do {
-		size_t gs = 1 << i;
-		size_t len = get_random_u32_below(rs) + gs;
+		size_t groupsize = 1 << i;
+		size_t len = get_random_u32_below(rowsize) + groupsize;
 
-		test_hexdump_overflow(buflen, rounddown(len, gs), rs, gs, ascii);
+		test_hexdump_overflow(buflen, rounddown(len, groupsize),
+				      rowsize, groupsize, ascii);
 	} while (i++ < 3);
 }
 
-- 
2.39.5



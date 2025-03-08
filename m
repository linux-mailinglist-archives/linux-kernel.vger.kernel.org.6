Return-Path: <linux-kernel+bounces-552398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9E9A5798A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823233B2DD8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41D01B0F18;
	Sat,  8 Mar 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVJjbcL8"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F01AF0C5
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426518; cv=none; b=QXaskojrrbxpnB9rz9UlsSfl9JPsdpCoi2wNWG6XdqAN1RhF7PqnqMXsVEp8GE8c+lPBQG010GCJTz6FTeB3wjzeFHZK/AFPR8krC4ZWGASlD/8uUt/smForz8aygZldSXmGrSSQGelHy8fvEGrge+0Am6fJSd+DU172JIsAqHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426518; c=relaxed/simple;
	bh=CkYsnKRXNatWif3xICg+QL4M1DMIPG6ytqPYguDtjdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ca5oktAKhEiZSFFju7EX4OFlWSDMS2tu9DRB+GeRaB7p7YsH6XJ7CM7lrdlfgaH7CLwAOfDf5s8/jqGTwNa+2wAb1MSQa5hs/RmlbkSEXD8Gd2OIRLNpCmSXVEEdfjzRtoAYWU/eua8fOcL1MAUANJCZG6xKzacyLwQAYXGyURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVJjbcL8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4394036c0efso14859595e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426515; x=1742031315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RcOCVzvPBtsIxHK6RsctkJ4kjVqT46IPYI0eIByXjGs=;
        b=gVJjbcL8RgQCwTxd0bMkrutMMXnWQndROAfmjup6ENkxyqonOynnobqRE3SI2S0gnU
         VC+NhH6FxUNQZDQWp4UvKC3tcANUJpmfSqwO3qZ2rsI6w3Q1BhBTfnOI7SakDLBxosyf
         dP+tZbUIuPg3le8Xw1+Mux2P96KkYI5CULOO+PphoqXh8pjhWtKZWmaNMDnlmalhEX/i
         Q/aFm7cRboyFEmdwPlqwwMqtydwTBLgUx8NIEEeG3/vrCyH5AN6/NrIaU2SqP/Pm+jfR
         x3VL17s9O7640Qg8WeGBupbFAl+bB7q+ju8QDIEaqcsHxekBK5+DPbt/CR9ONtYvn13K
         l8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426515; x=1742031315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RcOCVzvPBtsIxHK6RsctkJ4kjVqT46IPYI0eIByXjGs=;
        b=c5+8D+Qts0nf2gBdt+56LLVHtHcazIhfbKUvXIoeffwYf0+jkDbql9Ruf67cE/6jvb
         xIChzszmJbvY/pt+1ew2KFRfK334aoq/Ua3xiix1tO2HIvaR+jYfA97OLF1vl5yIXElM
         H6cSF6/7uuOM1V6aucXi1DAw10xhVIo31iRiEWmsJ/owSWaeEzMZFVtd12LhCIlMZ512
         iOdvkk2nfkZPocRWTq7JZld8F1jMXCGE5MSCZ6Rr2W9Bt/P6VIfPdkgqNS+HI0AonQTH
         VYAyUJWaS+k1blskRcKUchu+jCnyBCIWc4zhj2W+QJVZzlLc0PQ9TPC3HmuMGQ2IzHwW
         WpPQ==
X-Gm-Message-State: AOJu0YwurjbSf55Xyd3QnifMsIPzEpndu5ZfBbWFFulTB6BhMGLlmmG0
	VsFbsXCH4MZesHKUOf8lm3YK/6v5xGBBjgHnJclVMlf+kLbQshoyZAB12w==
X-Gm-Gg: ASbGncvN1jy6BkGPacms96RaORJwM6QS1b1gNbcqPjNoSBow0B0x9YEHb44lTFlW+L1
	g4cBK4dK81sLzhTEw8MnUAUfrixh31G8xgK0vih15nY85+0BNVfi3wg2CwX17KECjAWrMAjFXIt
	FIJ1umOr0cQG6txPueaVwLA92MjfrC/d+9ARttcRDvE3TEBoGZr66noUpgcRHSa0G2HzAi6Goke
	aDtzlzip4+7s3ZK2By1qSeYFL0WgM8m1MDHNbMqNneRvgZMx73k5yHQOfQ/HHkEqkouRBEJyUZj
	abOeGXWAzeIcj6Y1T8cBg/RpCCsDDAGUo/l+Dw1xaEb35cRUYGXWIQKSkqpjEbF77rEBqYEZnnq
	z/izI1jGq5vkQQzOVEuYsr/l39w==
X-Google-Smtp-Source: AGHT+IF7zQ7HAhUUObeZ6zTf1to4CejJUYxSdhRm7Z8XHD0R1guQv5sMhA0F5l3onw+eK+2Zvj5lLQ==
X-Received: by 2002:a7b:ca4c:0:b0:43c:eb00:50eb with SMTP id 5b1f17b1804b1-43ceb0054a9mr7366065e9.5.1741426514786;
        Sat, 08 Mar 2025 01:35:14 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:14 -0800 (PST)
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
Subject: [PATCH next 2/8] test_hexdump: Create test output data from the binary input data buffer
Date: Sat,  8 Mar 2025 09:34:46 +0000
Message-Id: <20250308093452.3742-3-david.laight.linux@gmail.com>
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

Using the same data that is passed to hex_dump_to_buffer() lets
the tests be expanded to test different input data bytes.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 80 +++++++++-------------------------------------
 1 file changed, 15 insertions(+), 65 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 502768e56e4e..e142b11c36c6 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -3,6 +3,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/ctype.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -16,49 +17,6 @@ static const unsigned char data_b[] = {
 	'\x4c', '\xd1', '\x19', '\x99', '\x43', '\xb1', '\xaf', '\x0c',	/* 18 - 1f */
 };
 
-static const unsigned char data_a[] = ".2.{....p..$}.4...1.....L...C...";
-
-static const char * const test_data_1[] __initconst = {
-	"be", "32", "db", "7b", "0a", "18", "93", "b2",
-	"70", "ba", "c4", "24", "7d", "83", "34", "9b",
-	"a6", "9c", "31", "ad", "9c", "0f", "ac", "e9",
-	"4c", "d1", "19", "99", "43", "b1", "af", "0c",
-};
-
-static const char * const test_data_2_le[] __initconst = {
-	"32be", "7bdb", "180a", "b293",
-	"ba70", "24c4", "837d", "9b34",
-	"9ca6", "ad31", "0f9c", "e9ac",
-	"d14c", "9919", "b143", "0caf",
-};
-
-static const char * const test_data_2_be[] __initconst = {
-	"be32", "db7b", "0a18", "93b2",
-	"70ba", "c424", "7d83", "349b",
-	"a69c", "31ad", "9c0f", "ace9",
-	"4cd1", "1999", "43b1", "af0c",
-};
-
-static const char * const test_data_4_le[] __initconst = {
-	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
-	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
-};
-
-static const char * const test_data_4_be[] __initconst = {
-	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
-	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
-};
-
-static const char * const test_data_8_le[] __initconst = {
-	"b293180a7bdb32be", "9b34837d24c4ba70",
-	"e9ac0f9cad319ca6", "0cafb1439919d14c",
-};
-
-static const char * const test_data_8_be[] __initconst = {
-	"be32db7b0a1893b2", "70bac4247d83349b",
-	"a69c31ad9c0face9", "4cd1199943b1af0c",
-};
-
 #define FILL_CHAR	'#'
 
 static unsigned total_tests __initdata;
@@ -69,11 +27,9 @@ static void __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 					     size_t testlen, bool ascii)
 {
 	char *p;
-	const char * const *result;
 	size_t l = len;
 	size_t gs = groupsize, rs = rowsize;
-	unsigned int i;
-	const bool is_be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
+	size_t bs, i, j;
 
 	if (rs != 16 && rs != 32)
 		rs = 16;
@@ -83,26 +39,18 @@ static void __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 
 	if (!is_power_of_2(gs) || gs > 8 || (len % gs != 0))
 		gs = 1;
-
-	if (gs == 8)
-		result = is_be ? test_data_8_be : test_data_8_le;
-	else if (gs == 4)
-		result = is_be ? test_data_4_be : test_data_4_le;
-	else if (gs == 2)
-		result = is_be ? test_data_2_be : test_data_2_le;
-	else
-		result = test_data_1;
+	bs = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ? 0 : gs - 1;
 
 	/* hex dump */
 	p = test;
-	for (i = 0; i < l / gs; i++) {
-		const char *q = *result++;
-		size_t amount = strlen(q);
-
-		memcpy(p, q, amount);
-		p += amount;
-
-		*p++ = ' ';
+	for (i = 0, j = 0; i < l; i++) {
+		unsigned char b = data_b[i ^ bs];
+		*p++ = "0123456789abcdef"[b >> 4];
+		*p++ = "0123456789abcdef"[b & 15];
+		if (++j == gs) {
+			j = 0;
+			*p++ = ' ';
+		}
 	}
 	if (i)
 		p--;
@@ -113,8 +61,10 @@ static void __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 			*p++ = ' ';
 		} while (p < test + rs * 2 + rs / gs + 1);
 
-		memcpy(p, data_a, l);
-		p += l;
+		for (i = 0; i < l; i++) {
+			unsigned char b = data_b[i];
+			*p++ = (isascii(b) && isprint(b)) ? b : '.';
+		}
 	}
 
 	*p = '\0';
-- 
2.39.5



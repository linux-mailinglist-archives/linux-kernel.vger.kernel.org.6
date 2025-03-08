Return-Path: <linux-kernel+bounces-552397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A45BA57989
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAA63B42F6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE54187FEC;
	Sat,  8 Mar 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjNw2D2V"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255201B0421
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426518; cv=none; b=Gmacbv/jpNQdkXvdDM4dBFO0kroIsy/jhIG+af+VaREvdMFFcsd7JnKhNY1KTNty3Pz8AWYYN6d6f01TDfsDKiWLtLS9jQliYHFwExYyyu3auEOW0D77lfL6PSZhcYYbcjw4IkaGmLNmD2LxM2c3t0WRp6cuDWTYgqUlLhypo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426518; c=relaxed/simple;
	bh=gJT8KFm2BDhcFxPIXv4x/VUO8cwfBB/jJoOBt6gPwRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyuhKDg4XX5fOW4tf0xRXS6ZUvy4QbE0rKA0MMHUF6X8iIzXhCu1n/DndcM1AEiM4HUe8uyqSb30SDHyD6gjBI6odVL5scYAz4v5ak7VKbuxguy+LAUrXUkB2341FYwf3sQ+KBiBCGjaKQKkNdKjc8Ww7iSNNy4iGndp3LrS05M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjNw2D2V; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bc48ff815so15777435e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426514; x=1742031314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS0WSD5gKp5cnAuszIjnCYCd0M0+1iOtyBELh+t/oUk=;
        b=XjNw2D2V14XDu3HK3OJGDX7UFUzk/le/UmCRTcKUWHxkXup/OHWIgm2zfTDjZVTs4B
         ASpn8KjcsxwSumlieg/SLzChlmCbgkkVQReH8Z9Hj1pU+zjmjtIF7wHnFGCVEepvR2fK
         dcRu+Yv0m8S9sLx9dH9mzmw+PxJQQLYG57ayunqCFrz1dMNKflsarcsL1bbFu8HFR7zR
         0qaqYv+6GgCy1RhEzJ8IUG/VJJQpsh40KJhrEoSfDDRPjEdQsXDJCOw/n1QAagDLbRoX
         fUSlW7t5MsOMGUNlPGOZ3rPDeqbtB3R+uhs2gwlJtUPL2nrhta9klNv94eK70CyPwhn6
         t6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426514; x=1742031314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iS0WSD5gKp5cnAuszIjnCYCd0M0+1iOtyBELh+t/oUk=;
        b=GD7uQU7TrA93u01f2tCpJGNNAN0zYlh3lEL3FSlsb6rDd9ZDOKLJiC8FovAK+4hi3e
         abHVeCYfmsCl1cNiataZmIN2GaFW+ltL2VIb3h88ERMbcqKi20p6i6M60RNKDmgLRBmC
         JL0A2IHLuTrGzuauITr/+K8SLyF7TYMaS9RqavUGPstP1z+E3so1+IlaAzObMpSvhN4q
         iAoaU9Bj0u7gfqGss0udZvcAAvM8GNnjDDzEk1z45JzXM1Z9ACrXK8NFXFB5itDfwFwM
         wBMZ1xnU4SaUNs9zUm9JEOgv9meCoexCFQEn1PUXhKKdBEI4kUBvN9SffkTq6Jzn1Y4r
         TweA==
X-Gm-Message-State: AOJu0YwDHyyBng9zsFujsk4jDJ5+gxywGD2fPLXbzqRvWdMKwXuS1h9I
	8w7yY/wfk04sZj8i9OkpbvtOuS7Kb/dcRKimjpGxltfal8lgu8Rc/0KLrw==
X-Gm-Gg: ASbGncuZ83wKY2P/EYfTDQYRaNQsjzbRnbosoId6Bf0OQpjo9mFh3owIemzrRGFthQl
	UGRYckmP6h4XZGRaKUPA7mVMQLdTxCPy0G00nYKEPooKQ6CTYdctbcPrtO+qwWYbN8U+57QUd5L
	xUsXyYjipXQu2NRNLtcK1ffnH31ELtd4Zzg6iSIZxy1wuWERcx5/hWjoYR9VgTaQG4lLey30ocY
	iIXphshttehTe7Aonj7DP5AMt7pPJhb+e9AoNgS6LnMTmggOVY599lOZX0pLnUoah7oFik/2AaR
	bmXSjmwfM+ynqZ6DQAI6Pm52doNtFeNfHmzlar3aPFTmF4lHFetYWC5p7hWblCo5KaM6eBP3pwg
	GWOMZ0IK+DhOxAhFSXNQhohoMAA==
X-Google-Smtp-Source: AGHT+IH4O6vzDrZ1HR1AZ4KCRONlOv/LizsBVk9kFV6Vz/TriUtHWtb84lTI8Cs29KXJfWVOcPFxwg==
X-Received: by 2002:a05:600c:54f1:b0:43b:c638:3433 with SMTP id 5b1f17b1804b1-43ce4af10f3mr13048525e9.12.1741426514063;
        Sat, 08 Mar 2025 01:35:14 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:13 -0800 (PST)
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
Subject: [PATCH next 1/8] test_hexdump: Change rowsize and groupsize to size_t
Date: Sat,  8 Mar 2025 09:34:45 +0000
Message-Id: <20250308093452.3742-2-david.laight.linux@gmail.com>
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

Both refer to positive values, size_t matches the other parameters.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 751645645988..502768e56e4e 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -64,14 +64,14 @@ static const char * const test_data_8_be[] __initconst = {
 static unsigned total_tests __initdata;
 static unsigned failed_tests __initdata;
 
-static void __init test_hexdump_prepare_test(size_t len, int rowsize,
-					     int groupsize, char *test,
+static void __init test_hexdump_prepare_test(size_t len, size_t rowsize,
+					     size_t groupsize, char *test,
 					     size_t testlen, bool ascii)
 {
 	char *p;
 	const char * const *result;
 	size_t l = len;
-	int gs = groupsize, rs = rowsize;
+	size_t gs = groupsize, rs = rowsize;
 	unsigned int i;
 	const bool is_be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 
@@ -122,7 +122,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 
 #define TEST_HEXDUMP_BUF_SIZE		(32 * 3 + 2 + 32 + 1)
 
-static void __init test_hexdump(size_t len, int rowsize, int groupsize,
+static void __init test_hexdump(size_t len, size_t rowsize, size_t groupsize,
 				bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
@@ -139,16 +139,16 @@ static void __init test_hexdump(size_t len, int rowsize, int groupsize,
 				  ascii);
 
 	if (memcmp(test, real, TEST_HEXDUMP_BUF_SIZE)) {
-		pr_err("Len: %zu row: %d group: %d\n", len, rowsize, groupsize);
+		pr_err("Len: %zu row: %zu group: %zu\n", len, rowsize, groupsize);
 		pr_err("Result: '%s'\n", real);
 		pr_err("Expect: '%s'\n", test);
 		failed_tests++;
 	}
 }
 
-static void __init test_hexdump_set(int rowsize, bool ascii)
+static void __init test_hexdump_set(size_t rowsize, bool ascii)
 {
-	size_t d = min_t(size_t, sizeof(data_b), rowsize);
+	size_t d = min(sizeof(data_b), rowsize);
 	size_t len = get_random_u32_inclusive(1, d);
 
 	test_hexdump(len, rowsize, 4, ascii);
@@ -158,13 +158,13 @@ static void __init test_hexdump_set(int rowsize, bool ascii)
 }
 
 static void __init test_hexdump_overflow(size_t buflen, size_t len,
-					 int rowsize, int groupsize,
+					 size_t rowsize, size_t groupsize,
 					 bool ascii)
 {
 	char test[TEST_HEXDUMP_BUF_SIZE];
 	char buf[TEST_HEXDUMP_BUF_SIZE];
-	int rs = rowsize, gs = groupsize;
-	int ae, he, e, f, r;
+	size_t rs = rowsize, gs = groupsize;
+	size_t ae, he, e, f, r;
 	bool a;
 
 	total_tests++;
@@ -185,7 +185,7 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 	else
 		e = he;
 
-	f = min_t(int, e + 1, buflen);
+	f = min(e + 1, buflen);
 	if (buflen) {
 		test_hexdump_prepare_test(len, rs, gs, test, sizeof(test), ascii);
 		test[f - 1] = '\0';
@@ -199,8 +199,8 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 	if (!a) {
 		pr_err("Len: %zu buflen: %zu strlen: %zu\n",
 			len, buflen, strnlen(buf, sizeof(buf)));
-		pr_err("Result: %d '%s'\n", r, buf);
-		pr_err("Expect: %d '%s'\n", e, test);
+		pr_err("Result: %zu '%s'\n", r, buf);
+		pr_err("Expect: %zu '%s'\n", e, test);
 		failed_tests++;
 	}
 }
@@ -208,10 +208,10 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 {
 	unsigned int i = 0;
-	int rs = get_random_u32_inclusive(1, 2) * 16;
+	size_t rs = get_random_u32_inclusive(1, 2) * 16;
 
 	do {
-		int gs = 1 << i;
+		size_t gs = 1 << i;
 		size_t len = get_random_u32_below(rs) + gs;
 
 		test_hexdump_overflow(buflen, rounddown(len, gs), rs, gs, ascii);
@@ -221,7 +221,7 @@ static void __init test_hexdump_overflow_set(size_t buflen, bool ascii)
 static int __init test_hexdump_init(void)
 {
 	unsigned int i;
-	int rowsize;
+	size_t rowsize;
 
 	rowsize = get_random_u32_inclusive(1, 2) * 16;
 	for (i = 0; i < 16; i++)
-- 
2.39.5



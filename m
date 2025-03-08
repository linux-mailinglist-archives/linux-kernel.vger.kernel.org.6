Return-Path: <linux-kernel+bounces-552402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4962A5798E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1911729B6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF09B1AF0BD;
	Sat,  8 Mar 2025 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U69HOax7"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49CD1B0F34
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426521; cv=none; b=bXqu1rXfhdF2+PMXrvOnX3r3zjZmG+wsue2mdHHHYVT8xxmoekfZCnmPU81iHUBVZNb0oYLFyPDuxLg/DCtYN2rtC4VaA7tTvROzuScRyGX3eq1QPPtChL15akSdc97GW4vKJBdxXVXVqavkSBE9yu2DnLkwj4xUyNwBrwTyidc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426521; c=relaxed/simple;
	bh=rXSaBXfcbQJqt0BgGEAbtlgiusEoJFPxi/+hJvLdrpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXmk3lI7eEAJiXTx6RRhfuCL17W+JiGv9rvsaz0sT8HL9RYzW/G/Ow/pqIGnEz3fp9C6EQDgiKOC+bOF/rF4hsqh3VV+1NxOFMwZyRd1Laq/FudzomDJ9Ral57uepBzSdyRZUinar1RMSD5GM5R2A+9gTAexDeI2ZbkO5+7d0Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U69HOax7; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43bc63876f1so22564575e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426518; x=1742031318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dBEWPyN2Xgq5pJleu9O7q2U3augDpu+DFH6QigHgwU=;
        b=U69HOax7O7tgliUTBLPRdkS1Kwhf58XmoxlpZLBU39S8hjuiSeUJN7yRBOnjOnqwJL
         BA/xQQa3PXiBuwBL4ZSxbg5MpT1lEzHY668Aw2PMMgGfcQqyU0M6BnakPFYfyUy4syGj
         CFpDyuPFFbnovhA9suKTuhQYbqesGk16OMO66geRA3bBvXfBWO0ObVjEnYTyt528nVCP
         t/2/dYfLOqoEQO53GPR4JP80Wh37om2eXGkTtb+R3BLoI2f684qqD/sCb95RsCfPQRus
         1iIxgz0XvR8EkFGTr8rC0XLgnAqWHsePkIx0wSAIG4iLjKAcebpVA4agrovl+oO614Ug
         BY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426518; x=1742031318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dBEWPyN2Xgq5pJleu9O7q2U3augDpu+DFH6QigHgwU=;
        b=SX30sZkFfSHpW9fNY0FuaOY2IOqB75KG2DxFti/R6r81AOUDTuUZLBzVDmnoPUm2UK
         wbKqARSazIT9uzayp48xuhMMcIZDJX2LnAQIV8TkpqEZLp72zTBNXwB+XpnA6qRQZR8e
         G2qSKvQ72WVU0EmWUAU43OlbSJd5bCQuBssUkDs6g+q2LAVfYKLNsBBi0J7yVwsVgZY6
         JOojADvzSE8hOM6vMm/VS/alMO/b/5IUwij4+rMrUa5OLe7Z1ONUTOwamGBVHOlc7VI0
         EScM/Ckg1vCJpgl1rvJB4WLLh3LlhIr6w8vcVdHiPYSqC91UIHmSFVt2rbYotZuXNxpp
         oCmQ==
X-Gm-Message-State: AOJu0YyDPFcU67HdI4tw/MX/kFMwUR/ljHELteGrOZ5AhR80d80hfywP
	SZi6UH0J52jdc/X6NR0sq6kuiOgwIGeCwsvPT++QKXvBqet+OgqrNv5K+w==
X-Gm-Gg: ASbGncusSM4LLsvCnFGgIW254ANqkuoTfvV8ea44kpQgBCOPyr1KOun2k9J9NmkGzqB
	5J7r9Ys3bAcsUAAKOmsW2NbErpF6LubA7ebKU+TgZczI9gGO6jjZq1SrL6FG2LMwEDyrFXurPw9
	xQvrqVj+hPdhIM9mbfMCoPSExDPXR2BdKDdxkREBablGsO2r+Dy7Iz4mqUsTf/pJ5nJ7r3sSx5x
	8zUW4QLtKi5q9fUvbxC33iXLRQHjL8KKPhPVp5QzdqTSYmcw72/IA7RgdIRU1arST9F3tDXKgDO
	Az8yh9xqeGUnK7AairwaDMdeQcCpj58FC9vVDCHFwdVuKApuuJG70L8dJFmYRVCdQEqzBAmsjM+
	8ci0W0OclrJDMt4CsvpUZpkqrmA==
X-Google-Smtp-Source: AGHT+IGDKj9fyryLAzHMCbNhcW2J4OZGRgKyhPcEXWP1tdnrhn1453rxJtqLSLot6YFXQkrk/6KtGQ==
X-Received: by 2002:a05:600c:3791:b0:43c:ec28:d303 with SMTP id 5b1f17b1804b1-43cec28d49fmr5086675e9.5.1741426517965;
        Sat, 08 Mar 2025 01:35:17 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 01:35:17 -0800 (PST)
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
Subject: [PATCH next 6/8] test_hexdump: If a test fails print all the parameters
Date: Sat,  8 Mar 2025 09:34:50 +0000
Message-Id: <20250308093452.3742-7-david.laight.linux@gmail.com>
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

Print the returned lengths as signed integers.
While they shouldn't be negative, -1 is better than 18446744073709551615.
The string outputs were also incorrectly truncated.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 07a8cc7e9088..56c0dfbd075b 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -146,13 +146,12 @@ static void __init test_hexdump_overflow(size_t buflen, size_t len,
 
 	ok = result == expected && !memcmp(test, buf, TEST_HEXDUMP_BUF_SIZE);
 
-	buf[sizeof(buf) - 1] = '\0';
-
 	if (!ok) {
-		pr_err("Len: %zu buflen: %zu strlen: %zu\n",
+		pr_err("Rowsize %zu, groupsize %zu, ascii %s, len %zu, buflen %zu, strlen %zu\n",
+			rowsize, groupsize, ascii ? "yes" : "no",
 			len, buflen, strnlen(buf, sizeof(buf)));
-		pr_err("Result: %zu '%s'\n", result, buf);
-		pr_err("Expect: %zu '%s'\n", expected, test);
+		pr_err("Result: %zd '%.*s'\n", result, TEST_HEXDUMP_BUF_SIZE, buf);
+		pr_err("Expect: %zd '%.*s'\n", expected, TEST_HEXDUMP_BUF_SIZE, test);
 		failed_tests++;
 	}
 }
-- 
2.39.5



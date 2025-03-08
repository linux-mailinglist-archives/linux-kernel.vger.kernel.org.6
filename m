Return-Path: <linux-kernel+bounces-552400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4E8A5798C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915E11729AA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41BC1B395F;
	Sat,  8 Mar 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQumPoEA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556501B042C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741426520; cv=none; b=ay9HAon3bzU626hXYezI9yqs1Ngb2nb0o8hI/8kWvXZGIQhSyF8focJmwT9llTgfiNMdhshXvGMVBr+AaaMQji5xD+MXS5pLpmj17oufZuu8u2Web+Ul/g/6tcEmw/iDbiW4jUQJVsui6eWwgs27vuw7KhICYhTeZZFIirg11Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741426520; c=relaxed/simple;
	bh=Na5QZnzZVT+yDAfsuNqlRZjHxAdQgXYY3JM2ct9y3rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SCxA/BzoPqxcnRQL49fgS4oPNIwES0cjr+knB5AWABjcHUicvDMaDf+BuIU6KZWed08PNye6iI6ptY4iQEeHKO1llw/Rcv8xMqbr1p/NcHaXzvCnxSq3uRryvawirCJ13xBEclRIn/J1fHySzGelFKQ40hIAY4V7P7kYJZZPS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQumPoEA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3913cf69784so321128f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 01:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741426516; x=1742031316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcclpSrczhYCUkaASfB4VlFx0+UuGDBAbCCoNJpvREs=;
        b=EQumPoEAorNYFDyTVpkeFw6NixWK0paRObthSgC3xE/az44Yq9qabbwyS0TkGouaTS
         Cozs27wVr6Cm6RgPNtuCG04lcOxtjq6iPkxeHXwR8Bq517BmhrXIXpQmo2jgJltACy7L
         TfO0t8K1ZU4sm6zvVSE6GJsws+pEf8BC3DDcjrM7bNFNnD17wGYERNKiizfE1834XLcc
         ZQ3Ef0d+TiCSKXLI7wPgidMJDvOSHN+3KPQ9i+504HyfwNw9b7f1nIaB5ePqrKaxvWLB
         suaocpt5bmFxv+mFPQa4XKU7F1drKTCUTIYoWwiRzwtymdNcW4GizIHG0ks8dN2VtXsX
         ErSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741426516; x=1742031316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcclpSrczhYCUkaASfB4VlFx0+UuGDBAbCCoNJpvREs=;
        b=XQGEAbohhz+wdz7U4KWrcYO/inj5dgY0i9TVqIjPbKp0UAFF46XaYO3wz1kVqU2oCO
         O8fGRD4YRdHuvBB7BGUtcRR6SkwjuhIdS8vEGDYTWXi14PyQdLiMO0f/cyi/pURa3Ywj
         9ZT2D7F52u+vYUh5HuwMgL19/3o5qq4xVfrPa2BaM/KjWL6e81+UeTFBCT58Xr4RUpSY
         /bd8NGnitGX1ml7ZBch3iJ7mA5qqfBwccbzhvl/MFen3+oF6pXCFfc/ninGeVAltD2wA
         vq6foq9BTW8jysoD5t4DUxt2R6iiUWZJ7YbsOJlazdgeQ4kEL//6VE93iD9AqwQXU6Ic
         YzWg==
X-Gm-Message-State: AOJu0Yw7ivK6SrWBFX2v4QHELV6GZ8O6jZYb6Murgn3HeCQXcQzBaIQJ
	6CaQRZKkSVqC6dbtdM8vI/DrboCvUl00MpKtuh8JemsX6AkR5ZmgWI6CrA==
X-Gm-Gg: ASbGncvNaRuvcmnzvfUz0220rtrng10xv25njdoe7y/3kDignGbNI/+efGsAo5zXtGX
	wg5AVgeAneZPA6OxF9hxVz5L3GOb8JQaKAl97GQNlYRHrNkfnfM5PNLVePdPd7QwhCi1pE5Fp3P
	/9GhE35IxvsfxRRy5gVj/eeIjUzH7OxRN2hT33eOJPtosg9S3KM0rd098KtrlqNSI0KQlKMB7PG
	zr6anL+CeJePBFXY+3djVgGZux7czITv97gDt2GxQzj2y/WafyUqQ59Ncb3pDfiA0zbaCAEzbh9
	Xiy+mqmM3RyqcFFJYEw+SRXOrMR1ggA+Ac6MzBxzBcIeDALVHUCqaHan1NHDjMo9cpINNVVw9aH
	E6aY6JV0L/5NavbdV9sjja/HN8w==
X-Google-Smtp-Source: AGHT+IHS4j9ICyntbrA/BcR/VMofdv33fdKuwLaq8j3TbpKch7Ews0lvzB0+RnXZFglw24Avy0rteg==
X-Received: by 2002:a05:6000:1fa9:b0:391:212:459a with SMTP id ffacd0b85a97d-39132d3b46fmr6507270f8f.22.1741426516381;
        Sat, 08 Mar 2025 01:35:16 -0800 (PST)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce3f573f6sm15663895e9.0.2025.03.08.01.35.15
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
Subject: [PATCH next 4/8] test_hexdump: Check for buffer overrun of sample output buffer
Date: Sat,  8 Mar 2025 09:34:48 +0000
Message-Id: <20250308093452.3742-5-david.laight.linux@gmail.com>
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

While the output generated by test_hexdump_prepare_test() shouldn't
be longer than the size of the buffer passed, for safety verify that
the buffer is long enough.
If too short fill the buffer with an error message - output on
test failure.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 lib/test_hexdump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 743ea5c78f9e..ed6f0b0a1bb3 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -39,6 +39,14 @@ static size_t __init test_hexdump_prepare_test(size_t len, size_t rowsize,
 		groupsize = 1;
 	byteswap = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) ? 0 : groupsize - 1;
 
+	/* Check test passed a big enough output buffer */
+	if (ascii)
+		i = rowsize * 2 + rowsize / groupsize + 1 + len + 1;
+	else
+		i = len * 2 + len / groupsize - 1 + 1;
+	if (i > testlen)
+		return scnprintf(test, testlen, "buffer too short %zu < %zu", testlen, i);
+
 	/* hex dump */
 	p = test;
 	for (i = 0, j = 0; i < len; i++) {
-- 
2.39.5



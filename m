Return-Path: <linux-kernel+bounces-247378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1347F92CE9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A3D2851D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44618FA12;
	Wed, 10 Jul 2024 09:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVEPnfI9"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07617FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720605379; cv=none; b=J/0GHM1JkvqXpKa4YsbP7B3NuDY/N9qzaFXmB2yhYJEYAQUoqSe0DxOfatV7VDYqbYq11RRzXf4N5/d0vQwAQfb8KRrTpCrwxZkAor0nQ/FGztr3oALF+6SEoL1I+zCtHWI/1KKno0UFJ4HbNsGTV8KX+Ipeo6aGsFRMpZ641mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720605379; c=relaxed/simple;
	bh=wqWlbYlS7N3yx2WPKzAhoN3+IiDRu+UrnoJRbZBcmQY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=UDU7n2HOWBANDKsEkzzeFi+eSgjICfWjFxqapDTDLGqAeiaNasAvhTbig3v6Jy8yI5uXthNGWcBxxY0Pw0QuKHar9DCQz9JemXnnzrwDC6vA8XLREanF7NHQbiGSRku+7QLv+sJ2ecgcWfz1wZPZzB1rg1fmgcCgRuKwvk1ah3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVEPnfI9; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso9259163e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720605376; x=1721210176; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qz+ZiHe2xfuBvGAa3ktMKXkdnx1A8H5OqyA9EhFkg+E=;
        b=BVEPnfI9q/eBVPx5elgD7LrCJRslHusSqZqvJRUl8siTpwxx8vjBDzBzAxdEBfuFJQ
         lyUsrMUi+VTUwa743wGReCu+pbsRnnSCSitN063KMyn7MnB283wSdcI2HbE20oPYX7b+
         LHPXgB4Gp+WOfGF2Vtab57r1JG7k8kjMPHgdgqvBsbFmEs/EN4+2OV/Pnx/BTHkOjtV2
         JoJE6Dg6nqfWu7La6V4FoNNZBix/pPelAUkYrbEzZ2C9jvZY3m67F4bu9x55OwSmQtvT
         VZfYN/zoHLXfFazJ2RKQ3I+R8DJ1fqHIWbbcHLkCLhIAQTFTR+hxxLmkSQV9ne48uytK
         ktDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720605376; x=1721210176;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qz+ZiHe2xfuBvGAa3ktMKXkdnx1A8H5OqyA9EhFkg+E=;
        b=sXLALZpgpWlS7Y1dDqESfE09Wl4uWcKTYhTpXy4oR3fd5YzpXNCoSdFfXIPImNEw4h
         jnaKztpjHKrlycBE++XOT6VWmk+3eAr/dfkfqvGbgDGEXtH5ih9q9Ve3ho6awMcv01cz
         qscef2B5lOPLIBN14VAPY8XuKfaEeEjdNxwuzOnHUbLUTuWQIrPgvmyPHmtLaJbBwWUg
         7D7I/sTmDKn7spV3jVI2n3zuolJohxV83iQZKdVzP91QP0bOP90mtObwvnmHOSCfSl89
         qZHp4PdGI9uDxZDTR7R2ZwM4+hdvWRnHx7+t08bBKIbVUbiqBD+eYumLZ52lEweKOq3o
         Jr3A==
X-Gm-Message-State: AOJu0YwyHsb76ScuREi5gHw8X9oYtmvtKBJNvM8c4GE0w6UAvwiMdvak
	ZM9JsYxHAdUWOgrrraHaQ2Zu2MVFTQ/a+vhQju9SGRG8L9nctqiqqpIPzD4Q
X-Google-Smtp-Source: AGHT+IH6rQfsGGt7ETBzxGKa4aSbbArSu2d3kYHBhwiHIlXcOuXjyUZ+DpsU1L2YVBSIbPlKH64SIw==
X-Received: by 2002:a05:6512:e85:b0:52c:f55d:44a3 with SMTP id 2adb3069b0e04-52eb999b3aemr4303101e87.19.1720605375857;
        Wed, 10 Jul 2024 02:56:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a872002sm144729166b.211.2024.07.10.02.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2024 02:56:15 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] radix tree test suite: put definition of bitmap_clear() into lib/bitmap.c
Date: Wed, 10 Jul 2024 09:55:54 +0000
Message-Id: <20240710095554.16725-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Instead of keeping a bitmap.c in radix-tree own directory, we can use
the common implementation in lib/ directory.

Just move the definition and link some related libs, no functional
change.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
---
 tools/lib/bitmap.c                | 20 ++++++++++++++++++++
 tools/testing/radix-tree/Makefile |  4 ++--
 tools/testing/radix-tree/bitmap.c | 23 -----------------------
 3 files changed, 22 insertions(+), 25 deletions(-)
 delete mode 100644 tools/testing/radix-tree/bitmap.c

diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index c3e4871967bc..a96dbf001244 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 			return true;
 	return false;
 }
+
+void bitmap_clear(unsigned long *map, unsigned int start, int len)
+{
+	unsigned long *p = map + BIT_WORD(start);
+	const unsigned int size = start + len;
+	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
+	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
+
+	while (len - bits_to_clear >= 0) {
+		*p &= ~mask_to_clear;
+		len -= bits_to_clear;
+		bits_to_clear = BITS_PER_LONG;
+		mask_to_clear = ~0UL;
+		p++;
+	}
+	if (len) {
+		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
+		*p &= ~mask_to_clear;
+	}
+}
diff --git a/tools/testing/radix-tree/Makefile b/tools/testing/radix-tree/Makefile
index 7527f738b4a1..505cc24a8b9c 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -5,8 +5,8 @@ CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
 TARGETS = main idr-test multiorder xarray maple
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
-			 slab.o maple.o
+LIBS := find_bit.o bitmap.o hweight.o vsprintf.o
+CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o slab.o maple.o $(LIBS)
 OFILES = main.o $(CORE_OFILES) regression1.o regression2.o regression3.o \
 	 regression4.o tag_check.o multiorder.o idr-test.o iteration_check.o \
 	 iteration_check_2.o benchmark.o
diff --git a/tools/testing/radix-tree/bitmap.c b/tools/testing/radix-tree/bitmap.c
deleted file mode 100644
index 66ec4a24a203..000000000000
--- a/tools/testing/radix-tree/bitmap.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/* lib/bitmap.c pulls in at least two other files. */
-
-#include <linux/bitmap.h>
-
-void bitmap_clear(unsigned long *map, unsigned int start, int len)
-{
-	unsigned long *p = map + BIT_WORD(start);
-	const unsigned int size = start + len;
-	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_clear = BITMAP_FIRST_WORD_MASK(start);
-
-	while (len - bits_to_clear >= 0) {
-		*p &= ~mask_to_clear;
-		len -= bits_to_clear;
-		bits_to_clear = BITS_PER_LONG;
-		mask_to_clear = ~0UL;
-		p++;
-	}
-	if (len) {
-		mask_to_clear &= BITMAP_LAST_WORD_MASK(size);
-		*p &= ~mask_to_clear;
-	}
-}
-- 
2.34.1



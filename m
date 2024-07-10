Return-Path: <linux-kernel+bounces-248013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC492D767
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFB3281023
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BECD195811;
	Wed, 10 Jul 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm+JBkLe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0787F194C6B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632485; cv=none; b=l0H3M12ICb4Ykr4ZdHB+VfJxjDBTOJoBc1JM1I6M0FsI/gwkMXj/658HuYrUfr3mwJOGIxxoxpwPdKxMRJLcWi1Ph+OTR9gy6c3Ma5A63vfJR6IJnPI7oSzGhEaYFwknnOyd47cGzGuymHDBYMiR9Zbioc1EpYv6BuLpBrc8HgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632485; c=relaxed/simple;
	bh=5M0Z+twPzS5H/7Fk/AofbvITS4D+6B2D73tqhVM8HTo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=A14y1H1XAO60wPkdr+s50muTlrJ+dbjMtXO7ZzsOdZ0TvjEv1rvnhrK711TzMXBSCaRdR7LN6+NfDuIDCTeGWSn36uI6njFnn/FW0osW00CNPAlEDtdFw29/5EVua+27myzNnlLyjc++V8h2qZmmePayMmDMaPlNZCn1aRnMsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bm+JBkLe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c2d89af8so1504566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720632482; x=1721237282; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdzfKFewUXp8Gva8L/9tc+XCpKnJk6sYSuWwtObhPbE=;
        b=bm+JBkLe5J4YvhwAwAh1SkVe4UD/EGh1fzQP9DIU7C8bGKqT8XyxtJauVLpZvVPkQQ
         SKkAq9rtDLhbFDR74w8hTHXsH2w0JIuIQ2FPmPiofQE8/b0DpRxnDAVyKV4Aud2zug4D
         FkHCYe7JQA5qfX9c9kRjv/uo4ujR3+Jeints+BHV7S6yGAULS/WzQZHI2FREgBher/BV
         uMuloxUeehufa4cyTjJXp9ZeS3tuLfn8nup31zO4/pxFB4Zdt2/9T74m2gmaRPeBJQ8t
         3v/SJZPkJ9c9udi1kXifwTzpYb8414gfCa646JlIy5rNkPUBY3oENfLjRHVSufFjHdy6
         +8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720632482; x=1721237282;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdzfKFewUXp8Gva8L/9tc+XCpKnJk6sYSuWwtObhPbE=;
        b=GgqIzZAkapDGPQk4VCfFlfXcjQS0Csc0jA0crQrc0rd8c6m7JmAo6IbUTmZPetHy6e
         zqPxxriobK0pg4MdpqEhN68h94QN/fwlHjFwSh41YFU+jK8i64mQRUh+BtWZy1yRSfkL
         HPOfxq1nzhFk9mmdwaffUc01xlxZETFZN7PfX/W6gYY2u4pG1EDlE5XkqICu208sVCrW
         6W2HGE33whcDXK6uKMiR8ZjZ1HovBz/2j8pceFnCJT0ivQ1AfqfK6ijDDydGcjtyFkRS
         Np5YB6khdphtunMQkNukLa2ykeEfsvsJ7Xt+VKzON1BAFWNs0HNZWs8NoUZrn/wnWZzZ
         DNig==
X-Gm-Message-State: AOJu0YxECu71lmjt+4T1V/ow4qqwFzimLQCNuKA4ig1nk1S0uofitTHw
	tQOZIFhzskIT+Ypjhn0HwF6I6QvnV94/A01qLg8uB+WT5uoUmAZuglT9wX0t
X-Google-Smtp-Source: AGHT+IGT5UEq+gCbVVD6lrXclnaqcfk2yE8QODonY1eGnbVz1/aQnDQtvYxo8yEoXFt7l+/vgcmVEQ==
X-Received: by 2002:a17:906:f0d4:b0:a77:cbe5:4135 with SMTP id a640c23a62f3a-a780b6b1ce4mr352825266b.20.1720632482312;
        Wed, 10 Jul 2024 10:28:02 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc701sm178420566b.34.2024.07.10.10.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Jul 2024 10:28:01 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2] radix tree test suite: put definition of bitmap_clear() into lib/bitmap.c
Date: Wed, 10 Jul 2024 17:27:01 +0000
Message-Id: <20240710172701.21339-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In tools/ directory, function bitmap_clear() is currently only used in
object file tools/testing/radix-tree/xarray.o.

But instead of keeping a bitmap.c with only bitmap_clear() definition in
radix-tree's own directory, it would be more proper to put it in common
directory lib/.

Sync the kernel definition and link some related libs, no functional
change is expected.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Matthew Wilcox <willy@infradead.org>
CC: Yury Norov <yury.norov@gmail.com>

---
v2:
  * slab.o is also defined in lib/, so put it in LIBS too
  * sync with kernel implementation
  * explain how bitmap_clear() is used in tools/
---
 tools/include/linux/bitmap.h      | 17 ++++++++++++++++-
 tools/lib/bitmap.c                | 20 ++++++++++++++++++++
 tools/testing/radix-tree/Makefile |  4 ++--
 tools/testing/radix-tree/bitmap.c | 23 -----------------------
 4 files changed, 38 insertions(+), 26 deletions(-)
 delete mode 100644 tools/testing/radix-tree/bitmap.c

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 210c13b1b857..2a7f260ef9dc 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -19,7 +19,7 @@ bool __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, unsigned int bits);
 bool __bitmap_equal(const unsigned long *bitmap1,
 		    const unsigned long *bitmap2, unsigned int bits);
-void bitmap_clear(unsigned long *map, unsigned int start, int len);
+void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int bits);
 
@@ -150,4 +150,19 @@ static inline bool bitmap_intersects(const unsigned long *src1,
 		return __bitmap_intersects(src1, src2, nbits);
 }
 
+static inline void bitmap_clear(unsigned long *map, unsigned int start,
+			       unsigned int nbits)
+{
+	if (__builtin_constant_p(nbits) && nbits == 1)
+		__clear_bit(start, map);
+	else if (small_const_nbits(start + nbits))
+		*map &= ~GENMASK(start + nbits - 1, start);
+	else if (__builtin_constant_p(start & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
+		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
+		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
+		memset((char *)map + start / 8, 0, nbits / 8);
+	else
+		__bitmap_clear(map, start, nbits);
+}
 #endif /* _TOOLS_LINUX_BITMAP_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index c3e4871967bc..2178862bb114 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -100,3 +100,23 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 			return true;
 	return false;
 }
+
+void __bitmap_clear(unsigned long *map, unsigned int start, int len)
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
index 7527f738b4a1..d1acd7d58850 100644
--- a/tools/testing/radix-tree/Makefile
+++ b/tools/testing/radix-tree/Makefile
@@ -5,8 +5,8 @@ CFLAGS += -I. -I../../include -I../../../lib -g -Og -Wall \
 LDFLAGS += -fsanitize=address -fsanitize=undefined
 LDLIBS+= -lpthread -lurcu
 TARGETS = main idr-test multiorder xarray maple
-CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o find_bit.o bitmap.o \
-			 slab.o maple.o
+LIBS := slab.o find_bit.o bitmap.o hweight.o vsprintf.o
+CORE_OFILES := xarray.o radix-tree.o idr.o linux.o test.o maple.o $(LIBS)
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



Return-Path: <linux-kernel+bounces-275527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F19486DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42654B21075
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710A41804A;
	Tue,  6 Aug 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW2Y14Cl"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C18C1E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906217; cv=none; b=QC+OzvXDra9YmpDtJV8Uo7e1lMX+QuXcN+5iphoovuMIxx4udDS2X3dr0QRSODefHxGkMtxaU4IwZ8kFnPsMRCpYcp7ysf52B9r2ahVkdYJU0zAsOAgDhQcvvZYDquCWqFcPGsLjZUMdMYASZgL6c5UHh9rUrLqSGVClh/mR4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906217; c=relaxed/simple;
	bh=g77zQiVriTZdZ2Jk6UEYqWv9smXGMroHgJ9a97y3zgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QRQIcFM8VAtS1hRXPEln82iYpwK59WElYs/lUQg/pwwcVWdsdMDSp1gY/6QkgBQKkmi+FCXR0A5rFsqkdWqgzbm/y3rgZn/mnYA0JocV5zfO5CkO4M8X21SfTkAH+zaweYkpu77K6UuEOTxUP0cfs9cypogI0CacH6I+CGfp9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gW2Y14Cl; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aada2358fso1014658066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722906214; x=1723511014; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyYOlz2K4LoDSHsLe8705YksXRaxa+aqBd+KCuRDSeI=;
        b=gW2Y14ClrbmDC3yRsMDjoMbxYZ+dmjTbhsfZhZyYYtJVw9HiG0hdPjgkawYqq/k6Hy
         04JFZRd7z+eTbzmAwst8k85croZCeAz/k2npnXpLIACpH6P3g6U9YySZbJHiYUHMnz4X
         REM8aoFjEeY3o1cNCBJOXxxH75enVO2GwwHN4IU6trlZv4TAgfEmPfsl9iXAGjYZdZot
         hI9GUHICPkp6d7KlNO/BiTnaow0n9PG5sdVVT8KqGMRbzZZeODYlfq4KBKvHpGHoJn17
         TRINmsLlAdD3pieArEYMkhZTd2IDWXG6+gCNklHs6XB7ONkoYDIBFPvZXY5gj3/ueC9a
         CKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906214; x=1723511014;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyYOlz2K4LoDSHsLe8705YksXRaxa+aqBd+KCuRDSeI=;
        b=gvc+M5/HUDLdub4rzui9U4tZDevNhpFpxFdasr4oYMWtbAh7Vloh/zM5RIz1Unmyzc
         zfCLSXNWxffM9He4NC/CO/L/+zq9XXY8xd1mXCiudhVBOBDYW3dgJrITLk6hAgTznEWG
         UOIqZNjySbZHO08wg5HF2aKRU71DDXiXwbvF16BVeT+526SqxPXoCIPPV70IE2w/sfLY
         cXZ10fl4LVRbyqxHc71PYefudZ3hGF2qaKPy4PnUFq3NQHCAdrE0reiRAT8vksP2QKHw
         KxqnlnZDMXKCxvj8yxSWy/ZS0T0mgBXks2lmF0AyHHZ89OjtTBbzZ8Sb2FIcyAi8ft4e
         sg0g==
X-Gm-Message-State: AOJu0Yw8iCtqWwD8NIsHJ2Ua42KeNpMxUrnwKk/I/cfVCOBD6dMlaxmN
	31QE9ayRa1wxSA2cYQAjEDiIE2tFtUEZbNVju7FGP+M+MzJ/33YM
X-Google-Smtp-Source: AGHT+IHqAXbyPKmlhIkOspU9uqm8KIkjo9T7iVX7QCIWp5S/2DklXoQj3Aa3giIsvCG/CqJlwiGi9w==
X-Received: by 2002:a17:907:6d12:b0:a7a:8a38:9d99 with SMTP id a640c23a62f3a-a7dc628ea90mr901339766b.35.1722906214345;
        Mon, 05 Aug 2024 18:03:34 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e7fe2fsm504877666b.178.2024.08.05.18.03.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2024 18:03:33 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 3/5] memblock test: fix implicit declaration of function 'memparse'
Date: Tue,  6 Aug 2024 01:03:17 +0000
Message-Id: <20240806010319.29194-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240806010319.29194-1-richard.weiyang@gmail.com>
References: <20240806010319.29194-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 1e4c64b71c9b ("mm/memblock: Add "reserve_mem" to reserved named
memory at boot up") introduce the usage of memparse(), which is not
defined in memblock test.

Add the definition and link it to fix the build.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 tools/include/linux/string.h          |  1 +
 tools/lib/cmdline.c                   | 53 +++++++++++++++++++++++++++
 tools/testing/memblock/Makefile       |  2 +-
 tools/testing/memblock/linux/kernel.h |  1 +
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 tools/lib/cmdline.c

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index db5c99318c79..fb8eda3019b5 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -47,4 +47,5 @@ extern char * __must_check skip_spaces(const char *);
 extern char *strim(char *);
 
 extern void *memchr_inv(const void *start, int c, size_t bytes);
+extern unsigned long long memparse(const char *ptr, char **retptr);
 #endif /* _TOOLS_LINUX_STRING_H_ */
diff --git a/tools/lib/cmdline.c b/tools/lib/cmdline.c
new file mode 100644
index 000000000000..c85f00f43c5e
--- /dev/null
+++ b/tools/lib/cmdline.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * From lib/cmdline.c
+ */
+#include <stdlib.h>
+
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
+#endif
+
+unsigned long long memparse(const char *ptr, char **retptr)
+{
+	char *endptr;	/* local pointer to end of parsed string */
+
+	unsigned long long ret = strtoll(ptr, &endptr, 0);
+
+	switch (*endptr) {
+	case 'E':
+	case 'e':
+		ret <<= 10;
+		fallthrough;
+	case 'P':
+	case 'p':
+		ret <<= 10;
+		fallthrough;
+	case 'T':
+	case 't':
+		ret <<= 10;
+		fallthrough;
+	case 'G':
+	case 'g':
+		ret <<= 10;
+		fallthrough;
+	case 'M':
+	case 'm':
+		ret <<= 10;
+		fallthrough;
+	case 'K':
+	case 'k':
+		ret <<= 10;
+		endptr++;
+		fallthrough;
+	default:
+		break;
+	}
+
+	if (retptr)
+		*retptr = endptr;
+
+	return ret;
+}
diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
index 7a1ca694a982..d80982ccdc20 100644
--- a/tools/testing/memblock/Makefile
+++ b/tools/testing/memblock/Makefile
@@ -8,7 +8,7 @@ LDFLAGS += -fsanitize=address -fsanitize=undefined
 TARGETS = main
 TEST_OFILES = tests/alloc_nid_api.o tests/alloc_helpers_api.o tests/alloc_api.o \
 		  tests/basic_api.o tests/common.o tests/alloc_exact_nid_api.o
-DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o
+DEP_OFILES = memblock.o lib/slab.o mmzone.o slab.o cmdline.o
 OFILES = main.o $(DEP_OFILES) $(TEST_OFILES)
 EXTR_SRC = ../../../mm/memblock.c
 
diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
index d2f148bd8902..c16d9cd2d1ae 100644
--- a/tools/testing/memblock/linux/kernel.h
+++ b/tools/testing/memblock/linux/kernel.h
@@ -8,5 +8,6 @@
 #include <linux/printk.h>
 #include <linux/linkage.h>
 #include <linux/kconfig.h>
+#include <linux/string.h>
 
 #endif
-- 
2.34.1



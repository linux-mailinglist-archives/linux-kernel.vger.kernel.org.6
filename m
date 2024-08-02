Return-Path: <linux-kernel+bounces-272012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE5F9455DF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 03:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8FCE1F22F20
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAA117C68;
	Fri,  2 Aug 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPbgRLZp"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F58F70
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 01:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722560979; cv=none; b=Q3L9dOboijLZB3jx2mI0ukbBHR43927rO3YYrLCh8/kg+APnUXpdKzuUWF9TR/GIVEisv6pHlk4wd1DUN6dR8edAD+SmGjl6GrX4Vi329kezWyTto2i2g/VWLvAZzUPfCq1A4IasfiY+OcZA1gesa+kSAwyP6vYezL6MVF04tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722560979; c=relaxed/simple;
	bh=g77zQiVriTZdZ2Jk6UEYqWv9smXGMroHgJ9a97y3zgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LcgBwrXV56o6Z7rblMlhzbVisoXVDVBCRY+UQP81wfk2Y0hzPE9UTDS1y6aFcBc52Qo7SuyJTIkX63x2jh5HQ8DQy239NDZf9o8FysLlN5LbPcymJSwNFqcFKDNR0JBNagGn7pBY5xeEkRQFi7jC81lCrMQxaUToQhW7WpMy0kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPbgRLZp; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so1020160166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722560976; x=1723165776; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyYOlz2K4LoDSHsLe8705YksXRaxa+aqBd+KCuRDSeI=;
        b=YPbgRLZp5gWhRXwY5ho+59GxNZYpyvR9m105gGoTV6c2a+oPBUCPCP5HR3tQu3MzV8
         TkmIeRVoaZAwTU7Qw2V5NjZwn1Y+5Wfg467Qbshrvne0g8Gvc5KTXECAw6SJvdUkXj9l
         S2vatz2+csZio1mTcNIDqHihTBUkruLo2upvlSIZho3TM8gKYrLe0d6Wy+GwjZYIKTaR
         uSfXo1criqiCd+FrQdaNsnvSSaebzEE6THG/9Uhmt/vMwo5NQUUYAZxUemlJ2MchRwZG
         +9anCKDRahMF24JPAxvsyAWcoCYUuyGnypFxf8NzKr5qn/qL4Qja5nKDvgjAZBcqe7Bw
         XYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722560976; x=1723165776;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyYOlz2K4LoDSHsLe8705YksXRaxa+aqBd+KCuRDSeI=;
        b=vgWkb0XqQSOrTkLZhWerlM06SCEsLw+wXOBx4/JuoTEFOb1Fpc28A+YgNOVpO/BGzw
         VRsbg3+A0Ub8pL+rNNJq5/bGzYNet/za1gk+sIbP8swxRBBt+8VdB9C16Qe4tRbZ4bKd
         m+vlhkJ4zkfRo/hBs1LySRmN2e+/ZtccreQ3qiopqI8oT3J7srs4YKcWca2biWLB3wFe
         y4SZgENb2idSqJ78TqzyzMlf25TvKKP42dgyoYQotNHNb7jLX8w/n+6D+Pt+VPyjr5MU
         uozpVqaelgUgtbzAkBp2zoGu2HLp3aAntBfZqTaMnCmz+uLxqMkFXQC9RxVyKIteObdI
         /GnQ==
X-Gm-Message-State: AOJu0Yzsdbpl5zYzON05CtEsZ7OSrYzHCPgnhfM1RheCTb5lDjpyfwhf
	8f5+sDc6owfgRHzuoRINUyqc/pCz8y5i9HQbWf25k3OLTilUd5bE
X-Google-Smtp-Source: AGHT+IGfRdSWtp+1onxx+iLVymNrzaKRpWBWPTb0pHFWlRNECurwh/KBXdrhvYQIruR2C0q5uxG1Jw==
X-Received: by 2002:a17:906:d542:b0:a7a:8e98:890d with SMTP id a640c23a62f3a-a7dc4e2808emr112728166b.16.1722560975756;
        Thu, 01 Aug 2024 18:09:35 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d42615sm37107766b.99.2024.08.01.18.09.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Aug 2024 18:09:35 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 3/5] memblock test: fix implicit declaration of function 'memparse'
Date: Fri,  2 Aug 2024 01:09:21 +0000
Message-Id: <20240802010923.15577-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240802010923.15577-1-richard.weiyang@gmail.com>
References: <20240802010923.15577-1-richard.weiyang@gmail.com>
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



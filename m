Return-Path: <linux-kernel+bounces-261643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B146D93BA3E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD141F23CED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030CF12E6D;
	Thu, 25 Jul 2024 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ys1PXJFV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4376FBE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721871728; cv=none; b=aCQx7/n25BMpn876uWXz+JQ0lbwACvk6RM4789vWNjB4s5oaU2hyGZM48WjefgRDKmJP6EmnBRdnphFiZFaeGzT1hVGPNEll0aRTX6LMkq7RPHc34Pa8V7+5yTqIxNtN69pvCnfzKzw+wPFVfiItRH6KgJuCF3HpfRr57LPmtRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721871728; c=relaxed/simple;
	bh=iMeWusMrtAQ1H/W2RodtNkN/xA7FODapxucgrBjgznw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LBs2iHqhVwNe//sDtZQfDsAMoC2RHKIDvIXStxHAorc7lUESf1HjhtqIlFK4+D2CLElfhxzpusVxvHQyurfHFVg7OsWM1mLcKmbSQ+Ogo8Ecx4LYGuu2t01Xp3B7jiG+MVgwNt+KmXqIZ89tZxW0q6Gwda/aMh2Wb3q68Jk/rlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ys1PXJFV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a8caef11fso7075766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721871725; x=1722476525; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARX0cQSlFVlhm2JIEi3wscjUVQ/KZdEKGbbJxa4tmRY=;
        b=Ys1PXJFV8QAfZT5KesoTfP5Lus2NMpOzBnqvL1gyjRT+KkrsGAwYTnUVhw9gvc4nSw
         lPgto+BwIAKAZWcHyhzfBTZNkFSH778NrcFCe+QGSdzBdBvy7XnLahenUzDwPA1r7ul5
         dH/CgkPgUrE8raNsDxvg3v5TP+efaFwwBYzAav6BBB+CSyk8T9eClZHElsdbiWEoYw5w
         PvqcqBF23h9vY9/sVBwUw9LxW/X6iLPGZtC4dnsdUjbE9ed4uKu8X/ZdlU6CnlwQdOJv
         JDNqZ97mWgminMNCDROZZgM0z2ZObJHdjFV3ENM5AqBH+zU5+CLmP/XpT5EXYNf28+a1
         pbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721871725; x=1722476525;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARX0cQSlFVlhm2JIEi3wscjUVQ/KZdEKGbbJxa4tmRY=;
        b=lIZ0raDknKjLfwRZUzshPwIpUAUbSBAoH1r7aLxqYdwTN9ggCGGmZV95BdTAZP80n7
         vlVMEY6hz3TW0XyrQOXqjHRwm4AN///WD5qIEEq0i87PlCFRI0iD9qvlEzUxNM2oy2HY
         quT0MsUD8k3XmuWBGfDKLv0ZybfzlPH9d6iBd31uCBhS00sgDMTdtEpl22AvAJhACQgn
         cfXeWPEHwfQj4JLdyRPwVQBbNfCHxXDCkpTA3uZ/WYrix03jP8bv3y5cJJM6sWLNQwvW
         ZNqkBHaaAbwAepn8dgAIgAWNjWlsVVlsn+Sv2ZnPrzIIHFLoQ2SF6jOdhUK2vQXjNpHL
         9p8A==
X-Gm-Message-State: AOJu0Ywrx5Fl5oC0mcSQytybse4y4VjuEnjJZv3L0XfjNmBPBV+qM3Nc
	0AeUUTsraG6WAczngYsQTR2RE2i0LDm6epThGgeWaVQrj5j4Ldcx
X-Google-Smtp-Source: AGHT+IH69WvgxiMD6OMwiWg1G+NoqJLzclvrJI/UH51QjspTKcbBFBgby0YTMR1Hy0MUj/xO2uBgjQ==
X-Received: by 2002:a17:907:9718:b0:a77:e48d:bc8 with SMTP id a640c23a62f3a-a7ac4f0bfcamr93989666b.21.1721871725006;
        Wed, 24 Jul 2024 18:42:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41462sm17069466b.119.2024.07.24.18.42.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2024 18:42:04 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] memblock test: fix implicit declaration of function 'memparse'
Date: Thu, 25 Jul 2024 01:41:55 +0000
Message-Id: <20240725014157.17707-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240725014157.17707-1-richard.weiyang@gmail.com>
References: <20240725014157.17707-1-richard.weiyang@gmail.com>
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
index ca56f36ef296..67c9ea1428a5 100644
--- a/tools/testing/memblock/linux/kernel.h
+++ b/tools/testing/memblock/linux/kernel.h
@@ -8,6 +8,7 @@
 #include <linux/printk.h>
 #include <linux/linkage.h>
 #include <linux/kconfig.h>
+#include <linux/string.h>
 
 #define virt_to_phys(p) ((unsigned long)p)
 
-- 
2.34.1



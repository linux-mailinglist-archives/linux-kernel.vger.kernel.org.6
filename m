Return-Path: <linux-kernel+bounces-264971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A893EABB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 03:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE8A1C211FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 01:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5A17BAE3;
	Mon, 29 Jul 2024 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROZsiYUu"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2530757F2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722217683; cv=none; b=D3zk3sUP85t5Kdgt3ZpZ2O73PYHwM5gJ8kqFxVNTLJppr+E/3rlgYAKFmbZycr99cqp/6t4Kp51l5I8anIz7jVzoZl0y9/qwQar3Qg03wJA9uTF6f9C0/6ZB9FxiulkK/GOlSnqTPPgBXPK7t17wRgNZMLM2vSMFUnph+CQPa/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722217683; c=relaxed/simple;
	bh=g77zQiVriTZdZ2Jk6UEYqWv9smXGMroHgJ9a97y3zgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ByMjWJ9nbt0mc7lI4BDaNSUgWFV9XctnGHh6KGd8nvjL+AeT9zCUsVP40+5qmzL55PzGhQr922DjamXotqC1T45j5fyiDEVVS6PlmK5RTDQ115M9Zs5+jxr6q592qcwEp7c7RticKZkRsmeKWM0VBbV0fEC+G/osBG8YVm+sIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ROZsiYUu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eeb1ba0481so47121161fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 18:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722217680; x=1722822480; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qyYOlz2K4LoDSHsLe8705YksXRaxa+aqBd+KCuRDSeI=;
        b=ROZsiYUuJ79mMZnUc/3ccvcqM7FLG/9kdK/1WyX8FJQSTCLLoQD9fyhNgi/T4i1RpT
         smNJFgqhKR/VIPkMqHXa+murTNFG5suyFj1LQ+hYAvuzG1BYrreX1oCn7zIKu3STkbDK
         MKED4NRwDYWpQuVQKJ3ZPYYdHbpfC9BNpptZuEZmPE+9iP4h1zGplfXqWP3CbEVEUz5F
         06SDDNPq8YMRxquua2F5GA+yMkojQeFcfKldvgALJZJTKx5Sg4tzdWrqSAyhibxvOvEf
         KY7Ti0/SE2/H8NvRzt6KBzS/grKclDAC5G/jc3HPYX97cGs2ofuaoi83R+y/ZRW54znT
         4J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722217680; x=1722822480;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qyYOlz2K4LoDSHsLe8705YksXRaxa+aqBd+KCuRDSeI=;
        b=LYq6BHsCWa8GeS4n9kZ8+BFrm+2JmO9wtB4KD63L70xxu9nqzjtl/ia8jjJCfDm2gc
         VNzL50aZBBETq9zaar72vkQeBO4bcXIarD7Ih4av3IDeHGvxeDarHIgMPwWOR06a7YfY
         sCOqNebGC/u6CiR+QOen4pEuDlqEaZkGHE6ayseqa5CnYBWfXMB1L4trFkNuzVn608zF
         55ypiZVHgcVAHQBpdtCy6HQ6wIA3b/+B5kWV0fZr5BTifOew51VBZEPIl9LnzNRJPw56
         lzeAIRSfYl4dKUHApkRWjqA+T1M2lY89KPwh9Mrk7YqOJCBUh4rFguXpeRMg7+86gRA0
         MJ8A==
X-Gm-Message-State: AOJu0YxVipYdGvz+vwGpU8xP7TVE5/7rM2qb1D0Ze9oe08nMTrP0U0Wf
	plC7MLeZ2zRDQqK4rjti0YQ9wvtfyhTA0BYp/NS2gWKJGMT/nHxe
X-Google-Smtp-Source: AGHT+IE+qlzpCq1UXhhU4cq/cBAQcMXhG/k6viozn73E8gKzNaEC5ly6j9uhxoFrE7HgKYt2maBkxg==
X-Received: by 2002:a2e:8686:0:b0:2ef:2a68:beca with SMTP id 38308e7fff4ca-2f12edd8220mr36122661fa.24.1722217679622;
        Sun, 28 Jul 2024 18:47:59 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac64eb7c0fsm5053001a12.62.2024.07.28.18.47.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Jul 2024 18:47:58 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: rppt@kernel.org,
	richard.weiyang@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 3/5] memblock test: fix implicit declaration of function 'memparse'
Date: Mon, 29 Jul 2024 01:47:23 +0000
Message-Id: <20240729014725.29839-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240729014725.29839-1-richard.weiyang@gmail.com>
References: <20240729014725.29839-1-richard.weiyang@gmail.com>
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



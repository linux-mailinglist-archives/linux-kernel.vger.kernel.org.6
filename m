Return-Path: <linux-kernel+bounces-225578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D291327A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 09:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1982CB233DF
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 07:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58214B97A;
	Sat, 22 Jun 2024 07:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3eOmEXE"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEA914B950
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719040376; cv=none; b=DZQjuxTRxqzJq8YAirKnD/JeCbEmjoyQfhz7l26+HnOph0SY96BqZE8Kj/pkSoacJH5T8us+DG+FSGgTXrfK5y+H9DRdv2a5wcIewllxASvgPs/1/aoPep2VcdOE07NhZvKX/7CzKP17sof+UMrLLnfbGcTpOfXBTe/iKZYENjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719040376; c=relaxed/simple;
	bh=RRMuxeCo2Nrrw0Ob7OnSglRBJa0tTcRIk9e7wXmqw0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9i9CrHFJVNgEobf3TcmkM22r57osh31gQPvnJMPejQKNu/t3y9FyANmhKgs8Ymi1Ivy8jsbwfpRyeawsS+pCQCyvxLtRUmoBB9KbmCRVG2LTtIo88Zx45FE8dCmVpwWZNNJ6JelDyL8INfERLwL53VBvF3tjQASAaMCNrWVMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3eOmEXE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9fb3ca81bso6802925ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 00:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719040374; x=1719645174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8riNiWPXJqBzm2BvXgRSJ73ikaCBhCcjPOKGJpl9B7g=;
        b=A3eOmEXEADn1+YzZX42IOPUrqEg+rY6uQdTjH7mRHb4hkGKs1sWDzN+cW3gdQ2rgZ/
         KooRpF62yEOgHGEfhZZofn4xfPoGMRAj5k2Ixf3C6EsrcYqqrzigyxn4eKrZDD9UVawe
         W5AKx27bvG28c+QAMG4qYDIcR8J2tZPB8yKUxNnxD7PVM6LTtgHwSPPA8fjij+0sq9pe
         Lqla+JbrmYsdMG3MEDj0CorTjTwhNjs8MV+aETdbNBpR90fTYyHbMZAqa3cUTI003TMh
         uVlAjgNs+///k/R9WEdBC/lnX8mzKihytMrbtYHr1eZgDZORbzz0t/Nj6jmmxbzpNRiH
         9w8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719040374; x=1719645174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8riNiWPXJqBzm2BvXgRSJ73ikaCBhCcjPOKGJpl9B7g=;
        b=eyPQ34lnpya1z5af0SGB8M51Mw8HG6xFbSRbg4Fw/XIB/IHrWx5RKDsg0AlUQglRku
         dFT94ggzAvB0asNrmc894Lro9m+kP/n2QtRX1NLkqxlgRfaYcZ+lF26DbP1P6QlYiTZT
         zoAYFZShP7aaPzG+Q4mG5t45RqcT/oRfSnLgJwFGcAzBKjeu579YNCHqxo40y+dAexS9
         POzcKcR3yKaGZSJ0Yt8LPn3Cr9vE9VQjKAWgDJeARBBa9swYEVHmOaCnWfDB+3y+ju8M
         wtXfxRLGaLcJjcJJeBBYdJT7+KhR5+afTddSQBsA1hUk9bz+ERfv8kZbbQ9YeZuNbBb0
         zO0w==
X-Forwarded-Encrypted: i=1; AJvYcCV9zFoJ2AtH7pWgb60y4dHEmpUB+xfndb5tztaspQHxg7ZIfJxoZC37yDCv+2Ohfa4ggyg+Z073gNSEKq1PZMWZaaw9php/xJiE/9Gm
X-Gm-Message-State: AOJu0YyfWB2EflNXVNPltBZY77n/8FxhCgrR9HhUI1ngsObgTRq0I/YN
	ak0/y8jyj19JMN+23XkMx2LSYs67LRd96ZFhObHq6lV1KqXLza4N
X-Google-Smtp-Source: AGHT+IHNJJepHyfC0lV8t456DGXOVM20KUS+z/LohhJkRB6veFSYruBi4ECW7C7qwhTJ2T4k+KcjJA==
X-Received: by 2002:a17:903:22c3:b0:1f9:edf6:d7a5 with SMTP id d9443c01a7336-1f9edf6d941mr45144125ad.1.1719040374237;
        Sat, 22 Jun 2024 00:12:54 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb3f1esm24831895ad.265.2024.06.22.00.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 00:12:53 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	ryan.roberts@arm.com
Cc: david@redhat.com,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	v-songbaohua@oppo.com,
	ying.huang@intel.com
Subject: [PATCH v2 1/1] tools/mm: Introduce a tool to assess swap entry allocation for thp_swapout
Date: Sat, 22 Jun 2024 19:12:31 +1200
Message-Id: <20240622071231.576056-2-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622071231.576056-1-21cnbao@gmail.com>
References: <20240622071231.576056-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

Both Ryan and Chris have been utilizing the small test program to aid
in debugging and identifying issues with swap entry allocation. While
a real or intricate workload might be more suitable for assessing the
correctness and effectiveness of the swap allocation policy, a small
test program presents a simpler means of understanding the problem and
initially verifying the improvements being made.

Let's endeavor to integrate it into tools/mm. Although it presently
only accommodates 64KB and 4KB, I'm optimistic that we can expand
its capabilities to support multiple sizes and simulate more
complex systems in the future as required.

Basically, we have
1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code
under high exercise in a short time.
2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in
freeing memory, as well as for munmap, app exits, or OOM killer scenarios.
This ensures new mTHP is always generated, released or swapped out, similar
to the behavior on a PC or Android phone where many applications are
frequently started and terminated.
3. Swap in with or without the "-a" option to observe how fragments
due to swap-in and the incoming swap-in of large folios will impact
swap-out fallback.

Due to 2, we ensure a certain proportion of mTHP. Similarly, because
of 3, we maintain a certain proportion of small folios, as we don't
support large folios swap-in, meaning any swap-in will immediately
result in small folios. Therefore, with both 2 and 3, we automatically
achieve a system containing both mTHP and small folios. Additionally,
1 provides the ability to continuously swap them out.

We can also use "-s" to add a dedicated small folios memory area.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 tools/mm/Makefile                  |   2 +-
 tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
 2 files changed, 234 insertions(+), 1 deletion(-)
 create mode 100644 tools/mm/thp_swap_allocator_test.c

diff --git a/tools/mm/Makefile b/tools/mm/Makefile
index 7bb03606b9ea..15791c1c5b28 100644
--- a/tools/mm/Makefile
+++ b/tools/mm/Makefile
@@ -3,7 +3,7 @@
 #
 include ../scripts/Makefile.include
 
-BUILD_TARGETS=page-types slabinfo page_owner_sort
+BUILD_TARGETS=page-types slabinfo page_owner_sort thp_swap_allocator_test
 INSTALL_TARGETS = $(BUILD_TARGETS) thpmaps
 
 LIB_DIR = ../lib/api
diff --git a/tools/mm/thp_swap_allocator_test.c b/tools/mm/thp_swap_allocator_test.c
new file mode 100644
index 000000000000..a363bdde55f0
--- /dev/null
+++ b/tools/mm/thp_swap_allocator_test.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * thp_swap_allocator_test
+ *
+ * The purpose of this test program is helping check if THP swpout
+ * can correctly get swap slots to swap out as a whole instead of
+ * being split. It randomly releases swap entries through madvise
+ * DONTNEED and swapin/out on two memory areas: a memory area for
+ * 64KB THP and the other area for small folios. The second memory
+ * can be enabled by "-s".
+ * Before running the program, we need to setup a zRAM or similar
+ * swap device by:
+ *  echo lzo > /sys/block/zram0/comp_algorithm
+ *  echo 64M > /sys/block/zram0/disksize
+ *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
+ *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
+ *  mkswap /dev/zram0
+ *  swapon /dev/zram0
+ * The expected result should be 0% anon swpout fallback ratio w/ or
+ * w/o "-s".
+ *
+ * Author(s): Barry Song <v-songbaohua@oppo.com>
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <time.h>
+
+#define MEMSIZE_MTHP (60 * 1024 * 1024)
+#define MEMSIZE_SMALLFOLIO (4 * 1024 * 1024)
+#define ALIGNMENT_MTHP (64 * 1024)
+#define ALIGNMENT_SMALLFOLIO (4 * 1024)
+#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
+#define TOTAL_DONTNEED_SMALLFOLIO (1 * 1024 * 1024)
+#define MTHP_FOLIO_SIZE (64 * 1024)
+
+#define SWPOUT_PATH \
+	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
+#define SWPOUT_FALLBACK_PATH \
+	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback"
+
+static void *aligned_alloc_mem(size_t size, size_t alignment)
+{
+	void *mem = NULL;
+
+	if (posix_memalign(&mem, alignment, size) != 0) {
+		perror("posix_memalign");
+		return NULL;
+	}
+	return mem;
+}
+
+/*
+ * This emulates the behavior of native libc and Java heap,
+ * as well as process exit and munmap. It helps generate mTHP
+ * and ensures that iterations can proceed with mTHP, as we
+ * currently don't support large folios swap-in.
+ */
+static void random_madvise_dontneed(void *mem, size_t mem_size,
+		size_t align_size, size_t total_dontneed_size)
+{
+	size_t num_pages = total_dontneed_size / align_size;
+	size_t i;
+	size_t offset;
+	void *addr;
+
+	for (i = 0; i < num_pages; ++i) {
+		offset = (rand() % (mem_size / align_size)) * align_size;
+		addr = (char *)mem + offset;
+		if (madvise(addr, align_size, MADV_DONTNEED) != 0)
+			perror("madvise dontneed");
+
+		memset(addr, 0x11, align_size);
+	}
+}
+
+static void random_swapin(void *mem, size_t mem_size,
+		size_t align_size, size_t total_swapin_size)
+{
+	size_t num_pages = total_swapin_size / align_size;
+	size_t i;
+	size_t offset;
+	void *addr;
+
+	for (i = 0; i < num_pages; ++i) {
+		offset = (rand() % (mem_size / align_size)) * align_size;
+		addr = (char *)mem + offset;
+		memset(addr, 0x11, align_size);
+	}
+}
+
+static unsigned long read_stat(const char *path)
+{
+	FILE *file;
+	unsigned long value;
+
+	file = fopen(path, "r");
+	if (!file) {
+		perror("fopen");
+		return 0;
+	}
+
+	if (fscanf(file, "%lu", &value) != 1) {
+		perror("fscanf");
+		fclose(file);
+		return 0;
+	}
+
+	fclose(file);
+	return value;
+}
+
+int main(int argc, char *argv[])
+{
+	int use_small_folio = 0, aligned_swapin = 0;
+	void *mem1 = NULL, *mem2 = NULL;
+	int i;
+
+	for (i = 1; i < argc; ++i) {
+		if (strcmp(argv[i], "-s") == 0)
+			use_small_folio = 1;
+		else if (strcmp(argv[i], "-a") == 0)
+			aligned_swapin = 1;
+	}
+
+	mem1 = aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
+	if (mem1 == NULL) {
+		fprintf(stderr, "Failed to allocate large folios memory\n");
+		return EXIT_FAILURE;
+	}
+
+	if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) != 0) {
+		perror("madvise hugepage for mem1");
+		free(mem1);
+		return EXIT_FAILURE;
+	}
+
+	if (use_small_folio) {
+		mem2 = aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
+		if (mem2 == NULL) {
+			fprintf(stderr, "Failed to allocate small folios memory\n");
+			free(mem1);
+			return EXIT_FAILURE;
+		}
+
+		if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) != 0) {
+			perror("madvise nohugepage for mem2");
+			free(mem1);
+			free(mem2);
+			return EXIT_FAILURE;
+		}
+	}
+
+	/* warm-up phase to occupy the swapfile */
+	memset(mem1, 0x11, MEMSIZE_MTHP);
+	madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT);
+	if (use_small_folio) {
+		memset(mem2, 0x11, MEMSIZE_SMALLFOLIO);
+		madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT);
+	}
+
+	/* iterations with newly created mTHP, swap-in, and swap-out */
+	for (i = 0; i < 100; ++i) {
+		unsigned long initial_swpout;
+		unsigned long initial_swpout_fallback;
+		unsigned long final_swpout;
+		unsigned long final_swpout_fallback;
+		unsigned long swpout_inc;
+		unsigned long swpout_fallback_inc;
+		double fallback_percentage;
+
+		initial_swpout = read_stat(SWPOUT_PATH);
+		initial_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
+
+		/*
+		 * The following setup creates a 1:1 ratio of mTHP to small folios
+		 * since large folio swap-in isn't supported yet. Once we support
+		 * mTHP swap-in, we'll likely need to reduce MEMSIZE_MTHP and
+		 * increase MEMSIZE_SMALLFOLIO to maintain the ratio.
+		 */
+		random_swapin(mem1, MEMSIZE_MTHP,
+				aligned_swapin ? ALIGNMENT_MTHP : ALIGNMENT_SMALLFOLIO,
+				TOTAL_DONTNEED_MTHP);
+		random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
+				TOTAL_DONTNEED_MTHP);
+
+		if (use_small_folio) {
+			random_swapin(mem2, MEMSIZE_SMALLFOLIO,
+					ALIGNMENT_SMALLFOLIO,
+					TOTAL_DONTNEED_SMALLFOLIO);
+		}
+
+		if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) != 0) {
+			perror("madvise pageout for mem1");
+			free(mem1);
+			if (mem2 != NULL)
+				free(mem2);
+			return EXIT_FAILURE;
+		}
+
+		if (use_small_folio) {
+			if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) != 0) {
+				perror("madvise pageout for mem2");
+				free(mem1);
+				free(mem2);
+				return EXIT_FAILURE;
+			}
+		}
+
+		final_swpout = read_stat(SWPOUT_PATH);
+		final_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
+
+		swpout_inc = final_swpout - initial_swpout;
+		swpout_fallback_inc = final_swpout_fallback - initial_swpout_fallback;
+
+		fallback_percentage = (double)swpout_fallback_inc /
+			(swpout_fallback_inc + swpout_inc) * 100;
+
+		printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu, Fallback percentage: %.2f%%\n",
+				i + 1, swpout_inc, swpout_fallback_inc, fallback_percentage);
+	}
+
+	free(mem1);
+	if (mem2 != NULL)
+		free(mem2);
+
+	return EXIT_SUCCESS;
+}
-- 
2.34.1



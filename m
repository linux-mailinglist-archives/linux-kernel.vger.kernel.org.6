Return-Path: <linux-kernel+bounces-371511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DBB9A3C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79511C21026
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5789E202F71;
	Fri, 18 Oct 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDp7zqhK"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA52022F9;
	Fri, 18 Oct 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248641; cv=none; b=hjzOMRCO/sTdD1xgxA+PeVfrqDBjrR8Z8nceNksaijq0h2aCJqfFyQfsRStQdtLbw8wECVAYALuvj7X7IJPG+u4ztYUY+WFrQsX7fyOO4ThNLnkV6JoW9Den+qGK5in8qWYXBwkHFX/cnliMaGHtGDXoUZRzeHbUXfxcbcWXR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248641; c=relaxed/simple;
	bh=HI79Pkt7n2LlJw3bJJcop8gJ0T5QnqUto0lUkIYJO6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9L0YFt9VLRf1JpuAKShdAbqHtcVRhnolrHshxhjI8wXZlynbR26SRDo4iib0odEi+nS3FE7L4p4/PZBSOrfL1rqq/ddC2L4hbzrTPUwIzp7aa7kkTIZwSsbWmISD1ZGaorffzH6NiOTFJrPfPkWWgpUIQ5X9weYiES54+2GBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDp7zqhK; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-84fb56d2fb2so601497241.3;
        Fri, 18 Oct 2024 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248639; x=1729853439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=um8CJgoH8YP7qg2KspbA5c0NLRN95mVz+O4+Mbauz+0=;
        b=RDp7zqhKhp7o4Py3oqnUS96r5gMmEr2zOiEnSIM40QHcKtoe+uRJm2ykl0VAsIiVLW
         qI8uO8GNCwUk3iW+Umx7kTm0CCbI9khOwdFo5ToctXYfgpJmXsxTNeLF3S0nOJvyQi+L
         poDijbB3xV6qjSWR7KQPx/eKs6eCIhqVaQFPrg9a3lGrkwT3KO+YnnegKZDzvrcxfQG0
         Qv7HtOdzDLlBvn9KaC29M7PlzaDQ1aUt5pw6GpcuUvC4gMvHDaLVifN3lwigmRw5eidN
         nAT5P9rWPfutfSuPHgXJplRgsy/2Y1uPmWb5M2fmueArJtbwEDC46Sh18BIlY0HeuXX/
         5EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248639; x=1729853439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=um8CJgoH8YP7qg2KspbA5c0NLRN95mVz+O4+Mbauz+0=;
        b=fwUomVpMqNh4VXIgRMlZVzZD0IZUAoZnfLRr4BcYyIredGE4pvMQ+l4Kaxk13AHbSX
         WIlSGGSW8+fffVo6XkIG4EH6WvCkWTcH3Bfa2BsBN2mNrxQlC+ZCK4//ocV5f5VFgxKJ
         D51VK420g3aO9Bt7dd+TovM+oZPZ1MRgm44NdiMr71gaybzeA17P3YbBKLv3suNe7Shx
         er81lv+S3aYfNIdNMXikYvOT3JfK3oc/G+qH84FGofgubEvK62CSkZ9H6evMpWZaK0uG
         /AuMYf58MxHCfHOZyB9e45BiZnGAngTp2g3gXTnjn+0PRLcSbSPx+SuqwvBXAxbKc/x0
         Idvg==
X-Forwarded-Encrypted: i=1; AJvYcCWcH04ZhJ0Y+6b2/hoVmsKfBwKxdo2sUfg8cBE9DUrIxN6JKyMFZaxQLKEc1Rs9xwxx0NNT/SjQT6M=@vger.kernel.org, AJvYcCXPp0YujBMV7OqpsntCIh+h80t3J7aZ60XUzexjesD8ANs7/0Y1AzULCWNqzRzgrZ3yIWoL2D9KCuvlMKC2@vger.kernel.org
X-Gm-Message-State: AOJu0YwC3Xex7YVCzCtTsoFJfFa5L5P8l1DSSXzPHPv3so5WM2h3HiHq
	Mwrrt+s+p8E9EBoXTl/gaE1SIHC/Du2UT2GbT0XAJRDouywngnm+tIgKZlc0
X-Google-Smtp-Source: AGHT+IH8Mn5he2yfHltuZbtxUYmes0GQVaKU8iMC8ELro74qZ/ahKHro38OTgzSJU4H0qaepttvaZA==
X-Received: by 2002:a05:6102:1608:b0:4a4:97bc:c0d7 with SMTP id ada2fe7eead31-4a5d6ae16a3mr1399174137.8.1729248638707;
        Fri, 18 Oct 2024 03:50:38 -0700 (PDT)
Received: from localhost (fwdproxy-ash-003.fbsv.net. [2a03:2880:20ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156fa5618sm58452385a.65.2024.10.18.03.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:50:38 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	david@redhat.com,
	willy@infradead.org,
	kanchana.p.sridhar@intel.com,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Usama Arif <usamaarif642@gmail.com>
Subject: [RFC 0/4] mm: zswap: add support for zswapin of large folios
Date: Fri, 18 Oct 2024 11:48:38 +0100
Message-ID: <20241018105026.2521366-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After large folio zswapout support added in [1], this patch adds
support for zswapin of large folios to bring it on par with zram.
This series makes sure that the benefits of large folios (fewer
page faults, batched PTE and rmap manipulation, reduced lru list,
TLB coalescing (for arm64 and amd)) are not lost at swap out when
using zswap.

It builds on top of [2] which added large folio swapin support for
zram and provides the same level of large folio swapin support as
zram, i.e. only supporting swap count == 1.

Patch 1 skips swapcache for swapping in zswap pages, this should improve
no readahead swapin performance [3], and also allows us to build on large
folio swapin support added in [2], hence is a prerequisite for patch 3.

Patch 3 adds support for large folio zswapin. This patch does not add
support for hybrid backends (i.e. folios partly present swap and zswap).

The main performance benefit comes from maintaining large folios *after*
swapin, large folio performance improvements have been mentioned in previous
series posted on it [2],[4], so have not added those. Below is a simple
microbenchmark to measure the time needed *for* zswpin of 1G memory (along
with memory integrity check).

                                |  no mTHP (ms) | 1M mTHP enabled (ms)
Base kernel                     |   1165        |    1163
Kernel with mTHP zswpin series  |   1203        |     738

The time measured was pretty consistent between runs (~1-2% variation).
There is 36% improvement in zswapin time with 1M folios. The percentage
improvement is likely to be more if the memcmp is removed.

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index 40de679248b8..77068c577c86 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -9,6 +9,8 @@
 #include <string.h>
 #include <sys/wait.h>
 #include <sys/mman.h>
+#include <sys/time.h>
+#include <malloc.h>
 
 #include "../kselftest.h"
 #include "cgroup_util.h"
@@ -407,6 +409,74 @@ static int test_zswap_writeback_disabled(const char *root)
        return test_zswap_writeback(root, false);
 }
 
+static int zswapin_perf(const char *cgroup, void *arg)
+{
+       long pagesize = sysconf(_SC_PAGESIZE);
+       size_t memsize = MB(1*1024);
+       char buf[pagesize];
+       int ret = -1;
+       char *mem;
+       struct timeval start, end;
+
+       mem = (char *)memalign(2*1024*1024, memsize);
+       if (!mem)
+               return ret;
+
+       /*
+        * Fill half of each page with increasing data, and keep other
+        * half empty, this will result in data that is still compressible
+        * and ends up in zswap, with material zswap usage.
+        */
+       for (int i = 0; i < pagesize; i++)
+               buf[i] = i < pagesize/2 ? (char) i : 0;
+
+       for (int i = 0; i < memsize; i += pagesize)
+               memcpy(&mem[i], buf, pagesize);
+
+       /* Try and reclaim allocated memory */
+       if (cg_write_numeric(cgroup, "memory.reclaim", memsize)) {
+               ksft_print_msg("Failed to reclaim all of the requested memory\n");
+               goto out;
+       }
+
+       gettimeofday(&start, NULL);
+       /* zswpin */
+       for (int i = 0; i < memsize; i += pagesize) {
+               if (memcmp(&mem[i], buf, pagesize)) {
+                       ksft_print_msg("invalid memory\n");
+                       goto out;
+               }
+       }
+       gettimeofday(&end, NULL);
+       printf ("zswapin took %fms to run.\n", (end.tv_sec - start.tv_sec)*1000 + (double)(end.tv_usec - start.tv_usec) / 1000);
+       ret = 0;
+out:
+       free(mem);
+       return ret;
+}
+
+static int test_zswapin_perf(const char *root)
+{
+       int ret = KSFT_FAIL;
+       char *test_group;
+
+       test_group = cg_name(root, "zswapin_perf_test");
+       if (!test_group)
+               goto out;
+       if (cg_create(test_group))
+               goto out;
+
+       if (cg_run(test_group, zswapin_perf, NULL))
+               goto out;
+
+       ret = KSFT_PASS;
+out:
+       cg_destroy(test_group);
+       free(test_group);
+       return ret;
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -584,6 +654,7 @@ struct zswap_test {
        T(test_zswapin),
        T(test_zswap_writeback_enabled),
        T(test_zswap_writeback_disabled),
+       T(test_zswapin_perf),
        T(test_no_kmem_bypass),
        T(test_no_invasive_cgroup_shrink),
 };

[1] https://lore.kernel.org/all/20241001053222.6944-1-kanchana.p.sridhar@intel.com/
[2] https://lore.kernel.org/all/20240821074541.516249-1-hanchuanhua@oppo.com/
[3] https://lore.kernel.org/all/1505886205-9671-5-git-send-email-minchan@kernel.org/T/#u
[4] https://lwn.net/Articles/955575/

Usama Arif (4):
  mm/zswap: skip swapcache for swapping in zswap pages
  mm/zswap: modify zswap_decompress to accept page instead of folio
  mm/zswap: add support for large folio zswapin
  mm/zswap: count successful large folio zswap loads

 Documentation/admin-guide/mm/transhuge.rst |   3 +
 include/linux/huge_mm.h                    |   1 +
 include/linux/zswap.h                      |   6 ++
 mm/huge_memory.c                           |   3 +
 mm/memory.c                                |  16 +--
 mm/page_io.c                               |   2 +-
 mm/zswap.c                                 | 120 ++++++++++++++-------
 7 files changed, 99 insertions(+), 52 deletions(-)

-- 
2.43.5



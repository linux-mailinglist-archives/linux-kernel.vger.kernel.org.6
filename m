Return-Path: <linux-kernel+bounces-173603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D388C02BF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C9A01F23F9D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 752D110A0B;
	Wed,  8 May 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jhd738Ox"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27358828
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188447; cv=none; b=pJ8XpE/DowX/Cu+/+WqxSi1nQkPYum60f45qLCDnLG1I091rkXqb1LUtD4/oBBswFEDsucaiU+gG2G2DWI/j9bqASBPHKoQ7mhmxE8quHOuK25wyuILHX7XK4jVT5Q8jiR1QyMqLp7Mm77QAT2YHONcEfbm3tjUZ0XmMTA+unaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188447; c=relaxed/simple;
	bh=vTQJRpkuuB+vPBhCazUEZTJLEfawD1MKDAqmMgFURTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dz1blrZ1tYAT3sdF1orgMja54nRs2wHBDl1x2BvCtMB9Z26F7DKY1xEvdDMXBIL9dhtbaWUAFk2OkP3Q3PNkOGifj+onvPGnOE9uMGd7RdQYC1DTA/qW8+cIDqGoR9LY1/GeyH7N7uoSrsR+I3y5yDCtXvXzIgGg1MZTRjdAcdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jhd738Ox; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9881d07fdso9914b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 10:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715188445; x=1715793245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w6EQnYXqwhIh5NpITcONCWmNDrHXysWnVbFLQfKBz5k=;
        b=Jhd738Ox1fHmALatgJSvcvr60UFVzML5Iy5SLe1BP4l7UA6SxFgEOeGDIGZDqw09BK
         3jCixjXjIybSAs15d1y184B+BgkxAANHafjzfsK8IJoX1v8AawbfSUZ2D5Kgpt4L/obM
         WpH86lWhlcdJGaefLlTjJz1foowPgBiux2cYqLJ4vZWNrLJKx/UBIN9BSgyX/wJPNY/Z
         GUHk0QdEJxLpsln6dWcUqGjRxFPHUpREEQK/Y20XIiEACIvZ/Y4bd/SBfDRe51WugqCp
         F67qCsQSYj5wfKa1D3SckZowP1i5uGakVW1BPtBmMV/yxqc9JMn7plY2JuapyGynZhp4
         SyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715188445; x=1715793245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6EQnYXqwhIh5NpITcONCWmNDrHXysWnVbFLQfKBz5k=;
        b=EznKXaOtXqdhnHvI/Xze0fiEzKtIK1O4QfAEO1ydYvueLa4iZwGIfkLOuBgTg+b0+e
         jVYK3lfa/ar3wpiK9GnmcaceoWCAPhLQSBeWjd21lKZOH0Q/N61Tt0baOV+NttJIj/pb
         eFsyQSA4ZgbruG9ZoWpNy03E/gp6+SC8jYK6lpAqXRTrDXgTvoPET/Iu5PJWA4BDTRoT
         BryiuPcYHYiPi/Jq2RroArXoL/w1qFck8kVgjZsLX2gOXI6pnVkex+iXznvhdGpVN2FZ
         kBmObuTjFOpXn4kVVeppyE4BajHXs+c63FS3tnYt0YcmP7KdrKv29X84m/tQvfZv35wx
         srtw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/CVRwjAcspf+XuPPV2gfTFjqUtQzcm8eFoSZeBpuuOl+ImUGfQ2+0kukgu9D8R3puiGaY5ao0IMLUu2GY0ir9c1HLNSmCyqmqEXh
X-Gm-Message-State: AOJu0Yzl7GZ7Fz+d9hldOB2GC9gcc/35NJiztfGi5pTJyjDHYjvS+eDP
	Ktt+JyDaNto4baz01m3B/zRYP/QJcr2wZczF5XKJ6cLVCuxB3WoS
X-Google-Smtp-Source: AGHT+IGJ6iC8d+ot25WgM9yxm37AYM8B7GTiDRdw+zaeYv1Gq6+4s1t3/CYLeeHdIK6PJV9mZRc82Q==
X-Received: by 2002:aca:1317:0:b0:3c9:714d:cc7b with SMTP id 5614622812f47-3c9852acfbbmr3272118b6e.9.1715188443237;
        Wed, 08 May 2024 10:14:03 -0700 (PDT)
Received: from localhost (fwdproxy-nao-000.fbsv.net. [2a03:2880:23ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id k9-20020a056214102900b006a0e6ffd710sm5761102qvr.97.2024.05.08.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 10:14:02 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5] selftests: cgroup: add tests to verify the zswap writeback path
Date: Wed,  8 May 2024 18:13:59 +0100
Message-ID: <20240508171359.1545744-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempt writeback with the below steps and check using
memory.stat.zswpwb if zswap writeback occurred:
1. Allocate memory.
2. Reclaim memory equal to the amount that was allocated in step 1.
   This will move it into zswap.
3. Save current zswap usage.
4. Move the memory allocated in step 1 back in from zswap.
5. Set zswap.max to half the amount that was recorded in step 3.
6. Attempt to reclaim memory equal to the amount that was allocated,
   this will either trigger writeback if it's enabled, or reclamation
   will fail if writeback is disabled as there isn't enough zswap
   space.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: Yosry Ahmed <yosryahmed@google.com>
---

v4 -> v5 (Yosry Ahmed):
- Use cg_write_numeric instead of cg_write for memory.reclaim missed in
  v4

v3 -> v4 (Yosry Ahmed):
- Use a fixed page-sized buffer for filling and checking memory when
  attempting writeback
- Use cg_write_numeric instead of cg_write for memory.reclaim
- Improved error checking for zswpwb_before and zswpwb_after

v2 -> v3:
- Remove memory.max (Yosry Ahmed)
- change from random allocation of memory to increasing and 0 allocation
  (Yosry Ahmed)
- stricter error checking when writeback is disabled (Yosry Ahmed)
- Ensure zswpwb_before == 0 (Yosry Ahmed)
- Variable definition reorder, function name change (Yosry Ahmed)

v1 -> v2:
- Change method of causing writeback from limit zswap to memory reclaim.
  (Further described in commit message) (Yosry Ahmed)
- Document why using random memory (Nhat Pham)
---
 tools/testing/selftests/cgroup/test_zswap.c | 130 +++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index f0e488ed90d8..67186b7fa31d 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -50,7 +50,7 @@ static int get_zswap_stored_pages(size_t *value)
 	return read_int("/sys/kernel/debug/zswap/stored_pages", value);
 }
 
-static int get_cg_wb_count(const char *cg)
+static long get_cg_wb_count(const char *cg)
 {
 	return cg_read_key_long(cg, "memory.stat", "zswpwb");
 }
@@ -248,6 +248,132 @@ static int test_zswapin(const char *root)
 	return ret;
 }
 
+/*
+ * Attempt writeback with the following steps:
+ * 1. Allocate memory.
+ * 2. Reclaim memory equal to the amount that was allocated in step 1.
+      This will move it into zswap.
+ * 3. Save current zswap usage.
+ * 4. Move the memory allocated in step 1 back in from zswap.
+ * 5. Set zswap.max to half the amount that was recorded in step 3.
+ * 6. Attempt to reclaim memory equal to the amount that was allocated,
+      this will either trigger writeback if it's enabled, or reclamation
+      will fail if writeback is disabled as there isn't enough zswap space.
+ */
+static int attempt_writeback(const char *cgroup, void *arg)
+{
+	long pagesize = sysconf(_SC_PAGESIZE);
+	char *test_group = arg;
+	size_t memsize = MB(4);
+	char buf[pagesize];
+	long zswap_usage;
+	bool wb_enabled;
+	int ret = -1;
+	char *mem;
+
+	wb_enabled = cg_read_long(test_group, "memory.zswap.writeback");
+	mem = (char *)malloc(memsize);
+	if (!mem)
+		return ret;
+
+	/*
+	 * Fill half of each page with increasing data, and keep other
+	 * half empty, this will result in data that is still compressible
+	 * and ends up in zswap, with material zswap usage.
+	 */
+	for (int i = 0; i < pagesize; i++)
+		buf[i] = i < pagesize/2 ? (char) i : 0;
+
+	for (int i = 0; i < memsize; i += pagesize)
+		memcpy(&mem[i], buf, pagesize);
+
+	/* Try and reclaim allocated memory */
+	if (cg_write_numeric(test_group, "memory.reclaim", memsize)) {
+		ksft_print_msg("Failed to reclaim all of the requested memory\n");
+		goto out;
+	}
+
+	zswap_usage = cg_read_long(test_group, "memory.zswap.current");
+
+	/* zswpin */
+	for (int i = 0; i < memsize; i += pagesize) {
+		if (memcmp(&mem[i], buf, pagesize)) {
+			ksft_print_msg("invalid memory\n");
+			goto out;
+		}
+	}
+
+	if (cg_write_numeric(test_group, "memory.zswap.max", zswap_usage/2))
+		goto out;
+
+	/*
+	 * If writeback is enabled, trying to reclaim memory now will trigger a
+	 * writeback as zswap.max is half of what was needed when reclaim ran the first time.
+	 * If writeback is disabled, memory reclaim will fail as zswap is limited and
+	 * it can't writeback to swap.
+	 */
+	ret = cg_write_numeric(test_group, "memory.reclaim", memsize);
+	if (!wb_enabled)
+		ret = (ret == -EAGAIN) ? 0 : -1;
+
+out:
+	free(mem);
+	return ret;
+}
+
+/* Test to verify the zswap writeback path */
+static int test_zswap_writeback(const char *root, bool wb)
+{
+	long zswpwb_before, zswpwb_after;
+	int ret = KSFT_FAIL;
+	char *test_group;
+
+	test_group = cg_name(root, "zswap_writeback_test");
+	if (!test_group)
+		goto out;
+	if (cg_create(test_group))
+		goto out;
+	if (cg_write(test_group, "memory.zswap.writeback", wb ? "1" : "0"))
+		goto out;
+
+	zswpwb_before = get_cg_wb_count(test_group);
+	if (zswpwb_before != 0) {
+		ksft_print_msg("zswpwb_before = %ld instead of 0\n", zswpwb_before);
+		goto out;
+	}
+
+	if (cg_run(test_group, attempt_writeback, (void *) test_group))
+		goto out;
+
+	/* Verify that zswap writeback occurred only if writeback was enabled */
+	zswpwb_after = get_cg_wb_count(test_group);
+	if (zswpwb_after < 0)
+		goto out;
+
+	if (wb != !!zswpwb_after) {
+		ksft_print_msg("zswpwb_after is %ld while wb is %s",
+				zswpwb_after, wb ? "enabled" : "disabled");
+		goto out;
+	}
+
+	ret = KSFT_PASS;
+
+out:
+	cg_destroy(test_group);
+	free(test_group);
+	return ret;
+}
+
+static int test_zswap_writeback_enabled(const char *root)
+{
+	return test_zswap_writeback(root, true);
+}
+
+static int test_zswap_writeback_disabled(const char *root)
+{
+	return test_zswap_writeback(root, false);
+}
+
 /*
  * When trying to store a memcg page in zswap, if the memcg hits its memory
  * limit in zswap, writeback should affect only the zswapped pages of that
@@ -425,6 +551,8 @@ struct zswap_test {
 	T(test_zswap_usage),
 	T(test_swapin_nozswap),
 	T(test_zswapin),
+	T(test_zswap_writeback_enabled),
+	T(test_zswap_writeback_disabled),
 	T(test_no_kmem_bypass),
 	T(test_no_invasive_cgroup_shrink),
 };
-- 
2.43.0



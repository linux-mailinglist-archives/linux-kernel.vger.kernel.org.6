Return-Path: <linux-kernel+bounces-173053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12728BFAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D751C1C23484
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31097C089;
	Wed,  8 May 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mr6Jgegx"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC7F22089
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163748; cv=none; b=aERHNdUzl+5jMrH7fqutl8H14WFyElB1oxFzkRS4sEA3HmmgIC85Db3ZapyTzwDi4jgPgxR22dQNwdyHwo9rcGjvVhTe1UaqaYLFvGST1MDCv/x5DnXBcK9dlJ/XWHOsCaqCAut5sH0USa+hRslWZp9vGvnedKNzs7SIZSil4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163748; c=relaxed/simple;
	bh=/UtBKVagn09C8ikyQ9ntU0VmjwrurBLLCv0wGxhk/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjQvXW1i1bQAsWkVT7K71V8Qz8vj3eXUDH8Zep7/QjHuuinlfuYNlzY8I+5pcPcRNjLa4cjtuKnhnjiSqMBC1KVvuVJkzSLbAMV3yMrjpMxU5aC1y2AdV37fzszaG0N7r9qAhQvoyBF95y3n1rQACPejRGyTRwS3RufqMIADWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mr6Jgegx; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43d3a33d41dso24262571cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715163745; x=1715768545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJzunWduLEJtl9HZRHR2liXCrjLe8ar6vqfD6L7Tfl8=;
        b=Mr6JgegxeYsuVenfGznVyqnivjNFqup57FMD/XQ0TMCUHEtrIngv2KPrcB/QZd356m
         lNkmJSfN7+Vg8/Avvxt7zQ9mWFCzMJ+R7raFOzTPCXTsJOZhrUy1IJIbJraChZsxVZZD
         d1V/rbMy2i8mT3mtiwJ7CV/czkDYFo+pEZGHhOSR1KLNBssWAGjj/lU7JGdg0fC6/yfm
         eI8E4qCpCdWYl9Co4w+/vGf1db0frF2/bD9mY57hCvilDH8vxN6MuZHIZV/WhlZhgXtI
         iwKnMbEe0D5bHo+fyEfMaBiJIKeeTinqXPGNGN2zI7lV17Bu3p6Cl1v8x7/mbVKfMner
         XxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715163745; x=1715768545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJzunWduLEJtl9HZRHR2liXCrjLe8ar6vqfD6L7Tfl8=;
        b=rQH87zl56XItQ0eui5tqCe5RBJhc0dYZ5eizocGdrCLLgdvU3U0QcMtm2Eyr05YWQX
         vnhkPZhXiKRubn90bcgf24KuD3HnRZIBdtmQQKtuspwcWruJGRGgb6jNpR5zGW1jh0HK
         708wIcy+Y0UyUt9icLrzudW2dXryfe6MimP5VwLS21w8keiCvYs/+VKwG+PPabmkGxXp
         XnhsLgUzpBNN+Wg3F4Fba652BO9RHps8Dg3wdhXVOg/51LaTXx0dLxvpKFSTeLCr3fIb
         esKfj6iMuaXSkynLu8cZt3AfYOBKaDl24UHK20ac4sXUm4X3PNAUcm1ZDuZiKROoskVE
         ksvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiQI4N05WZHvnpp5wPJB7OfVwcnu/Z7oSFPmiv75+SWg/7XtTrlZ4Nd7veIjFx8g7kx5LhRJI7NqPBiMzT2rTS4qxLIVUUXEbHxB4y
X-Gm-Message-State: AOJu0Yyeh7LJ4U1r+D0+hi3N7QmWBAHlaExmelYhDqLDZCSTWF1tWxHe
	bsJdTeRsdWrCP4pdELWRT2MMkXm2XnCYl9/iU7k3M++8r4YRj9Lv
X-Google-Smtp-Source: AGHT+IEIv91wQviqGRD7/ak0MDKHYkmzCd0dmCixa1tczIRoZlLSBS4O3x9AwtF9MKJuzOCUiNAmNQ==
X-Received: by 2002:a05:622a:1315:b0:43a:f007:a476 with SMTP id d75a77b69052e-43dbf2c3f1cmr21187411cf.2.1715163745209;
        Wed, 08 May 2024 03:22:25 -0700 (PDT)
Received: from localhost (fwdproxy-nao-009.fbsv.net. [2a03:2880:23ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id ex8-20020a05622a518800b0043a51b452a3sm7476483qtb.20.2024.05.08.03.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 03:22:24 -0700 (PDT)
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
Subject: [PATCH v4] selftests: cgroup: add tests to verify the zswap writeback path
Date: Wed,  8 May 2024 11:22:22 +0100
Message-ID: <20240508102222.4001882-1-usamaarif642@gmail.com>
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
---

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
index f0e488ed90d8..beab9b979957 100644
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
+	ret = cg_write(test_group, "memory.reclaim", "4M");
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



Return-Path: <linux-kernel+bounces-171074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B0C8BDF81
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBEB284324
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1C514EC51;
	Tue,  7 May 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhzZsYhJ"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1414E2DA
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076889; cv=none; b=n1/QlILi0ZqnP0OfWDcrI+i1Nn6y1V3oDdmuaj3ZS2wpEe6en+HQOUDUTOQgknSXbfCUeG14ps1CiWyUNTbxUwFMKEAepn3qqYPImR2znT29o716OJ/t9rA2uJjxWmY9aYPcOgA10Q55ruat3qTtn1aJrxghuM/wBjTZKGwlgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076889; c=relaxed/simple;
	bh=IrSdvnwUH841qGcOPvjcudeaP4ufwBfH9fwJ05SYV8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gfuw0nVlUu8FSTUxjh/+Zm8PIsQ+Z25qC/yFB1eA5Dy4D2+yNI1VqOJN+IfbQbTaDpzOt2dQE2n5y2dHzFX4ndALqBVILg+3BAN4e+V3wbTQyQ9SfuOk02aYxGuBSTR8uDG+xV+npxFpCgUYkzTo1YSMLdgMJIjPOG/uCejqqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhzZsYhJ; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7928ec5308cso272447185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715076887; x=1715681687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmNF1Voon22sEbCDSc1Fl59X5+YrmSQN7fGFAIA4IKw=;
        b=IhzZsYhJ/L/rpt9RbwN2y70u37b426bStNxqpRGXaXn7hAkQ75AU/npg/PQLzpNRL3
         0wTLF2s+Je9tQP4jV2iIL4hSaif0kuJsMwaIdoqrGGgDvL46yDiMDhE4B4bp4VWWDjS+
         q+tAVcI56EL5rbAkbVuRfl1TVRRKqQjwsa1IqEJl2EIv9Tt4w2ipO6tX6EVKN7ulOiJP
         Oujp57B+XhFXvAJns+/LYyXoS3XFIwJT5Iohzzt4zgIF23NUtUmN2Ejf1oe668eVyLil
         XsOZ+hq/35f/eOga9CLfHcdeLII69S/BO3HUw0cwJhcvQjbvSAEkQdCkXNYINHpP7gr4
         C6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715076887; x=1715681687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MmNF1Voon22sEbCDSc1Fl59X5+YrmSQN7fGFAIA4IKw=;
        b=uQcfAWZRMeMMri1INVvip/l95OmbrM8IO2WcU2lrcU9jM5ytL9Yyrb61kpQmeYy5bk
         O7R5tM9B2JNMFLuykI1WGE+5xx+Zuk29plL7R/hlM/Lv6fhuh+vTUnJQZkiwJPv29l7g
         6s1cNctgyBhfnK0QmfmkmPEb7cFSmXTVh43zImFB5Nv2fuu48q/tM8BxpLkK8obOBvXd
         X7sVzoTyUNttzCrwIPsokPcJn4BbHsSBKJDNCcHi2gYDbxyPgYDE2Ci45hrDTNu5Qx68
         50uYGDGuq7N4wc6Ls1ez0ZMByl4NO2f3J5VOU0iFseYkxM9OJ7Gdwjifr//MR6ifW8AN
         dMuA==
X-Forwarded-Encrypted: i=1; AJvYcCXRIFi1iTaKq6mB4gODFdthFcKg9n5O79HiOFX6e0WDoOxmy0qCckgNwlUbyfqyvY2H8jipZP36/pdnid2wgVEOyiX9bca7GoDqbBED
X-Gm-Message-State: AOJu0Yxmo84a8SYhZK9shDvFETvOMi36vvObgMkIJwgHc8WWcHslyBVV
	6NsbVuMj1z/rfAUoJvpDHPLr7VHNyUN78qjwA4GkeU4YmtzFyeBg
X-Google-Smtp-Source: AGHT+IE2YsE3yqQYRExxya240CqbhsZmmvu5SeOBp0MN191rAx6SG008x5nutOE0gbokYKbEGm6/zg==
X-Received: by 2002:a05:620a:370f:b0:790:96e8:5bfa with SMTP id de15-20020a05620a370f00b0079096e85bfamr4342499qkb.4.1715076887088;
        Tue, 07 May 2024 03:14:47 -0700 (PDT)
Received: from localhost (fwdproxy-nao-010.fbsv.net. [2a03:2880:23ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id h18-20020ae9ec12000000b00790fc75f318sm4759270qkg.32.2024.05.07.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 03:14:46 -0700 (PDT)
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
Subject: [PATCH v3] selftests: cgroup: add tests to verify the zswap writeback path
Date: Tue,  7 May 2024 11:14:42 +0100
Message-ID: <20240507101443.720190-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initate writeback with the below steps and check using
memory.stat.zswpwb if zswap writeback occurred:
1. Allocate memory.
2. Reclaim memory equal to the amount that was allocated in step 1.
   This will move it into zswap.
3. Save current zswap usage.
4. Move the memory allocated in step 1 back in from zswap.
5. Set zswap.max to half the amount that was recorded in step 3.
6. Attempt to reclaim memory equal to the amount that was allocated,
   this will either trigger writeback if its enabled, or reclamation
   will fail if writeback is disabled as there isn't enough zswap
   space.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---

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
 tools/testing/selftests/cgroup/test_zswap.c | 138 +++++++++++++++++++-
 1 file changed, 137 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index f0e488ed90d8..805301554fa8 100644
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
@@ -248,6 +248,140 @@ static int test_zswapin(const char *root)
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
+      this will either trigger writeback if its enabled, or reclamation
+      will fail if writeback is disabled as there isn't enough zswap space.
+ */
+static int attempt_writeback(const char *cgroup, void *arg)
+{
+	long pagesize = sysconf(_SC_PAGESIZE);
+	char *test_group = arg;
+	size_t memsize = MB(4);
+	long zswap_usage;
+	bool wb_enabled;
+	int ret = -1;
+	char memval;
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
+	for (int i = 0; i < memsize; i += pagesize) {
+		memval = 1;
+		for (int j = i; j < i + pagesize/2; j++) {
+			/* Overflow of memval is ok, will check with same values later */
+			mem[j] = memval++;
+		}
+	}
+
+	/* Try and reclaim allocated memory */
+	if (cg_write(test_group, "memory.reclaim", "4M")) {
+		ksft_print_msg("Failed to reclaim all of the requested memory\n");
+		goto out;
+	}
+
+	zswap_usage = cg_read_long(test_group, "memory.zswap.current");
+
+	/* zswpin */
+	for (int i = 0; i < memsize; i += pagesize) {
+		memval = 1;
+		for (int j = i; j < i + pagesize/2; j++) {
+			if (mem[j] != memval++) {
+				ksft_print_msg("invalid memory\n");
+				goto out;
+			}
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
+	if (!wb_enabled) {
+		if (ret == -EAGAIN)
+			ret = 0;
+		else
+			ret = -1;
+	}
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
+		ksft_print_msg("failed to get zswpwb_before\n");
+		goto out;
+	}
+
+	if (cg_run(test_group, attempt_writeback, (void *) test_group))
+		goto out;
+
+	/* Verify that zswap writeback occurred only if writeback was enabled */
+	zswpwb_after = get_cg_wb_count(test_group);
+	if (wb && zswpwb_after <= zswpwb_before) {
+		ksft_print_msg("zswpwb_after <= zswpwb_before\n");
+		goto out;
+	} else if (!wb && zswpwb_after) {
+		ksft_print_msg("zswpwb_after != zswpwb_before\n");
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
@@ -425,6 +559,8 @@ struct zswap_test {
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



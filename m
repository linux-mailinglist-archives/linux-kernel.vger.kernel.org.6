Return-Path: <linux-kernel+bounces-293695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404C1958331
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C64B239F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A518CBF9;
	Tue, 20 Aug 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kbGM7uKb"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A518C93F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147394; cv=none; b=RIulSOJCm2V6jz5jKMdIqyxLV/Jrv5Knw/qYXQs6hL+g9WIMNXDocxYduIWVTuonZSJAAu9lm8skgPmEQsyJDM89Ly96YDpp+x81LJJbIAMx/HcySuLr6z2AbXXo2/Qw3mNQT/hcDAQkDC1wNhuxLwAxYcbU3TsDDRl823rR88s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147394; c=relaxed/simple;
	bh=0ewCSOF2c1G2qY1J0DIuEJ+k7ukyWOpw1yoCOGS9yLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t6gZu+/khHYk/LJzhbBsasl5AUuy7Q/xRbr9yb/Jok7PSbPrR0Q20e+98O3VvlFoTeUn7i45bn6DVpmthBrzg9lAjaEM1A1GsAI8LLoMiYYzYWXLVeREzrZfGPjYqwbu9raXffcFJuA8mOIIObJY/1t3x0HTQ0VY2MYs/LnZJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kbGM7uKb; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724147386; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NETcifOYIb+Yf9TxOqDeY39PaKApxrCiukqpjtRmh74=;
	b=kbGM7uKbxeQJwLDFnmM7YJxxLdAEaMfd4WAuliMyaYQcTe81bEVZJxQUKgAl0LcAX7On5qhUuqMDcQ1T/eRcxkbxJY5AgOF4QLqOBoeYI5l5AyiFCO+nbwUAcwTPfxyFpMfs/fJ5XDyU7FaTssjFE6txPv4FSB7aFTIWMsB+hl8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WDIEwkS_1724147384)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 17:49:45 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: hughd@google.com,
	willy@infradead.org,
	david@redhat.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] selftests: mm: support shmem mTHP collapse testing
Date: Tue, 20 Aug 2024 17:49:17 +0800
Message-Id: <fa44bfa20ca5b9fd6f9163a048f3d3c1e53cd0a8.1724140601.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
References: <cover.1724140601.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add shmem mTHP collpase testing. Similar to the anonymous page, users can use
the '-s' parameter to specify the shmem mTHP size for testing.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 tools/testing/selftests/mm/khugepaged.c   |  4 +-
 tools/testing/selftests/mm/thp_settings.c | 46 ++++++++++++++++++++---
 tools/testing/selftests/mm/thp_settings.h |  9 ++++-
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/mm/khugepaged.c b/tools/testing/selftests/mm/khugepaged.c
index 829320a519e7..56d4480e8d3c 100644
--- a/tools/testing/selftests/mm/khugepaged.c
+++ b/tools/testing/selftests/mm/khugepaged.c
@@ -1095,7 +1095,7 @@ static void usage(void)
 	fprintf(stderr,	"\n\tSupported Options:\n");
 	fprintf(stderr,	"\t\t-h: This help message.\n");
 	fprintf(stderr,	"\t\t-s: mTHP size, expressed as page order.\n");
-	fprintf(stderr,	"\t\t    Defaults to 0. Use this size for anon allocations.\n");
+	fprintf(stderr,	"\t\t    Defaults to 0. Use this size for anon or shmem allocations.\n");
 	exit(1);
 }
 
@@ -1209,6 +1209,8 @@ int main(int argc, char **argv)
 	default_settings.khugepaged.pages_to_scan = hpage_pmd_nr * 8;
 	default_settings.hugepages[hpage_pmd_order].enabled = THP_INHERIT;
 	default_settings.hugepages[anon_order].enabled = THP_ALWAYS;
+	default_settings.shmem_hugepages[hpage_pmd_order].enabled = SHMEM_INHERIT;
+	default_settings.shmem_hugepages[anon_order].enabled = SHMEM_ALWAYS;
 
 	save_settings();
 	thp_push_settings(&default_settings);
diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
index a4163438108e..577eaab6266f 100644
--- a/tools/testing/selftests/mm/thp_settings.c
+++ b/tools/testing/selftests/mm/thp_settings.c
@@ -33,10 +33,11 @@ static const char * const thp_defrag_strings[] = {
 };
 
 static const char * const shmem_enabled_strings[] = {
+	"never",
 	"always",
 	"within_size",
 	"advise",
-	"never",
+	"inherit",
 	"deny",
 	"force",
 	NULL
@@ -200,6 +201,7 @@ void thp_write_num(const char *name, unsigned long num)
 void thp_read_settings(struct thp_settings *settings)
 {
 	unsigned long orders = thp_supported_orders();
+	unsigned long shmem_orders = thp_shmem_supported_orders();
 	char path[PATH_MAX];
 	int i;
 
@@ -234,12 +236,24 @@ void thp_read_settings(struct thp_settings *settings)
 		settings->hugepages[i].enabled =
 			thp_read_string(path, thp_enabled_strings);
 	}
+
+	for (i = 0; i < NR_ORDERS; i++) {
+		if (!((1 << i) & shmem_orders)) {
+			settings->shmem_hugepages[i].enabled = SHMEM_NEVER;
+			continue;
+		}
+		snprintf(path, PATH_MAX, "hugepages-%ukB/shmem_enabled",
+			(getpagesize() >> 10) << i);
+		settings->shmem_hugepages[i].enabled =
+			thp_read_string(path, shmem_enabled_strings);
+	}
 }
 
 void thp_write_settings(struct thp_settings *settings)
 {
 	struct khugepaged_settings *khugepaged = &settings->khugepaged;
 	unsigned long orders = thp_supported_orders();
+	unsigned long shmem_orders = thp_shmem_supported_orders();
 	char path[PATH_MAX];
 	int enabled;
 	int i;
@@ -271,6 +285,15 @@ void thp_write_settings(struct thp_settings *settings)
 		enabled = settings->hugepages[i].enabled;
 		thp_write_string(path, thp_enabled_strings[enabled]);
 	}
+
+	for (i = 0; i < NR_ORDERS; i++) {
+		if (!((1 << i) & shmem_orders))
+			continue;
+		snprintf(path, PATH_MAX, "hugepages-%ukB/shmem_enabled",
+			(getpagesize() >> 10) << i);
+		enabled = settings->shmem_hugepages[i].enabled;
+		thp_write_string(path, shmem_enabled_strings[enabled]);
+	}
 }
 
 struct thp_settings *thp_current_settings(void)
@@ -324,17 +347,18 @@ void thp_set_read_ahead_path(char *path)
 	dev_queue_read_ahead_path[sizeof(dev_queue_read_ahead_path) - 1] = '\0';
 }
 
-unsigned long thp_supported_orders(void)
+static unsigned long __thp_supported_orders(bool is_shmem)
 {
 	unsigned long orders = 0;
 	char path[PATH_MAX];
 	char buf[256];
-	int ret;
-	int i;
+	int ret, i;
+	char anon_dir[] = "enabled";
+	char shmem_dir[] = "shmem_enabled";
 
 	for (i = 0; i < NR_ORDERS; i++) {
-		ret = snprintf(path, PATH_MAX, THP_SYSFS "hugepages-%ukB/enabled",
-			(getpagesize() >> 10) << i);
+		ret = snprintf(path, PATH_MAX, THP_SYSFS "hugepages-%ukB/%s",
+			       (getpagesize() >> 10) << i, is_shmem ? shmem_dir : anon_dir);
 		if (ret >= PATH_MAX) {
 			printf("%s: Pathname is too long\n", __func__);
 			exit(EXIT_FAILURE);
@@ -347,3 +371,13 @@ unsigned long thp_supported_orders(void)
 
 	return orders;
 }
+
+unsigned long thp_supported_orders(void)
+{
+	return __thp_supported_orders(false);
+}
+
+unsigned long thp_shmem_supported_orders(void)
+{
+	return __thp_supported_orders(true);
+}
diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
index 71cbff05f4c7..876235a23460 100644
--- a/tools/testing/selftests/mm/thp_settings.h
+++ b/tools/testing/selftests/mm/thp_settings.h
@@ -22,10 +22,11 @@ enum thp_defrag {
 };
 
 enum shmem_enabled {
+	SHMEM_NEVER,
 	SHMEM_ALWAYS,
 	SHMEM_WITHIN_SIZE,
 	SHMEM_ADVISE,
-	SHMEM_NEVER,
+	SHMEM_INHERIT,
 	SHMEM_DENY,
 	SHMEM_FORCE,
 };
@@ -46,6 +47,10 @@ struct khugepaged_settings {
 	unsigned long pages_to_scan;
 };
 
+struct shmem_hugepages_settings {
+	enum shmem_enabled enabled;
+};
+
 struct thp_settings {
 	enum thp_enabled thp_enabled;
 	enum thp_defrag thp_defrag;
@@ -54,6 +59,7 @@ struct thp_settings {
 	struct khugepaged_settings khugepaged;
 	unsigned long read_ahead_kb;
 	struct hugepages_settings hugepages[NR_ORDERS];
+	struct shmem_hugepages_settings shmem_hugepages[NR_ORDERS];
 };
 
 int read_file(const char *path, char *buf, size_t buflen);
@@ -76,5 +82,6 @@ void thp_save_settings(void);
 
 void thp_set_read_ahead_path(char *path);
 unsigned long thp_supported_orders(void);
+unsigned long thp_shmem_supported_orders(void);
 
 #endif /* __THP_SETTINGS_H__ */
-- 
2.39.3



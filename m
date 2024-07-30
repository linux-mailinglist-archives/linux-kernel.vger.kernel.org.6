Return-Path: <linux-kernel+bounces-267545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E959412A3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C84D286D99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0311A0730;
	Tue, 30 Jul 2024 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDzInY6J"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9D1A01D3;
	Tue, 30 Jul 2024 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722344059; cv=none; b=ogn0EJGFOdSxRWbigrwAmHIiq8nTLf8qcvLkoBBm+wa5gAPOhNmvwLP4imvo2vmOXMW7Z2DCEIv9bUUWcniQYijeVw5us0WuXp4STGQXbISlhXoHOdoRAk2xlGP6Zg345oXQygubL0uuJhO5/jaM4c5J7A5ppDKrji/ZJVvYlAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722344059; c=relaxed/simple;
	bh=JIxWKMCWTWtq4hHAFtRWFUtzzelOPWyAk5/tlbZUSP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luh1z8LOih02eVdqTvcY8qy4ZDiCab676wTPrlT9L5lLP8HP54wbJ+HEn+w+Y89N8u8t3Ppg6TtoGCnQr73As5Vxovm21BHlfoDKn3eDNJbj7UY2KyihDj1fG2nSTuax+jvmF8JNfYsbeug4RLLx/Ulkbma7erLPOVuIh3iFxJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDzInY6J; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1e31bc183so136060985a.3;
        Tue, 30 Jul 2024 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722344056; x=1722948856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMly8HhHGH4A9wPlKbdln8VuB1NNTIz/ItEPyhn23R8=;
        b=GDzInY6Jc/5hBkqNck7COluEv2IwUxKXc3FwSd86DpRG3zgTNGq0nNq7L/ZtibcQnc
         wVtqX+pnUhEwktP29aRX3EtotYqLOVvT6yQ99Y1LG1ux4zi5WBtYAOJZIzCLf7Y1eXW0
         KS9iNt6UvLLtE6j/rnDyzi3egYb5FPykbX4MAa/WdnoMUy7pRFDzmTBJAqz+6wrwgIjz
         ImD4UrefmfCcuCpyIm2/tmyUin8IXx1UOadCB3+/NJ/5XA9RXUVGsCYwh0LdK/VbUBen
         QIGjrQ+8veKSl00FFNSA+xDhuLGaXzsfcXUWeZCyvN8jNtQtYW/OsF3edssjgWb2oMBR
         Y1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722344056; x=1722948856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMly8HhHGH4A9wPlKbdln8VuB1NNTIz/ItEPyhn23R8=;
        b=c8HW9SDaM3yWxZ6MB9Ic/KMYirOHLQiWCvwo1diJpmyl4Z/PVOQqfJlYjuc6ChGXr1
         VQWiEjsrGde67OtY9KfpcqZ3uWukHtgiTgoNrrY250uEjsT4P05+emo7RxZ9Gqvlo8mC
         V3KUG/doate3KizNVmrF2Ilgfiwr9RRy1yxZ/owOVkGsu9LtLG5jl9ubGccgz7IB4GS0
         pf6zNNpRVU6CPlMq5wehtoynOiJvIwhaJTBFXrw9SnVG2YUotuAPNoR3yY2YaElm08eq
         IKG9mDf8Y76V6zF4h9r+JiY+cJcHTjewYnVF7t1i4R537jTp2QtdM/IVgBjyFTFv+Flf
         7Zdw==
X-Forwarded-Encrypted: i=1; AJvYcCVgPzhkMIXpr4k70osMX2FkXYkHNQFqodXlSmA4F/LRBRIyIR6HuK2/mzIWcDm0sHlZqQSZw2VtItNMRBQpKrCsaYBFZVa0UBfpDLSzhsbwMsr2imyg5wwmGgKf2YYGvVNvL0oqXnuW
X-Gm-Message-State: AOJu0YxYqjpsi0i28mr/19UgoK0EQDSiKyOxz62566gnGYgMeHpcL0Jh
	8MEI8aytT/h5fCHNApwYU4a3GWPA9GsNEf4VJ6n68vTPJqmOpPde
X-Google-Smtp-Source: AGHT+IEmkurgjtLPaaaxi8bgqZN25LoWu8XIBbBu/DllgXvVyAnH9Zg7Q6mMTVSeKZ93YStrgiY5Rg==
X-Received: by 2002:a05:620a:4507:b0:79d:751b:67b6 with SMTP id af79cd13be357-7a1e525458cmr1406226385a.16.1722344056416;
        Tue, 30 Jul 2024 05:54:16 -0700 (PDT)
Received: from localhost (fwdproxy-ash-007.fbsv.net. [2a03:2880:20ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7435577sm636521785a.96.2024.07.30.05.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:54:15 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Alexander Zhu <alexlzhu@fb.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH 5/6] mm: add selftests to split_huge_page() to verify unmap/zap of zero pages
Date: Tue, 30 Jul 2024 13:46:02 +0100
Message-ID: <20240730125346.1580150-6-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125346.1580150-1-usamaarif642@gmail.com>
References: <20240730125346.1580150-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Zhu <alexlzhu@fb.com>

Self tests to verify the RssAnon value to make sure zero
pages are not remapped except in the case of userfaultfd.
Also includes a self test for the userfaultfd use case.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 .../selftests/mm/split_huge_page_test.c       | 113 ++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c          |  22 ++++
 tools/testing/selftests/mm/vm_util.h          |   1 +
 3 files changed, 136 insertions(+)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index e5e8dafc9d94..da271ad6ff11 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -17,6 +17,8 @@
 #include <malloc.h>
 #include <stdbool.h>
 #include <time.h>
+#include <sys/syscall.h>
+#include <linux/userfaultfd.h>
 #include "vm_util.h"
 #include "../kselftest.h"
 
@@ -84,6 +86,115 @@ static void write_debugfs(const char *fmt, ...)
 	write_file(SPLIT_DEBUGFS, input, ret + 1);
 }
 
+static char *allocate_zero_filled_hugepage(size_t len)
+{
+	char *result;
+	size_t i;
+
+	result = memalign(pmd_pagesize, len);
+	if (!result) {
+		printf("Fail to allocate memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	madvise(result, len, MADV_HUGEPAGE);
+
+	for (i = 0; i < len; i++)
+		result[i] = (char)0;
+
+	return result;
+}
+
+static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)
+{
+	uint64_t rss_anon_before, rss_anon_after;
+	size_t i;
+
+	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
+		printf("No THP is allocated\n");
+		exit(EXIT_FAILURE);
+	}
+
+	rss_anon_before = rss_anon();
+	if (!rss_anon_before) {
+		printf("No RssAnon is allocated before split\n");
+		exit(EXIT_FAILURE);
+	}
+
+	/* split all THPs */
+	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
+		      (uint64_t)one_page + len, 0);
+
+	for (i = 0; i < len; i++)
+		if (one_page[i] != (char)0) {
+			printf("%ld byte corrupted\n", i);
+			exit(EXIT_FAILURE);
+		}
+
+	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
+		printf("Still AnonHugePages not split\n");
+		exit(EXIT_FAILURE);
+	}
+
+	rss_anon_after = rss_anon();
+	if (rss_anon_after >= rss_anon_before) {
+		printf("Incorrect RssAnon value. Before: %ld After: %ld\n",
+		       rss_anon_before, rss_anon_after);
+		exit(EXIT_FAILURE);
+	}
+}
+
+void split_pmd_zero_pages(void)
+{
+	char *one_page;
+	int nr_hpages = 4;
+	size_t len = nr_hpages * pmd_pagesize;
+
+	one_page = allocate_zero_filled_hugepage(len);
+	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
+	printf("Split zero filled huge pages successful\n");
+	free(one_page);
+}
+
+void split_pmd_zero_pages_uffd(void)
+{
+	char *one_page;
+	int nr_hpages = 4;
+	size_t len = nr_hpages * pmd_pagesize;
+	long uffd; /* userfaultfd file descriptor */
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	/* Create and enable userfaultfd object. */
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1) {
+		perror("userfaultfd");
+		exit(1);
+	}
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
+		perror("ioctl-UFFDIO_API");
+		exit(1);
+	}
+
+	one_page = allocate_zero_filled_hugepage(len);
+
+	uffdio_register.range.start = (unsigned long)one_page;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+		perror("ioctl-UFFDIO_REGISTER");
+		exit(1);
+	}
+
+	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
+	printf("Split zero filled huge pages with uffd successful\n");
+	free(one_page);
+}
+
 void split_pmd_thp(void)
 {
 	char *one_page;
@@ -431,6 +542,8 @@ int main(int argc, char **argv)
 
 	fd_size = 2 * pmd_pagesize;
 
+	split_pmd_zero_pages();
+	split_pmd_zero_pages_uffd();
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 5a62530da3b5..7b7e763ba8e3 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -12,6 +12,7 @@
 
 #define PMD_SIZE_FILE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
 #define SMAP_FILE_PATH "/proc/self/smaps"
+#define STATUS_FILE_PATH "/proc/self/status"
 #define MAX_LINE_LENGTH 500
 
 unsigned int __page_size;
@@ -171,6 +172,27 @@ uint64_t read_pmd_pagesize(void)
 	return strtoul(buf, NULL, 10);
 }
 
+uint64_t rss_anon(void)
+{
+	uint64_t rss_anon = 0;
+	FILE *fp;
+	char buffer[MAX_LINE_LENGTH];
+
+	fp = fopen(STATUS_FILE_PATH, "r");
+	if (!fp)
+		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, STATUS_FILE_PATH);
+
+	if (!check_for_pattern(fp, "RssAnon:", buffer, sizeof(buffer)))
+		goto err_out;
+
+	if (sscanf(buffer, "RssAnon:%10ld kB", &rss_anon) != 1)
+		ksft_exit_fail_msg("Reading status error\n");
+
+err_out:
+	fclose(fp);
+	return rss_anon;
+}
+
 bool __check_huge(void *addr, char *pattern, int nr_hpages,
 		  uint64_t hpage_size)
 {
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 9007c420d52c..71b75429f4a5 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -39,6 +39,7 @@ unsigned long pagemap_get_pfn(int fd, char *start);
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
+uint64_t rss_anon(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
-- 
2.43.0



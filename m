Return-Path: <linux-kernel+bounces-284714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C986F95045F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C81F22764
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E8199EAA;
	Tue, 13 Aug 2024 12:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji2P19El"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1711199384;
	Tue, 13 Aug 2024 12:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550629; cv=none; b=hc14MlpnVylHA3vbnrmNiNy3utGdzTbTn0lFUzIe/8MJe2cBEqvexj0iMftgdGx01Ca3aVCBdo+qnO9ayzI3kwjtMszH1hwXEEQa+8BK19NOpQWBw6uKHhkcMGzDuEzqQOdUwg3E+IS1PqtdcKy44Kp87ngum/7FIbWdXdAkHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550629; c=relaxed/simple;
	bh=SjyxMmQKra7S5l/6xA9Wu7IUhwn3P+bFS/PXJwp2AHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+zTTXmp2QR62LRvQ0ngvvn97q98PMb96NfYl5h2+E2KiPRKeYpfKAg/rjTttswaVi90sjUF2FTi9XbeINoAE+2qy9xB0kT2Zw0JCBSoCVj2Y3rfSYte97cxtczqelLy7bhtGx/em7XoVtq3nmKDQxr8ImluDortk8NFdzkpKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji2P19El; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so53995866d6.1;
        Tue, 13 Aug 2024 05:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550627; x=1724155427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqJ9Y6RR0iCOONporxiAWd0rvcRWYXEUM+u9cAIorwk=;
        b=Ji2P19ElqjT4qoqC7El27UqGlYO3z66wNCrGdqfdz5JZURBcqmJrCLBhusd5o5ROVN
         lc+7imK9FAyExuAHHbHWPVWwsZBLeuihtwr4drRyTf1UJCcx6vPUsmComdFmD9+pZc5Q
         2/GUU2IJ0Hv8SS2mGj/OwK1igdQ+6n/Q3jIicvnJ8epVk7HfZiqa2ZsPlG50fve/LfxB
         vsCF5Zc85mGpNbmnAtdLXZxXK2kGmK2se5b84pQwJ2CMuJXCzknBm8nHXXKwCjjZyvzr
         q+UiYxaM9dsWSgnmTrK4vFJi7HBFm+elc2FWspWiO7WsxiaoNhiVeiNZNdiZ5UbqckQu
         afIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550627; x=1724155427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqJ9Y6RR0iCOONporxiAWd0rvcRWYXEUM+u9cAIorwk=;
        b=EEy+o/m0eYV1vMda6QA09RDlNsc/LN9S1B7Mf+FunHUdqlEE9NAvV9kLNDoGosBTlf
         Neqdf+LOzRTzm4MutHh3wl5Z3n12xhTs2qbLc3eNWZJR9tpRXeAZvWPaqPcz+5nyzOrZ
         b7bby0ECWVk8XL4fOhuSPtLFsUJgrsigt0ESfMcjETeA4GHF4y2NTg8LLVsfInVbDu5n
         vBcnJ02WJDoSMOxB1cGaNQotK+wn5S1pNl92UbMXgkz68dFiLNgS7dNDYcAr645R51Nq
         RduKecIjwPl/d8LRgU4V7Nw/V/7ilEE11esOb67Y7wUwVtpn4z1fez5czkAk97SYhUqc
         /s2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQLsOJQAhoNolFMFRs+m/SZVw3mBj9ob0NbDSDEOTaDBYLDeYGi4S5S5H1zOUJQKkHSjyWXWmYJobUcPd4Zj9YBsNlUzeoncm/EUqDo0a1/hdmYEcWpWSNRFTn4zdeiCgVFG3dfyrM
X-Gm-Message-State: AOJu0YzBXECUjUXHyA/wvkqtMhd9Imj89VJsNzVJ52JP1r0t18pT46vD
	do7gaow46l0leOrASrKAcXTPDd0NlPH9PmH2nDA3eGG3tkz16DXN
X-Google-Smtp-Source: AGHT+IFJ5i6wBfUkrpsXhs0Tc15ioa/fxXOSNWt+VVOIv2sQLq9LGVXdX8ciULa9jF+2pjwR9W6Tjw==
X-Received: by 2002:a05:6214:2aab:b0:6bb:8b7b:c2df with SMTP id 6a1803df08f44-6bf50c6a12emr48629266d6.25.1723550626609;
        Tue, 13 Aug 2024 05:03:46 -0700 (PDT)
Received: from localhost (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82e35785sm33439146d6.81.2024.08.13.05.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:46 -0700 (PDT)
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
Subject: [PATCH v3 3/6] mm: selftest to verify zero-filled pages are mapped to zeropage
Date: Tue, 13 Aug 2024 13:02:46 +0100
Message-ID: <20240813120328.1275952-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Zhu <alexlzhu@fb.com>

When a THP is split, any subpage that is zero-filled will be mapped
to the shared zeropage, hence saving memory. Add selftest to verify
this by allocating zero-filled THP and comparing RssAnon before and
after split.

Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
Acked-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 .../selftests/mm/split_huge_page_test.c       | 71 +++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c          | 22 ++++++
 tools/testing/selftests/mm/vm_util.h          |  1 +
 3 files changed, 94 insertions(+)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index e5e8dafc9d94..eb6d1b9fc362 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -84,6 +84,76 @@ static void write_debugfs(const char *fmt, ...)
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
+	unsigned long rss_anon_before, rss_anon_after;
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
 void split_pmd_thp(void)
 {
 	char *one_page;
@@ -431,6 +501,7 @@ int main(int argc, char **argv)
 
 	fd_size = 2 * pmd_pagesize;
 
+	split_pmd_zero_pages();
 	split_pmd_thp();
 	split_pte_mapped_thp();
 	split_file_backed_thp();
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 5a62530da3b5..d8d0cf04bb57 100644
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
 
+unsigned long rss_anon(void)
+{
+	unsigned long rss_anon = 0;
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
+	if (sscanf(buffer, "RssAnon:%10lu kB", &rss_anon) != 1)
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
2.43.5



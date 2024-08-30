Return-Path: <linux-kernel+bounces-308512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D4A965DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 848CAB20D72
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA3188A37;
	Fri, 30 Aug 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJSkLNDu"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EA017C23D;
	Fri, 30 Aug 2024 10:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012291; cv=none; b=HXjdxSrQChIXaXIsOsiea5yct9ZhQqxDx9J5rl1gvMedvWos2IT9hmxafQG5HZiCvvF6sFcwctDmImYgBGkxsEX8jlnIJqtoPwHHp7UwYDgeyEFGMQLqyPn2X9r32QQqIO3QaPm4E/h5EOF2ycFQg93fl8HmnXKGLfLqWtQLfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012291; c=relaxed/simple;
	bh=JRI/TG5tsEH+6PDoJbWTW8KeioTYkt/ObSbGirGtVEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgmNjreM1MEV4qlk0xLsCc75mNZdaFDqHe/kFf/oV48mKs+jAt7FPwfhbfZR4JWk3XkhLQ1A+u5DXtFnCwYgKpE3hne3o6l3gdlMHhO0dmXTFaUM0IDM41Pwv2HbH5cFLIJYhS8/BIcvKYEJ5U6CBdAPBT3CjyNuRhYSTVKs6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJSkLNDu; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2705dd4ba64so875950fac.3;
        Fri, 30 Aug 2024 03:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012286; x=1725617086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozbFo2ch+MkbZ+krZSCzDhOFvoowl/UCaYy4gtivTp4=;
        b=CJSkLNDuOJm6z6TgviQwW3i534TxivFX1WToPFfOFZgBBBqFC0g7sJKrrhUUHXPtRm
         8iUll/7HAiy1mAdNRm0DOTSdeQULKgYBL5xfrAipnwflDo8dpiRDMhwUfU1t1fnpBAi4
         4inVZsiAgV+QPMqm87u4qzVio4zM8nAnQE7HIZ1btSD4EROwrzR8mdPI0UkMC8vlaCY9
         f24FLHb1m4jKrAmJCiT1GX9vIh+fNso8dQRa3GBBZSWoGuUxlOMRmnIKf6vWqc+7wabw
         iQVt/71MV0nMW4B/ifiqmuJBXf5T18BsXFIgS+v3x3qVYeqRe+UrU3lf0aWt4J2gj3tZ
         /wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012286; x=1725617086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozbFo2ch+MkbZ+krZSCzDhOFvoowl/UCaYy4gtivTp4=;
        b=GzV/A1i4vG5kuKUd+Io5AHE/X6fveKU3AzFyi8VQeUPYuJMj6NiGPSZ7AZBWEM248C
         ZhKtLMUdgSku3po3VByDjtCrngTq9SI8NCZdWeEKQO5smNZyRK2qWoUdPacyxwetRc1g
         qb3f6c1CJzcvt64a2EArnxsP1yuLSpKN3kEKfKtw9CWQIk0q7gktrzwBCSbLn0F/Ekss
         x5glVy+FhpHJgh/O8w4y9z1zvLljvfni4aFR27N3XbJh84I22X8GazwANyzK1AhPj3AO
         CLItLpVIINUcgUcAa1zeAFYFLIBIvTSeEAk6KpHmki2VFKFDO2mOkKlDxL8ql9a1GVMP
         cg1w==
X-Forwarded-Encrypted: i=1; AJvYcCW8SuUH1aWFw/Q6HNdYE5blGzQW3lw2AcuonuWdNRZjlQ5WePZZoQC7DV4dWZwzsfVdMaZJQ7ewfG5cF+sN@vger.kernel.org, AJvYcCXGaGfBs+ZzIZCchSPdAxlRw120IGxPfMp/rxaZbXqBWenQGl3jut34ZqdjlIf4GdvET03Hn9YROWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFRuzuRZjm8omV4xgJYbGCQxdGb2iX8Hjdr5RQR11WghQRtyGh
	/gf9lKq1Iu+v/hlVtYWrOZLn6ouNHFin5yBy2L8qtiYOkk8Ir9//
X-Google-Smtp-Source: AGHT+IFoXn0hlKtDOWPBmBf5kINkjOtVZEqP5VHvyK8WGYNnu5Y+WFxUha8zAkckLlImFFhEi3Na6w==
X-Received: by 2002:a05:6870:2046:b0:270:1dab:64a9 with SMTP id 586e51a60fabf-277900c10d2mr6589971fac.14.1725012286247;
        Fri, 30 Aug 2024 03:04:46 -0700 (PDT)
Received: from localhost (fwdproxy-ash-003.fbsv.net. [2a03:2880:20ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806c4a6e6sm129878685a.64.2024.08.30.03.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:45 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Alexander Zhu <alexlzhu@fb.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 3/6] mm: selftest to verify zero-filled pages are mapped to zeropage
Date: Fri, 30 Aug 2024 11:03:37 +0100
Message-ID: <20240830100438.3623486-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830100438.3623486-1-usamaarif642@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
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
index 9007c420d52c..2eaed8209925 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -39,6 +39,7 @@ unsigned long pagemap_get_pfn(int fd, char *start);
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
+unsigned long rss_anon(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
-- 
2.43.5



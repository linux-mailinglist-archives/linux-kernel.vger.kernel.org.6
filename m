Return-Path: <linux-kernel+bounces-277978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BFC94A8E8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A81C23548
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404FC20FA89;
	Wed,  7 Aug 2024 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gucCDDgh"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424CC201259;
	Wed,  7 Aug 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038474; cv=none; b=bbt55bPJVAmh68LwAxhlj/G8HUsyRoFG1yvjIiMHHJAzI84gH14lSFhuOwEVMO5hhFPUsCGGBiN1NVBIR0vPXqwHomvxrO9YU9D3BeMAXJEpLdWs7BYqYEihnmK5Ppu6uRa0GIBz5YMMQrJGEO7w/Dc0yOt3G32Tn2tcR/v2jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038474; c=relaxed/simple;
	bh=SjyxMmQKra7S5l/6xA9Wu7IUhwn3P+bFS/PXJwp2AHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWhRpxPqzTJ0X4whBMwQ8sGKqdBudaXWLlsgrxOs5q1ILTsPM3nfgSKjTKs6opYFdJvVCKG++qdOwE9ZuPpeP4Dj1tzI+1Lg/cVEIRk1iasTxI8OwaPlHtJjiE+Gh+TLivt2jh7ZWvNnjLlV5i85KqXfcYjXKeHy7SMWF9eb/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gucCDDgh; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d3874c1eso98538385a.2;
        Wed, 07 Aug 2024 06:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723038468; x=1723643268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqJ9Y6RR0iCOONporxiAWd0rvcRWYXEUM+u9cAIorwk=;
        b=gucCDDghI51cS1eV1bqW8ztBDI+noS279TANVx9omvTSOJbGSq2xGu+OXFCg03hCJg
         wQcDkuwBw7uu3HCzBzOYBmAB7Ic/mAXBERFP75ntPHzNxyiCM6GzWJxDz8YSRxyiQIYK
         2zb9urtsfnozf8B5hWS6QVra9egScw5W8IL9dc5JSUd5KDl8mSncV2XpqL+1+0ZManYK
         92OZZHVPhPW0RX6ovbhJTFe0EMjN88irSJKtaN3I/bDr43sSW5utKMzmZJzM8ru2HFrC
         rh6fGEKH1f5dxZupVTk+7doaA3zPmArBocaYCLROn8K9Q0NSWOL8eoYPwUBom9bQlFb5
         tS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038468; x=1723643268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqJ9Y6RR0iCOONporxiAWd0rvcRWYXEUM+u9cAIorwk=;
        b=wawCC1vAemiG66gKzmrdYi+hMw4IzyhQ3GjVbedObV53qBbo44wQziZxckwNBKXWVQ
         XdbCKqDC35GH9eDZpR7xP//8h7vhUVhqWxSY3ShH8pzpstNDsomohjgZluGt/FNk3FgP
         85+GOgTHlqH2MRORumb4ymuG3ngtBMnMnXNhR/JRF8iKSHxCIUxAwdTFXHGdPQrFvBiF
         vPgjeuZ/ru8ljd5aNKXEjHIiM1amOEIjXebXJdPLyMkVYUSuhUV8y+TazaJV5gVsxPXo
         w2NcaoKvJoNORniRXKx8c4sqp161AkUde3/CrZLiKxabcR5hnsdbMohUg8Uo7jUb/QWu
         TyHw==
X-Forwarded-Encrypted: i=1; AJvYcCVGa49x5JWiOznk/KRR7b4w8fin+IV4DhnFXqGsNbqBeGqLs6Sm3D/+EvfZyjhWZKYEYBIoB6kImE8/pP+4ywpNam3fPGEjUaCdD9d6MjlipmaARE9YBqY8MVoEQVFVUv92Lzf2xeMO
X-Gm-Message-State: AOJu0YzH3dLRFAzEVNHQsU1C9gKO8J7hO+5nZV5f2SbrhO/wtLmb0CW3
	34RqVG4hHJlepUSQVgkKv7Owc3y6pOYcdv1ulSR2nAgfjutyciuv
X-Google-Smtp-Source: AGHT+IHQW7YO8vH6PCMO4bi5mfYOA1+oDgvBtCu5W4s36oxh3LTaNIEWy40RacM+ZPW0azhSvBDmOQ==
X-Received: by 2002:a05:620a:4729:b0:79f:bcf:9e6b with SMTP id af79cd13be357-7a34eebf2b5mr2001547285a.2.1723038468158;
        Wed, 07 Aug 2024 06:47:48 -0700 (PDT)
Received: from localhost (fwdproxy-ash-017.fbsv.net. [2a03:2880:20ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d3cedsm62811385a.15.2024.08.07.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:47:47 -0700 (PDT)
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
Subject: [PATCH v2 3/4] mm: selftest to verify zero-filled pages are mapped to zeropage
Date: Wed,  7 Aug 2024 14:46:48 +0100
Message-ID: <20240807134732.3292797-4-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807134732.3292797-1-usamaarif642@gmail.com>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
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



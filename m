Return-Path: <linux-kernel+bounces-296066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924A95A516
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 21:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF95284AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1931616DEBC;
	Wed, 21 Aug 2024 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iogSBig/"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE2F79CD;
	Wed, 21 Aug 2024 19:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267350; cv=none; b=UTgfTcsYshXXPe7Vb+rVmtEKZX0JiKVOq3XT3/NtNx9gEoeugHz9fwAKynQPqKMfQFmP0xb4SGivMHTjs/RqIWWsXKCGXcsOJA+AbrBmndNJhPJBkOKT89pn/6WJ6pS1eDba9+0zJSBs6SjEFg/ycS6HiZVTYGwZ00IkLhJsP/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267350; c=relaxed/simple;
	bh=1GS5KpP42dUeY0P/c4RKb8PrNCsfGY44JRLqU9LLATw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elGRYqHcWktvM+gGeVQGgZtFb+uawmWXfQa8coyJ0F6xHo9GfeBAuOe5x8ZF7TkScmCY5+1p2k4iHiCguptan7urcdwtf9IJLJdcWIvuYCABLxIorunPT0MbivvjwTt3F5WXet+vatgGbHcyo27nwptZ1JksFQSCcbiJpB/nO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iogSBig/; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1dac7f0b7so5142585a.0;
        Wed, 21 Aug 2024 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724267344; x=1724872144; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZV/86LxCKwuyalRbCAJV54TAfVVYMgUKitJ9ozX55o=;
        b=iogSBig/US+vZSXPpuAUosW7kRGzUgKdS1WbiD9Zp+GXnjuB96vqPlxo3y3hqtCy+O
         4KK6sO6tC9ZajAoCzvKdgIKvc0ybY9xyTkDCKCGEHZf+fPhbJ3t9s0T/56ZTxBxN+/lp
         Rh1Z3Ssr1dtDmTJ0X7LaKgXzy6493WDdGXQ01M4vsvqhaBnTEBGSt0YOZsxUjTEv5R9n
         1LG7RAhDLgZhcN+IWGo+7Cd3fhWI23fhEm1i7G7WgecgYXRXkETtZT60xXl9mRkxJ3Ng
         1fzxzDaUAdpKqzn/uyMpyKrArmjOBzuSG1h7Y/1I/lRNyuL/eWR/VFAEpKISkFr0UUgY
         emkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724267344; x=1724872144;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZV/86LxCKwuyalRbCAJV54TAfVVYMgUKitJ9ozX55o=;
        b=xIfScPx1e1ARSkx7MrpWGGJMi+ftmiw4g3t33QYSbckmQK/3wY2dp8x33LOYfwnGNF
         STwWk/5LdzdADV8vG2X2zh6eAMO3ND9N6WkRxCLHOvNpuAPkwOkTinCxu8XCECsOt+EP
         So8Ks1JvZtYiG1OqrYfbwmTKsldWXUxjXo4pvG1lQI46g95a7hU33wF74WMNxMKQETYi
         qptJO/F9ZKF+IkyJ7uQ2DGWNAtrVFND5kNGf3sacgyX3osvr6/RtbXzBefRo/ErvomZL
         IHSbfo5zAxfJa+pH3hjPySyWATTph08cmYhGh27c6Y8YM/mfDhVqztXOWwJ9RxsmILji
         EvsA==
X-Forwarded-Encrypted: i=1; AJvYcCVXTyx3BaGiwK4FOO4OTm3UJYMo4NetIVeTd8dtm76FnLtAJzGr7VHpffFpBpDXKOL3a2AtM2wIMI0EsAqP@vger.kernel.org, AJvYcCWVQjOmnZnGQgG2JWtQJNvdEN7D0sUUvgjXaFCHXTxt+kU3LHxNcwuWBxvo0OHgDkUnQSNxhDMnzQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPLzWKW83JDqj56dSpHXoMoo1EXCy0eigoK6wN5+bLKXN/p+IQ
	FCUpYvlGO32nPrtBPIy2YxkyOOQiX2HzEpp1sp1ND1agD1iia+Zq
X-Google-Smtp-Source: AGHT+IHxFdoYPWOkH1JCwrfDN5ypheMtxskVdCt/+SSzy7Py+zSpnykAjoilf3pepyWz8i16wVJ/jg==
X-Received: by 2002:a05:6214:3c9f:b0:6bf:796a:23ef with SMTP id 6a1803df08f44-6c15687d4e6mr29363086d6.56.1724267343564;
        Wed, 21 Aug 2024 12:09:03 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1145:4:1409:786c:cb1d:c3fb? ([2620:10d:c091:500::4:d08d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fdd8c22sm64402896d6.14.2024.08.21.12.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 12:09:03 -0700 (PDT)
Message-ID: <340d86df-94ce-4db8-8628-f75e4352bea2@gmail.com>
Date: Wed, 21 Aug 2024 15:09:02 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] mm: selftest to verify zero-filled pages are
 mapped to zeropage
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 roman.gushchin@linux.dev, yuzhao@google.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, rppt@kernel.org,
 willy@infradead.org, cerasuolodomenico@gmail.com, ryncsn@gmail.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com, Alexander Zhu <alexlzhu@fb.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
 <20240819023145.2415299-4-usamaarif642@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20240819023145.2415299-4-usamaarif642@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/08/2024 22:30, Usama Arif wrote:
> From: Alexander Zhu <alexlzhu@fb.com>
> 
> When a THP is split, any subpage that is zero-filled will be mapped
> to the shared zeropage, hence saving memory. Add selftest to verify
> this by allocating zero-filled THP and comparing RssAnon before and
> after split.
> 
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> Acked-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> ---
>  .../selftests/mm/split_huge_page_test.c       | 71 +++++++++++++++++++
>  tools/testing/selftests/mm/vm_util.c          | 22 ++++++
>  tools/testing/selftests/mm/vm_util.h          |  1 +
>  3 files changed, 94 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index e5e8dafc9d94..eb6d1b9fc362 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -84,6 +84,76 @@ static void write_debugfs(const char *fmt, ...)
>  	write_file(SPLIT_DEBUGFS, input, ret + 1);
>  }
>  
> +static char *allocate_zero_filled_hugepage(size_t len)
> +{
> +	char *result;
> +	size_t i;
> +
> +	result = memalign(pmd_pagesize, len);
> +	if (!result) {
> +		printf("Fail to allocate memory\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	madvise(result, len, MADV_HUGEPAGE);
> +
> +	for (i = 0; i < len; i++)
> +		result[i] = (char)0;
> +
> +	return result;
> +}
> +
> +static void verify_rss_anon_split_huge_page_all_zeroes(char *one_page, int nr_hpages, size_t len)
> +{
> +	unsigned long rss_anon_before, rss_anon_after;
> +	size_t i;
> +
> +	if (!check_huge_anon(one_page, 4, pmd_pagesize)) {
> +		printf("No THP is allocated\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	rss_anon_before = rss_anon();
> +	if (!rss_anon_before) {
> +		printf("No RssAnon is allocated before split\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* split all THPs */
> +	write_debugfs(PID_FMT, getpid(), (uint64_t)one_page,
> +		      (uint64_t)one_page + len, 0);
> +
> +	for (i = 0; i < len; i++)
> +		if (one_page[i] != (char)0) {
> +			printf("%ld byte corrupted\n", i);
> +			exit(EXIT_FAILURE);
> +		}
> +
> +	if (!check_huge_anon(one_page, 0, pmd_pagesize)) {
> +		printf("Still AnonHugePages not split\n");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	rss_anon_after = rss_anon();
> +	if (rss_anon_after >= rss_anon_before) {
> +		printf("Incorrect RssAnon value. Before: %ld After: %ld\n",
> +		       rss_anon_before, rss_anon_after);
> +		exit(EXIT_FAILURE);
> +	}
> +}
> +
> +void split_pmd_zero_pages(void)
> +{
> +	char *one_page;
> +	int nr_hpages = 4;
> +	size_t len = nr_hpages * pmd_pagesize;
> +
> +	one_page = allocate_zero_filled_hugepage(len);
> +	verify_rss_anon_split_huge_page_all_zeroes(one_page, nr_hpages, len);
> +	printf("Split zero filled huge pages successful\n");
> +	free(one_page);
> +}
> +
>  void split_pmd_thp(void)
>  {
>  	char *one_page;
> @@ -431,6 +501,7 @@ int main(int argc, char **argv)
>  
>  	fd_size = 2 * pmd_pagesize;
>  
> +	split_pmd_zero_pages();
>  	split_pmd_thp();
>  	split_pte_mapped_thp();
>  	split_file_backed_thp();
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 5a62530da3b5..d8d0cf04bb57 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -12,6 +12,7 @@
>  
>  #define PMD_SIZE_FILE_PATH "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size"
>  #define SMAP_FILE_PATH "/proc/self/smaps"
> +#define STATUS_FILE_PATH "/proc/self/status"
>  #define MAX_LINE_LENGTH 500
>  
>  unsigned int __page_size;
> @@ -171,6 +172,27 @@ uint64_t read_pmd_pagesize(void)
>  	return strtoul(buf, NULL, 10);
>  }
>  
> +unsigned long rss_anon(void)
> +{
> +	unsigned long rss_anon = 0;
> +	FILE *fp;
> +	char buffer[MAX_LINE_LENGTH];
> +
> +	fp = fopen(STATUS_FILE_PATH, "r");
> +	if (!fp)
> +		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, STATUS_FILE_PATH);
> +
> +	if (!check_for_pattern(fp, "RssAnon:", buffer, sizeof(buffer)))
> +		goto err_out;
> +
> +	if (sscanf(buffer, "RssAnon:%10lu kB", &rss_anon) != 1)
> +		ksft_exit_fail_msg("Reading status error\n");
> +
> +err_out:
> +	fclose(fp);
> +	return rss_anon;
> +}
> +
>  bool __check_huge(void *addr, char *pattern, int nr_hpages,
>  		  uint64_t hpage_size)
>  {
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 9007c420d52c..71b75429f4a5 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -39,6 +39,7 @@ unsigned long pagemap_get_pfn(int fd, char *start);
>  void clear_softdirty(void);
>  bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
>  uint64_t read_pmd_pagesize(void);
> +uint64_t rss_anon(void);
>  bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
>  bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);


Need below fixlet as well

From 2476b7a46908c801ab446f41566f4af52b939ac7 Mon Sep 17 00:00:00 2001
From: Usama Arif <usamaarif642@gmail.com>
Date: Wed, 21 Aug 2024 20:06:53 +0100
Subject: [PATCH] mm: selftest to verify zero-filled pages are mapped to
 zeropage fix

change uint64_t to unsigned long for rss_anon

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/mm/vm_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 71b75429f4a5..2eaed8209925 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -39,7 +39,7 @@ unsigned long pagemap_get_pfn(int fd, char *start);
 void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
-uint64_t rss_anon(void);
+unsigned long rss_anon(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
 bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
-- 
2.43.5





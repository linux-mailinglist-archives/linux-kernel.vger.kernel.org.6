Return-Path: <linux-kernel+bounces-242218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0675F92851D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B097B284068
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D114533A;
	Fri,  5 Jul 2024 09:31:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4A135A69
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171875; cv=none; b=D56sHX6yM1dvoGNkDu8tHIzxDJt2bI+AKTDDMqIVkGgHVMmv+h6L9qy/q2jK6RrS92zV/T2LDjEi45iE1HVdBTsclTJeOHjYa9K0wEq0RX8L97LvkPOc3F5Damr2QmYTCCVnezTs4dcmHz6ry1iMm36z5+fcy24uPwMyjugrNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171875; c=relaxed/simple;
	bh=1gdHd/PFkFY3kMJ3kHurFmgGr73Xnm90hy2uXVpiCYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPpOg07SquMAVhy3xgQQUj2HW1fIPtDiMQcDabyywhAdZobeVriuBpeqZZCxVryjbZA2bcDjINlNxx4OsCWCKeaGzE9uvnLkBCQ5ZsYdZdIIwMf79EwF6WJNElBYk7qddSMMKtYeZCJh0qtMIyC3HbcC/HzBrf+AXFyWBgYxwrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8094367;
	Fri,  5 Jul 2024 02:31:36 -0700 (PDT)
Received: from [10.57.74.223] (unknown [10.57.74.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 344C93F762;
	Fri,  5 Jul 2024 02:31:10 -0700 (PDT)
Message-ID: <0c183228-44d0-4f77-842a-d6c0bcf37fb1@arm.com>
Date: Fri, 5 Jul 2024 10:31:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] tools/mm: Introduce a tool to assess swap entry
 allocation for thp_swapout
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 chrisl@kernel.org, linux-mm@kvack.org
Cc: david@redhat.com, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 ying.huang@intel.com
References: <20240622071231.576056-1-21cnbao@gmail.com>
 <20240622071231.576056-2-21cnbao@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240622071231.576056-2-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/06/2024 08:12, Barry Song wrote:
> From: Barry Song <v-songbaohua@oppo.com>
> 
> Both Ryan and Chris have been utilizing the small test program to aid
> in debugging and identifying issues with swap entry allocation. While
> a real or intricate workload might be more suitable for assessing the
> correctness and effectiveness of the swap allocation policy, a small
> test program presents a simpler means of understanding the problem and
> initially verifying the improvements being made.
> 
> Let's endeavor to integrate it into tools/mm. Although it presently
> only accommodates 64KB and 4KB, I'm optimistic that we can expand
> its capabilities to support multiple sizes and simulate more
> complex systems in the future as required.
> 
> Basically, we have
> 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code
> under high exercise in a short time.
> 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in
> freeing memory, as well as for munmap, app exits, or OOM killer scenarios.
> This ensures new mTHP is always generated, released or swapped out, similar
> to the behavior on a PC or Android phone where many applications are
> frequently started and terminated.
> 3. Swap in with or without the "-a" option to observe how fragments
> due to swap-in and the incoming swap-in of large folios will impact
> swap-out fallback.
> 
> Due to 2, we ensure a certain proportion of mTHP. Similarly, because
> of 3, we maintain a certain proportion of small folios, as we don't
> support large folios swap-in, meaning any swap-in will immediately
> result in small folios. Therefore, with both 2 and 3, we automatically
> achieve a system containing both mTHP and small folios. Additionally,
> 1 provides the ability to continuously swap them out.
> 
> We can also use "-s" to add a dedicated small folios memory area.
> 
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>

I note there is an open thread about compilation failure due to missing header
include, with specific toolcahin. But once cleared up:

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

I didn't hit the compile issue so:

Tested-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  tools/mm/Makefile                  |   2 +-
>  tools/mm/thp_swap_allocator_test.c | 233 +++++++++++++++++++++++++++++
>  2 files changed, 234 insertions(+), 1 deletion(-)
>  create mode 100644 tools/mm/thp_swap_allocator_test.c
> 
> diff --git a/tools/mm/Makefile b/tools/mm/Makefile
> index 7bb03606b9ea..15791c1c5b28 100644
> --- a/tools/mm/Makefile
> +++ b/tools/mm/Makefile
> @@ -3,7 +3,7 @@
>  #
>  include ../scripts/Makefile.include
>  
> -BUILD_TARGETS=page-types slabinfo page_owner_sort
> +BUILD_TARGETS=page-types slabinfo page_owner_sort thp_swap_allocator_test
>  INSTALL_TARGETS = $(BUILD_TARGETS) thpmaps
>  
>  LIB_DIR = ../lib/api
> diff --git a/tools/mm/thp_swap_allocator_test.c b/tools/mm/thp_swap_allocator_test.c
> new file mode 100644
> index 000000000000..a363bdde55f0
> --- /dev/null
> +++ b/tools/mm/thp_swap_allocator_test.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * thp_swap_allocator_test
> + *
> + * The purpose of this test program is helping check if THP swpout
> + * can correctly get swap slots to swap out as a whole instead of
> + * being split. It randomly releases swap entries through madvise
> + * DONTNEED and swapin/out on two memory areas: a memory area for
> + * 64KB THP and the other area for small folios. The second memory
> + * can be enabled by "-s".
> + * Before running the program, we need to setup a zRAM or similar
> + * swap device by:
> + *  echo lzo > /sys/block/zram0/comp_algorithm
> + *  echo 64M > /sys/block/zram0/disksize
> + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> + *  mkswap /dev/zram0
> + *  swapon /dev/zram0
> + * The expected result should be 0% anon swpout fallback ratio w/ or
> + * w/o "-s".
> + *
> + * Author(s): Barry Song <v-songbaohua@oppo.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <time.h>
> +
> +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> +#define MEMSIZE_SMALLFOLIO (4 * 1024 * 1024)
> +#define ALIGNMENT_MTHP (64 * 1024)
> +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> +#define TOTAL_DONTNEED_SMALLFOLIO (1 * 1024 * 1024)
> +#define MTHP_FOLIO_SIZE (64 * 1024)
> +
> +#define SWPOUT_PATH \
> +	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> +#define SWPOUT_FALLBACK_PATH \
> +	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback"
> +
> +static void *aligned_alloc_mem(size_t size, size_t alignment)
> +{
> +	void *mem = NULL;
> +
> +	if (posix_memalign(&mem, alignment, size) != 0) {
> +		perror("posix_memalign");
> +		return NULL;
> +	}
> +	return mem;
> +}
> +
> +/*
> + * This emulates the behavior of native libc and Java heap,
> + * as well as process exit and munmap. It helps generate mTHP
> + * and ensures that iterations can proceed with mTHP, as we
> + * currently don't support large folios swap-in.
> + */
> +static void random_madvise_dontneed(void *mem, size_t mem_size,
> +		size_t align_size, size_t total_dontneed_size)
> +{
> +	size_t num_pages = total_dontneed_size / align_size;
> +	size_t i;
> +	size_t offset;
> +	void *addr;
> +
> +	for (i = 0; i < num_pages; ++i) {
> +		offset = (rand() % (mem_size / align_size)) * align_size;
> +		addr = (char *)mem + offset;
> +		if (madvise(addr, align_size, MADV_DONTNEED) != 0)
> +			perror("madvise dontneed");
> +
> +		memset(addr, 0x11, align_size);
> +	}
> +}
> +
> +static void random_swapin(void *mem, size_t mem_size,
> +		size_t align_size, size_t total_swapin_size)
> +{
> +	size_t num_pages = total_swapin_size / align_size;
> +	size_t i;
> +	size_t offset;
> +	void *addr;
> +
> +	for (i = 0; i < num_pages; ++i) {
> +		offset = (rand() % (mem_size / align_size)) * align_size;
> +		addr = (char *)mem + offset;
> +		memset(addr, 0x11, align_size);
> +	}
> +}
> +
> +static unsigned long read_stat(const char *path)
> +{
> +	FILE *file;
> +	unsigned long value;
> +
> +	file = fopen(path, "r");
> +	if (!file) {
> +		perror("fopen");
> +		return 0;
> +	}
> +
> +	if (fscanf(file, "%lu", &value) != 1) {
> +		perror("fscanf");
> +		fclose(file);
> +		return 0;
> +	}
> +
> +	fclose(file);
> +	return value;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int use_small_folio = 0, aligned_swapin = 0;
> +	void *mem1 = NULL, *mem2 = NULL;
> +	int i;
> +
> +	for (i = 1; i < argc; ++i) {
> +		if (strcmp(argv[i], "-s") == 0)
> +			use_small_folio = 1;
> +		else if (strcmp(argv[i], "-a") == 0)
> +			aligned_swapin = 1;
> +	}
> +
> +	mem1 = aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
> +	if (mem1 == NULL) {
> +		fprintf(stderr, "Failed to allocate large folios memory\n");
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) != 0) {
> +		perror("madvise hugepage for mem1");
> +		free(mem1);
> +		return EXIT_FAILURE;
> +	}
> +
> +	if (use_small_folio) {
> +		mem2 = aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_MTHP);
> +		if (mem2 == NULL) {
> +			fprintf(stderr, "Failed to allocate small folios memory\n");
> +			free(mem1);
> +			return EXIT_FAILURE;
> +		}
> +
> +		if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) != 0) {
> +			perror("madvise nohugepage for mem2");
> +			free(mem1);
> +			free(mem2);
> +			return EXIT_FAILURE;
> +		}
> +	}
> +
> +	/* warm-up phase to occupy the swapfile */
> +	memset(mem1, 0x11, MEMSIZE_MTHP);
> +	madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT);
> +	if (use_small_folio) {
> +		memset(mem2, 0x11, MEMSIZE_SMALLFOLIO);
> +		madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT);
> +	}
> +
> +	/* iterations with newly created mTHP, swap-in, and swap-out */
> +	for (i = 0; i < 100; ++i) {
> +		unsigned long initial_swpout;
> +		unsigned long initial_swpout_fallback;
> +		unsigned long final_swpout;
> +		unsigned long final_swpout_fallback;
> +		unsigned long swpout_inc;
> +		unsigned long swpout_fallback_inc;
> +		double fallback_percentage;
> +
> +		initial_swpout = read_stat(SWPOUT_PATH);
> +		initial_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
> +
> +		/*
> +		 * The following setup creates a 1:1 ratio of mTHP to small folios
> +		 * since large folio swap-in isn't supported yet. Once we support
> +		 * mTHP swap-in, we'll likely need to reduce MEMSIZE_MTHP and
> +		 * increase MEMSIZE_SMALLFOLIO to maintain the ratio.
> +		 */
> +		random_swapin(mem1, MEMSIZE_MTHP,
> +				aligned_swapin ? ALIGNMENT_MTHP : ALIGNMENT_SMALLFOLIO,
> +				TOTAL_DONTNEED_MTHP);
> +		random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTHP,
> +				TOTAL_DONTNEED_MTHP);
> +
> +		if (use_small_folio) {
> +			random_swapin(mem2, MEMSIZE_SMALLFOLIO,
> +					ALIGNMENT_SMALLFOLIO,
> +					TOTAL_DONTNEED_SMALLFOLIO);
> +		}
> +
> +		if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) != 0) {
> +			perror("madvise pageout for mem1");
> +			free(mem1);
> +			if (mem2 != NULL)
> +				free(mem2);
> +			return EXIT_FAILURE;
> +		}
> +
> +		if (use_small_folio) {
> +			if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOUT) != 0) {
> +				perror("madvise pageout for mem2");
> +				free(mem1);
> +				free(mem2);
> +				return EXIT_FAILURE;
> +			}
> +		}
> +
> +		final_swpout = read_stat(SWPOUT_PATH);
> +		final_swpout_fallback = read_stat(SWPOUT_FALLBACK_PATH);
> +
> +		swpout_inc = final_swpout - initial_swpout;
> +		swpout_fallback_inc = final_swpout_fallback - initial_swpout_fallback;
> +
> +		fallback_percentage = (double)swpout_fallback_inc /
> +			(swpout_fallback_inc + swpout_inc) * 100;
> +
> +		printf("Iteration %d: swpout inc: %lu, swpout fallback inc: %lu, Fallback percentage: %.2f%%\n",
> +				i + 1, swpout_inc, swpout_fallback_inc, fallback_percentage);
> +	}
> +
> +	free(mem1);
> +	if (mem2 != NULL)
> +		free(mem2);
> +
> +	return EXIT_SUCCESS;
> +}



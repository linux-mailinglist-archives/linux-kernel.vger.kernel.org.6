Return-Path: <linux-kernel+bounces-564952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3AA65D85
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7CD17CE75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717BF1C07DA;
	Mon, 17 Mar 2025 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/1GN7Na"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7E74A06
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742238331; cv=none; b=mxAUZ4j4ZjH2aNeR5PVh+f2+08rhYY+HXRVeme5CXfnpkVCgtuKGUWuo2BqyIs09LOhOeAXnt484oVLEWQqkBqSEUCsh0Cl55JzW+Ermtyutips4+5Pl2cz9qHOc7FzOyiuNufUPvHXXGoM26/c8KLt0pMY9uea1qTxaJk0/244=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742238331; c=relaxed/simple;
	bh=xGrEjToUOgsY9fL22B6DtpMCFedW7xjAY3gorWaF4lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mtr3vV79deDGcb+Sg+IAgRu3mF+ARF9vrRIgqPa1d2vU5ipPFbJnQlh4KFn5Z/mRw0wWEoNv7smqBZ8ki+0ue/k0Rkx+QlvcWgmPE1bdevJ4Nn6HGJE18FaP1HCpNqz6xNpl57K8KfqZJj6rxEXr5nLsQfImRhregQnIj7+vENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/1GN7Na; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742238328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UsOXMl93ebs5LY5H0WA9B3RWYRXifobzHDX+zAABh18=;
	b=i/1GN7Na1gDsleiWMUpdUAK2Q+Ahzn/ruPiqi4R/repamrNyNcpRjhB/xiMn6hfw50/MOc
	jiFmVt0qNWHlKswK/ChUlQ+AAiPlfRtE3Cpm+ypLlxYKTBAPfSoHzYKW32l054QIp1HlZp
	EWoh+6tKyvWlxLuEOXPYDQIjLoosJNY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-mmc0wJGtM5e5a5RoBYwWCA-1; Mon, 17 Mar 2025 15:05:27 -0400
X-MC-Unique: mmc0wJGtM5e5a5RoBYwWCA-1
X-Mimecast-MFC-AGG-ID: mmc0wJGtM5e5a5RoBYwWCA_1742238326
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c579d37eeeso651205585a.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742238326; x=1742843126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsOXMl93ebs5LY5H0WA9B3RWYRXifobzHDX+zAABh18=;
        b=HOXtBGLOQkMiU9yg8QlQc0QLLvWB7Yj9pWbvaXDxCvIzZpld8/wh+5/l6JAAy/CJiT
         bEmOCSbykL4zbaMethxK6S+kzEqUTGjUyxCjt0qkVu8MHuaRsb5B8vWlln+209tmV/ZA
         FrWcIo76E6Kso3/Q9/Jle4oAIC/vMezjf/V+yyNrtyE+UOyfnYsg6jXHNOO21ErPAYGS
         IrJphZix9EFkNE+aw3sKkSBgcUsqLPb4NIZw4t6bBPLTs1ZwUAmzOZZPdZHgZ0CrvIfO
         lIsb4r8Sz5EFlzmGO312E3U5PtdEZzZK2miAVaCranyHGy/WICmo0LRGx5WP4EYexlAJ
         irtA==
X-Forwarded-Encrypted: i=1; AJvYcCUbXwWu6W40UAFcINVwxbNEWrzN8ap5VXS2DI1GMkCo/IjSiO7AIwEDoyXOi5p4CkyBGpA/RpWU0l6sBo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx3MJ2Oz3gme9k2+/b6qFQx7h5c54bKnRp6wFgwVaZ4wQPDpkh
	pU5HEy6iZROrS+0tpDRvbjdIq0hVGL09LmFyJ/cpHG7qNr44ad4kasjZbx6u1AJV9u7pgBv/g9p
	24yEtjBFYIzHDwZhkX8D33h2qnQMCsbRKla2eOpMLd4rvCcYnvhcfjfnElcvgQQ==
X-Gm-Gg: ASbGncsjQEE6XJJeEGQ7g2HHQDSLzllknSUpYsNnfWUtrA9hcCJRCpOsF2FCt2KNaTY
	yXhvjuECXtwietxQVhdppjdISgdTKStCSguaV6WFBZl5E8MFHNLjBc666WwZKvVlioSB+E2cKE6
	4p6JDM+Ir6FbAQ0E7XiafzomBY2dFerCmM9pdrkmpVbJV0T09gM4bUrreJAdQ8XDpatuGjQ9LmD
	P4CM71qoJE5TuKcD0AxG9ZHRJQfjI9sOHWESpQREKJ0u1z8/dARDl7DDY2xedIp5ue4jplZ8YET
	CWK5uRQ=
X-Received: by 2002:a05:6214:4009:b0:6e8:f3b0:fa33 with SMTP id 6a1803df08f44-6eaea9ed9e0mr218201586d6.8.1742238326485;
        Mon, 17 Mar 2025 12:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1K39k7zt2GnQKcbjISXoc98vy6YInkdZ+nO3lU4s/J0+SLaRFyON3JbfudsvJiL7zfoW3lA==
X-Received: by 2002:a05:6214:4009:b0:6e8:f3b0:fa33 with SMTP id 6a1803df08f44-6eaea9ed9e0mr218201146d6.8.1742238326084;
        Mon, 17 Mar 2025 12:05:26 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb63e688sm56564131cf.31.2025.03.17.12.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 12:05:25 -0700 (PDT)
Date: Mon, 17 Mar 2025 15:05:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Marty Kareem <MartyKareem@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH RESEND] mm/selftest: Replace static BASE_PMD_ADDR with
 dynamic address allocation
Message-ID: <Z9hycm5JEAcGFrd2@x1.local>
References: <LV3P220MB18150CCCE6ADB3973208C245BAD22@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV3P220MB18150CCCE6ADB3973208C245BAD22@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>

Hello, Marty,

On Thu, Mar 13, 2025 at 10:35:35PM -0400, Marty Kareem wrote:
> (RESEND: previous email accidentally sent in HTML format, resending in plain
> text)

Yes, plan text is better, but when you repost again please send the patch
directly instead of making it an attachment.  See:

  https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

You could leverage git format-patch or git send-patch.

> 
> This patch addresses a longstanding TODO comment in the userfaultfd tests,
> '/linux/tools/testing/selftests/mm/uffd-common.c'
> ("/* Use a static addr is ugly */") by replacing hardcoded 1GB addresses
> with dynamic allocation. I'd appreciate your review.
> 
> The Problem
> ------------
> The current static address approach:
> - Causes test failures when other mappings occupy the 1GB region
> - Prevents parallel test execution (critical for modern CI/CD systems)
> - Breaks on systems with unusual memory layouts

Yes, I believe this is a real selftest issue.

> 
> The Solution
> ------------
> I implemented a find_suitable_area() helper that:
> - Asks the kernel for suggested addresses via mmap(NULL)
> - Automatically aligns for huge pages when needed
> - Uses MAP_FIXED_NOREPLACE where available (graceful fallback otherwise)
> - Adds guard pages between mappings to prevent VMA merging
> 
> Validation
> ----------
> I did multiple tests on my implementation to make sure it worked like:
> - Multiple parallel test runs
> - Memory pressure scenarios
> - Edge cases (unusual alignments, sizes, etc.)
> - Race conditions and concurrent access
> 
> Performance impact is minimal , about 1.2x overhead compared to the static
> approach in benchmarks.
> 
> Why This Matters
> ----------------
> - Removes longstanding TODO from the codebase
> - Enables safe parallel testing
> - Makes tests portable to different environments and memory layouts
> - Improves overall test reliability
> 
> This is my first PR for the Linux Kernel and I would be
> grateful for your feedback!
> 
> Signed-off-by: MrMartyK <martykareem@outlook.com>

> From 5295ee5a7532f1e75364cefa1091dfb49ad320d4 Mon Sep 17 00:00:00 2001
> From: MrMartyK <martykareem@outlook.com>

If you want, you may fill this up with your real full name.  But it's your
call.

> Date: Thu, 13 Mar 2025 20:17:43 -0400
> Subject: [PATCH] mm/selftest: Replace static BASE_PMD_ADDR with dynamic
>  address allocation
> 
> This commit replaces the static BASE_PMD_ADDR in userfaultfd tests with
> dynamic address discovery using the find_suitable_area() function. This
> addresses a TODO comment in the code which noted that using a static
> address was 'ugly'.
> 
> The implementation:
> 1. Adds find_suitable_area() that obtains a good address hint from the OS
> 2. Updates shmem_allocate_area() to use dynamic allocation
> 3. Includes proper fallback mechanisms when preferred addresses unavailable
> 4. Works with both MAP_FIXED_NOREPLACE and MAP_FIXED
> 5. Maintains backward compatibility with existing tests
> 
> This provides more robust operation when running tests in parallel or in
> environments with different memory layouts, while maintaining good
> performance (only ~1.2x overhead vs. the static approach).
> 
> Additional updates:
> - Added improved code formatting and comments
> - Enhanced error handling in fallback cases
> - Fixed memory verification in integration tests
> 
> Signed-off-by: MrMartyK <martykareem@outlook.com>
> ---
>  tools/testing/selftests/mm/uffd-common.c | 114 ++++++++++++++++++-----
>  1 file changed, 93 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
> index 717539eddf98..b91510da494e 100644
> --- a/tools/testing/selftests/mm/uffd-common.c
> +++ b/tools/testing/selftests/mm/uffd-common.c
> @@ -7,7 +7,7 @@
>  
>  #include "uffd-common.h"
>  
> -#define BASE_PMD_ADDR ((void *)(1UL << 30))
> +// Removed static BASE_PMD_ADDR definition in favor of dynamic address allocation
>  
>  volatile bool test_uffdio_copy_eexist = true;
>  unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
> @@ -122,6 +122,39 @@ static void shmem_release_pages(char *rel_area)
>  		err("madvise(MADV_REMOVE) failed");
>  }
>  
> +/**
> + * Find a suitable virtual address area of the requested size and alignment
> + *
> + * This function obtains a hint from the OS about where a good place to map
> + * memory might be, then aligns it according to the specified alignment
> + * requirements.
> + *
> + * @param size      Size of the memory area needed
> + * @param alignment Alignment requirement (typically huge page size)
> + * @return          A suitable address or NULL if none could be found
> + */
> +static void *find_suitable_area(size_t size, size_t alignment)
> +{
> +	void *addr;
> +	void *hint;
> +	uintptr_t aligned_addr;
> +	
> +	/* First try to get a suggestion from the OS */
> +	addr = mmap(NULL, size, PROT_NONE, 
> +	            MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (addr == MAP_FAILED)
> +		return NULL;
> +	
> +	/* Remember the address and unmap it */
> +	hint = addr;
> +	munmap(addr, size);

Above PROT_NONE private map trick looks good.  But right after munmap(),
another thread could take this range away instead using another concurrent
mmap(), because the kernel (after munmap() returned here) would think this
area free.

To make it not possible to happen, IIUC the general way to do this is
keeping the pointer without munmap() here, then mmap() with MAP_FIXED the
2nd time directly on top of it, causing atomic unmap of the PROT_NONE
range, replacing it with the new mmap() you really need.  Before the 2nd
mmap(), nothing should be able to race taking that region because in the
kernel this range is still occupied.

With that, IIUC we also don't need MAP_FIXED_NOREPLACE, because such
behavior should exist forever, and it should work on both old/new kernels.

> +	
> +	/* Align the address to requested alignment (e.g., huge page size) */
> +	aligned_addr = ((uintptr_t)hint + alignment - 1) & ~(alignment - 1);
> +	
> +	return (void *)aligned_addr;
> +}
> +
>  static int shmem_allocate_area(void **alloc_area, bool is_src)
>  {
>  	void *area_alias = NULL;
> @@ -129,35 +162,74 @@ static int shmem_allocate_area(void **alloc_area, bool is_src)
>  	unsigned long offset = is_src ? 0 : bytes;
>  	char *p = NULL, *p_alias = NULL;
>  	int mem_fd = uffd_mem_fd_create(bytes * 2, false);
> +	int map_flags;
>  
> -	/* TODO: clean this up.  Use a static addr is ugly */
> -	p = BASE_PMD_ADDR;
> -	if (!is_src)
> +	/* Find a suitable address range with appropriate alignment */
> +	p = find_suitable_area(bytes, hpage_size);
> +	if (!p) {
> +		/* Fallback strategy if finding area fails */
> +		fprintf(stderr, "Warning: Could not find suitable address, letting kernel choose\n");
> +	}
> +
> +	/* If this is dst area, add offset to prevent overlap with src area */
> +	if (!is_src && p) {
> +		/* Use same spacing as original code to maintain compatibility */
>  		/* src map + alias + interleaved hpages */
> -		p += 2 * (bytes + hpage_size);
> -	p_alias = p;
> -	p_alias += bytes;
> -	p_alias += hpage_size;  /* Prevent src/dst VMA merge */
> +		p = (char *)p + 2 * (bytes + hpage_size);
> +	}
>  
> -	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> -			   mem_fd, offset);
> +	/* Select flags based on whether we have a preferred address */
> +	map_flags = MAP_SHARED;
> +	if (p) {
> +#ifdef MAP_FIXED_NOREPLACE
> +		map_flags |= MAP_FIXED_NOREPLACE;
> +#else
> +		/* Fallback to regular MAP_FIXED if necessary */
> +		map_flags |= MAP_FIXED;
> +#endif
> +	}
> +
> +	/* Try to map at the suggested address, falling back if needed */
> +	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, map_flags, mem_fd, offset);
> +	
>  	if (*alloc_area == MAP_FAILED) {
> -		*alloc_area = NULL;
> -		return -errno;
> +		/* If fixed mapping failed, try again without it */
> +		*alloc_area = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
> +				  MAP_SHARED, mem_fd, offset);
> +		if (*alloc_area == MAP_FAILED) {
> +			*alloc_area = NULL;
> +			close(mem_fd);
> +			return -errno;
> +		}
>  	}
> -	if (*alloc_area != p)
> -		err("mmap of memfd failed at %p", p);
>  
> -	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
> -			  mem_fd, offset);
> +	/* Calculate a good spot for the alias mapping with space to prevent merging */
> +	p_alias = (char *)((uintptr_t)*alloc_area + bytes + hpage_size);
> +
> +	/* Map the alias area */
> +	map_flags = MAP_SHARED;
> +#ifdef MAP_FIXED_NOREPLACE
> +	map_flags |= MAP_FIXED_NOREPLACE;
> +#else
> +	map_flags |= MAP_FIXED;
> +#endif
> +
> +	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE,
> +			  map_flags, mem_fd, offset);
> +
>  	if (area_alias == MAP_FAILED) {
> -		munmap(*alloc_area, bytes);
> -		*alloc_area = NULL;
> -		return -errno;
> +		/* If fixed mapping failed, try anywhere */
> +		area_alias = mmap(NULL, bytes, PROT_READ | PROT_WRITE,
> +				  MAP_SHARED, mem_fd, offset);
> +		if (area_alias == MAP_FAILED) {
> +			munmap(*alloc_area, bytes);
> +			*alloc_area = NULL;
> +			close(mem_fd);
> +			return -errno;
> +		}
>  	}
> -	if (area_alias != p_alias)
> -		err("mmap of anonymous memory failed at %p", p_alias);
>  
> +	/* Store the alias mapping for later use */
>  	if (is_src)
>  		area_src_alias = area_alias;
>  	else
> -- 
> 2.43.0
> 


-- 
Peter Xu



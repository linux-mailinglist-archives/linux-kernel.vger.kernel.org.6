Return-Path: <linux-kernel+bounces-255474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F9593412D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2D31C21513
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD051822CA;
	Wed, 17 Jul 2024 17:10:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDBA7470
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 17:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236229; cv=none; b=gV6/snjxslEGK7g0N0TuI6h9EiaB1a8pe4Z8tWU4FxRXJ61UCmwq/MfIIGNkiJTi1r1SJX/gk+MGMqs8OtLFJxum5wRqNn3ucmY2FILTTYVtVPAe8Pzd3FutQiG3ZJ9ogIcboynUHEf86uOkbHaZho5oyvMzH6i2+bSQiJd0jlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236229; c=relaxed/simple;
	bh=yOmRUUbYv8U3o6WPBVqzSFStgceoLiUWMaFib9Kb7ME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOovh9RZ73r87JjjhRBa0Vb9jstV9U0mp3Bglttp2b6/c/Tqfc5+ULJ7IMtjfgSqoIFIZ+oMKL6QtdEmxrNUsHXhLo/6p2YtIM0wUT1hOuHMcPfRXkkZ+kBRSI9NaRnQqiZZ0LxqmkbVIkDQ0iBoAqOgz5JEcqbcz4zzqHe7j70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63E171063;
	Wed, 17 Jul 2024 10:10:50 -0700 (PDT)
Received: from [10.57.77.222] (unknown [10.57.77.222])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0D23F73F;
	Wed, 17 Jul 2024 10:10:22 -0700 (PDT)
Message-ID: <bb2fdbb7-6fef-4ea4-8dbb-ec62148b3965@arm.com>
Date: Wed, 17 Jul 2024 18:10:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/4] mm: Introduce "always+exec" for mTHP
 file_enabled control
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Gavin Shan <gshan@redhat.com>,
 Pankaj Raghav <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240717071257.4141363-1-ryan.roberts@arm.com>
 <20240717071257.4141363-3-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240717071257.4141363-3-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2024 08:12, Ryan Roberts wrote:
> In addition to `always` and `never`, add `always+exec` as an option for:
> 
>   /sys/kernel/mm/transparent_hugepage/hugepages-*kB/file_enabled
> 
> `always+exec` acts like `always` but additionally marks the hugepage
> size as the preferred hugepage size for sections of any file mapped with
> execute permission. A maximum of one hugepage size can be marked as
> `exec` at a time, so applying it to a new size implicitly removes it
> from any size it was previously set for.

Just to document discussion around this which happened in the THP Cabal meeting,
there was a proposal to avoid user controls by always always allocating the
largest folio that we can for an exec mapping, given the bounds of the VMA. But
we concluded that this would likely cause latency concerns for some workloads
(e.g. increased app start up time). We then thought about setting a ceiling on
the folio size to allocate (e.g. 64K). But in that case, who decides what the
right ceiling value is? So, in my opinion, we are back to user controls.

Thanks,
Ryan

> 
> Change readahead to use this flagged exec size; when a request is made
> for an executable mapping, do a synchronous read of the size in a
> naturally aligned manner.
> 
> On arm64 if memory is physically contiguous and naturally aligned to the
> "contpte" size, we can use contpte mappings, which improves utilization
> of the TLB. When paired with the "multi-size THP" changes, this works
> well to reduce dTLB pressure. However iTLB pressure is still high due to
> executable mappings having a low liklihood of being in the required
> folio size and mapping alignment, even when the filesystem supports
> readahead into large folios (e.g. XFS).
> 
> The reason for the low liklihood is that the current readahead algorithm
> starts with an order-2 folio and increases the folio order by 2 every
> time the readahead mark is hit. But most executable memory is faulted in
> fairly randomly and so the readahead mark is rarely hit and most
> executable folios remain order-2. This is observed impirically and
> confirmed from discussion with a gnu linker expert; in general, the
> linker does nothing to group temporally accessed text together
> spacially. Additionally, with the current read-around approach there are
> no alignment guarrantees between the file and folio. This is
> insufficient for arm64's contpte mapping requirement (order-4 for 4K
> base pages).
> 
> So it seems reasonable to special-case the read(ahead) logic for
> executable mappings. The trade-off is performance improvement (due to
> more efficient storage of the translations in iTLB) vs potential read
> amplification (due to reading too much data around the fault which won't
> be used), and the latter is independent of base page size.
> 
> Of course if no hugepage size is marked as `always+exec` the old
> behaviour is maintained.
> 
> Performance Benchmarking
> ------------------------
> 
> The below shows kernel compilation and speedometer javascript benchmarks
> on Ampere Altra arm64 system. When the patch is applied, `always+exec`
> is set for 64K folios.
> 
> First, confirmation that this patch causes more memory to be contained
> in 64K folios (this is for all file-backed memory so includes
> non-executable too):
> 
> | File-backed folios      |   Speedometer   |  Kernel Compile |
> | by size as percentage   |-----------------|-----------------|
> | of all mapped file mem  | before |  after | before |  after |
> |=========================|========|========|========|========|
> |file-thp-aligned-16kB    |    45% |     9% |    46% |     7% |
> |file-thp-aligned-32kB    |     2% |     0% |     3% |     1% |
> |file-thp-aligned-64kB    |     3% |    63% |     5% |    80% |
> |file-thp-aligned-128kB   |    11% |    11% |     0% |     0% |
> |file-thp-unaligned-16kB  |     1% |     0% |     3% |     1% |
> |file-thp-unaligned-128kB |     1% |     0% |     0% |     0% |
> |file-thp-partial         |     0% |     0% |     0% |     0% |
> |-------------------------|--------|--------|--------|--------|
> |file-cont-aligned-64kB   |    16% |    75% |     5% |    80% |
> 
> The above shows that for both use cases, the amount of file memory
> backed by 16K folios reduces and the amount backed by 64K folios
> increases significantly. And the amount of memory that is contpte-mapped
> significantly increases (last line).
> 
> And this is reflected in performance improvement:
> 
> Kernel Compilation (smaller is faster):
> | kernel   |   real-time |   kern-time |   user-time |   peak memory |
> |----------|-------------|-------------|-------------|---------------|
> | before   |        0.0% |        0.0% |        0.0% |          0.0% |
> | after    |       -1.6% |       -2.1% |       -1.7% |          0.0% |
> 
> Speedometer (bigger is faster):
> | kernel   |   runs_per_min |   peak memory |
> |----------|----------------|---------------|
> | before   |           0.0% |          0.0% |
> | after    |           1.3% |          1.0% |
> 
> Both benchmarks show a ~1.5% improvement once the patch is applied.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst |  6 +++++
>  include/linux/huge_mm.h                    | 11 ++++++++
>  mm/filemap.c                               | 11 ++++++++
>  mm/huge_memory.c                           | 31 +++++++++++++++++-----
>  4 files changed, 52 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
> index 9f3ed504c646..1aaf8e3a0b5a 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -292,12 +292,18 @@ memory from a set of allowed sizes. By default all THP sizes that the page cache
>  supports are allowed, but this set can be modified with one of::
> 
>  	echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/file_enabled
> +	echo always+exec >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/file_enabled
>  	echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>kB/file_enabled
> 
>  where <size> is the hugepage size being addressed, the available sizes for which
>  vary by system. ``always`` adds the hugepage size to the set of allowed sizes,
>  and ``never`` removes the hugepage size from the set of allowed sizes.
> 
> +``always+exec`` acts like ``always`` but additionally marks the hugepage size as
> +the preferred hugepage size for sections of any file mapped executable. A
> +maximum of one hugepage size can be marked as ``exec`` at a time, so applying it
> +to a new size implicitly removes it from any size it was previously set for.
> +
>  In some situations, constraining the allowed sizes can reduce memory
>  fragmentation, resulting in fewer allocation fallbacks and improved system
>  performance.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 19ced8192d39..3571ea0c3d8c 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -177,12 +177,18 @@ extern unsigned long huge_anon_orders_always;
>  extern unsigned long huge_anon_orders_madvise;
>  extern unsigned long huge_anon_orders_inherit;
>  extern unsigned long huge_file_orders_always;
> +extern int huge_file_exec_order;
> 
>  static inline unsigned long file_orders_always(void)
>  {
>  	return READ_ONCE(huge_file_orders_always);
>  }
> 
> +static inline int file_exec_order(void)
> +{
> +	return READ_ONCE(huge_file_exec_order);
> +}
> +
>  static inline bool hugepage_global_enabled(void)
>  {
>  	return transparent_hugepage_flags &
> @@ -453,6 +459,11 @@ static inline unsigned long file_orders_always(void)
>  	return 0;
>  }
> 
> +static inline int file_exec_order(void)
> +{
> +	return -1;
> +}
> +
>  static inline bool folio_test_pmd_mappable(struct folio *folio)
>  {
>  	return false;
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 870016fcfdde..c4a3cc6a2e46 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3128,6 +3128,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct file *fpin = NULL;
>  	unsigned long vm_flags = vmf->vma->vm_flags;
>  	unsigned int mmap_miss;
> +	int exec_order = file_exec_order();
> 
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	/* Use the readahead code, even if readahead is disabled */
> @@ -3147,6 +3148,16 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	}
>  #endif
> 
> +	/* If explicit order is set for exec mappings, use it. */
> +	if ((vm_flags & VM_EXEC) && exec_order >= 0) {
> +		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> +		ra->size = 1UL << exec_order;
> +		ra->async_size = 0;
> +		ractl._index &= ~((unsigned long)ra->size - 1);
> +		page_cache_ra_order(&ractl, ra, exec_order);
> +		return fpin;
> +	}
> +
>  	/* If we don't want any read-ahead, don't bother */
>  	if (vm_flags & VM_RAND_READ)
>  		return fpin;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index e8fe28fe9cf9..4249c0bc9388 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -81,6 +81,7 @@ unsigned long huge_anon_orders_always __read_mostly;
>  unsigned long huge_anon_orders_madvise __read_mostly;
>  unsigned long huge_anon_orders_inherit __read_mostly;
>  unsigned long huge_file_orders_always __read_mostly;
> +int huge_file_exec_order __read_mostly = -1;
> 
>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 unsigned long vm_flags,
> @@ -462,6 +463,7 @@ static const struct attribute_group hugepage_attr_group = {
>  static void hugepage_exit_sysfs(struct kobject *hugepage_kobj);
>  static void thpsize_release(struct kobject *kobj);
>  static DEFINE_SPINLOCK(huge_anon_orders_lock);
> +static DEFINE_SPINLOCK(huge_file_orders_lock);
>  static LIST_HEAD(thpsize_list);
> 
>  static ssize_t anon_enabled_show(struct kobject *kobj,
> @@ -531,11 +533,15 @@ static ssize_t file_enabled_show(struct kobject *kobj,
>  {
>  	int order = to_thpsize(kobj)->order;
>  	const char *output;
> +	bool exec;
> 
> -	if (test_bit(order, &huge_file_orders_always))
> -		output = "[always] never";
> -	else
> -		output = "always [never]";
> +	if (test_bit(order, &huge_file_orders_always)) {
> +		exec = READ_ONCE(huge_file_exec_order) == order;
> +		output = exec ? "always [always+exec] never" :
> +				"[always] always+exec never";
> +	} else {
> +		output = "always always+exec [never]";
> +	}
> 
>  	return sysfs_emit(buf, "%s\n", output);
>  }
> @@ -547,13 +553,24 @@ static ssize_t file_enabled_store(struct kobject *kobj,
>  	int order = to_thpsize(kobj)->order;
>  	ssize_t ret = count;
> 
> -	if (sysfs_streq(buf, "always"))
> +	spin_lock(&huge_file_orders_lock);
> +
> +	if (sysfs_streq(buf, "always")) {
>  		set_bit(order, &huge_file_orders_always);
> -	else if (sysfs_streq(buf, "never"))
> +		if (huge_file_exec_order == order)
> +			huge_file_exec_order = -1;
> +	} else if (sysfs_streq(buf, "always+exec")) {
> +		set_bit(order, &huge_file_orders_always);
> +		huge_file_exec_order = order;
> +	} else if (sysfs_streq(buf, "never")) {
>  		clear_bit(order, &huge_file_orders_always);
> -	else
> +		if (huge_file_exec_order == order)
> +			huge_file_exec_order = -1;
> +	} else {
>  		ret = -EINVAL;
> +	}
> 
> +	spin_unlock(&huge_file_orders_lock);
>  	return ret;
>  }
> 
> --
> 2.43.0
> 



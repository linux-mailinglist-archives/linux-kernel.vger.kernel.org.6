Return-Path: <linux-kernel+bounces-540458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D319DA4B0DB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 10:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E956F169F17
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23181DB148;
	Sun,  2 Mar 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK2q0RsI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9FD1D7E35;
	Sun,  2 Mar 2025 09:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740909164; cv=none; b=LK+vtrHirPo45UIXqwXuMaEZvJqtoUnjPKi8gN/Gq2Z5BxnoaoU0g+mP96cPKC2mj1MOU0Z4JUBwHkdV+dPNN4DQSXVtg/7LRTbSZFQQglIYwsOli9sVvLB9xXOxv5Who/8kGtmjCZfcxtErZMyJFCmh/U/5fczaA28tCtpReuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740909164; c=relaxed/simple;
	bh=qIxuZ5WiSBxwLR5ICTVNe79LX2iz3i45ANwtnsz7+NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dk0sbiUDvUSaA5ttXxgF9Ql1KELlfT1gpDyoTHjOzbkw0O98SjRQvrW6K6e1HSI4/23KY9VQAL/2PA7wwFs+RCk64RYN5eAznoMKXT4Eh+MCLcXGC/oxQsOlmpIqKIvFtFueQWQ2sgkT3CU+P8uih5ExiOGr32+HAeNny0i3KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK2q0RsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC166C4CED6;
	Sun,  2 Mar 2025 09:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740909163;
	bh=qIxuZ5WiSBxwLR5ICTVNe79LX2iz3i45ANwtnsz7+NQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hK2q0RsI2IhZnkaNBbYx0m8oZ5iyO774ejEIQwfBEUEyuyTwpZEzOvDEm2aVCTPCC
	 ab5Y3jRl8x1H0w8D/LXlx4EIR6itY4vIcs3PFvGljek/QvKMwg+sixcK9fza6oee3A
	 eki12xlpFZS3UAlowZyHkECf/Bjf1lFqj1qduXmN7u6iROZ4w2ZJsXc7ArFj+qhTpT
	 8nMmMGuNotddNRVLcBvSem24sDICYQ6leLpdf7vGEzrO5tMI4Fub/d9BzDc7lbnL8R
	 Ilaacc9fikOzSpvqDaCmc1sTeBio9xl++E398o7mgS/8/1DWH/l5Qst6mXPgYM/qEs
	 OkvCKYJjfNo1g==
Date: Sun, 2 Mar 2025 11:52:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 00/14] kexec: introduce Kexec HandOver (KHO)
Message-ID: <Z8QqVrqvR_p_CaUV@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <mafs0cyf4ii4k.fsf@kernel.org>
 <Z8Iah6FgrhSzApwf@kernel.org>
 <mafs0h64dk6wf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0h64dk6wf.fsf@kernel.org>

On Fri, Feb 28, 2025 at 11:04:48PM +0000, Pratyush Yadav wrote:
> On Fri, Feb 28 2025, Mike Rapoport wrote:
> > On Wed, Feb 26, 2025 at 08:08:27PM +0000, Pratyush Yadav wrote:
> >> On Thu, Feb 06 2025, Mike Rapoport wrote:
> >> 
> >> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >> >
> >> > Hi,
> >> >
> >> > This a next version of Alex's "kexec: Allow preservation of ftrace buffers"
> >> > series (https://lore.kernel.org/all/20240117144704.602-1-graf@amazon.com),
> >> > just to make things simpler instead of ftrace we decided to preserve
> >> > "reserve_mem" regions.
> >> [...]
> >> 
> >> I applied the patches on top of v6.14-rc1 and tried them out on an x86
> >> qemu machine . When I do a plain KHO activate and kexec, I get the below
> >> errors on boot. This causes networking to fail on the VM. The errors are
> >> consistent and happen every kexec-reboot, though fairly late in boot
> >> after systemd tries to bring up network. The same setup has worked fine
> >> with Alex's v3 of KHO patches.
> >> 
> >> Do you see anything obvious that might cause this? I can try to debug
> >> this tomorrow, but if it rings any loud bells it would be nice to know.
> >
> > Thanks for the report!
> > It didn't ring any bells, but after I've found the issue and a
> > fast-and-dirty fix.
> >
> > The scratch areas are allocated from high addresses and there is no scratch
> > memory to satisfy memblock_alloc_low() in swiotb, so second kernel produces
> > a couple of 
> >
> > software IO TLB: swiotlb_memblock_alloc: Failed to allocate 67108864 bytes for tlb structure
> 
> I also did some digging today and ended up finding the same thing out
> but it seems you got there before me :-)
> 
> >
> > and without those buffers e1000 can't dma :(
> >
> > A quick fix would be to add another scratch area in the lower memory
> > (below). I'll work on a better fix.
> 
> I have already written a less-quick fix (patch pasted below) so I
> suppose we can use that to review the idea instead. It adds a dedicated
> scratch area for lowmem, similar to your patch, and adds some tracking
> to calculate the size.
> 
> I am not sure if the size estimation is completely right though, since
> it is possible that allocations that don't _need_ to be in lowmem end up
> being there, causing the scratch area to be too big (or perhaps even
> causing allocation failures if the scale is big enough). Maybe we would
> be better off tracking lowmem allocation requests separately?

Normally memblock allocates top-down, so if there is enough memory
allocations that do not limit memory ranges won't end up in lowmem.
And on systems with smaller memory (e.g 4G and less) we'd anyway have
scratch areas in lowmem.

Yet, there is an issue with swiotlb_init() and estimation of the size for
lowmem scratch area we need to address. swiotlb_init() is called from
mem_init() and the memory it allocates won't be accounted by the time of
kho_memory_init().

I've been meaning to pull out common parts of mem_init() from arch-specific
code to mm_init for a while now, maybe the time has come :)
 
> ----- 8< -----
> From d60aeb2c4a1c0eea05e1a13b48b268d6192a615e Mon Sep 17 00:00:00 2001
> From: Pratyush Yadav <ptyadav@amazon.de>
> Date: Fri, 28 Feb 2025 22:36:06 +0000
> Subject: [PATCH] KHO: always have a lowmem scratch region
> 
> During initialization, some callers need to allocate low memory from
> memblock. One such caller is swiotlb_memblock_alloc() on x86. The global
> and per-node scratch regions are allocated without any constraints on
> the range. This can lead to having no scratch region in lowmem. If that
> happens, the lowmem allocations can fail, leading to failures during
> boot or later down the line.
> 
> Always ensure there is some scratch memory available in low memory by
> having a separate scratch area for it, along with the global and
> per-node ones, and allow specifying its size via the command line.
> 
> To more accurately guess suitable scratch sizes, add
> memblock_reserved_kern_lowmem_size() and
> memblock_reserved_kern_highmem_size() which calculate how much memory
> was allocated in low and high memory, along with some helper functions
> to calculate scratch sizes.
> 
> Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 +-
>  Documentation/kho/usage.rst                   | 10 +--
>  include/linux/memblock.h                      |  2 +
>  kernel/kexec_handover.c                       | 83 ++++++++++++++-----
>  mm/memblock.c                                 | 28 +++++++
>  5 files changed, 103 insertions(+), 29 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index ed656e2fb05ef..7c5afd45ad9dc 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2705,7 +2705,7 @@
>  			"1" | "on" | "y" - kexec handover is enabled
>  
>  	kho_scratch=	[KEXEC,EARLY]
> -			Format: nn[KMG],mm[KMG] | nn%
> +			Format: ll[KMG],nn[KMG],mm[KMG] | nn%
>  			Defines the size of the KHO scratch region. The KHO
>  			scratch regions are physically contiguous memory
>  			ranges that can only be used for non-kernel
> @@ -2715,9 +2715,10 @@
>  			bootstrap itself.
>  
>  			It is possible to specify the exact amount of
> -			memory in the form of "nn[KMG],mm[KMG]" where the
> -			first parameter defines the size of a global
> -			scratch area and the second parameter defines the
> +			memory in the form of "ll[KMG],nn[KMG],mm[KMG]" where the
> +			first parameter defines the size of a low memory scratch
> +			area, the second parameter defines the size of a global
> +			scratch area and the third parameter defines the
>  			size of additional per-node scratch areas.
>  			The form "nn%" defines scale factor (in percents)
>  			of memory that was used during boot.
> diff --git a/Documentation/kho/usage.rst b/Documentation/kho/usage.rst
> index e7300fbb309c1..6a6011809795d 100644
> --- a/Documentation/kho/usage.rst
> +++ b/Documentation/kho/usage.rst
> @@ -19,11 +19,11 @@ at compile time. Every KHO producer may have its own config option that you
>  need to enable if you would like to preserve their respective state across
>  kexec.
>  
> -To use KHO, please boot the kernel with the ``kho=on`` command line
> -parameter. You may use ``kho_scratch`` parameter to define size of the
> -scratch regions. For example ``kho_scratch=512M,512M`` will reserve a 512
> -MiB for a global scratch region and 512 MiB per NUMA node scratch regions
> -on boot.
> +To use KHO, please boot the kernel with the ``kho=on`` command line parameter.
> +You may use ``kho_scratch`` parameter to define size of the scratch regions. For
> +example ``kho_scratch=128M,512M,512M`` will reserve a 128 MiB low memory scratch
> +region, a 512 MiB global scratch region and 512 MiB per NUMA node scratch
> +regions on boot.
>  
>  Perform a KHO kexec
>  -------------------
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index 20887e199cdbd..9f5c5aec4b1d4 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -504,6 +504,8 @@ static inline __init_memblock bool memblock_bottom_up(void)
>  phys_addr_t memblock_phys_mem_size(void);
>  phys_addr_t memblock_reserved_size(void);
>  phys_addr_t memblock_reserved_kern_size(int nid);
> +phys_addr_t memblock_reserved_kern_lowmem_size(void);
> +phys_addr_t memblock_reserved_kern_highmem_size(void);
>  unsigned long memblock_estimated_nr_free_pages(void);
>  phys_addr_t memblock_start_of_DRAM(void);
>  phys_addr_t memblock_end_of_DRAM(void);
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index c26753d613cbc..29eeed09ceb31 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -547,20 +547,21 @@ late_initcall(kho_init);
>   *
>   * kho_scratch=N%
>   *
> - * It is also possible to explicitly define size for a global and per-node
> - * scratch areas:
> + * It is also possible to explicitly define size for a lowmem, a global and
> + * per-node scratch areas:
>   *
> - * kho_scratch=n[KMG],m[KMG]
> + * kho_scratch=l[KMG],n[KMG],m[KMG]
>   *
>   * The explicit size definition takes precedence over scale definition.
>   */
>  static unsigned int scratch_scale __initdata = 200;
>  static phys_addr_t scratch_size_global __initdata;
>  static phys_addr_t scratch_size_pernode __initdata;
> +static phys_addr_t scratch_size_lowmem __initdata;
>  
>  static int __init kho_parse_scratch_size(char *p)
>  {
> -	unsigned long size, size_pernode;
> +	unsigned long size, size_pernode, size_global;
>  	char *endptr, *oldp = p;
>  
>  	if (!p)
> @@ -578,15 +579,25 @@ static int __init kho_parse_scratch_size(char *p)
>  		if (*p != ',')
>  			return -EINVAL;
>  
> +		oldp = p;
> +		size_global = memparse(p + 1, &p);
> +		if (!size_global || p == oldp)
> +			return -EINVAL;
> +
> +		if (*p != ',')
> +			return -EINVAL;
> +
>  		size_pernode = memparse(p + 1, &p);
>  		if (!size_pernode)
>  			return -EINVAL;
>  
> -		scratch_size_global = size;
> +		scratch_size_lowmem = size;
> +		scratch_size_global = size_global;
>  		scratch_size_pernode = size_pernode;
>  		scratch_scale = 0;
>  
> -		pr_notice("scratch areas: global: %lluMB pernode: %lldMB\n",
> +		pr_notice("scratch areas: lowmem: %lluMB global: %lluMB pernode: %lldMB\n",
> +			  (u64)(scratch_size_lowmem >> 20),
>  			  (u64)(scratch_size_global >> 20),
>  			  (u64)(scratch_size_pernode >> 20));
>  	}
> @@ -595,18 +606,38 @@ static int __init kho_parse_scratch_size(char *p)
>  }
>  early_param("kho_scratch", kho_parse_scratch_size);
>  
> -static phys_addr_t __init scratch_size(int nid)
> +static phys_addr_t __init scratch_size_low(void)
> +{
> +	phys_addr_t size;
> +
> +	if (scratch_scale)
> +		size = memblock_reserved_kern_lowmem_size() * scratch_scale / 100;
> +	else
> +		size = scratch_size_lowmem;
> +
> +	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> +}
> +
> +static phys_addr_t __init scratch_size_high(void)
> +{
> +	phys_addr_t size;
> +
> +	if (scratch_scale)
> +		size = memblock_reserved_kern_highmem_size() * scratch_scale / 100;
> +	else
> +		size = scratch_size_global;
> +
> +	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
> +}
> +
> +static phys_addr_t __init scratch_size_node(int nid)
>  {
>  	phys_addr_t size;
>  
> -	if (scratch_scale) {
> +	if (scratch_scale)
>  		size = memblock_reserved_kern_size(nid) * scratch_scale / 100;
> -	} else {
> -		if (numa_valid_node(nid))
> -			size = scratch_size_pernode;
> -		else
> -			size = scratch_size_global;
> -	}
> +	else
> +		size = scratch_size_pernode;
>  
>  	return round_up(size, CMA_MIN_ALIGNMENT_BYTES);
>  }
> @@ -623,29 +654,41 @@ static phys_addr_t __init scratch_size(int nid)
>  static void kho_reserve_scratch(void)
>  {
>  	phys_addr_t addr, size;
> -	int nid, i = 1;
> +	int nid, i = 0;
>  
>  	if (!kho_enable)
>  		return;
>  
>  	/* FIXME: deal with node hot-plug/remove */
> -	kho_scratch_cnt = num_online_nodes() + 1;
> +	kho_scratch_cnt = num_online_nodes() + 2;
>  	size = kho_scratch_cnt * sizeof(*kho_scratch);
>  	kho_scratch = memblock_alloc(size, PAGE_SIZE);
>  	if (!kho_scratch)
>  		goto err_disable_kho;
>  
> -	/* reserve large contiguous area for allocations without nid */
> -	size = scratch_size(NUMA_NO_NODE);
> -	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
> +	/* reserve area for lowmem allocations. */
> +	size = scratch_size_low();
> +	addr = memblock_phys_alloc_range(size, CMA_MIN_ALIGNMENT_BYTES, 0,
> +					 ARCH_LOW_ADDRESS_LIMIT);
>  	if (!addr)
>  		goto err_free_scratch_desc;
>  
>  	kho_scratch[0].addr = addr;
>  	kho_scratch[0].size = size;
> +	i++;
> +
> +	/* reserve large contiguous area for allocations without nid */
> +	size = scratch_size_high();
> +	addr = memblock_phys_alloc(size, CMA_MIN_ALIGNMENT_BYTES);
> +	if (!addr)
> +		goto err_free_scratch_areas;
> +
> +	kho_scratch[1].addr = addr;
> +	kho_scratch[1].size = size;
> +	i++;
>  
>  	for_each_online_node(nid) {
> -		size = scratch_size(nid);
> +		size = scratch_size_node(nid);
>  		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
> diff --git a/mm/memblock.c b/mm/memblock.c
> index fdb08b60efc17..da7abf5e5e504 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1837,6 +1837,34 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
>  	return memblock.reserved.total_size;
>  }
>  
> +phys_addr_t __init_memblock memblock_reserved_kern_lowmem_size(void)
> +{
> +	struct memblock_region *r;
> +	phys_addr_t total = 0;
> +
> +	for_each_reserved_mem_region(r) {
> +		if ((r->flags & MEMBLOCK_RSRV_KERN) &&
> +		    (r->base + r->size <= ARCH_LOW_ADDRESS_LIMIT))
> +			total += r->size;
> +	}
> +
> +	return total;
> +}
> +
> +phys_addr_t __init_memblock memblock_reserved_kern_highmem_size(void)
> +{
> +	struct memblock_region *r;
> +	phys_addr_t total = 0;
> +
> +	for_each_reserved_mem_region(r) {
> +		if ((r->flags & MEMBLOCK_RSRV_KERN) &&
> +		    (r->base + r->size > ARCH_LOW_ADDRESS_LIMIT))
> +			total += r->size;
> +	}
> +
> +	return total;
> +}
> +
>  phys_addr_t __init_memblock memblock_reserved_kern_size(int nid)
>  {
>  	struct memblock_region *r;
> -- 
> Regards,
> Pratyush Yadav
> 

-- 
Sincerely yours,
Mike.


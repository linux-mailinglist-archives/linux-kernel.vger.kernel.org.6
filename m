Return-Path: <linux-kernel+bounces-387379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D603E9B5028
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E90CB23344
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658E51D8DFE;
	Tue, 29 Oct 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBSfyJFN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3F217D355
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730221980; cv=none; b=Zu9UjhfDJEgPsy1zUuB6sxQJfRpIyGiVWE1bOIm45rHWw1v65K8tvLeljXo0LXrQntS9kH1JqbEjAnZ4LrMWyKLypRcQL1K8Yeab+y9nIs5eu3gIJ1MvlPOh4M1SS8wNPu1Q6e7IUe1jYeb11v1drFeJ6KNBsmwxlyB+orbq/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730221980; c=relaxed/simple;
	bh=ukyVYyM0tOiZ4iqiktPsxWYx+0OwZldJr/Cwesjm6pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbJmpxST+Ca80mQxZ1KakjguR8M/G6Um9ukZ8fB5u1hOsaaUnbImvsSmBzv70lVj8VFd2QHCFZgQVgGw7ZnxMUDsBXzux32rzGAWXQrn3RrQTc2+zOCbIwhD79bFsO2qBkr7oNCPeFK4TuLwRWGhwiIE7i39/Hfktl4ILG5BRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBSfyJFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AEFC4CECD;
	Tue, 29 Oct 2024 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730221980;
	bh=ukyVYyM0tOiZ4iqiktPsxWYx+0OwZldJr/Cwesjm6pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bBSfyJFNvOZPaZUO3GeQ52d9XADLPWJmr0uaU99VQIxN5YGzLF40b2HtmsqquEBTa
	 U50WbY3bQJxBG0qco4frVQpbGIQeJu/FLQghFpuF4BWOqr3YzhhjzKGtTSp6ke8TVg
	 hGhJJEFAWcLhr6IhK10zSExEywIbCC/NiK9kwIxbBXvtfO/7PyBah+5uTXJ90pa9QP
	 ZdFhqPzRrirrbOFER6fhTyiYm3YUEnfU79E3FzfUq/OUGM6EKDCkhkmdqb9KpHUSz4
	 LL0Pt4xjn6625YRWekEYAJ58H5vD456b5w9nweeSIexFeGP9cgWW1kYMzhJhGcyASc
	 yzSE8wJwTl8MA==
Date: Tue, 29 Oct 2024 19:09:05 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, arnd@kernel.org, arnd@arndb.de,
	pasha.tatashin@soleen.com, mcgrof@kernel.org, song@kernel.org,
	mhiramat@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] alloc_tag: avoid execmem_vmap() when !MMU
Message-ID: <ZyEWsZVfNKTnRTum@kernel.org>
References: <20241028202935.1047017-1-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028202935.1047017-1-surenb@google.com>

Hi Suren,

On Mon, Oct 28, 2024 at 01:29:35PM -0700, Suren Baghdasaryan wrote:
> With CONFIG_MMU=n __get_vm_area_node() is not available and memory for the
> allocation tags cannot be populated as needed. For this case, populate the
> required memory at initialization time.

Do we care that much to have alloc_tags on !MMU configs?

Your patch is great, but it would have been a lot easier to make
MEM_ALLOC_PROFILING depend on MMU.
 
> Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410250808.dQGyYjlk-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver.sang@intel.com
> Closes: https://lore.kernel.org/oe-kbuild-all/202410261016.IO7C6Cml-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202410270919.LebQlmxD-lkp@intel.com/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/execmem.h |  2 ++
>  lib/alloc_tag.c         | 23 ++++++++++++++++++++++-
>  mm/execmem.c            | 32 ++++++++++++++++----------------
>  3 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> index 5a5e2917f870..64130ae19690 100644
> --- a/include/linux/execmem.h
> +++ b/include/linux/execmem.h
> @@ -139,6 +139,7 @@ void *execmem_alloc(enum execmem_type type, size_t size);
>   */
>  void execmem_free(void *ptr);
>  
> +#ifdef CONFIG_MMU
>  /**
>   * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memory
>   * @size: size of the virtual mapping in bytes
> @@ -148,6 +149,7 @@ void execmem_free(void *ptr);
>   * Return: the area descriptor on success or %NULL on failure.
>   */
>  struct vm_struct *execmem_vmap(size_t size);
> +#endif
>  
>  /**
>   * execmem_update_copy - copy an update to executable memory
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index c1ddac2d29f0..1c74942e6dfd 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -268,7 +268,6 @@ void __init alloc_tag_sec_init(void)
>  #ifdef CONFIG_MODULES
>  
>  static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
> -static struct vm_struct *vm_module_tags;
>  /* A dummy object used to indicate an unloaded module */
>  static struct module unloaded_mod;
>  /* A dummy object used to indicate a module prepended area */
> @@ -391,6 +390,9 @@ static bool find_aligned_area(struct ma_state *mas, unsigned long section_size,
>  	return false;
>  }
>  
> +#ifdef CONFIG_MMU
> +static struct vm_struct *vm_module_tags;
> +
>  static int vm_module_tags_populate(void)
>  {
>  	unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
> @@ -417,6 +419,13 @@ static int vm_module_tags_populate(void)
>  
>  	return 0;
>  }
> +#else
> +static int vm_module_tags_populate(void)
> +{
> +	/* Memory was already allocated */
> +	return 0;
> +}
> +#endif
>  
>  static void *reserve_module_tags(struct module *mod, unsigned long size,
>  				 unsigned int prepend, unsigned long align)
> @@ -561,6 +570,7 @@ static void replace_module(struct module *mod, struct module *new_mod)
>  
>  static int __init alloc_mod_tags_mem(void)
>  {
> +#ifdef CONFIG_MMU
>  	/* Map space to copy allocation tags */
>  	vm_module_tags = execmem_vmap(MODULE_ALLOC_TAG_VMAP_SIZE);
>  	if (!vm_module_tags) {
> @@ -578,6 +588,13 @@ static int __init alloc_mod_tags_mem(void)
>  	}
>  
>  	module_tags.start_addr = (unsigned long)vm_module_tags->addr;
> +#else
> +	/* Allocate space to copy allocation tags */
> +	module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
> +							      MODULE_ALLOC_TAG_VMAP_SIZE);
> +	if (!module_tags.start_addr)
> +		return -ENOMEM;
> +#endif
>  	module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
>  	/* Ensure the base is alloc_tag aligned when required for indexing */
>  	module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
> @@ -587,6 +604,7 @@ static int __init alloc_mod_tags_mem(void)
>  
>  static void __init free_mod_tags_mem(void)
>  {
> +#ifdef CONFIG_MMU
>  	int i;
>  
>  	module_tags.start_addr = 0;
> @@ -594,6 +612,9 @@ static void __init free_mod_tags_mem(void)
>  		__free_page(vm_module_tags->pages[i]);
>  	kfree(vm_module_tags->pages);
>  	free_vm_area(vm_module_tags);
> +#else
> +	execmem_free((void *)module_tags.start_addr);
> +#endif
>  }
>  
>  #else /* CONFIG_MODULES */
> diff --git a/mm/execmem.c b/mm/execmem.c
> index 5c0f9f2d6f83..317b6a8d35be 100644
> --- a/mm/execmem.c
> +++ b/mm/execmem.c
> @@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>  
>  	return p;
>  }
> +
> +struct vm_struct *execmem_vmap(size_t size)
> +{
> +	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
> +	struct vm_struct *area;
> +
> +	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> +				  range->start, range->end, NUMA_NO_NODE,
> +				  GFP_KERNEL, __builtin_return_address(0));
> +	if (!area && range->fallback_start)
> +		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> +					  range->fallback_start, range->fallback_end,
> +					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
> +
> +	return area;
> +}
>  #else
>  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
>  			     pgprot_t pgprot, unsigned long vm_flags)
> @@ -368,22 +384,6 @@ void execmem_free(void *ptr)
>  		vfree(ptr);
>  }
>  
> -struct vm_struct *execmem_vmap(size_t size)
> -{
> -	struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
> -	struct vm_struct *area;
> -
> -	area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> -				  range->start, range->end, NUMA_NO_NODE,
> -				  GFP_KERNEL, __builtin_return_address(0));
> -	if (!area && range->fallback_start)
> -		area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> -					  range->fallback_start, range->fallback_end,
> -					  NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
> -
> -	return area;
> -}
> -
>  void *execmem_update_copy(void *dst, const void *src, size_t size)
>  {
>  	return text_poke_copy(dst, src, size);
> 
> base-commit: 92409df3e00a17d6fd5bb27732fa186749725ed5
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

-- 
Sincerely yours,
Mike.


Return-Path: <linux-kernel+bounces-388702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EC9B6347
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB4F2820D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2BE1E884B;
	Wed, 30 Oct 2024 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/vmigNA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78491E4AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292417; cv=none; b=HnplnPiDNcV6kCQxnrYc9jWq+LC5ENO8S4ZGQkogrwWb+8xvReiw46f8pM3N9l235402zMNMzz/zNYr7/kWE8YgUJ8SjWGX1g3yUqbuwAo+nkFPyqH4dUi8sZVEcdhz6cfnHFCB0dgGRnpmvJSgGiXRgFhjIKz6R8Dn6T/sGlP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292417; c=relaxed/simple;
	bh=XO41anE+XMroSY1tEikHX5Rj9NNO7E3eB2ew5PJOOso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDU2KfF40ov1RD6pya+L0s6Q2InQGu6AtstC45RSFl73yTczLi1EzaiwpxQhwXatlrpaZNwW4ZUOhHUOYbgZ90Ka3Dk2DdhcGQiFnknslm1nTMa4jmPLl9t247KBPglw5zLfhSAfYgVtImnqwzkY0R7gSJm6R+VgQyJTtyQ6Dw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/vmigNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DC7C4CEE3;
	Wed, 30 Oct 2024 12:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730292417;
	bh=XO41anE+XMroSY1tEikHX5Rj9NNO7E3eB2ew5PJOOso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W/vmigNA+uvwPREdLWxs1c+Jj/ylmiNXQIaksBl63brZ4lq8ZDoJp549LnkqL1R8T
	 YnmdJT3iZzgdQij+FdUmA7KsY55mDFDZ30rMn9CexRaskXBOaEEg64RxwCu8ehQT/6
	 rgaf938cRo0YIwZBrBp0IN4hRvonUcNh2MB5Y/Y5JQ8JXqtvsy/Ht7oC46LtxA0mc6
	 Pxs9mGCGaetFnn2bGyX8JmMwTKGwJ59z6Wa4IOgHFhh2wtIiAHkw/vWgr8y0fRGCxf
	 y/3HmAWJpRtUo6Em9S7wvuoXu5cX0k1qK1UdnsH0646xyOLTpgH5xa4nlR5kXGD1Wh
	 rPOz2RMIi7Ruw==
Date: Wed, 30 Oct 2024 14:43:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, arnd@kernel.org, arnd@arndb.de,
	pasha.tatashin@soleen.com, mcgrof@kernel.org, song@kernel.org,
	mhiramat@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] alloc_tag: avoid execmem_vmap() when !MMU
Message-ID: <ZyIp1FFFFPul4105@kernel.org>
References: <20241028202935.1047017-1-surenb@google.com>
 <ZyEWsZVfNKTnRTum@kernel.org>
 <CAJuCfpHVgfTMTSNyvGmufjkOLPoz5onw8LujXmA-wZS9nwEikQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHVgfTMTSNyvGmufjkOLPoz5onw8LujXmA-wZS9nwEikQ@mail.gmail.com>

On Tue, Oct 29, 2024 at 01:03:51PM -0700, Suren Baghdasaryan wrote:
> On Tue, Oct 29, 2024 at 10:13 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Suren,
> >
> > On Mon, Oct 28, 2024 at 01:29:35PM -0700, Suren Baghdasaryan wrote:
> > > With CONFIG_MMU=n __get_vm_area_node() is not available and memory for the
> > > allocation tags cannot be populated as needed. For this case, populate the
> > > required memory at initialization time.
> >
> > Do we care that much to have alloc_tags on !MMU configs?
> >
> > Your patch is great, but it would have been a lot easier to make
> > MEM_ALLOC_PROFILING depend on MMU.
> 
> I didn't want to prevent !MMU users from using allocation profiling
> but I'm not aware of any current !MMU users. Therefore I have no
> objections to making MEM_ALLOC_PROFILING dependent on MMU if we indeed
> don't care about !MMU && MEM_ALLOC_PROFILING configuration.
> I'll be posting v5 tomorrow with all these fixes, so please let me
> know which way you prefer. Thanks!
 
I think if nommu users would want that feature, we can add the ifdefery
later

> > > Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as needed")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202410250808.dQGyYjlk-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver.sang@intel.com
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202410261016.IO7C6Cml-lkp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202410270919.LebQlmxD-lkp@intel.com/
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  include/linux/execmem.h |  2 ++
> > >  lib/alloc_tag.c         | 23 ++++++++++++++++++++++-
> > >  mm/execmem.c            | 32 ++++++++++++++++----------------
> > >  3 files changed, 40 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> > > index 5a5e2917f870..64130ae19690 100644
> > > --- a/include/linux/execmem.h
> > > +++ b/include/linux/execmem.h
> > > @@ -139,6 +139,7 @@ void *execmem_alloc(enum execmem_type type, size_t size);
> > >   */
> > >  void execmem_free(void *ptr);
> > >
> > > +#ifdef CONFIG_MMU
> > >  /**
> > >   * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memory
> > >   * @size: size of the virtual mapping in bytes
> > > @@ -148,6 +149,7 @@ void execmem_free(void *ptr);
> > >   * Return: the area descriptor on success or %NULL on failure.
> > >   */
> > >  struct vm_struct *execmem_vmap(size_t size);
> > > +#endif
> > >
> > >  /**
> > >   * execmem_update_copy - copy an update to executable memory
> > > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > index c1ddac2d29f0..1c74942e6dfd 100644
> > > --- a/lib/alloc_tag.c
> > > +++ b/lib/alloc_tag.c
> > > @@ -268,7 +268,6 @@ void __init alloc_tag_sec_init(void)
> > >  #ifdef CONFIG_MODULES
> > >
> > >  static struct maple_tree mod_area_mt = MTREE_INIT(mod_area_mt, MT_FLAGS_ALLOC_RANGE);
> > > -static struct vm_struct *vm_module_tags;
> > >  /* A dummy object used to indicate an unloaded module */
> > >  static struct module unloaded_mod;
> > >  /* A dummy object used to indicate a module prepended area */
> > > @@ -391,6 +390,9 @@ static bool find_aligned_area(struct ma_state *mas, unsigned long section_size,
> > >       return false;
> > >  }
> > >
> > > +#ifdef CONFIG_MMU
> > > +static struct vm_struct *vm_module_tags;
> > > +
> > >  static int vm_module_tags_populate(void)
> > >  {
> > >       unsigned long phys_size = vm_module_tags->nr_pages << PAGE_SHIFT;
> > > @@ -417,6 +419,13 @@ static int vm_module_tags_populate(void)
> > >
> > >       return 0;
> > >  }
> > > +#else
> > > +static int vm_module_tags_populate(void)
> > > +{
> > > +     /* Memory was already allocated */
> > > +     return 0;
> > > +}
> > > +#endif
> > >
> > >  static void *reserve_module_tags(struct module *mod, unsigned long size,
> > >                                unsigned int prepend, unsigned long align)
> > > @@ -561,6 +570,7 @@ static void replace_module(struct module *mod, struct module *new_mod)
> > >
> > >  static int __init alloc_mod_tags_mem(void)
> > >  {
> > > +#ifdef CONFIG_MMU
> > >       /* Map space to copy allocation tags */
> > >       vm_module_tags = execmem_vmap(MODULE_ALLOC_TAG_VMAP_SIZE);
> > >       if (!vm_module_tags) {
> > > @@ -578,6 +588,13 @@ static int __init alloc_mod_tags_mem(void)
> > >       }
> > >
> > >       module_tags.start_addr = (unsigned long)vm_module_tags->addr;
> > > +#else
> > > +     /* Allocate space to copy allocation tags */
> > > +     module_tags.start_addr = (unsigned long)execmem_alloc(EXECMEM_MODULE_DATA,
> > > +                                                           MODULE_ALLOC_TAG_VMAP_SIZE);
> > > +     if (!module_tags.start_addr)
> > > +             return -ENOMEM;
> > > +#endif
> > >       module_tags.end_addr = module_tags.start_addr + MODULE_ALLOC_TAG_VMAP_SIZE;
> > >       /* Ensure the base is alloc_tag aligned when required for indexing */
> > >       module_tags.start_addr = alloc_tag_align(module_tags.start_addr);
> > > @@ -587,6 +604,7 @@ static int __init alloc_mod_tags_mem(void)
> > >
> > >  static void __init free_mod_tags_mem(void)
> > >  {
> > > +#ifdef CONFIG_MMU
> > >       int i;
> > >
> > >       module_tags.start_addr = 0;
> > > @@ -594,6 +612,9 @@ static void __init free_mod_tags_mem(void)
> > >               __free_page(vm_module_tags->pages[i]);
> > >       kfree(vm_module_tags->pages);
> > >       free_vm_area(vm_module_tags);
> > > +#else
> > > +     execmem_free((void *)module_tags.start_addr);
> > > +#endif
> > >  }
> > >
> > >  #else /* CONFIG_MODULES */
> > > diff --git a/mm/execmem.c b/mm/execmem.c
> > > index 5c0f9f2d6f83..317b6a8d35be 100644
> > > --- a/mm/execmem.c
> > > +++ b/mm/execmem.c
> > > @@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> > >
> > >       return p;
> > >  }
> > > +
> > > +struct vm_struct *execmem_vmap(size_t size)
> > > +{
> > > +     struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
> > > +     struct vm_struct *area;
> > > +
> > > +     area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> > > +                               range->start, range->end, NUMA_NO_NODE,
> > > +                               GFP_KERNEL, __builtin_return_address(0));
> > > +     if (!area && range->fallback_start)
> > > +             area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> > > +                                       range->fallback_start, range->fallback_end,
> > > +                                       NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
> > > +
> > > +     return area;
> > > +}
> > >  #else
> > >  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> > >                            pgprot_t pgprot, unsigned long vm_flags)
> > > @@ -368,22 +384,6 @@ void execmem_free(void *ptr)
> > >               vfree(ptr);
> > >  }
> > >
> > > -struct vm_struct *execmem_vmap(size_t size)
> > > -{
> > > -     struct execmem_range *range = &execmem_info->ranges[EXECMEM_MODULE_DATA];
> > > -     struct vm_struct *area;
> > > -
> > > -     area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> > > -                               range->start, range->end, NUMA_NO_NODE,
> > > -                               GFP_KERNEL, __builtin_return_address(0));
> > > -     if (!area && range->fallback_start)
> > > -             area = __get_vm_area_node(size, range->alignment, PAGE_SHIFT, VM_ALLOC,
> > > -                                       range->fallback_start, range->fallback_end,
> > > -                                       NUMA_NO_NODE, GFP_KERNEL, __builtin_return_address(0));
> > > -
> > > -     return area;
> > > -}
> > > -
> > >  void *execmem_update_copy(void *dst, const void *src, size_t size)
> > >  {
> > >       return text_poke_copy(dst, src, size);
> > >
> > > base-commit: 92409df3e00a17d6fd5bb27732fa186749725ed5
> > > --
> > > 2.47.0.163.g1226f6d8fa-goog
> > >
> >
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.


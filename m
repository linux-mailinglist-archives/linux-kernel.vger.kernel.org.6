Return-Path: <linux-kernel+bounces-387570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC899B5309
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66091C225AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78801205ADF;
	Tue, 29 Oct 2024 20:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCRY/rcX"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93D2010EB
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232249; cv=none; b=iUNX+i3m/sm9iKHhX5gWCxhzIZwiHETd4SOi9ph/BrRh9yAMXumod+E9MXb72xQpBuXWCZza+BHRj+SZn2hrjSYsMAOHFp1L3YHO+rjEj6sZ0scPYPPnnzTjv8/Xo/p3pTO89YJRYzk/wArTpqeAj+RjLf7DFLtfF3QzJd0DQEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232249; c=relaxed/simple;
	bh=r02ZYarvMHuSz554v+BXveoT8OZ8onMzzxPEecYPOf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mt4woyeBkc26vRAyVbSeRcuqTHtt3FPPAyeOg0dqOU9tb320+EJ9ZvSpUa4yzEgTibQZfUvURV/zpNXAifJc3cUAasRsYWuHxBFbTgqe6dvqKS5QCwYQ7FmGgWverDkhF4ZVq8gvRdHL3StEWA9y4S4bbwZSNoKEkDXovuflSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCRY/rcX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460a8d1a9b7so3741cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730232245; x=1730837045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf39bWQ5vfHbieQ54t13BqlyoQktov7Zrgd6cXx/5yg=;
        b=uCRY/rcXog2/kV0QJnYWUuCHhfUphvsvlKkMQ5jqBu4TnZrowekxgHJQqYx8U3X2qa
         G0qBCsTph8AHmjIi+JY4LcVYIVkB1NXPAkH51NuXoO8oHgBCpBy2zungVWwTs2czQc1F
         Wf23LZfwPL9zUFk8AjSO89MIFSOD00XDCzX3GVj4wNg29+2x3vGvct78L0jyZoLaziBr
         dZy9NntXkp9kpaNIRWwRtWqnJMGCn14Cr2QyYgjpYUWAckb9ecWv3iERLBwT+/V0wuBa
         tRA5PIQhmQINKMe4IfVEwkXp+3aakK/uRZd1thdumGZa8bsRDVGZ0jl43d/SS0Fv/cVo
         +G0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232245; x=1730837045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zf39bWQ5vfHbieQ54t13BqlyoQktov7Zrgd6cXx/5yg=;
        b=lIgMrHtfqQnowMQDkJRob4I4EqZ0VNiEAkBlYYUXCKDv5qhft2wUvBAmOOtVHfV+r/
         HqHLOt7tT8j3BTT8uQIejTBY3IilrajP65EI4dmsjKaqo6gxAz8uth93NSalbiY18FD+
         cDLX3Wyr5748HBeB67Bw1YhTVOIo3LzotBBc9/GKf8KlabeJlS8hbes4ooNpLwThGd5t
         u62Oeq6WAz41chLcAuAeltwINFdzH2Ng5crXf+GTHT0utlxI0qkxmVr7yNEwXplEI/L6
         520ElSBucaCLH3SKVSoMPPzluXbuH2bPQuZlAEeAfq8FE3bzx5ar4mXlJgDUWNuUvEwH
         1qlA==
X-Forwarded-Encrypted: i=1; AJvYcCXri7ja9eMzxCohSbdfjRpVxK5QRDlxKJ1L3GdoTv4rTumWh/YM8RjBqVOAjJSb7cf6LuGk8zdvtHtAbSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpEuBbSv3DStE2CT/R4RREU0+K15r15+TB7PHaXczLnCL+3TC
	H3ZywecshogdpQ9FQwlSfd/3vykBJ8+kVUziFHU5G9MmVmOYRGlEx27Cks1MNIAaCtOzZdjjoYC
	FtsB7Nlz7J9JVM1tM1YY2kTSR/sdU4s9MWFN/MTQeGBCaUfC2N7QK
X-Gm-Gg: ASbGncv3xiPiiOQVKUFTbVwT2fyNqPZtyvyzE5V4onlF4x+Ww8g53FxBrZx9rLZ/48V
	hiP5/86KfejKv/7G341EzGIIMzawOc9pvgdtFLXtqh7ekt2ipvC6dvDVCH/WsSA==
X-Google-Smtp-Source: AGHT+IHZ2BmoldDG0jw/wYyhOArxtXPspkHOnLfPayzAYdt/J8JkxayXKHRKoQg8gPYakRL/DF4Pe3ywKFPSTVFhhlY=
X-Received: by 2002:ac8:776a:0:b0:461:6727:253f with SMTP id
 d75a77b69052e-4616727292amr3476101cf.24.1730232244814; Tue, 29 Oct 2024
 13:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028202935.1047017-1-surenb@google.com> <ZyEWsZVfNKTnRTum@kernel.org>
In-Reply-To: <ZyEWsZVfNKTnRTum@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 29 Oct 2024 13:03:51 -0700
Message-ID: <CAJuCfpHVgfTMTSNyvGmufjkOLPoz5onw8LujXmA-wZS9nwEikQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: avoid execmem_vmap() when !MMU
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, arnd@kernel.org, arnd@arndb.de, 
	pasha.tatashin@soleen.com, mcgrof@kernel.org, song@kernel.org, 
	mhiramat@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:13=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wr=
ote:
>
> Hi Suren,
>
> On Mon, Oct 28, 2024 at 01:29:35PM -0700, Suren Baghdasaryan wrote:
> > With CONFIG_MMU=3Dn __get_vm_area_node() is not available and memory fo=
r the
> > allocation tags cannot be populated as needed. For this case, populate =
the
> > required memory at initialization time.
>
> Do we care that much to have alloc_tags on !MMU configs?
>
> Your patch is great, but it would have been a lot easier to make
> MEM_ALLOC_PROFILING depend on MMU.

I didn't want to prevent !MMU users from using allocation profiling
but I'm not aware of any current !MMU users. Therefore I have no
objections to making MEM_ALLOC_PROFILING dependent on MMU if we indeed
don't care about !MMU && MEM_ALLOC_PROFILING configuration.
I'll be posting v5 tomorrow with all these fixes, so please let me
know which way you prefer. Thanks!

>
> > Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as nee=
ded")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410250808.dQGyYjlk-lkp=
@intel.com/
> > Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver.san=
g@intel.com
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410261016.IO7C6Cml-lkp=
@intel.com/
> > Closes: https://lore.kernel.org/oe-kbuild-all/202410270919.LebQlmxD-lkp=
@intel.com/
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/execmem.h |  2 ++
> >  lib/alloc_tag.c         | 23 ++++++++++++++++++++++-
> >  mm/execmem.c            | 32 ++++++++++++++++----------------
> >  3 files changed, 40 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> > index 5a5e2917f870..64130ae19690 100644
> > --- a/include/linux/execmem.h
> > +++ b/include/linux/execmem.h
> > @@ -139,6 +139,7 @@ void *execmem_alloc(enum execmem_type type, size_t =
size);
> >   */
> >  void execmem_free(void *ptr);
> >
> > +#ifdef CONFIG_MMU
> >  /**
> >   * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA memor=
y
> >   * @size: size of the virtual mapping in bytes
> > @@ -148,6 +149,7 @@ void execmem_free(void *ptr);
> >   * Return: the area descriptor on success or %NULL on failure.
> >   */
> >  struct vm_struct *execmem_vmap(size_t size);
> > +#endif
> >
> >  /**
> >   * execmem_update_copy - copy an update to executable memory
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index c1ddac2d29f0..1c74942e6dfd 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -268,7 +268,6 @@ void __init alloc_tag_sec_init(void)
> >  #ifdef CONFIG_MODULES
> >
> >  static struct maple_tree mod_area_mt =3D MTREE_INIT(mod_area_mt, MT_FL=
AGS_ALLOC_RANGE);
> > -static struct vm_struct *vm_module_tags;
> >  /* A dummy object used to indicate an unloaded module */
> >  static struct module unloaded_mod;
> >  /* A dummy object used to indicate a module prepended area */
> > @@ -391,6 +390,9 @@ static bool find_aligned_area(struct ma_state *mas,=
 unsigned long section_size,
> >       return false;
> >  }
> >
> > +#ifdef CONFIG_MMU
> > +static struct vm_struct *vm_module_tags;
> > +
> >  static int vm_module_tags_populate(void)
> >  {
> >       unsigned long phys_size =3D vm_module_tags->nr_pages << PAGE_SHIF=
T;
> > @@ -417,6 +419,13 @@ static int vm_module_tags_populate(void)
> >
> >       return 0;
> >  }
> > +#else
> > +static int vm_module_tags_populate(void)
> > +{
> > +     /* Memory was already allocated */
> > +     return 0;
> > +}
> > +#endif
> >
> >  static void *reserve_module_tags(struct module *mod, unsigned long siz=
e,
> >                                unsigned int prepend, unsigned long alig=
n)
> > @@ -561,6 +570,7 @@ static void replace_module(struct module *mod, stru=
ct module *new_mod)
> >
> >  static int __init alloc_mod_tags_mem(void)
> >  {
> > +#ifdef CONFIG_MMU
> >       /* Map space to copy allocation tags */
> >       vm_module_tags =3D execmem_vmap(MODULE_ALLOC_TAG_VMAP_SIZE);
> >       if (!vm_module_tags) {
> > @@ -578,6 +588,13 @@ static int __init alloc_mod_tags_mem(void)
> >       }
> >
> >       module_tags.start_addr =3D (unsigned long)vm_module_tags->addr;
> > +#else
> > +     /* Allocate space to copy allocation tags */
> > +     module_tags.start_addr =3D (unsigned long)execmem_alloc(EXECMEM_M=
ODULE_DATA,
> > +                                                           MODULE_ALLO=
C_TAG_VMAP_SIZE);
> > +     if (!module_tags.start_addr)
> > +             return -ENOMEM;
> > +#endif
> >       module_tags.end_addr =3D module_tags.start_addr + MODULE_ALLOC_TA=
G_VMAP_SIZE;
> >       /* Ensure the base is alloc_tag aligned when required for indexin=
g */
> >       module_tags.start_addr =3D alloc_tag_align(module_tags.start_addr=
);
> > @@ -587,6 +604,7 @@ static int __init alloc_mod_tags_mem(void)
> >
> >  static void __init free_mod_tags_mem(void)
> >  {
> > +#ifdef CONFIG_MMU
> >       int i;
> >
> >       module_tags.start_addr =3D 0;
> > @@ -594,6 +612,9 @@ static void __init free_mod_tags_mem(void)
> >               __free_page(vm_module_tags->pages[i]);
> >       kfree(vm_module_tags->pages);
> >       free_vm_area(vm_module_tags);
> > +#else
> > +     execmem_free((void *)module_tags.start_addr);
> > +#endif
> >  }
> >
> >  #else /* CONFIG_MODULES */
> > diff --git a/mm/execmem.c b/mm/execmem.c
> > index 5c0f9f2d6f83..317b6a8d35be 100644
> > --- a/mm/execmem.c
> > +++ b/mm/execmem.c
> > @@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_range *r=
ange, size_t size,
> >
> >       return p;
> >  }
> > +
> > +struct vm_struct *execmem_vmap(size_t size)
> > +{
> > +     struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_MOD=
ULE_DATA];
> > +     struct vm_struct *area;
> > +
> > +     area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIFT, V=
M_ALLOC,
> > +                               range->start, range->end, NUMA_NO_NODE,
> > +                               GFP_KERNEL, __builtin_return_address(0)=
);
> > +     if (!area && range->fallback_start)
> > +             area =3D __get_vm_area_node(size, range->alignment, PAGE_=
SHIFT, VM_ALLOC,
> > +                                       range->fallback_start, range->f=
allback_end,
> > +                                       NUMA_NO_NODE, GFP_KERNEL, __bui=
ltin_return_address(0));
> > +
> > +     return area;
> > +}
> >  #else
> >  static void *execmem_vmalloc(struct execmem_range *range, size_t size,
> >                            pgprot_t pgprot, unsigned long vm_flags)
> > @@ -368,22 +384,6 @@ void execmem_free(void *ptr)
> >               vfree(ptr);
> >  }
> >
> > -struct vm_struct *execmem_vmap(size_t size)
> > -{
> > -     struct execmem_range *range =3D &execmem_info->ranges[EXECMEM_MOD=
ULE_DATA];
> > -     struct vm_struct *area;
> > -
> > -     area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIFT, V=
M_ALLOC,
> > -                               range->start, range->end, NUMA_NO_NODE,
> > -                               GFP_KERNEL, __builtin_return_address(0)=
);
> > -     if (!area && range->fallback_start)
> > -             area =3D __get_vm_area_node(size, range->alignment, PAGE_=
SHIFT, VM_ALLOC,
> > -                                       range->fallback_start, range->f=
allback_end,
> > -                                       NUMA_NO_NODE, GFP_KERNEL, __bui=
ltin_return_address(0));
> > -
> > -     return area;
> > -}
> > -
> >  void *execmem_update_copy(void *dst, const void *src, size_t size)
> >  {
> >       return text_poke_copy(dst, src, size);
> >
> > base-commit: 92409df3e00a17d6fd5bb27732fa186749725ed5
> > --
> > 2.47.0.163.g1226f6d8fa-goog
> >
>
> --
> Sincerely yours,
> Mike.


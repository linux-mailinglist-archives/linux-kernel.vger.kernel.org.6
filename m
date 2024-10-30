Return-Path: <linux-kernel+bounces-389741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB329B70A0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 00:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09A97B21835
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F327217446;
	Wed, 30 Oct 2024 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jU6CgxNO"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF030215034
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730331765; cv=none; b=o3uXDAdcrCiW8TWO7re+8yYoKqL+4tCfrHnBly0lgSMAPxMVmxeQLqN5HvLkfPm4aLkkfx7ZpL39NUCBSELBqfl9kY3d2a7ElC5Hw048I6GloR+j0UWjr2i0RWxDAIGCUkyisjs9zfZRefv9Yg9fyZOkSbhVIjuPqJ5DlakCN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730331765; c=relaxed/simple;
	bh=RCZCQod2BuVZ//h2EkjZzRJg4OvyITeplM2O6XXzW9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAeieKA7JUoSuWj2PfmG4z9LpMVL4vs0LfQmFYRSGgmQj3Ep9zRaUwrxwx6DCa5qRXvvJ8fAvxNbCj53zRjzKFUmqS4LRNLHNsLp9a/KhVHPeeeD2zk5KGFK7OMW6zq3pF0I8e28NZtUWTz4gUhmcv1Q3xa+XqpKW1KQkngK6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jU6CgxNO; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460a8d1a9b7so69811cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730331761; x=1730936561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2aDKBjnJKpMpnGRXsZpDPEBKe9sKnnzwhleKkdKArc=;
        b=jU6CgxNOn9hodpCMm4vDMrj8p0FxhgTtevNNsMHd2UxUkuCoJMXNkd1moTGV6DX/Z3
         vky1HtfJLKv/01iVoHPfL+S6R44J2cKpM03Eqo2URyYfmjIqgNjw4SAUIUNqFfXWhX93
         a2BXVmjLLLbdARe3nQsVOA5CDO16LVHrGsM3neYBESEyg1K9iBtdMXdDX+LC2/xSJIRU
         tUj7vBkew8VvFOqLWm1DhhYGQldsD+L12abwGfUS0wgjKUMFQHY8UYfYSr+0IdPFh3NL
         qerErSXs7wNWkqejSTqcHU46Ec+HJ33PPST/Lmdi38fdJ6rf9Je/XkuCDcLgvjRNzDlP
         VCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730331761; x=1730936561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2aDKBjnJKpMpnGRXsZpDPEBKe9sKnnzwhleKkdKArc=;
        b=hgYTFwAlgidZeaItU1mAc+tG2V2cMTf9B7NOCxQg7x0UCglwXHqJ4OAH8YO+rKiWg3
         EiyHFYP0monAxk54X+CC+Ge75iviuv1wIt1sfrTPZfCKTAAinMIsbh+UTq0QBf2XErBt
         gZNuYnKFwwPrxJSYqtFzaibtpzh88nXna1x+bwN1WeLGGWxNl6UBUtN2fhFT2yK9qgYH
         4Uyn3TFbhjuRj7YpQ1IJnpIO20+WRcCNN6hOCpt+0cN3tFn0z8Mun+PphwGcuDsIxlWq
         U9d3ca2c9hjbyrYMFPJTh5G+IEQg7IAewEGWrJX3eTqjo5IOhX1ZVi5rhQi6yiSYPwQN
         PWnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGnex3wz8R/iUZFUo6g8hBOXmlAuCsSZ9lOpT6g4jz3yuK+Ag0i79lKFaQq9oip2bWtb/ycK2AtyB5W84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsiukvdDB+yleYplvNHoNxdMI1Ogz6rxBxStubO18ckdmaV5cY
	mCbTPfEJFrziYjC4bAv/gsjY20CLgcmIE1MLZrkRkk5tINH4glu/lnQQy4F/poeiDnmGWy6Pg/6
	A5pDUCeJGHai5X7TfTw0t96JjjWU6OJmb5Gi9
X-Gm-Gg: ASbGncvBHynEMJM8GFtfdQwbYxngnFvItWyfoEy0YXtVjC7HfYKLZeM0bUsixD+ldmC
	lplbIQT9byO0AjZ/7ct1rwg/vnCLr56Q6LMvP8i2Etb3EFv3YR8KAnbDvd41B
X-Google-Smtp-Source: AGHT+IFjyYRNzlHVeVeoBdnf9ro1pwJwW6jft94IlHTeeLIgPte6YKRb4BJSO3ylacTRcQWIyngd+f83hBiYQisDOdY=
X-Received: by 2002:a05:622a:286:b0:461:70cc:3799 with SMTP id
 d75a77b69052e-462ad1feb31mr643521cf.21.1730331761193; Wed, 30 Oct 2024
 16:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028202935.1047017-1-surenb@google.com> <ZyEWsZVfNKTnRTum@kernel.org>
 <CAJuCfpHVgfTMTSNyvGmufjkOLPoz5onw8LujXmA-wZS9nwEikQ@mail.gmail.com> <ZyIp1FFFFPul4105@kernel.org>
In-Reply-To: <ZyIp1FFFFPul4105@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 30 Oct 2024 16:42:28 -0700
Message-ID: <CAJuCfpEYtHyVznG73B1dGB-8epJ6vxKt41aA0hzn6P5JwQBNCA@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: avoid execmem_vmap() when !MMU
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, arnd@kernel.org, arnd@arndb.de, 
	pasha.tatashin@soleen.com, mcgrof@kernel.org, song@kernel.org, 
	mhiramat@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 5:46=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Tue, Oct 29, 2024 at 01:03:51PM -0700, Suren Baghdasaryan wrote:
> > On Tue, Oct 29, 2024 at 10:13=E2=80=AFAM Mike Rapoport <rppt@kernel.org=
> wrote:
> > >
> > > Hi Suren,
> > >
> > > On Mon, Oct 28, 2024 at 01:29:35PM -0700, Suren Baghdasaryan wrote:
> > > > With CONFIG_MMU=3Dn __get_vm_area_node() is not available and memor=
y for the
> > > > allocation tags cannot be populated as needed. For this case, popul=
ate the
> > > > required memory at initialization time.
> > >
> > > Do we care that much to have alloc_tags on !MMU configs?
> > >
> > > Your patch is great, but it would have been a lot easier to make
> > > MEM_ALLOC_PROFILING depend on MMU.
> >
> > I didn't want to prevent !MMU users from using allocation profiling
> > but I'm not aware of any current !MMU users. Therefore I have no
> > objections to making MEM_ALLOC_PROFILING dependent on MMU if we indeed
> > don't care about !MMU && MEM_ALLOC_PROFILING configuration.
> > I'll be posting v5 tomorrow with all these fixes, so please let me
> > know which way you prefer. Thanks!
>
> I think if nommu users would want that feature, we can add the ifdefery
> later

Sounds good. I'll add the dependency and simplify this fix in my next posti=
ng.
Thanks!

>
> > > > Fixes: 57bc3834fb6f ("alloc_tag: populate memory for module tags as=
 needed")
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202410250808.dQGyYjlk=
-lkp@intel.com/
> > > > Closes: https://lore.kernel.org/oe-lkp/202410251525.9f85854d-oliver=
.sang@intel.com
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202410261016.IO7C6Cml=
-lkp@intel.com/
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202410270919.LebQlmxD=
-lkp@intel.com/
> > > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > > Cc: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >  include/linux/execmem.h |  2 ++
> > > >  lib/alloc_tag.c         | 23 ++++++++++++++++++++++-
> > > >  mm/execmem.c            | 32 ++++++++++++++++----------------
> > > >  3 files changed, 40 insertions(+), 17 deletions(-)
> > > >
> > > > diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> > > > index 5a5e2917f870..64130ae19690 100644
> > > > --- a/include/linux/execmem.h
> > > > +++ b/include/linux/execmem.h
> > > > @@ -139,6 +139,7 @@ void *execmem_alloc(enum execmem_type type, siz=
e_t size);
> > > >   */
> > > >  void execmem_free(void *ptr);
> > > >
> > > > +#ifdef CONFIG_MMU
> > > >  /**
> > > >   * execmem_vmap - create virtual mapping for EXECMEM_MODULE_DATA m=
emory
> > > >   * @size: size of the virtual mapping in bytes
> > > > @@ -148,6 +149,7 @@ void execmem_free(void *ptr);
> > > >   * Return: the area descriptor on success or %NULL on failure.
> > > >   */
> > > >  struct vm_struct *execmem_vmap(size_t size);
> > > > +#endif
> > > >
> > > >  /**
> > > >   * execmem_update_copy - copy an update to executable memory
> > > > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > > > index c1ddac2d29f0..1c74942e6dfd 100644
> > > > --- a/lib/alloc_tag.c
> > > > +++ b/lib/alloc_tag.c
> > > > @@ -268,7 +268,6 @@ void __init alloc_tag_sec_init(void)
> > > >  #ifdef CONFIG_MODULES
> > > >
> > > >  static struct maple_tree mod_area_mt =3D MTREE_INIT(mod_area_mt, M=
T_FLAGS_ALLOC_RANGE);
> > > > -static struct vm_struct *vm_module_tags;
> > > >  /* A dummy object used to indicate an unloaded module */
> > > >  static struct module unloaded_mod;
> > > >  /* A dummy object used to indicate a module prepended area */
> > > > @@ -391,6 +390,9 @@ static bool find_aligned_area(struct ma_state *=
mas, unsigned long section_size,
> > > >       return false;
> > > >  }
> > > >
> > > > +#ifdef CONFIG_MMU
> > > > +static struct vm_struct *vm_module_tags;
> > > > +
> > > >  static int vm_module_tags_populate(void)
> > > >  {
> > > >       unsigned long phys_size =3D vm_module_tags->nr_pages << PAGE_=
SHIFT;
> > > > @@ -417,6 +419,13 @@ static int vm_module_tags_populate(void)
> > > >
> > > >       return 0;
> > > >  }
> > > > +#else
> > > > +static int vm_module_tags_populate(void)
> > > > +{
> > > > +     /* Memory was already allocated */
> > > > +     return 0;
> > > > +}
> > > > +#endif
> > > >
> > > >  static void *reserve_module_tags(struct module *mod, unsigned long=
 size,
> > > >                                unsigned int prepend, unsigned long =
align)
> > > > @@ -561,6 +570,7 @@ static void replace_module(struct module *mod, =
struct module *new_mod)
> > > >
> > > >  static int __init alloc_mod_tags_mem(void)
> > > >  {
> > > > +#ifdef CONFIG_MMU
> > > >       /* Map space to copy allocation tags */
> > > >       vm_module_tags =3D execmem_vmap(MODULE_ALLOC_TAG_VMAP_SIZE);
> > > >       if (!vm_module_tags) {
> > > > @@ -578,6 +588,13 @@ static int __init alloc_mod_tags_mem(void)
> > > >       }
> > > >
> > > >       module_tags.start_addr =3D (unsigned long)vm_module_tags->add=
r;
> > > > +#else
> > > > +     /* Allocate space to copy allocation tags */
> > > > +     module_tags.start_addr =3D (unsigned long)execmem_alloc(EXECM=
EM_MODULE_DATA,
> > > > +                                                           MODULE_=
ALLOC_TAG_VMAP_SIZE);
> > > > +     if (!module_tags.start_addr)
> > > > +             return -ENOMEM;
> > > > +#endif
> > > >       module_tags.end_addr =3D module_tags.start_addr + MODULE_ALLO=
C_TAG_VMAP_SIZE;
> > > >       /* Ensure the base is alloc_tag aligned when required for ind=
exing */
> > > >       module_tags.start_addr =3D alloc_tag_align(module_tags.start_=
addr);
> > > > @@ -587,6 +604,7 @@ static int __init alloc_mod_tags_mem(void)
> > > >
> > > >  static void __init free_mod_tags_mem(void)
> > > >  {
> > > > +#ifdef CONFIG_MMU
> > > >       int i;
> > > >
> > > >       module_tags.start_addr =3D 0;
> > > > @@ -594,6 +612,9 @@ static void __init free_mod_tags_mem(void)
> > > >               __free_page(vm_module_tags->pages[i]);
> > > >       kfree(vm_module_tags->pages);
> > > >       free_vm_area(vm_module_tags);
> > > > +#else
> > > > +     execmem_free((void *)module_tags.start_addr);
> > > > +#endif
> > > >  }
> > > >
> > > >  #else /* CONFIG_MODULES */
> > > > diff --git a/mm/execmem.c b/mm/execmem.c
> > > > index 5c0f9f2d6f83..317b6a8d35be 100644
> > > > --- a/mm/execmem.c
> > > > +++ b/mm/execmem.c
> > > > @@ -64,6 +64,22 @@ static void *execmem_vmalloc(struct execmem_rang=
e *range, size_t size,
> > > >
> > > >       return p;
> > > >  }
> > > > +
> > > > +struct vm_struct *execmem_vmap(size_t size)
> > > > +{
> > > > +     struct execmem_range *range =3D &execmem_info->ranges[EXECMEM=
_MODULE_DATA];
> > > > +     struct vm_struct *area;
> > > > +
> > > > +     area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIF=
T, VM_ALLOC,
> > > > +                               range->start, range->end, NUMA_NO_N=
ODE,
> > > > +                               GFP_KERNEL, __builtin_return_addres=
s(0));
> > > > +     if (!area && range->fallback_start)
> > > > +             area =3D __get_vm_area_node(size, range->alignment, P=
AGE_SHIFT, VM_ALLOC,
> > > > +                                       range->fallback_start, rang=
e->fallback_end,
> > > > +                                       NUMA_NO_NODE, GFP_KERNEL, _=
_builtin_return_address(0));
> > > > +
> > > > +     return area;
> > > > +}
> > > >  #else
> > > >  static void *execmem_vmalloc(struct execmem_range *range, size_t s=
ize,
> > > >                            pgprot_t pgprot, unsigned long vm_flags)
> > > > @@ -368,22 +384,6 @@ void execmem_free(void *ptr)
> > > >               vfree(ptr);
> > > >  }
> > > >
> > > > -struct vm_struct *execmem_vmap(size_t size)
> > > > -{
> > > > -     struct execmem_range *range =3D &execmem_info->ranges[EXECMEM=
_MODULE_DATA];
> > > > -     struct vm_struct *area;
> > > > -
> > > > -     area =3D __get_vm_area_node(size, range->alignment, PAGE_SHIF=
T, VM_ALLOC,
> > > > -                               range->start, range->end, NUMA_NO_N=
ODE,
> > > > -                               GFP_KERNEL, __builtin_return_addres=
s(0));
> > > > -     if (!area && range->fallback_start)
> > > > -             area =3D __get_vm_area_node(size, range->alignment, P=
AGE_SHIFT, VM_ALLOC,
> > > > -                                       range->fallback_start, rang=
e->fallback_end,
> > > > -                                       NUMA_NO_NODE, GFP_KERNEL, _=
_builtin_return_address(0));
> > > > -
> > > > -     return area;
> > > > -}
> > > > -
> > > >  void *execmem_update_copy(void *dst, const void *src, size_t size)
> > > >  {
> > > >       return text_poke_copy(dst, src, size);
> > > >
> > > > base-commit: 92409df3e00a17d6fd5bb27732fa186749725ed5
> > > > --
> > > > 2.47.0.163.g1226f6d8fa-goog
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.


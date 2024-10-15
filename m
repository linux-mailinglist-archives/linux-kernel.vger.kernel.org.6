Return-Path: <linux-kernel+bounces-366042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C799F011
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A9E281791
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6239E1C4A3A;
	Tue, 15 Oct 2024 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9rJmJot"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5C1C4A1D
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729003769; cv=none; b=AUBy9JaWnH9dKeOmSPDH9S8jstL1SqZYb24+TDm2/bfxwY91PC/m1F3W0pSEyOSGITRkMDkWCemC18Lr1EkyLNUREeUtWPhw4+oAKGe0Ck+dFfbwVCN2MnJtqVgc13xhvG11EgPTzkeuB8rSNPN5NpaZS7xQs7gcpIa1CfHJvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729003769; c=relaxed/simple;
	bh=ZhV7zbthHbMIewHCp0h03ho7/B/ftgyEQCYUwBDxG48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B5YAzOxi6GSg5Jdo5SOgiuYoAATM/YMG1ojRbaWWnJ7vqkSxzhKkvN+Ftp3xdokp/G/Vn8NNopqd9JauwVsM87z7OYakTNQm+GB9grn6t3U32TNn4BCOWvnwlCbD8GTXcZgavyUCMrbG6owGJUJqHByWrEp4DPj0qZ8lY8h7RGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R9rJmJot; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460395fb1acso755831cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729003767; x=1729608567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGfVMDlLn1825g+J14Hy1oDH1uXbeKzHCn9d9Ylz3+Q=;
        b=R9rJmJotcW+NqJe7rdt22hFUwXQVpBu+kK1elW1pgpaUQ3uNCLDHpABZBP0lK/o23d
         ObUGqW+oxoCM6Dbd8qIcklJPhBPLM28QQRdLP0dl68u+E21OL/CTDsucfbQCF5zPcTCE
         Ldy8ipOsory0FjDf00OqBSWKi5hQZvUczqqJ5QEE7r055Ayhj5vFy6PE5WgLW/A/M04o
         o/+NuZWvaFPkPUwTgBAdJpmlASeTrWJz85aN0gpUXxr6DSDLcRptbityC1/q2Y56pt+g
         GVMfuSFLJjksH73h4OW6FdEQJM84ehbRObN8o8sfQ9CazKF1Wn/g9v+q4YNFCuEA0QSE
         QwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729003767; x=1729608567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGfVMDlLn1825g+J14Hy1oDH1uXbeKzHCn9d9Ylz3+Q=;
        b=hpZuuJgv5mYRhnDajGKGOpTR5GaCj0iM190vdeporkeKW+vdAatwPUmWnVdeayImge
         JBZpybQItrnmgd8IVSDU2XsNPwSmp8EyOkNbPvu3lH6P+ZWYL02FvXUVPtp63BnlkiJ9
         TjH3laZcq365+6FzPUwl5JMpuCMZPWr3edfunvN+4JwnOUWYl5M0OfOfa7clrNVX8o9k
         tyiRIRPQaUsYIvtNU1vcpbQKQ6TmaQ2tO/Xy556es0XVxkUElps9LTX1udeOKHWofGTK
         eC4JvaaL6m4seilCdIkJ8NWSGC3DgSUKhJ1cwTh2pTPWqkyQHNgt3hHbqpIkdgiwOlRy
         epSA==
X-Forwarded-Encrypted: i=1; AJvYcCWaLKRLURgSdJylIqsQx190ptlG3ndGnZGw4Wwy6SRkVzA6tsfViOK+dL3f5s4KBNQTiOt4ds0xAdcXwRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV05ysqVXFYI5uhCDEJ6Wi0JWNAjFhjselw40zbnnEHjQ63SHD
	7VxjFCPhPyUNNtcMpkDC88McK2qBF36fxyrCK8QFPDqAi12ExR0uYG+nEraNSmdddUf91FjN6K8
	iM1btjKTFZSkH5iiu8j4sg+XDm6eEXSlc/rls
X-Google-Smtp-Source: AGHT+IHyqoTyx/YlQBvl8SRkssyjUIklgUBoWFJuAmw8xTcFULp90DIWTR4dOeGeR2G47cVqTZdstcTSZdSOnU18ol8=
X-Received: by 2002:a05:622a:820c:b0:45d:8d1f:c505 with SMTP id
 d75a77b69052e-46059c43f44mr7776181cf.15.1729003766319; Tue, 15 Oct 2024
 07:49:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014203646.1952505-1-surenb@google.com> <20241014203646.1952505-4-surenb@google.com>
 <Zw5c3zjW4sUUmont@kernel.org>
In-Reply-To: <Zw5c3zjW4sUUmont@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 15 Oct 2024 07:49:13 -0700
Message-ID: <CAJuCfpGymAAoyeWHgg_4vGX3DhRwLVa+Ueegs0DUCQ8+Wf6ChQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] alloc_tag: populate memory for module tags as needed
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, yuzhao@google.com, vvvvvv@google.com, 
	rostedt@goodmis.org, iamjoonsoo.kim@lge.com, rientjes@google.com, 
	minchan@google.com, kaleshsingh@google.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 5:19=E2=80=AFAM 'Mike Rapoport' via kernel-team
<kernel-team@android.com> wrote:
>
> On Mon, Oct 14, 2024 at 01:36:44PM -0700, Suren Baghdasaryan wrote:
> > The memory reserved for module tags does not need to be backed by
> > physical pages until there are tags to store there. Change the way
> > we reserve this memory to allocate only virtual area for the tags
> > and populate it with physical pages as needed when we load a module.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/execmem.h | 11 ++++++
> >  include/linux/vmalloc.h |  9 +++++
> >  lib/alloc_tag.c         | 84 +++++++++++++++++++++++++++++++++--------
> >  mm/execmem.c            | 16 ++++++++
> >  mm/vmalloc.c            |  4 +-
> >  5 files changed, 106 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/execmem.h b/include/linux/execmem.h
> > index 7436aa547818..a159a073270a 100644
> > --- a/include/linux/execmem.h
> > +++ b/include/linux/execmem.h
> > @@ -127,6 +127,17 @@ void *execmem_alloc(enum execmem_type type, size_t=
 size);
> >   */
> >  void execmem_free(void *ptr);
> >
> > +/**
> > + * execmem_vmap - create virtual mapping for executable memory
> > + * @type: type of the allocation
> > + * @size: size of the virtual mapping in bytes
> > + *
> > + * Maps virtually contiguous area that can be populated with executabl=
e code.
> > + *
> > + * Return: the area descriptor on success or %NULL on failure.
> > + */
> > +struct vm_struct *execmem_vmap(enum execmem_type type, size_t size);
> > +
>
> I think it's better limit it to EXECMEM_MODULE_DATA

Ack.

>
> >  /**
> >   * execmem_update_copy - copy an update to executable memory
> >   * @dst:  destination address to update
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 9a012cd4fad2..9d64cc6f24d1 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -202,6 +202,9 @@ extern int remap_vmalloc_range_partial(struct vm_ar=
ea_struct *vma,
> >  extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
> >                                                       unsigned long pgo=
ff);
> >
> > +int vmap_pages_range(unsigned long addr, unsigned long end,
> > +             pgprot_t prot, struct page **pages, unsigned int page_shi=
ft);
> > +
> >
> >  /*
> >   * Architectures can set this mask to a combination of PGTBL_P?D_MODIF=
IED values
> >   * and let generic vmalloc and ioremap code know when arch_sync_kernel=
_mappings()
> > @@ -239,6 +242,12 @@ extern struct vm_struct *__get_vm_area_caller(unsi=
gned long size,
> >                                       unsigned long flags,
> >                                       unsigned long start, unsigned lon=
g end,
> >                                       const void *caller);
> > +struct vm_struct *__get_vm_area_node(unsigned long size,
> > +                                  unsigned long align, unsigned long s=
hift,
> > +                                  unsigned long flags, unsigned long s=
tart,
> > +                                  unsigned long end, int node, gfp_t g=
fp_mask,
> > +                                  const void *caller);
> > +
>
> This is not used outside mm/, let's put it into mm/internal.h

Ack.

>
> >  void free_vm_area(struct vm_struct *area);
> >  extern struct vm_struct *remove_vm_area(const void *addr);
> >  extern struct vm_struct *find_vm_area(const void *addr);
> > diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> > index b10e7f17eeda..648f32d52b8d 100644
> > --- a/lib/alloc_tag.c
> > +++ b/lib/alloc_tag.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/proc_fs.h>
> >  #include <linux/seq_buf.h>
> >  #include <linux/seq_file.h>
> > +#include <linux/vmalloc.h>
> >
> >  static struct codetag_type *alloc_tag_cttype;
> >
> > @@ -153,6 +154,7 @@ static void __init procfs_init(void)
> >  #ifdef CONFIG_MODULES
> >
> >  static struct maple_tree mod_area_mt =3D MTREE_INIT(mod_area_mt, MT_FL=
AGS_ALLOC_RANGE);
> > +static struct vm_struct *vm_module_tags;
> >  /* A dummy object used to indicate an unloaded module */
> >  static struct module unloaded_mod;
> >  /* A dummy object used to indicate a module prepended area */
> > @@ -195,6 +197,25 @@ static void clean_unused_module_areas_locked(void)
> >       }
> >  }
> >
> > +static int vm_module_tags_grow(unsigned long addr, unsigned long bytes=
)
> > +{
> > +     struct page **next_page =3D vm_module_tags->pages + vm_module_tag=
s->nr_pages;
> > +     unsigned long more_pages =3D ALIGN(bytes, PAGE_SIZE) >> PAGE_SHIF=
T;
> > +     unsigned long nr;
> > +
> > +     nr =3D alloc_pages_bulk_array_node(GFP_KERNEL | __GFP_NOWARN,
> > +                                      NUMA_NO_NODE, more_pages, next_p=
age);
> > +     if (nr !=3D more_pages)
> > +             return -ENOMEM;
> > +
> > +     vm_module_tags->nr_pages +=3D nr;
> > +     if (vmap_pages_range(addr, addr + (nr << PAGE_SHIFT),
> > +                          PAGE_KERNEL, next_page, PAGE_SHIFT) < 0)
> > +             return -ENOMEM;
> > +
> > +     return 0;
> > +}
> > +
> >  static void *reserve_module_tags(struct module *mod, unsigned long siz=
e,
> >                                unsigned int prepend, unsigned long alig=
n)
> >  {
> > @@ -202,7 +223,7 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
> >       MA_STATE(mas, &mod_area_mt, 0, section_size - 1);
> >       bool cleanup_done =3D false;
> >       unsigned long offset;
> > -     void *ret;
> > +     void *ret =3D NULL;
> >
> >       /* If no tags return NULL */
> >       if (size < sizeof(struct alloc_tag))
> > @@ -239,7 +260,7 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
> >               goto repeat;
> >       } else {
> >               ret =3D ERR_PTR(-ENOMEM);
> > -             goto out;
> > +             goto unlock;
> >       }
> >
> >  found:
> > @@ -254,7 +275,7 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
> >               mas_store(&mas, &prepend_mod);
> >               if (mas_is_err(&mas)) {
> >                       ret =3D ERR_PTR(xa_err(mas.node));
> > -                     goto out;
> > +                     goto unlock;
> >               }
> >               mas.index =3D offset;
> >               mas.last =3D offset + size - 1;
> > @@ -263,7 +284,7 @@ static void *reserve_module_tags(struct module *mod=
, unsigned long size,
> >                       ret =3D ERR_PTR(xa_err(mas.node));
> >                       mas.index =3D pad_start;
> >                       mas_erase(&mas);
> > -                     goto out;
> > +                     goto unlock;
> >               }
> >
> >       } else {
> > @@ -271,18 +292,33 @@ static void *reserve_module_tags(struct module *m=
od, unsigned long size,
> >               mas_store(&mas, mod);
> >               if (mas_is_err(&mas)) {
> >                       ret =3D ERR_PTR(xa_err(mas.node));
> > -                     goto out;
> > +                     goto unlock;
> >               }
> >       }
> > +unlock:
> > +     mas_unlock(&mas);
> > +     if (IS_ERR(ret))
> > +             return ret;
> >
> > -     if (module_tags.size < offset + size)
> > -             module_tags.size =3D offset + size;
> > +     if (module_tags.size < offset + size) {
> > +             unsigned long phys_size =3D vm_module_tags->nr_pages << P=
AGE_SHIFT;
> >
> > -     ret =3D (struct alloc_tag *)(module_tags.start_addr + offset);
> > -out:
> > -     mas_unlock(&mas);
> > +             module_tags.size =3D offset + size;
> > +             if (phys_size < module_tags.size) {
> > +                     int grow_res;
> > +
> > +                     grow_res =3D vm_module_tags_grow(module_tags.star=
t_addr + phys_size,
> > +                                                    module_tags.size -=
 phys_size);
> > +                     if (grow_res) {
> > +                             static_branch_disable(&mem_alloc_profilin=
g_key);
> > +                             pr_warn("Failed to allocate tags memory f=
or module %s. Memory profiling is disabled!\n",
> > +                                     mod->name);
> > +                             return ERR_PTR(grow_res);
> > +                     }
> > +             }
> > +     }
>
> The diff for reserve_module_tags() is hard to read, and the function itse=
lf
> becomes really complex to follow with all the gotos back and forth.
> Maybe it's possible to split out some parts of it as helpers?

Got it. Will refactor this function to make it easier to review.

Thanks for the prompt review, Mike!

>
> > -     return ret;
> > +     return (struct alloc_tag *)(module_tags.start_addr + offset);
> >  }
> >
>
> --
> Sincerely yours,
> Mike.
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>


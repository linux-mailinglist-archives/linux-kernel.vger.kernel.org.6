Return-Path: <linux-kernel+bounces-406216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF8E9C5F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324A0B327E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624892022E0;
	Tue, 12 Nov 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NqePmODn"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236D2003D1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426331; cv=none; b=JOyZN9Mlqt55bY3DugNNzLgV6JIzGCzDuzL7YDmAASn5pXWu/DhHBfJ6InX8G7P+TalGaL0E2Km699r8r3L5xO0XmSGFkHK4nl3Hz84orEcWKDyuFwD3B6cGwT3aOsahfqFtM0deeWPCWZqvEXECY5Fwf6EZWyvU7lZldlL50r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426331; c=relaxed/simple;
	bh=JoJn0kWkrBvLHCNGdd/jBKtVGGQDbYIlRzmWn/4fDHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/yqMOB7P/GrrIEt82Fyq8OF41FDk5YSn35G9DPB+j7DPA4DzF19FxRMj+vyQ+sRUvxstMHYindJsmjC3nh+YGry2dfV6AwbwdASJ+vn67NGrvZArbc5NPfXjYdP3NdnBKq4hinJqbBIZqszBzBPCeMWLpV8hrtSyRhEHj+5T0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NqePmODn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460969c49f2so313561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731426329; x=1732031129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LC0oAB3hsBtzyot9DwM7yE0bq5av8B40/ay1VJm5kIY=;
        b=NqePmODn6oQbKBB8GTg7I6rIeCZVPqRXjy46nMLkc/bLgrNm8aqLrBzaJd4qzxXgpP
         Ee4QRoN63ngmPvWRrwUMjntiuIEU0kvxrfMBTdbqgMpgixsr60jaPeqmD814p0Tdo0J7
         m7m64EMQEi9/YrDjOb3TtiuKQa2oRb8lg4Apcu26adMI6/37Un1aqWAHiSCG7G0kbNzw
         KQ05bi7xhR0pmE2J2VMSAJuSmpyivTlZazMvcP3aJcGP00pmtANahCXL4jzzeMEEy3dj
         IPdNpyOYz1Xc96bRTcLRzMJSqjLckB/0WmGklcDf80RPr8pbQYC0liuXGeKRPiuLBmHq
         vuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426329; x=1732031129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LC0oAB3hsBtzyot9DwM7yE0bq5av8B40/ay1VJm5kIY=;
        b=u0P/7F9VMNW6xt+2ZSnd3iotXXONNl8aRunkmvI3SJ1bBg7rGyvg7FmoZHQIC07VAR
         ageTuOJgfwijhd8eRFOGFJXKncF1dHDdrD169BnxoIMcJW69cWeV8Equo8KTHRygUut9
         a25z28cP5UUaVndgIu6F/Wyya2i5RAJCBB9Iir6oH2j59N6oZbqz2Jk9vsGDcyQLxPAO
         g0crHQHztyTPn1X/FbZFTrNhT5+DyBSLDoOyTZ6YBt0Dzczb9IrX+Bp9ASOcbL396yrD
         48zHKQ8Biv8XoCHzjv0IMiyRiKC8+LcSjEZtZj1DTLqwEWH1RMYulFvbegcBMyuIGfto
         mdqg==
X-Forwarded-Encrypted: i=1; AJvYcCXThrDt3QCw/L8kY2ySDezNgX64fNkF6pTZnFANd8sF1yRCBmnOKZPg+6faq4LvgLoWHUafYo+VGsGQl6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvtRxFVY3nTBm8ZwL+c7Wi9NV6+wBXZokGYCBfVPnSdq8Habm
	0RqWrNSyYZ7T2UAa/H8qJ/tIKkpDxBEfmJQa3USGygFXRgpNl7o9oolmIvLuPSMAgGTOqINEbiJ
	ddEEnRfRbZbT8wHd1Bn0BzF4Ss1qLPceuoYib
X-Gm-Gg: ASbGncu2seexs1gESpKcGwdu9HRWO84FrRf2bqWgbMH4DRBpb+jTdDj1dvDc98cxpX7
	2o7HU50jV9rMrObBSA7nTsuadA/Zx7sL8rF4Igq7e/o4yRETWcUHODR6Zfpjt3Q==
X-Google-Smtp-Source: AGHT+IHITYhV1PsQizhz8Y+qiNc1Fv3ooQCiIBNrErc3MxHIp7FJycJEqDOHsW5Ie2/I+HtgciMvWSgYDyi1lwxy5Cc=
X-Received: by 2002:a05:622a:4b0f:b0:460:b4e3:49e with SMTP id
 d75a77b69052e-4634288b366mr2509591cf.9.1731426328226; Tue, 12 Nov 2024
 07:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <20241111205506.3404479-5-surenb@google.com>
 <fdb2bd2e-eaac-482b-bf32-641f9df7a5fc@suse.cz>
In-Reply-To: <fdb2bd2e-eaac-482b-bf32-641f9df7a5fc@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 12 Nov 2024 07:45:17 -0800
Message-ID: <CAJuCfpHpqfk-WUKOH0v_5bFasxqhACRCKdYCoTW791zNUMQ6+g@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: move lesser used vma_area_struct members into the
 last cacheline
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, hannes@cmpxchg.org, 
	mjguzik@gmail.com, oliver.sang@intel.com, mgorman@techsingularity.net, 
	david@redhat.com, peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, 
	paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, 
	hughd@google.com, minchan@google.com, jannh@google.com, 
	shakeel.butt@linux.dev, souravpanda@google.com, pasha.tatashin@soleen.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 2:07=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/11/24 21:55, Suren Baghdasaryan wrote:
> > Move several vma_area_struct members which are rarely or never used
> > during page fault handling into the last cacheline to better pack
> > vm_area_struct. As a result vm_area_struct will fit into 3 cachelines
> > as opposed to 4 cachelines before this change. New vm_area_struct layou=
t:
> >
> > struct vm_area_struct {
> >       union {
> >               struct {
> >                       long unsigned int vm_start;      /*     0     8 *=
/
> >                       long unsigned int vm_end;        /*     8     8 *=
/
> >               };                                       /*     0    16 *=
/
> >               struct callback_head vm_rcu ;            /*     0    16 *=
/
> >       } __attribute__((__aligned__(8)));               /*     0    16 *=
/
> >       struct mm_struct *         vm_mm;                /*    16     8 *=
/
> >       pgprot_t                   vm_page_prot;         /*    24     8 *=
/
> >       union {
> >               const vm_flags_t   vm_flags;             /*    32     8 *=
/
> >               vm_flags_t         __vm_flags;           /*    32     8 *=
/
> >       };                                               /*    32     8 *=
/
> >       bool                       detached;             /*    40     1 *=
/
> >
> >       /* XXX 3 bytes hole, try to pack */
> >
> >       unsigned int               vm_lock_seq;          /*    44     4 *=
/
> >       struct list_head           anon_vma_chain;       /*    48    16 *=
/
> >       /* --- cacheline 1 boundary (64 bytes) --- */
> >       struct anon_vma *          anon_vma;             /*    64     8 *=
/
> >       const struct vm_operations_struct  * vm_ops;     /*    72     8 *=
/
> >       long unsigned int          vm_pgoff;             /*    80     8 *=
/
> >       struct file *              vm_file;              /*    88     8 *=
/
> >       void *                     vm_private_data;      /*    96     8 *=
/
> >       atomic_long_t              swap_readahead_info;  /*   104     8 *=
/
> >       struct mempolicy *         vm_policy;            /*   112     8 *=
/
> >
> >       /* XXX 8 bytes hole, try to pack */
> >
> >       /* --- cacheline 2 boundary (128 bytes) --- */
> >       struct vma_lock       vm_lock (__aligned__(64)); /*   128     4 *=
/
> >
> >       /* XXX 4 bytes hole, try to pack */
> >
> >       struct {
> >               struct rb_node     rb (__aligned__(8));  /*   136    24 *=
/
> >               long unsigned int  rb_subtree_last;      /*   160     8 *=
/
> >       } __attribute__((__aligned__(8))) shared;        /*   136    32 *=
/
> >       struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0 *=
/
>
> I don't see anon_name in the output, I thought it was added for Android? =
:)

Yes, this output is generated with defconfig. That's why you see some
holes in this structure. On my x86 machine I have non-zero
vm_userfaultfd_ctx and numab_state, on Android I have
vm_userfaultfd_ctx and anon_name.

>
> >
> >       /* size: 192, cachelines: 3, members: 17 */
> >       /* sum members: 153, holes: 3, sum holes: 15 */
> >       /* padding: 24 */
>
> Instead you seem to have padding so an attempt to use SLAB_TYPESAFE_BY_RC=
U
> should use that and not add more up to 256 pages.

Yes, thanks for the tip about SLAB_TYPESAFE_BY_RCU freelist. In actual
configurations where I saw SLAB_TYPESAFE_BY_RCU causing this structure
to grow I had less padding at the end.

> Perhaps this pahole output wasn't generated with a fully representative c=
onfig?

You are right. I'll replace it with the actual output from my x86
setup (Android probably has a smaller interested audience).

>
> >       /* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
> > } __attribute__((__aligned__(64)));
> >
> >
> > Memory consumption per 1000 VMAs becomes 48 pages:
> >
> >     slabinfo after vm_area_struct changes:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    192   42    2 : ...
> >
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  include/linux/mm_types.h | 37 ++++++++++++++++++-------------------
> >  1 file changed, 18 insertions(+), 19 deletions(-)
> >
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 789bccc05520..c3755b680911 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -733,16 +733,6 @@ struct vm_area_struct {
> >       unsigned int vm_lock_seq;
> >  #endif
> >
> > -     /*
> > -      * For areas with an address space and backing store,
> > -      * linkage into the address_space->i_mmap interval tree.
> > -      *
> > -      */
> > -     struct {
> > -             struct rb_node rb;
> > -             unsigned long rb_subtree_last;
> > -     } shared;
> > -
> >       /*
> >        * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
> >        * list, after a COW of one of the file pages.  A MAP_SHARED vma
> > @@ -762,14 +752,6 @@ struct vm_area_struct {
> >       struct file * vm_file;          /* File we map to (can be NULL). =
*/
> >       void * vm_private_data;         /* was vm_pte (shared mem) */
> >
> > -#ifdef CONFIG_ANON_VMA_NAME
> > -     /*
> > -      * For private and shared anonymous mappings, a pointer to a null
> > -      * terminated string containing the name given to the vma, or NUL=
L if
> > -      * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
> > -      */
> > -     struct anon_vma_name *anon_name;
> > -#endif
> >  #ifdef CONFIG_SWAP
> >       atomic_long_t swap_readahead_info;
> >  #endif
> > @@ -782,11 +764,28 @@ struct vm_area_struct {
> >  #ifdef CONFIG_NUMA_BALANCING
> >       struct vma_numab_state *numab_state;    /* NUMA Balancing state *=
/
> >  #endif
> > -     struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> >  #ifdef CONFIG_PER_VMA_LOCK
> >       /* Unstable RCU readers are allowed to read this. */
> >       struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> >  #endif
> > +     /*
> > +      * For areas with an address space and backing store,
> > +      * linkage into the address_space->i_mmap interval tree.
> > +      *
> > +      */
> > +     struct {
> > +             struct rb_node rb;
> > +             unsigned long rb_subtree_last;
> > +     } shared;
> > +#ifdef CONFIG_ANON_VMA_NAME
> > +     /*
> > +      * For private and shared anonymous mappings, a pointer to a null
> > +      * terminated string containing the name given to the vma, or NUL=
L if
> > +      * unnamed. Serialized by mmap_lock. Use anon_vma_name to access.
> > +      */
> > +     struct anon_vma_name *anon_name;
> > +#endif
> > +     struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> >  } __randomize_layout;
> >
> >  #ifdef CONFIG_NUMA
>


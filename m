Return-Path: <linux-kernel+bounces-418817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4329D65DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5206282952
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88ED18C33A;
	Fri, 22 Nov 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyCRRyr3"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7678176FD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315431; cv=none; b=rBhz9l6AdhVQJQmpHIM9rKGl3FoaKC7lMauY/UDxrjBQq+YtWNdI334Tg/I8Dvg25irsYxZcif5y1gYKI3Qh2ZBqfGk7T+w6pzEi/MY5dLQPpFjodsDD65zY7Is0MF3ALK5V96WFeSxRVYkHmygOtrGAbwRoOvDIKWnq8btdY0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315431; c=relaxed/simple;
	bh=lqYVRUzCRXOYJL1sSEZW/Z88jOYbq8aQSd8shbMACzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUg7zaTg5wnGmx8pA2I0/5ebfkpkk7xX3k2hCdBSHwxDVrkwQ/zEN4bxz7bXC2RtKU4CLlkWDENXn/vskPJ+Vgibo9ImwU/cGath7P4YK38pFS+Q7kvZUbbaCoWpYyfbXN5mgSvu31COqgLHzWfgd7Ue673tO3bKc1hYuKRwWio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyCRRyr3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-460a8d1a9b7so25201cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732315428; x=1732920228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHORz47FiSIR9q+W9ZVN0yQsYQ1UBFTTA/DlKq9Xp9g=;
        b=nyCRRyr3XWU64ifabsNfHZodQ0LJh71vDdkK2dHTYr9OM+pkbMS1FhlzrUUMeVYOOM
         LulhcUSWqtYqeYbmEi+AR9DdIuNTDtTY5tQHAkaTO2YlxKXzoIK9caktAF0kxxLHMvTr
         pF9pYEZygXUWz7V3TynBlzwyiCQfWLRoHwjqlU6Gxmv7nDypStulpMfJAuPQT6Bzd3cM
         oIK68gPTytee+yYNbLS83QRhuIcWPU46uZCS7jFP8sv3lnr1rTvBIDRSuVA8/GUZPnPD
         9XNXXkDbFmepMRQuCnN+0FoiWxkuIEr+86iaWqtpT7iQCudons9W5k5GBB7V+gXQw/YQ
         Gzrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315428; x=1732920228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHORz47FiSIR9q+W9ZVN0yQsYQ1UBFTTA/DlKq9Xp9g=;
        b=bBXWOfpz7VPvqdobNfIOGYRugBzS2tW4FpqzwFf1BbpxDSGzAyHuRmyQw2muQjoz8o
         gx9IN+GHv/Rb3EINWdeQwmsNGDXvcGs6MCDX2iqzemmYhufkHcHl8VC6xrJXcQfb8G9Z
         eTEcHT1N+sym5YaBMdVXEOG5pV1psBA7pJjToj6WTs2U+DrEB7gRIJGGezSza7fFXb/S
         UzVd3dP6ARiBA9m+AgADmTDvnTYV/o+RJ+LlJCS2RlDi8LyHFQqncGzeB2MrY7wGNz5Z
         gaYsgFsHy9tXgszsjwGxL543saGVztS7cIuHxHfa1dqhxqjbZaHShzfcZjb8elVjiekb
         gXvg==
X-Forwarded-Encrypted: i=1; AJvYcCWWn5xc38d1lZbOTJoE8SroW05U/wnJTc3t3AigdR/+2+8WeqJdQP+DB2CzrKPqCEiw1hiH4WlJjhd8YTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP31LumWQAZwgCBmMnRsywbivXvA4zGglHHEQwrgR9D7jAHm+B
	eN/iXCkUtTikB8ATlDgS+L6Ju64WdDiJCO5GRBoUkHeJO3EwYvOaRWkZK4IhBWDiVFuqkEANcut
	/zCfi/tSWDRs20DKBw9esC9JQksAvRH+ivPpO
X-Gm-Gg: ASbGncvG0w1CebO4hwtfEU2Wt//73pkYu3LFjhNbULLU4PhR1CO8g8Yy2QA3bSVEsvJ
	PtyUT+Ndq0/w/hRfCg61RI9X/ibv4s9Q=
X-Google-Smtp-Source: AGHT+IEFX7LWkW1c39d4ISGOpA0oNTEkNboBSr8vIIy/woFz0x8Q9YCXC3T5nxjXIL6abvvQKd+D6KUVCI48zqhhqtY=
X-Received: by 2002:a05:622a:8c6:b0:460:b4e3:49e with SMTP id
 d75a77b69052e-46673dacb95mr259451cf.9.1732315428171; Fri, 22 Nov 2024
 14:43:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120000826.335387-1-surenb@google.com> <20241120000826.335387-5-surenb@google.com>
 <Zz1nRyMnIaCa0TL5@casper.infradead.org> <CAJuCfpFO3Hj+7f10e0Pnvf0U7-dHeYgvjK+4AFD8V=kmG4JA=w@mail.gmail.com>
In-Reply-To: <CAJuCfpFO3Hj+7f10e0Pnvf0U7-dHeYgvjK+4AFD8V=kmG4JA=w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 22 Nov 2024 14:43:37 -0800
Message-ID: <CAJuCfpEuLR8a2jrV4pUQL7emzjSrFa5JHC75PCBdLWRSL0SmmQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: make vma cache SLAB_TYPESAFE_BY_RCU
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, liam.howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, mhocko@suse.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com, 
	mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, minchan@google.com, 
	jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 10:37=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Nov 19, 2024 at 8:36=E2=80=AFPM Matthew Wilcox <willy@infradead.o=
rg> wrote:
> >
> > On Tue, Nov 19, 2024 at 04:08:25PM -0800, Suren Baghdasaryan wrote:
> > > +static inline void vma_clear(struct vm_area_struct *vma)
> > > +{
> > > +     /* Preserve vma->vm_lock */
> > > +     memset(vma, 0, VMA_BEFORE_LOCK);
> > > +     memset(VMA_LOCK_END(vma), 0, VMA_AFTER_LOCK);
> > > +}
> >
> > This isn't how you're supposed to handle constructors.  You've fixed
> > the immediate problem rather than writing the code in the intended styl=
e.
>
> Yeah, I don't like this myself but the only alternative I can think of
> is to set the struct members individually.
>
> >
> > > +static void vm_area_ctor(void *data)
> > > +{
> > > +     vma_lock_init(data);
> > > +}
> >
> > After the ctor has run, the object should be in the same state as
> > it is after it's freed.  If you want to memset the entire thing
> > then you can do it in the ctor.  But there should be no need to
> > do it in vma_init().
>
> IIUC, your suggestion is to memset() the vma and initialize vm_lock
> inside the ctor. Then when it's time to free the vma, we reset all
> members except vm_lock before freeing the vma. As you mention later,
> members like anon_vma_chain, which are already clear, also won't need
> to be reset at this point. Am I understanding your proposal correctly?
>
> BTW, if so, then vma_copy() will have to also copy vma members individual=
ly.
>
> >
> > And there's lots of things you can move from vma_init() to the ctor.
> > For example, at free time, anon_vma_chain should be an empty list.
> > So if you init it in the ctor, you can avoid doing it in vma_init().
>
> True.
>
> > I'd suggest that vma_numab_state_free() should be the place which
> > sets vma->numab_state to NULL and we can delete vma_numab_state_init()
> > entirely.
>
> Sounds good to me.

I took a stab at it and the result does not look pretty...
Couple notes:
- vma_init() is used in other places to initialize VMAs allocated on
the stack, so I left it alone for such cases. VMAs like that are not
allocated from vm_area_cachep, can't be reused anyway, therefore we
can override their vm_lock.
- Since vma_init() has to stay, we can't retire vma_numab_state_init()
because it's used in vma_init().
- I think resetting members before freeing might not be such a good
idea because after resetting the object might not be reused at all.

Now, the main point:
I moved initializations of several members into ctor but even with
that the code looks roughly like this:

static void vm_area_ctor(void *data)
{
    struct vm_area_struct *vma =3D (struct vm_area_struct *)data;

    vma->detached =3D true;
    INIT_LIST_HEAD(&vma->anon_vma_chain);
    vma_lock_init(vma);
}

struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
{
    struct vm_area_struct *vma;

    vma =3D kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
    if (!vma)
        return NULL;

    vma->vm_mm =3D mm;
    vma->vm_ops =3D &vma_dummy_vm_ops;
    vma->vm_start =3D 0;
    vma->vm_end =3D 0;
    memset(&vma->vm_page_prot, 0, sizeof(vma->vm_page_prot));
    vm_flags_init(vma, 0);
    vma_numab_state_init(vma);
    memset(&vma->shared, 0, sizeof(vma->shared));
    vma->anon_vma =3D NULL;
    vma->vm_pgoff =3D 0;
    vma->vm_file =3D NULL;
    vma->vm_private_data =3D NULL;
    memset(&vma->vm_userfaultfd_ctx, 0, sizeof(vma->vm_userfaultfd_ctx));
#ifdef CONFIG_ANON_VMA_NAME
    vma->anon_name =3D NULL;
#endif
#ifdef CONFIG_SWAP
    atomic_long_set(&vma->swap_readahead_info, 0);
#endif
#ifndef CONFIG_MMU
    vma->vm_region =3D NULL;
#endif
#ifdef CONFIG_NUMA
    vma->vm_policy =3D NULL;
#endif
#ifdef CONFIG_NUMA_BALANCING
    vma->numab_state =3D NULL;
#endif
    return vma;
}

I can of course add helper functions and get rid of the #ifdef's but still.=
..

Matthew, want to double check if this looks like the solution you were
proposing or am I completely off the target?

>
> Please confirm if I correctly got your idea and I'll update this patch.
> Thanks for the feedback!
>
> >


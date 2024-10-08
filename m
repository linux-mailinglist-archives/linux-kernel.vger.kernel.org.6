Return-Path: <linux-kernel+bounces-355720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D1D995608
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BAFB1C23A85
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3113620CCDA;
	Tue,  8 Oct 2024 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrVBL4er"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF31E0E0D
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409931; cv=none; b=YuxcDVW2YpAkq7W/wBK5aGDGxfjfXN7mxtHwoTI8ARrZrtLxMduFAAe7lLDUdO0cFMSuhSffz9g+OLTRcZG3NYIn+/F5NC095itBQtwuGdW8OUwMmt3zT8UkMj1IbvUyNt2zL8BY+IoGMenKxjAP7eunwLmW/vVK5PMHR+ifqSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409931; c=relaxed/simple;
	bh=eQpo9KOyLQD0SDyuvBt2E00xVmlbiE7mIi1Xs4NeDlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnknGuIM7rVM9ijwy/C5ClZIasKCqmyN5vIOFjEPH/gW3CFIIDvjJJT3h/YbslMLthIAAFs1/Il2QjBa0YzLCAn4iDrHBUaU2XUnCjPBnAH3m8QDnOE/QS0gCdnpSDDkQ+9xedSISQnbpfIux3P74S3LAUj7lOMItws18H3NJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrVBL4er; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4582a5b495cso23891cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728409928; x=1729014728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bYdSo/JSRjS9IGPMXSaJSzGPxeAQS0+usN1NkUtDUk=;
        b=GrVBL4erRgGRE4FYv7A5fHcwWVhggd0Tdyq8qkyOa1SiaAIyGtmIYSfkpT5fzzLUPC
         xfJ0vldbilOHm+xzwEyIKKAtsLPPOVyRLtWC623f1hcFgdMUyEhDj/kwytyc7+NDxKJS
         viwZc2x6cxa3yZyO8qEqcRHvb6DFLpRD7GuCHB0UWJ9IJI7MNsptH0eqhkjWjRqCttl0
         BdC0bEDsP0+uNSbZlf+ATM+1C0lSGPXB26U/aAHdNBXynCCp+OLL/ehZ/RFklXlshfU/
         Uief088DeKRn4Czgm4I4F8tgZMgDV2q4q3BPH3d3TtaJqkrk9bTEr1f+vikFIi9Fkz76
         RlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728409928; x=1729014728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bYdSo/JSRjS9IGPMXSaJSzGPxeAQS0+usN1NkUtDUk=;
        b=Bd5dySNkBhZANo8mxff8BjEslXfOAXM4AmyjXUfW4wiAcrvs36HZBtEwuguR2ss3EF
         uX9vVdb/ZEuwPXjRWk8J8w9eOVPS7okf+nn/E3mvpMnPR56RpzJkF3fFuo64Wo9Ykc3c
         US2kHhZZJ6+t8XWnub6HbpHJ789H7hJomqIdoVHdpt2iN6A+rhDLL4qVv2UuM3Pj5d6s
         xeFT4VsQ3dXzdYCure5c2Ei2rSM8zNkXYVRw4W5+OtbZP3ZyxHLCc79OScrr1ihnhJ5R
         VwQ4o0JQW0b5kicp+SPIoShI0a2X1tJKZA+/Vt31vwXikjmPiwTnx3Zusc+8VlNpXzJ5
         2P7g==
X-Forwarded-Encrypted: i=1; AJvYcCUu5nPPOz/tbuquuHXa9/CxfRX+7sI6GelCZC+vVIaz1eAr3cBb0mFr3p+xELpICsJeAVCuSfoSKAu1h/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI75wznznhGNrIL4M+814qU82tfPkjZbabNnaWG5h413pzArOT
	AUcg+6OLGG4Gsvh/y9zN8yVkoaAnvSBxyY2sTGARiRe6RdRxUDi/xWAoqygrEx7SpSJolZECHXm
	YKUqncggdKkqijEKEvMB/6kNqzMOg2M64zHQy
X-Google-Smtp-Source: AGHT+IFQIWs+lkw3S2POV4bbdPyWnNXIWluyz0TnAFQ7Q8jb5ITvNTC7yJSYO0ISx/jyccQ6Pgi/igF+FWjc5M+Rmsw=
X-Received: by 2002:a05:622a:2987:b0:45d:8da8:63de with SMTP id
 d75a77b69052e-45ec7e1fd73mr3559321cf.17.1728409928196; Tue, 08 Oct 2024
 10:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com> <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
 <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
 <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com>
 <btu3mxc7qn33vux2jtzewuavth7ziq4xb6nudiu5kf7bs3bejm@e7btayqaavzh> <CAG48ez0e4Zv3g2uHGzhrCmJcE2XE=160HxyNy4YAhEfQKKFNBw@mail.gmail.com>
In-Reply-To: <CAG48ez0e4Zv3g2uHGzhrCmJcE2XE=160HxyNy4YAhEfQKKFNBw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Oct 2024 10:51:57 -0700
Message-ID: <CAJuCfpE2+n_jd233-B_h8jfi+1ia2-KRCrnvSvvUaQehgUOJjg@mail.gmail.com>
Subject: Re: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing
 vma tree in mmap_region()
To: Jann Horn <jannh@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Linux-MM <linux-mm@kvack.org>, 
	kernel list <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 10:16=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Oct 8, 2024 at 3:51=E2=80=AFAM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> > * Jann Horn <jannh@google.com> [241007 17:31]:
> > > On Mon, Oct 7, 2024 at 10:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > > * Jann Horn <jannh@google.com> [241007 15:06]:
> > > > > On Fri, Aug 30, 2024 at 6:00=E2=80=AFAM Liam R. Howlett <Liam.How=
lett@oracle.com> wrote:
> > > > > > Instead of zeroing the vma tree and then overwriting the area, =
let the
> > > > > > area be overwritten and then clean up the gathered vmas using
> > > > > > vms_complete_munmap_vmas().
> > > > > >
> > > > > > To ensure locking is downgraded correctly, the mm is set regard=
less of
> > > > > > MAP_FIXED or not (NULL vma).
> > > > > >
> > > > > > If a driver is mapping over an existing vma, then clear the pte=
s before
> > > > > > the call_mmap() invocation.  This is done using the vms_clean_u=
p_area()
> > > > > > helper.  If there is a close vm_ops, that must also be called t=
o ensure
> > > > > > any cleanup is done before mapping over the area.  This also me=
ans that
> > > > > > calling open has been added to the abort of an unmap operation,=
 for now.
> > > > >
> > > > > As currently implemented, this is not a valid optimization becaus=
e it
> > > > > violates the (unwritten?) rule that you must not call free_pgd_ra=
nge()
> > > > > on a region in the page tables which can concurrently be walked. =
A
> > > > > region in the page tables can be concurrently walked if it overla=
ps a
> > > > > VMA which is linked into rmaps which are not write-locked.
> > > >
> > > > Just for clarity, this is the rmap write lock.
> > >
> > > Ah, yes.
> > >
> > > > > On Linux 6.12-rc2, when you mmap(MAP_FIXED) over an existing VMA,=
 and
> > > > > the new mapping is created by expanding an adjacent VMA, the foll=
owing
> > > > > race with an ftruncate() is possible (because page tables for the=
 old
> > > > > mapping are removed while the new VMA in the same location is alr=
eady
> > > > > fully set up and linked into the rmap):
> > > > >
> > > > >
> > > > > task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > mmap_region
> > > > >   vma_merge_new_range
> > > > >     vma_expand
> > > > >       commit_merge
> > > > >         vma_prepare
> > > > >           [take rmap locks]
> > > > >         vma_set_range
> > > > >           [expand adjacent mapping]
> > > > >         vma_complete
> > > > >           [drop rmap locks]
> > > > >   vms_complete_munmap_vmas
> > > > >     vms_clear_ptes
> > > > >       unmap_vmas
> > > > >         [removes ptes]
> > > > >       free_pgtables
> > > > >         [unlinks old vma from rmap]
> > > > >                              unmap_mapping_range
> > > > >                                unmap_mapping_pages
> > > > >                                  i_mmap_lock_read
> > > > >                                  unmap_mapping_range_tree
> > > > >                                    [loop]
> > > > >                                      unmap_mapping_range_vma
> > > > >                                        zap_page_range_single
> > > > >                                          unmap_single_vma
> > > > >                                            unmap_page_range
> > > > >                                              zap_p4d_range
> > > > >                                                zap_pud_range
> > > > >                                                  zap_pmd_range
> > > > >                                                    [looks up pmd =
entry]
> > > > >         free_pgd_range
> > > > >           [frees pmd]
> > > > >                                                    [UAF pmd entry=
 access]
> > > > >
> > > > > To reproduce this, apply the attached mmap-vs-truncate-racewiden.=
diff
> > > > > to widen the race windows, then build and run the attached reprod=
ucer
> > > > > mmap-fixed-race.c.
> > > > >
> > > > > Under a kernel with KASAN, you should ideally get a KASAN splat l=
ike this:
> > > >
> > > > Thanks for all the work you did finding the root cause here, I
> > > > appreciate it.
> > >
> > > Ah, this is not a bug I ran into while testing, it's a bug I found
> > > while reading the patch. It's much easier to explain the issue and
> > > come up with a nice reproducer this way than when you start out from =
a
> > > crash. :P
> > >
> > > > I think the correct fix is to take the rmap lock on free_pgtables, =
when
> > > > necessary.  There are a few code paths (error recovery) that are no=
t
> > > > regularly run that will also need to change.
> > >
> > > Hmm, yes, I guess that might work. Though I think there might be more
> > > races: One related aspect of this optimization that is unintuitive to
> > > me is that, directly after vma_merge_new_range(), a concurrent rmap
> > > walk could probably be walking the newly-extended VMA but still
> > > observe PTEs belonging to the previous VMA. I don't know how robust
> > > the various rmap walks are to things like encountering pfnmap PTEs in
> > > non-pfnmap VMAs, or hugetlb PUD entries in non-hugetlb VMAs. For
> > > example, page_vma_mapped_walk() looks like, if you called it on a pag=
e
> > > table range with huge PUD entries, but with a VMA without VM_HUGETLB,
> > > something might go wrong on the "pmd_offset(pud, pvmw->address)" call=
,
> > > and a 1G hugepage might get misinterpreted as a page table? But I
> > > haven't experimentally verified that.
> >
> > Yes, I am also concerned that reacquiring the lock will result in
> > another race.  I also don't think holding the lock for longer is a good
> > idea as it will most likely cause a regression by extending the lock fo=
r
> > the duration of the mmap() setup.  Although, maybe it would be fine if
> > we only keep it held if we are going to be removing a vma in the
> > MAP_FIXED case.
>
> I guess you could have a separate seqcount on the mm for "there might
> be temporary holes in the tree", or temporarily store some markers in
> the maple tree that say "there is nothing here right now, but if you
> want to see a full picture while iterating, you have to try again
> later"?
>
> Or you could basically unmap the VMA while it is still in the VMA tree
> but is already locked and marked as detached? So first you do
> unmap_vmas() and free_pgtables() (which clears the PTEs, removes the
> rmap links, and deletes page tables), then prepare the new VMAs, and
> then replace the old VMA's entries in the VMA tree with the new
> entries? I guess in the end the result would semantically be pretty
> similar to having markers in the maple tree.
>
> > Another idea would be to change the pte to know if a vma is being
> > modified using the per-vma locking, but I'm not sure what action to tak=
e
> > if we detect the vma is being modified to avoid the issue.  This would
> > also need to be done to all walkers (or low enough in the stack).
>
> Sorry, can you clarify what pte the "change the pte" is referring to?
>
> > By the way, this isn't an optimisation; this is to fix RCU walkers of
> > the vma tree seeing a hole between the underlying implementation of the
> > MAP_FIXED operations of munmap() and mmap().  This is needed for things
> > like the /proc/{pid}/maps rcu walker.  The page tables currently fall
> > back to the old way of locking if a hole is seen (and sane applications
> > shouldn't really be page faulting something being removed anyways..)
>
> Is that code in a tree somewhere?
>
> What locking will those RCU walkers use when accessing VMAs? I guess
> they probably anyway have to take the VMA locks to ensure they see
> consistent state, though I guess with enough effort you could avoid it
> (seqlock-style) on some fastpaths when the vma is not concurrently
> modified and the fastpath doesn't need access to the VMA's file?

Sorry, it's not posted upstream yet but yes, the idea is to walk the
tree under RCU and detect concurrent changes using seq-counters. A
prototype was posted here:
https://lore.kernel.org/all/20240123231014.3801041-3-surenb@google.com/
but it had some issues I'm yet to resolve.


Return-Path: <linux-kernel+bounces-355662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A93D7995571
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 19:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EED1F23302
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 17:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB541F4733;
	Tue,  8 Oct 2024 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/++cayE"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0011F130A
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728407791; cv=none; b=Rf5s/k7j896SM/NX4H3e4bvUZXeoCyRotu4xq5tDa504ny6LKVxKtPsL6a9r0aFFIVN1TB3uciEAzmguaPmeOlWeFzOta8hD6RsVoZ2K6LYIzAo66vT9FH31WKkFSICSSzg3mrI/wj3ppOeiHluz8fKNrvwQ7zVp8nIVpe86p6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728407791; c=relaxed/simple;
	bh=9qf5NUulCrLSD/yqyPv1D1IBlhOoRbIG2d6f2Hh9fyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=b7bHIN0Nmp42WfJrjOTemlTmXCGGoAjD019Ikal0U/RLLeW07c3p8Td6Mzl7kVS7fc3o6nekmVZmGz/tUNrZ/BD9gjfJC2oc0odcbnjWoI0u0kqeQ1Kws+0qMUPVeRD4l8AfWtT90uZmCef7G0O/lvRYa3kGc/MihQXxP8/qmQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/++cayE; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cbe8ec7dbso13905e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728407788; x=1729012588; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3CoJCnfswniqK7qx+TratnaWjUJJp9uH5BS3/WaBlI=;
        b=f/++cayE6X09ywKxj5DVj+7u6/QWPzjaULXHqhrjnuKTsy6Kcg2L48ftOqk3+bxUPr
         BINHz7Kum3rJWw1l5UwjKyTOtZZ6WWhuv9/tjsSsFZa8gHsoYQbeMTaatbsvARF1sKmn
         OyaDx7gfeKk8Ft8qeJjvs83ehb0KLkVfghrwjniBe9gsoHqRJtPm1aNUy2WTRFwZN5rm
         YKu24smFbSfjwRwj07MF8LSl+xmAEyoauAAt10woq9vXzF+g93y9+XBOU+AhhihQGmZx
         JWXb2enA2vsuV+0dndcqrze040fiUboydCTIeYdZnkhDdbVMdMaXb61LqDbVx/GWRpgw
         wUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728407788; x=1729012588;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3CoJCnfswniqK7qx+TratnaWjUJJp9uH5BS3/WaBlI=;
        b=CUU3F9VHdw0zkhdpVGjboCgUOfQdRueqvrZwj3aR15G7rFMoSfgdLt6yXuiZU6tbFh
         wcImC6vpl024xaBLvXYXZ387iuAf8DT3sQbXcr0GBC5LtWLtHF0ni2+HgHq7XI6UrFGT
         SnE3uSyvkjbUQAuB9AqGjo28itfXtrRyGa+/DMNdl1wjLhPCyAAHTY7wvJD8qpJhWTR8
         daORGCUJb5GJZJIhoJbxfrDG2Pv/waX9uRp7b751Ro9hV4QKhqu70U7+Qnta+SUGyU/J
         mT3b+Dm8ypEnIYiMRfldfnSgZzVXr+cyVkpvFUQj0WKGtlBbYXmjKS0OqXwZj9iYaNPh
         T8sA==
X-Forwarded-Encrypted: i=1; AJvYcCVNjMMGtxe7gf3Y/oVhksak1UXkCXh6FFoOz9MapbYjKdRwZwUkt7oCb45AIElCpDayOgI2ciLvX1i9VKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YymBx9n507PBMSenV8/XxYweAuSmWTCWyAXLeW4BQhM/y/ADmF3
	nPcmDx0GEpO2V58zfDsu1yxbohkv0CVpuFFYkBdcWZtvo5UVqXvMzM2ht0UjKEpzwmvQe13KGmf
	F4ajuuX4AeVKu7fMOYO0IVSU2T19DrVJz2ggX
X-Google-Smtp-Source: AGHT+IHr2RF6cZFrfSwR7EDwttJeVayvORqnmuF3I7SltQ7iJPxazCBWXlG6smm3DSypxHyuyQfQRrtmNfggRpIN14E=
X-Received: by 2002:a05:600c:1d85:b0:42b:8ff7:bee2 with SMTP id
 5b1f17b1804b1-4303de8bd79mr5095065e9.5.1728407787489; Tue, 08 Oct 2024
 10:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com> <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
 <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
 <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com> <btu3mxc7qn33vux2jtzewuavth7ziq4xb6nudiu5kf7bs3bejm@e7btayqaavzh>
In-Reply-To: <btu3mxc7qn33vux2jtzewuavth7ziq4xb6nudiu5kf7bs3bejm@e7btayqaavzh>
From: Jann Horn <jannh@google.com>
Date: Tue, 8 Oct 2024 19:15:49 +0200
Message-ID: <CAG48ez0e4Zv3g2uHGzhrCmJcE2XE=160HxyNy4YAhEfQKKFNBw@mail.gmail.com>
Subject: Re: [BUG] page table UAF, Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing
 vma tree in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Linux-MM <linux-mm@kvack.org>, kernel list <linux-kernel@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	Seth Jenkins <sethjenkins@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:51=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
> * Jann Horn <jannh@google.com> [241007 17:31]:
> > On Mon, Oct 7, 2024 at 10:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > * Jann Horn <jannh@google.com> [241007 15:06]:
> > > > On Fri, Aug 30, 2024 at 6:00=E2=80=AFAM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > > Instead of zeroing the vma tree and then overwriting the area, le=
t the
> > > > > area be overwritten and then clean up the gathered vmas using
> > > > > vms_complete_munmap_vmas().
> > > > >
> > > > > To ensure locking is downgraded correctly, the mm is set regardle=
ss of
> > > > > MAP_FIXED or not (NULL vma).
> > > > >
> > > > > If a driver is mapping over an existing vma, then clear the ptes =
before
> > > > > the call_mmap() invocation.  This is done using the vms_clean_up_=
area()
> > > > > helper.  If there is a close vm_ops, that must also be called to =
ensure
> > > > > any cleanup is done before mapping over the area.  This also mean=
s that
> > > > > calling open has been added to the abort of an unmap operation, f=
or now.
> > > >
> > > > As currently implemented, this is not a valid optimization because =
it
> > > > violates the (unwritten?) rule that you must not call free_pgd_rang=
e()
> > > > on a region in the page tables which can concurrently be walked. A
> > > > region in the page tables can be concurrently walked if it overlaps=
 a
> > > > VMA which is linked into rmaps which are not write-locked.
> > >
> > > Just for clarity, this is the rmap write lock.
> >
> > Ah, yes.
> >
> > > > On Linux 6.12-rc2, when you mmap(MAP_FIXED) over an existing VMA, a=
nd
> > > > the new mapping is created by expanding an adjacent VMA, the follow=
ing
> > > > race with an ftruncate() is possible (because page tables for the o=
ld
> > > > mapping are removed while the new VMA in the same location is alrea=
dy
> > > > fully set up and linked into the rmap):
> > > >
> > > >
> > > > task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > mmap_region
> > > >   vma_merge_new_range
> > > >     vma_expand
> > > >       commit_merge
> > > >         vma_prepare
> > > >           [take rmap locks]
> > > >         vma_set_range
> > > >           [expand adjacent mapping]
> > > >         vma_complete
> > > >           [drop rmap locks]
> > > >   vms_complete_munmap_vmas
> > > >     vms_clear_ptes
> > > >       unmap_vmas
> > > >         [removes ptes]
> > > >       free_pgtables
> > > >         [unlinks old vma from rmap]
> > > >                              unmap_mapping_range
> > > >                                unmap_mapping_pages
> > > >                                  i_mmap_lock_read
> > > >                                  unmap_mapping_range_tree
> > > >                                    [loop]
> > > >                                      unmap_mapping_range_vma
> > > >                                        zap_page_range_single
> > > >                                          unmap_single_vma
> > > >                                            unmap_page_range
> > > >                                              zap_p4d_range
> > > >                                                zap_pud_range
> > > >                                                  zap_pmd_range
> > > >                                                    [looks up pmd en=
try]
> > > >         free_pgd_range
> > > >           [frees pmd]
> > > >                                                    [UAF pmd entry a=
ccess]
> > > >
> > > > To reproduce this, apply the attached mmap-vs-truncate-racewiden.di=
ff
> > > > to widen the race windows, then build and run the attached reproduc=
er
> > > > mmap-fixed-race.c.
> > > >
> > > > Under a kernel with KASAN, you should ideally get a KASAN splat lik=
e this:
> > >
> > > Thanks for all the work you did finding the root cause here, I
> > > appreciate it.
> >
> > Ah, this is not a bug I ran into while testing, it's a bug I found
> > while reading the patch. It's much easier to explain the issue and
> > come up with a nice reproducer this way than when you start out from a
> > crash. :P
> >
> > > I think the correct fix is to take the rmap lock on free_pgtables, wh=
en
> > > necessary.  There are a few code paths (error recovery) that are not
> > > regularly run that will also need to change.
> >
> > Hmm, yes, I guess that might work. Though I think there might be more
> > races: One related aspect of this optimization that is unintuitive to
> > me is that, directly after vma_merge_new_range(), a concurrent rmap
> > walk could probably be walking the newly-extended VMA but still
> > observe PTEs belonging to the previous VMA. I don't know how robust
> > the various rmap walks are to things like encountering pfnmap PTEs in
> > non-pfnmap VMAs, or hugetlb PUD entries in non-hugetlb VMAs. For
> > example, page_vma_mapped_walk() looks like, if you called it on a page
> > table range with huge PUD entries, but with a VMA without VM_HUGETLB,
> > something might go wrong on the "pmd_offset(pud, pvmw->address)" call,
> > and a 1G hugepage might get misinterpreted as a page table? But I
> > haven't experimentally verified that.
>
> Yes, I am also concerned that reacquiring the lock will result in
> another race.  I also don't think holding the lock for longer is a good
> idea as it will most likely cause a regression by extending the lock for
> the duration of the mmap() setup.  Although, maybe it would be fine if
> we only keep it held if we are going to be removing a vma in the
> MAP_FIXED case.

I guess you could have a separate seqcount on the mm for "there might
be temporary holes in the tree", or temporarily store some markers in
the maple tree that say "there is nothing here right now, but if you
want to see a full picture while iterating, you have to try again
later"?

Or you could basically unmap the VMA while it is still in the VMA tree
but is already locked and marked as detached? So first you do
unmap_vmas() and free_pgtables() (which clears the PTEs, removes the
rmap links, and deletes page tables), then prepare the new VMAs, and
then replace the old VMA's entries in the VMA tree with the new
entries? I guess in the end the result would semantically be pretty
similar to having markers in the maple tree.

> Another idea would be to change the pte to know if a vma is being
> modified using the per-vma locking, but I'm not sure what action to take
> if we detect the vma is being modified to avoid the issue.  This would
> also need to be done to all walkers (or low enough in the stack).

Sorry, can you clarify what pte the "change the pte" is referring to?

> By the way, this isn't an optimisation; this is to fix RCU walkers of
> the vma tree seeing a hole between the underlying implementation of the
> MAP_FIXED operations of munmap() and mmap().  This is needed for things
> like the /proc/{pid}/maps rcu walker.  The page tables currently fall
> back to the old way of locking if a hole is seen (and sane applications
> shouldn't really be page faulting something being removed anyways..)

Is that code in a tree somewhere?

What locking will those RCU walkers use when accessing VMAs? I guess
they probably anyway have to take the VMA locks to ensure they see
consistent state, though I guess with enough effort you could avoid it
(seqlock-style) on some fastpaths when the vma is not concurrently
modified and the fastpath doesn't need access to the VMA's file?


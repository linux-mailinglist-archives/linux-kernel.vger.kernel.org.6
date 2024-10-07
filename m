Return-Path: <linux-kernel+bounces-354188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29226993932
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8071F22C03
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A018C00C;
	Mon,  7 Oct 2024 21:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4AZviZjv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB228EA
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336711; cv=none; b=l5CpE1lDpFLSXykDw0SvdTN9JwklgEpFjnS3CWAY23mG/hb3JdQOnvR97BXgXbg0AEKxICIM8IgkJsgXWXvdTonpDGaO+om4c6OfbQk/kkY6cjwPaezcJ3LuWwWdeOAva1wTTwiixJLAGjYJ7PuRvK0SAr4fdkMAV+zhES4/v6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336711; c=relaxed/simple;
	bh=bUUNrV8DKM05tKO6BgQBrd2fwMkS3O5H+hm1F2kPCsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F2HBEeBa7x4u6L2KUOdg0ZH/1yTA1rLgMTzlrbXfsccYrAWwXVeMcYJd79EkCMLB3gO6cMyos6OcUqiF1NwEm8rS9CI9yzmSYQ+kT749zyr1LRF6UpyfS8gNWuAVHffLwfMjwZVnD6gxQ/xq2tMlgohc83h6RWjwIFDUkU94DV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4AZviZjv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae4ead5bso26325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728336707; x=1728941507; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcwa0K69IwSijQTkEu3XQl+titgYL25kpkU8tLNbnQs=;
        b=4AZviZjv1s4Zaywl6NGHAZFjLFfUs3EguunYwmRiNis9mugqpn5JLK6ys4OxHAwQZg
         4vR1DMm4TUzakX8bXW2muu2mE8kU1dEobrw3pmdJrR7hgqFA277UXa4C/7ie77RFkmrI
         1Eur+zXkl9o/8qLoDiJc4KpK4RBRbYwJVM5CohCfP1DQyLUcN6T3YVfhtgfkPkvK+jNr
         0dcLcfiKD+sJqt2qvD45ZwaUkZxBNnif60LUAO4gtNtTnr87h18zQ1eOfxD5fC24fGql
         uUBCqueeEDpGO8+j8j451JCmGsfF81/MlGu7bWrVqud4bdWnqqbALdCxM/xwYVSuO2nL
         mFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336707; x=1728941507;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcwa0K69IwSijQTkEu3XQl+titgYL25kpkU8tLNbnQs=;
        b=DF70KJcguvUJGEPzR/kBii/aWF7ZxmBXm20rPc47wwdpUDMPUqbSKvbeAyPdue1Df9
         0sSmNeLAt9NTXbq/OsjNcMjp8j7WUaLMJhUbTe7ZXQhL5jMIBYH6w+mbmY/a3LvYlW/x
         vo8YoZo70Wz/zNU20PbnBwd5TXWgC89Iv93ICSwT8iaJLShW3s18l+85LKaOZVUGhN2w
         lpn/PQh369EtLDeLlYFXpCoMXjWiU8sSh4GZbw4wvTJVuptsK5ZXbou79xNTRegDxiy4
         YssGvCKbAtil/TlcOxIVhiX1/v6aCLjg/aSFyVTS25yS3vNMzZ+6p+vzHLnxYkmevTlW
         yN1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGRfENeFWsnh7y91k2JQKVQJFUXGvFvvaRGYrnPnIrD6NQPccGNiVM/p3I8HPEgkMfF8kn6RmWYv8vX1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJz0W03Hl3rGwP6j94ZKd9h5UQnR11IEFVG7qve3CDWG+57Aa
	ixkQxTtV6SwPe+E3RJ9D+cQWGcXpIcNPJMgbajKv/W0ai08cI9omzT0RxLbNKsRY9unrck6l340
	adzRtnZY5V8M5g8Ue0Fdpa6D4zIQkMg30oRjN
X-Google-Smtp-Source: AGHT+IGin0ZNEVS1gSKXXrgs4W00kOMVovkBWvysigwLPBAWQgXtJtvhQAKjkfxN+M/JJJeT4+58OvhYq79D6KZt7Qs=
X-Received: by 2002:a05:600c:34cb:b0:428:31c:5a4f with SMTP id
 5b1f17b1804b1-4303b67064bmr452985e9.3.1728336706808; Mon, 07 Oct 2024
 14:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-15-Liam.Howlett@oracle.com> <CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com>
 <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
In-Reply-To: <wxvj55hptaogh2yxhhfftaomwzm6ifek5xu3uobbdsaabdmjll@t2ixdotfhaie>
From: Jann Horn <jannh@google.com>
Date: Mon, 7 Oct 2024 23:31:09 +0200
Message-ID: <CAG48ez3Ao_XkT0LKHfZsZSEZaoDAc4zRjitKG=P5O7R2BOgHxw@mail.gmail.com>
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

On Mon, Oct 7, 2024 at 10:31=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
> * Jann Horn <jannh@google.com> [241007 15:06]:
> > On Fri, Aug 30, 2024 at 6:00=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > > Instead of zeroing the vma tree and then overwriting the area, let th=
e
> > > area be overwritten and then clean up the gathered vmas using
> > > vms_complete_munmap_vmas().
> > >
> > > To ensure locking is downgraded correctly, the mm is set regardless o=
f
> > > MAP_FIXED or not (NULL vma).
> > >
> > > If a driver is mapping over an existing vma, then clear the ptes befo=
re
> > > the call_mmap() invocation.  This is done using the vms_clean_up_area=
()
> > > helper.  If there is a close vm_ops, that must also be called to ensu=
re
> > > any cleanup is done before mapping over the area.  This also means th=
at
> > > calling open has been added to the abort of an unmap operation, for n=
ow.
> >
> > As currently implemented, this is not a valid optimization because it
> > violates the (unwritten?) rule that you must not call free_pgd_range()
> > on a region in the page tables which can concurrently be walked. A
> > region in the page tables can be concurrently walked if it overlaps a
> > VMA which is linked into rmaps which are not write-locked.
>
> Just for clarity, this is the rmap write lock.

Ah, yes.

> > On Linux 6.12-rc2, when you mmap(MAP_FIXED) over an existing VMA, and
> > the new mapping is created by expanding an adjacent VMA, the following
> > race with an ftruncate() is possible (because page tables for the old
> > mapping are removed while the new VMA in the same location is already
> > fully set up and linked into the rmap):
> >
> >
> > task 1 (mmap, MAP_FIXED)     task 2 (ftruncate)
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > mmap_region
> >   vma_merge_new_range
> >     vma_expand
> >       commit_merge
> >         vma_prepare
> >           [take rmap locks]
> >         vma_set_range
> >           [expand adjacent mapping]
> >         vma_complete
> >           [drop rmap locks]
> >   vms_complete_munmap_vmas
> >     vms_clear_ptes
> >       unmap_vmas
> >         [removes ptes]
> >       free_pgtables
> >         [unlinks old vma from rmap]
> >                              unmap_mapping_range
> >                                unmap_mapping_pages
> >                                  i_mmap_lock_read
> >                                  unmap_mapping_range_tree
> >                                    [loop]
> >                                      unmap_mapping_range_vma
> >                                        zap_page_range_single
> >                                          unmap_single_vma
> >                                            unmap_page_range
> >                                              zap_p4d_range
> >                                                zap_pud_range
> >                                                  zap_pmd_range
> >                                                    [looks up pmd entry]
> >         free_pgd_range
> >           [frees pmd]
> >                                                    [UAF pmd entry acces=
s]
> >
> > To reproduce this, apply the attached mmap-vs-truncate-racewiden.diff
> > to widen the race windows, then build and run the attached reproducer
> > mmap-fixed-race.c.
> >
> > Under a kernel with KASAN, you should ideally get a KASAN splat like th=
is:
>
> Thanks for all the work you did finding the root cause here, I
> appreciate it.

Ah, this is not a bug I ran into while testing, it's a bug I found
while reading the patch. It's much easier to explain the issue and
come up with a nice reproducer this way than when you start out from a
crash. :P

> I think the correct fix is to take the rmap lock on free_pgtables, when
> necessary.  There are a few code paths (error recovery) that are not
> regularly run that will also need to change.

Hmm, yes, I guess that might work. Though I think there might be more
races: One related aspect of this optimization that is unintuitive to
me is that, directly after vma_merge_new_range(), a concurrent rmap
walk could probably be walking the newly-extended VMA but still
observe PTEs belonging to the previous VMA. I don't know how robust
the various rmap walks are to things like encountering pfnmap PTEs in
non-pfnmap VMAs, or hugetlb PUD entries in non-hugetlb VMAs. For
example, page_vma_mapped_walk() looks like, if you called it on a page
table range with huge PUD entries, but with a VMA without VM_HUGETLB,
something might go wrong on the "pmd_offset(pud, pvmw->address)" call,
and a 1G hugepage might get misinterpreted as a page table? But I
haven't experimentally verified that.


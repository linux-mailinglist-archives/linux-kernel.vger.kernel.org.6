Return-Path: <linux-kernel+bounces-405132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE849C4D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E471E282B11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA705207A0E;
	Tue, 12 Nov 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Ji8DoiR"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F291DFE4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731382090; cv=none; b=AQgLICu93Bz/6FuSSs4cbGMDYwTDH3g3mfpMuzkDzcTJbf/LM/niEPK0o2aQA2Y/hQqey1RosqpP3d3GbXnY58vRAIwxdN+2QlxG4YOitoEJwkU2Q83X5e6HJxcfTzARTdlCXZ3USgLd+q78JhPBrBwJoidAS5Imk13fdUgAYtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731382090; c=relaxed/simple;
	bh=7Vy/LfoiRkz6i5IihFYg1p0hT26eAG94qEQtj1g/xmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=u/aGVz5t50XMfbSN0yymDRryDDtVV7z0s5YVPs39JQDGQJmGSFFmP76IQNJoIGKriN6JdCmUzleWmvG50tQ4JkXPxd8PKoNjHGfKfZqQNrSUGNv4pMP+/Qr/1dvNKBVuQu2+BQrer4fJNOMkw7l4rTLPWN1waWpCqKtQOhgSQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Ji8DoiR; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460969c49f2so138061cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731382088; x=1731986888; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCAf8+dxqLdX7eOAb6wjNbdElfKRHRt7U7TeGqx35oE=;
        b=0Ji8DoiRsOgjSkDFuss2OUxjhlpWfYiOiLhIStd8HR2jgfmaB5jR+kEg472mHs/j0U
         oiED2YGirTfaEemXJBADIw4Gg+5vBhXEGrtCnp59vnaTb1K4MMB0GZkc2fuJlgORnAdV
         7+6JFM3zivhNhdYQIxd/LOvoiWoCta4KyUDLAoRW08y2WjhwAhQ6pm3p9ixtimppoXeT
         fr0/xYTbJDXKRfhbcrUZAE9ugfTyDJLhHUldMbgPvyVMZth3gGNoFeC1WrshkDMzHqe9
         JYHOJoBpuwECiDInWyaUunpT4y6MOPzd/Qzx/3WqEQMUya/enHscPCd2D/do+1ximeCg
         FVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731382088; x=1731986888;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCAf8+dxqLdX7eOAb6wjNbdElfKRHRt7U7TeGqx35oE=;
        b=WSSLqjmdnhGIHTec7KDoVT/MVY6/XyDTq6TZTjJUKHFK+h9d+EMA1WZh5WkF0v9lC1
         ih5ETvWQ/GaewZf0rFPdg7tmL5/s8Uw5weQ09oenu4Ge2LpfqtFaQOxbDBSsz6oezvg8
         0BDSFPBL04lQBmLT6HZPzTullzPm+yTFEdQt9NMMfP7xpiwrH+iaDxYUmxteGFCwk+EK
         hN1/hns+HlpsIFweONsFqG0eU6cx2AgrR0ENmZ40wo1KejV1IBXwgebJqcHhL6NWAs23
         rcds0y/kTuJHg4tPP0PE0yKa29X2muQXKmQj3VmKAorus2JeYoJJEi2hPGMvlEZP0aws
         zVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdlmY6EokLk/O2iXMzMF2T/h3Zc3w39aSXoWBIh1E0SLhuS9MDbmZjQqAWHSqFsLp0ilg6GgbN9YMSY3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFR9iY1RgcR39RhZ3AZK0Qlqv52jZGNN7YmheNcoz9iNNe0O7X
	OtSV68GaUmAfg/a/Z2udiTzmSs6AskN7gKrHfUuD8e8VctWkfk5WVZD/BhvYu/YczoT6fAm/6U/
	MmYiNULzglCR7rW2TdjzqWxS9cHp6SXKquXpP
X-Gm-Gg: ASbGnctqTVYeaXdbB1HKo+G0eevnTTU28AEBZ6QkN8cwXWvbR0APDFmVUtLgH867FAj
	RBHkhTeqrKZihKqDshjAH3fF0Qu0deeI=
X-Google-Smtp-Source: AGHT+IEFUiciqb5uHKeO2gzGG4PQfgq0SXj49h9oTt8eAjKR6bvm7l1OmVT7yDxhJ3nxVCJF4yqHihwKWnlC7XWqyU8=
X-Received: by 2002:a05:622a:5289:b0:462:ad94:3554 with SMTP id
 d75a77b69052e-46342886136mr535501cf.17.1731382087741; Mon, 11 Nov 2024
 19:28:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <CAJuCfpER+Er8PAGVh2ScN70g267n4iuSukEifMS4929yVqv4xg@mail.gmail.com>
 <lvirfevzcrnkddmdsp456dzbb2f7ahd547zv4yy5syq3en6sjz@htyzuesvvezr>
In-Reply-To: <lvirfevzcrnkddmdsp456dzbb2f7ahd547zv4yy5syq3en6sjz@htyzuesvvezr>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 19:27:56 -0800
Message-ID: <CAJuCfpFeFmUiS95sBLYX1c0tAgvgsPiFAMx8STpcgo4rcPBVuA@mail.gmail.com>
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	akpm@linux-foundation.org, willy@infradead.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 6:48=E2=80=AFPM 'Liam R. Howlett' via kernel-team
<kernel-team@android.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [241111 16:41]:
> > On Mon, Nov 11, 2024 at 12:55=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > Back when per-vma locks were introduces, vm_lock was moved out of
> > > vm_area_struct in [1] because of the performance regression caused by
> > > false cacheline sharing. Recent investigation [2] revealed that the
> > > regressions is limited to a rather old Broadwell microarchitecture an=
d
> > > even there it can be mitigated by disabling adjacent cacheline
> > > prefetching, see [3].
> > > This patchset moves vm_lock back into vm_area_struct, aligning it at =
the
> > > cacheline boundary and changing the cache to be cache-aligned as well=
.
> > > This causes VMA memory consumption to grow from 160 (vm_area_struct) =
+ 40
> > > (vm_lock) bytes to 256 bytes:
> > >
> > >     slabinfo before:
> > >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> > >      vma_lock         ...     40  102    1 : ...
> > >      vm_area_struct   ...    160   51    2 : ...
> > >
> > >     slabinfo after moving vm_lock:
> > >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> > >      vm_area_struct   ...    256   32    2 : ...
> > >
> > > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pa=
ges,
> > > which is 5.5MB per 100000 VMAs.
> > > To minimize memory overhead, vm_lock implementation is changed from
> > > using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> > > vm_area_struct members are moved into the last cacheline, resulting
> > > in a less fragmented structure:
>
> Wait a second, this is taking 40B down to 8B, but the alignment of the
> vma will surely absorb that 32B difference?  The struct sum is 153B
> according to what you have below so we won't go over 192B.  What am I
> missing?

Take a look at the last patch in the series called "[PATCH 4/4] mm:
move lesser used vma_area_struct members into the last cacheline". I
move some struct members from the earlier cachelines into cacheline #4
where the vm_lock is staying.
>
> > >
> > > struct vm_area_struct {
> > >         union {
> > >                 struct {
> > >                         long unsigned int vm_start;      /*     0    =
 8 */
> > >                         long unsigned int vm_end;        /*     8    =
 8 */
> > >                 };                                       /*     0    =
16 */
> > >                 struct callback_head vm_rcu ;            /*     0    =
16 */
> > >         } __attribute__((__aligned__(8)));               /*     0    =
16 */
> > >         struct mm_struct *         vm_mm;                /*    16    =
 8 */
> > >         pgprot_t                   vm_page_prot;         /*    24    =
 8 */
> > >         union {
> > >                 const vm_flags_t   vm_flags;             /*    32    =
 8 */
> > >                 vm_flags_t         __vm_flags;           /*    32    =
 8 */
> > >         };                                               /*    32    =
 8 */
> > >         bool                       detached;             /*    40    =
 1 */
> > >
> > >         /* XXX 3 bytes hole, try to pack */
> > >
> > >         unsigned int               vm_lock_seq;          /*    44    =
 4 */
> > >         struct list_head           anon_vma_chain;       /*    48    =
16 */
> > >         /* --- cacheline 1 boundary (64 bytes) --- */
> > >         struct anon_vma *          anon_vma;             /*    64    =
 8 */
> > >         const struct vm_operations_struct  * vm_ops;     /*    72    =
 8 */
> > >         long unsigned int          vm_pgoff;             /*    80    =
 8 */
> > >         struct file *              vm_file;              /*    88    =
 8 */
> > >         void *                     vm_private_data;      /*    96    =
 8 */
> > >         atomic_long_t              swap_readahead_info;  /*   104    =
 8 */
> > >         struct mempolicy *         vm_policy;            /*   112    =
 8 */
> > >
> > >         /* XXX 8 bytes hole, try to pack */
> > >
> > >         /* --- cacheline 2 boundary (128 bytes) --- */
> > >         struct vma_lock       vm_lock (__aligned__(64)); /*   128    =
 4 */
> > >
> > >         /* XXX 4 bytes hole, try to pack */
> > >
> > >         struct {
> > >                 struct rb_node     rb (__aligned__(8));  /*   136    =
24 */
> > >                 long unsigned int  rb_subtree_last;      /*   160    =
 8 */
> > >         } __attribute__((__aligned__(8))) shared;        /*   136    =
32 */
> > >         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168    =
 0 */
> > >
> > >         /* size: 192, cachelines: 3, members: 17 */
> > >         /* sum members: 153, holes: 3, sum holes: 15 */
> > >         /* padding: 24 */
> > >         /* forced alignments: 3, forced holes: 2, sum forced holes: 1=
2 */
> > > } __attribute__((__aligned__(64)));
> > >
> > > Memory consumption per 1000 VMAs becomes 48 pages, saving 2 pages com=
pared
> > > to the 50 pages in the baseline:
> > >
> > >     slabinfo after vm_area_struct changes:
> > >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> > >      vm_area_struct   ...    192   42    2 : ...
> > >
> > > Performance measurements using pft test on x86 do not show considerab=
le
> > > difference, on Pixel 6 running Android it results in 3-5% improvement=
 in
> > > faults per second.
> > >
> > > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@goog=
le.com/
> > > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-902=
0/
> > > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53=
cT_kbfP_pR+-2g@mail.gmail.com/
> >
> > And of course I forgot to update Lorenzo's new locking documentation :/
> > Will add that in the next version.
> >
> > >
> > > Suren Baghdasaryan (4):
> > >   mm: introduce vma_start_read_locked{_nested} helpers
> > >   mm: move per-vma lock into vm_area_struct
> > >   mm: replace rw_semaphore with atomic_t in vma_lock
> > >   mm: move lesser used vma_area_struct members into the last cachelin=
e
> > >
> > >  include/linux/mm.h        | 163 +++++++++++++++++++++++++++++++++++-=
--
> > >  include/linux/mm_types.h  |  59 +++++++++-----
> > >  include/linux/mmap_lock.h |   3 +
> > >  kernel/fork.c             |  50 ++----------
> > >  mm/init-mm.c              |   2 +
> > >  mm/userfaultfd.c          |  14 ++--
> > >  6 files changed, 205 insertions(+), 86 deletions(-)
> > >
> > >
> > > base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
> > > --
> > > 2.47.0.277.g8800431eea-goog
> > >
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>


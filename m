Return-Path: <linux-kernel+bounces-405127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7ED9C4D41
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF2A1F21FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2807E207A03;
	Tue, 12 Nov 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwlH0RL1"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388720494F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381823; cv=none; b=YWdKHinMaiPV3/d4CbvTbDVmUFDExxcCAEcNMHBkkmLVhRR8We1y9gHN4Vhg3k+4eISS3rbWnqTOiVebQ3DKXusMt9NvU+iZCesklppxr0x+DstcUjThqH1WKTBFpE3C1hJM/+gWDGzSFe78PL6h/u+vzy+QguwqW3dU8h6DHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381823; c=relaxed/simple;
	bh=Ra0QFnf4lEv1zU6q2C32gJqUo9yHbnUeOxC/9C5oBrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=nYxjLD8vzWAOyQXiY9t/dOpkrOsnz4m7e2VQJQJgwjteOjkPrNkd0tpch3VbYLjmgqqGaMFZId0N5XZ2upW1k4v11JiAnQLhnt+Eeq0Gcs1VZ5ABAweV0Llx81B2CVqVa1ZhTIP3ASgwlsPOGVYjShv66hG/D1JC7uGvGrz3/Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwlH0RL1; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460b295b9eeso84911cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 19:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731381820; x=1731986620; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZ4JdoZQje+kaOr0XJAZHdsqYNTycxGtA/GqVUYAWS0=;
        b=HwlH0RL12DJO+iafBf4dZlAuE8vWFb07JSBu1/VQif/9z+nnnlfNd/6apM2BL9fMBA
         Y5OHF9PCpgFR7V/WibuFZJn706jCMECz1S5viyP7Pzle+Bn5qDpRshNu40qUsjEgBeaS
         Oc6ukYKEZR3w2uDjYMB2P9cZS6QVHIf5sYpEbvn2+Dshx6tBBVepx7Nzeltmr9cItASj
         dgtMV+hfhEw3mZg3TWjMf2WlabtONLkmP8zO2UUqcGhpCmOejzzCxdebCVVmW27HJvKv
         j9jBr/EJageByxs3Ho51TIyWGm1I7ubq+UBycye5WqAbpLkuy/Y4V5haLURYQ/XKqF5N
         C4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731381820; x=1731986620;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZ4JdoZQje+kaOr0XJAZHdsqYNTycxGtA/GqVUYAWS0=;
        b=PQvc1HEgY5qDQNw5ktT13EJc5AfXKrOT4i8Hnv39T82aTlQYHeWiTGKM+fi0XsY2bY
         gQutjTjza/PD35Y4gN4UMiiHBVMeVOIa+sakBrQTP3uujfwENMeQeDIx9WwKJorotFo3
         kaVB1J/o2t8JNK7f+heimDxjOue+GdO2sILP3mhpBqZrLMZAliARJTnK36vaHo/+9mg3
         TcrFyYSGp5sLsgTckiM12PI5q29Otv6DjtNTjqtYkxRHzAhsy+wO+BGUivxltqgMudbi
         QNvVicTCRZ1CWaAbGkj/4FuWECNLnEWJ/PTSskqhaVNrTX+0dOzmwwQ2MgNXxsjr8NJt
         2CPA==
X-Forwarded-Encrypted: i=1; AJvYcCU4/6kPNtnAabuWp3nGxJzJoyUDX9IcgiC5SzGxFzcyT/CDdiC9bJw2pfPAm03kFk73E6In0giykP+5IsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtEv0Uz3yVn4tI04XxUk6gCka2Z1JtpEDPgQNnUCQqx4pbPMNw
	rshdfkren8VgdNq3LOYkb22qL5hEqe57fjNgd0Yo/Zu3SjjtOy33zrGXVIAm0RhYhC0xN+ib+wb
	jK+asxMS74kZs06tHXx0V38t0c4U8LGj9g8mI
X-Gm-Gg: ASbGncuaZqoKPUR9/dOYaEDUxitwK66cYVtytp1t4MpBk5CeC+7lekpGj+0wPgR0NT8
	B6qGdc/mdNNGVfRiyUoDlesiO2Iwjylkr55PYIn/lVTfweV1bOawqgFvJQ5nLPg==
X-Google-Smtp-Source: AGHT+IH2X7R9EaxE8yEh/tFib5yP3+5ARuM042kvBNJm/BiVdasUXL+ESmr0khwLuuJ9NriFWoyJUV1Agr69/n8aGG0=
X-Received: by 2002:a05:622a:190a:b0:462:c96a:bb30 with SMTP id
 d75a77b69052e-4633ef60502mr2057411cf.2.1731381820135; Mon, 11 Nov 2024
 19:23:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com> <pbcublsqoi6yeev767ezc7qfmcvxipbvz2towavhfgzlmzt26r@h3cwlmrmt7da>
In-Reply-To: <pbcublsqoi6yeev767ezc7qfmcvxipbvz2towavhfgzlmzt26r@h3cwlmrmt7da>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 19:23:29 -0800
Message-ID: <CAJuCfpHt2vSoWi_43VP6CbUBycy2ky_g4fSRwbn9iCi1EsMeHg@mail.gmail.com>
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

On Mon, Nov 11, 2024 at 6:35=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [241111 15:55]:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
> > This patchset moves vm_lock back into vm_area_struct, aligning it at th=
e
> > cacheline boundary and changing the cache to be cache-aligned as well.
> > This causes VMA memory consumption to grow from 160 (vm_area_struct) + =
40
> > (vm_lock) bytes to 256 bytes:
> >
> >     slabinfo before:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vma_lock         ...     40  102    1 : ...
> >      vm_area_struct   ...    160   51    2 : ...
> >
> >     slabinfo after moving vm_lock:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    256   32    2 : ...
> >
> > Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 page=
s,
> > which is 5.5MB per 100000 VMAs.
> > To minimize memory overhead, vm_lock implementation is changed from
> > using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> > vm_area_struct members are moved into the last cacheline, resulting
> > in a less fragmented structure:
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
/ 40 + 16
> >       /* --- cacheline 1 boundary (64 bytes) --- */
> >       struct anon_vma *          anon_vma;             /*    64     8 *=
/ 56 + 8
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
> This is 8 bytes on my compile, I guess you have userfaultfd disabled?

Yeah, I show here results with the defconfig. After I move things
around at the end we will have space for to keep everything under 3
cachelines.

>
> Considering this will end up being 256 anyways these changes may not
> matter, but we can pack this better.
> 1. move vm_lock to after anon_vma (ends up at 64B in the end)
> 2. move vm_lock_seq to after vm_lock

Nope, for performance reasons it's important to keep vm_lock_seq in
the first cacheline. It's used very extensively when read-locking the
VMA.

> 4. move struct to the new 112 offset (which is 8B aligned at 112)
> 3. move detached to the end of the structure

detached also should stay in the first cacheline, otherwise we will
get performance regression. I spent a week experimenting with what we
can and can't move :)

>
> This should limit the holes and maintain the alignments.
>
> The down side is detached is now in the last used cache line and away
> from what would probably be used with it, but maybe it doesn't matter
> considering prefetch.

It very much does matter :)

>
> But maybe you have other reasons for the placement?
>
> >
> >       /* size: 192, cachelines: 3, members: 17 */
> >       /* sum members: 153, holes: 3, sum holes: 15 */
> >       /* padding: 24 */
> >       /* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
> > } __attribute__((__aligned__(64)));
> >
> > Memory consumption per 1000 VMAs becomes 48 pages, saving 2 pages compa=
red
> > to the 50 pages in the baseline:
> >
> >     slabinfo after vm_area_struct changes:
> >      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >      vm_area_struct   ...    192   42    2 : ...
> >
> > Performance measurements using pft test on x86 do not show considerable
> > difference, on Pixel 6 running Android it results in 3-5% improvement i=
n
> > faults per second.
> >
> > [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google=
.com/
> > [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> > [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT=
_kbfP_pR+-2g@mail.gmail.com/
> >
> > Suren Baghdasaryan (4):
> >   mm: introduce vma_start_read_locked{_nested} helpers
> >   mm: move per-vma lock into vm_area_struct
> >   mm: replace rw_semaphore with atomic_t in vma_lock
> >   mm: move lesser used vma_area_struct members into the last cacheline
> >
> >  include/linux/mm.h        | 163 +++++++++++++++++++++++++++++++++++---
> >  include/linux/mm_types.h  |  59 +++++++++-----
> >  include/linux/mmap_lock.h |   3 +
> >  kernel/fork.c             |  50 ++----------
> >  mm/init-mm.c              |   2 +
> >  mm/userfaultfd.c          |  14 ++--
> >  6 files changed, 205 insertions(+), 86 deletions(-)
> >
> >
> > base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
> > --
> > 2.47.0.277.g8800431eea-goog
> >


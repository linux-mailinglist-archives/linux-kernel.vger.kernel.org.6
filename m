Return-Path: <linux-kernel+bounces-404801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDE89C48A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8670CB322AE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A21B86F7;
	Mon, 11 Nov 2024 21:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+mzvevP"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A631ACDE7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361282; cv=none; b=Yvc+DZUhtRw3Np6UuTjkWY2h1OZPer2QPJ8zA9T5B+kXCKwrZKqTMc938xiE3xMX/RRsoMWwdbB4ivYs7yA/cu6clbvQE20TEDXqS5ckUFUda740ykFh5vQKJVzMdeBTUNBGpMAtW5tpfN32zhDatVnIEJ3by1cr6CRihCZMooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361282; c=relaxed/simple;
	bh=S6fdu8sFu/GWAJIun7mvI081Uo8T6EO7isMpOAR+YNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnoM7miIZxS0EFC4weLvQjbe1ek49F0jbTwPPGZ9AOJCmOpnlu54WAky+AbNVViaSAO1+HR+nJz0OUR37+1bfh/2zEW6J67uMl+0GfTXBNz6L95yri5aDAygOENQ0/uOSRFDnujKcfKN6VkwBo+hdqtcyLC9xi8wYJ+5TwBnDg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+mzvevP; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460b295b9eeso15871cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 13:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731361280; x=1731966080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0o1VajD5WDcGAgvLwqsAPBGDplXjntm8i6Rb+8zCTPc=;
        b=K+mzvevPNjW4fY0UmtSt+loA5lLhCWmpDQJxSK/K/ULv4t9X3DSlavuJBjoNNAJLtu
         3flT0SWeYoLQWrQMFtpIFvMAy03750vOHzm1Au3pNHVuD5TzfZsGbGtrgCbdiyaDKhX7
         ezcslNBVJgjZ2V2ubZTE6UFqjrvvbFUvoKcAYniQnnzUTJVwOGjd/fqEOjlXPMG5aTK1
         AIfyOHnToZPoB4semfLGcJOtDzHz2faOh/V6B95t6pgnUqarbS1hJLLVOWGVyklDwyV/
         rkyAEZpiZCAluB7oJLm+FgDqB3XSxDx9JStc+6PfBAj9IhWPbFqob2LOgkL+x/PM9huI
         LV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731361280; x=1731966080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0o1VajD5WDcGAgvLwqsAPBGDplXjntm8i6Rb+8zCTPc=;
        b=h3EQp60UQgD+K0S4HbeMjkkvOLWKRdUQz11HqBcsluFmXmAr088HeaMzo1x3tmCl00
         IwaY2v/7tI3Bn+Cv+ubfP2FHcIGQHhTKSoaHUFM8zkyXaoeL6RqzJD/o/4rXHgm4/tzR
         PxnRazERiS+2Zc2DKrW0cetN044yQwIMpbBha8tbpIQLuXatsQyntamcXV3rF2nmT5hd
         pMd5N7tpxn9GOci0anGDMQ+akFEy7hmZJoAtVyFLQDGDKYkFd0s6aoCN1XxSSx+/BZbZ
         Z7jYFh6RUvNXHB8uw4NUzx6Dzt/yY9mXowK73Jy0zchV8NPPSJNClur9HwfdBMq4LA6K
         kozQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa6Z44+0c/Flc++dM3MW6a1YVBORxhxaFZaMguMkinncu2xE99YfacClfL4e3f/8utd5Ynu6iIuMw5wDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71lNXhwhsDdtftMmO3pKqw9cSWEp8O/iciwRRZSupXBhRBl2m
	HKHfABqrd6a3TNE8PYHFIK2kNqGgFjDV6CTUa/TbQPbwqiMpNbVhA/+Ofk8guW+ahafVJZVWNRe
	gZ3fZNy//iBwxGdHhIv42CIlZRdxkd/45SwhU
X-Gm-Gg: ASbGnct5TwnkIqMHaSZZD6TqtPbnAiTMz1yGlBhBqAu/AeRCe3Vbf0al8844hNSBgBG
	zLUT1xQs0+gBRTPRPhJ+001lIMKmiRDw=
X-Google-Smtp-Source: AGHT+IGSwFkpn8md6DrPvbrEu1U0QdNk3aUasW3xWTUdEwmk8GNUKmRmgbqP0HdWP0odQfGStJVRwETqSfVia9SbpSA=
X-Received: by 2002:a05:622a:190a:b0:462:c96a:bb30 with SMTP id
 d75a77b69052e-4633ef60502mr927611cf.2.1731361279387; Mon, 11 Nov 2024
 13:41:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111205506.3404479-1-surenb@google.com>
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 11 Nov 2024 13:41:08 -0800
Message-ID: <CAJuCfpER+Er8PAGVh2ScN70g267n4iuSukEifMS4929yVqv4xg@mail.gmail.com>
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
To: akpm@linux-foundation.org
Cc: willy@infradead.org, liam.howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, 
	peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, 
	brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com, hughd@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, 
	souravpanda@google.com, pasha.tatashin@soleen.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:55=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].
> This patchset moves vm_lock back into vm_area_struct, aligning it at the
> cacheline boundary and changing the cache to be cache-aligned as well.
> This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
> (vm_lock) bytes to 256 bytes:
>
>     slabinfo before:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vma_lock         ...     40  102    1 : ...
>      vm_area_struct   ...    160   51    2 : ...
>
>     slabinfo after moving vm_lock:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    256   32    2 : ...
>
> Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
> which is 5.5MB per 100000 VMAs.
> To minimize memory overhead, vm_lock implementation is changed from
> using rw_semaphore (40 bytes) to an atomic (8 bytes) and several
> vm_area_struct members are moved into the last cacheline, resulting
> in a less fragmented structure:
>
> struct vm_area_struct {
>         union {
>                 struct {
>                         long unsigned int vm_start;      /*     0     8 *=
/
>                         long unsigned int vm_end;        /*     8     8 *=
/
>                 };                                       /*     0    16 *=
/
>                 struct callback_head vm_rcu ;            /*     0    16 *=
/
>         } __attribute__((__aligned__(8)));               /*     0    16 *=
/
>         struct mm_struct *         vm_mm;                /*    16     8 *=
/
>         pgprot_t                   vm_page_prot;         /*    24     8 *=
/
>         union {
>                 const vm_flags_t   vm_flags;             /*    32     8 *=
/
>                 vm_flags_t         __vm_flags;           /*    32     8 *=
/
>         };                                               /*    32     8 *=
/
>         bool                       detached;             /*    40     1 *=
/
>
>         /* XXX 3 bytes hole, try to pack */
>
>         unsigned int               vm_lock_seq;          /*    44     4 *=
/
>         struct list_head           anon_vma_chain;       /*    48    16 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct anon_vma *          anon_vma;             /*    64     8 *=
/
>         const struct vm_operations_struct  * vm_ops;     /*    72     8 *=
/
>         long unsigned int          vm_pgoff;             /*    80     8 *=
/
>         struct file *              vm_file;              /*    88     8 *=
/
>         void *                     vm_private_data;      /*    96     8 *=
/
>         atomic_long_t              swap_readahead_info;  /*   104     8 *=
/
>         struct mempolicy *         vm_policy;            /*   112     8 *=
/
>
>         /* XXX 8 bytes hole, try to pack */
>
>         /* --- cacheline 2 boundary (128 bytes) --- */
>         struct vma_lock       vm_lock (__aligned__(64)); /*   128     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct {
>                 struct rb_node     rb (__aligned__(8));  /*   136    24 *=
/
>                 long unsigned int  rb_subtree_last;      /*   160     8 *=
/
>         } __attribute__((__aligned__(8))) shared;        /*   136    32 *=
/
>         struct vm_userfaultfd_ctx  vm_userfaultfd_ctx;   /*   168     0 *=
/
>
>         /* size: 192, cachelines: 3, members: 17 */
>         /* sum members: 153, holes: 3, sum holes: 15 */
>         /* padding: 24 */
>         /* forced alignments: 3, forced holes: 2, sum forced holes: 12 */
> } __attribute__((__aligned__(64)));
>
> Memory consumption per 1000 VMAs becomes 48 pages, saving 2 pages compare=
d
> to the 50 pages in the baseline:
>
>     slabinfo after vm_area_struct changes:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    192   42    2 : ...
>
> Performance measurements using pft test on x86 do not show considerable
> difference, on Pixel 6 running Android it results in 3-5% improvement in
> faults per second.
>
> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.c=
om/
> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_k=
bfP_pR+-2g@mail.gmail.com/

And of course I forgot to update Lorenzo's new locking documentation :/
Will add that in the next version.

>
> Suren Baghdasaryan (4):
>   mm: introduce vma_start_read_locked{_nested} helpers
>   mm: move per-vma lock into vm_area_struct
>   mm: replace rw_semaphore with atomic_t in vma_lock
>   mm: move lesser used vma_area_struct members into the last cacheline
>
>  include/linux/mm.h        | 163 +++++++++++++++++++++++++++++++++++---
>  include/linux/mm_types.h  |  59 +++++++++-----
>  include/linux/mmap_lock.h |   3 +
>  kernel/fork.c             |  50 ++----------
>  mm/init-mm.c              |   2 +
>  mm/userfaultfd.c          |  14 ++--
>  6 files changed, 205 insertions(+), 86 deletions(-)
>
>
> base-commit: 931086f2a88086319afb57cd3925607e8cda0a9f
> --
> 2.47.0.277.g8800431eea-goog
>


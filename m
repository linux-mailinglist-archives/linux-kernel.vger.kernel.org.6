Return-Path: <linux-kernel+bounces-400675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8D9C10D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26EE91C24497
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A82217F5F;
	Thu,  7 Nov 2024 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MJ8snL+f"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A40155398
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014172; cv=none; b=Yil6LEaMvkSbQJB4ZpNb4KwkXr18+g5Y3SVaWZsrTXx0APTlmYf+mNjYCDmDs3Lkn64AYjENQTLQZHlW1pfJv8HaVF+stke/Wx1UiYnedNQaqu+o7M3ibavXzriAUYpCO8wGkMABoFL0xRXJnEGDeVdmM852PcgOk2Fe7hdUAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014172; c=relaxed/simple;
	bh=AluGnbjvrReC8/kUUlaldvGXBhVCW0UFZfTHSw3lz5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED2+a71WgfRQZV3Sc3Nr5xUGMtLbSnUjIhrk3O5Krra9Vz2WYAybsajJ+ufyZWFnfltR3LTgEyJ12+rAieNPQ30H3hWk0W+E5TB3vql6Ll3wjEiuXTuBRsZjN9Sv4fKABAJwzpb55Wrab0gk1F5vqCJ+VCaW9aQ1vE0zDcEIxv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MJ8snL+f; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e19d8c41so7643e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014169; x=1731618969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVaHQ1Y4UUsOIf67jORkC8pstG2aYdOgzFWIiY/VM64=;
        b=MJ8snL+fW0kcndhK6P6dybjVnK3QHf8CO8j8RC5Mvldn0sQCEnpEby87g9FudZpJko
         toOWtrGDASJUHXmDuIIMhaUvDV/Rmh0sZqKljdYK6R6YCdUmt1gYkzHdlTHd5GRXLMC/
         nkUF6oFKnVhKNgUBxh4d+UKy7tFfEqqQKC+/Eba12GoXLKp9cR4uxrm8PsO9pVemqPwS
         DBIVdvvYm4FktTjoB1Wq16ncUu2WTivK3Ziqzj5IvVsINxNfRln+ii2Wt2hxcvyXuxV5
         GQUsEHrdOnwMDTGE4TPx+P7yqkUKfoYy3IiikKw45G1d4z7qxDZr4ajsVYfH6mo0oYtK
         NDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014169; x=1731618969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVaHQ1Y4UUsOIf67jORkC8pstG2aYdOgzFWIiY/VM64=;
        b=dZAJBDqY/pE9TCdKqmvtxv812uVRywUQuZp8r+XQQFFVFnO560h+OAI2cVh2XvZFhd
         vsdzJPfJRy+XJPdKdlrln3BOD4Udn/aEzQiMlT4ZoSU97YdhI4QoF2SNpkl38piEOisl
         nKJK1cSySh7NVe1Zl1befaPN2QaC+U7L2cPfFkEEWgUor8oNTHc2ivvVoINTEKSfJFnK
         1sgYpBmNonpqYgknJlwE6A/jvS+B4lX9jxNl+ShziIBM64KDTPuOuphc+BWntRqoViSM
         +27l5h4jBHniHcwmdgRTcxuvMSLnXCkTqGg2lMq6Ag4Vz6e/Mb3C4zSbcKLMTQ8OwQZw
         w4gA==
X-Forwarded-Encrypted: i=1; AJvYcCXwwQ0sIEsWSxjSimJ8qIGPjLBNWN+sTc4e1pdVNVM4yL6dEFjW5eAcUqzhjJ8E23FcsFdPb7P/wkaB21E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1qaBDMOj2X7eOZRLiQ/kiB34f18OYSJe5HRzKvtPfKdUNEAnH
	5/0bULcalQ37kwJ2iQNa17GnYqbYsW68cm4yHgCcZeRRv0jLhIvgo1W2wuxWg7bb87+qM14tAM5
	Ol/W1r92mbuf14P7oUYBbreS8r/QedPudy9sw
X-Gm-Gg: ASbGnct3GEKt0rgZeiStb/61Rhxt/UVxidNf+4rDUImrXFwptRXxWO02eaIZWgUDzhU
	/Rt81hTMhXdjY0Vq0E2Y3iKc+2uOb4eoeaUsohpL0urCAq4eBNwfL7K08KGY=
X-Google-Smtp-Source: AGHT+IHtKDeI1hnEgGrvuwbIzYUz/eBlzb/8OZmh/fz7+HhpOrQahbFa/zrTKTUJiAlEiR64GCxcroXwjLWBudfunFA=
X-Received: by 2002:ac2:5b87:0:b0:52e:8a42:f152 with SMTP id
 2adb3069b0e04-53d812536c6mr448458e87.5.1731014168183; Thu, 07 Nov 2024
 13:16:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 7 Nov 2024 22:15:31 +0100
Message-ID: <CAG48ez1=Be_kROw-+oh2TQ7ag=+=FRe82Umhq74UZMo2W=QBcQ@mail.gmail.com>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Hillf Danton <hdanton@sina.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:02=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Locking around VMAs is complicated and confusing. While we have a number =
of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documentin=
g
> how locks are expected to be used when it comes to interacting with
> mm_struct and vm_area_struct objects.

Thanks, I think this is looking pretty good now.

> +VMA fields
> +^^^^^^^^^^
> +
> +We can subdivide :c:struct:`!struct vm_area_struct` fields by their purp=
ose, which makes it
> +easier to explore their locking characteristics:
> +
> +.. note:: We exclude VMA lock-specific fields here to avoid confusion, a=
s these
> +         are in effect an internal implementation detail.
> +
> +.. table:: Virtual layout fields
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +   Field                 Description                              Write =
lock
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
[...]
> +   :c:member:`!vm_pgoff` Describes the page offset into the file, rmap w=
rite.
> +                         the original page offset within the      mmap w=
rite,
> +                         virtual address space (prior to any      rmap w=
rite.
> +                         :c:func:`!mremap`), or PFN if a PFN map
> +                         and the architecture does not support
> +                         :c:macro:`!CONFIG_ARCH_HAS_PTE_SPECIAL`.

Is that a typo in the rightmost column? "rmap write. mmap write, rmap
write." lists rmap twice

> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +These fields describes the size, start and end of the VMA, and as such c=
annot be

s/describes/describe/

> +modified without first being hidden from the reverse mapping since these=
 fields
> +are used to locate VMAs within the reverse mapping interval trees.
[...]
> +.. table:: Reverse mapping fields
> +
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   Field                               Description                      =
         Write lock
> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +   :c:member:`!shared.rb`              A red/black tree node used, if th=
e        mmap write,
> +                                       mapping is file-backed, to place =
the VMA  VMA write,
> +                                       in the                           =
         i_mmap write.
> +                                       :c:member:`!struct address_space-=
>i_mmap`
> +                                      red/black interval tree.

This list of write locks is correct regarding what locks you need to
make changes to the VMA's tree membership. Technically at a lower
level, the contents of vma->shared.rb are written while holding only
the file rmap lock when the surrounding rbtree nodes change, but
that's because the rbtree basically takes ownership of the node once
it's been inserted into the tree. But I don't know how to concisely
express that here, and it's kind of a nitpicky detail, so I think the
current version looks good.

Maybe you could add "For changing the VMA's association with the
rbtree:" on top of the list of write locks for this one?

> +   :c:member:`!shared.rb_subtree_last` Metadata used for management of t=
he
> +                                       interval tree if the VMA is file-=
backed.  mmap write,
> +                                                                        =
         VMA write,
> +                                                                        =
         i_mmap write.

For this one, I think it would be more accurate to say that it is
written under just the i_mmap write lock. Though maybe that looks
kinda inconsistent with the previous one...

> +   :c:member:`!anon_vma_chain`         List of links to forked/CoW=E2=80=
=99d anon_vma    mmap read,
> +                                       objects.                         =
         anon_vma write.

Technically not just forked/CoW'd ones, but also the current one.
Maybe something like "List of links to anon_vma objects (including
inherited ones) that anonymous pages can be associated with"?

> +   :c:member:`!anon_vma`               :c:type:`!anon_vma` object used b=
y        mmap_read,
> +                                       anonymous folios mapped exclusive=
ly to    page_table_lock.
> +                                      this VMA.

move_vma() uses unlink_anon_vmas() to change ->anon_vma from non-NULL
to NULL. There we hold:

 - mmap lock (exclusive, from sys_mremap)
 - VMA write lock (from move_vma)
 - anon_vma lock (from unlink_anon_vmas)

So it's not true that we always hold the page_table_lock for this.

Should this maybe have two separate parts, one for "for changing NULL
-> non-NULL" and one for "changing non-NULL to NULL"? Where the
NULL->non-NULL scenario uses the locks you listed and non-NULL->NULL
relies on write-locking the VMA and the anon_vma?

> +   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +These fields are used to both place the VMA within the reverse mapping, =
and for
> +anonymous mappings, to be able to access both related :c:struct:`!struct=
 anon_vma` objects
> +and the :c:struct:`!struct anon_vma` which folios mapped exclusively to =
this VMA should

typo: s/which folios/in which folios/

> +reside.
> +
> +Page tables
> +-----------
> +
> +We won't speak exhaustively on the subject but broadly speaking, page ta=
bles map
> +virtual addresses to physical ones through a series of page tables, each=
 of
> +which contain entries with physical addresses for the next page table le=
vel
> +(along with flags), and at the leaf level the physical addresses of the
> +underlying physical data pages (with offsets into these pages provided b=
y the
> +virtual address itself).
> +
> +In Linux these are divided into five levels - PGD, P4D, PUD, PMD and PTE=
. Huge
> +pages might eliminate one or two of these levels, but when this is the c=
ase we
> +typically refer to the leaf level as the PTE level regardless.

(That last sentence doesn't match my headcanon but I also don't have
any reference for what is common Linux kernel phrasing around this so
this isn't really an actionable comment.)

> +.. note:: In instances where the architecture supports fewer page tables=
 than
> +   five the kernel cleverly 'folds' page table levels, that is skips the=
m within
> +   the logic, regardless we can act as if there were always five.
> +
> +There are three key operations typically performed on page tables:
> +
> +1. **Installing** page table mappings - whether creating a new mapping o=
r
> +   modifying an existing one.
> +2. **Zapping/unmapping** page tables - This is what the kernel calls cle=
aring page

bikeshedding, feel free to ignore:
Maybe "Zapping/unmapping page table entries"? At least that's how I
always read "zap_pte_range()" in my head - "zap page table entry
range". Though I don't know if that's the canonical interpretation.

> +   table mappings at the leaf level only, whilst leaving all page tables=
 in
> +   place. This is a very common operation in the kernel performed on fil=
e
> +   truncation, the :c:macro:`!MADV_DONTNEED` operation via :c:func:`!mad=
vise`,
> +   and others. This is performed by a number of functions including
> +   :c:func:`!unmap_mapping_range`, :c:func:`!unmap_mapping_pages` and re=
verse
> +   mapping logic.
[...]
> +Locking rules
> +^^^^^^^^^^^^^
> +
> +We establish basic locking rules when interacting with page tables:
> +
> +* When changing a page table entry the page table lock for that page tab=
le
> +  **must** be held.

(except, as you described below, in free_pgtables() when changing page
table entries pointing to lower-level page tables)

> +* Reads from and writes to page table entries must be appropriately atom=
ic. See
> +  the section on atomicity below.
[...]
> +Page table installation
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +When allocating a P4D, PUD or PMD and setting the relevant entry in the =
above
> +PGD, P4D or PUD, the :c:member:`!mm->page_table_lock` must be held. This=
 is
> +acquired in :c:func:`!__p4d_alloc`, :c:func:`!__pud_alloc` and
> +:c:func:`!__pmd_alloc` respectively.
> +
> +.. note:: :c:func:`!__pmd_alloc` actually invokes :c:func:`!pud_lock` an=
d
> +   :c:func:`!pud_lockptr` in turn, however at the time of writing it ult=
imately
> +   references the :c:member:`!mm->page_table_lock`.
> +
> +Allocating a PTE will either use the :c:member:`!mm->page_table_lock` or=
, if
> +:c:macro:`!USE_SPLIT_PMD_PTLOCKS` is defined, used a lock embedded in th=
e PMD

typo: s/used/use/

> +physical page metadata in the form of a :c:struct:`!struct ptdesc`, acqu=
ired by
> +:c:func:`!pmd_ptdesc` called from :c:func:`!pmd_lock` and ultimately
> +:c:func:`!__pte_alloc`.
> +
> +Finally, modifying the contents of the PTE has special treatment, as thi=
s is a

nit: unclear what "this" refers to here - it looks like it refers to
"the PTE", but "the PTE is a lock" wouldn't make grammatical sense

> +lock that we must acquire whenever we want stable and exclusive access t=
o
> +entries pointing to data pages within a PTE, especially when we wish to =
modify
> +them.

I don't think "entries pointing to data pages" need any more locking
than other entries, like swap entries or migration markers?

> +This is performed via :c:func:`!pte_offset_map_lock` which carefully che=
cks to
> +ensure that the PTE hasn't changed from under us, ultimately invoking
> +:c:func:`!pte_lockptr` to obtain a spin lock at PTE granularity containe=
d within
> +the :c:struct:`!struct ptdesc` associated with the physical PTE page. Th=
e lock
> +must be released via :c:func:`!pte_unmap_unlock`.
> +
> +.. note:: There are some variants on this, such as
> +   :c:func:`!pte_offset_map_rw_nolock` when we know we hold the PTE stab=
le but
> +   for brevity we do not explore this.  See the comment for
> +   :c:func:`!__pte_offset_map_lock` for more details.
> +
> +When modifying data in ranges we typically only wish to allocate higher =
page
> +tables as necessary, using these locks to avoid races or overwriting any=
thing,
> +and set/clear data at the PTE level as required (for instance when page =
faulting
> +or zapping).
[...]
> +Page table moving
> +^^^^^^^^^^^^^^^^^
> +
> +Some functions manipulate page table levels above PMD (that is PUD, P4D =
and PGD
> +page tables). Most notable of these is :c:func:`!mremap`, which is capab=
le of
> +moving higher level page tables.
> +
> +In these instances, it is either required that **all** locks are taken, =
that is
> +the mmap lock, the VMA lock and the relevant rmap lock, or that the mmap=
 lock
> +and VMA locks are taken and some other measure is taken to avoid rmap ra=
ces (see
> +the comment in :c:func:`!move_ptes` in the :c:func:`!mremap` implementat=
ion for
> +details of how this is handled in this instance).

mremap() always takes the rmap locks when moving entire page tables,
and AFAIK that is necessary to avoid races that lead to TLB flushes
going to the wrong address. mremap() sometimes moves *leaf entries*
without holding rmap locks, but never entire tables.

move_pgt_entry() is confusingly written - need_rmap_locks is actually
always true in the NORMAL_* cases that move non-leaf entries.

> +You can observe that in the :c:func:`!mremap` implementation in the func=
tions
> +:c:func:`!take_rmap_locks` and :c:func:`!drop_rmap_locks` which perform =
the rmap
> +side of lock acquisition, invoked ultimately by :c:func:`!move_page_tabl=
es`.
> +
> +VMA lock internals
> +------------------
> +
> +This kind of locking is entirely optimistic - if the lock is contended o=
r a
> +competing write has started, then we do not obtain a read lock.
> +
> +The :c:func:`!lock_vma_under_rcu` function first calls :c:func:`!rcu_rea=
d_lock`
> +to ensure that the VMA is acquired in an RCU critical section, then atte=
mpts to

Maybe s/is acquired in/is looked up in/, to make it clearer that
you're talking about a VMA lookup?

> +VMA lock it via :c:func:`!vma_start_read`, before releasing the RCU lock=
 via
> +:c:func:`!rcu_read_unlock`.
> +
> +VMA read locks hold the read lock on the :c:member:`!vma->vm_lock` semap=
hore for
> +their duration and the caller of :c:func:`!lock_vma_under_rcu` must rele=
ase it
> +via :c:func:`!vma_end_read`.
> +
> +VMA **write** locks are acquired via :c:func:`!vma_start_write` in insta=
nces where a
> +VMA is about to be modified, unlike :c:func:`!vma_start_read` the lock i=
s always
> +acquired. An mmap write lock **must** be held for the duration of the VM=
A write
> +lock, releasing or downgrading the mmap write lock also releases the VMA=
 write
> +lock so there is no :c:func:`!vma_end_write` function.
> +
> +Note that a semaphore write lock is not held across a VMA lock. Rather, =
a
> +sequence number is used for serialisation, and the write semaphore is on=
ly
> +acquired at the point of write lock to update this.
> +
> +This ensures the semantics we require - VMA write locks provide exclusiv=
e write
> +access to the VMA.
> +
> +The VMA lock mechanism is designed to be a lightweight means of avoiding=
 the use
> +of the heavily contended mmap lock. It is implemented using a combinatio=
n of a
> +read/write semaphore and sequence numbers belonging to the containing
> +:c:struct:`!struct mm_struct` and the VMA.
> +
> +Read locks are acquired via :c:func:`!vma_start_read`, which is an optim=
istic
> +operation, i.e. it tries to acquire a read lock but returns false if it =
is
> +unable to do so. At the end of the read operation, :c:func:`!vma_end_rea=
d` is
> +called to release the VMA read lock. This can be done under RCU alone.

Please clarify what "This" refers to, and whether the part about RCU
is explaining an implementation detail or the API contract.

> +
> +Writing requires the mmap to be write-locked and the VMA lock to be acqu=
ired via
> +:c:func:`!vma_start_write`, however the write lock is released by the te=
rmination or
> +downgrade of the mmap write lock so no :c:func:`!vma_end_write` is requi=
red.
> +
> +All this is achieved by the use of per-mm and per-VMA sequence counts, w=
hich are
> +used in order to reduce complexity, especially for operations which writ=
e-lock
> +multiple VMAs at once.
> +
> +If the mm sequence count, :c:member:`!mm->mm_lock_seq` is equal to the V=
MA
> +sequence count :c:member:`!vma->vm_lock_seq` then the VMA is write-locke=
d. If
> +they differ, then they are not.

nit: "it is not"?

> +
> +Each time an mmap write lock is acquired in :c:func:`!mmap_write_lock`,
> +:c:func:`!mmap_write_lock_nested`, :c:func:`!mmap_write_lock_killable`, =
the
> +:c:member:`!mm->mm_lock_seq` sequence number is incremented via
> +:c:func:`!mm_lock_seqcount_begin`.
> +
> +Each time the mmap write lock is released in :c:func:`!mmap_write_unlock=
` or
> +:c:func:`!mmap_write_downgrade`, :c:func:`!vma_end_write_all` is invoked=
 which
> +also increments :c:member:`!mm->mm_lock_seq` via
> +:c:func:`!mm_lock_seqcount_end`.
> +
> +This way, we ensure regardless of the VMA's sequence number count, that =
a write
> +lock is not incorrectly indicated (since we increment the sequence count=
er on
> +acquiring the mmap write lock, which is required in order to obtain a VM=
A write
> +lock), and that when we release an mmap write lock, we efficiently relea=
se
> +**all** VMA write locks contained within the mmap at the same time.

Incrementing on mmap_write_lock() is not necessary for VMA locks; that
part is for future seqlock-style users of the MM sequence count that
want to work without even taking the VMA lock, with the new
mmap_lock_speculation_{begin,end} API. See commit db8f33d3b7698 and
the thread https://lore.kernel.org/linux-mm/20241010205644.3831427-5-andrii=
@kernel.org/
.


Return-Path: <linux-kernel+bounces-408228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B50C19C7C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 20:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5D89B25F88
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6957D204923;
	Wed, 13 Nov 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wmsk67xa"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4A1C9DCB
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 19:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527240; cv=none; b=YYaoCEKsWSnDyYhtVDxZImaihk5Rj/eyZEbqU2SBfxGbtjo6dhTYcvcqN6fly4rt6ifgkefGkrBxhpUA9CdYau/cPlZ8jS3kaQaDMr+qhKqKO4Iu3Hi7xv+v8xYDy6juZKdQ5OG+BpH41OopP9GW8CXbULLZQvfImQ57wU8I578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527240; c=relaxed/simple;
	bh=D13vdmCI3PcgmX5HqYWjeJV0/SwB4g2qZNjfWujodGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0Z0dUo0TGcBAYWFsU7JJdzxp8jY3fECJPbr3RmbFmD48b8qjRbAlmLsjAQ4GZhx2CtH0EXIAuof7G9pPRDDGLBu869PojFdFuKU3JgH+nk8rv2XEWiopGXqIZ/iEH52ullKNj0uoySFPL3iU6B5CAJzPcyd5tH+weH44ZHlDE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wmsk67xa; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e66ba398so1928e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731527237; x=1732132037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSJWU8y6bHQxtW/mJOGtqf8Fg9KxuncXsLFp1xbzR6g=;
        b=wmsk67xaLzJQGn1pC20NFsdKRCrtcNkg9SNIT80HoZNXEhQoTi834VY/qXbufEp3I7
         QgivKdi6cYfGaQziDGbSrUFixd1h6NDQbnuYX7/WnTNwLFpy8O6VeKnaGplzKtnB9+bE
         HBALfcXCTfHRzrQw8OELoGCX+ZUP/KomvPsQDQgMVXTk6q992SrZr1GNpZR/Wx/4MWGO
         CnoCVTcWPWcymFxCRDhV9txszB5EcJC0b19uqfLOnDOYYDuIr04hVe7IIXy77rYS8YL/
         jWLmeVykI6+1ws3xE71n5W3P12XW8cPah0SKFWZkOXJvBHa4pwtODHKapmenbo0IhPEA
         2C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731527237; x=1732132037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSJWU8y6bHQxtW/mJOGtqf8Fg9KxuncXsLFp1xbzR6g=;
        b=OEuZSMnpDGqd+V6TVDE6ODFAIYgjj2tQDZSV3PfyEkKWJ/VvoLy+yQXyHDJEyQZYZB
         /hnFmyHHyC4UYM/e+Jb1hUu+O0mXONcgnNtd61v+x/43IYxp0DCBNh6XfzSuhVfoohh/
         9iN3PpwSlxkIaygUVQKTTPryGTys9vWtnYuY/c51FTjH8WwagIHsleeozXsB/3E25zxM
         fbD8ixEStGYIlnX9zyy0OO67p211HGxmyY85yDYqOFezCaSbMRiBkSJlxWiMQeWHiW3Q
         jZvJoLE8JiaEbA+gCfDZuPF6mdVZvIxcL6prUm1yEH5QuQBmotGcJPzCN7AVcfbtf0O3
         oXeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYdjJL1agObTYrLfLqYGEEziSt6wf144+GHRQVuQTIEJC4JNActzWxak+P070uaTdtVRel3naO4lPjAGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuAP2RwneVBeqGeSmExgJFUsNUO1y0um9PNKnV9KzyTfwZ3b0
	80zW6DQ8mTcPK64kSIsD2u38TmXGv0G5ZJckBjz0s14DVQn/AEtFQMURYt1sBHWa7FOtD7mqUy/
	JuPglD39VBHcCUzYZVoXxFwGfuZM1nBTDR8Xo
X-Gm-Gg: ASbGncthOcfTCs4Tu2G4i/yCfQ37JfCMPEixrwJi0YRNFBoaqnZFIXWmZcg3gE6JXMu
	LFCmTTkyizjQJ4enOwmzLngz4uXeH3R2gQuOZOolcXOn/fVVAfeZlyZPfHfIw
X-Google-Smtp-Source: AGHT+IE3ppARTnzlYrCDB5JZuDPBOlh5drJ+grQRZjPODoYVls/AM2IZL036eqnlrknFAL86fkQryAkCrlIkacqzw7I=
X-Received: by 2002:ac2:5213:0:b0:530:ae18:810e with SMTP id
 2adb3069b0e04-53da4f492dfmr33731e87.5.1731527236243; Wed, 13 Nov 2024
 11:47:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
In-Reply-To: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 13 Nov 2024 20:46:39 +0100
Message-ID: <CAG48ez2=oP15_X_MqtDG22P6TZYpTr07-TZBk3Z_DvuwB6nJFQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Hillf Danton <hdanton@sina.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, SeongJae Park <sj@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:57=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Locking around VMAs is complicated and confusing. While we have a number =
of
> disparate comments scattered around the place, we seem to be reaching a
> level of complexity that justifies a serious effort at clearly documentin=
g
> how locks are expected to be used when it comes to interacting with
> mm_struct and vm_area_struct objects.
>
> This is especially pertinent as regards the efforts to find sensible
> abstractions for these fundamental objects in kernel rust code whose
> compiler strictly requires some means of expressing these rules (and
> through this expression, self-document these requirements as well as
> enforce them).
>
> The document limits scope to mmap and VMA locks and those that are
> immediately adjacent and relevant to them - so additionally covers page
> table locking as this is so very closely tied to VMA operations (and reli=
es
> upon us handling these correctly).
>
> The document tries to cover some of the nastier and more confusing edge
> cases and concerns especially around lock ordering and page table teardow=
n.
>
> The document is split between generally useful information for users of m=
m
> interfaces, and separately a section intended for mm kernel developers
> providing a discussion around internal implementation details.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Jann Horn <jannh@google.com>

except some typos and one inaccuracy:

> +* **mmap locks** - Each MM has a read/write semaphore :c:member:`!mmap_l=
ock`
> +  which locks at a process address space granularity which can be acquir=
ed via
> +  :c:func:`!mmap_read_lock`, :c:func:`!mmap_write_lock` and variants.
> +* **VMA locks** - The VMA lock is at VMA granularity (of course) which b=
ehaves
> +  as a read/write semaphore in practice. A VMA read lock is obtained via
> +  :c:func:`!lock_vma_under_rcu` (and unlocked via :c:func:`!vma_end_read=
`) and a
> +  write lock via :c:func:`!vma_start_write` (all VMA write locks are unl=
ocked
> +  automatically when the mmap write lock is released). To take a VMA wri=
te lock
> +  you **must** have already acquired an :c:func:`!mmap_write_lock`.
> +* **rmap locks** - When trying to access VMAs through the reverse mappin=
g via a
> +  :c:struct:`!struct address_space` or :c:struct:`!struct anon_vma` obje=
ct
> +  (reachable from a folio via :c:member:`!folio->mapping`) VMAs must be =
stabilised via

missing dot between sentences?

> +These fields describes the size, start and end of the VMA, and as such c=
annot be
> +modified without first being hidden from the reverse mapping since these=
 fields
> +are used to locate VMAs within the reverse mapping interval trees.

still a typo here, "these fields describes"

> +.. note:: In instances where the architecture supports fewer page tables=
 than
> +         five the kernel cleverly 'folds' page table levels, that is stu=
bbing
> +         out functions related to the skipped levels. This allows us to
> +         conceptually act is if there were always five levels, even if t=
he

typo: s/is if/as if/

> +1. **Traversing** page tables - Simply reading page tables in order to t=
raverse
> +   them. This only requires that the VMA is kept stable, so a lock which
> +   establishes this suffices for traversal (there are also lockless vari=
ants
> +   which eliminate even this requirement, such as :c:func:`!gup_fast`).
> +2. **Installing** page table mappings - Whether creating a new mapping o=
r
> +   modifying an existing one. This requires that the VMA is kept stable =
via an
> +   mmap or VMA lock (explicitly not rmap locks).

Arguably clearing A/D bits through the rmap, and switching PTEs
between present entries and migration entries, counts as "modifying an
existing one", but the locking for that is like for zapping/unmapping
(both page_idle_clear_pte_refs and try_to_migrate go through the
rmap). So "modifying an existing one" either needs more caveats or
more likely should just be moved to point three.

> +3. **Zapping/unmapping** page table entries - This is what the kernel ca=
lls
> +   clearing page table mappings at the leaf level only, whilst leaving a=
ll page
> +   tables in place. This is a very common operation in the kernel perfor=
med on
> +   file truncation, the :c:macro:`!MADV_DONTNEED` operation via
> +   :c:func:`!madvise`, and others. This is performed by a number of func=
tions
> +   including :c:func:`!unmap_mapping_range` and :c:func:`!unmap_mapping_=
pages`
> +   among others. The VMA need only be kept stable for this operation.
> +4. **Freeing** page tables - When finally the kernel removes page tables=
 from a
> +   userland process (typically via :c:func:`!free_pgtables`) extreme car=
e must
> +   be taken to ensure this is done safely, as this logic finally frees a=
ll page
> +   tables in the specified range, ignoring existing leaf entries (it ass=
umes the
> +   caller has both zapped the range and prevented any further faults or
> +   modifications within it).
> +
> +**Traversing** and **zapping** ranges can be performed holding any one o=
f the
> +locks described in the terminology section above - that is the mmap lock=
, the
> +VMA lock or either of the reverse mapping locks.
> +
> +That is - as long as you keep the relevant VMA **stable** - you are good=
 to go
> +ahead and perform these operations on page tables (though internally, ke=
rnel
> +operations that perform writes also acquire internal page table locks to
> +serialise - see the page table implementation detail section for more de=
tails).
> +
> +When **installing** page table entries, the mmap or VMA lock mut be held=
 to keep

typo: "must be held"

> +When performing a page table traversal and keeping the VMA stable, wheth=
er a
> +read must be performed once and only once or not depends on the architec=
ture
> +(for instance x86-64 does not require any special precautions).

Nitpick: In theory that'd still be a data race with other threads
concurrently installing page tables, though in practice compilers
don't seem to do anything bad with stuff like that.

> +A typical pattern taken when traversing page table entries to install a =
new
> +mapping is to optimistically determine whether the page table entry in t=
he table
> +above is empty, if so, only then acquiring the page table lock and check=
ing
> +again to see if it was allocated underneath is.

s/ is// ?

> +This is why :c:func:`!__pte_offset_map_lock` locklessly retrieves the PM=
D entry
> +for the PTE, carefully checking it is as expected, before acquiring the
> +PTE-specific lock, and then *again* checking that the PMD lock is as exp=
ected.

s/PMD lock is/PMD entry is/ ?

> +In these instances, it is required that **all** locks are taken, that is
> +the mmap lock, the VMA lock and the relevant rmap lock.

s/rmap lock/rmap locks/

> +VMA read locking is entirely optimistic - if the lock is contended or a =
competing
> +write has started, then we do not obtain a read lock.
> +
> +A VMA **read** lock is obtained by :c:func:`!lock_vma_under_rcu` functio=
n, which

"is obtained by lock_vma_under_rcu function" sounds weird, maybe
either "is obtained by lock_vma_under_rcu" or "is obtained by the
lock_vma_under_rcu function"?


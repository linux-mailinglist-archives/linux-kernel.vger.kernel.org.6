Return-Path: <linux-kernel+bounces-405879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07C79C597C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2D13B3AF96
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D6113635B;
	Tue, 12 Nov 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfZLypWH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C570831
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416340; cv=none; b=QvkhGdrPWx3mUGTIG8MWCNBOqJbJBg1hSEVuHfLFdH6F3LB2barWPmSjpiWTs+PxSmDdc1mPfPLQZWdfRkuR3wNNO1KcCsT8wpblv/rt0+GwmMUp4pHEQu5qbLjlm7MYOg2J5xfxpbdMCLwhzhfRNw4myaV2VkU83vb6uCRU+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416340; c=relaxed/simple;
	bh=125QBvBBFLhLFtk94EPTnczNUbDw16H36xs8BEZ9QCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh6PKEr8ZANqhhfCYymiG4Mmj+POoPsi7XDTCakEAXNxm0TBhgF/vMslQqzBmNWdb4/dUVmS4msvat8CNTPTUIXMC89E1iob/DiRxCG1zQTRs6glYL+FLgLXJXGujFwegWHfI5cKvcl3G5jJSkPZFP0qpNz0c5IlEECnjsVtqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lfZLypWH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so84695e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731416336; x=1732021136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfAeLaRFWdN/IgPZYBOM4W/Hl1zrpIvx0XX4d1JTnqQ=;
        b=lfZLypWHEtTIxaWglQdddlsRIhzkC5DC08cFm1mrB/pw+q5c+voCfwAP+lmyI8iUbL
         Q/iOn8ydYGJXzGtyibs86KZplfRrT8UNRBILEW+C+HqgzUxZDenXVgcmXPxLu1raEunH
         FwFS0whGiCQuBFPdZIxVTUenSFL6MdNJ2mi9fnBoNwFqDKclj2A7V9m5JTBozQwC4lvl
         jwGymb9dv+fFvdEJDnP3u0RkhL6Zd0hq1HuRJ2QQkugW9akZH5GPZPph79IF39TnRgAO
         5dv8MY+IqrlcuAhikULQ7erXTSaS9B/b1FXCRQNG9ihE3GQ06zwSEQqNA3BDMuPvnh+h
         wKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731416336; x=1732021136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfAeLaRFWdN/IgPZYBOM4W/Hl1zrpIvx0XX4d1JTnqQ=;
        b=F+E4n1FE36bLdOVCXSMijkgg6SnX6KToklCsTXzpovtY5y4ytiIiJULJ5/P5yH1gre
         ZREqCd++onKTUPnAjyan8HTM/bgjl3pkg9zvzh4U+3ZUDIdV1PM07mxFBTDlZMNaZqDC
         8FuT6/82R1OVWm6ebpMXjYZYQ37hEN1hO/5Zyup4OB7gYL1amu/ZMb0CbduYwhcYDS4n
         3CnPfxqkCdja9bDLuOunEQ2JBlj9yPs0xZrRmaeUrlxY7I/Q5KNLYlfR/VTg8MLkKYdv
         BtSkxWNRKPA6hXxyzzQJpYcYue3NUvruBUk0vmvYjK7APJGjUzlCW3kkKhoRnSLYpWLf
         zSBg==
X-Forwarded-Encrypted: i=1; AJvYcCUJzYlZWR3nE25V6Or33blLm8Ypm4kwJVgHrcIhNCqK1uQmCgkq+uzWFXtZhbIhax2D63s2MOQavvCVNFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBxFckCG+sivj1Z5sRuQUPDqU/SAU3aDN+fCZMAqftg/dOAtpL
	t8BJfS2g0rWPYKz33kVQq6zxxMPTQKbr2PFNLzn5HPBIIukCzuPfDy2rg+ByEP2J4+mnj4PykYY
	UDaDDyYord/FA4Oa//5cvquZ5/iGUvwLWC0rClLorm77bg1u50bsMinc=
X-Gm-Gg: ASbGncsTNnorYc9cEsW6ee1Z9Hbm1h0ZmWKaTOPjcmhfNTrq3GN3fGtAZAk2MiYBVAH
	hSis4s1yBKuouSLjouBvcYNNTes2ojKCF63hDbB2z8zo950bWZxD8N5/BtQ==
X-Google-Smtp-Source: AGHT+IHLz6K9tbthJlaw1F8JcdjVsquGr069haUcEPP6n2eZiBDEp86lACNry8D0/sD7HeRefdA8WFvsihfIk72p6Tk=
X-Received: by 2002:a05:600c:4d0d:b0:42b:a8fc:3937 with SMTP id
 5b1f17b1804b1-432cc969fdamr1541985e9.4.1731416335983; Tue, 12 Nov 2024
 04:58:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
 <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
 <CAH5fLgjeWKSH+4X+moy9Qc9YOp0dKAFZic6wBHjq_D6NHFmNRg@mail.gmail.com>
 <CAG48ez2bdKj9=rHuu221jtLK9P_a9j-MVx=pW=zg91RPrBrZ_w@mail.gmail.com> <CAH5fLgiVTK6mv5m4FaNFZMP4vHKo=8UbR9qm56aaB0Dmrp3x3w@mail.gmail.com>
In-Reply-To: <CAH5fLgiVTK6mv5m4FaNFZMP4vHKo=8UbR9qm56aaB0Dmrp3x3w@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 12 Nov 2024 13:58:20 +0100
Message-ID: <CAG48ez0S_dgXUM476vithROG3-su+-UcJGYs52fvSeg0LG1eWA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	John Hubbard <jhubbard@nvidia.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 1:12=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> On Mon, Nov 11, 2024 at 5:51=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On Mon, Nov 11, 2024 at 12:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.c=
om> wrote:
> > > Thanks a lot for your review!
> > >
> > > Note that there is a v7 already:
> > > https://lore.kernel.org/all/20241014-vma-v7-0-01e32f861195@google.com=
/
> >
> > Yeah, oops, somehow I only realized I was looking at an older version
> > of the series after sending my mail...
> >
> > > On Fri, Nov 8, 2024 at 8:02=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > > On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@googl=
e.com> wrote:
> > > >> These abstractions allow you to manipulate vmas. Rust Binder will =
uses
> > > >> these in a few different ways.
> > > >>
> > > >> In the mmap implementation, a VmAreaNew will be provided to the mm=
ap
> > > >> call which allows it to modify the vma in ways that are only okay =
during
> > > >> initial setup. This is the case where the most methods are availab=
le.
> > > >>
> > > >> However, Rust Binder needs to insert and remove pages from the vma=
 as
> > > >> time passes. When incoming messages arrive, pages may need to be
> > > >> inserted if space is missing, and in this case that is done by usi=
ng a
> > > >> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write=
_lock
> > > >> followed by vma_lookup followed by vm_insert_page. In this case, s=
ince
> > > >> mmap_write_lock is used, the VmAreaMut type will be in use.
> > > >
> > > > FYI, the way the C binder implementation uses vma_lookup() and
> > > > vm_insert_page() is not very idiomatic. The standard way of
> > > > implementing binder_alloc_free_page() would be to use something lik=
e
> > > > unmap_mapping_range() instead of using
> > > > vma_lookup()+zap_page_range_single(); though to set that up, you'd
> > > > have to create one inode per binder file, maybe with something like
> > > > the DRM subsystem's drm_fs_inode_new(). And instead of having
> > > > binder_install_single_page(), the standard way would be to let
> > > > binder_vm_fault() install PTEs lazily on fault. That way you'd neve=
r
> > > > have to take mmap locks or grab MM references yourself.
> > >
> > > Would that actually work? All writes happen from kernel space, so it'=
s
> > > not clear to me that we can trigger the fault handler from there. We
> > > can't use copy_to_user because the write happens from a different
> > > process than the one that owns the vma.
> > >
> > > That said, one alternative is to let Binder store an array of `struct
> > > page` and just write directly to those pages when writing from kernel
> > > space. Then binder_vm_fault() can look up the relevant page from the
> > > array when userspace attempts to read the data.
> >
> > Right, that's what I was thinking of - keep allocating pages at the
> > same point in time when binder currently does it, only defer mapping
> > them into userspace.
> >
> > > Though we could also
> > > just vm_insert_page() right before returning the address to userspace=
,
> > > since we know that userspace will read it right away after the syscal=
l
> > > returns.
> >
> > I think that is basically what binder does now?
>
> Right now binder calls vm_insert_page() right after calling
> alloc_page(), which means that vm_insert_page() happens in the process
> sending the message. But we could delay the call so that it happens in
> the process that receives the message instead (which is also the
> process that owns the mapping).

Ah, I see. I don't think that would make much of a difference in terms
of the complexity of MM locking, except that you'd save an
mmget_not_zero()...

> > > > Let me know if you think it would be helpful to see a prototype of
> > > > that in C - I think I can cobble that together, but doing it nicely
> > > > will require some work to convert at least some of the binder_alloc
> > > > locking to mutexes, and some more work to switch the ->f_mapping of
> > > > the binder file or something like that. (I guess modeling that in R=
ust
> > > > might be a bit of a pain though...)
> > >
> > > It would be useful to hear about what the advantages of
> > > unmap_mapping_range() are. I don't need a full prototype, I should be
> > > able to understand given a rough description of what the required
> > > changes are.
> >
> > The nice part is that basically, if you have a pointer to the file or
> > the inode, you can just do something like the following to zap a PTE:
> >
> > unmap_mapping_range(file->f_mapping, index, 1, 1);
> >
> > You don't have to take any locks yourself to make that work, you don't
> > even have to hold a reference to the mm_struct or anything like that,
> > and you don't need any of that logic you currently have in the C
> > binder driver to look up the VMA by address and revalidate it is still
> > the VMA you expect. The MM subsystem will automatically iterate
> > through all VMAs that overlap the specified range of the file's
> > address_space, and it will zap PTEs in the specified range (and it
> > even works fine if the VMAs have been moved or split or exist in
> > multiple processes or stuff like that). It's a similar story on the
> > allocation path. The only locks you need to explicitly take are
> > whatever locks the driver internally requires.
> >
> > Going through the fault handler and/or the address_space for
> > installing/removing PTEs, instead of using vma_lookup(), is also safer
> > because it implicitly ensures you can only operate on your own
> > driver's VMAs. From a glance at the Rust binder RFC
> > (https://lore.kernel.org/all/20231101-rust-binder-v1-19-08ba9197f637@go=
ogle.com/),
> > it looks like use_page_slow() just looks up the VMA at the expected
> > address and calls insert_page() on it. I don't immediately see
> > anything in the Rust Binder RFC that would prevent calling
> > insert_page() on a newly created VMA of a different type that has
> > appeared at the same address - which could cause the page to
> > inadvertently become writable by userspace (if the new VMA is
> > writable), could cause refcounted pages to be installed in VM_PFNMAP
> > regions that are supposed to only contain non-refcounted entries,
> > could probably cause type confusion when trying to install 4K pages in
> > hugetlb regions that can't contain 4K pages, and so on.
>
> Right ... I guess I'm missing an equivalent to binder_vma_close to
> ensure that once the vma is closed, we don't try to insert pages.

Yeah, I think that would work. (I think there currently is no way to
shrink a VMA without first splitting it, so you should see ->open()
and ->close() invocations when that happens.)

> I gave a suggestion to enforce that vm_insert_page is only called on
> MIXEDMAP vmas in my previous email. I guess that would prevent the
> type confusion you mention, but it still seems dangerous ... you risk
> that some other driver is storing special data in the private data of
> pages in the new vma, and if you insert a random page there, there
> could maybe be type confusion on the private data in the `struct
> page`?

Hmm, yeah, maybe...

> > Though I just realized, you're only doing this in the shrinker
> > callback where you're not supposed to sleep, but unmap_mapping_range()
> > requires sleeping locks. So I guess directly using
> > unmap_mapping_range() wouldn't work so well. I guess one way to
> > address that could be to add a trylock version of
> > unmap_mapping_range().
> >
> > Another more fancy solution to that would be to stop using shrinkers
> > entirely, and instead make binder pages show up as clean file pages on
> > the kernel's page allocation LRU lists, and let the kernel take care
> > of removing page mappings - basically similar to how reclaim works for
> > normal file pages. I'm a bit fuzzy on how this area of the kernel
> > works exactly; one option might be to do something similar to
> > aio_private_file(), creating a new anonymous inode - but unlike in
> > AIO, you'd then install that anonymous inode's address_space as the
> > i_mapping of the existing file in binder_open(), rather than creating
> > a new file. Then you could pin the inode's pages into a page pointer
> > array in the kernel (sort of like in aio_setup_ring(), except you'd
> > only do it on demand in binder_install_buffer_pages()), and then have
> > a "release_folio" operation in your address_space_operations that
> > drops your page reference if the page is currently unused. At that
> > point, the driver wouldn't really be participating in creating or
> > removing userspace PTEs at all, the kernel would mostly manage it for
> > you, except that you'd have to tell the kernel when it is okay to
> > reclaim pages, or something like that.
>
> Whether it's okay to reclaim a given page can flip-flop very quickly
> under some workflows. Changing that setting has to be a pretty fast
> operation.

I think one fast way to do that would be to track this internally in
binder (as is the case now), and then have address_space_operations
callbacks that the kernel invokes when it wants to know whether a page
can be discarded or not.

> > (I think in the Linux kernel, you might theoretically be able to cause
> > memory safety issues by deadlocking in particular ways - if you are
> > running on a CONFIG_PREEMPT kernel without panic_on_warn set, and
> > you're in a non-preemptible context because you're holding a spinlock
> > or such, and then you sleep because you try to wait on a mutex or
> > kmalloc() with GFP_KERNEL, the scheduler will print a "scheduling
> > while atomic" error message and then try to recover from that
> > situation by resetting the preempt_count and scheduling anyway. I
> > think that theoretically breaks the RCU read-side critical sections
> > normally implied by spinlocks once you return to the broken context,
> > though IIRC this situation will get fixed up at the next syscall
> > return or something along those lines. I haven't tried this though.)
>
> Sleeping in atomic context is a known area of concern. We're working
> on it. For now, just assume that it's one of the allowed bad things.
> Eventually we would like to handle it properly with this tool:
> https://www.memorysafety.org/blog/gary-guo-klint-rust-tools/

Ah, thanks for the pointer.

> > > >> +    /// Maps a single page at the given address within the virtua=
l memory area.
> > > >> +    ///
> > > >> +    /// This operation does not take ownership of the page.
> > > >> +    #[inline]
> > > >> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> =
Result {
> > > >> +        // SAFETY: By the type invariants, the caller holds the m=
map write lock, so this access is
> > > >> +        // not a data race. The page is guaranteed to be valid an=
d of order 0. The range of
> > > >> +        // `address` is already checked by `vm_insert_page`.
> > > >> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr()=
, address as _, page.as_ptr()) })
> > > >
> > > > vm_insert_page() has a kinda weird contract because there are two
> > > > contexts from which you can call it cleanly:
> > > >
> > > > 1. You can call it on a VmAreaRef (just like zap_page_range_single(=
),
> > > > you only need to hold an mmap read lock or VMA read lock, no write
> > > > lock is required); however, you must ensure that the VMA is already
> > > > marked VM_MIXEDMAP. This is the API contract under which you'd call
> > > > this from a fault handler.
> > > >
> > > > 2. You can call it on a VmAreaNew (and it will take care of setting
> > > > VM_MIXEDMAP for you).
> > > >
> > > > I think nothing would immediately crash if you called vm_insert_pag=
e()
> > > > on a VMA that does not yet have VM_MIXEDMAP while holding the mmap
> > > > lock in write mode; but that would permit weird scenarios where you
> > > > could, for example, have a userfaultfd context associated with a VM=
A
> > > > which becomes VM_MIXEDMAP, while normally you can't attach userfaul=
tfd
> > > > contexts to VM_MIXEDMAP VMAs. I don't think if that actually leads =
to
> > > > anything bad, but it would be a weird state that probably shouldn't=
 be
> > > > permitted.
> > > >
> > > > There are also safety requirements for the page being installed, bu=
t I
> > > > guess the checks that vm_insert_page() already does via
> > > > validate_page_before_insert() might be enough to make this safe...
> > >
> > > One way to handle this is to make an VmAreaRef::check_mixedmap that
> > > returns a VmAreaMixedMapRef after checking the flag. That type can th=
en
> > > have a vm_insert_page method.
> >
> > Sounds reasonable.
> >
> > > As for VmAreaNew, I'm not sure we should have it there. If we're not
> > > careful, it would be a way to set VM_MIXEDMAP on something that alrea=
dy
> > > has the VM_PFNMAP flag. We can probably just tell you to set VM_MIXED=
MAP
> > > directly and then go through the method on VmAreaRef.
> >
> > Makes sense.
> >
> > I guess one tricky part is that it might be bad if you could
>
> Seems like this sentence is incomplete?

Whoops, guess I got distracted while writing this...

I guess it could be bad if you could install page mappings before
changing the VMA flags in a way that makes the already-installed page
mappings invalid. But as long as you don't change the
VM_READ/VM_WRITE/VM_EXEC flags, and you never clear
VM_MIXEDMAP/VM_PFNMAP, I think that probably can't happen, so that
should be fine...


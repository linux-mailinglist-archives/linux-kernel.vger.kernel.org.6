Return-Path: <linux-kernel+bounces-404374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F89C4329
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D98B20548
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01271A3020;
	Mon, 11 Nov 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XR9PvOT"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EF914AD3F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343875; cv=none; b=pcsgwfwwb1U0R12OXy9yFmGxdB7AnY4+nEz98KgMwm/QgBR4HCYp/wbn4zQRuZ4lbzGodjumjOI30ThSOjyjqy2JY1NGe0Gfs6ZW/xEeRWxbjtRzOgqIM39KRqH4xqByNAZIiq2YLdM68l6W4u0WYWwpcYvOS34Sq85g44rsMRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343875; c=relaxed/simple;
	bh=PDqImS3xFdR9hu+KAmbHVSHO1Ju4mYqnl3c/CKjmx48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wc++vppy4r4iGAo8P+EXQC2Xj8D8+7O8A9MQ8v8Xyi7t2amQFpgzbn3PddUKQ2AEmBD0pXk4YORANEXNMl1zY97MB3j2hS9d4VJAYbCIh572cBbbt0+TdG9zfBSRvMlHHjIGaCuEgIo4U7wLnsMKoL4lzJOjvpM8TU2/MQeVJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XR9PvOT; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e681ba70so27748e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731343871; x=1731948671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyOCXe024hTIZhA+WfTeCexEWX70cnZXlZAwFj9OuSw=;
        b=3XR9PvOTLDvKDF5iKn4huqJHWMjCqZgpe7hfcqxiVfAOtxz7uncBdFdDuKEsdNtsom
         Utq2NBNuXqncAarxrDwRH5NSzJuNmBRjW6o/HdsUBjND8tzrzOBblkUp+bWSrN1YLsN/
         BeiB8fxtE3dY6hn1Pv8EqBqVJdfksOYMpds2HmZF69bflM+zJI0VKjKCFBg1JbaW9rxI
         yDqzb4MTvf+VnPXp5pUQNEHeDtYmPDUHIR0ZLC2YT02smUOrLT+Gk0ScT/FwjzjquUSt
         px+mxwH0hmgG8n8bjIkSRbI69Ygtz2/0+t2Squ3D/V+cTyLVa9+TFylmyWikR12A8OSJ
         odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343871; x=1731948671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyOCXe024hTIZhA+WfTeCexEWX70cnZXlZAwFj9OuSw=;
        b=KRZOiZoIFVEqwGNPJVS1tfriEZqGZ2okfU1H7n+PkIc8awY6uDrHOVNg///IKEPcvo
         cESeOdu02Zi+jHXtOUGg+uUaKEOlEel7jozzexk5ZD4kbnDKCsVtAl/CD0I0fFcnFzD3
         /2BjVWdugJ59wjyf8wavwfvN4d/lm0UTfwimv1iFUn1k+dTgDr6JXD3ZC8TRjyZQ+2Ym
         /RQEKBSEKMPmtabPrPdEcxa7cpkuKmqHo+gk081Tpey+mIDTPqYyaR5mD+SdH3QDCqSJ
         WujMKOON3kik/9Sx46M0JK1ZyhujRS2/ly0TmTjNlQodmrK+iP3rrD2296uqVfLyG+ts
         NAMg==
X-Forwarded-Encrypted: i=1; AJvYcCVXvORYP3AwHj2XcY3/9lO4R2KqzgSPexSH27nMKAnkGQfe4/LATti5GyAWXsdtF5nDy4yPAMpsr2p6Ug4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO69ReG0vRtpSR78sorV5Bjp/HuDh06b5LQyvIF7UDYuXtVrg
	8iRG1s+vU1ZqGzGGzKJ51zIqOviTe7Luj01OwuY4DL++Fs9y7dPmCbcnZ3Wdoub+WscNaDwa0Nh
	r+q8nuUjHyk4Pw7nbBCOfVFLBZALwGd4IbDPu
X-Gm-Gg: ASbGncuK0yBBaB7aU7uSqCoGfPPEOFlqIOL4dzKvGxmt0bQzlEX+Zx9YOgDbWbVsN8M
	XH4lggdLMwP6Y55LSa+38o8jrV+N6n4ohCKwyEySX7ss+sFppKlS+IUShGpo=
X-Google-Smtp-Source: AGHT+IGlAXrhQckNZnr1IIn4CFi/ZZaUahN0YiaLZAOXVri+zumzWJ6yDur/LM2E4z1ptkHWHBwNWiMywZZp2CQx0U4=
X-Received: by 2002:a19:ee1a:0:b0:530:ae18:810e with SMTP id
 2adb3069b0e04-53d8c42f8b3mr483707e87.5.1731343870517; Mon, 11 Nov 2024
 08:51:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
 <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com> <CAH5fLgjeWKSH+4X+moy9Qc9YOp0dKAFZic6wBHjq_D6NHFmNRg@mail.gmail.com>
In-Reply-To: <CAH5fLgjeWKSH+4X+moy9Qc9YOp0dKAFZic6wBHjq_D6NHFmNRg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 11 Nov 2024 17:50:33 +0100
Message-ID: <CAG48ez2bdKj9=rHuu221jtLK9P_a9j-MVx=pW=zg91RPrBrZ_w@mail.gmail.com>
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

On Mon, Nov 11, 2024 at 12:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
> Thanks a lot for your review!
>
> Note that there is a v7 already:
> https://lore.kernel.org/all/20241014-vma-v7-0-01e32f861195@google.com/

Yeah, oops, somehow I only realized I was looking at an older version
of the series after sending my mail...

> On Fri, Nov 8, 2024 at 8:02=E2=80=AFPM Jann Horn <jannh@google.com> wrote=
:
> > On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> >> These abstractions allow you to manipulate vmas. Rust Binder will uses
> >> these in a few different ways.
> >>
> >> In the mmap implementation, a VmAreaNew will be provided to the mmap
> >> call which allows it to modify the vma in ways that are only okay duri=
ng
> >> initial setup. This is the case where the most methods are available.
> >>
> >> However, Rust Binder needs to insert and remove pages from the vma as
> >> time passes. When incoming messages arrive, pages may need to be
> >> inserted if space is missing, and in this case that is done by using a
> >> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_loc=
k
> >> followed by vma_lookup followed by vm_insert_page. In this case, since
> >> mmap_write_lock is used, the VmAreaMut type will be in use.
> >
> > FYI, the way the C binder implementation uses vma_lookup() and
> > vm_insert_page() is not very idiomatic. The standard way of
> > implementing binder_alloc_free_page() would be to use something like
> > unmap_mapping_range() instead of using
> > vma_lookup()+zap_page_range_single(); though to set that up, you'd
> > have to create one inode per binder file, maybe with something like
> > the DRM subsystem's drm_fs_inode_new(). And instead of having
> > binder_install_single_page(), the standard way would be to let
> > binder_vm_fault() install PTEs lazily on fault. That way you'd never
> > have to take mmap locks or grab MM references yourself.
>
> Would that actually work? All writes happen from kernel space, so it's
> not clear to me that we can trigger the fault handler from there. We
> can't use copy_to_user because the write happens from a different
> process than the one that owns the vma.
>
> That said, one alternative is to let Binder store an array of `struct
> page` and just write directly to those pages when writing from kernel
> space. Then binder_vm_fault() can look up the relevant page from the
> array when userspace attempts to read the data.

Right, that's what I was thinking of - keep allocating pages at the
same point in time when binder currently does it, only defer mapping
them into userspace.

> Though we could also
> just vm_insert_page() right before returning the address to userspace,
> since we know that userspace will read it right away after the syscall
> returns.

I think that is basically what binder does now?

> > I guess the one benefit of the current implementation of C binder over
> > the more idiomatic approach is that it avoids taking a fault after
> > binder_install_buffer_pages(), but that's probably not such a hot path
> > that it matters...
>
> Saying "probably not a hot path" is dangerous when it comes to binder's
> allocator. :)

Each page installed by binder_install_buffer_pages() has to be torn
down by either binder's shrinker callback or by userspace unmapping
binder VMAs, right? So for this to be a hot path, the system would
have to either constantly create and destroy new binder FDs, or
execute the shrinker at a fairly high frequency while lots of binder
clients perform infrequent binder transactions?

> > Let me know if you think it would be helpful to see a prototype of
> > that in C - I think I can cobble that together, but doing it nicely
> > will require some work to convert at least some of the binder_alloc
> > locking to mutexes, and some more work to switch the ->f_mapping of
> > the binder file or something like that. (I guess modeling that in Rust
> > might be a bit of a pain though...)
>
> It would be useful to hear about what the advantages of
> unmap_mapping_range() are. I don't need a full prototype, I should be
> able to understand given a rough description of what the required
> changes are.

The nice part is that basically, if you have a pointer to the file or
the inode, you can just do something like the following to zap a PTE:

unmap_mapping_range(file->f_mapping, index, 1, 1);

You don't have to take any locks yourself to make that work, you don't
even have to hold a reference to the mm_struct or anything like that,
and you don't need any of that logic you currently have in the C
binder driver to look up the VMA by address and revalidate it is still
the VMA you expect. The MM subsystem will automatically iterate
through all VMAs that overlap the specified range of the file's
address_space, and it will zap PTEs in the specified range (and it
even works fine if the VMAs have been moved or split or exist in
multiple processes or stuff like that). It's a similar story on the
allocation path. The only locks you need to explicitly take are
whatever locks the driver internally requires.

Going through the fault handler and/or the address_space for
installing/removing PTEs, instead of using vma_lookup(), is also safer
because it implicitly ensures you can only operate on your own
driver's VMAs. From a glance at the Rust binder RFC
(https://lore.kernel.org/all/20231101-rust-binder-v1-19-08ba9197f637@google=
.com/),
it looks like use_page_slow() just looks up the VMA at the expected
address and calls insert_page() on it. I don't immediately see
anything in the Rust Binder RFC that would prevent calling
insert_page() on a newly created VMA of a different type that has
appeared at the same address - which could cause the page to
inadvertently become writable by userspace (if the new VMA is
writable), could cause refcounted pages to be installed in VM_PFNMAP
regions that are supposed to only contain non-refcounted entries,
could probably cause type confusion when trying to install 4K pages in
hugetlb regions that can't contain 4K pages, and so on.

Though I just realized, you're only doing this in the shrinker
callback where you're not supposed to sleep, but unmap_mapping_range()
requires sleeping locks. So I guess directly using
unmap_mapping_range() wouldn't work so well. I guess one way to
address that could be to add a trylock version of
unmap_mapping_range().

Another more fancy solution to that would be to stop using shrinkers
entirely, and instead make binder pages show up as clean file pages on
the kernel's page allocation LRU lists, and let the kernel take care
of removing page mappings - basically similar to how reclaim works for
normal file pages. I'm a bit fuzzy on how this area of the kernel
works exactly; one option might be to do something similar to
aio_private_file(), creating a new anonymous inode - but unlike in
AIO, you'd then install that anonymous inode's address_space as the
i_mapping of the existing file in binder_open(), rather than creating
a new file. Then you could pin the inode's pages into a page pointer
array in the kernel (sort of like in aio_setup_ring(), except you'd
only do it on demand in binder_install_buffer_pages()), and then have
a "release_folio" operation in your address_space_operations that
drops your page reference if the page is currently unused. At that
point, the driver wouldn't really be participating in creating or
removing userspace PTEs at all, the kernel would mostly manage it for
you, except that you'd have to tell the kernel when it is okay to
reclaim pages, or something like that.

> >> +    /// Sets the flags associated with the virtual memory area.
> >> +    ///
> >> +    /// The possible flags are a combination of the constants in [`fl=
ags`].
> >> +    #[inline]
> >> +    pub fn set_flags(&self, flags: usize) {
> >> +        // SAFETY: By the type invariants, the caller holds the mmap =
write lock, so this access is
> >> +        // not a data race.
> >> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags =3D flags=
 as _ };
> >
> > It can be a data race, for example you could race with pte_mkwrite()
> > called from remove_migration_pte(). (But that's an existing issue, the
> > same data race currently occurs with existing vm_flags updates in
> > other core kernel paths.)
> >
> > Separately from that: If you want to update the flags of existing
> > VMAs, you need to call vma_start_write() first. The vm_flags_set()
> > helper is designed to enforce this automatically.
> >
> > But really I think drivers normally don't change the flags of existing
> > VMAs anyway, only the flags of newly created VMAs; only core MM code
> > should be changing the flags of existing VMAs. You should maybe move
> > this method over into VmAreaNew.
>
> Yeah. Based on what you're saying, moving this method to VmAreaNew
> sounds like a good idea.
>
> Just to confirm, vma_start_write() is not necessary if I move it to
> VmAreaNew?

Right, the MM subsystem will have already internally called
vma_start_write() on the VMA by that time the ->mmap handler is
called.

> > There are ways to set VMA flags that are dangerous and invalid; I
> > think VM_PFNMAP|VM_MIXEDMAP would be an example (though that might not
> > actually lead to any actual bad consequences with the way the code is
> > currently written). Clearing VM_MIXEDMAP after calling
> > vm_insert_page() might be another one.
> >
> > VM_HUGETLB is also a flag you really shouldn't be touching from driver
> > code, that would cause type confusion through a bad cast in
> > unmap_single_vma -> __unmap_hugepage_range -> hstate_vma ->
> > hstate_file -> hstate_inode.
> >
> > I'm not sure how safe against programmer error this is supposed to be;
> > if you want the API to be safe even against silly blunders, I think
> > you'd have to at least allowlist which bits the driver may clear and
> > which bits it may set, and additionally deny at least the bad
> > combination VM_MIXEDMAP|VM_PFNMAP. Though you might want to introduce
> > higher-level helpers instead, so that a driver author doesn't blunder
> > by checking VM_WRITE without also clearing VM_MAYWRITE, which is a
> > somewhat common mistake that IIRC has led to several security bugs in
> > the past.
>
> In general, the goal is to write an abstraction such that you cannot
> trigger memory safety issues, even if triggering it involves a silly
> blunder. But only memory safety issues *must* be prevented; other issues
> such as BUG_ON or deadlocks or resource leaks need not be prevented,
> though those are still a nice-to-have when possible.

Ah, thanks for the context.

(I think in the Linux kernel, you might theoretically be able to cause
memory safety issues by deadlocking in particular ways - if you are
running on a CONFIG_PREEMPT kernel without panic_on_warn set, and
you're in a non-preemptible context because you're holding a spinlock
or such, and then you sleep because you try to wait on a mutex or
kmalloc() with GFP_KERNEL, the scheduler will print a "scheduling
while atomic" error message and then try to recover from that
situation by resetting the preempt_count and scheduling anyway. I
think that theoretically breaks the RCU read-side critical sections
normally implied by spinlocks once you return to the broken context,
though IIRC this situation will get fixed up at the next syscall
return or something along those lines. I haven't tried this though.)

I think the MM subsystem is a place where logic issues and memory
safety issues are closer to each other than in most other parts of the
kernel, since much of the logic in the MM subsystem is responsible for
managing memory...

> > I think the reasonable ways in which drivers might want to change
> > flags on a VmAreaNew are:
> >
> > 1. clear VM_MAYWRITE after checking VM_WRITE is unset
> > 2. (you could do the same with the VM_EXEC/VM_MAYEXEC bits)
> > 3. set VM_PFNMAP (only valid if not VM_MIXEDMAP and no PTEs have been
> > installed yet)
> > 4. set VM_MIXEDMAP (only valid if not VM_PFNMAP)
> > 5. set VM_IO/VM_DONTEXPAND
> > 6. set VM_DONTCOPY/VM_DONTDUMP (only permanently effective if VM_IO is =
also set)
>
> Okay, thanks for the overview. Comparing with the drivers I'm familiar
> with, they do the following:
>
> Ashmem: Clear VM_MAYREAD/VM_MAYWRITE/VM_MAYEXEC after checking
> VM_READ/VM_WRITE/VM_EXEC. This is allowed by what you say. (You did not
> mention VM_READ but I assume the same applies here.)

Yeah, I think VM_READ should work the same way. (With the caveat that
if you tried to create a mapping that can't be read but can be
written, or can't be read but can be executed, the restriction on read
access might be ineffective. In particular, arch-specific code for
mapping VMA access configuration to page table bits might silently
ignore such a restriction because the architecture has no way to
express write-only/execute-only access in the page table bits. I
imagine other kernel code might also have the assumption baked in that
at least write access implies read access.)

> Binder: Clears VM_MAYWRITE after checking VM_WRITE. Ok. Binder also sets
> the flags VM_DONTCOPY and VM_MIXEDMAP. Is a VM_PFNMAP check missing? But
> I guess that flag only gets set if you do so yourself, so the check is
> probably not necessary?

Yeah, VM_PFNMAP only gets set if you do that yourself (or if you call
remap_pfn_range(), which will do that for you).

> >> +    /// Maps a single page at the given address within the virtual me=
mory area.
> >> +    ///
> >> +    /// This operation does not take ownership of the page.
> >> +    #[inline]
> >> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Resu=
lt {
> >> +        // SAFETY: By the type invariants, the caller holds the mmap =
write lock, so this access is
> >> +        // not a data race. The page is guaranteed to be valid and of=
 order 0. The range of
> >> +        // `address` is already checked by `vm_insert_page`.
> >> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), ad=
dress as _, page.as_ptr()) })
> >
> > vm_insert_page() has a kinda weird contract because there are two
> > contexts from which you can call it cleanly:
> >
> > 1. You can call it on a VmAreaRef (just like zap_page_range_single(),
> > you only need to hold an mmap read lock or VMA read lock, no write
> > lock is required); however, you must ensure that the VMA is already
> > marked VM_MIXEDMAP. This is the API contract under which you'd call
> > this from a fault handler.
> >
> > 2. You can call it on a VmAreaNew (and it will take care of setting
> > VM_MIXEDMAP for you).
> >
> > I think nothing would immediately crash if you called vm_insert_page()
> > on a VMA that does not yet have VM_MIXEDMAP while holding the mmap
> > lock in write mode; but that would permit weird scenarios where you
> > could, for example, have a userfaultfd context associated with a VMA
> > which becomes VM_MIXEDMAP, while normally you can't attach userfaultfd
> > contexts to VM_MIXEDMAP VMAs. I don't think if that actually leads to
> > anything bad, but it would be a weird state that probably shouldn't be
> > permitted.
> >
> > There are also safety requirements for the page being installed, but I
> > guess the checks that vm_insert_page() already does via
> > validate_page_before_insert() might be enough to make this safe...
>
> One way to handle this is to make an VmAreaRef::check_mixedmap that
> returns a VmAreaMixedMapRef after checking the flag. That type can then
> have a vm_insert_page method.

Sounds reasonable.

> As for VmAreaNew, I'm not sure we should have it there. If we're not
> careful, it would be a way to set VM_MIXEDMAP on something that already
> has the VM_PFNMAP flag. We can probably just tell you to set VM_MIXEDMAP
> directly and then go through the method on VmAreaRef.

Makes sense.

I guess one tricky part is that it might be bad if you could


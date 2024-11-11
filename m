Return-Path: <linux-kernel+bounces-403989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F629C3D99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 12:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FC283808
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9312515666B;
	Mon, 11 Nov 2024 11:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HjMGTTks"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A21139578
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325285; cv=none; b=oRuqnVWzRbP53tXX+83nz4lgmEF6xmwTpkyJcMpYMoQQI2li3HgfJdNa4mUyh+LoXijuHOLqjb7tORP4qkEdw9QYaVD3iVoLVFqGOUKk96ITU5PBAOBu9dYxseoGQTrBqGKFKzsDheQpP/9zeSl/FHS1h2asqbkDj02EUgv2dQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325285; c=relaxed/simple;
	bh=pFHToxhtit3KSOXbtWTfhG3FKXj3eujtnJe9uUxDYt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quLbdc8tvaRUkUkndsdBlx5VR01iDlrBHv3exOGfdjlsz8bhq+u6kU1b1uYs9+jmHZ45CbkvFum5OZZrguYSRD0zCPAdtufcU1Hs0qxZLKch8XBJsN0L8no6UqOUWTkEgRkTBklkuqV+JOM5xMvVi7h1aa/7LEcSIdkJQf3k70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HjMGTTks; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso33939675e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731325282; x=1731930082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jes3Na1DwV42xEzjklXg+wdvGXekxNIMfWwwEe1FIhg=;
        b=HjMGTTks4e8GLdh6+hJpk0a3LoVOTYQOdj3O0SIhwuimm13cvXDjezD4c5LBd0pFSU
         m7GAIuPgds5C+CwdYfhenkeYhVrcWC8Y8XdvBfrTbj1UiwtH8S0e3owreXece6IxHh/C
         XpMYmqroQapN/DcWKwagkHt48chmBZhM9YASItG81mZI/y8wEAz5mt7zQZtK896qcAtD
         ZBLcmOkPOYvyzS/GsfEc9F+kMgr5z23AYch5/X5NYodkIhoTQg+XvW5+mJcBVZV0kR+E
         PLbnrJAFjJ81jm36UHja8dETbNgeZzutha0nvY1ZtruGHs8FZc/3C5F3ZzzQtrAhaIAm
         5ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731325282; x=1731930082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jes3Na1DwV42xEzjklXg+wdvGXekxNIMfWwwEe1FIhg=;
        b=aiqQ7nezNeL878XiJ/nBnvLgbmxxlNQS0pJlMcivc47ax6Uc8Sp2HBNnS+2lrK31u5
         i6ypgQ3v1uHxNGmGdLFGpjXmiuse2SYyrUGOCPGgh2+vTypjouF+F7svWjmrOFeVoDoI
         eD77SBKeDwxuQvgx/LFxaVENJWnh8Fy8Dsg1uDo0mtdk7hXTTVG6m9F2AezIWZREf1sW
         V0TpXFsBJT6RlmKHLdwHbuhBlo7hOKNr4CwbaZ5Hk7oUpE+A/6yZ7Z+7IVN+NpRFBYXB
         qPtqkRGLHOeOriDMglrgq2TjN7uljYscfAuWAOQA/LwldcSTb5Imeh/HmMWYXnoM/FcI
         fUWw==
X-Forwarded-Encrypted: i=1; AJvYcCUJG+h4i4MZF8kG+bQcjhcK37Z8nv/WgdreeXr38KqzAGQMEtG0vlzy0Hmf4LNO2K435yz8HWtd3dJQ3vQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD42Wukp/xPRjHESiu8HRXpowr5Ku9DSbtKf1nxdXDZi21XlDk
	3hIj17kbWoYcWVwDm7O5bBh3KQVqutrl29PfoWTNQTCZu/ICaTmrrxqL6pxkdeHjXztxl3YO+KP
	/7248dfONgFTOD8HHcb0oi3xjPwZstw/ZLFTx
X-Google-Smtp-Source: AGHT+IHzfc2BcPNSukzrW3L33WiMN3c1O2ZNRrzVojKRfByT7A79dGn6BkVVNEdwvofJvtOYDluIXwvOAM8KNQ+3FZ8=
X-Received: by 2002:a5d:584b:0:b0:37d:50e1:b3e1 with SMTP id
 ffacd0b85a97d-381f186ac29mr11711457f8f.16.1731325281595; Mon, 11 Nov 2024
 03:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
 <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
In-Reply-To: <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Nov 2024 12:41:10 +0100
Message-ID: <CAH5fLgjeWKSH+4X+moy9Qc9YOp0dKAFZic6wBHjq_D6NHFmNRg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Jann Horn <jannh@google.com>
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

Thanks a lot for your review!

Note that there is a v7 already:
https://lore.kernel.org/all/20241014-vma-v7-0-01e32f861195@google.com/

On Fri, Nov 8, 2024 at 8:02=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
>> These abstractions allow you to manipulate vmas. Rust Binder will uses
>> these in a few different ways.
>>
>> In the mmap implementation, a VmAreaNew will be provided to the mmap
>> call which allows it to modify the vma in ways that are only okay during
>> initial setup. This is the case where the most methods are available.
>>
>> However, Rust Binder needs to insert and remove pages from the vma as
>> time passes. When incoming messages arrive, pages may need to be
>> inserted if space is missing, and in this case that is done by using a
>> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_lock
>> followed by vma_lookup followed by vm_insert_page. In this case, since
>> mmap_write_lock is used, the VmAreaMut type will be in use.
>
> FYI, the way the C binder implementation uses vma_lookup() and
> vm_insert_page() is not very idiomatic. The standard way of
> implementing binder_alloc_free_page() would be to use something like
> unmap_mapping_range() instead of using
> vma_lookup()+zap_page_range_single(); though to set that up, you'd
> have to create one inode per binder file, maybe with something like
> the DRM subsystem's drm_fs_inode_new(). And instead of having
> binder_install_single_page(), the standard way would be to let
> binder_vm_fault() install PTEs lazily on fault. That way you'd never
> have to take mmap locks or grab MM references yourself.

Would that actually work? All writes happen from kernel space, so it's
not clear to me that we can trigger the fault handler from there. We
can't use copy_to_user because the write happens from a different
process than the one that owns the vma.

That said, one alternative is to let Binder store an array of `struct
page` and just write directly to those pages when writing from kernel
space. Then binder_vm_fault() can look up the relevant page from the
array when userspace attempts to read the data. Though we could also
just vm_insert_page() right before returning the address to userspace,
since we know that userspace will read it right away after the syscall
returns.

> I guess the one benefit of the current implementation of C binder over
> the more idiomatic approach is that it avoids taking a fault after
> binder_install_buffer_pages(), but that's probably not such a hot path
> that it matters...

Saying "probably not a hot path" is dangerous when it comes to binder's
allocator. :)

> Let me know if you think it would be helpful to see a prototype of
> that in C - I think I can cobble that together, but doing it nicely
> will require some work to convert at least some of the binder_alloc
> locking to mutexes, and some more work to switch the ->f_mapping of
> the binder file or something like that. (I guess modeling that in Rust
> might be a bit of a pain though...)

It would be useful to hear about what the advantages of
unmap_mapping_range() are. I don't need a full prototype, I should be
able to understand given a rough description of what the required
changes are.

>> Another use-case is the shrinker, where the mmap read lock is taken
>> instead, and zap_page_range_single is used to remove pages from the vma.
>> In this case, only the read lock is taken, so the VmAreaRef type will be
>> in use.
>
> I think this might also use unmap_mapping_range() in a more idiomatic
> implementation.
>
>> Future extensions could involve a VmAreaRcuRef for accessing vma methods
>> that are okay to use when holding just the rcu read lock. However, these
>> methods are not needed from Rust yet.
>
> You're probably talking about the VMA read lock here? There's not much
> you can do under just RCU.

I'm not sure. At Plumbers I was explaining the idea of splitting the
Rust abstractions into VmaAreaRef, VmAreaMut, VmAreaNew to some mm folks
and I was told that there is a fourth option involving RCU by ... I
think it was Lorenzo. I haven't looked into this aspect further since
that conversation.

>> +    /// Unmap pages in the given page range.
>> +    #[inline]
>> +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
>> +        // SAFETY: By the type invariants, the caller holds at least th=
e mmap read lock, so this
>> +        // access is okay. Any value of `address` and `size` is allowed=
.
>
> FWIW, if you passed in a size that is big enough to make the end
> address wrap around the end of the address space, I think you could at
> least hit a BUG_ON() in unmap_page_range(). I don't know what level of
> safety kernel Rust is going for though - I guess that might be
> acceptable?

Hitting a BUG_ON is acceptable.

>> +        unsafe {
>> +            bindings::zap_page_range_single(
>> +                self.as_ptr(),
>> +                address as _,
>> +                size as _,
>> +                core::ptr::null_mut(),
>> +            )
>> +        };
>> +    }
>> +}
>> +
>> +impl VmAreaMut {
>> +    /// Access a virtual memory area given a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that `vma` is valid for the duration of 'a,=
 and that the mmap write lock
>> +    /// (or stronger) is held for at least the duration of 'a.
>
> A mutable VMA should probably also come with the vma write lock held
> (meaning vma_start_write() has been called on it) - that's needed for
> almost all operations that actually mutate the VMA. (Though with the
> comments below, maybe you don't actually have any use for VmAreaMut
> for now.)

Agreed. See:
https://lore.kernel.org/r/CAH5fLggpEezhR_o+8RPmYix-JLZ47HwQLQM2OUzKQg3i7UYu=
5Q@mail.gmail.com

>> +    /// Sets the flags associated with the virtual memory area.
>> +    ///
>> +    /// The possible flags are a combination of the constants in [`flag=
s`].
>> +    #[inline]
>> +    pub fn set_flags(&self, flags: usize) {
>> +        // SAFETY: By the type invariants, the caller holds the mmap wr=
ite lock, so this access is
>> +        // not a data race.
>> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags =3D flags a=
s _ };
>
> It can be a data race, for example you could race with pte_mkwrite()
> called from remove_migration_pte(). (But that's an existing issue, the
> same data race currently occurs with existing vm_flags updates in
> other core kernel paths.)
>
> Separately from that: If you want to update the flags of existing
> VMAs, you need to call vma_start_write() first. The vm_flags_set()
> helper is designed to enforce this automatically.
>
> But really I think drivers normally don't change the flags of existing
> VMAs anyway, only the flags of newly created VMAs; only core MM code
> should be changing the flags of existing VMAs. You should maybe move
> this method over into VmAreaNew.

Yeah. Based on what you're saying, moving this method to VmAreaNew
sounds like a good idea.

Just to confirm, vma_start_write() is not necessary if I move it to
VmAreaNew?

> There are ways to set VMA flags that are dangerous and invalid; I
> think VM_PFNMAP|VM_MIXEDMAP would be an example (though that might not
> actually lead to any actual bad consequences with the way the code is
> currently written). Clearing VM_MIXEDMAP after calling
> vm_insert_page() might be another one.
>
> VM_HUGETLB is also a flag you really shouldn't be touching from driver
> code, that would cause type confusion through a bad cast in
> unmap_single_vma -> __unmap_hugepage_range -> hstate_vma ->
> hstate_file -> hstate_inode.
>
> I'm not sure how safe against programmer error this is supposed to be;
> if you want the API to be safe even against silly blunders, I think
> you'd have to at least allowlist which bits the driver may clear and
> which bits it may set, and additionally deny at least the bad
> combination VM_MIXEDMAP|VM_PFNMAP. Though you might want to introduce
> higher-level helpers instead, so that a driver author doesn't blunder
> by checking VM_WRITE without also clearing VM_MAYWRITE, which is a
> somewhat common mistake that IIRC has led to several security bugs in
> the past.

In general, the goal is to write an abstraction such that you cannot
trigger memory safety issues, even if triggering it involves a silly
blunder. But only memory safety issues *must* be prevented; other issues
such as BUG_ON or deadlocks or resource leaks need not be prevented,
though those are still a nice-to-have when possible.

> I think the reasonable ways in which drivers might want to change
> flags on a VmAreaNew are:
>
> 1. clear VM_MAYWRITE after checking VM_WRITE is unset
> 2. (you could do the same with the VM_EXEC/VM_MAYEXEC bits)
> 3. set VM_PFNMAP (only valid if not VM_MIXEDMAP and no PTEs have been
> installed yet)
> 4. set VM_MIXEDMAP (only valid if not VM_PFNMAP)
> 5. set VM_IO/VM_DONTEXPAND
> 6. set VM_DONTCOPY/VM_DONTDUMP (only permanently effective if VM_IO is al=
so set)

Okay, thanks for the overview. Comparing with the drivers I'm familiar
with, they do the following:

Ashmem: Clear VM_MAYREAD/VM_MAYWRITE/VM_MAYEXEC after checking
VM_READ/VM_WRITE/VM_EXEC. This is allowed by what you say. (You did not
mention VM_READ but I assume the same applies here.)

Binder: Clears VM_MAYWRITE after checking VM_WRITE. Ok. Binder also sets
the flags VM_DONTCOPY and VM_MIXEDMAP. Is a VM_PFNMAP check missing? But
I guess that flag only gets set if you do so yourself, so the check is
probably not necessary?

>> +    /// Maps a single page at the given address within the virtual memo=
ry area.
>> +    ///
>> +    /// This operation does not take ownership of the page.
>> +    #[inline]
>> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result=
 {
>> +        // SAFETY: By the type invariants, the caller holds the mmap wr=
ite lock, so this access is
>> +        // not a data race. The page is guaranteed to be valid and of o=
rder 0. The range of
>> +        // `address` is already checked by `vm_insert_page`.
>> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), addr=
ess as _, page.as_ptr()) })
>
> vm_insert_page() has a kinda weird contract because there are two
> contexts from which you can call it cleanly:
>
> 1. You can call it on a VmAreaRef (just like zap_page_range_single(),
> you only need to hold an mmap read lock or VMA read lock, no write
> lock is required); however, you must ensure that the VMA is already
> marked VM_MIXEDMAP. This is the API contract under which you'd call
> this from a fault handler.
>
> 2. You can call it on a VmAreaNew (and it will take care of setting
> VM_MIXEDMAP for you).
>
> I think nothing would immediately crash if you called vm_insert_page()
> on a VMA that does not yet have VM_MIXEDMAP while holding the mmap
> lock in write mode; but that would permit weird scenarios where you
> could, for example, have a userfaultfd context associated with a VMA
> which becomes VM_MIXEDMAP, while normally you can't attach userfaultfd
> contexts to VM_MIXEDMAP VMAs. I don't think if that actually leads to
> anything bad, but it would be a weird state that probably shouldn't be
> permitted.
>
> There are also safety requirements for the page being installed, but I
> guess the checks that vm_insert_page() already does via
> validate_page_before_insert() might be enough to make this safe...

One way to handle this is to make an VmAreaRef::check_mixedmap that
returns a VmAreaMixedMapRef after checking the flag. That type can then
have a vm_insert_page method.

As for VmAreaNew, I'm not sure we should have it there. If we're not
careful, it would be a way to set VM_MIXEDMAP on something that already
has the VM_PFNMAP flag. We can probably just tell you to set VM_MIXEDMAP
directly and then go through the method on VmAreaRef.

>> +impl VmAreaNew {
>> +    /// Access a virtual memory area given a raw pointer.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that `vma` is valid for the duration of 'a,=
 and that the vma is
>> +    /// currently undergoing initial VMA setup.
>> +    #[inline]
>> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) ->=
 &'a Self {
>> +        // SAFETY: The caller ensures that the invariants are satisfied=
 for the duration of 'a.
>> +        unsafe { &*vma.cast() }
>> +    }
>> +
>> +    /// Make this vma anonymous.
>> +    #[inline]
>> +    pub fn set_anonymous(&self) {
>> +        // SAFETY: The vma is not yet shared.
>> +        unsafe { (*self.as_ptr()).vm_ops =3D core::ptr::null() };
>> +    }
>
> What would you use this for? I don't think drivers are supposed to
> create anonymous VMAs. (Also, if you called this after inserting some
> non-anonymous pages into the VMA, that might confuse some core MM
> code, though I don't know if it can actually cause anything really
> bad.)

Hmm, I don't think I need it anymore. I can just drop it. But I'm
probably missing a way to set a custom vm_ops with your own
open/close/fault methods.

Alice


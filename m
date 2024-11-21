Return-Path: <linux-kernel+bounces-416830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46589D4AD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656B8287185
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704F91D356C;
	Thu, 21 Nov 2024 10:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1IJt4/oU"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9E91D3565
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184636; cv=none; b=nrtN77BPFzIhXkIkimkKuUYrscoc9tY3l21v5mBtbi0wOD0tHV1Ad7LDnY9Hl7bM8rhPUfs2qu++9RTl5BPjrWsbkCzusPfncm/R9AfoiVkMcQPuiG3+MR4ODIPoJorN1jV+wFu6zbyALtYEIiBhq8petpNfh1n4EvrH2VWA4ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184636; c=relaxed/simple;
	bh=r2vqhBLadvtHBUeCOMSUP+L28dC5F+GcWemMdh8ESS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbUSXTO+7vQx5pnZq99CGMRo4P2FfH/4gyDbbdHG77yaei8yXW3BVu8D2zs/QREfHUmhRMEyGaYFls65Y55SRGWEus+KfTbsIisyXIeVurtuV108bPxAYItuJqzaCz27p5RDkE7d4HiN/tz8hA8ECsqxHUgHp8E0KhZcNl3f0NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1IJt4/oU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-432d86a3085so5901225e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732184632; x=1732789432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlhoxgSKcYll6Lv3NUhKYXSAfrSERdcOsWs5wudsJzM=;
        b=1IJt4/oURHIkt3f9NLMswOyZBXsVUMTN8AIacbfwLPaQjD8zEYwWT3AcLZyL25tcxB
         ffQel3/4stRwM8kTHa/m4VOPhvZLacqOjs6NpspFQVCHlFJ2RMWjd4QIn3NpMpxWs516
         Z7ylQV0MTUnwH8I8t6tz8sutRJtZ/dxPsmhW/ohu1dyUBn6UYfy9pRSIGrLztOvuPtz2
         c9Qa/lZmbCQcffnLJ6ZriAwfonyatlZ9Isunrc90qNliRvFa9yU5CTqeHpvR73kQQvtZ
         6ER5Nd9P1WaSqRca8phDQ87aq2OJiX2AQMfo3HVM4WNICQ15CUbR3MONRGgBPa56RrlB
         vRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184632; x=1732789432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlhoxgSKcYll6Lv3NUhKYXSAfrSERdcOsWs5wudsJzM=;
        b=P7+VG41J8kp9JnzX++4h2des+KLkTZ1jeU/hIofqp19mhmu5WQq1nbfygMYTAVRMjD
         QSfTngi048ojQTbJydPmIUphKheaGuQub/PUeybBrx6mRrB+jmmz6SUfCCw1Q4vo//Ee
         I28fmngNwH7wYsopsxtgYIKgcZp9pvozO5DDYNbGE465uqNl/pSFLn6aXDA3Ce9J/m5a
         8y5IlfkPIqYNPdeOZmE5AfIomfl1T6zYH/w8laZaeAy5aOp8073PoOP+h8Kk4JqG3mnx
         rVUt4PAI6mbzlKHvfgyf9g/s1wFj1qFlQXsX++vz3PTcqpt7CuX2s+hDWzYimdfZMD6S
         iKLA==
X-Forwarded-Encrypted: i=1; AJvYcCXzOKOEgEPxCBTLfU4dehBrGjAP0vn7w7DRtluKMPrSYE7tkIYjQBJE4MuLb3JPbK4LsdyuGsXgxgjDh9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO7b2GzIKwbUUfn24HBSGjBWUsQ+6TrfIEz6/5ra2MwJwIJZZM
	sNpUZBNS673yKe0Pafjliq3PuMXXs0no5ttvHx2Uv5KOOsi4OmdTNzxaxjJgO/GsOQnEa4B55hm
	VcRIAjbqlFRnsLLz1LzbM+67VVYNZSoXXVQU/
X-Gm-Gg: ASbGncvWrc03MLnmNLGpriDr2BQcfgQADpXJvcczlRypxroEDElZ2LRURz8dhb/Eg2F
	Hph7FZoPhoqAl2PEhmMszYg7htCynfSaNhod54owon41xRSp0qPOEdguzhWhK6Q==
X-Google-Smtp-Source: AGHT+IHg4W/WUKGS8b99/9IFak+Ih4XgWQHTn4uE6zc4bD/TotmtUxHVl01wgBvUz//vn3WMdD++hod39LRNOsPPkVw=
X-Received: by 2002:a05:600c:b8a:b0:431:52a3:d9d9 with SMTP id
 5b1f17b1804b1-43348904026mr58688315e9.0.1732184631834; Thu, 21 Nov 2024
 02:23:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-2-eb31425da66b@google.com>
 <c26a63a3-0f1e-467d-b24f-3963e5e4e13d@lucifer.local>
In-Reply-To: <c26a63a3-0f1e-467d-b24f-3963e5e4e13d@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 11:23:39 +0100
Message-ID: <CAH5fLghdeBvbtC+aPq0mSr1io+DUt-J54zYagys63cK-4tictQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/7] mm: rust: add vm_area_struct methods that require
 read access
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:07=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:49:56PM +0000, Alice Ryhl wrote:
> > This adds a type called VmAreaRef which is used when referencing a vma
> > that you have read access to. Here, read access means that you hold
> > either the mmap read lock or the vma read lock (or stronger).
>
> This is pure nit and not important but...
>
> I know we screwed up naming in mm, with the god awful vm_area_struct (we
> abbreviate, for 2 letters, get bored, stop abbreviating, but throw in a
> struct for a laugh) or 'VMA', but I wonder if this would be better as
> VmaRef? Then again that's kinda terrible too.
>
> Sorry about that. I mean this isn't hugely important + ultimately _our
> fault_.
>
> VirtualMemoryAreaRef is worse... VirtMemAreaRef? OK. Maybe VMAreaRef is t=
he
> least bad...

Happy to use whichever name you prefer. :)

> > Additionally, a vma_lookup method is added to the mmap read guard, whic=
h
> > enables you to obtain a &VmAreaRef in safe Rust code.
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >  rust/helpers/mm.c      |   6 ++
> >  rust/kernel/mm.rs      |  21 ++++++
> >  rust/kernel/mm/virt.rs | 171 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 198 insertions(+)
> >
> > diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> > index 7201747a5d31..7b72eb065a3e 100644
> > --- a/rust/helpers/mm.c
> > +++ b/rust/helpers/mm.c
> > @@ -37,3 +37,9 @@ void rust_helper_mmap_read_unlock(struct mm_struct *m=
m)
> >  {
> >       mmap_read_unlock(mm);
> >  }
> > +
> > +struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
> > +                                           unsigned long addr)
> > +{
> > +     return vma_lookup(mm, addr);
> > +}
>
> I wonder whether we want to abstract some of the VMA iterator stuff,
> because it's inefficient to look up VMAs by doing this each time if you a=
re
> looking at, for instance, adjacent VMAs.
>
> But perhaps reasonable to defer doing that to later work?

Yeah, that should probably be deferred. Binder only has one vma per
mm, so iteration is not useful.

> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > index 84cba581edaa..ace8e7d57afe 100644
> > --- a/rust/kernel/mm.rs
> > +++ b/rust/kernel/mm.rs
> > @@ -12,6 +12,8 @@
> >  };
> >  use core::{ops::Deref, ptr::NonNull};
> >
> > +pub mod virt;
> > +
> >  /// A wrapper for the kernel's `struct mm_struct`.
> >  ///
> >  /// Since `mm_users` may be zero, the associated address space may not=
 exist anymore. You can use
> > @@ -210,6 +212,25 @@ pub struct MmapReadGuard<'a> {
> >      _nts: NotThreadSafe,
> >  }
> >
> > +impl<'a> MmapReadGuard<'a> {
> > +    /// Look up a vma at the given address.
> > +    #[inline]
> > +    pub fn vma_lookup(&self, vma_addr: usize) -> Option<&virt::VmAreaR=
ef> {
>
> Kind of lovely to have functions under the read guard and then knowing th=
at
> hey - we must hold the read lock to be able to do this.
>
> Imagine, a programming language with actual types... :P

:)

> > +        // SAFETY: We hold a reference to the mm, so the pointer must =
be valid. Any value is okay
> > +        // for `vma_addr`.
> > +        let vma =3D unsafe { bindings::vma_lookup(self.mm.as_raw(), vm=
a_addr as _) };
>
> Why do we say 'as _' here?

This is an integer cast where the target type of the cast is inferred
by the compiler. It will go away once this lands:
https://lore.kernel.org/rust-for-linux/20240913213041.395655-1-gary@garyguo=
.net/

> > +
> > +        if vma.is_null() {
> > +            None
> > +        } else {
> > +            // SAFETY: We just checked that a vma was found, so the po=
inter is valid. Furthermore,
> > +            // the returned area will borrow from this read lock guard=
, so it can only be used
> > +            // while the mmap read lock is still held.
>
> Lovely!
>
> > +            unsafe { Some(virt::VmAreaRef::from_raw(vma)) }
> > +        }
> > +    }
> > +}
> > +
> >  impl Drop for MmapReadGuard<'_> {
> >      #[inline]
> >      fn drop(&mut self) {
> > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > new file mode 100644
> > index 000000000000..1e755dca46dd
> > --- /dev/null
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Virtual memory.
>
> Trivial rust q again but does this result in a heading in generated docs =
or
> something?

Yes, this becomes module documentation. Check out:
https://rust.docs.kernel.org/kernel/
or try out `make LLVM=3D1 rustdoc`

> > +use crate::{bindings, types::Opaque};
> > +
> > +/// A wrapper for the kernel's `struct vm_area_struct` with read acces=
s.
> > +///
> > +/// It represents an area of virtual memory.
> > +///
> > +/// # Invariants
> > +///
> > +/// The caller must hold the mmap read lock or the vma read lock.
>
> Might be worth mentioning here that you have yet to abstract the vma lock=
?

I do that in the next patch.

> > +#[repr(transparent)]
> > +pub struct VmAreaRef {
> > +    vma: Opaque<bindings::vm_area_struct>,
> > +}
> > +
> > +// Methods you can call when holding the mmap or vma read lock (or str=
ong). They must be usable no
> > +// matter what the vma flags are.
>
> typo: 'or strong' -> 'or stronger'.
>
> Nitty, but perhaps say 'Methods must be usable' rather than 'they' to be
> totally clear.

Will reword.

> > +impl VmAreaRef {
> > +    /// Access a virtual memory area given a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, and that the mmap read lock
> > +    /// (or stronger) is held for at least the duration of 'a.
>
> Well, VMA locks make this more complicated, in that we can just hold a VM=
A
> lock. But again, perhaps worth doing this incrementally and just talk abo=
ut
> mmap locks to start with.
>
> However since we reference VMA locks elsewhere, we should reference them
> here (and probably worth mentioning that they are not yet abstracted).

Oh I forgot to update this, it should say "mmap or vma read lock".

> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -=
> &'a Self {
> > +        // SAFETY: The caller ensures that the invariants are satisfie=
d for the duration of 'a.
> > +        unsafe { &*vma.cast() }
> > +    }
> > +
> > +    /// Returns a raw pointer to this area.
> > +    #[inline]
> > +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
> > +        self.vma.get()
> > +    }
> > +
> > +    /// Returns the flags associated with the virtual memory area.
> > +    ///
> > +    /// The possible flags are a combination of the constants in [`fla=
gs`].
> > +    #[inline]
> > +    pub fn flags(&self) -> vm_flags_t {
> > +        // SAFETY: By the type invariants, the caller holds at least t=
he mmap read lock, so this
> > +        // access is not a data race.
> > +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
>
> Hm what's up with this __bindgen_anon_N stuff?

Whenever you have a `struct { ... }` or `union { ... }` in the middle
of a struct, bindgen generates additional types for them because Rust
doesn't have a direct equivalent.

> > +    }
> > +
> > +    /// Returns the start address of the virtual memory area.
> > +    #[inline]
> > +    pub fn start(&self) -> usize {
>
> Is usize guranteed to be equivalent to unsigned long?

They are guaranteed to have the same size, yes.

But again, right now `unsigned long` is being translated to whichever
one of u32 or u64 has the same size as usize, instead of just being
translated to usize. Thus the annoying casts. We can get rid of them
as soon as
https://lore.kernel.org/rust-for-linux/20240913213041.395655-1-gary@garyguo=
.net/
lands.

> > +        // SAFETY: By the type invariants, the caller holds at least t=
he mmap read lock, so this
> > +        // access is not a data race.
> > +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm=
_start as _ }
> > +    }
> > +
> > +    /// Returns the end address of the virtual memory area.
>
> Worth mentioning that it's an _exclusive_ end.

Sure, I'll add that.

> > +    #[inline]
> > +    pub fn end(&self) -> usize {
> > +        // SAFETY: By the type invariants, the caller holds at least t=
he mmap read lock, so this
> > +        // access is not a data race.
> > +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm=
_end as _ }
> > +    }
> > +
> > +    /// Unmap pages in the given page range.
>
> This needs some more description, as 'unmapping' pages is unfortunately a=
n
> overloaded term in the kernel and this very much might confuse people as
> opposed to e.g. munmap()'ing a range.
>
> I'd say something like 'clear page table mappings for the range at the le=
af
> level, leaving all other page tables intact, freeing any memory reference=
d
> by the VMA in this range (anonymous memory is completely freed, file-back=
ed
> memory has its reference count on page cache folio's dropped, any dirty
> data will still be written back to disk as usual)'.

Sure, will add that to the docs.

> > +    #[inline]
> > +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> > +        // SAFETY: By the type invariants, the caller has read access =
to this VMA, which is
> > +        // sufficient for this method call. This method has no require=
ments on the vma flags. Any
> > +        // value of `address` and `size` is allowed.
> > +        unsafe {
> > +            bindings::zap_page_range_single(
>
> Hm weirdly I see this in rust/bindings/bindings_generated.rs but not in
> rust/helpers/mm.c is this intended?
>
> Is this meant to be generated _from_ somewhere? Is something missing for
> that?

The bindings_generated.rs file is generated at built-time from C
headers. The zap_page_range_single is a real function, not a fake
static inline header-only function, so bindgen is able to generate it
without anything in rust/helpers.

> > +                self.as_ptr(),
> > +                address as _,
> > +                size as _,
> > +                core::ptr::null_mut(),
> > +            )
> > +        };
> > +    }
> > +}
> > +
> > +/// The integer type used for vma flags.
> > +#[doc(inline)]
> > +pub use bindings::vm_flags_t;
>
> Where do you declare this type?

It's declared in include/linux/mm_types.h

> > +
> > +/// All possible flags for [`VmAreaRef`].
>
> Well you've not specified all as they're some speciailist ones and ones
> that depend on config flags, so maybe worth just saying 'core' flags?

Sure.

> > +pub mod flags {
>
> Pure rust noobie question (again...) but what is a 'mod'?

It's a module.

> > +    use super::vm_flags_t;
> > +    use crate::bindings;
> > +
> > +    /// No flags are set.
> > +    pub const NONE: vm_flags_t =3D bindings::VM_NONE as _;
>
> This is strictly not a flag, as is the 0 value (and is used 'cleverly' in
> kernel code when we have flags that are defined under some circumstances
> but not others, where we can then assign these values to VM_NONE if not
> available, ensuring all |=3D ... operations are no-ops and all &
> ... expressions evaluate to false) but I guess it doesn't matter all too
> much right?

Ultimately it's just a bunch of integer constants. We can include or
exclude whichever ones we prefer.

> > +    /// Mapping allows reads.
> > +    pub const READ: vm_flags_t =3D bindings::VM_READ as _;
> > +
> > +    /// Mapping allows writes.
> > +    pub const WRITE: vm_flags_t =3D bindings::VM_WRITE as _;
> > +
> > +    /// Mapping allows execution.
> > +    pub const EXEC: vm_flags_t =3D bindings::VM_EXEC as _;
> > +
> > +    /// Mapping is shared.
> > +    pub const SHARED: vm_flags_t =3D bindings::VM_SHARED as _;
> > +
> > +    /// Mapping may be updated to allow reads.
> > +    pub const MAYREAD: vm_flags_t =3D bindings::VM_MAYREAD as _;
> > +
> > +    /// Mapping may be updated to allow writes.
> > +    pub const MAYWRITE: vm_flags_t =3D bindings::VM_MAYWRITE as _;
> > +
> > +    /// Mapping may be updated to allow execution.
> > +    pub const MAYEXEC: vm_flags_t =3D bindings::VM_MAYEXEC as _;
> > +
> > +    /// Mapping may be updated to be shared.
> > +    pub const MAYSHARE: vm_flags_t =3D bindings::VM_MAYSHARE as _;
> > +
> > +    /// Page-ranges managed without `struct page`, just pure PFN.
> > +    pub const PFNMAP: vm_flags_t =3D bindings::VM_PFNMAP as _;
> > +
> > +    /// Memory mapped I/O or similar.
> > +    pub const IO: vm_flags_t =3D bindings::VM_IO as _;
> > +
> > +    /// Do not copy this vma on fork.
> > +    pub const DONTCOPY: vm_flags_t =3D bindings::VM_DONTCOPY as _;
> > +
> > +    /// Cannot expand with mremap().
> > +    pub const DONTEXPAND: vm_flags_t =3D bindings::VM_DONTEXPAND as _;
> > +
> > +    /// Lock the pages covered when they are faulted in.
> > +    pub const LOCKONFAULT: vm_flags_t =3D bindings::VM_LOCKONFAULT as =
_;
> > +
> > +    /// Is a VM accounted object.
> > +    pub const ACCOUNT: vm_flags_t =3D bindings::VM_ACCOUNT as _;
> > +
> > +    /// should the VM suppress accounting.
> > +    pub const NORESERVE: vm_flags_t =3D bindings::VM_NORESERVE as _;
> > +
> > +    /// Huge TLB Page VM.
> > +    pub const HUGETLB: vm_flags_t =3D bindings::VM_HUGETLB as _;
> > +
> > +    /// Synchronous page faults.
>
> Might be worth mentioning that this is DAX-specific only.

Will add.

> > +    pub const SYNC: vm_flags_t =3D bindings::VM_SYNC as _;
> > +
> > +    /// Architecture-specific flag.
> > +    pub const ARCH_1: vm_flags_t =3D bindings::VM_ARCH_1 as _;
> > +
> > +    /// Wipe VMA contents in child..
>
> Typo '..' - also probably worth saying 'wipe VMA contents in child on
> fork'.

Will add.

> > +    pub const WIPEONFORK: vm_flags_t =3D bindings::VM_WIPEONFORK as _;
> > +
> > +    /// Do not include in the core dump.
> > +    pub const DONTDUMP: vm_flags_t =3D bindings::VM_DONTDUMP as _;
> > +
> > +    /// Not soft dirty clean area.
> > +    pub const SOFTDIRTY: vm_flags_t =3D bindings::VM_SOFTDIRTY as _;
> > +
> > +    /// Can contain `struct page` and pure PFN pages.
> > +    pub const MIXEDMAP: vm_flags_t =3D bindings::VM_MIXEDMAP as _;
> > +
> > +    /// MADV_HUGEPAGE marked this vma.
> > +    pub const HUGEPAGE: vm_flags_t =3D bindings::VM_HUGEPAGE as _;
> > +
> > +    /// MADV_NOHUGEPAGE marked this vma.
> > +    pub const NOHUGEPAGE: vm_flags_t =3D bindings::VM_NOHUGEPAGE as _;
> > +
> > +    /// KSM may merge identical pages.
> > +    pub const MERGEABLE: vm_flags_t =3D bindings::VM_MERGEABLE as _;
> > +}
> >
>
> I'd say these comments are a bit sparse and need more detail, but they ar=
e
> literally comments from include/linux/mm.h and therefore,  again, our fau=
lt
> so this is fine :)

Happy to add more if you tell me what you'd like to see. ;)

Alice


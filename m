Return-Path: <linux-kernel+bounces-416787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 292DE9D4A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E291F21DD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD9C16C6B7;
	Thu, 21 Nov 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuHtuEdW"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76386175562
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732182747; cv=none; b=DKLRX8xESfVmwmyOut/ZkZkzRGE+vWsNahl9N5W7kQTY0gVtLnPLl4VSZeAdX0JcLKXow9emyHtSXnt+/v6IJHIHuC3DYmooNugwN9PIHp5uHqyOKbrUQ8479x4v2gmMg9jttVBLhD6qwJGdi0WuM0hS7vYUrfc2ztXFDIti5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732182747; c=relaxed/simple;
	bh=hYI3Fe90H9LAddlEQlijXiqoskgY3nldnugpXl1GViE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TMpJyboukcvdNk/8tEL1DXKddoQaFR/UqRCr4lkUFVUBABFnD/2KxQjSYi6PA5R20nB34mnlDWrxhU+1O5Iwxorr6ynpDfi+w+CTtPn+f/2f0W2/+jYf+C9bO2nu1YeyPCMSmB/yoqksTKTaWDtz+cfwUQdbFrPfZS7pQOGcjCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CuHtuEdW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-382442b7d9aso589923f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 01:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732182743; x=1732787543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTBWOwGZXjE8ga3DQF6sB2opa7IGPizFg1SgL/vf2OM=;
        b=CuHtuEdWXV2MC51JgzdQvvn0ePf2MwOQPAeHRxUTQwyFSDD3FlcVguL5GLiG9YoGKw
         MOzd0I6+j50gzIJnyPuAyczGQPJHNb+6jGQiHg5iATQSV8pwiiJfkoBw59/G/WnpY/hH
         yQc5VsbFhqF5Cm+C075qnRd+/YLBvmCqmrre+3K5nSTyOXMrj6PodRGK3uL3OP28hjTf
         SdknGnPVz8OAG1ujGv3+yy6qfgMjXaw/REF6CeLGtzCbU5UZGr3KWrtsdG1MS8dmVVFT
         jX9gCBbYZ56LQ7+ORKZFfCDdvt1p5d/B15uJbKl/P4nuKFlr1WVsxWiuTG/OF1mSwyad
         v3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732182743; x=1732787543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTBWOwGZXjE8ga3DQF6sB2opa7IGPizFg1SgL/vf2OM=;
        b=aya7caazwVnBUhHm6ITm2XlcuI29qHZcVfy/qQ9bbkLzoddYjTNddoIc1XKs3Ldab9
         1VapOZuzb4tJDSyVtiOmb5ebA7d4m7I3ee6A1q0hELgYuwjjDMadscyVyEcQBJ1iNdTL
         e2VNg3j0I2toC+PfUQCsQc5p5BdyJJZJFJ92dCrvRY4fjWp5D6bMrSWIpDQA962P+If5
         tM4aZAVF84LLP5PMACR4mRz6I0lvnogzqDdTSCD2v7Grn0zcs5TYr7v2dl8Xun0QZSWF
         ZOWKmyL1YNefMdW3Y38Q3v07grUTg/Q+irI7k8CR+ZilHb3v9ykMhmxm8FktODDK6CeF
         Mc6A==
X-Forwarded-Encrypted: i=1; AJvYcCVKO6npx4vqSMjkhPjrJWbD+ae6Os0cJ+FTdya9e3vcENIqIyUy5abbgsdrtzgGaBOnh8Zp0IuxOQxcuKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHTP+bwMjZ/EaRM+MyveHHxNijtocdn9iaOj5RVTvp3Rq+JR3
	3JhnItKvZapeO7Tp5OpuTN65AdGlvxrl/K2NDU7q6L/2/WZfECHw0goZrm1rCCFpXDkhlbuebaL
	wjIGHMn/xhS41VpeWvWrVaE63iQ24U4XPkyUhVU53NxQYBIx9jLc0fk4=
X-Gm-Gg: ASbGncuafgFtOz5NtVSQmB8Nl25wTET+Tlp3QJ4D/YXmMzL5lr/iOEOyNyJM0DOTWix
	GXGUPIlU68iE8xpV9bViq1M4iCHH8SQJ/IRZhwQdjkhglnyCOgBtPxVtImActyQ==
X-Google-Smtp-Source: AGHT+IFRDM9zgYI7PpWvm/L6eR+CyCzkGhRP2rQe+oWfJhPeIwpQkyur4SUQpHd//2z4ia4wRuKzD42aTVJpkYLYiKQ=
X-Received: by 2002:a5d:6d8d:0:b0:382:3afd:1273 with SMTP id
 ffacd0b85a97d-38254afa4f2mr4875903f8f.30.1732182742505; Thu, 21 Nov 2024
 01:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120-vma-v8-0-eb31425da66b@google.com> <20241120-vma-v8-1-eb31425da66b@google.com>
 <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
In-Reply-To: <0c6f4dbb-ff09-439c-b736-35568c1450cc@lucifer.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 21 Nov 2024 10:52:09 +0100
Message-ID: <CAH5fLgi5xbL=L-Mz_u64sA1QGLtxOgEvG_y4aJV2_mfy4iCxyg@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] mm: rust: add abstraction for struct mm_struct
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

On Wed, Nov 20, 2024 at 7:13=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Nov 20, 2024 at 02:49:55PM +0000, Alice Ryhl wrote:
> > These abstractions allow you to reference a `struct mm_struct` using
> > both mmgrab and mmget refcounts. This is done using two Rust types:
> >
> > * Mm - represents an mm_struct where you don't know anything about the
> >   value of mm_users.
> > * MmWithUser - represents an mm_struct where you know at compile time
> >   that mm_users is non-zero.
> >
> > This allows us to encode in the type system whether a method requires
> > that mm_users is non-zero or not. For instance, you can always call
> > `mmget_not_zero` but you can only call `mmap_read_lock` when mm_users i=
s
> > non-zero.
>
> It's kind of interesting to represent these things this way, I like the
> self-documenting element of that.
>
> >
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>
> So obviously I'm not a rust person (yet... yet :) so from my side I can
> only look at things from an mm perspective conceptually. To avoid boring
> everyone I won't repeat this and instead you can take it as read.
>
> I will obviously inevitably ask a TON of questions as a result of not bei=
ng
> a rust person so, bear with me...
>
> > ---
> >  rust/helpers/helpers.c |   1 +
> >  rust/helpers/mm.c      |  39 +++++++++
> >  rust/kernel/lib.rs     |   1 +
> >  rust/kernel/mm.rs      | 219 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  4 files changed, 260 insertions(+)
> >
> > diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> > index 20a0c69d5cc7..60a488eb4efe 100644
> > --- a/rust/helpers/helpers.c
> > +++ b/rust/helpers/helpers.c
> > @@ -13,6 +13,7 @@
> >  #include "build_bug.c"
> >  #include "err.c"
> >  #include "kunit.c"
> > +#include "mm.c"
> >  #include "mutex.c"
> >  #include "page.c"
> >  #include "rbtree.c"
> > diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> > new file mode 100644
> > index 000000000000..7201747a5d31
> > --- /dev/null
> > +++ b/rust/helpers/mm.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/mm.h>
> > +#include <linux/sched/mm.h>
> > +
> > +void rust_helper_mmgrab(struct mm_struct *mm)
> > +{
> > +     mmgrab(mm);
> > +}
> > +
> > +void rust_helper_mmdrop(struct mm_struct *mm)
> > +{
> > +     mmdrop(mm);
> > +}
> > +
> > +void rust_helper_mmget(struct mm_struct *mm)
> > +{
> > +     mmget(mm);
> > +}
> > +
> > +bool rust_helper_mmget_not_zero(struct mm_struct *mm)
> > +{
> > +     return mmget_not_zero(mm);
> > +}
> > +
> > +void rust_helper_mmap_read_lock(struct mm_struct *mm)
> > +{
> > +     mmap_read_lock(mm);
> > +}
> > +
> > +bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
> > +{
> > +     return mmap_read_trylock(mm);
> > +}
> > +
> > +void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> > +{
> > +     mmap_read_unlock(mm);
> > +}
>
> I guess at this point we're only interested in reading?

Yeah. The write lock would be very similar.

> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 66f5cde7f322..cc1963510cdf 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -43,6 +43,7 @@
> >  pub mod kunit;
> >  pub mod list;
> >  pub mod miscdevice;
> > +pub mod mm;
> >  #[cfg(CONFIG_NET)]
> >  pub mod net;
> >  pub mod page;
> > diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> > new file mode 100644
> > index 000000000000..84cba581edaa
> > --- /dev/null
> > +++ b/rust/kernel/mm.rs
> > @@ -0,0 +1,219 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Memory management.
> > +//!
> > +//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
> > +
> > +use crate::{
> > +    bindings,
> > +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> > +};
> > +use core::{ops::Deref, ptr::NonNull};
> > +
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// Since `mm_users` may be zero, the associated address space may not=
 exist anymore. You can use
> > +/// [`mmget_not_zero`] to be able to access the address space.
> > +///
> > +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destr=
uctor may sleep.
> > +///
> > +/// # Invariants
> > +///
> > +/// Values of this type are always refcounted using `mmgrab`.
> > +///
> > +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> > +#[repr(transparent)]
> > +pub struct Mm {
> > +    mm: Opaque<bindings::mm_struct>,
> > +}
>
> Does this tie this type to the C struct mm_struct type?
>
> Does 'Opaque' mean it is a pointer to a type which is 'opaque' in the sen=
se
> that rust can't see into its internals?

This declaration defines a Rust type called Mm which has the same
size, alignment, and contents as `struct mm_struct`. The purpose of
Opaque is to tell Rust that it can't assume anything about the
contents at all; we do that to leave it up to C.

For example, normally if you have an immutable reference &i32, then
Rust is going to assume that the contents behind the reference are in
fact immutable. Opaque turns that off, meaning that an `&Opaque<i32>`
is allowed to reference an integer as it gets modified. It makes all
access to the contents unsafe, though.

Note that Opaque is *not* a pointer type. We're going to be dealing
with types like &Mm or ARef<Mm> where &_ and ARef<_> are two different
kinds of pointers.

> > +// SAFETY: It is safe to call `mmdrop` on another thread than where `m=
mgrab` was called.
> > +unsafe impl Send for Mm {}
> > +// SAFETY: All methods on `Mm` can be called in parallel from several =
threads.
> > +unsafe impl Sync for Mm {}
> > +
> > +// SAFETY: By the type invariants, this type is always refcounted.
> > +unsafe impl AlwaysRefCounted for Mm {
> > +    #[inline]
> > +    fn inc_ref(&self) {
> > +        // SAFETY: The pointer is valid since self is a reference.
> > +        unsafe { bindings::mmgrab(self.as_raw()) };
> > +    }
> > +
> > +    #[inline]
> > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > +        // SAFETY: The caller is giving up their refcount.
> > +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> > +    }
> > +}
>
> Under what circumstances would these be taken? Same question for MmWthUse=
r.

This makes `Mm` compatible with the pointer type called ARef<_>. This
pointer type is used to represent ownership of a refcount. So whenever
a variable of type ARef<_> goes out of scope, the refcount is
decremented, and whenever an ARef<_> is cloned, the refcount is
incremented.

The way this works is that ARef<_> is implemented to use the
AlwaysRefCounted trait to understand how to manipulate the count. Only
types that implement the trait with an impl block like above can be
used with ARef<_>.

> > +
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// This type is like [`Mm`], but with non-zero `mm_users`. It can onl=
y be used when `mm_users` can
> > +/// be proven to be non-zero at compile-time, usually because the rele=
vant code holds an `mmget`
> > +/// refcount. It can be used to access the associated address space.
> > +///
> > +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. It=
s destructor may sleep.
> > +///
> > +/// # Invariants
> > +///
> > +/// Values of this type are always refcounted using `mmget`. The value=
 of `mm_users` is non-zero.
> > +#[repr(transparent)]
> > +pub struct MmWithUser {
> > +    mm: Mm,
> > +}
>
> Why does Mm have this as a Opaque<bindings::mm_struct> and this sort of
> nests it?
>
> Does this somehow amount to the same thing, or would you probably never
> actually reference this mm field?

It amounts to the same thing as Opaque<bindings::mm_struct>.

> > +// SAFETY: It is safe to call `mmput` on another thread than where `mm=
get` was called.
> > +unsafe impl Send for MmWithUser {}
> > +// SAFETY: All methods on `MmWithUser` can be called in parallel from =
several threads.
> > +unsafe impl Sync for MmWithUser {}
> > +
> > +// SAFETY: By the type invariants, this type is always refcounted.
> > +unsafe impl AlwaysRefCounted for MmWithUser {
> > +    #[inline]
> > +    fn inc_ref(&self) {
> > +        // SAFETY: The pointer is valid since self is a reference.
> > +        unsafe { bindings::mmget(self.as_raw()) };
> > +    }
> > +
> > +    #[inline]
> > +    unsafe fn dec_ref(obj: NonNull<Self>) {
> > +        // SAFETY: The caller is giving up their refcount.
> > +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> > +    }
>
> Hm, why is it we mmget(self.as_raw()) but mmput(obj.cast().as_ptr())?

There's one assumption about references that Opaque doesn't turn off:
The memory behind the reference must not get deallocated while the
reference exists. We can't use a reference in dec_ref because the
memory might get deallocated during the call to dec_ref.

> Also I guess relatedly, why does one refer to &self and the other as a
> NonNull<Self>?

Writing `&self` means that the "self parameter" has type `&Self`,
which in this case is the same as `&MmWithUser`.

The type `NonNull<Self>` is the same as `NonNull<MmWithUser>`. The
NonNull type is a raw pointer that can't be null. Other than the
non-null requirement, nothing is assumed about the raw pointer.

> I'm guessing as a non-rust person a 'reference' is like a C++ reference i=
n
> the sense that (well it is _assumed_ in C++ anyway) it acts like a pointe=
r
> for the type which should never not be there, but we need .as_raw() to ge=
t
> the raw C pointer?

Yeah, Rust references come with an assumption that the object is not
deallocated while the reference exists.

The .as_raw() call converts from &MmWithUser to `*mut
bindings::mm_struct`. So note that it not only converts from reference
to raw pointer, but it also changes the target type from MmWithUser to
bindings::mm_struct.

> And I guess in the dec_ref() case we need the .cast().as_ptr() because ob=
j
> 'boxes' around self (I guess equivalent to 'this' in C++ kinda)
> guaranteeing that it can provide non-null pointer to the current object?

Well, the thing that is equivalent to "this" would be "self".

> > +// Make all `Mm` methods available on `MmWithUser`.
> > +impl Deref for MmWithUser {
> > +    type Target =3D Mm;
> > +
> > +    #[inline]
> > +    fn deref(&self) -> &Mm {
> > +        &self.mm
> > +    }
> > +}
>
> I rubber ducked myself a bit on this, so I guess this makes it possible t=
o
> dereference the object, and it

It lets you transparently obtain an &Mm from an &MmWithUser, making
all Mm methods available on MmWithUser.

> > +// These methods are safe to call even if `mm_users` is zero.
> > +impl Mm {
> > +    /// Call `mmgrab` on `current.mm`.
> > +    #[inline]
> > +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> > +        // SAFETY: It's safe to get the `mm` field from current.
> > +        let mm =3D unsafe {
> > +            let current =3D bindings::get_current();
> > +            (*current).mm
> > +        };
>
> I don't see an equivalent means of obtaining mm from current for
> MmWithUser, is that intentional, would there be another means of obtainin=
g
> an mm? (perhaps via vma->vm_mm I guess?)
>
> An aside -->
>
> If we're grabbing from current, and this is non-NULL (i.e. not a kernel
> thread), this is kinda MmWithUser to _start out_ with, but I guess if
> you're grabbing the current one you might not expect it.
>
> I guess one thing I want to point out (maybe here is wrong place) is that
> the usual way of interacting with current->mm is that we do _not_ increme=
nt
> mm->mm_count, mm->mm_users or any refernce count, as while we are in the
> kernel portion of the task, we are guaranteed the mm and the backing
> virtual address space will stick around.
>
> With reference to MmWithUser, in fact, if you look up users of
> mmget()/mmput() it is pretty rare to do that.
>
> So ideally we'd avoid doing this if we could (though having the semantics
> of grabbing a reference if we were to copy the object somehow again or ho=
ld
> its state or something would be nice).
>
> I guess this might actually be tricky in rust, because we'd probably need
> to somehow express the current task's lifetime and tie this to that
> and... yeah.
>
> <-- aside

Ah, yeah, I guess this API is incomplete. We could have an API that
lets you obtain an &MmWithUser instead. Then, if the user wants to
increment the refcount, they can manually convert that into an
ARef<Mm> or ARef<MmWithUser>.

It's true that it's slightly tricky to express in Rust, but it's
possible. We already have a way to get a &Task pointing at current.


> > +
> > +        if mm.is_null() {
> > +            return None;
> > +        }
> > +
> > +        // SAFETY: The value of `current->mm` is guaranteed to be null=
 or a valid `mm_struct`. We
> > +        // just checked that it's not null. Furthermore, the returned =
`&Mm` is valid only for the
> > +        // duration of this function, and `current->mm` will stay vali=
d for that long.
> > +        let mm =3D unsafe { Mm::from_raw(mm) };
>
> Hm does mm now reference something with a different type, as in before it
> was a 'raw' pointer or such, and now it's a reference to an Mm right?

Yes ... this is using shadowing to change the type of the variable.
It's actually rather common in Rust.

The former mm variable had type `*mut bindings::mm_struct`. The latter
mm variable has type `&Mm`.

> Also I guess the 'duration of this function' is because we put this in th=
e
> 'Aref' smart pointer which kinda takes over the lifetime of the reference
> by wrapping it right?

Yeah, basically, the lifetime gets inferred from how we use it.

> I mean I'm not a rust person so actually I have no business _commenting_ =
on
> this :P as this may very well be idiomatic rust, but I'm just curious abo=
ut
> this.
>
> It's nitty but I feel like maybe we're somewhat overloading 'mm's here a
> bit though? As we have our wrapped Mm type and then an internal raw mm
> type. On the other hand, it's hard to now have horribly awkward and
> confusing naming here I guess, and perhaps this is fine.
>
> Not a big deal though!
>
> > +
> > +        // This increments the refcount using `mmgrab`.
> > +        Some(ARef::from(mm))
>
> So I get that Some() means this is like a discriminated union or such,
> where we can return None (as above) or Some, which contains the value is =
of
> type ARef<Mm>. And I guess this moves the 'lifetime' of mm which was
> previously with the function into that of the ARef<>?

Yes, Some() is normally a discriminated union, but in this particular
case since ARef uses a NonNull pointer for its only field, the
compiler is smart enough to represent None as a null pointer instead
of using a discriminated union with a separate tag.

As for the "lifetime" of the `mm`, that's not really the lifetime of
the mm_struct. Rather, it's the duration for which the &Mm reference
is assumed to be valid for. That lifetime ends right after the
ARef::from call, because that's our last use of the &Mm.

> Does the ARef<> 'just know' to use the AlwaysRefCounted methods?

Yep! See e.g. the destructor of ARef:

impl<T: AlwaysRefCounted> Drop for ARef<T> {
    fn drop(&mut self) {
        unsafe { T::dec_ref(self.ptr) };
    }
}

Due to the `T: AlwaysRefCounted`, the type `T` must be a type that
implements the `AlwaysRefCounted` trait, and the compiler is able to
resolve T::dec_ref based on that.

> > +    }
> > +
> > +    /// Returns a raw pointer to the inner `mm_struct`.
> > +    #[inline]
> > +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> > +        self.mm.get()
> > +    }
>
> I guess this .get() method is on the Opaque<> object and returns a raw pt=
r?

Yes, it just creates a raw pointer.

> > +    /// Obtain a reference from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure that `ptr` points at an `mm_struct`, an=
d that it is not deallocated
> > +    /// during the lifetime 'a.
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a=
 Mm {
>
> I'm guessing this funny 'a syntax, based on the comment, refers to the
> lifetime of the object?

It's a lifetime, but not necessarily the lifetime of the object.
Rather, it's the maximum duration in which the reference is assumed to
be valid. It must not be longer than the lifetime of the mm_struct of
course, but it's usually going to be much shorter than the lifetime of
the mm_struct.

> > +        // SAFETY: Caller promises that the pointer is valid for 'a. L=
ayouts are compatible due to
> > +        // repr(transparent).
>
> God I love these SAFETY comments (I mean actually, sorry I realise it's
> almost impossible to convey 'not sarcastically, actually' in text form
> :). Is that something that gets parsed somewhere, or a convention or?
>
> I like that there is a discipline of expressing under what circumstances =
we
> are permitted to reference things.

They don't get parsed anywhere, except that not using a SAFETY comment
at all is a compilation warning.

> > +        unsafe { &*ptr.cast() }
> > +    }
> > +
> > +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> > +    #[inline]
> > +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
>
> I actually kinda love that this takes an mm and guarantees that you get a=
n
> MmWithUser out of it which is implied by the fact this succeeds.
>
> However as to the point above, I'm concerned that this might be seen as
> 'the way' to access an mm, i.e. mm.mmgrab_current().mmget_not_zero() or
> something.
>
> Whereas, the usual way of referencing current->mm is to not increment any
> reference counts at all (assuming what you are doing resides in the same
> lifetime as the task).
>
> Obviously if you step outside of that lifetime, then you _do_ have to pin
> the mm (nearly always you want to grab rather than get though in that
> circumstance).

I can add a way to obtain an &MmWithUser from current without
incrementing the refcount.

> > +        // SAFETY: The pointer is valid since self is a reference.
> > +        let success =3D unsafe { bindings::mmget_not_zero(self.as_raw(=
)) };
> > +
> > +        if success {
> > +            // SAFETY: We just created an `mmget` refcount.
> > +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.a=
s_raw().cast())) })
>
> When you do this, does it cause the reference count to increment, or does
> it assume it's already at 1?

This uses `from_raw` which by convention never increments the
refcount. Semantically we're taking ownership of the increment
performed by bindings::mmget_not_zero.

> > +        } else {
> > +            None
> > +        }
> > +    }
> > +}
> > +
> > +// These methods require `mm_users` to be non-zero.
> > +impl MmWithUser {
> > +    /// Obtain a reference from a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure that `ptr` points at an `mm_struct`, an=
d that `mm_users` remains
> > +    /// non-zero for the duration of the lifetime 'a.
> > +    #[inline]
> > +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a=
 MmWithUser {
> > +        // SAFETY: Caller promises that the pointer is valid for 'a. T=
he layout is compatible due
> > +        // to repr(transparent).
> > +        unsafe { &*ptr.cast() }
> > +    }
>
> I guess this is another means by which you can get the mm. I'd say an
> equivalent for getting from current is highly relevant.

This lets you write MmWithUser::from_raw in unsafe code.

> > +
> > +    /// Lock the mmap read lock.
> > +    #[inline]
> > +    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> > +        // SAFETY: The pointer is valid since self is a reference.
> > +        unsafe { bindings::mmap_read_lock(self.as_raw()) };
> > +
> > +        // INVARIANT: We just acquired the read lock.
> > +        MmapReadGuard {
> > +            mm: self,
> > +            _nts: NotThreadSafe,
>
> I'm sure this is a rusty thing, but curious as to why this is like that?
> What is '_nts', etc.?

_nts is the name of a field. The NotThreadSafe type has size zero, so
it doesn't exist in the compiled code. It exists only to mark that the
MmapReadGuard cannot be transferred across thread boundaries.

> > +        }
> > +    }
> > +
> > +    /// Try to lock the mmap read lock.
> > +    #[inline]
> > +    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
> > +        // SAFETY: The pointer is valid since self is a reference.
> > +        let success =3D unsafe { bindings::mmap_read_trylock(self.as_r=
aw()) };
> > +
> > +        if success {
> > +            // INVARIANT: We just acquired the read lock.
> > +            Some(MmapReadGuard {
> > +                mm: self,
> > +                _nts: NotThreadSafe,
> > +            })
> > +        } else {
> > +            None
> > +        }
> > +    }
> > +}
> > +
> > +/// A guard for the mmap read lock.
> > +///
> > +/// # Invariants
> > +///
> > +/// This `MmapReadGuard` guard owns the mmap read lock.
> > +pub struct MmapReadGuard<'a> {
> > +    mm: &'a MmWithUser,
> > +    // `mmap_read_lock` and `mmap_read_unlock` must be called on the s=
ame thread
> > +    _nts: NotThreadSafe,
> > +}
> > +
> > +impl Drop for MmapReadGuard<'_> {
> > +    #[inline]
> > +    fn drop(&mut self) {
> > +        // SAFETY: We hold the read lock by the type invariants.
> > +        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
> > +    }
> > +}
>
> Ah that's nice, an actual guard for it :) I'm guessing the fact this
> implements the guard implies that you _must_ hold the lock first right?

Yeah so this code runs when a variable of type MmapReadGuard goes out
of scope. We don't provide any way to obtain an MmapReadGuard without
locking the mmap read guard.

> >
> > --
> > 2.47.0.371.ga323438b13-goog
> >
>
> Sorry for the numerous questions, I'm afraid there'll be a lot of this fo=
r
> rust stuff for the time being. Perhaps advent of code will help improve
> things on the rust front for me ;)

Thanks for all the excellent questions!

Alice


Return-Path: <linux-kernel+bounces-267318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A907941014
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD151C22ADA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2CA199236;
	Tue, 30 Jul 2024 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31ryOC8d"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8261DA32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337079; cv=none; b=jrHpIQH0dfHUssA3DWvl3Aec+JFq/lfZ70iVAPbWx1mIC7nSzFtLZM29rFs3CNcjugAvYNACV0VRLDOPi/vxQO+a6rSfjPZ89epd1z10MHcYpgXowuS4i9ofRpG80INu1ymqdcdlbkE1IX8+Tr8UpZvdmxFL72iEEIH8m7qlu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337079; c=relaxed/simple;
	bh=LwAq/le4I9m7f8tUodgDtzku+Gg1+TypsQdyGxsA7C8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhpiJ1rCBHVAeCqybKGmIaCnE8oJkWOVMX+FwBxDPOxlky3KyzxzFOYzj9NEgdVkOopp2SlAPfx/1Sh9N1pcSOfcfBe0FypigfDwqH/7JHRuvtwnfC8Symayu6J2ASEOI080nG6BUeEYu2a+gdAzmTRvbXrscGqDoQWyBaygGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31ryOC8d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3684e8220f9so1530101f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722337076; x=1722941876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Byx/+NsYax4XTwzR5o0dMoTnWWs//cW6U9789awaLpM=;
        b=31ryOC8dDgiZ+T519VAAQ2H4SOx7zePR7TOvV6kaBIaucpnUUMgBfbZIUv8t96UJCa
         kJzFfyeQcNhQBWlvNMHQf9SlY3It5s+H07QclUuWZK69fbLv/gw7+0AtdhGpqITX+OL+
         Wf+PxXMPfjW1v5t6jHiN2tvFEefjU0wqHCTue9kTc+TmoxoamngGN26pE5MATDUYWHON
         z0Sp7kyhTH2OrWP3F1EOLCQTYJguTND3K7W03xlOWxLBUtpuwXGYZyuT/Eq4rjQ88lJ0
         lSlLrJnTp0wE6oDHPYncL2Y+frdjMjpZByMcrG3jhPuts6+mnZmrZpTwlqIytX0t1lSN
         MXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722337076; x=1722941876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Byx/+NsYax4XTwzR5o0dMoTnWWs//cW6U9789awaLpM=;
        b=DQuOTRijENaFhcV/Cup0ygMmIk201N0RkotQP5aCV6KsSHq3R7QO6bmc7UqVkpdLpE
         VDBivYAnYLFmOmRxTPB2knLRl2+FGjwPERNLvxO6YYZ9Khkh0ez8zs0MU2X4dnuuLPqW
         vKNrnMEBvv4UPMq6y9UMGe6ehUJqBUCRWVwxJmmRksRYy2XZLBrqiixk+eWBWBLgATxM
         8yiaS9gLf9qS8AF0+ba1GiOAWwNS/aB6GQYTAL9jJtDgvPrXcj2cxG5go5j5fWgpsNyk
         Ql5+FAUWxgtkiyfNhJnuGjWNOfwrLANgrkNYzCdDTIWVWKJlf7RTUso0BgDcXmBar8fz
         RzSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcrNYBSaJH7jq7bsezA6YesquEXmzPyd0uHAGv0EA1QxLU97WM0EAgLclt7E29t1f/5NKHZIiczspq2sjSv95g8kMEHMl1IhR0+slb
X-Gm-Message-State: AOJu0YzMlDOSxTw2Uq1sh7cmXrYAhSOPFTs+xCN0AF5V6SBDdeV9szA3
	mqP8CXJ44m1GQWfQE8OHn5wTO2aTLIeTulPW5Kqga0fAxsSyCyHUJcBmAz0ivlfFZmHhrF0nQhR
	qe6IISxfa7XaG43WYKtgJQTNvZ/trbfZz4S33
X-Google-Smtp-Source: AGHT+IHBKvdpwpeX66stBMzQBehm8htfa32lEV9TetSlhZ2IXJcx0jHxCW463ZOp5gjW96fEFOWtq7k3XkupvLgGB/k=
X-Received: by 2002:a5d:46c9:0:b0:368:374d:81ec with SMTP id
 ffacd0b85a97d-36b8c8df3cemr1018349f8f.10.1722337075385; Tue, 30 Jul 2024
 03:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727-vma-v2-1-ab3e5927dc3a@google.com> <3ffd4742-7a84-434d-ad0d-962f302b977a@proton.me>
In-Reply-To: <3ffd4742-7a84-434d-ad0d-962f302b977a@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 30 Jul 2024 12:57:43 +0200
Message-ID: <CAH5fLgg1DR2mLDvP6J=+Zp-OJWHfL-hXdZ3HioueXF=rg9yN9w@mail.gmail.com>
Subject: Re: [PATCH v2] rust: mm: add abstractions for mm_struct and vm_area_struct
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 6:13=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 27.07.24 11:03, Alice Ryhl wrote:
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// Since `mm_users` may be zero, the associated address space may not=
 exist anymore. You must use
> > +/// [`mmget_not_zero`] before accessing the address space.
> > +///
> > +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destr=
uctor may sleep.
> > +///
> > +/// # Invariants
> > +///
> > +/// Values of this type are always refcounted.
> > +///
> > +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> > +pub struct Mm {
> > +    mm: Opaque<bindings::mm_struct>,
> > +}
> > +
> > +/// A wrapper for the kernel's `struct mm_struct`.
> > +///
> > +/// This type is used only when `mm_users` is known to be non-zero at =
compile-time. It can be used
> > +/// to access the associated address space.
> > +///
> > +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. It=
s destructor may sleep.
> > +///
> > +/// # Invariants
> > +///
> > +/// Values of this type are always refcounted. The value of `mm_users`=
 is non-zero.
> > +#[repr(transparent)]
> > +pub struct MmWithUser {
> > +    mm: Mm,
> > +}
>
> I personally wouldn't sort it this way (so struct decls, methods and
> then AlwaysRefCounted impl), but I would sort it first by the struct.
> I find it helpful to have the `AlwaysRefCounted` impl close to the
> struct declaration (similarly for `Drop`). But that might just be me.

I can reorder for next version.

> > +
> > +/// Equivalent to `ARef<MmWithUser>` but uses `mmput_async` in destruc=
tor.
> > +///
> > +/// The destructor of this type will never sleep.
> > +///
> > +/// # Invariants
> > +///
> > +/// `inner` points to a valid `mm_struct` and the `ARefMmWithUserAsync=
` owns an `mmget` refcount.
> > +pub struct ARefMmWithUserAsync {
> > +    inner: NonNull<bindings::mm_struct>,
>
> I am confused, why doesn't `mm: MM` work here? I.e. also allow usage of
> `ARef<MmWithUserAsync>`.

We could do that, but I don't know how much sense it makes. With Mm
and MmWithUser there's a legitimate distinction between them that
makes sense regardless of whether it's behind an ARef or &. But with
the `mmput_async` case, the distinction only makes sense for ARef
pointers, and &MmWithUser and &MmWithUserAsync would be 100%
interchangeable.

That is to say, this is a property of the pointer, not the pointee. I
don't think it makes sense semantically to have it be a wrapper around
MmWithUser.

> Another approach might be to have the function on `MmWithUser`:
>
>     fn put_async(this: ARef<Self>)
>
> Or do you need it to be done on drop?

This needs to happen in drop so that use of the question mark
operation doesn't suddenly result in sleep-in-atomic-ctx bugs.

> > +}
> > +
> > +// Make all `Mm` methods available on `MmWithUser`.
> > +impl Deref for MmWithUser {
> > +    type Target =3D Mm;
> > +
> > +    #[inline]
> > +    fn deref(&self) -> &Mm {
> > +        &self.mm
> > +    }
>
> Does it really make sense to expose every function? E.g.
> `mmget_not_zero` would always succeed, right?

I don't think it's a problem. Right now it exposes mmget_not_zero,
is_same_mm, and as_raw. The only one where it doesn't make much sense
is mmget_not_zero, but I don't think it hurts either.

> > +}
> > +
> > +// These methods are safe to call even if `mm_users` is zero.
>
> [...]
>
> > diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> > new file mode 100644
> > index 000000000000..2e97ef1eac58
> > --- /dev/null
> > +++ b/rust/kernel/mm/virt.rs
> > @@ -0,0 +1,199 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +// Copyright (C) 2024 Google LLC.
> > +
> > +//! Virtual memory.
> > +
> > +use crate::{
> > +    bindings,
> > +    error::{to_result, Result},
> > +    page::Page,
> > +    types::Opaque,
> > +};
> > +
> > +/// A wrapper for the kernel's `struct vm_area_struct`.
> > +///
> > +/// It represents an area of virtual memory.
> > +#[repr(transparent)]
> > +pub struct VmArea {
> > +    vma: Opaque<bindings::vm_area_struct>,
> > +}
> > +
> > +impl VmArea {
> > +    /// Access a virtual memory area given a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, with shared access. The
> > +    /// caller must ensure that using the pointer for immutable operat=
ions is okay.
>
> Nothing here states that the pointee is not allowed to be changed,
> unless you mean that by "shared access" which would not match my
> definition.

How about this?

Callers must ensure that:
* `vma` is valid for the duration of 'a.
* the caller holds the mmap read lock for 'a.

And `from_raw_vma_mut` would instead require the caller to hold the
mmap write lock.

> > +    #[inline]
> > +    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struc=
t) -> &'a Self {
> > +        // SAFETY: The caller ensures that the pointer is valid.
> > +        unsafe { &*vma.cast() }
> > +    }
> > +
> > +    /// Access a virtual memory area given a raw pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `vma` is valid for the duration of 'a=
, with exclusive access. The
> > +    /// caller must ensure that using the pointer for immutable and mu=
table operations is okay.
> > +    #[inline]
> > +    pub unsafe fn from_raw_vma_mut<'a>(vma: *mut bindings::vm_area_str=
uct) -> &'a mut Self {
> > +        // SAFETY: The caller ensures that the pointer is valid.
> > +        unsafe { &mut *vma.cast() }
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
> > +    pub fn flags(&self) -> usize {
> > +        // SAFETY: The pointer is valid since self is a reference. The=
 field is valid for reading
> > +        // given a shared reference.
>
> Why is the field not changed from the C side? Is this part readonly?

Because we hold the mmap read lock. (or the write lock)

Alice


Return-Path: <linux-kernel+bounces-402234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD4B9C254C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22482845C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105261AA1D7;
	Fri,  8 Nov 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbXZ003E"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38F19922F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092548; cv=none; b=I8ERDVaem5CZlLVa7ZqkPwxx/upkVfUhkEpampQVydMIHNF3LQj38PJqBtc0pq10/UQiOyePdCN0ewLj4FXI1MMQ6ss4wk56e6lhfbJLAPaTVhnePL0PVtcxo3xnYTvt6V+lUBvSdrmUWzdDgkoQOhgd6JJc8a/a8G8VYbQDKzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092548; c=relaxed/simple;
	bh=YEwWWdTygdfPwKXQSTYfbGOGF0MUKQwYGLbCoB2q61s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iyAQ+pQWZsp6BcCc/mhP9pOJtlDVKF7bgy3882nbhenIYD2Tx4D3RDEWC6g5m/0vQi1t19yQGUEYAQWkVYtkdoEhixOJ2eOrijEbFwLbzGJy5XoAGKslp+DdhRFwPr0rfydJA03F9Xbo3UVZJFSqYcTzO+UVmVCw986Mw04PnnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbXZ003E; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e617ef81so1311e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 11:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731092545; x=1731697345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5dcxcXk694RMvcWb5k1dVNXtrLmI1dR+rZM3ZVOTn8=;
        b=SbXZ003Ec3w7NUnDIGW3iTgd53PYg1JPTrasFHue60HxH31oGQmk1wTDjo0UI3256p
         esXJUBTJxyFHCOf9+W1V4pebjjau6k45z2jj7R2TuOyHJ2heKV5sLsjtfPguNuMslgIF
         vz+xCx6pDt9aFomTDn4qR+ghF2dj9XT1zDOiFGSeLzy8fWQGsSFxJd8GqKVnrMs6nDjD
         3npwvTwlmgzQfY6UYJXeSejbyUIpoEo2gLC4BXk0KNQXh20oBXQvbWF+zSqyvQgWxnHJ
         e2bJE/SorWv+GmInkeKX9oXpQEhNH10qInN+iOq5QTc8hVgeigHivTbHQ7lgnBpiFcZM
         vadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092545; x=1731697345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5dcxcXk694RMvcWb5k1dVNXtrLmI1dR+rZM3ZVOTn8=;
        b=iI0Ubb4HdK6Itv5lTcAMZvztARPv2r/8IJAPMuTsgCC/V+PPfPjLzFAs5qjkNAYoTL
         otDvp//dOmTMipoJrpRj9xjr1N7Ja9A4iRgdpqhYd5MPypAQUE2Vk+kRGVAGrQ2pP7DF
         oIbVNaYwhRAurJ+MeBNH3Ay5ppmS+pzk9xFqWCEoQXTy6N7gE6rAHl8PLKbx+KnS4/F9
         E2EMlKM6DQpFZbWp3ZiFNXPkL+jd+tQqfkRknogRLi1iGpx6jQMG7BcYYxS3svftG/Dj
         Hiuy+CVhJ8kdMFJx+Jfk6HRNdUG8hXVHVwDwVChIlvzj8PWGlDvsI9HF7BpEgUTwofS9
         fYEg==
X-Forwarded-Encrypted: i=1; AJvYcCW9VNQRtr0GRfvwa3NrprIeiUUutqsAzMYT9g+uot8Z83G0FyYpru0QXRx8Ms125K/LMVSYR9m2Eg/4w8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYEuGRBOI8t4aAbBKYFrlnP6Eq9hJLpeap5LMFFeTQRwWV9RO7
	wXwYIetgKvc9e50nHRmGroV7zYY0xlM2RCtvXZqZKdxyfPrdLvUf5pTAgbfyCyy1LzX7E3QPIqr
	77Qw8Bg+KrAlV/B9bxjTgHcpgjuwp/IzDDNN5
X-Gm-Gg: ASbGnctvtwmUs8fM9pmwIseWhdtlBNUEZXkLX2t3rBMAEg8Ec//wT+PPcQa+Xk+PeFI
	Q1EBOG0eUpSsb9NNKFHlpAlsq1xsomVborn7jfTBWcgI/q3vEM8u/255SUTY=
X-Google-Smtp-Source: AGHT+IHcdHRiwMr8+Qu01GgNV0vMtk5CA/bfKgogQKcSIdPXH6MUjs+l+BdiSRl0GGjfEWL4sNJIizZBndurlTIUza4=
X-Received: by 2002:ac2:518e:0:b0:536:88d0:420d with SMTP id
 2adb3069b0e04-53d8bdf9fb4mr22123e87.6.1731092544016; Fri, 08 Nov 2024
 11:02:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010-vma-v6-0-d89039b6f573@google.com> <20241010-vma-v6-1-d89039b6f573@google.com>
In-Reply-To: <20241010-vma-v6-1-d89039b6f573@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 8 Nov 2024 20:01:47 +0100
Message-ID: <CAG48ez3gXicVYXiPsQDmYuPSsKMbES2KRQDk+0ANWSS0zDkqSw@mail.gmail.com>
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

On Thu, Oct 10, 2024 at 2:56=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
> These abstractions allow you to manipulate vmas. Rust Binder will uses
> these in a few different ways.
>
> In the mmap implementation, a VmAreaNew will be provided to the mmap
> call which allows it to modify the vma in ways that are only okay during
> initial setup. This is the case where the most methods are available.
>
> However, Rust Binder needs to insert and remove pages from the vma as
> time passes. When incoming messages arrive, pages may need to be
> inserted if space is missing, and in this case that is done by using a
> stashed ARef<Mm> and calling mmget_not_zero followed by mmap_write_lock
> followed by vma_lookup followed by vm_insert_page. In this case, since
> mmap_write_lock is used, the VmAreaMut type will be in use.

FYI, the way the C binder implementation uses vma_lookup() and
vm_insert_page() is not very idiomatic. The standard way of
implementing binder_alloc_free_page() would be to use something like
unmap_mapping_range() instead of using
vma_lookup()+zap_page_range_single(); though to set that up, you'd
have to create one inode per binder file, maybe with something like
the DRM subsystem's drm_fs_inode_new(). And instead of having
binder_install_single_page(), the standard way would be to let
binder_vm_fault() install PTEs lazily on fault. That way you'd never
have to take mmap locks or grab MM references yourself.

I guess the one benefit of the current implementation of C binder over
the more idiomatic approach is that it avoids taking a fault after
binder_install_buffer_pages(), but that's probably not such a hot path
that it matters...

> Another use-case is the shrinker, where the mmap read lock is taken
> instead, and zap_page_range_single is used to remove pages from the vma.
> In this case, only the read lock is taken, so the VmAreaRef type will be
> in use.

I think this might also use unmap_mapping_range() in a more idiomatic
implementation.

> Future extensions could involve a VmAreaRcuRef for accessing vma methods
> that are okay to use when holding just the rcu read lock. However, these
> methods are not needed from Rust yet.

You're probably talking about the VMA read lock here? There's not much
you can do under just RCU.

> +    /// Unmap pages in the given page range.
> +    #[inline]
> +    pub fn zap_page_range_single(&self, address: usize, size: usize) {
> +        // SAFETY: By the type invariants, the caller holds at least the=
 mmap read lock, so this
> +        // access is okay. Any value of `address` and `size` is allowed.

FWIW, if you passed in a size that is big enough to make the end
address wrap around the end of the address space, I think you could at
least hit a BUG_ON() in unmap_page_range(). I don't know what level of
safety kernel Rust is going for though - I guess that might be
acceptable?

> +        unsafe {
> +            bindings::zap_page_range_single(
> +                self.as_ptr(),
> +                address as _,
> +                size as _,
> +                core::ptr::null_mut(),
> +            )
> +        };
> +    }
> +}
> +
> +impl VmAreaMut {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, =
and that the mmap write lock
> +    /// (or stronger) is held for at least the duration of 'a.

A mutable VMA should probably also come with the vma write lock held
(meaning vma_start_write() has been called on it) - that's needed for
almost all operations that actually mutate the VMA. (Though with the
comments below, maybe you don't actually have any use for VmAreaMut
for now.)

> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> =
&'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied =
for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Sets the flags associated with the virtual memory area.
> +    ///
> +    /// The possible flags are a combination of the constants in [`flags=
`].
> +    #[inline]
> +    pub fn set_flags(&self, flags: usize) {
> +        // SAFETY: By the type invariants, the caller holds the mmap wri=
te lock, so this access is
> +        // not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags =3D flags as=
 _ };

It can be a data race, for example you could race with pte_mkwrite()
called from remove_migration_pte(). (But that's an existing issue, the
same data race currently occurs with existing vm_flags updates in
other core kernel paths.)

Separately from that: If you want to update the flags of existing
VMAs, you need to call vma_start_write() first. The vm_flags_set()
helper is designed to enforce this automatically.

But really I think drivers normally don't change the flags of existing
VMAs anyway, only the flags of newly created VMAs; only core MM code
should be changing the flags of existing VMAs. You should maybe move
this method over into VmAreaNew.

There are ways to set VMA flags that are dangerous and invalid; I
think VM_PFNMAP|VM_MIXEDMAP would be an example (though that might not
actually lead to any actual bad consequences with the way the code is
currently written). Clearing VM_MIXEDMAP after calling
vm_insert_page() might be another one.

VM_HUGETLB is also a flag you really shouldn't be touching from driver
code, that would cause type confusion through a bad cast in
unmap_single_vma -> __unmap_hugepage_range -> hstate_vma ->
hstate_file -> hstate_inode.

I'm not sure how safe against programmer error this is supposed to be;
if you want the API to be safe even against silly blunders, I think
you'd have to at least allowlist which bits the driver may clear and
which bits it may set, and additionally deny at least the bad
combination VM_MIXEDMAP|VM_PFNMAP. Though you might want to introduce
higher-level helpers instead, so that a driver author doesn't blunder
by checking VM_WRITE without also clearing VM_MAYWRITE, which is a
somewhat common mistake that IIRC has led to several security bugs in
the past.

I think the reasonable ways in which drivers might want to change
flags on a VmAreaNew are:

1. clear VM_MAYWRITE after checking VM_WRITE is unset
2. (you could do the same with the VM_EXEC/VM_MAYEXEC bits)
3. set VM_PFNMAP (only valid if not VM_MIXEDMAP and no PTEs have been
installed yet)
4. set VM_MIXEDMAP (only valid if not VM_PFNMAP)
5. set VM_IO/VM_DONTEXPAND
6. set VM_DONTCOPY/VM_DONTDUMP (only permanently effective if VM_IO is also=
 set)

> +    }
> +
> +    /// Maps a single page at the given address within the virtual memor=
y area.
> +    ///
> +    /// This operation does not take ownership of the page.
> +    #[inline]
> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result =
{
> +        // SAFETY: By the type invariants, the caller holds the mmap wri=
te lock, so this access is
> +        // not a data race. The page is guaranteed to be valid and of or=
der 0. The range of
> +        // `address` is already checked by `vm_insert_page`.
> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), addre=
ss as _, page.as_ptr()) })

vm_insert_page() has a kinda weird contract because there are two
contexts from which you can call it cleanly:

1. You can call it on a VmAreaRef (just like zap_page_range_single(),
you only need to hold an mmap read lock or VMA read lock, no write
lock is required); however, you must ensure that the VMA is already
marked VM_MIXEDMAP. This is the API contract under which you'd call
this from a fault handler.

2. You can call it on a VmAreaNew (and it will take care of setting
VM_MIXEDMAP for you).

I think nothing would immediately crash if you called vm_insert_page()
on a VMA that does not yet have VM_MIXEDMAP while holding the mmap
lock in write mode; but that would permit weird scenarios where you
could, for example, have a userfaultfd context associated with a VMA
which becomes VM_MIXEDMAP, while normally you can't attach userfaultfd
contexts to VM_MIXEDMAP VMAs. I don't think if that actually leads to
anything bad, but it would be a weird state that probably shouldn't be
permitted.

There are also safety requirements for the page being installed, but I
guess the checks that vm_insert_page() already does via
validate_page_before_insert() might be enough to make this safe...

> +    }
> +}
> +
> +impl VmAreaNew {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, =
and that the vma is
> +    /// currently undergoing initial VMA setup.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> =
&'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied =
for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Make this vma anonymous.
> +    #[inline]
> +    pub fn set_anonymous(&self) {
> +        // SAFETY: The vma is not yet shared.
> +        unsafe { (*self.as_ptr()).vm_ops =3D core::ptr::null() };
> +    }

What would you use this for? I don't think drivers are supposed to
create anonymous VMAs. (Also, if you called this after inserting some
non-anonymous pages into the VMA, that might confuse some core MM
code, though I don't know if it can actually cause anything really
bad.)


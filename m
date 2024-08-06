Return-Path: <linux-kernel+bounces-275887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28AF7948B82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D24B228130D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120AF15F409;
	Tue,  6 Aug 2024 08:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="de3JxpN5"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806C15B153
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933855; cv=none; b=jMQ6ARYZYpT+jFVuJssDh3AQQZ9Z9DlzHwvfEu4YMAhj5j9sdSrpAZhp7pGoZkVBWYu46aahw+Ol4DfZJAa1oaFIGN+AshtNezcg/iZLYfMp0HDUMmNwwT5ctYMWIbwpyJfcUNZX0iMhllRwvBiKs+DszoT+1KFojFdKSkV6q54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933855; c=relaxed/simple;
	bh=5NnzlJHH1Uur4/JIdDKM1bI4iRTWZsSEgo4zWkTensE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1Gu1zZMbU5WUpSnIouQxXhSjv29wSBoVPE+Gk4qkpNlV3LJpZdo/J6g4dAqrnyqhVpEQNcbVriRDW0dYRquKRbSclHxfahubKEBTouJazZlfcalElwvUY+YOsAf839n/ePYayC+39qRY2oyd/KhDiSfGLQwFov5N5yX3oXkC34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=de3JxpN5; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722933849; x=1723193049;
	bh=gHPxGVyssSfW3HceeXUqh8HEKsxaHZzQjVEy69dZFdc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=de3JxpN58fE4yRY235TVsXVn1genOb8G4hkxuIC2Lj8n+FUM8lo6p4WXnXok/ulnI
	 L2x09TbS7CxT5bt0iNV1VcRvvTuEcQJDF1/nYvCKMEEW4VsMc2fl7QD2Uj2j8skEt0
	 RG3e2pH4o6BIRLqGYUqbSr79kYvKjuWrudLKjSosIleLe+Orwp/OmLg8otGBIE1D2x
	 zrMvj+Kow4qGPzKIFym+o8eOOXfewUEAUn0FZbum1O8KDs8WFyCj3Bm7Wq6iwxSluf
	 1+Q67c/k7lNVZ6VQTyB8aqKi8TdFgHFZEJCzyBmB3B7iuiafX1w/IBhFz+lJF4/RSw
	 cMiBr9BQtPevA==
Date: Tue, 06 Aug 2024 08:44:02 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
Message-ID: <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
In-Reply-To: <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com> <20240725-alice-file-v8-3-55a2e80deaa8@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fd93ad581a32d9f89838e453a9358c2320d4fccd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.07.24 16:27, Alice Ryhl wrote:
> +/// Wraps the kernel's `struct file`. Not thread safe.
> +///
> +/// This type represents a file that is not known to be safe to transfer=
 across thread boundaries.
> +/// To obtain a thread-safe [`File`], use the [`assume_no_fdget_pos`] co=
nversion.
> +///
> +/// See the documentation for [`File`] for more information.
> +///
> +/// # Invariants
> +///
> +/// * All instances of this type are refcounted using the `f_count` fiel=
d.
> +/// * If there is an active call to `fdget_pos` that did not take the `f=
_pos_lock` mutex, then it
> +///   must be on the same thread as this `File`.

Do you mean `LocalFile`?

> +///
> +/// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
> +pub struct LocalFile {
> +    inner: Opaque<bindings::file>,
> +}

[...]

> +    /// Returns the flags associated with the file.
> +    ///
> +    /// The flags are a combination of the constants in [`flags`].
> +    #[inline]
> +    pub fn flags(&self) -> u32 {
> +        // This `read_volatile` is intended to correspond to a READ_ONCE=
 call.
> +        //
> +        // SAFETY: The file is valid because the shared reference guaran=
tees a nonzero refcount.
> +        //
> +        // FIXME(read_once): Replace with `read_once` when available on =
the Rust side.

Do you know the status of this?

> +        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_vola=
tile() }
> +    }
> +}
> +
> +impl File {
> +    /// Creates a reference to a [`File`] from a valid pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * The caller must ensure that `ptr` points at a valid file and t=
hat the file's refcount is
> +    ///   positive for the duration of 'a.
> +    /// * The caller must ensure that if there are active `fdget_pos` ca=
lls on this file, then they
> +    ///   took the `f_pos_lock` mutex.
> +    #[inline]
> +    pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a F=
ile {
> +        // SAFETY: The caller guarantees that the pointer is not danglin=
g and stays valid for the
> +        // duration of 'a. The cast is okay because `File` is `repr(tran=
sparent)`.
> +        //
> +        // INVARIANT: The caller guarantees that there are no problemati=
c `fdget_pos` calls.
> +        unsafe { &*ptr.cast() }
> +    }
> +}
> +
> +// Make LocalFile methods available on File.
> +impl core::ops::Deref for File {
> +    type Target =3D LocalFile;
> +    #[inline]
> +    fn deref(&self) -> &LocalFile {
> +        // SAFETY: The caller provides a `&File`, and since it is a refe=
rence, it must point at a
> +        // valid file for the desired duration.
> +        //
> +        // By the type invariants, there are no `fdget_pos` calls that d=
id not take the
> +        // `f_pos_lock` mutex.
> +        unsafe { LocalFile::from_raw_file(self as *const File as *const =
bindings::file) }
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `LocalFile` is always ref-=
counted. This implementation
> +// makes `ARef<File>` own a normal refcount.
> +unsafe impl AlwaysRefCounted for LocalFile {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the re=
fcount is nonzero.
> +        unsafe { bindings::get_file(self.as_ptr()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
> +        // SAFETY: To call this method, the caller passes us ownership o=
f a normal refcount, so we
> +        // may drop it. The cast is okay since `File` has the same repre=
sentation as `struct file`.
> +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> +    }
> +}

Can you move these `AlwaysRefCounted` impls towards the struct
definitions?

With those two comments fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



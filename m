Return-Path: <linux-kernel+bounces-275889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54761948B96
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F131C222D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E71BD501;
	Tue,  6 Aug 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0Ax9u7d"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2A165F13
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934108; cv=none; b=S3jmU/J9HJMg5vHV8kzbUsM76PbGHMm8xZH3duGRUfpiz2IGotCEiY5lTovgSXbt1cR4l96jCg7TPZ3YyJaYF6yFHTD/MTrs0FsbGhZbiRzCJ0JHK20pJ6nPHEuhkxmL+qpzHWpagpXUEH3XBYQlMyLD6V+vvG81OqblMFGEtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934108; c=relaxed/simple;
	bh=r/HPO+3T3d3Rsx1+glCgz0NrZqNjccBNAyubtwnWY3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfGcsDw32q+zwgmTaPwfP3Z6+/wGHKCaL8TzIkWTZuAZS2tNm2tBMWUxnW+qfxea1u+uIx1b7prWJdT64sKxDLMLotFPV4fRAyBbma937y76+yUuLI985vbPrDDtAueRsvjNtnorwyDGjeWdxnyfJeUm5Z1Bk1eRofLCwaxA0u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0Ax9u7d; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-428f5c0833bso11670275e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722934104; x=1723538904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkB0Cd0s/Qf30uEbUTYOzYCP2KGraAxLVDIwggQyhkE=;
        b=D0Ax9u7dx+o+y3NP9iSx9HaBXOkUFDftI5G0okULj6z6Etr7PR3v56wLKjB+eyTuTo
         4GuVNvWKt6Bi61E9xnClWL1eA1sEfBEMRBq5KzYnzVrUruuDJSNc+4DYK6bgpWUWLq3v
         zR4r4IeyDlIYBqePFQBJmwLNxiWltl2LEHqrp0sAhWeDioziiqdY365igi2jz6K5gpmV
         2l0uyK15iXHiYoUIYTbx5jp7Cr882oD7zKOGIye9/bQnhm4LdjBDSe2KiQQGgyTyG1fw
         e9QEsuQd8ywXjUk8maS9zbHVgVzf7E5lOZvRuHjHKjf0q6ukr6aCZJYtMSC6j/uZLGby
         Zdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722934104; x=1723538904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vkB0Cd0s/Qf30uEbUTYOzYCP2KGraAxLVDIwggQyhkE=;
        b=KCpGxq/LDUtKsfw6WKZAR9nufeANMnhKQQKt2KWRPFrsEoaZqUmTRjZqZ/tPqmydVU
         9Wx2MypWtwlz9CtAtWFqfx995x0ppnesYfwh3N3CB6GLS0e8sCbhhipuAfKLRcH5tQ4S
         HuCQknlSPZGPRevL7SclFNAANGMWt33HYnMpD6XIs8b0TcjzkpCWpUDe2rrKEKzQgTN2
         FAbGxBzMbOE6DlS2HRzO+7jJvehnTWKqUKUfdGJEn825eyX7V3BQBezY1eCT1bpnEWLH
         KpeSmIkB2a+vTrlW/HgiHCGsivlXSyKkvlXI9XIqJ70zlqwdHZ2eh+QYgT5uZFXq6goH
         gamw==
X-Forwarded-Encrypted: i=1; AJvYcCUrCpnWGaIEbP8kkqNyrq57NILQh4OBuWaYdA/1qcjIwSbTDXgigVk/8dDPmt7bgPFM0HszWTMlKrAllJPF/sfVplxEXw9iwAju9P1H
X-Gm-Message-State: AOJu0YypagzjuKKNwqudcbYpSw7K9izWuUZwX3J9yfIJ46BBwPXA7fk3
	i29J4OWj6ZiF5vQMeijzCo9e+EPpGWKZMgDOsTLyPZctlc2AUcZ+zaZ61kIRLJ+Z3cBXEeucZvm
	13oArKoctftxKnnVDzZvOiRQ1ATBkKlvz13o3
X-Google-Smtp-Source: AGHT+IGFgI0TVkke22UsDZQDfugvSmvi4S+Fu5uBorocOt5O9xaTLJiWkTnkaIRnZXLb/CpZCMg4SficQPlMCFHLlNY=
X-Received: by 2002:adf:ea02:0:b0:362:69b3:8e4d with SMTP id
 ffacd0b85a97d-36bbbecb622mr12534784f8f.25.1722934103552; Tue, 06 Aug 2024
 01:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725-alice-file-v8-0-55a2e80deaa8@google.com>
 <20240725-alice-file-v8-3-55a2e80deaa8@google.com> <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
In-Reply-To: <4bf5bf3b-88f4-4ee4-80fd-c566428d9f69@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 10:48:11 +0200
Message-ID: <CAH5fLgi0MGUhbD0WV99NtU+08HCJG+LYMtx+Ca4gwfo9FR+hTw@mail.gmail.com>
Subject: Re: [PATCH v8 3/8] rust: file: add Rust abstraction for `struct file`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 10:44=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On 25.07.24 16:27, Alice Ryhl wrote:
> > +/// Wraps the kernel's `struct file`. Not thread safe.
> > +///
> > +/// This type represents a file that is not known to be safe to transf=
er across thread boundaries.
> > +/// To obtain a thread-safe [`File`], use the [`assume_no_fdget_pos`] =
conversion.
> > +///
> > +/// See the documentation for [`File`] for more information.
> > +///
> > +/// # Invariants
> > +///
> > +/// * All instances of this type are refcounted using the `f_count` fi=
eld.
> > +/// * If there is an active call to `fdget_pos` that did not take the =
`f_pos_lock` mutex, then it
> > +///   must be on the same thread as this `File`.
>
> Do you mean `LocalFile`?

I guess. Perhaps I should just say "file" as a general concept?

> > +///
> > +/// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
> > +pub struct LocalFile {
> > +    inner: Opaque<bindings::file>,
> > +}
>
> [...]
>
> > +    /// Returns the flags associated with the file.
> > +    ///
> > +    /// The flags are a combination of the constants in [`flags`].
> > +    #[inline]
> > +    pub fn flags(&self) -> u32 {
> > +        // This `read_volatile` is intended to correspond to a READ_ON=
CE call.
> > +        //
> > +        // SAFETY: The file is valid because the shared reference guar=
antees a nonzero refcount.
> > +        //
> > +        // FIXME(read_once): Replace with `read_once` when available o=
n the Rust side.
>
> Do you know the status of this?

It's still unavailable.

> > +        unsafe { core::ptr::addr_of!((*self.as_ptr()).f_flags).read_vo=
latile() }
> > +    }
> > +}
> > +
> > +impl File {
> > +    /// Creates a reference to a [`File`] from a valid pointer.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// * The caller must ensure that `ptr` points at a valid file and=
 that the file's refcount is
> > +    ///   positive for the duration of 'a.
> > +    /// * The caller must ensure that if there are active `fdget_pos` =
calls on this file, then they
> > +    ///   took the `f_pos_lock` mutex.
> > +    #[inline]
> > +    pub unsafe fn from_raw_file<'a>(ptr: *const bindings::file) -> &'a=
 File {
> > +        // SAFETY: The caller guarantees that the pointer is not dangl=
ing and stays valid for the
> > +        // duration of 'a. The cast is okay because `File` is `repr(tr=
ansparent)`.
> > +        //
> > +        // INVARIANT: The caller guarantees that there are no problema=
tic `fdget_pos` calls.
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +}
> > +
> > +// Make LocalFile methods available on File.
> > +impl core::ops::Deref for File {
> > +    type Target =3D LocalFile;
> > +    #[inline]
> > +    fn deref(&self) -> &LocalFile {
> > +        // SAFETY: The caller provides a `&File`, and since it is a re=
ference, it must point at a
> > +        // valid file for the desired duration.
> > +        //
> > +        // By the type invariants, there are no `fdget_pos` calls that=
 did not take the
> > +        // `f_pos_lock` mutex.
> > +        unsafe { LocalFile::from_raw_file(self as *const File as *cons=
t bindings::file) }
> > +    }
> > +}
> > +
> > +// SAFETY: The type invariants guarantee that `LocalFile` is always re=
f-counted. This implementation
> > +// makes `ARef<File>` own a normal refcount.
> > +unsafe impl AlwaysRefCounted for LocalFile {
> > +    #[inline]
> > +    fn inc_ref(&self) {
> > +        // SAFETY: The existence of a shared reference means that the =
refcount is nonzero.
> > +        unsafe { bindings::get_file(self.as_ptr()) };
> > +    }
> > +
> > +    #[inline]
> > +    unsafe fn dec_ref(obj: ptr::NonNull<LocalFile>) {
> > +        // SAFETY: To call this method, the caller passes us ownership=
 of a normal refcount, so we
> > +        // may drop it. The cast is okay since `File` has the same rep=
resentation as `struct file`.
> > +        unsafe { bindings::fput(obj.cast().as_ptr()) }
> > +    }
> > +}
>
> Can you move these `AlwaysRefCounted` impls towards the struct
> definitions?
>
> With those two comments fixed:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks!

Alice


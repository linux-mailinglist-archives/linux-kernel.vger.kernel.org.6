Return-Path: <linux-kernel+bounces-276458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299C994940A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4741C2173C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFC518D653;
	Tue,  6 Aug 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H5lr5CpF"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5D91D1F4E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722956416; cv=none; b=c+MD8F6rVX8VbDDAMRHBQnM3tfmXQArlpxmjY3rAQy9INzcx5g66tQIwqz60B/+3R3gf9KIrScpUhWYDOrwYMQnJQu6D3ZcG1a1alC0wRyCPC+Q9ATx1LoNxtbSM82JBUU1NZ3NJE3IRd0f3RzTht8vGlJeO7EUIOC7vn4cb+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722956416; c=relaxed/simple;
	bh=yqisXkgSD2Nkg9hq1EwKbPZ+otbZreIdbThlZ/FBl7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGcPPerCEAg7649lKFDeoLzichRK3tkHNgZ5FO8PvuUysk+vjW0cOsnSLzXUZfgbpLdAx5db8i7Rm1PGt15xemW8MStGvHOALaE4Ig7w0MHaii9j7By9gJ3jVQMFo62/8Dx7nrcuk+LtpY9w/OuQnAS4F/Y+S8k5Ig8lujYVXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H5lr5CpF; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3685b3dbcdcso553976f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722956413; x=1723561213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3lPYNCqUQ0CBq9NAtWdv9x9dDXsAeH8iPTFshxwRXw=;
        b=H5lr5CpFbZxc2y9Tm5TvvMKN3HUwYHz4kzHKP1fzMPSe/tVdWIjCxpnPvvjP5iOdMP
         ioNYAssgTO2SkqpSlaqDpWbdz+iFTH1sDpcApaARxzP7lkZvPKtudpb8ABq3qs0LWVSX
         BZXPWmwHU/tZr/bDg79YVvbyy/gsmEpK7+wkZqw/Nm8nRPtW0julOH7KFSsFJtoN8N/G
         U1IDX0onSRrBqEpY27DoW0O3qj04a8jNwDViI9ibc29JvVP0jVg7Rd5OsIRJw7ARC2IM
         KzEXvwsnK32xwAiiCuX3j0BtKopOhk019jj3IxjshKRfotbMCI6yF0iHyE9RWZX/DkLz
         g1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722956413; x=1723561213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3lPYNCqUQ0CBq9NAtWdv9x9dDXsAeH8iPTFshxwRXw=;
        b=iy5ze8/rDwlrcpFkgNgP6AJmaRS0UFK/3gaG38ouAr86CDXXhCcHDlS4U558zDdasq
         1z8J4/HcEMZU0XuBDp3eRWMXy12LlH+fyduPVycUro0jg3Msj7UYvUZeGCB16zXSolY4
         4d0XjARZYpoIjVeAm9RF3IKQ2dPTLEeJ/JGyEEgN31bhtXeCxygeEWu3ODSMzyMokYqT
         kWfuXjhFDQO4Tj+Cm72OgLCxF85xlc2HqTBSqZS0OqxdLCzQ9pHLkpbDdW2kPyLakxP6
         563pAZbASuc6+YepR0rSZNnH0u386oIsN4zjpKWqeOLOxVfu3G3fgszUSVDbYINJiEVu
         TQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg8UeVBghGTNKA4OuHn9HVUf1l1Eatv28gKvUgyUe1/ySkEhD7jIFUVZS4XLPcrjOpZFWgkyVd/pQz9JsFFZHttvHoma5ulKEIV8qN
X-Gm-Message-State: AOJu0Yysn3zduKeV6AgFuD4olwQIOQoYiI+/684OAenv6NAfk0MAMT19
	i5gkwbJBYfa+h+r4IFCuQat1XHpjJc8sfY7SmLNbHlo0hkvMCQbtzJBCMu9jAVIU4ukPmP6n2jU
	Bhw+nzdLljPEozELBRUuyOqm2nG1zdwO5CWfU
X-Google-Smtp-Source: AGHT+IE/CVhS1wESVTuZ5jEcviM63X/Js9/n1/UOV4np0a6p1yHbV1w2VwEd+yTFq+QbD1M6s8WKCwNsuvaj3ZgfgSY=
X-Received: by 2002:a5d:5749:0:b0:367:8fee:443b with SMTP id
 ffacd0b85a97d-36bbc1911a4mr11189866f8f.41.1722956412869; Tue, 06 Aug 2024
 08:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-2-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-2-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 17:00:00 +0200
Message-ID: <CAH5fLgj=Z7HkBkdRscw1TTXbn5WTN5WvJsPBjnRTRw25CgUudQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/28] rust: alloc: add `Allocator` trait
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:20=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
>
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index 1966bd407017..8a71a589469d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -11,6 +11,7 @@
>  /// Indicates an allocation error.
>  #[derive(Copy, Clone, PartialEq, Eq, Debug)]
>  pub struct AllocError;
> +use core::{alloc::Layout, ptr::NonNull};
>
>  /// Flags to be used when allocating memory.
>  ///
> @@ -86,3 +87,81 @@ pub mod flags {
>      /// small allocations.
>      pub const GFP_NOWAIT: Flags =3D Flags(bindings::GFP_NOWAIT);
>  }
> +
> +/// The kernel's [`Allocator`] trait.
> +///
> +/// An implementation of [`Allocator`] can allocate, re-allocate and fre=
e memory buffer described
> +/// via [`Layout`].
> +///
> +/// [`Allocator`] is designed to be implemented as a ZST; [`Allocator`] =
functions do not operate on
> +/// an object instance.
> +///
> +/// In order to be able to support `#[derive(SmartPointer)]` later on, w=
e need to avoid a design
> +/// that requires an `Allocator` to be instantiated, hence its functions=
 must not contain any kind
> +/// of `self` parameter.
> +///
> +/// # Safety
> +///
> +/// Memory returned from an allocator must point to a valid memory buffe=
r and remain valid until
> +/// it is explicitly freed.
> +///
> +/// Any pointer to a memory buffer which is currently allocated must be =
valid to be passed to any
> +/// other [`Allocator`] function of the same type. The same applies for =
a NULL pointer.
> +///
> +/// If `realloc` is called with:
> +///   - a size of zero, the given memory allocation, if any, must be fre=
ed
> +///   - a NULL pointer, a new memory allocation must be created
> +pub unsafe trait Allocator {
> +    /// Allocate memory based on `layout` and `flags`.
> +    ///
> +    /// On success, returns a buffer represented as `NonNull<[u8]>` that=
 satisfies the layout
> +    /// constraints (i.e. minimum size and alignment as specified by `la=
yout`).
> +    ///
> +    /// This function is equivalent to `realloc` when called with a NULL=
 pointer.
> +    fn alloc(layout: Layout, flags: Flags) -> Result<NonNull<[u8]>, Allo=
cError> {
> +        // SAFETY: Passing a NULL pointer to `realloc` is valid by it's =
safety requirements and asks
> +        // for a new memory allocation.
> +        unsafe { Self::realloc(None, layout, flags) }
> +    }
> +
> +    /// Re-allocate an existing memory allocation to satisfy the request=
ed `layout`. If the
> +    /// requested size is zero, `realloc` behaves equivalent to `free`.
> +    ///
> +    /// If the requested size is larger than the size of the existing al=
location, a successful call
> +    /// to `realloc` guarantees that the new or grown buffer has at leas=
t `Layout::size` bytes, but
> +    /// may also be larger.
> +    ///
> +    /// If the requested size is smaller than the size of the existing a=
llocation, `realloc` may or
> +    /// may not shrink the buffer; this is implementation specific to th=
e allocator.
> +    ///
> +    /// On allocation failure, the existing buffer, if any, remains vali=
d.
> +    ///
> +    /// The buffer is represented as `NonNull<[u8]>`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `Some(ptr)` must point to an existing and valid memory allocatio=
n created by this allocator
> +    /// instance. The alignment encoded in `layout` must be smaller than=
 or equal to the alignment
> +    /// requested in the previous `alloc` or `realloc` call of the same =
allocation.
> +    ///
> +    /// Additionally, `ptr` is allowed to be `None`; in this case a new =
memory allocation is
> +    /// created.
> +    ///
> +    unsafe fn realloc(
> +        ptr: Option<NonNull<u8>>,
> +        layout: Layout,
> +        flags: Flags,
> +    ) -> Result<NonNull<[u8]>, AllocError>;
> +
> +    /// Free an existing memory allocation.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to an existing and valid memory allocation crea=
ted by this `Allocator`
> +    /// instance.
> +    unsafe fn free(ptr: NonNull<u8>) {
> +        // SAFETY: `ptr` is guaranteed to be previously allocated with t=
his `Allocator` or NULL.
> +        // Calling `realloc` with a buffer size of zero, frees the buffe=
r `ptr` points to.

It can't actually be NULL since it's a NonNull. I would reword to:

// SAFETY: The caller guarantees that `ptr` points at a valid
allocation created by this allocator. We are passing a Layout with the
smallest possible alignment, so it is smaller than or equal to the
alignment previously used with this allocation.

Anyway, otherwise this LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice


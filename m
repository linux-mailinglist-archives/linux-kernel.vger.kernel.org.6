Return-Path: <linux-kernel+bounces-414695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8B9D2C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C5D5284EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A271D0E14;
	Tue, 19 Nov 2024 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q/iM6dq7"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603B314AD1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732036104; cv=none; b=qPePEDjuabbERkuqLyTCJnhZfhlWRpCVNogM7ZcpRLp1AuR85Ifnpc+0U1l4r2t6proM8CktvWz0u6DyLXGphnWtHG87nj7qJB2Z5vcwudTYjHROkot5Dv6h8Ec40zH7jhF9LRM43V7lSjcsCnKAScQFej8yyEx0yMoKPUIlYhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732036104; c=relaxed/simple;
	bh=tqM86SeTKQoiep417VbKhJAWs7U+fRIvoXBzK1BPrJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TLZm1LqxDJ11SpHg+n5sLZbF53TYR4Os1ect117E66XrMfG4kPispsfOpDVu2geze1i1k6E7s6IIyN+Uu7xTH/bjv5va52hlhLREeCzG6EJ9woyMQVJ4ud3ZX92OfRvHTrE/15iOKF8vU3hY5HWqJ4fmZrzmiQ6CW5jnFKHcEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q/iM6dq7; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5cfb81a0af9so14853a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732036100; x=1732640900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCV9WHZTFYTHla+38liafRITO+eDswnLk5ctpG/DKf4=;
        b=Q/iM6dq7v9G6JJNqHSTv7JBAnMdjNaAiZ8s7mtwitY85W9kIXjqGHTqkzWtpmQMnOd
         38QQ7sNElCXJzFl/av4yJm3z9BfmXiF5j39SdkJw/TjniaoTjqnarQgCmmCsALKIORdC
         oFPjZCv25SVR85lGVn4Sx283GMhJbBvQ7wTTYW8XziuXvhYMXVu0dknc0Y6DWgZXjHa4
         mDX1YIVda2RQEgHD7vKMJBb9k0VB/cJN/ezcZ2VCxTlZrQG8b9cDaHP5rQBjGrSIkQkG
         En3sbI1lt1wWtT1dOx+yY4pUlCDgvXfFFQ8fXCcOkq8BcgmomoL26QXaga5VT2tz6hl8
         nQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732036100; x=1732640900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCV9WHZTFYTHla+38liafRITO+eDswnLk5ctpG/DKf4=;
        b=GSMTAyT0hSz7lLo1fspH0ts1Ve4Xk7+DvVXROaTFOp+wCL+jjP6r1BkMwk/hsRGTAW
         4fiyJqV4NQivXOQxxZ0Lkvv5an0qu9p1Y24f72uifUMvZB0KvmCIBZ78F/Z84I4yIT2q
         4p6q/JY5TgM2c09C0C2/+epiVGa3mG7Qyn/9shB+Qb8DGmcDO4hEIgMYfmroWu5wqDbc
         8JxbO23DNTwFexvETsrdf+EqvT761OIZXpZrHP2kIkK6bxBLKzJbDidmU/lspvjvUi6i
         cc4G1izAhUy7W87dif5n8skXc8f25pNYHD9eAGR9zkxD+Qij67Fw3Bgew1MZdpS11cTh
         5MKw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8eG4FxcmRC8aKxhyXE5wubHbEdfPRE8QqgpMGhEjC+1QJX3STJ2FXMQEcnSDke3BXfGN7AexIqq6rp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDD+FSVhRSE+FWY+fsM5dMffHzjeLM5FcxaF0eofk2sknZ8cY6
	SjlCcPsI09pKa7uMklrC/Vq7sCTsLAJuqfjRMubVDeph4IOz4diyzQJfVtAZ7s7rGCSkh5iF8Fz
	eZ0/L6kjGnwVYaZGE98WtjZHh+nuPhTh0MxaV
X-Gm-Gg: ASbGncs7r0wkVw49ioE5Oq7NsAfixFC8p2L/AYtAhKYzMT+A1VMWJDQMHQ6bT0GRP2j
	MDu9Je4wTpGv5BTVYYLJiDV7Sfoq5pkz78w1OgUnBUeDpGVZeCWoKH/sM4Pw=
X-Google-Smtp-Source: AGHT+IF2NA4+N5BCrudBX2E2EdWGDzoY5N2xiN8KTBuW6FT8jxbNTi1fhsn3CWPCChG9Plc207DSpKkVbPrO1sPa7NU=
X-Received: by 2002:a05:6402:50c6:b0:5cf:deaf:ac2 with SMTP id
 4fb4d7f45d1cf-5cfdec1bb2cmr115336a12.2.1732036099141; Tue, 19 Nov 2024
 09:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com> <20241119112408.779243-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20241119112408.779243-3-abdiel.janulgue@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 Nov 2024 18:07:43 +0100
Message-ID: <CAG48ez3fjXG1Zi=V8yte9ZgSkDVeJiQV6xau7FHocTiTMw0d=w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rust: page: Extend support to existing struct page mappings
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, airlied@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commenting as someone who understands kernel MM decently but only
knows a tiny bit about Rust:

On Tue, Nov 19, 2024 at 12:24=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
> Extend Page to support pages that are not allocated by the constructor,
> for example, those returned by vmalloc_to_page() or virt_to_page().
> Since we don't own those pages we shouldn't Drop them either. Hence we
> take advantage of the switch to Opaque so we can cast to a Page pointer
> from a struct page pointer and be able to retrieve the reference on an
> existing struct page mapping. In this case no destructor will be called
> since we are not instantiating a new Page instance.
>
> The new page_slice_to_page wrapper ensures that it explicity accepts
> only page-sized chunks.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
[...]
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index fdf7ee203597..d0a896f53afb 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -3,7 +3,7 @@
>  //! Kernel page allocation and management.
>
>  use crate::{
> -    alloc::{AllocError, Flags},
> +    alloc::{AllocError, Allocator, Flags, VVec, KVec, KVVec, Vec, flags:=
:*},
>      bindings,
>      error::code::*,
>      error::Result,
> @@ -87,6 +87,49 @@ pub fn alloc_page(flags: Flags) -> Result<ARef<Self>, =
AllocError> {
>          Ok(unsafe { ARef::from_raw(NonNull::new_unchecked(ptr)) })
>      }
>
> +    /// Create a page object from a buffer which is associated with an e=
xisting C `struct page`.
> +    ///
> +    /// This function ensures it takes a page-sized buffer as represente=
d by `PageSlice`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::page::*;
> +    ///
> +    /// let somedata: [u8; PAGE_SIZE * 2] =3D [0; PAGE_SIZE * 2];
> +    /// let buf: &[u8] =3D &somedata;
> +    /// let pages: VVec<PageSlice> =3D buf.try_into()?;
> +    /// let page =3D Page::page_slice_to_page(&pages[0])?;
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn page_slice_to_page<'a>(page: &PageSlice) -> Result<&'a Self>

Sorry, can you explain to me what the semantics of this are? Does this
create a Page reference that is not lifetime-bound to the PageSlice?

> +    {
> +        let ptr: *const core::ffi::c_void =3D page.0.as_ptr() as _;
> +        if ptr.is_null() {
> +            return Err(EINVAL)
> +        }
> +        // SAFETY: We've checked that `ptr` is non-null, hence it's safe=
 to call this method.
> +        let page =3D if unsafe { bindings::is_vmalloc_addr(ptr) } {
> +            // SAFETY: We've checked that `ptr` is non-null and within t=
he vmalloc range, hence
> +            // it's safe to call this method.
> +            unsafe { bindings::vmalloc_to_page(ptr) }
> +        // SAFETY: We've checked that `ptr` is non-null, hence it's safe=
 to call this method.
> +        } else if unsafe { bindings::virt_addr_valid(ptr) } {
> +            // SAFETY: We've checked that `ptr` is non-null and a valid =
virtual address, hence
> +            // it's safe to call this method.
> +            unsafe { bindings::virt_to_page(ptr) }
> +        } else {
> +            ptr::null_mut()
> +        };
> +        if page.is_null() {
> +            return Err(EINVAL);
> +        }
> +        // CAST: `Self` is a `repr(transparent)` wrapper around `binding=
s::page`.
> +        // SAFETY: We just successfully retrieved an existing `bindings:=
:page`, therefore
> +        // dereferencing the page pointer is valid.
> +        Ok(unsafe { &*page.cast() })
> +    }
> +
>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
>          self.page.get()
> @@ -270,3 +313,55 @@ unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
>          unsafe { bindings::put_page(obj.cast().as_ptr()) }
>      }
>  }
> +
> +/// A page-aligned, page-sized object.
> +///
> +/// This is used for convenience to convert a large buffer into an array=
 of page-sized chunks
> +/// allocated with the kernel's allocators which can then be used in the
> +/// `Page::page_slice_to_page` wrapper.
> +///
> +// FIXME: This should be `PAGE_SIZE`, but the compiler rejects everythin=
g except a literal
> +// integer argument for the `repr(align)` attribute.
> +#[repr(align(4096))]
> +pub struct PageSlice([u8; PAGE_SIZE]);
> +
> +fn to_vec_with_allocator<A: Allocator>(val: &[u8]) -> Result<Vec<PageSli=
ce, A>, AllocError> {
> +    let mut k =3D Vec::<PageSlice, A>::new();
> +    let pages =3D page_align(val.len()) >> PAGE_SHIFT;
> +    match k.reserve(pages, GFP_KERNEL) {

Do I understand correctly that this can be used to create a kmalloc
allocation whose pages can then basically be passed to
page_slice_to_page()?

FYI, the page refcount does not protect against UAF of slab
allocations through new slab allocations of the same size. In other
words: The slab allocator can internally recycle memory without going
through the page allocator, and the slab allocator itself does not
care about page refcounts.

If the Page returned from calling page_slice_to_page() on the slab
memory pages returned from to_vec_with_allocator() is purely usable as
a borrow and there is no way to later grab a refcounted reference to
it or pass it into a C function that assumes it can grab a reference
to the page, I guess that works. But if I understand correctly what's
going on here, and you can grab references to slab pages returned from
page_slice_to_page(to_vec_with_allocator()), that'd be bad.

> +        Ok(()) =3D> {
> +            // SAFETY: from above, the length should be equal to the vec=
tor's capacity
> +            unsafe { k.set_len(pages); }
> +            // SAFETY: src buffer sized val.len() does not overlap with =
dst buffer since
> +            // the dst buffer's size is val.len() padded up to a multipl=
e of PAGE_SIZE.
> +            unsafe { ptr::copy_nonoverlapping(val.as_ptr(), k.as_mut_ptr=
() as *mut u8,
> +                                              val.len()) };
> +            Ok(k)
> +        },
> +        Err(_) =3D> Err(AllocError),
> +    }
> +}


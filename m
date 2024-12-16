Return-Path: <linux-kernel+bounces-447528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908549F33C5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25EC164C59
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0ED32080DD;
	Mon, 16 Dec 2024 14:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gydENcCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1690A207E1D;
	Mon, 16 Dec 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360691; cv=none; b=T8oO+FcSneMflvs13ET3W1EQA7vbWQ86BioQ9eb+WilQYUwNIXC19toMwMTBwOaEM/F8SS2F0TdedCGF2FIDxWGjVhZU+Vi8Sr6XRDym6zJrV/BDP82YctPWVU9I11RrXGINf9b8CMXyQyMpXzuXFtT9k9Pm/+2cjDnni1HfDPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360691; c=relaxed/simple;
	bh=bA9uLAVZ8BgttLZYWSnIy1R0Ug4OzPSdjjR00xzG6Cs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=h/of7Ix2ZNHMWyEd6G4Cf4IHHw0JT/h3uZX5LNSs3NIy40wtGJdzOpIFWSH6Gzog78dvor1kCyZC3PmFuGSGD3fc36qXxISxkak9mTWDrcWH9l8Oak1ewEFk/FzricQNGv09ztqfR2sQtGA6kJIq4EUtFAzXJp+R5gCp+diFaNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gydENcCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBADC4CED0;
	Mon, 16 Dec 2024 14:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360690;
	bh=bA9uLAVZ8BgttLZYWSnIy1R0Ug4OzPSdjjR00xzG6Cs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=gydENcCYiqN9nlkfNikBstd+KaAqF32kisCt1UfFdZW2s0aHgbUriurkcQT7Qkgqa
	 9lsBW9s5YGeCkxfhGtpWCiyT/RcEZWma+y49hL42B14dJETPRJObqW4lhKlOzwUUmG
	 O/kULJ+mQzUm5uETHYlUckwtZQ2rXgHlab5/kbc+tsMEq+3MFU5nTLPIE2FID/wsxc
	 ellH5LqAvkHU+4aqwZzcmuLQm9py3GWsCE66HPYLjzOLZb42cePaJHFXEvsaZgT7Ui
	 6my0w1UlHK84nz8A4wfcS9NoqzWGm2mqoD2SCH9jyuuxDQ/1ZLUvDRfC+sV/MJg6j4
	 DywA/e7c6mkAA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
  "Vlastimil Babka" <vbabka@suse.cz>,  "John Hubbard"
 <jhubbard@nvidia.com>,  "Liam R. Howlett" <Liam.Howlett@oracle.com>,
  "Andrew Morton" <akpm@linux-foundation.org>,  "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Arnd Bergmann" <arnd@arndb.de>,
  "Christian Brauner" <brauner@kernel.org>,  "Jann Horn"
 <jannh@google.com>,  "Suren Baghdasaryan" <surenb@google.com>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?us-ascii?Q?=3D=3Futf-8=3FQ=3FBj=3DC3?=
 =?us-ascii?Q?=3DB6rn=3F=3D?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v11 3/8] mm: rust: add vm_insert_page
In-Reply-To: <20241211-vma-v11-3-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:07 +0000")
Date: Mon, 16 Dec 2024 13:25:12 +0100
Message-ID: <87o71bbys7.fsf@kernel.org>
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<k0kNBzmNg_c8GHIFyjlyJfEpyRNoAIZZVM1n3zK2kVT1pScUOUpkePSltcN-CfRI2UpS0OIvEG7FBvkHhXYrAQ==@protonmail.internalid>
	<20241211-vma-v11-3-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> The vm_insert_page method is only usable on vmas with the VM_MIXEDMAP
> flag, so we introduce a new type to keep track of such vmas.
>
> The approach used in this patch assumes that we will not need to encode
> many flag combinations in the type. I don't think we need to encode more
> than VM_MIXEDMAP and VM_PFNMAP as things are now. However, if that
> becomes necessary, using generic parameters in a single type would scale
> better as the number of flags increases.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/mm/virt.rs | 71 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index 68c763169cf0..3a23854e14f4 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -4,7 +4,15 @@
>
>  //! Virtual memory.
>
> -use crate::{bindings, mm::MmWithUser, types::Opaque};
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    mm::MmWithUser,
> +    page::Page,
> +    types::Opaque,
> +};
> +
> +use core::ops::Deref;
>
>  /// A wrapper for the kernel's `struct vm_area_struct` with read access.
>  ///
> @@ -100,6 +108,67 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>              )
>          };
>      }
> +
> +    /// Check whether the `VM_MIXEDMAP` flag is set.

Perhaps "Check whether the `VM_MIXEDMAP` flag is set. If so, return
`Some`, otherwise `None` ?

> +    ///
> +    /// This can be used to access methods that require `VM_MIXEDMAP` to be set.
> +    #[inline]
> +    pub fn as_mixedmap_vma(&self) -> Option<&VmAreaMixedMap> {
> +        if self.flags() & flags::MIXEDMAP != 0 {
> +            // SAFETY: We just checked that `VM_MIXEDMAP` is set. All other requirements are
> +            // satisfied by the type invariants of `VmAreaRef`.
> +            Some(unsafe { VmAreaMixedMap::from_raw(self.as_ptr()) })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with read access and `VM_MIXEDMAP` set.
> +///
> +/// It represents an area of virtual memory.

Could we have a link to `VmAreaRef` and explain that this is a
`VmAreaRef` with an additional requirement?

> +///
> +/// # Invariants
> +///
> +/// The caller must hold the mmap read lock or the vma read lock. The `VM_MIXEDMAP` flag must be
> +/// set.
> +#[repr(transparent)]
> +pub struct VmAreaMixedMap {
> +    vma: VmAreaRef,
> +}
> +
> +// Make all `VmAreaRef` methods available on `VmAreaMixedMap`.
> +impl Deref for VmAreaMixedMap {
> +    type Target = VmAreaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmAreaRef {
> +        &self.vma
> +    }
> +}
> +
> +impl VmAreaMixedMap {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap read lock
> +    /// (or stronger) is held for at least the duration of 'a. The `VM_MIXEDMAP` flag must be set.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Maps a single page at the given address within the virtual memory area.
> +    ///
> +    /// This operation does not take ownership of the page.
> +    #[inline]
> +    pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
> +        // SAFETY: The caller has read access and has verified that `VM_MIXEDMAP` is set. The page
> +        // is order 0. The address is checked on the C side so it can take any value.

Maybe something like this: "By the type invariant of `Self` caller has read
access and has verified that `VM_MIXEDMAP` is set. By invariant on
`Page` the page has order 0."

> +        to_result(unsafe { bindings::vm_insert_page(self.as_ptr(), address as _, page.as_ptr()) })
> +    }
>  }
>
>  /// The integer type used for vma flags.


Best regards,
Andreas Hindborg




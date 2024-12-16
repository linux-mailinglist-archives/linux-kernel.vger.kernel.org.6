Return-Path: <linux-kernel+bounces-447518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D69F33AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E821883786
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9020627F;
	Mon, 16 Dec 2024 14:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntDhzXmm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892BB1494DC;
	Mon, 16 Dec 2024 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360668; cv=none; b=owKLZsOd/qxe/vjLIcECSnxZKK3AnAnxLbQ/dXzBV1T5K7hJ6kbrj8P29n9BKOErGzXAZBQCUrOXB2RMSU17olbe5jKjy5qwnrwQlqxq5hwL+Cpmcv8q72B+tn7agkWHXyR3y57fX2jAvY316EjBsXlDd6BDKTs0QmsNM4WUIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360668; c=relaxed/simple;
	bh=SMYh9PcJuq1j1ppQPjaIWrpi0Qfk9xq4kRLozv99bfA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=m7eeg7gn8kcSouFhazA6pisHysKDn/738mU7vwEpHvGo0y92Jhdb3id+YDfXxsua/HL9SxzFTYE40FgZ3si3uwtMGIReozg/ah4kFL6Bztwc/i9AgG8LAbNxFTDBdWMMZEx4FuJPWB4kmCmBcBrplUkSThrfEGqMkweXZIqJGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntDhzXmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F710C4CED0;
	Mon, 16 Dec 2024 14:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360668;
	bh=SMYh9PcJuq1j1ppQPjaIWrpi0Qfk9xq4kRLozv99bfA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=ntDhzXmmrbqmdgNWGzQzuiK1LJPv4aJUfNdyUWxZa7g6l2M60aPj6DwndsAvSj/NW
	 Hs7RztDXDaDxOD1A32CM6Ji3MmsIOdRl7tCArNIg/0BtPm0hfa3CC2LkBQ+3WgWZpe
	 emINfwDDiLp1tSTMJfMiQmFTfn4rAD1ApTEdHSv7lIi+b3k8CPnSI2JuhhCk+j8kKx
	 lkPVZeG23uyOOkQb8YvzYj+hSVa5GGZCvwVcbTH27f4iOoqcOdEP3AsqcKZaKiqoD9
	 SzmZ5i2IaNlwgWO6g3pa7KFGx8u0vml72gjDhflbjBHSBlpvjBNe6EaM8IstP+dEH0
	 ntV5T9sMpJscQ==
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
  "Gary Guo" <gary@garyguo.net>,  =?us-ascii?Q?=3D=3Fus-ascii=3FQ=3F=3D3D?=
 =?us-ascii?Q?=3D3Fus-ascii=3D3FQ=3D3F=3D3D3D=3F=3D_=3D=3Fus-ascii=3FQ=3F?=
 =?us-ascii?Q?=3D3D3Futf-8=3D3D3FQ=3D3D3FBj=3D3D3DC3=3D3F=3D3D=5F=3D3D=3D3?=
 =?us-ascii?Q?Fus-ascii=3D3FQ=3D3F=3F=3D_=3D=3Fus-ascii=3FQ=3F=3D3D3DB6rn?=
 =?us-ascii?Q?=3D3D3F=3D3D3D=3D3F=3D3D=3F=3D?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Trevor Gross" <tmgross@umich.edu>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v11 2/8] mm: rust: add vm_area_struct methods that
 require read access
In-Reply-To: <20241211-vma-v11-2-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:06 +0000")
Date: Mon, 16 Dec 2024 13:12:30 +0100
Message-ID: <874j33ddxt.fsf@kernel.org>
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<RiN4oxf3FtqzOa42iVF50yHiC7LgOLlBneneq5PqKrMSQTHph5qY1Vfm3lCY4BUyz_SqqRNWoibFUVuSfEPR3Q==@protonmail.internalid>
	<20241211-vma-v11-2-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi Alice,

In general, can we avoid the `as _` casts? If not, could you elaborate
why they are the right choice here, rather than `try_into`?

Other comments inline below.

"Alice Ryhl" <aliceryhl@google.com> writes:

> This adds a type called VmAreaRef which is used when referencing a vma
> that you have read access to. Here, read access means that you hold
> either the mmap read lock or the vma read lock (or stronger).
>
> Additionally, a vma_lookup method is added to the mmap read guard, which
> enables you to obtain a &VmAreaRef in safe Rust code.
>
> This patch only provides a way to lock the mmap read lock, but a
> follow-up patch also provides a way to just lock the vma read lock.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers/mm.c      |   6 ++
>  rust/kernel/mm.rs      |  21 ++++++
>  rust/kernel/mm/virt.rs | 191 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 218 insertions(+)
>

[cut]

> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> new file mode 100644
> index 000000000000..68c763169cf0
> --- /dev/null
> +++ b/rust/kernel/mm/virt.rs
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Virtual memory.

Could you add a bit more context here?

> +
> +use crate::{bindings, mm::MmWithUser, types::Opaque};
> +
> +/// A wrapper for the kernel's `struct vm_area_struct` with read access.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// The caller must hold the mmap read lock or the vma read lock.
> +#[repr(transparent)]
> +pub struct VmAreaRef {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +// Methods you can call when holding the mmap or vma read lock (or
> strong). They must be usable no

typo "strong".

> +// matter what the vma flags are.
> +impl VmAreaRef {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, and that the mmap or vma
> +    /// read lock (or stronger) is held for at least the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Returns a raw pointer to this area.
> +    #[inline]
> +    pub fn as_ptr(&self) -> *mut bindings::vm_area_struct {
> +        self.vma.get()
> +    }
> +
> +    /// Access the underlying `mm_struct`.
> +    #[inline]
> +    pub fn mm(&self) -> &MmWithUser {
> +        // SAFETY: By the type invariants, this `vm_area_struct` is valid and we hold the mmap/vma
> +        // read lock or stronger. This implies that the underlying mm has a non-zero value of
> +        // `mm_users`.
> +        unsafe { MmWithUser::from_raw((*self.as_ptr()).vm_mm) }
> +    }
> +
> +    /// Returns the flags associated with the virtual memory area.
> +    ///
> +    /// The possible flags are a combination of the constants in [`flags`].
> +    #[inline]
> +    pub fn flags(&self) -> vm_flags_t {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.vm_flags as _ }
> +    }
> +
> +    /// Returns the (inclusive) start address of the virtual memory area.
> +    #[inline]
> +    pub fn start(&self) -> usize {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_start as _ }
> +    }
> +
> +    /// Returns the (exclusive) end address of the virtual memory area.
> +    #[inline]
> +    pub fn end(&self) -> usize {
> +        // SAFETY: By the type invariants, the caller holds at least the mmap read lock, so this
> +        // access is not a data race.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_1.__bindgen_anon_1.vm_end as _ }
> +    }
> +
> +    /// Zap pages in the given page range.
> +    ///
> +    /// This clears page table mappings for the range at the leaf level, leaving all other page
> +    /// tables intact,

I don't fully understand this docstring. Is it correct that the function
will unmap the address range given by `start` and `size`, _and_ free the
pages used to hold the mappings at the leaf level of the page table?

> and freeing any memory referenced by the VMA in this range. That is,
> +    /// anonymous memory is completely freed, file-backed memory has its reference count on page
> +    /// cache folio's dropped, any dirty data will still be written back to disk as usual.
> +    #[inline]
> +    pub fn zap_page_range_single(&self, address: usize, size: usize) {


Best regards,
Andreas Hindborg




Return-Path: <linux-kernel+bounces-271393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81500944D92
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E961C22E89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F019014A601;
	Thu,  1 Aug 2024 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqMD1JAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925E1A38C1;
	Thu,  1 Aug 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520954; cv=none; b=Q12sam2prTSS3M8RHPoryonrkZhMSpoZuPg8D1HzIi8IIrNeDTko8DIXXFqq3nRM5MJVdCLggJM8YDbu7gTXCWLJIQ11w8ZeutIugCHdR55+DNVyRBV0Lg4oRjhUdA+EUaRSocs68jtnVSgA5S6m3wZtjO/km1qo68xpqz8T2uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520954; c=relaxed/simple;
	bh=VdiINaxnbnaYhSdTjoFb4By0McAamaV/qtatA2bkCFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2KWNP7uDsUD7ltQfu/t07SQovThU8MKft7sRdcqNhBIviWWYgclLAHyz76I1Yarmkoh9IcoyfBo/POPZ4w4JJNDBiscLBjkv7KjaGL77vM+V96LbCaVaf0aoFIcvCNLmsVvH5XCHZrVU4KDcN3VGqO5YCGPqCxCW8YLm61yPic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqMD1JAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34783C32786;
	Thu,  1 Aug 2024 14:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722520953;
	bh=VdiINaxnbnaYhSdTjoFb4By0McAamaV/qtatA2bkCFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqMD1JAHCRf4bPp4ekUD0sWbvUCOfESxAU37GVTDioDHOXUAm0FoaszYBPq9gvUP2
	 BPpqNQQuSeJw7oK9RNbSc4FUX1H/8jBMwMp2kVPLLozn6afueYG5x4iQink6vb0gzF
	 x4mqERJc8lnrImgMwEZLiYf9njYy1KHSgYRp7vaAZunybAcEwQg9t6G8rB16K6E24B
	 Eb1Qn9nl18SXnQC2X9wTwI8AqG+InYOfQ/cytcFgtFg0vQbuRpBtFzCHRK5XUxUD/8
	 4qrc40E29sCk11PY2i7ddsM8f1SkE2dKq4APw8DDc5T18KFJ7sgqAW4fm+ANVcTM8T
	 wKfMqhpUsCCyg==
Date: Thu, 1 Aug 2024 16:02:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3] rust: mm: add abstractions for mm_struct and
 vm_area_struct
Message-ID: <ZquVcyeLqGGRbgx-@pollux>
References: <20240801-vma-v3-1-db6c1c0afda9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-vma-v3-1-db6c1c0afda9@google.com>

On Thu, Aug 01, 2024 at 12:58:45PM +0000, Alice Ryhl wrote:
> This is a follow-up to the page abstractions [1] that were recently
> merged in 6.11. Rust Binder will need these abstractions to manipulate
> the vma in its implementation of the mmap fop on the Binder file.
> 
> This patch is based on Wedson's implementation on the old rust branch,
> but has been changed significantly. All mistakes are Alice's.
> 
> Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@google.com [1]
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v3:
> - Reorder entries in mm.rs.
> - Use ARef for mmput_async helper.
> - Clarify that VmArea requires you to hold the mmap read or write lock.
> - Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@google.com
> 
> Changes in v2:
> - mm.rs is redesigned from scratch making use of AsRef
> - Add notes about whether destructors may sleep
> - Rename Area to VmArea
> - Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com
> ---
>  rust/helpers.c         |  61 +++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 337 +++++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/mm/virt.rs | 204 ++++++++++++++++++++++++++++++
>  rust/kernel/types.rs   |   9 ++
>  5 files changed, 612 insertions(+)
> 
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..ed2db893fb79
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.
> +//!
> +//! C header: [`include/linux/mm.h`](../../../../include/linux/mm.h)

NIT: srctree

> +
> +    /// Returns a raw pointer to the inner `mm_struct`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> +        self.mm.get()
> +    }
> +
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
> +    /// during the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw_mm<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {

I'd just call this `from_raw`, like you call the counterpart `as_raw` above.
Same goes for `MmWithUser` and `VmArea`.

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index bd189d646adb..143a2bf06941 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -366,6 +366,15 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>              _p: PhantomData,
>          }
>      }
> +
> +    /// Pass ownership of the refcount to a raw pointer.
> +    pub fn into_raw(self) -> NonNull<T> {
> +        let ptr = self.ptr;
> +        // Skip the destructor.
> +        core::mem::forget(self);
> +
> +        ptr
> +    }

I think this should be a separate patch.

>  }
>  
>  impl<T: AlwaysRefCounted> Clone for ARef<T> {
> 
> ---
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
> change-id: 20240723-vma-f80119f9fb35
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
> 


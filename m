Return-Path: <linux-kernel+bounces-377661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 966FD9AC201
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324A7B25D77
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1D815C158;
	Wed, 23 Oct 2024 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="log0oo+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59D515B119;
	Wed, 23 Oct 2024 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729672952; cv=none; b=sFM6nE/AmKg2M9fD0mnKNnHqO/2dCy5S3L3nWEV3bMQmfSa5DJVkJqv7hwt1l8OkF/ivNlZZqWpihOOwiNB4ePq1D9vkIalW566U0sZyJFmzc8Jauxt8aAY1SJDhf1BhmzkPCbpVuNtqn0rgR5U+p3tUVHpvAFDEh1jOotkFb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729672952; c=relaxed/simple;
	bh=MUvsm0SJiAa7QJxtfIg1c1B+VPR/9fnWUOukgzeCebI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doj6SA3bjTnTFpVpJNz9OHYScZAO7k5xsFzMfdxCE2qWi6B3VLGmdKAuxQ+0dtVKvEit0x0cvF8K9/2s8dHZFGaK5W+hweGcRd3rremN0ZJlsOOLTQavJw4NXLhvKHC5f8xxGRVR35Gl3KrvwFMkqoevcg8+gi8/X4MyICo+J4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=log0oo+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B931C4CEC6;
	Wed, 23 Oct 2024 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729672952;
	bh=MUvsm0SJiAa7QJxtfIg1c1B+VPR/9fnWUOukgzeCebI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=log0oo+MY70lsYlmUABQukyclUAvCVf9UoVj1hhSijAYjdobWreM4J9NUjpM/jw6z
	 E+UXAn6DuLEgloK0G0xE/ez0OBaQ6FsMidPIlW5JXN0RQsvoNNgxR/ZuEGQb31MRL5
	 gQu0QQP1QiGU18fU4QDHaP2RxZxEZE6m72E64jKragb3CEKOJ+N/QYfWb8DnCd7s/6
	 6/jgkqaTsdY72cHSt7iIY/qWr+9HrwDmb9QlLV/VbprAkmJRI/IDKVxrd6MHt3990T
	 xgooWawOO01Q7OJfzaGdAcFv3zJPNKpjcTuG7IQueDVXCVDEGjUmcwLYBD45LSeKg/
	 kxON/qpD4Pa5A==
Date: Wed, 23 Oct 2024 10:42:27 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
	linux-kernel@vger.kernel.org, airlied@redhat.com,
	miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
Subject: Re: [PATCH v2 3/5] rust: page: Extend support to vmalloc_to_page
Message-ID: <Zxi287W_MJcMB4YO@pollux>
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-4-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022224832.1505432-4-abdiel.janulgue@gmail.com>

On Wed, Oct 23, 2024 at 01:44:47AM +0300, Abdiel Janulgue wrote:
> Extend Page to support pages that are not allocated by the constructor, for
> example, those returned by vmalloc_to_page(). Since we don't own those pages
> we shouldn't Drop them either. Hence we take advantage of the switch to Opaque
> so we can cast to a Page pointer from a struct page pointer and be able to
> retrieve the reference on an existing struct page mapping. In this case
> no destructor will be called since we are not instantiating a new Page instance.
> 
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/page.rs | 32 ++++++++++++++++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index a8288c15b860..465928986f4b 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
> @@ -31,11 +31,12 @@ pub const fn page_align(addr: usize) -> usize {
>      (addr + (PAGE_SIZE - 1)) & PAGE_MASK
>  }
>  
> -/// A pointer to a page that owns the page allocation.
> +/// A pointer to a page that may own the page allocation.
>  ///
>  /// # Invariants
>  ///
> -/// The pointer is valid, and has ownership over the page.
> +/// The pointer is valid, and has ownership over the page if the page is allocated by this
> +/// abstraction.
>  #[repr(transparent)]
>  pub struct Page {
>      page: Opaque<bindings::page>,
> @@ -88,6 +89,33 @@ pub fn alloc_page(flags: Flags) -> Result<Owned<Self>, AllocError> {
>          Ok(unsafe { Owned::to_owned(ptr) })
>      }
>  
> +    /// This is just a wrapper to vmalloc_to_page which returns an existing page mapping, hence

In documentation, try to avoid filler words, such as "just". Better say
something like:

"This is an abstraction around the C `vmalloc_to_page()` function. Note that by
a call to this function the caller doesn't take ownership of the returned `Page`
[...]."

> +    /// we don't take ownership of the page. Returns an error if the pointer is null or if it
> +    /// is not returned by vmalloc().
> +    pub fn vmalloc_to_page<'a>(
> +        cpu_addr: *const core::ffi::c_void

When you have a raw pointer argument in your function it becomes unsafe by
definition.

I also think it would also be better to pass a `NonNull<u8>` instead.

> +    ) -> Result<&'a Self, AllocError>

Please don't use `AllocError`. We're not allocating anything here.

Anyway, do we need this as a separate function at all?

> +    {
> +        if cpu_addr.is_null() {
> +            return Err(AllocError);
> +        }
> +        // SAFETY: We've checked that the pointer is not null, so it is safe to call this method.
> +        if unsafe { !bindings::is_vmalloc_addr(cpu_addr) } {
> +            return Err(AllocError);
> +        }
> +        // SAFETY: We've initially ensured the pointer argument to this function is not null and
> +        // checked for the requirement the the buffer passed to it should be allocated by vmalloc,
> +        // so it is safe to call this method.
> +        let page = unsafe { bindings::vmalloc_to_page(cpu_addr) };
> +        if page.is_null() {
> +            return Err(AllocError);
> +        }

I think those should all return `EINVAL` instead.

> +        // CAST: `Self` is a `repr(transparent)` wrapper around `bindings::page`.
> +        // SAFETY: We just successfully allocated a page, therefore dereferencing
> +        // the page pointer is valid.
> +        Ok(unsafe { &*page.cast() })
> +    }
> +
>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
>          self.page.get()
> -- 
> 2.43.0
> 


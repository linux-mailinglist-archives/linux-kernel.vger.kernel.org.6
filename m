Return-Path: <linux-kernel+bounces-521200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198D7A3B77F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 994107A7B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEAD1E51ED;
	Wed, 19 Feb 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn/5O4Py"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110681DE2C5;
	Wed, 19 Feb 2025 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956135; cv=none; b=GQAGX0FWbG4lUykjjW11rPQydppRNLRzeam+BC4BtG/KF8pcv+6KVCELFn3I5lIhXuKQbBruKlVImWWRBTqHJTnJNtD07tQIBomVpYHvK5iyobIyDbmiN+HzdgvJHlY2GnhC+WRXBhmUhiLKqHjFZa/uLVz2mogZ8nGxcvF/gaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956135; c=relaxed/simple;
	bh=H5NMFS2Fh2rZLI4Ybr4KO56eNYRwtHNXpI5Gr51mPrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cWxAV7469fgOxtdkANuswcKZ492Gf6C72/T2H/2XhffB+ggzMFa3oC10oXadJlQxQdRQRFH1m+vc6i4OnB4SBq3PldI1tL96STAUQ3Vz7WFWDVzvND5DRBvIkoT3gQPaBZBaSHf5L7GmhnWpl0GaBGcTOLU053xdzVyqNLoVs6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn/5O4Py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9377C4CEE8;
	Wed, 19 Feb 2025 09:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739956134;
	bh=H5NMFS2Fh2rZLI4Ybr4KO56eNYRwtHNXpI5Gr51mPrQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cn/5O4Py8nkJkGYAn5w3MmHBEFOVt01d1Ny7OCDGR4665c6UZeu0jZ9ne3VtKtaOv
	 w2r5joyy7DyVMQdQFVH9lEY/eCybUgOSoRqfCxj82PKRz4jEavtz/jmo3Hotoa8PKb
	 IhhRW4Ycm/W5ydcV2au/2as69WSk2Jr1kx1kmXR2AOW2Wt0IBpSru0ljk8Jxz2/BEu
	 HK6D1Td7xjZxJhs7ksKtLLNPK6IHeoI/BDI/JqI/4gForwP2DiuhlywDW1nfY1Hr4l
	 7x8swvlgZJ+kkLMygbcGUBawIJ9Z8632m/iszzWSPIP6/6BwwZIX61EhVA49HVcrjU
	 lUJ6xc8RoxusA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Asahi Lina" <lina@asahilina.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Jann Horn" <jannh@google.com>,
  "Matthew Wilcox" <willy@infradead.org>,  "Paolo Bonzini"
 <pbonzini@redhat.com>,  "Danilo Krummrich" <dakr@kernel.org>,  "Wedson
 Almeida Filho" <wedsonaf@gmail.com>,  "Valentin Obst"
 <kernel@valentinobst.de>,  "Andrew Morton" <akpm@linux-foundation.org>,
  <linux-mm@kvack.org>,  <airlied@redhat.com>,  "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <asahi@lists.linux.dev>
Subject: Re: [PATCH 5/6] rust: page: Add physical address conversion functions
In-Reply-To: <20250202-rust-page-v1-5-e3170d7fe55e@asahilina.net> (Asahi
	Lina's message of "Sun, 02 Feb 2025 22:05:47 +0900")
References: <20250202-rust-page-v1-0-e3170d7fe55e@asahilina.net>
	<VV8JXgQx5DhojJFUVdTJ-K7EH0VWJ4_JVIMqPi_SQJPDuak8dJOVOhWSIpndjMtwJUTDwDSt4T8jFtkiUmpQOQ==@protonmail.internalid>
	<20250202-rust-page-v1-5-e3170d7fe55e@asahilina.net>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 19 Feb 2025 10:06:48 +0100
Message-ID: <87r03ucnh3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Asahi Lina" <lina@asahilina.net> writes:

[...]

>  /// A bitwise shift for the page size.
> @@ -249,6 +251,69 @@ pub unsafe fn copy_from_user_slice_raw(
>              reader.read_raw(unsafe { core::slice::from_raw_parts_mut(dst.cast(), len) })
>          })
>      }
> +
> +    /// Returns the physical address of this page.
> +    pub fn phys(&self) -> PhysicalAddr {
> +        // SAFETY: `page` is valid due to the type invariants on `Page`.
> +        unsafe { bindings::page_to_phys(self.as_ptr()) }
> +    }
> +
> +    /// Converts a Rust-owned Page into its physical address.
> +    ///
> +    /// The caller is responsible for calling [`Page::from_phys()`] to avoid leaking memory.
> +    pub fn into_phys(this: Owned<Self>) -> PhysicalAddr {
> +        ManuallyDrop::new(this).phys()
> +    }
> +
> +    /// Converts a physical address to a Rust-owned Page.
> +    ///
> +    /// # Safety
> +    /// The caller must ensure that the physical address was previously returned by a call to
> +    /// [`Page::into_phys()`], and that the physical address is no longer used after this call,
> +    /// nor is [`Page::from_phys()`] called again on it.

Do we really need the `PhysicalAddr` to come from a call to
`Page::into_phys`? Could we relax this and say that we don't care how
you came about the `PhysicalAddr` as long as you can guarantee that
ownership is correct? That would make interop with C easer in some cases.

> +    pub unsafe fn from_phys(phys: PhysicalAddr) -> Owned<Self> {
> +        // SAFETY: By the safety requirements, the physical address must be valid and
> +        // have come from `into_phys()`, so phys_to_page() cannot fail and
> +        // must return the original struct page pointer.
> +        unsafe { Owned::from_raw(NonNull::new_unchecked(bindings::phys_to_page(phys)).cast()) }
> +    }
> +
> +    /// Borrows a Page from a physical address, without taking over ownership.
> +    ///
> +    /// If the physical address does not have a `struct page` entry or is not
> +    /// part of a System RAM region, returns None.
> +    ///
> +    /// # Safety
> +    /// The caller must ensure that the physical address, if it is backed by a `struct page`,
> +    /// remains available for the duration of the borrowed lifetime.
> +    pub unsafe fn borrow_phys(phys: &PhysicalAddr) -> Option<&Self> {
> +        // SAFETY: This is always safe, as it is just arithmetic
> +        let pfn = unsafe { bindings::phys_to_pfn(*phys) };
> +        // SAFETY: This function is safe to call with any pfn
> +        if !unsafe { bindings::pfn_valid(pfn) && bindings::page_is_ram(pfn) != 0 } {
> +            None
> +        } else {
> +            // SAFETY: We have just checked that the pfn is valid above, so it must
> +            // have a corresponding struct page. By the safety requirements, we can
> +            // return a borrowed reference to it.
> +            Some(unsafe { &*(bindings::pfn_to_page(pfn) as *mut Self as *const Self) })

I think you can maybe go
`bindings::pfn_to_page(pfn).cast::<Self>().cast_const()` here.

> +        }
> +    }
> +
> +    /// Borrows a Page from a physical address, without taking over ownership
> +    /// nor checking for validity.
> +    ///
> +    /// # Safety
> +    /// The caller must ensure that the physical address is backed by a `struct page` and
> +    /// corresponds to System RAM. This is true when the address was returned by
> +    /// [`Page::into_phys()`].
> +    pub unsafe fn borrow_phys_unchecked(phys: &PhysicalAddr) -> &Self {
> +        // SAFETY: This is always safe, as it is just arithmetic
> +        let pfn = unsafe { bindings::phys_to_pfn(*phys) };
> +        // SAFETY: The caller guarantees that the pfn is valid. By the safety
> +        // requirements, we can return a borrowed reference to it.
> +        unsafe { &*(bindings::pfn_to_page(pfn) as *mut Self as *const Self) }

Same applies here.


Best regards,
Andreas Hindborg





Return-Path: <linux-kernel+bounces-447516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A399F33AA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD1A1888E33
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516D146599;
	Mon, 16 Dec 2024 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iY3MHIeD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE502145A05;
	Mon, 16 Dec 2024 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360657; cv=none; b=SJHSg0hB1+seQ8Yv/dDriRK6KhUdeOnXV0ZFRe34rFAN8s6QmqONTC4juoWIaqoCKDI8ysR1RLMNKVjlPf5jwndbQhBPaC/BxnKeDUyduGIC8xW9dKfDDO9TBF5F7hAVEHYqg/rw/4HNQq9cQFZ5wn9SsBYUWrpn5ASyKYhvj60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360657; c=relaxed/simple;
	bh=FHSKQmzPdFG9CKTMPQ6TI+GuboZTe/7QRXLSQ47Adp4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Pa7yZI1qxdMz6xb7jg4eL3frmmlYzSArAnfB/BwtxQBohRYvf5pYItQPXmHdXGsgI+ifcGOweBoCrucQ8a1CPp3/gSm15pgL5oCcFkQlK9QQageVoVJAN0C/WdGmt7Kqbj1dIjIqN00DLoMkudvTxDfEItUqOtL8mJzbb7FUUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iY3MHIeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31E7C4CED0;
	Mon, 16 Dec 2024 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734360657;
	bh=FHSKQmzPdFG9CKTMPQ6TI+GuboZTe/7QRXLSQ47Adp4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:References:From;
	b=iY3MHIeD+eKZcKR6936M4JiHCd9w4+Hm6gJ2fTm9HF2TC0lPxlMw4j/M0qkLF9lGE
	 bp4tsX6m9Qw8mZjQSxjvufNA24PnvzlMEwDuLt2lsAxhb+8IpN+aVZBzVCCTtekdnx
	 MJFeWJ0LlVHulmrQ9Ye7gloOmVeQPgUmZKZFN/YEzh+htZ2QhzF3i2Bfjtr2rNhM2E
	 gd4nvxd4p2+wYLHlqZfp14Qod2FuXhB6u0tsMeorMiJIyzWsa1DvqEQevMstDQ4nm7
	 6earhRgnx37C5DVA0YN4ihLtUxqXHGvmq7peJk6GsgP+qAZOY876Zdj3i6wcCs6g4y
	 8zufe36yAuQvw==
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
Subject: Re: [PATCH v11 4/8] mm: rust: add lock_vma_under_rcu
In-Reply-To: <20241211-vma-v11-4-466640428fc3@google.com> (Alice Ryhl's
	message of "Wed, 11 Dec 2024 10:37:08 +0000")
Date: Mon, 16 Dec 2024 13:47:11 +0100
Message-ID: <87jzbzbxrk.fsf@kernel.org>
References: <20241211-vma-v11-0-466640428fc3@google.com>
	<zLgtayXoZAk9UcN1xyPVa-vRd7F8sqv12X8fKo4pIXbs0xFLULWuH5tBEbOiIuktvkf7o4PNsNvDli037vcxnQ==@protonmail.internalid>
	<20241211-vma-v11-4-466640428fc3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> Currently, the binder driver always uses the mmap lock to make changes
> to its vma. Because the mmap lock is global to the process, this can
> involve significant contention. However, the kernel has a feature called
> per-vma locks, which can significantly reduce contention. For example,
> you can take a vma lock in parallel with an mmap write lock. This is
> important because contention on the mmap lock has been a long-term
> recurring challenge for the Binder driver.
>
> This patch introduces support for using `lock_vma_under_rcu` from Rust.
> The Rust Binder driver will be able to use this to reduce contention on
> the mmap lock.
>
> Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers/mm.c |  5 +++++
>  rust/kernel/mm.rs | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> index 7b72eb065a3e..81b510c96fd2 100644
> --- a/rust/helpers/mm.c
> +++ b/rust/helpers/mm.c
> @@ -43,3 +43,8 @@ struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
>  {
>  	return vma_lookup(mm, addr);
>  }
> +
> +void rust_helper_vma_end_read(struct vm_area_struct *vma)
> +{
> +	vma_end_read(vma);
> +}
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> index ace8e7d57afe..425b73a9dfe6 100644
> --- a/rust/kernel/mm.rs
> +++ b/rust/kernel/mm.rs
> @@ -13,6 +13,7 @@
>  use core::{ops::Deref, ptr::NonNull};
>
>  pub mod virt;
> +use virt::VmAreaRef;
>
>  /// A wrapper for the kernel's `struct mm_struct`.
>  ///
> @@ -170,6 +171,32 @@ pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
>          unsafe { &*ptr.cast() }
>      }
>
> +    /// Attempt to access a vma using the vma read lock.
> +    ///
> +    /// This is an optimistic trylock operation, so it may fail if there is contention. In that
> +    /// case, you should fall back to taking the mmap read lock.
> +    ///
> +    /// When per-vma locks are disabled, this always returns `None`.
> +    #[inline]
> +    pub fn lock_vma_under_rcu(&self, vma_addr: usize) -> Option<VmaReadGuard<'_>> {
> +        #[cfg(CONFIG_PER_VMA_LOCK)]
> +        {
> +            // SAFETY: Calling `bindings::lock_vma_under_rcu` is always okay given an mm where
> +            // `mm_users` is non-zero.
> +            let vma = unsafe { bindings::lock_vma_under_rcu(self.as_raw(), vma_addr as _) };

Is `as _` the right approach here?


Best regards,
Andreas Hindborg




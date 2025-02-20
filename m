Return-Path: <linux-kernel+bounces-523718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856DA3DA55
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02D03BA560
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685061F4169;
	Thu, 20 Feb 2025 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="rDfOqb7B"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773B579CD;
	Thu, 20 Feb 2025 12:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740055592; cv=none; b=cMr1eXjTs6huR460rqLwbwCt+hXi/A2jm3xvrN5dSJiZJqxJ8qfy3dWnwitwyDLGD9zlzcQsl0/kGVnzVEhlYEnptn9+zPln/mRJ/cduftDmwlt6jHgQGM1Av7pRdb1ielgc6nEnR27iwKjdmNYqGo64Jcs8LyGEI/Q27apqf0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740055592; c=relaxed/simple;
	bh=22lsmoPowc52Hi4mQD+2kdYb1bae2R5reXgDwM5IHNM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oP+Ncx+mbB3wvK1E8F5R4LOTtmt6AsC3j5XsxPDHv6FH6TnzYK55ctjR9BxAJFjOJ+J6joswzfcgzcaBODRvkry0ApF9DylnC3KNeh8Tp65q+/N17HWDGJcibH2Qf2tGlHKYCoePe5dsI69rc7G1x3NlbfR42MPrmFUcdfo1nvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=rDfOqb7B; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1740055586; bh=+5Hriei/4orgcIc6p+422qMKgtVSC7Hm3HwgFOrINsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=rDfOqb7BB3I3aZoorFjkDqlP0pzNufijzwS6Dzg8HbRyG1oPJrwR/lMnqBuRuFg/0
	 i5AVA93ztX8WmU5OcoxPslQDr6+kkgagGj7A1jDr2GbHG+NazD/orT6WKuCFlXLbdi
	 Bw8tkN2wrxOn4bmBVBhLqs/f60s/KVTjcI1cpe3U=
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno Lossin <benno.lossin@proton.me>,
  Andreas Hindborg <a.hindborg@kernel.org>,  Alice Ryhl
 <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,  Danilo
 Krummrich <dakr@kernel.org>,  Will Deacon <will@kernel.org>,  Peter
 Zijlstra <peterz@infradead.org>,  Mark Rutland <mark.rutland@arm.com>,
  Tamir Duberstein <tamird@gmail.com>,  Lyude Paul <lyude@redhat.com>,
  Wedson Almeida Filho <wedsonaf@gmail.com>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] rust: implement `kernel::sync::Refcount`
In-Reply-To: <20250219201602.1898383-2-gary@garyguo.net> (Gary Guo's message
	of "Wed, 19 Feb 2025 20:15:30 +0000")
References: <20250219201602.1898383-1-gary@garyguo.net>
	<20250219201602.1898383-2-gary@garyguo.net>
Date: Thu, 20 Feb 2025 13:46:26 +0100
Message-ID: <87h64o6axp.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gary Guo <gary@garyguo.net> writes:

> This is a wrapping layer of `include/linux/refcount.h`. Currently the
> kernel refcount has already been used in `Arc`, however it calls into
> FFI directly.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>

With the doc link fixed below

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
[snip]
> diff --git a/rust/kernel/sync/refcount.rs b/rust/kernel/sync/refcount.rs
> new file mode 100644
> index 000000000000..a6a683f5d7b8
> --- /dev/null
> +++ b/rust/kernel/sync/refcount.rs
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Atomic reference counting.
> +//!
> +//! C header: [`include/linux/refcount.h`](srctree/include/linux/refcount.h)
> +
> +use crate::types::Opaque;
> +
> +/// Atomic reference counter.
> +///
> +/// This type is conceptually an atomic integer, but provides saturation semantics compared to
> +/// normal atomic integers. Values in the negative range when viewed as a signed integer are
> +/// saturation (bad) values. For details about the saturation semantics, please refer to top of
> +/// [`include/linux/refcount.h`](srctree/include/refcount.h).

Link is not pointing to the linux directory as in the text of the link.

Thanks,
Fiona

> +///
> +/// Wraps the kernel's C `refcount_t`.
> +#[repr(transparent)]
> +pub struct Refcount(Opaque<bindings::refcount_t>);
> +
> +impl Refcount {
> +    /// Construct a new [`Refcount`] from an initial value.
> +    #[inline]
> +    pub fn new(value: i32) -> Self {
> +        // SAFETY: There are no safety requirements for this FFI call.
> +        Self(Opaque::new(unsafe { bindings::REFCOUNT_INIT(value) }))
> +    }
> +
> +    #[inline]
> +    fn as_ptr(&self) -> *mut bindings::refcount_t {
> +        self.0.get()
> +    }
> +
> +    /// Set a refcount's value.
> +    #[inline]
> +    pub fn set(&self, value: i32) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_set(self.as_ptr(), value) }
> +    }
> +
> +    /// Increment a refcount.
> +    ///
> +    /// It will saturate if overflows and `WARN`. It will also `WARN` if the refcount is 0, as this
> +    /// represents a possible use-after-free condition.
> +    ///
> +    /// Provides no memory ordering, it is assumed that caller already has a reference on the
> +    /// object.
> +    #[inline]
> +    pub fn inc(&self) {
> +        // SAFETY: self is valid.
> +        unsafe { bindings::refcount_inc(self.as_ptr()) }
> +    }
> +
> +    /// Decrement a refcount.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stores are done
> +    /// before.
> +    #[inline]
> +    pub fn dec(&self) {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_dec(self.as_ptr()) }
> +    }
> +
> +    /// Decrement a refcount and test if it is 0.
> +    ///
> +    /// It will `WARN` on underflow and fail to decrement when saturated.
> +    ///
> +    /// Provides release memory ordering, such that prior loads and stores are done
> +    /// before, and provides an acquire ordering on success such that memory deallocation
> +    /// must come after.
> +    ///
> +    /// Returns true if the resulting refcount is 0, false otherwise.
> +    #[inline]
> +    #[must_use = "use `dec` instead you do not need to test if it is 0"]
> +    pub fn dec_and_test(&self) -> bool {
> +        // SAFETY: `self.as_ptr()` is valid.
> +        unsafe { bindings::refcount_dec_and_test(self.as_ptr()) }
> +    }
> +}
> +
> +// SAFETY: `refcount_t` is thread-safe.
> +unsafe impl Send for Refcount {}
> +
> +// SAFETY: `refcount_t` is thread-safe.
> +unsafe impl Sync for Refcount {}


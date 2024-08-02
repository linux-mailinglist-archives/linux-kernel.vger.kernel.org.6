Return-Path: <linux-kernel+bounces-272393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3E945B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247721F24E19
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6D1DB420;
	Fri,  2 Aug 2024 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VV3uBCnl"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E71C2BD;
	Fri,  2 Aug 2024 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591562; cv=none; b=ib5Y5GKO5PFMgEarGWA2xRSEakT7Pd8p4CFcuF9PPFzvqgF7M7XasBXGsGA5c0YI6Ct4bsJSqMuFi922onTFX2jYtxkxhbpjOnFmWqS2qRqN2ZV4VvF2LFQz/lNGa2IxNGBfpkDdL4HdbD7bhbkeAVRPocKipGmY/uy3qs1iAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591562; c=relaxed/simple;
	bh=V/sP0mCciYSgP1SK2ZhqvHjubWCGsjGQsHmSxjGBpQ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/qtvBngX+pDv3COLxVIqTZmvCO3JYliPNjTOB7x/0fRr0Zv3kAQlUPrZGFgdTcns4tIgbGkn3lH8pGV3qFBDgcxWD49sWTbs+i+uQJekm28G8DpCPD2AU82YuQbxfHwoXxrNzL1kS63cChRaDiZ1QVFO4OE2xHQvOieJ/bAzLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VV3uBCnl; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722591551; x=1722850751;
	bh=m1QNeER4/O9Nb9QxsEYXTwhiESfbBDeW5e0hMJz/WCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VV3uBCnlJPNxvWs14rOC+xZdu5TqRnHJA+phOt1m1hgOQ/AsUyRPkYre4cie7TpKN
	 W43niQXnjvnTKI29yuLtUqxcYbp372Jmt9x6GWLILBXP5WaXoBQ3JpKezeW661zadL
	 kc0qrOQTy2mTwUwZnJiSiFjvsGW16FpSPdpo+o4RoHHte6Z/ERrQcCSr+4dRviRevM
	 LC944B7ROW/Z2+yMkgcXsKY9MbATF7APWS0qBJ0dtxFKHI2Hm4dzxpaQhFIYVP6tK5
	 vNHGPA6Ug2nK2yX19V17foe5tWnawOuQCuaGFrWIUTzKl2kG4F+BxiQdTBQOT0GUFm
	 bTjrw7HtHO7Bg==
Date: Fri, 02 Aug 2024 09:39:03 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: mm: add abstractions for mm_struct and vm_area_struct
Message-ID: <7f31fa8b-d788-4067-b296-9cdf23df65c7@proton.me>
In-Reply-To: <20240802-vma-v4-1-091a87058a43@google.com>
References: <20240802-vma-v4-1-091a87058a43@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1eea1a3ef92c701c98da726d04b4cde5a36fbe26
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.08.24 09:38, Alice Ryhl wrote:
> This is a follow-up to the page abstractions [1] that were recently
> merged in 6.11. Rust Binder will need these abstractions to manipulate
> the vma in its implementation of the mmap fop on the Binder file.
>=20
> This patch is based on Wedson's implementation on the old rust branch,
> but has been changed significantly. All mistakes are Alice's.
>=20
> Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@googl=
e.com [1]
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I have one nit below, with that fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> new file mode 100644
> index 000000000000..ec8cadb09626
> --- /dev/null
> +++ b/rust/kernel/mm/virt.rs
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Virtual memory.
> +
> +use crate::{
> +    bindings,
> +    error::{to_result, Result},
> +    page::Page,
> +    types::Opaque,
> +};
> +
> +/// A wrapper for the kernel's `struct vm_area_struct`.
> +///
> +/// It represents an area of virtual memory.
> +///
> +/// # Invariants
> +///
> +/// * If the caller has shared access to this type, then they must hold =
the mmap read lock.
> +/// * If the caller has exclusive access to this type, then they must ho=
ld the mmap write lock.
> +#[repr(transparent)]
> +pub struct VmArea {
> +    vma: Opaque<bindings::vm_area_struct>,
> +}
> +
> +impl VmArea {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is valid for the duration of 'a, =
and that the mmap read lock
> +    /// (or write lock) is held for at least the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw_vma<'a>(vma: *const bindings::vm_area_struct)=
 -> &'a Self {

I think this also should be named `from_raw`.

I took a look at your conversation with Christian Brauner and I
personally don't see the benefit of `File::from_raw_file` over
`File::from_raw`. To me it's clear that this function takes some raw C
structure that represents a `File` and turns it into a `File`.
In the situation where there are multiple ways of creating something
from different C structs, I think we should include the name. But if
there is only one possible struct, then the name should be `from_raw`.

Do you think we should re-open that discussion/start a new one on a
naming convention for this?

---
Cheers,
Benno

> +        // SAFETY: The caller ensures that the invariants are satisfied =
for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }



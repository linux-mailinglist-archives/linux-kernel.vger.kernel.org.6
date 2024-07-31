Return-Path: <linux-kernel+bounces-269682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7419435BB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6058D1C21F36
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 18:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF1747F69;
	Wed, 31 Jul 2024 18:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aRv7cnXn"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53D381AD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451313; cv=none; b=BHTkBOdl62W6koGs8OiYg4tlr1VyY4ybqeLKSoeXKy5IF86xNqva95AyWTzo8P/il+0QLugNjx2HwDbSXC/PnFXUIcbJrtIP9VqGYPuFRyLwgbPbvDTZhLkvctGO+1HF/cqpgf3omqe8qk9wn6xcGgxepd56Xihrbo7b9li+GpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451313; c=relaxed/simple;
	bh=lJilw/AoVHYdYfRUwSwCjA7exwUKyo868FVxs6MJao8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8gw3CxBnenqiywGafaEd7Uzg0wIRHcCEQCl3ymqRfY+5/pEn6PugRrOsHz5yVPSrj/gZ1fzifKIGfmJ3cStRuFP4cdxdKpLYUA4xcsaN1X+BUZS/oQMwTd7YK60IuS9zzAy4i6QK52b75FTaRsTiFv+HPmkyXuK7ezc3BPWQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aRv7cnXn; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722451303; x=1722710503;
	bh=j42rHfXMMIaRB2UIZ2G8pZNOKdDpMtFUjLRZK4Fc7YQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aRv7cnXnwMx+MADwFzWx7EPDrs0XS7Fo4WyNQN8t4Ejrnf+wGiV7WO82K4ss8euJi
	 c15z5eWV6fRWrwdT0ufY+Uajqkp57T7Knue3H4uoowr8gEAtBGAyDQ5sAGDS6VRkQT
	 ZcSCACYQVDyzSkgw4CvQsR6kGajgm15GLygS6zPNlv1sb/6R3beyoJ/cYFvRQ6XkeG
	 uW6YCoQav8e1OTEzpAkTMKcD63g6GK8l7FJW0x6obz+BkNoYLY4lx0GRtGKp40kO8i
	 9gL4LX0uiflpNGVMJNwtxogSSo1d+GrTCe9dn/fLdDN/379oUD/jBSkiseHS8N/nwc
	 P0Y/51xokpdUw==
Date: Wed, 31 Jul 2024 18:41:38 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 04/10] rust: list: add struct with prev/next pointers
Message-ID: <1b2078d8-d93b-4626-a73f-edc5616a2357@proton.me>
In-Reply-To: <20240723-linked-list-v3-4-89db92c7dbf4@google.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-4-89db92c7dbf4@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8aa0c8a898d34210a5055c792d60eb3bc6c0071d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 10:22, Alice Ryhl wrote:
> +/// The prev/next pointers for an item in a linked list.
> +///
> +/// # Invariants
> +///
> +/// The fields are null if and only if this item is not in a list.
> +#[repr(transparent)]
> +pub struct ListLinks<const ID: u64 =3D 0> {
> +    #[allow(dead_code)]
> +    inner: Opaque<ListLinksFields>,

Do you really need `Opaque`? Or would `UnsafeCell` be enough? (If it is
enough and you change this, be aware that `Opaque` is `!Unpin`, so if
you intend for `ListLinks` to also be `!Unpin`, then you need a
`PhantomPinned`)

> +}
> +
> +// SAFETY: The next/prev fields of a ListLinks can be moved across threa=
d boundaries.

Why? This is not a justification.

> +unsafe impl<const ID: u64> Send for ListLinks<ID> {}
> +// SAFETY: The type is opaque so immutable references to a ListLinks are=
 useless. Therefore, it's
> +// okay to have immutable access to a ListLinks from several threads at =
once.

You don't need to argue via `Opaque`, the type doesn't expose any
`&self` functions, so there are no functions to consider.

---
Cheers,
Benno

> +unsafe impl<const ID: u64> Sync for ListLinks<ID> {}
> +
> +impl<const ID: u64> ListLinks<ID> {
> +    /// Creates a new initializer for this type.
> +    pub fn new() -> impl PinInit<Self> {
> +        // INVARIANT: Pin-init initializers can't be used on an existing=
 `Arc`, so this value will
> +        // not be constructed in an `Arc` that already has a `ListArc`.
> +        ListLinks {
> +            inner: Opaque::new(ListLinksFields {
> +                prev: ptr::null_mut(),
> +                next: ptr::null_mut(),
> +            }),
> +        }
> +    }
> +}
>=20
> --
> 2.45.2.1089.g2a221341d9-goog
>=20



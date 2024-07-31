Return-Path: <linux-kernel+bounces-269616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD78E9434DF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEDD1C23FAF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4BF1BC067;
	Wed, 31 Jul 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HsqajtWZ"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C5015E86;
	Wed, 31 Jul 2024 17:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446280; cv=none; b=Bb2nUQ20B1RXSpNVaaJvxx9L9cC6KOW3ljGlDT250DOJsivN8SbFo8oJvOT82T4q6AVZG1QRkHWGBeyxJoWBxqNiDxidnMnlztAgW15erHblied1EMWGS5m8nmzofIaCkWuf7sX80bn8+9IGqIulFEBWsHOYr6yiFCHRBE5/mQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446280; c=relaxed/simple;
	bh=Tkxapr+WIByTqBuyO0R4QPIoo6SDCYv3XDQc5BTwP8g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMCLfh6HC0C29kLIhJf/qSGOTAW9gbT+KG4Pn47cwQ7aJ2d/226xdA0lbBz5wWn1Tvr8rtyfCEsoqmXNy5elOiGuThl1L5u3c55Ma8+DMTg39w+ixMYseOSDxLpEWFk7OyyEra6fcqzB2n8FPTtzfFGu9wmFgrSh67lRMw+KIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HsqajtWZ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722446276; x=1722705476;
	bh=yYZmVqKZ96/h9nwo0b6Z0ReIaMNU0P6ADrpHZ7NhGl0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HsqajtWZEi9BWQb34UWsqZLq++yGkSKzkv7jXJRFF9WsOSNUklPMrWpqL48pNBiMS
	 uvtFE2F6I50zZpa9I8hPxva3F6W9UTO2F7GKI+JvothD/aySOt7jCIfjbcPwOLtr4r
	 9q8R88HdvsGstiFKVfKjpD3Q246P+l9MPS3rAJQPyB9wx0K9HYGfqZa9F7hDp2CG3A
	 KrPIjlyhL3sJfCHnyJ8Rz39i3gsi2Dyz/HS7DqrjDJ++oQc2EF+KOf00grKFjQLl9q
	 NeakzzjNKXHfLdQQlzwY318E2a5o5JejSVmq5CuggSp4Xj1Yi+kxAL9+cMeSeK0gAR
	 tCUW0XHzeEMVA==
Date: Wed, 31 Jul 2024 17:17:52 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 03/10] rust: list: add tracking for ListArc
Message-ID: <95687c33-4abf-43b7-b835-e18cfae280ef@proton.me>
In-Reply-To: <20240723-linked-list-v3-3-89db92c7dbf4@google.com>
References: <20240723-linked-list-v3-0-89db92c7dbf4@google.com> <20240723-linked-list-v3-3-89db92c7dbf4@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d06078fd2e66d6c42d43953e42fe35e5357da090
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.07.24 10:22, Alice Ryhl wrote:
> @@ -47,9 +48,30 @@ pub trait ListArcSafe<const ID: u64 =3D 0> {
>      unsafe fn on_drop_list_arc(&self);
>  }
>=20
> +/// Declares that this type is able to safely attempt to create `ListArc=
`s at any time.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that `try_new_list_arc` does not return `tr=
ue` if a `ListArc` already
> +/// exists.
> +pub unsafe trait TryNewListArc<const ID: u64 =3D 0>: ListArcSafe<ID> {
> +    /// Attempts to convert an `Arc<Self>` into an `ListArc<Self>`. Retu=
rns `true` if the
> +    /// conversion was successful.

I think this could use some more explanation. It has been a couple weeks
since I last reviewed this, so I forgot what exactly this does and at
first I thought that the tracking is not updated. But it actually is.
Additionally, the safety documentation does not ensure that this
function updates the tracking. So maybe use this?:

    Attempts to convert an `Arc<Self>` into a `ListArc<Self>`.

    # Guarantees

    * If the return value is `true`, then there exists no `ListArc<Self, ID=
>` pointing to this value.
      Additionally, the tracking inside of `self` now thinks there is a `Li=
stArc<Self, ID>`.

And then add in the `Safety` section of the trait that the guarantees of
`try_new_list_arc` need to be ensured.

Just to make sure: this method must handle concurrent access, but that
should be guaranteed if `Self: Sync`, right?

> +    fn try_new_list_arc(&self) -> bool;
> +}
> +
>  /// Declares that this type supports [`ListArc`].
>  ///
> -/// When using this macro, it will only be possible to create a [`ListAr=
c`] from a [`UniqueArc`].
> +/// This macro supports a few different strategies for implementing the =
tracking inside the type:
> +///
> +/// * The `untracked` strategy does not actually keep track of whether a=
 [`ListArc`] exists. When
> +///   using this strategy, the only way to create a [`ListArc`] is using=
 a [`UniqueArc`].
> +/// * The `tracked_by` strategy defers the tracking to a field of the st=
ruct. The user much specify
> +///   which field to defer the tracking to. The field must implement [`L=
istArcSafe`].
> +///
> +/// The `tracked_by` strategy is usually used by deferring to a field of=
 type
> +/// [`AtomicListArcTracker`]. However, it is also possible to defer the =
tracking to another struct
> +/// using also using this macro.

Can you add that if the field selected by the `tracked_by` strategy
implements `TryNewListArc`, so will `$t`?

>  #[macro_export]
>  macro_rules! impl_list_arc_safe {
>      (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untrack=
ed; } $($rest:tt)*) =3D> {
> @@ -60,6 +82,39 @@ unsafe fn on_drop_list_arc(&self) {}
>          $crate::list::impl_list_arc_safe! { $($rest)* }
>      };

[...]

> @@ -346,3 +447,60 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn=
<ListArc<U, ID>> for ListArc
>      U: ListArcSafe<ID> + ?Sized,
>  {
>  }
> +
> +/// A utility for tracking whether a [`ListArc`] exists using an atomic.
> +///
> +/// # Invariant
> +///
> +/// If the boolean is `false`, then there is no [`ListArc`] for this val=
ue.
> +#[repr(transparent)]
> +pub struct AtomicListArcTracker<const ID: u64 =3D 0> {

I am not a fan of this long name, what about `AtomicTracker`? I could
see this type also being used by other things that need tracking.

> +    inner: AtomicBool,
> +    _pin: PhantomPinned,

Would be nice to have a comment explaining why this is needed. IIUC then
it is needed because of the INVARIANT comment in `new()`.

---
Cheers,
Benno

> +}
> +
> +impl<const ID: u64> AtomicListArcTracker<ID> {
> +    /// Creates a new initializer for this type.
> +    pub fn new() -> impl PinInit<Self> {
> +        // INVARIANT: Pin-init initializers can't be used on an existing=
 `Arc`, so this value will
> +        // not be constructed in an `Arc` that already has a `ListArc`.
> +        Self {
> +            inner: AtomicBool::new(false),
> +            _pin: PhantomPinned,
> +        }
> +    }



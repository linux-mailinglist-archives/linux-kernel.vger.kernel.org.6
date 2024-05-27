Return-Path: <linux-kernel+bounces-190362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEC58CFD48
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 11:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC01F262C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2513D625;
	Mon, 27 May 2024 09:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="MbsgICAu"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5513AD22
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802786; cv=none; b=S9sy0qGkFCqdXKpOllLQUheJd7VAULgxaHfT1ZcYd+I3WV20JruIddNs3SQHny/GO9KxNgXAr6FXs6SuLy8iIq/FAD7TebS2w227axueQY9YZWFcWUuJURbjqu43Y99R7+tDve4Iy0a9wH+VC+VlfxC0OxY1Mykq0M1qlT48hjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802786; c=relaxed/simple;
	bh=Bc9tW9Cz1DZ6iFpTzDPfmkj3uh5mXjjEkrZPtv5Yq/0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnn2LDb436tscLCMl+4AzZ81PzmZSWvPXcFhDW2bnJ4MYh6wZCfHTGAOhKpClpRYOC7YIKROX8Y2xPzqTdB1+zkL3Zk00vWIGLLIkqdvKAl2D99JLyI/Xx+juY35Fbxl4RZzmA7NQvEYmfoxrAuvGWXj3zlGt1AIcImNFrSV8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=MbsgICAu; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716802782; x=1717061982;
	bh=bkUwFBzgjFcOaacbjZdsraAbAQYEQ569ujl7iN25NmA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MbsgICAunyMFYYipG/xUhINPKEFnTmWeYRVF4b34mD4oRscCS2SzKlcPXtfB4kygL
	 Dwxt99gJxJd3h1ymCxYxV7A6rrqmdBWPL/hsaths91EhC8WIe+jhrKisOWUBjwvOFB
	 VL0f0JB78OR3M7XeOvJus5Zx/XU6O+DMzw5PFtMGIbgR4AbecPchcUqG3MIoWI6Loq
	 nr0faS5MbTwNw3Q1QFOk3Zpmj87VAb4n9sNPMIUDc3C8DaVTZcmK14CvZNY3ZtPcW1
	 8hlZeWL128JxBTp6EY42zRKsP/YCCiYr4rXYKx7g/vjknQLdasT6H8+pM0XWTV9adv
	 0nvwJez8MS/iQ==
Date: Mon, 27 May 2024 09:39:38 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 2/9] rust: list: add tracking for ListArc
Message-ID: <35544d52-166a-45a0-ae60-b39ecde576bc@proton.me>
In-Reply-To: <20240506-linked-list-v2-2-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-2-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 4cc69eeba12c0c462a2df5fdc5ed89fa72890678
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> @@ -32,9 +33,24 @@ pub trait ListArcSafe<const ID: u64 =3D 0> {
>     unsafe fn on_drop_list_arc(&self);
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
> +    fn try_new_list_arc(&self) -> bool;
> +}
> +
>  /// Declares that this type supports [`ListArc`].
>  ///
> -/// When using this macro, it will only be possible to create a [`ListAr=
c`] from a [`UniqueArc`].
> +/// When using this macro, you may choose between the `untracked` strate=
gy where it is not tracked
> +/// whether a [`ListArc`] exists, and the `tracked_by` strategy where th=
e tracking is deferred to a
> +/// field of the struct. The `tracked_by` strategy can be combined with =
a field of type
> +/// [`AtomicListArcTracker`] to track whether a [`ListArc`] exists.

I think it would make sense to use bullet points here.
Also, you should mention that in the `tracked_by` strategy, the field is
required to implement `TryNewListArc`.

>  #[macro_export]
>  macro_rules! impl_list_arc_safe {
>     (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty { untracke=
d; } $($rest:tt)*) =3D> {
> @@ -45,6 +61,37 @@ unsafe fn on_drop_list_arc(&self) {}
>         $crate::list::impl_list_arc_safe! { $($rest)* }
>     };
>=20
> +    (impl$({$($generics:tt)*})? ListArcSafe<$num:tt> for $t:ty {
> +        tracked_by $field:ident : $fty:ty;
> +    } $($rest:tt)*) =3D> {
> +        impl$(<$($generics)*>)? $crate::list::ListArcSafe<$num> for $t {
> +            unsafe fn on_create_list_arc_from_unique(self: ::core::pin::=
Pin<&mut Self>) {
> +                // SAFETY: This field is structurally pinned.

Who ensures this? This is not documented on the macro.
The only way that I see to fix this would be to make the `tracked_by`
strategy `unsafe`. At least until we implement proper structural pinning
of fields.

> +                let field =3D unsafe {
> +                    ::core::pin::Pin::map_unchecked_mut(self, |me| &mut =
me.$field)
> +                };
> +                // SAFETY: The caller promises that there is no `ListArc=
`.
> +                unsafe {
> +                    <$fty as $crate::list::ListArcSafe<$num>>::on_create=
_list_arc_from_unique(field)
> +                };
> +            }
> +            unsafe fn on_drop_list_arc(&self) {
> +                // SAFETY: The caller promises that there is no `ListArc=
` reference, and also
> +                // promises that the tracking thinks there is a `ListArc=
` reference.
> +                unsafe { <$fty as $crate::list::ListArcSafe<$num>>::on_d=
rop_list_arc(&self.$field) };
> +            }
> +        }
> +        unsafe impl$(<$($generics)*>)? $crate::list::TryNewListArc<$num>=
 for $t
> +        where
> +            $fty: TryNewListArc<$num>,
> +        {
> +            fn try_new_list_arc(&self) -> bool {
> +                <$fty as $crate::list::TryNewListArc<$num>>::try_new_lis=
t_arc(&self.field)
> +            }
> +        }
> +        $crate::list::impl_list_arc_safe! { $($rest)* }
> +    };
> +
>     () =3D> {};
>  }
>  pub use impl_list_arc_safe;

[...]

> @@ -313,3 +406,60 @@ impl<T, U, const ID: u64> core::ops::DispatchFromDyn=
<ListArc<U, ID>> for ListArc
>     U: ListArcSafe<ID> + ?Sized,
>  {
>  }
> +
> +/// A utility for tracking whether a [`ListArc`] exists using an atomic.
> +///
> +/// # Invariant
> +///
> +/// If the boolean is `false`, then there is no [`ListArc`] for this val=
ue.

"If `inner` is `false`, ..."

---
Cheers,
Benno

> +#[repr(transparent)]
> +pub struct AtomicListArcTracker<const ID: u64 =3D 0> {
> +    inner: AtomicBool,
> +    _pin: PhantomPinned,
> +}

[...]



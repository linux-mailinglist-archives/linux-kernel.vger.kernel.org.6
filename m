Return-Path: <linux-kernel+bounces-190433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A98728CFE28
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AC17B209B8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152013B2BB;
	Mon, 27 May 2024 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Mptzl2WF"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BD79E1
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716805906; cv=none; b=UTTomzpFKPtMmGdRwsC1V1wYACsMOw7OzeXluFGelMbwheyL0tNVfa78kjilXPiBf5ia4ue/aqLBYma1OaHMLT7bbGTkOPuDt+7AinVxeBOqph0T+gSl8aCz56f0MhvuTTmJyeJ8OGid6XUukWswf9iMl5w/ApmENdv4YsxvX2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716805906; c=relaxed/simple;
	bh=5915iZqkJRQVbm8GLKDIhbeHZhz7RipJyJhqNV1k5cs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXgsgaBC/zGckkgrkKhbW+Vfaw7lIpPxzOFh58UNjhQ9l40YZUgAa5TktMos+B05XJbIGw32QTGK8kKt1oG4t1FDvr7kbk42yEzCnj6AGzgwMh8DMZ/+Bv4WmvMICqc4AI4HxLCR3f+iD/Bsz0jdWGC0ECHOcPMLgYRzouAXfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Mptzl2WF; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716805901; x=1717065101;
	bh=vwyP38HX9GqRLRmp9euL8DsYmRpssOoH8PmzQUaaO+s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Mptzl2WFBbWsnxY28V/bH4KkS5FCx7eed1sOrD9bVwxOb5gauTPm+QBvZ+vKGyBT6
	 lZLszxmRMgFA8sPMoS7cahy3bLiFB3BjLpaZOl4XDoLDmMDDLKsaWeUX7S6ERQ0vr9
	 yqStFnG2RVLb1OhUGYi3SD85hbUeYyICUerLOETKP6uwQPG7Kw7XPHaayQklNKMrRx
	 YZGhrF79g27vdm4ZSLp3chR+wi+KHgj2YWfdYnHn07OLReR8t921An/jdNDyETbT27
	 R1VKWfN0KCdaqDDT+dpX4yjHH3LP5HksdUEvHLLWRDUVXYyov1oowgKq/guP//QKVY
	 y0XOkqrx8jAXA==
Date: Mon, 27 May 2024 10:31:35 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: list: add iterators
Message-ID: <cc65eeaf-81e1-45f5-8350-8e8259efe289@proton.me>
In-Reply-To: <20240506-linked-list-v2-6-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-6-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7ca9ca532a66a67c1020f5d68da622eadad78e61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> Rust Binder has lists containing stuff such as all contexts or all
> processes, and sometimes need to iterate over them. This patch enables

typo: need -> needs

> Rust Binder to do that using a normal for loop.
>=20
> The iterator returns the ArcBorrow type, so it is possible to grab a
> refcount to values while iterating.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Two documentation nits below, with those fixed:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/list.rs | 102 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 102 insertions(+)
>=20
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index d0ff29a3e5d1..e36afc7ee44a 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -5,7 +5,9 @@
>  //! A linked list implementation.
>=20
>  use crate::init::PinInit;
> +use crate::sync::ArcBorrow;
>  use crate::types::Opaque;
> +use core::iter::{DoubleEndedIterator, FusedIterator};
>  use core::marker::PhantomData;
>  use core::ptr;
>=20
> @@ -435,6 +437,17 @@ pub fn push_all_back(&mut self, other: &mut List<T, =
ID>) {
>          // INVARIANT: The other list is now empty, so update its pointer=
.
>          other.first =3D ptr::null_mut();
>      }
> +
> +    /// Creates an iterator over the list.
> +    pub fn iter(&self) -> Iter<'_, T, ID> {
> +        // INVARIANT: If the list is empty, both pointers are null. Othe=
rwise, both pointers point
> +        // at the first element of the same list.
> +        Iter {
> +            current: self.first,
> +            stop: self.first,
> +            _ty: PhantomData,
> +        }
> +    }
>  }
>=20
>  impl<T: ?Sized + ListItem<ID>, const ID: u64> Default for List<T, ID> {
> @@ -450,3 +463,92 @@ fn drop(&mut self) {
>          }
>      }
>  }
> +
> +/// An iterator into a [`List`].

I would use "over" instead of "into".

> +///
> +/// # Invariants
> +///
> +/// * There must be a [`List`] that is immutably borrowed for the durati=
on of `'a`.
> +/// * The `current` pointer is null or points at a value in that [`List`=
].
> +/// * The `stop` pointer is equal to the `first` field of the [`List`].

the -> that

---
Cheers,
Benno

> +#[derive(Clone)]
> +pub struct Iter<'a, T: ?Sized + ListItem<ID>, const ID: u64 =3D 0> {
> +    current: *mut ListLinksFields,
> +    stop: *mut ListLinksFields,
> +    _ty: PhantomData<&'a ListArc<T, ID>>,
> +}



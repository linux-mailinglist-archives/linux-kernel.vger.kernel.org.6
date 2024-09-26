Return-Path: <linux-kernel+bounces-340539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30A9874E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F071F271BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A442139597;
	Thu, 26 Sep 2024 13:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nHYUjAin"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1353A3A8F7;
	Thu, 26 Sep 2024 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359063; cv=none; b=S0fuaUtkcVjo1bMPWLmDLSIhJUIXYfGWjntr5r03Z6/crY55wzeFs7Lw2WEKDWy5UXfUGdvqG5ojh2xjIA31wtcKWQzJoRNKI3vct1sKao8LX92jm+aBTokGGHJAoAZT4A+8a43mzPxw77P6KwdPiQ/t7lmwnxW2Z7vzqTuDzso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359063; c=relaxed/simple;
	bh=3nnfCCqVcL2frU2/7bgMH777LF8IyOKxnvQmcIuObxA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgWDtucpWvZVEpBw+0o0AST9GCgwW03br2zCwRkLAmAKJrM/vhj6y8va3G3qKwE0FRW0aqPir1eMqj+Sup8Xr35O4QBd9TlcdGd7zpPhYYryMpTw2xB+kKDaMXgBSNEpLKGNF8qwYlPdKjK7u2kq/fzVuERrSQJyYaejRshvJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nHYUjAin; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727359060; x=1727618260;
	bh=czkVTqGn4chEF/J0VNZDWOv9U4Fd+kX8nK5PomYrYB8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nHYUjAinItLYXodB2Cvy4L9bsRrVklBTIUqyJOTmMNZKlAE8+TOTtHx2JT1MhCiGb
	 Ik84FPvBxobRU/Y0+Y09mspsdUHWlNamkPPFqbKjPDcVimK1f7TuXcceYM/B74W3V5
	 nvAXZNLvni+Le6JlkMlHdzf8HZpvFw25JX2fUaE4iNtO6xncuaZVyCRUZXzbrO1jTA
	 fhFBmlm5+Zaax9+LMlwVp3lD76Z49tIYTPlMdcdyS7WOQsmiUbGCOlqSOZV0JPcvXw
	 kW9FO+YMnRioROu40U3Pa13nM+NxWNvSFnCS1h+AO4nr7y02AsQpxBuHU90h71T/5n
	 VXU5gFGoafVZQ==
Date: Thu, 26 Sep 2024 13:57:36 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 15/26] rust: alloc: implement `collect` for `IntoIter`
Message-ID: <bcfe1565-1a62-4993-a075-b583cbf8a03f@proton.me>
In-Reply-To: <20240911225449.152928-16-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-16-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7d27dc04614ce399c67efe45c3100564b8f1b095
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> Currently, we can't implement `FromIterator`. There are a couple of
> issues with this trait in the kernel, namely:
>=20
>   - Rust's specialization feature is unstable. This prevents us to
>     optimze for the special case where `I::IntoIter` equals `Vec`'s
>     `IntoIter` type.
>   - We also can't use `I::IntoIter`'s type ID either to work around this,
>     since `FromIterator` doesn't require this type to be `'static`.
>   - `FromIterator::from_iter` does return `Self` instead of
>     `Result<Self, AllocError>`, hence we can't properly handle allocation
>     failures.
>   - Neither `Iterator::collect` nor `FromIterator::from_iter` can handle
>     additional allocation flags.
>=20
> Instead, provide `IntoIter::collect`, such that we can at least convert
> `IntoIter` into a `Vec` again.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc/kvec.rs | 86 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)

One comment below, but feel free to keep it as-is.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> +    pub fn collect(self, flags: Flags) -> Vec<T, A> {
> +        let (mut ptr, buf, len, mut cap) =3D self.into_raw_parts();
> +        let has_advanced =3D ptr !=3D buf.as_ptr();
> +
> +        if has_advanced {
> +            // Copy the contents we have advanced to at the beginning of=
 the buffer.
> +            //
> +            // SAFETY:
> +            // - `ptr` is valid for reads of `len * size_of::<T>()` byte=
s,
> +            // - `buf.as_ptr()` is valid for writes of `len * size_of::<=
T>()` bytes,
> +            // - `ptr` and `buf.as_ptr()` are not be subject to aliasing=
 restrictions relative to
> +            //   each other,
> +            // - both `ptr` and `buf.ptr()` are properly aligned.
> +            unsafe { ptr::copy(ptr, buf.as_ptr(), len) };
> +            ptr =3D buf.as_ptr();
> +        }
> +
> +        // This can never fail, `len` is guaranteed to be smaller than `=
cap`.
> +        let layout =3D core::alloc::Layout::array::<T>(len).unwrap();
> +
> +        // SAFETY: `buf` points to the start of the backing buffer and `=
len` is guaranteed to be
> +        // smaller than `cap`. Depending on `alloc` this operation may s=
hrink the buffer or leaves
> +        // it as it is.
> +        ptr =3D match unsafe { A::realloc(Some(buf.cast()), layout, flag=
s) } {
> +            // If we fail to shrink, which likely can't even happen, con=
tinue with the existing
> +            // buffer.
> +            Err(_) =3D> ptr,
> +            Ok(ptr) =3D> {
> +                cap =3D len;
> +                ptr.as_ptr().cast()
> +            }
> +        };

Would it make sense to only do the resize if the iterator has advanced?
If it hasn't, doing `into_iter().collect()` would be a no-op, which
would make sense IMO.

---
Cheers,
Benno

> +
> +        // SAFETY: If the iterator has been advanced, the advanced eleme=
nts have been copied to
> +        // the beginning of the buffer and `len` has been adjusted accor=
dingly.
> +        //
> +        // - `ptr` is guaranteed to point to the start of the backing bu=
ffer.
> +        // - `cap` is either the original capacity or, after shrinking t=
he buffer, equal to `len`.
> +        // - `alloc` is guaranteed to be unchanged since `into_iter` has=
 been called on the original
> +        //   `Vec`.
> +        unsafe { Vec::from_raw_parts(ptr, len, cap) }
> +    }
>  }
>=20
>  impl<T, A> Iterator for IntoIter<T, A>
> --
> 2.46.0
>=20



Return-Path: <linux-kernel+bounces-266080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F79993FA6D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF594283D25
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85915ECFD;
	Mon, 29 Jul 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lAZyPgK4"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407EECC;
	Mon, 29 Jul 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269786; cv=none; b=L//5ySQFk/1eTHn/zlKm0whPDiBrUCpoCq48aGz3la1YY8zxCe0pJOmNT0wBKjKu4WNOGze8y1oKevvlKj56IBAeRq97E2Jq2GeYaT7UrVpOaN/SLD/gOXqaLBdGwpeE90MCfcEAC2O7hg1Wizrjw/NlsiPnd/ac4MutiI0So0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269786; c=relaxed/simple;
	bh=ehBurIQi8ijJxGWEavJbL4QmtSsIOXItx8pphGSIR+o=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIKfOoqlNLQ3bqw/K4g20uYE+e8Mla6L3tGnDHVMg6JfzcGoDizUh/TzOcNBF5gAkqM4uB4wPWhhxz3CKGvy/mo1Mj5TPlJRU+NMUcjN8t9dbEZ5uwKLuG/xOwvRVBm2FkoitCTp/rouCaS7JcAMg0SJEwKCSAziKElsX2KeoBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lAZyPgK4; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722269782; x=1722528982;
	bh=eJtp2KWKzRi7UdjYcjMOVvWqstwMnIlMin59bDf22H4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=lAZyPgK4J5Nw+ks/pODD45/5HP9SQTEv0ZEpG1AKkAFCsKLQ72OWwWucyb2cEUWpS
	 DontLS6u0v1oz8mMivdFISx/Z4VN7158dP80pjViRG5ryXY+fMWM+OlhN4Xr53pDWb
	 s8abQey3kif4pcxp1WUl0Jwp0qw/W5W3tDE9KU2sPpOZRgb17hLesBFMoFR7pnjc3S
	 TGvyrFKUTB+Cl4FLFvvUyg9l+eOzJTz6kSm5bWNhnEVVCpKi3+3Bkuj0UGrk6CqGZ2
	 eTBz2ByS9vpCZtPh5djNqce5orXyjpshxNNa4FpjUN85YY9uG/FKagTawqXMNmOGNI
	 3vzSl+HpBOBQw==
Date: Mon, 29 Jul 2024 16:15:28 +0000
To: Alex Mantel <alexmantel93@mailbox.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v3] rust: Implement the smart pointer `InPlaceInit` for `Arc`
Message-ID: <6688a873-20d6-4e45-82c1-83a226f5bba4@proton.me>
In-Reply-To: <20240727042442.682109-1-alexmantel93@mailbox.org>
References: <20240727042442.682109-1-alexmantel93@mailbox.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 21dec5c1b2754a5b6a4d34c5e6428e38f1be1711
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.07.24 06:24, Alex Mantel wrote:
> For pinned and unpinned initialization of structs, a trait named
> `InPlaceInit` exists for uniform access. `Arc` did not implement
> `InPlaceInit` yet, although the functions already existed. The main
> reason for that, was that the trait itself returned a `Pin<Self>`. The
> `Arc` implementation of the kernel is already implicitly pinned.
>=20
> To enable `Arc` to implement `InPlaceInit` and to have uniform access,
> for in-place and pinned in-place initialization, an associated type is
> introduced for `InPlaceInit`. The new implementation of `InPlaceInit`
> for `Arc` sets `Arc` as the associated type. Older implementations use
> an explicit `Pin<T>` as the associated type. The implemented methods for
> `Arc` are mostly moved from a direct implementation on `Arc`. There
> should be no user impact. The implementation for `ListArc` is omitted,
> because it is not merged yet.
>=20
> Link: https://github.com/Rust-for-Linux/linux/issues/1079
> Signed-off-by: Alex Mantel <alexmantel93@mailbox.org>

One documentation nit below, otherwise this LGTM:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> Hello again!
>=20
> This is the 3rd version of my very first patch. I applied the
> suggestions on the 2nd submission. Thank you again for your feedback,
> looking for more!
>=20
> v1:
>   * https://lore.kernel.org/rust-for-linux/20240717034801.262343-2-alexma=
ntel93@mailbox.org/
>=20
> v2:
>   * remove the `From:` from the patch.
>   * add the prefix `rust: ` to the subject.
>   * Remove the empty line between `Link` and `Signed-off-by`.
>   * https://lore.kernel.org/all/20240719192234.330341-1-alexmantel93@mail=
box.org/
>=20
> v3:
>   * Rename PinnedResult to PinnedSelf
>   * Adjust documentation for PinnedSelf
>=20
>  rust/kernel/init.rs     | 39 +++++++++++++++++++++++++++++++++++----
>  rust/kernel/sync/arc.rs | 25 ++-----------------------
>  2 files changed, 37 insertions(+), 27 deletions(-)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 68605b633..fa5f182fe 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -213,6 +213,7 @@
>  use crate::{
>      alloc::{box_ext::BoxExt, AllocError, Flags},
>      error::{self, Error},
> +    sync::Arc,
>      sync::UniqueArc,
>      types::{Opaque, ScopeGuard},
>  };
> @@ -1112,11 +1113,17 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Re=
sult<(), E> {
>=20
>  /// Smart pointer that can initialize memory in-place.
>  pub trait InPlaceInit<T>: Sized {
> +    /// Pinned version of Rusts `Self`.

I would not have mentioned "Rust" here, since that should be obvious.

---
Cheers,
Benno

> +    ///
> +    /// If a type already implicitly pins its pointee, `Pin<Self>` is un=
necessary. In this case use
> +    /// `Self`, otherwise just use `Pin<Self>`.
> +    type PinnedSelf;
> +
>      /// Use the given pin-initializer to pin-initialize a `T` inside of =
a new smart pointer of this
>      /// type.
>      ///
>      /// If `T: !Unpin` it will not be able to move afterwards.
> -    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result=
<Pin<Self>, E>
> +    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result=
<Self::PinnedSelf, E>
>      where
>          E: From<AllocError>;
>=20



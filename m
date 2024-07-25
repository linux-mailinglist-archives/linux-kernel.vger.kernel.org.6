Return-Path: <linux-kernel+bounces-262517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6293C820
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5B891F227D4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A7B19DF70;
	Thu, 25 Jul 2024 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ppard+I/"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3219DF6E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721930775; cv=none; b=SrksRbWMBNtrwb2rXQxQEtUyazEpV5qZ4bcQHHTcb30SEo5oQC3JpRAeAAdAfUDKVx5mEhyvasMZMVcowcqpDrWLsqbZlXUC668ud6LRWTU6XO3U3mcC+Dq3Jp6qfDroxMPxHIGzU5Ly+g8gIZ0cSLoJYeQOONFEYhqga43ApCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721930775; c=relaxed/simple;
	bh=dPR++PvUoyCPmtYZdQ7LKhGBEs9H2po/2npLkA6LiAg=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJCam7MMc/+aFx+PL2aZM93UU14fxIFUhXbo6DiLJy0eahlYK8iYzFaysHsG3RxOT8qhs0WgLqA0K0QyK7XkVF0SPEQ4i17fSiI0j/4Fuw0byymG75uFTjHIR+PTGac25O7j7SUryv5Ukb+PzWlCGL/gHKtvRLHgd9EAN1Ym/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ppard+I/; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721930771; x=1722189971;
	bh=v1XSfOC46SQD5J7rzSfoiVRwNcJgL8NSNBFuFhZJcM4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ppard+I/1RXQyHNfh5sqm6pMuNzjFOU1Rs1HSv5P2qlxOXaOxVOF7GO4PCR70qvXN
	 tGtfMlaF+cGN6BmX/ODBRYABaIHYDa/NwBazJhT4lb4Dp/WSBHDJ/us2tQTJf2+yCC
	 yUZFObvleQpPfLTFfgYK8y8wikGwrf3HLPGOAMeZqfbdehv0xZPZ0YaO+cVyyNu4wY
	 c8MVd18BexLv2TVMn7ZSiI5wkiS20Q2W83bYJDsSMr0Nw95dRVFdTAORtj1FtJoOAW
	 HL7yT0J8/9qjg8T49vReWZ3BtGj0977sVo3GLVgYoA4v9flfdbcMp7iYZwNk54ycs8
	 3jSxacxQWhvMw==
Date: Thu, 25 Jul 2024 18:06:06 +0000
To: Alex Mantel <alexmantel93@mailbox.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH v2] rust: Implement the smart pointer `InPlaceInit` for `Arc`
Message-ID: <27dad59c-ba8a-43c4-a288-870cf29fa131@proton.me>
In-Reply-To: <20240719192234.330341-1-alexmantel93@mailbox.org>
References: <20240719192234.330341-1-alexmantel93@mailbox.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8bedcef49daeb2c7699dc9d626a3c03a5b899e97
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.07.24 21:22, Alex Mantel wrote:
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 68605b633..46f50cf12 100644
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
> @@ -1112,11 +1113,15 @@ unsafe fn __pinned_init(self, slot: *mut T) -> Re=
sult<(), E> {
>=20
>  /// Smart pointer that can initialize memory in-place.
>  pub trait InPlaceInit<T>: Sized {
> +    /// A type might be pinned implicitly. An addtional `Pin<ImplicitlyP=
inned>` is useless. In
> +    /// doubt, the type can just be set to `Pin<Self>`.

This comment should better describe the purpose of this associated type,
the first line could be "Pinned version of `Self`" then (with an empty
line in between) you could write more explanatory stuff. I would also
rephrase what you have above, for example: "If a type already implicitly
pins its pointee, `Pin<Self>` is unnecessary. In this case use `Self`,
otherwise just use `Pin<Self>`.".

> +    type PinnedResult;

I don't really like the name for this, since it is not a result. What do
you think of `PinnedSelf`?

Otherwise this looks good!

---
Cheers,
Benno

> +
>      /// Use the given pin-initializer to pin-initialize a `T` inside of =
a new smart pointer of this
>      /// type.
>      ///
>      /// If `T: !Unpin` it will not be able to move afterwards.
> -    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result=
<Pin<Self>, E>
> +    fn try_pin_init<E>(init: impl PinInit<T, E>, flags: Flags) -> Result=
<Self::PinnedResult, E>
>      where
>          E: From<AllocError>;
>=20



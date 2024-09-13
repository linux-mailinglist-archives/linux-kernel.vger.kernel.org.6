Return-Path: <linux-kernel+bounces-328293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3C978182
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8922839BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BD51DB54F;
	Fri, 13 Sep 2024 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="oq3kYpLJ"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969B1DA62C;
	Fri, 13 Sep 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726235430; cv=none; b=r8mWpXRBkIvJnYQvwoYKPFsD6R3ln7xCQhs9zQpizNT3ZWb6n1tf1WDv/MZfVxE7gVjo2AlOmlrBAyQ0KXyCTjCVleUS3FaSjVuBj+B7iKiAIHmoyNOrUEuKzr1yUQGJE9t6Q0K66Ry3IwzTMdhNtlGnBpMjv9kMENmbe/2MTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726235430; c=relaxed/simple;
	bh=rmbVteh3MhMwb6kEdNs/84s2F30jItgTqVYsZhXGmko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDnTRYdX6nRcCtk3iVtUMFEXemBwSf2ZiCyNoe47y1WmggLQpGXxC5hlpM89d4RIClX1zPmeC3W5L4x1+o5J2xsm11qgkRI+fZoe3/BmFFsa+aAMhqE/5xEQsa7kmknk8hV2w49hZsmp7H0H8TIShVnMN8SP4C0u9oXiS8s2xlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=oq3kYpLJ; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1726234868; bh=koEIKzayacr7Jw1JspcVjhqLCbSZescfm3Wqy+rjWOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oq3kYpLJwiuDiblrUu8Tds3YRWHP9RXxhCzUyZPChjf4FpGPNNy4sKBPf/B6BGqjv
	 1L1PNHdNcroidcPyfFjCxY6dd5sUZuPk8laioBYMiHbXqZIDuieYHLIbMfVvXtZFgV
	 Gvuu4ZpHYeRrzCl/R+7x1q0pof7wkpKDiH6CsOYQ=
To: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Date: Fri, 13 Sep 2024 15:41:06 +0200
Message-ID: <EE2A76E7-58E6-40E5-9075-48A169292250@kloenk.dev>
In-Reply-To: <20240913112643.542914-2-benno.lossin@proton.me>
References: <20240913112643.542914-1-benno.lossin@proton.me>
 <20240913112643.542914-2-benno.lossin@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 13 Sep 2024, at 13:26, Benno Lossin wrote:

> When reading data from userspace, hardware or other external untrusted
> sources, the data must be validated before it is used for logic within
> the kernel. This abstraction provides a generic newtype wrapper that
> prevents direct access to the inner type. It does allow access through
> the `untrusted()` method, but that should be a telltale sign to
> reviewers that untrusted data is being used at that point.
>
> Any API that reads data from an untrusted source should return
> `Untrusted<T>` where `T` is the type of the underlying untrusted data.
> This generic allows other abstractions to return their custom type
> wrapped by `Untrusted`, signaling to the caller that the data must be
> validated before use. This allows those abstractions to be used both in=

> a trusted and untrusted manner, increasing their generality.
> Additionally, using the arbitrary self types feature, APIs can be
> designed to explicitly read untrusted data:
>
>     impl MyCustomDataSource {
>         pub fn read(self: &Untrusted<Self>) -> &Untrusted<[u8]>;
>     }
>
> To validate data, the `Validator` trait is introduced, readers of
> untrusted data should implement it for their type and move all of their=

> validation and parsing logic into its `validate` function. That way
> reviewers and later contributors have a central location to consult for=

> data validation.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/types.rs | 248 ++++++++++++++++++++++++++++++++++++++++++-=

>  1 file changed, 247 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 9e7ca066355c..20ef04b1b417 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
=E2=80=A6
> +
> +/// Validates untrusted data.
> +///
> +/// # Examples
> +///
> +/// ## Using an API returning untrusted data
> +///
> +/// Create the type of the data that you want to parse:
> +///
> +/// ```
> +/// pub struct FooData {
> +///     data: [u8; 4],
> +/// }
> +/// ```
> +///
> +/// Then implement this trait:
> +///
> +/// ```
> +/// use kernel::types::{Untrusted, Validator};
> +/// # pub struct FooData {
> +/// #     data: [u8; 4],
> +/// # }
> +/// impl Validator for FooData {
> +///     type Input =3D [u8];
> +///     type Output =3D FooData;
> +///     type Err =3D Error;
> +///
> +///     fn validate(untrusted: &Untrusted<Self::Input>) -> Result<Self=
::Output, Self::Err> {
> +///         let untrusted =3D untrusted.untrusted();
> +///         let untrusted =3D <[u8; 4]>::try_from(untrusted);
> +///         for byte in &untrusted {
> +///             if byte & 0xf0 !=3D 0 {
> +///                 return Err(());
> +///             }
> +///         }
> +///         Ok(FooData { data: untrusted })
> +///     }
> +/// }
> +/// ```
> +///
> +/// And then use the API that returns untrusted data:
> +///
> +/// ```ignore
> +/// let result =3D get_untrusted_data().validate::<FooData>();
> +/// ```
> +///
> +/// ## Creating an API returning untrusted data
> +///
> +/// In your API instead of just returning the untrusted data, wrap it =
in [`Untrusted<T>`]:
> +///
> +/// ```
> +/// pub fn get_untrusted_data(&self) -> &Untrusted<[u8]> {
> +///     todo!()
> +/// }
> +/// ```
> +pub trait Validator {
> +    /// Type of the input data that is untrusted.
> +    type Input: ?Sized;

I would like to explore this trait with being generic over Input, instead=
 of having Input as an associated type. Might be nicer to have Validators=
 for different input types if the valid data is always the same?

> +    /// Type of the validated data.
> +    type Output;
> +    /// Validation error.
> +    type Err;
> +
> +    /// Validate the given untrusted data and parse it into the output=
 type.
> +    ///
> +    /// When implementing this function, you can use [`Untrusted::untr=
usted()`] to get access to
> +    /// the raw untrusted data.
> +    fn validate(untrusted: &Untrusted<Self::Input>) -> Result<Self::Ou=
tput, Self::Err>;
> +}
> -- =

> 2.46.0


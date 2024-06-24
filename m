Return-Path: <linux-kernel+bounces-226886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76762914540
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BEBB23EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024E73EA7B;
	Mon, 24 Jun 2024 08:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x66/RpTL"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB622907
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218878; cv=none; b=ZZw0QzohqA8KtWcQ8c//58AGJqBb31yy/N0jzLU56E00X0sG/MMpFw2rbRZk6Czjg93TTwWqRG75LfBGJm0iqRtfwSVE04ErS0xDFOh7fmetjqbe9YHgWAf+ySGeXScvCXBGHqLdUoRL0dudDJZDuI/dU08Exm3KZOe7gJiu0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218878; c=relaxed/simple;
	bh=i3kZDMLWLd96gDc9K4Y6EHHzzcKLPUDlc3MNH5wNmtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWpFsC1WMgfEboF4TyR9NBLp29v5eHhEpK3FuOpkJmp+gTzw9cHj/45PvqLo4ZIyrMh7T2ShU9LdvmmXkJxj5NZfSbxhTtZuVcODrNxd6Wc+Etu6T33xPWS5cAFcwHHWGSRhmS1mCZ68IsHyvOlfnXx5F/irWWp1NYZRqMJMg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x66/RpTL; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so2577920f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719218875; x=1719823675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vELzHvwfYhfgaQfS4TW87Hdwhf+qF89/1wZ285PgAPE=;
        b=x66/RpTLtnZEYxHRs5gMA+kOCWSNEHg4AjtC9fmhbjLx6bFdctvioj09EH5xeI7E0y
         SJa2Zf/X9NGyS+A5qsAfxV7o6NJhZk7ixwe0Rr02miAo0is47o2PH/s5Y1NLsMc64jAT
         tqT7ZUkScQF0COHiQdh4rslyN03aaRgIkbVbgim/1phKZ9knqD65N1GdTzudW0fhqUYj
         jc9QtrbQBvnMgxhwWfShFAxKRSg5ElKVm24u3SHP1Wn7JAq9+IRq5dc8aOl6kBR79xnN
         OGBamLvgBQHQNbcywPKPfTQWDlN1QMAbX7mStns3uLHABUFzgLW0EiPYTjXI0IBylaSD
         ddeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719218875; x=1719823675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vELzHvwfYhfgaQfS4TW87Hdwhf+qF89/1wZ285PgAPE=;
        b=iFs1yBveSuAaHMQZiW4Yk1WocLKnzEL3hRsFZezphFlpJPHo/u5zbyUezhk/hh5x4J
         XJpsXxAMGqGLKTXaUmBenohfFvv9Y99UKbfYIacavxAeHayk73TmjL6AWpnPgPm5vT3W
         FWcG+UT4iI+z1XvQVw2gtBsVkfA+lpMs8jvlCe83KLqSOkg6xn3t1Ql/81EyLqrPjOVO
         zHLSj/R45C2WRQwcUNQwLW3SmVVMe27rzyv1ZGyBszwklk/guVSK/tmnKgGe4/2W5poQ
         4wp0DIJJ6LQIsldAZV18MWgxsPMT32K39pV0a+G3TpAgqDg8pScZ+jfqrTPsLXSUTQvm
         ce3g==
X-Forwarded-Encrypted: i=1; AJvYcCXcXw2nmlttVBdeNcii+pcMfLQf/atG8koqySyOo628JoWOQQGahhfmo5Z4pI+e2eCs2scV2g09S9HXNYAb+cBNTr/aONB8gpDUowPh
X-Gm-Message-State: AOJu0Ywraazgfuf42NY3KiBAU3vy4gNUJW6excDnMPGY/yCOr2KoP2hC
	AaEoBU8n2KELsGs90ieusau6tcWTMqqDKUrhbZDtMfGomFTA/vXgZV17Oh7Kbw2xpnCfgCNHw96
	d92/URuBYw6QK5tORniyCR+sUrYpbqnMnPJYv
X-Google-Smtp-Source: AGHT+IE9V99OcnVY2w5i3sRLtVONVJbuxlBrAVus/aJjTnXSg4b3TawmnAI8iMfxGKRXFJX0BoKOdvzCDWniQrAdAjY=
X-Received: by 2002:a5d:58fa:0:b0:35f:1b73:1d83 with SMTP id
 ffacd0b85a97d-366e7a08ba5mr3371333f8f.4.1719218874677; Mon, 24 Jun 2024
 01:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624030327.90301-1-ethan.twardy@gmail.com> <20240624030327.90301-5-ethan.twardy@gmail.com>
In-Reply-To: <20240624030327.90301-5-ethan.twardy@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Jun 2024 10:47:43 +0200
Message-ID: <CAH5fLgjgMxZ5S-wLqu6pOz=HzrV6qJGe5N=2rrYNvo3uVPbVbA@mail.gmail.com>
Subject: Re: [PATCH 4/4] rust: macros: Enable the rest of the tests
To: "Ethan D. Twardy" <ethan.twardy@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Aswin Unnikrishnan <aswinunni01@gmail.com>, "open list:RUST" <rust-for-linux@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 5:04=E2=80=AFAM Ethan D. Twardy <ethan.twardy@gmail=
.com> wrote:
>
> Now that the rusttest target for the macros crate is compiled with the
> kernel crate as a dependency, the rest of the rustdoc tests can be
> enabled.
>
> Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 8afed8facb21..6d764099563b 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -102,7 +102,9 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  ///
>  /// # Examples
>  ///
> -/// ```ignore
> +/// ```rust
> +/// # #[macro_use] extern crate macros;
> +/// # #[macro_use] extern crate kernel;

You also added these lines in patch 2, but you did not make them hidden the=
re.

>  /// use kernel::error::VTABLE_DEFAULT_ERROR;
>  /// use kernel::prelude::*;
>  ///
> @@ -147,12 +149,28 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -=
> TokenStream {
>  ///
>  /// # Examples
>  ///
> -/// ```ignore
> -/// use kernel::macro::concat_idents;
> +/// ```rust
> +/// # const binder_driver_return_protocol_BR_OK: u32 =3D 0;
> +/// # const binder_driver_return_protocol_BR_ERROR: u32 =3D 1;
> +/// # const binder_driver_return_protocol_BR_TRANSACTION: u32 =3D 2;
> +/// # const binder_driver_return_protocol_BR_REPLY: u32 =3D 3;
> +/// # const binder_driver_return_protocol_BR_DEAD_REPLY: u32 =3D 4;
> +/// # const binder_driver_return_protocol_BR_TRANSACTION_COMPLETE: u32 =
=3D 5;
> +/// # const binder_driver_return_protocol_BR_INCREFS: u32 =3D 6;
> +/// # const binder_driver_return_protocol_BR_ACQUIRE: u32 =3D 7;
> +/// # const binder_driver_return_protocol_BR_RELEASE: u32 =3D 8;
> +/// # const binder_driver_return_protocol_BR_DECREFS: u32 =3D 9;
> +/// # const binder_driver_return_protocol_BR_NOOP: u32 =3D 10;
> +/// # const binder_driver_return_protocol_BR_SPAWN_LOOPER: u32 =3D 11;
> +/// # const binder_driver_return_protocol_BR_DEAD_BINDER: u32 =3D 12;
> +/// # const binder_driver_return_protocol_BR_CLEAR_DEATH_NOTIFICATION_DO=
NE: u32 =3D 13;
> +/// # const binder_driver_return_protocol_BR_FAILED_REPLY: u32 =3D 14;
> +///
> +/// use kernel::macros::concat_idents;

The empty line above this import should probably be removed to improve
how this is rendered.

>  ///
>  /// macro_rules! pub_no_prefix {
>  ///     ($prefix:ident, $($newname:ident),+) =3D> {
> -///         $(pub(crate) const $newname: u32 =3D kernel::macros::concat_=
idents!($prefix, $newname);)+
> +///         $(pub(crate) const $newname: u32 =3D concat_idents!($prefix,=
 $newname);)+
>  ///     };
>  /// }
>  ///
> @@ -198,8 +216,9 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream =
{
>  ///
>  /// # Examples
>  ///
> -/// ```rust,ignore
> -/// #[pin_data]
> +/// ```rust
> +/// # use std::{sync::Mutex, process::Command};
> +/// #[kernel::macros::pin_data]
>  /// struct DriverData {

I'm pretty sure `#[pin_data]` is in our prelude and doesn't need an
import in normal code. If it needs an import in the test, then please
add a hidden import rather than using the full path.

>  ///     #[pin]
>  ///     queue: Mutex<Vec<Command>>,
> @@ -207,7 +226,15 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream=
 {
>  /// }
>  /// ```
>  ///
> -/// ```rust,ignore
> +/// ```rust
> +/// # use std::{sync::Mutex, process::Command};
> +/// # use core::pin::Pin;
> +/// # pub struct Info;
> +/// # mod bindings {
> +/// #     pub unsafe fn destroy_info(_ptr: *mut super::Info) {}
> +/// # }
> +/// use kernel::macros::{pin_data, pinned_drop};
> +///
>  /// #[pin_data(PinnedDrop)]
>  /// struct DriverData {
>  ///     #[pin]
> @@ -222,6 +249,8 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream =
{
>  ///         unsafe { bindings::destroy_info(self.raw_info) };
>  ///     }
>  /// }
> +///
> +/// # fn main() {}
>  /// ```
>  ///
>  /// [`pin_init!`]: ../kernel/macro.pin_init.html
> @@ -237,13 +266,20 @@ pub fn pin_data(inner: TokenStream, item: TokenStre=
am) -> TokenStream {
>  ///
>  /// # Examples
>  ///
> -/// ```rust,ignore
> +/// ```rust
> +/// # use macros::{pin_data, pinned_drop};
> +/// # use std::{sync::Mutex, process::Command};
> +/// # use core::pin::Pin;
> +/// # mod bindings {
> +/// #     pub struct Info;
> +/// #     pub unsafe fn destroy_info(_ptr: *mut Info) {}
> +/// # }
>  /// #[pin_data(PinnedDrop)]
>  /// struct DriverData {
>  ///     #[pin]
>  ///     queue: Mutex<Vec<Command>>,
>  ///     buf: Box<[u8; 1024 * 1024]>,
> -///     raw_info: *mut Info,
> +///     raw_info: *mut bindings::Info,
>  /// }
>  ///
>  /// #[pinned_drop]
> @@ -408,7 +444,9 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  ///
>  /// # Examples
>  ///
> -/// ```rust,ignore
> +/// ```rust
> +/// use kernel::macros::Zeroable;
> +///
>  /// #[derive(Zeroable)]
>  /// pub struct DriverData {
>  ///     id: i64,
> --
> 2.44.2
>


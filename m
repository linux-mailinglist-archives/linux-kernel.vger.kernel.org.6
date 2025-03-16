Return-Path: <linux-kernel+bounces-562939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52391A634F7
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 11:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6638D3ADB03
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777B919CD13;
	Sun, 16 Mar 2025 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="R6i98oBY"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364418B46C
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742120114; cv=none; b=jvJwh1YYQmZjXCLdUG41DY1tQ+7wejAD3OWfCyEd/8wdp45shiH3j1Fw4hlTz7rv3FsDAvqOD2Ky9wPM6B/ad9ydw8dys9MqhS0jCvk1en1iFofEPGRTgG+wVSPK4VXrPnpePW+EfuzbXeQDBurzMPKlKBy2TMDdvjErrpbxjL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742120114; c=relaxed/simple;
	bh=2Jk5Wokn+8pKV7as5JF030ToM5JjsC+W0PrJ+TDSZmM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ex3o6kyVXKdjTMBKyDDTOR4HXEt9E1XpARUCc93Zf8A3gYz20vWDXlTyx2NmvTd7LDyW4drfsNo9rYbp8ymUQoEIXDjk0XOcMGAfh/z3csOUC0myxH9rYEdgdxjX5FTUD+9M9R5U+2fN9k/GoUOWJd8v3DlbIgR1RwQqofWfick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=R6i98oBY; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742120105; x=1742379305;
	bh=Lt21KLUUCgCro7DuWF5ZJ2ch0F89A+CFLZ2/hDqXRe4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=R6i98oBYDyMUOJ2fSBoPY7q2Nf56Ii1JxXxwxNJ+AwpnyjJTRatXDDMH1mJ4y+KlG
	 76IkI4TZaPih1HFy2sPALrjTg7RoenuRlPhE1icbQpv9tvZgciF2BhqRG9IZYU7ppD
	 V53cNR0vwwU5X6/IQdhQTtr4ikV9OyfVdn5GyevFpvR217RjFEALjMlnm5Bx6tpTmU
	 702aFt+jQv47ks3XHWSPxbfhVLsqV+cH3YfU+6pJ0w6I7JT0nC7gs6M0kaCuvs0hLI
	 w+gF1rSgX5u8d+swU8unIpt8cUnbjAoEqBSoV0uDBsFepYIRz3/6JgpwKTgfMDdJhO
	 favgn2gEBK6Ag==
Date: Sun, 16 Mar 2025 10:14:58 +0000
To: Antonio Hickey <contact@byte-forge.io>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Antonio Hickey <contact@antoniohickey.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/16] rust: init: refactor to use `&raw [const|mut]`
Message-ID: <D8HM15XV9W1G.I3I2N7MWWK2P@proton.me>
In-Reply-To: <20250316061429.817126-3-contact@antoniohickey.com>
References: <20250316061429.817126-1-contact@antoniohickey.com> <20250316061429.817126-3-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a6526c96bc9b8662f4732ea5973134e7e5442211
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Mar 16, 2025 at 7:14 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of!(place)` and `addr_of_mut!(place)`
> with `&raw const place` and `&raw mut place` respectively.
>
> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw const`, `&raw mut` are similar
> to `&`, `&mut` making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>
> ---
>  rust/kernel/init.rs        |  8 ++++----
>  rust/kernel/init/macros.rs | 28 ++++++++++++++--------------
>  2 files changed, 18 insertions(+), 18 deletions(-)

When compiling this on Rust 1.78, I get:

    error[E0658]: raw address of syntax is experimental
      --> drivers/block/rnull.rs:57:9
       |
    57 | /         try_pin_init!(Self {
    58 | |             _disk <- new_mutex!(disk?, "nullb:disk"),
    59 | |         })
       | |__________^
       |
       =3D note: see issue #64490 <https://github.com/rust-lang/rust/issues=
/64490> for more information
       =3D help: add `#![feature(raw_ref_op)]` to the crate attributes to e=
nable
       =3D note: this compiler was built on 2024-04-29; consider upgrading =
it if it is out of date
       =3D note: this error originates in the macro `$crate::__init_interna=
l` which comes from the expansion of the macro `try_pin_init` (in Nightly b=
uilds, run with -Z macro-backtrace for more info)

So the previous commit also needs to affect doctests.

---
Cheers,
Benno



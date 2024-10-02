Return-Path: <linux-kernel+bounces-348183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED2098E3CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB09E286598
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DA216A3C;
	Wed,  2 Oct 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cwBTUKHE"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F500216A1C;
	Wed,  2 Oct 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899235; cv=none; b=WArUz8ursqvjG0FgKr6rOK8HIjG7zAcMZDFNChz9cJUdbfqfvGo1dHK1hiBXjri8Y+einyRWsEGqU2oPTOeg6sIob9gvzRMEAl/0ggjW8ka28eGTMVr0oIKTsXqjACdbDJWFFGG4m3xuEgkoE2mHIHxeB32966FKbGM3LMF09Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899235; c=relaxed/simple;
	bh=t1IwMBSjloCwMzOBfxbUaf3jSmTgE2Dk4z4cd1P+QMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lv+ZUixDKNlTRuyHn/iBrJZCr2ecMNVLN7/2W3oN+02MTDs8/xKXLmpXA+F1OCKgcbXMSDGAqlytU9v9S5ZkMqujEPoqzVeV7YnV9r4lUPtgApgb7H5BecvwdcYyGOrnAeEe0kx5jlwzEefoOclMOt29YY7PzV4LDVc58ximcbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cwBTUKHE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727899231; x=1728158431;
	bh=t1IwMBSjloCwMzOBfxbUaf3jSmTgE2Dk4z4cd1P+QMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cwBTUKHEEtK4/JJiPjQztX3+/EogsU/Zo7f4vzoPq0ZRm8Y8PGhINjpbdQPnjw/WK
	 BaTGLH0QjMb0ABgIIn6guK8h2oTL90fAPC5MficSGuKJ0B2e9Q4akSvDT06YGQdZ86
	 CbQDaBkIiOOTEyl+31I/uTSDsAZGZGS3DPDLXdzcJoRhl2lTFGa3pekf3sfbYz6hm9
	 uzvooBC74Nzy/tkJaZ+Fc02BbjiAkc5cAp3A6oTGgN25V/ehuwP43YPjGM1RI9+jGr
	 WVvSJquOv/ozxKLs3saF/3N0XqBAG+3ymzpE9T0CaoqGc2G0tc3VRXBIdMDeI/A96l
	 mRjMqgDBCIB2w==
Date: Wed, 02 Oct 2024 20:00:28 +0000
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Danilo Krummrich <dakr@redhat.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, Valentin Obst <kernel@valentinobst.de>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Alex Mantel <alexmantel93@mailbox.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Adrian Taylor <ade@hohum.me.uk>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2] rust: enable arbitrary_self_types and remove `Receiver`
Message-ID: <f82424dd-1f10-4181-9100-aeff0bd955a7@proton.me>
In-Reply-To: <20240915132734.1653004-1-gary@garyguo.net>
References: <20240915132734.1653004-1-gary@garyguo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 6bfee8498bc9399cbbb0a390b304579b07aca6e0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.09.24 15:26, Gary Guo wrote:
> The term "receiver" means that a type can be used as the type of `self`,
> and thus enables method call syntax `foo.bar()` instead of
> `Foo::bar(foo)`. Stable Rust as of today (1.81) enables a limited
> selection of types (primitives and types in std, e.g. `Box` and `Arc`)
> to be used as receivers, while custom types cannot.
>=20
> We want the kernel `Arc` type to have the same functionality as the Rust
> std `Arc`, so we use the `Receiver` trait (gated behind `receiver_trait`
> unstable feature) to gain the functionality.
>=20
> The `arbitrary_self_types` RFC [1] (tracking issue [2]) is accepted and
> it will allow all types that implement a new `Receiver` trait (different
> from today's unstable trait) to be used as receivers. This trait will be
> automatically implemented for all `Deref` types, which include our `Arc`
> type, so we no longer have to opt-in to be used as receiver. To prepare
> us for the change, remove the `Receiver` implementation and the
> associated feature. To still allow `Arc` and others to be used as method
> receivers, turn on `arbitrary_self_types` feature instead.
>=20
> This feature gate is introduced in 1.23.0. It used to enable both
> `Deref` types and raw pointer types to be used as receivers, but the
> latter is now split into a different feature gate in Rust 1.83 nightly.
> We do not need receivers on raw pointers so this change would not affect
> us and usage of `arbitrary_self_types` feature would work for all Rust
> versions that we support (>=3D1.78).
>=20
> Cc: Adrian Taylor <ade@hohum.me.uk>
> Link: https://github.com/rust-lang/rfcs/pull/3519 [1]
> Link: https://github.com/rust-lang/rust/issues/44874 [2]
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



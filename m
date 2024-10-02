Return-Path: <linux-kernel+bounces-347759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3C98DE20
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AF71C224C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4694E1CEEAF;
	Wed,  2 Oct 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HJES9lEB"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD563CB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881151; cv=none; b=gvaAL0G4shHnmbrLcYMF5qN/yBPWAtT5TmqBFKjrTWWrwEklaLQFHwcozlCvSHgETnZGhr4Juys9jiO5B1mDzjeAGNRkG5gLE0aR1OeR6Smja6PjjVu2Z9fmht+ieHxUf6eIZVZRb621CvdMmKgoHCnbIPyig1iNFgUhFxiWatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881151; c=relaxed/simple;
	bh=Xg31csycTk/cboZWhfwqwo8phaev8qLj7Us0yLTjsQ0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lvMsnq0VAa00q9Vi9QfondDKqvFuu43V6A4AVtndg0A1ZsK9neTe4nc2lGPLp2eSw4mb/wzikBBO7EWnSM6rZlHzpo+yCa7bJVvPdJkv/D2eszHE1en34v76AZZsG4A+GXIE+4cEY8qYP74F7v4y96iNeSWkTqZ5xn981kNZJDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HJES9lEB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=axhbyft3xreklhjkiwqqe5tdda.protonmail; t=1727881147; x=1728140347;
	bh=g+umvFbuw4spdDrQrhaXJ4dxcSLHzaUamYVgHkmZgUM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=HJES9lEBiA1/OMO5SYNHUkj3AaVuwE769bdR0L7xdh8W1IkIWxdedmcykFt9eGgnJ
	 pmTKSZQaOuDcE5ZMoX7BL13z93UnOd9ktmAzcGaFabJ7OA9uQzgEXHto0rMSqnZJHH
	 if8RNBqj0r8Bdnk8qdsMF90VWIopyVvUfRbN9sNEUSiHIcfybrMyUrGB4ppJBi/uuu
	 iGraAAGp+ViqV0g1dn5589/5nRrO8E4/Rx9WZtdMA6ZteOgaRX2ER6CAa0kSUf+7tK
	 WFY66iN1F5tGn2zatDc07rc2zK1rgaXd6zetCKJ9LPvY9umJ3MGzenfmSygsS+dH3x
	 69FfXfxwdH7hQ==
Date: Wed, 02 Oct 2024 14:59:03 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 01/29] rust: alloc: add `Allocator` trait
Message-ID: <8f1802f9-30b0-49f1-aa60-4471e1baae3a@proton.me>
In-Reply-To: <20241001150008.183102-2-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 604caa6824e44bd27c17d0c6ef08a4316add373c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 16:59, Danilo Krummrich wrote:
> Add a kernel specific `Allocator` trait, that in contrast to the one in
> Rust's core library doesn't require unstable features and supports GFP
> flags.
>=20
> Subsequent patches add the following trait implementors: `Kmalloc`,
> `Vmalloc` and `KVmalloc`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs | 101 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



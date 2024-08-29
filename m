Return-Path: <linux-kernel+bounces-307466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A63964DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3625EB21863
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFE71B9B28;
	Thu, 29 Aug 2024 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AdhDIDwQ"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F331B5832;
	Thu, 29 Aug 2024 18:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956733; cv=none; b=RHNBWGqWzZfZnZPAdYG1kiXtkJNeenxVz8bv5UJktfDFoOMaaHna+FNqMc8l5lNalgkxHpN1quFwbQAnK67wlU5xXvGI1x6gXQFpTi6eBzyeuyQ21GNey+Be+8yU7zdgvAwgH7d7t7VA7QD2970ub6GW16zOdWChTCRRfwar+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956733; c=relaxed/simple;
	bh=Hzlq9ATV/IdK2qYDozMOa6xJ4Laou6pdDwohHLPhdSk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0+hxOa8qjjbYrB6gVhMxN0Rros4z8b5JsvaM2qFR4gK9/aZWns9pGN2OeKDK9CzAdSu9U6jjqd3Bu+iSxo/hVXSccRGzSEhb8wbrU32dy0f5ySo3Z3cQlqprc/QBYF2VmvzKPhzZ8jpSlmRZ5QUEKdXcFQu8onCvmAbBIOd7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AdhDIDwQ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724956726; x=1725215926;
	bh=MLJi7n9niisvBeNz7ehwmqHyybu0ZRqBu18tqOTkky0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AdhDIDwQakEz+/dzhJumYYkSe+qGsMoyJ9+klfZo69XLksxf8gGtpf11I7C+Z0Hlw
	 hHllUrViyv0cN05yUPIIwRoKLPpGWnIYANZ8Dkm2cOg1+EkrBLyIAP+AZ18gDYmobt
	 i5ehKJEdDRBkHT6X9RENqi4Nhk7+BM3vU/0QdjqiMQxDEcJ31l+U9ROzD9qx/LfZBg
	 Z2andH6Btn3FKVJcilk7JH0ivfgRGp4rcBcjCRRiWTioFwfD5cpaCf0EafbpCzFHkn
	 /xxgUmJDBoliYdvN7mnDCr2K5fKWS+qnnAMAS5Ue+ABV3gA216Jc4JfoWIpB4MJQis
	 rNIk+kNyLWx1g==
Date: Thu, 29 Aug 2024 18:38:43 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 11/26] rust: alloc: remove `BoxExt` extension
Message-ID: <01e83e23-28f8-4e1e-8fc7-4115cfe82bb1@proton.me>
In-Reply-To: <20240816001216.26575-12-dakr@kernel.org>
References: <20240816001216.26575-1-dakr@kernel.org> <20240816001216.26575-12-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 60dc07155cb8e4f3049451d813e6c9d7e4195563
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.08.24 02:10, Danilo Krummrich wrote:
> Now that all existing `Box` users were moved to the kernel `Box` type,
> remove the `BoxExt` extension and all other related extensions.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

This is just a minor nit, but could you please change the commit title
to "rust: alloc: remove extension of std's `Box`"?
With that:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc.rs         |  1 -
>  rust/kernel/alloc/box_ext.rs | 80 ------------------------------------
>  rust/kernel/init.rs          | 44 +-------------------
>  rust/kernel/lib.rs           |  1 -
>  rust/kernel/prelude.rs       |  4 +-
>  rust/kernel/types.rs         | 28 -------------
>  6 files changed, 3 insertions(+), 155 deletions(-)
>  delete mode 100644 rust/kernel/alloc/box_ext.rs



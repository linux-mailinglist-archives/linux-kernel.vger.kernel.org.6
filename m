Return-Path: <linux-kernel+bounces-190437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E060A8CFE37
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4331C21F9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A313B598;
	Mon, 27 May 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZNAifA0D"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0F213B285;
	Mon, 27 May 2024 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716806265; cv=none; b=mleMOHJaYHFkOxPVQXRhQ+xJ5QJgcU6lr2L/vmbbOTqAccdlUkIRMtt1VKYDadsNAIvm+8/YhG3bonLlM7yBGe9ID/6BcgYxZuMG3fICTZ3SSIBuHDhO+ABgCcizjt/IxaR2o1g+Oezkunat29Xnld7UIzP55ZbeS8y9PQ7eVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716806265; c=relaxed/simple;
	bh=/l5XUuv8nQtGDLPCUzrTecaodGAdXukMy8bIzHTUU0A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4B31M76Jo8+vWCPC/YhsT1cva9u/33a5/m7rzVYVQ9fR9+E34wytwTUqsP5FMsJN1s4OJAaeJh0jJ09Xwo7b9NhYZWZQbocBIPL4Mz4dlcO6f4v5p0aCsFqImUR92Jrg7LMYUhw9oE1LmITux10tKsCYwfmWEhz1ZAems8y3xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZNAifA0D; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1716806260; x=1717065460;
	bh=xmJd03Rx3Rsva29jvNtokJfKBgBZOsRKCO2bIGkI074=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZNAifA0DNvB75SPNd8q/OstLXxVN1gU+9xJQepeuD8bPcnGzLxu6M52SGX2WfzwyR
	 L3YdxmFiL/efVGjkvX0JSPPxX5aHhHVB8sNn/7BJSwSEMV0Sh6LYsVGqo8P/zc1SE4
	 /4/FnwkHA7cvXezmCdpgeXGtXHCI2B6bqmr/oeL2SWmKnnIDFhNFh0Hf8SHMVBnF5U
	 sWbMAyOjffKa/ZP9r4Y0qhcq49DCysKklCRW+ZjGnelDU9ZuuegnSJnNwSqSb0cIPG
	 J+ZFVTL1d78lg5OgaqIk3aB22lxZv2qbt4oAeACgHHXoDRPMYNZQQmHHZBTDSId02z
	 cB3e5wfc6VZKw==
Date: Mon, 27 May 2024 10:37:34 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>, Coly Li <colyli@suse.de>, Paolo Abeni <pabeni@redhat.com>, Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 7/9] rust: list: add cursor
Message-ID: <d6c98f90-7bbb-45c3-bc0d-d700fa16cbd9@proton.me>
In-Reply-To: <20240506-linked-list-v2-7-7b910840c91f@google.com>
References: <20240506-linked-list-v2-0-7b910840c91f@google.com> <20240506-linked-list-v2-7-7b910840c91f@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: bac6eefd646ce6bbb8fb40143a92647993893885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.05.24 11:53, Alice Ryhl wrote:
> The cursor is very similar to the list iterator, but it has one
> important feature that the iterator doesn't: it can be used to remove
> items from the linked list.
>=20
> This feature cannot be added to the iterator because the references you
> get from the iterator are considered borrows of the original list,
> rather than borrows of the iterator. This means that there's no way to
> prevent code like this:
>=20
> let item =3D iter.next();
> iter.remove();
> use(item);
>=20
> If `iter` was a cursor instead of an iterator, then `item` will be
> considered a borrow of `iter`. Since `remove` destroys `iter`, this
> means that the borrow-checker will prevent uses of `item` after the call
> to `remove`.
>=20
> So there is a trade-off between supporting use in traditional for loops,
> and supporting removal of elements as you iterate. Iterators and cursors
> represents two different choices on that spectrum.
>=20
> Rust Binder needs cursors for the list of death notifications that a
> process is currently handling. When userspace tells Binder that it has
> finished processing the death notification, Binder will iterate the list
> to search for the relevant item and remove it.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/list.rs | 82 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 82 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



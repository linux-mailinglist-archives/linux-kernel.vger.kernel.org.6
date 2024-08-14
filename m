Return-Path: <linux-kernel+bounces-286879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98638951FE5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 18:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2011F24A21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D570A1BDAA8;
	Wed, 14 Aug 2024 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="I47hKbkO"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4691BD4FE
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652725; cv=none; b=cFato5NvKhkyOHG5cooL2HpBx6wSCe+P9QO/vvvpxkFOoeSXq/HwjQYoi1pgV74RT+nA3s3+ivTK40gbphMgxLLmUN3RTeXfEQ3sQ3r/ClEL+bvdqtm1TyGufvql7OqDTaLnH4ckH6qy3+vNtcVNM/HpqvE/kjffqy1VZKUV9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652725; c=relaxed/simple;
	bh=j9+tKFjuW6GFWgsPdpRDPnqOsku7GCtJaxfdNZ5k/5s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzpcbaSsF7aDHybcxwfwsnRCa3u0SOeOj1qcmvfYEhPq4VYzKue8XwS2qRqdmcSkZqzwpb/260f2vMmiBF+Xqj80df3M5259nFoiPHmlOaG1G/M49HsbkGyyNgQnjaVM0OIPJCnOZVay/LBcV9cedBKmqI4gw2QO7ySRhGvBPD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=I47hKbkO; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723652715; x=1723911915;
	bh=IKfUGaTAOHB51bKnbEf+rAr3CdrfW+9USkiN1kmYibU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=I47hKbkO713e2pmuyZXfw1vb4XfUpJnxN4I7GVhx10PiF9JR5/+knmvjtAQghBdqL
	 U2eo+sjn9Zju5ZJKNutwanBRclUpXvfYGIZZHq2hadEJn9SKIwlwSe7a4thDeFa4Fk
	 jGF2Ur7XyASWYbAj5D+Hff+0Bu/7PQDF8nQWL3lIe3QEQpcNlK+TatUzKW6hlw3eLr
	 6SYYab2JKx79x1ZyjOl1+kLqhKh5arrsyP1MCBxkz2th0dNYDiIxTn8zDUIMzhIHnr
	 809pFBzbr94Dzjx1wbWW3BkTWqj8zPqKj7kAGP8jWPzNJTe1PsOKhKxa7McDl8+/vx
	 5kv4/2EVOH9Xw==
Date: Wed, 14 Aug 2024 16:25:10 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 05/26] rust: alloc: add module `allocator_test`
Message-ID: <7b690bb5-9dac-4566-af01-657961f57d62@proton.me>
In-Reply-To: <20240812182355.11641-6-dakr@kernel.org>
References: <20240812182355.11641-1-dakr@kernel.org> <20240812182355.11641-6-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e996931214727300fd137374c8f6121bec0c1b09
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.08.24 20:22, Danilo Krummrich wrote:
> `Allocator`s, such as `Kmalloc`, will be used by e.g. `Box` and `Vec` in
> subsequent patches, and hence this dependency propagates throughout the
> whole kernel.
>=20
> Add the `allocator_test` module that provides an empty implementation
> for all `Allocator`s in the kernel, such that we don't break the
> `rusttest` make target in subsequent patches.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs                |  9 +++++++--
>  rust/kernel/alloc/allocator_test.rs | 19 +++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>  create mode 100644 rust/kernel/alloc/allocator_test.rs

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



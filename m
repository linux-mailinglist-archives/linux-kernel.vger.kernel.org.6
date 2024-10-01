Return-Path: <linux-kernel+bounces-346326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDF498C324
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 906581F21DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DAD1CBEA4;
	Tue,  1 Oct 2024 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZNGUgSua"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FD31CB336;
	Tue,  1 Oct 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727799119; cv=none; b=gVRQnXUfF3oBdmSRjOEed1eaEC+pVUAuffwEDZJ4Y6Pzv+aiNmheG6cdhrA8lwKOBlsd0HZsdaAOf9hAL1wtpIQN9Aq9//IAiSM6fUi3JGI2oA54gH/+d5Uxrtd9EWxD4wGOFewiF6af0H8L+4WkT8DxKsGRJXXroelIyEA9AxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727799119; c=relaxed/simple;
	bh=2YGIZaFrOnGDaTKzfugWebelgNno+hOEx7A9ztp4KhE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3gN5jRwH/ZD8exi/y7bx4sGslEkmhlEY172FmJvpHvYi0J6SULiYHG53pUoX/AS9B1q2cE3ZoQUA0YfuxB9bsyMkrTrPYH7YxRGat8wzDPvP0o6NXjsKakWz9jAe+6bVRosiP97GAnsUYz+iYeyPLRCJQ1vyc3sE6haoo7asCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZNGUgSua; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vnjsgbalfnap5f4hptdj2judga.protonmail; t=1727799114; x=1728058314;
	bh=hTfqNfUjUKIPxkk0ZRQCbBK32A2RpKTwUDWrKfJio1s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZNGUgSuafoW6Dyxx/fVT61WpfLy+GITc/56F62Lv44ng/cnwRY7KYhrXs1p1/xYd4
	 H8GfFLibXu/omzsMQ1EK7DvGrf1yQ+3KEgeKmNjLDWS6040WqHyMptWLNU5BpU61ib
	 JqLEuqYFpS2cl/eIbUkwDGJi+JX2wEfl0icXWPdq6C/iN3Lw4Q+X+LjCMrH5VK5hKL
	 /fFAr0bzwXB2rCoqIIzOLRZ8jImCcNsnYc8WctAuSVT3SOxwr7HpVqdZi7v2SUTz2i
	 qMkrVgostDP3wIxFrnexDyz6ZXQR3w5mQO/JVlrh4+a6vvHnmNNWwkLIcyB776zK+V
	 0O9EI383vi+2Q==
Date: Tue, 01 Oct 2024 16:11:50 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 04/29] rust: alloc: implement `ReallocFunc`
Message-ID: <eccce274-5451-400b-a5a6-8aa960771edf@proton.me>
In-Reply-To: <20241001150008.183102-5-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fa8abf5eb9d1191d33d4ae78556aff996810fe5b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 16:59, Danilo Krummrich wrote:
> `ReallocFunc` is an abstraction for the kernel's realloc derivates, such
> as `krealloc`, `vrealloc` and `kvrealloc`.
>=20
> All of the named functions share the same function signature and
> implement the same semantics. The `ReallocFunc` abstractions provides a
> generalized wrapper around those, to trivialize the implementation of
> `Kmalloc`, `Vmalloc` and `KVmalloc` in subsequent patches.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/alloc.rs           |  8 ++++
>  rust/kernel/alloc/allocator.rs | 70 ++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



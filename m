Return-Path: <linux-kernel+bounces-340496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 289B4987424
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB16C1F23A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F8C28DCB;
	Thu, 26 Sep 2024 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VJlAu/Gz"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5B62AE84
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356007; cv=none; b=OB9UHv1TYDw5NUT3G7piDSWmB339Jt9CZ75SZ28cg4caeulQ+6h/HDdLCpPVmICcR2Z/NcAA1UUxQoz6x4pDSqW1C+ylIQB38uuhIrgAne/m5jzI+4viENFbNRm/JEYpWKULS+p/QR71R8lmRy4ltXiBBx/E6FO3jYPDo6i0djU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356007; c=relaxed/simple;
	bh=N9AOY60Re6sbl4gS2L3klLeSnQWKAhByELnw8dkv7C4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckb3cE8k4cI7XcdPI1yxR6DK7WlK91FAODW0OK2h8HXvS+k3Otpj5AGI+qUSWmKsgDx6Sy+iEeWOn0eH5V2HBvbp1xdVuG4WvTk6I9ldICC5EUWFs6S1g2EKjWMsU5ifavZ8sjB93MiSgGU35T9czzLXhQKaAPPPAGD1nlTeqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VJlAu/Gz; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727356003; x=1727615203;
	bh=TL5z/1gzdLLW9Ubrhup3pugN8+Yh9hBL8znGvXpjJ/8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VJlAu/GzOA09oJngt1hksEiHM7bg5mjTj85IXHCu44O+enPFwxtLzbWnVn0xJqD4f
	 b255IdKyr2VefkJK2UYSvUeGBt1mr/AmCWemP6iyGLrMqxNNWzhCrrnfwhGuAvexfe
	 aYAp47Rs8Pty+6I9M1Vpb8Km31ZYhCo2T9hWDZpReIQEn1DAaZgNAYwCrgybp0wcMA
	 vDGfNqyjJIHJLaqG3K+h4KlhtiC6z8SEbM74EHnq5/k697zR1UYhIrUSSRl7OJX41V
	 KlEI1eumTukC/COp9exn/3q1SPDKZSsoyFNZ8U3+FRLthembeoyhX7l25aVW6z1Cz+
	 y/abihXNbXiyQ==
Date: Thu, 26 Sep 2024 13:06:37 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 06/26] rust: alloc: implement `Vmalloc` allocator
Message-ID: <406a5fb9-090d-4b51-bef2-e5db51d5147a@proton.me>
In-Reply-To: <20240911225449.152928-7-dakr@kernel.org>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 08d4c668d6729e5542ba087e8f47a9f6284c5add
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.09.24 00:52, Danilo Krummrich wrote:
> Implement `Allocator` for `Vmalloc`, the kernel's virtually contiguous
> allocator, typically used for larger objects, (much) larger than page
> size.
>=20
> All memory allocations made with `Vmalloc` end up in `vrealloc()`.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/helpers/helpers.c              |  1 +
>  rust/helpers/vmalloc.c              |  9 ++++++++
>  rust/kernel/alloc/allocator.rs      | 36 +++++++++++++++++++++++++++++
>  rust/kernel/alloc/allocator_test.rs |  1 +
>  4 files changed, 47 insertions(+)
>  create mode 100644 rust/helpers/vmalloc.c

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



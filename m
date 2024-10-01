Return-Path: <linux-kernel+bounces-346269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE5D98C21A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8FF1F24E94
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0A21C9B60;
	Tue,  1 Oct 2024 16:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="EGcKYLok"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502247A48
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798506; cv=none; b=Ic4aSXsBQGa7gVMZNeGbmB2H11qMZU48uh062GuQTKJISoin0aL0/HbHoUhqGsD0thogRkNSdpsdnURHFRTqyrVHktAgY8v3XQ4bnJz7U1/w+axoLbXpqDYuTPft+6jBftJ50alZdKhphs9CEXji0hzmNREb+BKW3QqpxgjNl58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798506; c=relaxed/simple;
	bh=uJa5ldSKSn8A5jd3/z+52anM1vVnwwopqOCR9pv8o10=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpCou5K5xUPde3hTIeKePFwTR8YWD9fnJW9iaGLJARZ+5B3FCH+2VhnJC566exqOFtmPnTAz+/jeF5kLLhV0NeMcSZNpvNzmDI4QfQsqrJ+5fQZlXOF1EbK9IF/4ehW3+e3dGBim3F1JUY0WG1JeiTF5qkgTrXKdnPVJIQm3XJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=EGcKYLok; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ka4if5rcjngqlcyhpcjdrlxdfe.protonmail; t=1727798499; x=1728057699;
	bh=JvbQ64Fa0JL4tjTIFclw+9klj6/6SNFZBM5WkEOqjcE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=EGcKYLokrrrqukqw3XH29gp9kz9pFbkzjIb0Al7eLmIaj6AbsVQ5slQlhxlAChvKI
	 tAzM4pOPa3sMKktyDnuMA0ubiMjOwMBwCKBzqRf6tBlnlfUlezFBvZzG1EBAVI04q9
	 +fJURlGGISJwzESyQGxc6Mv0yIGgIacFh6ptM4SWaMnM+51U+T5D3zXxF5dSeGdb7o
	 1sxnGWbTt6si64D24kYRsggur9wblQ+e55Yk4ucC/Abijd3J6gFtOiY33QAswgfXoy
	 ZiyqG9EZhQ+z5cT5LVnr2Q7ZEo9mG/3kl3AxZApj0WErSk+ICRM1HKv5+vvxBtmyXJ
	 cbNHfv53fn/cA==
Date: Tue, 01 Oct 2024 16:01:32 +0000
To: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 05/29] rust: alloc: make `allocator` module public
Message-ID: <c1eccee8-755a-4305-bc7e-7d34670d04a5@proton.me>
In-Reply-To: <20241001150008.183102-6-dakr@kernel.org>
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-6-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d66eff84ffab00af75db2c45459f814c1981c5e6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.24 16:59, Danilo Krummrich wrote:
> Subsequent patches implement allocators such as `Kmalloc`, `Vmalloc`,
> `KVmalloc`; we need them to be available outside of the kernel crate as
> well.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/alloc.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index da49c5306431..91b2a26faf3d 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -4,7 +4,7 @@
>=20
>  #[cfg(not(test))]
>  #[cfg(not(testlib))]
> -mod allocator;
> +pub mod allocator;
>  pub mod box_ext;
>  pub mod vec_ext;
>=20
> --
> 2.46.1
>=20



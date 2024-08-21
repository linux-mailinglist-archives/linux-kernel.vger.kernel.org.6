Return-Path: <linux-kernel+bounces-296100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D3095A597
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7E19B2199D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 20:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B73B16EBF2;
	Wed, 21 Aug 2024 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cPMOAOvE"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BC1D12F4;
	Wed, 21 Aug 2024 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724270520; cv=none; b=uoqG2Jgr3fxyKt+i7h1lsVO5gXznQWpysQWvf8PndcM0d+1mMecMc8389ZEYscfYlWQg++R89fYQO4IfzIVU666XxGvcbtcUMzN8sWkQK5nNBZy/HhROajO4quBxBjLwHXG93M7RbKL04ErCEjsr9PP6I9OqG+XmaUNOt856D/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724270520; c=relaxed/simple;
	bh=47a6QeiPXZ1GNgP293RF2lGlxg2ZWsHgxIkm/yVkAoQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Denfr9/8n3Geo3DoqELAaFOqIdX2Fb869pk9/aCNru12xhc213pNZgVEF6eXBBkXTEZgwucoPazVg0rac4CUA8an+nXxMEvtjuyAdhNdK9KtB0fLJC4dXT7WZGqKF+SXbJBrpO+z0igJognkEw5bDOK3hRi8Ve+10fEO180npQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cPMOAOvE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724270515; x=1724529715;
	bh=47a6QeiPXZ1GNgP293RF2lGlxg2ZWsHgxIkm/yVkAoQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cPMOAOvEYMFBQXXDB9JVbKnzd5xJ7uXonstRzyW1tNyNJDMpCL7WYMtnyhi1Qg5Eu
	 a1PZO7j63F8kVTr8bNS8L42wXmOU0mfNh0CQsSUZnpIsJxlLIydF85ysm7PmBjJsNY
	 xzTct3GnJKY7izLeZMcwTGfI9ixOnjYbstO9Bt0v0p0Lwanu2qIkfkhIlKXRiqSs96
	 wB6MNWfP/WsorNMTAMlxvDcle4dqvYVKoJip9jGgDdehZ9CavNNR7MVV4lq+QwxOgD
	 GUMCafKFFnxVIfnxMYKYkDgN8rquSzdRm32aZfWBGYMe/g5hXtAO1Mw/K9TEqUL4u0
	 6+b5J7Meme36w==
Date: Wed, 21 Aug 2024 20:01:48 +0000
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Kartik Prajapati <kartikprajapati987@gmail.com>
Subject: Re: [PATCH v2] rust: add `ARef::into_raw`
Message-ID: <c7cd7a36-380c-4ffe-be97-61d6e64b2290@proton.me>
In-Reply-To: <20240821-aref-into-raw-v2-1-9215bbca5720@google.com>
References: <20240821-aref-into-raw-v2-1-9215bbca5720@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f0bae94d7e631160fded5a0f5f4061c3c65c3184
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.08.24 21:58, Alice Ryhl wrote:
> From: Kartik Prajapati <kartikprajapati987@gmail.com>
>=20
> Add a method for `ARef` that is analogous to `Arc::into_raw`. It is the
> inverse operation of `ARef::from_raw`, and allows you to convert the
> `ARef` back into a raw pointer while retaining ownership of the
> refcount.
>=20
> This new function will be used by [1] for converting the type in an
> `ARef` using `ARef::from_raw(ARef::into_raw(me).cast())`. The author has
> also needed the same function for other use-cases in the past, but [1]
> is the first to go upstream.
>=20
> This was implemented independently by Kartik and Alice. The two versions
> were merged by Alice, so all mistakes are Alice's.
>=20
> Link: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com=
 [1]
> Closes: https://github.com/Rust-for-Linux/linux/issues/1044
> Signed-off-by: Kartik Prajapati <kartikprajapati987@gmail.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno



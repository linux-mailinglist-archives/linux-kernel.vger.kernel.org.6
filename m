Return-Path: <linux-kernel+bounces-538885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEB1A49E49
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C8E3A9488
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB428192D7E;
	Fri, 28 Feb 2025 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Wrl36nR7"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3FC1EF36E;
	Fri, 28 Feb 2025 16:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758776; cv=none; b=iZklwLomNYdvt/lWLDlXY983n8zfrIgr0Pb7mN5GoQt+CwzOV/YcyG7eCwsWeWXFXzpFVycBQr8OD7bMidNZD2ESDdnSbZfcAdsE7bYdL276SPlPxsb2sOwhFWMD93rt2Wkin5le20SedAXiEJ79lpLBaiFdSd1f7scmILw55XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758776; c=relaxed/simple;
	bh=cCAI4rWuDYKnaxg2mTxzS8Vaq+Ng6/IvAK31njQRb5o=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JDOcbtU8t0U1MPjfpI87oAKSZWodvFTLnzeMRFd3Xai9eSbqZ2j0bkYW7tWY6/oPghYIQZsqPthcDJw+Ld6wR2dlGJs8i/z9EpPP5K6kw2lLEcv4lKWZT46/IkUX5dtDGd+bIZ1g4Y1mWc18MCk+tKkrZipFSiPwQXGuTgtAmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Wrl36nR7; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740758766; x=1741017966;
	bh=cCAI4rWuDYKnaxg2mTxzS8Vaq+Ng6/IvAK31njQRb5o=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=Wrl36nR7LUTOAThUn9KGPZ8MnvhKSg+epEuSZDJt8/nsWjm/Pm42VAc//yThb8eQq
	 7h5RQG2r0DkQ4BUu5TfkqKE9LumRgRL1ov99prgit08pwRnfTorEvWVfbff1+MOAli
	 MIXcfOgPkQNya/dWjOERy449ztQK22ANq09uuVN0dMx64HscDML50fPslJ8RUc8qLa
	 coepNn20jEZHiPztbaqbj3ZrQidR+kG9Kqh0lm2lL9THe+E8gtbWRcMdAOOpBgXSXa
	 fIbL2C2rRU3usuXG9XSXd69PbhmLSLM8WR4mc5nc02eZOlAA8+X49Ehy0RLfkoYiau
	 Z649e6WxWNjXA==
Date: Fri, 28 Feb 2025 16:06:01 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <kQ8hbiYXcV2MseWnElEexwgQswt23842ggoLF2xsd1hDd-4K106zO_gGho5K6KI147luazt2rZNOY3NOJP4JOw==@protonmail.internalid>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 8e4ea72dbc34624db418fc3d0543cb5df1a24145
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>=20
> Hmm... Something went wrong here -- this patch looks broken, e.g. the
> SoB is at the end, the title does not say v2, these replies seem to be
> part of the patch, etc.
>
Hi,

should I post it again with a fix, then?

> (Also, by the way, in case it helps, the message got marked as spam in
> my side for some reason).
>=20

Cannot comment on that. The mysteries of a spam filter :)

On 250228 0754, Boqun Feng wrote:
>=20
> One meta comment: could you add examples for the usage of UniqueRef?
> Ideally, we should have example code for all the new APIs, so that we at
> least have some test payload on them (doctest will be generated as kunit
> test).

For now I can point you to the implementation for block::mq::Request which
Andreas did on top of this. So there will shortly at least one actual user
of the API (which uses all the features, as I believe).

https://github.com/metaspace/linux/commit/797b90ae0f83b45495364d4c31651bca0=
6471ef0

But if you still need a separate test, I can do one during the next couple
of days.

Best,

Oliver



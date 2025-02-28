Return-Path: <linux-kernel+bounces-539192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0DA4A1DA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D551899602
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2C27CCDB;
	Fri, 28 Feb 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="InN261fA"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239C27CCC3;
	Fri, 28 Feb 2025 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768132; cv=none; b=H3ZJJYZmyNpnwMEBnaOLw2XSbLgDKlq/D+eZdKX+H5oZHTR9rzYcYtReWxaf9kv3xkLRahLKouPPyiUzQyKUF8AEX6sgIiiQt2xPj4owUZEwfebsp65e4TxTLupg9LOccd1tvo+6/C4FaI2F6KaktJc+pVToeODoiCA5cPcbjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768132; c=relaxed/simple;
	bh=M0JrWN0XWYjTYJdgo6pkzfuIJgRwEEhKEwlHvCG/c+8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Cd1sIMASW+Da4lZoBiy/NzL/Beez+j03xgJ8Xb+5wYojvzH2eIXmPM6PEA9XDY9Hs+Q74Ap3RQu7KjQr0y2chRDonDFIqFhq7NlY3gwalnZvj2CG/6hdb2TUNSODHZF4OUm5c99lQiEj/Zbtmj5a6LYJ3Va2Kmqpqy/3KZRgOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=InN261fA; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740768123; x=1741027323;
	bh=M0JrWN0XWYjTYJdgo6pkzfuIJgRwEEhKEwlHvCG/c+8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=InN261fAg039RKRvjaSTv9p6lLpEJZdGXPzUczFgH8DNeVJeKhM/JvQ2dNG1yIPVc
	 +YpNa4Y7y9WuJcOjTifl5jwcE+X7IoXVy0vlbaZaFNUsma+qpLmWHPClqcY8NDXfGo
	 zDzyou7QI+RNV6V4jCD3VDn93eKdodMvHRxrjlBggANknwFWZLYvWVYgdXIASkVKBF
	 4m+l0n884i5VRvgaIBeQK2HbZcYgdt9cR3tJIhh0BkXDsDiOzngU14lBb1GV5/PmfU
	 /agM4SKgPsoAsTIXnxJ5jOIKHs9/9/a2Zr5dZHvvQ7zLPAXtBJmIXqLc3e+0ej+Qjb
	 /fyffMPOb8t3g==
Date: Fri, 28 Feb 2025 18:41:57 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <wDFD2QQ-TzRRhJJhPo1BisVzYy16SalSuoDJiYAb3sntdZaPfiVo1Q1DOVQqL873jaGY-ebJWMlyDERukXuFIg==@protonmail.internalid>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: f3a727b8f6a4d00f8ef7446a8e5daf989a4f4ab1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250228 1929, Andreas Hindborg wrote:
>=20
> I would suggest splitting out the use case from the commit message:
>=20
Yes, that makes sense. Will do.
>=20
> The comments after the --- will not got in the commit log, they are a
> message for the review process only.
>=20
Ahhh. Honestly I'm not very familiar with the format-patch/am
method, yet. That was a gap in my understanding.
Thanks for pointing that out. Now everything makes sense.

On 250228 1033, Boqun Feng wrote:
>=20
> Now as we cleared things, I want to make sure that it's clear that I
> would like to see the patch with examples in it.
>
That's fine. That's a reasonable request. Will do.
>=20
> i.e. you can add some description after the "---" line, and that won't
> affect git to apply the patches. Usually people put changes between
> versions, and in this case since you just want to update a version that
> is not the final version, you can add some description about that there
> as well.
>=20
Yes. I just learned that it's working like this. See above :)
>=20
> Thanks! Again, sorry for not being clear in previous emails.
>
Don't worry.


Best,

Oliver



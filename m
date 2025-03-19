Return-Path: <linux-kernel+bounces-568144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F88BA68EA9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 275C97A6426
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC291AA1D2;
	Wed, 19 Mar 2025 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="HY5WWWTf"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5577B19B5B8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393594; cv=none; b=rN44ZuG0U2OG5eQCo+BPVV3fS4lx2TZKffjJ+UrfZiNUnZa8OWRITZVpdjFKmsg+7ymWpVLXw3jhE4mNgtexd799caDAKbkYdVsDU30cfYS7oXEO8ijGMiMXSzpPRWm5M4crIbbNZNmE4xYgeZmLS5OtIytnyjjEDqFsJGxw4xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393594; c=relaxed/simple;
	bh=173mR8ZcqIucBbAsooxSJ7aCrBDlB0BXxLNyDYR2IkI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jk+FDdsM4HLkCiX2Hi6CwMv4/hhlPsbOq4frlProzC15QxUJJ/IQkgxdEMOrx1LmmldsoBmr7V+oGmLp0bynbD7jrzl+CMeUMasQXroBuWtwAHSIDqp55AnkfJeEDr1tCs+UocPnJ3tB8+lha1DaofV5TuzH4pY1pPSq8V+g1W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=HY5WWWTf; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742393584; x=1742652784;
	bh=yYLcfHuvK6FvGpwQFNJmILNKHihIkpgM2uT8zMa5DCs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=HY5WWWTfyhBjxkHduWvmBtGULW1loewR5xlXgUfO5cZ5gwsKQ+U9rARjqqR/ALYv1
	 +7y34Ofkw0vwjdy2JiXZ9r2t2yTrNbDQv4pFyhFj6HbWhMoiwWyODDCS8wN+akkQek
	 U+tBqfAGz3XVg7UgROscGQ0kz+AxoH+89vlSLpVSw/YWaUuke9/b0wjvEHxPJW8GXX
	 XSuAJdj9v+KWeco8H7tBOcXAORnJVDPg+YFGFPL88D7x8jhh/8bJEgLGLmUFyqB4r7
	 QTr4jNb/Wc5AuxkHZDQuAJKR7mGVHgGRU/t8nL6Iu365mtROL9ymCv+eD17DuBCqSu
	 GdmtHSpSs7sng==
Date: Wed, 19 Mar 2025 14:13:00 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v7 3/3] rust: platform: allow ioremap of platform resources
Message-ID: <D8KAZ2NYJ4C3.STH2PZYCM7X4@proton.me>
In-Reply-To: <Z9qpC1EapJFNadME@pollux>
References: <20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com> <20250318-topics-tyr-platform_iomem-v7-3-7438691d9ef7@collabora.com> <Z9mwu-RHwZ8qwcbH@cassiopeiae> <FF128DEF-28D6-4302-9C53-2DD4D417053A@collabora.com> <D8JTUPQ28758.2SKKTA6IL6Y8E@proton.me> <Z9qpC1EapJFNadME@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 72b1eaec6fc8bf9fcfcb1f6690c590f709d0dbd4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 12:22 PM CET, Danilo Krummrich wrote:
> On Wed, Mar 19, 2025 at 12:48:00AM +0000, Benno Lossin wrote:
>> On Tue Mar 18, 2025 at 7:22 PM CET, Daniel Almeida wrote:
>> > On 18 Mar 2025, at 14:43, Danilo Krummrich <dakr@kernel.org> wrote:
>> >> On Tue, Mar 18, 2025 at 02:20:43PM -0300, Daniel Almeida wrote:
>> >>> +    ///     // Read and write a 32-bit value at `offset`. Calling `=
try_access()` on
>> >>> +    ///     // the `Devres` makes sure that the resource is still v=
alid.
>> >>> +    ///     let data =3D iomem.try_access().ok_or(ENODEV)?.readl(of=
fset);
>> >>> +    ///
>> >>> +    ///     iomem.try_access().ok_or(ENODEV)?.writel(data, offset);
>> >>=20
>> >> I'd probably write this as
>> >>=20
>> >> || -> Result {
>> >> let iomem =3D iomem.try_access().ok_or(ENODEV)?;
>> >>=20
>> >> iomem.read32(offset);
>> >> iomem.write32(data, offset);
>> >>=20
>> >> Ok(())
>> >> }()?;
>>=20
>> Why use a closure here?
>
> Calling try_access() only once and not having the closure is fine too.
>
> But I also think it would be good practice for an example to explicitly l=
imit
> the scope of the corresponding guard.

Ah you're using the closure to limit the lifetime of the guard. You
don't need a closure, braces suffice.

> Ideally, it uses [1], once available.
>
> [1] https://lore.kernel.org/rust-for-linux/20250313-try_with-v1-1-adcae7e=
d98a9@nvidia.com/

Yeah that sounds best.

---
Cheers,
Benno



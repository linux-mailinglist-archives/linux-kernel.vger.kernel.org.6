Return-Path: <linux-kernel+bounces-257582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F3937C23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898CA283176
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68B1494B3;
	Fri, 19 Jul 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="q3G6gYxe"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDC6149011;
	Fri, 19 Jul 2024 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412571; cv=none; b=b0CuTKAZwa+SkROluBDO03j5Dr4EdJ5J3F+r/kw5TJsH47oJDz+bWWbNjeEvAU7AHzeoN4uWIJavrYa8/Sfaa/hMr/rHJ1SZG045EW4mgTleSgTksgzroKI0WRc3KX+nxPFZ/NpQFC3ZmjN5hbrkz+fq0wBjO7QXXAACDaGdfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412571; c=relaxed/simple;
	bh=3VMU5eBjazeBhKCKDGXwCZUunmjYG8Cp+p+cnvIeGvc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aXu7/cjpCdhg1aTS0MUvQrIaDeXS/X6fJPaR55l5l70pdtpNpgqEVlDJzSkS1MiWLgJar1XeuhnHrme0aXCGsLn3+Hw2fGq7rveiCoz52PSX7hXjbYTf4wn6cnapby1kAqv+kaM/092mrlqA0gbeNx9YbupEIJlnKnYNe9w3YbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=q3G6gYxe; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721412567;
	bh=3VMU5eBjazeBhKCKDGXwCZUunmjYG8Cp+p+cnvIeGvc=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=q3G6gYxe1mm4JSgEhPPABmtwg3oQs+4kEWVEqU90u48LTSJFIZ4IO1KsCYV/6oCKK
	 8j3XbRRq21tGMo3MEi7mB2Su1wzYsReJ+feJ75TVT3ScKlty09ocDVMefLSZgsywUT
	 WmyWk5Wzjm9RSMA2+yg+bBqqWuDYGgB2h9yazI1JEd3ByFxH8fvgcnvz5FvFQL3PsU
	 zNeTu7Ez/ghdAbOdufQDEVBoP+7ggPYKGOJ04T9HJFAPXqcNgpTt4sOjDU9ZQ1Cz59
	 ajsgA4raP4TOGC5a9tqdymDWYRd4KTjBakkm1cSzucrZWmJxCVqZroBGHYUlm4helE
	 M0tzjaGOo9oMA==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A8F623780523;
	Fri, 19 Jul 2024 18:09:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH 1/5] doc: rust: create safety standard
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <ZpqeEywGic4nIEL8@pollux>
Date: Fri, 19 Jul 2024 15:09:09 -0300
Cc: Benno Lossin <benno.lossin@proton.me>,
 Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E1B12C1-1ACD-4A26-AC89-CC32327B51F5@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-2-benno.lossin@proton.me>
 <99DF6A0F-BAE9-4341-8B42-6C1F1C69E2C6@collabora.com>
 <ZpqeEywGic4nIEL8@pollux>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Danilo,


>=20
> We can easily build abstractions that ensure that the address a driver =
is trying
> to access is mapped properly, such that you can't have accidential =
out-of-bound
> accesses.
>=20
> Those can be implemented by the corresponding subsystem / bus that the =
resource
> originates from.
>=20
> In fact, we already have abstractions for that on the way, a generic =
I/O
> abstraction [1] as base implementation and a specific abstraction for =
PCI bars
> [2].
>=20
> Of course, if the MMIO region comes from let's say the device tree, we =
still
> have to assume that the information in the DT is correct, but the =
driver does
> not need unsafe code for this.
>=20
> [1] =
https://lore.kernel.org/rust-for-linux/20240618234025.15036-8-dakr@redhat.=
com/
> [2] =
https://lore.kernel.org/rust-for-linux/20240618234025.15036-11-dakr@redhat=
.com/
>=20

Thanks for pointing that out. So from this:

+impl<const SIZE: usize> Io<SIZE> {
+ ///
+ ///
+ /// # Safety
+ ///
+ /// Callers must ensure that `addr` is the start of a valid I/O mapped =
memory region of size
+ /// `maxsize`.
+ pub unsafe fn new(addr: usize, maxsize: usize) -> Result<Self> {
+ if maxsize < SIZE {
+ return Err(EINVAL);
+ }
+
+ Ok(Self { addr, maxsize })
+ }

It looks like one can do this:

let io =3D unsafe { Io::new(<some address>, <some size>)? };=20
let value =3D io.readb(<some offset>)?;

Where <some address> has already been mapped for <some size> at an =
earlier point?

That=E2=80=99s fine, as I said, if an abstraction makes sense, I have =
nothing
against it. My point is more that we shouldn=E2=80=99t enact a blanket =
ban on
'unsafe' in drivers because corner cases do exist. But it=E2=80=99s good =
to know that this
particular example I gave does not apply.


>>=20
>> If a driver is written partially in Rust, and partially in C, and it =
gets a
>> pointer to some kcalloc=E2=80=99d memory in C, should It be forbidden =
to use unsafe
>> in order to build a slice from that pointer? How can you possibly =
design a
>> general abstraction for something that is, essentially, a =
driver-internal API?
>=20
> That sounds perfectly valid to me.
>=20


=E2=80=94 Daniel




Return-Path: <linux-kernel+bounces-559708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DCFA5F867
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4797ABF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913126A1C4;
	Thu, 13 Mar 2025 14:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="k4ommqUg"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B48526A0E0;
	Thu, 13 Mar 2025 14:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876245; cv=none; b=FmqLapo0DUtLToMZ0yRFJKpcldjeBPe1LDkuJBX+0dpfXwvJ4CZ2+82T1CbIvkkAJ3DyZq+U9ktL7Bn5qpMdOOzi1kvRzFqwUcMt9VzBAHzrsziGGR9/sK5qLL4+mJ7k3dP4V4URQ0hS89IbBepwbB8ciNVapfeL5OK9AcKDpbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876245; c=relaxed/simple;
	bh=zz9OKaHpyYWuhTHYCFpBeMMjlsOXeK8pV/uVlGaqErU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCZGJeKUWf0g4u8TbU5tldfDpa1Fq3YMBXWMf6fDfjfWgVh5Rf8rlidSiqDIRkx83ILkp/lDzld9Nx04HPppGBwUZag4ZRXNm1DAZ26KngiSpGKtSD4zd4iNBF7/Y3IpS3T0kL0vIMMmUPTEs74U5e68O2iT33wrdsyaaKc5vqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=k4ommqUg; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741876236; x=1742135436;
	bh=F6M4s+ILHt7DM/PwWL75YNy9CFejS8naNQqvpm0Y5MM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=k4ommqUgBcITHpFz9jGy2Q4yTqBr63A0LyH2aHQny0PXRqHyzOsP7VyiY60Hyqlym
	 VnI7W8Sp9l13GvyQh9ufwBvLeUWA2RmZtsIrhSihIirtvLm8kznxdkdiOvo+YrtLFg
	 jCA+2bBVWu1NhyBe5h0yLzuPpPhK+wGY8GdvNnE7/OQwjWj6Y1aSzeZWht5xFgeChC
	 4LKyznGvRyC1loILA34aqIqqollscW7Cgfb+Lf2onzsW3hBaWp3reH49rgrDglSbL1
	 LVnZG8lRk/TEY0G1K8KOGAv83E6yOXnqlFvAK+K7eqX87/zQ/74TGSWSHKWl0932hQ
	 HT5BLpatyXHmA==
Date: Thu, 13 Mar 2025 14:30:32 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 3/4] rust: pci: fix unrestricted &mut pci::Device
Message-ID: <D8F7L7ZGQW9J.3Q8MVXYPTJIT@proton.me>
In-Reply-To: <Z9Lq8xyTbIzfPhRX@pollux>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-4-dakr@kernel.org> <D8F2S8YNYGZP.3JQKC7ZMRAB2C@proton.me> <Z9Lq8xyTbIzfPhRX@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3006e74b50f619147a17f02ee397e88943aa2cc2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:25 PM CET, Danilo Krummrich wrote:
> On Thu, Mar 13, 2025 at 10:44:38AM +0000, Benno Lossin wrote:
>> On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
>> > As by now, pci::Device is implemented as:
>> >
>> > =09#[derive(Clone)]
>> > =09pub struct Device(ARef<device::Device>);
>> >
>> > This may be convenient, but has the implication that drivers can call
>> > device methods that require a mutable reference concurrently at any
>> > point of time.
>>=20
>> Which methods take mutable references? The `set_master` method you
>> mentioned also took a shared reference before this patch.
>
> Yeah, that's basically a bug that I never fixed (until now), since making=
 it
> take a mutable reference would not have changed anything in terms of
> accessibility.

Gotcha.

>> >  impl AsRef<device::Device> for Device {
>> >      fn as_ref(&self) -> &device::Device {
>> > -        &self.0
>> > +        // SAFETY: By the type invariant of `Self`, `self.as_raw()` i=
s a pointer to a valid
>> > +        // `struct pci_dev`.
>> > +        let dev =3D unsafe { addr_of_mut!((*self.as_raw()).dev) };
>> > +
>> > +        // SAFETY: `dev` points to a valid `struct device`.
>> > +        unsafe { device::Device::as_ref(dev) }
>>=20
>> Why not use `&**self` instead (ie go through the `Deref` impl)?
>
> `&**self` gives us a `Device` (i.e. `pci::Device`), not a `device::Device=
`.

Ah, yeah then you'll have to use `unsafe`.

---
Cheers,
Benno



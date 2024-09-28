Return-Path: <linux-kernel+bounces-342467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2D988F60
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978041F21C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 13:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA6E188008;
	Sat, 28 Sep 2024 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ABYXK6ph"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9C1DFF8;
	Sat, 28 Sep 2024 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727529662; cv=none; b=DlIO1ZRELdg/mo/pxA0GMvwL/2lUHwY9RzXV81xI1l0mhmdAN+JDYcqog6vns3KUSYYrcCycxreQLnjrjUbSrn55vxSLIkZoZJvSOOA4U5Mg4MUMl2uzLcTMkyTZSRSgco168RyzJoRywG0nwkVLKn53UO6fTFHmyqOIaYwkZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727529662; c=relaxed/simple;
	bh=UH1WsrDfH845J7N+rwSC8AvHZeCjoIhAa/TviSrMug4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OtLogOSMx4mEGM/KlzcvZi4UGX/YGG6aW1un0/v2B/D4EahD4W/KmhgXAvQdko2Cquux0u3kxeHJvibU2Na68y+0eTzUiJxbkzGfwjxSEtFa8gbnw8nSrKBPA/5KGxVrkeeHUGCm3HrbcJvT7usWPWky8sjIGeSfi77feMhR7qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ABYXK6ph; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=tkj6nbwqzbhc3bfzg4sbzipy74.protonmail; t=1727529652; x=1727788852;
	bh=b03AlkBxsxLRuJ6y9m9dznsNy8PcwqXKGf2lbe9Z5X8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ABYXK6phgiAsHFNuoPmcwPAKZKbjqsrEAOy9MD6FhYm7uRrfD1i/DNLKnTgf7oJgW
	 Fi2MTKejoxt7bkYLd9np7oVFzl1JQZRCCBv/jowNOBu7jRsSJ0mwOZS3bmfA7OiZ4T
	 A+LZ/S8iw4lu5eLfJ/ynIATUp/U/Gc9BnXTC2H30oT5AZBSxBPy0K0nZZmzIFdT091
	 TqWX+yxWYslkHeodxw4oZfp9xpul3nVweoO4yBitLCOAqWbtRhe3dvVMKudyVpo483
	 YbPLUa3Ved3bGxlDU07RsRZ/sLrIMieJxe2A+Com/HU4I2jGLe9Q2A1aoZNEjdkttT
	 IPNj0oww2Txkg==
Date: Sat, 28 Sep 2024 13:20:45 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 13/26] rust: alloc: implement kernel `Vec` type
Message-ID: <0d71296c-e605-47cb-a8be-8cd16c54d9d4@proton.me>
In-Reply-To: <Zvf58aEqGEamm7s8@pollux>
References: <20240911225449.152928-1-dakr@kernel.org> <20240911225449.152928-14-dakr@kernel.org> <1a06b767-ca02-41ec-840a-47e73f7876d8@proton.me> <Zvf58aEqGEamm7s8@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 341fb30362b194ab6bb6b8b04e97d79a43f2503d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28.09.24 14:43, Danilo Krummrich wrote:
> On Thu, Sep 26, 2024 at 01:47:04PM +0000, Benno Lossin wrote:
>> On 12.09.24 00:52, Danilo Krummrich wrote:
>>> +    /// Appends an element to the back of the [`Vec`] instance.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// ```
>>> +    /// let mut v =3D KVec::new();
>>> +    /// v.push(1, GFP_KERNEL)?;
>>> +    /// assert_eq!(&v, &[1]);
>>> +    ///
>>> +    /// v.push(2, GFP_KERNEL)?;
>>> +    /// assert_eq!(&v, &[1, 2]);
>>> +    /// # Ok::<(), Error>(())
>>> +    /// ```
>>> +    pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocErro=
r> {
>>> +        Vec::reserve(self, 1, flags)?;
>>> +
>>> +        // SAFETY:
>>> +        // - `self.len` is smaller than `self.capacity` and hence, the=
 resulting pointer is
>>> +        //   guaranteed to be part of the same allocated object.
>>> +        // - `self.len` can not overflow `isize`.
>>> +        let ptr =3D unsafe { self.as_mut_ptr().add(self.len) };
>>> +
>>> +        // SAFETY:
>>> +        // - `ptr` is properly aligned and valid for writes.
>>> +        unsafe { core::ptr::write(ptr, v) };
>>
>> Why not use `self.spare_capacity_mut()[0].write(v);`?
>=20
> Before v7 I did exactly that, but in v6 you suggested to use the raw poin=
ter
> instead to avoid the bounds check.

Ah I see... Would be pretty useful for me to have my previous comments
easily accessible, I don't usually look at the previous thread. Is
anyone aware of some tools for that?

>> If you want to avoid the bounds check, you can do
>>
>>     let first =3D self.spare_capacity_mut().first();
>>     // SAFETY: the call to `Vec::reserve` above ensures that `spare_capa=
city_mut()` is non-empty.
>>     unsafe { first.unwrap_unchecked() }.write(v);
>=20
> `first` does a similar check to create the `Option<&T>`, right?. I'd rath=
er keep
> the raw pointer access as suggested in v6.

It does a check, but the optimizer will get rid of it if you use
`unwrap_unchecked` [1]. But feel free to leave it as-is.

[1]: https://godbolt.org/z/zYbMTo86M

---
Cheers,
Benno



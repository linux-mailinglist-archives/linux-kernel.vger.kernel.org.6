Return-Path: <linux-kernel+bounces-547990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9702EA53E8F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C667B1891341
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6CA207675;
	Wed,  5 Mar 2025 23:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jOJAu7pW"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721DE1E7C20;
	Wed,  5 Mar 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741217835; cv=none; b=juBRVGAjetziIThqekbn+6TvlISeZcMTAxCKolKFaCmZAkLk6sHStk1iSeRf4oWdKy2k8z2Zg9Y75UOmyo3P5pdwDmclMqjUiOv+nAtPal49dDwQAbgpdKLYMqkct6z50uvNCvcyWhXpOx7UUbTKj/GjY57VRyoG/H2L9vqczhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741217835; c=relaxed/simple;
	bh=1YbTGjEn48i1yS1UtOBqzTT2yFuTNMZM06nIFIgdYfo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zs/xuTidId0qzoP8YXEAtUF+2GGcIDe3fJL5kuU3AvzkEDy5Nmn+YfQRqGB0W4piSKGQE0ja1h7j8CGipKRvEM7Me8HZ0C4sPJlALDZ/wCaFPuvIQDsOtCV+vlPB48BIiVdMloY4lW/8CMbAB1Rdzfsr9bJwKhetOT3Y/3Qbpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jOJAu7pW; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741217824; x=1741477024;
	bh=Gxk41D0aEqbdm+zd94pkZqxTTDSqmpgclDrTYWEtmOU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=jOJAu7pWZF5YNcHCbbVPZ4Fkebu/IyTtsQPmQsnttyTD0DL599Ek2Pb7/DQwV6Anj
	 kFmvU5ZkfUcIsDFuUcsNb/99bl5sNLQV2E0t9r9uVi5/i4PJbNRR15kWVPf0RpV30i
	 i7L+/QxnHgzNCEGyv+aDgcZ23NRGTQzFykPqCUDvuQz3livsEWVMnbsel4heR8sYIX
	 SiOahehcGiHt5tgQoSJFyW2VXaXpc6ZwG68MnmRXttIau09KAUKaBge5yAMbVeHUxL
	 xzo7BUSGvahj4wi1j5zCYwp4oGqMsiaWeQlKmQ8QadrHR3Z6btPMOIduRUE5IPk5Ij
	 2cwQm7Sab+yag==
Date: Wed, 05 Mar 2025 23:36:54 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 2/5] rust: firmware: introduce `firmware::ModInfoBuilder`
Message-ID: <D88Q7503C8FF.2TMMBSEMOGKU1@proton.me>
In-Reply-To: <Z8jSV5CpZDcXrviY@pollux>
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-3-dakr@kernel.org> <D88OSC9XJXZL.C5HXWFYCG9U6@proton.me> <Z8jSV5CpZDcXrviY@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f41048d72c2b4fded541320cd54a9e6ca4066086
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 5, 2025 at 11:38 PM CET, Danilo Krummrich wrote:
> On Wed, Mar 05, 2025 at 10:30:31PM +0000, Benno Lossin wrote:
>> On Tue Mar 4, 2025 at 6:34 PM CET, Danilo Krummrich wrote:
>> > +    /// Push an additional path component.
>> > +    ///
>> > +    /// After a new [`ModInfoBuilder`] instance has been created, [`M=
odInfoBuilder::prepare`] must
>> > +    /// be called before adding path components.
>> > +    pub const fn push(self, s: &str) -> Self {
>> > +        if N !=3D 0 && self.n =3D=3D 0 {
>> > +            crate::build_error!("Must call prepare() before push().")=
;
>>
>> This will only prevent the first `prepare` call being missed, right?
>
> Correct, unfortunately there's no way to detect subsequent ones.

Does it make sense to do that one in the constructor?

(After looking at the example below) Ah maybe you can't do that, since
then you would have two `prepare()` calls for the example below...?

>> > +        }
>> > +
>> > +        self.push_internal(s.as_bytes())
>> > +    }
>> > +
>> > +    const fn prepare_module_name(self) -> Self {
>> > +        let mut this =3D self;
>> > +        let module_name =3D this.module_name;
>> > +
>> > +        if !this.module_name.is_empty() {
>> > +            this =3D this.push_internal(module_name.as_bytes_with_nul=
());
>> > +
>> > +            if N !=3D 0 {
>> > +                // Re-use the space taken by the NULL terminator and =
swap it with the '.' separator.
>> > +                this.buf[this.n - 1] =3D b'.';
>> > +            }
>> > +        }
>> > +
>> > +        this.push_internal(b"firmware=3D")
>> > +    }
>> > +
>> > +    /// Prepare for the next module info entry.
>> > +    ///
>> > +    /// Must be called before [`ModInfoBuilder::push`] can be called.
>>
>> If you always have to call this before `push`, why not inline it there?
>
> You can push() multiple times to compose the firmware path string (which =
is the
> whole purpose :).

Ah I see, I only looked at the example you have in the next patch. All
in all, I think this patch could use some better documentation, since I
had to read a lot of the code to understand what everything is supposed
to do...

It might also make sense to make this more generic, since one probably
also needs this in other places? Or do you think this will only be
required for modinfo?

---
Cheers,
Benno

> Example from nova-core:
>
> =09pub(crate) struct ModInfoBuilder<const N: usize>(firmware::ModInfoBuil=
der<N>);
>
> =09impl<const N: usize> ModInfoBuilder<N> {
> =09    const fn make_entry_file(self, chipset: &str, fw: &str) -> Self {
> =09        let version =3D "535.113.01";
>
> =09        ModInfoBuilder(
> =09            self.0
> =09                .prepare()
> =09                .push("nvidia/")
> =09                .push(chipset)
> =09                .push("/gsp/")
> =09                .push(fw)
> =09                .push("-")
> =09                .push(version)
> =09                .push(".bin"),
> =09        )
> =09    }
>
> =09    const fn make_entry_chipset(self, chipset: &str) -> Self {
> =09        self.make_entry_file(chipset, "booter_load")
> =09            .make_entry_file(chipset, "booter_unload")
> =09            .make_entry_file(chipset, "bootloader")
> =09            .make_entry_file(chipset, "gsp")
> =09    }
>
> =09    pub(crate) const fn create(
> =09        module_name: &'static kernel::str::CStr,
> =09    ) -> firmware::ModInfoBuilder<N> {
> =09        let mut this =3D Self(firmware::ModInfoBuilder::new(module_nam=
e));
> =09        let mut i =3D 0;
>
> =09        while i < gpu::Chipset::NAMES.len() {
> =09            this =3D this.make_entry_chipset(gpu::Chipset::NAMES[i]);
> =09            i +=3D 1;
> =09        }
>
> =09        this.0
> =09    }
> =09}




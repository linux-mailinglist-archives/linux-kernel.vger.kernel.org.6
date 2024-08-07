Return-Path: <linux-kernel+bounces-278463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6325D94B094
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209A128401E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9090D1448C7;
	Wed,  7 Aug 2024 19:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Abp3Pb0k"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D7225A2;
	Wed,  7 Aug 2024 19:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059962; cv=none; b=t3S3fwscMozfqPo05tpWLhFY5SW4gvlieeU85vFPRM0qndpUX+rHr72luVMq0HS73hjmJXIaWeHEXwiBFhh5iJ9BWT7CDiNHZN81HFAHBhTCyy8hkI6akLZcBB9FDYmJrxMOJbWWBSJRJejdybcUHM95hNvXRFSvunGes46ZQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059962; c=relaxed/simple;
	bh=8yPjSG27OzCjwdEUBKBXWh2QvkDACViiJWliReBWynU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ub0/ADT/6Tmpu9oKWLxcI50ukeqyBN/KycL3B8hlmXOXA0TF085jRVw0vxTyCSAqrSztYPIKXWsuyLL7nqu6irI2HM7OkDKTL3ZtYrFh1oTgWsW4dtpAwBrCQbdypp23Uyyle4SxABqUIFJ30R6Jgn5pJ64nm4FBUe4dQRcf6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Abp3Pb0k; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723059957; x=1723319157;
	bh=n7b2GAQrzs9AM3lt4AGGK8DRluSXFCmxK7usLnL622o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Abp3Pb0k50xRVS/dZ07wZTHqjbTyqGulgCXc8lofc4ThV4VrChFOxQhtBZb0CU1ts
	 AffU6+4XSYJkZjcBM/o38ijuE2srNb2RbxTwDWT4xMeu2pZU/o5+k2CAMgsJbrHenh
	 rWt7c/q/YduyslenVOrvviW7cMp+08OL594AWifPWdiULbbcFNKikZ0dJKFzmaldcE
	 YerLviJT60GxtT7x1haVW1apCzJVBsvW3H/JeEMGV26+YkVA1lgRRW3bEkt1ZumzRN
	 zm6+8oghPv5w2N9gkex7JxWIpE9SNJPNKJXNOBwkq4z8kA7hJyNSxuLb2CSianMh9m
	 bosbl+dbP+X8g==
Date: Wed, 07 Aug 2024 19:45:50 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <57f75d21-6bb4-4991-ab48-de5f08acba18@proton.me>
In-Reply-To: <ZrNOqEXo_V4O4srC@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-10-dakr@kernel.org> <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me> <ZrKrMrg5E85y7jkj@pollux> <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me> <ZrNOqEXo_V4O4srC@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: c515a4ad2e035c03667191254930f97f6ab0ce2c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 12:38, Danilo Krummrich wrote:
> On Wed, Aug 07, 2024 at 07:49:31AM +0000, Benno Lossin wrote:
>>>>> +    {
>>>>> +        Ok(Self::new(x, flags)?.into())
>>>>> +    }
>>>>> +
>>>>> +    /// Drops the contents, but keeps the allocation.
>>>>> +    ///
>>>>> +    /// # Examples
>>>>> +    ///
>>>>> +    /// ```
>>>>> +    /// let value =3D KBox::new([0; 32], GFP_KERNEL)?;
>>>>> +    /// assert_eq!(*value, [0; 32]);
>>>>> +    /// let value =3D KBox::drop_contents(value);
>>>>> +    /// // Now we can re-use `value`:
>>>>> +    /// let value =3D KBox::write(value, [1; 32]);
>>>>> +    /// assert_eq!(*value, [1; 32]);
>>>>> +    /// # Ok::<(), Error>(())
>>>>> +    /// ```
>>>>> +    pub fn drop_contents(this: Self) -> Box<MaybeUninit<T>, A> {
>>>>> +        let ptr =3D Box::into_raw(this);
>>>>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_r=
aw`.
>>>>> +        unsafe { core::ptr::drop_in_place(ptr) };
>>>>> +        // SAFETY: `ptr` is valid, because it came from `Box::into_r=
aw`.
>>>>> +        unsafe { Box::from_raw(ptr.cast()) }
>>>>> +    }
>>>>
>>>> I don't particularly care in this instance, but you just took my patch
>>>> and folded it into your own without asking me or specifying it in the
>>>> commit message. In general I would have assumed that you just put the
>>>> entire patch into the series (with correct From:... etc).
>>>
>>> When I asked about this in [1] my understanding was that we expect [1] =
to land
>>> prior to this series. So, I'm just anticipating a future rebase where I=
 move
>>> this code from box_ext.rs to kbox.rs, just like Alice suggested for her
>>> "ForeignOwnable for Pin<crate::alloc::Box<T, A>>" implementation.
>>>
>>> I also understand your later reply, where you said: "[...] then you can=
 just
>>> include it when you remove the `BoxExit` trait." as confirmation.
>>>
>>> Probably that's a misunderstanding though. Sorry if that's the case.
>>
>> Yeah what I meant by that was you base it on top and then move it from
>> the `BoxExt` trait over to `Box` in a correctly attributed patch.
>=20
> I don't understand this. What do you mean with "correctly attributed patc=
h" in
> this case?

So, seems like I mixed the two approaches I thought of. Here are they
separated:
1. base the series on top of my patches and then copy the implementation
   from the in-tree file this patch.
2. create a new patch that adds `drop_contents` to your Box (ie after
   this patch) that has `Signed-off-by: you` and `Co-Developed-by: me`.
   With this approach I would also ask privately (including the patch)
   if that would be ok.

---
Cheers,
Benno

> There are various existing implementations around `Box` and `BoxExt`, are=
 you
> saying that I should create separate patches for moving / adapting all of=
 them,
> e.g. this patch adapts parts from `BoxExt`, the implementation of
> `ForeignOwnable` for `Box<T>`, the implementation of `InPlaceInit<T>` for
> `Box<T>`.
>=20
> I don't think this is necessary.
>=20
> I probably shouldn't anticipate a future rebase though, it just leads to
> confusion. I'll drop it for now and re-add it once your patch lands in ru=
st-next.
>=20
>> As I
>> said above, I don't really mind in this case, since it's trivial, so no
>> worries. Just a heads-up for occasions where it is non-trivial.
>>
>>> [1] https://lore.kernel.org/lkml/24a8d381-dd13-4d19-a736-689b8880dbe1@p=
roton.me/



Return-Path: <linux-kernel+bounces-277454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E24D94A1A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEE028649B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195C1C7B93;
	Wed,  7 Aug 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aPurxjKR"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036DC1C7B81
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015674; cv=none; b=q4ja1TPhp0tc8EUy8g21ojNtWHHatZvigfJDqIh6F/oUFH7B0U2c9oM5l2SFFbsiV5mrMLxnJeBrJsoLtSBnHIKXf8DdxEGdABpohsduTPrRNILfX14FyQx4aPATXixw7I0+rDYLj1/dKfyW4RIpkUVoaTz+4uR87hRf7dIlYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015674; c=relaxed/simple;
	bh=xpcdVMCOMS6ZEUxGHrLtt6WYnma8jov+VO8vTgPH3Lw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF3Hq0+2ytcxg57QXecmK/ZiMWgnjlBXalC5BuUrcb+0lLcQuoU+of58Lpb8sxZoJH514qHRpcxyiZVnU1pMTjmzAVEir90WvlxFJD43Z+ymv0ShMbRTG3hlGlep2RY0DIsHv2JQD3v+twKNJBiwxP9FmZqYrylFfJu9noeyWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aPurxjKR; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723015670; x=1723274870;
	bh=INMG5HrhyREBaOaaWbYVtgtotk53aCP+1xHBSxmczYI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aPurxjKRvSEaRucKuZ7JFILRNT/3RTNud9f4LmE/jkxnZFtWpKFgq+kawQZh80BNW
	 U8/Q24+n7rc9dwUMx5mC+ua2PKyuuIuct5ARNqEzj4UMYTVjztugcBz/EpCcoy7N3j
	 2UtWpqFIVVemoF6ldD+pu8wTA+fGTlUkV2YxcmkHSvOmPm027O7pbD4OP7aCdRqA5H
	 nupogAy0AAa+uWjfCMZ3eXWPoYWZwh0AGQ+RZTb5Gstql+ufw7yrzigkwP1MX5IFTT
	 F8zUZV0aFNZS9GWe9zWSPk/mNenjyENT1cH9lizbhXe+0nSZMl8hGkh5kcBDe0nPrn
	 ZKHUgQppFXN+g==
Date: Wed, 07 Aug 2024 07:27:43 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 08/28] rust: types: implement `Unique<T>`
Message-ID: <f3457432-dc83-4a19-b75a-88b914430733@proton.me>
In-Reply-To: <ZrKt7K68W1Jh6nhr@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-9-dakr@kernel.org> <ff0826af-9430-4653-abe8-25fb80cd0e97@proton.me> <ZrKt7K68W1Jh6nhr@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 76ed0ca302491360577dc6e8f86574c9d2d01ecb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07.08.24 01:12, Danilo Krummrich wrote:
> On Tue, Aug 06, 2024 at 05:22:21PM +0000, Benno Lossin wrote:
>> On 05.08.24 17:19, Danilo Krummrich wrote:
>>> +impl<T: Sized> Unique<T> {
>>> +    /// Creates a new `Unique` that is dangling, but well-aligned.
>>> +    ///
>>> +    /// This is useful for initializing types which lazily allocate, l=
ike
>>> +    /// `Vec::new` does.
>>> +    ///
>>> +    /// Note that the pointer value may potentially represent a valid =
pointer to
>>> +    /// a `T`, which means this must not be used as a "not yet initial=
ized"
>>> +    /// sentinel value. Types that lazily allocate must track initiali=
zation by
>>> +    /// some other means.
>>> +    #[must_use]
>>> +    #[inline]
>>> +    pub const fn dangling() -> Self {
>>> +        Unique {
>>> +            pointer: NonNull::dangling(),
>>> +            _marker: PhantomData,
>>> +        }
>>> +    }
>>
>> I think I already asked this, but the code until this point is copied
>> from the rust stdlib and nowhere cited, does that work with the
>> licensing?
>>
>> I also think that the code above could use some improvements:
>> - add an `# Invariants` section with appropriate invariants (what are
>>   they supposed to be?)
>> - Do we really want this type to be public and exported from the kernel
>>   crate? I think it would be better if it were crate-private.
>> - What do we gain from having this type? As I learned recently, the
>>   `Unique` type from `core` doesn't actually put the `noalias` onto
>>   `Box` and `Vec`. The functions are mostly delegations to `NonNull`, so
>>   if the only advantages are that `Send` and `Sync` are already
>>   implemented, then I think we should drop this.
>=20
> I originally introduced it for the reasons described in [1], but mainly t=
o make
> clear that the owner of this thing also owns the memory behind the pointe=
r and
> the `Send` and `Sync` stuff you already mentioned.

I would prefer if we make that explicit, since it is rather error-prone
when creating new pointer types (and one should have to think about
thread safety).

---
Cheers,
Benno

> If no one else has objections we can also just drop it. Personally, I'm f=
ine
> either way.
>=20
> [1] https://docs.rs/rust-libcore/latest/core/ptr/struct.Unique.html



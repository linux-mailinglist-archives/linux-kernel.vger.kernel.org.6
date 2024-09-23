Return-Path: <linux-kernel+bounces-336143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCE497EFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 19:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDC51F21FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3CA19F133;
	Mon, 23 Sep 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PYr1c8Dh"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1127219F111
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110797; cv=none; b=RW7O/x42aa2uGWodpSK7qPmEvxQyPVKQr4ozaphHShzHpIo7u9NmxkHniiqPO0e+RfSOWRQRV5SSKzlBtkpbVEk9BbWCylF6u/euFiEJQ5i/YwCrn/NHbSfNNole4T+vdhGpnKtMNf5+PxyobmKvjvkxCrQzmJyMeUQt1vrVxsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110797; c=relaxed/simple;
	bh=tChY4i4t1si/Ow2SVnPOYtdrSdx8APVATHGGLuW49eQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI2wpZReG7dmE6T3PkGxs55UtGsNejmczy0DKqb0rOROdf1DV9y2QQlnEUj3miB9FR/QZeQGTq0EDDDawQ+L2iGTpIUMm4gZB+vXAU3pKF9L625mpSnqyepSsL0oZdSAKWDvgVEUBJ0V30mQjk1XXBcOk1LE0a9xc2iFQPvnyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PYr1c8Dh; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1727110792; x=1727369992;
	bh=bL0NMBwkdYkg3IgaS9DIPLf8onrINPcFkF0NWk2OV5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PYr1c8DhG22xdd2ukIXAdZkdSqwYynDaPAaplYKMYk3D4G2CRpZJqzk2qp5G/QrfH
	 1rLSJBAu8dHaqcjEOtj7a6E/exDdS8zK8BURx6BnnJWWBYXEHzR8YMJsKF0JVuWqpM
	 EHC8BzKMRX/IvWiaA40HqME1xWovHtVRQCRYQeB7Fvb+DA1AJM8jQkOFTVZzgFZVfI
	 ESyNL2bPThmLRSki/iTUWhIFS9XqOY40fTPghFbciIKYVx0bGx8cgqbims6xqtHMaU
	 UUhP6NEb/1NtkMppEEPBnK0TC3EddQPrXp/jVtEMpe6kedqlM3fQ+h++gXhxY9jmHv
	 ZShZn2tPwujpg==
Date: Mon, 23 Sep 2024 16:59:47 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <51f18817-1ebd-451a-bc6e-e298a9148001@proton.me>
In-Reply-To: <87ldziqqeo.fsf@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-3-a.hindborg@kernel.org> <Wohby8PLjQeZ47sXKGeWKOxdA2ShTjjvqOM6xWzhJY1aZ-SYk9TCDAnZN2EqiWuJUKwPKoFCsCofDHjtfeG--w==@protonmail.internalid> <f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me> <878qvojj0o.fsf@kernel.org> <pvhILkKRTj8T2Ks3off5HLMqewNM_X192WV4J5-nnC4Uu0o9G8-Qk5Tl9bQxsqVCw4QHmeJii7mCK2VorN-xcw==@protonmail.internalid> <33c65715-3af5-44f9-93c5-149d07a4c503@proton.me> <87ldziqqeo.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5e4d315e84d155ed467c03c1240338dc0ae7f548
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.09.24 18:35, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>> On 19.09.24 07:43, Andreas Hindborg wrote:
>>>>> +    /// until the timer is unarmed and the callback has completed.
>>>>> +    ///
>>>>> +    /// Note: It must be safe to leak the handle.
>>>>> +    type TimerHandle: TimerHandle;
>>>>
>>>> Why does this need to be an associated type? Couldn't we have a
>>>> `TimerHandle<T>` struct? The schedule function below could then return
>>>> `TimerHandle<Self>`.
>>>
>>> At one point, I had some cycles in trait resolution. Moving generics to
>>> associated types solved that issue. Maybe this can be changed to a
>>> generic. But are generics preferred over associated types for some
>>> reason?
>>
>> The associated type is more complicated IMO, because then every
>> implementer of the trait needs to create one. If we can avoid that, I
>> would prefer a generic type.
>=20
> When you say create, you mean specify?

Yes.

> Users would not invent their own type to put here, they would use the
> types defined by the `hrtimer` module in later patches.

I mean the implementers of this trait, not the users of the trait. You
define an `ArcTimerHandle`, `PinTimerHandle` and a `PinMutTimerHandle`
in this series. I think we can avoid that using a single generic struct.

---
Cheers,
Benno



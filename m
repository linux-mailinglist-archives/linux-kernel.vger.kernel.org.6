Return-Path: <linux-kernel+bounces-546781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF3FA4FEB2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344FF3AF3EE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF57245016;
	Wed,  5 Mar 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGPrZMkE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84587244EAB;
	Wed,  5 Mar 2025 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178053; cv=none; b=b57AlbAvEvRyCge9DoSjpR7xDvCJzHmF0Ok+vuMKh5yQrc97KFunlaL3gIkSV1dCLwuuNofEUaGNEQkSrZPirZmQooXBhyjlPQfZ93uTy+TSakoPerXtpoSJNC0ohZdy63OWjln6gsgKNS3aPxmQrjKrYLyY1U/Ch5+A5pS5/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178053; c=relaxed/simple;
	bh=HtDB4LHLVUdi5nQk0sqUMa3TbwIfRW7AwbxUSS/ZPAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jmHS9HowhFYR0D/Qh2Bz2o6wxaPg61oJdv7SI1ZbV5UBf+k3XrEYe0G6PI045Zs2yNIj7IATzNnCFIQBuXrPLl305hg7UxSfGs5iqCApYk9hddlgGpUvLE8xCbmoub/hyiF8NoAOQKDbhyJ7rIoLibewtuQ/h+16iX/O18gUqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGPrZMkE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB85C4CEE2;
	Wed,  5 Mar 2025 12:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741178053;
	bh=HtDB4LHLVUdi5nQk0sqUMa3TbwIfRW7AwbxUSS/ZPAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UGPrZMkEXSNHSjD5BHMFcMgDyj0u4e2rp18AEGJ0JW054go7MaUkcLEOYHV5Li5HK
	 D+ntpx/EFVJhU4PgPGxqfZyxytmEcfrJAXkM8tPExrRYUrF6Z+n+cwxq+CflyKr5H4
	 wmxUk3MBUGQ5AhBWr07H1bamLZYsgZ86qxw3aC7hOie/ndPK8VO3HCyvP53wX/g/v/
	 hKGysS4mEv/6HlabQm1gmF2G2J8xW0ZOKBnS/mt08I2AlldGQRpJiRwyXWaxJlDIYM
	 Z+ALQY9dm8v3VMZ8LqAI/4tysHm8q6AckvjE8Qwa5/KTAEFMXmh5lhXkJraCcOPumS
	 s8O0ZH3A5aPaQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/22] rust: pin-init: remove kernel-crate dependency
In-Reply-To: <D88BDOC74W1T.IMRXO8BE868S@proton.me> (Benno Lossin's message of
	"Wed, 05 Mar 2025 12:00:06 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<3-KVPpYsvS6jLhJOL7kCLrypBUWO1rtUDTDUTfy8T_iGZObM3CP6YUK_QLHmL_QTivMtd3jfnRbZOGpClk37cQ==@protonmail.internalid>
	<20250304225245.2033120-13-benno.lossin@proton.me>
	<87senrd7eq.fsf@kernel.org>
	<TtSwFcuhXiTGV4L74Ufe2hmXRw7Mtkty8owmqzxhfZtUt_jMJM_hWq_u47IlR5AobLRcddkgvZ4LzwhYY5cLPg==@protonmail.internalid>
	<D88BDOC74W1T.IMRXO8BE868S@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:27:38 +0100
Message-ID: <87wmd3br2d.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Wed Mar 5, 2025 at 12:49 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> In order to make pin-init a standalone crate, remove dependencies on
>>> kernel-specific code such as `ScopeGuard` and `KBox`.
>>>
>>> `ScopeGuard` is only used in the `[pin_]init_array_from_fn` functions
>>> and can easily be replaced by a primitive construct.
>>>
>>> `KBox` is only used for type variance of unsized types and can also
>>> easily be replaced.
>>>
>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>
>> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>
>>> ---
>>>  rust/pin-init/src/__internal.rs |  2 +-
>>>  rust/pin-init/src/lib.rs        | 41 +++++++++++----------------------
>>>  2 files changed, 15 insertions(+), 28 deletions(-)
>>>
>>> diff --git a/rust/pin-init/src/__internal.rs b/rust/pin-init/src/__internal.rs
>>> index 0db800819681..74086365a18a 100644
>>> --- a/rust/pin-init/src/__internal.rs
>>> +++ b/rust/pin-init/src/__internal.rs
>>> @@ -105,7 +105,7 @@ fn make_closure<F, O, E>(self, f: F) -> F
>>>      }
>>>  }
>>>
>>> -pub struct AllData<T: ?Sized>(PhantomData<fn(KBox<T>) -> KBox<T>>);
>>> +pub struct AllData<T: ?Sized>(Invariant<T>);
>>
>> Off topic, trying to learn something: You define `Invariant<T>` like so:
>>
>>   pub(super) type Invariant<T> = PhantomData<fn(*mut T) -> *mut T>;
>>
>> Consulting the variance table at [1], could you define it as
>>
>>   pub(super) type Invariant<T> = PhantomData<*mut T>;
>>
>> or is there another reason for using `fn`?
>
> Yes! There is another reason: `Send` and `Sync`, my `Invariant` type
> will always be `Send` and `Sync`, but `PhantomData<*mut T>` is always
> `!Send` and `!Sync`.
> One could argue that an `Invariant<T>` type should impl `Send`/`Sync`
> if and only if `T` does, but for my usage it doesn't matter. If you do
> need to use that, you could use `PhantomData<(fn(*mut T) -> *mut T, T)>`

Awesome, thanks for explaining.

Could you add this info to the docstring for `Invariant<T>`?


Best regards,
Andreas Hindborg




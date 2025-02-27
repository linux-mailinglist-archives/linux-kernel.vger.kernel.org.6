Return-Path: <linux-kernel+bounces-537073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD31A487C5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8E31886341
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79E91FFC54;
	Thu, 27 Feb 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvZxYJKR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F51B424D;
	Thu, 27 Feb 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680797; cv=none; b=fP4ZKxlGydOPB9K4gXXu5Rx9uns6RabxWDq/3Sp2vsKITX0IpKY0NA1VrD2fBbmKxxFFUsFMmkRGj+35zZwXbMvtGzkc26wAB8dpND2bO/IyPdL5D8r1jyYdIBL+Tfs4NQBVZIkbGzV+CqU6wmBqcYyW1Gy6mW0QcEnDBTg6eKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680797; c=relaxed/simple;
	bh=YU70u+Lrzy3NIIllb8QVYgo1H7mfIbm+KM3tzzZcf6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OQzTAinuPTc4d7ItzgPfW045/9XCzEeJjHIO7t+vk5/W0SZMySz8YvPa9raNkHm9nHM4ezvqrldZ3224lP1HF5uDxxcIkJbY+mEJUeW7P1mCCSELf4HPMtqjHVhx5UfJpe2CwNPe7vO34rnM0uOsK88W0JtgDXmOThSBwXrajq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvZxYJKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63068C4CEDD;
	Thu, 27 Feb 2025 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740680796;
	bh=YU70u+Lrzy3NIIllb8QVYgo1H7mfIbm+KM3tzzZcf6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TvZxYJKRgbB2G2OLEyVlfL+mdNvysSF33CQSt1GOmzIEx7pdTY3U9z2XODUxOg33J
	 TmbqsToF/lhstDr3tcBykMzOf6AhnwNwMFJ6BMOjbGoa3I2rWAPQhe7Wvbwyw7vGIt
	 BkigdisaCDkQyYStz9WEAfmUy2riOhZKe6RJo1A+qamlszz5m+u2Uch/smlWARBNDN
	 VySGas+8cNX2otAz6HAqw46rUxrdvaETeW3gZNdQ5/xUj1Pe+bAFbG/ELN3ldn1Hlw
	 YpBYFKQiNKM1VVn29k2dHBj1Hwbdyj1uy43alOWwli5uGt2uqzm1fNCB0VoRq6kaC1
	 dE6R/BvDXNK0g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Joel Becker" <jlbec@evilplan.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Ingo Molnar" <mingo@redhat.com>,  "Will Deacon"
 <will@kernel.org>,  "Waiman Long" <longman@redhat.com>,  "Fiona Behrens"
 <me@kloenk.dev>,  "Charalampos Mitrodimas" <charmitro@posteo.net>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] rust: sync: change `<Arc<T> as
 ForeignOwnable>::PointedTo` to `T`
In-Reply-To: <87o6ynp7nr.fsf@kernel.org> (Andreas Hindborg's message of "Thu,
	27 Feb 2025 19:24:56 +0100")
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
	<20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org>
	<CWcBoUvs9GV44AJgOvQffgsR1G-O58dn7IrSDXfpf0iskvvi98bw3hr9qDSNfZESFWRVP_WV-1hV2pXdM5IYag==@protonmail.internalid>
	<CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
	<87o6ynp7nr.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 19:26:28 +0100
Message-ID: <87ikovp7l7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Tamir Duberstein" <tamird@gmail.com> writes:
>
>> On Thu, Feb 27, 2025 at 7:37=E2=80=AFAM Andreas Hindborg <a.hindborg@ker=
nel.org> wrote:
>>>
>>> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation f=
or
>>> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
>>> functionality, but allows `ArcInner` to be private. Further, it allows
>>> downstream users to write code that is generic over `Box` and `Arc`, wh=
en
>>> downstream users need access to `T` after calling `into_foreign`.
>>>
>>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>
>>> This patch is a dependency for Rust `configfs` abstractions. It allows =
both
>>> `Box` and `Arc` to be used as pointer types in the `configfs` hierarchy.
>>> ---
>>>  rust/kernel/sync/arc.rs | 21 ++++++++++++++++-----
>>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> index dfe4abf82c25..3d77a31e116f 100644
>>> --- a/rust/kernel/sync/arc.rs
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
>>>  #[doc(hidden)]
>>>  #[pin_data]
>>>  #[repr(C)]
>>> -pub struct ArcInner<T: ?Sized> {
>>> +struct ArcInner<T: ?Sized> {
>>>      refcount: Opaque<bindings::refcount_t>,
>>>      data: T,
>>>  }
>>> @@ -345,18 +345,25 @@ pub fn into_unique_or_drop(self) -> Option<Pin<Un=
iqueArc<T>>> {
>>>
>>>  // SAFETY: The `into_foreign` function returns a pointer that is well-=
aligned.
>>>  unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
>>> -    type PointedTo =3D ArcInner<T>;
>>> +    type PointedTo =3D T;
>>>      type Borrowed<'a> =3D ArcBorrow<'a, T>;
>>>      type BorrowedMut<'a> =3D Self::Borrowed<'a>;
>>>
>>>      fn into_foreign(self) -> *mut Self::PointedTo {
>>> -        ManuallyDrop::new(self).ptr.as_ptr()
>>> +        let this =3D ManuallyDrop::new(self).ptr.as_ptr();
>>> +        // SAFETY: `x` is a valid pointer to `Self` so the projection =
below is
>>> +        // in bounds of the allocation.
>>
>> Isn't the unsafe bit `*this`, which is what this comment should
>> justify?
>
> Yes, not sure what the origin of that name is. Good catch.

Referring to the `x` part here.


Best regards,
Andreas Hindborg




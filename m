Return-Path: <linux-kernel+bounces-537072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D042A487C4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D04188A2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D1C26BDA4;
	Thu, 27 Feb 2025 18:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaUsj17Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93C6238D31;
	Thu, 27 Feb 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680709; cv=none; b=qu90rHW9ACJ4h+iVJRUzyOBOPzvZS0KXb6I40kzQMwo6Gtgnmlno5NsU+DL9/sSEkM7LnUH4DKseQ3X4IkrHo5muhu/DWxP0J7kLf3Z2C1WQzCXUwkTJ/heZt1Dvv07EVLlFEPoenJGdNkcOs7HbRj0jmOiBrTKb0lr7yXvPxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680709; c=relaxed/simple;
	bh=70FTCzeq2DVWU4inj/e69raAv+onltp5Mp8jHyPZxbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h4mJsjyXeHKR/NIlpqaDS3bp54FsPNGggLVA6xc0Iuq8xWNnE1gwD0L2iL7cFiayYcF5DbHqIcsbtPLx+MXp0b1UNIhW1UKHCl0LZn1GmwpFZSoKwuD1l6N2PS1O3jTqj+Cq6PYk0FfVYoHDz8Y+2FvJHc96zxmnDOAZ0Hf0xHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaUsj17Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B42C4CEE4;
	Thu, 27 Feb 2025 18:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740680709;
	bh=70FTCzeq2DVWU4inj/e69raAv+onltp5Mp8jHyPZxbw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SaUsj17YQ+Z1zBTgG4tR2AvRZoO9OOMMoZz12Mq24j7+IkCOxe6T4dD9L9APWMw0N
	 0Dr7h00ZT/idoM7Jbr2tX8Qxmy3lHatmBxbnpo93uJReEU4qPRrb2ZraFKn7MW1mGU
	 KM+zyGEIPdnADwUFzksN8DUmZ5NrtnuIaM5gtGwY9R2mEpg97nbniJy9GhrVOG2LMW
	 cL+rz4c7C8Ny0tFRWv223CclMYYxHjbOTt17GUmR8ZBvnstjDaytzpJboufpUf0JZJ
	 p8auWK2BdO46i/wMUJ00PbfVKZ4sdmEojRFbLLH+vfjXdPZRF087dDCdXp9vmEgA3C
	 VjQz8jIuYRsQA==
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
In-Reply-To: <CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
 (Tamir
	Duberstein's message of "Thu, 27 Feb 2025 08:48:27 -0500")
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
	<20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org>
	<CWcBoUvs9GV44AJgOvQffgsR1G-O58dn7IrSDXfpf0iskvvi98bw3hr9qDSNfZESFWRVP_WV-1hV2pXdM5IYag==@protonmail.internalid>
	<CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 19:24:56 +0100
Message-ID: <87o6ynp7nr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Tamir Duberstein" <tamird@gmail.com> writes:

> On Thu, Feb 27, 2025 at 7:37=E2=80=AFAM Andreas Hindborg <a.hindborg@kern=
el.org> wrote:
>>
>> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
>> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
>> functionality, but allows `ArcInner` to be private. Further, it allows
>> downstream users to write code that is generic over `Box` and `Arc`, when
>> downstream users need access to `T` after calling `into_foreign`.
>>
>> Reviewed-by: Fiona Behrens <me@kloenk.dev>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>
>> This patch is a dependency for Rust `configfs` abstractions. It allows b=
oth
>> `Box` and `Arc` to be used as pointer types in the `configfs` hierarchy.
>> ---
>>  rust/kernel/sync/arc.rs | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>> index dfe4abf82c25..3d77a31e116f 100644
>> --- a/rust/kernel/sync/arc.rs
>> +++ b/rust/kernel/sync/arc.rs
>> @@ -143,7 +143,7 @@ pub struct Arc<T: ?Sized> {
>>  #[doc(hidden)]
>>  #[pin_data]
>>  #[repr(C)]
>> -pub struct ArcInner<T: ?Sized> {
>> +struct ArcInner<T: ?Sized> {
>>      refcount: Opaque<bindings::refcount_t>,
>>      data: T,
>>  }
>> @@ -345,18 +345,25 @@ pub fn into_unique_or_drop(self) -> Option<Pin<Uni=
queArc<T>>> {
>>
>>  // SAFETY: The `into_foreign` function returns a pointer that is well-a=
ligned.
>>  unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
>> -    type PointedTo =3D ArcInner<T>;
>> +    type PointedTo =3D T;
>>      type Borrowed<'a> =3D ArcBorrow<'a, T>;
>>      type BorrowedMut<'a> =3D Self::Borrowed<'a>;
>>
>>      fn into_foreign(self) -> *mut Self::PointedTo {
>> -        ManuallyDrop::new(self).ptr.as_ptr()
>> +        let this =3D ManuallyDrop::new(self).ptr.as_ptr();
>> +        // SAFETY: `x` is a valid pointer to `Self` so the projection b=
elow is
>> +        // in bounds of the allocation.
>
> Isn't the unsafe bit `*this`, which is what this comment should
> justify?

Yes, not sure what the origin of that name is. Good catch.

> In Rust 1.82+ `addr_of_mut!` isn't unsafe I believe. Also `x`
> is likely meant to be `this`.

The field projection (*this).data is still unsafe, as far as I know.

Actually the macro is not required any longer, the underlying raw
reference syntax has been stabilized. But since our minimum rust version
is 1.78, we have to keep the macro.

>
>> +        unsafe { core::ptr::addr_of_mut!((*this).data) }
>>      }
>>
>>      unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
>> +        // SAFETY: We did the reverse offset calculation in `into_forei=
gn`, so
>> +        // the offset calculation below is in bounds of the allocation.
>> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, ArcInner<=
T>, data).cast_mut() };
>> +
>>          // SAFETY: The safety requirements of this function ensure that=
 `ptr` comes from a previous
>>          // call to `Self::into_foreign`.
>> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
>> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>>
>>          // SAFETY: By the safety requirement of this function, we know =
that `ptr` came from
>>          // a previous call to `Arc::into_foreign`, which guarantees tha=
t `ptr` is valid and
>> @@ -365,9 +372,13 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) -=
> Self {
>>      }
>>
>>      unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T>=
 {
>> +        // SAFETY: We did the reverse offset calculation in `into_forei=
gn`, so
>> +        // the offset calculation below is in bounds of the allocation.
>> +        let inner_ptr =3D unsafe { kernel::container_of!(ptr, ArcInner<=
T>, data).cast_mut() };
>> +
>>          // SAFETY: The safety requirements of this function ensure that=
 `ptr` comes from a previous
>>          // call to `Self::into_foreign`.
>> -        let inner =3D unsafe { NonNull::new_unchecked(ptr) };
>> +        let inner =3D unsafe { NonNull::new_unchecked(inner_ptr) };
>>
>>          // SAFETY: The safety requirements of `from_foreign` ensure tha=
t the object remains alive
>>          // for the lifetime of the returned value.
>
> It might be good to extract a shared helper from `from_foreign` and
> `borrow`, though the duplication isn't new in this patch. Either way:

I would encourage a follow-up patch :)

>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>

Thanks!


Best regards,
Andreas Hindborg




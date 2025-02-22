Return-Path: <linux-kernel+bounces-527162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D48A407FC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B32219C1B5F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4DD20ADCF;
	Sat, 22 Feb 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWZhGPhu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888FA1FFC5A;
	Sat, 22 Feb 2025 11:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224437; cv=none; b=lzHm+3k1lycweiO6hvnORpZDuvnFCv641o08hpQ03+kfEaGVQyq9uk4xcQCh+KjgxeJVRyHGI0fdyBVnC0r+3fIb9cSQWEVE/oTR3ThFy0rfFZKoix4m4rrCcD0UizgN03iW0yPveNMODm2VaiyDIdTZzA9cnOfzbFImE/j5V+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224437; c=relaxed/simple;
	bh=3DZ40JdNPlh8KNMjFXeN2zlk13Yu3H5tsfDipn0TRFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hCen7tK4GHtVmkfDdTLWittqPEtdhhJ2XFwTnSbP/40x23AV16/Lid3qtsJ1KHv8BP2Rc+tLeZLJJ9ssibRoNUZwDy8iZ5G2dxL8Nz00QJoTMrdWYjjWBhlvu9v1LnoAPk5m9h/R3B/K6ftB/MOqRvZZUFSl8dyo3cCTUP0kZsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWZhGPhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48338C4CED1;
	Sat, 22 Feb 2025 11:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740224437;
	bh=3DZ40JdNPlh8KNMjFXeN2zlk13Yu3H5tsfDipn0TRFc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YWZhGPhuwtmrz3CqQoL1DgGt3ZVNdTe1oLWIa0A8aGr4cDOhkA/JGOzrj0joK7mDl
	 yOcVmtAk/7o7Jiqn0Ss2g9t2Fx43sh3U3WFhYmipR1E6qd9TGDydipXLnTLlwCrqmS
	 aB3FL4Sd3gP6dcFH8s6A5E0CQQppkAS8tSgyvSVqnf5oWknJbYf2MswSN1H0GMF7to
	 KGGaOPZ9h3YNh7ZJpNaweRGE8RNO5bBiYtgjGXBz3H8nWqw9VfSm8PlipaKsiV0vtl
	 N7XNyplokwqYlzKsUXwZ0PRiv+iQgC/0iBQjyQTi65XVX4bnJgVV2KCesraHkTOQS/
	 fSNfu2C1CJ+VQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: "Tamir Duberstein" <tamird@gmail.com>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
  "Frederic Weisbecker" <frederic@kernel.org>,  "Thomas Gleixner"
 <tglx@linutronix.de>,  "Danilo Krummrich" <dakr@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <87y0xycowa.fsf@kernel.org> (Andreas Hindborg's message of "Sat,
	22 Feb 2025 10:25:09 +0100")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<KDmrJnQA2_Ojf67mD8WA_UafgVCACRRleB9t-D_1yl_bua8e1VWdGQAUvmMGHscqRHu1gzPJCKe_BfotutZm5Q==@protonmail.internalid>
	<CAJ-ks9ncOyGyQsDFOBxg-7wmXkrQYiZr6H6eEFWsFstk=p1uAA@mail.gmail.com>
	<87wmdkgvr0.fsf@kernel.org>
	<djAeSx8DNZwss2-UqXGmhVPqYm2z4LhKWC70jPHPisd1w70qmpmOfVbHfhqJErhoFwVFM8IpbTv4MKkk_BIpQw==@protonmail.internalid>
	<CAJ-ks9mNidHZvWkFJE1jExc2oVk_bbJpiO_DRMrWu5nYhTpKgg@mail.gmail.com>
	<87ldtzhexi.fsf@kernel.org> <87cyfbe89x.fsf@kernel.org>
	<Z7iQcDa72XnJ5zGC@Mac.home>
	<CAJ-ks9kQccoa7znFNzWAgi6_G0TKvLUARWPZ_Dbed1C-d4Lr+Q@mail.gmail.com>
	<lP-bWmvvDdcUDicFow-u6piINSeNk1_a_BWKDDFMbFpE3Mo_5lxqfpA6v_8yYqTXNDmVZLXyz6RY3cQHhMoVrA==@protonmail.internalid>
	<Z7iZevQkYVGDoeTa@Mac.home> <87y0xycowa.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Feb 2025 12:40:23 +0100
Message-ID: <87h64mcimw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Boqun Feng" <boqun.feng@gmail.com> writes:
>
>> On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
>>> On Fri, Feb 21, 2025 at 9:40=E2=80=AFAM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
>>> >
>>> > Hmm... if you mean:
>>> >
>>> > trait HasHrTimer {
>>> >     unsafe fn start(&self, expires: Ktime) {
>>> >         ...
>>> >     }
>>> > }
>>> >
>>> > Then it'll be problematic because the pointer derived from `&self`
>>> > doesn't have write provenance, therefore in a timer callback, the
>>> > pointer cannot be used for write, which means for example you cannot
>>> > convert the pointer back into a `Pin<Box<HasTimer>>`.
>>> >
>>> > To answer Tamir's question, pointers are heavily used here because we
>>> > need to preserve the provenance.
>>>
>>> Wouldn't the natural implication be that &mut self is needed? Maybe
>>
>> For an `Arc<HasTimer>`, you cannot get `&mut self`.
>>
>>> you can help me understand why pointers can express a contract that
>>> references can't?
>>
>> I assume you already know what a pointer provenance is?
>>
>> 	http://doc.rust-lang.org/std/ptr/index.html#provenance
>>
>> Passing a pointer (including offset operation on it) preserves the
>> provenance (determined as derive time), however, deriving a pointer from
>> a reference gives the pointer a provenance based on the reference type.
>> For example, let's say we have an `Arc<i32>` and a clone:
>>
>> 	let arc =3D Arc::new(42);
>> 	let clone =3D arc.clone();
>>
>> you can obviously do a into_raw() + from_raw() pair:
>>
>> 	let ptr =3D Arc::into_raw(arc);
>> 	let arc =3D unsafe { Arc::from_raw(arc) };
>>
>> however, if you create a reference based on `Arc::into_raw()`, and then
>> derive a pointer from that, you change the provenance,
>
> In this case, the pointer will have the pointer of `Arc::into_raw()`
> will have the provenance of the original reference. When you turn that
> pointer back into a reference, won't the reference inherit the
> provenance of the pointer, which is the same as the original reference?
>
> As I read the docs, getting a reference to a `Timer` from a reference to
> a `<MyType as HasHrTimer>` by converting `&MyType` to a `*const MyType`,
> doing a `ptr.cast::<u8>().add(offset).cast::<HrTimer<T>>()` and
> converting that pointer to a reference should be fine? The final pointer
> before converting back to a reference will still have provenance of the
> original reference. Converting to a reference at the end will shrink the
> provenance, but it is still fine.
>
> Going from a `&HrTimer<T>` to a `&T` is a problem, because that would
> require offset outside spatial permission of pointer provenance, and it
> would require increasing the size of the spatial permission.
>
> Is this correctly understood?

How does provenance work across language boundaries? Should we actually
use `with_addr` [1] when we get pointers from C round trips?


Best regards,
Andreas Hindborg



[1] https://doc.rust-lang.org/stable/std/primitive.pointer.html#method.with=
_addr



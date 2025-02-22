Return-Path: <linux-kernel+bounces-527054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B41A406CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF83BE506
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE07206F09;
	Sat, 22 Feb 2025 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAKDB5vm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63C2063FC;
	Sat, 22 Feb 2025 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740216327; cv=none; b=HWdzHAcNT52K712qQF53bEuDdiMKMAbkI2bS6Chl15epFxJAwNc3agN/JS+zKaIvQjVck9yDKh8cRIhdIAwReRsyYKlSYQrRQ5w8zivKqIrY4v8j4EMSscFIFnM1cDCex3pkYya7drto8QK8pf6JlLnQVmqj+qGnx6InXxq9JMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740216327; c=relaxed/simple;
	bh=IMcz2FR9FyEmU9VdznZ5X96EJVgFB1Vgb5+TmAyVvZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CGj8jiAix/LXTe7bf+tdLwt2Z1gZn7jZFhjNYtT3X6287O7bpzVLkE+64Uaou81T4TXISFj+ZifLHCoBGJ3gDL/cJ7ICg0KdwUk7h2aletYnhhFTaLPiwDsahZ9jOSd7UsN+LHXFKIXAtcUBrkiSkO8zeQJiMZfV/V6EFtyfRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAKDB5vm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE65C4CED1;
	Sat, 22 Feb 2025 09:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740216327;
	bh=IMcz2FR9FyEmU9VdznZ5X96EJVgFB1Vgb5+TmAyVvZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NAKDB5vm9wJVend3wFBqfIvJfoE8yqbf+HYWkHmxseZtRL881gkgrz8qGktlNM0z9
	 03ojd1ZC/90sucn8uIFtLwXv6hTJfyAy73P16tChTnpvV/8uqKojNXsSIRTyaoSFJC
	 +Aw/eVxQ4yvy42sdcT27Ri8jzFdwu9s3yoAf3bJ6YNgkNMb5RKFCk1IkzzfFX+TgLC
	 /jOvSOnpibFXbVDWcybT/1sIjOEdMmF37bQ0dSOxoAb7vofhMv9JkoHlNxaDAmrqK5
	 lDzTbpOEHFb2s6+MvZ3V4jjdtRDOL4B8448GD39Eb6t1EcLznoC7JUsYKEdG6q4/E7
	 Rx4rzWc3DFiBg==
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
In-Reply-To: <Z7iZevQkYVGDoeTa@Mac.home> (Boqun Feng's message of "Fri, 21 Feb
	2025 07:19:22 -0800")
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
	<Z7iZevQkYVGDoeTa@Mac.home>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Feb 2025 10:25:09 +0100
Message-ID: <87y0xycowa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Boqun Feng" <boqun.feng@gmail.com> writes:

> On Fri, Feb 21, 2025 at 09:46:08AM -0500, Tamir Duberstein wrote:
>> On Fri, Feb 21, 2025 at 9:40=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>> >
>> > Hmm... if you mean:
>> >
>> > trait HasHrTimer {
>> >     unsafe fn start(&self, expires: Ktime) {
>> >         ...
>> >     }
>> > }
>> >
>> > Then it'll be problematic because the pointer derived from `&self`
>> > doesn't have write provenance, therefore in a timer callback, the
>> > pointer cannot be used for write, which means for example you cannot
>> > convert the pointer back into a `Pin<Box<HasTimer>>`.
>> >
>> > To answer Tamir's question, pointers are heavily used here because we
>> > need to preserve the provenance.
>>
>> Wouldn't the natural implication be that &mut self is needed? Maybe
>
> For an `Arc<HasTimer>`, you cannot get `&mut self`.
>
>> you can help me understand why pointers can express a contract that
>> references can't?
>
> I assume you already know what a pointer provenance is?
>
> 	http://doc.rust-lang.org/std/ptr/index.html#provenance
>
> Passing a pointer (including offset operation on it) preserves the
> provenance (determined as derive time), however, deriving a pointer from
> a reference gives the pointer a provenance based on the reference type.
> For example, let's say we have an `Arc<i32>` and a clone:
>
> 	let arc =3D Arc::new(42);
> 	let clone =3D arc.clone();
>
> you can obviously do a into_raw() + from_raw() pair:
>
> 	let ptr =3D Arc::into_raw(arc);
> 	let arc =3D unsafe { Arc::from_raw(arc) };
>
> however, if you create a reference based on `Arc::into_raw()`, and then
> derive a pointer from that, you change the provenance,

In this case, the pointer will have the pointer of `Arc::into_raw()`
will have the provenance of the original reference. When you turn that
pointer back into a reference, won't the reference inherit the
provenance of the pointer, which is the same as the original reference?

As I read the docs, getting a reference to a `Timer` from a reference to
a `<MyType as HasHrTimer>` by converting `&MyType` to a `*const MyType`,
doing a `ptr.cast::<u8>().add(offset).cast::<HrTimer<T>>()` and
converting that pointer to a reference should be fine? The final pointer
before converting back to a reference will still have provenance of the
original reference. Converting to a reference at the end will shrink the
provenance, but it is still fine.

Going from a `&HrTimer<T>` to a `&T` is a problem, because that would
require offset outside spatial permission of pointer provenance, and it
would require increasing the size of the spatial permission.

Is this correctly understood?

> therefore the
> below code would generate UB:
>
> 	// cannot mutably borrow because of clone.
> 	let ptr =3D unsafe { &*Arc::into_raw(arc) } as *const i32;
>
> 	let arc =3D unsafe { Arc::from_raw(ptr) };
>
>
> (playground code snippet for this example)
>
> 	https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D2021=
&gist=3D15e051db46c3886b29ed02e579562278
>
> As you already know, the whole thing about pointers/references here is
> passing the value to the callback and the callback can "reconstruct" the
> data, in such a case, reborrowing in the middle of the chain into a
> reference is not necessary, and as the above shows, it can be
> problematic.

Thanks for bringing this up, I forgot about it.


Best regards,
Andreas Hindborg




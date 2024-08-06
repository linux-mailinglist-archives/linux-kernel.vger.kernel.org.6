Return-Path: <linux-kernel+bounces-275935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8C0948C28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD95E1C222FA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD4C1BDA9B;
	Tue,  6 Aug 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fyzDO43g"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786A01607BD;
	Tue,  6 Aug 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936470; cv=none; b=Bhgy7y00tlP6lWfJAH343m8EKvbpHcT61Z2k2H0Sm1BY1u2nrvdeFj+8lMw8UzNJH4/xtSgjqQDfE1sN3bLkYKsc3Sn6JYBHqf/EQkH4i7QI0SMWf6sjqhLfL5e5JdsHEKm5DsuSqQsKYcosW1AIQtcnwxJne9KujS06+BvUbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936470; c=relaxed/simple;
	bh=7sPbgXjAAEJtXFHk0SLmRdhHDyevcomFeceOUjfG9Sg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iy7IS1a6e+HLc8Af+VyhJ3gUSKHbdX/YnX5U/sUcbA8mZnZKsW1edeNizZ5YNgl2ObrUr6t5zH5yFkQONZErcegABXXeaKatK5rNnQ5ZjHY2Yw8UUQw/sqSUQ098GTdl28IBzR2jKK8w4SVHSvoJWGNdNseEqDJnuLRoeJzbmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fyzDO43g; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722936455; x=1723195655;
	bh=QtfHhNVL/fDZI1RcLFsBz/E+dffq3r9sCPeAFCaPUwU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fyzDO43gjcKljxhbfec5pSJF3YbmImFPjpC8V3Q8HyrxfEDDHxJ7GCrTC6rY5VeBw
	 yd4l725NDJ+p3oFVij5KoFVA6/2iJMa3Mw9xRdd3+TIlJe3OfV6JJzw0Gd+DAJrJdc
	 mF0didLDoGGOwIA2fK0sMJjMBN/1sVCPrvcbmiR/0kotsbYaGvLzPyjGGjPPutbv17
	 WKXDv4iG/kd0lxTlo0xQDVwOGJ4anklspl3DvmFWr3+Kgi5AHBVmLmf4oK2ACN6BHj
	 lFHq+Tz63Jns0GmMDjt/M8uXyVUf3ON7FAaornh+2k5+hdWwpnSGy88vvHz7fBVCU6
	 BX2DcC0ZpUucg==
Date: Tue, 06 Aug 2024 09:27:29 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] rust: rbtree: add `RBTreeCursor`
Message-ID: <4a1b6a7a-9d0c-4089-bc14-0fe629a56d3e@proton.me>
In-Reply-To: <CAH5fLgjiqOcu0JVgLze76LQDUD3KTQv9WrBy-GkMbCgVWn0xzA@mail.gmail.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-5-951600ada434@google.com> <309d3d27-62d0-42b0-b50a-40692a019b40@proton.me> <CAH5fLgh30z2Cfixn1aC-LPp-ua46eJ+jREWDTfhMK3aqXzbt-A@mail.gmail.com> <4ef9616f-a35a-4aa2-993c-9b67f50a46ee@proton.me> <CAH5fLgjiqOcu0JVgLze76LQDUD3KTQv9WrBy-GkMbCgVWn0xzA@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 285a73cad60a0c1f3ea661eebb3b461d0430e2d9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 11:04, Alice Ryhl wrote:
> On Tue, Aug 6, 2024 at 11:01=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On 06.08.24 10:24, Alice Ryhl wrote:
>>> On Mon, Aug 5, 2024 at 9:35=E2=80=AFPM Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>>> On 27.07.24 22:30, Matt Gilbride wrote:
>>>>> +    tree: &'a mut RBTree<K, V>,
>>>>> +    current: NonNull<bindings::rb_node>,
>>>>> +}
>>>>> +
>>>>> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K =
and mutable references to V,
>>>>> +// so it has the same thread safety requirements as mutable referenc=
es.
>>>>> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
>>>>
>>>> Again, do we want to use `K: Sync` here instead?
>>>
>>> In this case, `K: Send` and `K: Sync` are both sufficient conditions,
>>> but `K: Send` will generally be less restrictive for the user.
>>
>> What if `K =3D struct(RefCell<i32>, i32)` where only the second i32 is
>> used in `(Partial)Ord`? Then you can send `RBTreeCursor` to another
>> thread and call `borrow` there, even though `K: !Sync` (and the value
>> still lives on another thread).
>=20
> In that scenario, all immutable references to the key would be on the
> same thread as the cursor. The cursor borrows the tree mutably, so
> there can only be one cursor.
>=20
> When using `K: Send`, it's basically like having `RBTreeCursor` store
> mutable references to the key, but with an API that downgrades to
> immutable reference when giving out access to the key.

Ah that's true.

---
Cheers,
Benno



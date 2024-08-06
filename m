Return-Path: <linux-kernel+bounces-275916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1214948BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860AF1F254BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE5D1C37A2;
	Tue,  6 Aug 2024 09:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="AD7XM46b"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971911C2339
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934880; cv=none; b=QqOV8GsbiorbfGRFeSrdqTuvez2VkoNiZFcAk1Bnf5xR5/9ItJLGU2uw7E5A9UFxeUEhopfWyCuObKRuhPN4yD/h8gDcWKzC24pf7HgY7S+Nm1inv5FCr2GM1IljLGZB5mONfJCPp5NBdIM58P/P4RAjaRcFKEp55ZnPHALxOtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934880; c=relaxed/simple;
	bh=BfSTvAOsReTnP3JlF7cLzW4CvDrU/S3xFUXcE5/iNjY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pICMuIRmxi4BUbon7PYPk4dUcEgr9e29ibITa+tUlBWzJTOG/Rh5EwJDz07xVdjq4sEJtDpxM2WpCDU47yixGndAvvaBTlshr96A0WghLr+XHmZMYmBaQeEHTC8j72gTGcsJ3FqZqeE34iUblhWx3T4Q7Puog0QgeFgDIZ6LYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=AD7XM46b; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722934876; x=1723194076;
	bh=5v/nBs+67zpAaDKhp9HPcoKGYEoQDvqTLsTti1UV37s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AD7XM46b8l2cxdYB1uV7IuHS7h1bHRSSwsqZyJxweDo0MVJrmLszCZzrjfEleBx5C
	 pkKEC5BIkhLDc2rvggyxrVwKPA5bEQcFnrg18kh6cYqR1y1kf0UkZe/DzKe3+WWqu/
	 srNuOvztCzja4YNfMKxjAmoGDyXjIQ2q9+E4kP8/pPFgGLQ/tBC15MEaf6omNqOHZI
	 kQiyX9dnW7PJL18flOfo6Pq393jvkBiUbZZq6J1A9YQMhcX/Po9xihH3fpnsIw/Kv/
	 544XxPlTs69YCfeqcZtY9YTTSb0qlBGeNrgTQjcMXVusTyon1FU31P9sEeeb8f3EXt
	 Xf3VVhTrwU4YA==
Date: Tue, 06 Aug 2024 09:01:09 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] rust: rbtree: add `RBTreeCursor`
Message-ID: <4ef9616f-a35a-4aa2-993c-9b67f50a46ee@proton.me>
In-Reply-To: <CAH5fLgh30z2Cfixn1aC-LPp-ua46eJ+jREWDTfhMK3aqXzbt-A@mail.gmail.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-5-951600ada434@google.com> <309d3d27-62d0-42b0-b50a-40692a019b40@proton.me> <CAH5fLgh30z2Cfixn1aC-LPp-ua46eJ+jREWDTfhMK3aqXzbt-A@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 7464af185247a7f47ee62a2523597dbb618e06f5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 10:24, Alice Ryhl wrote:
> On Mon, Aug 5, 2024 at 9:35=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>> On 27.07.24 22:30, Matt Gilbride wrote:
>>> +        // SAFETY: `best` is a non-null node so it is valid by the typ=
e invariants.
>>> +        let links =3D unsafe { addr_of_mut!((*best.as_ptr()).links) };
>>> +
>>> +        NonNull::new(links).map(|current| {
>>
>> Why would `links` be a null pointer? AFAIK it just came from `best`
>> which is non-null. (I don't know if we want to use `new_unchecked`
>> instead, but wanted to mention it)
>=20
> It's never a null pointer in this branch. Do you prefer an extra
> unsafe block to call new_unchecked?

No need, doesn't seem like this part is hot and this is something that
field projections could solve.

>>> +            // INVARIANT:
>>> +            // - `current` is a valid node in the [`RBTree`] pointed t=
o by `self`.
>>> +            // - Due to the type signature of this function, the retur=
ned [`RBTreeCursor`]
>>> +            //   borrows mutably from `self`.
>>> +            RBTreeCursor {
>>> +                current,
>>> +                tree: self,
>>> +            }
>>> +        })
>>> +    }
>>
>> [...]
>>
>>> +/// // Calling `remove_next` removes and returns the last element.
>>> +/// assert_eq!(cursor.remove_next().unwrap().to_key_value(), (30, 300)=
);
>>> +///
>>> +/// # Ok::<(), Error>(())
>>> +/// ```
>>
>> I would put a newline here.
>=20
> Ok.
>=20
>>> +/// # Invariants
>>> +/// - `current` points to a node that is in the same [`RBTree`] as `tr=
ee`.
>>> +pub struct RBTreeCursor<'a, K, V> {
>>
>> I think we can name it just `Cursor`, since one can refer to it as
>> `rbtree::Cursor` and then it also follows the naming scheme for `Iter`
>> etc.
>=20
> You are welcome to submit that as a follow-up change.
>=20
>>> +    tree: &'a mut RBTree<K, V>,
>>> +    current: NonNull<bindings::rb_node>,
>>> +}
>>> +
>>> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K an=
d mutable references to V,
>>> +// so it has the same thread safety requirements as mutable references=
.
>>> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}
>>
>> Again, do we want to use `K: Sync` here instead?
>=20
> In this case, `K: Send` and `K: Sync` are both sufficient conditions,
> but `K: Send` will generally be less restrictive for the user.

What if `K =3D struct(RefCell<i32>, i32)` where only the second i32 is
used in `(Partial)Ord`? Then you can send `RBTreeCursor` to another
thread and call `borrow` there, even though `K: !Sync` (and the value
still lives on another thread).

---
Cheers,
Benno



Return-Path: <linux-kernel+bounces-275933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2897F948C23
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3961C21DB2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E391BDABE;
	Tue,  6 Aug 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="UnPsvDnv"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526C4161900;
	Tue,  6 Aug 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936245; cv=none; b=Ek0sQmYX6ol8pC6KwuLdCMfkvdSBmaqEmwXo6vFKrB42QrCtXTvk2yd1QCXspqjr0XJnN03WRb4uliKvwKTuzg6s7EGZLSV0LDGNV95OXaHBu8ow/OjgHaz2JjKGSiQ5ElsbfT3f4LeOAeHJGOEcCDwRTO8d2yJF2UdbsEejzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936245; c=relaxed/simple;
	bh=6QihisEp0mn1uvvvE4Jqxxv+CSMqCfke8XvcUnoWJ+k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BH2YLH6msRAnjwOSTCIQybffYGLDtJmbKUV0x4iZO2xbgxfsdsfe/wak3CEagrKt8OLum6k4nW2dmsAFyC9XWovXZBXx+V4y7KQRh/si9UMUL5HrmsS3CVtkKl/6xdwQ06GiQY7o9GcVKfd8CxBkmR77LHfc0JzkeIwQlrTsbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=UnPsvDnv; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722936240; x=1723195440;
	bh=o80ArRjJ4S+NSkA8kokhob7C7RE9JLax11CpmI/aPAI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=UnPsvDnvhAEAhk9KdeXay7NGZvPclwwcrvF0VQeX8P6gIlj11NKXx/7APmfZMbVeA
	 XhPMm2hqgmzLZASJp4fNaeaCbonhQuOeA4U+P/gYODTJDdzg2TUX+XM8kk8ge68a5Q
	 oZ0m5ER9iXgTR8xfGo6dzUN1Og0kqSodT8qe7VsohjNeXChjf1Gz34F9QE/PkEUFTv
	 lFwSbmR3F0yznx1RNlqleEAPprKJcnKTolivRacMsSeXtgaFtW1Qo8sMsjqxmjpRzV
	 ZoLX7cG4pg2DLM1z30GRx/DkrhzDWWdfyunoJPKelhHQL90ZI6JQ0OoTWGp/dTQmV5
	 5qCmv237QtiMw==
Date: Tue, 06 Aug 2024 09:23:55 +0000
To: Alice Ryhl <aliceryhl@google.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/6] rust: rbtree: add mutable iterator
Message-ID: <2617ec4a-6413-4341-b4fe-c30c1b14432e@proton.me>
In-Reply-To: <CAH5fLghJmA_01QJvzSBX4HEfLwPr+FskM9dzOs0ykbYj_sCWTg@mail.gmail.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-4-951600ada434@google.com> <27f724ba-4f04-407b-9f5d-81a472f8ba14@proton.me> <CAH5fLghJmA_01QJvzSBX4HEfLwPr+FskM9dzOs0ykbYj_sCWTg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 03925b95f4e0101d5cdd57dfd80d4da26e3ebc5e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.24 10:30, Alice Ryhl wrote:
> On Mon, Aug 5, 2024 at 9:22=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>>
>> On 27.07.24 22:30, Matt Gilbride wrote:
>>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>>>
>>> Add mutable Iterator implementation for `RBTree`,
>>> allowing iteration over (key, value) pairs in key order. Only values ar=
e
>>> mutable, as mutating keys implies modifying a node's position in the tr=
ee.
>>>
>>> Mutable iteration is used by the binder driver during shutdown to
>>> clean up the tree maintained by the "range allocator" [1].
>>>
>>> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-=
08ba9197f637@google.com/ [1]
>>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>>> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
>>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>>> Tested-by: Alice Ryhl <aliceryhl@google.com>
>>> ---
>>>  rust/kernel/rbtree.rs | 98 +++++++++++++++++++++++++++++++++++++++++++=
+-------
>>>  1 file changed, 86 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
>>> index d10074e4ac58..d7514ebadfa8 100644
>>> --- a/rust/kernel/rbtree.rs
>>> +++ b/rust/kernel/rbtree.rs
>>> @@ -197,8 +197,26 @@ pub fn iter(&self) -> Iter<'_, K, V> {
>>>          // INVARIANT: `bindings::rb_first` returns a valid pointer to =
a tree node given a valid pointer to a tree root.
>>
>> This INVARIANT is out of place, `Iter` doesn't have any INVARIANT any
>> more.
>=20
> We can delete it.
>=20
>>>          Iter {
>>>              _tree: PhantomData,
>>> -            // SAFETY: `self.root` is a valid pointer to the tree root=
.
>>> -            next: unsafe { bindings::rb_first(&self.root) },
>>> +            iter_raw: IterRaw {
>>
>> This `IterRaw` construction is missing an INVARIANT comment. I think you
>> can copy paste from below.
>=20
> We can copy from below.
>=20
>>> +                // SAFETY: by the invariants, all pointers are valid.
>>> +                next: unsafe { bindings::rb_first(&self.root) },
>>> +                _phantom: PhantomData,
>>> +            },
>>> +        }
>>> +    }
>>> +
>>> +    /// Returns a mutable iterator over the tree nodes, sorted by key.
>>> +    pub fn iter_mut(&mut self) -> IterMut<'_, K, V> {
>>> +        IterMut {
>>> +            _tree: PhantomData,
>>> +            // INVARIANT:
>>> +            //   - `self.root` is a valid pointer to a tree root.
>>> +            //   - `bindings::rb_first` produces a valid pointer to a =
node given `root` is valid.
>>> +            iter_raw: IterRaw {
>>> +                // SAFETY: by the invariants, all pointers are valid.
>>> +                next: unsafe { bindings::rb_first(&self.root) },
>>
>> Does this really derive a mutable reference? Ie shouldn't this be:?
>>
>>     next: unsafe { bindings::rb_first(&mut self.root) },
>=20
> Let's change this to:
>=20
> next: unsafe { bindings::rb_first(ptr::from_mut(&mut self.root)) }
>=20
> This way, the pointer will be derived from a mutable reference even if
> it becomes a `*const` through intermediate operations.

SGTM

>=20
>=20
>>> +                _phantom: PhantomData,
>>> +            },
>>>          }
>>>      }
>>>
>>> @@ -211,6 +229,11 @@ pub fn keys(&self) -> impl Iterator<Item =3D &'_ K=
> {
>>>      pub fn values(&self) -> impl Iterator<Item =3D &'_ V> {
>>>          self.iter().map(|(_, v)| v)
>>>      }
>>> +
>>> +    /// Returns a mutable iterator over the values of the nodes in the=
 tree, sorted by key.
>>> +    pub fn values_mut(&mut self) -> impl Iterator<Item =3D &'_ mut V> =
{
>>> +        self.iter_mut().map(|(_, v)| v)
>>> +    }
>>>  }
>>>
>>>  impl<K, V> RBTree<K, V>
>>> @@ -414,13 +437,9 @@ fn into_iter(self) -> Self::IntoIter {
>>>  /// An iterator over the nodes of a [`RBTree`].
>>>  ///
>>>  /// Instances are created by calling [`RBTree::iter`].
>>> -///
>>> -/// # Invariants
>>> -/// - `self.next` is a valid pointer.
>>> -/// - `self.next` points to a node stored inside of a valid `RBTree`.
>>>  pub struct Iter<'a, K, V> {
>>>      _tree: PhantomData<&'a RBTree<K, V>>,
>>> -    next: *mut bindings::rb_node,
>>> +    iter_raw: IterRaw<K, V>,
>>>  }
>>>
>>>  // SAFETY: The [`Iter`] gives out immutable references to K and V, so =
it has the same
>>> @@ -434,21 +453,76 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Iter<'=
a, K, V> {}
>>>  impl<'a, K, V> Iterator for Iter<'a, K, V> {
>>>      type Item =3D (&'a K, &'a V);
>>>
>>> +    fn next(&mut self) -> Option<Self::Item> {
>>> +        self.iter_raw.next().map(|(k, v)|
>>> +            // SAFETY: Due to `self._tree`, `k` and `v` are valid for =
the lifetime of `'a`.
>>> +            unsafe { (&*k, &*v) })
>>
>> I don't really like the formatting here, can you move the SAFETY one
>> line upwards? It should format nicely then.
>=20
> You suggested exactly the reverse formatting change on RBTreeCursor?

Do you mean on this version or in a previous one? If you mean in this
one, then I would argue that they are not "reverses" of each other. For
this instance I would prefer

        // SAFETY: Due to `self._tree`, `k` and `v` are valid for the lifet=
ime of `'a`.
        self.iter_raw.next().map(|(k, v)| unsafe { (&*k, &*v) })

or

        self.iter_raw.next().map(|(k, v)| {
            // SAFETY: Due to `self._tree`, `k` and `v` are valid for the l=
ifetime of `'a`.
            unsafe { (&*k, &*v) }
        })

I hope that this seems consistent, my motivation behind the suggestions=20
are that I don't like the comment splitting the single line.

---
Cheers,
Benno



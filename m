Return-Path: <linux-kernel+bounces-275239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091EC94823B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB152846BA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0214116B388;
	Mon,  5 Aug 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="djxVG3BU"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47336364AB;
	Mon,  5 Aug 2024 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885753; cv=none; b=kKjLYey3kqgCk9MPn9R5ZJzFIsPfC8n3q6tMIv/W9AU5BvvWcd5KP6antmmwm5WyA6XQBQ5aqKWmlGxFQ0XE2q2MReSNX8NN7N7eGduEOy9DQUiQU/ioHD2UDjEOjXyiI/Omk74rSnqs+YCiCRHH08BeV1QHZISP/8pRLYTL8kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885753; c=relaxed/simple;
	bh=WoHIKQqI7dEeVySmjuIeYOtKXAI/eOZgBGvS3Kb5Bew=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kq85+iN6UTjPEkh68kHqnF8xpyD0E1F9DKGLMbz//q4V4STicgzvpIU8mT3rjUg/mKh476fROP+xoUIEEumH+iseea7x7k342ouWkyEb9yek7CnklgcqRgfT/sdnVN62T8ejLDfrihkhtgU3Pv+ESUPSNM4u1LJotzjtwmkLYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=djxVG3BU; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722885748; x=1723144948;
	bh=tG9zTHc54W7MrHg+PmjTsQxfF7AJWcvfwu19734+u4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=djxVG3BUAQiXq9fOoH2L8y38TRMx+w4gwZ3bQFjYsHH3H+k6HihHUJWex1kP0AVyW
	 jfHmFj4JKWEStqdCpMyK2LmsUuOcDw38XRY3m8epC/5//q47r/tZsOvRlmpUJGRUI8
	 HKfLHUf8PjAlJximinUuejkmZiMlaYVCwbxwFlsPYo3YzFHhWTzodU/f1Ia4WQIhNM
	 EmI9h6E8arM3wYG83de+qMn7Ybq4+U5Lz6mXabqyTIiv7ycrdq4WEfE0DgaN6vxa1v
	 71LkEo8ogiArKJ6slnF80LC30ADNRLQgxIBvsM0I/OCx1HQ5HLXPZk3Z7vcPVTps4j
	 bn/QrSrtApjmA==
Date: Mon, 05 Aug 2024 19:22:23 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/6] rust: rbtree: add mutable iterator
Message-ID: <27f724ba-4f04-407b-9f5d-81a472f8ba14@proton.me>
In-Reply-To: <20240727-b4-rbtree-v8-4-951600ada434@google.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-4-951600ada434@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: faa97aef71a75896ed3a9838451f19d039164229
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.07.24 22:30, Matt Gilbride wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>=20
> Add mutable Iterator implementation for `RBTree`,
> allowing iteration over (key, value) pairs in key order. Only values are
> mutable, as mutating keys implies modifying a node's position in the tree=
.
>=20
> Mutable iteration is used by the binder driver during shutdown to
> clean up the tree maintained by the "range allocator" [1].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08=
ba9197f637@google.com/ [1]
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/rbtree.rs | 98 ++++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 86 insertions(+), 12 deletions(-)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index d10074e4ac58..d7514ebadfa8 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -197,8 +197,26 @@ pub fn iter(&self) -> Iter<'_, K, V> {
>          // INVARIANT: `bindings::rb_first` returns a valid pointer to a =
tree node given a valid pointer to a tree root.

This INVARIANT is out of place, `Iter` doesn't have any INVARIANT any
more.

>          Iter {
>              _tree: PhantomData,
> -            // SAFETY: `self.root` is a valid pointer to the tree root.
> -            next: unsafe { bindings::rb_first(&self.root) },
> +            iter_raw: IterRaw {

This `IterRaw` construction is missing an INVARIANT comment. I think you
can copy paste from below.

> +                // SAFETY: by the invariants, all pointers are valid.
> +                next: unsafe { bindings::rb_first(&self.root) },
> +                _phantom: PhantomData,
> +            },
> +        }
> +    }
> +
> +    /// Returns a mutable iterator over the tree nodes, sorted by key.
> +    pub fn iter_mut(&mut self) -> IterMut<'_, K, V> {
> +        IterMut {
> +            _tree: PhantomData,
> +            // INVARIANT:
> +            //   - `self.root` is a valid pointer to a tree root.
> +            //   - `bindings::rb_first` produces a valid pointer to a no=
de given `root` is valid.
> +            iter_raw: IterRaw {
> +                // SAFETY: by the invariants, all pointers are valid.
> +                next: unsafe { bindings::rb_first(&self.root) },

Does this really derive a mutable reference? Ie shouldn't this be:?

    next: unsafe { bindings::rb_first(&mut self.root) },

> +                _phantom: PhantomData,
> +            },
>          }
>      }
>=20
> @@ -211,6 +229,11 @@ pub fn keys(&self) -> impl Iterator<Item =3D &'_ K> =
{
>      pub fn values(&self) -> impl Iterator<Item =3D &'_ V> {
>          self.iter().map(|(_, v)| v)
>      }
> +
> +    /// Returns a mutable iterator over the values of the nodes in the t=
ree, sorted by key.
> +    pub fn values_mut(&mut self) -> impl Iterator<Item =3D &'_ mut V> {
> +        self.iter_mut().map(|(_, v)| v)
> +    }
>  }
>=20
>  impl<K, V> RBTree<K, V>
> @@ -414,13 +437,9 @@ fn into_iter(self) -> Self::IntoIter {
>  /// An iterator over the nodes of a [`RBTree`].
>  ///
>  /// Instances are created by calling [`RBTree::iter`].
> -///
> -/// # Invariants
> -/// - `self.next` is a valid pointer.
> -/// - `self.next` points to a node stored inside of a valid `RBTree`.
>  pub struct Iter<'a, K, V> {
>      _tree: PhantomData<&'a RBTree<K, V>>,
> -    next: *mut bindings::rb_node,
> +    iter_raw: IterRaw<K, V>,
>  }
>=20
>  // SAFETY: The [`Iter`] gives out immutable references to K and V, so it=
 has the same
> @@ -434,21 +453,76 @@ unsafe impl<'a, K: Sync, V: Sync> Sync for Iter<'a,=
 K, V> {}
>  impl<'a, K, V> Iterator for Iter<'a, K, V> {
>      type Item =3D (&'a K, &'a V);
>=20
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.iter_raw.next().map(|(k, v)|
> +            // SAFETY: Due to `self._tree`, `k` and `v` are valid for th=
e lifetime of `'a`.
> +            unsafe { (&*k, &*v) })

I don't really like the formatting here, can you move the SAFETY one
line upwards? It should format nicely then.

> +    }
> +}
> +
> +impl<'a, K, V> IntoIterator for &'a mut RBTree<K, V> {
> +    type Item =3D (&'a K, &'a mut V);
> +    type IntoIter =3D IterMut<'a, K, V>;
> +
> +    fn into_iter(self) -> Self::IntoIter {
> +        self.iter_mut()
> +    }
> +}
> +
> +/// A mutable iterator over the nodes of a [`RBTree`].
> +///
> +/// Instances are created by calling [`RBTree::iter_mut`].
> +pub struct IterMut<'a, K, V> {
> +    _tree: PhantomData<&'a mut RBTree<K, V>>,
> +    iter_raw: IterRaw<K, V>,
> +}
> +
> +// SAFETY: The [`IterMut`] gives out immutable references to K and mutab=
le references to V, so it has the same
> +// thread safety requirements as mutable references.
> +unsafe impl<'a, K: Send, V: Send> Send for IterMut<'a, K, V> {}

Since we only borrow `K` immutably, would it make sense to have `K:
Sync`?

---
Cheers,
Benno

> +
> +// SAFETY: The [`IterMut`] gives out immutable references to K and mutab=
le references to V, so it has the same
> +// thread safety requirements as mutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for IterMut<'a, K, V> {}
> +
> +impl<'a, K, V> Iterator for IterMut<'a, K, V> {
> +    type Item =3D (&'a K, &'a mut V);
> +
> +    fn next(&mut self) -> Option<Self::Item> {
> +        self.iter_raw.next().map(|(k, v)|
> +            // SAFETY: Due to `&mut self`, we have exclusive access to `=
k` and `v`, for the lifetime of `'a`.
> +            unsafe { (&*k, &mut *v) })
> +    }
> +}
> +
> +/// A raw iterator over the nodes of a [`RBTree`].
> +///
> +/// # Invariants
> +/// - `self.next` is a valid pointer.
> +/// - `self.next` points to a node stored inside of a valid `RBTree`.
> +struct IterRaw<K, V> {
> +    next: *mut bindings::rb_node,
> +    _phantom: PhantomData<fn() -> (K, V)>,
> +}
> +
> +impl<K, V> Iterator for IterRaw<K, V> {
> +    type Item =3D (*mut K, *mut V);
> +
>      fn next(&mut self) -> Option<Self::Item> {
>          if self.next.is_null() {
>              return None;
>          }
>=20
> -        // SAFETY: By the type invariant of `Iter`, `self.next` is a val=
id node in an `RBTree`,
> +        // SAFETY: By the type invariant of `IterRaw`, `self.next` is a =
valid node in an `RBTree`,
>          // and by the type invariant of `RBTree`, all nodes point to the=
 links field of `Node<K, V>` objects.
> -        let cur =3D unsafe { container_of!(self.next, Node<K, V>, links)=
 };
> +        let cur: *mut Node<K, V> =3D
> +            unsafe { container_of!(self.next, Node<K, V>, links) }.cast_=
mut();
>=20
>          // SAFETY: `self.next` is a valid tree node by the type invarian=
ts.
>          self.next =3D unsafe { bindings::rb_next(self.next) };
>=20
> -        // SAFETY: By the same reasoning above, it is safe to dereferenc=
e the node. Additionally,
> -        // it is ok to return a reference to members because the iterato=
r must outlive it.
> -        Some(unsafe { (&(*cur).key, &(*cur).value) })
> +        // SAFETY: By the same reasoning above, it is safe to dereferenc=
e the node.
> +        Some(unsafe { (addr_of_mut!((*cur).key), addr_of_mut!((*cur).val=
ue)) })
>      }
>  }
>=20
>=20
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>=20



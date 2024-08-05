Return-Path: <linux-kernel+bounces-275222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FC6948208
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5761F22A49
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F9C16A943;
	Mon,  5 Aug 2024 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aDF7vEEY"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9C1537D4
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 19:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884565; cv=none; b=Og7NGucb0uNA5HOVE3pZHnxSBnmySjvuoE+b3GVPrSP4UBgYvjpINhnKQSCBKjcDUCttQ1O2VPaTGyHkIdCt8QW91hNwzHdIMDDKi5o84Q3/M3Zg7R5vBPbIBBay+A9D2bAYSfHwKGFpbaXmznWbbN+VcJE9j4WoH4PpyK0zUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884565; c=relaxed/simple;
	bh=B9YP0SmlZmrl709lb0+tiYfGHYkYU+mdsIyn8q4+xxc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I9U1ttwWTPegKo1x1P3NgIxLlVWcmAj0WuwDEyEawxqLHaF6UBxZzXob+DFPy234EhnEz7eVv8b8YFpEuuW4OUl7pbB3CfAWCgmEP0FfFLtznA9/EoS1QYK/G767zK6W7QY0Um4gUShGZJwn/INoa3xeONfXGeiSdBDyxHPZVw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aDF7vEEY; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722884555; x=1723143755;
	bh=jb6ms6xd9vhXotlchGtOcFeNqtU4VEY61hgvRpRUbqA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aDF7vEEY2Gmo9e2GyoEwT2v8jxIBncldQYMSy9u7ukb6sqTZeYUdlAoK5j/Le/eaR
	 +VGl2sFY1vOAQcd4IHM1o2MC1T9l/k1ynQiRO2Iz3YSNCWX0AVFAFT6qqGibPeMYRm
	 JHYf9f/HNU56oCw6U1s4ycREZ8zWTML2IBDEx51lo171XYBWbnlTDvJz9Cn08/so/5
	 2mHHM9EtbQA1obB3ec+NfmpLAceNR1NmuxKNfW/aLK8VINeDWHSYm6D8sjWIXJEI3/
	 uaUFcxxbFRZ8l0NlBxYHghC8v71EYGC8ePXQDdShKPuhoT+U1YvZtoen/0QTpBqOM6
	 o0vf5ufP3DM8w==
Date: Mon, 05 Aug 2024 19:02:28 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/6] rust: rbtree: add red-black tree implementation backed by the C version
Message-ID: <242d0107-8e2b-4856-8f4c-1d5351fdaad8@proton.me>
In-Reply-To: <20240727-b4-rbtree-v8-2-951600ada434@google.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-2-951600ada434@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 97f1e6a14d126e5e30454a54fb1b44ce92ec5ec1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.07.24 22:30, Matt Gilbride wrote:
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> new file mode 100644
> index 000000000000..74c53e4d5c00
> --- /dev/null
> +++ b/rust/kernel/rbtree.rs
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Red-black trees.
> +//!
> +//! C header: [`include/linux/rbtree.h`](srctree/include/linux/rbtree.h)
> +//!
> +//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree.h=
tml>
> +
> +use crate::{alloc::Flags, bindings, container_of, error::Result, prelude=
::*};
> +use alloc::boxed::Box;
> +use core::{
> +    cmp::{Ord, Ordering},
> +    marker::PhantomData,
> +    mem::MaybeUninit,
> +    ptr::{addr_of_mut, NonNull},
> +};
> +
> +/// A red-black tree with owned nodes.
> +///
> +/// It is backed by the kernel C red-black trees.
> +///
> +/// # Invariants
> +///
> +/// Non-null parent/children pointers stored in instances of the `rb_nod=
e` C struct are always
> +/// valid, and pointing to a field of our internal representation of a n=
ode.

I think we should standardize that `Invariants` and `Safety` sections
are put last. This is because people reading the HTML version are
probably not interested in the inner workings. This also makes it
possible to have the invariants and the struct definition on the same
screen.

> +///
> +/// # Examples

[...]

> +/// ```
> +pub struct RBTree<K, V> {
> +    root: bindings::rb_root,

It has been a while, so I might have already asked this, but do we need
`Opaque` here? We would need it, if C changes anything inside `root`
while Rust holds a `&RBTree` or `&mut RBTree`.
I don't think that this is the case (ie we don't need `Opaque`), but I
am not sure.

> +    _p: PhantomData<Node<K, V>>,
> +}
> +

[...]

> +    /// Inserts a new node into the tree.
> +    ///
> +    /// It overwrites a node if one already exists with the same key and=
 returns it (containing the
> +    /// key/value pair). Returns [`None`] if a node with the same key di=
dn't already exist.
> +    ///
> +    /// This function always succeeds.
> +    pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> O=
ption<RBTreeNode<K, V>> {
> +        let node =3D Box::into_raw(node);
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +
> +        // The parameters of `rb_link_node` are as follows:

Can you write `bindings::rb_link_node`?

> +        // - `node`: A pointer to an uninitialized node being inserted.
> +        // - `parent`: A pointer to an existing node in the tree. One of=
 its child pointers must be
> +        //          null, and `node` will become a child of `parent` by =
replacing that child pointer
> +        //          with a pointer to `node`.
> +        // - `rb_link`: A pointer to either the left-child or right-chil=
d field of `parent`. This
> +        //          specifies which child of `parent` should hold `node`=
 after this call. The
> +        //          value of `*rb_link` must be null before the call to =
`rb_link_node`. If the
> +        //          red/black tree is empty, then it=E2=80=99s also poss=
ible for `parent` to be null. In
> +        //          this case, `rb_link` is a pointer to the `root` fiel=
d of the red/black tree.
> +        //
> +        // We will traverse the tree looking for a node that has a null =
pointer as its child,
> +        // representing an empty subtree where we can insert our new nod=
e. We need to make sure
> +        // that we preserve the ordering of the nodes in the tree. In ea=
ch iteration of the loop
> +        // we store `parent` and `child_field_of_parent`, and the new `n=
ode` will go somewhere
> +        // in the subtree of `parent` that `child_field_of_parent` point=
s at. Once
> +        // we find an empty subtree, we can insert the new node using `r=
b_link_node`.
> +        let mut parent =3D core::ptr::null_mut();
> +        let mut child_field_of_parent: &mut *mut bindings::rb_node =3D &=
mut self.root.rb_node;
> +        while !child_field_of_parent.is_null() {
> +            parent =3D *child_field_of_parent;
> +
> +            // We need to determine whether `node` should be the left or=
 right child of `parent`,
> +            // so we will compare with the `key` field of `parent` a.k.a=
. `this` below.
> +            //
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb=
_node` pointers stored in `self`
> +            // point to the links field of `Node<K, V>` objects.
> +            let this =3D unsafe { container_of!(parent, Node<K, V>, link=
s) };
> +
> +            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants. `node` is
> +            // valid until the node is removed.
> +            match unsafe { (*node).key.cmp(&(*this).key) } {
> +                // We would like `node` to be the left child of `parent`=
.  Move to this child to check
> +                // whether we can use it, or continue searching, at the =
next iteration.
> +                //
> +                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> +                Ordering::Less =3D> child_field_of_parent =3D unsafe { &=
mut (*parent).rb_left },
> +                // We would like `node` to be the right child of `parent=
`.  Move to this child to check
> +                // whether we can use it, or continue searching, at the =
next iteration.
> +                //
> +                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> +                Ordering::Greater =3D> child_field_of_parent =3D unsafe =
{ &mut (*parent).rb_right },
> +                Ordering::Equal =3D> {
> +                    // There is an existing node in the tree with this k=
ey, and that node is
> +                    // parent.  Thus, we are replacing parent with a new=
 node.

Missing `` around "parent", double space after '.'.

> +                    //
> +                    // INVARIANT: We are replacing an existing node with=
 a new one, which is valid.
> +                    // It remains valid because we "forgot" it with `Box=
::into_raw`.
> +                    // SAFETY: All pointers are non-null and valid.
> +                    unsafe { bindings::rb_replace_node(parent, node_link=
s, &mut self.root) };
> +
> +                    // INVARIANT: The node is being returned and the cal=
ler may free it, however,
> +                    // it was removed from the tree. So the invariants s=
till hold.
> +                    return Some(RBTreeNode {
> +                        // SAFETY: `this` was a node in the tree, so it =
is valid.
> +                        node: unsafe { Box::from_raw(this.cast_mut()) },
> +                    });
> +                }
> +            }
> +        }

[...]

> +struct Node<K, V> {
> +    links: bindings::rb_node,

Same question as with `rb_root`, do we need `Opaque`?


Otherwise the patch looks good.

---
Cheers,
Benno

> +    key: K,
> +    value: V,
> +}
>=20
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>=20



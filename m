Return-Path: <linux-kernel+bounces-293488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D30195806C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04125285646
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15202189BBD;
	Tue, 20 Aug 2024 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cgjYCCFL"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB718E37D
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140852; cv=none; b=szq4Eem9/Dm6iVxYI5i1N+EeMUbsGrMU6KmnCMDnlpI/TDK7JL5PJp9sSJzCJk5YUiRjp8mOuntiteuz1OaslupQ4WoojsqhCXZOBBBC4u2g8y8565rDcoKxOxFknUpwI1d3sqnn/62xpcE1Qg0IsDO7kNr8KNhFRyYfhYufD8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140852; c=relaxed/simple;
	bh=45CFavrRmiUgCOWn+8UMYgAijihqGsrwh20+k90AbDA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qe26yn4km/E+vkZGz8IKNuSoiVbzGQC4QT8dxftMJf159D2EXP12vRwJJRxsKrKJXbUKr7UK9UaSUE2L41FeK6rahwc7fc5KoeW30pChTy1+1DxkpC7XecbKQNptk22aOkPQwFjEBweToYDp2ImMYOvh9GKeBfvLPqdO/a4Ch30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cgjYCCFL; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724140846; x=1724400046;
	bh=gpTaEjzTAA8CTwwnN5T9GMAFa4M+/VTyRF4u+7qUIK0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=cgjYCCFLSkN2sMkbB0qQLPpUF9aUptT1A6c8tA1xgirRU+I0Xvv61x5uvfCKRHG2D
	 cNjEHiYrOjQ8ZH5NWpCSuqu2/0zmpYlEnwx1DSFH2IAxGlB8yOQCboRvUBb8DsCYz8
	 d8+9AZhCA52vEgdPfiwhSkBCSgs8dWJAl8AB6F2MjQ2ikU931Xzvz4UKXol+MHKlbL
	 kllZ9NuEGrWpR5VoIm/XRNLehjuwC6HEd2Fgg4oEq3vbKFYP/wjob/XB3hPrAfcbH+
	 AikhAJCA4kjjJVSkM2/r3UwSLJDiSEuRys8ClAz7ftmg5l1Wm7FR6cxM10mkY9+X6y
	 DJRGUiivell+Q==
Date: Tue, 20 Aug 2024 08:00:40 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 4/5] rust: rbtree: add cursor
Message-ID: <9ac0aeb3-0f27-4345-8faf-4aeb22f451c5@proton.me>
In-Reply-To: <20240819-b4-rbtree-v10-4-3b3b2c4d73af@google.com>
References: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com> <20240819-b4-rbtree-v10-4-3b3b2c4d73af@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 1b40b9369f1722951cfd4a82e33e563c69e89e35
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.08.24 17:07, Matt Gilbride wrote:
> Add a cursor interface to `RBTree`, supporting the following use cases:
> - Inspect the current node pointed to by the cursor, inspect/move to
>   it's neighbors in sort order (bidirectionally).
> - Mutate the tree itself by removing the current node pointed to by the
>   cursor, or one of its neighbors.
>=20
> Add functions to obtain a cursor to the tree by key:
> - The node with the smallest key
> - The node with the largest key
> - The node matching the given key, or the one with the next larger key
>=20
> The cursor abstraction is needed by the binder driver to efficiently
> search for nodes and (conditionally) modify them, as well as their
> neighbors [1].
>=20
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-6-08=
ba9197f637@google.com/ [1]
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
>  rust/kernel/rbtree.rs | 541 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 541 insertions(+)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 6c9a8f0a00e6..754af0db86b5 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -236,6 +236,40 @@ pub fn values(&self) -> impl Iterator<Item =3D &'_ V=
> {
>      pub fn values_mut(&mut self) -> impl Iterator<Item =3D &'_ mut V> {
>          self.iter_mut().map(|(_, v)| v)
>      }
> +
> +    /// Returns a cursor over the tree nodes, starting with the smallest=
 key.
> +    pub fn cursor_front(&mut self) -> Option<Cursor<'_, K, V>> {
> +        let root =3D addr_of_mut!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_first(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self`.
> +            // - Due to the type signature of this function, the returne=
d [`Cursor`]
> +            //   borrows mutably from `self`.

This second invariant doesn't exist on `Cursor`, probably some stale
comment.

> +            Cursor {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }
> +
> +    /// Returns a cursor over the tree nodes, starting with the largest =
key.
> +    pub fn cursor_back(&mut self) -> Option<Cursor<'_, K, V>> {
> +        let root =3D addr_of_mut!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_last(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self`.
> +            // - Due to the type signature of this function, the returne=
d [`Cursor`]
> +            //   borrows mutably from `self`.

Ditto.

> +            Cursor {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }
>  }
>=20
>  impl<K, V> RBTree<K, V>
> @@ -396,6 +430,75 @@ fn remove_node(&mut self, key: &K) -> Option<RBTreeN=
ode<K, V>> {
>      pub fn remove(&mut self, key: &K) -> Option<V> {
>          self.remove_node(key).map(|node| node.node.value)
>      }
> +
> +    /// Returns a cursor over the tree nodes based on the given key.
> +    ///
> +    /// If the given key exists, the cursor starts there.
> +    /// Otherwise it starts with the first larger key in sort order.
> +    /// If there is no larger key, it returns [`None`].
> +    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<Cursor<'_, K=
, V>>
> +    where
> +        K: Ord,
> +    {
> +        let mut node =3D self.root.rb_node;
> +        let mut best_match: Option<NonNull<Node<K, V>>> =3D None;
> +        while !node.is_null() {
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb=
_node` pointers stored in `self`
> +            // point to the links field of `Node<K, V>` objects.
> +            let this =3D unsafe { container_of!(node, Node<K, V>, links)=
 }.cast_mut();
> +            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants.
> +            let this_key =3D unsafe { &(*this).key };
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            let left_child =3D unsafe { (*node).rb_left };
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            let right_child =3D unsafe { (*node).rb_right };
> +            if key =3D=3D this_key {
> +                return NonNull::new(node).map(|current| {
> +                    // INVARIANT:
> +                    // - `node` is a valid node in the [`RBTree`] pointe=
d to by `self`.
> +                    // - Due to the type signature of this function, the=
 returned [`Cursor`]
> +                    //   borrows mutably from `self`.

Here again the stale invariant.

> +                    Cursor {
> +                        current,
> +                        tree: self,
> +                    }
> +                });

You could do this instead of returning here:

    best_match =3D NonNull::new(this);
    break;

Then we don't have two places constructing a `Cursor` and can avoid
having to duplicate the `INVARIANT` comment.

> +            } else {
> +                node =3D if key > this_key {

I don't know how much this cares about performance, but you can avoid
having to do two comparisons by doing `match key.cmp(this_key)`. Maybe
the compiler is already doing that optimization though.

> +                    right_child
> +                } else {
> +                    let is_better_match =3D match best_match {
> +                        None =3D> true,
> +                        Some(best) =3D> {
> +                            // SAFETY: `best` is a non-null node so it i=
s valid by the type invariants.
> +                            let best_key =3D unsafe { &(*best.as_ptr()).=
key };
> +                            best_key > this_key
> +                        }
> +                    };
> +                    if is_better_match {
> +                        best_match =3D NonNull::new(this);
> +                    }
> +                    left_child
> +                };
> +            }
> +        }
> +
> +        let best =3D best_match?;
> +
> +        // SAFETY: `best` is a non-null node so it is valid by the type =
invariants.
> +        let links =3D unsafe { addr_of_mut!((*best.as_ptr()).links) };
> +
> +        NonNull::new(links).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self`.
> +            // - Due to the type signature of this function, the returne=
d [`Cursor`]
> +            //   borrows mutably from `self`.

Stale invariant (more instances below).

---
Cheers,
Benno

> +            Cursor {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }
>  }
>=20
>  impl<K, V> Default for RBTree<K, V> {



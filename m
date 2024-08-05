Return-Path: <linux-kernel+bounces-275250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D90D994825C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F651F2432F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE516BE00;
	Mon,  5 Aug 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Ssqz4Nbw"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CBB15D5D9;
	Mon,  5 Aug 2024 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722886517; cv=none; b=SaFBnnrn0TWgS1bt9QO7ZNTGedx/xDQe3i6ZgFMmHAQlL45nP0cyrUl2Z3o/Eo/Du4PGdaSm2mjkOKfbS7DJLdnt9BkIplf5QhY5TekL7F5Hx579flmndWd+1WSr4RVAXj2X5LXNxQ/FKnfMe/GtSFI/Iu7BMX7tgBof4lMv75Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722886517; c=relaxed/simple;
	bh=1oYTmApsWUMCoyhJNbSotw8Y6T9AY6jJ9lxiJIB5S2A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNz90YA8XbzYlzKD10IAsAMHhyeUDxknWGNkGcSirq+FuZXES13nxMJ3oXz0YFcfmedvS9gkFpKDhEMDOyLzNPnFzkd0b3zCnog7Cu12zLm38QZbXj+h3O6zuzs/7oZqdf2I7SmJDU2XcBvDssnKzZp7kqZxIYQBchrxIXUmwEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Ssqz4Nbw; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722886511; x=1723145711;
	bh=AVZzERX1hqRhV0NyTpv0qSgyKK+DMrk9GDymwb+Al7A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ssqz4NbwpILp0T8n5LAMAUkFFul4AfWUYdA0OGvFqCVDynBK5SKV5f04SwoC+vaf7
	 TSYdeOwM8kBGRLZ8g8SbuLO3BkR9BYcgOU0Ds2eTsdP1NLBsMfWdrklRQ0O+3WNaE0
	 tyNdFvnGdd+xcUJn+OpfpBw9P/1FOkB+kM+6LVW5ZoYGVE00DFByBIXCSO0bMMUZkx
	 8HxD+6wZmSxPPHNyMDTbnKiz2jtoeCFZo5bJxljPfQEJf7+Kie9CnDV3ekC2Nl6aBM
	 nLxW5n0PqcC4Nf4+5uITsOJ5JbRJZ8iHBmlXCHQajpWpzze25S+2QbYo4HgeR08fYF
	 0tbj/ePLq8iaQ==
Date: Mon, 05 Aug 2024 19:35:05 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 5/6] rust: rbtree: add `RBTreeCursor`
Message-ID: <309d3d27-62d0-42b0-b50a-40692a019b40@proton.me>
In-Reply-To: <20240727-b4-rbtree-v8-5-951600ada434@google.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-5-951600ada434@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3054514ec3b7af3eb17af2ecb4e374423f282aef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.07.24 22:30, Matt Gilbride wrote:
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
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
>  rust/kernel/rbtree.rs | 536 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 536 insertions(+)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index d7514ebadfa8..5d37aa373685 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -234,6 +234,40 @@ pub fn values(&self) -> impl Iterator<Item =3D &'_ V=
> {
>      pub fn values_mut(&mut self) -> impl Iterator<Item =3D &'_ mut V> {
>          self.iter_mut().map(|(_, v)| v)
>      }
> +
> +    /// Returns a cursor over the tree nodes, starting with the smallest=
 key.
> +    pub fn cursor_front(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
> +        let root =3D addr_of_mut!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_first(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self`.
> +            // - Due to the type signature of this function, the returne=
d [`RBTreeCursor`]
> +            //   borrows mutably from `self`.
> +            RBTreeCursor {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }
> +
> +    /// Returns a cursor over the tree nodes, starting with the largest =
key.
> +    pub fn cursor_back(&mut self) -> Option<RBTreeCursor<'_, K, V>> {
> +        let root =3D addr_of_mut!(self.root);
> +        // SAFETY: `self.root` is always a valid root node
> +        let current =3D unsafe { bindings::rb_last(root) };
> +        NonNull::new(current).map(|current| {
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self`.
> +            // - Due to the type signature of this function, the returne=
d [`RBTreeCursor`]
> +            //   borrows mutably from `self`.
> +            RBTreeCursor {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }
>  }
>=20
>  impl<K, V> RBTree<K, V>
> @@ -394,6 +428,75 @@ fn remove_node(&mut self, key: &K) -> Option<RBTreeN=
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
> +    pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor=
<'_, K, V>>
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
 returned [`RBTreeCursor`]
> +                    //   borrows mutably from `self`.
> +                    RBTreeCursor {
> +                        current,
> +                        tree: self,
> +                    }
> +                });
> +            } else {
> +                node =3D if key > this_key {
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

Why would `links` be a null pointer? AFAIK it just came from `best`
which is non-null. (I don't know if we want to use `new_unchecked`
instead, but wanted to mention it)

> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self`.
> +            // - Due to the type signature of this function, the returne=
d [`RBTreeCursor`]
> +            //   borrows mutably from `self`.
> +            RBTreeCursor {
> +                current,
> +                tree: self,
> +            }
> +        })
> +    }

[...]

> +/// // Calling `remove_next` removes and returns the last element.
> +/// assert_eq!(cursor.remove_next().unwrap().to_key_value(), (30, 300));
> +///
> +/// # Ok::<(), Error>(())
> +/// ```

I would put a newline here.

> +/// # Invariants
> +/// - `current` points to a node that is in the same [`RBTree`] as `tree=
`.
> +pub struct RBTreeCursor<'a, K, V> {

I think we can name it just `Cursor`, since one can refer to it as
`rbtree::Cursor` and then it also follows the naming scheme for `Iter`
etc.

> +    tree: &'a mut RBTree<K, V>,
> +    current: NonNull<bindings::rb_node>,
> +}
> +
> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K and =
mutable references to V,
> +// so it has the same thread safety requirements as mutable references.
> +unsafe impl<'a, K: Send, V: Send> Send for RBTreeCursor<'a, K, V> {}

Again, do we want to use `K: Sync` here instead?

> +
> +// SAFETY: The [`RBTreeCursor`] gives out immutable references to K and =
mutable references to V,
> +// so it has the same thread safety requirements as mutable references.
> +unsafe impl<'a, K: Sync, V: Sync> Sync for RBTreeCursor<'a, K, V> {}
> +
> +impl<'a, K, V> RBTreeCursor<'a, K, V> {
> +    /// The current node
> +    pub fn current(&self) -> (&K, &V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an immutable reference by the function signature.
> +        unsafe { Self::to_key_value(self.current) }
> +    }
> +
> +    /// The current node, with a mutable value
> +    pub fn current_mut(&mut self) -> (&K, &mut V) {
> +        // SAFETY:
> +        // - `self.current` is a valid node by the type invariants.
> +        // - We have an mutable reference by the function signature.
> +        unsafe { Self::to_key_value_mut(self.current) }
> +    }
> +
> +    /// Remove the current node from the tree.
> +    ///
> +    /// Returns a tuple where the first element is a cursor to the next =
node, if it exists,
> +    /// else the previous node, else [`None`] (if the tree becomes empty=
). The second element
> +    /// is the removed node.
> +    pub fn remove_current(self) -> (Option<Self>, RBTreeNode<K, V>) {
> +        let prev =3D self.get_neighbor_raw(Direction::Prev);
> +        let next =3D self.get_neighbor_raw(Direction::Next);
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this =3D unsafe { container_of!(self.current.as_ptr(), Node<=
K, V>, links) }.cast_mut();
> +        // SAFETY: `this` is valid by the type invariants as described a=
bove.
> +        let node =3D unsafe { Box::from_raw(this) };
> +        let node =3D RBTreeNode { node };
> +        // SAFETY: The reference to the tree used to create the cursor o=
utlives the cursor, so
> +        // the tree cannot change. By the tree invariant, all nodes are =
valid.
> +        unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(sel=
f.tree.root)) };
> +
> +        let current =3D match (prev, next) {
> +            (_, Some(next)) =3D> next,
> +            (Some(prev), None) =3D> prev,
> +            (None, None) =3D> {
> +                return (None, node);
> +            }
> +        };
> +
> +        (
> +            // INVARIANT:
> +            // - `current` is a valid node in the [`RBTree`] pointed to =
by `self.tree`.
> +            // - Due to the function signature, `self` is an owned [`RBT=
reeCursor`],
> +            //   and [`RBTreeCursor`]s are only created via functions wi=
th a mutable reference
> +            //   to an [`RBTree`].
> +            Some(Self {
> +                current,
> +                tree: self.tree,
> +            }),
> +            node,
> +        )
> +    }
> +
> +    /// Remove the previous node, returning it if it exists.
> +    pub fn remove_prev(&mut self) -> Option<RBTreeNode<K, V>> {
> +        self.remove_neighbor(Direction::Prev)
> +    }
> +
> +    /// Remove the next node, returning it if it exists.
> +    pub fn remove_next(&mut self) -> Option<RBTreeNode<K, V>> {
> +        self.remove_neighbor(Direction::Next)
> +    }
> +
> +    fn remove_neighbor(&mut self, direction: Direction) -> Option<RBTree=
Node<K, V>> {
> +        if let Some(neighbor) =3D self.get_neighbor_raw(direction) {
> +            let neighbor =3D neighbor.as_ptr();
> +            // SAFETY: The reference to the tree used to create the curs=
or outlives the cursor, so
> +            // the tree cannot change. By the tree invariant, all nodes =
are valid.
> +            unsafe { bindings::rb_erase(neighbor, addr_of_mut!(self.tree=
.root)) };
> +            // SAFETY: By the type invariant of `Self`, all non-null `rb=
_node` pointers stored in `self`
> +            // point to the links field of `Node<K, V>` objects.
> +            let this =3D unsafe { container_of!(neighbor, Node<K, V>, li=
nks) }.cast_mut();
> +            // SAFETY: `this` is valid by the type invariants as describ=
ed above.
> +            let node =3D unsafe { Box::from_raw(this) };
> +            return Some(RBTreeNode { node });
> +        }
> +        None
> +    }
> +
> +    /// Move the cursor to the previous node, returning [`None`] if it d=
oesn't exist.
> +    pub fn move_prev(self) -> Option<Self> {
> +        self.mv(Direction::Prev)
> +    }
> +
> +    /// Move the cursor to the next node, returning [`None`] if it doesn=
't exist.
> +    pub fn move_next(self) -> Option<Self> {
> +        self.mv(Direction::Next)
> +    }
> +
> +    fn mv(self, direction: Direction) -> Option<Self> {
> +        // INVARIANT:
> +        // - `neighbor` is a valid node in the [`RBTree`] pointed to by =
`self.tree`.
> +        // - Due to the function signature, `self` is an owned [`RBTreeC=
ursor`],
> +        //   and [`RBTreeCursor`]s are only created via functions with a=
 mutable reference
> +        //   to an [`RBTree`].
> +        self.get_neighbor_raw(direction).map(|neighbor| Self {
> +            tree: self.tree,
> +            current: neighbor,
> +        })
> +    }
> +
> +    /// Access the previous node without moving the cursor.
> +    pub fn peek_prev(&self) -> Option<(&K, &V)> {
> +        self.peek(Direction::Prev)
> +    }
> +
> +    /// Access the previous node without moving the cursor.
> +    pub fn peek_next(&self) -> Option<(&K, &V)> {
> +        self.peek(Direction::Next)
> +    }
> +
> +    fn peek(&self, direction: Direction) -> Option<(&K, &V)> {
> +        self.get_neighbor_raw(direction)
> +            // SAFETY:
> +            // - `neighbor` is a valid tree node.
> +            // - By the function signature, we have an immutable referen=
ce to `self`.
> +            .map(|neighbor| unsafe { Self::to_key_value(neighbor) })

Alternative way of formatting this:

        self.get_neighbor_raw(direction).map(|neighbor| {
            // SAFETY:
            // - `neighbor` is a valid tree node.
            // - By the function signature, we have an immutable reference =
to `self`.
            unsafe { Self::to_key_value(neighbor) }
        })

I think it looks nicer, but we should probably have a written
preference.

> +    }
> +
> +    /// Access the previous node mutably without moving the cursor.
> +    pub fn peek_prev_mut(&mut self) -> Option<(&K, &mut V)> {
> +        self.peek_mut(Direction::Prev)
> +    }
> +
> +    /// Access the next node mutably without moving the cursor.
> +    pub fn peek_next_mut(&mut self) -> Option<(&K, &mut V)> {
> +        self.peek_mut(Direction::Next)
> +    }
> +
> +    fn peek_mut(&mut self, direction: Direction) -> Option<(&K, &mut V)>=
 {
> +        self.get_neighbor_raw(direction)
> +            // SAFETY:
> +            // - `neighbor` is a valid tree node.
> +            // - By the function signature, we have a mutable reference =
to `self`.
> +            .map(|neighbor| unsafe { Self::to_key_value_mut(neighbor) })

Ditto.

---
Cheers,
Benno

> +    }
> +
> +    fn get_neighbor_raw(&self, direction: Direction) -> Option<NonNull<b=
indings::rb_node>> {
> +        // SAFETY: `self.current` is valid by the type invariants.
> +        let neighbor =3D unsafe {
> +            match direction {
> +                Direction::Prev =3D> bindings::rb_prev(self.current.as_p=
tr()),
> +                Direction::Next =3D> bindings::rb_next(self.current.as_p=
tr()),
> +            }
> +        };
> +
> +        NonNull::new(neighbor)
> +    }
> +
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to `node` for the duration of =
'b.
> +    unsafe fn to_key_value<'b>(node: NonNull<bindings::rb_node>) -> (&'b=
 K, &'b V) {
> +        // SAFETY: the caller guarantees that `node` is a valid pointer =
in an `RBTree`.
> +        let (k, v) =3D unsafe { Self::to_key_value_raw(node) };
> +        // SAFETY: the caller guarantees immutable access to `node`.
> +        (k, unsafe { &*v })
> +    }
> +
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has mutable access to `node` for the duration of 'b=
.
> +    unsafe fn to_key_value_mut<'b>(node: NonNull<bindings::rb_node>) -> =
(&'b K, &'b mut V) {
> +        // SAFETY: the caller guarantees that `node` is a valid pointer =
in an `RBTree`.
> +        let (k, v) =3D unsafe { Self::to_key_value_raw(node) };
> +        // SAFETY: the caller guarantees mutable access to `node`.
> +        (k, unsafe { &mut *v })
> +    }
> +
> +    /// SAFETY:
> +    /// - `node` must be a valid pointer to a node in an [`RBTree`].
> +    /// - The caller has immutable access to the key for the duration of=
 'b.
> +    unsafe fn to_key_value_raw<'b>(node: NonNull<bindings::rb_node>) -> =
(&'b K, *mut V) {
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_nod=
e` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this =3D unsafe { container_of!(node.as_ptr(), Node<K, V>, l=
inks) }.cast_mut();
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let k =3D unsafe { &(*this).key };
> +        // SAFETY: The passed `node` is the current node or a non-null n=
eighbor,
> +        // thus `this` is valid by the type invariants.
> +        let v =3D unsafe { addr_of_mut!((*this).value) };
> +        (k, v)
> +    }
> +}
> +
> +/// Direction for [`RBTreeCursor`] operations.
> +enum Direction {
> +    /// the node immediately before, in sort order
> +    Prev,
> +    /// the node immediately after, in sort order
> +    Next,
> +}
> +
>  impl<'a, K, V> IntoIterator for &'a RBTree<K, V> {
>      type Item =3D (&'a K, &'a V);
>      type IntoIter =3D Iter<'a, K, V>;
> @@ -583,6 +1114,11 @@ impl<K, V> RBTreeNode<K, V> {
>      pub fn new(key: K, value: V, flags: Flags) -> Result<RBTreeNode<K, V=
>> {
>          Ok(RBTreeNodeReservation::new(flags)?.into_node(key, value))
>      }
> +
> +    /// Get the key and value from inside the node.
> +    pub fn to_key_value(self) -> (K, V) {
> +        (self.node.key, self.node.value)
> +    }
>  }
>=20
>  // SAFETY: If K and V can be sent across threads, then it's also okay to=
 send [`RBTreeNode`] across
>=20
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>=20



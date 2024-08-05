Return-Path: <linux-kernel+bounces-275289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2000F9482CC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 22:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92F911F22131
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 20:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460E116BE06;
	Mon,  5 Aug 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VmiqxcDq"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84FE1DFF7;
	Mon,  5 Aug 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888192; cv=none; b=T6vunqB2RTKbpgGVCnWOKvOvAY52HwGtNbvrQVi+8RNxsWCaJDlTNy+bxYKEF5W0CvQZ/cEkzi3vbrt7WOUsvddU0sG0qpRWE5iwfd8IcpDdNjx0HaWKcnaXWALMVD0bege5VkvjC1uliDmUjUKk9/Ch6xOfLVY9tYKmop78g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888192; c=relaxed/simple;
	bh=5tFdp3ft7H3f+MK8zWHkeM9P13HgKQqEeMxBAsgyCGc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHCgKLxviL/trhu8Oavwi/EY7AjGfbIKOdedV5pjRspvpyMrW2g6v+rruRgDISHRdFiSKe9HcHz0XxR59vPtfZUvYp//C2hDo1UprxTlI9f07h7nszIX6jMTeR4d2eA2+oGsIQpoBDtKdEV4Am1vEwiZEtJtLZVb+U/7DJFDeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VmiqxcDq; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1722888187; x=1723147387;
	bh=Mx1iV7m9zmN2bzCNB5dxHVCrzFzdUTXtk1t2sNrOrUc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=VmiqxcDqImRJoKO9BvPfSwgj7Ec45UL5nOPgOkgCD5AsYfIxcEqkFUHa70wV3iJd7
	 LFmKta/tB/kKt+Q9Xlt2O2DqgWjzmzbUWpCHztxGN5fDz9v+/NtUovCPhrR1T9R75/
	 A8yvczoEPRx/9CuJDIbxElabWbNNwKnI+wgBQbnaBxpja0M/G8tn2fJE625b6gx9Zx
	 mEIsLuMdN630QUFKAYNbaa1MSfY6Wz1X82V11aVJsloRqc06wRafkbFcNEX05rMxb7
	 m30mhgnAW+/H9wATqMaThSX01neWuvoqDyHzDox7H7FpRJU9vp40tEQKuHNZP4hYk9
	 8ZgrB2KVPZF7A==
Date: Mon, 05 Aug 2024 20:02:57 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/6] rust: rbtree: add `RBTree::entry`
Message-ID: <cabdde17-5191-4ce6-8cf3-7e7e929e5671@proton.me>
In-Reply-To: <20240727-b4-rbtree-v8-6-951600ada434@google.com>
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com> <20240727-b4-rbtree-v8-6-951600ada434@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 82189986bc081e96c60bfbd91cc2664227030a0d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.07.24 22:30, Matt Gilbride wrote:
> From: Alice Ryhl <aliceryhl@google.com>
>=20
> This mirrors the entry API [1] from the Rust standard library on
> `RBTree`. This API can be used to access the entry at a specific key and
> make modifications depending on whether the key is vacant or occupied.
> This API is useful because it can often be used to avoid traversing the
> tree multiple times.
>=20
> This is used by binder to look up and conditionally access or insert a
> value, depending on whether it is there or not [2].
>=20
> Link: https://doc.rust-lang.org/stable/std/collections/btree_map/enum.Ent=
ry.html [1]
> Link: https://android-review.googlesource.com/c/kernel/common/+/2849906 [=
2]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> ---
>  rust/kernel/rbtree.rs | 302 +++++++++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 227 insertions(+), 75 deletions(-)
>=20
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 5d37aa373685..428f8be8f3a2 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -295,12 +295,19 @@ pub fn try_create_and_insert(
>      /// key/value pair). Returns [`None`] if a node with the same key di=
dn't already exist.
>      ///
>      /// This function always succeeds.
> -    pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) -> O=
ption<RBTreeNode<K, V>> {
> -        let node =3D Box::into_raw(node);
> -        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> -        // the node is removed or replaced.
> -        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +    pub fn insert(&mut self, node: RBTreeNode<K, V>) -> Option<RBTreeNod=
e<K, V>> {
> +        match self.raw_entry(&node.node.key) {
> +            RawEntry::Occupied(entry) =3D> Some(entry.replace(node)),
> +            RawEntry::Vacant(entry) =3D> {
> +                entry.insert(node);
> +                None
> +            }
> +        }
> +    }
>=20
> +    fn raw_entry(&mut self, key: &K) -> RawEntry<'_, K, V> {
> +        let raw_self: *mut RBTree<K, V> =3D self;
> +        // The returned `RawEntry` is used to call either `rb_link_node`=
 or `rb_replace_node`.
>          // The parameters of `rb_link_node` are as follows:
>          // - `node`: A pointer to an uninitialized node being inserted.
>          // - `parent`: A pointer to an existing node in the tree. One of=
 its child pointers must be
> @@ -319,62 +326,56 @@ pub fn insert(&mut self, RBTreeNode { node }: RBTre=
eNode<K, V>) -> Option<RBTree
>          // in the subtree of `parent` that `child_field_of_parent` point=
s at. Once
>          // we find an empty subtree, we can insert the new node using `r=
b_link_node`.
>          let mut parent =3D core::ptr::null_mut();
> -        let mut child_field_of_parent: &mut *mut bindings::rb_node =3D &=
mut self.root.rb_node;
> -        while !child_field_of_parent.is_null() {
> -            parent =3D *child_field_of_parent;
> +        let mut child_field_of_parent: &mut *mut bindings::rb_node =3D
> +            // SAFETY: `raw_self` is a valid pointer to the `RBTree` (cr=
eated from `self` above).
> +            unsafe { &mut (*raw_self).root.rb_node };
> +        while !(*child_field_of_parent).is_null() {

Why do you manually dereference `child_field_of_parent` here?

> +            let curr =3D *child_field_of_parent;
> +            // SAFETY: All links fields we create are in a `Node<K, V>`.

I think the SAFETY comment from below that argues via the type invariant
of `Self` is better.

> +            let node =3D unsafe { container_of!(curr, Node<K, V>, links)=
 };
>=20
> -            // We need to determine whether `node` should be the left or=
 right child of `parent`,
> -            // so we will compare with the `key` field of `parent` a.k.a=
. `this` below.
> -            //
> -            // SAFETY: By the type invariant of `Self`, all non-null `rb=
_node` pointers stored in `self`
> -            // point to the links field of `Node<K, V>` objects.
> -            let this =3D unsafe { container_of!(parent, Node<K, V>, link=
s) };
> -
> -            // SAFETY: `this` is a non-null node so it is valid by the t=
ype invariants. `node` is
> -            // valid until the node is removed.
> -            match unsafe { (*node).key.cmp(&(*this).key) } {
> -                // We would like `node` to be the left child of `parent`=
.  Move to this child to check
> -                // whether we can use it, or continue searching, at the =
next iteration.
> -                //
> -                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> -                Ordering::Less =3D> child_field_of_parent =3D unsafe { &=
mut (*parent).rb_left },
> -                // We would like `node` to be the right child of `parent=
`.  Move to this child to check
> -                // whether we can use it, or continue searching, at the =
next iteration.
> -                //
> -                // SAFETY: `parent` is a non-null node so it is valid by=
 the type invariants.
> -                Ordering::Greater =3D> child_field_of_parent =3D unsafe =
{ &mut (*parent).rb_right },
> +            // SAFETY: `node` is a non-null node so it is valid by the t=
ype invariants.
> +            match key.cmp(unsafe { &(*node).key }) {
> +                // SAFETY: `curr` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Less =3D> child_field_of_parent =3D unsafe { &=
mut (*curr).rb_left },
> +                // SAFETY: `curr` is a non-null node so it is valid by t=
he type invariants.
> +                Ordering::Greater =3D> child_field_of_parent =3D unsafe =
{ &mut (*curr).rb_right },
>                  Ordering::Equal =3D> {
> -                    // There is an existing node in the tree with this k=
ey, and that node is
> -                    // parent.  Thus, we are replacing parent with a new=
 node.
> -                    //
> -                    // INVARIANT: We are replacing an existing node with=
 a new one, which is valid.
> -                    // It remains valid because we "forgot" it with `Box=
::into_raw`.
> -                    // SAFETY: All pointers are non-null and valid.
> -                    unsafe { bindings::rb_replace_node(parent, node_link=
s, &mut self.root) };
> -
> -                    // INVARIANT: The node is being returned and the cal=
ler may free it, however,
> -                    // it was removed from the tree. So the invariants s=
till hold.
> -                    return Some(RBTreeNode {
> -                        // SAFETY: `this` was a node in the tree, so it =
is valid.
> -                        node: unsafe { Box::from_raw(this.cast_mut()) },
> -                    });
> +                    return RawEntry::Occupied(OccupiedEntry {
> +                        rbtree: self,
> +                        node_links: curr,
> +                    })
>                  }
>              }
> +            parent =3D curr;
>          }
>=20
> -        // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> -        // "forgot" it with `Box::into_raw`.
> -        // SAFETY: All pointers are non-null and valid (`*child_field_of=
_parent` is null, but `child_field_of_parent` is a
> -        // mutable reference).
> -        unsafe { bindings::rb_link_node(node_links, parent, child_field_=
of_parent) };
> +        RawEntry::Vacant(RawVacantEntry {

RawVacantEntry has Invariants, so missing INVARIANT comment.

> +            rbtree: raw_self,
> +            parent,
> +            child_field_of_parent,
> +            _phantom: PhantomData,
> +        })
> +    }

[...]

> +/// A view into a vacant entry in a [`RBTree`]. It is part of the [`Entr=
y`] enum.
> +pub struct VacantEntry<'a, K, V> {
> +    key: K,
> +    raw: RawVacantEntry<'a, K, V>,
> +}
> +
> +/// Like [`VacantEntry`], but doesn't hold on to the key.a

Typo: trailing 'a'.

> +///
> +/// # Invariants
> +/// - `parent` may be null if the new node becomes the root.
> +/// - `child_field_of_parent` is a valid pointer to the left-child or ri=
ght-child of `parent`. If `parent` is
> +///     null, it is a pointer to the root of the [`RBTree`].
> +struct RawVacantEntry<'a, K, V> {
> +    rbtree: *mut RBTree<K, V>,
> +    /// The node that will become the parent of the new node if we inser=
t one.
> +    parent: *mut bindings::rb_node,
> +    /// This points to the left-child or right-child field of `parent`, =
or `root` if `parent` is
> +    /// null.
> +    child_field_of_parent: *mut *mut bindings::rb_node,
> +    _phantom: PhantomData<&'a mut RBTree<K, V>>,
> +}
> +
> +impl<'a, K, V> RawVacantEntry<'a, K, V> {
> +    /// Inserts the given node into the [`RBTree`] at this entry.
> +    ///
> +    /// The `node` must have a key such that inserting it here does not =
break the ordering of this
> +    /// [`RBTree`].
> +    fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
> +        let node =3D Box::into_raw(node.node);
> +
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> +
> +        // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> +        // "forgot" it with `Box::into_raw`.
> +        // SAFETY: The type invariants of `RawVacantEntry` are exactly t=
he safety requirements of `rb_link_node`.
> +        unsafe { bindings::rb_link_node(node_links, self.parent, self.ch=
ild_field_of_parent) };
> +
> +        // SAFETY: All pointers are valid. `node` has just been inserted=
 into the tree.
> +        unsafe { bindings::rb_insert_color(node_links, addr_of_mut!((*se=
lf.rbtree).root)) };
> +
> +        // SAFETY: The node is valid until we remove it from the tree.
> +        unsafe { &mut (*node).value }
> +    }
> +}
> +
> +impl<'a, K, V> VacantEntry<'a, K, V> {
> +    /// Inserts the given node into the [`RBTree`] at this entry.
> +    pub fn insert(self, value: V, reservation: RBTreeNodeReservation<K, =
V>) -> &'a mut V {
> +        self.raw.insert(reservation.into_node(self.key, value))
> +    }
> +}
> +
> +/// A view into an occupied entry in a [`RBTree`]. It is part of the [`E=
ntry`] enum.
> +///
> +/// # Invariants
> +/// - `node_links` is a valid, non-null pointer to a tree node in `self.=
rbtree`
> +pub struct OccupiedEntry<'a, K, V> {
> +    rbtree: &'a mut RBTree<K, V>,
> +    /// The node that this entry corresponds to.
> +    node_links: *mut bindings::rb_node,
> +}
> +
> +impl<'a, K, V> OccupiedEntry<'a, K, V> {
> +    fn node_ptr(&self) -> *mut Node<K, V> {
> +        // SAFETY: By the type invariant of `Self`, all `node_links` poi=
nters stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        unsafe { container_of!(self.node_links, Node<K, V>, links) }.cas=
t_mut()

You should not call `cast_mut` here, see below

> +    }
> +
> +    /// Gets a reference to the value in the entry.
> +    pub fn get(&self) -> &V {
> +        // SAFETY: `self.node_ptr` produces a valid pointer to a node in=
 the tree.

Can you add a `# Guarantees` section to `node_ptr` that states exactly
this?

> +        unsafe { &(*self.node_ptr()).value }
> +    }
> +
> +    /// Gets a mutable reference to the value in the entry.
> +    pub fn get_mut(&mut self) -> &mut V {
> +        // SAFETY: `self.node_ptr` produces a valid pointer to a node in=
 the tree.
> +        unsafe { &mut (*self.node_ptr()).value }

This is sadly UB, you are creating a `&mut` reference from a pointer
that was derived from a `&` reference:
- `node_ptr` takes `&self`, thus it converts the `&mut self` to that.
- `container_of!` inside of `node_ptr` is used to create a read-only
  pointer to the `links` field (it is casted to `*mut`, but that doesn't
  change the fact that you are only allowed to use it for reads)
- `get_mut` turns it again into a `&mut` reference.

One solution is to make `note_ptr` take a `*mut Self`/`*const Self`.

> +    }
> +
> +    /// Converts the entry into a mutable reference to its value.
> +    ///
> +    /// If you need multiple references to the `OccupiedEntry`, see [`se=
lf#get_mut`].
> +    pub fn into_mut(self) -> &'a mut V {
> +        // SAFETY: `self.node_ptr` produces a valid pointer to a node in=
 the tree.
> +        unsafe { &mut (*self.node_ptr()).value }
> +    }
> +
> +    /// Remove this entry from the [`RBTree`].
> +    pub fn remove_node(self) -> RBTreeNode<K, V> {
> +        // SAFETY: The node is a node in the tree, so it is valid.
> +        unsafe { bindings::rb_erase(self.node_links, &mut self.rbtree.ro=
ot) };
> +
> +        // INVARIANT: The node is being returned and the caller may free=
 it, however, it was
> +        // removed from the tree. So the invariants still hold.
> +        RBTreeNode {
> +            // SAFETY: The node was a node in the tree, but we removed i=
t, so we can convert it
> +            // back into a box.
> +            node: unsafe { Box::from_raw(self.node_ptr()) },
> +        }
> +    }
> +
> +    /// Takes the value of the entry out of the map, and returns it.
> +    pub fn remove(self) -> V {
> +        self.remove_node().node.value
> +    }
> +
> +    /// Swap the current node for the provided node.
> +    ///
> +    /// The key of both nodes must be equal.

Is this a safety requirement? Ie if it is violated, can memory bugs
occur, or is it only going to lead to logic bugs?

---
Cheers,
Benno

> +    fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
> +        let node =3D Box::into_raw(node.node);
> +
> +        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // the node is removed or replaced.
> +        let new_node_links =3D unsafe { addr_of_mut!((*node).links) };
> +
> +        // SAFETY: This updates the pointers so that `new_node_links` is=
 in the tree where
> +        // `self.node_links` used to be.
> +        unsafe {
> +            bindings::rb_replace_node(self.node_links, new_node_links, &=
mut self.rbtree.root)
> +        };
> +
> +        // SAFETY:
> +        // - `self.node_ptr` produces a valid pointer to a node in the t=
ree.
> +        // - Now that we removed this entry from the tree, we can conver=
t the node to a box.
> +        let old_node =3D unsafe { Box::from_raw(self.node_ptr()) };
> +
> +        RBTreeNode { node: old_node }
> +    }
> +}
> +
>  struct Node<K, V> {
>      links: bindings::rb_node,
>      key: K,
>=20
> --
> 2.46.0.rc1.232.g9752f9e123-goog
>=20



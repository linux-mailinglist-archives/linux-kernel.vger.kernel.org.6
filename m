Return-Path: <linux-kernel+bounces-275885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7F948B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FA5B2441A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3C81BD01F;
	Tue,  6 Aug 2024 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JxyI/wmJ"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125A16BE0A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933705; cv=none; b=t42lTqaCF43yvFeh4UuxvQRUyGFajqIuSA1Yq3urKJEFZSWMjsxopd75vLypFCt9wkzkXEdSZ+h+1Mw8gAkYBsGJQkNR+68M0+gN2bfU5eTSpxBrpq8hOIuDYdxgD00qClq75q/aF+dGtlvQLhxgj5lf7ow+dXCPwju18z22FF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933705; c=relaxed/simple;
	bh=1BCUKF/NxrY736k6d8X1R566Qy/yqnnxSXUzi+kgVfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWwfiaAbrmSqHtTTqw6RtS08mOaxpguOO5xp2p2VuvcZCfpqFqU6Nv7EBQ0plsCAk3vbz4ltM5br1S9bBavgdrWiJedN9aQR5ioKLMSpVV73oNRa/ZLPRC6r7B32if6UqV3JgnZzIYWg8ZJYEPWctn7y4ZsZzWmOCqHSlnWp4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JxyI/wmJ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428178fc07eso2315385e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 01:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722933701; x=1723538501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbPnQdD6jscSpbjXvc3gDQS1zyX0rqfw1Ssl5ILmXtk=;
        b=JxyI/wmJ1t2rn8dDITkVezkiqnpZDInSXUuN3qzHFbrlOZjapE8gDam40goWcBnad8
         Vo/KXDOVLY50kIn/YcACqm1dh/qNE461/+7cFdq+W73cpmPQmK40A8qqR2gWbG7iCJj8
         xZXrjxuXWQRmUZVLiXljHQrvtDq6k3kBZzTqkxC0ychkDJ1Vv6mERrjJ55+BoBgr06lr
         dn1TuO+n+QQor+hu7U/NTrnq+YD9V8Lg5Sl2HqxcXPhK4iI9VL3/HvtYeAFFcDklSHM4
         tR4ijS8yyh6K+ewR2Zy3gCFri3htN+LB1w+TpDxLE+zl85cuOPDN1j+p/uasATv64emI
         oDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722933701; x=1723538501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbPnQdD6jscSpbjXvc3gDQS1zyX0rqfw1Ssl5ILmXtk=;
        b=E/VOaqpDpcWmq8eHUEkW/5jm2Mz+p1Vq+m6eB+hsYYYXdt9eNTeRMjpaEKDk1G6SsM
         6lkgWVOoLt8h5fW7ABc36AGSenWS1x2Exy6tzUypE6fYb5em4k8dxFDTLkpOTrHoGMDL
         m6IWbNQBO7u/MTBaOws/a0Yy3IC1hl5KfA/3btyiHD27tmLamqPf0sr6E/Le2ArJ7aw1
         FpXScbeIlFWJ7crc6QBu/YMfaivqDEulrNXoT2HxXXGEtCbR5ZUY0jH4UBAf5XHswe6r
         2g70esOiQHPdcvaDQq2F2ISigW98d7gVQY6G0Gickiwjhpq9Fo2hYxE+CFtAtaQL77HC
         2aIg==
X-Forwarded-Encrypted: i=1; AJvYcCWVu2OcCxpLhE03lV8M95sL+Ur5MUZrpwSBZbLQ4DedejKV4tjD3G28MkO17lQGuzG+PP7aqTAZQMYxOdxydiuUMt0Ey6BE1ZU5FuWs
X-Gm-Message-State: AOJu0YzfAWFS1HPzpFXb1iCKYV0RgNMq7UqC/Qaef8n2WhkzGM4m/9s/
	Lo7lcNu/WNSnUHluO1kbUQfJG3sUUaBpdMHchiVkYTBz+XN0UIetLsgPzsQNyADN/LtbSgw5+dn
	ChNMFy0TOdY2N8Z6+RI5U1Xs+rz3mZx+Y5fL/
X-Google-Smtp-Source: AGHT+IF9RsntfHl2jP/BOOW/JZ89fvt4refZJ+i46F1lV8Wf+hRDNEFRNfqmAO1qVDqpAm2gZ/OH/uhWs6oIvLZmi5Y=
X-Received: by 2002:a05:600c:1c83:b0:426:64a2:5362 with SMTP id
 5b1f17b1804b1-428e6af4bbemr109205455e9.8.1722933701179; Tue, 06 Aug 2024
 01:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727-b4-rbtree-v8-0-951600ada434@google.com>
 <20240727-b4-rbtree-v8-2-951600ada434@google.com> <242d0107-8e2b-4856-8f4c-1d5351fdaad8@proton.me>
In-Reply-To: <242d0107-8e2b-4856-8f4c-1d5351fdaad8@proton.me>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 6 Aug 2024 10:41:29 +0200
Message-ID: <CAH5fLgjHzYJAeZBA7JjK0_dw_m_XL+gU9x6M4Jv0tRzAH40+Pg@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] rust: rbtree: add red-black tree implementation
 backed by the C version
To: Benno Lossin <benno.lossin@proton.me>
Cc: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>, Rob Landley <rob@landley.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 9:02=E2=80=AFPM Benno Lossin <benno.lossin@proton.me=
> wrote:
>
> On 27.07.24 22:30, Matt Gilbride wrote:
> > diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> > new file mode 100644
> > index 000000000000..74c53e4d5c00
> > --- /dev/null
> > +++ b/rust/kernel/rbtree.rs
> > @@ -0,0 +1,432 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Red-black trees.
> > +//!
> > +//! C header: [`include/linux/rbtree.h`](srctree/include/linux/rbtree.=
h)
> > +//!
> > +//! Reference: <https://www.kernel.org/doc/html/latest/core-api/rbtree=
.html>
> > +
> > +use crate::{alloc::Flags, bindings, container_of, error::Result, prelu=
de::*};
> > +use alloc::boxed::Box;
> > +use core::{
> > +    cmp::{Ord, Ordering},
> > +    marker::PhantomData,
> > +    mem::MaybeUninit,
> > +    ptr::{addr_of_mut, NonNull},
> > +};
> > +
> > +/// A red-black tree with owned nodes.
> > +///
> > +/// It is backed by the kernel C red-black trees.
> > +///
> > +/// # Invariants
> > +///
> > +/// Non-null parent/children pointers stored in instances of the `rb_n=
ode` C struct are always
> > +/// valid, and pointing to a field of our internal representation of a=
 node.
>
> I think we should standardize that `Invariants` and `Safety` sections
> are put last. This is because people reading the HTML version are
> probably not interested in the inner workings. This also makes it
> possible to have the invariants and the struct definition on the same
> screen.

We can reorder.

> > +/// ```
> > +pub struct RBTree<K, V> {
> > +    root: bindings::rb_root,
>
> It has been a while, so I might have already asked this, but do we need
> `Opaque` here? We would need it, if C changes anything inside `root`
> while Rust holds a `&RBTree` or `&mut RBTree`.
> I don't think that this is the case (ie we don't need `Opaque`), but I
> am not sure.

It's not needed.

> > +    _p: PhantomData<Node<K, V>>,
> > +}
> > +
>
> [...]
>
> > +    /// Inserts a new node into the tree.
> > +    ///
> > +    /// It overwrites a node if one already exists with the same key a=
nd returns it (containing the
> > +    /// key/value pair). Returns [`None`] if a node with the same key =
didn't already exist.
> > +    ///
> > +    /// This function always succeeds.
> > +    pub fn insert(&mut self, RBTreeNode { node }: RBTreeNode<K, V>) ->=
 Option<RBTreeNode<K, V>> {
> > +        let node =3D Box::into_raw(node);
> > +        // SAFETY: `node` is valid at least until we call `Box::from_r=
aw`, which only happens when
> > +        // the node is removed or replaced.
> > +        let node_links =3D unsafe { addr_of_mut!((*node).links) };
> > +
> > +        // The parameters of `rb_link_node` are as follows:
>
> Can you write `bindings::rb_link_node`?

Ok.

> > +        // - `node`: A pointer to an uninitialized node being inserted=
.
> > +        // - `parent`: A pointer to an existing node in the tree. One =
of its child pointers must be
> > +        //          null, and `node` will become a child of `parent` b=
y replacing that child pointer
> > +        //          with a pointer to `node`.
> > +        // - `rb_link`: A pointer to either the left-child or right-ch=
ild field of `parent`. This
> > +        //          specifies which child of `parent` should hold `nod=
e` after this call. The
> > +        //          value of `*rb_link` must be null before the call t=
o `rb_link_node`. If the
> > +        //          red/black tree is empty, then it=E2=80=99s also po=
ssible for `parent` to be null. In
> > +        //          this case, `rb_link` is a pointer to the `root` fi=
eld of the red/black tree.
> > +        //
> > +        // We will traverse the tree looking for a node that has a nul=
l pointer as its child,
> > +        // representing an empty subtree where we can insert our new n=
ode. We need to make sure
> > +        // that we preserve the ordering of the nodes in the tree. In =
each iteration of the loop
> > +        // we store `parent` and `child_field_of_parent`, and the new =
`node` will go somewhere
> > +        // in the subtree of `parent` that `child_field_of_parent` poi=
nts at. Once
> > +        // we find an empty subtree, we can insert the new node using =
`rb_link_node`.
> > +        let mut parent =3D core::ptr::null_mut();
> > +        let mut child_field_of_parent: &mut *mut bindings::rb_node =3D=
 &mut self.root.rb_node;
> > +        while !child_field_of_parent.is_null() {
> > +            parent =3D *child_field_of_parent;
> > +
> > +            // We need to determine whether `node` should be the left =
or right child of `parent`,
> > +            // so we will compare with the `key` field of `parent` a.k=
.a. `this` below.
> > +            //
> > +            // SAFETY: By the type invariant of `Self`, all non-null `=
rb_node` pointers stored in `self`
> > +            // point to the links field of `Node<K, V>` objects.
> > +            let this =3D unsafe { container_of!(parent, Node<K, V>, li=
nks) };
> > +
> > +            // SAFETY: `this` is a non-null node so it is valid by the=
 type invariants. `node` is
> > +            // valid until the node is removed.
> > +            match unsafe { (*node).key.cmp(&(*this).key) } {
> > +                // We would like `node` to be the left child of `paren=
t`.  Move to this child to check
> > +                // whether we can use it, or continue searching, at th=
e next iteration.
> > +                //
> > +                // SAFETY: `parent` is a non-null node so it is valid =
by the type invariants.
> > +                Ordering::Less =3D> child_field_of_parent =3D unsafe {=
 &mut (*parent).rb_left },
> > +                // We would like `node` to be the right child of `pare=
nt`.  Move to this child to check
> > +                // whether we can use it, or continue searching, at th=
e next iteration.
> > +                //
> > +                // SAFETY: `parent` is a non-null node so it is valid =
by the type invariants.
> > +                Ordering::Greater =3D> child_field_of_parent =3D unsaf=
e { &mut (*parent).rb_right },
> > +                Ordering::Equal =3D> {
> > +                    // There is an existing node in the tree with this=
 key, and that node is
> > +                    // parent.  Thus, we are replacing parent with a n=
ew node.
>
> Missing `` around "parent", double space after '.'.

Ok.

> > +                    //
> > +                    // INVARIANT: We are replacing an existing node wi=
th a new one, which is valid.
> > +                    // It remains valid because we "forgot" it with `B=
ox::into_raw`.
> > +                    // SAFETY: All pointers are non-null and valid.
> > +                    unsafe { bindings::rb_replace_node(parent, node_li=
nks, &mut self.root) };
> > +
> > +                    // INVARIANT: The node is being returned and the c=
aller may free it, however,
> > +                    // it was removed from the tree. So the invariants=
 still hold.
> > +                    return Some(RBTreeNode {
> > +                        // SAFETY: `this` was a node in the tree, so i=
t is valid.
> > +                        node: unsafe { Box::from_raw(this.cast_mut()) =
},
> > +                    });
> > +                }
> > +            }
> > +        }
>
> [...]
>
> > +struct Node<K, V> {
> > +    links: bindings::rb_node,
>
> Same question as with `rb_root`, do we need `Opaque`?

No.

> Otherwise the patch looks good.

Will you give a Reviewed-by conditional on the above changes?

Alice


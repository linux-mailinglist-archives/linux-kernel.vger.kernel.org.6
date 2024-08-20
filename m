Return-Path: <linux-kernel+bounces-293500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1995958090
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B0D1B211CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D939718E345;
	Tue, 20 Aug 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ETXQDx+F"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9991898FD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141311; cv=none; b=kq5jOb5REBzl9KRn9U7y5+86/Eb1yYxavv/2pQwH3Chtq/rtK9PvKcyBNY9RG5x4UrrUMetboZhNIFhqzO279yOhp6tKs5+AMBwzOFJrmvmlyQhZ9r25JJwcu/VSLlwFwov4CSWtWjyegaTSn4YWkys4fMxNu4r68pOuewDPl1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141311; c=relaxed/simple;
	bh=pd90YgBG4tBg17cPOjEFD3caGTY+9mJ92uswnxk6IkE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQ+uMdS1YELIkLNYUIfxIu7JvO4WqXkvhiF8tIpUWcMnfY6PrTeXoL7mtxCpyqb7HkmOw9MJpmI9E+9bA3vnNrE+fM6V4gv2o3Tn7VWZFQblL+8J+JD2WFAa0gj/aieZu/7U/qhrJjclMcl7AaJ/nW4K1L4SS3zCj1f5shYDN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ETXQDx+F; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724141306; x=1724400506;
	bh=53+5x/xmXek+DbIG4yjMFIEkhMF4WzX2KOCqZDEYdaM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ETXQDx+FpztwH++Xyy1bxmN7dL8AFYd03w0HFzh1Py+dioTXjnSmxku+so0A2rF1b
	 Kim+QH0zXvcdbC+8evJD7Kre8ZRDk3uHnzmVp8b/1/UcR4t9J2THbco7ZO5nfR83vo
	 dPtV1Q7mfLs6a9Bw5ojvbBtfrjMXe5PnmNof59oSstTpS+F1McadQmTHufj1/3bVAc
	 XwV1xhVY/v8B+ecqCritye3o7rhBnqfrmtn3FutpH8X3ziPuf1PzK/pT/qGR5iyRJ6
	 yq64fVB4cIKgGtuYWPivqrwNhtbdW3w2oqR85QnwMlb+R7BtnyclX2/fBeixwUggXl
	 sE/P8YRwPGSGA==
Date: Tue, 20 Aug 2024 08:08:22 +0000
To: Matt Gilbride <mattgilbride@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 5/5] rust: rbtree: add `RBTree::entry`
Message-ID: <57aa157d-ee94-419d-bad3-0bb93f5c2095@proton.me>
In-Reply-To: <20240819-b4-rbtree-v10-5-3b3b2c4d73af@google.com>
References: <20240819-b4-rbtree-v10-0-3b3b2c4d73af@google.com> <20240819-b4-rbtree-v10-5-3b3b2c4d73af@google.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 5ab9c56df45f04e8737dfb27924e85c535452cfa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.08.24 17:07, Matt Gilbride wrote:
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
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

One nit below, but feel free to add if it doesn't work:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>  rust/kernel/rbtree.rs | 310 ++++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 235 insertions(+), 75 deletions(-)

[...]

> +    /// Gets a mutable reference to the value in the entry.
> +    pub fn get_mut(&mut self) -> &mut V {
> +        // SAFETY:
> +        // - `self.node_links` is a valid pointer to a node in the tree.
> +        // - We have exclusive access to the underlying tree, and can th=
us give out a mutable reference.
> +        unsafe {
> +            &mut (*(container_of!(self.node_links, Node<K, V>, links) as=
 *mut Node<K, V>)).value

Does `.cast_mut()` work here instead of `as *mut Node<K, V>`? (also
below)

---
Cheers,
Benno

> +        }
> +    }
> +
> +    /// Converts the entry into a mutable reference to its value.
> +    ///
> +    /// If you need multiple references to the `OccupiedEntry`, see [`se=
lf#get_mut`].
> +    pub fn into_mut(self) -> &'a mut V {
> +        // SAFETY:
> +        // - `self.node_links` is a valid pointer to a node in the tree.
> +        // - This consumes the `&'a mut RBTree<K, V>`, therefore it can =
give out a mutable reference that lives for `'a`.
> +        unsafe {
> +            &mut (*(container_of!(self.node_links, Node<K, V>, links) as=
 *mut Node<K, V>)).value
> +        }
> +    }



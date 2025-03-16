Return-Path: <linux-kernel+bounces-562926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6A7A634C6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 10:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 851C07A796A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C719CC0E;
	Sun, 16 Mar 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="eWMd6YWR"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55C928F4;
	Sun, 16 Mar 2025 09:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742116825; cv=none; b=NzDdexQobAC2/Fdlbzg2TWeyzJEbaXnQgS5clO7XI8MvaRTkYd0GLxBTfI9k0SL12JEed8i6W4Z4mrbmXRPzAUxvdhd0iDt/d4xADYehWTT5B9gkRjiXZXYnd+CbkwINTXGKwWbFxwMbIGQ3lsYPOTkzndru8fBrTSQqRJSFavY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742116825; c=relaxed/simple;
	bh=Lq2nRa89GwzacBqB7cce7FrMWzbs9BvcYpclZTCdWCE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyWRpfs8pRDdEkwsnSqq56xIE22vvcmWCci/cn8fLIzhBuurR1KAHp5IFqvRx5hEqMEdHBdwGslEhgcHOGNkZPWORidI93NTjh5xKN9UxdcDvdUq/w0EibgCT0chufAxlk6ua8PtrNWn2dTUIlOjmdurjz0qauDaOxftPn3h15U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=eWMd6YWR; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742116814; x=1742376014;
	bh=E/GOEqwdAKcscL6gdC1W9MW7dv8UhKopri8EjjSqrjQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=eWMd6YWRkr1W8LyagRNQGWyUjO6okmnXb0PLVPIEdEul9xQSwuEKu4qzME2j8beOj
	 W0MWuYb9+DNNZH309pyKP77npcYRXAWHJRTA9rg18Ir2+V7x1CajmIwQ+RID0/EsnT
	 u2d7ayIVtxkKnl/Wx6/rNu+khCEhT6TogfrtuVYjXlUcQPvT2Lch2z4uMoWh4PRSP8
	 RTr5ER3BP5xu7UdwVFJ+JW/jEUbTwbKnHwQzwpeAU510VRSaVFvXQLkK2rUpr1jb20
	 nez5nAPkwU/qvNpaq4sllhjKvbNEI3hvku/b856qb7yVJr0Ey5ob+RYw2Vk6bjM41r
	 /LE6sGxTUYyJw==
Date: Sun, 16 Mar 2025 09:20:08 +0000
To: Charalampos Mitrodimas <charmitro@posteo.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: rbtree: fix comments referring to Box instead of KBox
Message-ID: <D8HKV6149T8U.2HZ2WE1E8FCJ@proton.me>
In-Reply-To: <20250315-rbtree-comment-fixes-v1-1-51f72c420ff0@posteo.net>
References: <20250315-rbtree-comment-fixes-v1-1-51f72c420ff0@posteo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: eeda091ed9a595ddf1ea9799160ab0b52e77b3fc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Mar 15, 2025 at 10:48 PM CET, Charalampos Mitrodimas wrote:
> Several safety comments in the RBTree implementation still refer to
> "Box::from_raw" and "Box::into_raw", but the code actually uses KBox.
> These comments were not updated when the implementation transitioned
> from using Box to KBox.
>
> Fixes: 8373147ce496 ("rust: treewide: switch to our kernel `Box` type")
> Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/rbtree.rs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
> index 0d1e75810664e18c0abe851ece2223d203721f79..a7ce512773563150fc2c290c5=
44f20baad6509bf 100644
> --- a/rust/kernel/rbtree.rs
> +++ b/rust/kernel/rbtree.rs
> @@ -1168,12 +1168,12 @@ impl<'a, K, V> RawVacantEntry<'a, K, V> {
>      fn insert(self, node: RBTreeNode<K, V>) -> &'a mut V {
>          let node =3D KBox::into_raw(node.node);
> =20
> -        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // SAFETY: `node` is valid at least until we call `KBox::from_ra=
w`, which only happens when
>          // the node is removed or replaced.
>          let node_links =3D unsafe { addr_of_mut!((*node).links) };
> =20
>          // INVARIANT: We are linking in a new node, which is valid. It r=
emains valid because we
> -        // "forgot" it with `Box::into_raw`.
> +        // "forgot" it with `KBox::into_raw`.
>          // SAFETY: The type invariants of `RawVacantEntry` are exactly t=
he safety requirements of `rb_link_node`.
>          unsafe { bindings::rb_link_node(node_links, self.parent, self.ch=
ild_field_of_parent) };
> =20
> @@ -1259,7 +1259,7 @@ pub fn remove(self) -> V {
>      fn replace(self, node: RBTreeNode<K, V>) -> RBTreeNode<K, V> {
>          let node =3D KBox::into_raw(node.node);
> =20
> -        // SAFETY: `node` is valid at least until we call `Box::from_raw=
`, which only happens when
> +        // SAFETY: `node` is valid at least until we call `KBox::from_ra=
w`, which only happens when
>          // the node is removed or replaced.
>          let new_node_links =3D unsafe { addr_of_mut!((*node).links) };
> =20
>
> ---
> base-commit: eb88e6bfbc0a975e08a18c39d1138d3e6cdc00a5
> change-id: 20250315-rbtree-comment-fixes-99e567449195
>
> Best regards,




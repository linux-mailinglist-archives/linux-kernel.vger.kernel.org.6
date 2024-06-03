Return-Path: <linux-kernel+bounces-199495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5704E8D87B7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AD21C2218E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92151137743;
	Mon,  3 Jun 2024 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzHULEMQ"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E112E1F9;
	Mon,  3 Jun 2024 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434747; cv=none; b=q+5Qz5jz6sAT9sMW+LU1AivG3/nNDJYf9de3b7jJIxR5YB0dmgo9DSCKtf+41nz8RY+17LZrC3osV7zDEByuHKZt8VX1XTQotrwY3bKAmOKhNf6r8s00d2uVTFzdz3C1uL9BV71UQYInIZhaUjy7xguVsyDlvkzqxll40tnHSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434747; c=relaxed/simple;
	bh=rbtH+DpYhqBMd0xLDXJmN7RirgQ6wnLGRMVHaZoyBt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2fu9gnHjrB50ZABF1paHfxKsjU6/3IypSyEi2nSVIxqKQofKr17i7ExeJ0n3ebbb/a8Ffu92nb0UU2UNxCv9u5QlRMewSAwhze+6I7WODemrsNOwH7Ge2Uv5WcE5hUXd/kqjsG4VWCXVdH/ZgdMlh9JLnRN5UHMy3XngcdI7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzHULEMQ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-794ab01e747so8949185a.1;
        Mon, 03 Jun 2024 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717434745; x=1718039545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xowQVtG5FrDvjNgj7LbV6txQKMGt2SxrGC16ykxcKRw=;
        b=HzHULEMQf7QqvnzkLcLLAgGbu/mBmi1Tho5Hhkw896d6Jmrr8IW9w01JGStFtXnN04
         oTr5GelT9OtR8hW6uFfsMMR/gonjw42VQHGfHjoRitNYFhzz9ECNpQ0n6pYrdjGJYmR6
         wQdEq8VYRoCooSr0/isdHKfPgP4J5gJ79hyMBIZCDF4hvDWIb29ZpsCf9AzJs/Fkl4hf
         fy7vioXn06EpD/yFInaQ32LFb+mLF17fSIXIulQ+wzOmZcMahAuUUpyK2HbXuQnM/wiN
         xb1h/Mg+Vh69quNxGHMkLvqSWKtfC4r35vtxgiZZSX/bkDSaga4/YVBJU7H2Ce+DqS/h
         ttGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717434745; x=1718039545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xowQVtG5FrDvjNgj7LbV6txQKMGt2SxrGC16ykxcKRw=;
        b=XROeovn/HTZGgFGctQDtLxzj+vaHA6ZcsK9JWgM1ExhaOySh1yMKLVZyrAtWhJADeI
         PgXskJyGEU+2tYlsZlaxHR099cbPlIlBGcfS5akrD2rkr4G1hRDCPUxGqO9v1U98CtPg
         Bd0R9WhbdbHPlBhfh9snld1lSSqPK+mNpqSI8YHU/CIRXrtnoY9rwMpsTJS4vPOUq4uO
         6HTc4Hp0q24HIT1HFdViZR1i84pH5QydN8y5yMueiHeZwyU8bQG76xPJLihzvwPU4/Pv
         TraqTHBb0xvTWaFwzKkfkn8dTd3tRM3qOlsTSm7OhYANWYNAAagKiMDowGhgUE6yc+Uk
         jMFg==
X-Forwarded-Encrypted: i=1; AJvYcCWeabnqRFUo07INiKuww9jiI2UbUsedYaj8UyfwC/N1IdjWYtsryDFgowxBDtQNded1/UTs5ehTcyJhcGEW9dIXvCqhiitQnzWEkSdYIh7E6Yh5lPDjJvT1h/q/Ac6RGuajfL589Nw+lUVsupM=
X-Gm-Message-State: AOJu0YxfZsSf1gg0LLFDR4hJuiw5PVvOP8HpJPKCevrT1U+plYkBnRVk
	lWhegwdP3uimGAcAWjlMOMoVJDIpctIvtdyOKjY/Vnb1CcCB9KF6rEYYmQ==
X-Google-Smtp-Source: AGHT+IG1+ImgQlShZJjOVinqc19ZW7tffsoXk/S/ELVIsV9v9S0BiFRQszbLq8XpL1zK1XQ8didDJQ==
X-Received: by 2002:a05:620a:4691:b0:78e:c890:1aa9 with SMTP id af79cd13be357-794f5c97363mr1194128685a.39.1717434745113;
        Mon, 03 Jun 2024 10:12:25 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff2593ba4sm40794651cf.90.2024.06.03.10.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 10:12:24 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id DC78E1200043;
	Mon,  3 Jun 2024 13:12:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 13:12:23 -0400
X-ME-Sender: <xms:d_ldZu-pV7_Pvupb69iz5JKxoz354vxmfK5THE5C7DFvk1j7K4ctrg>
    <xme:d_ldZuswSm17kqi6ADV-Jnq_2IERMhLmD15C4Cdb0jNENJTTolq3_yjHyH-s3ZAg3
    ZsHNuDBRd9paEI-oA>
X-ME-Received: <xmr:d_ldZkBOjgqOhxKuETdhi_dfohwyf-vePb0boAxnAOxNwfzJXTBbJ2QxWf38ZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgfelfeetleeivdeigfektddvhefhjeevfeeujeelleejgedtvdfggfff
    jefftdevnecuffhomhgrihhnpehnohguvgdrrghspdhruhhsthdqlhgrnhhgrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgv
X-ME-Proxy: <xmx:d_ldZmc9yED-qrYV6w3qJyFagxFhvrH7Vr466_PKVFMTWrSEHinVWA>
    <xmx:d_ldZjNzpKX9S1a4k8H6hOZ4f7GpiLdbxGQGKkcODx2SR2VMnRNyJw>
    <xmx:d_ldZgl7bzS34JlitWJRMef1cnQK8Jz91q2kXu3RWMelAVTw0I_B7w>
    <xmx:d_ldZlsK6yg7Q0vmGOfdklzI5O68Y7AKchREJk73SjVsHv1T0QdhVg>
    <xmx:d_ldZpv39RV6RJcBadnjxSr5fkCoeCeUBeMYYcSqKjLh69HvaiHDJtwy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 13:12:23 -0400 (EDT)
Date: Mon, 3 Jun 2024 10:11:25 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Matt Gilbride <mattgilbride@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>,
	Michel Lespinasse <michel@lespinasse.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] rust: rbtree: add red-black tree implementation
 backed by the C version
Message-ID: <Zl35PQ8LAdw67xaS@boqun-archlinux>
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
 <20240603-b4-rbtree-v4-2-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-b4-rbtree-v4-2-308e43d6abfc@google.com>

On Mon, Jun 03, 2024 at 04:05:17PM +0000, Matt Gilbride wrote:
[...]
> +/// A memory reservation for a red-black tree node.
> +///
> +///
> +/// It contains the memory needed to hold a node that can be inserted into a red-black tree. One
> +/// can be obtained by directly allocating it ([`RBTreeNodeReservation::new`]).
> +pub struct RBTreeNodeReservation<K, V> {
> +    node: Box<MaybeUninit<Node<K, V>>>,
> +}
> +
> +impl<K, V> RBTreeNodeReservation<K, V> {
> +    /// Allocates memory for a node to be eventually initialised and inserted into the tree via a
> +    /// call to [`RBTree::insert`].
> +    pub fn new(flags: Flags) -> Result<RBTreeNodeReservation<K, V>> {
> +        Ok(RBTreeNodeReservation {
> +            node: Box::new_uninit(flags)?,
> +        })
> +    }
> +}
> +
> +// SAFETY: This doesn't actually contain K or V, and is just a memory allocation. Those can always
> +// be moved across threads.
> +unsafe impl<K, V> Send for RBTreeNodeReservation<K, V> {}
> +
> +// SAFETY: This doesn't actually contain K or V, and is just a memory allocation.
> +unsafe impl<K, V> Sync for RBTreeNodeReservation<K, V> {}
> +
> +impl<K, V> RBTreeNodeReservation<K, V> {
> +    /// Initialises a node reservation.
> +    ///
> +    /// It then becomes an [`RBTreeNode`] that can be inserted into a tree.
> +    pub fn into_node(mut self, key: K, value: V) -> RBTreeNode<K, V> {
> +        let node_ptr = self.node.as_mut_ptr();
> +        // SAFETY: `node_ptr` is a valid pointer to a tree node.
> +        unsafe {
> +            node_ptr.write(Node {
> +                key,
> +                value,
> +                links: bindings::rb_node::default(),
> +            })
> +        }
> +        RBTreeNode {
> +            // SAFETY: The pointer came from a `MaybeUninit<Node>` whose fields have all been
> +            // initialised. Additionally, it has the same layout as `Node`.
> +            node: unsafe { Box::<MaybeUninit<_>>::assume_init(self.node) },
> +        }

nit: could you use Box::write()[1] here? It saves two `unsafe` blocks.

[1]: https://doc.rust-lang.org/std/boxed/struct.Box.html#method.write 

Regards,
Boqun

> +    }
> +}
> +
> +/// A red-black tree node.
> +///
> +/// The node is fully initialised (with key and value) and can be inserted into a tree without any
> +/// extra allocations or failure paths.
> +pub struct RBTreeNode<K, V> {
> +    node: Box<Node<K, V>>,
> +}
> +
> +impl<K, V> RBTreeNode<K, V> {
> +    /// Allocates and initialises a node that can be inserted into the tree via
> +    /// [`RBTree::insert`].
> +    pub fn new(key: K, value: V, flags: Flags) -> Result<RBTreeNode<K, V>> {
> +        Ok(RBTreeNodeReservation::new(flags)?.into_node(key, value))
> +    }
> +}
> +
> +// SAFETY: If K and V can be sent across threads, then it's also okay to send [`RBTreeNode`] across
> +// threads.
> +unsafe impl<K: Send, V: Send> Send for RBTreeNode<K, V> {}
> +
> +// SAFETY: If K and V can be accessed without synchronization, then it's also okay to access
> +// [`RBTreeNode`] without synchronization.
> +unsafe impl<K: Sync, V: Sync> Sync for RBTreeNode<K, V> {}
> +
> +struct Node<K, V> {
> +    links: bindings::rb_node,
> +    key: K,
> +    value: V,
> +}
> 
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 


Return-Path: <linux-kernel+bounces-199557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F258D888E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552B01F22B58
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03341384B1;
	Mon,  3 Jun 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/zuQt/E"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F42B12F373;
	Mon,  3 Jun 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717439014; cv=none; b=KMjtkvccxyj/N7jUIwgFdNzDom/HiqEhf4cFHkLSXt/fGs+bXBwWfa47aKWe76FzyaOeyasJU3rHSorGQJ0x28V2MsIBRTXU+pJIWcNEdAe0C7gaKkjYY2VtUBnFx5T0G9ex4ApUUlNQtxs/DsufeMnuhMHcyAh1lFyu/lQJpes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717439014; c=relaxed/simple;
	bh=+LsBDBbnK7K81j+VutGsbSjZ8b8W3RQlBCTwKrkDT2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEfYuftcMaM3TTjvG29g+6InnBkHeiOk0cptzY3UmEwNE+kC++gsvzr2CKIOiThcGqmayGF7JGSVF4iPGknhBbDQy2VHtYUedsTakkLQEsCUhtfJd8hhazl3XH6sP1j2rjP9mie6q4bzwgGpiQcKjmsUaJXDZFwQyXKqPrqTRqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/zuQt/E; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-24c9f6338a4so1811277fac.1;
        Mon, 03 Jun 2024 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717439012; x=1718043812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPIkN+Vz6u0IAS0DSpZkSencyyQI4KXXUBpf2kyrDBU=;
        b=j/zuQt/EEHKFRSYcCCv6eXS+SSBPRVhNtSv0ILnj/74que9yORY9eqFV9IfmraZIaP
         C1/FBxE3f4Jb316OVGtP31g3zWS5PQJ0JQB4P+ROfRwL5oNF+p4qmMe29SYX50CkxUMa
         sbCTWxLJI5+zycT4IfLfJ/SUoSETedRH81KEwVjfcVDgPZGvizH/rF76wvSImJhojDsd
         xF9qAHMmyZjUppkkOjnBCk8WrpJ+GC2wNktT3LMG1T2gtGR36F1ofrcA48UI/zOXJ8kG
         nFgw5jIcLJA6chXu/vPqCup8lnN+j17KRE6cdjm5D2/klbYafHKweplN8Guon1dFBvQ8
         tI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717439012; x=1718043812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BPIkN+Vz6u0IAS0DSpZkSencyyQI4KXXUBpf2kyrDBU=;
        b=Qa7oS6yWK1UVq6k5khWTBBr19vnwFeseakQrcS9zvFre+D9OxDyzH7Vt5eJeDRKvHn
         nDpxxxS3Wi3Avgv5N8x2N6ukyuVnDUTBg8jwtqo1k5dYXZx/nOBft5w+K/Pk5/kRETSO
         HQmWFXzoPoyNrGdMTNnTFEPij1sE1kRAIgoOOZXfKbOxA38V7m5SNfXryjbXE9VQB/mg
         /0xwZZAMPhkITfc3vA0IxCofrtGE1qKq+z2qAF9cLrl9JmuMK7G9Rm+7L8MH/LL8iCGV
         Yw0OfLsPYfJ4kyVDKWrVW4l6L32o2a7Kxxp6eau0+U0U0weriuf4VWF/KFKmUwRJC0JK
         2g8w==
X-Forwarded-Encrypted: i=1; AJvYcCUzXmoqT22aU6h1N+uLSQB1dtzOL9+VKiYWG3nkojs5lcO1yv3+dtKdwiZZmcjXKUsPKVmR6W0Xk7kdwA3sCPfP44coBze4qed1NL53rNu+nGNG5gxnXVnql+pvds8CvWTqclm/HMQuCwSBzSA=
X-Gm-Message-State: AOJu0Yzog7sUBbMIVvY9DxrCRF7XeEk5vNhxCGMjN0YONsIPcv6QCHfd
	7JQh17GnUj7LOqIwxud8EO4pTvsB3dHLIB7j8941gZpSX9w5aYYw
X-Google-Smtp-Source: AGHT+IGI1i0dw7bQS7otMUvvzgFeO10QfSZBNWp3zgZIrGEqwD3HX+QfvUl/b+r5hgnfic27c1IayA==
X-Received: by 2002:a05:6871:3a22:b0:24c:b1d8:8475 with SMTP id 586e51a60fabf-2508bbc0756mr10556765fac.42.1717439012346;
        Mon, 03 Jun 2024 11:23:32 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f2efc664sm302801485a.4.2024.06.03.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:23:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 066F01200032;
	Mon,  3 Jun 2024 14:23:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 14:23:31 -0400
X-ME-Sender: <xms:IgpeZm6pBxNaIwGaSY6TmZGwGfdy_XcXrLjmhZlsZv9CLnkho7J7IA>
    <xme:IgpeZv4T2tki4aHhmEOzU1ymfAA0_NhgC1wp09GSsXhABSs1ff08HWl5vAI3TbRP_
    _yqwdmu3GRho1L72A>
X-ME-Received: <xmr:IgpeZlcPWVm0nIM3F8m5VCApHm0JBPj4CbUR2grSkHty5dux6sYi9bY_7uuI1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:IgpeZjIey-mBZYIQ8Y9IF5U8FThKD5FDeg4sQQ8Dh8lNK7q5gE66mQ>
    <xmx:IgpeZqKL-HZcd7ojsQQFRCYZVDY0YMsMzzZTThvZSjlOIHLQaB5hcg>
    <xmx:IgpeZkychas1FcRXbiU8INtAs9Y-YIveNjs6ghJB8Pl0w_kTWQ4D1w>
    <xmx:IgpeZuJl_YJpncukmxT2vNtuaQ_fvbGPyO20oJ1Zm63sFM220W2qzA>
    <xmx:IgpeZhY6dmC82tEdA5z_OU2CHbluxvFlTXNyWSkSo7PITwR_DjSdZdHa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 14:23:30 -0400 (EDT)
Date: Mon, 3 Jun 2024 11:22:32 -0700
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
Subject: Re: [PATCH v4 5/6] rust: rbtree: add `RBTreeCursor`
Message-ID: <Zl4J6IrdweiI0MgC@boqun-archlinux>
References: <20240603-b4-rbtree-v4-0-308e43d6abfc@google.com>
 <20240603-b4-rbtree-v4-5-308e43d6abfc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-b4-rbtree-v4-5-308e43d6abfc@google.com>

On Mon, Jun 03, 2024 at 04:05:20PM +0000, Matt Gilbride wrote:
[...]
> +    /// Remove the current node from the tree.
> +    ///
> +    /// Returns a cursor to the next node, if it exists,
> +    /// else the previous node. Returns [`None`] if the tree
> +    /// becomes empty.
> +    pub fn remove_current(self) -> Option<Self> {

I'd expect this function returns a `(Option<Self>, Option<RBTreeNode>)`
or something similar, since it removes a node in a tree, could you
explain why we don't need to care the removed node?

Regards,
Boqun

> +        let prev = self.get_neighbor_raw(Direction::Prev);
> +        let next = self.get_neighbor_raw(Direction::Next);
> +        // SAFETY: By the type invariant of `Self`, all non-null `rb_node` pointers stored in `self`
> +        // point to the links field of `Node<K, V>` objects.
> +        let this = unsafe { container_of!(self.current, Node<K, V>, links) }.cast_mut();
> +        // SAFETY: The reference to the tree used to create the cursor outlives the cursor, so
> +        // the tree cannot change. By the tree invariant, all nodes are valid.
> +        unsafe { bindings::rb_erase(&mut (*this).links, addr_of_mut!(self.tree.root)) };
> +
> +        let current = match (prev, next) {
> +            (_, Some(next)) => next,
> +            (Some(prev), None) => prev,
> +            (None, None) => {
> +                return None;
> +            }
> +        };
> +
> +        // INVARIANT:
> +        // - `current` is a valid node in the [`RBTree`] pointed to by `self.tree`.
> +        // - Due to the function signature, `self` is an owned [`RBTreeCursor`],
> +        //   and [`RBTreeCursor`]s are only created via functions with a mutable reference
> +        //   to an [`RBTree`].
> +        Some(Self {
> +            current,
> +            tree: self.tree,
> +        })
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
[...]


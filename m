Return-Path: <linux-kernel+bounces-263739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F97693D9F9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1C91F2391B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E92149E06;
	Fri, 26 Jul 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5tlPxze"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2524205;
	Fri, 26 Jul 2024 20:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722026779; cv=none; b=eOSg5YZOXW9nH0CD9TkprEYyGCp0tfFgDZT4esIUZx9l5W3lqe8mYznNqnw2cZttk694AP+VVo3MjVrsccANBcIG4y45ZcbuYma1GUhgSjiKmiU62JlwySBSiCyktwpKxMaohEddRICyuGPSDLP69irdg/QplARJh4PHQVeQkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722026779; c=relaxed/simple;
	bh=f9qO9Rn2Uv7ovrigWpLllbYPBkKULIErG/qEpgFC7H4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lr6qWd7jV5MWyWMNNiRHX7jsKJUuckCHAoOPSUG1Zb3OYy6odnZmeNwcRdwKGE8yXBc1o4WZLxxKXB8DaKj9jGQqCsGC2pd30I+MsHuoZDm1eRB82JVcvw5IRwc1Jh5DSWBc5rxR0Pc2FejEPybe931rIqXMA86Bu2BwxMqfqwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5tlPxze; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5d5aecbe0a9so814196eaf.1;
        Fri, 26 Jul 2024 13:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722026776; x=1722631576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cF1c8neFTt1VPx0ppHccxu/q8NvWgl5cUeRvDaUlvaI=;
        b=E5tlPxzeyK22y+72G98Q8JTxapC9feFbCChEXwnb4vF8EPz3AygDBcOOQB6OBxYnhf
         YkaKNjQECBLml2PC70QgibNX1F4/peiu59UFavI0EsZBh+ePwYiIb+rgM7pBKnVl7AiS
         rlrod3CL7BGAZcSB0WRRDjqoIWPU/nSv6BlhhpYx3Oxu71L1pIx0E+/Oha+iPtXpTSdV
         4xzYGzwb41kOm6GuGaIiIvnaaJaWspgt/74lI/lXi2FvlMbKbeNhBPHHpq17bCQBfq7d
         InN10LkpDyqUYLZfR0KOtIdpMQFmIE/ZXLZzDPwzWsTKRJCzkFkI0/8Ivw1y2QLSpYfd
         bmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722026776; x=1722631576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cF1c8neFTt1VPx0ppHccxu/q8NvWgl5cUeRvDaUlvaI=;
        b=ZiJQuiP0jn+PqSeNGz2F/WFL+Ui82fy965LfX4vv/ERRInpseXxyhoKTqSRYtqQIfb
         iRWZfp5skSeNdqePmoII8UtR8TVXGMcwVyHw/tKi+EVxUzGUUkvKaSt7Gmxcra/UCKo5
         Oo9dv7UstfDWiZ3mxc9mH8nIQhAS+yUyFaMqEZ4ZjdZzF5Y33rHRkS1o2Qqqu8nO9KUM
         +I4J95CX1hSpr7yX/RHY/dy0II+ApPsyd6jweNS/y+4j+rex/UzYCy81lILb8SgSSoOw
         s2GFqCDDsc6JGYyW1IwYaudsahnnXYObtWqyFkCNQQGEykoEG0PcFp7pFSinPadsrx//
         fP1g==
X-Forwarded-Encrypted: i=1; AJvYcCXSJ9Fq4wcS1DGj8nYQqN2H/UzM/gdKuQ86YwzNuHbze2LOSUBiITEEI0F80+wJJykXGrWl/Yn9/U1bezxX4IIt5OaMbuByeNM1BoWGHZ3IvSTZ5n4OyAOg4TerORc3DJzG9bV4FGZqbJg41xE=
X-Gm-Message-State: AOJu0YwhF0+hpLxQCeMGvIv9zFawhNdt2Cl4mtN/jdBb8wX8PiBCkxQg
	Q2+4UCNmPRm35CBctDqneBaydyrDH6qdgUaBH+tjTzFA6bGvIrnV
X-Google-Smtp-Source: AGHT+IEYW3lScmUtRluZGt6bNQJq343utiMw3Q48Pnz0Q3CTpLt7Lq8PPeplmXxiQ/N4N2q8UTEzsw==
X-Received: by 2002:a05:6358:c022:b0:1ad:a25:a6d8 with SMTP id e5c5f4694b2df-1adcdba1001mr100762855d.27.1722026776392;
        Fri, 26 Jul 2024 13:46:16 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa950a3sm20005946d6.90.2024.07.26.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:46:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id EE15C1200070;
	Fri, 26 Jul 2024 16:46:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 26 Jul 2024 16:46:14 -0400
X-ME-Sender: <xms:FgukZhNclUwQWNlwVd7oRcQ9kTtvkSHHQzt2VK7v5qwSFi2l4u0kUg>
    <xme:FgukZj9iy2-8JvVLRjfUfWJV7jcwis38tMvrUuLTG7QvWEmKO3Bqb3SitNCYzTjhv
    gdIy5KHlPXtS3r8TQ>
X-ME-Received: <xmr:FgukZgTHUX9MGr6jogds0tYQp8YpGMoHL4VE4qXCLczto492bU2k343FiPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehgeevvdeivedvfedvuddtffegfeetgeetheeftdeggeegfeffjedufedu
    tefhtdenucffohhmrghinheprghnughrohhiugdrtghomhdpkhgvrhhnvghlrdhorhhgpd
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqd
    eiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhl
    rdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:FgukZtvAMuOdDDTKShWG0D3FQHi_g7zpHjwojf5H8fzISBRVTIca_g>
    <xmx:FgukZpejCEZ9hLkWyzSMHyxTC9s0LTQxA9XaIztICd8qHFwUlNOGSw>
    <xmx:FgukZp3twdYaTPuiKs2BFX9A-DiPL7eC40cbR886onfYHJeLEDAVfA>
    <xmx:FgukZl_LZlGj3fE6wGG6HtluTxb9gywpLKtFAhY1YFDJG5IkPVjVcw>
    <xmx:FgukZk--wOmqEeAJGMU0hePqb3q3CGmZgI8q0_ThoP9ryJCviI3cJ8vN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 16:46:14 -0400 (EDT)
Date: Fri, 26 Jul 2024 13:45:43 -0700
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
Subject: Re: [PATCH v7 0/6] Red-black tree abstraction needed by Rust Binder
Message-ID: <ZqQK92Mj09a0ocDY@boqun-archlinux>
References: <20240726-b4-rbtree-v7-0-aee88caaf97c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726-b4-rbtree-v7-0-aee88caaf97c@google.com>

On Fri, Jul 26, 2024 at 07:57:39PM +0000, Matt Gilbride wrote:
> This patchset contains the red-black tree abstractions needed by the Rust
> implementation of the Binder driver.
> 
> Binder driver benefits from O(log n) search/insertion/deletion of
> key/value mappings in various places, including `process.rs` and
> `range_alloc.rs`.  In `range_alloc.rs`, the ability to store and
> search by a generic key type is also useful.
> 
> Please see the Rust Binder RFC for usage examples [1]. Note that
> the `container_of` macro is currently used only by `rbtree` itself.
> 
> Users of "rust: rbtree: add red-black tree implementation backed by the C version"
>     [PATCH RFC 03/20] rust_binder: add threading support
>     [PATCH RFC 05/20] rust_binder: add nodes and context managers
>     [PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: rbtree: add iterator"
>     [PATCH RFC 17/20] rust_binder: add oneway spam detection
> 
> Users of "rust: rbtree: add mutable iterator"
>     [PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: rbtree: add `RBTreeCursor`"
>     [PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: rbtree: add RBTree::entry"
>     Not used in the original RFC, but introduced after further
>     code review.  See: https://r.android.com/2849906
> 
> The Rust Binder RFC addresses the upstream deprecation of red-black
> tree. Quoted here for convenience:
> 
> "This RFC uses the kernel's red-black tree for key/value mappings, but we
> are aware that the red-black tree is deprecated. We did this to make the
> performance comparison more fair, since C binder also uses rbtree for
> this. We intend to replace these with XArrays instead. That said, we
> don't think that XArray is a good fit for the range allocator, and we
> propose to continue using the red-black tree for the range allocator."
> 
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>

Thanks! For patch #5, there is a small style issue, which can be fixed
by:

diff --git a/rust/kernel/rbtree.rs b/rust/kernel/rbtree.rs
index f6d5162e46f5..96fd45f9dc52 100644
--- a/rust/kernel/rbtree.rs
+++ b/rust/kernel/rbtree.rs
@@ -465,9 +465,7 @@ pub fn cursor_lower_bound(&mut self, key: &K) -> Option<RBTreeCursor<'_, K, V>>
             }
         }
 
-        let Some(best) = best_match else {
-            return None;
-        };
+        let best = best_match?;
 
         // SAFETY: `best` is a non-null node so it is valid by the type invariants.
         let links = unsafe { addr_of_mut!((*best.as_ptr()).links) };

with that, for the whole series:

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

I also put this on rust-dev branch for my own testing purpose (with the
above fix applied, and using Benno's version of patch #1 since it's
already in rust-dev).

Regards,
Boqun

> ---
> Changes in v7:
> - make `RawVacantEntry.rbtree` a raw pointer like
>   `RawVacantEntry.child_field_of_parent`, since the latter can
>   technically point at a field of the former. We prefer that the
>   implementation be explicit about the safety guarantees of both because
>   of the relationship between them.
> - Link to v6: https://lore.kernel.org/r/20240711-b4-rbtree-v6-0-14bef1a8cdba@google.com
> 
> Changes in v6:
> - Minimize usage of `*mut bindings::rb_node`, replacing with
>   `NonNull<bindings::rb_node>`. Specifically, changing
>   `RBTreeCursor.current` to be `NonNull<bindings::rb_node>` and updating
>   the corresponding functions.
> - Update `RBTreeCursor:to_key_value` helpers to have their own lifetime
>   (they are not instance methods, using a different lifetime than that
>   of the `impl` block they are in makes things more clear.
> - Fix misplaced semicolon in `cursor_lower_bound`.
> - Link to v5: https://lore.kernel.org/r/20240606-b4-rbtree-v5-0-96fe1a0e97c0@google.com
> 
> Changes in v5:
> - Used `Box::write` in `RBTreeNodeReservation::into_node`, removing
>   unnecessary `unsafe` blocks.
> - Updated `RBTreeCursor::remove_current` to return the removed node.
> - Link to v4: https://lore.kernel.org/r/20240603-b4-rbtree-v4-0-308e43d6abfc@google.com
> 
> Changes in v4:
> - rebased onto the tip of rust-for-linux/rust-next (97ab3e8eec0ce79d9e265e6c9e4c480492180409)
> - addressed comments from draft PR on GitHub: https://github.com/Rust-for-Linux/linux/pull/1081
> - Link to v3: https://lore.kernel.org/r/20240418-b4-rbtree-v3-0-323e134390ce@google.com
> 
> Changes in v3:
> - Address various feedback re: SAFETY and INVARIANT comments from v2.
> - Update variable naming and add detailed comments for the `RBTree::insert` (later moved to
>   `RBTree::raw_entry`) implementation.
> - Link to v2: https://lore.kernel.org/r/20240219-b4-rbtree-v2-0-0b113aab330d@google.com
> 
> Changes in v2:
> - Update documentation link to the C header file
> - Use `core::convert::Infallible` in try_reserve_node
> - Link to v1: https://lore.kernel.org/r/20240205-b4-rbtree-v1-0-995e3eee38c0@google.com
> 
> ---
> Alice Ryhl (1):
>       rust: rbtree: add `RBTree::entry`
> 
> Benno Lossin (1):
>       rust: kernel: add `drop_contents` to `BoxExt`
> 
> Matt Gilbride (1):
>       rust: rbtree: add `RBTreeCursor`
> 
> Wedson Almeida Filho (3):
>       rust: rbtree: add red-black tree implementation backed by the C version
>       rust: rbtree: add iterator
>       rust: rbtree: add mutable iterator
> 
>  rust/helpers.c               |    7 +
>  rust/kernel/alloc/box_ext.rs |   24 +-
>  rust/kernel/lib.rs           |    1 +
>  rust/kernel/rbtree.rs        | 1290 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1321 insertions(+), 1 deletion(-)
> ---
> base-commit: 97ab3e8eec0ce79d9e265e6c9e4c480492180409
> change-id: 20231205-b4-rbtree-abb1a016f0a0
> 
> Best regards,
> -- 
> Matt Gilbride <mattgilbride@google.com>
> 


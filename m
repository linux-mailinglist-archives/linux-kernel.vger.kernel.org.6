Return-Path: <linux-kernel+bounces-301137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D2395ECD9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 377F71C217D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343201422BF;
	Mon, 26 Aug 2024 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b="jbgjJgBd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzxF4RXz"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3CA13CA9C;
	Mon, 26 Aug 2024 09:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663706; cv=none; b=ePmiqg1dBayL0T9gN+eRr6+uPxfErV8l4r/KD4OBzjT/48hooaq5zwmagBmy1IW992UGhLHxf6JdcxV4pGt6+QiH77HRJaz5u9KLy0u3NFhNFDfkugMstC8CG+6L9ch67/B1gaOigZnAtMI9KQ1istyJqDVdWWazt1NwMqIRz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663706; c=relaxed/simple;
	bh=qb7mmv6xJRCSL+owbyLSt5Srq8pjUtv2W/aeiFKWbT8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pwqeHnGWAfQEOv35VsPTX6+mb7McMmJkETanKBy7PihxuaTUfiv1aPDUYihvuiFapJrE2BkB4yGc10ddX8/s4rVw5Z4inRc51kS39I+dMC5rwb51LUXfastlCo4UOMKcowmO8nJDek+WyotMD6kHlr3hVSkawOH0caMx+H8GwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu; spf=pass smtp.mailfrom=readahead.eu; dkim=pass (2048-bit key) header.d=readahead.eu header.i=@readahead.eu header.b=jbgjJgBd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzxF4RXz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readahead.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=readahead.eu
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 940A013909DD;
	Mon, 26 Aug 2024 05:15:01 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-01.internal (MEProxy); Mon, 26 Aug 2024 05:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724663701;
	 x=1724750101; bh=qXlm+u9a6zbDeibr7DEQuo12TJCy96Uotozqm940FDo=; b=
	jbgjJgBdAgPds+Ng/ADJaCyAsQmdtOXfYOTOzFGtyTZLxYSk5umIc2hYpdlCERNq
	0f7XoCLZHl+ZNEWMbyDY/JHmpagq1UwnlMOCBYu/DbIPoiS9sQ2RwiWU82WR6sAL
	80hh6K5U5qDmE/NfxreGrkK9WdhlFUq3nVs1y0A7qjh16+5W/HDViw/vpyM4+x/H
	MQBzLiLOhJrwFY5GRslaODKT+YUYEivIANpmztzLTM50e5aDpEakGWXiWdc9AZWE
	8BPHmbbD5ZJ3CfD2fb7M91RdCW/4IwoWYenCpzJEMYvx9yl7N3CbtmnVEfMU3FgH
	mC5X7yEbjnrZad2+N7rdmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724663701; x=
	1724750101; bh=qXlm+u9a6zbDeibr7DEQuo12TJCy96Uotozqm940FDo=; b=h
	zxF4RXz5wGTy6ZnSiHTYGdjjd3jLJ8vF+kojug+E1XHR1RLB7DAI+2UgXVTAUTNH
	5qktOHxamlLvcdXCagb9MFkhuWe+pVcx5GZCXHEwnrZow2szdt6rqbyEjoEjw5Lc
	P9R5UMoAIsLScAgsC8M7fAw9lguWSwmEUxSQCYdMHPjqbBfdpQGjttE1BujT8SQa
	WZRCXxCtzVQ3emRDl7z+NPUNQkXKXDlQTdqa0P+ON3o+a/96MME4+XK7YWm7HCjx
	t70U/wIaPj6d0TjL2NMyt+HLyOis1ch2w654kTlXAEudJk8ds7et2kawhCCsiAGP
	YSa/E2za8jGhSnueAiN1g==
X-ME-Sender: <xms:lEfMZoOz7X6Fl_G5Km8x7gd204MMUhtPrI9XPQYc521LnXfex7iLfw>
    <xme:lEfMZu88N_mWAG6cn0HmWdxYRf1rFXqBapCIi5vzIoik01HHzqQRmh15oS5-8l9Ap
    J4dS-2mFPi-2BlTMhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvkedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfffgrvhhiugcutfhhvghinhhssggvrhhgfdcuoegurghvihgusehrvg
    gruggrhhgvrggurdgvuheqnecuggftrfgrthhtvghrnhepffekieevueeijeehieekleei
    hedvledvgfeifeeiffehleetheevffegueeltdeknecuffhomhgrihhnpegrnhgurhhoih
    gurdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepuggrvhhiugesrhgvrggurghhvggrugdrvghupdhnsggprhgtphhtthhopedvfedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheprghrvhgvsegrnhgurhhoihgurdgtohhm
    pdhrtghpthhtohepmhgrtghosegrnhgurhhoihgurdgtohhmpdhrtghpthhtohepthhkjh
    hoshesrghnughrohhiugdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepfigv
    ughsohhnrghfsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheptghmlhhlrghmrghssehgohhoghhlvgdrtgho
    mh
X-ME-Proxy: <xmx:lEfMZvQD-CIxMeYuTQ_xsIRnnK16uJ0J0t66UNVjPkDK6DdvPOdXXQ>
    <xmx:lEfMZgtT-jhBL8l0CsJaVVHw-C7LK5tHUB-UFeTz_D37TBoV8VvnRg>
    <xmx:lEfMZgcCmX3XCn6qD6ohQQULwVRay9MQ8SY6VFRrH7JNrVB03l7VwQ>
    <xmx:lEfMZk3DUmORKkVOR9HiKbLopFVSQaN-gKgD24gvpCNtsuFL9N_08Q>
    <xmx:lUfMZkPLCaJniAo1u3odtqMCgqY1xOmPH29qWgPtF2H0zBL695dgf9aE>
Feedback-ID: id2994666:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1A0A618A0068; Mon, 26 Aug 2024 05:15:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 26 Aug 2024 11:14:39 +0200
From: "David Rheinsberg" <david@readahead.eu>
To: "Matt Gilbride" <mattgilbride@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Alice Ryhl" <aliceryhl@google.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 "Todd Kjos" <tkjos@android.com>, "Martijn Coenen" <maco@android.com>,
 "Joel Fernandes" <joel@joelfernandes.org>,
 "Carlos Llamas" <cmllamas@google.com>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Rob Landley" <rob@landley.net>, "Davidlohr Bueso" <dave@stgolabs.net>,
 "Michel Lespinasse" <michel@lespinasse.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <5a7e828e-b003-4062-9469-53f090defc03@app.fastmail.com>
In-Reply-To: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
References: <20240822-b4-rbtree-v12-0-014561758a57@google.com>
Subject: Re: [PATCH v12 0/5] Red-black tree abstraction needed by Rust Binder
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

On Thu, Aug 22, 2024, at 6:37 PM, Matt Gilbride wrote:
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
> Users of "rust: rbtree: add red-black tree implementation backed by the 
> C version"
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

(I might have missed this in previous versions of the patchset, so let me know if this has been answered before.)

1) Have you had any chance to compare this (performance wise) to the intrusive version used by the C Binder implementation? I assume the allocations are negligible, but tree-traversal should be significantly faster with intrusive trees when keys are next to the rb-node (e.g., binder range allocator, or ref/node lookup based on u64). With the allocating style, you likely double the number of cache-lines you load during a traversal, don't you?
We have been trying hard to keep the intrusive style, but never really measured the performance. So in case you do have numbers / experience, I would love to hear about it.

2) Similar to 1), what is the reason to avoid the intrusive style? Is this just to simplify the API and keep it close to what rust-std does? Is the intention of this RFC to move towards an allocating style, or is work on the intrusive abstraction still welcome? I guess for compatibility to C-code, we still need the intrusive helpers, and likely for a long time.

3) I know that Matthew has spent significant time converting users to xarray, yet I have not seen any real deprecation of rbtrees. Especially when keys are user controlled or sparse, I do not see how xarray is a suitable replacement. Did I miss some discussions there? Or are you just referring to the general recommendation to consider xarray?

Thanks a lot for the series!
David


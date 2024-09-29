Return-Path: <linux-kernel+bounces-343036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9802F989616
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDF91F2107A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A7C16E892;
	Sun, 29 Sep 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itBWcsI5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D07417C;
	Sun, 29 Sep 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727623051; cv=none; b=p67C1m7u7liA1IfG01/MKWjkcqE4tz4fQpt3Y5XyeEN33gmJj/fiaZ6NqBbq1Jq0rJth7wQqXqmJZHzuHrgpIfZcwei1Am/SY5iO+a1dzIbNu5uabfRr4MdvFCM5Gvxv8UvBioJcWbbTImbYT6mUbKiZrVq6BsDVxtnVyQeGTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727623051; c=relaxed/simple;
	bh=eQylGUNRxchABfJswjanp/s+IOJknU6kiHFdLqGmXTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiNMcreYu2zPIAGqT4EREjdXyi8YIvTgdXTLzG84eMur+rF6X1jENEl1EPXpFBjbb4FuqfY45XeDXJ3yIC2hawjyrJmBGkIl10YyWgGehQXD8IqwQqRxRF21pZFgktFnEc3Te1LLntl3mH01525+OYuu9JSkhY1sbgn72/ZleQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itBWcsI5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C03C4CEC5;
	Sun, 29 Sep 2024 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727623050;
	bh=eQylGUNRxchABfJswjanp/s+IOJknU6kiHFdLqGmXTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=itBWcsI5uSxHOMUI+hnyql50fUWWO1cwMCySRGDRJW3pELQFcx2w0m51e83B+aYe3
	 x0e8Mnov2bCUzmpT7mdROBFZ3Z6j9hWUfj5IyBlI0Wln+W08YWPYW68OcsM3+LcpOg
	 8YuZAMwZz05dAIjJUtk85hqL5B/G7+Fj4lMzzRtfe8JyMI7LEdI3Pi+DTgzOpWOJbp
	 5+3gOPe5Wk7u5v7EHEuo0INXe2epKLS70bBPE4+1xRavjo79tnDRkglBDoJkzF6hVS
	 lKOTbaEhfL0h6avtYuXOO7wgfUZ8ScSK5b2/Y7wNEL+UTW6SjBCUvP4qJdMfIf/8xp
	 dZ0Pc71VP8XHA==
Date: Sun, 29 Sep 2024 17:17:23 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 25/26] kbuild: rust: remove the `alloc` crate and
 `GlobalAlloc`
Message-ID: <Zvlvg0pBkhmukh0N@pollux>
References: <20240911225449.152928-1-dakr@kernel.org>
 <20240911225449.152928-26-dakr@kernel.org>
 <20240928204357.3a28dada.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240928204357.3a28dada.gary@garyguo.net>

On Sat, Sep 28, 2024 at 08:43:57PM +0100, Gary Guo wrote:
> On Thu, 12 Sep 2024 00:53:01 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Now that we have our own `Allocator`, `Box` and `Vec` types we can remove
> > Rust's `alloc` crate and the `new_uninit` unstable feature.
> > 
> > Also remove `Kmalloc`'s `GlobalAlloc` implementation -- we can't remove
> > this in a separate patch, since the `alloc` crate requires a
> > `#[global_allocator]` to set, that implements `GlobalAlloc`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/Makefile                     | 43 +++++----------------
> >  rust/exports.c                    |  1 -
> >  rust/kernel/alloc/allocator.rs    | 63 +------------------------------
> >  scripts/Makefile.build            |  7 +---
> >  scripts/generate_rust_analyzer.py | 11 +-----
> >  5 files changed, 15 insertions(+), 110 deletions(-)
> > 
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 72b1232b1f7d..529ec5972e55 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -262,18 +262,13 @@ $(obj)/%.lst: $(obj)/%.c FORCE
> >  
> >  # Compile Rust sources (.rs)
> >  # ---------------------------------------------------------------------------
> > -
> > -rust_allowed_features := new_uninit
> > -
> 
> Would it make sense to throw in a soon-to-be-stable (or
> already-stable-but-beyond-min-rust-version) feature here to not have to
> remove the build system support for unstable feature directly?

It's only about those two lines, right? I can only remove the `new_uninit` and
leave `rust_allowed_features :=` and leave...

> 
> For example, I know that const_refs_to_static might be added here
> soon-ish.
> 
> >  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
> >  # current working directory, which may be not accessible in the out-of-tree
> >  # modules case.
> >  rust_common_cmd = \
> >  	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
> > -	-Zallow-features=$(rust_allowed_features) \

...this line, I guess?

> 
> I think this actually allow all features instead of allowing none.
> 
> >  	-Zcrate-attr=no_std \
> > -	-Zcrate-attr='feature($(rust_allowed_features))' \
> > -	-Zunstable-options --extern force:alloc --extern kernel \
> > +	-Zunstable-options --extern kernel \
> >  	--crate-type rlib -L $(objtree)/rust/ \
> >  	--crate-name $(basename $(notdir $@)) \
> >  	--sysroot=/dev/null \
> > diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> > index d2bc63cde8c6..09e1d166d8d2 100755
> > --- a/scripts/generate_rust_analyzer.py
> > +++ b/scripts/generate_rust_analyzer.py
> > @@ -64,13 +64,6 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
> >          [],
> >      )
> >  
> > -    append_crate(
> > -        "alloc",
> > -        sysroot_src / "alloc" / "src" / "lib.rs",
> > -        ["core", "compiler_builtins"],
> > -        cfg=crates_cfgs.get("alloc", []),
> > -    )
> > -
> >      append_crate(
> >          "macros",
> >          srctree / "rust" / "macros" / "lib.rs",
> > @@ -96,7 +89,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
> >      append_crate(
> >          "kernel",
> >          srctree / "rust" / "kernel" / "lib.rs",
> > -        ["core", "alloc", "macros", "build_error", "bindings"],
> > +        ["core", "macros", "build_error", "bindings"],
> >          cfg=cfg,
> >      )
> >      crates[-1]["source"] = {
> > @@ -133,7 +126,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
> >              append_crate(
> >                  name,
> >                  path,
> > -                ["core", "alloc", "kernel"],
> > +                ["core", "kernel"],
> >                  cfg=cfg,
> >              )
> >  
> 


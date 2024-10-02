Return-Path: <linux-kernel+bounces-347796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E91398DEC6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8F21F21C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBF71D07B1;
	Wed,  2 Oct 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1HUVrPP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA3D38F91;
	Wed,  2 Oct 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882415; cv=none; b=HPijJ6gYlIDuiRalegyPb3OzC2+lFyygLnyf4fTPXIV6RXwqGbzc24hc7A4Nc3S8bLLiEGrgsO70xXJRkzO28tQ3uPn8Pg/a6F0eeMcK99nUQ9WukSC5w1UOWJbhKs5svIzvPRRT1dbccdhDp8Igo//9VvJbIaqyyFQbzH3agyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882415; c=relaxed/simple;
	bh=dyBqlInnswGOHm0meUkvVLFHAotMWeY/uR1TxBb6IoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axcppSQX8TaoJaUXti0oKWeDmQsJCNXM0mLp1vRX+jP39P1/AN+Q9/Cwvcl+iN/j18iwfpldyaqI9LZLdqSMhbE0jVMbafgZHWDmQlgFpPCm2v4667po5xhYcFwlFFfwhU9GqCbjEfgUv68BvhL/Sf4JcXu5ucSGuhx9K4ifyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1HUVrPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE1C6C4CECD;
	Wed,  2 Oct 2024 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727882414;
	bh=dyBqlInnswGOHm0meUkvVLFHAotMWeY/uR1TxBb6IoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1HUVrPPSjClNuYbPG1ypLB0rwaYBL1XllUPD5r/UvgLZV01+gHZjG9E08NelR0Lb
	 NVl00V7pEBg0K9zPJJaf7qOlZk/WMN6ev4IQHXRuF8TRbiQZpIockal/xaNGSAGUgh
	 BDCd6ee37/38/K0s785FqHq/FCO8kUhTNxe8rOPGU9SLv3LREPbisxvONgb4MN3VS4
	 vWo+X6U978iegyI1GztsmMTJc3cPcleTsEFDDaSQndFp4aG9a/CWkkwJDy4Iv4XFqA
	 c5ucy9EMhCjto2pybh/ZWM7IKareS8bL3pIbisipZghDzc3hitBKqi5/lyhTIDmvU5
	 KECFYvf3XW+Ag==
Date: Wed, 2 Oct 2024 17:20:06 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@samsung.com, aliceryhl@google.com,
	akpm@linux-foundation.org, daniel.almeida@collabora.com,
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com,
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 16/29] rust: alloc: implement kernel `Vec` type
Message-ID: <Zv1kpqCihqrlCo6f@pollux>
References: <20241001150008.183102-1-dakr@kernel.org>
 <20241001150008.183102-17-dakr@kernel.org>
 <977af809-71f5-4a5a-8006-a283f8a6fc25@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <977af809-71f5-4a5a-8006-a283f8a6fc25@proton.me>

On Wed, Oct 02, 2024 at 03:02:18PM +0000, Benno Lossin wrote:
> On 01.10.24 16:59, Danilo Krummrich wrote:
> > `Vec` provides a contiguous growable array type with contents allocated
> > with the kernel's allocators (e.g. `Kmalloc`, `Vmalloc` or `KVmalloc`).
> > 
> > In contrast to Rust's stdlib `Vec` type, the kernel `Vec` type considers
> > the kernel's GFP flags for all appropriate functions, always reports
> > allocation failures through `Result<_, AllocError>` and remains
> > independent from unstable features.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/alloc.rs      |   6 +
> >  rust/kernel/alloc/kvec.rs | 637 ++++++++++++++++++++++++++++++++++++++
> 
> Any reason against naming this `vec.rs`?

I think I didn't rename kvec.rs and kbox.rs because we'd need to escape "box" in
various places, e.g. in rust/kernel/alloc.rs:

```
pub mod r#box;

pub use self::r#box::Box;
pub use self::r#box::KBox;
pub use self::r#box::VBox;
pub use self::r#box::KVBox;
```

And it's a kernel specific implementation, so kbox.rs and kvec.rs still makes
sense. :)

> 
> >  rust/kernel/prelude.rs    |   2 +-
> >  3 files changed, 644 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/alloc/kvec.rs
> 
> I share Gary's opinion, let's do future improvements via
> good-first-issues/patches in the current cycle. But get this version
> merged now.
> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> 
> ---
> Cheers,
> Benno
> 


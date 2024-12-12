Return-Path: <linux-kernel+bounces-442903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15C09EE3BB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A597283BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A8210F6A;
	Thu, 12 Dec 2024 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DNzJ76fr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B52101A3;
	Thu, 12 Dec 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998012; cv=none; b=m8i8Tea4wgzF2YRmXJqVC+PS9pCQ2tNOOkFY8mTdHYJ8S0+hgc+9fmTA+2odxjId1AtekbOon9bOQffh+RNnct9P4zcp3KniFjFKX5UiDPlN+MDT291FcBK7cqzVQ6wWvNkWE6fihjwwym1XYAiYA47+Lc79/PPok2rnkJukHjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998012; c=relaxed/simple;
	bh=//z0nlF9Ten2G/5k5BiYmvGlZ4CfbVMsXAvyUocRS+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCVv32KfRXq6/VwIFoJ6ByGLE2DaXvp4GdUDhQHfXhkKXqn8G4dmfUirsubZg3PYcXzxMh0n2/JNsKukma15ITjMZY2BwiOkizprKsWZv6KgS+nun/iF4gijXIv/yODE5kFVZfsbqlaZgJ5+eRqxLXSgxdwz8PeLwkud0xZ9SYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DNzJ76fr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oXW1NldzuCyEVJq6d3ZfUBAHkkt0UUL63vAbkA+kcA8=; b=DNzJ76frGJSJ7yoYrnnjT4vFsV
	QKWsJ01Q5Y7nzkJUveiAMxzxv7J7TBYzR2HE+Hp1Tvnybywx4FWMDz8dQ2ilFERpoog5xtlV7LlxA
	Mjg4c4N+rZRUa2kSqWTn6LMEhcnPSSN6g/Jp33xZ9LyKWamQeKpsFd4agOTPcGzXAeUrbJykfjtFy
	24TGCQdar/ZtAe7uJJhy9aZ4SVOtOD2MBc2mB+Z6/JEZwR8cH7NXRDBRee6juYzDCgxxHEspvI/mF
	JnFEsftq0+pO99mECD68Nqe4bdb9DPluJdPXIpqzg4sX+ww79lYn4WsvzfQBMJ600slrYigX8bC86
	nhdKRpfg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLg5i-00000004t05-2Xkb;
	Thu, 12 Dec 2024 10:06:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D0D52300230; Thu, 12 Dec 2024 11:06:41 +0100 (CET)
Date: Thu, 12 Dec 2024 11:06:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>, Filipe Xavier <felipe_life@live.com>
Subject: Re: [RFC 1/5] locking: MAINTAINERS: Start watching Rust locking
 primitives
Message-ID: <20241212100641.GW21636@noisy.programming.kicks-ass.net>
References: <20241128054022.19586-1-boqun.feng@gmail.com>
 <20241128054022.19586-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128054022.19586-2-boqun.feng@gmail.com>

On Wed, Nov 27, 2024 at 09:40:18PM -0800, Boqun Feng wrote:
> It makes sense to add Rust locking primitives under the watch of general
> locking primitives maintainers. This will encourage more reviews and
> find potential issues earlier. Hence add related Rust files into the
> LOCKING PRIMITIVES entry in MAINTAINERS.
> 
> While we are at it, change the role of myself into the maintainer of
> LOCKDEP and RUST to reflect my responsibility for the corresponding
> code.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

This seems fine with me; thanks for taking that up Boqun. I'm assuming
this whole series is aimed at the rust tree, in which case:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 443217066eb9..3a6a193fad99 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13351,8 +13351,8 @@ LOCKING PRIMITIVES
>  M:	Peter Zijlstra <peterz@infradead.org>
>  M:	Ingo Molnar <mingo@redhat.com>
>  M:	Will Deacon <will@kernel.org>
> +M:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP & RUST)
>  R:	Waiman Long <longman@redhat.com>
> -R:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP)
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> @@ -13366,6 +13366,11 @@ F:	include/linux/seqlock.h
>  F:	include/linux/spinlock*.h
>  F:	kernel/locking/
>  F:	lib/locking*.[ch]
> +F:	rust/helpers/mutex.c
> +F:	rust/helpers/spinlock.c
> +F:	rust/kernel/sync/lock.rs
> +F:	rust/kernel/sync/lock/
> +F:	rust/kernel/sync/locked_by.rs
>  X:	kernel/locking/locktorture.c
>  
>  LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP/Vista Dynamic Disks)
> -- 
> 2.39.5 (Apple Git-154)
> 


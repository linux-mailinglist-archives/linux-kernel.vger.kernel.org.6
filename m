Return-Path: <linux-kernel+bounces-536990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 134DAA486BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903BE3B5CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212BF1E51E8;
	Thu, 27 Feb 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFTWj5Mn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DE1DEFFD;
	Thu, 27 Feb 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677711; cv=none; b=RSrZo6JcumRRruAYYsDbidVPPCql8N1BmKLwVEGvTf50Nq6aLG2Vky3P9LL1hOFhNGrLOs+hbowMJxp7S3FojzqQLJqxpFWh3njhQKfs9IccmnNOSOlJ5SS7hy+A953goMk8UU9OBr8ny368dxcEwfHGGzk4UtFQrd7II7Wg4xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677711; c=relaxed/simple;
	bh=ey8ABS/p5vUBXOFJPmbtoJ/tRFgZYhZrBVTq4JyjQDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFt9XywtVO0fvLX5gPlnCEkuFObNDfegMhOoaEn/y122qY7yY3z6MHsH++Lt5C1hxI1yeeVp8ZIK5l4Y9D0hKykrHLoS6dgNF5UQb0ry1DY6B8U+KGf1dJl9xYxOvSZEsLQA1iYl0t+fpWK3K4y7MWOnRnnYpupRwMNNrM5VFjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFTWj5Mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FDCC4CEDD;
	Thu, 27 Feb 2025 17:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677710;
	bh=ey8ABS/p5vUBXOFJPmbtoJ/tRFgZYhZrBVTq4JyjQDQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lFTWj5MnYrsCAgU0ARCWVNpj30xfhEtQfvYkdsW5Tew7TwJHMLPOxTUQpZOctEPh9
	 UheY0twEBzeznHFgD4dlAEt+fPgORW40apw+ROIvO4NrhM1SNbXtvCEjdiC4HEcUrj
	 G7ahZrvE7gsp5eQ4UOY/epkXJR07JL5kiMwpBxMB3mHPRJ0KRVA0/gJZaS7yK8GrxJ
	 8ur/P5TwncksU7+2+xkIuPhNr7SnH20OGfVC/kcj/iRwKBAvXhEZxIR1jzTk+P17Yq
	 CcL4aXH3KhbovABO3AjLSK30mYqLowBxg8VJFEghgWneCbm+8i6oyyqIfqNcnTOBsK
	 c62We2LEAkrzA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8EEA2CE0799; Thu, 27 Feb 2025 09:35:10 -0800 (PST)
Date: Thu, 27 Feb 2025 09:35:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Gary Guo <gary@garyguo.net>, airlied@gmail.com,
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de,
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <54b92e98-cabf-4ddc-b51b-496626ac3ccb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
 <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
 <2f5a537b895250c40676d122a08d31e23a575b81.camel@tugraz.at>
 <20250227092949.137a39e9@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250227092949.137a39e9@gandalf.local.home>

On Thu, Feb 27, 2025 at 09:29:49AM -0500, Steven Rostedt wrote:
> On Thu, 27 Feb 2025 07:56:47 +0100
> Martin Uecker <uecker@tugraz.at> wrote:
> 
> > Observable is I/O and volatile accesses.  These are things considered
> > observable from the outside of a process and the only things an
> > optimizer has to preserve.  
> > 
> > Visibility is related to when stores are visible to other threads of
> > the same process. But this is just an internal concept to give
> > evaluation of expressions semantics in a multi-threaded 
> > program when objects are accessed from different threads. But 
> > the compiler is free to change any aspect of it, as  long as the 
> > observable behavior stays the same.
> > 
> > In practice the difference is not so big for a traditional
> > optimizer that only has a limited local view and where
> > "another thread" is basically part of the "outside world".
> 
> So basically you are saying that if the compiler has access to the entire
> program (sees the use cases for variables in all threads) that it can
> determine what is visible to other threads and what is not, and optimize
> accordingly?
> 
> Like LTO in the kernel?

LTO is a small step in that direction.  In the most extreme case, the
compiler simply takes a quick glance at the code and the input data and
oracularly generates the output.

Which is why my arguments against duplicating atomic loads have been
based on examples where doing so breaks basic arithmetic.  :-/

							Thanx, Paul


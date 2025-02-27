Return-Path: <linux-kernel+bounces-537149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F7A4888D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7879E188BF5E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AD426E654;
	Thu, 27 Feb 2025 19:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVvDI46L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2526E63F;
	Thu, 27 Feb 2025 19:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683457; cv=none; b=F1UHkoyUHL7WZVdaigVXoP9XxqmH0QJP3UjwMoM7BupuY7NFXHkgR/dy9De65ro/baEgBAwXB5vavsXxPAiOCyRzYAZk1FNDzt6qEl0T3t8hBJX5gp7bkf1IuILGHZ4P0MfbiE3VZBVhltP7PoSwTGKfkZaBOPnbbmofVUegPuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683457; c=relaxed/simple;
	bh=IcMDrCFUyWWuyUKJigwMhEoRpg9pbvdpgup3hiDyvDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh7wcse4ZwmMV339f8he3dVFKbWYfKsUnnWnjbTlX5y2GACv16wsaUNV151OponzlveaXuMFgPDgNwZn3sr5YXFRQK6M7QhD3q8TGvWIOpksZXh18iBG0yJNnE748Req6wD8VT2c/j37FqdvNJd3JpvFqGwYOn5rQXdq/D8Aw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVvDI46L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16031C4CEDD;
	Thu, 27 Feb 2025 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740683457;
	bh=IcMDrCFUyWWuyUKJigwMhEoRpg9pbvdpgup3hiDyvDU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hVvDI46LbUUXBr217w1MRrLcEeobjX7mjWP4O7tNTyNZVmNa+MB+bXIzYq60GmwJb
	 sKwn+a4DALi9NxsdqbIh6AlAz24ODpQihY1e/7VjUoJRKl9mhMRsFQrGIq66ZEvb01
	 Kh2TcqrcYfOzX9/FrSBfbhJ81T0QXC6GZQXDdeHYDeq385IT9n9n5PtTW5U52UiCUQ
	 684nueLx7haLKuWnU+Lj8Tgidu2XK5ls5HMKOZ6eYe1q8+LinUwwaV8OlqbAgj+LoB
	 Z0qIq76UYMBFI47woSjOtLfi8GIH/6APmESbJyKmBi9pSznN7sp6hSc0PK2hg0k1sv
	 sc4SC1TngzUmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9BF80CE0799; Thu, 27 Feb 2025 11:10:56 -0800 (PST)
Date: Thu, 27 Feb 2025 11:10:56 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Martin Uecker <uecker@tugraz.at>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>,
	airlied@gmail.com, boqun.feng@gmail.com,
	david.laight.linux@gmail.com, ej@inai.de,
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <5ef99795-8d4e-48f9-909a-d752dc24c023@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
 <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
 <2f5a537b895250c40676d122a08d31e23a575b81.camel@tugraz.at>
 <20250227092949.137a39e9@gandalf.local.home>
 <54b92e98-cabf-4ddc-b51b-496626ac3ccb@paulmck-laptop>
 <czke6xumgufksyvu7xgin2ygn2jx6uvgtgwfknafq4s4migccz@aih2ptkzw3jx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <czke6xumgufksyvu7xgin2ygn2jx6uvgtgwfknafq4s4migccz@aih2ptkzw3jx>

On Thu, Feb 27, 2025 at 01:13:40PM -0500, Kent Overstreet wrote:
> On Thu, Feb 27, 2025 at 09:35:10AM -0800, Paul E. McKenney wrote:
> > On Thu, Feb 27, 2025 at 09:29:49AM -0500, Steven Rostedt wrote:
> > > On Thu, 27 Feb 2025 07:56:47 +0100
> > > Martin Uecker <uecker@tugraz.at> wrote:
> > > 
> > > > Observable is I/O and volatile accesses.  These are things considered
> > > > observable from the outside of a process and the only things an
> > > > optimizer has to preserve.  
> > > > 
> > > > Visibility is related to when stores are visible to other threads of
> > > > the same process. But this is just an internal concept to give
> > > > evaluation of expressions semantics in a multi-threaded 
> > > > program when objects are accessed from different threads. But 
> > > > the compiler is free to change any aspect of it, as  long as the 
> > > > observable behavior stays the same.
> > > > 
> > > > In practice the difference is not so big for a traditional
> > > > optimizer that only has a limited local view and where
> > > > "another thread" is basically part of the "outside world".
> > > 
> > > So basically you are saying that if the compiler has access to the entire
> > > program (sees the use cases for variables in all threads) that it can
> > > determine what is visible to other threads and what is not, and optimize
> > > accordingly?
> > > 
> > > Like LTO in the kernel?
> > 
> > LTO is a small step in that direction.  In the most extreme case, the
> > compiler simply takes a quick glance at the code and the input data and
> > oracularly generates the output.
> > 
> > Which is why my arguments against duplicating atomic loads have been
> > based on examples where doing so breaks basic arithmetic.  :-/
> 
> Please tell me that wasn't something that seriously needed to be said...

You are really asking me to lie to you?  ;-)

							Thanx, Paul


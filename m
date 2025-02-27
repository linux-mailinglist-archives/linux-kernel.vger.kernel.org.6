Return-Path: <linux-kernel+bounces-537054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E77D3A4878D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC4D016B197
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F9B1F5857;
	Thu, 27 Feb 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QY9aK830"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8581F5821
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680029; cv=none; b=DaowbBBiOIe+mmYZU1cKbwibllU/CqyFSHDIMNMOADLGSxavow7EDiZNngUBWvTb9BnhtxDNaFRjbTt0blozDpUGoYYCUtKVqo6xC2YAq2kKX3zcm42Bi0ZUv+SGU0lIFeTU3BnLSpPgX0halmKADcrDVSB+s2ArzlyQ7fy1/PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680029; c=relaxed/simple;
	bh=7imsQZUmHAdh0eNzgSer2Z0qckCWf9otlLGyNA+uz/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNpBBBjvRsa0eXq9ULyM84eofEBH4qjCQ/C8IoX7dSwg1ecP+P7V1eotJ/z5ozPjS9xkLBPuBEefCftQUE9Wnsmo/66iM4sNsmT89m6IFuUkKnnCvd4f/W4bAuXeTJFzFRjIQ/d/IkRFuSGfBPX7XHyWk6zQIBw1rhZ33wPBXPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QY9aK830; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 13:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740680026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SDLHKCyT2rrolHtXm3DioQqLj/OwZed4ywF3mGt1m3k=;
	b=QY9aK830EGCr7nXAJ0NuKY2XFe+53n+1RGSy8yoJZTVI4Luj+fJ+taJd7btgRmbXyZL4te
	hI/d3ZLOqaPfqN5mjpflbtlh22CRuqCfhrbozHppNADeEnpPqVay7VRrIpQtcvscjeWjGQ
	51lejRUI4eKECiyqI5toQxZgZ9kpqVw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Martin Uecker <uecker@tugraz.at>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Ralf Jung <post@ralfj.de>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <czke6xumgufksyvu7xgin2ygn2jx6uvgtgwfknafq4s4migccz@aih2ptkzw3jx>
References: <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <09e282a9c02fb07ba4fc248f14c0173d9b19179a.camel@tugraz.at>
 <CAHk-=wjqmHD-3QQ_9o4hrkhH57pTs3c1zuU0EdXYW23Vo0KTmQ@mail.gmail.com>
 <2f5a537b895250c40676d122a08d31e23a575b81.camel@tugraz.at>
 <20250227092949.137a39e9@gandalf.local.home>
 <54b92e98-cabf-4ddc-b51b-496626ac3ccb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54b92e98-cabf-4ddc-b51b-496626ac3ccb@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 09:35:10AM -0800, Paul E. McKenney wrote:
> On Thu, Feb 27, 2025 at 09:29:49AM -0500, Steven Rostedt wrote:
> > On Thu, 27 Feb 2025 07:56:47 +0100
> > Martin Uecker <uecker@tugraz.at> wrote:
> > 
> > > Observable is I/O and volatile accesses.  These are things considered
> > > observable from the outside of a process and the only things an
> > > optimizer has to preserve.  
> > > 
> > > Visibility is related to when stores are visible to other threads of
> > > the same process. But this is just an internal concept to give
> > > evaluation of expressions semantics in a multi-threaded 
> > > program when objects are accessed from different threads. But 
> > > the compiler is free to change any aspect of it, as  long as the 
> > > observable behavior stays the same.
> > > 
> > > In practice the difference is not so big for a traditional
> > > optimizer that only has a limited local view and where
> > > "another thread" is basically part of the "outside world".
> > 
> > So basically you are saying that if the compiler has access to the entire
> > program (sees the use cases for variables in all threads) that it can
> > determine what is visible to other threads and what is not, and optimize
> > accordingly?
> > 
> > Like LTO in the kernel?
> 
> LTO is a small step in that direction.  In the most extreme case, the
> compiler simply takes a quick glance at the code and the input data and
> oracularly generates the output.
> 
> Which is why my arguments against duplicating atomic loads have been
> based on examples where doing so breaks basic arithmetic.  :-/

Please tell me that wasn't something that seriously needed to be said...


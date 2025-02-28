Return-Path: <linux-kernel+bounces-539493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0972A4A50C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F03381728D6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBE71D9A5D;
	Fri, 28 Feb 2025 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCqTnMgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05D1D14FF;
	Fri, 28 Feb 2025 21:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778182; cv=none; b=e6aBsN4W5DVeyID3j73oJoNopeLIN+vXMnjSSGHL7Ls8+wQPEc6TzipZ8wfsuTlyHUtaDAEWO7D+WRRBzh3JE285kTkPBXSuUdP2Q1litbZ5fOANPCIbnQ2W9ggqMZs4XsQzMCEyLKCLx1zgHAacr3+FoBqn59S3FBvCqtxrCLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778182; c=relaxed/simple;
	bh=WpiVu7G/gcbEeYsk0cZWhzU9IoiNFSi9tQN7+E70E/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACMo9s1DpG3LsTMaIJI+pnDMHiyi10TFNtLItNEzw07ds1oryChW+EnHKHtvVlRW8VjunL/0MooJBK5KVPOBCPriklQzo8V9dF7bcudI+7f4NGBd5SUYfiBHMn8L+uD2CSiwf2+0SpjmJakKxo+tVNktm1mfDhDsC5/mkXf54lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCqTnMgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44D1C4CED6;
	Fri, 28 Feb 2025 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740778181;
	bh=WpiVu7G/gcbEeYsk0cZWhzU9IoiNFSi9tQN7+E70E/U=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KCqTnMgVZuiubKIq3Pe73kKLpBSoxSEgapK1uRgJAzodbAGBKhbwMI8D4DxZCWcVq
	 Ia3/J6lTtOoBlZLrObo6+sVsrT/wKVRvx0vuMYoTk9tDVO6MdaPZZgqdQ++ZgLuWxV
	 ownqmVOkfsk8PMk3VSzOe9Mjc4uy853/C1YSoNlD3Nx52WCPNUQu/W9GY6h17JgBAl
	 OktAqIBVcGcgLCqFOM+mJQPeV2r8pZLN19uK2vqVxyZyiLWUHK58gJ2z+3/4nV1Hl+
	 sRqCW15aNNpk05wpqCgW+HhaJY9n7K/wvYRni+/KwfUxrbIwjezsw0DYjCJeG+iy6X
	 IvMqLoudr5DmA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7BE1DCE0DEB; Fri, 28 Feb 2025 13:29:41 -0800 (PST)
Date: Fri, 28 Feb 2025 13:29:41 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>,
	Alice Ryhl <aliceryhl@google.com>,
	Ventura Jack <venturajack85@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Gary Guo <gary@garyguo.net>, airlied@gmail.com,
	boqun.feng@gmail.com, ej@inai.de, gregkh@linuxfoundation.org,
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <30fb630e-2bba-43d3-8d80-4ad553d503ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home>
 <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home>
 <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com>
 <20250226173534.44b42190@gandalf.local.home>
 <20250227204722.653ce86b@pumpkin>
 <20250227163319.5b19a68a@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227163319.5b19a68a@gandalf.local.home>

On Thu, Feb 27, 2025 at 04:33:19PM -0500, Steven Rostedt wrote:
> On Thu, 27 Feb 2025 20:47:22 +0000
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > Except that (IIRC) it is actually valid for the compiler to write something
> > entirely unrelated to a memory location before writing the expected value.
> > (eg use it instead of stack for a register spill+reload.)
> > Not gcc doesn't do that - but the standard lets it do it.
> 
> I call that a bug in the specification ;-)

Please feel free to write a working paper to get it changed.  ;-)

							Thanx, Paul


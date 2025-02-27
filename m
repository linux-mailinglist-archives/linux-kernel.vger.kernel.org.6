Return-Path: <linux-kernel+bounces-535224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3DEA4704D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65BDA188D5F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0252F39FCE;
	Thu, 27 Feb 2025 00:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O2BpLRBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542678F40;
	Thu, 27 Feb 2025 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740616521; cv=none; b=fDhpFiR2d8uOcmRmX44gx4w+3w1VCzANf9WfunCiZGOPKL9VnST3c9LQW3wuOLkxDApUUELxoXq7Sjo1M07tkE9GlctGYcyahJf03qtkU3LkAcHxyERgW6STjJnpTVmP1oM1Q+Kw6toiPqvy2wVa4aSfAdvJuvhRrzgBSk2iBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740616521; c=relaxed/simple;
	bh=Wy7Ps2b9jvFus5J5E7BSRLli4kUSB0c6CXczlzQwknI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhwNsza5s5F6UtmaJ9cKYP5Q5/pLUqb5znuWFJKa7b7l7NxSVgACrkytUZX0bQIS1zN7P4s8/jcwyitISySLiYs5Sdb2bmTp3qk5zsncooKY4foFqWsf1tvFwLaVDxL7wNk4cUVPWaiME1UXAxLvEQvT+3I5+tlan+0DQ8S0OhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O2BpLRBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1504C4CED6;
	Thu, 27 Feb 2025 00:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740616518;
	bh=Wy7Ps2b9jvFus5J5E7BSRLli4kUSB0c6CXczlzQwknI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=O2BpLRBh57E3c+cqDfMq5RttyAnwFMCrNNq1wt72LSvdsUvOU7W7vQtmK9hgWXSsP
	 pHgssPAaYW725Cpq+mUxwx/Sy9fgisXC+jy6e4AXYX9LC6CA0eNyFmJZ0ggeSYW0Ld
	 3rqE2YsVP47A6kPp3NhSaTvmZ/+khU1kMjKqKb5aSqvMM/YO09nVoGX6J1QwosErET
	 JRlw8eXH4nYyRcCqmBRZKsXIiHtsrRPwfcBEcDIe5BSghOl+HhLmu19Pklpv+NWcJh
	 /4+9dIWCJTnr4eIsdydKeL9q5S2r534Y/DXooHg1lxO/YE8W4wejYe7IfwM16l+G2G
	 44YTcXJ/BLihw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 650F5CE1680; Wed, 26 Feb 2025 16:35:18 -0800 (PST)
Date: Wed, 26 Feb 2025 16:35:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <0cca6df4-ec77-40d4-8714-b46a18cc6a82@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <CAHk-=wj3C7Gc7pB0BD+5dvrFWh8xNJLYgupq6parOCFk94VyoA@mail.gmail.com>
 <20250226225412.35133185@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226225412.35133185@pumpkin>

On Wed, Feb 26, 2025 at 10:54:12PM +0000, David Laight wrote:
> On Wed, 26 Feb 2025 13:21:41 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > On Wed, 26 Feb 2025 at 13:14, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > That "single read done as multiple reads" is sadly still accepted by
> > > the C standard, as far as I can tell. Because the standard still
> > > considers it "unobservable" unless I've missed some update.  
> > 
> > I want to clarify that I'm talking about perfectly normal and entirely
> > unannotated variable accesses.
> > 
> > Don't say "programmers should annotate their special accesses with
> > volatile if they want to avoid compiler-introduced TOCTOU issues".
> > 
> > Having humans have to work around failures in the language is not the way to go.
> > 
> > Particularly when there isn't even any advantage to it. I'm pretty
> > sure neither clang nor gcc actually rematerialize reads from memory,
> 
> I thought some of the very early READ_ONCE() were added because there
> was an actual problem with the generated code.
> But it has got entirely silly.
> In many cases gcc will generate an extra register-register transfer
> for a volatile read - I've seen it do a byte read, register move and
> then and with 0xff.
> I think adding a separate memory barrier would stop the read being
> rematerialized - but you also need to stop it doing (for example)
> two byte accesses for a 16bit variable - arm32 has a limited offset
> for 16bit memory accesses, so the compiler might be tempted to do
> two byte writes.

Perhaps some day GCC __atomic_load_n(__ATOMIC_RELAXED) will do what we
want for READ_ONCE().  Not holding my breath, though.  ;-)

							Thanx, Paul


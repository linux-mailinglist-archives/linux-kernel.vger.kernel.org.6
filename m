Return-Path: <linux-kernel+bounces-527420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCAAA40B11
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ED503BFF2B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D3020F063;
	Sat, 22 Feb 2025 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gNXDrDA3"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E261D5CCC
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740250498; cv=none; b=YnkjqezbYhlHFx3c9dreaq4Cw4VQZeP63yHDSPV+ih4MCvOuykyC80ypUWpJRcwqwsT0xTwHmRdGQyIk+2v9ewr8rGyqDEHg3JkzrfZEUi1K+2mAZ5M1uVJnpZAQZinTMq6NQ+GAsexcmTfvzfWt/hzukk9obu5ErLkYZ8lNod4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740250498; c=relaxed/simple;
	bh=YDAq+cRRsLy+ykmpjVQTrj4RQ5j+1r2N4JxfkFyTpvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enwiLb/HrbQBSfXJBjWH19yXeD7HIk4HdGlL4DXo77s6HGoK3DUyZxKg2gx4X/ai+GWvyJhQqwHdulul6GyjCFYsZ7+pdneKHNHTEQj72qSJuJSzMt5kHLsmIPHRUBojua3uA8B/uCQ7tNpnrQHTYCNTCVhdrRhm7UJQlDzew+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gNXDrDA3; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 13:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740250483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaY9ztTmxQj/0q0Xoo11s2UkO0IE8e6MpwmitiAkFo4=;
	b=gNXDrDA3IaRD8gD0pWOXh8tUlKCmpL9MLcRgZTxDvKOC3J4JVKr3a4lu1fVX95k4eX85Zh
	ZqJhdU1ylTCEHwN01ar/NuVqVE0WEq0Hyy7teuUrEmS2uqD6dOEkHudKqRnvRy+C5XaRI3
	qo50Q8iNkCsKvY3Lf56/ukiVycyB3bA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Ventura Jack <venturajack85@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, torvalds@linux-foundation.org, 
	airlied@gmail.com, boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 08:03:29AM -0700, Ventura Jack wrote:
> On Sat, Feb 22, 2025 at 7:15 AM Gary Guo <gary@garyguo.net> wrote:
> >
> > On Sat, 22 Feb 2025 03:06:44 -0700
> > Ventura Jack <venturajack85@gmail.com> wrote:
> >
> > > >Gcc used to initialize it all, but as of gcc-15 it apparently says
> > > >"Oh, the standard allows this crazy behavior, so we'll do it by
> > > default".
> > > >
> > > >Yeah. People love to talk about "safe C", but compiler people have
> > > >actively tried to make C unsafer for decades. The C standards
> > > >committee has been complicit. I've ranted about the crazy C alias
> > > >rules before.
> > >
> > > Unsafe Rust actually has way stricter rules for aliasing than C. For
> > > you and others who don't like C's aliasing, it may be best to avoid
> > > unsafe Rust.
> > >
> >
> > I think the frequently criticized C aliasing rules are *type-based
> > aliasing*. Rust does not have type based aliasing restrictions.
> >
> > It does have mutability based aliasing rules, but that's easier to
> > reason about, and we have mechanisms to disable them if needed at much
> > finer granularity.
> >
> > Best,
> > Gary
> 
> Are you sure that unsafe Rust has easier to reason about aliasing
> rules? Last I checked, there are two different models related to
> aliasing, tree borrows and stacked borrows, both at an experimental
> research stage. And the rules for aliasing in unsafe Rust are not yet
> fully defined. https://chadaustin.me/2024/10/intrusive-linked-list-in-rust/
> has some commentary on the aliasing rules.
> 
> From the blog post:
> >The aliasing rules in Rust are not fully defined.
> 
> Other blog posts and videos have likewise described unsafe Rust as
> being harder than C to reason about and get correct, explicitly
> mentioning the aliasing rules of unsafe Rust as being one reason
> unsafe Rust is harder than C.

I believe (Miguel was talking about this at one of the conferences,
maybe he'll chime in) that there was work in progress to solidify the
aliasing and ownership rules at the unsafe level, but it sounded like it
may have still been an area of research.

If that work is successful it could lead to significant improvements in
code generation, since aliasing causes a lot of unnecessary spills and
reloads - VLIW could finally become practical.


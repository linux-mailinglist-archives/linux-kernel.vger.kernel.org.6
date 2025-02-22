Return-Path: <linux-kernel+bounces-527471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA246A40B99
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708E4175486
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930A9202F9A;
	Sat, 22 Feb 2025 20:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SJdqWBsA"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAA1D63D3
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740257393; cv=none; b=XLfvGu79Uhi8uVGX12+/pFeMlrV4O5w4lG5BEIzes0h1voamry1DzggKv76NANvODQ0uHaz7E1nfjdxVufbUZyeBFcMVVC87ox1YtFUjYWmWo9Dol+gTnll3KY3tjWkahYpgdSnD6DOGGpBDG1V0vwaII4Fyvoc6Ov14eR3zcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740257393; c=relaxed/simple;
	bh=3w7H+jIo6otmlxFlbAf99skQW2XjsB2m65ucYf3JZIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KK0It+tSBgV9IUUQHEA8NBoDI/7OeJetfi6cWfMqoQP55X3MOHIeOUKIVSqjVW958U0dSo7+PEl58lQTc/s0qNF/MXEvJfqCAbM4jPLjn0HNUXdzsuzysGm6rGN8THy++aQ45BuF3wqIkcU/Zja73lYXkDdN4JSLZLd8ikiyAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SJdqWBsA; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 22 Feb 2025 15:49:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740257379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M7irQiW8qwpyGnceNIn1BMN3Gn6knqxNjwqf8h3sTCA=;
	b=SJdqWBsAeInXO2zAEudB778i4wO1QtTa8o0ealGUml6aoGRRvC0I5jXiz70jL5XKuLl/qX
	KZw6PAWt1HM1Le2aKZj7VhUEJyfqxPkDvaRc+qGEbc/SwJoXVgDEDp88cSz9nASWYtzluK
	JqraK7DImGF/lRoJegdm399Lci3KVJY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, 
	torvalds@linux-foundation.org, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, hch@infradead.org, 
	hpa@zytor.com, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Ralf Jung <post@ralfj.de>
Subject: Re: C aggregate passing (Rust kernel policy)
Message-ID: <lz7hsnvexoywjgdor33mcjrcztxpf7lzvw3khwzd5rifetwrcf@g527ypfkbhp2>
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo>
 <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72mdzUJocjXhPRQEEdgRXsr+TEMt99V5-9R7TjKB7Dtfaw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 22, 2025 at 08:41:52PM +0100, Miguel Ojeda wrote:
> On Sat, Feb 22, 2025 at 7:54 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > I believe (Miguel was talking about this at one of the conferences,
> > maybe he'll chime in) that there was work in progress to solidify the
> > aliasing and ownership rules at the unsafe level, but it sounded like it
> > may have still been an area of research.
> 
> Not sure what I said, but Cc'ing Ralf in case he has time and wants to
> share something on this (thanks in advance!).

Yeah, this looks like just the thing. At the conference you were talking
more about memory provenance in C, if memory serves there was cross
pollination going on between the C and Rust folks - did anything come of
the C side?

> 
> From a quick look, Tree Borrows was submitted for publication back in November:
> 
>     https://jhostert.de/assets/pdf/papers/villani2024trees.pdf
>     https://perso.crans.org/vanille/treebor/

That's it.

This looks fantastic, much further along than the last time I looked.
The only question I'm trying to answer is whether it's been pushed far
enough into llvm for the optimization opportunities to be realized - I'd
quite like to take a look at some generated code.


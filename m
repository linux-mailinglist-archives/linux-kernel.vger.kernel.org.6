Return-Path: <linux-kernel+bounces-268132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4539420BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D8B1F23E91
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40C18C938;
	Tue, 30 Jul 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kkih7tUL"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10896E573
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722368327; cv=none; b=uznXHr7Q/D9rMW6AQcOtIp94c16b1Nna3wjTrxOnrWjqC+HHMWpZSjfQDxwCfUS0264WabadzOnfUAlQRreUu/MAwsnuhWHsbgtr6vYatawQEl3yEFD+Mx7ZNb6V8bCvQZSXWsfr4M6UVGlpMvV9NUEVHgLrk/MkBGsZRp2DUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722368327; c=relaxed/simple;
	bh=rslhWtrvQ9mk+QWH55Eo3kU1eTDQX6P/vW/HHjoC1BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h40rC+oVpS7YFDVSrnoTn74Z6qtE6ScHL98c7s1NxYnFc5SWGn7uTuCktUbb7rcwQidreYu9YQGhlMr9ROxdTKoJzmFTXGWr8/v0s6ZYWTI9S6oX8XuJ5r1AmlLK4lWydsddoue+3DlX22x5p4FE7sUzo9zYJBHlyegPKmuy5Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kkih7tUL; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sYTBm2JyQE4Fqzv992X+FDRLe/C2+ewskX/9CEbqAns=; b=Kkih7tULFXS4IO8Pxbp7kpL6ms
	/vD6gzBtEnjtlpG57gFTBskjcMTurJw1wTAyQzZUs9lKaDZ7VAoPYxc6J/DSMcRL+OMoYA1vimpIS
	VIPwj7jPBFOcFpQjT3Mj1+AWeVodobmTzsPXKHEFNwvtzBzR6EMzZnYcIEQTKs4pXTZ0Di4ufSO/D
	PJfNuZS3lcS4b0HAV78AJhj1jFIQJzHRYrd29A0F8M0FmuiHQHhmJT4v4GKFPDCs9D1IgH58k5CQ/
	cKa1cf69z5e3CKQKF/UV2LE1qk0cG98hl8m1tiNPCQjj84RZmso3YGKhJ3ytUiskrTbSdxdHBFwT8
	cQB5b0nQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYsgD-000000054jB-2Lgo;
	Tue, 30 Jul 2024 19:38:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 34B313003EA; Tue, 30 Jul 2024 21:38:41 +0200 (CEST)
Date: Tue, 30 Jul 2024 21:38:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240730193841.GS33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>

On Tue, Jul 30, 2024 at 01:31:18PM -0600, Jens Axboe wrote:
> On 7/30/24 1:22 PM, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:
> > 
> >> Which makes me think it's asm_exc_int3 just recursively failing.
> > 
> > Sounds like text_poke() going sideways, there's a jump_label fail out
> > there:
> > 
> >  https://lkml.kernel.org/r/20240730132626.GV26599@noisy.programming.kicks-ass.net
> 
> No change with this applied...
> 
> Also not sure if you read my link, but a few things to note:
> 
> - It only happens with gcc-11 here. I tried 12/13/14 and those
>   are fine, don't have anything older

One of my test boxes has 4.4 4.6 4.8 4.9 5 6 8 9 10 11 12 13

(now I gotta go figure out wth 7 went :-) And yeah, we don't support
most of those version anymore (phew).

So if its easy to setup, I could try older GCCs.

> - It only happens with KFENCE enabled.

I missed the KFENCE bit. Happen to have the .config handy, I couldn't
make much sense of Gunther's website in a hurry.



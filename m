Return-Path: <linux-kernel+bounces-268184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8F0942151
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3121C23A41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943DB18CC11;
	Tue, 30 Jul 2024 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NpaD22tN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C4518B479
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370203; cv=none; b=as9YrvhPTF9PfBukJ8lPRs2PVcOcPjQvU7CtxHKtzUYHKnjQMRW4TW/JASdaEnmHt0j7k32licI6LL9W+UxN0TTBBjqrnZWJE/UTEaUAraG3I2x8yPS4yPvYQM77307rx7K8rIdqjJ8zcl+UkmfFOaAF6Q0Z0bfVXuJ34MNwXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370203; c=relaxed/simple;
	bh=iLOeGKnDishYvfMscY5qaYBG9052ZD8smIYRwg+XmSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQCTF3Fnu6ovQw3RdC8aExv9TvUA+iyTIdc8cipWq/U9A54IBL8wrc0tmZh/Uj9ARtBpUslYzgw7E5syoCXsHp7ZgnbeNfMbuPciIc1lPExhy8Pe+u3AEXW8S3vXtWL9I4UduWWONELuxXroAVzMk0ai6hGS6XrzVGxZfrF3nTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NpaD22tN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ygQcz9ZWLapBmOyXGj0quqijSOH9bRVxNbuCShyt1GA=; b=NpaD22tNnm6z/JoHW31XYFIsxu
	3Upz7sTMBbRoVE2dztLkXfeAN9yEg4W3iIkTQzzeMzphQPIYRJla8yAYPgDfM7TFu2AoplqlDrR0E
	pr/lIlyETGgiV4iIvEJZdHiItnNr+88i9IBHAvB2fxB0E4UzROLpkd9kwRuLrxBMws1WZrt8Q9Pzy
	GlSISn/8l77aYfxoYValUh8M1evu9zMMYLGm90oAsAIm7qX2xSuo4JcPCtkK+oxolbaxEbh3fCwJp
	j6zgS5yRJBOx5SCDBe8sV8GOSI/xhCxmLH661bYAoQXj99Ykiog7ViROFe/lFAVyiCy/fd1GhlKWl
	16S/VamQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYtAK-000000054sl-1TD4;
	Tue, 30 Jul 2024 20:09:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F95D3003EA; Tue, 30 Jul 2024 22:09:47 +0200 (CEST)
Date: Tue, 30 Jul 2024 22:09:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240730200947.GT33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>

On Tue, Jul 30, 2024 at 01:04:49PM -0700, Guenter Roeck wrote:
> On 7/30/24 12:38, Peter Zijlstra wrote:
> > On Tue, Jul 30, 2024 at 01:31:18PM -0600, Jens Axboe wrote:
> > > On 7/30/24 1:22 PM, Peter Zijlstra wrote:
> > > > On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:
> > > > 
> > > > > Which makes me think it's asm_exc_int3 just recursively failing.
> > > > 
> > > > Sounds like text_poke() going sideways, there's a jump_label fail out
> > > > there:
> > > > 
> > > >   https://lkml.kernel.org/r/20240730132626.GV26599@noisy.programming.kicks-ass.net
> > > 
> > > No change with this applied...
> > > 
> > > Also not sure if you read my link, but a few things to note:
> > > 
> > > - It only happens with gcc-11 here. I tried 12/13/14 and those
> > >    are fine, don't have anything older
> > 
> > One of my test boxes has 4.4 4.6 4.8 4.9 5 6 8 9 10 11 12 13
> > 
> > (now I gotta go figure out wth 7 went :-) And yeah, we don't support
> > most of those version anymore (phew).
> > 
> > So if its easy to setup, I could try older GCCs.
> > 
> 
> WFM with gcc 9.4, 10.3, 12.4, and 13.3. gcc 11.4 and 11.5 both fail.

10.5 and 13.2 worked for me, and I can confirm 11.4 makes it go boom.

> Maybe I should just switch to a more recent version of gcc and call it a day,
> in the hope that it is a compiler (or qemu) problem and doesn't just hide
> the problem.
> 
> Thoughts ?

Tempting, but I think it would be good to figure out what in GCC-11
makes it sad, gcc-11 is still well within the supported range of GCCs
afaik.

Lets see if its something that wants to be bisected.


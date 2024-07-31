Return-Path: <linux-kernel+bounces-269348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401029431D1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C07B2135A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B751B3F33;
	Wed, 31 Jul 2024 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="II6jRdgR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B31B3758
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435315; cv=none; b=B+Kv7LWMZa8S6UH1aTkqFLWDQ0WipTNh9RKCPB2eFslQ/39ZcvPnWCelwod+/sZ3yWlJP9jmvNKy5CQk8IYDoFyxmeRaUr6EiaydrKj6zi0/NYaxWzVq70xPwyIo3J77wK3CYJJoy3+Dr1+lzbJScrg+ioTplXaMacP0OXDKumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435315; c=relaxed/simple;
	bh=J+LMvz9Wx/sbtipj3UJuhOh6MMDNixyLt0xfqWXQB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZwxThCqE3Y0hNY+qE/wis/5SwfwBnJelgp6YnaoWbVaJlVce/pKoMvOEinpOYw6lwnTG7a3YX9pzxdIzPLUWIJIeyLsnkSIVKyv8gTyeX0OC3KMqAB4Y/2fAZ1GcWb54aGy5eXwKSJu7KcJvWiVa5PS5uOMPyu1GtwbmQ/kENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=II6jRdgR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v2MjKDfUsFkxxPTojbHvkJty1eTdehfkI3cDRFuQ0fk=; b=II6jRdgRPQ0wHti8+960mxvn3f
	hRlgru/ycUkHCDI7r/gpvLOLwJZINr52KkTBAZSMnvp/nIcBWUpONqMsxV7zTIJVQV9OMZVxfxGpt
	+eq9FBYyDkUg60OZoT6lISPIxSBz6tkFkrX9SeSsQ9wvjO/5eyA5UaNpYuQCg17akwBv92iwWC81C
	6EZcAwkvAK6xj8ZreTknzYS4hOJIP5DX+BedKFuaVwjjaerNyx7UdddWEfC4twndJmo3RPPTl2Dn6
	sWlSH+MIyhOdetGJWPxYVSNtGZHpirHcn1j3ZlyoBHghMu5snR1QRAQcH31mi7JQe+AK755jAKbn+
	d9049Fvw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZA6e-0000000GDGs-0Mo7;
	Wed, 31 Jul 2024 14:15:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1D8C9300820; Wed, 31 Jul 2024 16:15:07 +0200 (CEST)
Date: Wed, 31 Jul 2024 16:15:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731141507.GX12673@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240731103332.GX33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731103332.GX33588@noisy.programming.kicks-ass.net>

On Wed, Jul 31, 2024 at 12:33:32PM +0200, Peter Zijlstra wrote:
> On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:
> 
> > Definitely something wrong with the page tables. But where that
> > wrongness comes from, I have no idea.
> 
> [   10.231081] CR0: 80050033 CR2: ffa02ffc CR3: 02bc6000 CR4: 000006f0
> 
> See CR3 being a user address.... but yeah, million dollar question is
> how the fuck did that happen?

Thomas just reminded me that CR3 is physical... duh.


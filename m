Return-Path: <linux-kernel+bounces-350026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2183898FEE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06651F2203F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3838E13D279;
	Fri,  4 Oct 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4IQEsx+"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FE96F305
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728030033; cv=none; b=rm6ZqeI0FjQn0z9yuYRuzXC3bl1VYDzBsULIiI/A9Pjeu/FtU7ES17szLfbL9tnbaDEJszSSUrDP5qh16s8DU7hOdvd/t3bgsKmEPa/3FHwPVa+nCcEjC3tZVIPCZiTUb+xuqnNDh7OZ5dvAAvRB3Pr3c05RXJArJV8D1phuXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728030033; c=relaxed/simple;
	bh=ZTytNPoI1VsiU8vbCiKMrPwgYutTd9w1EooYJZH5ciI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKxciZBHyUNYYMGBqi7+/Vk/u/7P1MbYUso3M0TOZKKi1Kqd1+lzRClYIeHp8B2BckmQJkOTbC/xdnmnWj6lNBo+EZCE6VkWW8ugbFkQ4VkbteRwELERrVXWZgzz54TY3NU+z1VPFUIimolimE9ad4AM73o78jqUQ7QksAaAHfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S4IQEsx+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OG2Hy7O/HuXLeaaWC5ImIXY8TC2ou3U1Aw6NVwwEboQ=; b=S4IQEsx+yNb/ccTKq3NGKtvJRL
	afXVh60mkDKwdRjNdfa6YpDDUKNqhj/A6wdDe1m8H+we33Vodik+fpzCrAQgA1+YNhgH98OlbcHn1
	ozjbZywBO6GACH4ZlEHD7fC0GPFaznPm5akgprqNlYsiZPoJJsVD9B31cz53PuMPojfOO8aUdG9UJ
	0S13H0EQzKvbfSgrvKObcrDBJZblN1HB+6t5U68OXWLSsWvZ5+cWmhYPgwH8dxM7+5ARE7OuwpnqG
	Im/34Gt606nJ4FatadBG+rhIBhDLd61LEaEgRECB9STcmC/3vF8P5MNO2ByXxWUXM9AxpZza93tf0
	qcdZGdVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swdY5-00000003nmV-2Kdk;
	Fri, 04 Oct 2024 08:20:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38AB030083E; Fri,  4 Oct 2024 10:20:29 +0200 (CEST)
Date: Fri, 4 Oct 2024 10:20:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Detect non-relocated text references
Message-ID: <20241004082029.GG18071@noisy.programming.kicks-ass.net>
References: <05fd690797ea4e1ee798b7fa497857519ae840d4.1728001850.git.jpoimboe@kernel.org>
 <CAMj1kXHt3GTVx-Ow0OZaP4WW7k=RVc+jgtC-4qOSZM3js4jo0g@mail.gmail.com>
 <20241004072847.zihm6dw7y5m4e2lb@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004072847.zihm6dw7y5m4e2lb@treble>

On Fri, Oct 04, 2024 at 12:28:47AM -0700, Josh Poimboeuf wrote:
> On Fri, Oct 04, 2024 at 08:54:16AM +0200, Ard Biesheuvel wrote:
> > On Fri, 4 Oct 2024 at 02:31, Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > > However there are some "lea xxx(%rip)" cases which don't use relocations
> > > because they're referencing code in the same translation unit.
> > 
> > input section
> 
> "in the same translation unit and section" ?
> 
> > > However if we enable -fpie, the compiler would start generating them and
> > > there would definitely be bugs in the IBT sealing.
> > >
> > 
> > -fpie is guaranteed to break things, but even without it, Clang may
> > issue RIP-relative LEA instructions (or LLD when it performs
> > relaxations), so this is definitely worth addressing even if we don't
> > enable -fpie.
> 
> I haven't seen this with Clang either.  Also, objtool runs before the
> linker so LLD relaxations shouldn't matter.

LTO might have a few more cases, the input sections are bigger there.
But even there we run before the final link stage.


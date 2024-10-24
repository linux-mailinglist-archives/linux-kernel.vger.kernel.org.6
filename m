Return-Path: <linux-kernel+bounces-379775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE3D9AE380
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 13:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15831F22C58
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766321CACD4;
	Thu, 24 Oct 2024 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e40LN49V"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BEC176AAD;
	Thu, 24 Oct 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729768501; cv=none; b=MHWpI474Uaj74/UV9NaFDmHhpE1AU8OKU7zCQmRrn906p6o4FOvHtDphXv4aKGYp9hNRPJJ6lGckWcBoOlYZBJVpCEgUGy2MThX3XnaQ/KmSy0cskAaXB1Pv/0kIcTvrkKHrTzYlgGgXfhiNIap2F9bMPvlT3Ga6ZAgjnsZ3QKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729768501; c=relaxed/simple;
	bh=6898A2k/2mms9wLPBGuH6tUr9Dzh+/KBjXZ6gQD8d2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CR4HP2yrQB21EjZJ3WPPenysfw0OY24lheKAtvcQ8b1Uul+GE51HsoIw4E1/dR2CBp8f14CUcPh8RN1r1rKOiWczZOzQwqta8mepKNdNAZNZZXvMj8pU63fdGURmXtXwd79GETQ7z04cThTdjOpXD9Viyt7d4ZlNe067D1v8n+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e40LN49V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cDiSrKvvEk8aarD54GeIVwtccnuhH7x3Y3alCSyn4w0=; b=e40LN49VDcf3+uLR06drpRWcwf
	Okq/kyxxueB+GdWBIxMptITT6Ol79wJiiOAs1L1u3r7v6aDAH0tnHJeQ84udsTB8MZaeJ5pOsHSR2
	r/P4kgWu0XecloLxzfUTZnIWmF3ILI50dTl+S15tGLLKp/R4IkIuAFpkl1cCyFSiMU+4aGZ1ZDMNs
	GoTcUmwKYAaXCsRDJt7XzX0CrFSET34i8aTEYs0SxmgDG9Wlpzlchx+m7ODQpkL1k+OvNh/Sf+buY
	98Ozlf8fXyV5mebn5rxHOGmcM1cUUKlA4eeR3ZOKOPAJpnA8dKxRflWuCHOlknGQgls64HtHH3vv8
	H3HvT5YA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t3vnr-00000000BMv-0NMk;
	Thu, 24 Oct 2024 11:14:55 +0000
Date: Thu, 24 Oct 2024 04:14:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <ZxosLw0gBG7QFNua@infradead.org>
References: <20241023051914.7f8cf758@rorschach.local.home>
 <8734km2lt7.fsf@mail.lhotse>
 <20241024010103.238ef40b@rorschach.local.home>
 <07422710-19b2-412b-b8d5-7ec51b708693@roeck-us.net>
 <20241024024928.6fb9d892@rorschach.local.home>
 <CAMuHMdVLsLA97u4AVTA6=YKyfyWNrJOQk7S02s36AFTrFoUM3A@mail.gmail.com>
 <20241024052139.2cf7397f@rorschach.local.home>
 <ZxoSZQSw0z6AdgaU@infradead.org>
 <20241024054909.49ae9faa@rorschach.local.home>
 <658bb573-69f5-4873-98d3-9e9d6412966d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658bb573-69f5-4873-98d3-9e9d6412966d@sirena.org.uk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Oct 24, 2024 at 12:08:28PM +0100, Mark Brown wrote:
> On Thu, Oct 24, 2024 at 05:49:09AM -0400, Steven Rostedt wrote:
> 
> > So basically, all I need to do to satisfy your request is to add fixes
> > branch that I push to that is pushed after it passes my tests (and not
> > the urgent branch that is still being tested and may have bugs) and
> > then have that be added to linux-next?
> 
> > Now I have been batching changes and not send a pull request right
> > after my tests pass. I've been sending a pull request at most now once
> > a week. So I could have this branch hold the code that's already been
> > tested.
> 
> Yes, that's what pretty much everyone is doing here.  Generally we find
> very few issues this way but it's certainly a non-zero number.

*nod*



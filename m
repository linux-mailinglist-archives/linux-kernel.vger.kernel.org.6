Return-Path: <linux-kernel+bounces-189122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8598CEB80
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029141F2243C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C08A86252;
	Fri, 24 May 2024 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KlKSYU71";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRK92Xlq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AE284D03
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716583914; cv=none; b=AjwPnhus1wq4hVR1eTn9ccA0Fcs5jndSTbbyJ6VPz5O+REjh6G27icFQZsKTyJ7rLPDU+DWJNg5NDvk6eU5giSByOmcOr1u6+Dk3W2S8zaiWdg0LozJ+QwxBzK2bZxJ+BhmH32eypo4GYybaMl+dO1SZTqRdKlrKQXwkaaub53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716583914; c=relaxed/simple;
	bh=i3deDqDeO7A/a/n2crxYTP1YsSLmSlhLrhiMYiiSeX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEC5K+i90P8oOMy4TGo3fuFDXpOXOA11kopkzJHTWaFgHONuuIGI4o86xQfMjs+Amue/IJqdRXMA4Jct5xVvVyOUaCyilEOG/Rgx7uq6HRM6ofSAbEjVCxweGX69HhC4WvxVPy5GtnS2Z0k5BJD3eg3JG6TTuVn02SBp3jVf3MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KlKSYU71; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRK92Xlq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 May 2024 22:51:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716583911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LnGzUsjzG0HmIIecrpeyhdj8xRmmJcYzbtjAguZpAMc=;
	b=KlKSYU71/teOqH2WxiRGXp7U+lVSfUBTL+htQXBPEgsDsZ+FIPaf8ehRnLE7VJdAt3/5B0
	lecEB6p39aOURjQ/ZPh8ZGAiI212GHRHx/jEM2FJkcnK9AZIf0IYOx1fYq7cvi70jWlW9o
	JKtVIf54tHlL5KCoYyHW90+KRFlfyfdGpzgJuzvX+rSvEVu7pVOE0Jq3bA6f7ych9axMfX
	b5wNrYkNVjt1cWOeMJn8nyv6QV1IxgblSZm7VArYgZWpK3F5uYgwz7u3DNpsaMF9sdME/B
	fUfBjE68dt3EZnoNwD/327H52oQER1PHoCHRjrdjDD283Pg+7gwxS/vIToyvoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716583911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LnGzUsjzG0HmIIecrpeyhdj8xRmmJcYzbtjAguZpAMc=;
	b=dRK92Xlqdes65yghENzMvVaVr2hLmOXfLT7gE558r2LJBjTbK1XjdKD4okqnrOJH3G4oBJ
	60PoI4dUQ6JRj7BQ==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Don't use hugepage mappings for vmemmap if it's
 not supported
Message-ID: <20240524205146.ZaCva-qC@linutronix.de>
References: <20240508173116.2866192-1-namcao@linutronix.de>
 <43829e94-98ae-46a4-a3e6-dbabbe94d7c1@ghiti.fr>
 <20240508184641.WP8ok_Hg@linutronix.de>
 <8b741144-8a3c-4a4c-bb3f-dfab4aa8e576@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b741144-8a3c-4a4c-bb3f-dfab4aa8e576@ghiti.fr>

On Fri, May 24, 2024 at 10:07:40PM +0200, Alexandre Ghiti wrote:
> Hi Nam,
Hi Alex,

> On 08/05/2024 20:46, Nam Cao wrote:
> > On Wed, May 08, 2024 at 08:22:43PM +0200, Alexandre Ghiti wrote:
> > > > Commit ff172d4818ad ("riscv: Use hugepage mappings for vmemmap") broke XIP
> > > > kernel, because huge pages are not supported on XIP kernel.
> > > I don't understand why XIP kernels can't support huge vmalloc mappings,
> > Me neither.
> > 
> > > so I
> > > think the right fix would be to enable such mappings on XIP. WDYT?
> > I agree that is the ideal solution. But I don't want to send any new
> > feature to the stable trees (stable folks may even reject such patch).
> > So I intend that to be in another patch.
> 
> 
> I have been thinking about that, and I actually think that the real fix is
> enabling huge vmalloc mappings for XIP as it was an oversight/mistake in the
> first place. On 64-bit kernels, there are no reasons we can't use PMD
> mappings for vmalloc. So I'd rather not go with this fix.

If you have strong preference for that approach, then we can go that way.

I don't like this patch that much anyway. The only upside is that it is
safer to backport, because it is obvious that it won't break anything else.

I will do some testing with PMD mapping on XIP, and come back later.

Best regards,
Nam


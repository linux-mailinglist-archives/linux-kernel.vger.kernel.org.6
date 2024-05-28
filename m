Return-Path: <linux-kernel+bounces-192095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBE48D1852
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92ADF1F21471
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB61667FE;
	Tue, 28 May 2024 10:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/OMErT6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANOcN4Q+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A715E96
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891553; cv=none; b=qI8P6+VLDB12Cdu1gwk2kGbirG4XoFqCslCsaQnY8ty54U2o7MGejQe2T1cjwAV7Jb5D/3eafpnmRTYnKzfjzHhiFfejFZfKGgHG/yyxKGsQo/GdbgQdubJn3pt5i7Y2KtGpPo0KBdlSSkXpNJEWMGttHf29R3QYLchM3MrOVfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891553; c=relaxed/simple;
	bh=Ya9VdVB0Xq6yIt8kP/OA7nigs6apnznopnU3bqowtAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIQE3qPnli7+/V+Asugjir+HeS0xsJ00K7okJ614bHzPDczx+dmS9/IldHkFWlLZIyG8Y2NY0MTPZgak7UqgLxvJ/kQBL2SnW5Y36Taqa6AsM+CQWsEedXaQLEMFd1vO71Dj6KpLsYOQW97PXdnASCtltGP5vF9HlE0SwtvXetE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/OMErT6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANOcN4Q+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 28 May 2024 12:19:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716891548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj4XdVUI9qLUqsuyCq3B3lu21WNFGQYe/dCkjjZ08E8=;
	b=c/OMErT65eQpDjOOuCoAlir2qD9xE0i98dbANpjAG9uVf4pNhkmV2AveVZgwomMwfsNI/6
	h273vMV2rgx7Opv2JM9vUHs4i2+dytB4xZquvs89ZwpzCijRZ1kIJMt9EhFydA1HT2GeoF
	1u3TqP3RBUKH5QS9o0emIPrVsVsylQ7SxRrUjq2afFoXcctdt92PRzWHmMQBVJvt7sgzde
	/a0Uc5oG+2/S6GEHcaeekjKlsqmeFvGfDNpDzy3Fgnhxz8bAyHuTWqwBaESiiQl4+2ndYm
	RfFrCujtsCBWBlklCPSfqtzbMRm2UmeQuE11eb8DTzNjihupGM+dz+PgUbJUbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716891548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Oj4XdVUI9qLUqsuyCq3B3lu21WNFGQYe/dCkjjZ08E8=;
	b=ANOcN4Q+/n0ojmW/+nTv158Zi0sbQEPrSXevIiJYINPUmHcTVz9JU27KnrR29TSxkc5E8a
	aZwJdLmoLgqUNSCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] memcg: simple cleanup of stats update functions
Message-ID: <20240528101906.ts4NjHvU@linutronix.de>
References: <20240420232505.2768428-1-shakeel.butt@linux.dev>
 <20240527152200.P1rU7FaG@linutronix.de>
 <86006806-4ffc-4330-ab4b-29215ab2c98c@kernel.org>
 <n6zstrcbqp7fqpennqf3qgt2nuc2tdrnsc5dmoawyke3zn3xcm@6uirkotvrhe6>
 <20240528075623.oFcU1JLj@linutronix.de>
 <69c0e008-ddde-4a38-b856-b765dc2b9745@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69c0e008-ddde-4a38-b856-b765dc2b9745@kernel.org>

On 2024-05-28 10:10:50 [+0200], Vlastimil Babka (SUSE) wrote:
> > I don't mind sending a patch. I'm just not sure if the lock is the right
> > thing to do. However it should ensure that interrupts are disabled on
> > !RT for the sake of the counter update (if observed in IRQ context).
> 
> Looks like some places there use VM_WARN_ON_IRQS_ENABLED() that's turned off
> for PREEMPT_RT, so maybe that's what should replace the current
> lockdep_assert, perhaps together with
> lockdep_assert_held(this_cpu_ptr(&memcg_stock.stock_lock));
> 
> But also __mod_memcg_lruvec_state() already has that VM_WARN_ON.

This "VM_WARN_ON_IRQS_ENABLED" is the initial assert for "interrupts
must be disabled while change the counter".
You want to replace it with lockdep? Part of its requirement was that it
yells with lockdep disabled.

Currently I am leaning towards removing the
lockdep_assert_irqs_disabled() from __mod_objcg_mlstate(). Nothing but
the counter need it and they have their own check. So?

Sebastian


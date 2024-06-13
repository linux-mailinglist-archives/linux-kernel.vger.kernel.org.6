Return-Path: <linux-kernel+bounces-213679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CE49078A8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C3F71C20DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F54130A46;
	Thu, 13 Jun 2024 16:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lTDAk4co"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B88E12EBE6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297357; cv=none; b=okswqLD9JZJbeM+btyJ8fRF89nnN40nOwAGlVZ/9KZ3+PIGiOkCG2+wbwcYeAdrc/iAU2mZvOuYyS0ub0zsdTmX4Jdo5CP7rYTWtvlnJaAgZyNluyg/io5ZzHh8Hss5j5hhDK4opChiO5cayYiaVDnAFYKUbcFGsyjP47e3Hx/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297357; c=relaxed/simple;
	bh=DICBEk8onTRIhXycuenMRZ2If1US8PChQMniiIGYzF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8QiMFAzrQaZdEmR6Rn5g/w3/MCNs1kj3531awBqKGyfO6pgspMCzJQvfRMj6o2p4ECHn4+wpDxUK6my8OTRbDzNcom6FuLiXG2x/tnh65o6MoHfmsP4VLmnxINDVHvs4AOJ2FLpa3SuPdxjIELUvkP5unAbczjURLfSmszIDa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lTDAk4co; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nphamcs@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718297352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wYZqS3WmpZ1OvyFzFMKzzNWnX5VrFLB0li+OWnNc9tk=;
	b=lTDAk4coW1qoEqSDcrGUh77VX9j2ToBzIDmRD01DGlpZ2pVHQOSkG9HMrZUWcbzW7hp1ia
	ubqHXDB4O45iH/naEAOAuHIR1o6brS/DizNg2D09vDop/YnP1binzlzb0CGPMvXO1oDW7q
	t3sjoCaZwpP/bn3Iv10dVkKj4mCo+ik=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: corbet@lwn.net
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 13 Jun 2024 09:49:06 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Takero Funaki <flintglass@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
Message-ID: <pezgvebjcykwgawtmvymqwktul25pgw5orxvvrbm24hjc3sizv@3yg7tbpwnlnf>
References: <20240608155316.451600-1-flintglass@gmail.com>
 <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
 <CAPpoddeigM44jhTA8Ua=+J4MC1MikouBZVoPrCW2LZF+9r5YeA@mail.gmail.com>
 <CAJD7tkYp3GbuXV9G5bAZ1DetMmepV5ynciA+ukae7CKuxpXDJQ@mail.gmail.com>
 <CAPpoddfj1EdfXfTUT8bLaNxat0hYiE4X9=qG38gPgRgmmVOjcw@mail.gmail.com>
 <CAJD7tkZTSGz1bpo-pMNP_=11O-7RrhubWonqhUJwrt+TB=Ougg@mail.gmail.com>
 <CAPpoddcp9rVvg77WapsuiMdMzFrV0UioJ+VbQuJbKNY7-=nvVw@mail.gmail.com>
 <CAJD7tkY0=0yKSmEz=E5dL7GLRsO8r6ESWyzF+HdgK0wnMpzLKg@mail.gmail.com>
 <CAKEwX=PF=a2+pUBM3xEHBMu6VJY2Q64eTmVwo7vb4YmJQpK_DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=PF=a2+pUBM3xEHBMu6VJY2Q64eTmVwo7vb4YmJQpK_DA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 13, 2024 at 08:04:39AM GMT, Nhat Pham wrote:
[...]
> > > >
> > > > Is the idea here to avoid moving the iterator to another offline memcg
> > > > that zswap_memcg_offline_cleanup() was already called for, to avoid
> > > > holding a ref on that memcg until the next run of zswap shrinking?
> > > >
> > > > If yes, I think it's probably worth doing. But why do we need to
> > > > release and reacquire the lock in the loop above?
> > >
> > > Yes, the existing cleaner might leave the offline, already-cleaned memcg.
> > >
> > > The reacquiring lock is to not loop inside the critical section.
> > > In shrink_worker of v0 patch, the loop was restarted on offline memcg
> > > without releasing the lock. Nhat pointed out that we should drop the
> > > lock after every mem_cgroup_iter() call. v1 was changed to reacquire
> > > once per iteration like the cleaner code above.
> >
> > I am not sure how often we'll run into a situation where we'll be
> > holding the lock for too long tbh. It should be unlikely to keep
> > encountering offline memcgs for a long time.
> >
> > Nhat, do you think this could cause a problem in practice?
> 
> I don't remember prescribing anything to be honest :) I think I was
> just asking why can't we just drop the lock, then "continue;". This is
> mostly for simplicity's sake.
> 
> https://lore.kernel.org/linux-mm/CAKEwX=MwrRc43iM2050v5u-TPUK4Yn+a4G7+h6ieKhpQ7WtQ=A@mail.gmail.com/
> 
> But I think as Takero pointed out, it would still skip over the memcg
> that was (concurrently) updated to zswap_next_shrink by the memcg
> offline callback.

What's the issue with keep traversing until an online memcg is found?
Something like the following:


	spin_lock(&zswap_shrink_lock);
	do {
		zswap_next_shrink = mem_cgroup_iter(NULL, zswap_next_shrink, NULL);
	} while (zswap_next_shrink && !mem_cgroup_online(zswap_next_shrink));

	if (!zswap_next_shrink)
		zswap_next_shrink = mem_cgroup_iter(NULL, NULL, NULL);
	....

Is the concern that there can a lot of offlined memcgs which may cause
need resched warnings?


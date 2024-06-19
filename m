Return-Path: <linux-kernel+bounces-221562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E325390F581
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 19:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04731C2169E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 17:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717FC156967;
	Wed, 19 Jun 2024 17:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="akoSr2fv"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F271E87B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718819570; cv=none; b=HUMWztghDGbSJNIyaYpTn8hcEURQhKYRfM3BMDnnGBq8vHGJxlTm+KWxHt30Qtcz0m3zDYOzzy+2FWzo9UdWHI9NN1XDPkKug08F50+4xXDk66z9UgC60ZajcVfukNwmci+1AFcAX/2NCPGWQ8imtzmwcSGrTX3tQu6WjYVGqeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718819570; c=relaxed/simple;
	bh=kQndasnA2q4Zhiw3IRbkeozFbGuf3KlkxS4BizI+YOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwQnTKXNxzACOqnt+w6glNQQM3ZVogOZuMKMT+U+Z5Tq/vskPdv6GrZuQ4FSI4LO/Lp+I5OSEQCT5Miz6PQ/uapTnH8WB4+4dVZNEAueN98AWlN8ylXbyVr+l44LgAWkaAuqG75Xp9Wt0bG1kNsWag2CBaZGC02KOa7LQ2wlcl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=akoSr2fv; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mjguzik@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718819566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G12t0zsbjBLtka1z3Edmtxikovb2H51+AQMkglEZLGo=;
	b=akoSr2fvU73Q0cSewLCqxsWHjT3wWMthQ4WH14GMMUiok98sXGU8Y/gQX9C04DwYpcgDOv
	Z1Y1GlEg3tyfD1OtiM2DOaf144Zxdcetx7jXL3Ov7cTn47wfrqCsNAf72CC3HSpXkqGafg
	Ih6uyJ8AqFVjMuTPlbjqniF38dZZoBw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: torvalds@linux-foundation.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kyle@infradead.org
Date: Wed, 19 Jun 2024 10:52:41 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	kernel-team@meta.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <20240619175241.6i5fjkjm3sl4aaas@linux.dev>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
 <fm7buc5wqjfbpkc4vciubjttk73k7vzahohlcolztrhjqywnca@pysupztheg6i>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fm7buc5wqjfbpkc4vciubjttk73k7vzahohlcolztrhjqywnca@pysupztheg6i>
X-Migadu-Flow: FLOW_OUT

On Wed, Jun 19, 2024 at 02:49:21PM +0200, Mateusz Guzik wrote:
> On Tue, Jun 18, 2024 at 02:34:21PM -0700, Shakeel Butt wrote:
> > At the moment oversize kvmalloc warnings are triggered once using
> > WARN_ON_ONCE() macro. One issue with this approach is that it only
> > detects the first abuser and then ignores the remaining abusers which
> > complicates detecting all such abusers in a timely manner. The situation
> > becomes worse when the repro has low probability and requires production
> > traffic and thus require large set of machines to find such abusers. In
> > Mera production, this warn once is slowing down the detection of these
> > abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> > 
> > Reported-by: Kyle McMartin <kyle@infradead.org>
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/util.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/util.c b/mm/util.c
> > index 10f215985fe5..de36344e8d53 100644
> > --- a/mm/util.c
> > +++ b/mm/util.c
> > @@ -649,7 +649,8 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
> >  
> >  	/* Don't even allow crazy sizes */
> >  	if (unlikely(size > INT_MAX)) {
> > -		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> > +		WARN_RATELIMIT(!(flags & __GFP_NOWARN), "size = %zu > INT_MAX",
> > +			       size);
> >  		return NULL;
> >  	}
> >  
> 
> I don't think this is necessary. From the description I think interested
> parties can get away with bpftrace.
> 
> Suppose you have an abuser of the sort and you are worried there is more
> than one.
> 
> Then this one-liner will catch *all* of them, not just the ones which
> were "lucky" to get logged with ratelimit:
> bpftrace -e 'kprobe:kvmalloc_node_noprof /arg0 > 2147483647/ { @[kstack()] = count(); }'
> 
> Of course adding a probe is not free, but then again kvmalloc should not
> be used often to begin with so I doubt it is going to have material
> impact in terms of performance.
> 
> While I concede it takes more effort to get this running on all affected
> machines, the result is much better than mere ratelimit. Also there is
> no need to patch the kernel.
> 

Thanks for the response and suggestion. I am inclined towards warn once
for each unique stack trace as suggested by Michal because I think it
would be useful in general.



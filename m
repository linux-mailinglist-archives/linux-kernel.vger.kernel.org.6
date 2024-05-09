Return-Path: <linux-kernel+bounces-174612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E67F8C1192
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01119B2185B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1C9134CCC;
	Thu,  9 May 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kxCQfYmg"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861A1A2C3A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266662; cv=none; b=pVOjCUMFPzPdAIR6CTZmlnFK3+/EdYzxRLZPtYqG+quQPWgyznKk+VY/CHYkBd6vcZ82B9KnEGnTwbpS7DcnpFP4jteCDaRTlBE0WoAU4gbsMxoLAbmdyJwoFz1NtnXfs9glgjJegD4MuByGdp3hniK69d/YubSaKwVTm7CgQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266662; c=relaxed/simple;
	bh=xsOrB5+mLW6wdrM4FaEOMLihm4F2cgax+VDPr4gVmdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhcUGy3y4KD1acMoQjQtpA3Pi4wyn5DkJ/B84QYFjZWXPT25ni5KY3VUC9a6pVWnrujxl4L0LAI7dnnCtWyYZXhq+Zc2wOvYKsQu7yZpYDoBIDVZ9t6szKXzVzKn6cdfo88KBjrZ7pjoU0JEgHodwd773IZHNrq5qnqnIp92Rgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kxCQfYmg; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 May 2024 07:57:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715266656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4bqRwrBrqoa19SvEpE/J0OTW8kDuORQv0JaSXGHN1Ek=;
	b=kxCQfYmgzEJJatutIe250OnBWlRlo3hl0rMFNu4PIDHKKj1dWF70b0tqtevbLXEA92GBTF
	RlfANb+akKXuenK3bTOYzQTSYYtt7Jx3KFZLa970lk8To8HJFzQoenTQITyUzc9yu1ZHZG
	oHraiU/TxtBzp5MZEMF7y5xFqg6Ey6Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH rfc 0/9] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <ZjzkWt-ut902Qa7N@P9FQF9L96D.corp.robot.car>
References: <20240509034138.2207186-1-roman.gushchin@linux.dev>
 <20240509142205.GC374370@cmpxchg.org>
 <20240509143635.GD374370@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509143635.GD374370@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, May 09, 2024 at 10:36:35AM -0400, Johannes Weiner wrote:
> On Thu, May 09, 2024 at 10:22:10AM -0400, Johannes Weiner wrote:
> > On Wed, May 08, 2024 at 08:41:29PM -0700, Roman Gushchin wrote:
> > > 3) Is it better to use a new include/linux/memcontrol-v1.h instead of
> > >    mm/internal.h? Or mm/memcontrol-v1.h.
> > 
> > mm/memcontrol-v1.h sounds good to me.
> 
> Argh, there is a folio_memcg_lock() callsite in fs/buffer.c. I suppose
> include/linux/memcontrol-v1.h makes the most sense then.

You mean put everything into include/linux/memcontrol-v1.h?
And functions from memcontrol.c by memcontrol-v1.c into
include/linux/memcontrol.h?

It's an option I considered it but the downside is that we're "leaking"
a lot of internal definitions into the outside world, because
memcontrol.h is included everywhere.

So maybe mm/memcontrol-v1.h for definitions shared between v1 and v2
and keep exported functions in include/linux/memcontrol.h? There are
only few of them.

Thanks!


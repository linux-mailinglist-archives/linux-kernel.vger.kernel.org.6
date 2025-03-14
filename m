Return-Path: <linux-kernel+bounces-561748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98AA615B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A33B2147
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03702202F80;
	Fri, 14 Mar 2025 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fNsQGZuZ"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F595202963
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741968232; cv=none; b=X2bbnFI3hge9tuIqNBylO1V6xbifTg7jQgXktZkI9GFOCDct3/fqkWOgls8Tv2jNiohG98nVIpZlA8vK2Wj5MD0AXgQOT7WDRixxWVG34QzTseFIVcsYTWWw9YNjEsSr7h67Cm4wsQb9pzFBQT0VMnneMiMwDMopQhZytdTgJy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741968232; c=relaxed/simple;
	bh=yrHIMZEQIzQRIQq+cMhYQ6EfuVso/JtelOIXBni+FtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTzcwV5wNmE8/RDj8nxl+8IZE1QFgDZPAjMd3BoxLgnWWMH7jDbzDIhQGI0dbvUjjDZbIYHdcziQCs2hoREPX8I1y1PHnskigdcZSE/FV9BYP6Fr/AzuOHtBMk8llGrG8NfNv6FT92iJKLsOG0+4OjC9UiqOdgBI46NLssGegRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fNsQGZuZ; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 09:03:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741968218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4CTT02FmBRZU5Cwt4ngsfM8t+ChpAnoBkXBi8a3BtK4=;
	b=fNsQGZuZw0rPbHUA9iWBUzeGKeM1e6d1wSwp3NTHWe6TiwSharfI8h5jWYjpDXAabMK0Gy
	mTMmj6SOLuD7KrbltqVnmCsPtraLDoccquSeUDHX8G2gTZCJH7exSJB/NdUqhIVx/u+/zy
	9+j7jpTXodhAJuFBWyZh3QZ7Hi0x/hU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 00/10] memcg: stock code cleanups
Message-ID: <p6zxnvjyuc5e7rzkfjti3226io6iz4aabfcnoluxm4xsxscixn@l5qyadx7p6lv>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <6bd606f4-cfe9-4afb-b538-26feb56f9268@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bd606f4-cfe9-4afb-b538-26feb56f9268@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 02:33:28PM +0100, Vlastimil Babka wrote:
> On 3/14/25 07:15, Shakeel Butt wrote:
> > This is a cleanup series (first 7 patches) is trying to simplify the
> > memcg stock code, particularly it tries to remove unnecessary
> > dependencies. The last 3 patches are a prototype to make per-cpu memcg
> > stock work without disabling irqs.
> > 
> > My plan is to send out the first 7 cleanup patches separately for the
> > next release window and iterate more on the last 3 patches plus add
> > functionality for multiple memcgs.
> > 
> > This series is based on next-20250313 plus two following patches:
> > 
> > Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> > Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> > 
> >  to simply the memcg stock code
> 
> Hi, 
> 
> I've been looking at this area too, and noticed a different opportunity for
> cleanup+perf improvement yesterday. I rebased it on top of patch 7 as it
> would make sense to do it before changing the locking - it reduces the
> number of places where the local_trylock is taken. If it's ok to you, please
> incorporate to your series.

Thanks a lot Vlastimil, I will take it and add review tag after
reviewing it.

Andrew, I will post only the cleanup series soon. It will be based on
next-20250314. If you decide to take it for upcoming open window
(6.15-rc) then some coordination with bpf tree would be needed. However
for the next window (6.16-rc), I don't expect conflicts.


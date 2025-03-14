Return-Path: <linux-kernel+bounces-561682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521FDA614DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDD33B5504
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487EF20297B;
	Fri, 14 Mar 2025 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDfx+ZY7"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89BA20126A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966172; cv=none; b=URMtU4l9JsSYA4AUTvZyB2yrtH0ctlqqUUcN9mkBFjcfeH3oYFhlHH4Q2AS6qj4fBYDuL4Hl93mIJwVRp8tgrFQuNiHoCwjxbZbgD6vReXjc6efTLs9pXXjI/WZY06n9GpqqYZDM7EvW13+IFUUjiwhkPRO3R/QQmEnNuuqSl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966172; c=relaxed/simple;
	bh=N08HYeEx2BLrOY3nk+p6mAez4Kgu5A5p0jeN14xGrDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr5XUXlQ4ZGYM3HBxx0pqpaxhsROyzKKORPiBFmEEJPUrkWnQIIrQqeMQV0XWWat2NS4kr90eynlWrv/TP+wbIfA0u/LbTObTrxyEx4kWTKV+11hTDSoBmO9H3R2r1mb1+AK77wgbuUSSvmy7YujZLNVQPwTXLEn/J+vabPAcUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDfx+ZY7; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 08:29:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741966168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NX9W4pphy205/je/RVrubGPLxjHvf8FAm0FIpSStotM=;
	b=kDfx+ZY7HutAn6rwpzWwfre1nFXudLPhjbodB85y6jIN/Ln6IkoL9WULIxtXkUJGr1TiPD
	VXyBzBgfexKieRjL91Prs3oJZx0FlorqnOO4kREJEPGP9ujsaSo8kzPxdyVSl8oVwLgFnd
	JpiuBv1U/4Dey65VG6hDinMXaFa8DQU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 06/10] memcg: do obj_cgroup_put inside drain_obj_stock
Message-ID: <grxsn6nng2hetvcx4o463g27p6cnv3x5tsc73bquuu2m34lb65@a5pp5nfdps22>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-7-shakeel.butt@linux.dev>
 <0b3ab5e5-e684-44ce-b6ed-276ad37784e6@suse.cz>
 <20250314113533.jNrVXeyr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314113533.jNrVXeyr@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:35:33PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-14 11:17:28 [+0100], Vlastimil Babka wrote:
> > On 3/14/25 07:15, Shakeel Butt wrote:
> > > Previously we could not call obj_cgroup_put() inside the local lock
> > > because on the put on the last reference, the release function
> > > obj_cgroup_release() may try to re-acquire the local lock. However that
> > > chain has been broken. Now simply do obj_cgroup_put() inside
> > > drain_obj_stock() instead of returning the old objcg.
> > > 
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > 
> > Hm is this really safe? I can see obj_cgroup_release() doing
> > percpu_ref_exit() -> kfree(), do we have guaranteed that allocation won't be
> > also in a kmemcg and recurse?
> 
> This was like this until commit
> 	5675114623872 ("mm/memcg: protect memcg_stock with a local_lock_t")
> 
> at which point the put had to happen outside. This "percpu_ref_exit() ->
> kfree()" was also prior this commit.

Yes, as Sebastian said, this is as safe as before commit 567511462387.
Also the ref->data which is getting kfree()'ed from percpu_ref_exit() is
not a __GFP_ACCOUNT allocation, so can't recurse.


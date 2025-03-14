Return-Path: <linux-kernel+bounces-561705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EA8A61512
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85073AD8AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F145E202F88;
	Fri, 14 Mar 2025 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jLXHOc3X"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707643A8F7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966419; cv=none; b=LBMjrROwvSe18sXPpHHyTx7zUczYaotL1opygWBcg3eM+WooRr2Al3RV0jjw3DMOkCbINl2mKYX04hXAABEcSQXZL+dZJ3YwxoyOVODtiR+m0+/K9Y+FJ7fQoWgk0FEzHqe+zezTLaJDvlkjIpR9mFj7SKW3otYpAfsMa9hPxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966419; c=relaxed/simple;
	bh=gfV5KRqfy23+YgcjBRsQElBecHIn+MHo3Eq47qJf7yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9ZKJCW8n+FozKOUkJ0CXvL1zHxdrCrX53WtgwABsCK8JwABkoalZwWveHdepMYvlC0gPjJFV8F95qdd8ynXCOFciKN4tuB1fVuJYZ/Q2fy2tcdzOU/W51apPZg6QeGqowhCFTVPnL6TR3TskHeZFVt0GI5q7Be7NA9gwVnFRYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jLXHOc3X; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 14 Mar 2025 08:33:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741966405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EQZ1hRUiUX1Uv5De+AMk390tcCYkein0nUGbYfp2WQ8=;
	b=jLXHOc3XIQYh9KwNdMlyCf7igSJ0+ADyoqyy2+froIq3W+bd9up4RHC4gixK2/KleUBjfC
	+fDfEoKQNkRidYjQbC83Jp7Co8HS6aW22UwX1MeTJCCN46QMqLmOG/aUpO24oFO2YucoYQ
	zrWHVqQGmyL0prKATIFtExNZqr6NJXE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 09/10] memcg: trylock stock for objcg
Message-ID: <lr7pg6kxj2rggwaj6pwoca63uvdbqhiphs4hhva4f2pjsfqnwb@7a3ackqh2l66>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-10-shakeel.butt@linux.dev>
 <20250314114700.TiLB4FH0@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314114700.TiLB4FH0@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 14, 2025 at 12:47:00PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-13 23:15:10 [-0700], Shakeel Butt wrote:
> > To make objcg stock functions work without disabling irq, we need to
> > convert those function to use localtry_trylock_irqsave() instead of
> > localtry_lock_irqsave(). This patch for now just does the conversion and
> > later patch will eliminate the irq disabling code.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  mm/memcontrol.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c803d2f5e322..ba5d004049d3 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2764,7 +2764,11 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> >  	unsigned long flags;
> >  	int *bytes;
> >  
> > -	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
> > +	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> 
> Don't you need to change the of memcg_stock.stock_lock? Didn't we
> introduce an explicit different type for this trylock feature?
> 

Yes, Alexei has already changed the type of this exact lock at [1].

[1] https://lore.kernel.org/r/20250222024427.30294-5-alexei.starovoitov@gmail.com


Return-Path: <linux-kernel+bounces-309407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FF7966A02
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 21:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 019AFB22BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF141BD039;
	Fri, 30 Aug 2024 19:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dVp0Xqlr"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01D71B29D2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725047085; cv=none; b=mCzLtP9YsaLHAfNW09Gg5bZ0P3KxEsLkvyMYdkRFALSfts0Wx9oUooCm7VmCPEHGTSEtvuJsQwFiPz0OSKBBrgN/4nwplOskXe/lQQWI9PqlNmNlFs3mhlMiDD8BnBy5c5YEZAx77Dyv39eUSa+vML072SjOKIHJJXISvzXO6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725047085; c=relaxed/simple;
	bh=GaonNHETruVB9x4Kgz4WTZ1UNypcrNwlxsfn1fPhuxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUCM79oZwKh+8b6u9x2Iv95ALXjvYzXFg/i/FLgMeis6PM/luEsFLt5SJDcnZcJ/lVn/J2PaghD0nCf42Tptv9yKOMKCNcw1NBYMQRTVDlwt3WJOKVEl/Wah4IAHVn6OHHIW4mwL0CG+lQ2ySHIbUnTesNnih43nsxBDp01eznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dVp0Xqlr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 30 Aug 2024 12:44:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725047081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2qi8zuVUA51rj6VM4lfmCDpw1uLh7fyiw4/O+HNlVkU=;
	b=dVp0XqlriwFTDYo/Ug8DdXCl5PxXyfROEj+MZBbcva2bnnPEvClzifbBZsVY7LSmNDPxKj
	041f7SbZDnVAGWqF+XBot0/oGepvgFHnBPPDEkWVAZaPv2kZEjLsecOC5qK608xd1H3we7
	hGGAux6SjYVJghdMBrq24ma7VIJTsiE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3] memcg: add charging of already allocated slab objects
Message-ID: <ukrl43rakgdzlo4fvw3ldwyoke76dgnseobtf75ldghe3fadxc@ag2y4jk77js2>
References: <20240829175339.2424521-1-shakeel.butt@linux.dev>
 <76079f79-2e72-4a59-9eae-3b05ae6b9a9e@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76079f79-2e72-4a59-9eae-3b05ae6b9a9e@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 30, 2024 at 11:07:32AM GMT, Vlastimil Babka wrote:
> On 8/29/24 19:53, Shakeel Butt wrote:
> > At the moment, the slab objects are charged to the memcg at the
> > allocation time. However there are cases where slab objects are
> > allocated at the time where the right target memcg to charge it to is
> > not known. One such case is the network sockets for the incoming
> > connection which are allocated in the softirq context.
> > 
> > Couple hundred thousand connections are very normal on large loaded
> > server and almost all of those sockets underlying those connections get
> > allocated in the softirq context and thus not charged to any memcg.
> > However later at the accept() time we know the right target memcg to
> > charge. Let's add new API to charge already allocated objects, so we can
> > have better accounting of the memory usage.
> > 
> > To measure the performance impact of this change, tcp_crr is used from
> > the neper [1] performance suite. Basically it is a network ping pong
> > test with new connection for each ping pong.
> > 
> > The server and the client are run inside 3 level of cgroup hierarchy
> > using the following commands:
> > 
> > Server:
> >  $ tcp_crr -6
> > 
> > Client:
> >  $ tcp_crr -6 -c -H ${server_ip}
> > 
> > If the client and server run on different machines with 50 GBPS NIC,
> > there is no visible impact of the change.
> > 
> > For the same machine experiment with v6.11-rc5 as base.
> > 
> >           base (throughput)     with-patch
> > tcp_crr   14545 (+- 80)         14463 (+- 56)
> > 
> > It seems like the performance impact is within the noise.
> > 
> > Link: https://github.com/google/neper [1]
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Thanks, pushed to slab/for-next for test coverage, hopefully net people will
> ack.
> 
> Also one thing:
> 
> We should add some kernel doc for this, no? Explaining when people are
> supposed to use this, that objects from KMALLOC_NORMAL will be ignored, and
> what the return value means (including where it's faked to be true).
> 

Yes this makes sense. I will add this info similar to the kmalloc()
have. Should I send a v4 with this details?


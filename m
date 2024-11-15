Return-Path: <linux-kernel+bounces-411468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747139CFA55
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2902C1F257C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 22:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A17191F69;
	Fri, 15 Nov 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Whyit7I0"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B18BBB0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 22:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731710806; cv=none; b=CzMicjwMjTPNarQmQivjGPr+/StklcwDN7fnc3V6IJD9G5HS1a9vu1P6u+RxWJMB2Qn2II7X08ybzLGayX7H/Rq4Bauq03kk3bG74S0XNNxzTnqb7appSlmcqJFmI253FpCSPN2TfL5TbeUhz2vRbUl1EPeSVxwxNk9mXHeqo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731710806; c=relaxed/simple;
	bh=SHfm1H6utnhnE/6b4Wl0eT3+Xuyn8mMuSgWmzDEK3G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKExBldowP9foLuQhlLTBem1rZCs1SSEoe9O9mQKMrlyAl7Goq6L4gO+JiWAHuETHhiaQOBPMna55ABXc0Fj+vJQyx7ggXqXP/MdnTcdTTWUVSOtVCfXHQTD4MUXA18Cnt8NVItxC+146s1LqKb3ap/Mzw1y1mtDRFUlq04c4mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Whyit7I0; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Nov 2024 22:46:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731710801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F+XkfQkv61y6MHM2C1K/HEDEHbXtzc7+sIRDedcjJLs=;
	b=Whyit7I076zGP5Iwr9ST+6OduULZjhg5bVi+kdfyPiaGLRPb4VHRWI5BJd5by6z9h4taTa
	eu24NjZErNOggMrWrp1MDnHzDfGiBeLd7kwRPpIDowL2Bh/fbwqXjz7NuLubtNB4hTHxJ/
	yWosy5VPqBgnWfQmUoaZXoekT93lwr4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Michal Hocko <mhocko@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH 1/2] mm: swap_cgroup: allocate swap_cgroup map using
 vcalloc()
Message-ID: <ZzfPS_YFeWVhySQJ@google.com>
References: <20241115190229.676440-1-roman.gushchin@linux.dev>
 <tygpha75uaeztnihylxyiguts2xfdzwr4arz4dwsygmbspdubr@gqwcze4d5ufd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tygpha75uaeztnihylxyiguts2xfdzwr4arz4dwsygmbspdubr@gqwcze4d5ufd>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 15, 2024 at 12:17:43PM -0800, Shakeel Butt wrote:
> On Fri, Nov 15, 2024 at 07:02:28PM +0000, Roman Gushchin wrote:
> > Currently swap_cgroup's map is constructed as a vmalloc()'s-based
> > array of pointers to individual struct pages. This brings an
> > unnecessary complexity into the code.
> > 
> > This patch turns the swap_cgroup's map into a single space
> > allocated by vcalloc().
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thank you for reviewing the patchset!

> 
> [...]
> > @@ -215,19 +169,8 @@ void swap_cgroup_swapoff(int type)
> >  	mutex_lock(&swap_cgroup_mutex);
> >  	ctrl = &swap_cgroup_ctrl[type];
> >  	map = ctrl->map;
> > -	length = ctrl->length;
> >  	ctrl->map = NULL;
> > -	ctrl->length = 0;
> >  	mutex_unlock(&swap_cgroup_mutex);
> >  
> > -	if (map) {
> > -		for (i = 0; i < length; i++) {
> > -			struct page *page = map[i];
> > -			if (page)
> > -				__free_page(page);
> > -			if (!(i % SWAP_CLUSTER_MAX))
> > -				cond_resched();
> > -		}
> > -		vfree(map);
> > -	}
> > +	kvfree(map);
> 
> Any reason to use kvfree() instead of just vfree()?

No, you're right, vfree() is a better choice here.

Andrew, do you prefer a v2 or it's easier to master a fix-up?

Thank you!


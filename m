Return-Path: <linux-kernel+bounces-260245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2A193A4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25E8BB229C3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028BA157A48;
	Tue, 23 Jul 2024 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kVpFifPp"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287F1E522
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755843; cv=none; b=bErcyIYtcKVQsRk3ZcrPLpAH0bNAcxLP3p9Zz3okFJbrgyNdQ2H6fqFPINmGnZN8TWTkueRg9Hkx0vOHKoTHS4HVrnJKOJFLzfGXblmZcbYIPj2y7gubzNA0Gygga4OOz56ThUsLLZhQWuL3mJ/E07pz8vfVYtJZd5fyf2lQWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755843; c=relaxed/simple;
	bh=DwPAdNykstygkA2sE8N3G/tSKadzfVYIwT69D3XZ6Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw3soGj9C0ZmHsQknhObo/PwkXCDnS8DTRyG0uspm6MW1tWWYARqjOdEm3XdnYW9Kg6YPsAxxKgEoPPOfhIIPNqzJDz/xWIUyfakt0IXVdL3SKOvs5b/PV3rv7f0FMFmsxptOX3slfgVcEjhR3zC7aTZYgnI1RpPuQE8v/4UHcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kVpFifPp; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721755839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9cHdPzr4K9qQeSBivFdfCoG2vPWvfw0XuNk1DtimTEQ=;
	b=kVpFifPpYQPrrjq5ozBJoceCWBa48WJkEok+vg7l/jgJMGF+t1cKPS5yV36Gp2z9H7ZXiO
	f3BBBqRu5KkDqc+8YWQ2V7NYKxnI3Ecj9W8UVhJ5tV3WBJl8ZLUH7CwOSbrj1h7ZUhd9qs
	i5hKD2EvTvAAur5n+4jijr3Nl3A4MxA=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: oliver.sang@intel.com
Date: Tue, 23 Jul 2024 10:30:31 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] mm: memcg: add cacheline padding after lruvec in
 mem_cgroup_per_node
Message-ID: <4xrfzyqmmq5gmowvyxxqn2xogo4o3rktc2btces3zeamhnaoxz@kor2cgbm46ou>
References: <20240723171244.747521-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723171244.747521-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 23, 2024 at 05:12:44PM GMT, Roman Gushchin wrote:
> Oliver Sand 

Oliver Sang

> reported a performance regression caused by
> commit 98c9daf5ae6b ("mm: memcg: guard memcg1-specific members of struct
> mem_cgroup_per_node"), which puts some fields of the
> mem_cgroup_per_node structure under the CONFIG_MEMCG_V1 config option.
> Apparently it causes a false cache sharing between lruvec and
> lru_zone_size members of the structure. Fix it by adding an explicit
> padding after the lruvec member.
> 
> Even though the padding is not required with CONFIG_MEMCG_V1 set,
> it seems like the introduced memory overhead is not significant
> enough to warrant another divergence in the mem_cgroup_per_node
> layout, so the padding is added unconditionally.
> 
> Fixes: 98c9daf5ae6b ("mm: memcg: guard memcg1-specific members of struct mem_cgroup_per_node")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202407121335.31a10cb6-oliver.sang@intel.com
> Tested-by: Oliver Sang <oliver.sang@intel.com>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


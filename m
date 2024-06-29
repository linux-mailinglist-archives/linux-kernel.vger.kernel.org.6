Return-Path: <linux-kernel+bounces-234727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13191C9D7
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924CF1F23089
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0886EDB;
	Sat, 29 Jun 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ll/8mQxs"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5334D365
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719622362; cv=none; b=FDw+bOFNzkr2V1NeDXhJr6StFQxxjzvOcnYfQjZsX3iklP8Fsixaj36nypWMGDzMEyGGroja/Tqt2nbsnSQ5IrFL6LV8fwSrecmzRkbOQ6xyC5Yx9vr/3VKZfUbb2X2qlUXM7MvkSmTSG8bA9RGHLK9KmVeFWJiJlvE9u2dtCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719622362; c=relaxed/simple;
	bh=8KQ30hbG0gbF0SKihtXeemuskyTVq0D0Xu422lLL13A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpJX4K6lPoo9/oVt2OPuO9dYuAiwmcfVsIu9qu229bIilDFh8Bl1144BBp4bBZUcnQnxLKZNNJGjwrazcEKmZhwNFzzL/l08nUzkA4a+MjqyHlFglUcTL48mMMg/dJcRXG9kmyr78Ouw6WvzwHt/HQb3EC1TV6irAMuWzGPNDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ll/8mQxs; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719622358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ff7tgazsT1nDgKOq79Cr0QpW2ZWTgrWkaozuK1JvS3Y=;
	b=ll/8mQxsXlF/QH5BVlusnu5oJPHaCMPL7A5SSZFVIIFzYWduMYqo5CvFbBV0asAQxdNeiM
	lc/uYs4zpEqv1kC5WwOgYlkDi+hYiBMz4GbCTB5xl9azSSBxAZ35WGqPR1qRE2JPFYFZ8N
	Lld56mIXUuvcz9wHhS2hkmxkqz+xCN8=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:52:33 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 7/9] mm: memcg: guard memcg1-specific members of
 struct mem_cgroup_per_node
Message-ID: <sf5dhfhw672hnx6w3jgiovspllzrrpxbvbkx47kgpxdvzu2hzm@ghcyrbnnirix>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-8-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:15PM GMT, Roman Gushchin wrote:
> Put memcg1-specific members of struct mem_cgroup_per_node under the
> CONFIG_MEMCG_V1 config option.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/memcontrol.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 107b0c5d6eab..c7ef628ee882 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -92,6 +92,7 @@ struct mem_cgroup_per_node {
>  	struct lruvec_stats			*lruvec_stats;
>  	struct shrinker_info __rcu	*shrinker_info;
>  
> +#ifdef CONFIG_MEMCG_V1
>  	/*
>  	 * Memcg-v1 only stuff in middle as buffer between read mostly fields
>  	 * and update often fields to avoid false sharing. Once v1 stuff is
> @@ -102,6 +103,7 @@ struct mem_cgroup_per_node {
>  	unsigned long		usage_in_excess;/* Set to the value by which */
>  						/* the soft limit is exceeded*/
>  	bool			on_tree;

Here we definitely need a padding after the pointers and before the
lruvec. We can add a #else to the #ifdef CONFIG_MEMCG_V1 and put a
cacheline padding in it.

> +#endif
>  
>  	/* Fields which get updated often at the end. */
>  	struct lruvec		lruvec;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 


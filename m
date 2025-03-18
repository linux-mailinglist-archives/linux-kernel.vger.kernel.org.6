Return-Path: <linux-kernel+bounces-565229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0A1A66412
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068461885AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2783D3A1DB;
	Tue, 18 Mar 2025 00:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TpjbFmcB"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7167D528
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258668; cv=none; b=lq5/bxkCZXZdmsmNfhrkcGIOAGjt1o4KQA9BjdZrhKInq3YLy386CxTBo8zW1kXNaESJP59fboAClHiAWm7z8i3m7uhv1Rn/cX7MuL0JGYStDGi3QYQcBbZ3lUBb/nbY7cFewN1FMstmi9pzdqgzA4kBZbW2uMEp3pxbvuW6C5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258668; c=relaxed/simple;
	bh=F3vD+NRW7UkJ+0yytSNN7OXbaglUyoVsb6mjeXb459A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDAReu8FBOcyf5RXfZ7K0K065+TJKViSGYPEs3U6HQTRpCnYASjYZvk+ebrR+4LjwH558FeY6yhKw1piB/i8myrz/CifTO5iiYeqsSpmdJVMySewXU2OoTItZhb8MYlntSwQtwKcJ2g1WyVy7xtgPV+0VylRsdXyw/uv44S/eCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TpjbFmcB; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 00:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742258653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C7kakdstnKjvLGQIhEhWpQEdZQmyKZq0R1gZch3KMP4=;
	b=TpjbFmcBC0KcZsaXeJOmFuFyAWlkA9Rj73jyr1MVjg3tjIaKUnbfB4EZ21KWOphqE8qKM3
	EsJxpjvhGxPbMKalATQwSlz44zwQtxZZZJG9TStCQ00dgJKhLxzOC4bwwTguNvmgPPO9Jl
	4Hh/ZZIPd4rxRq4pXCiTvVRUEhjNAJU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 2/9] memcg: decouple drain_obj_stock from local stock
Message-ID: <Z9jB2DFVY2R99ekS@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-3-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-3-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:23AM -0700, Shakeel Butt wrote:
> Currently drain_obj_stock() can potentially call __refill_stock which
> accesses local cpu stock and thus requires memcg stock's local_lock.
> However if we look at the code paths leading to drain_obj_stock(), there
> is never a good reason to refill the memcg stock at all from it.
> 
> At the moment, drain_obj_stock can be called from reclaim, hotplug cpu
> teardown, mod_objcg_state() and refill_obj_stock(). For reclaim and
> hotplug there is no need to refill. For the other two paths, most
> probably the newly switched objcg would be used in near future and thus
> no need to refill stock with the older objcg.
> 
> In addition, __refill_stock() from drain_obj_stock() happens on rare
> cases, so performance is not really an issue. Let's just uncharge
> directly instead of refill which will also decouple drain_obj_stock from
> local cpu stock and local_lock requirements.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


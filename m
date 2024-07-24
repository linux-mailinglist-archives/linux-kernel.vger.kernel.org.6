Return-Path: <linux-kernel+bounces-261592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCEA93B999
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3441C23506
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB1143C4C;
	Wed, 24 Jul 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="en1q0hKd"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3434A39
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864632; cv=none; b=degTQ5I6PUOJjhQ+CwvLBGHt3nEwig4CWMNkyF7i/CY1zKfDDYCa9lFSLRngP5je1SvnPYiC5fx4VG/uh9P8AfRddU1T6jp2QDxpPbsJMf4I/xM1iVHUIH56CMQrXardPlHpVN837L0RejA1VHibOdjZ6awrUaqrU9wZb9K4Vig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864632; c=relaxed/simple;
	bh=41KFLH3NijeF/8a5ycS9iUnv9YBywhFngD5blkqZN80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix7kq15nFbBfmsVpgxErhYcUtEDHhyNtMFx0ADQWx+egY+rFbURY08zkbaxEVmOtOmU4TyZIWcURbH9ortQRlDybXxD43WOsinOwtonNXjgVe5NsCc02ILMyIiJ1fOTk9+9QXgR2Qti8OsOik/HF+fCPrxLnVlOKt/Hjhm0pH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=en1q0hKd; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 16:43:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721864624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CIPcIIxxy9z4+epxsP0r2wMNd2Sp+GzWaFR17pD0fGg=;
	b=en1q0hKdbKM1ZUVuiv00Ks+fozZGUtfMf/tbuwhw6l3thhi9LSnkOSKW/Og+dBdxaDndeK
	JelQBUgHulWV1N+pJ0cb6fRNHMrluVR1IHnHCE6LlweCpu8d+7XUqdoGaw/YeRN3gc5PwD
	zUtyWJVSfiGuSR/ttEDOxv62fEZBUSw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 3/5] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <7bm2a2bwwq3jfmdazu23tie3uajvkfzfsrmaeujv4maz4cxvt7@sdth2ybkn4k3>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-4-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:21:01PM GMT, Roman Gushchin wrote:
> Struct page_counter is used by memory and hugetlb cgroups to track
> the resource usage. Memory cgroups are using up to four different
> counters (on cgroup v1). Hugetlb cgroups are using 2 * HUGE_MAX_HSTATE
> counters.
> 
> Every page_counter structure (except the one belonging to the root
> cgroup) contains a pointer to the corresponding parent structure.
> It's obviously wasteful because for each cgroup there are several
> similar chains of page_counter structures. It's not particularly
> cache-effective too.
> 
> Also every page_counter structure contains fields required for
> tracking the usage of the memory protection, while it's used only
> for the main ("memory") counter and only by memory cgroups.
> 
> To address these issues let's make page_counter structures to support
> N counters and use a single page_counter structure for a memory cgroup
> and 2 page_counter structures for a hugetlb cgroup (to track the
> actual usage and reservations).
> 
> N is determined at the compile time depending on the configuration and
> HUGE_MAX_HSTATE value. HUGE_MAX_HSTATE is relatively small on all
> existing platforms (max is 5 on sparc), so it's not too far from 4
> memcg memory types.
> 
> Memory min/low functionality is supported only for the first counter.
> 
> Memory savings (on x86_64):
> 
> |-----------------------------+----------------------------+----------------------------|
> |                             | memcg                      | hugetlb                    |
> |-----------------------------+----------------------------+----------------------------|
> | original, CONFIG_MEMCG_V1=n | size: 1600, cachelines: 25 | size: 1280, cachelines: 20 |
> | patched, CONFIG_MEMCG_V1=n  | size: 1472, cachelines: 23 | size: 1024, cachelines: 16 |
> |-----------------------------+----------------------------+----------------------------|
> | original, CONFIG_MEMCG_V1=y | size: 2176, cachelines: 34 | size: 1280, cachelines: 20 |
> | patched, CONFIG_MEMCG_V1=y  | size: 1664, cachelines: 26 | size: 1152, cachelines: 18 |
> |-----------------------------+----------------------------+----------------------------|
> 
> So it's 10-35% reduction in the number of cache lines depending on
> the kernel configuration.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


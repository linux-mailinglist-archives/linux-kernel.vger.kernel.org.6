Return-Path: <linux-kernel+bounces-261523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A4B93B83E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 22:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C795B2290E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 20:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0E13A878;
	Wed, 24 Jul 2024 20:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qXqOq+iG"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51B9136E18
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721854367; cv=none; b=uaTDK63uF+1BqBVPxryXOwGnHcOyM4K3kNbdzgqL2EfjoeivvY6TwI8Xprxv/GGzg8NamlKfqIhpbUvr7jFS2f1xNkzC7buiozVFAOFizw1JXOfJO94ShGiejzmFiFIDU5c1RO3sWhsmxfZs2zXNdijunMAE8qsCelMMH7Dcsx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721854367; c=relaxed/simple;
	bh=+fKKsvG7l0rY//BDzZBA00lz0E7lDlrO4tgLevspNqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJrqq28Q1A7SxUhlrnIiHjAR9vyoVNfUJP1JBKjp9v4wO56Lk4ceoslF0jUPIoPWTnqeYw75PA6geabYdEv31c7gi1X2vqhnx0IpnJ2VZoot5y9ED9GP9L4luH3eB5rDicDxX4QVqzSeKAYxCCIB21W/fY9fW0Tun50QTmfm2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qXqOq+iG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 13:52:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721854363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8oEYtDqRCidvl1ML54l/KCYLGkWbzzfgqJgJQTvbIpY=;
	b=qXqOq+iG+uE2WNLgXhMeANfi5WvBS/kCYyPjYvuWsR/+KoFccSAvjouCt1Yjb7ZbD0r1yo
	6Wg0am5KfKyv9w3xv9Jf+gjOFqGqj/w+sVaHS2jNtqkoLCFqPFGYAiX3Cpn2vFRUkG6O1h
	yicmIqA8lJCNpdeGUnZBSCKt43ijEqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 1/5] mm: memcg: don't call propagate_protected_usage()
 needlessly
Message-ID: <yeic3imklc46iztcx2djt2ygxac57k7aeaaajkmp2vbfsd3gjr@ibfxai7ctndk>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:20:59PM GMT, Roman Gushchin wrote:
> Memory protection (min/low) requires a constant tracking of
> protected memory usage. propagate_protected_usage() is called
> on each page counters update and does a number of operations
> even in cases when the actual memory protection functionality
> is not supported (e.g. hugetlb cgroups or memcg swap counters).
> 
> It's obviously inefficient and leads to a waste of CPU cycles.
> It can be addressed by calling propagate_protected_usage() only
> for the counters which do support memory guarantees. As of now
> it's only memcg->memory - the unified memory memcg counter.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


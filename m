Return-Path: <linux-kernel+bounces-565257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A98A664A8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC3B9189F177
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7C25336D;
	Tue, 18 Mar 2025 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BAxalUnB"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCF126BFA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260050; cv=none; b=FW09prJJ39cHiMPGLkipGzxyNR4KYuSmGmc29+AoXt2kKUw1yWQJD3I1AbZmWHoUrLzFw4pSAVq1ObNRNAvzv8E2ANhcIFyokq1E0vIjxMVHqIp+DB69Gyv4SM4f6bVNm4wbVvqdXC+k0qrhCyzx1qCsn310abWcsWBkkrypF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260050; c=relaxed/simple;
	bh=o3ntH+VyxBbQxuXAIdQdU6Z4EDjFyFPzkvUVQn5XsYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui68wz9Nsj/dMmcQHs2x/zqYhHopTENEbVXjDd/CdFWFj6Ulc+0Aet0uq0YmdTuWBvy3vilLAFed8cNEC/eOahlPTTyta1UXde4OrWrcYzELjpXNR7KXbpb6vLtCMTCjbzaE94UEkxSRUIpCuJNve1GGG5Uq7vtrhIienPgm1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BAxalUnB; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9mPeLIacidUCCPqGAAEH/lqRKjMQTyR3oZRrUoAsBGw=;
	b=BAxalUnByRD9ldhNz0FH+D2OiWjrXYA+0FmMAzx1K8mp1ZMvRk2BimXfnmVvfghjfnlRfO
	yFMkgKFnWXYFg7rF3TzWlScC79a7uk3NOcz9RRlvmi2XcT7w3G74o4/e/lNigrxoK5COcX
	iz9PX83xKCCNSrblZ9Ny/rcQiKiwVzs=
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
Subject: Re: [PATCH 6/9] memcg: do obj_cgroup_put inside drain_obj_stock
Message-ID: <Z9jHRnXnAnL0Mcjn@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-7-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-7-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:27AM -0700, Shakeel Butt wrote:
> Previously we could not call obj_cgroup_put() inside the local lock
> because on the put on the last reference, the release function
> obj_cgroup_release() may try to re-acquire the local lock. However that
> chain has been broken. Now simply do obj_cgroup_put() inside
> drain_obj_stock() instead of returning the old objcg.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Nice one too!

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


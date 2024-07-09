Return-Path: <linux-kernel+bounces-246775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5592C685
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111691F229FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144A185627;
	Tue,  9 Jul 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ChKpY3vx"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DA7E765
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567068; cv=none; b=MckbTTiSu3yekuzBwHpxENf/vN6zWF/9rdiH/q9mk30JTA1VAoHS4ZdmfZ99dkX2RypYT/jFBnQtzIIB/2545UbvrhSOrNKc9lQkiyZJY+A0aeM+T9eLlbq2qkIewlkJyyJxZcyWvqNtIfWf2vtyK/V96/BJso+UhaXUljLl3/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567068; c=relaxed/simple;
	bh=hkJh2G245kK5yrln/5bUKqe0hGrf8KQTzgcYqUoCgGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRg04boIyHWaziZZnC0H6iVyi0vdWCqGA8DLUD1GO6v1nfXYNQRJph7YbgCx8W9HkzIdPni8uuqHuXDqveZN7bqiC8qf8rcmaCaQP5N6MuEwgKVEt/OCdlAZ7wMucmj3J9SG0YNlXrZL8MeXHRTq/gpbxPwDaUlB01t5eshxXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ChKpY3vx; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720567065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RK9Y5z4esCl/0wptVyHMDsH+At4AHH/Nt2PZDk2eccU=;
	b=ChKpY3vxx6hvZJVlnM5gYc5SXa7vsvbzJ9mPy/9wkA9eqerHdTd3W8vlsRFsZOgLyN+B37
	ZbM5USYjUy55AzSJECEvXkyXSPb2f3+mJCD+k2s6HXGVVoB9b2wTXDZUFN9UpihF6L3mU2
	P2JCIKziJIoO6+AUSBmK6j93sC/2Wdo=
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 9 Jul 2024 16:17:31 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V6] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <3oyf3p3xyhxxugucwsuhtuais6547rvzob5fkz3yc7jgocow2n@odqb6l2oweto>
References: <172052399087.2357901.4955042377343593447.stgit@firesoul>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172052399087.2357901.4955042377343593447.stgit@firesoul>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 09, 2024 at 01:20:48PM GMT, Jesper Dangaard Brouer wrote:
> Avoid lock contention on the global cgroup rstat lock caused by kswapd
> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
> call inlined in shrink_node, which takes the rstat lock.
> 
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
> we noted severe lock contention on the rstat lock. This contention
> causes 12 CPUs to waste cycles spinning every time kswapd runs.
> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
> due to spinning on the rstat lock.
> 
> Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
> causing all kswapdN threads to wake up simultaneously. The kswapd thread
> invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously. Leveraging
> this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
> cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.
> 
> To avoid this kind of thundering herd problem, kernel previously had a
> "stats_flush_ongoing" concept, but this was removed as part of commit
> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
> reintroduce and generalized the concept to apply to all users of cgroup
> rstat, not just memcg.
> 
> If there is an ongoing rstat flush, and current cgroup is a descendant,
> then it is unnecessary to do the flush. For callers to still see updated
> stats, wait for ongoing flusher to complete before returning, but add
> timeout as stats are already inaccurate given updaters keeps running.
> 
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/

Does this version fixes the contention you are observing in production
for v5?


Return-Path: <linux-kernel+bounces-568729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D63AA699D0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5DC189BE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EB421480E;
	Wed, 19 Mar 2025 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Lpgz7SGh"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C05921420B
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413917; cv=none; b=twh6qGucd9EqsPdX7Y3tGHOY98NGf1o6hkWFauOKgLcPtgnVGPZ+srosO5is2fweJYMRHonutIT4tkBzJD1H6U0gj1dvwCcK2GpgWE9kQhBGj0RlJ9tGo+FFUXLKfWmFqEsRtFTW+uHdZnwToQF+ft5st7vP5hIzYlO5ErsLpPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413917; c=relaxed/simple;
	bh=HN5eIXWdGopBCpBEbJ9mpWJ+ld+jJk0lkQLW90W9lUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VaPKUpXaqtMhL1+DAcB047aZdtjzfcLyYEQPGk47EScInMQPN7ZGCmvQIuqAqJDQMUNnArFhnIj2/hnQOp2hZoGGJLXDnf/rMhNPuRHaBU2d/jRQJONDewXw56Y2nX5NKM85EYaSXuLH6BFoHT3hnj0EmpKgY97Rx4LxNXgb1PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Lpgz7SGh; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 12:51:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742413913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aHgZcT1OHid9wj/QcT/hae8vjIoU8PnHq3r0EIbYZD4=;
	b=Lpgz7SGhCMwypbwd8JKXXD5zkrPvifG4egMIHmtaMFUa8q0QzeszfeGuiKCFCJflpJruT3
	rVNcVgU0sm0q7qcNSPpB0bVEG4CjuCxDZXnLUL0fQ+ACwtOHdFmjz0VyO3k1eCqzifiGD1
	EEW1XPZllaW2p7yJHw5qH/8WNZUnIiM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jingxiang Zeng <jingxiangzeng.cas@gmail.com>, 
	akpm@linux-foundation.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, kasong@tencent.com, Zeng Jingxiang <linuszeng@tencent.com>
Subject: Re: [RFC 0/5] add option to restore swap account to cgroupv1 mode
Message-ID: <vfy3aq3zzpjscku6mody34qhwhdnwmas5evxowfleuyl457ggq@cmvlcu5mk34v>
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
 <20250319193838.GE1876369@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319193838.GE1876369@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 03:38:38PM -0400, Johannes Weiner wrote:
> On Wed, Mar 19, 2025 at 02:41:43PM +0800, Jingxiang Zeng wrote:
> > From: Zeng Jingxiang <linuszeng@tencent.com>
> > 
> > memsw account is a very useful knob for container memory
> > overcommitting: It's a great abstraction of the "expected total
> > memory usage" of a container, so containers can't allocate too
> > much memory using SWAP, but still be able to SWAP out.
> > 
> > For a simple example, with memsw.limit == memory.limit, containers
> > can't exceed their original memory limit, even with SWAP enabled, they
> > get OOM killed as how they used to, but the host is now able to
> > offload cold pages.
> > 
> > Similar ability seems absent with V2: With memory.swap.max == 0, the
> > host can't use SWAP to reclaim container memory at all. But with a
> > value larger than that, containers are able to overuse memory, causing
> > delayed OOM kill, thrashing, CPU/Memory usage ratio could be heavily
> > out of balance, especially with compress SWAP backends.
> > 
> > This patch set adds two interfaces to control the behavior of the
> > memory.swap.max/current in cgroupv2:
> > 
> > CONFIG_MEMSW_ACCOUNT_ON_DFL
> > cgroup.memsw_account_on_dfl={0, 1}
> > 
> > When one of the interfaces is enabled: memory.swap.current and
> > memory.swap.max represents the usage/limit of swap.
> > When neither is enabled (default behavior),memory.swap.current and
> > memory.swap.max represents the usage/limit of memory+swap.
> 
> This should be new knobs, e.g. memory.memsw.current, memory.memsw.max.
> 
> Overloading the existing swap knobs is confusing.
> 
> And there doesn't seem to be a good reason to make the behavior
> either-or anyway. If memory.swap.max=max (default), it won't interfere
> with the memsw operation. And it's at least conceivable somebody might
> want to set both, memsw.max > swap.max, to get some flexibility while
> excluding the craziest edge cases.

At the moment memsw and swap shares the underlying page_counter. This
would require having explicit page_counter for memsw.

What's your take on memsw interfaces still behind
CONFIG_MEMSW_ACCOUNT_ON_DFL?


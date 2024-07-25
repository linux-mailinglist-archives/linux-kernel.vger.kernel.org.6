Return-Path: <linux-kernel+bounces-262655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBBF93CA18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F761F22C30
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB0C13B5A0;
	Thu, 25 Jul 2024 21:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aPmXhEtw"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C42AD299
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941779; cv=none; b=B6f4Op5e/82rBkDaiNh+ZSYEFss7TqI4zOoG3baa7FIR3BIIOR9ALdHhzjKHSpqsDYq/zsDoBn86m/s1kcUVa3xpXmkg7dGY+64Vbv4XJnG2AsD1M6224uhAtvwg582OnPo2tLK+zHXwvcm1gzS5xb97DHvjSBj/AyRCVNOyqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941779; c=relaxed/simple;
	bh=hpoK2O+1nbhmelUyB2+WwH8R4HEgvO04+ap6yEfnN5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlC0uvMjBIpTiHKOT7vPh5mMqOLhRIrDnDRRogycEuY7TTIg1Rmo+jWNFhi/azPqi3/WN9BKZCyu824tSzYncbqVlExBya5yL0LlL8p9u5yOsBU/9VY6M8dbmewi2VxKB/hGUOZ8cedt9wq5vwaKpLJqiqYXcCHB/NtG9UddI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aPmXhEtw; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jul 2024 21:09:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721941773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pCPuEvOfteQD+7e1yz6EqoVenBGR0CrTD60+z0NUItc=;
	b=aPmXhEtwggljIX6OydnpC1U4iR61AvfVSPKPA4B/QtqT7wdT604LQFifUImkBLXy2sDYsk
	UFmidENcu2kPjny2RAYkiXO9vqlcg850YlJGQadzTmlfGysfnFi7ovCCAf+IF+DuLyQdw+
	LTOtOqgClu6rXizs8HijFwta96N8xVI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kinsey Ho <kinseyho@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during
 traversal
Message-ID: <ZqK_CG9AtBy9mVVH@google.com>
References: <20240724190214.1108049-1-kinseyho@google.com>
 <20240724190214.1108049-2-kinseyho@google.com>
 <20240725204346.GA1702603@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725204346.GA1702603@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 25, 2024 at 04:43:46PM -0400, Johannes Weiner wrote:
> On Wed, Jul 24, 2024 at 07:02:11PM +0000, Kinsey Ho wrote:
> > To obtain the pointer to the saved memcg position, mem_cgroup_iter()
> > currently holds css->refcnt during memcg traversal only to put
> > css->refcnt at the end of the routine. This isn't necessary as an
> > rcu_read_lock is already held throughout the function.
> > 
> > Remove css->refcnt usage during traversal by leveraging RCU.
> 
> Eh, I don't know about this.
> 
> RCU ensures that the css memory isn't freed.
> 
> The tryget ensures that the css is still alive and valid.
> 
> In this case, it just so happens that the sibling linkage is also rcu
> protected. But accessing random css members when the refcount is 0 is
> kind of sketchy. On the other hand, the refcount is guaranteed to be
> valid, and rcu + tryget is a common pattern.

I also spent quite some time thinking about potential bad consequences,
but _it seems_ to be safe (but I agree it feels dangerous).

> 
> What does this buy us? The tryget is cheap.

To be fair, tryget is not always cheap. Offline/dying cgroups have an atomic
operation there.


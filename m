Return-Path: <linux-kernel+bounces-397319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C39BDA5E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844171F24476
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8876061FEB;
	Wed,  6 Nov 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6YLLdSd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA5CA5A
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853235; cv=none; b=ghElkLKdMd0srOtbaggK4YrLFiksf42TCeVv7Vem/ArBxF20pb28rBME3zxPaDuBhpdDLBCGGs0BxDIrd5p9US1QRoqdQycD5Km6GUpPcVMlNF9NfKWfb+SuaitYhJEeGkCHIWZnferntSzwgLCVVFrxglI9/5QK81GNL9UgaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853235; c=relaxed/simple;
	bh=3wzrMsXrDoCgqEE7p0Ouhq3heGwPmfe/6ZEZcV3rZ30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6PS+4BAaASBqooRYW20nmxMg0GhYflQyK8DtNOjXLgJBNZIdLKPhdu/UHCq/d+wZeigyjuw8yJ5Xj+Put32HJ3A6LI0omOJkGYzyByz8jDvnSg5wx0Zj+upPmBLCCiRFWUC3rTItP2kIqpvtXfKUQLqL2KgbNaKEwKxs9pEEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6YLLdSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7488AC4CECF;
	Wed,  6 Nov 2024 00:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730853234;
	bh=3wzrMsXrDoCgqEE7p0Ouhq3heGwPmfe/6ZEZcV3rZ30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6YLLdSdGnXazWUPcIZMvdt7QYyaH0lgO6PK7n91NIVsAv+pSlUhzfDc9oU9TjqFJ
	 GZvzuhSLi+WGCYUL+C7EkvX+5Aeg3veoWfvM0qHUkVbUe5m/fql0IMGyit6DySqgOV
	 6odUNJ7BttHJAOMXAQ+6NFuaTcARhjO0c2p6zAow5YH91cOsZClVVxeUnWe8hdOZ6/
	 tj5DraFctPajzGbGOv6KvAvyQvSmBrx+mB16lQzb8RJz0tRn+8ygQODoENPdx0nfrV
	 x2qh1F9pApflyuFPScLlI0R/drzMkFGwmgaZ32UndkmavY90FywmDGgV2XhZ5ifAPf
	 xzDMEJCV8ndMQ==
Date: Tue, 5 Nov 2024 14:33:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zyq5cX9fLE-3wZSx@slm.duckdns.org>
References: <20241031073401.13034-1-arighi@nvidia.com>
 <Zyqq9fnsOg56aO7S@slm.duckdns.org>
 <Zyq4VFpbaKXERdDh@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyq4VFpbaKXERdDh@gpd3>

Hello,

On Wed, Nov 06, 2024 at 01:29:08AM +0100, Andrea Righi wrote:
...
> Let's say we have 2 NUMA nodes, each with 2 sockets, and each socket
> has its own L3 cache. In this case, numa_cpus will be larger than
> llc_cpus, and enabling both NUMA and LLC optimizations would be
> beneficial.
> 
> On the other hand, if each NUMA node contains only 1 socket, numa_cpus
> and llc_cpus will overlap completely, making it unnecessary to enable
> both NUMA and LLC optimizations, so we can have just the LLC in this
> case.
> 
> Would something like this help clarifying the first test?

I was more thinking about the theoretical case where one socket has one LLC
while a different socket has multiple LLCs. I don't think there are any
systems which are actually like that but there's nothing in the code which
prevents that (unlike a single CPU belonging to multiple domains), so it'd
probably be worthwhile to explain why the abbreviated test is enough.

Thanks.

-- 
tejun


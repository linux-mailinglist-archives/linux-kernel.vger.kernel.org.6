Return-Path: <linux-kernel+bounces-261606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 079BE93B9C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D57C1F21E34
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B62187F;
	Thu, 25 Jul 2024 00:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wo4xR7ko"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B41F17C2
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721867125; cv=none; b=CDtT7Dqxr2JoADLnL3H1UoZL1x8jVLx7e2clgZlpQj8EJuTeVRDPemlia7Iwa/bK+4U2pt1cbvf0sPs1CCoUQIpD6hHyBA0NQM/JxjM5bAbphQulVWtyvswp60JekSH8skzt2PWCr7cQS0qtzOTOjH2f+TwpazS12/u9mt8q2Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721867125; c=relaxed/simple;
	bh=OVgAT4kFVK5nQL4LJ4RzeoqCSvbwsqoNvxZg/8f2Cpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzNIDfa/227Qdg6Mhc+IyqOlr3uq27jhoPUt2KErrEv2lCR/t6UArDn9K5qFmRuXNiqB7B1wMPfjKS7Wab9q32+moaL9MQ/KrpGjSBLZCScpPwAqmPC9h46cU+rtRYSkCCBc9rsuJbS+qQs+ltcjKhe0vmHgX+KYdi3r9NQNj3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wo4xR7ko; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Jul 2024 00:25:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721867120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9i8xCty+wlBhuD77WYEniSm6emEYVnVvP2uoezmkh64=;
	b=wo4xR7koN+IE2YAJNgdj54jBKUwwPmzby5nMtbcIECvDux16LD3XnjhPUq7e/LM+1+UKM5
	nicWcrdd6vSe1CaGTuAkb+MOi0vLvJZruaVrzXL6ZL6Ph+q0Jz2bc0/Qc47fC+wqY8JdoB
	3JNu6c1DvsPNgU6zJxUkZwq49EmOjhA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH mm-unstable v1 0/4] Improve mem_cgroup_iter()
Message-ID: <ZqGbbN2Ue8HLlVmL@google.com>
References: <20240724190214.1108049-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724190214.1108049-1-kinseyho@google.com>
X-Migadu-Flow: FLOW_OUT

cc memcg maintainers

On Wed, Jul 24, 2024 at 07:02:10PM +0000, Kinsey Ho wrote:
> Incremental cgroup iteration is being used again [1], but incremental
> cgroup iteration was introduced for cgroup v1. It hasn't been fully
> maintained for many years.

This is a bold statement :)

> This patchset improves the reliability of
> mem_cgroup_iter(), along with improving simplicity and code readability.
> 
> [1] https://lore.kernel.org/20240514202641.2821494-1-hannes@cmpxchg.org/
> 
> Kinsey Ho (4):
>   mm: don't hold css->refcnt during traversal
>   mm: increment gen # before restarting traversal
>   mm: restart if multiple traversals raced
>   mm: clean up mem_cgroup_iter()

But the series looks great to me!

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

Thanks!


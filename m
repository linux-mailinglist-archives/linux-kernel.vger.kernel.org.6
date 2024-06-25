Return-Path: <linux-kernel+bounces-229358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568A916ECB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCD28D5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1863A176248;
	Tue, 25 Jun 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pfvEsxds"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E81176232
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335041; cv=none; b=o30SW6WTq/9g+HY/FV1/5LSwr2ZJSNLKKZUIFDoPenx7aS4f3eL0ceIS0JFbVbnlu2Gf6DhmcrH5ekUD4AGTOAZpk/IF46iyVSY/k0G0vgB9KkDAZNi5Buud327eMBhpiGgf6DpBtHfAZBWvZml4VdTOYpFgaGpNjjMYjB50yns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335041; c=relaxed/simple;
	bh=hYbg1fTYzfrTslibePhoV7VvrLaFLWrgZARMjDb4/Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kostmcXOCLGRvMOXCv5lV5btEHha7ZXFrYSKtK8xZyKAD1RxEXGb52J9LXetT7/Os9hMb0SdHbvOTocwSdtVM1wUxfvudi/pirKGT0iECZuBw2UZzP70q/Jc/9irGMH+ck4Ynn+nhYiTTpfyM24t1jODMIBBf9gg/1LCVWUKUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pfvEsxds; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719335037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eS9TJekxDVy7pj/kCvzbG6fFW3jQY5tj8X/hscqVo8=;
	b=pfvEsxdsh8mMt4C8BLMqOK1WIsW18E6YqnZhXzVyrSmObWAdWXIylqcLvJLCb9xdT/SmhK
	BilkhaV82DWU/EBGHy+sNNEErSuq2yjtGrzKpAwhLP+N9qcffWumDF983SmLQdSh9lLq5K
	nvtsGBaiT0mhzbysvT62aD8LXZgL03E=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: willy@infradead.org
Date: Tue, 25 Jun 2024 10:03:53 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 00/14] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <rkztmxmrsjw7cdwh3jcbhte3izirveb544vc7qbmpxpc6gmgia@htjd3ozkxpcd>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 05:58:52PM GMT, Roman Gushchin wrote:
> Cgroups v2 have been around for a while and many users have fully adopted them,
> so they never use cgroups v1 features and functionality. Yet they have to "pay"
> for the cgroup v1 support anyway:
> 1) the kernel binary contains an unused cgroup v1 code,
> 2) some code paths have additional checks which are not needed,
> 3) some common structures like task_struct and mem_cgroup contain unused
>    cgroup v1-specific members.
> 
> Cgroup v1's memory controller has a number of features that are not supported
> by cgroup v2 and their implementation is pretty much self contained.
> Most notably, these features are: soft limit reclaim, oom handling in userspace,
> complicated event notification system, charge migration. Cgroup v1-specific code
> in memcontrol.c is close to 4k lines in size and it's intervened with generic
> and cgroup v2-specific code. It's a burden on developers and maintainers.
> 
> This patchset aims to solve these problems by:
> 1) moving cgroup v1-specific memcg code to the new mm/memcontrol-v1.c file,
> 2) putting definitions shared by memcontrol.c and memcontrol-v1.c into the
>    mm/memcontrol-v1.h header,
> 3) introducing the CONFIG_MEMCG_V1 config option, turned off by default,
> 4) making memcontrol-v1.c to compile only if CONFIG_MEMCG_V1 is set.
> 
> If CONFIG_MEMCG_V1 is not set, cgroup v1 memory controller is still available
> for mounting, however no memory-specific control knobs are present.
> 
> This patchset is based against mm-unstable tree (b610f75d19a34),
> however a version based on mm-stable can be found here:
>   https://github.com/rgushchin/linux/tree/memcontrol_v1.1-stable .
> 
> v2:
>   - minor compilation fix
>   - #else/#endif comments fix (Lance Yang)
> 
> v1:
>   - switched to CONFIG_MEMCG_V1 being off by default based on LSFMMBPF
>     discussion [1]
>   - switched to memcg1_ prefix (Johannes)
>   - many minor fixes
>   - dropped patches which put struct memcg members under CONFIG_MEMCG_V1
>     (will post as a separate patchset)
> 
> rfc:
>   https://lwn.net/Articles/973082/
> 
> [1]: https://lwn.net/Articles/974575/
> 
> MAINTAINERS                |    2 +
> include/linux/memcontrol.h |  156 ++++---
> init/Kconfig               |    9 +
> mm/Makefile                |    2 +
> mm/memcontrol-v1.c         | 2933 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> mm/memcontrol-v1.h         |  132 ++++++
> mm/memcontrol.c            | 4169 +++++++++++++++++++++++++++---------------------------------------------------------------------------------------------------------------------------------------------------
> mm/vmscan.c                |   10 +-
> 8 files changed, 3794 insertions(+), 3619 deletions(-)
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

For the series:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


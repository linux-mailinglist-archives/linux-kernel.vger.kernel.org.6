Return-Path: <linux-kernel+bounces-206408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1E2900931
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 065AA1C2153B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDA1991A4;
	Fri,  7 Jun 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RCFPzykk"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F98199E8C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 15:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774168; cv=none; b=ZmaqiZbvEWp2tD0AAgUbjAcGwA4/Y6xU5LxNiLIOCjWv3oHU7G5zVuIe+psn4OwNDfbQt0rlc63UkcpkAILpWYN3F+hHE0AFEpjWLH6YoGoRz5jSNdHBkB+q9zqzP8mabSDHPj7fNvDvyuNOm0m31XcSf14r7Nyjy4kRrNpeesI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774168; c=relaxed/simple;
	bh=PKZVe4mcn6uOB4HjHJO9HPTtMma60ZTT53tknV4ytJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwBxlmo+7WDkUDhbUI8u+YKx23z1lvxZGPNOlCSqleKZpRgkIFcbPvejquhdk7SqK4T0fC2dVtx/bM+tgbxVsw9KQ///yun9U9JZH+kzJ3/uGLI70qElSnCzgq9qIwEOSSaSxO1qSNeDKBb758n1NBygVCFxafsoMwdHDu6tFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RCFPzykk; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717774163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UAtyDHoN42s2SICjC1kSRt3AHu7WTv3/bhxAklvJG0M=;
	b=RCFPzykkL+F2+d2EfoMzgJ92c240N9+uvkYQb9Nt8V7e8rbo6Dx57KYTdzSObyfKrAHzLS
	CSIJhJop/ds2/LmmBgzW8XWBJZSYZ+s2oy4sOQ9DUPF98h8SaB8MWUWKfgHT9SqO7Qm1lJ
	cF0vONxTJR30aNlQGK3KpYhFx9RV0e0=
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 7 Jun 2024 08:29:20 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <b7qpa2ixaid7lucw6ebur5zljm3jmovpzhepf2rxjftg4zgj74@hr4rjh7uzyow>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi Andrew, can you please add this series to the mm-unstable? Roman and I
plan to add more stuff based on this series, so it would be good to get
some exposure for this series.

Thanks,
Shakeel

On Tue, May 28, 2024 at 01:20:52PM GMT, Roman Gushchin wrote:
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
> rfc:
>   https://lwn.net/Articles/973082/
> 
> v1:
>   - switched to CONFIG_MEMCG_V1 being off by default based on LSFMMBPF
>     discussion [1]
>   - switched to memcg1_ prefix (Johannes)
>   - many minor fixes
>   - dropped patches which put struct memcg members under CONFIG_MEMCG_V1
>     (will post as a separate patchset)
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
> 
> 
> Roman Gushchin (14):
>   mm: memcg: introduce memcontrol-v1.c
>   mm: memcg: move soft limit reclaim code to memcontrol-v1.c
>   mm: memcg: rename soft limit reclaim-related functions
>   mm: memcg: move charge migration code to memcontrol-v1.c
>   mm: memcg: rename charge move-related functions
>   mm: memcg: move legacy memcg event code into memcontrol-v1.c
>   mm: memcg: rename memcg_check_events()
>   mm: memcg: move cgroup v1 oom handling code into memcontrol-v1.c
>   mm: memcg: rename memcg_oom_recover()
>   mm: memcg: move cgroup v1 interface files to memcontrol-v1.c
>   mm: memcg: make memcg1_update_tree() static
>   mm: memcg: group cgroup v1 memcg related declarations
>   mm: memcg: put cgroup v1-related members of task_struct under config
>     option
>   MAINTAINERS: add mm/memcontrol-v1.c/h to the list of maintained files
> 
>  MAINTAINERS                |    2 +
>  include/linux/memcontrol.h |  156 +-
>  init/Kconfig               |    9 +
>  mm/Makefile                |    2 +
>  mm/memcontrol-v1.c         | 2933 +++++++++++++++++++++++++
>  mm/memcontrol-v1.h         |  132 ++
>  mm/memcontrol.c            | 4141 ++++++------------------------------
>  mm/vmscan.c                |   10 +-
>  8 files changed, 3780 insertions(+), 3605 deletions(-)
>  create mode 100644 mm/memcontrol-v1.c
>  create mode 100644 mm/memcontrol-v1.h
> 
> -- 
> 2.45.1
> 


Return-Path: <linux-kernel+bounces-199650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865C8D8A40
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 21:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222CF1F228DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB31E136E0F;
	Mon,  3 Jun 2024 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHlkQsLm"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DF0374EA
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443311; cv=none; b=nsyRQiL2GoUBbmC8KAac6sKOfO7q4FNRlJPd46YHVlNugDMLPt3wkFIHIyuKy/BcWJM95uYnX3g24urmgYAm19CjGt7zVVQUJH6Fg6oAQbyOdS2HEGJ+J82hc10W6NhMBNsLIL5VTFVxvD36RZQPlkAHKAcuH2CvpvgQTtnUdIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443311; c=relaxed/simple;
	bh=LPxgm0gPfNdNU2OnpKP4McOqYHqJs7wl2fDDPy3w4GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdgxmdAOF68Z4t+j7hb5PWcHnnNPlGOwYHzx66K0IWUD6fkpNowrmqs3AqhuQ2SV2WnWTN9JP2c3JE6EJs6jagLROQSBB63Ikm4YQ4g642F9KukUONaPbz0XU4ssDVxVnKaUgdJkVnfYj3lAHoKu1+EiHNZujndKRa84bX9lIig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHlkQsLm; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717443303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n087SDLE+scLkBaUJiPJ9dff+JW8lP4Fl+fT+WAXUT4=;
	b=XHlkQsLmzn2vQoMxW3Es/YI+hJafRD2Z/ebJQjXnfZKkj4Z10G64eOKZ2yJ2K+vQ/5P5Nh
	/RFjdelznh6OWyTMdmT2hks5xJv2ZCpy3LBoVpVr7gIKrUGNXXy6esXdTkOC37jfIZLTqo
	m9DbT1iLmdqPKTrWz3uZI58SKXeymWo=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 3 Jun 2024 12:34:57 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/14] mm: memcg: separate legacy cgroup v1 code and
 put under config option
Message-ID: <Zl4a4fK97vaiDxfH@P9FQF9L96D>
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

Johannes, Michal,

friendly ping. Do you have any concerns regarding this patchset?

There is a number of things which can/need to be improved/polished on top,
but I'd really like to land this one first, because rebasing of
such a massive patchset is time-consuming and might also introduce
some silly bugs.

Thanks

On Tue, May 28, 2024 at 01:20:52PM -0700, Roman Gushchin wrote:
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


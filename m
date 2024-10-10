Return-Path: <linux-kernel+bounces-358059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D15FF9979C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 02:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785E81F20F93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 00:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49408F9D6;
	Thu, 10 Oct 2024 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qb1zhgrY"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBD8524C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728521207; cv=none; b=aMEz/i1El+HAr/loig39t5Wry/79OcJjzrd+Bwk6vWyX4l0no4xaVHgU+QxymqRNBMUCZXTgcI/3YQvNOG2zdgy4RwOj1Fp1y/xH/yWHwZripdRxY4LYX95OMHHLfo89EnuIoERj4UsZsjyn6kEg9NI586QN/yiNTl0CXgD5RcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728521207; c=relaxed/simple;
	bh=fkizFp7l77AMJuYhqiNCGk4oI631TIneABJ5gaAxN/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVfgRw0pQlmcWq36XIKc1vuvYHQpsha46ACRgBIqreiUwiHOl4b/sbo3EdhV4aEzQxSK4veRrRnIyhXGEm+gYOeg/Z666Lz6P4/XGgRwmM9JBXlAQDDaG+YBEzP1R0POdAiyW6wF8KOcY1huWBELEWp4cZIoR+ZfWG0cXi1nXwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qb1zhgrY; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 10 Oct 2024 00:46:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728521202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xK1WQarFxXrWVmh59gBm5+U+RpMp85d18rs4ONytfFg=;
	b=Qb1zhgrYZssStY2Ir2MnJURZFiE+oBArbjOxqBkWAk44qsWUMlboZOQdnCdzfTeUKYvK/M
	6hR5sfTyw85ZITVSgxbFRlbj6oCpge0eBQ6b/g02AtV0bMyWzDEYRUuMt2qQVd+w7+gwtC
	nLilTtgiuE6nPe3E1qd+SNAzL+lG21s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
Message-ID: <Zwcj5SC_MYrPpNQq@google.com>
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010003550.3695245-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 09, 2024 at 05:35:50PM -0700, Shakeel Butt wrote:
> The memcg stats are maintained in rstat infrastructure which provides
> very fast updates side and reasonable read side. However memcg added
> plethora of stats and made the read side, which is cgroup rstat flush,
> very slow. To solve that, threshold was added in the memcg stats read
> side i.e. no need to flush the stats if updates are within the
> threshold.
> 
> This threshold based improvement worked for sometime but more stats were
> added to memcg and also the read codepath was getting triggered in the
> performance sensitive paths which made threshold based ratelimiting
> ineffective. We need more visibility into the hot and cold stats i.e.
> stats with a lot of updates. Let's add trace to get that visibility.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!


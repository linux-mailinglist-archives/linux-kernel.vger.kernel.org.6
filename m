Return-Path: <linux-kernel+bounces-419268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277ED9D6B8F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9848BB21A97
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 21:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACC51A7ADD;
	Sat, 23 Nov 2024 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dxkobz0M"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C2C148FED
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732396554; cv=none; b=P52/dYalJprl3ifT/tE1yBLzirv2dEoKs6tH+pXRwYspgzp7nmK93OCMOza8Pjim8xIzavJ12V6mYcklTMltB4sNG20fz0B8O6kPr3QJoZSeNbJtiY8+RWF6VSTh5luLNNfomcZi4ZuXRegckTKMO2ojSeXs7f1rLzSlAq2+LR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732396554; c=relaxed/simple;
	bh=hZ+lIMlNIlbFR25T7VMc8NmKASzcirseMhYDuyhhqXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TtAzux5NwAigNsBY1twJURHIfcccCbbDPdJRkt43K+MaC5TQSkcVsiTQEKzaXAb3bt2e2iSZEbm1rzPpt+h1vkpVk2o9kh8UBVFy3RUbAhJTtF5y8QdU/N7aC3aPc636NTJ8Fn0hhcHSk5+Kw4W5UnQFML+CZZEaj632itRo1jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dxkobz0M; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 13:15:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732396549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MXmSBrZpWl/Xy/VpB0EsgeUw0zP4+U6MJ+lql+/W8ws=;
	b=dxkobz0MvFMtfcUDntw4+WeL4boWWsnW0X5Mi1WFim5eEIZp6baQ8ldbTujGnmE0LeByQz
	7yoZWeQS71FeX5Fa0LGuW7iKce9m+tfdq/vR9GwjUAdLLxReVuTmQ3JJWvd5rZD1NkZ+Bn
	ySWDBcsR8uL1hGeWD8Z9FfyFNpkgiOY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo <tj@kernel.org>, Michal Koutny <mkoutny@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Axel Rasmussen <axelrasmussen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <a2aa5dbl2lwi3q3qzyds3lllgbcgruxjzwzwhnolg63i4swcus@lwtetk5wra44>
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
 <99c6af52-942f-4262-a79d-53a9c2e8eefe@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c6af52-942f-4262-a79d-53a9c2e8eefe@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 23, 2024 at 09:38:09AM +0100, Vlastimil Babka wrote:
> On 11/23/24 7:09 AM, Shakeel Butt wrote:
> > We are starting to deploy mmap_lock tracepoint monitoring across our
> > fleet and the early results showed that these tracepoints are consuming
> > significant amount of CPUs in kernfs_path_from_node when enabled.
> > 
> > It seems like the kernel is trying to resolved the cgroup path in the
> > fast path of the locking code path when the tracepoints are enabled. In
> > addition for some application their metrics are regressing when
> > monitoring is enabled.
> > 
> > The cgroup path resolution can be slow and should not be done in the
> > fast path. Most userspace tools, like bpftrace, provides functionality
> > to get the cgroup path from cgroup id, so let's just trace the cgroup
> > id and the users can use better tools to get the path in the slow path.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> AFAIU this would also remove the lockdep issue that patch [1] is solving
> with RCU conversion. It probably has other benefits on its own too, so
> just FYI. It's definitely better to avoid complex operations to gather
> tracepoint data, if avoidable.
> 
> [1] https://lore.kernel.org/all/20241121175250.EJbI7VMb@linutronix.de/
> 

Thanks for the pointer, I might add a reference to this in the commit
message in next version.


Return-Path: <linux-kernel+bounces-450008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E409F5952
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 23:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A0DC189484C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385861F9EC0;
	Tue, 17 Dec 2024 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg3YNd/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F121D5CCC
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472665; cv=none; b=EYZxDtl1z/0Z6SBigaCycVt/0h9JSh5cWj60ja+HpShmQa3BCksf53R1ojeB0UzbY5B/Rt92PBSsKB1KxYB0i3yNuSbAaUWaWwiB3g4T2MBsx4NGgyQTEGGLEUbIgAy3FbfOh+e3O3AoTdb3McBYjQCfnmhiC5rIl6xMCubsfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472665; c=relaxed/simple;
	bh=o3XMMgs1n/FWTh4DzzVz/nj9pHNHbY7z/+E/J2CGnP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyCKJOje4Mm8jhuIxa9vkZOLMnQYjCoh9SIepqORBphEFhHZnjNBhoS59DoIHXydaKPDlU+Nr4FUILBWpUXLvn2zdrdZWq/kIgQheLy/oSr0707Pt+gjJa/2JPiTe6LioGZ/AaGsTgAScvNyO9hqtbjzb38X9Zyd6RtBv8UD94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg3YNd/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF4FC4CED3;
	Tue, 17 Dec 2024 21:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734472665;
	bh=o3XMMgs1n/FWTh4DzzVz/nj9pHNHbY7z/+E/J2CGnP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg3YNd/8eWIw14c6hfg4AcrLnrH0GatQL6zqU7+1D6s+xP0T9s4HdXfh7ZBpLxBID
	 BugqKqXzmOmaOZmLIU9qu3nzp4qGEVINjDYGD7Xyp2nGk0O5EYtv2aQIbGQys8gn1X
	 8Iw261bLgf/uvyci3jen/luHFQJb0kCEmbIwKh06iaMyyGkeOgMSkoBb5ZPhGGxwO7
	 /a0qLnO18X1PU4MlX7NStfsNUqeZwIE+iDPsltN/w7mRWLzwr3bEHkpcsEW5ujDs/7
	 bWU1odZ/XrcmQTjlm4Q+u3Gnchqa5+ChB10vpEsKgWvSQc2QvhrE5n+WnX+Crxx20U
	 lDsokPhQg3mIQ==
Date: Tue, 17 Dec 2024 11:57:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/topology: introduce for_each_numa_hop_node() /
 sched_numa_hop_node()
Message-ID: <Z2Hz2NW-J06BuuHj@slm.duckdns.org>
References: <20241217094156.577262-1-arighi@nvidia.com>
 <20241217094156.577262-2-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217094156.577262-2-arighi@nvidia.com>

Hello,

On Tue, Dec 17, 2024 at 10:32:26AM +0100, Andrea Righi wrote:
...
> +int sched_numa_hop_node(nodemask_t *hop_nodes, int start, unsigned int state)
> +{
> +	int dist, n, min_node, min_dist;
> +
> +	if (state >= NR_NODE_STATES)
> +		return NUMA_NO_NODE;
> +
> +	min_node = NUMA_NO_NODE;
> +	min_dist = INT_MAX;
> +
> +	for_each_node_state(n, state) {
> +		if (n == start || node_isset(n, *hop_nodes))
> +			continue;
> +		dist = node_distance(start, n);
> +		if (dist < min_dist) {
> +			min_dist = dist;
> +			min_node = n;
> +		}
> +	}
> +	if (min_node != NUMA_NO_NODE)
> +		node_set(min_node, *hop_nodes);
> +
> +	return min_node;
> +}

So, this would work but given that there is nothing dynamic about this
ordering, would it make more sense to build the ordering and store it
per-node? Then, the iteration just becomes walking that array.

Thanks.

-- 
tejun


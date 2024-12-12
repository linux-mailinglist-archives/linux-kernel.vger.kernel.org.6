Return-Path: <linux-kernel+bounces-443714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 838CD9EFAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F08169AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A11E223338;
	Thu, 12 Dec 2024 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IKYd0eID"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C6A2210C2
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028340; cv=none; b=jf0kHG01L4gaX0JMNFDncXbqvANvCB1I7idmlPe/tS5oDJ/jP+k+0NBfTaEAIpIeMxOeKBeVkEa/I7MwtBjUeCPmM2G1EEBylBPLb1YMuIapQbxJTYiNEk7P9+gaUyRJfJ/HQaGe6iMm5RVKbuSBGiwVxQ80wCDxAqQB0v7Xlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028340; c=relaxed/simple;
	bh=/2P4JQ4o9LfjnGL6PW60gglUYd3I1qYkGnXHZm/hGbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbWEtHzqrL129JTig4VQ5Ppq1BUgQb9tfSAZtH0OPTTajGCjfHjdC3yZ4aNL+466A1HHfTQu+wDUIAydK90u5CYqkXlpXGGtAhbDWpIvamcqs4cBvVBLoA3cx4SquDXktGdq7+MEjJItjQKSEWLxlkTGSGhPL/V++Q0fJjl2OWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IKYd0eID; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 12 Dec 2024 18:31:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734028324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/2P4JQ4o9LfjnGL6PW60gglUYd3I1qYkGnXHZm/hGbw=;
	b=IKYd0eIDaH9mMFkZYywkjVap8ervWeRg7YFbQ7HotZzDWTpz5sA24oDoET4Ep68gz6K3wS
	NGZ7f8kcED+ALMtEPtd4VLrgxFHyNDXpSuk78sjxNRXWXEA90cwpFIvwusWhQYppTZ+1GC
	KjmWJumG/UmkO2oXEh0VQtcCgclVC04=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Rik van Riel <riel@surriel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Balbir Singh <balbirs@nvidia.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <Z1ssHQYI-Wyc1adP@google.com>
References: <20241212115754.38f798b3@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212115754.38f798b3@fangorn>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 12, 2024 at 11:57:54AM -0500, Rik van Riel wrote:
> A task already in exit can get stuck trying to allocate pages, if its
> cgroup is at the memory.max limit, the cgroup is using zswap, but
> zswap writeback is enabled, and the remaining memory in the cgroup is
> not compressible.

Is it about a single task or groups of tasks or the entire cgroup?
If former, why it's a problem? A tight memcg limit can slow things down
in general and I don't see why we should treat the exit() path differently.

If it's about the entire cgroup and we have essentially a deadlock,
I feel like we need to look into the oom reaper side.

Alternatively we can allow to go over the limit in this case, but only
assuming all tasks in the cgroup are going to die and no new task can
enter it.

Thanks!


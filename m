Return-Path: <linux-kernel+bounces-263553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1DB93D79D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5228B22A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E46D17CA10;
	Fri, 26 Jul 2024 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WRyB7Hou"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DF3282EA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015043; cv=none; b=JI6fjoa7mDppX2hGoMPs+niBSTLnkgo3lW2RIiJZ84zsD9KxNGsYwg4WcuQ2OWt2m/IoBeJG2MnBg9BcEATzFQJfnsvB9ygIkEWAW+2/JCUoWx4VvMPkb9w2EZjsrlNzC4CgIZoAyStzVYxkSW3cNAmJnB7ZACAij3uuq5vDmlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015043; c=relaxed/simple;
	bh=GaWwutOzEnf50wVkkqR5vEV+4ugPo5rP0Y2AZh8DbA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8KVemzCY/PsL23woce9Rk3ndiALLE5el+iJduaFFCoTU+Ark5PjOdSfxlLONlh9UpMy/JfVRuR+1oWkfBKln/nFUJYQSu/1pkOEhZFihk9md7DzpoohxD0cUwhSYJXAPzny5bWhAvtQ7Eky7CHUC8gMTRtOnhHiJep7Y9YKHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WRyB7Hou; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jul 2024 10:30:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722015039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q/whrTc8Vg6KsFi8iJ+kBMuu41SrRr3us36dwb/hbYY=;
	b=WRyB7HouuQRI7axifysvz57Xzls6I5KgVhHHPuNkgSRrvhuloHKdI4jWGjbcHSTSbn7EsT
	Ov2XLxeQcuJO+xIUWCJlO796mu/n2hh9CGqS28EOarTrM3OLjEFMVrSHbTMpIygfTdOyGY
	syvW8IMO+O/Ofdl6ccInR0v+duB/As4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Greg Thelen <gthelen@google.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
Message-ID: <z2chqotbjp27rtq4c5mrmz3llsn3o523goq4ycy5jt7s4atcdp@xyb34euw2s45>
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
 <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
 <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 26, 2024 at 09:25:27AM GMT, Yosry Ahmed wrote:
> On Fri, Jul 26, 2024 at 8:48 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
[...]
> >
> > No, the workloads running in non-root memcgs will not see any
> > difference. Only the workloads running in root will see charging
> > overhead.
> 
> Oh yeah we already charge the root's page counters hierarchically in
> the upstream kernel, we just do not charge them if the origin of the
> charge is the root itself.
> 
> We also have workloads that iterate top-level memcgs to calculate the
> total charged memory, so memory.children_usage for the root memcg
> would help.
> 
> As for memory.current, do you have any data about how much memory is
> charged to the root itself? We think of the memory charged to the root
> as system overhead, while the memory charged to top-level memcgs
> isn't.
> 
> So basically total_memory - root::memory.children_usage would be a
> fast way to get a rough estimation of system overhead. The same would
> not apply for total_memory - root::memory.current if I understand
> correctly.

Please note that root::memory.children_usage will have top level zombies
included as well (at least until lru reparenting is not done). So, for
your example it would provide good estimation of top level zombie memory
through root::memory.children_usage - top_level(alive)::memory.current.


Return-Path: <linux-kernel+bounces-263597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A48893D817
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEF91C22EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5A833997;
	Fri, 26 Jul 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A+yA6E3F"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065D04430
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017822; cv=none; b=qClVDXR4FwOaef06vThDz+TjmJB4BqU2XAdqMQ1CdHi1jKG9YhAwBQ+FTwztZV4eihM16JEjkgaDFSlAEbqPTq0ts7gb/GMSQbPM1cY082MRm5DWKU7tNv/d8uEbfHPDhQ66fyNHw3q5ORnGVWBXLtSrBfPWUJCN97a1VwoGx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017822; c=relaxed/simple;
	bh=jfcq9dMtKAd1p6EqpkxhcKHETx/vTMZ1v5D4g+Fx9z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2VVkhGI38V77fTsR2b05GTHsyEm9YQqA9uNPUAwa418IYdAbT0mMGd2u8IDWGw2i9kLf21qGtDd+b/8xkiuh9olmKUroHKf8cC7RfOqG/xGX/T+MD7/NcP5zxuEqv+6mHmN0Hk29mgTtM2u0fDKo3o9Gwf9n1HHcwUOOGHSFa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A+yA6E3F; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 26 Jul 2024 11:16:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722017816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Swun6CogEp3EWEPStG+jjImIZ9tcFlvinrHHXIyi+ps=;
	b=A+yA6E3FeWWMRIxWCPIEgHvwDvnszVvf1jIzTbK9EdowIuJTq5pFgOvy2JRyFyaOF+ONiQ
	ycykG5HKkldwdAgPZDgwORMXq0BxxLo7Ss4Ns8SQQ/4nI2Saaf0UdtRh3AGdZHOWlTy/N7
	nlAD17Er47tOjTk6w6pG8SvJJPxt8JQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Greg Thelen <gthelen@google.com>, Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] memcg: expose children memory usage for root
Message-ID: <qivq2vwax5t5gzpu2r7ktfgmxgyroxycgc7klgfascd3cdlkaj@wnoq4u2mq57l>
References: <20240722225306.1494878-1-shakeel.butt@linux.dev>
 <CAJD7tkaR3s6fzRZWdvMvfSRBRaozSj7d2pH5HUjtbuOW+RROFA@mail.gmail.com>
 <lhlfj2keag2ciurt7v76d4nhyk5k5czrkvuocbgxkeep6zgwgo@ifjthvn5osvr>
 <CAJD7tkaW8bkwpUChJPc-Bw1epfrLySVhgr8528yZg5eCg3d=JA@mail.gmail.com>
 <z2chqotbjp27rtq4c5mrmz3llsn3o523goq4ycy5jt7s4atcdp@xyb34euw2s45>
 <CAJD7tkYCERG5pUTcdmw8UGks8wtK9W9jzZGZODE6sZ-9-WEv-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYCERG5pUTcdmw8UGks8wtK9W9jzZGZODE6sZ-9-WEv-g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jul 26, 2024 at 10:43:31AM GMT, Yosry Ahmed wrote:
> On Fri, Jul 26, 2024 at 10:30 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Fri, Jul 26, 2024 at 09:25:27AM GMT, Yosry Ahmed wrote:
> > > On Fri, Jul 26, 2024 at 8:48 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > >
> > [...]
> > > >
> > > > No, the workloads running in non-root memcgs will not see any
> > > > difference. Only the workloads running in root will see charging
> > > > overhead.
> > >
> > > Oh yeah we already charge the root's page counters hierarchically in
> > > the upstream kernel, we just do not charge them if the origin of the
> > > charge is the root itself.
> > >
> > > We also have workloads that iterate top-level memcgs to calculate the
> > > total charged memory, so memory.children_usage for the root memcg
> > > would help.
> > >
> > > As for memory.current, do you have any data about how much memory is
> > > charged to the root itself? We think of the memory charged to the root
> > > as system overhead, while the memory charged to top-level memcgs
> > > isn't.
> > >
> > > So basically total_memory - root::memory.children_usage would be a
> > > fast way to get a rough estimation of system overhead. The same would
> > > not apply for total_memory - root::memory.current if I understand
> > > correctly.
> >
> > Please note that root::memory.children_usage will have top level zombies
> > included as well (at least until lru reparenting is not done). So, for
> > your example it would provide good estimation of top level zombie memory
> > through root::memory.children_usage - top_level(alive)::memory.current.
> 
> Good point. The fact that it includes the top-level zombies makes it
> less valuable for this use case, as zombie memory is considered system
> overhead as well. So we need to iterate the top level memcgs anyway.

Most of the users use systemd which has fixed top level hierarchy, so
this is fine for most users. 


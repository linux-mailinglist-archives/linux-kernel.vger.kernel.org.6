Return-Path: <linux-kernel+bounces-287221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F05FB9524F1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1E01F22EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F031C8FB1;
	Wed, 14 Aug 2024 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ejs7FKlZ"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C277346D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672150; cv=none; b=lcCU9nKPBx5nevAlsSGtIw1lk3BoeSLNM/piVhZueyfLKwBwTCLKi1Yv2/HSmLR0DP/lQaNU+RlhWQSN6bDIiTvhbD29SoM19Acv9ElWXuX8UwXH3Ewsy4vbqFxEfa5EO42F0juMkq3H1QLqbYA3BRbT56cqEt8qUkECITDv5CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672150; c=relaxed/simple;
	bh=8xhDo+ZnjUSH1S+3H0xzJx5i48z1o9oM4o9isEVAHxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCNRUy8SABnA6T6J/fND20MM/o/Ft1URg3uDByalNZFIImO3IciHRbs6UU54AF93Y1TxPW4Cq894QuS6NcfQj8Pf6vPU6IK11CVI0U4QB//SrILs0KkdN+n6wfo6FoWKCCxjqg0t4Lq+b9r26UB9cbTk+DA4tzHpo+pMs0YR/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ejs7FKlZ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Aug 2024 14:49:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723672145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bfz+tInBoeolRrtoXPsGQjhjRpHjQBGUo7rwsFTiXqA=;
	b=Ejs7FKlZYp7kRaj+qN/pnYUF/TAjVFChDAVad+mNprhdz2Pggck7VBt9OHgY5rtnXKnjjC
	3vKsBOnuCpk+4+L5w1XsgzoNRlNVyVm375DYtjYikgklqtRzFF5siRFDpPNJbO82vdhQr0
	egozFJpZIipBQ83KIxayOg+B+Dpvs1k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH 3/4] memcg: initiate deprecation of oom_control
Message-ID: <vhmogrjr4zehf2duzhd5treij77j6npyisch5f2vyshjztgn57@db5suilpihly>
References: <20240814202825.2694077-1-shakeel.butt@linux.dev>
 <20240814202825.2694077-4-shakeel.butt@linux.dev>
 <CABdmKX2HvW3qZ9zrTq0Gz6q0Gg7_XubVY22o3GJoTOhQg=V+8Q@mail.gmail.com>
 <vixhnru2gag4wav5m2qesoihlhuce75s662ccxcekdp3ba44kj@ml7tlkaefqsx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vixhnru2gag4wav5m2qesoihlhuce75s662ccxcekdp3ba44kj@ml7tlkaefqsx>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 14, 2024 at 02:41:13PM GMT, Shakeel Butt wrote:
> On Wed, Aug 14, 2024 at 02:00:03PM GMT, T.J. Mercier wrote:
> > On Wed, Aug 14, 2024 at 1:29 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > The oom_control provides functionality to disable memcg oom-killer,
> > > notifications on oom-kill and reading the stats regarding oom-kills.
> > > This interface was mainly introduced to provide functionality for
> > > userspace oom-killers. However it is not robust enough and only supports
> > > OOM handling in the page fault path.
> > >
> > > For v2, the users can use the combination of memory.events notifications
> > > and memory.high interface to provide userspace OOM-killing functionality.
> > > Let's start the deprecation process for v1 and gather the info on how
> > > the current users are using this interface and work on providing a more
> > > robust functionality in v2.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > ---
> > >  Documentation/admin-guide/cgroup-v1/memory.rst | 8 ++++++--
> > >  mm/memcontrol-v1.c                             | 7 +++++++
> > >  2 files changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
> > > index afe5e95e9f7b..74cea6712d06 100644
> > > --- a/Documentation/admin-guide/cgroup-v1/memory.rst
> > > +++ b/Documentation/admin-guide/cgroup-v1/memory.rst
> > > @@ -92,6 +92,8 @@ Brief summary of control files.
> > >                                       This knob is deprecated and shouldn't be
> > >                                       used.
> > >   memory.oom_control                 set/show oom controls.
> > > +                                     This knob is deprecated and shouldn't be
> > > +                                     used.
> > >   memory.numa_stat                   show the number of memory usage per numa
> > >                                      node
> > >   memory.kmem.limit_in_bytes          Deprecated knob to set and read the kernel
> > > @@ -846,8 +848,10 @@ It's applicable for root and non-root cgroup.
> > >
> > >  .. _cgroup-v1-memory-oom-control:
> > >
> > > -10. OOM Control
> > > -===============
> > > +10. OOM Control (DEPRECATED)
> > > +============================
> > > +
> > > +THIS IS DEPRECATED!
> > >
> > >  memory.oom_control file is for OOM notification and other controls.
> > >
> > > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > > index e0bb54e42011..07343e338e4e 100644
> > > --- a/mm/memcontrol-v1.c
> > > +++ b/mm/memcontrol-v1.c
> > > @@ -1907,6 +1907,9 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> > >                 event->register_event = mem_cgroup_usage_register_event;
> > >                 event->unregister_event = mem_cgroup_usage_unregister_event;
> > >         } else if (!strcmp(name, "memory.oom_control")) {
> > > +               pr_warn_once("oom_control is deprecated and will be removed. "
> > > +                            "Please report your usecase to linux-mm-@kvack.org"
> > > +                            " if you depend on this functionality. \n";
> > 
> > Missing close paren?
> 
> Ah, thanks for catching that. I compile tested the old version before
> moving text around. Anyways, will resend.
> 

Oh I was building without CONFIG_MEMCG_V1.


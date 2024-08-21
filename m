Return-Path: <linux-kernel+bounces-295724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6973A95A0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B4FB22D80
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0EAC45038;
	Wed, 21 Aug 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgrNikH+"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D4B2B9B3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252435; cv=none; b=Y94u/xPGeFrQFY7IDqFMlrORJOYZ2QU4s8rBKrw7NM+S8dvQinWJlLkYk1TUq0i9E+1AgtA9pLwbDTDUmnU5dAuOEB6UQ4CfGlOPRYmVo1vIK4QnBAV328om9OkJJ8Vbp/dcc6yt8ZjPyAeoScXxMjdvsa6bUT/NqAgm3HaI8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252435; c=relaxed/simple;
	bh=2wvu1qvqnw4MQhcDyl/5Lh/Cq0lA25yuKmeh1p0cDrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ94fqMpOWiVUWxlO0pSvlVEdwln1KwlyuKgzzHQoCG6HkshbebjeuwGJ82IGnvOTtYQj7thyuNTJACyRNceY9UdeJzGlcVXCryF5Jt2CI2PX/ZCpXpxFZQZJeAp4VVU2Igi5I6Sb6zfnQzvwMc9MCUQ03aAenFAgh6+N0ZsgVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgrNikH+; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a864574429aso256629866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724252431; x=1724857231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xcRUKZYdyBX916nHF6t0DptHBUYpaDVMRVKVcN+50Rc=;
        b=CgrNikH+sm1PDOEOCN/d0u7vy8YRYnYGPrX5ehDHineRPvC+4nLxoaaxMlvx6A8mE+
         pkorOVJ86oqJeufOCct4yrfrlxR2cx8RCDFeu1r0ajtDYYZtrFaCFIB7rUTAQSC87qo2
         T4L5sN+USy4+1Ce7ZpJLoy316l+NGIWLz5vTEOnnhHTVmf+9phHboBVyH1s2DLOyc3ei
         DeC5eLHW/ywpsLqSkND3u0tWuSwf53Vr5B6Xl6cKxwVlmwkEoFcNyhQy69EFuaUAUiQh
         wnG05Wm+36O6HBqc3qozTzULE2YeraAvD8iCttyWT7GZQSnbhK0VuH8ozt3hOw/4xGtK
         X6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724252431; x=1724857231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xcRUKZYdyBX916nHF6t0DptHBUYpaDVMRVKVcN+50Rc=;
        b=jaxI7fmQOmjr8M77RPULipO7j8VdWplzixLozPxcp6sUh2CHfpcF794jINpe8tEIz/
         H9ODxMyhKRtgyDKV4t5IisvwReNTu5uELoPAuwVmt+IVQVeHbx6nWQlRrFxp1HyIPVGs
         2D0R1ugAP5hOIZAs/kMK4WflAsgdgBT+Yp8/t+ddGPwX8JxsvSxzTApFExT2UK89654u
         i2fu4Q1ZO05eVH69WwVMws/ACQMmRitO7Bar3z8bvuUdcJcKIO7G11U2WmWr0l7tu3lp
         /HK4tzFVWKyGT83jPd8/r9BxaofytJT1yPWnP2hxMgfFDOibKlLRZQKKsscEapQ+A4qQ
         QNww==
X-Forwarded-Encrypted: i=1; AJvYcCX9XraZX0vTGOg3BTROEOI7vSFCnwi5wmioDLj4IUo9/Q+fX6gSBiLhY8h8ZNM+YbdEmW8j72UH+vcM9YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFgzNCB1UEZYgeaEL5oyUQ3uWwYofhU2mvKStn+IR2SLfHOHm3
	qysHFW1fED22wqZRCXWOJH44GNfYLIXQENSIVv8JDLCqN9uh61TjCpCuepiu9BE=
X-Google-Smtp-Source: AGHT+IETZL55oHXa2GmSfrxU68Y2JXpAaweNsD7J6sIoff16mz8wyMfOeSSbaZQl3H/+dKh9IQbnHg==
X-Received: by 2002:a17:907:948e:b0:a7d:3cf6:48d1 with SMTP id a640c23a62f3a-a866f36f8b4mr144681566b.32.1724252430479;
        Wed, 21 Aug 2024 08:00:30 -0700 (PDT)
Received: from localhost (109-81-81-250.rct.o2.cz. [109.81.81.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8678084255sm99494766b.92.2024.08.21.08.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 08:00:30 -0700 (PDT)
Date: Wed, 21 Aug 2024 17:00:28 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [PATCH] mm:page_alloc: fix the NULL ac->nodemask in
 __alloc_pages_slowpath()
Message-ID: <ZsYBDGE-_8GPPEpE@tiehlicka>
References: <20240821135900.2199983-1-hezhongkun.hzk@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821135900.2199983-1-hezhongkun.hzk@bytedance.com>

On Wed 21-08-24 21:59:00, Zhongkun He wrote:
> I found a problem in my test machine that should_reclaim_retry() do
> not get the right node if i set the cpuset.mems
> 
> 1.Test step and the machines.
> ------------
> root@vm:/sys/fs/cgroup/test# numactl -H | grep size
> node 0 size: 9477 MB
> node 1 size: 10079 MB
> node 2 size: 10079 MB
> node 3 size: 10078 MB
> 
> root@vm:/sys/fs/cgroup/test# cat cpuset.mems
>     2
> 
> root@vm:/sys/fs/cgroup/test# stress --vm 1 --vm-bytes 12g  --vm-keep
> stress: info: [33430] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd
> stress: FAIL: [33430] (425) <-- worker 33431 got signal 9
> stress: WARN: [33430] (427) now reaping child worker processes
> stress: FAIL: [33430] (461) failed run completed in 2s

OK, so the test gets killed as expected.

> 2. reclaim_retry_zone info:
> 
> We can only alloc pages from node=2, but the reclaim_retry_zone is
> node=0 and return true.
> 
> root@vm:/sys/kernel/debug/tracing# cat trace
> stress-33431   [001] ..... 13223.617311: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=1 wmark_check=1
> stress-33431   [001] ..... 13223.617682: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=2 wmark_check=1
> stress-33431   [001] ..... 13223.618103: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=3 wmark_check=1
> stress-33431   [001] ..... 13223.618454: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=4 wmark_check=1
> stress-33431   [001] ..... 13223.618770: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=5 wmark_check=1
> stress-33431   [001] ..... 13223.619150: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=6 wmark_check=1
> stress-33431   [001] ..... 13223.619510: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=7 wmark_check=1
> stress-33431   [001] ..... 13223.619850: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=8 wmark_check=1
> stress-33431   [001] ..... 13223.620171: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=9 wmark_check=1
> stress-33431   [001] ..... 13223.620533: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=10 wmark_check=1
> stress-33431   [001] ..... 13223.620894: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=11 wmark_check=1
> stress-33431   [001] ..... 13223.621224: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=12 wmark_check=1
> stress-33431   [001] ..... 13223.621551: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=13 wmark_check=1
> stress-33431   [001] ..... 13223.621847: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=14 wmark_check=1
> stress-33431   [001] ..... 13223.622200: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=15 wmark_check=1
> stress-33431   [001] ..... 13223.622580: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=16 wmark_check=1

Are you suggesting that the problem is that should_reclaim_retry is
iterating nodes which are not allowed by cpusets and that makes the
retry loop happening more than unnecessary?

Is there any reason why you haven't done the same that the page
allocator does in this case?
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 28f80daf5c04..cbf09c0e3b8a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4098,6 +4098,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		unsigned long min_wmark = min_wmark_pages(zone);
 		bool wmark;
 
+		if (cpusets_enabled() &&
+			(alloc_flags & ALLOC_CPUSET) &&
+			!__cpuset_zone_allowed(zone, gfp_mask))
+				continue;
+
 		available = reclaimable = zone_reclaimable_pages(zone);
 		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
 
-- 
Michal Hocko
SUSE Labs


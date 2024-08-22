Return-Path: <linux-kernel+bounces-296663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1580D95AD69
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD1E1F2288D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6B137930;
	Thu, 22 Aug 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PUJhaAZq"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB383B192
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307894; cv=none; b=N3NdCwWBykpGQD6+3ydvfkx5wIHtKcYbW/pH8QehQmzgiDDpYGH/vNmyFQ8pCpd6nVctOLal3IR8lGSDy+icmef5/i9jBWFNLM8ApaBFpXucsAMwiFFLJolChhXqX7xXf+3r550cI3AMLG5cy187ofZXbkRMytum318nSQPkz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307894; c=relaxed/simple;
	bh=1BSWe6ii3+DwJ4JPNZ3t55eNn7gdVfk9vRLHCXwDpcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUicxxPb2I6JjXCXd7lrW5a6FXWmzDCg49bMbcz+PcYw65T3Rp6sZt7FCmzsCJ7nUqNgdYaIk/VJO7joWNKmXI0fFiOIy5SAQ12TFs5v2HQkVQCiLo4OjCXp+/PBheusAoWTD+8UPNZzLtyfUZ4XA6TRGFOdu9uEXMCfgMApP+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PUJhaAZq; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bef295a45bso513918a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724307891; x=1724912691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSj0hW6JDdfU92jXObH8IcQ1h41k65h/FvcN5Kx0k/c=;
        b=PUJhaAZqhShe+njhEfeBmTfhuGtyKZOFO82JCopgsqZYeOIGhp4P3Ja8idip9j36lX
         CQ/zC1x+tsb+dvxaSu46bzUuKl48LL5pm7kvp5W2t/45Q+wbEsOZx2im0APxXAlYLRZL
         XPw2KAn3y5sMCFv7Gh0pBay5U4XyfhglQ/87UFcO5KS4AR5NR0N4xeQNB5PqYX5Qz4Lx
         jOkZ/ZbNfPPBJZs53GQM4uvej1DTIbSaEbG1PiCZM839CTJVZ6teQvxHMcngf06tUSv9
         NSHaE2NbkeVzb/6flnGRD5gZVDbo+xQN1wB0872lujpBhmzMJnWOaHMftj7nu0qFfMG+
         rqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724307891; x=1724912691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSj0hW6JDdfU92jXObH8IcQ1h41k65h/FvcN5Kx0k/c=;
        b=SCcQGrvlGL0TbSAMIMZ2MKYOb4cj5+rbE4TCZJEkRwLbxWDhIotNbL2Pt5a/xLJraE
         1LpQaU81/udjakyojjOR2Oh/rXNHCN/71igldJn30rJZydqyhIn4xI5E7AjUYkAMJbPx
         IVdVghcgWMhhBrWZvlXaqw5zCMmmfupEHKFhd9/tlwJnCrP1UggeZAh+ZY+zUmJ11o3z
         kI+83qRDYMA6R863Vc/GUaVBwM9G1+MHz9TFtLNKYb0q1p/rPFxjmgVBJ0Qsg9qCkv5C
         0gW5RNEIk9ZD6pGpEzovN1EiO80XdFX0P70l4o2Bh3MlkWCbfG2R7XAWTyzgM5RwWydy
         RALQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5nPafT0H9yCYspvCbBYjBelWKK4C+B2phur62j5REsu0N25iTjmrFvrOyIU0xEumUjMyChy3P8EkJFe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbQM8F/A5wtxtRh8ZAn5XGzwfMkWdAsIRar5g2Lgs0wCV+ql+
	WSW4KrCo19yJuqKRzf1It37Qe5MVyl/J+/8F+uoHefxHsCPbo3x+wwUXSCPWKPo=
X-Google-Smtp-Source: AGHT+IHqd6rCfjoNRUOqVbNXPscNq7pN5OEsUCzKi8tCe/NqbwN/se9mjcjnct3VbqEUaVc1zCTyTg==
X-Received: by 2002:a05:6402:35c4:b0:5be:fe26:dac1 with SMTP id 4fb4d7f45d1cf-5c0791d07fbmr957946a12.3.1724307890681;
        Wed, 21 Aug 2024 23:24:50 -0700 (PDT)
Received: from localhost (109-81-92-13.rct.o2.cz. [109.81.92.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3eb329sm475609a12.55.2024.08.21.23.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:24:50 -0700 (PDT)
Date: Thu, 22 Aug 2024 08:24:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net,
	hannes@cmpxchg.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Subject: Re: [External] Re: [PATCH] mm:page_alloc: fix the NULL ac->nodemask
 in __alloc_pages_slowpath()
Message-ID: <ZsbZsf2Z93_d9PQR@tiehlicka>
References: <20240821135900.2199983-1-hezhongkun.hzk@bytedance.com>
 <ZsYBDGE-_8GPPEpE@tiehlicka>
 <CACSyD1OdKb4n1SrStdTfhwO0F1eBA5mNruxOeYKrhKP6+jTXAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACSyD1OdKb4n1SrStdTfhwO0F1eBA5mNruxOeYKrhKP6+jTXAg@mail.gmail.com>

On Thu 22-08-24 11:15:34, Zhongkun He wrote:
> On Wed, Aug 21, 2024 at 11:00 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 21-08-24 21:59:00, Zhongkun He wrote:
> > > I found a problem in my test machine that should_reclaim_retry() do
> > > not get the right node if i set the cpuset.mems
> > >
> > > 1.Test step and the machines.
> > > ------------
> > > root@vm:/sys/fs/cgroup/test# numactl -H | grep size
> > > node 0 size: 9477 MB
> > > node 1 size: 10079 MB
> > > node 2 size: 10079 MB
> > > node 3 size: 10078 MB
> > >
> > > root@vm:/sys/fs/cgroup/test# cat cpuset.mems
> > >     2
> > >
> > > root@vm:/sys/fs/cgroup/test# stress --vm 1 --vm-bytes 12g  --vm-keep
> > > stress: info: [33430] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd
> > > stress: FAIL: [33430] (425) <-- worker 33431 got signal 9
> > > stress: WARN: [33430] (427) now reaping child worker processes
> > > stress: FAIL: [33430] (461) failed run completed in 2s
> >
> > OK, so the test gets killed as expected.
> >
> > > 2. reclaim_retry_zone info:
> > >
> > > We can only alloc pages from node=2, but the reclaim_retry_zone is
> > > node=0 and return true.
> > >
> > > root@vm:/sys/kernel/debug/tracing# cat trace
> > > stress-33431   [001] ..... 13223.617311: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=1 wmark_check=1
> > > stress-33431   [001] ..... 13223.617682: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=2 wmark_check=1
> > > stress-33431   [001] ..... 13223.618103: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=3 wmark_check=1
> > > stress-33431   [001] ..... 13223.618454: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=4 wmark_check=1
> > > stress-33431   [001] ..... 13223.618770: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=5 wmark_check=1
> > > stress-33431   [001] ..... 13223.619150: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=6 wmark_check=1
> > > stress-33431   [001] ..... 13223.619510: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=7 wmark_check=1
> > > stress-33431   [001] ..... 13223.619850: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=8 wmark_check=1
> > > stress-33431   [001] ..... 13223.620171: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=9 wmark_check=1
> > > stress-33431   [001] ..... 13223.620533: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=10 wmark_check=1
> > > stress-33431   [001] ..... 13223.620894: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=11 wmark_check=1
> > > stress-33431   [001] ..... 13223.621224: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=12 wmark_check=1
> > > stress-33431   [001] ..... 13223.621551: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=13 wmark_check=1
> > > stress-33431   [001] ..... 13223.621847: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=14 wmark_check=1
> > > stress-33431   [001] ..... 13223.622200: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=15 wmark_check=1
> > > stress-33431   [001] ..... 13223.622580: reclaim_retry_zone: node=0 zone=Normal   order=0 reclaimable=4260 available=1772019 min_wmark=5962 no_progress_loops=16 wmark_check=1
> >
> > Are you suggesting that the problem is that should_reclaim_retry is
> > iterating nodes which are not allowed by cpusets and that makes the
> > retry loop happening more than unnecessary?
> 
> Yes, exactly.
> 
> >
> > Is there any reason why you haven't done the same that the page
> > allocator does in this case?
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 28f80daf5c04..cbf09c0e3b8a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4098,6 +4098,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
> >                 unsigned long min_wmark = min_wmark_pages(zone);
> >                 bool wmark;
> >
> > +               if (cpusets_enabled() &&
> > +                       (alloc_flags & ALLOC_CPUSET) &&
> > +                       !__cpuset_zone_allowed(zone, gfp_mask))
> > +                               continue;
> > +
> >                 available = reclaimable = zone_reclaimable_pages(zone);
> >                 available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
> >
> 
> That was my original version,  but I found that the problem exists in
> other places.
> Please see the function flow below.
> 
> __alloc_pages_slowpath:
> 
>   get_page_from_freelist
>      __cpuset_zone_allowed /* check the node */
> 
>   __alloc_pages_direct_reclaim
>      shrink_zones
>         cpuset_zone_allowed（）/* check the node */
> 
>  __alloc_pages_direct_compact
>    try_to_compact_pages
>        /* do not check the cpuset_zone_allowed（）*/
> 
>   should_reclaim_retry
>   /* do not check the cpuset_zone_allowed（）*/
> 
>   should_compact_retry
>       compaction_zonelist_suitable
>           /* do not check the cpuset_zone_allowed（）*/
> 
> Should we add __cpuset_zone_allowed() checks in the three functions
> listed above,
> or should we set the nodemask in __alloc_pages_slowpath()  if it is empty
> and the request comes from user space?

cpuset integration into the page allocator is rather complex (check
ALLOC_CPUSET) use. Reviewing your change is not an easy task to make
sure all the subtlety is preserved. Therefore I would suggest addressing
the specific issue you have found.

-- 
Michal Hocko
SUSE Labs


Return-Path: <linux-kernel+bounces-296964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C24895B135
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14054B23038
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D03171092;
	Thu, 22 Aug 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="kwGeenhJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84219470
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724317880; cv=none; b=pNcZStYfrcbi7mL4HFyXPJQUYIGK9orItLw1uVoMXLuH98bYwPwJgd6rI8YutDMZi85QYngfjhQ6H32jy6q2fHel5EN52Inw90GD3FEGZRVw49NLuB4C3xwuGk9ttxba44XZ/MaC8RhT17LVqdan0i3Bc37dJmqOkEZ2KAFQ0DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724317880; c=relaxed/simple;
	bh=r/FkDQ7C6iSkewbgYxJUG0zyYuEvpaa4y8rHsXi3wFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1575VVu95bvbrxSwZ9GpaMpJLQnL7DWd+xsFmvlR54VOJVR5XC2MLIxA413DxbzExSWO8nuuHuWwCuTelHZz76UkTWsqSSqyuruWqg9egAcFD7HZybEWVwFGnE27NcmWA+5AgqXo/kspbKvB243UKdgFgwsspuX78WIKh84yto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=kwGeenhJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso1038511fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724317876; x=1724922676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZLvaadLIt/5eGubYu3Bg1lQuk7g/soC7lWxPhD4egM=;
        b=kwGeenhJQnQOR6AUMygH+ul9SsSsyMVq4uX9NOQ1RjKHQlBvWORekVVibphOz7dgje
         Nz2vVHdH3soJjYGto2oY0KY31UTpjM3qRNK4mEyneTL4P3WaGy6B68jK4F9esNkfvsND
         4Cf4MoO+B1EU66bQ+jZdkAJf//hdtFX+j7czvBZZf7mCp6vzE3DWW8wPZXWBPp3V4cH7
         yMnV14SnwvchJDBr0aYKyzrO55caGTHuH995hpt0LpmRYUOisQ7BfkaSCWwWT4oZx6rJ
         U/W4B529WfyesVXsoAa9Aw9giZKn6uTIFceTnuHTI2YlvxY9581mfZXoHpSv3Und7GUb
         XhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724317876; x=1724922676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZLvaadLIt/5eGubYu3Bg1lQuk7g/soC7lWxPhD4egM=;
        b=WaD9IXo94mV7gFmW7nVmvUAETRhD3qn3RUY2Y83/ZtmJ0oibAenjinjHSguv16/kCK
         QDpiDLZhZlp6Wj1MVsn+8PpaY4D5EB6QdH6dcIOpRMOaIRbYb7JH7wb/Qy5ox6HvIP6R
         ZgIOv2J3ndh5K1YtLwH+SjKb92+bug0JfvsVIsHuCB5ycrgV3cc+pPdXeoqKfNXSLLlp
         BswzYd58ZSN85fsCbhwAPpp5u3iFkAk6CkWvo1ungVPJNgNs3hHnYpjipjTiEFtiBlYa
         u0Q00X1vaJkAX1xPv8Y/qQA76Ycknvwy4Sea3MnTDYMc0xFE9H3Y0cnIA4PysPRxwN9k
         FFBA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCIkVRiqRdRzOGkU0U8EmzEC4WjbW/MiEm9t4mQZiLwI4X5zDBPWzFQq/co7QIqXNilNjzGnmna3E9E4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/cmuCa0VoZLJDK+0EaED/6RzBN7xK0n3Yj3GCjTFX/FekL+2w
	LIcbFmer8EMLTFnrIbgcgaSUNbh7h42XOh99MRmJX0ey3fN031yobGMDWwKnhL01fBXyWLQctNe
	svTSH02dbef2BTqfrBddVSqNC9ODrlTV5NshPig==
X-Google-Smtp-Source: AGHT+IFL1pOCsLOzeBtwBjcM2LXd+pFUt5QuQhNleW8Q7cESkl9pWYhZOltzib9pUL20mIRQ8tYdGrayaMLcj6yPlA4=
X-Received: by 2002:a2e:87d5:0:b0:2f3:f441:af16 with SMTP id
 38308e7fff4ca-2f3f8b69a3fmr28576191fa.48.1724317875669; Thu, 22 Aug 2024
 02:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822083842.3167137-1-hezhongkun.hzk@bytedance.com> <Zsb-SplgW_JizWdE@tiehlicka>
In-Reply-To: <Zsb-SplgW_JizWdE@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 22 Aug 2024 17:11:03 +0800
Message-ID: <CACSyD1M9wzdkjcV+zT3exTPKZdKL3rUEuGU_norPZxivF3518A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH V1] mm:page_alloc: fix the NULL
 ac->nodemask in __alloc_pages_slowpath()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 5:01=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Thu 22-08-24 16:38:42, Zhongkun He wrote:
> > I found a problem in my test machine that should_reclaim_retry() do
> > not get the right node if i set the cpuset.mems.
> > The should_reclaim_retry() and try_to_compact_pages() are iterating
> > nodes which are not allowed by cpusets and that makes the retry loop
> > happening more than unnecessary.
>
> I would update the problem description because from the above it is not
> really clear what the actual problem is.
>
> should_reclaim_retry is not ALLOC_CPUSET aware and that means that it
> considers reclaimability of NUMA nodes which are outside of the cpuset.
> If other nodes have a lot of reclaimable memory then should_reclaim_retry
> would instruct page allocator to retry even though there is no memory
> reclaimable on the cpuset nodemask. This is not really a huge problem
> because the number of retries without any reclaim progress is bound but
> it could be certainly improved. This is a cold path so this shouldn't
> really have a measurable impact on performance on most workloads.
>

Thanks for your description about this case.

> >
> > 1.Test step and the machines.
> > ------------
> > root@vm:/sys/fs/cgroup/test# numactl -H | grep size
> > node 0 size: 9477 MB
> > node 1 size: 10079 MB
> > node 2 size: 10079 MB
> > node 3 size: 10078 MB
> >
> > root@vm:/sys/fs/cgroup/test# cat cpuset.mems
> >     2
> >
> > root@vm:/sys/fs/cgroup/test# stress --vm 1 --vm-bytes 12g  --vm-keep
> > stress: info: [33430] dispatching hogs: 0 cpu, 0 io, 1 vm, 0 hdd
> > stress: FAIL: [33430] (425) <-- worker 33431 got signal 9
> > stress: WARN: [33430] (427) now reaping child worker processes
> > stress: FAIL: [33430] (461) failed run completed in 2s
> >
> > 2. reclaim_retry_zone info:
> >
> > We can only alloc pages from node=3D2, but the reclaim_retry_zone is
> > node=3D0 and return true.
> >
> > root@vm:/sys/kernel/debug/tracing# cat trace
> > stress-33431   [001] ..... 13223.617311: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D1 wmark_check=3D1
> > stress-33431   [001] ..... 13223.617682: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D2 wmark_check=3D1
> > stress-33431   [001] ..... 13223.618103: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D3 wmark_check=3D1
> > stress-33431   [001] ..... 13223.618454: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D4 wmark_check=3D1
> > stress-33431   [001] ..... 13223.618770: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D5 wmark_check=3D1
> > stress-33431   [001] ..... 13223.619150: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D6 wmark_check=3D1
> > stress-33431   [001] ..... 13223.619510: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D7 wmark_check=3D1
> > stress-33431   [001] ..... 13223.619850: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D8 wmark_check=3D1
> > stress-33431   [001] ..... 13223.620171: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D9 wmark_check=3D1
> > stress-33431   [001] ..... 13223.620533: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D10 wmark_check=3D1
> > stress-33431   [001] ..... 13223.620894: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D11 wmark_check=3D1
> > stress-33431   [001] ..... 13223.621224: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D12 wmark_check=3D1
> > stress-33431   [001] ..... 13223.621551: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D13 wmark_check=3D1
> > stress-33431   [001] ..... 13223.621847: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D14 wmark_check=3D1
> > stress-33431   [001] ..... 13223.622200: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D15 wmark_check=3D1
> > stress-33431   [001] ..... 13223.622580: reclaim_retry_zone: node=3D0 z=
one=3DNormal   order=3D0 reclaimable=3D4260 available=3D1772019 min_wmark=
=3D5962 no_progress_loops=3D16 wmark_check=3D1
> >
>
> You can drop the following
>

OK.

> > 3. Root cause:
> > Nodemask usually comes from mempolicy in policy_nodemask(), which
> > is always NULL unless the memory policy is bind or prefer_many.
> >
> > nodemask =3D NULL
> > __alloc_pages_noprof()
> >       prepare_alloc_pages
> >               ac->nodemask =3D &cpuset_current_mems_allowed;
> >
> >       get_page_from_freelist()
> >
> >       ac.nodemask =3D nodemask;  /*set  NULL*/
> >
> >       __alloc_pages_slowpath() {
> >               f (!(alloc_flags & ALLOC_CPUSET) || reserve_flags) {
> >                       ac->nodemask =3D NULL;
> >                       ac->preferred_zoneref =3D first_zones_zonelist(ac=
->zonelist,
> >                                       ac->highest_zoneidx, ac->nodemask=
);
> >
> >               /* so ac.nodemask =3D NULL */
> >       }
> >
> > According to the function flow above, we do not have the memory limit t=
o
> > follow cpuset.mems, so we need to add it.
> >
> > Test result:
> > Try 3 times with different cpuset.mems and alloc large memorys than tha=
t numa size.
> > echo 1 > cpuset.mems
> > stress --vm 1 --vm-bytes 12g --vm-hang 0
> > ---------------
> > echo 2 > cpuset.mems
> > stress --vm 1 --vm-bytes 12g --vm-hang 0
> > ---------------
> > echo 3 > cpuset.mems
> > stress --vm 1 --vm-bytes 12g --vm-hang 0
> >
> > The retry trace look like:
> > stress-2139    [003] .....   666.934104: reclaim_retry_zone: node=3D1 z=
one=3DNormal   order=3D0 reclaimable=3D7 available=3D7355 min_wmark=3D8598 =
no_progress_loops=3D1 wmark_check=3D0
> > stress-2204    [010] .....   695.447393: reclaim_retry_zone: node=3D2 z=
one=3DNormal   order=3D0 reclaimable=3D2 available=3D6916 min_wmark=3D8598 =
no_progress_loops=3D1 wmark_check=3D0
> > stress-2271    [008] .....   725.683058: reclaim_retry_zone: node=3D3 z=
one=3DNormal   order=3D0 reclaimable=3D17 available=3D8079 min_wmark=3D8597=
 no_progress_loops=3D1 wmark_check=3D0
> >
>
> And only keep this
>

OK.

> > With this patch, we can check the right node and get less retry in __al=
loc_pages_slowpath()
> > because there is nothing to do.
> >
> > V1:
> > Do the same with the page allocator using __cpuset_zone_allowed().
> >
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
>
> With those changes you can add
> Acked-by: Michal Hocko <mhocko@suse.com>
> Thanks!
>
> > ---
> >  mm/compaction.c | 6 ++++++
> >  mm/page_alloc.c | 5 +++++
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index d1041fbce679..a2b16b08cbbf 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/freezer.h>
> >  #include <linux/page_owner.h>
> >  #include <linux/psi.h>
> > +#include <linux/cpuset.h>
> >  #include "internal.h"
> >
> >  #ifdef CONFIG_COMPACTION
> > @@ -2822,6 +2823,11 @@ enum compact_result try_to_compact_pages(gfp_t g=
fp_mask, unsigned int order,
> >                                       ac->highest_zoneidx, ac->nodemask=
) {
> >               enum compact_result status;
> >
> > +             if (cpusets_enabled() &&
> > +                     (alloc_flags & ALLOC_CPUSET) &&
> > +                     !__cpuset_zone_allowed(zone, gfp_mask))
> > +                             continue;
> > +
> >               if (prio > MIN_COMPACT_PRIORITY
> >                                       && compaction_deferred(zone, orde=
r)) {
> >                       rc =3D max_t(enum compact_result, COMPACT_DEFERRE=
D, rc);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 29608ca294cf..8a67d760b71a 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4128,6 +4128,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned or=
der,
> >               unsigned long min_wmark =3D min_wmark_pages(zone);
> >               bool wmark;
> >
> > +             if (cpusets_enabled() &&
> > +                     (alloc_flags & ALLOC_CPUSET) &&
> > +                     !__cpuset_zone_allowed(zone, gfp_mask))
> > +                             continue;
> > +
> >               available =3D reclaimable =3D zone_reclaimable_pages(zone=
);
> >               available +=3D zone_page_state_snapshot(zone, NR_FREE_PAG=
ES);
> >
> > --
> > 2.20.1
>
> --
> Michal Hocko
> SUSE Labs


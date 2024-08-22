Return-Path: <linux-kernel+bounces-296528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF7F95ABC7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90D481F26472
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC501BF2A;
	Thu, 22 Aug 2024 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hJjm34Ds"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2A175AE
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296552; cv=none; b=e3kDBjMD8n6X9+TKzrzEIU6aZU1/UTitdQcwW3BrsOlRSRZ1dMZjz+0HcD27VAcCbZmIxIu7SbjVfjiisZsVv4GbK6kaepZskMkDXvQU1u5VxnQXyGYIUYz0S6awGYs8I6GMTZRBNyJPN62a0bipbYZHau0Fd/4molxx2agvAJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296552; c=relaxed/simple;
	bh=xDeW4UA6nkOVTBvO9jYP9AWkorz2ERFYo8jmNVy0Sts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+E468QBEvXbINOLqIQNBiYKY+VZCtpW4Lvrba0Jic7kgoOjh5/95rauYwepG5KauWruEG/HN1vd4Gn/+6eqS4JZPQAv+qTxyd5C/of/4VzmQ/7WdR379iEbMcsQP9WlrZkKHQeToyyNxHrLgCKZRbBquToXN0w+VJQsAu7TE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hJjm34Ds; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f16767830dso2780661fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724296547; x=1724901347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vM0VGpc++28VKep3l7Qp8XNykaCbGwjKhJqn2A5lERM=;
        b=hJjm34Ds8pGlVgSm2Q0i9xALNZucrj6xlLQOYiAGadSYe4YeoKUO5pNax/NP7guHv6
         Q+jy+4hBhM6jLk5vrGj+pwzm6Gbe8JEIBAOtwNEXWd4VvF4a/YqsShIXp4J12bSrBBTl
         9/tO2cphf5aR23p016HJX9hfRSiO4CCrYmYkNwQ/0am0JYGVDEs2So/cKxsHZGSiq80y
         hKiRv/hGpqwZ8wM+oX62DgbkCDsNinU/Ct9PSdCGjC7KkAvwJ0F1fA0zeU65xnejZnnf
         OxZbgwyKRwBnWXjDBTZ2mg0uLGx4/XS0fP1wixwc20Ge72Aujy6l5H3bDrqQ0GaPvGvB
         ZQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724296547; x=1724901347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vM0VGpc++28VKep3l7Qp8XNykaCbGwjKhJqn2A5lERM=;
        b=gi5/rldD4V5PlA+UpdvIY+5UJtNYCV+muR0iL3Ig48+84BBt/HqIXTJA/rihFio68c
         +oVI3zp8vPsMZNNlqfH67jEZqqMIckEmBciTd3m6Ho3WelUf+CK0POmGbULanCINRXqf
         ZpHZGoQtlP7ck1gTbzLKXsHn/lDuFBi7jJ8im9uSSFRCC53MFNE4po6ZW8NZMwlANTdg
         i+Q07huzeg1C3jJLvcWkQosbY1QxKbqVdXjLrFotuNGNZ1mVy9W2tQV5vOEmnW4wLQn+
         14mG8cecGRHhmUAUexViMI1PLS7/DnV/GyxHMtXy+NtDMQpNUczveC0CYp0Y8OuuKclX
         R33Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrKltg7/EH7RbGaXxWU7oWxTKvplZHQnOUNbIva/XANhMEg71lnlBTR1pYAGJCRbIkkYHeZcFWpztZ2DM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6QXCRIRy6TFJ5WqyZFseP5QWso8oyjTvwCX0vwlxLcL3YxSPx
	R+yc1CpllfBmmsYCAadW1bra0ENUioA5JBhYc/GcyVXTx6eRv4wLstO10Ucen0XxjzSxjsBVh3k
	JZEi8w8d84jmiVxI0WdY6HT4k9P+4IeB8zdyuuVmkbdpgS8w/Xtc=
X-Google-Smtp-Source: AGHT+IFKMin858I+mlpUJ2KUlld1JnHNrWMfMMDwzAXDgaD3Y3Bol8k2HnoTudZ0gvsdR1zYtwXSOO+zsHSxp8wBkpI=
X-Received: by 2002:a2e:a589:0:b0:2f1:59ed:87ab with SMTP id
 38308e7fff4ca-2f3f88ea892mr26771881fa.24.1724296546876; Wed, 21 Aug 2024
 20:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821135900.2199983-1-hezhongkun.hzk@bytedance.com> <ZsYBDGE-_8GPPEpE@tiehlicka>
In-Reply-To: <ZsYBDGE-_8GPPEpE@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 22 Aug 2024 11:15:34 +0800
Message-ID: <CACSyD1OdKb4n1SrStdTfhwO0F1eBA5mNruxOeYKrhKP6+jTXAg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:page_alloc: fix the NULL ac->nodemask
 in __alloc_pages_slowpath()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 11:00=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 21-08-24 21:59:00, Zhongkun He wrote:
> > I found a problem in my test machine that should_reclaim_retry() do
> > not get the right node if i set the cpuset.mems
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
>
> OK, so the test gets killed as expected.
>
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
>
> Are you suggesting that the problem is that should_reclaim_retry is
> iterating nodes which are not allowed by cpusets and that makes the
> retry loop happening more than unnecessary?

Yes, exactly.

>
> Is there any reason why you haven't done the same that the page
> allocator does in this case?
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 28f80daf5c04..cbf09c0e3b8a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4098,6 +4098,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned orde=
r,
>                 unsigned long min_wmark =3D min_wmark_pages(zone);
>                 bool wmark;
>
> +               if (cpusets_enabled() &&
> +                       (alloc_flags & ALLOC_CPUSET) &&
> +                       !__cpuset_zone_allowed(zone, gfp_mask))
> +                               continue;
> +
>                 available =3D reclaimable =3D zone_reclaimable_pages(zone=
);
>                 available +=3D zone_page_state_snapshot(zone, NR_FREE_PAG=
ES);
>

That was my original version,  but I found that the problem exists in
other places.
Please see the function flow below.

__alloc_pages_slowpath:

  get_page_from_freelist
     __cpuset_zone_allowed /* check the node */

  __alloc_pages_direct_reclaim
     shrink_zones
        cpuset_zone_allowed=EF=BC=88=EF=BC=89/* check the node */

 __alloc_pages_direct_compact
   try_to_compact_pages
       /* do not check the cpuset_zone_allowed=EF=BC=88=EF=BC=89*/

  should_reclaim_retry
  /* do not check the cpuset_zone_allowed=EF=BC=88=EF=BC=89*/

  should_compact_retry
      compaction_zonelist_suitable
          /* do not check the cpuset_zone_allowed=EF=BC=88=EF=BC=89*/

Should we add __cpuset_zone_allowed() checks in the three functions
listed above,
or should we set the nodemask in __alloc_pages_slowpath()  if it is empty
and the request comes from user space?

Adding checks respectively in the three functions might be safer and
easier to review.
It would be better if you had any suggestions.

Thanks.

> --
> Michal Hocko
> SUSE Labs


Return-Path: <linux-kernel+bounces-232223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B2491A55B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D21F21EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54279152DF2;
	Thu, 27 Jun 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpxRHwz1"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4915278C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487964; cv=none; b=JTqnwJqFuzyuFGc+ap+qBoxw2qYGZzAVVv3us4VJRHzYTNfEhXbcDq1v1zRr28xIj1y3u154PUvsZ36cAzHBvfRdUsC+EDVisRuyNMaCnr3rjz/Cr5MfAgD5feDBQtOAjTGW4ERXOD9fMG1HQ678OoMvmpMKL076xViUgtrmyz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487964; c=relaxed/simple;
	bh=4UzUuSBdxSOm4GQ+VmRCKLjYCfbEBtPljvESWwFnQ7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xq1uY7RHfoCFR0lZF8fiHjR82Lr7AJ/g8WuEt+yvmYEWyG2s3Wc2AL4OysUwFkqdLqrr5cl9B9dtg8JxK9kVCKRPPLCt2TsVGMJhtTAXQK1Ne0PyJy5SEXdauxFm3Te+HaQAq6dRUgOb5jk1CuHf8rWmcTlkho8gcQeyHebv/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpxRHwz1; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a725a918edaso417535566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 04:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719487961; x=1720092761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vU5agj/EL1K0f7W7LUiKvhi+dR0y1Ed4dZ6K6lOZ28=;
        b=MpxRHwz1RmB342SgcwIEo3I2Ku7/yPm0nKX8qig3EBuHYwmr72deGYWRsPcWKooL+H
         f2DbIXPatj6nt6N8SPJcRs1e5UlQ9H8KXwhssu5+Twh2CxBMNoWsJw+p/oS/piIHgUCN
         Pcp+/XaMXFm+bJwtLsHEeyEhkLgCbb67z9uFdrQVessS2paD0u7jSD5nLeS4CgwO8zP1
         ETFBey7LpEOhxpyjRwAghSFexMsz+kehUHcuO9U8OsCgSGbm558g6JnoxrUH/eEMk32D
         3GzWtbzp/fwgNIq2PW0R8gnRF9miktUaN0df8AXf1tysFQ6C3PKy515gHR4XpQUVI2UU
         i11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719487961; x=1720092761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vU5agj/EL1K0f7W7LUiKvhi+dR0y1Ed4dZ6K6lOZ28=;
        b=Rn2Ouuvp1iHVvzhYwGoMsTgKX0d14aIoOmfuqabixvGEOxr8nj/Cowr66UoBhn9rUG
         2BZWpX4Jt6P2q1oR/uN7t3N+7G4DbJgLqHHnQp8LjHaqXzmnsoM5YVqvzZftma1TPeTE
         x7v9fZGRwYP3sPlV01+k0VX8bJ83+wsy+SCP+yq1ZQyGNDSR7+29vSwxH9CsSKIme1ta
         LxrlWom1MyGPB0aIHO1/TqzPxlPrZ1daE3B76be470xPKqBqIIU3PtmklAzIkFZxL0gJ
         XXr8rgmxxxHV54hp2jnYtf9OAPqvFWQVz7OZArhM90gsJL28ZbATgPtnH4ohy89uVfFZ
         FjUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWf68eC5WuN1iNDGi2MX5cRuliF8jqumVQkzcUyX8ME7vgT/j2sUyRRAQYvXf70xF5oqnESCCaXz44ieO4biaGuvWON35ATDX1ZNWF1
X-Gm-Message-State: AOJu0YwV6zde/8YoTElyW+rapEGK22VjzJh4RQdH2rq9NrzW4P1luDXE
	KuUUV0cDAqWJqGM5iUsxSz9fpFlG5EbIhB5IkjHK4T9ytQrfk7V61NvNWJU8nZNapZcRD0WY8bF
	D3oYzs7nGTEgUGMh+O4RLaPN6RJsmgikybpnR
X-Google-Smtp-Source: AGHT+IFzenAMVJq7FYqPhFgYZ5K6XiUy6e6TmL+067a8BQRtwc96chyuNJ9XV581VCJKL/mCZSROLKHWMI1AqndJi9E=
X-Received: by 2002:a17:907:c085:b0:a72:4676:4f8 with SMTP id
 a640c23a62f3a-a7246760537mr1163117766b.62.1719487960491; Thu, 27 Jun 2024
 04:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171943667611.1638606.4158229160024621051.stgit@firesoul>
 <171943668946.1638606.1320095353103578332.stgit@firesoul> <CAJD7tkbBpPqFW5fhmhcwDAfrze+aj8xFCF+3S4egBfipA4zKgQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbBpPqFW5fhmhcwDAfrze+aj8xFCF+3S4egBfipA4zKgQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 27 Jun 2024 04:32:03 -0700
Message-ID: <CAJD7tkYFKTA7aLcBE=X0jA1vKG_V+6Z-HstJRnnNrvMnjnLzHw@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 3:33=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Wed, Jun 26, 2024 at 2:18=E2=80=AFPM Jesper Dangaard Brouer <hawk@kern=
el.org> wrote:
> >
> > Avoid lock contention on the global cgroup rstat lock caused by kswapd
> > starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> > massive issues due to kswapd and the specific mem_cgroup_flush_stats()
> > call inlined in shrink_node, which takes the rstat lock.
> >
> > On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
> > we noted severe lock contention on the rstat lock. This contention
> > causes 12 CPUs to waste cycles spinning every time kswapd runs.
> > Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
> > burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
> > due to spinning on the rstat lock.
> >
> > To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
> > empty, __alloc_pages_slowpath calls wake_all_kswapds(), causing all
> > kswapdN threads to wake up simultaneously. The kswapd thread invokes
> > shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> > operation as part of its work. This results in kernel self-induced rsta=
t
> > lock contention by waking up all kswapd threads simultaneously.
> > Leveraging this detail: balance_pgdat() have NULL value in
> > target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
> > root_mem_cgroup.
> >
> > To avoid this kind of thundering herd problem, kernel previously had a
> > "stats_flush_ongoing" concept, but this was removed as part of commit
> > 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
> > reintroduce and generalized the concept to apply to all users of cgroup
> > rstat, not just memcg.
> >
> > If there is an ongoing rstat flush, and current cgroup is a descendant,
> > then it is unnecessary to do the flush. For callers to still see update=
d
> > stats, wait for ongoing flusher to complete before returning, but add
> > timeout as stats are already inaccurate given updaters keeps running.
> >
> > Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> > Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > ---
> > V2: https://lore.kernel.org/all/171923011608.1500238.359100257373268363=
9.stgit@firesoul/
> > V1: https://lore.kernel.org/all/171898037079.1222367.134673174847937485=
19.stgit@firesoul/
> > RFC: https://lore.kernel.org/all/171895533185.1084853.30337515613022282=
52.stgit@firesoul/
> >
> >  kernel/cgroup/rstat.c |   61 ++++++++++++++++++++++++++++++++++++++++-=
--------
> >  1 file changed, 50 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> > index 2a42be3a9bb3..f21e6b1109a4 100644
> > --- a/kernel/cgroup/rstat.c
> > +++ b/kernel/cgroup/rstat.c
> > @@ -2,6 +2,7 @@
> >  #include "cgroup-internal.h"
> >
> >  #include <linux/sched/cputime.h>
> > +#include <linux/completion.h>
> >
> >  #include <linux/bpf.h>
> >  #include <linux/btf.h>
> > @@ -11,6 +12,8 @@
> >
> >  static DEFINE_SPINLOCK(cgroup_rstat_lock);
> >  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> > +static struct cgroup *cgrp_rstat_ongoing_flusher;
> > +static DECLARE_COMPLETION(cgrp_rstat_flusher_done);
> >
> >  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
> >
> > @@ -346,6 +349,44 @@ static void cgroup_rstat_flush_locked(struct cgrou=
p *cgrp)
> >         }
> >  }
> >
> > +#define MAX_WAIT       msecs_to_jiffies(100)
> > +/* Trylock helper that also checks for on ongoing flusher */
> > +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> > +{
> > +retry:
> > +       bool locked =3D __cgroup_rstat_trylock(cgrp, -1);
> > +       if (!locked) {
> > +               struct cgroup *cgrp_ongoing;
> > +
> > +               /* Lock is contended, lets check if ongoing flusher is =
already
> > +                * taking care of this, if we are a descendant.
> > +                */
> > +               cgrp_ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> > +               if (!cgrp_ongoing)
> > +                       goto retry;
> > +
> > +               if (cgroup_is_descendant(cgrp, cgrp_ongoing)) {
> > +                       wait_for_completion_interruptible_timeout(
> > +                               &cgrp_rstat_flusher_done, MAX_WAIT);
>
> Thanks for sending this!
>
> The reason why I suggested that the completion live in struct cgroup
> is because there is a chance here that the flush completes and another
> irrelevant flush starts between reading cgrp_rstat_ongoing_flusher and
> calling wait_for_completion_interruptible_timeout().
>
> This will cause the caller to wait for an irrelevant flush, which may
> be fine because today the caller would wait for the lock anyway. Just
> mentioning this in case you think this may happen enough to be a
> problem.

Actually, I think this can happen beyond the window I described above.
I think it's possible that a thread waits for the flush, then gets
woken up when complete_all() is called, but another flusher calls
reinit_completion() immediately. The woken up thread will observe
completion->done =3D=3D 0 and go to sleep again.

I think most of these cases can be avoided if we make the completion
per cgroup. It is still possible to wait for more flushes than
necessary, but only if they are for the same cgroup.


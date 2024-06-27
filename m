Return-Path: <linux-kernel+bounces-232133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BD91A3EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109091F21365
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1B13C67B;
	Thu, 27 Jun 2024 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isuZrrqO"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769413D8B6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484471; cv=none; b=PyNdK7o+zRu5PfC15bMOE8YPjR9hhLvB1RxKH6jLcWA4aETqPh3IVzqXRVtRpPkWI83BBH+y5TyKuu0hwT3LV84wiKaeHJD8sxknyy/euJ5v8dfEcEVnKtPaTKMeUsVdsK614o/89KoElrwGkzpwFN5rvBNLkciHtmy6XTWJpPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484471; c=relaxed/simple;
	bh=/NjzPjCkeQR/9FVL9SZ4g6IzWAjGvT3d86pL2oSZKlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbCQU5PytHbnqXk+bGAK3GLAKuSA/sTLAgnnBfcSj25GHhs7Ri8a1EPnuRAYz8aQVx+GnRJ66PeVWg4p1JZ4n5iZRIHvHpSMkDQa40Qk/x6Qc6tJrJIQBcSXOhq5ojXa/1EXZF5YnE6Ve9QiiFgN6b+m6rHXim1JvPEzjYwjqv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=isuZrrqO; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fdd947967so596903166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719484468; x=1720089268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9FS9JzVBeWa6xY6RjccFGH3HEep7Fmdm+7GGppOyXg=;
        b=isuZrrqOT45q349s6Wl2gF4OhC7RFzrSXdDyBeXoEtdLXiK0PngmqDX2VpQzpjbat2
         oGkGPZDH5kMTHjlDLG4CZkeofFVs65delic72FaB5bGwlTCngXRXy0CJAwzd4aWuOKlL
         ZMSVxjd8Mz8S5ZgYae5Iif9i0Z4DhcHNtJnOKnLCYrQ0ZLJS9QNDGdT0tqFZkTUuUJUs
         7lz6HTsMjv2o5t0mYuPorZnFVttzjzNFgHlO9UPKBE5DxbrALCJ81ET4kdT9FLuMOFk4
         fPWyX3qeMJS3sUak4NZnuaNlAVA9DpG1GLkHOTgLJvF+T83/8hNIepcdOOXuM2CAEliE
         BUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719484468; x=1720089268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9FS9JzVBeWa6xY6RjccFGH3HEep7Fmdm+7GGppOyXg=;
        b=hKt/mPpo7hNA42e2ZfxbDxTEt7+2fMcSaBFM9SVq4FzIfFpdVq98siuuvi5tjn3ZVf
         7KAYQtEie1YLLFsKZaxaa3wUy/HSiSOIKyggDYt69+VV+pmxj90ZXTD/omvCAA6wbezi
         Pqva8OJfr1Xmlg8b9NK2iBg+hV2t96ZFp5iSorTsYBrJ/KG7LukjE0N1r676xUD1pev3
         hgL8YqRMOGJx+RSrkFK+R5IPzuVLeY1JJX2ZsiOYpiEJJMoo/rlnA2wpMxclp6MAJgaI
         Ma4gnR1GXVNp/Rs2kLVLS1gYD4g550+SzU11G4W9syOqT81dzij2G06/c7EZq3cte0nD
         34FA==
X-Forwarded-Encrypted: i=1; AJvYcCVN5OW3X/OSLjrtYMb80T1vLxhV7kVyKhPNnPSh99xDDE/ryLwLprLvoKZIvx3yJDYSarCmDLeEGyOoUnd5vpI8+hO05+/ngr4rvjI8
X-Gm-Message-State: AOJu0Yz9QfNgSq7MvqgdpjabD18nOKDssJ13EXcx0HVrxRAMrx2oXX3G
	ugHHHRWIMikCfoPr5LqGkNk+UhsCHGDazai9/Qdqw1caU5f+IKY2bQNsh+IfMyczozPpp7EJuxc
	yM7685p0MONTGmxNU++c2ISJ6ZHpFQBO/KQmO
X-Google-Smtp-Source: AGHT+IGdO93khlibtkshuAazBmWw34RWyRGVw1+TAnqsxI8uf5V5MdIMHrT8t2WBfe+sceFvDcXuReAU2O9n7qvXycM=
X-Received: by 2002:a17:906:d96e:b0:a6f:608e:c0d0 with SMTP id
 a640c23a62f3a-a7245ba3cc0mr1099324466b.25.1719484467646; Thu, 27 Jun 2024
 03:34:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171943667611.1638606.4158229160024621051.stgit@firesoul> <171943668946.1638606.1320095353103578332.stgit@firesoul>
In-Reply-To: <171943668946.1638606.1320095353103578332.stgit@firesoul>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 27 Jun 2024 03:33:49 -0700
Message-ID: <CAJD7tkbBpPqFW5fhmhcwDAfrze+aj8xFCF+3S4egBfipA4zKgQ@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 2:18=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
> Avoid lock contention on the global cgroup rstat lock caused by kswapd
> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
> call inlined in shrink_node, which takes the rstat lock.
>
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
> we noted severe lock contention on the rstat lock. This contention
> causes 12 CPUs to waste cycles spinning every time kswapd runs.
> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
> due to spinning on the rstat lock.
>
> To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
> empty, __alloc_pages_slowpath calls wake_all_kswapds(), causing all
> kswapdN threads to wake up simultaneously. The kswapd thread invokes
> shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously.
> Leveraging this detail: balance_pgdat() have NULL value in
> target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
> root_mem_cgroup.
>
> To avoid this kind of thundering herd problem, kernel previously had a
> "stats_flush_ongoing" concept, but this was removed as part of commit
> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
> reintroduce and generalized the concept to apply to all users of cgroup
> rstat, not just memcg.
>
> If there is an ongoing rstat flush, and current cgroup is a descendant,
> then it is unnecessary to do the flush. For callers to still see updated
> stats, wait for ongoing flusher to complete before returning, but add
> timeout as stats are already inaccurate given updaters keeps running.
>
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.=
stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519=
.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252=
.stgit@firesoul/
>
>  kernel/cgroup/rstat.c |   61 ++++++++++++++++++++++++++++++++++++++++---=
------
>  1 file changed, 50 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 2a42be3a9bb3..f21e6b1109a4 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -2,6 +2,7 @@
>  #include "cgroup-internal.h"
>
>  #include <linux/sched/cputime.h>
> +#include <linux/completion.h>
>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> @@ -11,6 +12,8 @@
>
>  static DEFINE_SPINLOCK(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static struct cgroup *cgrp_rstat_ongoing_flusher;
> +static DECLARE_COMPLETION(cgrp_rstat_flusher_done);
>
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>
> @@ -346,6 +349,44 @@ static void cgroup_rstat_flush_locked(struct cgroup =
*cgrp)
>         }
>  }
>
> +#define MAX_WAIT       msecs_to_jiffies(100)
> +/* Trylock helper that also checks for on ongoing flusher */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +retry:
> +       bool locked =3D __cgroup_rstat_trylock(cgrp, -1);
> +       if (!locked) {
> +               struct cgroup *cgrp_ongoing;
> +
> +               /* Lock is contended, lets check if ongoing flusher is al=
ready
> +                * taking care of this, if we are a descendant.
> +                */
> +               cgrp_ongoing =3D READ_ONCE(cgrp_rstat_ongoing_flusher);
> +               if (!cgrp_ongoing)
> +                       goto retry;
> +
> +               if (cgroup_is_descendant(cgrp, cgrp_ongoing)) {
> +                       wait_for_completion_interruptible_timeout(
> +                               &cgrp_rstat_flusher_done, MAX_WAIT);

Thanks for sending this!

The reason why I suggested that the completion live in struct cgroup
is because there is a chance here that the flush completes and another
irrelevant flush starts between reading cgrp_rstat_ongoing_flusher and
calling wait_for_completion_interruptible_timeout().

This will cause the caller to wait for an irrelevant flush, which may
be fine because today the caller would wait for the lock anyway. Just
mentioning this in case you think this may happen enough to be a
problem.

Also, I like the idea of the timeout here, it bounds the flush wait
time. I am wondering if there's a way to log something when the
timeout is exceeded (which probably means flushing is taking too
long), or maybe have a debug counter if we suspect this may spam the
log.


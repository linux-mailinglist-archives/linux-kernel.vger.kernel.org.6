Return-Path: <linux-kernel+bounces-365316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E699E062
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C0D1F2326A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9B71C7299;
	Tue, 15 Oct 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chv8b1GM"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF7C19F420
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979692; cv=none; b=cEg15rbSf8qYLMkMPOpnIcLT2/PUQSDuTl3VYghkE/rOEKKf/ShhbiCLArX59iDzW/qjKMy/CPToVN/AJqlFV/TQivhcIUBjk4v3IBbmTAQG4Tprf390F91zRCJspNqtKoco7s4rwzCw6dCZB4X3aNbvDYbBHTiLKRsmOBw2H/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979692; c=relaxed/simple;
	bh=EyuBUYVXMadI36C78i9QIdQhVNDEx6HBS9/nIPezoVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WT9VGMhtB9fuCpv56y7MlbsYWLQayw9hskx/ygBbYdW7JngsaJrgzrVX6HkGOJcxWKJGlfQABbzz9YJyQ6nit3fqzCwhaK8Unu16/milpvlh9vX2rG7oX7CIWP1sq9y2Z780Gzrtr7rEgI2G40CbFYic6qNw4f4t/5Ib5XiP3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chv8b1GM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a156513a1so223692166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728979689; x=1729584489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DrzNGwPkbdM1CPH+YAONA+c6AWmVrJfrGwHxsSXjb8=;
        b=chv8b1GMZTao6K3xjTGZOEaW6zi9VK3zyYvlv0FCL681X4lEScQMTiCzP9jmlStS58
         RyfWdBjGRoA6amXm0cmmPsNxIxwYU3IHCFqGoiKYMG1xQ5OQcNuujMyqHcpreVQMuKz4
         Ihj8ZIOBtK9D/1vto4zqseSPqHdMwF1zfj4ryGW0wo4GOr+0yLsFzgbF1MZiN9ffdNx1
         QCN8E1hUPryXDkS8w2CuiXjw5RI6qMXFS5GdRh9G33DmBYTjZDB48Clt3E1Ws5L8znxf
         jH03DD7yyxx7um1fnPBVfbQsQdy53n5Oss9/i/TX3omf/ZrclHXwVSd5+tLs3UI9f9bw
         Qlcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979689; x=1729584489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6DrzNGwPkbdM1CPH+YAONA+c6AWmVrJfrGwHxsSXjb8=;
        b=ROjQlqTyrTpf8KLBAuzGW5/PA2Gk1+GaSGuq9s9zN27y47J4iOtnbvB7AzYmVDaEm4
         DgzeNpdnJg4fR4YUZS9l9JSMZqtg8b1s1XY7e6fqSSmZ7JHRWW90DFDqZq4ccEVnYdAe
         y63BfpbjqQtbuDi5PF5vWR4vCYOTL45pG7lBRRc4STwfhZR/XXu0iP2mIFHbtFM90EFt
         pYH2Uq0+igR1yMbQ/k7YO4BljbeXw+unhyL6wISRbsjplKhEdTD19dZ9d7VQdciQCLa+
         1QnXoU/rOun0jpmB+cICZpzwS2H9/3ErbfDggXsAeeSfwkU53CLWlmstwIIpFGojleku
         UNig==
X-Forwarded-Encrypted: i=1; AJvYcCWNU2p+xXrqlyg22Ai4yxJWNJJLQE37mcRB9AZJ4lMRhg2bXOgE7EZ/9L+1MA7x4woml09ynQZG3slWm4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxndqK9AP6G65aKOAPOIOu0ZhHylKgxdGPr3Mlea63e2O8G5lSJ
	JQAKgfFiC8Eg0MWGAUuYeKEQxvei8GQlOm1ujAHnc2R5A+jlaVR6P3KWRARGLhwCfRsJ9YFfVIh
	mrF6vRHePA3g8JpQULFUwZrvE28h6e6LW6hR/
X-Google-Smtp-Source: AGHT+IHQzE7/7CkNCdHcq4IpVEJ3q3XKiM7PqNExgmsDCcv7tTn2wDhZIkhqo6XqDnhnl0O7IIiH6FHw2aZ61lcbY00=
X-Received: by 2002:a17:907:7288:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a99b9586a29mr1156979866b.49.1728979688785; Tue, 15 Oct 2024
 01:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
In-Reply-To: <20241010003550.3695245-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 01:07:30 -0700
Message-ID: <CAJD7tkZJcnpREVdfJDMiM5y-UTX=Fby0LqQar3N9LCFeyOsn+Q@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 5:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.dev=
> wrote:
>
> The memcg stats are maintained in rstat infrastructure which provides
> very fast updates side and reasonable read side. However memcg added
> plethora of stats and made the read side, which is cgroup rstat flush,
> very slow. To solve that, threshold was added in the memcg stats read
> side i.e. no need to flush the stats if updates are within the
> threshold.
>
> This threshold based improvement worked for sometime but more stats were
> added to memcg and also the read codepath was getting triggered in the
> performance sensitive paths which made threshold based ratelimiting
> ineffective. We need more visibility into the hot and cold stats i.e.
> stats with a lot of updates. Let's add trace to get that visibility.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

One question below, otherwise:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  include/trace/events/memcg.h | 59 ++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c              | 13 ++++++--
>  2 files changed, 70 insertions(+), 2 deletions(-)
>  create mode 100644 include/trace/events/memcg.h
>
> diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> new file mode 100644
> index 000000000000..913db9aba580
> --- /dev/null
> +++ b/include/trace/events/memcg.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM memcg
> +
> +#if !defined(_TRACE_MEMCG_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MEMCG_H
> +
> +#include <linux/memcontrol.h>
> +#include <linux/tracepoint.h>
> +
> +
> +DECLARE_EVENT_CLASS(memcg_rstat,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val),
> +
> +       TP_STRUCT__entry(
> +               __field(u64, id)
> +               __field(int, item)
> +               __field(int, val)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> +               __entry->item =3D item;
> +               __entry->val =3D val;
> +       ),
> +
> +       TP_printk("memcg_id=3D%llu item=3D%d val=3D%d",
> +                 __entry->id, __entry->item, __entry->val)
> +);
> +
> +DEFINE_EVENT(memcg_rstat, mod_memcg_state,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val)
> +);
> +
> +DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val)
> +);
> +
> +DEFINE_EVENT(memcg_rstat, count_memcg_events,
> +
> +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +
> +       TP_ARGS(memcg, item, val)
> +);
> +
> +
> +#endif /* _TRACE_MEMCG_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c098fd7f5c5e..17af08367c68 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -71,6 +71,10 @@
>
>  #include <linux/uaccess.h>
>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/memcg.h>
> +#undef CREATE_TRACE_POINTS
> +
>  #include <trace/events/vmscan.h>
>
>  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum=
 memcg_stat_item idx,
>                 return;
>
>         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> +       val =3D memcg_state_val_in_pages(idx, val);
> +       memcg_rstat_updated(memcg, val);
> +       trace_mod_memcg_state(memcg, idx, val);
>  }
>
>  /* idx can be of type enum memcg_stat_item or node_stat_item. */
> @@ -741,7 +747,9 @@ static void __mod_memcg_lruvec_state(struct lruvec *l=
ruvec,
>         /* Update lruvec */
>         __this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
>
> -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
> +       val =3D memcg_state_val_in_pages(idx, val);
> +       memcg_rstat_updated(memcg, val);
> +       trace_mod_memcg_lruvec_state(memcg, idx, val);
>         memcg_stats_unlock();
>  }
>
> @@ -832,6 +840,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, e=
num vm_event_item idx,
>         memcg_stats_lock();
>         __this_cpu_add(memcg->vmstats_percpu->events[i], count);
>         memcg_rstat_updated(memcg, count);
> +       trace_count_memcg_events(memcg, idx, count);

count here is an unsigned long, and we are casting it to int, right?

Would it be slightly better if the tracepoint uses a long instead of
int? It's still not ideal but probably better than int.

>         memcg_stats_unlock();
>  }
>
> --
> 2.43.5
>


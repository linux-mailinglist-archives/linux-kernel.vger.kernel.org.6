Return-Path: <linux-kernel+bounces-366488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEC599F601
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A00C1C20D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A981B3956;
	Tue, 15 Oct 2024 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQIwvf4f"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4188A2036F1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729018091; cv=none; b=GWt8A5E27zKRFI1Lhv4v7jPKPv7L3ZO+WKf3S2I2no2BzRsT6yYmA1OV1h+w/y3zZdh9ajP0JwnjjVAX7GSuzo+jZqmh/weNWIlAuwx44V0xHdyPyQc0Ca87iAXiwlgT8qW/cRSIbbQHP/G242jl7JomYldhl6BHZTTD1CL5RLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729018091; c=relaxed/simple;
	bh=2YOBzryoMQPT0Tv1TmqsC2v/Ef77ZZPEvOF+Rh1DTsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCJ8lPr+i4UC7AWFvEa5d21nGGuaahyTMaDgeWc+2x3rgf1qw1sTn5nymkVC/NOsRJciKohcxaj8v6baRGJRMLEAPbvi0CN/ejU9hVkiG9ZneagNgx3GF/fhjIqt7iMtXAE7c3R/G7BAicfhzc2wWXJ1qLJfLYG2WEKldqQfGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQIwvf4f; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a998a5ca499so845557566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729018088; x=1729622888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0Q6Rr8GmR7OPODRoA8Pk21Xu3m03yYr3s3ff8F/GCo=;
        b=vQIwvf4fX8BWoexsPFpDPt3uoBVGSPoWz7z2zUyyO9JK6cZLyEyE30g0bRFFe3gwXb
         yzHDi87X8MfdG8LA2UW9jRwD+2H8NgoEFHanY280wUXuTxN8ba2SXwib/sKjjDCFDjng
         kaDL7Y2AluGHBVb8NFwD3+c5W+5Tlpc7AD8JY3fwHG88PhrM0svgKxIYfnLcc6MPeV7I
         zpaKJmEBZ97wu4k6tlXe2qoq4oMEZ77N8g5YpAbxzB0f9wdHJXxZGgAjFZi/phMY7pHs
         9Dcoml/L50pgxW/kkiJzXcO0BL5vz5Q0qrYhH85Rzk0+ZO7zuRhqR6JEivJ1XeY+5Az5
         t9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729018088; x=1729622888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0Q6Rr8GmR7OPODRoA8Pk21Xu3m03yYr3s3ff8F/GCo=;
        b=YscFAQV9RzYE4b+BcieWk5Bxmty9yMo7+zFkDStc7rgRrR8tSQ3vm1UdTGUnO2h3TW
         NORR8VF0iKlQ6gnWjLe4m9lX+no0SpNt0fhMjdt1YMheqpfxJ2ji16sIL0LoR7O4GhVR
         Zf2tQqT8Xm6lhhId0XABZz3tDrO+5wpMLQQ3g67DHsqvXgrF1D4Ur+yeyXzfXbhXvg2Y
         VEIEbfcx8RDTkmz1sVAgOjBYWU5rKY8OOt8aUjquyc42wtvLmSLP8jjno2zsW3qTps6k
         ftl+jHbdonDUTRmK3GdHn/DpMjP9x2KQXNJN0j63U315WMoMUZH7GwFjE0DLW2rgk8Y5
         N72A==
X-Forwarded-Encrypted: i=1; AJvYcCXvvFuCusF1I7I1d7yDU1XtSgIWgrysMJzh/XYBxbT3cROUq2pQCcDj3KLzdjWqB6BvlmWbuw9waw9MdeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJimQ3PbOLUVDPBVYaO7jvaAPMgodFgSp5KNf1NXt262NmaFIk
	OMRYLUjqmTAkfux3F5bdzeKmgpYztTwwoGQCLCyJLugvJWtLHxZ15NLA2uVGiwKTlIjmFWpbdCy
	Zo38sKZYcJ8mjE5d2DPbHsHo5w0P7GdXLhLQP
X-Google-Smtp-Source: AGHT+IEPE4Wm+iAmO9A2wTEUS7hNRVy3vUa9Q+I2Ede5JQ064QDWeqSACfAYirinEsa2vM2o7hLn+VBgAb65Kad6Xkc=
X-Received: by 2002:a17:907:1b1c:b0:a99:7455:25f2 with SMTP id
 a640c23a62f3a-a99e3cdc18bmr1202242066b.39.1729018087243; Tue, 15 Oct 2024
 11:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010003550.3695245-1-shakeel.butt@linux.dev>
 <CAJD7tkZJcnpREVdfJDMiM5y-UTX=Fby0LqQar3N9LCFeyOsn+Q@mail.gmail.com> <t6y4ocz7pxktqoktd4h5qc3jkuxifisvnwlahmpgeyitmfk5j3@fs7q2jaxchif>
In-Reply-To: <t6y4ocz7pxktqoktd4h5qc3jkuxifisvnwlahmpgeyitmfk5j3@fs7q2jaxchif>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 15 Oct 2024 11:47:29 -0700
Message-ID: <CAJD7tkbFbkmJYh=n1hnm=jJNZz2-BcYP4dyJF_G2Q37cGE=eJQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 11:39=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Tue, Oct 15, 2024 at 01:07:30AM GMT, Yosry Ahmed wrote:
> > On Wed, Oct 9, 2024 at 5:36=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
.dev> wrote:
> > >
> > > The memcg stats are maintained in rstat infrastructure which provides
> > > very fast updates side and reasonable read side. However memcg added
> > > plethora of stats and made the read side, which is cgroup rstat flush=
,
> > > very slow. To solve that, threshold was added in the memcg stats read
> > > side i.e. no need to flush the stats if updates are within the
> > > threshold.
> > >
> > > This threshold based improvement worked for sometime but more stats w=
ere
> > > added to memcg and also the read codepath was getting triggered in th=
e
> > > performance sensitive paths which made threshold based ratelimiting
> > > ineffective. We need more visibility into the hot and cold stats i.e.
> > > stats with a lot of updates. Let's add trace to get that visibility.
> > >
> > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > One question below, otherwise:
> >
> > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> >
> > > ---
> > >  include/trace/events/memcg.h | 59 ++++++++++++++++++++++++++++++++++=
++
> > >  mm/memcontrol.c              | 13 ++++++--
> > >  2 files changed, 70 insertions(+), 2 deletions(-)
> > >  create mode 100644 include/trace/events/memcg.h
> > >
> > > diff --git a/include/trace/events/memcg.h b/include/trace/events/memc=
g.h
> > > new file mode 100644
> > > index 000000000000..913db9aba580
> > > --- /dev/null
> > > +++ b/include/trace/events/memcg.h
> > > @@ -0,0 +1,59 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#undef TRACE_SYSTEM
> > > +#define TRACE_SYSTEM memcg
> > > +
> > > +#if !defined(_TRACE_MEMCG_H) || defined(TRACE_HEADER_MULTI_READ)
> > > +#define _TRACE_MEMCG_H
> > > +
> > > +#include <linux/memcontrol.h>
> > > +#include <linux/tracepoint.h>
> > > +
> > > +
> > > +DECLARE_EVENT_CLASS(memcg_rstat,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val),
> > > +
> > > +       TP_STRUCT__entry(
> > > +               __field(u64, id)
> > > +               __field(int, item)
> > > +               __field(int, val)
> > > +       ),
> > > +
> > > +       TP_fast_assign(
> > > +               __entry->id =3D cgroup_id(memcg->css.cgroup);
> > > +               __entry->item =3D item;
> > > +               __entry->val =3D val;
> > > +       ),
> > > +
> > > +       TP_printk("memcg_id=3D%llu item=3D%d val=3D%d",
> > > +                 __entry->id, __entry->item, __entry->val)
> > > +);
> > > +
> > > +DEFINE_EVENT(memcg_rstat, mod_memcg_state,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val)
> > > +);
> > > +
> > > +DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val)
> > > +);
> > > +
> > > +DEFINE_EVENT(memcg_rstat, count_memcg_events,
> > > +
> > > +       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> > > +
> > > +       TP_ARGS(memcg, item, val)
> > > +);
> > > +
> > > +
> > > +#endif /* _TRACE_MEMCG_H */
> > > +
> > > +/* This part must be outside protection */
> > > +#include <trace/define_trace.h>
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index c098fd7f5c5e..17af08367c68 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -71,6 +71,10 @@
> > >
> > >  #include <linux/uaccess.h>
> > >
> > > +#define CREATE_TRACE_POINTS
> > > +#include <trace/events/memcg.h>
> > > +#undef CREATE_TRACE_POINTS
> > > +
> > >  #include <trace/events/vmscan.h>
> > >
> > >  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
> > > @@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, =
enum memcg_stat_item idx,
> > >                 return;
> > >
> > >         __this_cpu_add(memcg->vmstats_percpu->state[i], val);
> > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val)=
);
> > > +       val =3D memcg_state_val_in_pages(idx, val);
> > > +       memcg_rstat_updated(memcg, val);
> > > +       trace_mod_memcg_state(memcg, idx, val);
> > >  }
> > >
> > >  /* idx can be of type enum memcg_stat_item or node_stat_item. */
> > > @@ -741,7 +747,9 @@ static void __mod_memcg_lruvec_state(struct lruve=
c *lruvec,
> > >         /* Update lruvec */
> > >         __this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
> > >
> > > -       memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val)=
);
> > > +       val =3D memcg_state_val_in_pages(idx, val);
> > > +       memcg_rstat_updated(memcg, val);
> > > +       trace_mod_memcg_lruvec_state(memcg, idx, val);
> > >         memcg_stats_unlock();
> > >  }
> > >
> > > @@ -832,6 +840,7 @@ void __count_memcg_events(struct mem_cgroup *memc=
g, enum vm_event_item idx,
> > >         memcg_stats_lock();
> > >         __this_cpu_add(memcg->vmstats_percpu->events[i], count);
> > >         memcg_rstat_updated(memcg, count);
> > > +       trace_count_memcg_events(memcg, idx, count);
> >
> > count here is an unsigned long, and we are casting it to int, right?
> >
> > Would it be slightly better if the tracepoint uses a long instead of
> > int? It's still not ideal but probably better than int.
> >
>
> Do you mean something line the following? If this looks good to you then
> we can ask Andrew to squash this in the patch.

Yes, unless you have a better way to also accommodate the unsigned
long value in __count_memcg_events().

>
>
> diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
> index 913db9aba580..37812900acce 100644
> --- a/include/trace/events/memcg.h
> +++ b/include/trace/events/memcg.h
> @@ -11,14 +11,14 @@
>
>  DECLARE_EVENT_CLASS(memcg_rstat,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val),
>
>         TP_STRUCT__entry(
>                 __field(u64, id)
>                 __field(int, item)
> -               __field(int, val)
> +               __field(long, val)
>         ),
>
>         TP_fast_assign(
> @@ -33,21 +33,21 @@ DECLARE_EVENT_CLASS(memcg_rstat,
>
>  DEFINE_EVENT(memcg_rstat, mod_memcg_state,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val)
>  );
>
>  DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val)
>  );
>
>  DEFINE_EVENT(memcg_rstat, count_memcg_events,
>
> -       TP_PROTO(struct mem_cgroup *memcg, int item, int val),
> +       TP_PROTO(struct mem_cgroup *memcg, int item, long val),
>
>         TP_ARGS(memcg, item, val)
>  );
>


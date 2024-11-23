Return-Path: <linux-kernel+bounces-418963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D389D67DD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 07:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B691D1613FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 06:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9E916B3B7;
	Sat, 23 Nov 2024 06:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CP58vpLh"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050629405
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 06:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732344453; cv=none; b=hcllgbd/xXY9/Ua7X+BlumHTkQ7X+UCjSW5CwMrno26ZwOFLGM+lBzLFoQgpp/9MC3ylKJ8X0FZW8BNo1tDo9U1JyU3nV2acGIOePdssCcWq9L+0jvyP1eMXYktWd/SrCSWdvOpVeys04b1cSB367tCTnyHheg/iFJ/V9zAaUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732344453; c=relaxed/simple;
	bh=YVACDs1RtLKGWVhnz3UkHS1/ASXsfVYyPBlgFQOfk1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AEpmQ0FczUfYHLLnYuv2Tf9c63MFhaYvx6iOj5gaZIBOMQW3BlkxUET6g70El7rse4UgAhyOXFpN2dK8AUzlobNOKB69iDGTV1kTKVNO5bPcQJBcjOrazml/uZU6CwB6Tk+xOUzAvQFP0af9rPDyx6F2po62xPwr3cVEt61WpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CP58vpLh; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d400ffb227so18914986d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732344450; x=1732949250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymgflkDUVyug1wPOQFiRQ2YqU/Q7TymF7PGNQguc3+A=;
        b=CP58vpLhPzKcFU9UN4M+xmmxcxlg8aGEHXYHZbBmmHD0sPUbI6+lgfXgj29g2x0CFP
         nAsff5HdIytDSZE9j3lLaH3r1rW18VbhR0cL6Az4hM/AvQ5pwf8Ify/9aOcpZiPEUHr9
         TZNx3wHXk0aoKF9vV2VaczCpoubFS2jyC/mIXbKXATb1zpHcwurrAABvzCd7RTDwiPzD
         ekjtlxCIzVkLtWuOVm8vDl5zKUn89WfF2gGUxo4D4Z4iT8avFelQJPN/wM5SD4I0TsAs
         0t/SU8BHnUF70c3AfifbDTgdhYq1rcr8pNVsJKisHrQwFWHzb4Ro/lXsdfRn6a059Acd
         os/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732344450; x=1732949250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymgflkDUVyug1wPOQFiRQ2YqU/Q7TymF7PGNQguc3+A=;
        b=J6YK8zvP0sYrG7qy0teIVMJ62HxKsuQQ2wiZWJiA8bst+Tc9t1tvaWgtyIpKw1VyBV
         l/YDuqutOvX8w9L8tBkCC0kHMARp8oLBDOnFWJY5zWqKLXBfd8nSphZx8VzB6RXRXHLm
         Rl//2SVI9iR+O6Ftd5UIilXqJDFyWHbNtFEfKueCOzElpBSlw69Aa556fNAd+C6GG/qS
         8tcdIHpvzk1AF8ft0650TRCfEsm1cZsGZ+vXaNyiPG9X/ozijhvjgkhYpehKjPxjSpwI
         aRLQ+f+eKU1I8i3ZEbxJpKQYK4Wp3jjS/Y364mE1Gy5OVhtm9KmyMj45FeqO8SMYlmH2
         I9zA==
X-Forwarded-Encrypted: i=1; AJvYcCVOzyxKua9s8IlcKmvImljLn+/pqTw3KrxyZHXtlFQZ5X1kBaloPrxnqxkxF/RJHqYMv7MAQZ2euHhcKh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9aZN8MZasTkFIq8Z2FBA9XBiZMnUn2S087GrBNEEySze60i5
	5orcFIfpq7zmVrZpmru1QjZejhzJuFDGT0y2kGJBHc+/t914vX3QJmWqD58EgSi+QUc46g6naML
	l98gooWIRFmGQ8B1osIsQcH0ubQcB4cYMJ4zSWUOfjeF3fLby+wI0
X-Gm-Gg: ASbGncvMPqcpcBFZODcew9oqIFCHrpSjHLtBvFp9wwPFVxTUshrOLuw3FQakFpVLgja
	Omi6d9L27XAeDW9MPN41jfqsOBb0D
X-Google-Smtp-Source: AGHT+IEkDB9TYGxxMJwZU3/JVtCFBD87cfOIXWCVX3m/odh7EtLSO0xYG3/4XTBX7kGJq+bQhEf7xk72q9otkdJWVxs=
X-Received: by 2002:a05:6214:410:b0:6d4:1bad:7405 with SMTP id
 6a1803df08f44-6d450e6a990mr87224516d6.3.1732344450249; Fri, 22 Nov 2024
 22:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123060939.169978-1-shakeel.butt@linux.dev>
In-Reply-To: <20241123060939.169978-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 22 Nov 2024 22:46:53 -0800
Message-ID: <CAJD7tkYAch4TpO0JSpjmg6k3VVw-0x_acf2P2JBveaD3mXPxgA@mail.gmail.com>
Subject: Re: [PATCH] mm: mmap_lock: optimize mmap_lock tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Axel Rasmussen <axelrasmussen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 10:10=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> We are starting to deploy mmap_lock tracepoint monitoring across our
> fleet and the early results showed that these tracepoints are consuming
> significant amount of CPUs in kernfs_path_from_node when enabled.
>
> It seems like the kernel is trying to resolved the cgroup path in the

s/resolved/resolve

> fast path of the locking code path when the tracepoints are enabled. In
> addition for some application their metrics are regressing when
> monitoring is enabled.
>
> The cgroup path resolution can be slow and should not be done in the
> fast path. Most userspace tools, like bpftrace, provides functionality
> to get the cgroup path from cgroup id, so let's just trace the cgroup
> id and the users can use better tools to get the path in the slow path.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  include/linux/memcontrol.h       | 18 ++++++++++++
>  include/trace/events/mmap_lock.h | 32 ++++++++++----------
>  mm/mmap_lock.c                   | 50 ++------------------------------
>  3 files changed, 36 insertions(+), 64 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..d82f08cd70cd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1046,6 +1046,19 @@ static inline void memcg_memory_event_mm(struct mm=
_struct *mm,
>
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>
> +static inline u64 memcg_id_from_mm(struct mm_struct *mm)

The usage of memcg_id here and throughout the patch is a bit confusing
because we have a member called 'id' in struct mem_cgroup, but this
isn't it. This is the cgroup_id of the memcg. I admit it's hard to
distinguish them during naming, but when I first saw the function I
thought it was returning memcg->id.

Maybe just cgroup_id_from_mm()? In cgroup v2, the cgroup id is the
same regardless of the controller anyway, in cgroup v1, it's kinda
natural that we return the cgroup id of the memcg.

I don't feel strongly, but I prefer that we use clearer naming, and
either way a comment may help clarify things.

> +{
> +       struct mem_cgroup *memcg;
> +       u64 id =3D 0;
> +
> +       rcu_read_lock();
> +       memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
> +       if (likely(memcg))
> +               id =3D cgroup_id(memcg->css.cgroup);

We return 0 if the memcg is NULL here, shouldn't we return the cgroup
id of the root memcg instead? This is more consistent with
get_mem_cgroup_from_mm(), and makes sure we always return the id of a
valid cgroup.

> +       rcu_read_unlock();
> +       return id;
> +}
> +
>  #else /* CONFIG_MEMCG */
>
>  #define MEM_CGROUP_ID_SHIFT    0
> @@ -1466,6 +1479,11 @@ void count_memcg_event_mm(struct mm_struct *mm, en=
um vm_event_item idx)
>  static inline void split_page_memcg(struct page *head, int old_order, in=
t new_order)
>  {
>  }
> +
> +static inline u64 memcg_id_from_mm(struct mm_struct *mm)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_MEMCG */
>
>  /*
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap=
_lock.h
> index bc2e3ad787b3..5529933d19c5 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -5,6 +5,7 @@
>  #if !defined(_TRACE_MMAP_LOCK_H) || defined(TRACE_HEADER_MULTI_READ)
>  #define _TRACE_MMAP_LOCK_H
>
> +#include <linux/memcontrol.h>
>  #include <linux/tracepoint.h>
>  #include <linux/types.h>
>
> @@ -12,64 +13,61 @@ struct mm_struct;
>
>  DECLARE_EVENT_CLASS(mmap_lock,
>
> -       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write=
),
> +       TP_PROTO(struct mm_struct *mm, bool write),
>
> -       TP_ARGS(mm, memcg_path, write),
> +       TP_ARGS(mm, write),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
> -               __string(memcg_path, memcg_path)
> +               __field(u64, memcg_id)
>                 __field(bool, write)
>         ),
>
>         TP_fast_assign(
>                 __entry->mm =3D mm;
> -               __assign_str(memcg_path);
> +               __entry->memcg_id =3D memcg_id_from_mm(mm);
>                 __entry->write =3D write;
>         ),
>
>         TP_printk(
> -               "mm=3D%p memcg_path=3D%s write=3D%s",
> -               __entry->mm,
> -               __get_str(memcg_path),
> +               "mm=3D%p memcg_id=3D%llu write=3D%s",
> +               __entry->mm, __entry->memcg_id,
>                 __entry->write ? "true" : "false"
>         )
>  );
>
>  #define DEFINE_MMAP_LOCK_EVENT(name)                                    =
\
>         DEFINE_EVENT(mmap_lock, name,                                   \
> -               TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> -                       bool write),                                    \
> -               TP_ARGS(mm, memcg_path, write))
> +               TP_PROTO(struct mm_struct *mm, bool write),             \
> +               TP_ARGS(mm, write))
>
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
>
>  TRACE_EVENT(mmap_lock_acquire_returned,
>
> -       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write=
,
> -               bool success),
> +       TP_PROTO(struct mm_struct *mm, bool write, bool success),
>
> -       TP_ARGS(mm, memcg_path, write, success),
> +       TP_ARGS(mm, write, success),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
> -               __string(memcg_path, memcg_path)
> +               __field(u64, memcg_id)
>                 __field(bool, write)
>                 __field(bool, success)
>         ),
>
>         TP_fast_assign(
>                 __entry->mm =3D mm;
> -               __assign_str(memcg_path);
> +               __entry->memcg_id =3D memcg_id_from_mm(mm);
>                 __entry->write =3D write;
>                 __entry->success =3D success;
>         ),
>
>         TP_printk(
> -               "mm=3D%p memcg_path=3D%s write=3D%s success=3D%s",
> +               "mm=3D%p memcg_id=3D%llu write=3D%s success=3D%s",
>                 __entry->mm,
> -               __get_str(memcg_path),
> +               __entry->memcg_id,
>                 __entry->write ? "true" : "false",
>                 __entry->success ? "true" : "false"
>         )
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index f186d57df2c6..e7dbaf96aa17 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -17,51 +17,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_start_locking);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_acquire_returned);
>  EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
>
> -#ifdef CONFIG_MEMCG
> -
> -/*
> - * Size of the buffer for memcg path names. Ignoring stack trace support=
,
> - * trace_events_hist.c uses MAX_FILTER_STR_VAL for this, so we also use =
it.
> - */
> -#define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                           \
> -       do {                                                            \
> -               if (trace_mmap_lock_##type##_enabled()) {               \
> -                       char buf[MEMCG_PATH_BUF_SIZE];                  \
> -                       get_mm_memcg_path(mm, buf, sizeof(buf));        \
> -                       trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
> -               }                                                       \
> -       } while (0)
> -
> -#else /* !CONFIG_MEMCG */
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                            =
       \
> -       trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> -
> -#endif /* CONFIG_MEMCG */
> -
>  #ifdef CONFIG_TRACING
> -#ifdef CONFIG_MEMCG
> -/*
> - * Write the given mm_struct's memcg path to a buffer. If the path canno=
t be
> - * determined, empty string is written.
> - */
> -static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t bu=
flen)
> -{
> -       struct mem_cgroup *memcg;
> -
> -       buf[0] =3D '\0';
> -       memcg =3D get_mem_cgroup_from_mm(mm);
> -       if (memcg =3D=3D NULL)
> -               return;
> -       if (memcg->css.cgroup)
> -               cgroup_path(memcg->css.cgroup, buf, buflen);
> -       css_put(&memcg->css);
> -}
> -
> -#endif /* CONFIG_MEMCG */
> -
>  /*
>   * Trace calls must be in a separate file, as otherwise there's a circul=
ar
>   * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> @@ -69,20 +25,20 @@ static void get_mm_memcg_path(struct mm_struct *mm, c=
har *buf, size_t buflen)
>
>  void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write=
)
>  {
> -       TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
> +       trace_mmap_lock_start_locking(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
>
>  void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool wr=
ite,
>                                            bool success)
>  {
> -       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +       trace_mmap_lock_acquire_returned(mm, write, success);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
>
>  void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
>  {
> -       TRACE_MMAP_LOCK_EVENT(released, mm, write);
> +       trace_mmap_lock_released(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #endif /* CONFIG_TRACING */
> --
> 2.43.5
>
>


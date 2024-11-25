Return-Path: <linux-kernel+bounces-421582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2489D8D10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947E228D944
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E961C174E;
	Mon, 25 Nov 2024 19:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxYjr1ix"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D71CDA05
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564342; cv=none; b=ZLQDG02mPEoFMLQ9AE4yadzH1oRRR+/ndjFaAdj6xiPxVq768l+IkNWlFM1WJJz2JBxGa0gF3OLb3M9hSxLn9Ovv8Ib5MOW0Zp++u8ka9tBqEKj9KeSXb4n/+07d/Eg5ti0mgyd7fUR/XvHAI5un3EuN137BaBgfTObkWDjgPS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564342; c=relaxed/simple;
	bh=HfM3V2n4+o1oWCq9CctlkfFe192VofPIZEj9AaKTu4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ug2ooU2sQDnN2hdtMrXtKWJ6fBgxrLC6YurzgR+1ItT7WE60qtGH3B+BWhjs1/Aks8gxT75pZy3NYdNoDGNFhhs1FRTYOcl3OE/d3GkS3aeAaN0NhIKQZvSmO3e7wvKEJ+3aeq2gYSQ8jQ+YJCNMibfH5dme4N70OvyxBHv53cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxYjr1ix; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea053b5929so38768837b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564338; x=1733169138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mne9TnxCPP2fm/4106chmuJnI2d9LCsaAMO9TCov5uc=;
        b=GxYjr1ix9Lr+JCqse+sizOME3zUDCE0Gr15ob/otc0Ck6hihJaoxcvmGU0WThawuDC
         vqiGBM2yz4Zd6Zn5jsT+MY0IHguRrdPsbERzaVHjrdP2OyZdeeNOeLt6NHV/U18uHl0T
         zIyWj88UL6zZMm4SE4QHMuBNRqIrEvcoBg26q4/uf8s/L6EJM52laSma/jlmLWQ3yt2X
         Vc1OIQl4o6AKNrqO9m6NvnUq1j1cqGU6dw9tElpuFOt/TyWZhYz+Q9FWgYjbhN0sd9hm
         5JL89PtMFspqQ6nDLnRu6D4RgE0HYKQhTfweAX0BslboizBo5V6FNfqbPZZTgHN/OtLo
         GwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564338; x=1733169138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mne9TnxCPP2fm/4106chmuJnI2d9LCsaAMO9TCov5uc=;
        b=JcYdF3R6aplTGCS1apTosnZBbmwqEqQpM38DEapHDNI9gGj4nW2XzXNO8KSY/DuT9A
         v9eILEeQlaDkzI79XIt8jpCbcdYrL2x+KvdXYgnIN6AEdY5hY0sVJriSbgMbMBKYY0F8
         ORYYv8MJg6RGRI5p2HXfLdu9H8kvwzjBMGFd1VA84ZW6i4YUGkmsF1fvW784CSxA2wf5
         ffqmdZrAEGgT+yd4v0YAKdGvaA/9dP/TM7YPADf689SKZFl663xCpaxVD0OXVK8ehWAt
         eEkcTE0Qli8B1Nz2ByB+6wbNxZLF0nAjP8I53Q0XcFfquaS/1J5Z/f7wGgwqhB5plxY+
         k2IA==
X-Forwarded-Encrypted: i=1; AJvYcCXC8l4fYGXFqVtEl/78qtfs6RZUzTDWJJhTrQ9PnqV0cvfOvGrXbEd21SFFE2zcPC3nHGbolhuAhtCdVoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpiZ8xM+Msilyw4GMypuuL5a3rvb0Z+tU3SMKHAbENgC/7H0Y
	/op66ah69Xh5/yaib81LcFK+U8BQ/IMv/akpbCipbUXreYjH0M2A2P2G2VRmBQbkJSUn7G71jQK
	+juwh4hDI+Zb19iJf/fDn9vFcgNwI4CSn19hZ
X-Gm-Gg: ASbGncsUgM0VrswoxPvE6fTdmjr0UPPzhJwPq/qKazysh42NqqDFNXh7/yawP9QZGWj
	RsQKKBE6L9sOM9Svn/70+z4B5rx5BE8yrWPfuoXbwx1mxKw1EZKGvTDh8FLBlug==
X-Google-Smtp-Source: AGHT+IHmCrrVRu68GQphwJ7BbRlO6PPSA+ohYN9FNXBSxIiNptZk+ncdZDsbIU3cNZCqTtKbpWvr76w7HALzW8miY5o=
X-Received: by 2002:a05:690c:7085:b0:6ea:7d88:ae3f with SMTP id
 00721157ae682-6eee08c3ed1mr137907717b3.17.1732564338195; Mon, 25 Nov 2024
 11:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125171617.113892-1-shakeel.butt@linux.dev>
In-Reply-To: <20241125171617.113892-1-shakeel.butt@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 25 Nov 2024 11:51:41 -0800
Message-ID: <CAJD7tkZM+=Ju7NGs=K7BGaErM=_yDjOHLt_-pp2=NzAior18=Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: mmap_lock: optimize mmap_lock tracepoints
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, 
	Axel Rasmussen <axelrasmussen@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 9:16=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> We are starting to deploy mmap_lock tracepoint monitoring across our
> fleet and the early results showed that these tracepoints are consuming
> significant amount of CPUs in kernfs_path_from_node when enabled.
>
> It seems like the kernel is trying to resolve the cgroup path in the
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

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>
> Changes since v1:
> - Fixed commit message (Yosry).
> - Renamed memcg_id_from_mm to cgroup_id_from_mm (Yosry).
> - Fixed handling of root memcg (Yosry).
> - Fixed mem_cgroup_disabled() handling.
> - Kept mm pointer printing based on Steven's feedback.
>
>  include/linux/memcontrol.h       | 22 ++++++++++++++
>  include/trace/events/mmap_lock.h | 32 ++++++++++----------
>  mm/mmap_lock.c                   | 50 ++------------------------------
>  3 files changed, 40 insertions(+), 64 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 5502aa8e138e..b28180269e75 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1046,6 +1046,23 @@ static inline void memcg_memory_event_mm(struct mm=
_struct *mm,
>
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>
> +static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
> +{
> +       struct mem_cgroup *memcg;
> +       u64 id;
> +
> +       if (mem_cgroup_disabled())
> +               return 0;
> +
> +       rcu_read_lock();
> +       memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));
> +       if (!memcg)
> +               memcg =3D root_mem_cgroup;
> +       id =3D cgroup_id(memcg->css.cgroup);
> +       rcu_read_unlock();
> +       return id;
> +}
> +
>  #else /* CONFIG_MEMCG */
>
>  #define MEM_CGROUP_ID_SHIFT    0
> @@ -1466,6 +1483,11 @@ void count_memcg_event_mm(struct mm_struct *mm, en=
um vm_event_item idx)
>  static inline void split_page_memcg(struct page *head, int old_order, in=
t new_order)
>  {
>  }
> +
> +static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_MEMCG */
>
>  /*
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap=
_lock.h
> index bc2e3ad787b3..cf9f9faf8914 100644
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
> +               __entry->memcg_id =3D cgroup_id_from_mm(mm);
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
> +               __entry->memcg_id =3D cgroup_id_from_mm(mm);
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


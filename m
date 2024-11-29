Return-Path: <linux-kernel+bounces-421444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CB39D8B62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778C1281E30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99C186E59;
	Mon, 25 Nov 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukwktytr"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ACB14D43D;
	Mon, 25 Nov 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732556064; cv=none; b=L0POKysSpK5LGP+OtrZPXZjD2USiDY/LoH6Qtkg9ceu+7G6l/X/V9sXPYFXo6LesR+Gj3VFeI/wVvDkJs+UAt3gjHy9H+A83KxiUr8p08efXQEhzTtP/xu/oke4YURT9fv3ZIugJXqzatWubKNwUrEHXnHTw+hB+E3dfBhMY3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732556064; c=relaxed/simple;
	bh=t58KL/L6a6BeJD/yzhQzpSW1kLBIuI7w0W9DzZ8zdvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTYA5Ufkqx4q1rC4GwMily7pga/p2fpoQdkZpF6AcpIPE5PHH8FVLTfzUDsxzG3KEHtiN2JLmz76gVOdMUbb4yqdhNDm9LPb5qr2j3cf86wQkYS9sgMlIUZGRRKDfDF38y3MSPRVpD2kqFuaQV6zUem94tHlXhceUV7ItogeDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukwktytr; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Nov 2024 09:34:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732556059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftws9Jc/aR17pFgSNeoO8CO9UsEIAO0k+/pFLC677oE=;
	b=ukwktytrjn5qnXmZos9eCGwRbqIB0fvZHlKjQFq0Q36UgKav2F5kFr3C4h1klSzZcCZ4jn
	aRouhGF0YhcZrMFcnJcXYAfTUBQwRP1t18e1gyRNscq4CFuSpjioG0nItIjrxfP2wD2y5b
	bKIc3qXG+liJHPy+/ROdc/sH2Ak6frs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Axel Rasmussen <axelrasmussen@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH v2] mm: mmap_lock: optimize mmap_lock tracepoints
Message-ID: <oi4axinfi7ix6iyrll3wloamdcywpiieneqwjh6fzt52rtkp4s@i2xz6nrurktt>
References: <20241125171617.113892-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125171617.113892-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

Cc Yosry.

On Mon, Nov 25, 2024 at 09:16:17AM -0800, Shakeel Butt wrote:
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
> @@ -1046,6 +1046,23 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  
>  void split_page_memcg(struct page *head, int old_order, int new_order);
>  
> +static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
> +{
> +	struct mem_cgroup *memcg;
> +	u64 id;
> +
> +	if (mem_cgroup_disabled())
> +		return 0;
> +
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
> +	if (!memcg)
> +		memcg = root_mem_cgroup;
> +	id = cgroup_id(memcg->css.cgroup);
> +	rcu_read_unlock();
> +	return id;
> +}
> +
>  #else /* CONFIG_MEMCG */
>  
>  #define MEM_CGROUP_ID_SHIFT	0
> @@ -1466,6 +1483,11 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  static inline void split_page_memcg(struct page *head, int old_order, int new_order)
>  {
>  }
> +
> +static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_MEMCG */
>  
>  /*
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
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
> -	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
> +	TP_PROTO(struct mm_struct *mm, bool write),
>  
> -	TP_ARGS(mm, memcg_path, write),
> +	TP_ARGS(mm, write),
>  
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
> -		__string(memcg_path, memcg_path)
> +		__field(u64, memcg_id)
>  		__field(bool, write)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__assign_str(memcg_path);
> +		__entry->memcg_id = cgroup_id_from_mm(mm);
>  		__entry->write = write;
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s",
> -		__entry->mm,
> -		__get_str(memcg_path),
> +		"mm=%p memcg_id=%llu write=%s",
> +		__entry->mm, __entry->memcg_id,
>  		__entry->write ? "true" : "false"
>  	)
>  );
>  
>  #define DEFINE_MMAP_LOCK_EVENT(name)                                    \
>  	DEFINE_EVENT(mmap_lock, name,                                   \
> -		TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> -			bool write),                                    \
> -		TP_ARGS(mm, memcg_path, write))
> +		TP_PROTO(struct mm_struct *mm, bool write),		\
> +		TP_ARGS(mm, write))
>  
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
>  
>  TRACE_EVENT(mmap_lock_acquire_returned,
>  
> -	TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> -		bool success),
> +	TP_PROTO(struct mm_struct *mm, bool write, bool success),
>  
> -	TP_ARGS(mm, memcg_path, write, success),
> +	TP_ARGS(mm, write, success),
>  
>  	TP_STRUCT__entry(
>  		__field(struct mm_struct *, mm)
> -		__string(memcg_path, memcg_path)
> +		__field(u64, memcg_id)
>  		__field(bool, write)
>  		__field(bool, success)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->mm = mm;
> -		__assign_str(memcg_path);
> +		__entry->memcg_id = cgroup_id_from_mm(mm);
>  		__entry->write = write;
>  		__entry->success = success;
>  	),
>  
>  	TP_printk(
> -		"mm=%p memcg_path=%s write=%s success=%s",
> +		"mm=%p memcg_id=%llu write=%s success=%s",
>  		__entry->mm,
> -		__get_str(memcg_path),
> +		__entry->memcg_id,
>  		__entry->write ? "true" : "false",
>  		__entry->success ? "true" : "false"
>  	)
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
> - * Size of the buffer for memcg path names. Ignoring stack trace support,
> - * trace_events_hist.c uses MAX_FILTER_STR_VAL for this, so we also use it.
> - */
> -#define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)				\
> -	do {								\
> -		if (trace_mmap_lock_##type##_enabled()) {		\
> -			char buf[MEMCG_PATH_BUF_SIZE];                  \
> -			get_mm_memcg_path(mm, buf, sizeof(buf));        \
> -			trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
> -		}							\
> -	} while (0)
> -
> -#else /* !CONFIG_MEMCG */
> -
> -#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
> -	trace_mmap_lock_##type(mm, "", ##__VA_ARGS__)
> -
> -#endif /* CONFIG_MEMCG */
> -
>  #ifdef CONFIG_TRACING
> -#ifdef CONFIG_MEMCG
> -/*
> - * Write the given mm_struct's memcg path to a buffer. If the path cannot be
> - * determined, empty string is written.
> - */
> -static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
> -{
> -	struct mem_cgroup *memcg;
> -
> -	buf[0] = '\0';
> -	memcg = get_mem_cgroup_from_mm(mm);
> -	if (memcg == NULL)
> -		return;
> -	if (memcg->css.cgroup)
> -		cgroup_path(memcg->css.cgroup, buf, buflen);
> -	css_put(&memcg->css);
> -}
> -
> -#endif /* CONFIG_MEMCG */
> -
>  /*
>   * Trace calls must be in a separate file, as otherwise there's a circular
>   * dependency between linux/mmap_lock.h and trace/events/mmap_lock.h.
> @@ -69,20 +25,20 @@ static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
>  
>  void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
>  {
> -	TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
> +	trace_mmap_lock_start_locking(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
>  
>  void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
>  					   bool success)
>  {
> -	TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +	trace_mmap_lock_acquire_returned(mm, write, success);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
>  
>  void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
>  {
> -	TRACE_MMAP_LOCK_EVENT(released, mm, write);
> +	trace_mmap_lock_released(mm, write);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #endif /* CONFIG_TRACING */
> -- 
> 2.43.5
> 


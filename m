Return-Path: <linux-kernel+bounces-256842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB41937121
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EBCBB21CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF414659C;
	Thu, 18 Jul 2024 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VeCX3KMg"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592461DA3D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721345795; cv=none; b=LIXpxUDC9jEoZ5kjBDKpFksYomV8Z6TwBb5rpj+e/DoZF0b1XTvjhpf+ioNmoNLPtEUtuDXx9R7H4qmK+uCxGp4Cdzdpa/urvQt0RpH+r7zCnnSLgbEZnrOmTqf4XpI8A8ZsJeXUfQopcSkzbaVQNb5297D62M2/pXW8hvnd/tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721345795; c=relaxed/simple;
	bh=rQb0vw+KePVNByiaAlh0PfcHeT+81YTip37CSWknuEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUpobw8vR7gBgA/aWP4sEIKw0d0hUWqUiYnfMyRZ5e2LkXPcxV18CZmotMvhOb4kMgmb8l0TePhY0PB7EClJbHdj4xzMUPKV65YZhOQo8QIlIZiynK7WJle427PscYvv9etYT0khJ69efcBDddZW08z6hTHaG+1E3mhGkCmmIHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VeCX3KMg; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: pasha.tatashin@soleen.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721345789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXn2FMIulOwKD/dALcoO2d1mEEwa00LIGNe5/0vkHoU=;
	b=VeCX3KMgX0CuiqZf0yZa2vq1WIblArijXqPIWIeh5DnwvrsEEM2X3OBk0RDAf3iOYK2yZJ
	JTJJGeYcnZoo4iIunkNjglFfL0qt0epTJmBvCy8UZq2Cvdq2hTzoScnYVNoaz2UjFcWopo
	31RHe1a3pEEspzgCGX5vBbd782zoH0E=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: jpoimboe@kernel.org
X-Envelope-To: kent.overstreet@linux.dev
X-Envelope-To: peterz@infradead.org
X-Envelope-To: nphamcs@gmail.com
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: surenb@google.com
X-Envelope-To: lizhijian@fujitsu.com
X-Envelope-To: willy@infradead.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: ziy@nvidia.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Date: Thu, 18 Jul 2024 16:36:19 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, jpoimboe@kernel.org, 
	kent.overstreet@linux.dev, peterz@infradead.org, nphamcs@gmail.com, 
	cerasuolodomenico@gmail.com, surenb@google.com, lizhijian@fujitsu.com, willy@infradead.org, 
	vbabka@suse.cz, ziy@nvidia.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] vmstat: Kernel stack usage histogram
Message-ID: <2fbbxcsjs7vtzpb6a5wudbppcr2wgc2xwdw3cgs6ejzx6rioze@z2sct6rbulng>
References: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718202611.1695164-1-pasha.tatashin@soleen.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Jul 18, 2024 at 08:26:11PM GMT, Pasha Tatashin wrote:
[...]
> diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
> index ccd72b978e1f..65e8c9fb7f9b 100644
> --- a/include/linux/sched/task_stack.h
> +++ b/include/linux/sched/task_stack.h
> @@ -95,9 +95,51 @@ static inline int object_is_on_stack(const void *obj)
>  extern void thread_stack_cache_init(void);
>  
>  #ifdef CONFIG_DEBUG_STACK_USAGE
> +#ifdef CONFIG_VM_EVENT_COUNTERS
> +#include <linux/vm_event_item.h>
> +
> +/* Count the maximum pages reached in kernel stacks */
> +static inline void kstack_histogram(unsigned long used_stack)

Any specific reason to add this function in header?

> +{
> +	if (used_stack <= 1024)
> +		this_cpu_inc(vm_event_states.event[KSTACK_1K]);

Why not count_vm_event(KSTACK_1K)? Avoiding header include recursion?

> +#if THREAD_SIZE > 1024
> +	else if (used_stack <= 2048)
> +		this_cpu_inc(vm_event_states.event[KSTACK_2K]);
> +#endif
> +#if THREAD_SIZE > 2048
> +	else if (used_stack <= 4096)
> +		this_cpu_inc(vm_event_states.event[KSTACK_4K]);
> +#endif
> +#if THREAD_SIZE > 4096
> +	else if (used_stack <= 8192)
> +		this_cpu_inc(vm_event_states.event[KSTACK_8K]);
> +#endif
> +#if THREAD_SIZE > 8192
> +	else if (used_stack <= 16384)
> +		this_cpu_inc(vm_event_states.event[KSTACK_16K]);
> +#endif
> +#if THREAD_SIZE > 16384
> +	else if (used_stack <= 32768)
> +		this_cpu_inc(vm_event_states.event[KSTACK_32K]);
> +#endif
> +#if THREAD_SIZE > 32768
> +	else if (used_stack <= 65536)
> +		this_cpu_inc(vm_event_states.event[KSTACK_64K]);
> +#endif
> +#if THREAD_SIZE > 65536
> +	else
> +		this_cpu_inc(vm_event_states.event[KSTACK_REST]);
> +#endif
> +}
> +#else /* !CONFIG_VM_EVENT_COUNTERS */
> +static inline void kstack_histogram(unsigned long used_stack) {}
> +#endif /* CONFIG_VM_EVENT_COUNTERS */
> +
>  static inline unsigned long stack_not_used(struct task_struct *p)
>  {
>  	unsigned long *n = end_of_stack(p);
> +	unsigned long unused_stack;
>  
>  	do { 	/* Skip over canary */
>  # ifdef CONFIG_STACK_GROWSUP
> @@ -108,10 +150,13 @@ static inline unsigned long stack_not_used(struct task_struct *p)
>  	} while (!*n);
>  
>  # ifdef CONFIG_STACK_GROWSUP
> -	return (unsigned long)end_of_stack(p) - (unsigned long)n;
> +	unused_stack = (unsigned long)end_of_stack(p) - (unsigned long)n;
>  # else
> -	return (unsigned long)n - (unsigned long)end_of_stack(p);
> +	unused_stack = (unsigned long)n - (unsigned long)end_of_stack(p);
>  # endif
> +	kstack_histogram(THREAD_SIZE - unused_stack);
> +
> +	return unused_stack;
>  }
>  #endif
>  extern void set_task_stack_end_magic(struct task_struct *tsk);



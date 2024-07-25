Return-Path: <linux-kernel+bounces-262669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A393CA51
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 23:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54C91C2206A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 21:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762C91422D4;
	Thu, 25 Jul 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="H5WV/fFU"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2971C6BE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943756; cv=none; b=Ty/9iQfjkjJyN3+3+TXgzCa6uejS9XBVoNiTLUMWnNZkXaR6XBLhFkkW3S1aEACCKDM608we36RnVWuZiMj77cmZrg3vmqzOVfkd+T0n4IU+SzAVU7+kE07wqn4eJ2V7l6b2NAZB38izRqq1JNlk5XZYm+o5YRIo0dfZTSb5QVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943756; c=relaxed/simple;
	bh=w/JpMMIh01WhZ68h17l0vVdYdvI4cPpNmK7mot+LhNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgvmmJKqzzp8HYoQUJB/uBWQdllrs6I1RqNpV+HHA/lhe5FYhz4u2965+SGWYWeqIt2KQ9s21efINsp+w3nJ129uBb0EbIUG6imIHO9B3ACkdX0sSrcx9Rtu87zO4XE36mhl9aeufIhClVLMNYaCrtOsSLExqTfnD9cl/95n/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=H5WV/fFU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7b28442f9so238696d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721943752; x=1722548552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JUNNKtqHZbxwfAx7HOnTg7aMz1aKTG+IkoHsU1G/oG4=;
        b=H5WV/fFUWdM2OBV0BLZRRAo2kJXT1cBWMIN1rLO9aEVqqPgUCGeqCw04ibTIAxou3t
         ph9jTShZBr5z/iVb0oIEK7OVcp5u6QE780V/VgZRh+9+isvDH1WOpT/hC3hS2/E0z3up
         q6OpxsazTCEsDUHI7gPW+R2qeIfXLrdcUNTs09L65kqVKOhpb2/cQqNYJVRsIcOvpk6n
         PpT3bdKEJy89Z3q2LbWdxAmqBIsolIgxAGmgrPM5e4LFZCYHVENsTwNlsCMYehULAXyY
         7ZmuNYaYXM5IXTCqnjAk1Zj6ardlY3k6ygBsa7rMuinpiq6Z8aLzWCpiwFDt5wXMQ8g/
         EWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943752; x=1722548552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUNNKtqHZbxwfAx7HOnTg7aMz1aKTG+IkoHsU1G/oG4=;
        b=o7YwcJciJmVVYGSsQHui3sWrAXnuDEfvelkr6ejzHNO4+PPNd3VgLiw3Cac/y2zQMI
         TeP1T+Rrs+7AD4qHJ54kbL/4gQ9qgGz4fYNL4RXuvgyFQa6Xb01d7Ks5mfgydCp3BYfm
         97IalWg5CVIkqZKx6K8MsDE1GP6NnQxjMrYiO+Lno61OBhLCBKE3/EJM/cV2z/Cg/LlI
         WEqOzV5C6qa7nL3zgVP1l2eeDvH3sqMJ1DSpDKe5SvEGxIJ+s1oJ6hYOaoeE/tkbIWlN
         pohwIbTwDXb5WQ2xdimYdA9dx5rsY42qq3VScJoQODkxOYSeaBRfZXYTQKRYt7TbnxsB
         /hpw==
X-Forwarded-Encrypted: i=1; AJvYcCVJpRkfL7rrYV74mQELw0r9eF+SWu+6uhkb+ZQlnR5tHUimLeY5bKtD9E/NplTdRCiTttYyXdmhZiDdu5aQNMpIF7i60dUwQiuXuM9a
X-Gm-Message-State: AOJu0YyyY8hRX6ArHkY1vdWmx3TwUW/sIORjUJi8fDh6y0LxHRw8WR/K
	QkQ7ywvPV8E4J0nVJh7OKGybuJObC42qaUxNGY/p1Ga755DtAX02a69XxRc/u1w=
X-Google-Smtp-Source: AGHT+IFu2YtwJBnJ95W0WxuO+SmfkJkFUWVBgTkLY+R2I9ra50FAos4fu+qCOCY8imKGfO9mdUJ9Ew==
X-Received: by 2002:a05:6214:c6b:b0:6b7:4298:2c75 with SMTP id 6a1803df08f44-6bb408c8cf0mr29487846d6.55.1721943752414;
        Thu, 25 Jul 2024 14:42:32 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa9bcabsm10912776d6.95.2024.07.25.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:42:32 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:42:27 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 3/5] mm: memcg: merge multiple page_counters into a
 single structure
Message-ID: <20240725214227.GC1702603@cmpxchg.org>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-4-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-4-roman.gushchin@linux.dev>

On Wed, Jul 24, 2024 at 08:21:01PM +0000, Roman Gushchin wrote:
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -5,14 +5,71 @@
>  #include <linux/atomic.h>
>  #include <linux/cache.h>
>  #include <linux/limits.h>
> +#include <linux/mm_types.h>
>  #include <asm/page.h>
>  
> +/*
> + * Page counters are used by memory and hugetlb cgroups.
> + * Memory cgroups are using up to 4 separate counters:
> + * memory, swap (memory + swap on cgroup v1), kmem and tcpmem.
> + * Hugetlb cgroups are using 2 arrays of counters with HUGE_MAX_HSTATE
> + * in each to track the usage and reservations of each supported
> + * hugepage size.
> + *
> + * Protection (min/low) is supported only for the first counter
> + * with idx 0 and only if the counter was initialized with the protection
> + * support.
> + */
> +
> +enum mem_counter_type {
> +#ifdef CONFIG_MEMCG
> +	/* Unified memory counter */
> +	MCT_MEM,
> +
> +	/* Swap */
> +	MCT_SWAP,
> +
> +	/* Memory + swap */
> +	MCT_MEMSW = MCT_SWAP,
> +
> +#ifdef CONFIG_MEMCG_V1
> +	/* Kernel memory */
> +	MCT_KMEM,
> +
> +	/* Tcp memory */
> +	MCT_TCPMEM,
> +#endif /* CONFIG_MEMCG_V1 */
> +#endif /* CONFIG_MEMCG */
> +
> +	/* Maximum number of memcg counters */
> +	MCT_NR_MEMCG_ITEMS,
> +};
> +
> +#ifdef CONFIG_CGROUP_HUGETLB
> +#ifdef HUGE_MAX_HSTATE
> +#define MCT_NR_HUGETLB_ITEMS HUGE_MAX_HSTATE
> +#else
> +#define MCT_NR_HUGETLB_ITEMS 1
> +#endif
> +
> +/*
> + * max() can't be used here: even though __builtin_choose_expr() evaluates
> + * to true, the false clause generates a compiler error:
> + * error: braced-group within expression allowed only inside a function .
> + */
> +#define MCT_NR_ITEMS (__builtin_choose_expr(MCT_NR_MEMCG_ITEMS > MCT_NR_HUGETLB_ITEMS, \
> +					    MCT_NR_MEMCG_ITEMS, MCT_NR_HUGETLB_ITEMS))
> +
> +#else /* CONFIG_CGROUP_HUGETLB */
> +#define MCT_NR_ITEMS MCT_NR_MEMCG_ITEMS
> +#endif /* CONFIG_CGROUP_HUGETLB */
> +
>  struct page_counter {
>  	/*
>  	 * Make sure 'usage' does not share cacheline with any other field. The
>  	 * memcg->memory.usage is a hot member of struct mem_cgroup.
>  	 */
> -	atomic_long_t usage;
> +	atomic_long_t usage[MCT_NR_ITEMS];
>  	CACHELINE_PADDING(_pad1_);
>  
>  	/* effective memory.min and memory.min usage tracking */
> @@ -25,9 +82,9 @@ struct page_counter {
>  	atomic_long_t low_usage;
>  	atomic_long_t children_low_usage;
>  
> -	unsigned long watermark;
> -	unsigned long local_watermark; /* track min of fd-local resets */
> -	unsigned long failcnt;
> +	unsigned long watermark[MCT_NR_ITEMS];
> +	unsigned long local_watermark[MCT_NR_ITEMS]; /* track min of fd-local resets */
> +	unsigned long failcnt[MCT_NR_ITEMS];
>  
>  	/* Keep all the read most fields in a separete cacheline. */
>  	CACHELINE_PADDING(_pad2_);
> @@ -35,8 +92,9 @@ struct page_counter {
>  	bool protection_support;
>  	unsigned long min;
>  	unsigned long low;
> -	unsigned long high;
> -	unsigned long max;
> +	unsigned long high[MCT_NR_ITEMS];
> +	unsigned long max[MCT_NR_ITEMS];
> +
>  	struct page_counter *parent;
>  } ____cacheline_internodealigned_in_smp;

This hardcodes way too much user specifics into what should be a
self-contained piece of abstraction. Should anybody else try to use
the 'struct page_counter' for a single resource elsewhere, they'd end
up with up to 5 counters, watermarks, failcnts, highs and maxs etc.

It's clear that the hierarchical aspect of the page_counter no longer
works. It was okay-ish when all we had was a simple hard limit. Now we
carry to much stuff in it that is only useful to a small set of users.

Instead of doubling down and repeating the mistakes we made for struct
page, it would be better to move user specific stuff out of it
entirely. I think there are two patterns that would be more natural:
a) pass a callback function and have a priv pointer in page_counter
for user-specifics; or b) remove the hierarchy aspect from the page
counter entirely, let the *caller* walk the tree, call the page
counter code to trycharge (and log watermark) only that level, and
handle everything caller specific on the caller side.

All users already have parent linkage in the css, so this would
eliminate the parent pointer in page_counter altogether.

The protection stuff could be moved to memcg proper, eliminating yet
more fields that aren't interesting to any other user.

You'd save more memory, while at the same time keeping struct
page_counter clean and generic.


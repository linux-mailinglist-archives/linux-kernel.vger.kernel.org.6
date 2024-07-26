Return-Path: <linux-kernel+bounces-263048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E91D893D04F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187051C20FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DD1741DA;
	Fri, 26 Jul 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dtOYh3Xs"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261B6116
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721985480; cv=none; b=bCOtthYsmBnQhwCj/6Sq1kRuHmwvavzsziQkso0i+0JO8IUiUSgzXHuueVoW/JJ4huHIh3SekJNullzFNxUJfExqJGXMHIBolJOr69SAwfoGtQnGY16Zsl6andF2cl2UYBpcWLEyOFnz0x4f0f68agkmUvOWViDMniFhUq1UYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721985480; c=relaxed/simple;
	bh=/AeXsGKnw1kl7XaCWtUv+LJres2nLQGiHlSDKKacJa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhbbdMqjurX1tOTsmS1euaH95/BDp7YdlgAedf/zY5zUcLFQdhCqryR9mgo0llfEXb1HaIXefZj3mXwFFDQzRmEpC8CwFK1xaF11R2zjYqrZZoRgHHesYodSwH6Km/+VU4pPu4QOxw8JPKQrj8XU/Hp5iH3WQ6UnQMYxP12Lu98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dtOYh3Xs; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a108354819so2597780a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721985476; x=1722590276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBdg6mNGUPcbuWUmi2rLCF5VQjxVbO3U5q1H7NBUlvo=;
        b=dtOYh3XsUdQQ9r2ncoZNpvc0VINsm6zT3SjQbu9Gf6al1z+agSaDaKK5IfQiIyw39R
         G6G6MrNGnBxB1RY2EbyRTsIIZDqjkCX0mqUNNrJ7WyPuaR78DXA3E5274sC+EMvaMOGR
         SHPPihpR21BGIZkSuFTHTJISk4sXg5CJULu8Tj6ttWArT81SaZmocpUrpqvV+I7avHiB
         tYpN05aKihIydCYcgX8f5gLSWkJTW0ZIZimQpjZkEHR6xJhp66JWqchXRGdZZaS0lU/s
         Hwmd3NUY8ZE8OiBLP6OzpuL8465mpcFbCRYyRUNDu6XV07c7Yr8q8IlmKLu+rFAoOHSH
         jzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721985476; x=1722590276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBdg6mNGUPcbuWUmi2rLCF5VQjxVbO3U5q1H7NBUlvo=;
        b=DgQfPhBsV9g5lu6VAyUe1CHsvB+sBfAuHi2t2q0zpCDpERWg+ZN4gNAScPzLsYrD1e
         qgBFwNzwS4WMaoeLJT0IO4vct9TKaMMuLA2h1TQbz3Y44ZX5Mn7Ibc2Ougvxc1TvT3wT
         GcG0q0ZjVsmeOSf5A+YnApVO7UGQM64jK5vUIcZuoMm/Kx0MptqAqoYwMa+doUKAsNEJ
         bd4I5HRZ2gX6/wPIw4f3jnIqeYISJU6bZO5uzXZL6IrWAIRD07xa3F/7/7myL2y2ZHFn
         0Sprr8FjlrRFPa13bEclbpbgL9wB9j4bzi4yuWpZsHSSCJwYly2yHHeV0j4y6KZgjlBd
         m1gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNK5L0oMTEkW9tiEiDxParFuA+YSyyt3OK5TQl5Ch7cGGw2YUJ5U+5OBX/y143l2/9heTCaMQJvCssns7xbZdVE2MvVBasf+ds2pDm
X-Gm-Message-State: AOJu0YzGoPWxpJjxsYaMlrcqbV04OflFcR2ZT7EgnQdU5QGf57ipg82e
	/og1MMBtg+ZX6vNCch1ant8c5I4sLla+2wNcmNOxCB1wGO4MWiEgbvP+Ny0F4WbmiJFno7U2G/j
	+
X-Google-Smtp-Source: AGHT+IGxC8XByHC1B4bLYFrxJ47zVM0KLxN8ioKkWJmQFI2t+P0w18j+O+o9I9bFHiaHoP5YPtieIw==
X-Received: by 2002:a50:9eec:0:b0:5a2:eab0:4a with SMTP id 4fb4d7f45d1cf-5ac63c52d21mr3357767a12.24.1721985476368;
        Fri, 26 Jul 2024 02:17:56 -0700 (PDT)
Received: from localhost (109-81-83-231.rct.o2.cz. [109.81.83.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63593a8esm1674213a12.30.2024.07.26.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 02:17:56 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:17:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>, linux-kernel@vger.kernel.org,
	Yasunori Gotou <y-goto@fujitsu.com>
Subject: Re: [PATCH RFC] mm: Avoid triggering oom-killer during memory
 hot-remove operations
Message-ID: <ZqNpwz5UW44WOdHr@tiehlicka>
References: <20240726084456.1309928-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726084456.1309928-1-lizhijian@fujitsu.com>

On Fri 26-07-24 16:44:56, Li Zhijian wrote:
> When a process is bound to a node that is being hot-removed, any memory
> allocation attempts from that node should fail gracefully without
> triggering the OOM-killer. However, the current behavior can cause the
> oom-killer to be invoked, leading to the termination of processes on other
> nodes, even when there is sufficient memory available in the system.

But you said they are bound to the node that is offlined.
 
> Prevent the oom-killer from being triggered by processes bound to a
> node undergoing hot-remove operations. Instead, the allocation attempts
> from the offlining node will simply fail, allowing the process to handle
> the failure appropriately without causing disruption to the system.

NAK.

Also it is not really clear why process of offlining should behave any
different from after the node is offlined. Could you describe an actual
problem you are facing with much more details please?
 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  include/linux/memory_hotplug.h |  6 ++++++
>  mm/memory_hotplug.c            | 21 +++++++++++++++++++++
>  mm/page_alloc.c                |  6 ++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 7a9ff464608d..0ca804215e11 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -332,6 +332,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  extern int remove_memory(u64 start, u64 size);
>  extern void __remove_memory(u64 start, u64 size);
>  extern int offline_and_remove_memory(u64 start, u64 size);
> +bool is_offlining_node(nodemask_t nodes);
>  
>  #else
>  static inline void try_offline_node(int nid) {}
> @@ -348,6 +349,11 @@ static inline int remove_memory(u64 start, u64 size)
>  }
>  
>  static inline void __remove_memory(u64 start, u64 size) {}
> +
> +static inline bool is_offlining_node(nodemask_t nodes)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  
>  #ifdef CONFIG_MEMORY_HOTPLUG
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 431b1f6753c0..da3982751ba9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1938,6 +1938,22 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
>  	return 0;
>  }
>  
> +static nodemask_t offlining_node = NODE_MASK_NONE;
> +
> +bool is_offlining_node(nodemask_t nodes)
> +{
> +	return nodes_equal(offlining_node, nodes);
> +}
> +
> +static void offline_pages_start(int node)
> +{
> +	node_set(node, offlining_node);
> +}
> +
> +static void offline_pages_end(void)
> +{
> +	offlining_node = NODE_MASK_NONE;
> +}
>  /*
>   * Must be called with mem_hotplug_lock in write mode.
>   */
> @@ -1991,6 +2007,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  		goto failed_removal;
>  	}
>  
> +	offline_pages_start(node);
>  	/*
>  	 * Disable pcplists so that page isolation cannot race with freeing
>  	 * in a way that pages from isolated pageblock are left on pcplists.
> @@ -2107,6 +2124,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  
>  	memory_notify(MEM_OFFLINE, &arg);
>  	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
> +	offline_pages_end();
> +
>  	return 0;
>  
>  failed_removal_isolated:
> @@ -2121,6 +2140,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>  		 reason);
> +
> +	offline_pages_end();
>  	return ret;
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1780df31d5f5..acdab6b114a5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3563,6 +3563,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	if (page)
>  		goto out;
>  
> +	/* hot-remove is on-going, it generally fails to allocate memory from
> +	 * the being removed memory node. Leave it alone.
> +	 */
> +	if (is_offlining_node(*ac->nodemask))
> +		goto out;
> +
>  	/* Coredumps can quickly deplete all memory reserves */
>  	if (current->flags & PF_DUMPCORE)
>  		goto out;
> -- 
> 2.29.2
> 

-- 
Michal Hocko
SUSE Labs


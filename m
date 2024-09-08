Return-Path: <linux-kernel+bounces-320359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FA0970947
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409D01F21922
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FAE176FB6;
	Sun,  8 Sep 2024 18:53:27 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994862B9CD
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821607; cv=none; b=bnMOc8cmaVG5HsLnct+xeB6lj2pFmim+OMkw2VmIYfXJWFjPk0mHOJ1HvkyakVemQBCg57Yfdjgi06BmOkIJvf96HuIoPOlagLE7s7ZL02RJfVmLeu/OegKyHFdEaA4rERFh2EXlsV+S2aftHxl1jUP2UzLImHUowMTBoylLEKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821607; c=relaxed/simple;
	bh=tSzAKMeFkT26Zg0eEpBFE5CLLGmQSu9e5DhK9eXz5cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=flr9pfRUok0PCDXHfo3xBihs0l+o3LXWBbF7ZXYSfYagCAyR8aB48+gfQqxmiHCR52kA2ls23JgTSIlg20ZWRjOdeg8zrKGFHZYHG+EHNAPzWf5n6AaCwHbIFG/ZOPxCNa+cSs3jGpBvWGx6UfbHjKAaiwXi3GPGWekKuS5GmeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2059112f0a7so32798665ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 11:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725821605; x=1726426405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uCJ9AvJDNH55nzQc9GN1xu818GG/S5c50EOZ6rrXCc=;
        b=H8crdmorwzez/7c137lu9K7ITgX0v303o8e8DmeAuy1TWjTfm6h0cF/qEcIQj8205N
         qpYOAGW0oUp6CCQitk8RUVWorpjUYt25ejD7C1qNdmBruXydSQ6QzUyRIwjOiue0YxX5
         JkapFiq9Jsd2WsBbLvtQgD5eWhVPEAherLCppVufCqOQEqjByVAyI1QktmvYB9D+sqUw
         zmhbng4UevYIWyLXWI80Dgaa8F3zw2EN/bZlAQ3nMbii7+ddNFh37PrUb+VKYihPsBsR
         lcm6K0TXec2MfmWERx6FIU8cGylIP1AmRvFi1oiEMSMIajbbxU0BL8UFJ7/OhzQDp6wK
         3iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLypeOCuSM7HYHmR1Usja6tpMCfGWf+qaHAa7fwBBKPYBe/X88X6giTD6JKDWCV2NIykrPLPnpnoDlLZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZLkYD9bNzvbc4qu6lD69UewCDjI1xIxHRGX/0pihr1S89F+7
	li5awg0hIoDvsbVdj0IiBy8czkATd8fPOavV6/HNM9AjsTd2Cj9e
X-Google-Smtp-Source: AGHT+IHGXoFhM3YhJqWziJWfozX3naXDrko1aq8/x/3ZldaDxH8TQZBA47/qpJJIFMKBgXqm8GR6ww==
X-Received: by 2002:a17:902:c946:b0:206:c8dc:e334 with SMTP id d9443c01a7336-20706fb929emr49132025ad.39.1725821604582;
        Sun, 08 Sep 2024 11:53:24 -0700 (PDT)
Received: from V92F7Y9K0C.attlocal.net (99-124-153-174.lightspeed.sntcca.sbcglobal.net. [99.124.153.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20714b31ba5sm21092205ad.248.2024.09.08.11.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:53:24 -0700 (PDT)
Date: Sun, 8 Sep 2024 11:53:21 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: dennis@kernel.org, tj@kernel.org, cl@linux.com,
	akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH] percpu: fix data race in pcpu_alloc_noprof() and extend
 spinlock protection area
Message-ID: <Zt3yoaLmrII_gypa@V92F7Y9K0C.attlocal.net>
References: <20240908135209.15159-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240908135209.15159-1-aha310510@gmail.com>

Hello,

On Sun, Sep 08, 2024 at 10:52:10PM +0900, Jeongjun Park wrote:
> I got the following KCSAN report during syzbot testing:
> 
> ==================================================================
> BUG: KCSAN: data-race in pcpu_alloc_noprof / pcpu_free_area
> 
> read-write to 0xffffffff883f872c of 4 bytes by task 3378 on cpu 0:
>  pcpu_update_empty_pages mm/percpu.c:602 [inline]
>  pcpu_block_update_hint_free mm/percpu.c:1044 [inline]
>  pcpu_free_area+0x4dc/0x570 mm/percpu.c:1302
>  free_percpu+0x1c6/0xb30 mm/percpu.c:2277
>  xt_percpu_counter_free+0x63/0x80 net/netfilter/x_tables.c:1951
>  cleanup_entry+0x195/0x1c0 net/ipv6/netfilter/ip6_tables.c:671
>  __do_replace+0x470/0x580 net/ipv6/netfilter/ip6_tables.c:1099
>  do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
>  do_ip6t_set_ctl+0x820/0x8c0 net/ipv6/netfilter/ip6_tables.c:1644
>  nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
>  ipv6_setsockopt+0x126/0x140 net/ipv6/ipv6_sockglue.c:998
>  tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
>  sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
>  do_sock_setsockopt net/socket.c:2324 [inline]
>  __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
>  __do_sys_setsockopt net/socket.c:2356 [inline]
>  __se_sys_setsockopt net/socket.c:2353 [inline]
>  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
>  x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:55
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> read to 0xffffffff883f872c of 4 bytes by task 3374 on cpu 1:
>  pcpu_alloc_noprof+0x9a5/0x10c0 mm/percpu.c:1894
>  xt_percpu_counter_alloc+0x79/0x110 net/netfilter/x_tables.c:1931
>  find_check_entry net/ipv4/netfilter/ip_tables.c:526 [inline]
>  translate_table+0x921/0xf70 net/ipv4/netfilter/ip_tables.c:716
>  do_replace net/ipv4/netfilter/ip_tables.c:1137 [inline]
>  do_ipt_set_ctl+0x7bd/0x8b0 net/ipv4/netfilter/ip_tables.c:1635
>  nf_setsockopt+0x195/0x1b0 net/netfilter/nf_sockopt.c:101
>  ip_setsockopt+0xea/0x100 net/ipv4/ip_sockglue.c:1424
>  tcp_setsockopt+0x93/0xb0 net/ipv4/tcp.c:3768
>  sock_common_setsockopt+0x64/0x80 net/core/sock.c:3735
>  do_sock_setsockopt net/socket.c:2324 [inline]
>  __sys_setsockopt+0x1d8/0x250 net/socket.c:2347
>  __do_sys_setsockopt net/socket.c:2356 [inline]
>  __se_sys_setsockopt net/socket.c:2353 [inline]
>  __x64_sys_setsockopt+0x66/0x80 net/socket.c:2353
>  x64_sys_call+0x278d/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:55
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x54/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> value changed: 0x00000005 -> 0x00000006
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 UID: 0 PID: 3374 Comm: syz-executor.3 Not tainted 6.11.0-rc6-syzkaller-00326-gd1f2d51b711a-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> ==================================================================
> 
> The global variable pcpu_nr_empty_pop_pages can be protected by pcpu_lock, 
> but since pcpu_alloc_noprof reads outside the spinlock protection section,
> a data race may occur and the branch of the conditional statement may change.
> Therefore, the reading of pcpu_nr_empty_pop_pages should be modified to be 
> performed within the spinlock protection section.
> 
> However, the for_each_clear_bitrange_from loop requires and uses a spinlock, 
> but it repeatedly locks and unlocks the spinlock unnecessarily. 
> 
> Therefore, I think it is appropriate to remove the repeated spin_lock and 
> spin_unlock in for_each_clear_bitrange_from and perform the operation of 
> reading pcpu_nr_empty_pop_pages and then perform spin_unlock to postpone 
> the point in time when the spin_unlock is performed.
> 
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Fixes: e04d320838f5 ("percpu: indent the population block in pcpu_alloc()")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  mm/percpu.c |  5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 20d91af8c033..5c958a54da51 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1864,7 +1864,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  
>  area_found:
>  	pcpu_stats_area_alloc(chunk, size);
> -	spin_unlock_irqrestore(&pcpu_lock, flags);
>  
>  	/* populate if not all pages are already there */
>  	if (!is_atomic) {
> @@ -1878,14 +1877,12 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  
>  			ret = pcpu_populate_chunk(chunk, rs, re, pcpu_gfp);
>  
> -			spin_lock_irqsave(&pcpu_lock, flags);
>  			if (ret) {
>  				pcpu_free_area(chunk, off);
>  				err = "failed to populate";
>  				goto fail_unlock;
>  			}
>  			pcpu_chunk_populated(chunk, rs, re);
> -			spin_unlock_irqrestore(&pcpu_lock, flags);
>  		}

We don't want to do this because pcpu_populate_chunk() calls
alloc_pages_node() which can block.
>  
>  		mutex_unlock(&pcpu_alloc_mutex);
> @@ -1894,6 +1891,8 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
>  		pcpu_schedule_balance_work();
>  
> +	spin_unlock_irqrestore(&pcpu_lock, flags);
> +
>  	/* clear the areas and return address relative to base address */
>  	for_each_possible_cpu(cpu)
>  		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);
> --

I sent out [1] which is a more appropriate fix. I'll merge it later
today.

Thanks,
Dennis

[1] https://lore.kernel.org/lkml/20240906031151.80719-1-dennis@kernel.org/



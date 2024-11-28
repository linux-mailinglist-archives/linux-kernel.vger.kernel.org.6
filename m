Return-Path: <linux-kernel+bounces-424076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACA69DB065
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 01:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E662811DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 00:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FA9D27E;
	Thu, 28 Nov 2024 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vSnw2AD9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7AF2581
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732754989; cv=none; b=IoMJLsrsdPf/kptsdOXM7yp2PGf9Hyoq9fgOzZ7hLH3tubfCpbv5BWGWfjiEj3jwEkWYmih0zl/5Jrg/5dZs5lAthoZGt8b+JtTEpuHeRlia5vHU1co119i0XY3/LT5rENnkZILndHsJLAKybB+RSn5kLo17uhLBlaP4Nh0aEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732754989; c=relaxed/simple;
	bh=pR9wREWB2fodb0/QPUlRVXlY0hvBsyu1VJhYzZ7hj/M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=szPHO8TAVlLBdUIZL7wiiktwmcBjmJwH6si/rmTPaPtDvHShFdDoQ73W82+c+hAEX7zbCNaHGU0ehREhqBqBs7ZmxzrPGjue6Wbr2T6S/miUnchXMzGt95jMnGT+Uv3/YyLEtnaDLONHT7e/OrIyZXTzcKmQlyK5mh2mp2d3krA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vSnw2AD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3761C4CECC;
	Thu, 28 Nov 2024 00:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1732754989;
	bh=pR9wREWB2fodb0/QPUlRVXlY0hvBsyu1VJhYzZ7hj/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vSnw2AD9RnEFdjGtCyY9VWQVrSRb4jcfu48WtHrEy/XjlkdNqTTy/7Jt5ZLimmsEp
	 8le2+rtce2WajrByNqD8e4vO+lqh9SDKqOqdiz1EYX2v82EXm4Rjn7aVtiVf1IjW+5
	 VWNzXrsdiE3Td+3xvKl8yAPQfF6425yC6ZsRnw6o=
Date: Wed, 27 Nov 2024 16:49:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Seiji Nishikawa <snishika@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mel Gorman
 <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm: vmscan: ensure kswapd is woken up if the wait queue
 is active
Message-Id: <20241127164948.74659f9400fd076760c2a670@linux-foundation.org>
In-Reply-To: <20241126150612.114561-1-snishika@redhat.com>
References: <20241126150612.114561-1-snishika@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 00:06:12 +0900 Seiji Nishikawa <snishika@redhat.com> wrote:

> Even after commit 501b26510ae3 ("vmstat: allow_direct_reclaim should use
> zone_page_state_snapshot"), a task may remain indefinitely stuck in
> throttle_direct_reclaim() while holding mm->rwsem.
> 
> __alloc_pages_nodemask
>  try_to_free_pages
>   throttle_direct_reclaim
> 
> This can cause numerous other tasks to wait on the same rwsem, leading
> to severe system hangups:
> 
> [1088963.358712] INFO: task python3:1670971 blocked for more than 120 seconds.
> [1088963.365653]       Tainted: G           OE     -------- -  - 4.18.0-553.el8_10.aarch64 #1
> [1088963.373887] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [1088963.381862] task:python3         state:D stack:0     pid:1670971 ppid:1667117 flags:0x00800080
> [1088963.381869] Call trace:
> [1088963.381872]  __switch_to+0xd0/0x120
> [1088963.381877]  __schedule+0x340/0xac8
> [1088963.381881]  schedule+0x68/0x118
> [1088963.381886]  rwsem_down_read_slowpath+0x2d4/0x4b8
> 
> The issue arises when allow_direct_reclaim(pgdat) returns false,
> preventing progress even when the pgdat->pfmemalloc_wait wait queue is
> empty. Despite the wait queue being empty, the condition,
> allow_direct_reclaim(pgdat), may still be returning false, causing it to
> continue looping.
> 
> In some cases, reclaimable pages exist (zone_reclaimable_pages() returns
>  > 0), but calculations of pfmemalloc_reserve and free_pages result in
> wmark_ok being false.
> 
> And then, despite the pgdat->kswapd_wait queue being non-empty, kswapd
> is not woken up, further exacerbating the problem:
> 
> crash> px ((struct pglist_data *) 0xffff00817fffe540)->kswapd_highest_zoneidx
> $775 = __MAX_NR_ZONES
> 
> This patch modifies allow_direct_reclaim() to wake kswapd if the
> pgdat->kswapd_wait queue is active, regardless of whether wmark_ok is
> true or false. This change ensures kswapd does not miss wake-ups under
> high memory pressure, reducing the risk of task stalls in the throttled
> reclaim path.

The code which is being altered is over 10 years old.  

Is this misbehavior more recent?  If so, are we able to identify which
commit caused this?

Otherwise, can you suggest why it took so long for this to be
discovered?  Your test case must be doing something unusual?

Thanks.

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6389,8 +6389,8 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
>  
>  	wmark_ok = free_pages > pfmemalloc_reserve / 2;
>  
> -	/* kswapd must be awake if processes are being throttled */
> -	if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
> +	/* Always wake up kswapd if the wait queue is not empty */
> +	if (waitqueue_active(&pgdat->kswapd_wait)) {
>  		if (READ_ONCE(pgdat->kswapd_highest_zoneidx) > ZONE_NORMAL)
>  			WRITE_ONCE(pgdat->kswapd_highest_zoneidx, ZONE_NORMAL);
>  



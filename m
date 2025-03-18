Return-Path: <linux-kernel+bounces-565259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48657A664C3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3139D16A68C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014C146A72;
	Tue, 18 Mar 2025 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VtTsTjJG"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EBD4594A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742260433; cv=none; b=mXq8rv9qo5plwO6KAbDKwduCtmYqXaxSEr/I2bRzKVhcwmo2ctEHQ/gFiuPg2APz1PSoJ2XmX1H1bjMa0F50ZIawb4Ih5PJpBDhqYksafLFBX48fJPUelnxK+kaPlnANNIo+zryFVuRNESlbGOWj5IdALeViklDZJ0lQfyNeTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742260433; c=relaxed/simple;
	bh=ngrXW5OGnozsH3LpRBKU9FtsESl6OnusHLUi7b59djc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lyjufcgpj09egzJib10bvbuy1Ed2Yv57nwFcSt7Udhdu3w+kANdDWipMrAlVW0qyqwipQV/dwN78RshUvq9jGBtTb2utewDfs8IPoEEgcmmm+AIrGzDOQgBJbeYdvnL0Jgz80LiZeE1ZSnvlP9T8yWoV/VC9UJJ2sRsyaJ1TbPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VtTsTjJG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 18 Mar 2025 01:13:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742260429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXsTKHcuddy1YSKto3W7H1Cp7bk8qRJyAR00726aAHw=;
	b=VtTsTjJGb8MWmUtCJKt+7eGKLLa5cg9fuBs5cRP/UkiGZuTshbdUWj55y715ExOjMvORE2
	LkwxUkbGT1MILWSH43oUc/3FbbQ/qCi6vSBTfixkEZL6tSDSfDNaIYZcrr3dkzZDahg+Oi
	8BQYyD7HOilk6YmFzmAFrKjldiQ/z88=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 7/9] memcg: use __mod_memcg_state in drain_obj_stock
Message-ID: <Z9jIxxllVwFSLYeL@google.com>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-8-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315174930.1769599-8-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 10:49:28AM -0700, Shakeel Butt wrote:
> For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> disabled, so we can use __mod_memcg_state() instead of
> mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> in __mod_memcg_state().
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3c4de384b5a0..dfe9c2eb7816 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -707,10 +707,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
>  	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
>  		return;
>  
> +	memcg_stats_lock();
>  	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
>  	val = memcg_state_val_in_pages(idx, val);
>  	memcg_rstat_updated(memcg, val);
>  	trace_mod_memcg_state(memcg, idx, val);
> +	memcg_stats_unlock();
>  }
>  
>  #ifdef CONFIG_MEMCG_V1
> @@ -2845,7 +2847,7 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)

VM_WARN_ON_IRQS_ENABLED() ?

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>


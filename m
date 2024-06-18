Return-Path: <linux-kernel+bounces-219995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8C90DB46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 975541C21B37
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08CF14F9D0;
	Tue, 18 Jun 2024 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWmtCd6n"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898C14F108
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734050; cv=none; b=RaV+qQie/egocLJVOuhxUSC7yURyRjWvt/elKF9GxOHL2DHRLuTEVecARHftus7KQGFC2UAIkBEleC2QJ+BP4/kKv8ulX0dEFARjpGGLa4lDgu2un2yVZTUO+U17PVxNE/Nkt4/bwOsHsFnLuRQZnWi89tuhYJlg+u/hP8w57UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734050; c=relaxed/simple;
	bh=TAWP4ZRLy761cM1Lf73e48y5a7IcOyWmrJCPL96Z7a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt9MogpQqcYyCOxtgCbLt/TLRr08W82WC6QvaU8uARW19dalu7f5Eksqj1Oy6Cv4xG2ujqsXF8RiOkVxeLlWiDk2SSMjR+MxSw6aT7UIvU8gDETVcT8wjgkwD1L4g58z+UTK2PlCN6bDNiNSyzZBKn+F1yV7nIfEOfsBQUCtv5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWmtCd6n; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718734045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zIwihtAQuXrEh3tnnCfdNBIMJgSNe8TW7SZdiKpL4Hw=;
	b=BWmtCd6nd3/8EOFMbnPOeDiCXcNj+p8YYkdeMig84HxUklkWYmkmlMWpWRiFlf7C4IxUsO
	SisGpOGsg6nVpwU8cxUXeZ5xbvLk1XYLi4i93X62D01E++q2xXr5o1AxeAgIfWFVyzuJ46
	s9SLPix8IThbDNH4HDjY+aVoOAnTkvM=
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@suse.com
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: yuzhao@google.com
X-Envelope-To: songmuchun@bytedance.com
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: kernel-team@cloudflare.com
Date: Tue, 18 Jun 2024 11:07:20 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Yu Zhao <yuzhao@google.com>, Muchun Song <songmuchun@bytedance.com>, 
	Facebook Kernel Team <kernel-team@meta.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH] memcg: use ratelimited stats flush in the reclaim
Message-ID: <fn5di727hk3fk3we5bt2btaki5fh6yhtwv5tpxvjk3yxx3e5mb@vr23hctsbxw7>
References: <20240615081257.3945587-1-shakeel.butt@linux.dev>
 <CAJD7tkbpFu8z1HaUgkaE6bup_fsD39QLPmgNyOnaTrm+hZ_9hA@mail.gmail.com>
 <0ec3c33c-d9ff-41a5-be94-0142f103b815@kernel.org>
 <rhvafiag6fjkj66ohex3eamoqpsw62bxmwbvd7shsa72rqcile@fvo4nsggjpwg>
 <c0fb8c2d-433d-4f8a-a06d-e6ca578ebbf0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0fb8c2d-433d-4f8a-a06d-e6ca578ebbf0@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 18, 2024 at 05:53:02PM GMT, Jesper Dangaard Brouer wrote:
> 
> 
[...]
> > > > - With the added thresholding code, a flush is only done if there is a
> > > > significant number of pending updates in the relevant subtree.
> > > > Choosing the ratelimited approach is intentionally ignoring a
> > > > significant change in stats (although arguably it could be irrelevant
> > > > stats).
> > > > 
> > > 
> > > My production observations are that the thresholding code isn't limiting
> > > the flushing in practice.
> > > 
> > 
> > Here we need more production data. I remember you mentioned MEMCG_KMEM
> > being used for most of the updates. Is it possible to get top 5 (or 10)
> > most updated stats for your production environment?
> > 
> 
> Do you have a method for obtaining these stats?
> 
> Last time I used eBPF + bpftrace to extract these stats.  The high rate
> these updates occur, it caused production overload situations that SRE
> noticed.  So, I have to be careful when producing these stats for you.
> 
> Also could you be more specific what code lines you want stats for?
> 

I am looking for idx and val in __mod_memcg_state, __mod_memcg_lruvec_state
and __count_memcg_events.

Can you share your bpftrace trace (I remember you shared it, sorry for
asking again) and I will reach out to bpf experts to see if we can
further reduce the cost.

> 
> > > 
> > > > - Reclaim code is an iterative process, so not updating the stats on
> > > > every retry is very counterintuitive. We are retrying reclaim using
> > > > the same stats and heuristics used by a previous iteration,
> > > > essentially dismissing the effects of those previous iterations.
> > > > 
> > > > - Indeterministic behavior like this one is very difficult to debug if
> > > > it causes problems. The missing updates in the last 2s (or whatever
> > > > period) could be of any magnitude. We may be ignoring GBs of
> > > > free/allocated memory. What's worse is, if it causes any problems,
> > > > tracing it back to this flush will be extremely difficult.
> > > > 
> > > 
> > > The 2 sec seems like a long period for me.
> > > 
> > > > What can we do?
> > > > 
> > > > - Try to make more fundamental improvements to the flushing code (for
> > > > memcgs or cgroups in general). The per-memcg flushing thresholding is
> > > > an example of this. For example, if flushing is taking too long
> > > > because we are flushing all subsystems, it may make sense to have
> > > > separate rstat trees for separate subsystems.
> > > > 
> > > > One other thing we can try is add a mutex in the memcg flushing path.
> > > > I had initially had this in my subtree flushing series [1], but I
> > > > dropped it as we thought it's not very useful.
> > > 
> > > I'm running an experimental kernel with rstat lock converted to mutex on
> > > a number of production servers, and we have not observed any regressions.
> > > The kswapd thundering herd problem also happen on these machines, but as
> > > these are sleep-able background threads, it is fine to sleep on the mutex.
> > > 
> > 
> > Sorry but a global mutex which can be taken by userspace applications
> > and is needed by node controller (to read stats) is a no from me. On a
> > multi-tenant systems, global locks causing priority inversion is a real
> > issue.
> > 
> 
> The situation we have *today* with a global IRQ-disabling spin_lock is
> precisely causing a priority-inversion situation always by design.
> Userspace applications (reading stat file) and kswapd background
> processes are currently getting higher priority than both hardware and
> software interrupts. This is causing actual production issues, which is
> why I'm working on this.
> 
> I do understand that changing this to a global mutex creates the
> theoretical *possibility* for priority-inversion between processes with

Ah sorry for giving the impression that I am talking about theoretical
issue, no, we (old me at Google) have seen global lock causing priority
inversions and cauing the high priority node controller stuck for 10s of
seconds to several minutes in Google production.

> different configured priorities.  IMHO this is better than always taking
> the "big" bottom-half-lock [LWN].  I still want to lower the potential
> priority-inversion issue with the mutex lock, by (1) working on lowering
> the pressure on the lock (e.g. exit if flush is ongoing on root, and
> e.g. add time limit on how often flush can run on sub-trees), and (2) we
> will collect production metrics for lock contention and hold time (with
> appropriate alerts).

Oh I am open to mutex change along with the efforts to reduce the
chances of priority inversion, just not the mutex change only. I am open
to trying out new things as some (or all) might not work and we may have
to go back to the older situation.

> 
> 
> [LWN] https://lwn.net/SubscriberLink/978189/5f50cab8478fac45/
> 
> 
> > > 
> > [...]
> > > 
> > > My pipe dream is that kernel can avoiding the cost of maintain the
> > > cgroup threshold stats for flushing, and instead rely on a dynamic time
> > > based threshold (in ms area) that have no fast-path overhead :-P
> > > 
> > 
> > Please do expand on what you mean by dynamic time based threshold.
> 
> I proposed a fixed 50 ms flush rate limiting in [2].  But I don't want
> this to be a static value as it will vary on different configs and
> hardware. I propose making this dynamic via measuring the time it takes
> to flush the cgroup root.  This makes sense in a queuing theory context,
> because this corresponds to the (longest) service time, and theory say
> "a queue is formed when customers arrive faster than they can get
> served". Thus, this should lower the pressure/contention on the lock,
> while still allowing frequent flushing.  Hope it makes sense.
> 

Thanks for the explanation.

> --Jesper
> 
> 
> [2] https://lore.kernel.org/all/171328990014.3930751.10674097155895405137.stgit@firesoul/


Return-Path: <linux-kernel+bounces-375612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF369A982D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B071F23AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F9E12F588;
	Tue, 22 Oct 2024 05:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5oopKOg"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C8C12C522
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574050; cv=none; b=t4bHUat6yhUnJgn4/FqLo754LDWvBt4DB4fM47WQwDJ5w+6Rd/Fp+Zc2ZAvEMueELAkWIE4OSds5uE/fPEsoRPFMXjV92Yvkv9qeFYgbFEoz8ClYHt3tnP2V7ZZAtmp1VyrSZAslpspQi7uWoOHyFgVeQX/lhVboHbqz3YOXywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574050; c=relaxed/simple;
	bh=SlJkwPGyAmgj+3nVc5GPEvLAsxK3Oim7R9eglxcJbDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bklZLTHuUHvvQlx84YyqSC9FcFRJm3FQ9ZYY7szc1qsphtk0EGHDW94qMxcQoUlaS8MX+/qYUn802rAZK7NwoKdG+9B3OpDl0Cr5HPxVHscQyhw/agbd7WgABYXxMw3YN+gs8V6pPEMR4WU+FnHba7o2rT+Af7zYKKxzGJnHmjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5oopKOg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so3799709a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 22:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729574049; x=1730178849; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=at3mNX0tawpFGP5P12WETb9tShYw0qm9sRbMOHP+YTI=;
        b=E5oopKOgIaZD5vebQQ/3xatvoUCzWgD8M+rRmj4V6A2oBU3VFxNbiOgYEpBvOgSj+D
         K0BC27A6We8FA88Wp/fZWxsHXiPc0Xvghczn7QzfKA0cTB39ey9W0RRzdFUpyJfz5Kj7
         WHwdt9KwOJ7CaVyKXCy8aMO0BTOJOGYH5jZ41/4jIcM+tKrXR/mNQNe+Z70ms3mOAikO
         eMSEEZUyIFgs3O10nE2bumGYpwayofDM1ZqLuQvC5VJZtFUnSIuPBjDfsoSwHtg5YP8A
         81Nl5TK3uKqm4lU5rHce3FPTs+yinPYFSyEHqY7otMwmmKB0kpNXU5W8Bw+Td+Ff6nMz
         HVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729574049; x=1730178849;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=at3mNX0tawpFGP5P12WETb9tShYw0qm9sRbMOHP+YTI=;
        b=joa9auNJ54ATdVfOM1cL6C11Oyi0RG6ZNwlU3bhtIW9fgye82RfqfFKQJOpys5Udwt
         srz7SFtuo/RQ5rkhvhvV/OCNZj6aA5Tj5unrYPm4jb+y0GIttfDTYy8BzgTxzd1h+XcN
         Z9wxwwdIVc7VCnrWsGl82Yy5vR6mmSy0OxDuNCAACzxfSNfpnabDV+DXJWf7J6ih/qkb
         J2/l/j3zpyXE3+U/C0o33WHZGsdcUZ9iSCpVr3D1lMQQ1KqcbiUhh4s8HBUeVyNNPjOM
         cBQ5rcfL1DO+OQbll7VB6gNh63hvlEbM8zCxvuT8ojaZnRl1qY6QyrbgK/ZTCveqNfbu
         BHZA==
X-Forwarded-Encrypted: i=1; AJvYcCVySZrVkbzD0wk7+0O56eKV+cQgxndZzykDxbtrpxfrbmKU38Gcat16FvAWyuDUrNReQEfn6EU/3Mxh/c8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg4prZXSKBcS/71ilnKPeqJ1HAe5xOJmDpZkMyfcfc3j/P9fTU
	dHjAgRTRNTzGVmkUT26ZZk3D/Q1Dx4d1Z2ujs9FN846spFdOlDsz
X-Google-Smtp-Source: AGHT+IFheUPN8TAJ6sSMv8qbClgGA9hLNbm4NdGj+Q2op7OD6KynBw2ik4mcP300XeC70jTavoRX2A==
X-Received: by 2002:a17:90a:8990:b0:2e2:bbcd:6cbb with SMTP id 98e67ed59e1d1-2e5da552565mr2318855a91.6.1729574048496;
        Mon, 21 Oct 2024 22:14:08 -0700 (PDT)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad2616b9sm5032149a91.3.2024.10.21.22.14.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2024 22:14:08 -0700 (PDT)
From: MengEn Sun <mengensun88@gmail.com>
X-Google-Original-From: MengEn Sun <mengensun@tencent.com>
To: ying.huang@intel.com
Cc: akpm@linux-foundation.org,
	alexjlzheng@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mengensun88@gmail.com,
	mengensun@tencent.com
Subject: Re: [PATCH linux-mm v2] mm: make pcp_decay_high working better with NOHZ full
Date: Tue, 22 Oct 2024 13:14:06 +0800
Message-Id: <1729574046-3392-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <87msix6e8c.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <87msix6e8c.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Thank you for your suggestion. I understand and am ready to make
some changes  

> 
> Have verified the issue with some test?  If not, I suggest you to do
> that.
> 

I have conducted tests:
Applying this patch or not does not have a significant impact on the test results.
perhaps my testing was not thorough enough. #^_^

But, the logic of the code is like following:
CPU0                              CPUx
----                              -----
                                  T0: vmstat_work is pending
T1: vmstat_shepherd
    check vmstat_work
    and do nothing
                                  T2: vmstat_work is in unpending state.

                                  T3: alloc many pages
                                  T4: free all the pages allocated at T3
                                  T5: entry NOHZ, flushing all zonestats
                                      and nodestats
T6: next vmstat_shepherd fired

In my opinion, there are indeed some issues. I'm not sure if there's
something I haven't understood?


By the way,
There are two other questions for me:
Q1:
Vmstat_work is a **deferreable work** So, It may be delayed for a long time
by NOHZ. As a result, "vmstat_update() may not be executed once every
second in the above scenario. Therefore, I'm not sure if using a deferrable
work to reduce pcp->high is appropriate. In my tests, if I don't use
deferrable work, it takes about a minute to reduce high to high_min, but
using deferrable work may take several minutes to reduce high to high_min.

Q2:
On a big machine, for example, with 1TB of memory, the default maximum
memory on PCP can be 1TB * 0.125.
This portion of memory is not accounted for in MemFree in /proc/meminfo.
Users can see this portion of memory from /proc/zoneinfo, but the memory
reported by the `free` command is reduced.
can we include the PCP memory in the MemFree statistic in /proc/meminfo?

> > While, This seems to be fine:
> > - if freeing and allocating memory occur later, it may the
> >   high_max may be adjust automatically
> > - If memory is tight, the memory reclamation process will
> >   release the pcp
> 
> This could be a real issue for me.

Thanks, I will test more carefully for those issue

> 
> > Whatever, we make vmstat_shepherd to checking whether we need
> > decay pcp high_max, and fire pcp_decay_high early if we need.
> >
> > Fixes: 51a755c56dc0 ("mm: tune PCP high automatically")
> > Reviewed-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > Signed-off-by: MengEn Sun <mengensun@tencent.com>
> > ---
> > changelog:
> > v1: https://lore.kernel.org/lkml/20241012154328.015f57635566485ad60712f3@linux-foundation.org/T/#t
> > v2: Make the commit message clearer by adding some comments.
> > ---
> >  mm/vmstat.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 1917c034c045..07b494b06872 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -2024,8 +2024,17 @@ static bool need_update(int cpu)
> >  
> >  	for_each_populated_zone(zone) {
> >  		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> > +		struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> >  		struct per_cpu_nodestat *n;
> >  
> > +		/* per_cpu_nodestats and per_cpu_zonestats maybe flush when cpu
> > +		 * entering NOHZ full, see quiet_vmstat. so, we check pcp
> > +		 * high_{min,max} to determine whether it is necessary to run
> > +		 * decay_pcp_high on the corresponding CPU
> > +		 */
> 
> Please follow the comments coding style.
> 
>                 /*
>                  * comments line 1
>                  * comments line 2
>                  */
> 

Thank you for your suggestion. I understand and am ready to make
some changes

> > +		if (pcp->high_max > pcp->high_min)
> > +			return true;
> > +
> 
> We don't tune pcp->high_max/min in fact.  Instead, we tune pcp->high.
> Your code may make need_update() return true in most cases.

You are right, using high_max is incorrect. May i use pcp->high > pcp->high_min?

> 
> >  		/*
> >  		 * The fast way of checking if there are any vmstat diffs.
> >  		 */
> 
> --
> Best Regards,
> Huang, Ying

Best Regards,
MengEn, Sun


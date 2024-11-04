Return-Path: <linux-kernel+bounces-395309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548E9BBC2D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A611F2319B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F61C57A5;
	Mon,  4 Nov 2024 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hqVrNpjr"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF133FE
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742073; cv=none; b=XetMILrsdO67zkwX7rpvI9VJzw45YNJzMaeLZj88HOuOOumsKRQu0lPifC+RTJVtxdmZyRNWTVTOULgG6wpD3yF4cLV98+569+qLFAhf1KKudA9NKpnrgydxhTOBDS+/n1kntCRDsf/rS/9zsYIczLi0aVRmEYCG4xnHUxZ6IYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742073; c=relaxed/simple;
	bh=oiHaHDjbQIXvhef8cEb8LMzup1uxrIQAQJ/zn1ZYhtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJd10u1bV9pkseStVUnjN1Ea6G8wxyj2toKOEaP0OThkS5sVlBIRxnpSg1rWr3dg6xxAcpZQF6reg2K4D2aR3SIQkIP1jiBIvi2Y9VcxTWlVfVr+QFb4zBwAvVbTxLeKHPT+tgL6taTitMSN1EKwY4sB907xMQcZVdyq7ftMiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=hqVrNpjr; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a5e0bfc7fdso13269625ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1730742070; x=1731346870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eD0jIBbhvUw1Wft/Zgy3c3Ny5uJt0MdTa2/Xn5r+wmA=;
        b=hqVrNpjrhixU3rlnZ7iaS4NdcVhGw59A2cNnGvTpvKitjsKfWPtV78DHYDlQxKtZvC
         P3CiY7nDkww825ODnzxP1JVMaTQhX027CcDi491Euv/vvEi+yNDxafCQkHOlZqWUBb6l
         tn9Qmk/byrJjn7tsgvw30Y0qYK+dPB4U+m5hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742070; x=1731346870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eD0jIBbhvUw1Wft/Zgy3c3Ny5uJt0MdTa2/Xn5r+wmA=;
        b=ilYEm4wr+inCrmZk9UpW6GKrx2FP3HKpU4S0G6Enfz4Qq+TuKQ45ll7c2mgxdG8Abr
         gwfjbxeS0wZM+9DgBm46H+PHe9YXV1ohXIDf+z66aAtRJ2W/8GK/iSYXH40388m76gz7
         xUG8a5VawtUug84XEmCOFAxtQgRBaRWrv9hzpKVrC369RQU9pCMkt/iLeQvu8vJbb52h
         8HUcWq9OUBq4KmexUTHP1Twoxa3pH6TEVuxckGPaIn9PlW1/U7RRutBGLxiKz7wYyD2Z
         ye2V3FumMZUg3J8CBIftQMQ/SCodtYXGblZNlSI9gNyx/bPwgye2NygsHWs2dJTBjGC3
         kniw==
X-Gm-Message-State: AOJu0YxsZKr379q5yh3y3b+jIcvIc4U7xn5NVLzffrWWgDNH3nZwZcUi
	p2PHku10S9U8q2IGUHJec29pKCxLJg+/Mi0Qf/dkGhz9jyTtL0/24jq7AJNI4hY=
X-Google-Smtp-Source: AGHT+IE6ix7bkCmClEgArBXLydcf8dFaRNEFQ9jt86CJ5B5ABDWDOip0eQcrAdJym4d/yu10AUYsXA==
X-Received: by 2002:a05:6e02:2194:b0:3a6:bd97:96bf with SMTP id e9e14a558f8ab-3a6bd979cbdmr65631535ab.24.1730742070416;
        Mon, 04 Nov 2024 09:41:10 -0800 (PST)
Received: from localhost (68.192.68.34.bc.googleusercontent.com. [34.68.192.68])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6c4d62243sm11947905ab.60.2024.11.04.09.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:41:09 -0800 (PST)
Date: Mon, 4 Nov 2024 17:41:09 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <20241104174109.GA1044726@google.com>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>

On Mon, Nov 04, 2024 at 11:54:36AM +0100, Juri Lelli wrote:
> On 30/10/24 19:50, Joel Fernandes wrote:
> 
> ...
> 
> > With some prints [1] in the kernel, we can see on boot:
> > 
> > $ dmesg|grep appl
> > [    0.930337] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> > [    0.949025] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> > [    0.953026] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1
> > [    0.957024] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1
> > [    0.961023] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1
> > [    0.965030] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1
> > [    0.969024] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1
> > [    0.973024] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1
> > 
> > For the 8th apply_params, the 8th CPU is not considered. This is because
> > set_cpu_active() for the 8th CPU has not yet happened as mentioned in commit
> > message.
> > 
> > With the patch:
> > 
> > $ dmesg|grep appl
> > [    0.961169] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> > [    0.981936] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1
> > [    0.985836] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1
> > [    0.989835] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1
> > [    0.993840] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1
> > [    0.997835] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1
> > [    1.001838] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1
> > [    1.005834] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1
> > 
> >    [ ... here somewhere rd changes as topology init finishes, then all the
> >    params are replied, this time with the correct rd. ]
> > 
> > [    1.009903] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.012409] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.014269] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.019865] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.054908] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.081865] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.108861] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > [    1.136944] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=8, cap=8192, init=1
> > 
> > The -EBUSY happens for our 5.15 backport. I see dl_b->total_bw to be 0
> > without my patch. Even if the -EBUSY doesn't happen for you (perhaps due to
> > compiler or other differences), shouldn't we use the correct rd for
> > apply_params? The dl_bw is tied to the rd via  cpu_rq(cpu)->rd->dl_bw;
> 
> I think I am still seeing something different.
> 
> [    0.184629] dl_server_apply_params: cpu=0, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=0, dl_b->bw=996147
> [    0.185498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=1024, cap_scale=996147 dl_bw->total_bw=0, old_bw=0, new_bw=52428
> [    0.371531] dl_server_apply_params: cpu=1, runtime=50000000, period=1000000000, cpus=1, cap=1024, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=52428, dl_b->bw=996147
> [    0.372498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=1024, cap_scale=996147 dl_bw->total_bw=52428, old_bw=0, new_bw=52428
> [    0.373541] dl_server_apply_params: cpu=2, runtime=50000000, period=1000000000, cpus=2, cap=2048, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=104856, dl_b->bw=996147
> [    0.374498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=2048, cap_scale=1992294 dl_bw->total_bw=104856, old_bw=0, new_bw=52428
> [    0.375507] dl_server_apply_params: cpu=3, runtime=50000000, period=1000000000, cpus=3, cap=3072, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=157284, dl_b->bw=996147
> [    0.376498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=3072, cap_scale=2988441 dl_bw->total_bw=157284, old_bw=0, new_bw=52428
> [    0.377507] dl_server_apply_params: cpu=4, runtime=50000000, period=1000000000, cpus=4, cap=4096, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=209712, dl_b->bw=996147
> [    0.378498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=4096, cap_scale=3984588 dl_bw->total_bw=209712, old_bw=0, new_bw=52428
> [    0.379505] dl_server_apply_params: cpu=5, runtime=50000000, period=1000000000, cpus=5, cap=5120, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=262140, dl_b->bw=996147
> [    0.380498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=5120, cap_scale=4980735 dl_bw->total_bw=262140, old_bw=0, new_bw=52428
> [    0.381504] dl_server_apply_params: cpu=6, runtime=50000000, period=1000000000, cpus=6, cap=6144, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=314568, dl_b->bw=996147
> [    0.382498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=6144, cap_scale=5976882 dl_bw->total_bw=314568, old_bw=0, new_bw=52428
> [    0.384527] dl_server_apply_params: cpu=7, runtime=50000000, period=1000000000, cpus=7, cap=7168, init=1, dl_b=ffffffffb837c080, dl_b->total_bw=366996, dl_b->bw=996147
> [    0.385498] __dl_overflow: dl_b=ffffffffb837c080, dl_b->bw=996147, cap=7168, cap_scale=6973029 dl_bw->total_bw=366996, old_bw=0, new_bw=52428
>      ...
> [    0.388556] __dl_server_attach_root: cpu=0, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=52428, dl_b->bw=996147
> [    0.389507] __dl_server_attach_root: cpu=1, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=104856, dl_b->bw=996147
> [    0.390501] __dl_server_attach_root: cpu=2, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=157284, dl_b->bw=996147
> [    0.391503] __dl_server_attach_root: cpu=3, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=209712, dl_b->bw=996147
> [    0.392499] __dl_server_attach_root: cpu=4, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=262140, dl_b->bw=996147
> [    0.393499] __dl_server_attach_root: cpu=5, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=314568, dl_b->bw=996147
> [    0.394428] __dl_server_attach_root: cpu=6, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=366996, dl_b->bw=996147
> [    0.394499] __dl_server_attach_root: cpu=7, new_bw=52428, dl_b=ffff949bc080e040, dl_b->total_bw=419424, dl_b->bw=996147
> 
> 
> I added a printk in __dl_server_attach_root which is called after the
> dynamic rd is built to transfer bandwidth to it.
> 
> __dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
> server interface"), do you have this change in your backport?

You nailed it! Our 5.15 backport appears to be slightly older and is missing
this from topology.c as you mentioned. Thanks for clarifying!


        /*
         * Because the rq is not a task, dl_add_task_root_domain() did not
         * move the fair server bw to the rd if it already started.
         * Add it now.
         */
        if (rq->fair_server.dl_server)
                __dl_server_attach_root(&rq->fair_server, rq);

> 
> > So if rd changes during boot initialization, the correct dl_bw has to be
> > updated AFAICS. Also if cpusets are used, the rd for a CPU may change.
> 
> cpusets changes are something that I still need to double check. Will
> do.
> 

Sounds good, that would be good to verify.

Thanks,

 - Joel



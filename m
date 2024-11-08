Return-Path: <linux-kernel+bounces-401471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CF69C1AD8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCFB283149
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2941E25E3;
	Fri,  8 Nov 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KLQIYI/i"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A641C6E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062462; cv=none; b=ZRlJZ7OM7+gpIwQWIgE5kRQ0kXZvVs/deBz04fmPFUuMvJID2V4o8mwq4yVB2uRbDGDvqghUcr3WhysmDdFEVhvG76AxGBmpsyaH5CqCoH4kG8kRWcdeqY+hOwCsgLjlaUPprP2G/AqYuKI/EVtcSIw24IcQwW4lo+NeampOM9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062462; c=relaxed/simple;
	bh=LyQ/34sdEq88qqr8RgZ1ETW59iZn5NN5+qaGufK2zYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3QIoR5LA8gTibm7Eqad7pp/HVo2G796u1qFYQszX/V2tJ0e2R3A2Mh3BAWZw513YooW2I6Y0LxtFEquD7eQtrzzUXQvF6FzoLH3JNBk5LT4lRLRG85cuq+P55aMbTWaj9xmq/mPECe7qT7RU3qoZraNaSi8jJs6ZEyE/Y7/M/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KLQIYI/i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731062458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0oQh4hs+ahIQ4W1afqG0+5AfGIPhbq8psBrgytlA0c=;
	b=KLQIYI/iNoKDVkll4YUwabrnPfFLAajFJ6tGOsNkYuk8YDjJbKN2x+po7SgIBsFSNXy+ri
	mKLuQ6dquYP26tyyHNnMH+vdK5M0K3X7Lq/LPifz8YCYMO7sWKXP9jvYHADntKkBZNrLph
	ztpPxyFTcRJAuVOAU/04yKLPDlrfsi0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-98HbgVCuPgO2f3EK5BbrdQ-1; Fri, 08 Nov 2024 05:40:56 -0500
X-MC-Unique: 98HbgVCuPgO2f3EK5BbrdQ-1
X-Mimecast-MFC-AGG-ID: 98HbgVCuPgO2f3EK5BbrdQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43159603c92so13717825e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062455; x=1731667255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0oQh4hs+ahIQ4W1afqG0+5AfGIPhbq8psBrgytlA0c=;
        b=uf341gFPbxq2QMmb14PthKBvutq3E9FLERpLbbkDOiY84VHPnzq7lXX5yZa8RclobO
         xBUq1ONiFxhT7UcAdzsrvgoHVrmX3zhDBB5Gl26jvpqkNL0kn4Ow1PYQM1+QGOUvSAnI
         TD+UfsyrIzVjHjVP6I45dJFIigoKAyPxmzw9M/pO3l663RN5DYWDkkjBO+5d7VIEIAd8
         LUvAc7d9+FRssBDHq8TbINgmMBByB/PpdR0kuk2/uBhW8iW9wWB3flv7be9Vn16Pe/GL
         urjv9C+sUzXjo4yx+rv0mczU4HXGcUdBI01bIillUcngXdgc780Os5nCrgpFnPlnBY4q
         NNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFjDkcXVJKQDsPo126UgjI0fFq73dzC1fFzHC9x6oi/HQofqtkpPx8E5v+29N0b3P0spBZ+oWJvTIAxK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxklonPQiPkbqGg6E5kIntXefC1yp9KHObYj42F0XcLyzMx6kvT
	LHulymLVJ4/E86nf5wQgj3OLJZR6YZwiMqjSfQKJxFgwGKLNs+EXGCFCPuis4dlTGdOFTt+QflN
	dKj0i+OCkwDAnJe5eaeZsDedWHsXPp8dt3GGCXJJuKTeMtMI5cIPlj8YVzQU1NdqqinZY/Q==
X-Received: by 2002:a05:600c:4709:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-432b7503496mr17574885e9.13.1731062454828;
        Fri, 08 Nov 2024 02:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFoAq7ASw38j6nntrWcenSQJl/hhMmgehrQLdne2WnBG7JE60MCCEAxltP1L99pQwNf/PeWQ==
X-Received: by 2002:a05:600c:4709:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-432b7503496mr17574695e9.13.1731062454445;
        Fri, 08 Nov 2024 02:40:54 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c1298sm94598435e9.24.2024.11.08.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:40:53 -0800 (PST)
Date: Fri, 8 Nov 2024 11:40:51 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <Zy3qszfGHO5PUa6W@jlelli-thinkpadt14gen4.remote.csb>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
 <20241104174109.GA1044726@google.com>
 <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
 <74c126bc-911f-45fc-b024-815e134c97cf@redhat.com>
 <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3833509d-e0c1-4fc4-874f-5a10fe3f1633@redhat.com>

On 07/11/24 23:40, Waiman Long wrote:
> On 11/6/24 1:05 PM, Waiman Long wrote:
> > On 11/6/24 11:08 AM, Juri Lelli wrote:
> > > On 04/11/24 17:41, Joel Fernandes wrote:
> > > > On Mon, Nov 04, 2024 at 11:54:36AM +0100, Juri Lelli wrote:
> > > ...
> > > 
> > > > > I added a printk in __dl_server_attach_root which is called after the
> > > > > dynamic rd is built to transfer bandwidth to it.
> > > > > 
> > > > > __dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
> > > > > server interface"), do you have this change in your backport?
> > > > You nailed it! Our 5.15 backport appears to be slightly older
> > > > and is missing
> > > > this from topology.c as you mentioned. Thanks for clarifying!
> > > > 
> > > > 
> > > >          /*
> > > >           * Because the rq is not a task,
> > > > dl_add_task_root_domain() did not
> > > >           * move the fair server bw to the rd if it already started.
> > > >           * Add it now.
> > > >           */
> > > >          if (rq->fair_server.dl_server)
> > > > __dl_server_attach_root(&rq->fair_server, rq);
> > > > 
> > > > > > So if rd changes during boot initialization, the correct
> > > > > > dl_bw has to be
> > > > > > updated AFAICS. Also if cpusets are used, the rd for a
> > > > > > CPU may change.
> > > > > cpusets changes are something that I still need to double check. Will
> > > > > do.
> > > > > 
> > > > Sounds good, that would be good to verify.
> > > So, I played a little bit with it and came up with a simple set of ops
> > > that point out an issue (default fedora server install):
> > > 
> > > echo Y >/sys/kernel/debug/sched/verbose
> > > 
> > > echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control
> > > 
> > > echo 0-7 > /sys/fs/cgroup/user.slice/cpuset.cpus
> > > echo 6-7 > /sys/fs/cgroup/user.slice/cpuset.cpus.exclusive
> > > echo root >/sys/fs/cgroup/user.slice/cpuset.cpus.partition
> > > 
> > > The domains are rebuilt correctly, but we end up with a null total_bw.
> > > 
> > > The conditional call above takes care correctly of adding back dl_server
> > > per-rq bandwidth when we pass from the single domain to the 2 exclusive
> > > ones, but I noticed that we go through partition_sched_domains_locked()
> > > twice for a single write of 'root' and the second one, since it's not
> > > actually destroying/rebuilding anything, is resetting total_bw w/o
> > > addition dl_server contribution back.
> > > 
> > > Now, not completely sure why we need to go through partition_sched_
> > > domains_locked() twice, as we have (it also looked like a pattern from
> > > other call paths)
> > > 
> > > update_prstate()
> > > -> update_cpumasks_hier()
> > >     -> rebuild_sched_domains_locked() <- right at the end
> > > -> update_partition_sd_lb()
> > >     -> rebuild_sched_domains_locked() <- right after the above call
> > > 
> > > Removing the first call does indeed fix the issue and domains look OK,
> > > but I'm pretty sure I'm missing all sort of details and corner cases.
> > > 
> > > Waiman (now Cc-ed), maybe you can help here understanding why the two
> > > back to back calls are needed?
> > 
> > Thanks for letting me know about this case.
> > 
> > I am aware that rebuild_sched_domains_locked() can be called more than
> > once. I have addressed the hotplug case, but it can happen in some other
> > corner cases as well. The problem with multiple
> > rebuild_sched_domains_locked() calls is the fact that intermediate ones
> > may be called where the internal states may not be consistent. I am
> > going to work on a fix to this issue by making sure that
> > rebuild_sched_domains_locked() will only be called once.
> 
> I am working on a set of cpuset patches to eliminate redundant
> rebuild_sched_domains_locked() calls. However, my cpuset test script fails
> after the change due to the presence of test cases where the only CPU in a
> 1-cpu partition is being offlined. So I sent out a sched/deadline patch [1]
> to work around this particular corner case.
> 
> [1]
> https://lore.kernel.org/lkml/20241108042924.520458-1-longman@redhat.com/T/#u
> 
> Apparently, the null total_bw bug caused by multiple
> rebuild_sched_domains_locked() calls masks this problem.
> 
> Anyway, I should be able to post the cpuset patch series next week after
> further testing. Please review my sched/deadline patch to see if you are OK
> with this minor change.

Thank you! Will take a look.

Best,
Juri



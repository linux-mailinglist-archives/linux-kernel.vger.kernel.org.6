Return-Path: <linux-kernel+bounces-398561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645149BF2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48CB1F243DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692B2206519;
	Wed,  6 Nov 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iI/Bm03R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05985189F5C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909313; cv=none; b=OE3fZf9qMbF44cgOiiWZD1nwf6ma8d41a3hNqNYQYF/1HEDyruODV+XHm6jXtrucoQUEiMGdHsYTN605v9IiZJXF24Kh0vVmhq041UrvUq7T1jG37zN5FIXYLYvN4TpELJ9EHjKTtpOINZnO+L6E6tg9T4bnSAbSXFiMeSrcOIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909313; c=relaxed/simple;
	bh=n0xRcBe0rIsVQ1363YpVYQ//vPK33a4m4GsHEeT6hog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXMk34WmkM8lD16RkiGKV4K1Q+ntptuNtZtYqTQ5QO9k2xbQOiS3VPewaK+moDrm/iMtaSenUma63P9mYYcRxsCrhXkt0RPH/lhYr9/H0VnsNSQcQHxDyL7T7AGn3usNry4fjFD9iaC3tMYT3oazMEKO+74RSV+bX4DhvAbVhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iI/Bm03R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730909309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtktfGJOSu4yP8vXJE1RmnBu/n+VHlAgoAhCDtbar/M=;
	b=iI/Bm03RZtNg+/H7lqo7FoXM0AS7moTpN6J33sBVgHTyX4gQUCXqFBqHQXhwbtLZomeqym
	D5OUvG8Sgc5NIoaGmtYFpN7htuT/8utA7DjiUt9JQnkuLfST4qgaiOF6sUJQ8OqH4Db0vC
	VDh2XfRLFG8rjonu4BFtR8RzDgVqp9o=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-vSQnOx1sOg2QXeuDjxv4KA-1; Wed, 06 Nov 2024 11:08:25 -0500
X-MC-Unique: vSQnOx1sOg2QXeuDjxv4KA-1
X-Mimecast-MFC-AGG-ID: vSQnOx1sOg2QXeuDjxv4KA
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3e6587f103bso4472371b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 08:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730909303; x=1731514103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtktfGJOSu4yP8vXJE1RmnBu/n+VHlAgoAhCDtbar/M=;
        b=Iz0fcAAOQRSnds3gEFj0ZNBNRMcQPAkvNCU2OULKrrQtLHFWt2q9uzCEgR5jy84paH
         w24ivVW3Ei/T+m0PKfGKdO5/DCyHR7oGoMWI29905Adlj5W+oQmgP2gtSYn/MTe7G7GU
         RtZXdfkvo+QSwokYEvUiCLdR3o8kkP7doOqcj3xKoE+c+YBw7obhO2rNEdL0mvcj7UdP
         CaS2Qkka9SWy9Z6uFqalzNkTI2aKLvoReRpCHhJ0tJK2SUs1gTP4hSx+IiVmoZa5Trel
         bDM+EhxtJhakjjSScYqHH754RQ/HXes0VOujkECDl6qaw1+HQFc/njn8wF2Uy5kbNjyH
         96Ag==
X-Gm-Message-State: AOJu0YyNIeK7DwxC7vY4JgD9x1ZjdXR6tD1VzbXm22XrFJ572g+7459Z
	MjlvVEVWUqSKzWFT6EbHMkMQT5ePHk25psMz+AzeljXcQD9BWukmcHBEH95WSiHRDh682cY3pMy
	k1f7/u9Dzubzo4eD17EjAmUQOCLpIoGsuVJAIailKO8eYPbd7lnGCNCU+ylZ5XA==
X-Received: by 2002:a05:6808:2023:b0:3e6:b47:6226 with SMTP id 5614622812f47-3e758c4be90mr19099643b6e.27.1730909303571;
        Wed, 06 Nov 2024 08:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRwQG9IyzATA4SoiRH7kwIVlnMSE+WwDnNnWWqZnN8xxFintYiC+5HL3aDsUu7eDxWGtmMwQ==
X-Received: by 2002:a05:6808:2023:b0:3e6:b47:6226 with SMTP id 5614622812f47-3e758c4be90mr19099603b6e.27.1730909303245;
        Wed, 06 Nov 2024 08:08:23 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e66119120dsm3024857b6e.12.2024.11.06.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 08:08:22 -0800 (PST)
Date: Wed, 6 Nov 2024 17:08:16 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Joel Fernandes <joel@joelfernandes.org>
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
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH] dl_server: Reset DL server params when rd changes
Message-ID: <ZyuUcJDPBln1BK1Y@jlelli-thinkpadt14gen4.remote.csb>
References: <20241029225116.3998487-1-joel@joelfernandes.org>
 <ZyJC9MkbPeF9_rdP@jlelli-thinkpadt14gen4.remote.csb>
 <20241030195017.GA4171541@google.com>
 <Zyin7P2WNZMM40tp@jlelli-thinkpadt14gen4.remote.csb>
 <20241104174109.GA1044726@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104174109.GA1044726@google.com>

On 04/11/24 17:41, Joel Fernandes wrote:
> On Mon, Nov 04, 2024 at 11:54:36AM +0100, Juri Lelli wrote:

...

> > I added a printk in __dl_server_attach_root which is called after the
> > dynamic rd is built to transfer bandwidth to it.
> > 
> > __dl_server_attach_root came with d741f297bceaf ("sched/fair: Fair
> > server interface"), do you have this change in your backport?
> 
> You nailed it! Our 5.15 backport appears to be slightly older and is missing
> this from topology.c as you mentioned. Thanks for clarifying!
> 
> 
>         /*
>          * Because the rq is not a task, dl_add_task_root_domain() did not
>          * move the fair server bw to the rd if it already started.
>          * Add it now.
>          */
>         if (rq->fair_server.dl_server)
>                 __dl_server_attach_root(&rq->fair_server, rq);
> 
> > 
> > > So if rd changes during boot initialization, the correct dl_bw has to be
> > > updated AFAICS. Also if cpusets are used, the rd for a CPU may change.
> > 
> > cpusets changes are something that I still need to double check. Will
> > do.
> > 
> 
> Sounds good, that would be good to verify.

So, I played a little bit with it and came up with a simple set of ops
that point out an issue (default fedora server install):

echo Y >/sys/kernel/debug/sched/verbose

echo +cpuset >/sys/fs/cgroup/cgroup.subtree_control

echo 0-7 > /sys/fs/cgroup/user.slice/cpuset.cpus
echo 6-7 > /sys/fs/cgroup/user.slice/cpuset.cpus.exclusive
echo root >/sys/fs/cgroup/user.slice/cpuset.cpus.partition

The domains are rebuilt correctly, but we end up with a null total_bw.

The conditional call above takes care correctly of adding back dl_server
per-rq bandwidth when we pass from the single domain to the 2 exclusive
ones, but I noticed that we go through partition_sched_domains_locked()
twice for a single write of 'root' and the second one, since it's not
actually destroying/rebuilding anything, is resetting total_bw w/o
addition dl_server contribution back.

Now, not completely sure why we need to go through partition_sched_
domains_locked() twice, as we have (it also looked like a pattern from
other call paths)

update_prstate()
-> update_cpumasks_hier()
   -> rebuild_sched_domains_locked() <- right at the end
-> update_partition_sd_lb()
   -> rebuild_sched_domains_locked() <- right after the above call

Removing the first call does indeed fix the issue and domains look OK,
but I'm pretty sure I'm missing all sort of details and corner cases.

Waiman (now Cc-ed), maybe you can help here understanding why the two
back to back calls are needed?

Thanks!
Juri



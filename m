Return-Path: <linux-kernel+bounces-311348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3E9687E1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382741C21F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ADA19C555;
	Mon,  2 Sep 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2lKK3uG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14CE19E996
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281382; cv=none; b=eRqCVyx3gBZan79s7L1WqZbTIQ9YKefAk/NoeCq0Z1h0Bvid60l5FcYX3hmSKeHmDOasC58+G0+hTqmZmiXy9UjiPPk/XUXN2fmiMJvxbbW3FKHdD751qe9PTvJ2WeMtD4efuoqJN3RkP9ZqiIfe/C8kn7W/cZ1N1Fk2kC4rQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281382; c=relaxed/simple;
	bh=kvPbNxYKzekbaZmz6AS0Frr3oZAf08qHiN4HijB5ieQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxRyCuQTL4bRZFa6Jb8Coi//XH4KMD2lKNnGxDB/7vJLrI/8gppkySrOp39W0rUy+bRDeW2uDVlup0IT+tC9rj1MYt19ysjBzm3m7jh18q68uAfiwfTcG9pm5p5BcMVcsKF/EAWhaCcg5LJgMN4Cw47D1QQRNFChrgyn7mNkPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2lKK3uG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725281378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Va9NV6iKOWa6GEbBZj1bvfHyhw5LTJFD4PO+jf8FBf4=;
	b=U2lKK3uGXpunptWBeXhXmb1JIXg9MaKaZC0DjWWDIfSQJulNaiYBJLmmaNgG1UUdS/kReP
	i4cIlEDBrgM0jhLfVKFujanAFtyNplHMrabOtqbrkhGf1zfAtApKzA1o+hZnWDP5tQ3N68
	yzylzv6h85Q4H4oTNlFpKJ939PSWNkE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-YQzMYN1MPTWwfNZP77-8bQ-1; Mon, 02 Sep 2024 08:49:37 -0400
X-MC-Unique: YQzMYN1MPTWwfNZP77-8bQ-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3df3ae0d9c5so1501441b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:49:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725281377; x=1725886177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Va9NV6iKOWa6GEbBZj1bvfHyhw5LTJFD4PO+jf8FBf4=;
        b=uD9myl93S0PF1YQCKQ8HVKP7UqouOk92dOITadeHUa3hgIG6YkdrP+CIrcqxIWl5Ok
         gYCr8OEZK0zK/IbvdPp/Owc8LNaDZrTW2V/Fx+s+bXeCuUA5A4/R3FKItWvb1sUksMmt
         FXnR/Am+YLz16X4ryLdWOqeq+VpKkaju4q8E0iDyMn5iMkwXEjNirfPOzSj43MabjMMR
         ma9gm6oOnXzsP+GUOHNfqd5HV8oraYvIbG78wtMiquRz2CFGlZbWGpe6QH6kG40hyMYY
         1BhTFuuqLA6cvkDecI8cS52hqKhRbt+J8cPa3rwgfj+vdE9vnpGqiCaW2WtIjUUlCz/B
         e0hw==
X-Forwarded-Encrypted: i=1; AJvYcCU6kztW6p9zdtoIgPaJ5BNyb+AEDtxfdXeO+4sUdTuk/mJhh6xCHMLGvKb7OQmh5gxl15jJT0E6HvT13W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN81dAd9SKkIIuISzpZnORXGsjplxsNrGLJUMmHaxESCjeI6SN
	qp4f7TdDDEH+bNe1CDB/qyDDCSI56fafNMtay7K6nRlUgeDoabLStXc0slDgnGR8M9p8mvGQB/G
	GQzFsm/hNkhqrNU38kNEAzegrAOT1H5JO6W1oiu6yx7UiFjpiJsXl7LAOyElyqg==
X-Received: by 2002:a05:6808:2002:b0:3d9:ed9e:ae1 with SMTP id 5614622812f47-3df05dbe279mr15063312b6e.28.1725281376988;
        Mon, 02 Sep 2024 05:49:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaouNfdmYeH+q22cUCfWz3yzC9CuGenSG+Ad/d6Hp4IcOduOqqwQiDH7gVDifxdleYYw8qxA==
X-Received: by 2002:a05:6808:2002:b0:3d9:ed9e:ae1 with SMTP id 5614622812f47-3df05dbe279mr15063301b6e.28.1725281376636;
        Mon, 02 Sep 2024 05:49:36 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.33.125])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682ca8aa4sm39518781cf.34.2024.09.02.05.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:49:36 -0700 (PDT)
Date: Mon, 2 Sep 2024 14:49:31 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, mingo@redhat.com,
	patches@amperecomputing.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, vineeth@bitbyteword.org,
	bristot@kernel.org, linux-kernel@vger.kernel.org,
	hongyan.xia2@arm.com
Subject: Re: [PATCH v3] sched/deadline: fix the hang in dl_task_of
Message-ID: <ZtW0W9EQrMOV4eeo@jlelli-thinkpadt14gen4.remote.csb>
References: <20240829031111.12142-1-shijie@os.amperecomputing.com>
 <ZtAtymo-KB9c20Q8@jlelli-thinkpadt14gen4.remote.csb>
 <20240902111446.GG4723@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902111446.GG4723@noisy.programming.kicks-ass.net>

On 02/09/24 13:14, Peter Zijlstra wrote:
> On Thu, Aug 29, 2024 at 10:14:02AM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 29/08/24 11:11, Huang Shijie wrote:
> > > When we enable the schedstats, we will meet an OS hang like this:
> > >   --------------------------------------------------------
> > > 	[  134.104253] kernel BUG at kernel/sched/deadline.c:63!
> > > 	[  134.132013] ------------[ cut here ]------------
> > > 	[  134.133441]  x27: 0000000000000001
> > > 	[  134.138048] kernel BUG at kernel/sched/deadline.c:63!
> > > 	[  134.146478] x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000001
> > > 	[  134.153607] x23: 0000000000000001 x22: 0000000000000000 x21: 0000000000000001
> > > 	[  134.160734] x20: ffff007dbf1b6d00 x19: ffff007dbf1b7610 x18: 0000000000000014
> > > 	[  134.162027] ------------[ cut here ]------------
> > > 	[  134.167861] x17: 000000009deab6cd x16: 00000000527c9a1c x15: 00000000000000dc
> > > 	[  134.172473] kernel BUG at kernel/sched/deadline.c:63!
> > > 	[  134.179595] x14: 0000000001200011 x13: 0000000040001000 x12: 0000ffffb6df05bc
> > > 	[  134.191760] x11: ffff007dbf1b6d00 x10: ffff0001062dd2e8 x9 : ffff8000801215ac
> > > 	[  134.192036] ------------[ cut here ]------------
> > > 	[  134.198888] x8 : 0000000000000000 x7 : 0000000000000021 x6 : ffff0001764ed280
> > > 	[  134.203498] kernel BUG at kernel/sched/deadline.c:63!
> > > 	[  134.210622] x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff807d3dd24000
> > > 	[  134.222787] x2 : 000000028b77a140 x1 : 0000003400000000 x0 : ffff007dbf1b6c80
> > > 	[  134.229915] Call trace:
> > > 	[  134.232353]  dl_task_of.part.0+0x0/0x10
> > > 	[  134.236182]  dl_server_start+0x54/0x158
> > > 	[  134.240013]  enqueue_task_fair+0x138/0x420
> > > 	[  134.244100]  enqueue_task+0x44/0xb0
> > > 	[  134.247584]  wake_up_new_task+0x1c0/0x3a0
> > > 	[  134.251584]  kernel_clone+0xe8/0x3e8
> > > 	[  134.252022] ------------[ cut here ]------------
> > > 	[  134.255156]  __do_sys_clone+0x70/0xa8
> > > 	[  134.259764] kernel BUG at kernel/sched/deadline.c:63!
> > > 	[  134.263412]  __arm64_sys_clone+0x28/0x40
> > > 	[  134.272360]  invoke_syscall+0x50/0x120
> > > 	[  134.276101]  el0_svc_common+0x44/0xf8
> > > 	[  134.279753]  do_el0_svc+0x28/0x40
> > > 	[  134.283058]  el0_svc+0x40/0x150
> > > 	[  134.286195]  el0t_64_sync_handler+0x100/0x130
> > > 	[  134.290546]  el0t_64_sync+0x1a4/0x1a8
> > > 	[  134.294200] Code: 35ffffa2 17ffffe3 d4210000 17ffffb4 (d4210000)
> > > 	[  134.300283] ---[ end trace 0000000000000000 ]---
> > > 	[  134.304890] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > > 	[  134.311147] SMP: stopping secondary CPUs
> > > 	[  135.365096] SMP: failed to stop secondary CPUs 8-9,16,30,43,86,88,121,149
> > > 	[  135.371884] Kernel Offset: disabled
> > > 	[  135.375361] CPU features: 0x00,00100003,80153d29,d75ffea7
> > > 	[  135.380749] Memory Limit: none
> > > 	[  135.383793] ---[ end Kernel panic - not syncing: Oops - BUG: Fatal exception ]
> > >   --------------------------------------------------------
> > > 
> > > In dl_server_start(), we set the dl_se->dl_server with 1. When schedstats
> > > is enabled, in the following:
> > >    dl_server_start() --> enqueue_dl_entity() --> update_stats_enqueue_dl()
> > > 	__schedstats_from_dl_se() -->dl_task_of()
> > > 
> > > we will meet the BUG_ON.
> > > 
> > > Since the fair task has already had its own schedstats, there is no need
> > > to track anything for the associated dl_server.
> > > 
> > > So add check in:
> > >             update_stats_wait_start_dl()
> > > 	    update_stats_wait_end_dl()
> > > 	    update_stats_enqueue_dl()
> > > 	    update_stats_dequeue_dl()
> > > 
> > > return early for a dl_server dl_se.
> > > 
> > > Tested this patch with memcached in Altra.
> > > 
> > > Fixes: 5f6bd380c7bd ("sched/rt: Remove default bandwidth control")
> > > Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> > > ---
> > > v2 --> v3:
> > >    Return early in:
> > >             update_stats_wait_start_dl()
> > > 	    update_stats_wait_end_dl()
> > > 	    update_stats_enqueue_dl()
> > > 	    update_stats_dequeue_dl()
> > 
> > This looks better, thanks.
> > 
> > Peter, what do you think?
> 
> Peter thinks that the Changelog is overly verbose, the Fixes tag is
> wrong and he doesn't much like the repeated conditions. But he is very
> glad this issue is found and fixed.

:)

> As such, he's rewritten things like so, does this work for people?

Works for me!

> ---
> Subject: sched/deadline: Fix schedstats vs deadline servers
> From: Huang Shijie <shijie@os.amperecomputing.com>
> Date: Thu, 29 Aug 2024 11:11:11 +0800
> 
> From: Huang Shijie <shijie@os.amperecomputing.com>
> 
> In dl_server_start(), when schedstats is enabled, the following
> happens:
> 
>   dl_server_start()
>     dl_se->dl_server = 1;
>     enqueue_dl_entity()
>       update_stats_enqueue_dl()
>         __schedstats_from_dl_se()
>           dl_task_of()
>             BUG_ON(dl_server(dl_se));
> 
> Since only tasks have schedstats and internal entries do not, avoid
> trying to update stats in this case.
> 
> Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
> Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20240829031111.12142-1-shijie@os.amperecomputing.com

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri



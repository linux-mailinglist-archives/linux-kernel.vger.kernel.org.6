Return-Path: <linux-kernel+bounces-519608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0285BA39E94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A38C1897396
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658426A0A0;
	Tue, 18 Feb 2025 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRXlK96h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A2269D1B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888327; cv=none; b=uDzHK5XGgnw7HFHhesgOOIbQ0aWlrrYY7BCkiIsdhz0m89/gxOqDKuYMJaNyZhlZhEbvRUZUC/uu7Yt2Wm7wCKQKx8Ad3pI0UeNrnXP613FntDAEg8ZQmkoeV5PJD3Hs6Sm+2qB7kALmr8EukPCoVMIT1T7ii+VEqmH151zPGOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888327; c=relaxed/simple;
	bh=Ylh6BzLP55i04wVfiFq0UdGu/ctOqdofDLlmv68+FsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgTrphHSJAnf2s3rFsczQMuhUDJescQj9t7u2Hpfuae2rZUEoNwOeKhIcS+hk5FEslgGoGyBQMzo2HU0mDU3Eq6kTY8WaiXcErGcozWkWzCwuGLzg1zWsWJqFcijgrATa7PWs+4R8AD/BOFE2i33jCEyLDo9zrshX1Ul3kCM4Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRXlK96h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739888324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DBhsPO91wIOuIx7V5POaYr34tBMgM6YIQ+GqBqORH08=;
	b=bRXlK96hUDR5bzmcPbOPpjiXxn2RIpXJlb7bM/p0Aw9YMVXB5V7wKn2n7KRKLLyp7INYLY
	dLpBojmaqZ6GdarV6hRZRp0DqixPpddOWnv5vUkc7SSFfurS4uPzPiVOWTI+qY2IA/U1OQ
	6lRdEjDAmB1rWZbJI3caa+lXYHaBzd4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-RNr94hMnPU6g3ntB6LjTUQ-1; Tue, 18 Feb 2025 09:18:43 -0500
X-MC-Unique: RNr94hMnPU6g3ntB6LjTUQ-1
X-Mimecast-MFC-AGG-ID: RNr94hMnPU6g3ntB6LjTUQ_1739888322
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-439385b08d1so48560445e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:18:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739888322; x=1740493122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBhsPO91wIOuIx7V5POaYr34tBMgM6YIQ+GqBqORH08=;
        b=MWEpbaid4FeHZSxSX0oHqU6zyqGXBLTH4AY/ZPcACUasyvPnmU5ZrarNDbrcW8MshS
         0Ow9LK9vF/XWlnG4AjAwSjT8f02xFl2jC4QdPc42yFlEShqpx1E3FolrZs+jTurLs2sT
         EpZZRA9V3RL8ww24nHxu8s/1AXnIDnUz00cubrtEKIw+x+AdqIC2YmzNxjgKflsTGWKM
         sp2y5aQDzUpPb6vVX+c+/WJgTtrhttp6WIoEOvPvIus9JXpcojLZrHIpwKgOfBo3GhCz
         pgjoFFy/3+StqzpO8EpNpkC+9ljKs7/NTsqjK+ZyJp7MFf8MnmREmdn6WpzPrYbcRbha
         qUWg==
X-Forwarded-Encrypted: i=1; AJvYcCXLQJKWNyunHMau4lJpz/pf9CqVnkI6SYcOaTeT+CvoaZ/yhTp9nCc3YLz0byuvAc07p+4N31c76i9noIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxLLAgaln734jelWf3RSNJtK6LnDtvIoVp/Xe8YY0+psfbuPa
	k7Ezb26sH17WykWrT4HdVf+TaFRlp0aEzbbydATIfN8svVNBWHn20LDcuv/sAggi+yyupwmWwv2
	v0i2Kcm8cEputSuzzl3DnhOvmCVgTBNpoKofImga9GRlX8lf20O0cfIECiBlkeg==
X-Gm-Gg: ASbGncvdcdSE2RwbUzflyDisQb5rgtpWN93GGrcRZqMB3l1N0CWVZMi/5nPFXy3b6yD
	RF3kxN4rjfu4U040ehvMg5aaL2r/9YeFO4nCZQTKn+OabAceTCqhvVOKK0sdUaFcwo4FC95lh4F
	0633uW8IUT4BM0my0nI1kvlpDzcAKH/TrzVjuAYiMYMdg9LOHD99p6OR8S7dtbpWuIMKXBm1uKA
	ihZydMrIWEqPVhzisMd1vbNXGO50sLybX3yEh+z14i7H5I1br1KKXJ6JraI02cGI9RwbKAnB8Es
	Ho8/LPFaIUCgnQfLZjP41CWUsE76qiXOTg==
X-Received: by 2002:a05:600c:4f03:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-4396e6978f1mr108096635e9.2.1739888321808;
        Tue, 18 Feb 2025 06:18:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHz+8srgi2drXTmMyM1NYHrwhlKtyRHpPGxtjZL4L3zCFR0eLaPU7DhmwvLMH2MoF6LIUl/tw==
X-Received: by 2002:a05:600c:4f03:b0:438:a240:c63 with SMTP id 5b1f17b1804b1-4396e6978f1mr108096425e9.2.1739888321363;
        Tue, 18 Feb 2025 06:18:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8471sm185070475e9.37.2025.02.18.06.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 06:18:40 -0800 (PST)
Date: Tue, 18 Feb 2025 15:18:38 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
References: <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>

On 18/02/25 15:12, Dietmar Eggemann wrote:
> On 18/02/2025 10:58, Juri Lelli wrote:
> > Hi!
> > 
> > On 17/02/25 17:08, Juri Lelli wrote:
> >> On 14/02/25 10:05, Jon Hunter wrote:
> > 
> > ...
> > 
> >> At this point I believe you triggered suspend.
> >>
> >>> [   57.290150] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
> >>> [   57.335619] tegra-xusb 3530000.usb: Firmware timestamp: 2020-07-06 13:39:28 UTC
> >>> [   57.353364] dwc-eth-dwmac 2490000.ethernet eth0: Link is Down
> >>> [   57.397022] Disabling non-boot CPUs ...
> >>
> >> Offlining CPU5.
> >>
> >>> [   57.400904] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4 type=DYN span=0,3-5
> >>> [   57.400949] CPU0 attaching NULL sched-domain.
> >>> [   57.415298] span=1-2
> >>> [   57.417483] __dl_sub: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> >>> [   57.417487] __dl_server_detach_root: cpu=0 rd_span=0,3-5 total_bw=157284
> >>> [   57.417496] rq_attach_root: cpu=0 old_span=NULL new_span=1-2
> >>> [   57.417501] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0-2 type=DEF
> >>> [   57.417504] __dl_server_attach_root: cpu=0 rd_span=0-2 total_bw=157284
> >>> [   57.417507] CPU3 attaching NULL sched-domain.
> >>> [   57.454804] span=0-2
> >>> [   57.456987] __dl_sub: cpus=2 tsk_bw=52428 total_bw=104856 span=3-5 type=DYN
> >>> [   57.456990] __dl_server_detach_root: cpu=3 rd_span=3-5 total_bw=104856
> >>> [   57.456998] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> >>> [   57.457000] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0-3 type=DEF
> >>> [   57.457003] __dl_server_attach_root: cpu=3 rd_span=0-3 total_bw=209712
> >>> [   57.457006] CPU4 attaching NULL sched-domain.
> >>> [   57.493964] span=0-3
> >>> [   57.496152] __dl_sub: cpus=1 tsk_bw=52428 total_bw=52428 span=4-5 type=DYN
> >>> [   57.496156] __dl_server_detach_root: cpu=4 rd_span=4-5 total_bw=52428
> >>> [   57.496162] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> >>> [   57.496165] __dl_add: cpus=5 tsk_bw=52428 total_bw=262140 span=0-4 type=DEF
> >>> [   57.496168] __dl_server_attach_root: cpu=4 rd_span=0-4 total_bw=262140
> >>> [   57.496171] CPU5 attaching NULL sched-domain.
> >>> [   57.532952] span=0-4
> >>> [   57.535143] rq_attach_root: cpu=5 old_span= new_span=0-4
> >>> [   57.535147] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> >>
> >> Maybe we shouldn't add the dl_server contribution of a CPU that is going
> >> to be offline.
> > 
> > I tried to implement this idea and ended up with the following. As usual
> > also pushed it to the branch on github. Could you please update and
> > re-test?
> > 
> > Another thing that I noticed is that in my case an hotplug operation
> > generating a sched/root domain rebuild ends up calling dl_rebuild_
> > rd_accounting() (from partition_and_rebuild_sched_domains()) which
> > resets accounting for def and dyn domains. In your case (looking again
> > at the last dmesg you shared) I don't see this call, so I wonder if for
> > some reason related to your setup we do the rebuild by calling partition_
> > sched_domains() (instead of partition_and_rebuild_) and this doesn't
> > call dl_rebuild_rd_accounting() after partition_sched_domains_locked() -
> > maybe it should? Dietmar, Christian, Peter, what do you think?
> 
> Yeah, looks like suspend/resume behaves differently compared to CPU hotplug.
> 
> On my Juno [L b b L L L]
>                 ^^^
>                 isolcpus=[2,3]
> 
> # ps2 | grep DLN
>    98    98 S 140      0   - DLN sugov:0
>    99    99 S 140      0   - DLN sugov:1
> 
> # taskset -p 98; taskset -p 99
> pid 98's current affinity mask: 39
> pid 99's current affinity mask: 6
> 
> 
> [   87.679282] partition_sched_domains() called
> ...
> [   87.684013] partition_sched_domains() called
> ...
> [   87.687961] partition_sched_domains() called
> ...
> [   87.689419] psci: CPU3 killed (polled 0 ms)
> [   87.689715] __dl_bw_capacity() mask=2-5 cap=1024
> [   87.689739] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
> [   87.689757] dl_bw_manage: cpu=2 cap=0 fair_server_bw=52428
> total_bw=209712 dl_bw_cpus=1 type=DEF span=2-5
> [   87.689775] dl_bw_cpus() cpu=6 rd->span=2-5 cpu_active_mask=0-2 cpus=1
> [   87.689789] dl_bw_manage() cpu=2 cap=0 overflow=1 return=-16
> [   87.689864] Error taking CPU2 down: -16                       <-- !!!
> ...
> [   87.690674] partition_sched_domains() called
> ...
> [   87.691496] partition_sched_domains() called
> ...
> [   87.693702] partition_sched_domains() called
> ...
> [   87.695819] partition_and_rebuild_sched_domains() called
> 

Ah, OK. Did you try with my last proposed change?



Return-Path: <linux-kernel+bounces-517887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA03A38702
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D793ACEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079A12248AA;
	Mon, 17 Feb 2025 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ki9qLwQ2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127C2248AC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803943; cv=none; b=l1vTZjX2F/WLPhOj/PFJ2nT6y6li9wIJXr3yfy/gRbwjgGZ5wKtYAqWEf7jliP8DJVdH3ViiI1YwAFX/4Lf/2p19Ms32YzZssZ/jVQ9FDQbW4xfE3pLc4WqSCqVuyYUtYNAmTb53adaPhSclvcPxovEKzGu0pWTUjqrygp4Bj7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803943; c=relaxed/simple;
	bh=BzzPH2vmywHmqMj2cNHtgj0bNaw6qpjGJ4ryviyDMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwKpW227zDNo9nSHFERVO4giDsr2XVtoRk/wlEOCgaoEzzyrjSgNsBBvM7eP1NMdFp1nZQMt+3MlQgtE620xotucBS14ksHjxFDLDTiwpazZoZ9ZM8b3KwaGbnrPau9VCDq+6FHDkdHHZemTX2+qwZSkZieiGKldfxcRMVyp3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ki9qLwQ2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739803940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n62JfojyMxlNviTaSrgFR+47IrUK3Jnf+u30cXg6IU8=;
	b=Ki9qLwQ2rO6sjEDxW5o3zSehLVUdfcgLny+UPz0CpCfWdLJ63ASQZMAJYa69z0E12MGH3n
	Wdr1Ose6Z2/kBq9YUYkC2DMlULji5ahq1J+wcIkNtRG/DDvRcRjIrLVSMimobTaUgm0NZ1
	aa2aFdBZGfCnC4VD9UrgEMWnT8RqEl8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-JYB3-b6mPTGS3KlVMu7tew-1; Mon, 17 Feb 2025 09:52:18 -0500
X-MC-Unique: JYB3-b6mPTGS3KlVMu7tew-1
X-Mimecast-MFC-AGG-ID: JYB3-b6mPTGS3KlVMu7tew_1739803938
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38f4cce15c8so339224f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739803938; x=1740408738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n62JfojyMxlNviTaSrgFR+47IrUK3Jnf+u30cXg6IU8=;
        b=wFJDFZl6ItcGmWFsjclz7cwAS9w/l0WWMAPb+snF81rPj3IgdrWbBgRzeHBWt+9xck
         hpEEJK2cLQHWBZiPT8Ot+At6FQxFx4UGyzhXk28nYPtduYZL2fkgYJJfrSInM4/c6pDd
         YszQSlhF1r576JSC2j9El3RjpNfG4O1Vc43nZo+lLxEIk0fmdr4cZy5wMNPyc0+w+pmX
         GbdDHWHKA8BX76y5Nd762eZQZ3dvTJvGL+XUwndEzykPfjJsIXURI0mj3J5QuB23InY8
         MdFBq8k8SgjEJZCCtT5Ss27R25XYjrnzPaZ2Y6qGmW4mYehAr6oBYlLAXPjeBBC56Saw
         E3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVtBO+/bcvL7MxXc0gboMmCgeyXRyP7XXa0CeHiFj6+M3g4XKfeO9v/IzDsViEi3y9wLxXSGv67vYQXr28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnsw/lwnQjXqR+FXO4wGD3o34hP1bA71TESqqTvRK5/ZZN2BZI
	iQyicr2HTcf6xtyYiDORAehnnFYSROI2JSTMAKTrDoYLdpWsoCEa848JzY22TTbCrCrZyYlO0ZG
	jjGEyDFzFAZ3mSRtks/Xkxitg9LkSt49wgThHvz6B6DcvuWoMqSkPCOCwXKDGuQ==
X-Gm-Gg: ASbGncusFDodfqtgbsQaYXLYq7uxZ0nU+7Xv4EqGX7rmUiwmXQwZFl/qONLYykSN03m
	64pSCQ5psHDqagD9qDa6TA+786dkllgH2lGQtN/X8pU24An3gGYDAJDPQjqqIOZhVWPtJdn5k0v
	iZaCmVenBsDllQFgjNsqLmpGNv+cj62IIY0gXSq4cs0EPb7gj80t87mlZehaAffrkxPvoTnuwSD
	puugkCSua93C8Zi0A1RqWgQLgBCYadu8fbMpocnGSltFByLdx3WqNRgl7rgN7V/JYa8AkG71Yo5
	mnfMRKD79S68iIWnjMH2LSZJHNuVSH2xjA==
X-Received: by 2002:adf:e387:0:b0:38f:2113:fba0 with SMTP id ffacd0b85a97d-38f34171386mr7355535f8f.50.1739803937760;
        Mon, 17 Feb 2025 06:52:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTVdSBHOISJ5tDzp41H2vIhrlfxz3GOda5fRJNmab4HtNRj85X8u3+oM45gnUlcyd4iGxLMA==
X-Received: by 2002:adf:e387:0:b0:38f:2113:fba0 with SMTP id ffacd0b85a97d-38f34171386mr7355505f8f.50.1739803937339;
        Mon, 17 Feb 2025 06:52:17 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2580fe7dsm12482708f8f.0.2025.02.17.06.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:52:16 -0800 (PST)
Date: Mon, 17 Feb 2025 15:52:14 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Qais Yousef <qyousef@layalina.io>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>,
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
Message-ID: <Z7NNHmGgrEF666W_@jlelli-thinkpadt14gen4.remote.csb>
References: <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <dbd2af63-e9ac-44c8-8bbf-84358e30bf0b@arm.com>
 <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <285a43db-c36d-400e-8041-0566f089a482@arm.com>
 <Z62PPUOY5DClYo1A@jlelli-thinkpadt14gen4.remote.csb>
 <20250216163340.ttwddti5pzuynsj5@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216163340.ttwddti5pzuynsj5@airbuntu>

On 16/02/25 16:33, Qais Yousef wrote:
> On 02/13/25 07:20, Juri Lelli wrote:
> > On 12/02/25 19:22, Dietmar Eggemann wrote:
> > > On 11/02/2025 11:42, Juri Lelli wrote:
> > 
> > ...
> > 
> > > > What about we actually ignore them consistently? We already do that for
> > > > admission control, so maybe we can do that when rebuilding domains as
> > > > well (until we find maybe a better way to deal with them).
> > > > 
> > > > Does the following make any difference?
> > > 
> > > It at least seems to solve the issue. And like you mentioned on irc, we
> > > don't know the bw req of sugov anyway.
> > > 
> > > So with this change we start with 'dl_bw->total_bw = 0' even w/ sugov tasks.
> > > 
> > > dl_rq[0]:
> > >   .dl_nr_running                 : 0
> > >   .dl_bw->bw                     : 996147
> > >   .dl_bw->total_bw               : 0       <-- !
> > > 
> > > IMHO, people who want to run serious DL can always check whether there
> > > are already these infrastructural DL tasks or even avoid schedutil.
> > 
> > It definitely not ideal and admittedly gross, but not worse than what we
> > are doing already considering we ignore sugovs at AC and the current
> > bandwidth allocation its there only to help with PI. So, duck tape. :/
> > 
> > A more proper way to work with this would entail coming up with sensible
> > bandwidth allocation for sugovs, but that's most probably hardware
> > specific, so I am not sure how we can make that general enough.
> 
> I haven't been following the problem closely, but one thing I was considering
> and I don't know if it makes sense to you and could help with this problem too.
> Shall we lump sugov with stopper class or create a new sched_class (seems
> unnecessary, I think stopper should do)? With the consolidate cpufreq update
> patch I've been working on Vincent raised issues with potential new ctx switch
> and to improve that I needed to look at improving sugov wakeup path. If we
> decouple it from DL I think that might fix your problem here and could allow us
> to special case it for other problems like the ones I faced more easily without
> missing up with DL.
> 
> Has the time come to consider retire the simple solution of making sugov a fake
> DL task?

Problem is that 'ideally' we would want to explicitly take sugovs into
account when designing the system. We don't do that currently as a
'temporary solution' that seemed simpler than a proper approach (started
wondering if it's indeed simpler). So, not sure if moving sugovs outside
DL is something we want to do.

Thanks,
Juri



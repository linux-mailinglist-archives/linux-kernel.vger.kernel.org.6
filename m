Return-Path: <linux-kernel+bounces-556019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2411BA5BFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56EFF173FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36345255E3C;
	Tue, 11 Mar 2025 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqTwGj9C"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F5222589
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694389; cv=none; b=H0tUuB+hJnOT6/pu4wZA4jXmNAc61FBuE6IaEhgzSbPVQHotmvd9nJ9RceLAd1f8lUQtThQbL9SycL8jlJYKFtrmB8BTHXf/c4rsMQRtuP64MWzDbfWUDeNK4sNZjYHy9E/UkC8PkLGuR4jQf55qvIskuGjyFe/BDynA46T+IN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694389; c=relaxed/simple;
	bh=6ik8CDdyssom/lcu/O8RGgc/PpkhidUmPdJmCaGldO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZtNBwSHHg24pRmxLh11lDXql8Wpvj0YR3LxDlDScR7A0qd7Yz5qnqc4MOHQRUCEgsdrT/gnGHwB3iPJ+UVx3PyZlRF5woo/mzh4moVRqE4kYH5QyAe5JznTb0Iv9eel44q+QWxLPzxWu4Szfq7Xi2i1R0eGrmNBJrUnYCad4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqTwGj9C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741694386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDKIujl/GD2HW4RyQYl/pH+0c9rxOzqbtce1pc+BO6M=;
	b=aqTwGj9CHkVFVn3DEBlCkxhlU06W8g0emzKte2tBn2ihXl5YSI8FcpHEs5OrrYf7pwYmPw
	i+af9rTlUQd+klYkOLgWXQdiuMUZbwxkNzPLF8rQjBmkwmiZbUZspIq5lmyWWFN9LLcNDT
	mJcwqwhLdI1y7HzRkX+heto3qjrWdDg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-bZtOmGD0NHeGpt81KJ-pZw-1; Tue, 11 Mar 2025 07:59:45 -0400
X-MC-Unique: bZtOmGD0NHeGpt81KJ-pZw-1
X-Mimecast-MFC-AGG-ID: bZtOmGD0NHeGpt81KJ-pZw_1741694384
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-438da39bb69so38012845e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 04:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694384; x=1742299184;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDKIujl/GD2HW4RyQYl/pH+0c9rxOzqbtce1pc+BO6M=;
        b=mzS4iGMuNguKca8HeWFwQRIl5k5/qHxQAV6yOvBtaNDLOugn3/cduhr4LL5WfQ3g3L
         2h/vlI7nHi8OmGahAGuIe8QduQbeL0c/7Jxj2VqErU7A5O2m56ITIay0S5/vnufyJ4tl
         Xd3XmgJhjBgjyZhCjVN22n8R+fklhX+Nmi2BhaclHo5cZg7NtljtLfgFT486bU9rNqid
         JzVS6vGtkDofNLJMDxoUhksIRkfeB8bwqBJv7og0pcP4gurr67u3rZAmtu2Rfz8I8Dno
         8s9Y343kBr6w6E962LFmXlZCY1AXNuQEJ0AlFeRe9tuOXrHx3RXTdtgFM08xAFtVzhdp
         4feA==
X-Forwarded-Encrypted: i=1; AJvYcCWvfqaN/RgJQZhKoiCr0FO2zhgkERzr5i3pDwGn1U5uCtVIc/0l1YaeBbcP/oRG3SIkM2smQ5rpqt6FAgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXFMDG2YCyOXZLDLnJYozhX5G9rNZ/WVYxkOFJt74AcOUzfjEO
	BpBvIG9fq4ZczdQLkTZnk3zIJJu0NRHvy4G3WxZS9snNY3cnYBBKTDHcDvKyR9ca8MpiQSBu7fY
	bhcjPmXFlILKNEwUKK7vAQtGl8lzRX8gmiIe+V5O5Fh1719mZp4C9N4pMKnSJug==
X-Gm-Gg: ASbGnct1MTI0OBZbmspRE2Ak2ne7mVkDtVfFU493Rsp7tUyyGfjGNfTCKhhMQsHlthL
	IogNAW68nlypy8yDt+jitGVk8K2mJ+OdHt+h5CCpLoIg/B0ZMQdax27A89TgRjFIzb9ltgpXVzJ
	vsBw7iCNy6aiWFNjJf2TccagR5SyOhbu/eaP41u3JjlQjSHLcUP+Y4IG1tKNV0s19jgcUJ7Jpxs
	xDkxOJU6uaoP0XGluRLqeCa3WnCTLjWnhbdn19U5ZlMtYR4iI9ZBhKYasK4Bdx3TqSjZRfNbICQ
	fRcvihot129iF4QjOm8aMXc1owH8J+78d/CqW/M5LIY=
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43ceeeeb9e3mr86667185e9.20.1741694384265;
        Tue, 11 Mar 2025 04:59:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO9dgeAbIUcM48A8qtpiJ49dyz1L2I4mkXKwM7z476ZguqAw6Rk7o/AfXg3QYfwBdjPJvv1w==
X-Received: by 2002:a05:600c:4f0c:b0:43c:eeee:b713 with SMTP id 5b1f17b1804b1-43ceeeeb9e3mr86666545e9.20.1741694383075;
        Tue, 11 Mar 2025 04:59:43 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352e29sm206132935e9.32.2025.03.11.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 04:59:42 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:59:39 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>

On 10/03/25 20:16, Waiman Long wrote:
> On 3/10/25 3:18 PM, Waiman Long wrote:
> > 
> > On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
> > > On 10/03/2025 10:37, Juri Lelli wrote:
> > > > Rebuilding of root domains accounting information (total_bw) is
> > > > currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> > > Nit: Couldn't spot any arch dependency here. I guess it was just tested
> > > on Arm64 platforms so far.
> > > 
> > > [...]
> > > 
> > > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > > index 44093339761c..363ad268a25b 100644
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int
> > > > ndoms_new, cpumask_var_t doms_new[],
> > > >       ndoms_cur = ndoms_new;
> > > >         update_sched_domain_debugfs();
> > > > +    dl_rebuild_rd_accounting();
> > > Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
> > > barf when called via cpuhp's:
> > > 
> > > sched_cpu_deactivate()
> > > 
> > >    cpuset_cpu_inactive()
> > > 
> > >      partition_sched_domains()
> > > 
> > >        partition_sched_domains_locked()
> > > 
> > >          dl_rebuild_rd_accounting()
> > > 
> > > ?

Good catch. Guess I didn't notice while testing with LOCKDEP as I was
never able to hit this call path on my systems.

> > Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be
> > called without holding cpuset mutex.
> > 
> > Well, I think we will need an additional wrapper in cpuset.c that
> > acquires the cpuset_mutex first before calling partition_sched_domains()
> > and use the new wrapper in these cases.
> 
> Actually, partition_sched_domains() is called with the special arguments (1,
> NULL, NULL) to reset the domain to a single one. So perhaps something like
> the following will be enough to avoid this problem.

I think this would work, as we will still rebuild the accounting after
last CPU comes back from suspend. The thing I am still not sure about is
what we want to do in case we have DEADLINE tasks around, since with
this I belive we would be ignoring them and let suspend proceed.



Return-Path: <linux-kernel+bounces-551478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC66DA56CE8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA711787C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFC8221543;
	Fri,  7 Mar 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwawaDLs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CE021E088
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363183; cv=none; b=rrMVl0G31kLZcbOn0WbQCOgxUEXJDbBg3d+0K8XgDEpEryQMAUKFidBaYgOm604AOzqd2zALXgwEByfYiSiFvHAVXu0IQIM1qKHYvxN16RpFgPk0/6yosflBkgYmugRlfMZG/42l0gJlPh+pB2b/HhMN+8BA8wK+A1xt+oeAyDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363183; c=relaxed/simple;
	bh=xYH7LSHm5j/GWwqF2OYbRbZazYDy7WN0+uBsOZUgbug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzPKkCx9diNFqMStgR9BstMWgsgKZm5LyBWrjrdJ1RalPneZobDteuIXiyZIicWxEi2c3JiQvBgqDN9dU7bpKdjGTy5RyW8JID9++YgHhuSSgBQ9VfuljsjT50+ucwUiU251PbKsQkMzKVednL5iFthzkDI5Uv8T56cnNCjC/k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwawaDLs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741363180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPYw1VLtMSRwN0ZfuUC08MZa+lggggv7LW9ZP7kVzVw=;
	b=FwawaDLsFvPNvf5I+odwzy9ryKs4D1EfbzBTFsoDy9O3gFrfFIRI0q9in8bkb1MQwmI/9k
	gRudgS8WRgxrQIcycZyl0I8iK1A4NuuorsLcgzp2O6iQp8oowg/WszChFXBPaMkrcA3fCP
	UKXeW8xoyHLBIQGvyqTfsewqRuANVoM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-DCpKPMJXPIWLIThonHUd-A-1; Fri, 07 Mar 2025 10:59:39 -0500
X-MC-Unique: DCpKPMJXPIWLIThonHUd-A-1
X-Mimecast-MFC-AGG-ID: DCpKPMJXPIWLIThonHUd-A_1741363179
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3b53373f7so522271585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363179; x=1741967979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qPYw1VLtMSRwN0ZfuUC08MZa+lggggv7LW9ZP7kVzVw=;
        b=f/4OuvdKnFwAAAEgRZRmZrHzyZbJ+UjnitNC4frFHTU4KUkhsGTeGUERsG3l+KrREG
         m+4I1XhFU7RAATTkdYL5JItTMdVG87VChYPnAdl+TVYsCXgxmza7mOV5oIMJ3dUfb2Oj
         aoNUNp43Xs4Sstkvx3sN8De0Mn7uiZg+wSvkQrzWd/+RvRIl9RMSijavv+UN2Je9JoHg
         Xzkj8+R4JziC3en7sgMyf2qS136mmD8WSjox5wMwT/D5oENW6h2PNlJeP4owy7wErhwb
         wOtAtwVJAv1UM29rssnfPwEB84xbldIDrcyZ7h/yvUPywrEJFkrpn090RdPMhedezJUV
         A/vQ==
X-Gm-Message-State: AOJu0YzuXZqAss8kqghvqXDuDIHksDS1s4OhkkgkIFnXtc4ms/kpPccF
	8Z6P8QJ9yr1BRU/L0o5noI4uO8sl4tTxxUQyG237EM2gDEfD7JFR23K0X7rf7vDbEOWyK5Fodp6
	JoJzhpGy4MhAHGk1nAuByMYnVlQ/rfcqwSzoLKNn8jgX2DLJDO+BH0PKcTJYhPg==
X-Gm-Gg: ASbGncss7UkKMkGrxIt1Hexl0nbhrpI5kKB44IuLtgOii8bV8cHrYNTbYNk1Kofzlwl
	/h322mDowNgRbnN54JbdIJA/uNX91qgyHiGkNmlJKM+ZxX+uU+vvc1L/BTmUtCZf0A2cejATcsM
	g+CtAdi4vhvc2sOuztlBxWq5EMG/h4XC8vU5zsRjIgfcDARP0Co/lwdVH+Ri8lCacL6tApoPB1I
	xx2yQJALxgG4Njgfm5jCPiyN1QkesZZ4K0UmmN+7DAFaLIygzUkITgfOZatrC5s+LeRyfT0+q/Y
	N5yo/aAwqoFZBqQJbDt4F+57zZtsTrNJiYnX4eWT53z6h4PjX3lt9VuVbXmiA5MtvrmRsJIoxdn
	XyPJl
X-Received: by 2002:a05:620a:2b9c:b0:7c3:d63d:7bd4 with SMTP id af79cd13be357-7c4e61ceb21mr580448585a.42.1741363178894;
        Fri, 07 Mar 2025 07:59:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA/ZRjB9AnIN+nmv5qbFdyJU6rV6EVsRMlJ4pB99IV3rAk4IoB3xl6XoOHWtExb+XmkOBr8g==
X-Received: by 2002:a05:620a:2b9c:b0:7c3:d63d:7bd4 with SMTP id af79cd13be357-7c4e61ceb21mr580443585a.42.1741363178480;
        Fri, 07 Mar 2025 07:59:38 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511328sm257409685a.105.2025.03.07.07.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:59:37 -0800 (PST)
Date: Fri, 7 Mar 2025 15:59:33 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8sX5VtKuBD1BoiB@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
 <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>

On 07/03/25 10:19, Waiman Long wrote:
> 
> On 3/7/25 10:11 AM, Waiman Long wrote:
> > On 3/6/25 9:10 AM, Juri Lelli wrote:
> > > Create wrappers for sched_domains_mutex so that it can transparently be
> > > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > > do.
> > > 
> > > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
> > > earlier for hotplug")
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > > ---
> > > v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
> > >            either in that case
> > > ---
> > >   include/linux/sched.h   |  2 ++
> > >   kernel/cgroup/cpuset.c  |  4 ++--
> > >   kernel/sched/core.c     |  4 ++--
> > >   kernel/sched/debug.c    |  8 ++++----
> > >   kernel/sched/topology.c | 12 ++++++++++--
> > >   5 files changed, 20 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 9632e3318e0d..d5f8c161d852 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -383,6 +383,8 @@ enum uclamp_id {
> > >   extern struct root_domain def_root_domain;
> > >   extern struct mutex sched_domains_mutex;
> > >   #endif
> > > +extern void sched_domains_mutex_lock(void);
> > > +extern void sched_domains_mutex_unlock(void);
> > 
> > As discussed in the other thread, move the
> > sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block
> > and define the else part so that it can be used in code block that will
> > also be compiled in the !CONFIG_SMP case.
> > 
> > Other than that, the rest looks good to me.
> 
> Actually, you can also remove sched_domains_mutex from the header and make
> it static as it is no longer directly accessed.

Apart from a lockdep_assert_held() in cpuset.c, no? Guess I can create a
wrapper for that, but is it really better?

Thanks,
Juri



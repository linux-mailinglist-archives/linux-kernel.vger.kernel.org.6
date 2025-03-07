Return-Path: <linux-kernel+bounces-551376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EFBA56BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE8BC3A5CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BC22171E;
	Fri,  7 Mar 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CO+ayTAF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E1221DBC
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360564; cv=none; b=cz5nmd6lwGv692hqRaY9SYjGrMzYdjO3OprV2f6pEv94badIbXSQ0fXyt81xB0sdioqihdRdm13g0Y4HVjo9nMTCrd+fHFPhZgOZsLlPaSdFmxDycVTijKeaQ8j6+WT4xJELcOvWq5vWKqPVD+Ur5Q3CdKNtAwmnHms2buyJogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360564; c=relaxed/simple;
	bh=c3CH7TGyw7ayKW/y+JIiPgELaX0LllMUxZuFzWkEm4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLtw/FOAHmU69/Xe0Tny0N5xTPwDrVIyJf2xbmnqbLDq/OM4z5UCqyTC3MPV9Pqoa08UHB9d3VG929JiOYUTwl/Ss4u9TSQPBTEP3byTwiamdjSGnH//kIJIS42nOlvmmFZUlu9DeL/Znh5noqCZb16ciyFsKtdjbv5EmS4LZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CO+ayTAF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qph6zf+ID+ly6xmuaXbG620k26a/5kfcTY2Rgld0WAE=;
	b=CO+ayTAFciPdfQ7GQX5U0tOlZPsE8hhM3131kGeXGug4Is5aioJBr7WWkrV84qNo1dxF3R
	lkVqbh+8b8ifpuDccUaVl/3lD4Q34mHNTZMjpca2t1FK4IWH6KIwCQaz8putz7qJHFMgq4
	oD0/+bcNPRqbTa65qk6RbtWRHxHdQ3A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-1g8rrjGMOEi5KVfT6nwLwQ-1; Fri, 07 Mar 2025 10:16:00 -0500
X-MC-Unique: 1g8rrjGMOEi5KVfT6nwLwQ-1
X-Mimecast-MFC-AGG-ID: 1g8rrjGMOEi5KVfT6nwLwQ_1741360559
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39137e17c50so208051f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:15:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360559; x=1741965359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qph6zf+ID+ly6xmuaXbG620k26a/5kfcTY2Rgld0WAE=;
        b=Z7RSKR9cH7Ce5eviNpOGKsvZ2I5pXf6IDO4w60SZN1Jxmuj88BDQTczxFarK61x3sZ
         P5hIucS96YBky0+C9b6iZOOwRD/RhTRj3vlLgxR2/Uzk/ZOY03RAy7tOEFLUOKifbl+a
         dVIpGz86x7i60/L30WahQS+REOk3hTpknmdMJNTwuqq2iJDfGOJwbBp1Eo0pUjMt6QtR
         hCdRKuksPSYFetY8VMRAFgxuQVg3LxL0uboGbYrGLB+z4bpe77wqtGfD1sUuF7sdL6SN
         5Aj/Uf0u/5N2XFxVMZMBvNzf6NFLkQ9DuJZJ+HuUX4y4nEAOwPpTPt/3Bd563b42dO1L
         3pgg==
X-Gm-Message-State: AOJu0Yw535NysxTQRdGUeSrLUmNLLF6QVm71108US7HhRGDXwox/g1+w
	i4q2ekrkerVRRNzLBWchBeTnCJhb5YMzKjzkJVH6A7DqJjlIbIj87YGMlrEaV60+NcYqPjrI3Zx
	qIq69mimA1gQUANPxo2SXV8UvDjHLkYl0MrjNtyDnVY+d4+LdRQiJjPKNWkcgpw==
X-Gm-Gg: ASbGncvhy+LjebYIjzsIgZ+DFTm0+utpqWLXWgH3a/Db9MIdAd3CHWCXGMI3HOGhWNJ
	F+VfVfTCwplgxUnd2VuUXT9BiiX98gpacToTY7ZlIuppGD5NrmRmb8iRdboWlk6/xqfN8mrumU6
	sW3FnCAfHhX2gy3cuR5QlEYv6DaYmQAjkfdX3AZkeYbp8lOE7n9yoEyH0rYJdeRtfgdvVTppe+0
	iSfsR35Puo2iYKS8PH8YyFTZ9J3ZSVGut7VrnCS39jexfw8gGHDNQaQ1SxThavFJJuCj+6RuSc8
	BxkYsZp+eXDOWAXV0VoBb0sOX0tEXivR7mKwnk9d+0LoO7igTOQaAmQLP3B8gxY+aUW1nfGvDD7
	FX6r5
X-Received: by 2002:a05:6000:1a8e:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-39132da110fmr2004178f8f.42.1741360558633;
        Fri, 07 Mar 2025 07:15:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1tTVUb8fhqvR/i8Dhv36ZU++qT8Rx+xYofykOLwza7hYP0SmxRFCS3D/ymSQcV7dlgT+jiQ==
X-Received: by 2002:a05:6000:1a8e:b0:390:eacd:7009 with SMTP id ffacd0b85a97d-39132da110fmr2004126f8f.42.1741360557941;
        Fri, 07 Mar 2025 07:15:57 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd948cd0sm52773135e9.38.2025.03.07.07.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:15:56 -0800 (PST)
Date: Fri, 7 Mar 2025 15:15:55 +0000
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
Message-ID: <Z8sNq6gSuz_PrInW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>

On 07/03/25 10:11, Waiman Long wrote:
> On 3/6/25 9:10 AM, Juri Lelli wrote:
> > Create wrappers for sched_domains_mutex so that it can transparently be
> > used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> > do.
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> > v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
> >            either in that case
> > ---
> >   include/linux/sched.h   |  2 ++
> >   kernel/cgroup/cpuset.c  |  4 ++--
> >   kernel/sched/core.c     |  4 ++--
> >   kernel/sched/debug.c    |  8 ++++----
> >   kernel/sched/topology.c | 12 ++++++++++--
> >   5 files changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9632e3318e0d..d5f8c161d852 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -383,6 +383,8 @@ enum uclamp_id {
> >   extern struct root_domain def_root_domain;
> >   extern struct mutex sched_domains_mutex;
> >   #endif
> > +extern void sched_domains_mutex_lock(void);
> > +extern void sched_domains_mutex_unlock(void);
> 
> As discussed in the other thread, move the
> sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block and
> define the else part so that it can be used in code block that will also be
> compiled in the !CONFIG_SMP case.

Ack. 

> Other than that, the rest looks good to me.

Thanks! I will be sending out a v3 early next week (waiting a few more
hours in case anyone spots something else that needs rework).

Best,
Juri



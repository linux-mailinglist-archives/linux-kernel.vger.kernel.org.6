Return-Path: <linux-kernel+bounces-550779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0F6A56408
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F2D188F421
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45620C492;
	Fri,  7 Mar 2025 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhGBRDnF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D18204C0E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339935; cv=none; b=aQ8yoceT9RZNLREetsovQeDDvCCu4+J4qu5bmyEbJFJFAhkbKgWRrf/B2aoDmqn/EMtXIBuEetz1zbx4qeclAWl4rk0IwVY7cMlAPMPR1CKK5EyEuFQ7f9mfFVXpkMyA7fJlmj31nfhVchg2IyGqYih8LiYs+cAo+7P5XLuvd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339935; c=relaxed/simple;
	bh=ZN91VVIiE49rxzpSN14jkta0VDEUkNiiJiOjKTsR1UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF5I81mNBhitSs+q/scR15nllDQZjCoHe06lmYyJWtEcLqpvRPSBG2bPWZFCkIv6P4YxrzU2RkbwnSFQyqgVeZT0lRWy+alvP8U0PhHzkkYYf0B29kCkm8UT5KvBnMiOMBgCYVPe6gBJy4tz4VmqwY24rgG6+w6EUS0knp6pPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhGBRDnF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741339932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1OGWeLhD/3SKHmtpXLwJR/pWSWE9QtQB2+RWYuvjzU=;
	b=UhGBRDnFX5VK6QMUPK6YEN4bDI30yCn6qwjJjbq4rYdX2tV/ox7pqQvne8yn015E/UBAPx
	6scRsZDSOo61bQLolIdAoNpJVFYI5PIXiMPC3rd3wRLZ1BdQI6xzwsWOkI9PnMfEnNsJFc
	x69xl5ay9KbJwMigQ53mdd/ElYLqqts=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-dvS8M2qyP5eB4sA5zFQC2w-1; Fri, 07 Mar 2025 04:32:10 -0500
X-MC-Unique: dvS8M2qyP5eB4sA5zFQC2w-1
X-Mimecast-MFC-AGG-ID: dvS8M2qyP5eB4sA5zFQC2w_1741339930
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-47508da4b00so21605791cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741339930; x=1741944730;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1OGWeLhD/3SKHmtpXLwJR/pWSWE9QtQB2+RWYuvjzU=;
        b=VezAD+clTYoIWaJ+TZUQh5igpfTQnDIwV2eGKoNKDinTCxjUlMGr+G+HVpoP+un/ep
         Hx+M8HqqwLKRlcYzxo5sK3Hyoi7F3PTXzsY6KmxDLnirkjQ0Pp3G1f+JjPEuJpKJlujj
         iB79Np/xuir6Jcz2TViPAp/zwWHJ7ne1V9hvSQ2M4yL6T/B+fmkghwZ/jtkYpyRizPxi
         sRQ+JxeRKqbS7GHN9qFzPJMOqR02860DtE2h06he+X4nJi0liV9s/DAHvT0fttsKlLkt
         ygm9zPkA4YivItiiR8jD4eFZG2JAP+hxQUt93dzZQFgMEoGxBW8W8JEsjwuql+eym98M
         qDfg==
X-Gm-Message-State: AOJu0YyfAL1lRtx5Qkuz7sc9FfUkp0LEA8Qs4cqjQzfFbfFKJM75j3z2
	ABlyf+CxWFK3Q97uKPxFEHymAKbvgOb+sn7izLZsqCFHVafRuXdAPAMSvplY5YjvNkpLuk9eOue
	azk7lERNpeM6Mu7gV0P/lZ993FdxP0tAmRBxHCDP+vVICbzSrgGweuI0qofU75Q==
X-Gm-Gg: ASbGnctCiRknKXjOnrTM9oAPyWSEXLSsclRW4vh6gJoQxf0q1J3+K7NH3GRMIHJCmSu
	bi8egC9hBfbP0iYx5ut8ilIjfVF+ddXUbfR+yexLFqi4ApQw9gzwPB8S/z2ewDWxijP+hWi/ddT
	84UrJ2hJcigQ7L7j5ZqmFtgEsRgq7jn4WlH2RKpYcMQr5YXqFWbxybm6HRaS5ijHctG1K5x36rZ
	d1vkUesMCSo6PLdGLdChy8ySVe0K/afmNFvIa3xsI4Bb5K8CWO3UzXMuaVDC0i0klFSdqxePd2G
	abbsLtgCsFn+INz2CuzI1q1R/kkxoQHlgCExXix9/Q9uAv7+apToUYaZZ8BemzA1yeLI/eGPtkK
	ZQvZf
X-Received: by 2002:a05:622a:118e:b0:475:7c0:9390 with SMTP id d75a77b69052e-47618af3564mr29595821cf.48.1741339929912;
        Fri, 07 Mar 2025 01:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFerUMJmzuZeGRv0gplglLVFFk6MAamjLT9/4AYtJqbxasFWs3PcPJWi/IBIlpqfSSTNZ3vGQ==
X-Received: by 2002:a05:622a:118e:b0:475:7c0:9390 with SMTP id d75a77b69052e-47618af3564mr29595571cf.48.1741339929550;
        Fri, 07 Mar 2025 01:32:09 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d96b568sm18673441cf.25.2025.03.07.01.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:32:08 -0800 (PST)
Date: Fri, 7 Mar 2025 09:32:03 +0000
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
Subject: Re: [PATCH 2/5] sched/topology: Wrappers for sched_domains_mutex
Message-ID: <Z8q9E6j6cMX3jTi8@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
 <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
 <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>

On 05/03/25 10:52, Juri Lelli wrote:
> On 04/03/25 11:01, Waiman Long wrote:
> > On 3/4/25 10:05 AM, Waiman Long wrote:
> > > > --- a/kernel/sched/topology.c
> > > > +++ b/kernel/sched/topology.c
> > > > @@ -6,6 +6,19 @@
> > > > � #include <linux/bsearch.h>
> > > > � � DEFINE_MUTEX(sched_domains_mutex);
> > > > +#ifdef CONFIG_SMP
> > > > +void sched_domains_mutex_lock(void)
> > > > +{
> > > > +��� mutex_lock(&sched_domains_mutex);
> > > > +}
> > > > +void sched_domains_mutex_unlock(void)
> > > > +{
> > > > +��� mutex_unlock(&sched_domains_mutex);
> > > > +}
> > > > +#else
> > > > +void sched_domains_mutex_lock(void) { }
> > > > +void sched_domains_mutex_unlock(void) { }
> > > > +#endif
> > > > � � /* Protected by sched_domains_mutex: */
> > > > � static cpumask_var_t sched_domains_tmpmask;
> > > > @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int
> > > > ndoms_new, cpumask_var_t doms_new[],
> > > > � void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > > > ������������������ struct sched_domain_attr *dattr_new)
> > > > � {
> > > > -��� mutex_lock(&sched_domains_mutex);
> > > > +��� sched_domains_mutex_lock();
> > > > ����� partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > > > -��� mutex_unlock(&sched_domains_mutex);
> > > > +��� sched_domains_mutex_unlock();
> > > > � }
> > > 
> > > There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
> > > topology.c file and one in cpuset.c. That can be problematic in the
> > > non-SMP case. Maybe another wrapper to do the assert?
> > 
> > Ignore that as both topology.c and cpuset.c will only be compiled if
> > CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP"
> > above.
> 
> Indeed!

Ah, actually I believe next patch (3/5) introduce usage for the !SMP
case in sched_rt_handler()

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 4b8e33c615b1..8cebe71d2bb1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2910,6 +2910,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
        int ret;

        mutex_lock(&mutex);
+       sched_domains_mutex_lock();
        old_period = sysctl_sched_rt_period;
        old_runtime = sysctl_sched_rt_runtime;

@@ -2936,6 +2937,7 @@ static int sched_rt_handler(const struct ctl_table *table, int write, void *buff
                sysctl_sched_rt_period = old_period;
                sysctl_sched_rt_runtime = old_runtime;
        }
+       sched_domains_mutex_unlock();
        mutex_unlock(&mutex);

        return ret;

So, I will need to add the ifdef back I guess (I removed it on v2). Do
you agree?

Thanks,
Juri



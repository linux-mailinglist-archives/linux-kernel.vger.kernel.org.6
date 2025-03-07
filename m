Return-Path: <linux-kernel+bounces-550783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0606A5640C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C781817817A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0E220C476;
	Fri,  7 Mar 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9w52F4n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9292202F9A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340042; cv=none; b=MKcJ7owNz40uN6auq0D2KpO69FV3jV9JJzKI39NbT7xVUC0MCfAeTbB9thUBtPSnpmvGlg8fzXw1utDOPU9B+Ce5ippI4/T222c2TCDQSdDid15kTK8Y0TiifuPmwU7w0bRqLHHG8qXFUUCkznXp5SgcOPtvEhVc3ByZVJN+Fkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340042; c=relaxed/simple;
	bh=Ypb9lH57vm+WjVbRerOzUIkxUzGc7i5IMTgs/vJz0zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CaGhBcdCZqnjyeIz+binz7P1+O1sHiyfDUY+mplwAi6KySM2019lEC0X5wM3FltGResgUaz6uxgDSJzPJyoshW8fBTnMQukpc0vxyXKSQvW8/tcdcoq5XYYxPQXbPZfosQfUSCCito9ysA93j4QYljmDTzY+N7YbYMKKm62OEe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9w52F4n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741340039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jVEOIfEn4WDZ5RzbzaumI6wBZHn7khG5qOmcjQFY/34=;
	b=h9w52F4n/pCaAIW7xhI09jxg5sVIPyBOvnPvNuyGK1pw4+RuGLdDx0Qef9CNUVuwxGTub2
	vkXYtZF7Mg809TP9zjbohaKVdYrdYITWWCwa7wSumutFiuwr1rDOvdYiptWaUfYsF0PApt
	F/omwqllRhz+ZMl1MQeNv5Ryt24b2OA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Vy6fiRnkPK-rnji1tWsQeA-1; Fri, 07 Mar 2025 04:33:56 -0500
X-MC-Unique: Vy6fiRnkPK-rnji1tWsQeA-1
X-Mimecast-MFC-AGG-ID: Vy6fiRnkPK-rnji1tWsQeA_1741340036
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e8ff626b73so16675956d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741340036; x=1741944836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVEOIfEn4WDZ5RzbzaumI6wBZHn7khG5qOmcjQFY/34=;
        b=N8CP9QsTCtJM75s4fXOblbnUS15t/OvvcJP70bn1wH0qGGVPmx1CS9/Z6U78S4tInf
         9nonAPqcwZqSKVl0FYeVRx1ha8uLsen9QmWO8b4ytT3OiHFektLyXKYXRf5mNw4HNtbT
         S/9x/9FJY1PIUIFozqyfRB5ivCAO1gYA8IVDDlm4zgPZ2oJJkEFqQoFS1DXwEJDqPX59
         R+VyNrIVLjLDTH67YgWHv6te5wso/lCIgS3zy2Wt353Ru4xl6Wy6J2cpgL2V1EHQXcSV
         VtI3qNbYHJssKlxrDnpyEye7eXM+88ykmzkzUi+OO/36gSChMHWuj2uAtbjjXuH8wTVF
         cNcw==
X-Forwarded-Encrypted: i=1; AJvYcCXfRtASMBDbA5ldtZXJpvLFpZ3IGEKr/4gmtw6ryCR0dR5AAkdQ6NFROpu08vPLKfMCI2dsDRTdb3IWFNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreTKtgMIxGE0vQ8Z6C2qjRn8vYoUJLnjCuK9qlqVHKtA8o0lg
	sujGcFgqVI9hkaASqRyXEn2SAxPEEwAdaD/+kSgBOi3ZwQxAM++6Bn/9laeRDTn97QQijwLVFNu
	YQ1o5dO3/3CjLHQZ/2EYpOBJKsrEN8vJqENojx4jn2zFTpWTaNU940pYCxGcdOQ==
X-Gm-Gg: ASbGncvUnwJiieWFKMo/jjjvDxozBBNi2IjagGbKMAYevQ1gm/v+riIy2TiwuF3L32j
	J3kQ0wUWm/kBD/NkCc0y+bO2ij4wB3Ct+IlXuyoXo3CC7o6+iV+uJvbG5IXcWi6XkxyhTulLBrG
	iY/WizPkfiXC6Jmkpde8oNKCtigMUfNWloeoUzChAjowsoxp51ooHcnPjUbazd4P4q9rj1+moed
	CY3he1tOOoXm6VR2Ic7UyDg8mNWG1G8xV2ZKNBV0/AnoAzHVBEIfyR3KMMmb4/CYLyCJSMPr/Wv
	vrTrT1924XMdarKnvW1/Ok9uyB1CluZU3MO/lGs0X3W1pDCcBX2C3Ts3t6kTkVF7Vq8Z3azVHhY
	iAkFl
X-Received: by 2002:ad4:5d65:0:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6e900604760mr33987766d6.7.1741340035817;
        Fri, 07 Mar 2025 01:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyw0MIlPz6JSxN4+Pj2WN6QeNWdmbKWHxOQqdc5jlEBKq4ZYwIpIMz5BhiL2wU0DVNM6In+g==
X-Received: by 2002:ad4:5d65:0:b0:6e8:89bd:2b50 with SMTP id 6a1803df08f44-6e900604760mr33987556d6.7.1741340035522;
        Fri, 07 Mar 2025 01:33:55 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090c4csm17736036d6.33.2025.03.07.01.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:33:54 -0800 (PST)
Date: Fri, 7 Mar 2025 09:33:49 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>, cgroups@vger.kernel.org,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 4/8] sched/deadline: Rebuild root domain accounting
 after every update
Message-ID: <Z8q9fY0DDzVsc4Yb@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-5-juri.lelli@redhat.com>
 <2926c843-62e6-419b-a045-e49bdd0b0b97@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2926c843-62e6-419b-a045-e49bdd0b0b97@linux.ibm.com>

On 07/03/25 12:03, Shrikanth Hegde wrote:
> Hi Juri.
> 
> On 3/6/25 19:40, Juri Lelli wrote:
> > Rebuilding of root domains accounting information (total_bw) is
> > currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> > is that the way we keep track of domain changes and try to add bandwidth
> > back is convoluted and fragile.
> > 
> > Fix it by simplify things by making sure bandwidth accounting is cleared
> > and completely restored after root domains changes (after root domains
> > are again stable).
> > 
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > ---
> >   include/linux/sched/deadline.h |  4 ++++
> >   include/linux/sched/topology.h |  2 ++
> >   kernel/cgroup/cpuset.c         | 16 +++++++++-------
> >   kernel/sched/deadline.c        | 16 ++++++++++------
> >   kernel/sched/topology.c        |  1 +
> >   5 files changed, 26 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> > index 6ec578600b24..a780068aa1a5 100644
> > --- a/include/linux/sched/deadline.h
> > +++ b/include/linux/sched/deadline.h
> > @@ -34,6 +34,10 @@ static inline bool dl_time_before(u64 a, u64 b)
> >   struct root_domain;
> >   extern void dl_add_task_root_domain(struct task_struct *p);
> >   extern void dl_clear_root_domain(struct root_domain *rd);
> > +extern void dl_clear_root_domain_cpu(int cpu);
> > +
> > +extern u64 dl_cookie;
> > +extern bool dl_bw_visited(int cpu, u64 gen);
> 
> Is this needed? There is same declaration outside of CONFIG_SMP done in
> patch 3/8.

Nope. Good catch.

Thanks,
Juri



Return-Path: <linux-kernel+bounces-546615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D932A4FCDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 807FC3A3E28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859EF212FAB;
	Wed,  5 Mar 2025 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLm5Ud/s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88221577C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171984; cv=none; b=ZgywTmY95AQ7xYVo2oT2PfdcoMSlwKDyFaTpdjT8WZFPYnewlgpCmjTQfuDeg3UOoxLL1506nZ2UtADgyubjanMxzPAeewxfYgevzLVTlWfAIbRZNkDR7Qe4x7L+i/EIz31EeOTBpWuhZQlLCZHtKPHpQn/6HQacBA8TUeNFzxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171984; c=relaxed/simple;
	bh=nk+KkRYXUjtSGWWIcw2HfvCEMC1Z4n55lXhVtQL8h9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBjNCcw+iopJ55g+8Dv+n6/KQ4+sLDqw+Up7vWxiqkcWfFBw0sTvlsDHMGiikQnzCZ/WSxZl79OmgTcYac9ufJ4e7BR+WjopFmoK/apa1+pT19CdVSJsHcnVeG4KWmxAuacdDhxlqa9uNHCYTB1YWOhL9cUTjrvG9Z8yN4h92Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLm5Ud/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78UcZquxL+SEJoDfw96YhTrJfkNqg4zF+abkQ0siliY=;
	b=OLm5Ud/s7KvbxK1VNqoofcmeRh8M4IIXB9R3jGmb6yZmkBwhmZzpnuPyfT1xxA0hUP3bjM
	mhxA4PCx0I230ppvWipHWsMk/a/tSorJzDnK4ufGbzdEIn4oid2Z4sfGstNDxiT8sPMnah
	+hbHZnyJOO4lkZfigdJ8HwtS6XvUO2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-OYGciPepOIiKeGEVNKcU_w-1; Wed, 05 Mar 2025 05:52:46 -0500
X-MC-Unique: OYGciPepOIiKeGEVNKcU_w-1
X-Mimecast-MFC-AGG-ID: OYGciPepOIiKeGEVNKcU_w_1741171965
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-439a0e28cfaso35708915e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171965; x=1741776765;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=78UcZquxL+SEJoDfw96YhTrJfkNqg4zF+abkQ0siliY=;
        b=elLrZAhY0LuIJUxAKhOgGkPcf4VYVlWvjTIDxT4FDGk/So1XeKcm5/BbjPk0vI6YuW
         MZXJALxp8np/nY1gxxOr8zI1YrU8BDJ5gCVWIlKlWNjTRftzrRf2PrHPebNP6M5P+Pwb
         +6l/PIsrJREpNZadPG880xvlyCYVxUI5QuYwbZ2i4J7z3/R3ajOB9EcVI16zkl7yZ7YO
         TTwg7AAwi6i9AoVdXg98YuVDmpu7aVoPzPM+3QHSzUBwwHimFzQuNNZOWAr7iamLyEk5
         TlR+Sd6aGTsiVuhuwZxdX8p9BlWc028KtFnMwKe9MV/KhbwJMvfjQiddw8WwbUGNDo3D
         n4AA==
X-Gm-Message-State: AOJu0Yx7+Sm+GBrb/KXkzENOs3GenePpQ7Ti7K3LZl/iGF80dWDlL67A
	SwYeDSTcv9CzZBVjCefFi6WCPgvjFFtbX/NRysj8kSw239I8xVHbp5jVjU/ZFgTjjlYQBt4bQT4
	OwaFWMHApzQNSDRMZGzeLNvUSk4w09Y2lu/KDOeRr/VTj7yTaAR1fXdU/o9+z2g==
X-Gm-Gg: ASbGncuqeg8mVS8isqWurQXuh27siQSm09xVUqfG0SmfsCKj7wxbsd9UoROtG/wsQ7F
	292aTFH/IP0ukac24IzjRX7+HwMnjPiIj+AUF5HILnCndTgWmh6KlyWfmIhUncsCz3Eq8PIPzCB
	qlpHAqpkyUtij+GJ24OT12WohLKyRuck9LIIiaW5Z4tQPki8Oo7igkJflgp657x2EoZd43p6K8N
	sCeLku8ixdyaCON+kI0kW8obbPXg/VewMzp4MG3WrRW9BfxSydhNebgw7FYAugV3fdKraj2cz0P
	ArDTPWfGvcD5ixc/vZshUuwVgL4yVkv10s4kd5fg7wKQ6ckDGgzNVHBisnWamVuHY7FKdTfc/Ud
	Cj6ti
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr21882695e9.16.1741171965013;
        Wed, 05 Mar 2025 02:52:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF19cuSbrSvv6USTbmde98zlhhGMHtMbRetjnXV558FvTHe9XzYEm48iwA5rlldmCxfdsnJNg==
X-Received: by 2002:a05:600c:5117:b0:439:a6db:1824 with SMTP id 5b1f17b1804b1-43bd29d6c7fmr21882415e9.16.1741171964658;
        Wed, 05 Mar 2025 02:52:44 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd429370esm13721195e9.14.2025.03.05.02.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:52:44 -0800 (PST)
Date: Wed, 5 Mar 2025 10:52:41 +0000
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
Message-ID: <Z8gs-but1oFcwEn0@jlelli-thinkpadt14gen4.remote.csb>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
 <20250304084045.62554-3-juri.lelli@redhat.com>
 <c02dd563-7cfc-404d-80d1-cec934117caf@redhat.com>
 <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0abc29ee-df9c-4c00-a7f9-d55ab5dd90c4@redhat.com>

On 04/03/25 11:01, Waiman Long wrote:
> On 3/4/25 10:05 AM, Waiman Long wrote:
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -6,6 +6,19 @@
> > >   #include <linux/bsearch.h>
> > >     DEFINE_MUTEX(sched_domains_mutex);
> > > +#ifdef CONFIG_SMP
> > > +void sched_domains_mutex_lock(void)
> > > +{
> > > +    mutex_lock(&sched_domains_mutex);
> > > +}
> > > +void sched_domains_mutex_unlock(void)
> > > +{
> > > +    mutex_unlock(&sched_domains_mutex);
> > > +}
> > > +#else
> > > +void sched_domains_mutex_lock(void) { }
> > > +void sched_domains_mutex_unlock(void) { }
> > > +#endif
> > >     /* Protected by sched_domains_mutex: */
> > >   static cpumask_var_t sched_domains_tmpmask;
> > > @@ -2791,7 +2804,7 @@ void partition_sched_domains_locked(int
> > > ndoms_new, cpumask_var_t doms_new[],
> > >   void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > >                    struct sched_domain_attr *dattr_new)
> > >   {
> > > -    mutex_lock(&sched_domains_mutex);
> > > +    sched_domains_mutex_lock();
> > >       partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
> > > -    mutex_unlock(&sched_domains_mutex);
> > > +    sched_domains_mutex_unlock();
> > >   }
> > 
> > There are two "lockdep_assert_held(&sched_domains_mutex);" statements in
> > topology.c file and one in cpuset.c. That can be problematic in the
> > non-SMP case. Maybe another wrapper to do the assert?
> 
> Ignore that as both topology.c and cpuset.c will only be compiled if
> CONFIG_SMP is defined. IOW, you don't need the the "#ifdef CONFIG_SMP"
> above.

Indeed!

Thanks,
Juri



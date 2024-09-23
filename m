Return-Path: <linux-kernel+bounces-331634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805797AF40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 13:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B612875E4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FFC15CD41;
	Tue, 17 Sep 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z9bbRuWJ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A823315539A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571250; cv=none; b=kLxUzlDNntep+y+H1rgeQQPmFA8d3o5ulDnWBVqd8wz2mfi2N62j72zW50kQVFAYMfXo6+W2lKQ0uh9/tR1tozRLDccdsTfQ8A+q0a3GtWuvYAYeMu2/PoxambNocqQq4a5VHTHNagbJox99Zybe/dFQ8nImAZap8znjnlUwwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571250; c=relaxed/simple;
	bh=AjzXQJDawkz0u3x8Gb/cP4YDGAWEbv6gltnoKXeUdic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpuL4Q+LuTRSln4kAimAOzIjD40F9ByECRPnsLlubGgNJXpJt3NgzvySa+p0ARfofWZN0QVD7LoNUYmAsoSB1Gb9YAmc3+YccypTNPUPZyXNR8+RTlG5/zEuFYnHxo/7ezqUUMXBhc4v3seVZz7Q4f8etPLB1uCpH8n0SoNIXdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z9bbRuWJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374b9761eecso4409222f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726571247; x=1727176047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D51B76i/syphr7fBrFBR8DX4oQsj03G++/BsgOPPFu4=;
        b=Z9bbRuWJZET7u4aBl11Q6HL0YK2/i0JTSxgvUNB+wj8JZwA/GDOYOPH1c6zgefcryz
         bCDalKH7XsAGG16z34BUmDdvflJef68F8m1HQCtIYcoLymsoTy7qhmeoFG8igvTJh1/R
         TZbqoC8q6teazoEh3PzIQaDBWTcR/M/h2Q+RlsbB7egsunnk9FZ5Rf8vrFzZyotjq3XH
         GXCJgS7UbRJ8HKx1yqSBV8fOigbguXSQUh55Z88A2a+XGPD6CHeQJTRabkNjJqrVcQOp
         V67yif7FIHSWN5N1PD5HN6eFfpreAbGAbDQkHRNg5htb5S/BnxpxeJLmKPrRS3EtWvcq
         9Cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726571247; x=1727176047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D51B76i/syphr7fBrFBR8DX4oQsj03G++/BsgOPPFu4=;
        b=RgcuKcLTLWwPcBjBqmarrVb1+e6lzVa0OQ52Umre8vyoPzGsFstA7C9gfRJCGqA0D0
         lBE3lSRcHY9yaD0BnGgBh8EEvoE8WGQ5J/wcqVeH4voGYx3hkjp+C/A6g4avA4kgI1iB
         4WWgTcNo8Nxhx8s+aJhJ8cZvTpgR9V06EC9XnTxNAZA4aTXyWsA93o7ufbPAKXNuBb3a
         O8EQjU/p/F8iBd+UrYMwFSeOz5lliTqf5ECGtm5fflAuEF+zsyXmXsgCVheMl1rKSQUo
         sQXS/2FBIMypVfwaU1LC34smyOYhzxevOQbgB/QSYR/PtoJeJUL/+n4FWy+wx7zhG33t
         Kx9A==
X-Gm-Message-State: AOJu0Yw8XwXuEUOlraq6+Daq4y0hPsa173eiaGkfWjlP1E61DMm6mSFV
	W6WZ8F0TQBY3uxnmvoWstdoTL4iLvNn+3eA1EDbJ+yVfAl2bnbVyc1ntbFQqSc0=
X-Google-Smtp-Source: AGHT+IEOVlYSleyjY2/K9oNfyzgog+SKayd+ffTDMu5r/Gl/KopEsVR3ZiFiNUx57eV/p1k50ijMkg==
X-Received: by 2002:adf:f9c5:0:b0:374:b675:6213 with SMTP id ffacd0b85a97d-378c2d4c938mr11870489f8f.45.1726571246795;
        Tue, 17 Sep 2024 04:07:26 -0700 (PDT)
Received: from localhost (109-81-94-244.rct.o2.cz. [109.81.94.244])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805185sm9195857f8f.96.2024.09.17.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 04:07:26 -0700 (PDT)
Date: Tue, 17 Sep 2024 13:07:25 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH 12/19] kthread: Default affine kthread to its preferred
 NUMA node
Message-ID: <Zuli7SGxkbEbQraJ@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-13-frederic@kernel.org>
 <ZukhKXxErPOaXtAL@tiehlicka>
 <ZulbS1MvZVVYe-YO@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZulbS1MvZVVYe-YO@localhost.localdomain>

On Tue 17-09-24 12:34:51, Frederic Weisbecker wrote:
> Le Tue, Sep 17, 2024 at 08:26:49AM +0200, Michal Hocko a �crit :
> > On Tue 17-09-24 00:49:16, Frederic Weisbecker wrote:
> > > Kthreads attached to a preferred NUMA node for their task structure
> > > allocation can also be assumed to run preferrably within that same node.
> > > 
> > > A more precise affinity is usually notified by calling
> > > kthread_create_on_cpu() or kthread_bind[_mask]() before the first wakeup.
> > > 
> > > For the others, a default affinity to the node is desired and sometimes
> > > implemented with more or less success when it comes to deal with hotplug
> > > events and nohz_full / CPU Isolation interactions:
> > > 
> > > - kcompactd is affine to its node and handles hotplug but not CPU Isolation
> > > - kswapd is affine to its node and ignores hotplug and CPU Isolation
> > > - A bunch of drivers create their kthreads on a specific node and
> > >   don't take care about affining further.
> > > 
> > > Handle that default node affinity preference at the generic level
> > > instead, provided a kthread is created on an actual node and doesn't
> > > apply any specific affinity such as a given CPU or a custom cpumask to
> > > bind to before its first wake-up.
> > 
> > Makes sense.
> > 
> > > This generic handling is aware of CPU hotplug events and CPU isolation
> > > such that:
> > > 
> > > * When a housekeeping CPU goes up and is part of the node of a given
> > >   kthread, it is added to its applied affinity set (and
> > >   possibly the default last resort online housekeeping set is removed
> > >   from the set).
> > > 
> > > * When a housekeeping CPU goes down while it was part of the node of a
> > >   kthread, it is removed from the kthread's applied
> > >   affinity. The last resort is to affine the kthread to all online
> > >   housekeeping CPUs.
> > 
> > But I am not really sure about this part. Sure it makes sense to set the
> > affinity to exclude isolated CPUs but why do we care about hotplug
> > events at all. Let's say we offline all cpus from a given node (or
> > that all but isolated cpus are offline - is this even
> > realistic/reasonable usecase?). Wouldn't scheduler ignore the kthread's
> > affinity in such a case? In other words how is that different from
> > tasksetting an userspace task to a cpu that goes offline? We still do
> > allow such a task to run, right? We just do not care about affinity
> > anymore.
> 
> Suppose we have this artificial online set:
> 
> NODE 0 -> CPU 0
> NODE 1 -> CPU 1
> NODE 2 -> CPU 2
> 
> And we have nohz_full=1,2
> 
> So there is kswapd/2 that is affine to NODE 2 and thus CPU 2 for now.
> 
> Now CPU 2 goes offline. The scheduler migrates off all
> tasks. select_fallback_rq() for kswapd/2 doesn't find a suitable CPU
> to run to so it affines kswapd/2 to all remaining online CPUs (CPU 0, CPU 1)
> (see the "No more Mr. Nice Guy" comment).
> 
> But CPU 1 is nohz_full, so kswapd/2 could run on that isolated CPU. Unless we
> handle things before, like this patchset does.

But that is equally broken as before, no? CPU2 is isolated as well so it
doesn't really make much of a difference.

> And note that adding isolcpus=domain,1,2 or setting 1,2 as isolated
> cpuset partition (like most isolated workloads should do) is not helping
> here. And I'm not sure this last resort scheduler code is the right place
> to handle isolated cpumasks.

Well, we would have the same situation with userspace tasks, no? Say I
have taskset -p 2 (because I want bidning to node2) and that CPU2 goes
offline. The task needs to be moved somewhere. And it would be last
resort logic to do that unless I am missing anything. Why should kernel
threads be any different?

> So it looks necessary, unless I am missing something else?

I am not objecting to patch per se. I am just not sure this is really
needed. It is great to have kernel threads bound to non isolated cpus by
default if they have node preferences. But as soon as somebody starts
offlining cpus excessively and make the initial cpumask empty then
select_fallback_rq sounds like the right thing to do.

Not my call though. I was just curious why this is needed and it seems
to me you are looking for some sort of correctness for broken setups.
-- 
Michal Hocko
SUSE Labs


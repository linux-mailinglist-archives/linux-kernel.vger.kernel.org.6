Return-Path: <linux-kernel+bounces-402002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A099C2224
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6AC61F2480D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED9D1BD9DB;
	Fri,  8 Nov 2024 16:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+52VTiY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4826519259B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083527; cv=none; b=qEYc5TYfbEstEVz5z0b7ocSz/X/nkJgbHObchgMtEbpnPd4rDPdPkC0/f5Ovh+xLRJVfmFxvrCtHUYCMUhSF19twR4oiCi4B8c6nHC9r3XE6zNcMxE0jBFbbdK2Zb9ytBMKkzlnFpUgQiSmXRArn7AanD449R4Ty+yQfuMy2jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083527; c=relaxed/simple;
	bh=j5k1OIRrm03JnVstT6x9t6TbhESWVJV+MLhx7SsvBdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/dAG4tm4TEZF++Xr2ZDOWmjOdGeEN0Oo8c9GFNNDtO1nJIhu/ZOKMnRY/whEvITPSRNbIo1NivqMOrT32nFV6fGz8M0ujx+oJ5D/O+fQBEn+cKoDRC17BEjW2ML8P3slk+49o/2jVqcTDpe9ao6f+Xp2yrkI/06VeULImRBB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+52VTiY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731083523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axzkxLJUXWiMDlmMX2kRHVoqStja9edkDa58KxGWcAM=;
	b=i+52VTiYGPkd2OdCs/E6jZOlm1uorpddj/K2p2tJyqcWAz78qLo0V8LbopzoTvXF5Ynv5r
	F7iOf7rOjjzz6UbhqOVOcq4VSdKoxOYc3w2jwRL0x3xQOkVy/IS1TcnhBZVDoUL+VSYRU2
	nCe8N7A0Dk2b0qCmuQHCjCrO0LnHWlc=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-0cKBr4atO6qm2AMCid3wNw-1; Fri, 08 Nov 2024 11:32:00 -0500
X-MC-Unique: 0cKBr4atO6qm2AMCid3wNw-1
X-Mimecast-MFC-AGG-ID: 0cKBr4atO6qm2AMCid3wNw
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-539f067414fso1654712e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 08:32:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083519; x=1731688319;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axzkxLJUXWiMDlmMX2kRHVoqStja9edkDa58KxGWcAM=;
        b=NZRAzO2095q4wgYUJn0ZNR5sBKd6rQgTpC+gNiBPOh6zPfrj0EQv7cXx7KiS8mLSZO
         Ssra6GO+l9eENuushGPNFwAppUylGVcVi4s669ClpxHjw2YXfc8gwQxPtG3bQMbKuUm6
         SR35Hjc5CcsPen+E+S2CshdWgOUadXyMjlZNTutxT1+c5rO2+t2VxltUgGP2NoJramwF
         02xxvMhgepdJH6PQr3YPZoxkRGRHTcd4WiVDmVGA2aG/EHKAOVy29ZHAHDd2D8oneWtt
         h6Ue0VMGEKjrf3GAzj+SKhfCMF+AqPnLEpit1XITZO6d4eQBq9vqyDHSnJc4jXsUV4mf
         4Nww==
X-Forwarded-Encrypted: i=1; AJvYcCXzyo9kGYYNZG7+Pkvhz5muwDvrwJaFrs7RVAurCgcjdDeF2mnHoexljwtNmc420Yx0bNzLprjRG+uLWVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYZ9hqOV1RX5a1GCllHS/GbrVExp3h2sIsgPegZLhJn0+ArUSg
	yJdT/wnllENU/IZkKrcdARPHG8K0y/FdJ1/H29vfeC4yCqvtLCicOeiJ+r+ilOYpyqQgorwwaDU
	Wjw/ow31AOxatCTY8v7q4p9iXljJtQ/IUz803MNrRRIoLuT10hLterdqf5gKRTQ==
X-Received: by 2002:a05:6512:138b:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53d862c5905mr2089050e87.30.1731083518946;
        Fri, 08 Nov 2024 08:31:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeDhGnocJ3Sqfq8pVia/ejFVBfpdCRg3veAh/RlbFwrIxdkSrk0sYGZb3oVk4NbQCXRr+h9A==
X-Received: by 2002:a05:6512:138b:b0:53b:1625:bcf8 with SMTP id 2adb3069b0e04-53d862c5905mr2089024e87.30.1731083518443;
        Fri, 08 Nov 2024 08:31:58 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.142.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b5fc9sm110160525e9.3.2024.11.08.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:31:57 -0800 (PST)
Date: Fri, 8 Nov 2024 17:31:55 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH] sched/deadline: Skip overflow check if 0 capacity
Message-ID: <Zy48-zbUnjTzxXXB@jlelli-thinkpadt14gen4.remote.csb>
References: <20241108042924.520458-1-longman@redhat.com>
 <Zy4RWJPH9jxew_7G@jlelli-thinkpadt14gen4.remote.csb>
 <735344cd-1c32-451f-904e-235578e1a360@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <735344cd-1c32-451f-904e-235578e1a360@redhat.com>

On 08/11/24 08:39, Waiman Long wrote:
> On 11/8/24 8:25 AM, Juri Lelli wrote:
> > On 07/11/24 23:29, Waiman Long wrote:
> > > By properly setting up a 1-cpu sched domain (partition) with no
> > > task, it was found that offlining that particular CPU failed because
> > > dl_bw_check_overflow() in cpuset_cpu_inactive() returned -EBUSY. This
> > > is due to the fact that dl_bw_capacity() return 0 as the sched domain
> > > has no active CPU causing a false positive in the overflow check.
> > > 
> > > Fix this corner case by skipping the __dl_overflow() check in
> > > dl_bw_manage() when the returned capacity is 0.
> > > 
> > > Signed-off-by: Waiman Long <longman@redhat.com>
> > > ---
> > >   kernel/sched/deadline.c | 8 +++++++-
> > >   1 file changed, 7 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index be1b917dc8ce..0195f350d6d3 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -3479,7 +3479,13 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
> > >   	} else {
> > >   		unsigned long cap = dl_bw_capacity(cpu);
> > > -		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> > > +		/*
> > > +		 * In the unlikely case of 0 capacity (e.g. a sched domain
> > > +		 * with no active CPUs), skip the overflow check as it will
> > > +		 * always return a false positive.
> > > +		 */
> > > +		if (likely(cap))
> > > +			overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> > The remaining total_bw that make this check fail should be the one
> > relative to the dl_server on the cpu that is going offline. Wonder if we
> > shouldn't rather clean that up (remove dl_server contribution) before we
> > get to this point during an hotplug operation. Need to think about it a
> > little more.
> static inline bool
> __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
> {
>         return dl_b->bw != -1 &&
>                cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
> }
> 
> With a 0 cap, cap_scale(dl_b->bw, cap) will always be 0. As long as total_bw
> isn't 0 and bw isn't -1, the condition will be true.

Right, but I fear that by hiding the special corner case we would also
miss the cases where we have DEADLINE tasks with bandwidth on that
single CPU and then ignore it.

So, maybe something like the below?

---
 kernel/sched/deadline.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index be1b917dc8ce..7884e566557c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -130,11 +130,24 @@ static inline int dl_bw_cpus(int i)
 	if (cpumask_subset(rd->span, cpu_active_mask))
 		return cpumask_weight(rd->span);
 
+	/*
+	 * Hotplug extreme case in which the last remaining online CPU in a
+	 * root domain is going offline. We get here after that cpus has been
+	 * cleared from cpu_active_mask, so the loop below would return 0
+	 * CPUs, which of course doesn't make much sense. Return at least 1
+	 * CPU.
+	 */
+
+	if (cpumask_weight(rd->span) == 1)
+		return 1;
+
 	cpus = 0;
 
 	for_each_cpu_and(i, rd->span, cpu_active_mask)
 		cpus++;
 
+	WARN_ON(!cpus);
+
 	return cpus;
 }
---

That said though, I believe I just found an additional issue. With the
above the system doesn't crash (it did w/o it), but happily moves
DEADLINE tasks out of a domain with a single CPU going offline. Last
time I looked at this we were properly checking and failing the hotplug
operation, but it was indeed a while ago, so not sure yet what changed.
More staring.

Oh, so broken, yay. :)

Best,
Juri



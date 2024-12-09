Return-Path: <linux-kernel+bounces-437786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466FA9E989B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1AA284367
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC151B041F;
	Mon,  9 Dec 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3e7UMIx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552411494BF
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733754017; cv=none; b=VQc5ehE6ba+cvP+jZL0vUXl9hVvimSw3pXE5FPLc6JFNG7RVxx+PYtRythHFpvW8ANb+GRv08nJUhLi6zvDioekQXXIqqcZCU1DeJNOWP6xXSTelXOOpxymeOczMhoMoJRjfRuWTFfC2zWJtByyxSxXIGdYb4wH8oJiAH+01hnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733754017; c=relaxed/simple;
	bh=5LxPzkwXbkWs8QADAY0HXIgv9Pxu1uooRAocU3GSwZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1fEGofQS0Wr37HLfU6rM8mVsa3ZNrfmXTWlIah17WNdt+K/d4JlyFlJV6aR917wYWsG0QzYYYe2AmHkqr5T1n/80MhdOqV048znG9g+BsKZMOpM3HOw/r2dpSHB3CsMvHsXaL5OQIQKSWFtC1/2p8Pt7JGeCw7csqYN06pm8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3e7UMIx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733754014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uUafJPITbFDpJxN3Yx+BE2RB7iQ7hbigXZ4vj14KZBU=;
	b=d3e7UMIxfABm2rtETcxR5qBAKD/s1ZldQ46Hvo0qthOD73GnlGlbihjWEXRt7DIJn5g781
	yKNN2AjjNetROuwsXZucjE7xelfKHWHm0YXfNMQPJeyqGWAUOx2rKXBjZGPHtT7a63K53W
	83svar6ZMdHIaBIOJxOW9DYun2Zsirc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-rv49O600Pa23kY_u9feh8w-1; Mon, 09 Dec 2024 09:20:12 -0500
X-MC-Unique: rv49O600Pa23kY_u9feh8w-1
X-Mimecast-MFC-AGG-ID: rv49O600Pa23kY_u9feh8w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e4a759e6so2555282f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 06:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733754012; x=1734358812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUafJPITbFDpJxN3Yx+BE2RB7iQ7hbigXZ4vj14KZBU=;
        b=JgMeS0eHWCsRVv5vfT6/9KGQo9o+gO+G8tU68au34rtypv58p8lk2kO4eSVSuhTG1m
         T9jkMBtaKsBVCr0sVLnbInycR4ThijpHTGC3GqX4EOsl17VOgN6WIWYiP2PFmFxd+Qfx
         BI+LbF6JKPCJ+e7MovNVjZL/445sua73NppbMBV15pt1W5xI/G1gS5nQUyJS852+ioLO
         uIscxewDBX8pL0GauESEd1ra0TnU/iNkwCBbSY5IH15u6j1rQ6caAh7RZHuNMDOILLw4
         wyYJaZzM73pT7gqJ9jJZ2oH5DUvTsb4cTEzstgy7ijp7fiYpMT4KK9FnCFos2LAQznUK
         vOhA==
X-Forwarded-Encrypted: i=1; AJvYcCX9hljMh5X9R2MtB7PtbZgfqJuGsnMZZCuMrnizS3Pg3Py4JCjHZmYHPpt7RcSf06WgEqNxNW2kcySCDJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVeS1wTkBxWRnEk787IfC4/L4TmTB84jPR10Qw2lb1CMB5hAUF
	TnXdFVqCNhlQzbwKVl8qBL3QHDFBdP9/VsEhQkUZhZuyW7nsXRvYkq12kxGPW1gh9E4OewzThH3
	XdchO0gYvsRBtsHsKhthZDMdmjvPK3tJeXak2l05fgAg85YiGJRjkf10Kxykpsg==
X-Gm-Gg: ASbGncs8orH8k+TYFGn5c7gBfReZR71fav4c5ZZcU5YGYUnS6Ld8LGUVzE98xbv4T6f
	5oofqbARPQfaSMnrAFTPN7n6xdGU1fCWB08Utth6VLC8SMs2tjV7q2db6fzxlRi3mFpZnADipx2
	jR4GzLDFsoH/vt0L0kRUMM/joOYmRMPHQanTwqnFCpvDuk4atY3YdinfWkdu+ocztH7gwoEztf+
	mNol9QzbU687M3RCdZp7AlwIAyRJ9uiVpjc62Rv5bdol2GeFfKok8kgv9N+AbfZA8nUJF02yEAV
	CsYG1BT8pTUpZtrKvpClMwK0l5cDkg6anQ==
X-Received: by 2002:a5d:47aa:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-3862b345322mr9501048f8f.1.1733754011606;
        Mon, 09 Dec 2024 06:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEimI6Ui0mKxeYiiQzQnI7rasXWcvol+mQTx49rmAZ0iGqXOJRujNGaWhnPX9VCfJ4Dtk3eDQ==
X-Received: by 2002:a5d:47aa:0:b0:385:e9ca:4e18 with SMTP id ffacd0b85a97d-3862b345322mr9501019f8f.1.1733754011212;
        Mon, 09 Dec 2024 06:20:11 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-2-102-14-117.as13285.net. [2.102.14.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f063357csm77489715e9.22.2024.12.09.06.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:20:10 -0800 (PST)
Date: Mon, 9 Dec 2024 14:20:08 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
Message-ID: <Z1b8mGctDusOZPA8@jlelli-thinkpadt14gen4.remote.csb>
References: <20241114142810.794657-1-juri.lelli@redhat.com>
 <20241114142810.794657-3-juri.lelli@redhat.com>
 <cb188000-f0e1-4b0a-9b5a-d725b754c353@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb188000-f0e1-4b0a-9b5a-d725b754c353@stanley.mountain>

Hi,

On 06/12/24 13:43, Dan Carpenter wrote:
> On Thu, Nov 14, 2024 at 02:28:10PM +0000, Juri Lelli wrote:
> >  static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
> >  {
> > -	unsigned long flags;
> > +	unsigned long flags, cap;
> >  	struct dl_bw *dl_b;
> >  	bool overflow = 0;
> > +	u64 fair_server_bw = 0;
>         ^^^^^^^^^^^^^^^^^^
> This is a u64.
> 
> >  
> >  	rcu_read_lock_sched();
> >  	dl_b = dl_bw_of(cpu);
> >  	raw_spin_lock_irqsave(&dl_b->lock, flags);
> >  
> > -	if (req == dl_bw_req_free) {
> > +	cap = dl_bw_capacity(cpu);
> > +	switch (req) {
> > +	case dl_bw_req_free:
> >  		__dl_sub(dl_b, dl_bw, dl_bw_cpus(cpu));
> > -	} else {
> > -		unsigned long cap = dl_bw_capacity(cpu);
> > -
> > +		break;
> > +	case dl_bw_req_alloc:
> >  		overflow = __dl_overflow(dl_b, cap, 0, dl_bw);
> >  
> > -		if (req == dl_bw_req_alloc && !overflow) {
> > +		if (!overflow) {
> >  			/*
> >  			 * We reserve space in the destination
> >  			 * root_domain, as we can't fail after this point.
> > @@ -3501,6 +3503,34 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
> >  			 */
> >  			__dl_add(dl_b, dl_bw, dl_bw_cpus(cpu));
> >  		}
> > +		break;
> > +	case dl_bw_req_deactivate:
> > +		/*
> > +		 * cpu is going offline and NORMAL tasks will be moved away
> > +		 * from it. We can thus discount dl_server bandwidth
> > +		 * contribution as it won't need to be servicing tasks after
> > +		 * the cpu is off.
> > +		 */
> > +		if (cpu_rq(cpu)->fair_server.dl_server)
> > +			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
> > +
> > +		/*
> > +		 * Not much to check if no DEADLINE bandwidth is present.
> > +		 * dl_servers we can discount, as tasks will be moved out the
> > +		 * offlined CPUs anyway.
> > +		 */
> > +		if (dl_b->total_bw - fair_server_bw > 0) {
>                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Since this subtraction is unsigned the condition is equivalent to:
> 
>         if (dl_b->total_bw != fair_server_bw)
> 
> but it feels like maybe it was intended to be:
> 
>         if (dl_b->total_bw > fair_server_bw) {

I actually believe they are equivalent for this case, as if there is a
dl_server total_bw is either equal or bigger than fair_server_bw, so
checking for it to be different than fair_server_bw should still be OK
(even though confusing maybe).

Thanks,
Juri



Return-Path: <linux-kernel+bounces-275403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC219484F7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 23:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EEB1F23A8C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 21:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4D916CD12;
	Mon,  5 Aug 2024 21:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/U5nC5M"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9828816190C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722894167; cv=none; b=COUPWJe6q6bsa+4wNNZlfVufAsDel2nzIas8qdM+crGNyEHfywzT8a9RLQgga/IAR1c0YN+2DSSvKqmIvIXNeDlGUBQdkuy1pT7WkJruUoPiE3ERXFQB+lGjH8pGX62/Dr5xPpkq7M2ZcsBljgk4akfyCDWMi0AlCfKGDYBlBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722894167; c=relaxed/simple;
	bh=1CL9BOJ0mEhfnYReT/6WVWyy2T4vzzx17of5YWsvio4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=TSKh8mU4f7xzlfEg2SsqgOV4kEEhv92PccrOtiGVd8IS+h+saFqtbVNYOosyfGH8YuTiIfvGQHLOQNqTNhXbV5TaXvLmhLPO69uy+whOdGQBi++jqfGCnkAi5Lk4HSi1u9feyRLQa/UjYpE0MgTdRhsO4cLmyR/skWx8a3VQpus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y/U5nC5M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722894164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWLpmNOUmnPHJOdiA3JRIaCGYZSxWHXRf9U3OHgDsOo=;
	b=Y/U5nC5Mnwp4ELrY7IQMCSo4JtYFN5OWW6YR3RlnjF/IpoWS3vzAWXvRQ7Iwi8zwgEfWCd
	RYUupRWILsWPsBFNcc6e/uSWo4Ic3ZuwmE4FGDxPFqGV35/0HV257EzaJ56YPrOlj/MwQ7
	woLzz1HVJ5vGPpQdEyGNMr4QyQu8CF0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-rYxb6dyMOHCJk36-RPEGwQ-1; Mon, 05 Aug 2024 17:42:41 -0400
X-MC-Unique: rYxb6dyMOHCJk36-RPEGwQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ff24acb60dso2103315ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 14:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722894160; x=1723498960;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWLpmNOUmnPHJOdiA3JRIaCGYZSxWHXRf9U3OHgDsOo=;
        b=jRbSRN9HozZbvnnWBOmRbYDlYx2dTfmoXQ1PhDca4VwsSujmHHrDn3RsT/+10N7Zk3
         +0v4OfG7jXD8i/gsBGevFz1YwXuxpOLUqjIKMnRK6p602DyBsxlVx+4wai6nNZCHdr2A
         qZyrLpfuTlbJRM6+lNzUD1VkEtMmITavvcvaNBqDMfxHc3dQKHiqs4+nm74CUcjMFBmw
         /BiugY7ZGQBD6Z12nFqabWFOq9ur389vGlzBztp/09NBdLBayyxJeA4MG2GfGcGzoeq6
         9Z0cvrRaMluqjhiVaY6QCp2i/rZxcYrpjIZgJPO9VRqJwNGvEKGGrRaeTzANsxRjHYNE
         X+Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVw6/hDn0IkNCRT2JL7J2RycU8YbFMscL6MqyYWsSRHLj5O5/qaePT9QKXWycqk2hSFbri39zFNGAQAjHICHXxxkw1yQriZV9UJ8Eqg
X-Gm-Message-State: AOJu0Yx0RqeEUcTPz3Yud4xSn1N2hxQtElKNZcF54fFEhlgOIwAxhpV1
	VOnKOK4TJoPoesbWVJAJ+QMq6AXmmun8HHY6vHEXhtfvhPtuCqRJUMtRltS1S7ExTWsgv/ehPAU
	yH9QNjLoxYhoxj7m6KPNvs4lZkuwclJzKYJ5+R9w+7AwzV0C0xdQHXWvkFK6c5A==
X-Received: by 2002:a17:903:124e:b0:1fd:a412:5df2 with SMTP id d9443c01a7336-1ff524b3d24mr213616015ad.29.1722894160127;
        Mon, 05 Aug 2024 14:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXZL3j0naT+k8M7hE/kMki+FAesMGDGQi+w+0bVCMhZwooc9jPvm5zCXmFA0/m5NNTdyxsjQ==
X-Received: by 2002:a17:903:124e:b0:1fd:a412:5df2 with SMTP id d9443c01a7336-1ff524b3d24mr213615825ad.29.1722894159726;
        Mon, 05 Aug 2024 14:42:39 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:431:c7ed:9fa5:5bef:f08e:c5a8:9864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff59176c89sm73306285ad.192.2024.08.05.14.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 14:42:39 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	neeraj.upadhyay@kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	mingo@kernel.org,
	peterz@infradead.org,
	imran.f.khan@oracle.com,
	riel@surriel.com,
	tglx@linutronix.de
Subject: Re: [PATCH v2 2/3] locking/csd_lock: Provide an indication of ongoing CSD-lock stall
Date: Mon,  5 Aug 2024 18:42:25 -0300
Message-ID: <ZrFHQbmkcGc6DLad@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <c95fd735-30b0-471b-bbcc-7c456acd6dc4@paulmck-laptop>
References: <20240722133559.GA667117@neeraj.linux> <20240722133735.667161-2-neeraj.upadhyay@kernel.org> <ZqquJwsH1vqsZhD2@LeoBras> <c95fd735-30b0-471b-bbcc-7c456acd6dc4@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Jul 31, 2024 at 03:08:29PM -0700, Paul E. McKenney wrote:
> On Wed, Jul 31, 2024 at 06:35:35PM -0300, Leonardo Bras wrote:
> > On Mon, Jul 22, 2024 at 07:07:34PM +0530, neeraj.upadhyay@kernel.org wrote:
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > If a CSD-lock stall goes on long enough, it will cause an RCU CPU
> > > stall warning.  This additional warning provides much additional
> > > console-log traffic and little additional information.  Therefore,
> > > provide a new csd_lock_is_stuck() function that returns true if there
> > > is an ongoing CSD-lock stall.  This function will be used by the RCU
> > > CPU stall warnings to provide a one-line indication of the stall when
> > > this function returns true.
> > 
> > I think it would be nice to also add the RCU usage here, as for the 
> > function being declared but not used.
> 

Hi Paul,

> These are external functions, and the commit that uses it is just a few
> farther along in the stack.

Oh, I see. I may have received just part of this patchset.

I found it weird a series of 3 to have a 4th patch, and did not think that 
it could have more, so I did not check the ML. :)

>  Or do we now have some tool that complains
> if an external function is not used anywhere?

Not really, I was just interested in the patchset but it made no sense in 
my head to add a function & not use it. On top of that, it did not occur to 
me that it was getting included on a different patchset. 

Thanks!
Leo


> 
> > > [ neeraj.upadhyay: Apply Rik van Riel feedback. ]
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Imran Khan <imran.f.khan@oracle.com>
> > > Cc: Ingo Molnar <mingo@kernel.org>
> > > Cc: Leonardo Bras <leobras@redhat.com>
> > > Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > > Cc: Rik van Riel <riel@surriel.com>
> > > Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
> > > ---
> > >  include/linux/smp.h |  6 ++++++
> > >  kernel/smp.c        | 16 ++++++++++++++++
> > >  2 files changed, 22 insertions(+)
> > > 
> > > diff --git a/include/linux/smp.h b/include/linux/smp.h
> > > index fcd61dfe2af3..3871bd32018f 100644
> > > --- a/include/linux/smp.h
> > > +++ b/include/linux/smp.h
> > > @@ -294,4 +294,10 @@ int smpcfd_prepare_cpu(unsigned int cpu);
> > >  int smpcfd_dead_cpu(unsigned int cpu);
> > >  int smpcfd_dying_cpu(unsigned int cpu);
> > >  
> > > +#ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> > > +bool csd_lock_is_stuck(void);
> > > +#else
> > > +static inline bool csd_lock_is_stuck(void) { return false; }
> > > +#endif
> > > +
> > >  #endif /* __LINUX_SMP_H */
> > > diff --git a/kernel/smp.c b/kernel/smp.c
> > > index 81f7083a53e2..9385cc05de53 100644
> > > --- a/kernel/smp.c
> > > +++ b/kernel/smp.c
> > > @@ -207,6 +207,19 @@ static int csd_lock_wait_getcpu(call_single_data_t *csd)
> > >  	return -1;
> > >  }
> > >  
> > > +static atomic_t n_csd_lock_stuck;
> > > +
> > > +/**
> > > + * csd_lock_is_stuck - Has a CSD-lock acquisition been stuck too long?
> > > + *
> > > + * Returns @true if a CSD-lock acquisition is stuck and has been stuck
> > > + * long enough for a "non-responsive CSD lock" message to be printed.
> > > + */
> > > +bool csd_lock_is_stuck(void)
> > > +{
> > > +	return !!atomic_read(&n_csd_lock_stuck);
> > > +}
> > > +
> > >  /*
> > >   * Complain if too much time spent waiting.  Note that only
> > >   * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
> > > @@ -228,6 +241,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> > >  		cpu = csd_lock_wait_getcpu(csd);
> > >  		pr_alert("csd: CSD lock (#%d) got unstuck on CPU#%02d, CPU#%02d released the lock.\n",
> > >  			 *bug_id, raw_smp_processor_id(), cpu);
> > > +		atomic_dec(&n_csd_lock_stuck);
> > >  		return true;
> > >  	}
> > >  
> > > @@ -251,6 +265,8 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
> > >  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %lld ns for CPU#%02d %pS(%ps).\n",
> > >  		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), (s64)ts_delta,
> > >  		 cpu, csd->func, csd->info);
> > > +	if (firsttime)
> > > +		atomic_inc(&n_csd_lock_stuck);
> > >  	/*
> > >  	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> > >  	 * to become unstuck. Use a signed comparison to avoid triggering
> > > -- 
> > > 2.40.1
> > > 
> > 
> > IIUC we have a single atomic counter for the whole system, which is 
> > modified in csd_lock_wait_toolong() and read in RCU stall warning.
> > 
> > I think it should not be an issue regarding cache bouncing because in worst 
> > case scenario we would have 2 modify / cpu each csd_lock_timeout (which is 
> > 5 seconds by default).
> 
> If it does become a problem, there are ways of taking care of it.
> Just a little added complexity.  ;-)
> 
> > Thanks!
> 
> And thank you for looking this over!
> 
> 							Thanx, Paul
> 



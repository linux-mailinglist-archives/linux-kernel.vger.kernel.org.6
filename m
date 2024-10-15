Return-Path: <linux-kernel+bounces-366389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8599F4A4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614E4B234B9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9609206E74;
	Tue, 15 Oct 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceOhChty"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330631850AF
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015229; cv=none; b=danvUz2S2Tsbg9TIUItfFOQHUTm47EPnjMQCSYOEPMZZy5u9cMKFr2yiNCxys+7Ao76/6vusKjBfoLsaZ2U8iFqjvhQzqQnq4AqPyE2HfV56GpYYVrgoWIA2CO+wq48vGFlJN9RoBeqlvqwNPCieJ8GPhF0BKOBvYXHGqyAdQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015229; c=relaxed/simple;
	bh=DKs7FFGDb0nM7IDJBBUmvGB2LDgLDm2l+01USGXGpg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqeR1ra1qrbfV5SMuNl7OJJ5Sl+vgla141uj0fBir7pe3q5z46mtPs1zjNPmoA53B2EGFhm0Tm5UnfaCsgUBqMV9jX/ula4Bu/FY23Efs8X6nPKE/CURTwv+D7SUHODW3flIAmwWj9QVIdkal67ha3sXNCA2WCKWVusnvWl4KrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceOhChty; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b13b3fa372so50272185a.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729015226; x=1729620026; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S1BxdHEZWEliogyG1J+QY5fDw9FHV13egUIB/DvmL3U=;
        b=ceOhChtyEFE7mS7CO1y5F2pJ/7F6YICsBapxA/gmkekDC41mAR5Mq3dNu/iRb0wjw7
         DbwqxvI7iKw7IcYfXv/VzXxEUbxb+ugaA7rA2IyidlBiy91kVdWHXRhjWrOs/HCGtT/7
         N7iVrect0XKz+hCIDpKgnTe5qZFKB3erquSU7zN7eIIR9GyXKS1/VzLYZAW1U2HeY8Kn
         IhD9RzdqHibf87KobvLokpfV1DKo7Krbnax/hcDOvjMue+Fp3oucG3TXyhtW9LEEmxNY
         b6tKjOfeOhg+6OAbCD6tFfJG09mPpI68lK/tM3TFjwP+mozuxk33H4rtd6RgeAUyCLho
         M2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729015226; x=1729620026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1BxdHEZWEliogyG1J+QY5fDw9FHV13egUIB/DvmL3U=;
        b=Pdb83DsW+UzGz2oMrEv8T//7wT8FHdBigqamnENVcxRvcaDatYe/mXZvHJR5t5cICv
         p+FeTCbDjcJ0ls8zkxmOROC5hzmD6O5fcxXmWZzDcl38DyzfbK68VYfDQyqfP7k506sJ
         eWsrvnf6MvpJjUtO72fgu3AUqYnOef5hmEKwAqkZQwA5W/HnUqPGBbYZoO3i+J5dNDfQ
         +QG1IVApD8vI+yF9Y1NBUf9tEYXFqDN1bf2znd8KZFBiyyB9Ca4O+IJQYrxJduxg/SgY
         eZUen/LAJR+Bt5vK4hbMZH/PN+HPtB9UFi/4YL2XgTfUjPVN8uGWXJSuZ3bXRF3Mh6rC
         CVdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLPEnV+W97oQajzexUuokyKZZW0oeKaNveO6iSD5lsS+acA3chCJH7BJO+WaQ4BRfx/4IvSzWSP/x8W3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1rusfs628TJfCKMaCkQGy9uoXBygoqxCf2a7LC7JrCvVMIQfp
	E0ucPh1Xxp2dBYYkdZuR289QymOmt+ElESIpT/sOnTeaflI7QiK3
X-Google-Smtp-Source: AGHT+IG3qUIEHF+/l4+dB9oEUoz9L9Ss69/+kPyUP9BPLldKpPPv3PHWPLqsDBOOWldQqXN+GALvpg==
X-Received: by 2002:a05:620a:2682:b0:7ae:6ba2:faba with SMTP id af79cd13be357-7b1417f7c6emr131030985a.28.1729015225780;
        Tue, 15 Oct 2024 11:00:25 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13639a509sm97324085a.92.2024.10.15.11.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 11:00:24 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 180961200043;
	Tue, 15 Oct 2024 14:00:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 15 Oct 2024 14:00:24 -0400
X-ME-Sender: <xms:t60OZ4He3l78Rere98IL9sk648DpUykLLWYo1PkgYz3NjttLnYgCzw>
    <xme:t60OZxW_ruVhCEM6HbM-1xuMl-Jba2kE2hRUtMrFwVT1WRv6V_0psCYsQ47aZ2Wo1
    sZg6gmZ2jo8FoKnOQ>
X-ME-Received: <xmr:t60OZyKS0B_fFwyCiTFP3AQFOklDMc-NBb87cR0ZJkdmXXWG8da1fqs3c3fx7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepuddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehthhhomhgrshdrhhgvlhhlshhtrhhomh
    eslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehinhhtvghlqdigvgeslhhi
    shhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehpvghtvghriiesih
    hnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonh
    hgmhgrnhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnheslhgrnhhk
    hhhorhhsthdrshgvpdhrtghpthhtoheptghhrhhishhtihgrnhdrkhhovghnihhgsegrmh
    gurdgtohhmpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggv
    shhkthhophdrohhrgh
X-ME-Proxy: <xmx:t60OZ6EwVGcgW-7BBveew-JkT-pzRsbM721e4VZvFbKiMl41Udmktg>
    <xmx:uK0OZ-UeOVHeI6lvilkV1RVJb6mqx6GvYf5oOQ8fbg6g4wQb2zQ9Xg>
    <xmx:uK0OZ9OBFnkkdO95VyZmG5C5kiAz2xwvCH-QKpuf1-7okldiSQuaGw>
    <xmx:uK0OZ11qWuL0yF0xQ2AzlVN6sLin5YJbg3CyHvZ7H0VK5mGz2uXcmQ>
    <xmx:uK0OZ3Wke1iSBapnGNHHSRKHk_-o2mCf0u-Fcy6SiJyt_-fQnTHS-S65>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 14:00:23 -0400 (EDT)
Date: Tue, 15 Oct 2024 11:00:02 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Cc: intel-xe@lists.freedesktop.org, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Maarten Lankhorst <maarten@lankhorst.se>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] locking/ww_mutex: Adjust to lockdep nest_lock
 requirements
Message-ID: <Zw6touohNwfqs3T0@boqun-archlinux>
References: <20241009092031.6356-1-thomas.hellstrom@linux.intel.com>
 <Zw19sMtnKdyOVQoh@boqun-archlinux>
 <bf7632b74c075f2c430fdb98cefed486b4d9e74f.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf7632b74c075f2c430fdb98cefed486b4d9e74f.camel@linux.intel.com>

On Tue, Oct 15, 2024 at 05:27:28PM +0200, Thomas Hellström wrote:
[..]
> > diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
> > index 6f6a5fc85b42..6750321e3e9a 100644
> > --- a/lib/locking-selftest.c
> > +++ b/lib/locking-selftest.c
> > @@ -1720,8 +1720,6 @@ static void ww_test_normal(void)
> >  {
> >         int ret;
> > 
> > -       WWAI(&t);
> > -
> >         /*
> >          * None of the ww_mutex codepaths should be taken in the
> > 'normal'
> >          * mutex calls. The easiest way to verify this is by using
> > the
> > @@ -1770,6 +1768,8 @@ static void ww_test_normal(void)
> >         ww_mutex_base_unlock(&o.base);
> >         WARN_ON(o.ctx != (void *)~0UL);
> > 
> > +       WWAI(&t);
> > +
> >         /* nest_lock */
> >         o.ctx = (void *)~0UL;
> >         ww_mutex_base_lock_nest_lock(&o.base, &t);
> > 
> > Please confirm whether this change is intended.
> 
> This fix looks correct and while this change was not intended, I think
> it makes sense and if this locking order is present in existing code
> apart from this selftest, it's probably easily fixable.
> 
> > 
> > The second is a case as follow:
> > 
> > 	ww_acquire_init(...);
> > 	spin_lock(...);
> > 	ww_mutex_lock(...); // this should trigger a context
> > 			    // invalidation. But the mutex was
> > 			    // initialized by ww_acquire_init() as a
> > 			    // LD_WAIT_INV lock.
> > 
> > The following could fix this:
> > 
> > diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> > index a401a2f31a77..45ff6f7a872b 100644
> > --- a/include/linux/ww_mutex.h
> > +++ b/include/linux/ww_mutex.h
> > @@ -156,8 +156,8 @@ static inline void ww_acquire_init(struct
> > ww_acquire_ctx *ctx,
> >         debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
> >         lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
> >                          &ww_class->acquire_key, 0);
> > -       lockdep_init_map(&ctx->first_lock_dep_map, ww_class-
> > >mutex_name,
> > -                        &ww_class->mutex_key, 0);
> > +       lockdep_init_map_wait(&ctx->first_lock_dep_map, ww_class-
> > >mutex_name,
> > +                             &ww_class->mutex_key, 0,
> > LD_WAIT_SLEEP);
> >         mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
> >         mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx-
> > >dep_map, _RET_IP_);
> >  #endif
> > 
> > A v3 with all these fixed would look good to me, and I can add a
> > Tested-by tag to it. Thanks!
> 
> The fix here is a bit confusing. It looks like this test is crafted to
> fail because we take a sleeping ww_mutex inside a spinlock. But the
> ww_mutex lockdep map is already initialized as LD_WAIT_SLEEP. How come
> the first_lock_dep_map locking mode LD_WAIT_INV is used in the
> ww_mutex_lock()? Is that because of the lockdep hlock refcounting?
> 

No, it's not because of refcounting, actually in this case refcounting
won't happen because there is a spin_lock sitting in between:

held_locks stack:

	ww_lockdep_acquire
	  ww_lockdep_mutex
	    lock_A

because there is a lock_A here, the following "if" will be false for
ww_mutex_lock() in the test case:

	hlock = curr->held_locks + depth - 1;
	if (hlock->class_idx == class_idx && nest_lock) {

The reason why the wait types of 'first_lock_dep_map' matter is because
the lock class it shares with ww_mutex_lock() are registered at
*acquire* time. So because we do

	ww_acquire_init():
	  ...
	  lockdep_init_map(...);
	  ...
	  mutex_acquire_nest(...);
	...
	ww_mutex_lock():
	  __mutex_lock_common():
	    mutex_acquire_nest(...);

in the test case, these two mutex_acquire_nest()s use different
lockdep_maps but share the same key, therefore whoever call
mutex_acquire_nest() registers the lock class with its wait types.

So even though first_lock_dep_map is a fake lock, it has to have the
same wait types as a real mutex.

Does this make sense?

Regards,
Boqun

> Thanks,
> Thomas
> 
> 
> 
> > 
> > Regards,
> > Boqun
> > 
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Waiman Long <longman@redhat.com>
> > > Cc: Boqun Feng <boqun.feng@gmail.com>
> > > Cc: Maarten Lankhorst <maarten@lankhorst.se>
> > > Cc: Christian König <christian.koenig@amd.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > ---
> > >  include/linux/ww_mutex.h       | 14 ++++++++++++++
> > >  kernel/locking/test-ww_mutex.c |  8 +++++---
> > >  2 files changed, 19 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
> > > index bb763085479a..a401a2f31a77 100644
> > > --- a/include/linux/ww_mutex.h
> > > +++ b/include/linux/ww_mutex.h
> > > @@ -65,6 +65,16 @@ struct ww_acquire_ctx {
> > >  #endif
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > >  	struct lockdep_map dep_map;
> > > +	/**
> > > +	 * @first_lock_dep_map: fake lockdep_map for first locked
> > > ww_mutex.
> > > +	 *
> > > +	 * lockdep requires the lockdep_map for the first locked
> > > ww_mutex
> > > +	 * in a ww transaction to remain in memory until all
> > > ww_mutexes of
> > > +	 * the transaction have been unlocked. Ensure this by
> > > keeping a
> > > +	 * fake locked ww_mutex lockdep map between
> > > ww_acquire_init() and
> > > +	 * ww_acquire_fini().
> > > +	 */
> > > +	struct lockdep_map first_lock_dep_map;
> > >  #endif
> > >  #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> > >  	unsigned int deadlock_inject_interval;
> > > @@ -146,7 +156,10 @@ static inline void ww_acquire_init(struct
> > > ww_acquire_ctx *ctx,
> > >  	debug_check_no_locks_freed((void *)ctx, sizeof(*ctx));
> > >  	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
> > >  			 &ww_class->acquire_key, 0);
> > > +	lockdep_init_map(&ctx->first_lock_dep_map, ww_class-
> > > >mutex_name,
> > > +			 &ww_class->mutex_key, 0);
> > >  	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
> > > +	mutex_acquire_nest(&ctx->first_lock_dep_map, 0, 0, &ctx-
> > > >dep_map, _RET_IP_);
> > >  #endif
> > >  #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
> > >  	ctx->deadlock_inject_interval = 1;
> > > @@ -185,6 +198,7 @@ static inline void ww_acquire_done(struct
> > > ww_acquire_ctx *ctx)
> > >  static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
> > >  {
> > >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> > > +	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
> > >  	mutex_release(&ctx->dep_map, _THIS_IP_);
> > >  #endif
> > >  #ifdef DEBUG_WW_MUTEXES
> > > diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-
> > > ww_mutex.c
> > > index 10a5736a21c2..5d58b2c0ef98 100644
> > > --- a/kernel/locking/test-ww_mutex.c
> > > +++ b/kernel/locking/test-ww_mutex.c
> > > @@ -62,7 +62,8 @@ static int __test_mutex(unsigned int flags)
> > >  	int ret;
> > >  
> > >  	ww_mutex_init(&mtx.mutex, &ww_class);
> > > -	ww_acquire_init(&ctx, &ww_class);
> > > +	if (flags & TEST_MTX_CTX)
> > > +		ww_acquire_init(&ctx, &ww_class);
> > >  
> > >  	INIT_WORK_ONSTACK(&mtx.work, test_mutex_work);
> > >  	init_completion(&mtx.ready);
> > > @@ -90,7 +91,8 @@ static int __test_mutex(unsigned int flags)
> > >  		ret = wait_for_completion_timeout(&mtx.done,
> > > TIMEOUT);
> > >  	}
> > >  	ww_mutex_unlock(&mtx.mutex);
> > > -	ww_acquire_fini(&ctx);
> > > +	if (flags & TEST_MTX_CTX)
> > > +		ww_acquire_fini(&ctx);
> > >  
> > >  	if (ret) {
> > >  		pr_err("%s(flags=%x): mutual exclusion failure\n",
> > > @@ -679,7 +681,7 @@ static int __init test_ww_mutex_init(void)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -	ret = stress(2047, hweight32(STRESS_ALL)*ncpus,
> > > STRESS_ALL);
> > > +	ret = stress(2046, hweight32(STRESS_ALL)*ncpus,
> > > STRESS_ALL);
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > -- 
> > > 2.46.0
> > > 
> 


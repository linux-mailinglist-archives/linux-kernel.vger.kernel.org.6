Return-Path: <linux-kernel+bounces-511509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2902A32C07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F833AA679
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6A2505B3;
	Wed, 12 Feb 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0CBKqQI"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840C209F38
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378335; cv=none; b=J40Ewgk5onyAWpg9T7kOA7T2yRjE249t8uohkNH8cG6QVyn/L7uaIzmgd8AWZwxaZhp4Iy1mfML3OBeW+vhqmc6gB750h9SU+XKvxlniKJOAWptlxJ4Lti45zP/J/nTnU8P4RNj/+YQxC2cJG8/a1xCfi4hPTunxdPyAemM+StE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378335; c=relaxed/simple;
	bh=yCPQyPB8m7MMG4k8HGjewL6EMln1CRdVD6NoI5zA3yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeyBRebDKP6X82G+DJkDdM8CmtgpB7Q7h7yi0BON0AS5+ahyC1/EXMZZfqkWqnsCMevx/VB1hlJalaXl6ePIUfEm5ie4N18yQlrqyXFSZiomahhjwJhUFNmi1QhQMqQ9MM2k/bpwXByGhbyyloi75HTks74Bkd5oteZdpDVzf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0CBKqQI; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c079f1d96fso8679385a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739378331; x=1739983131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5tx6vpK3HZBw7aJjPT7qFcAgBl4KLdbUjzf9HttGhk=;
        b=E0CBKqQIdItIJK7kWuYv2Vjj90jtcsTMJSByw4nLsgI02SXY+rzEBC9qJ+xaLe2Ukh
         cJCZqngq/bFSls09r2lltGIq+k+bHJZx/Z358wiAzShIMKLMQytbEdFDDFsrzXoyIdtu
         UJ7b8WuQW1ULpsnoaHmDgtnvle1gDIDdT0Bvwb+CFTU0jI/fAvcgZE0Wz3AhoYqBxnxr
         RpVgMJYdzgMfRwgGlzar0Fe6wm/ZiOu+K13Q8DtIac0D7MGBs1svLGsHrUMktKjmFhlr
         FHkGTVrEJ+VDr0D8N1IttoSxWLtTWM/EXvwu455F6ijlmOkKsptM7AcQp3unB/IjM5dR
         h//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378331; x=1739983131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5tx6vpK3HZBw7aJjPT7qFcAgBl4KLdbUjzf9HttGhk=;
        b=Roe4Ix24OuDH7gVFbJLJfG8peLQ4aqrU/pmk1OFERjx4n4MHvpIsqISjzwyTZRcF3t
         bSM6SHzwi4boSIV0vFxTKaDN4tA0mEiLz7EoDOdaRHh72S4caM+1pI/+VSSuk5RdvKjy
         GsiDROHvIUT0aOBtDEJJfCtOdF1RGql4YOLMdxsq8/VpiUzNRxbkRSVT57YvYJjidk5p
         mB4p6BSH+sXYjyB/wFKgKB/+sNBhCh/uc2WAqXJXVNs4sgHvZmgXTLDuPohtI9ZAODmH
         6PmjqoVQP5pGLEAx5CM6w8Zv08KOb/xe2G7HHdEA1gEU1JCRPurV/LsHSvXsQlkMAKX/
         FHeA==
X-Forwarded-Encrypted: i=1; AJvYcCVwxht2z2MjfnLGjIeMnygBwWt8R76p2tMSAHHue5KZBp0XzALDo9jA4IxebOlvCTly9oQt71him4rpBJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYZUqD+lZ38NH4QoWqKnkSWlZ35x7PQ8yOfpdxYsjSORpI+83
	SeOmyXHfP7bgG/N/rG3JJ2qizsBGjGbpLleLmLATV3op4ylnDUdi
X-Gm-Gg: ASbGncsG0Ldb6B87xP0J4lbQtGnkoUerAWOiif7dm5kkXDgv9RS2A6wNUWPfNKU1hQ9
	e6In9sRVNvHTO/Zwl+WIS/yC3hzKafm4iW+yUDl0EFzMDnrmKy72Yk0H0+suevJMCvOfOpnEgQ1
	tUyfJwr0RD56rCl7ShT3ulLoOv4yOJwBExWK2laEe2l2bQ/VJuH2agKixMKmK4X6Jqg51vo+S5L
	EX85cWCerumOUHwgCUxyNP1JYdHq5eabcmJOev/bzKLBRvCJuurdHhbSG7Ix4jIsNowCi6TnNIc
	+1MeewYuPucqcWH89Rq2JmEuCtREIeNFxvIDe87MV5njzzd90qJuookqB2aSp/7qyy34terK0qF
	9/SC55Q==
X-Google-Smtp-Source: AGHT+IGbz1pPKdnBLxyzQrQBiZGGSUFNF62513UzPcbrTxZCtm3q+QOtvHblxSxRMDNq6pOSP4ZrPw==
X-Received: by 2002:a05:620a:44d4:b0:7c0:6076:76fe with SMTP id af79cd13be357-7c06fc570f9mr513968785a.3.1739378330859;
        Wed, 12 Feb 2025 08:38:50 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0648ebfd3sm376115085a.27.2025.02.12.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:38:50 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBFDB120006A;
	Wed, 12 Feb 2025 11:38:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 12 Feb 2025 11:38:49 -0500
X-ME-Sender: <xms:mc6sZwwJ7FFKHhnyjtbcdF5YC6-iwBPiksYfA-M8Ob8JhObIwrMMzQ>
    <xme:mc6sZ0S-pvilmKBI0jZYcC-Y3KoEd3rMTP8xPYN6Vnoy8X0huylghSSNZwT41jsF-
    rLeEt7bHS5t-4oahA>
X-ME-Received: <xmr:mc6sZyVzAATZyVD62Nlqu4dMbnw0JSzTDgl9v8vT1sXuMvgAOAdNwnBcCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleel
    ieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehllhhonhhgsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehm
    ihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopeifihhllhdruggvrggtohhnse
    grrhhmrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghoqhhunhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:mc6sZ-iwo5wJ5sDjFv64nb7uAjMETpXnv3R5WWAHKd79bqCCRpDVsQ>
    <xmx:mc6sZyCHxkRDQ3W0MXI9G5Ez2rphNYfsqtslaNLr0FaZ-K5auqA2vQ>
    <xmx:mc6sZ_LkVHhYmtQeIJlzRi0dhYtrk2Wmx-XJNJ-hm2bzssJZJ6cy3A>
    <xmx:mc6sZ5B4jN-S1Hy6ELOM4mNPT2B8HWJXI5HmdymazWxLg2fAgYuErg>
    <xmx:mc6sZyyCkXDDyrm1GRuo-4qRKUBW3G3tyJA5juDJzvkzAPKm__mUt829>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 11:38:49 -0500 (EST)
Date: Wed, 12 Feb 2025 08:38:47 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <Z6zOlw2moxw0OAsZ@Mac.home>
References: <20250127013127.3913153-1-longman@redhat.com>
 <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com>
 <Z6w1cvz29NkMZh9b@Mac.home>
 <5f518ef0-2dbc-4d14-82ce-ad310a780598@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f518ef0-2dbc-4d14-82ce-ad310a780598@redhat.com>

On Wed, Feb 12, 2025 at 09:10:25AM -0500, Waiman Long wrote:
> On 2/12/25 12:45 AM, Boqun Feng wrote:
> > On Tue, Feb 11, 2025 at 09:18:56PM -0500, Waiman Long wrote:
> > > On 1/26/25 8:31 PM, Waiman Long wrote:
> > > > A circular lock dependency splat has been seen involving down_trylock().
> > > > 
> > > > [ 4011.795602] ======================================================
> > > > [ 4011.795603] WARNING: possible circular locking dependency detected
> > > > [ 4011.795607] 6.12.0-41.el10.s390x+debug
> > > > [ 4011.795612] ------------------------------------------------------
> > > > [ 4011.795613] dd/32479 is trying to acquire lock:
> > > > [ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
> > > > [ 4011.795636]
> > > > [ 4011.795636] but task is already holding lock:
> > > > [ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0
> > > > 
> > > >     the existing dependency chain (in reverse order) is:
> > > >     -> #4 (&zone->lock){-.-.}-{2:2}:
> > > >     -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
> > > >     -> #2 (&rq->__lock){-.-.}-{2:2}:
> > > >     -> #1 (&p->pi_lock){-.-.}-{2:2}:
> > > >     -> #0 ((console_sem).lock){-.-.}-{2:2}:
> > > > 
> > > > The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
> > > > while holding the console.sem raw_spinlock. This dependency can be broken
> > > > by using wake_q to do the wakeup instead of calling try_to_wake_up()
> > > > under the console_sem lock. This will also make the semaphore's
> > > > raw_spinlock become a terminal lock without taking any further locks
> > > > underneath it.
> > > > 
> > > > The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
> > > > spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
> > > > the debug_objects_fill_pool() helper function in the debugobjects code.
> > > > 
> > > > [ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
> > > > [ 4011.795650]        __lock_acquire+0xe86/0x1cc0
> > > > [ 4011.795655]        lock_acquire.part.0+0x258/0x630
> > > > [ 4011.795657]        lock_acquire+0xb8/0xe0
> > > > [ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
> > > > [ 4011.795663]        rmqueue_bulk+0xac/0x8f0
> > > > [ 4011.795665]        __rmqueue_pcplist+0x580/0x830
> > > > [ 4011.795667]        rmqueue_pcplist+0xfc/0x470
> > > > [ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
> > > > [ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
> > > > [ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
> > > > [ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
> > > > [ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
> > > > [ 4011.795684]        allocate_slab+0x320/0x460
> > > > [ 4011.795686]        ___slab_alloc+0xa58/0x12b0
> > > > [ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
> > > > [ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
> > > > [ 4011.795692]        fill_pool+0xf6/0x450
> > > > [ 4011.795697]        debug_object_activate+0xfe/0x360
> > > > [ 4011.795700]        enqueue_hrtimer+0x34/0x190
> > > > [ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
> > > > [ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
> > > > [ 4011.795707]        hrtimer_interrupt+0x316/0x760
> > > > [ 4011.795709]        do_IRQ+0x9a/0xe0
> > > > [ 4011.795712]        do_irq_async+0xf6/0x160
> > > > 
> > > > Normally raw_spinlock to spinlock dependency is not legit
> > > > and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
> > > > but debug_objects_fill_pool() is an exception as it explicitly
> > > > allows this dependency for non-PREEMPT_RT kernel without causing
> > > > PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
> > > > legit and not a bug.
> > > > 
> > > > Anyway, semaphore is the only locking primitive left that is still
> > > > using try_to_wake_up() to do wakeup inside critical section, all the
> > > > other locking primitives had been migrated to use wake_q to do wakeup
> > > > outside of the critical section. It is also possible that there are
> > > > other circular locking dependencies involving printk/console_sem or
> > > > other existing/new semaphores lurking somewhere which may show up in
> > > > the future. Let just do the migration now to wake_q to avoid headache
> > > > like this.
> > > I can also add the following as another instance where deadlock can happen.
> > > 
> > > Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
> > > 
> > FWIW, I already queued in my lockdep-for-tip branch, will send it in a
> > PR to Peter in one or two weeks (in case he hasn't taken it before
> > then).
> > 
> > BTW, do we need a "Fixes" tag for stable kernels?
> 
> After some more thought, I realize that this patch doesn't really fix the
> circular lock dependency problem, it just remove console_sem.lock from it.
> The problem is that printk() can be called in any context. To really solve
> the problem, we will need some kind of deferred wakeup using workqueue, for
> instance. As printing to the console is inherently slow, adding some more

Hmm... but your patch does remove the dependency console_sem.lock ->
pi_lock, right? So it does fix the circular lock dependency problem. Or
do you mean that it doesn't fix all the deadlocks that may cause by
printk()?

Regards,
Boqun

> latency to the wakeup process shouldn't really be a problem. This patch will
> be the first step, I will work on additional patches to complete this
> deferred wakeup functionality. So I don't need to add a Fixes tag for now.
> You can either take this patch out or just leave it there.
> 
> Cheers,
> Longman
> 


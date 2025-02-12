Return-Path: <linux-kernel+bounces-511597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB080A32D1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D22E3A42A6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB21325EF8C;
	Wed, 12 Feb 2025 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ON0rgpWU"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20C725E44E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739380171; cv=none; b=nKvdP77LCdz6S4zbhMp5x1tMMfRdmTH5w0tIsS0a+DqF34Z9ySl62D5EFpoELArtPQtkDUWLel1amUAP/VEulMQ/JXyxp+A4BqZcQ67PF25Xqt6fOL8lyXEzW3YAmMPo81kn9r5hvOahtjTpYWXoDBR8tyIoDhRRBx63oXkqaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739380171; c=relaxed/simple;
	bh=asL01wWRqDJNjsgqu/y9RKdoDVQjlEyRfalqiVqi3h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKWbnDnRaZAMz2+tFKXJjCt5p4bq8npvZt3IctgJim0mSEbOzuT3x+eJnNSE6eD/wVwLqQqEdndjxN/bmxUVVCGUg2Tq2IGGUBNpvo2jCYhAcmdZB6sLmFRWDmN7goFbbw+qSF/ITtw7tNE6yxXnXBg0TP0TMa9D5w2sQHORIc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ON0rgpWU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-471bef62e12so316681cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739380169; x=1739984969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pYZCLKsySzJgIc8+gvgk3OCa/deZTg4lFACkckbwTrg=;
        b=ON0rgpWUA3uEB/KF+bMNwNvOovCeZWCx7UutSDJDaCmq88p5zHGAAIWSbGGglq72AY
         bwGm3j63cdfHkbSqjcnUdyJqJTpO831ba1iNich/oQyPm/tjocWSA3z+kqoHmqw6cEuT
         SaVD4oIK0N5Ku5niDXb53eEYmkUylTCcNCQWNGCE9iVrj5gM4J5QsNqKearCsoha0JkV
         iBTvisjRlcNwsDjNI13+cq1c556qlN7XrUBI/87pysf34jcQTWpB41JVhjQq6G0Z25Py
         p7/LufgpcAEppdkGAjlSE2youMSsXCiWajq5yWj6/RaB48lLx2muEhII9+I4o2/NvDaP
         98Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739380169; x=1739984969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYZCLKsySzJgIc8+gvgk3OCa/deZTg4lFACkckbwTrg=;
        b=d4F7TusBv9EBizchzxAu5DM/MPXwggMhhtVzG/QbLtt0Sd/UCo9wAv7zYOpxBxyMkg
         ziSxckgM7SMgAH3HbvCxtalOS76Uhzdvs2btuxFJE023RA3zoarhs7bTLzqHnLJLVE5Q
         mhfSN0OVLcgXL297nrn1S6yHcFrZH41gZBJr4Fwi/jHSCtO31uthyBWaq2Lpd6m4PmVI
         +jiE2QE2sBTCWQjHWVWuZPxANmzy4Bj9Yqn8E5ua34vsZQNpVf+oEFie7umOM8cwOe5l
         aWQtkcq+kigQm+Fdj0UPuaeNE0ZWU2s2OjFQT4tcmqmHlTeTHP+cz1oXMH6dl7bK2Es2
         WOaw==
X-Forwarded-Encrypted: i=1; AJvYcCV9sYo7BM2Xn/k4SpzdQkHs4jr7PLZjCBnBzOOtaICn4E0QP1uzXU3WgVNIsw1zCf5REd1jonfPWd9eNFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGlpjptF2n0aIzJQqvzmhFY1UbMqYJKL+tFXtdwcU7qFTTXz+
	UlDMgbXFmY/j8TA6x1uFLDZ0wsADfvtO9rZSaqUCEQ+xqPY31D4Z64Unfw==
X-Gm-Gg: ASbGncubOmRvteQkSjAwBn84HatXsdbW9h1938RFZbdJTDh3A8evDJ/Tk7Wit9oWlth
	4McQoOJTNW4Zhft7BPEQ/UshTjG1VqMZd2jioUjDuHYoFd1bp6t8AXNajRDMzlZLVAP4BzBjgIP
	yCNeBCo9O5S7j/UpRCBuO90dGLpNETC1eMPgp5exauzc5AF7MfkvmhAuypH9HWTiVBLWzPahns/
	eclNAqH/wEELdGXN7RKwA6p6sOPtWjVP68mhl75qqIdYXrUB6X69wOwl7mDmlnuJ/kpjg3onUN4
	GMkF3BZUz1COvvCEOSBK0QVBP5QFV3LT1n0uIWANZ45XDqblLVyd2zUkqlmMGn2rDQbNVgg5BUm
	t75iVkQ==
X-Google-Smtp-Source: AGHT+IGA5Ce38E80wI6pFNKGW0sQph+jcTRqdFbSrxiFeQSsO1Cgy+Rh3Q69EZ4Eq7f7+elFqS3mkA==
X-Received: by 2002:a05:6214:c46:b0:6e1:afcf:8711 with SMTP id 6a1803df08f44-6e46ed77a9amr69610606d6.8.1739380168708;
        Wed, 12 Feb 2025 09:09:28 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65c3309d0sm154756d6.7.2025.02.12.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:09:28 -0800 (PST)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E65B120007C;
	Wed, 12 Feb 2025 12:09:28 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 12 Feb 2025 12:09:28 -0500
X-ME-Sender: <xms:x9WsZwMHLULPBpNn1AEhGec3vvTb1w1dzR8tXh0U-q76bhV_NkC9xg>
    <xme:x9WsZ2_KMvrlUbouIjLaUmn33xa8cQ2G2l2kpZ2hTI8e0ggkEcHAnUvJFXYIatJRp
    mBgifP76TAzvxMUNg>
X-ME-Received: <xmr:x9WsZ3RDNAEznWNpF-1eX1pq6adhxKs7RFFUy1qSYleIAD8xYiv-Ch-UMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepiedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhlohhnghesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    mhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlrdguvggrtghonh
    esrghrmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:x9WsZ4tcroNHr0Re99pFx5OhE5UUgKobnn_fVFGtVqXoeO9dHmNxwQ>
    <xmx:x9WsZ4cNys6rkfPQWtUvwoFf6PJfgFpl9TI_ve1W7gtLeBmTmZcTAA>
    <xmx:x9WsZ82oiZ_CIv6QBbTeLAMYRKxmDDr3qZpieja2jTAGlMQvpeXAlg>
    <xmx:x9WsZ8-e3nA3_1qdh84jbE06cEcAURBgot2FXSbIISToLEjh-MAH9A>
    <xmx:yNWsZ_9k_AKKuBJF0A18caRHDpDdXyly99ACHbYNe2b7B9KAqA8wuCSm>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 12:09:27 -0500 (EST)
Date: Wed, 12 Feb 2025 09:09:26 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] locking/semaphore: Use wake_q to wake up processes
 outside lock critical section
Message-ID: <Z6zVxtOdiH7GbVH0@Mac.home>
References: <20250127013127.3913153-1-longman@redhat.com>
 <3e45144d-d147-4431-91be-63d0817fa2ce@redhat.com>
 <Z6w1cvz29NkMZh9b@Mac.home>
 <5f518ef0-2dbc-4d14-82ce-ad310a780598@redhat.com>
 <Z6zOlw2moxw0OAsZ@Mac.home>
 <efbe0c96-2bc6-4520-a90d-57e273f9f613@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <efbe0c96-2bc6-4520-a90d-57e273f9f613@redhat.com>

On Wed, Feb 12, 2025 at 11:45:31AM -0500, Waiman Long wrote:
> 
> On 2/12/25 11:38 AM, Boqun Feng wrote:
> > On Wed, Feb 12, 2025 at 09:10:25AM -0500, Waiman Long wrote:
> > > On 2/12/25 12:45 AM, Boqun Feng wrote:
> > > > On Tue, Feb 11, 2025 at 09:18:56PM -0500, Waiman Long wrote:
> > > > > On 1/26/25 8:31 PM, Waiman Long wrote:
> > > > > > A circular lock dependency splat has been seen involving down_trylock().
> > > > > > 
> > > > > > [ 4011.795602] ======================================================
> > > > > > [ 4011.795603] WARNING: possible circular locking dependency detected
> > > > > > [ 4011.795607] 6.12.0-41.el10.s390x+debug
> > > > > > [ 4011.795612] ------------------------------------------------------
> > > > > > [ 4011.795613] dd/32479 is trying to acquire lock:
> > > > > > [ 4011.795617] 0015a20accd0d4f8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x26/0x90
> > > > > > [ 4011.795636]
> > > > > > [ 4011.795636] but task is already holding lock:
> > > > > > [ 4011.795637] 000000017e461698 (&zone->lock){-.-.}-{2:2}, at: rmqueue_bulk+0xac/0x8f0
> > > > > > 
> > > > > >      the existing dependency chain (in reverse order) is:
> > > > > >      -> #4 (&zone->lock){-.-.}-{2:2}:
> > > > > >      -> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
> > > > > >      -> #2 (&rq->__lock){-.-.}-{2:2}:
> > > > > >      -> #1 (&p->pi_lock){-.-.}-{2:2}:
> > > > > >      -> #0 ((console_sem).lock){-.-.}-{2:2}:
> > > > > > 
> > > > > > The console_sem -> pi_lock dependency is due to calling try_to_wake_up()
> > > > > > while holding the console.sem raw_spinlock. This dependency can be broken
> > > > > > by using wake_q to do the wakeup instead of calling try_to_wake_up()
> > > > > > under the console_sem lock. This will also make the semaphore's
> > > > > > raw_spinlock become a terminal lock without taking any further locks
> > > > > > underneath it.
> > > > > > 
> > > > > > The hrtimer_bases.lock is a raw_spinlock while zone->lock is a
> > > > > > spinlock. The hrtimer_bases.lock -> zone->lock dependency happens via
> > > > > > the debug_objects_fill_pool() helper function in the debugobjects code.
> > > > > > 
> > > > > > [ 4011.795646] -> #4 (&zone->lock){-.-.}-{2:2}:
> > > > > > [ 4011.795650]        __lock_acquire+0xe86/0x1cc0
> > > > > > [ 4011.795655]        lock_acquire.part.0+0x258/0x630
> > > > > > [ 4011.795657]        lock_acquire+0xb8/0xe0
> > > > > > [ 4011.795659]        _raw_spin_lock_irqsave+0xb4/0x120
> > > > > > [ 4011.795663]        rmqueue_bulk+0xac/0x8f0
> > > > > > [ 4011.795665]        __rmqueue_pcplist+0x580/0x830
> > > > > > [ 4011.795667]        rmqueue_pcplist+0xfc/0x470
> > > > > > [ 4011.795669]        rmqueue.isra.0+0xdec/0x11b0
> > > > > > [ 4011.795671]        get_page_from_freelist+0x2ee/0xeb0
> > > > > > [ 4011.795673]        __alloc_pages_noprof+0x2c2/0x520
> > > > > > [ 4011.795676]        alloc_pages_mpol_noprof+0x1fc/0x4d0
> > > > > > [ 4011.795681]        alloc_pages_noprof+0x8c/0xe0
> > > > > > [ 4011.795684]        allocate_slab+0x320/0x460
> > > > > > [ 4011.795686]        ___slab_alloc+0xa58/0x12b0
> > > > > > [ 4011.795688]        __slab_alloc.isra.0+0x42/0x60
> > > > > > [ 4011.795690]        kmem_cache_alloc_noprof+0x304/0x350
> > > > > > [ 4011.795692]        fill_pool+0xf6/0x450
> > > > > > [ 4011.795697]        debug_object_activate+0xfe/0x360
> > > > > > [ 4011.795700]        enqueue_hrtimer+0x34/0x190
> > > > > > [ 4011.795703]        __run_hrtimer+0x3c8/0x4c0
> > > > > > [ 4011.795705]        __hrtimer_run_queues+0x1b2/0x260
> > > > > > [ 4011.795707]        hrtimer_interrupt+0x316/0x760
> > > > > > [ 4011.795709]        do_IRQ+0x9a/0xe0
> > > > > > [ 4011.795712]        do_irq_async+0xf6/0x160
> > > > > > 
> > > > > > Normally raw_spinlock to spinlock dependency is not legit
> > > > > > and will be warned if PROVE_RAW_LOCK_NESTING is enabled,
> > > > > > but debug_objects_fill_pool() is an exception as it explicitly
> > > > > > allows this dependency for non-PREEMPT_RT kernel without causing
> > > > > > PROVE_RAW_LOCK_NESTING lockdep splat. As a result, this dependency is
> > > > > > legit and not a bug.
> > > > > > 
> > > > > > Anyway, semaphore is the only locking primitive left that is still
> > > > > > using try_to_wake_up() to do wakeup inside critical section, all the
> > > > > > other locking primitives had been migrated to use wake_q to do wakeup
> > > > > > outside of the critical section. It is also possible that there are
> > > > > > other circular locking dependencies involving printk/console_sem or
> > > > > > other existing/new semaphores lurking somewhere which may show up in
> > > > > > the future. Let just do the migration now to wake_q to avoid headache
> > > > > > like this.
> > > > > I can also add the following as another instance where deadlock can happen.
> > > > > 
> > > > > Reported-by:syzbot+ed801a886dfdbfe7136d@syzkaller.appspotmail.com
> > > > > 
> > > > FWIW, I already queued in my lockdep-for-tip branch, will send it in a
> > > > PR to Peter in one or two weeks (in case he hasn't taken it before
> > > > then).
> > > > 
> > > > BTW, do we need a "Fixes" tag for stable kernels?
> > > After some more thought, I realize that this patch doesn't really fix the
> > > circular lock dependency problem, it just remove console_sem.lock from it.
> > > The problem is that printk() can be called in any context. To really solve
> > > the problem, we will need some kind of deferred wakeup using workqueue, for
> > > instance. As printing to the console is inherently slow, adding some more
> > Hmm... but your patch does remove the dependency console_sem.lock ->
> > pi_lock, right? So it does fix the circular lock dependency problem. Or
> > do you mean that it doesn't fix all the deadlocks that may cause by
> > printk()?
> 
> Right, it doesn't  fix all the deadlocks that may be caused by printk().
> Similar circular lock dependency splat will still happen. It will start with
> pi_lock instead of console_sem.lock and will have one less lock in the
> circular list. It is caused by waking up process within the printk()
> context. That is why I think the proper solution is to have a deferred
> wakeup. It will be specific to the printk() use cases.
> 

Sounds good. Then I will take this patch, because 1) it fixes an issue
(although partially) and 2) the fix is toward the right direction (i.e.
avoiding wakeup inside critical section). Thanks!

Regards,
Boqun

> Cheers,
> Longman
> 


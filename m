Return-Path: <linux-kernel+bounces-324319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAE7974B16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314E62875E7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9766F13C810;
	Wed, 11 Sep 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDuvwKwH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0768BE7
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039056; cv=none; b=GHfRQuXkUhxT0K7cQaYifOpq4hi+MvIKtzCsOtFoP/rPj44YxY4EdBmXXhNPBTmAfgA6aPQuxG02BqdKsDIDFy5CuL8W3J5ijYGzI+yGY7qtI8jeeWFT9+xHY8mDF7jiVS5hLyCEoIPt0E1omFc2YdB4tBwcQLhCiS+NwSr8/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039056; c=relaxed/simple;
	bh=rAXfuwy7B2+QXySHJ14taKQMc/nkJ5KahS/kgFJm4Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=rqdQCGoO8/5yhDpEizNRVRGSaI+8bLrfZ1yhcjpH+3PC4sQSfDTP7Z4X3KF+3jMZaH6gizGRuOQoagzyH+Z/LemP0UaqDygngzB1fog010eBUNBD7B4wCmYQT6q5EKWvQFEGFjRPSGFwBTc/VCLD7lt5XIW0BBTLJ2CLt5Ue9ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDuvwKwH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726039052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EWS0zdSRA6QBuHeVPu9p9QQM9sNJybBO18pUWus00es=;
	b=BDuvwKwHV5+2sbuZT+3eT2+2rZ/p9j0YbVifPGMjJB7q2fHEA4Gh/ddy+4XOgeml8RB6q2
	z2Atpt0Fgkv972VXLyj3RL9WSuy78jI1ZXtONJDXMWUtAWxdAjAjbx1YxQclxQaam58/N9
	cUgPHMvIuwcWy5xRrXY1jlq4XE7TPEU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-oNaXzNZoNUqxwosi42M08Q-1; Wed, 11 Sep 2024 03:17:30 -0400
X-MC-Unique: oNaXzNZoNUqxwosi42M08Q-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-7d4f9974c64so5180763a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039049; x=1726643849;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EWS0zdSRA6QBuHeVPu9p9QQM9sNJybBO18pUWus00es=;
        b=I1jKX6dzDJ1IkJOFf9/CkjxmVyUN3zxDaZ3uTUTPzaPZbnmmlBwodzXrDwZvGTUKDZ
         kRGXERDyjQ6mLFXc8i7LChcB8OGgbnhEv4AMlYuouA76SlIZb+ZEz+yLod3gQi9gMFRc
         L7R6t/QJaAl9tDbyLkONyKIRpPi9k8MYWdG4iDE7taCklX6NbIjqQVTwWdeyI8BGTpr6
         Dm0wMhwvzgUbBagYasR/BP85gIqUaLE2rXaYd7u0FkqwPrbSXejLUAUdk5Zmkju4PI/D
         GUL/yqcxA1GFTXkztHBfhxwJJRlULrBeXC1ZUqGWle+JnII1VsCI9wst53EWEalQC8Ba
         K1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCWQHQ7KMTY8KsPLnVGEGhMbcEJNQ2frH965FVllTsRJEcPyB7u3UXBpEb9YbtVpMLo2vH0UvSN+b0BxKWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTE6wBayK4sJkhlKyHjP9q8SVaCnxC2739ySvdBaJ4uxGWzin
	ZZH+l4SF6N4673Jc0DvVlufiTlB7shwWqJf3koXiO24Dxp1fenRXikBrqIgrT9YQwS59O4Mf3E2
	bYemWkUTaEUGOAARKCdyf+DOshlaK+j3+QmPLGsAwITTJss09lUzd1TbmT0zweA==
X-Received: by 2002:a05:6a20:d526:b0:1ce:cde2:4458 with SMTP id adf61e73a8af0-1cf5e15710amr5116831637.35.1726039049180;
        Wed, 11 Sep 2024 00:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfPMdzQCpRyvsuzf833UGi7nTs6J1w1LxjL6dvBwUdC2XXOTOBOy5/7LWeNy6FfSCYJeydpA==
X-Received: by 2002:a05:6a20:d526:b0:1ce:cde2:4458 with SMTP id adf61e73a8af0-1cf5e15710amr5116788637.35.1726039048478;
        Wed, 11 Sep 2024 00:17:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a800:3c59:c8f1:7d33:571a:fde2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db12af2c69sm419278a12.38.2024.09.11.00.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:17:27 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 1/4] Introducing qpw_lock() and per-cpu queue & flush work
Date: Wed, 11 Sep 2024 04:17:05 -0300
Message-ID: <ZuFD8bR01GhPbPH6@LeoBras>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
References: <20240622035815.569665-1-leobras@redhat.com> <20240622035815.569665-2-leobras@redhat.com> <f69793ab-41c3-4ae2-a8b1-355e629ffd0b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Sep 04, 2024 at 05:39:01PM -0400, Waiman Long wrote:
> On 6/21/24 23:58, Leonardo Bras wrote:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with some unrelated task is
> > sure to introduce unexpected deadline misses.
> > 
> > It's interesting, though, that local_lock()s in RT kernels become
> > spinlock(). We can make use of those to avoid scheduling work on a remote
> > cpu by directly updating another cpu's per_cpu structure, while holding
> > it's spinlock().
> > 
> > In order to do that, it's necessary to introduce a new set of functions to
> > make it possible to get another cpu's per-cpu "local" lock (qpw_{un,}lock*)
> > and also the corresponding queue_percpu_work_on() and flush_percpu_work()
> > helpers to run the remote work.
> > 
> > On non-RT kernels, no changes are expected, as every one of the introduced
> > helpers work the exactly same as the current implementation:
> > qpw_{un,}lock*()        ->  local_{un,}lock*() (ignores cpu parameter)
> > queue_percpu_work_on()  ->  queue_work_on()
> > flush_percpu_work()     ->  flush_work()
> > 
> > For RT kernels, though, qpw_{un,}lock*() will use the extra cpu parameter
> > to select the correct per-cpu structure to work on, and acquire the
> > spinlock for that cpu.
> > 
> > queue_percpu_work_on() will just call the requested function in the current
> > cpu, which will operate in another cpu's per-cpu object. Since the
> > local_locks() become spinlock()s in PREEMPT_RT, we are safe doing that.
> > 
> > flush_percpu_work() then becomes a no-op since no work is actually
> > scheduled on a remote cpu.
> > 
> > Some minimal code rework is needed in order to make this mechanism work:
> > The calls for local_{un,}lock*() on the functions that are currently
> > scheduled on remote cpus need to be replaced by qpw_{un,}lock_n*(), so in
> > RT kernels they can reference a different cpu. It's also necessary to use a
> > qpw_struct instead of a work_struct, but it just contains a work struct
> > and, in PREEMPT_RT, the target cpu.
> > 
> > This should have almost no impact on non-RT kernels: few this_cpu_ptr()
> > will become per_cpu_ptr(,smp_processor_id()).
> > 
> > On RT kernels, this should improve performance and reduce latency by
> > removing scheduling noise.
> > 
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> > ---
> >   include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100644 include/linux/qpw.h
> > 
> > diff --git a/include/linux/qpw.h b/include/linux/qpw.h
> > new file mode 100644
> > index 000000000000..ea2686a01e5e
> > --- /dev/null
> > +++ b/include/linux/qpw.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_QPW_H
> > +#define _LINUX_QPW_H
> > +
> > +#include "linux/local_lock.h"
> > +#include "linux/workqueue.h"
> > +
> > +#ifndef CONFIG_PREEMPT_RT
> > +
> > +struct qpw_struct {
> > +	struct work_struct work;
> > +};
> > +
> > +#define qpw_lock(lock, cpu)					\
> > +	local_lock(lock)
> > +
> > +#define qpw_unlock(lock, cpu)					\
> > +	local_unlock(lock)
> > +
> > +#define qpw_lock_irqsave(lock, flags, cpu)			\
> > +	local_lock_irqsave(lock, flags)
> > +
> > +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
> > +	local_unlock_irqrestore(lock, flags)
> > +
> > +#define queue_percpu_work_on(c, wq, qpw)			\
> > +	queue_work_on(c, wq, &(qpw)->work)
> > +
> > +#define flush_percpu_work(qpw)					\
> > +	flush_work(&(qpw)->work)
> > +
> > +#define qpw_get_cpu(qpw)					\
> > +	smp_processor_id()
> > +
> > +#define INIT_QPW(qpw, func, c)					\
> > +	INIT_WORK(&(qpw)->work, (func))
> > +
> > +#else /* !CONFIG_PREEMPT_RT */
> > +
> > +struct qpw_struct {
> > +	struct work_struct work;
> > +	int cpu;
> > +};
> > +
> > +#define qpw_lock(__lock, cpu)					\
> > +	do {							\
> > +		migrate_disable();				\
> > +		spin_lock(per_cpu_ptr((__lock), cpu));		\
> > +	} while (0)
> > +
> > +#define qpw_unlock(__lock, cpu)					\
> > +	do {							\
> > +		spin_unlock(per_cpu_ptr((__lock), cpu));	\
> > +		migrate_enable();				\
> > +	} while (0)
> 
> Why there is a migrate_disable/enable() call in qpw_lock/unlock()? The
> rt_spin_lock/unlock() calls have already include a migrate_disable/enable()
> pair.

This was copied from PREEMPT_RT=y local_locks.

In my tree, I see:

#define __local_unlock(__lock)					\
	do {							\
		spin_unlock(this_cpu_ptr((__lock)));		\
		migrate_enable();				\
	} while (0)

But you are right:
For PREEMPT_RT=y, spin_{un,}lock() will be defined in spinlock_rt.h
as rt_spin{un,}lock(), which already runs migrate_{en,dis}able().

On the other hand, for spin_lock() will run migrate_disable() just before 
finishing the function, and local_lock() will run it before calling 
spin_lock() and thus, before spin_acquire().

(local_unlock looks like to have an unnecessary extra migrate_enable(), 
though).

I am not sure if it's actually necessary to run this extra 
migrate_disable() in local_lock() case, maybe Thomas could help us 
understand this.

But sure, if we can remove this from local_{un,}lock(), I am sure we can 
also remove this from qpw.


> 
> > +
> > +#define qpw_lock_irqsave(lock, flags, cpu)			\
> > +	do {							\
> > +		typecheck(unsigned long, flags);		\
> > +		flags = 0;					\
> > +		qpw_lock(lock, cpu);				\
> > +	} while (0)
> > +
> > +#define qpw_unlock_irqrestore(lock, flags, cpu)			\
> > +	qpw_unlock(lock, cpu)
> > +
> > +#define queue_percpu_work_on(c, wq, qpw)			\
> > +	do {							\
> > +		struct qpw_struct *__qpw = (qpw);		\
> > +		WARN_ON((c) != __qpw->cpu);			\
> > +		__qpw->work.func(&__qpw->work);			\
> > +	} while (0)
> > +
> > +#define flush_percpu_work(qpw)					\
> > +	do {} while (0)
> > +
> > +#define qpw_get_cpu(w)						\
> > +	container_of((w), struct qpw_struct, work)->cpu
> > +
> > +#define INIT_QPW(qpw, func, c)					\
> > +	do {							\
> > +		struct qpw_struct *__qpw = (qpw);		\
> > +		INIT_WORK(&__qpw->work, (func));		\
> > +		__qpw->cpu = (c);				\
> > +	} while (0)
> > +
> > +#endif /* CONFIG_PREEMPT_RT */
> > +#endif /* LINUX_QPW_H */
> 
> You may also consider adding a documentation file about the
> qpw_lock/unlock() calls.

Sure, will do when I send the non-RFC version. Thanks for pointing that 
out!

> 
> Cheers,
> Longman
> 

Thanks!
Leo



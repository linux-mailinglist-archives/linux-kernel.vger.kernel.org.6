Return-Path: <linux-kernel+bounces-228231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FA0915D18
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0107A1F2676C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C2945BE3;
	Tue, 25 Jun 2024 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcvCZzol"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BF945978
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719284297; cv=none; b=n5hAyDBh/CQe2FRrTeIOwLNhtkLwnv/iwYGk6FiLc3DbR0t+MaeAJo1UMlN0VGWAzFy5lTrncJUHgz9b5U0TLBvnE6VLwX3R4Y51exVc3RRbcNCs749Uz/uHrrKe2oq4IDmWWbIF5Gowgq9suRDzz2VrSsE6qLTRtrnUPUvPWmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719284297; c=relaxed/simple;
	bh=CcLS3OTowtx3R9+9pzXuHh+HYKrUE882Dv3fEaCiOsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=aDZ0Sz6TH4EP4u5ci95SKFaw/0H6Xhb+YQHcFvn1spy/aVELzjtZ+gAmK8hu9BIP+eZy1mHVfC9LJe+3M7X3bK7se6A0IiircFuGSqs2eP0iMAr2kS7nITtgd4yGJ03JfauowY00/6NvGQoC/y2ELiky3q4JhwpVvS2y1ZJpku8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcvCZzol; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719284294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syJjt5ixA/f0tjdi5WdyuW2MiVMWIPWhYOIIe9HkUzQ=;
	b=gcvCZzoln7H+CTIwO4JxZhuFMF4rxdaaRsvChX4WbJms9Ka5ZL3B1P3SMgZ85idwBgdBow
	EuoVizvSxkLT5x7CNl3IeOO2VDAGbu1/41d8EuRFPNVebpGpd0DtMq6WxoT+7Sfney2smn
	9488DD/ZeRuxCevjLEoftqf6kO/T4lc=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-Q9khuMWIPmWQRexWt-6RgA-1; Mon, 24 Jun 2024 22:58:11 -0400
X-MC-Unique: Q9khuMWIPmWQRexWt-6RgA-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f6174d0421so54776825ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719284290; x=1719889090;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=syJjt5ixA/f0tjdi5WdyuW2MiVMWIPWhYOIIe9HkUzQ=;
        b=jHRbxmoZWEnEofXlPDWGd1lqH+M+1dtOlwWoOK15U1nKsi6IIgpUTJBO0vQEJKqtcZ
         oOMwyMe1NJHcZznHby+EcR5iYFJmUSiMBaklMZKEHh7nLkRDCcK29sgBCnI2xeTyKJOA
         Cm9DrM8mqih7Blesv4DMCuXmreZYAvdXSOPhaRBW43Ma2PpERlm3h6koP+E7OM54N44A
         RkTElx2cFe99cOQfdNgzLwxauLWO9Ca6hSs+FJNTDVfnklbWg09HJj9sNFos578+HN6C
         f8JM3VrWCu/j4Y+1B8vIpcNycZR+nS5t5cYjUgQ9+BvrSiUCL1FVAcyRZoFaoVyHhIL2
         lxBw==
X-Forwarded-Encrypted: i=1; AJvYcCVKBgqGj9owJRLcHthcWE3XA+7EIItoc5CXTvUmZvEgnzKS4/6xe3J1XgQMQwPjHcPlcjWSAgdNpeSG+Yg48nhVURbmxsu2PJZouJoW
X-Gm-Message-State: AOJu0YxllGSLUBClQbOpGs7JI8O4uW89XsWw5GgnGRIKEN7XiazKB2kL
	bFKdHv6hN0/KHXP3k5fyVU3/CSdhxRJcOba6m4mo1OD0x1T2VFbr7iQEwumTNOXQiVUgAzoq/gP
	TK5zErMe6AHoiseOjekIeAumbMqTxtEsDvwF0vCKGVFoqoQ5Xm6VX+znOISv1CA==
X-Received: by 2002:a17:902:e851:b0:1fa:cbf:c8b9 with SMTP id d9443c01a7336-1fa158f79b2mr91419525ad.38.1719284290576;
        Mon, 24 Jun 2024 19:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4BRlOcWHTc7rAkYWYrFoBO7157nBjNcPk/UZJfP6+36id69+6Snc9jGenlIdVCvXxJPkqSQ==
X-Received: by 2002:a17:902:e851:b0:1fa:cbf:c8b9 with SMTP id d9443c01a7336-1fa158f79b2mr91419225ad.38.1719284290153;
        Mon, 24 Jun 2024 19:58:10 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:fda9:d11e:3755:61da:97fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32973asm69694765ad.113.2024.06.24.19.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 19:58:09 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Mon, 24 Jun 2024 23:57:57 -0300
Message-ID: <ZnoyNQLQdyAcMxjP@LeoBras>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Znn5FgqoCAUAfQhu@boqun-archlinux>
References: <20240622035815.569665-1-leobras@redhat.com> <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz> <Znn5FgqoCAUAfQhu@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 24, 2024 at 03:54:14PM -0700, Boqun Feng wrote:
> On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> > Hi,
> > 
> > you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> > section in MAINTAINERS so I've added folks from there in my reply.
> 
> Thanks!
> 
> > Link to full series:
> > https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/
> > 
> 
> And apologies to Leonardo... I think this is a follow-up of:
> 
> 	https://lpc.events/event/17/contributions/1484/
> 
> and I did remember we had a quick chat after that which I suggested it's
> better to change to a different name, sorry that I never found time to
> write a proper rely to your previous seriese [1] as promised.
> 
> [1]: https://lore.kernel.org/lkml/20230729083737.38699-2-leobras@redhat.com/

That's correct, I commented about this in the end of above presentation.
Don't worry, and thanks for suggesting the per-cpu naming, it was very 
helpful on designing this solution.

> 
> > On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > > The problem:
> > > Some places in the kernel implement a parallel programming strategy
> > > consisting on local_locks() for most of the work, and some rare remote
> > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > kernels, even though the very few remote operations will be expensive due
> > > to scheduling overhead.
> > > 
> > > On the other hand, for RT workloads this can represent a problem: getting
> > > an important workload scheduled out to deal with remote requests is
> > > sure to introduce unexpected deadline misses.
> > > 
> > > The idea:
> > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > > In this case, instead of scheduling work on a remote cpu, it should
> > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > work locally. Tha major cost, which is un/locking in every local function,
> > > already happens in PREEMPT_RT.
> > 
> > I've also noticed this a while ago (likely in the context of rewriting SLUB
> > to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> > the idea. But I forgot the details about why, so I'll let the the locking
> > experts reply...
> > 
> 
> I think it's a good idea, especially the new name is less confusing ;-)
> So I wonder Thomas' thoughts as well.

Thanks!

> 
> And I think a few (micro-)benchmark numbers will help.

Last year I got some numbers on how replacing local_locks with 
spinlocks would impact memcontrol.c cache operations:

https://lore.kernel.org/all/20230125073502.743446-1-leobras@redhat.com/

tl;dr: It increased clocks spent in the most common this_cpu operations, 
while reducing clocks spent in remote operations (drain_all_stock).

In RT case, since local locks are already spinlocks, this cost is 
already paid, so we can get results like these:

drain_all_stock
cpus	Upstream 	Patched		Diff (cycles)	Diff(%)
1	44331.10831	38978.03581	-5353.072507	-12.07520567
8	43992.96512	39026.76654	-4966.198572	-11.2886198
128	156274.6634	58053.87421	-98220.78915	-62.85138425

Upstream: Clocks to schedule work on remote CPU (performing not accounted)
Patched:  Clocks to grab remote cpu's spinlock and perform the needed work 
	  locally.

Do you have other suggestions to use as (micro-) benchmarking?

Thanks!
Leo


> 
> Regards,
> Boqun
> 
> > > Also, there is no need to worry about extra cache bouncing:
> > > The cacheline invalidation already happens due to schedule_work_on().
> > > 
> > > This will avoid schedule_work_on(), and thus avoid scheduling-out an 
> > > RT workload. 
> > > 
> > > For patches 2, 3 & 4, I noticed just grabing the lock and executing
> > > the function locally is much faster than just scheduling it on a
> > > remote cpu.
> > > 
> > > Proposed solution:
> > > A new interface called Queue PerCPU Work (QPW), which should replace
> > > Work Queue in the above mentioned use case. 
> > > 
> > > If PREEMPT_RT=n, this interfaces just wraps the current 
> > > local_locks + WorkQueue behavior, so no expected change in runtime.
> > > 
> > > If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
> > > per-cpu structure and perform work on it locally. This is possible
> > > because on functions that can be used for performing remote work on
> > > remote per-cpu structures, the local_lock (which is already
> > > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > > 
> > > Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
> > > current local_lock + WorkQueue interface by the QPW interface in
> > > swap, memcontrol & slub interface.
> > > 
> > > Please let me know what you think on that, and please suggest
> > > improvements.
> > > 
> > > Thanks a lot!
> > > Leo
> > > 
> > > Leonardo Bras (4):
> > >   Introducing qpw_lock() and per-cpu queue & flush work
> > >   swap: apply new queue_percpu_work_on() interface
> > >   memcontrol: apply new queue_percpu_work_on() interface
> > >   slub: apply new queue_percpu_work_on() interface
> > > 
> > >  include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> > >  mm/memcontrol.c     | 20 ++++++-----
> > >  mm/slub.c           | 26 ++++++++------
> > >  mm/swap.c           | 26 +++++++-------
> > >  4 files changed, 127 insertions(+), 33 deletions(-)
> > >  create mode 100644 include/linux/qpw.h
> > > 
> > > 
> > > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> > 
> 



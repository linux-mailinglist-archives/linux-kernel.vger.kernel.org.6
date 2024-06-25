Return-Path: <linux-kernel+bounces-228206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E05C915C51
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C44B20EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C56A433B1;
	Tue, 25 Jun 2024 02:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6Of6d5J"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10501CA8D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719282995; cv=none; b=QqA1IygqVEEDL76Pjor9K4e/dX8LhJtnheyD+S67VvmYYviOUDL7iNaRA0ao0kASDCdhU7iAKccE3tvhacfkpKcYh3XP63NJfU9xDJFz0kxwmnnLiPt1kKK64OufLmlxdqKrECHBe4ZweYQq6NOyFnaUPWbtY90UTZfCWs+Q8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719282995; c=relaxed/simple;
	bh=E3dRV3THCRl8+7F7g/EIdSW3iGC+lN12chAsAfvgans=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=WgfNH6okgQvP/GqPY/4pzxV2K/o9cz05Q+/9ljH7HpI5brIS6uhocEyVSiCWgtqb6fe9caD+iGNaHqoXVS2KO5UHhpRd4JU9BE1mRdJ353z5w06lVmtVkr0ApAcSZOFvv8g5poCXpc6EFYZlDLBl4c0hB7DstjyyQeKkNtvm/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6Of6d5J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719282992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgjh/ZqyuyNc2ziwefd5jIC6p/c9Pbm133iPEufxgFk=;
	b=S6Of6d5Jdw3yiPYHikH1KxuxNbJ2CbLTzI9FKc7ihXnOGKlc9zFTqZIGZxxQzvkz0Tvb7i
	Fwe6I/H4hy4MHtriKQW4O8xBYTxu1NIByWsFxB17UV8aEk/LcU22ZseM7A4hWq6kgJeD5H
	nVAwqOQFDr1e0Oig3y+n6hj/gEIeUj8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-7YypkadPOO2UBrmE6wVqpw-1; Mon, 24 Jun 2024 22:36:31 -0400
X-MC-Unique: 7YypkadPOO2UBrmE6wVqpw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6c380e03048so6042319a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 19:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719282990; x=1719887790;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgjh/ZqyuyNc2ziwefd5jIC6p/c9Pbm133iPEufxgFk=;
        b=Y/fzWxTlnx7Z4Y9mzj9WGUTkYszqI/XeisyjKEsU04Yk2pHlpQLttc6YF968MMfp8H
         lUHEulxZ7EYJuDuQot95B29BUPpN/89bqw/DsMqwurXVzFDXpHOpDw0Yp1CDPtqt/gWp
         jU6koCnGlcXi/5ollnXwTy3gkADxyBb1EHGQ1UAHCcktQm1LSdDCmHfG7XJDVV6zLDPQ
         pFuASbuTWa2LVzzZHsTm0nl7FZwBY07DYOX5jJVyCjTHp57hPu+ecq2Ga9tX6SvCM/ci
         tk5vjuY3p+CGkXIePLfV15vVCQ3KXqmW1bcyiQ7C+cF+tTGMh09EaTFzZo8STJ+nuJ+T
         Okog==
X-Forwarded-Encrypted: i=1; AJvYcCUqjoIDyk5fQldEHF0J1oArd1Rn0rJFyVd2y9o1Ar5VnGt0+Vnpt4VF2V8P7qhUQVNj51WoxTuml2owTPi6gnIV6PTfwtatra8sNwyA
X-Gm-Message-State: AOJu0YxwsOWAGRIKe/7vJzsQZr5VbYTe3DymZlqlRvkhDCQJr9BQL9q9
	+I+7gCjNNCx74J62RyhoegAJZrvvq3c1GvTP9w2viBQQenS5OQ+Ml/v/hN8P3qVoi9Ow9r7naa9
	H8JqY1Z6Ac+uwPmc+7+vhLGjtzVtFzZnpP5f2WJHHfBt+gz6R/L/W2iQM3rI1kQ==
X-Received: by 2002:a17:902:f54c:b0:1f9:ddea:451d with SMTP id d9443c01a7336-1fa23bdf3b8mr64915055ad.3.1719282990061;
        Mon, 24 Jun 2024 19:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4WMoko6gcC4VFyy3g03y2NymCh8kug4N9kCWpYbiJNlDLdPwV2S623AMwW20um4Llrvh4oA==
X-Received: by 2002:a17:902:f54c:b0:1f9:ddea:451d with SMTP id d9443c01a7336-1fa23bdf3b8mr64914795ad.3.1719282989651;
        Mon, 24 Jun 2024 19:36:29 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a801:fda9:d11e:3755:61da:97fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f038asm69440895ad.52.2024.06.24.19.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 19:36:29 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Vlastimil Babka <vbabka@suse.cz>
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
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Mon, 24 Jun 2024 23:36:21 -0300
Message-ID: <ZnotJB-8YM562QsR@LeoBras>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
References: <20240622035815.569665-1-leobras@redhat.com> <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> Hi,
> 
> you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> section in MAINTAINERS so I've added folks from there in my reply.
> Link to full series:
> https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/

Thanks Vlastimil!

> 
> On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > The problem:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with remote requests is
> > sure to introduce unexpected deadline misses.
> > 
> > The idea:
> > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > In this case, instead of scheduling work on a remote cpu, it should
> > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > work locally. Tha major cost, which is un/locking in every local function,
> > already happens in PREEMPT_RT.
> 
> I've also noticed this a while ago (likely in the context of rewriting SLUB
> to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> the idea. But I forgot the details about why, so I'll let the the locking
> experts reply...
> 
> > Also, there is no need to worry about extra cache bouncing:
> > The cacheline invalidation already happens due to schedule_work_on().
> > 
> > This will avoid schedule_work_on(), and thus avoid scheduling-out an 
> > RT workload. 
> > 
> > For patches 2, 3 & 4, I noticed just grabing the lock and executing
> > the function locally is much faster than just scheduling it on a
> > remote cpu.
> > 
> > Proposed solution:
> > A new interface called Queue PerCPU Work (QPW), which should replace
> > Work Queue in the above mentioned use case. 
> > 
> > If PREEMPT_RT=n, this interfaces just wraps the current 
> > local_locks + WorkQueue behavior, so no expected change in runtime.
> > 
> > If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
> > per-cpu structure and perform work on it locally. This is possible
> > because on functions that can be used for performing remote work on
> > remote per-cpu structures, the local_lock (which is already
> > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > 
> > Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
> > current local_lock + WorkQueue interface by the QPW interface in
> > swap, memcontrol & slub interface.
> > 
> > Please let me know what you think on that, and please suggest
> > improvements.
> > 
> > Thanks a lot!
> > Leo
> > 
> > Leonardo Bras (4):
> >   Introducing qpw_lock() and per-cpu queue & flush work
> >   swap: apply new queue_percpu_work_on() interface
> >   memcontrol: apply new queue_percpu_work_on() interface
> >   slub: apply new queue_percpu_work_on() interface
> > 
> >  include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> >  mm/memcontrol.c     | 20 ++++++-----
> >  mm/slub.c           | 26 ++++++++------
> >  mm/swap.c           | 26 +++++++-------
> >  4 files changed, 127 insertions(+), 33 deletions(-)
> >  create mode 100644 include/linux/qpw.h
> > 
> > 
> > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> 



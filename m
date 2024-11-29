Return-Path: <linux-kernel+bounces-425227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F79DBF14
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CEE281A88
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A66155753;
	Fri, 29 Nov 2024 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZk5qmH2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05301552E4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 04:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732855189; cv=none; b=ZmXvuulSRXU+PYMl1HEoSupK8/lXtf11+lwMfgI/IczRmxg+nOlifWc3+WAThPgoCCXCuBB9rENVl7kYfPaf6bifw0MLHtwnz0Czt6zKrrxfY5g62l2wlzyvPj1fuwmoPq5LYPnNvg+reAL/0Mx8Z0yXgvshChi1ucDke1lGfaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732855189; c=relaxed/simple;
	bh=tNVaavRCEpRbTS3oB3arsLU1HVqHx9Hwzc2EcWVF+oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekm5vGrRzw8Mg7lzjfoWFh3b39AICU+5JuBeVJHgpsu1vKJ5YUGHO70OdqYVUFADOBLI+q2hB7Ru6j2ioaxl6sS4kw564wFHdgfuDbWPndhKmGYxMSjl6gYZtwHKcdwOaXr/N3ynp/aSzQNWuzxv2desa9UKuDy9R0pi9Sy5pH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZk5qmH2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732855186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RzFXXHDdcs/VvVbBdMyuNhGF0MKwUMd0fbOPDUe9+/o=;
	b=hZk5qmH2Uhhyv3JIydQshAYBHDQkaphXU44+dCnBn2afOjghri7xuhs6Ujj4HwJ3jPDMfQ
	v/Bfz7RWy9/r00c4ctZfcyFP3lkV+7Lea/ZbZxZVGCD6xIEXKUisFMJxBaYxAXxnggZ181
	0deeIHTXMHDGxkw3+dDz/RCC46ThjNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-RMzaHnOYNgulRJu-4OcHCg-1; Thu,
 28 Nov 2024 23:39:42 -0500
X-MC-Unique: RMzaHnOYNgulRJu-4OcHCg-1
X-Mimecast-MFC-AGG-ID: RMzaHnOYNgulRJu-4OcHCg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 574CC19560B5;
	Fri, 29 Nov 2024 04:39:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E81A6195605A;
	Fri, 29 Nov 2024 04:39:38 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	snishika@redhat.com
Subject: Re: [PATCH] mm: vmscan: ensure kswapd is woken up if the wait queue is active
Date: Fri, 29 Nov 2024 13:39:35 +0900
Message-ID: <20241129043936.316481-1-snishika@redhat.com>
In-Reply-To: <20241127164948.74659f9400fd076760c2a670@linux-foundation.org>
References: <20241127164948.74659f9400fd076760c2a670@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Nov 28, 2024 at 9:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 27 Nov 2024 00:06:12 +0900 Seiji Nishikawa <snishika@redhat.com> wrote:
>
> > Even after commit 501b26510ae3 ("vmstat: allow_direct_reclaim should use
> > zone_page_state_snapshot"), a task may remain indefinitely stuck in
> > throttle_direct_reclaim() while holding mm->rwsem.
> >
> > __alloc_pages_nodemask
> >  try_to_free_pages
> >   throttle_direct_reclaim
> >
> > This can cause numerous other tasks to wait on the same rwsem, leading
> > to severe system hangups:
> >
> > [1088963.358712] INFO: task python3:1670971 blocked for more than 120 seconds.
> > [1088963.365653]       Tainted: G           OE     -------- -  - 4.18.0-553.el8_10.aarch64 #1
> > [1088963.373887] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [1088963.381862] task:python3         state:D stack:0     pid:1670971 ppid:1667117 flags:0x00800080
> > [1088963.381869] Call trace:
> > [1088963.381872]  __switch_to+0xd0/0x120
> > [1088963.381877]  __schedule+0x340/0xac8
> > [1088963.381881]  schedule+0x68/0x118
> > [1088963.381886]  rwsem_down_read_slowpath+0x2d4/0x4b8
> >
> > The issue arises when allow_direct_reclaim(pgdat) returns false,
> > preventing progress even when the pgdat->pfmemalloc_wait wait queue is
> > empty. Despite the wait queue being empty, the condition,
> > allow_direct_reclaim(pgdat), may still be returning false, causing it to
> > continue looping.
> >
> > In some cases, reclaimable pages exist (zone_reclaimable_pages() returns
> >  > 0), but calculations of pfmemalloc_reserve and free_pages result in
> > wmark_ok being false.
> >
> > And then, despite the pgdat->kswapd_wait queue being non-empty, kswapd
> > is not woken up, further exacerbating the problem:
> >
> > crash> px ((struct pglist_data *) 0xffff00817fffe540)->kswapd_highest_zoneidx
> > $775 = __MAX_NR_ZONES
> >
> > This patch modifies allow_direct_reclaim() to wake kswapd if the
> > pgdat->kswapd_wait queue is active, regardless of whether wmark_ok is
> > true or false. This change ensures kswapd does not miss wake-ups under
> > high memory pressure, reducing the risk of task stalls in the throttled
> > reclaim path.
>
> The code which is being altered is over 10 years old.
>
> Is this misbehavior more recent?  If so, are we able to identify which
> commit caused this?

The issue is not new but may have become more noticeable after commit 
501b26510ae3, which improved precision in allow_direct_reclaim(). This 
change exposed edge cases where wmark_ok is false despite reclaimable 
pages being available.

> Otherwise, can you suggest why it took so long for this to be
> discovered?  Your test case must be doing something unusual?

The issue likely occurs under specific conditions: high memory pressure 
with frequent direct reclaim, contention on mmap_sem from concurrent 
memory allocations, reclaimable pages exist, but zone states cause 
wmark_ok to return false.

Modern workloads (e.g., Python multiprocessing) and changes in kernel 
reclaim logic may have surfaced such edge cases more prominently than 
before.

The workload involves concurrent Python processes under high memory 
pressure, leading to contention on mmap_sem. While not unusual, this 
workload may trigger a rare combination of conditions that expose the 
issue.

>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -6389,8 +6389,8 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
> >
> >       wmark_ok = free_pages > pfmemalloc_reserve / 2;
> >
> > -     /* kswapd must be awake if processes are being throttled */
> > -     if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
> > +     /* Always wake up kswapd if the wait queue is not empty */
> > +     if (waitqueue_active(&pgdat->kswapd_wait)) {
> >               if (READ_ONCE(pgdat->kswapd_highest_zoneidx) > ZONE_NORMAL)
> >                       WRITE_ONCE(pgdat->kswapd_highest_zoneidx, ZONE_NORMAL);
> >



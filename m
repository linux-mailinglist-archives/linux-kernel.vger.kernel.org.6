Return-Path: <linux-kernel+bounces-426344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E2A9DF1F1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36077B218E0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766C31A0BFF;
	Sat, 30 Nov 2024 16:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RyI4G/oa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64909757FC
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732983170; cv=none; b=LHOcpA5ho/G75DkuCQAclLNlJdPHGQ9VAqGc841eL3K6fKsGdpbx0/grV3WywX+J0NRBXOrHTd2eCZ3oenh/VBslD40f72dh1vrqBhYKeh8pxjCDtQs2kg7oChtUXbPTxrWQbplkka4omLK9enrkx79InL1vNaLmSU5wz6p/eIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732983170; c=relaxed/simple;
	bh=d7sBHxB2mvIGJW6+QR+gre1nJF1zDVlG+dt/f8Ovv+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lWQdyRUYKsIFdmfTZ1h0Ytvk7qf1R5Tb5MGWtxeuF63OpbsQ8RmbzBpar1G8qBMn14izchh++a9ok3RiWJ9bphKT2eq9O0PpB40POHyvWgcouv7bEk+BVfbmzAmmSQaL4Tz4uYj92zl0N/PCgWsVkQV6clKHySYSh9xNtAwTffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RyI4G/oa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732983167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1hPTC8lAcmkEHMqYcDwBhrsAdI12Fh/C7IVNBK0GtTE=;
	b=RyI4G/oav146ndRpb+Mr4DMc66kpN/+jlzbuLMru5ewfphe/wePq6/iH7kxqOtFvM6OmYT
	HC5IHCWMEENozYEPptl1Ki4WJ29SOqsW57kR+WLO4/ydkiZQWNYJwnlrcQlvqwqL34FUXY
	1FqwgQUxR/nZwZoEmSXuNco2/c51LCo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-6gARcCBDPiCoyqV7C3l0jQ-1; Sat,
 30 Nov 2024 11:12:41 -0500
X-MC-Unique: 6gARcCBDPiCoyqV7C3l0jQ-1
X-Mimecast-MFC-AGG-ID: 6gARcCBDPiCoyqV7C3l0jQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 805181955DC2;
	Sat, 30 Nov 2024 16:12:40 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E80C11956089;
	Sat, 30 Nov 2024 16:12:37 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	snishika@redhat.com
Subject: [PATCH] mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
Date: Sun,  1 Dec 2024 01:12:33 +0900
Message-ID: <20241130161236.433747-1-snishika@redhat.com>
In-Reply-To: <20241129043936.316481-1-snishika@redhat.com>
References: <20241129043936.316481-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Nov 29, 2024 at 1:39 PM Seiji Nishikawa <snishika@redhat.com> wrote:
>
> On Thu, Nov 28, 2024 at 9:49 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 27 Nov 2024 00:06:12 +0900 Seiji Nishikawa <snishika@redhat.com> wrote:
> >
> > > Even after commit 501b26510ae3 ("vmstat: allow_direct_reclaim should use
> > > zone_page_state_snapshot"), a task may remain indefinitely stuck in
> > > throttle_direct_reclaim() while holding mm->rwsem.
> > >
> > > __alloc_pages_nodemask
> > >  try_to_free_pages
> > >   throttle_direct_reclaim
> > >
> > > This can cause numerous other tasks to wait on the same rwsem, leading
> > > to severe system hangups:
> > >
> > > [1088963.358712] INFO: task python3:1670971 blocked for more than 120 seconds.
> > > [1088963.365653]       Tainted: G           OE     -------- -  - 4.18.0-553.el8_10.aarch64 #1
> > > [1088963.373887] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > [1088963.381862] task:python3         state:D stack:0     pid:1670971 ppid:1667117 flags:0x00800080
> > > [1088963.381869] Call trace:
> > > [1088963.381872]  __switch_to+0xd0/0x120
> > > [1088963.381877]  __schedule+0x340/0xac8
> > > [1088963.381881]  schedule+0x68/0x118
> > > [1088963.381886]  rwsem_down_read_slowpath+0x2d4/0x4b8
> > >
> > > The issue arises when allow_direct_reclaim(pgdat) returns false,
> > > preventing progress even when the pgdat->pfmemalloc_wait wait queue is
> > > empty. Despite the wait queue being empty, the condition,
> > > allow_direct_reclaim(pgdat), may still be returning false, causing it to
> > > continue looping.
> > >
> > > In some cases, reclaimable pages exist (zone_reclaimable_pages() returns
> > >  > 0), but calculations of pfmemalloc_reserve and free_pages result in
> > > wmark_ok being false.
> > >
> > > And then, despite the pgdat->kswapd_wait queue being non-empty, kswapd
> > > is not woken up, further exacerbating the problem:
> > >
> > > crash> px ((struct pglist_data *) 0xffff00817fffe540)->kswapd_highest_zoneidx
> > > $775 = __MAX_NR_ZONES
> > >
> > > This patch modifies allow_direct_reclaim() to wake kswapd if the
> > > pgdat->kswapd_wait queue is active, regardless of whether wmark_ok is
> > > true or false. This change ensures kswapd does not miss wake-ups under
> > > high memory pressure, reducing the risk of task stalls in the throttled
> > > reclaim path.
> >
> > The code which is being altered is over 10 years old.
> >
> > Is this misbehavior more recent?  If so, are we able to identify which
> > commit caused this?
>
> The issue is not new but may have become more noticeable after commit
> 501b26510ae3, which improved precision in allow_direct_reclaim(). This
> change exposed edge cases where wmark_ok is false despite reclaimable
> pages being available.
>
> > Otherwise, can you suggest why it took so long for this to be
> > discovered?  Your test case must be doing something unusual?
>
> The issue likely occurs under specific conditions: high memory pressure
> with frequent direct reclaim, contention on mmap_sem from concurrent
> memory allocations, reclaimable pages exist, but zone states cause
> wmark_ok to return false.
>
> Modern workloads (e.g., Python multiprocessing) and changes in kernel
> reclaim logic may have surfaced such edge cases more prominently than
> before.
>
> The workload involves concurrent Python processes under high memory
> pressure, leading to contention on mmap_sem. While not unusual, this
> workload may trigger a rare combination of conditions that expose the
> issue.
>
> >
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -6389,8 +6389,8 @@ static bool allow_direct_reclaim(pg_data_t *pgdat)
> > >
> > >       wmark_ok = free_pages > pfmemalloc_reserve / 2;
> > >
> > > -     /* kswapd must be awake if processes are being throttled */
> > > -     if (!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) {
> > > +     /* Always wake up kswapd if the wait queue is not empty */
> > > +     if (waitqueue_active(&pgdat->kswapd_wait)) {
> > >               if (READ_ONCE(pgdat->kswapd_highest_zoneidx) > ZONE_NORMAL)
> > >                       WRITE_ONCE(pgdat->kswapd_highest_zoneidx, ZONE_NORMAL);
> > >
>

Through further extensive debugging, it has been revealed that the 
interpretation that kswapd was not woken up even when 
(!wmark_ok && waitqueue_active(&pgdat->kswapd_wait)) held true was 
incorrect. 

Every time kswapd() runs, it overwrites pgdat->kswapd_highest_zoneidx 
with MAX_NR_ZONES, hence it is __MAX_NR_ZONES just at the time when this
dump is captured.

The task continues looping in throttle_direct_reclaim() because 
allow_direct_reclaim(pgdat) keeps returning false. 

 #0 [ffff80002cb6f8d0] __switch_to at ffff8000080095ac
 #1 [ffff80002cb6f900] __schedule at ffff800008abbd1c
 #2 [ffff80002cb6f990] schedule at ffff800008abc50c
 #3 [ffff80002cb6f9b0] throttle_direct_reclaim at ffff800008273550
 #4 [ffff80002cb6fa20] try_to_free_pages at ffff800008277b68
 #5 [ffff80002cb6fae0] __alloc_pages_nodemask at ffff8000082c4660
 #6 [ffff80002cb6fc50] alloc_pages_vma at ffff8000082e4a98
 #7 [ffff80002cb6fca0] do_anonymous_page at ffff80000829f5a8
 #8 [ffff80002cb6fce0] __handle_mm_fault at ffff8000082a5974
 #9 [ffff80002cb6fd90] handle_mm_fault at ffff8000082a5bd4

At this point, the pgdat contains the following two zones:

        NODE: 4  ZONE: 0  ADDR: ffff00817fffe540  NAME: "DMA32"
          SIZE: 20480  MIN/LOW/HIGH: 11/28/45
          VM_STAT:
                NR_FREE_PAGES: 359
        NR_ZONE_INACTIVE_ANON: 18813
          NR_ZONE_ACTIVE_ANON: 0
        NR_ZONE_INACTIVE_FILE: 50
          NR_ZONE_ACTIVE_FILE: 0
          NR_ZONE_UNEVICTABLE: 0
        NR_ZONE_WRITE_PENDING: 0
                     NR_MLOCK: 0
                    NR_BOUNCE: 0
                   NR_ZSPAGES: 0
            NR_FREE_CMA_PAGES: 0

        NODE: 4  ZONE: 1  ADDR: ffff00817fffec00  NAME: "Normal"
          SIZE: 8454144  PRESENT: 98304  MIN/LOW/HIGH: 68/166/264
          VM_STAT:
                NR_FREE_PAGES: 146
        NR_ZONE_INACTIVE_ANON: 94668
          NR_ZONE_ACTIVE_ANON: 3
        NR_ZONE_INACTIVE_FILE: 735
          NR_ZONE_ACTIVE_FILE: 78
          NR_ZONE_UNEVICTABLE: 0
        NR_ZONE_WRITE_PENDING: 0
                     NR_MLOCK: 0
                    NR_BOUNCE: 0
                   NR_ZSPAGES: 0
            NR_FREE_CMA_PAGES: 0

In allow_direct_reclaim(), while processing ZONE_DMA32, the sum of 
inactive/active file-backed pages calculated in zone_reclaimable_pages()
based on the result of zone_page_state_snapshot() is zero. 

Additionally, since this system lacks swap, the calculation of inactive/
active anonymous pages is skipped.

        crash> p nr_swap_pages
        nr_swap_pages = $1937 = {
          counter = 0
        }

As a result, ZONE_DMA32 is deemed unreclaimable and skipped, moving on 
to the processing of the next zone, ZONE_NORMAL, despite ZONE_DMA32 
having free pages significantly exceeding the high watermark.

The problem is that the pgdat->kswapd_failures hasn't been incremented.

        crash> px ((struct pglist_data *) 0xffff00817fffe540)->kswapd_failures
        $1935 = 0x0

This is because the node deemed balanced. The node balancing logic in 
balance_pgdat() evaluates all zones collectively. If one or more zones 
(e.g., ZONE_DMA32) have enough free pages to meet their watermarks, the 
entire node is deemed balanced. This causes balance_pgdat() to exit 
early before incrementing the kswapd_failures, as it considers the 
overall memory state acceptable, even though some zones (like 
ZONE_NORMAL) remain under significant pressure.

The new patch ensures that zone_reclaimable_pages() includes free pages 
(NR_FREE_PAGES) in its calculation when no other reclaimable pages are 
available (e.g., file-backed or anonymous pages). This change prevents 
zones like ZONE_DMA32, which have sufficient free pages, from being 
mistakenly deemed unreclaimable. By doing so, the patch ensures proper 
node balancing, avoids masking pressure on other zones like ZONE_NORMAL,
and prevents infinite loops in throttle_direct_reclaim() caused by 
allow_direct_reclaim(pgdat) repeatedly returning false.




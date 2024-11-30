Return-Path: <linux-kernel+bounces-426355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 201ED9DF20D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BBB4B216AC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2B1A0BC3;
	Sat, 30 Nov 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UM8UYiCv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89A1E884
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732985040; cv=none; b=e+/ITt9o6hxgDuE3lA36NKLj//wuWuB2IcT5wcxh+rVBq4CTbs1UaCGduTZUkgP6/0g4TdAxbQugcyLJU+lDhuz4M3FTAfXF/+vKegqr/g/TooMHj/rqK+f3r09WTz0BNCpawgtAJUgVMkMViY+DIHgs70KYaGgINahz+pi6iRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732985040; c=relaxed/simple;
	bh=SW6xEdMx5VZx47gHZKgLJ9hZcgwzVE1EAsDt8M2KICM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aab5aADajZf8lrYBLcxA6zYuWn9xqCXEDnJqhTcPFATZ9u3HOk7BtaAfmpUChPm09CXB9d0IixU5ojl675DveCQ57uoqiMZA1Wz16gLEqdGSx4LjlYgjVAZ1lJOjbLY7pTR1FcxXRCBsAMO5Wo0uv1XUkKsjgGCyA3Z8e8bXGTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UM8UYiCv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732985036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FRLS0gcdB1AumXGblW+zgRaLfL75WT/hgr7eTEKWACo=;
	b=UM8UYiCvD5T2RWRcQpeHui6fv4dNNZN+BpjSgZ7Hlp134MnUc3MEvy4i4f5fVPccIHUXuY
	RgVTGYbFq9Fi6ZTPjT+FKqi77DB7Ejr+2+0ZqFuPu+S3SeOQqK1Pm+qCWjfzB9gwZHL5mq
	P8v3xr3Ji3kHH0X1SAtstoRlYtF0d8A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-qVJhnX-qMKCpsjoJ-GwJ6A-1; Sat,
 30 Nov 2024 11:43:52 -0500
X-MC-Unique: qVJhnX-qMKCpsjoJ-GwJ6A-1
X-Mimecast-MFC-AGG-ID: qVJhnX-qMKCpsjoJ-GwJ6A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DA734195608C;
	Sat, 30 Nov 2024 16:43:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.64.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86631300018D;
	Sat, 30 Nov 2024 16:43:48 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	mgorman@techsingularity.net,
	snishika@redhat.com
Subject: [PATCH] mm: vmscan: account for free pages to prevent infinite Loop in throttle_direct_reclaim()
Date: Sun,  1 Dec 2024 01:43:45 +0900
Message-ID: <20241130164346.436469-1-snishika@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The task sometimes continues looping in throttle_direct_reclaim() 
because allow_direct_reclaim(pgdat) keeps returning false. 

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



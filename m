Return-Path: <linux-kernel+bounces-428987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509C79E15F2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1667A281682
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26911DE3AD;
	Tue,  3 Dec 2024 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fWaretu3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB91DDC24
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733215091; cv=none; b=OIK9L/l4h+sBFUDqp94YTAT7g8wsK92jkdy7hLBQJz0TeSZbuseP4fbMgtTxIRuZDPV3QuupPshrKy01pa6HkMJ0joUlgS3Bv2+auNCl0G69Q2mzSCUT4CkKjFxqXv6wgakWLGkp7Qy2+3LdqqM9myvb+Oy8wJ54nAsjOYG1syU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733215091; c=relaxed/simple;
	bh=N3zDXkO/kUgEglGlJdK8QxjvBxHZ5qGfVLmPEscd0Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LdFKoj3fCXNlhzu1qSoRWkJNiXt+UxWfwoKVtE+T+Tv41haN2TkykD5Q6zqotkJSFFXKu2y+EeWqEJbDkhFsOxamhPzQgD1YllOGVeL8D5Hu6BItetCrlhDynkkjjX5049leEkJAO8bXIzKxmwN1P7FeDhAAaposs9g5UJvp0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fWaretu3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733215088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nZgnwRofquDisPupcvXEoz+OH4Gw/VsFrsLE5SFZYPI=;
	b=fWaretu36BHD7kwpaj+N2KK3ODOcFE5wLmcJAZ5FdLfLFUkO/ZpXgxLl4mOFf65WPDkGc9
	SsBDmQBTAj6ivZhl9PzYmQT3Z37x62sUzJpTAuBZXnozixRxUBYf87608jn2V9rvgxMYgE
	CysdzG6ShCMUeSHVzAA/2x1EKzctWA8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-28AAsukmNAeuT1N0EefuoA-1; Tue,
 03 Dec 2024 03:38:05 -0500
X-MC-Unique: 28AAsukmNAeuT1N0EefuoA-1
X-Mimecast-MFC-AGG-ID: 28AAsukmNAeuT1N0EefuoA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 148751955F4A;
	Tue,  3 Dec 2024 08:38:03 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.88.109])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4072030001A0;
	Tue,  3 Dec 2024 08:37:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Zi Yan <ziy@nvidia.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH v2 0/6] mm/page_alloc: gfp flags cleanups for alloc_contig_*()
Date: Tue,  3 Dec 2024 09:37:50 +0100
Message-ID: <20241203083756.112975-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

For some reason v1 didn't make it to linux-mm; let's see if the problem
persists.

Let's clean up the gfp flags handling, and support __GFP_ZERO, such that we
can finally remove the TODO in memtrace code.

I did some alloc_contig_*() testing with virtio-mem and hugetlb; I did not
test powernv/memtrace -- I cross-compiled it, though.

v1 -> v2:
* "mm/page_alloc: forward the gfp flags from alloc_contig_range() to
   post_alloc_hook()"
 -> Fixup patch description

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>

David Hildenbrand (6):
  mm/page_isolation: don't pass gfp flags to isolate_single_pageblock()
  mm/page_isolation: don't pass gfp flags to start_isolate_page_range()
  mm/page_alloc: make __alloc_contig_migrate_range() static
  mm/page_alloc: sort out the alloc_contig_range() gfp flags mess
  mm/page_alloc: forward the gfp flags from alloc_contig_range() to
    post_alloc_hook()
  powernv/memtrace: use __GFP_ZERO with alloc_contig_pages()

 arch/powerpc/platforms/powernv/memtrace.c | 31 +++---------
 include/linux/page-isolation.h            |  2 +-
 mm/internal.h                             |  4 --
 mm/memory_hotplug.c                       |  3 +-
 mm/page_alloc.c                           | 62 +++++++++++++++++++----
 mm/page_isolation.c                       | 12 ++---
 6 files changed, 63 insertions(+), 51 deletions(-)


base-commit: 679694cdccaf75df589c2737f233954669a5f601
-- 
2.47.1



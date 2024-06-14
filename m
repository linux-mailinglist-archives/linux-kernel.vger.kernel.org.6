Return-Path: <linux-kernel+bounces-214943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E3F908C76
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BD161C22E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0C620E6;
	Fri, 14 Jun 2024 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PvWIGrqN"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C36E817
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718371839; cv=none; b=rjf+ycFy0+cgScmESCxroEtUWrvkJ1Scr15cUZ+Za5ZH9xrkku7eQU9Zs/RfG+2IfU493PYiiUhM7tBoO/cZRTxPMMQ84RWaJGGjQjQq5eWBD8a2YVPXyQ1oJt7KHQET6Kbk7GlxczEjOPKE0mdxTdZdK2h7EEEktX/5X6Cii9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718371839; c=relaxed/simple;
	bh=IrUqQGQwMsJxdGGWpIHTN9D0+7CLh6RJMSAS0N42slk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WVWrUkUfj+IIp0rSVZOA5JBQz2dfMa+Rn+q5GqfGeV6ADKg7LNgsVVau869wm2Ax7cDUVRCa2Pd820dH/QVX37MGy+xuYIoADm0UKqy/wg9GDTPs9yYjnnfpCM42zqVrb9Yz22AqYq01kCUjLJUcJ2Hx55mtClup3yQDpb5yXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PvWIGrqN; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718371838; x=1749907838;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=W6LtgifkW6+vXdOdWZYDsm/k1XVnlz90Nl+MiPv0cOs=;
  b=PvWIGrqNnR5FPRUg1T8sBjw3tKdM+3pALM1y1DqkOx3XcvFpJICS2Akj
   1oqIuVOZQOp0unhDCxmI7aJq1TclwpIBGkflgNw9ylTUn/yC0Qqu2uC4y
   DwXrGVJaBPqhdccVwrl9KP5fEuY2D/5jR/Ztw8PY1jwH6hZiC2ASQAhuT
   g=;
X-IronPort-AV: E=Sophos;i="6.08,237,1712620800"; 
   d="scan'208";a="96832771"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 13:30:36 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:56353]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.205:2525] with esmtp (Farcaster)
 id 2b5aa1d4-dad0-4f2f-93a7-f12dbffe2c77; Fri, 14 Jun 2024 13:30:35 +0000 (UTC)
X-Farcaster-Flow-ID: 2b5aa1d4-dad0-4f2f-93a7-f12dbffe2c77
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 13:30:35 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.1.213.23) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 14 Jun 2024 13:30:31 +0000
From: James Gowans <jgowans@amazon.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: James Gowans <jgowans@amazon.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Alex Graf <graf@amazon.de>
Subject: [PATCH] memblocks: Move late alloc warning down to phys alloc
Date: Fri, 14 Jun 2024 15:30:16 +0200
Message-ID: <20240614133016.134150-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

If a driver/subsystem tries to do an allocation after memblocks have
been freed and the memory handed to the buddy allocator, it will not
actually be legal to use that allocation - the buddy allocator owns the
memory. This is handled by the memblocks function which does allocations
and returns virtual addresses by printing a warning and doing a kmalloc
instead. However, the physical allocation function does not to do this
check - callers of the physical alloc function are unprotected against
mis-use.

Improve the error catching here by moving the check into the physical
allocation function which is used by the virtual addr allocation
function.

Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Graf <graf@amazon.de>
---
 mm/memblock.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..dd4f237dc1fc 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1457,6 +1457,17 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 		align = SMP_CACHE_BYTES;
 	}
 
+	/*
+	 * Detect any accidental use of these APIs after slab is ready, as at
+	 * this moment memblock may be deinitialized already and its
+	 * internal data may be destroyed (after execution of memblock_free_all)
+	 */
+	if (WARN_ON_ONCE(slab_is_available())) {
+		void *vaddr = kzalloc_node(size, GFP_NOWAIT, nid);
+
+		return vaddr ? virt_to_phys(vaddr) : 0;
+	}
+
 again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
@@ -1576,13 +1587,6 @@ static void * __init memblock_alloc_internal(
 {
 	phys_addr_t alloc;
 
-	/*
-	 * Detect any accidental use of these APIs after slab is ready, as at
-	 * this moment memblock may be deinitialized already and its
-	 * internal data may be destroyed (after execution of memblock_free_all)
-	 */
-	if (WARN_ON_ONCE(slab_is_available()))
-		return kzalloc_node(size, GFP_NOWAIT, nid);
 
 	if (max_addr > memblock.current_limit)
 		max_addr = memblock.current_limit;
-- 
2.34.1



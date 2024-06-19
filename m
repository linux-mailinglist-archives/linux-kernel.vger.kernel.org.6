Return-Path: <linux-kernel+bounces-220818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B14F90E798
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A12A288FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393113C8F0;
	Wed, 19 Jun 2024 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aijsnspO"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B9084FAD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790978; cv=none; b=aA/Fi6+0OIyyuhkzkv0k+GxhNbPz+zPZHYlIVnpj1lQUbiJ/k+vW4NV2bR8CfMp+4ldD6WYBoVJrsCgZX1v9uSMSPqtuGLu+rP0oDMxT8nkMTCDWpPsFVnHVK1grKRTfsG2dBFFcx/spASlUkm78+aG5li4plYkK48MnKGj0bWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790978; c=relaxed/simple;
	bh=nNjrSgSeRfWnkJMdnUI9E0gWMw3vB/pCzNI+OqbllBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AP1Xo7O2WEtPg+z5iWIi5uCNMi5J2VhYQlEdCA0T2QyG6j+iBwHDpGySr/P0DpUU0hojhB1ZyP1sBaRa1/N565RnJ/6lpARnwVYx2QpjDVMDzN1LY+1s9A8dK3ZwEPG76C/EeMJJp9L+Ma/HllO4RQKEXhSNHRNNRzX9ekSKY2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aijsnspO; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718790977; x=1750326977;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=raIEZpdgkW+RHfmC8vCCejhzjRvyZaw+50MAD0K0AN4=;
  b=aijsnspOcj9IQ+XZZzFAh1sQjDaoXUv3mrOXDaZAVWoVe6ORs80Las3R
   mIGNStPrC+GJ9daPtVoKBMdTKlLpiAxt/IfNFj4mmCmkpo3psBq8DLOHA
   SfXGMhKX5Dx8cEpeJ5q5hi+0H9OaP2vapxDMIjHKToXUcoR1L6SPJscaZ
   s=;
X-IronPort-AV: E=Sophos;i="6.08,250,1712620800"; 
   d="scan'208";a="97813385"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 09:56:14 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:12585]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.211:2525] with esmtp (Farcaster)
 id 65371dce-1daa-44d6-9e02-e86036a7bf71; Wed, 19 Jun 2024 09:56:14 +0000 (UTC)
X-Farcaster-Flow-ID: 65371dce-1daa-44d6-9e02-e86036a7bf71
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Jun 2024 09:56:13 +0000
Received: from u5d18b891348c5b.ant.amazon.com (10.146.13.221) by
 EX19D014EUC004.ant.amazon.com (10.252.51.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 19 Jun 2024 09:56:10 +0000
From: James Gowans <jgowans@amazon.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
CC: James Gowans <jgowans@amazon.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Alex Graf <graf@amazon.de>
Subject: [PATCH v2] memblock: Move late alloc warning down to phys alloc
Date: Wed, 19 Jun 2024 11:55:55 +0200
Message-ID: <20240619095555.85980-1-jgowans@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D014EUC004.ant.amazon.com (10.252.51.182)

If a driver/subsystem tries to do an allocation after the memblock
allocations have been freed and the memory handed to the buddy
allocator, it will not actually be legal to use that allocation: the
buddy allocator owns the memory. Currently this mis-use is handled by
the memblock function which does allocations and returns virtual
addresses by printing a warning and doing a kmalloc instead. However
the physical allocation function does not to do this check - callers of
the physical alloc function are unprotected against mis-use.

Improve the error catching here by moving the check into the physical
allocation function which is used by the virtual addr allocation
function.

Signed-off-by: James Gowans <jgowans@amazon.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Graf <graf@amazon.de>
---

Notes:
    Changes since v1: https://lore.kernel.org/all/20240614133016.134150-1-jgowans@amazon.com/
    - Move this late usage check before alignment check
    - Replace memblocks with memblock

 mm/memblock.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index d09136e040d3..dbb3d700247e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1451,6 +1451,17 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
 		nid = NUMA_NO_NODE;
 
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
 	if (!align) {
 		/* Can't use WARNs this early in boot on powerpc */
 		dump_stack();
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



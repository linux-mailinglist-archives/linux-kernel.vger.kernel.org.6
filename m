Return-Path: <linux-kernel+bounces-333788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C5D97CE17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 21:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580D2B21322
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED10F21345;
	Thu, 19 Sep 2024 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGyTKZeR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5BF101E2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726773444; cv=none; b=RzHmip2qmJTYQfBDjpn0re8Z4+Qz5d6PXfhQvrmSDzvsrw3CvtE0EJSZLn2cALf4PAP7zg+JfsmPIHonLqV2xIpDW1pXhxZyq0tn7B7MDNu/Dgs1tgPyv0FYRg4rEs0k9kvReMn2voJDdft+2t4dVITcJtFoPkfndBaHbJwv7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726773444; c=relaxed/simple;
	bh=6JyLNbOyN6vCQP+53wRtz0e4/6T6fen+MDJAYxPdy8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YDZn33bcJsfQuPvodzR3+NgJ83YlejURqzKeM3YLxJ7vV5A/PziaOntVDwhjwcIzYy+FJ37fKIgquaTdulu/J3loWdT8/KedRJerLtxrk3rP641zMXlluu0/amZZnmsnV5DKDulcAX5OFUhEbYpDqywx09KNRlQQD1Nu1NnKvDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGyTKZeR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726773440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+io0bQ7YY0xQVBt4I/DgX0X8J9QiI1A9WEgxXR3OG6I=;
	b=hGyTKZeRe8zGO3fNeTB7lhhhyBMhOqYldg/9rqY6zFQopYYvtuhQhX0HtYHs7mTHNK3hWx
	Y8N6Sk6yGl7nXPmvOywHDWR93+EbeNHa1GruAO/1EMBWSKiLWN/pKZbIae2l/4tCw4iLy0
	W9WtiUo96vPKootgAHDsfhjRK357Bew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-W5ex_4jKN3SFjKo0sztS2g-1; Thu,
 19 Sep 2024 15:14:10 -0400
X-MC-Unique: W5ex_4jKN3SFjKo0sztS2g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCE3E1935D3E;
	Thu, 19 Sep 2024 19:14:06 +0000 (UTC)
Received: from llong.com (unknown [10.45.224.31])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F18BE19560A3;
	Thu, 19 Sep 2024 19:14:03 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] memory tier: Remove unused default_dram_perf_ref_source
Date: Thu, 19 Sep 2024 15:13:57 -0400
Message-ID: <20240919191357.49976-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
added a default_dram_perf_ref_source variable that was initialized but
never used. This causes kmemleak to report the following memory leak:

unreferenced object 0xff11000225a47b60 (size 16):
  comm "swapper/0", pid 1, jiffies 4294761654
  hex dump (first 16 bytes):
    41 43 50 49 20 48 4d 41 54 00 c1 4b 7d b7 75 7c  ACPI HMAT..K}.u|
  backtrace (crc e6d0e7b2):
    [<ffffffff95d5afdb>] __kmalloc_node_track_caller_noprof+0x36b/0x440
    [<ffffffff95c276d6>] kstrdup+0x36/0x60
    [<ffffffff95dfabfa>] mt_set_default_dram_perf+0x23a/0x2c0
    [<ffffffff9ad64733>] hmat_init+0x2b3/0x660
    [<ffffffff95203cec>] do_one_initcall+0x11c/0x5c0
    [<ffffffff9ac9cfc4>] do_initcalls+0x1b4/0x1f0
    [<ffffffff9ac9d52e>] kernel_init_freeable+0x4ae/0x520
    [<ffffffff97c789cc>] kernel_init+0x1c/0x150
    [<ffffffff952aecd1>] ret_from_fork+0x31/0x70
    [<ffffffff9520b18a>] ret_from_fork_asm+0x1a/0x30

Fix this memory leak by removing default_dram_perf_ref_source.

Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memory-tiers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4775b3a3dabe..baa5f20e3b78 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -119,7 +119,6 @@ static DEFINE_MUTEX(default_dram_perf_lock);
 static bool default_dram_perf_error;
 static struct access_coordinate default_dram_perf;
 static int default_dram_perf_ref_nid = NUMA_NO_NODE;
-static const char *default_dram_perf_ref_source;
 
 static inline struct memory_tier *to_memory_tier(struct device *device)
 {
@@ -728,7 +727,6 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
 	if (default_dram_perf_ref_nid == NUMA_NO_NODE) {
 		default_dram_perf = *perf;
 		default_dram_perf_ref_nid = nid;
-		default_dram_perf_ref_source = kstrdup(source, GFP_KERNEL);
 		return 0;
 	}
 
-- 
2.43.5



Return-Path: <linux-kernel+bounces-336969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6598436A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DBD1C20932
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9505B17BB3A;
	Tue, 24 Sep 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OWY9avjv"
Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8C170A3D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727173037; cv=none; b=g7Nr1bEPlOWO/3x5Wvu/hxopWcoSEOz3PCQ68lxhI44fsTcDDz6SbeDRkNR/bwnzlNnTRf4OlAbC/HmJs0YE4EhePXWjAnCPy7uvoVTAtTrPzUDnS1OShyw1dX9eXjWXegEHap/nOrs5r4yRqPnhBYt75dz5a9pZqiVRh6y+lsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727173037; c=relaxed/simple;
	bh=NrioGdwCtDf6v9Dyob9Lgl6+b8tepoKpj4yVA6ow5xs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J67nHwBqNQ6CoBrGNUM0I9/gzZhzY6MiW9WjKUjDEog3D6UdGC7xLhOpIopzIg29IhuaMjT693MGMOad+qqSc7YujyKq0vO/ygpIWECZuQ0Pj8SXa886DPYNG/Mpj5zs4iYrtHXyaoCOgoPvI3L9+kfLg+FXqHEMsQAk/sZRV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OWY9avjv; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1727173034; x=1758709034;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NrioGdwCtDf6v9Dyob9Lgl6+b8tepoKpj4yVA6ow5xs=;
  b=OWY9avjvs9X/lraSu7Yik9PKQuwdr7UfeUu2gWkil80DmRubh0Bz5yA4
   WA3RyGASN1zIxvHWLdVi/Ydwt90pn0Rg6FpI1GDuljcwd0IFUJkSU5774
   hNNkvhodPx/PDM+RbXeahSKj5RCw0Kl1pufNMhaAq9x8xB+uyHjCapJ7M
   nGZVHYKHMQFL5tsiYi6yVY0hAknYE29ftX68c5YhjuT5PxbqxDFB+4nqG
   eWcQSYi3ZBc0P67F2VDymFxLrfWOQ+Nbjn5WJvJdxLjE11d/rwHEOnjo0
   cL5sXQinIbo1crFJ3mMCz2XOYfbdM6+2wbiIUB2IJs9z79+Rr3wM866T9
   w==;
X-CSE-ConnectionGUID: dPbHytZdRYy6Mof1nehtwQ==
X-CSE-MsgGUID: ZjOjiBRxRtKx024mY794gQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="154039039"
X-IronPort-AV: E=Sophos;i="6.10,254,1719846000"; 
   d="scan'208";a="154039039"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 19:16:02 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 30724CC145
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:16:00 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 7CB02BF3C8
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:15:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 0C97B20081301
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:15:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.44])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 1EDF81A000B;
	Tue, 24 Sep 2024 18:15:58 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] mm/memory_hotplug: Print the correct pfn in do_migrate_range()
Date: Tue, 24 Sep 2024 18:15:54 +0800
Message-Id: <20240924101555.327091-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28684.007
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28684.007
X-TMASE-Result: 10--0.154800-10.000000
X-TMASE-MatchedRID: Se4t54mhS/0bO59FK9BdmLrbxxduc6FPTfK5j0EZbytaer+1iaJkEL8F
	Hrw7frluf146W0iUu2uN6fDbnTu0nx8TzIzimOwPlpYqKNmWxsHZs3HUcS/scCq2rl3dzGQ1z31
	4VDF21MZTpjF0LDVmji87Lr8mlOQu3wv5/qh65H4GsUZRlmOtWBm3sy14XQEUEjPZKdhSZs8mt4
	OYpJRnCTbenjOGpCfJUR9ws8a0/88VxRB/din+uJ07T8ZSLiAVvR84/OmB1wQp4n8eQBnwiw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The pfn value needs to be retrieved correctly when PageTransHuge(page)
is true. Fix it by replacing the usage of 'pfn' with 'page_to_pfn(page)'
to ensure the correct pfn is printed in warning messages when isolation
fails.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 mm/memory_hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 26790c8d5b43..000430406a9e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1829,7 +1829,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 
 		} else {
 			if (__ratelimit(&migrate_rs)) {
-				pr_warn("failed to isolate pfn %lx\n", pfn);
+				pr_warn("failed to isolate pfn %lx\n", page_to_pfn(page));
 				dump_page(page, "isolation failed");
 			}
 		}
-- 
2.29.2



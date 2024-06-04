Return-Path: <linux-kernel+bounces-199981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43118FA8B9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 05:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2C3285EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D882E13D2BF;
	Tue,  4 Jun 2024 03:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V/7+uHm2"
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3975433F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717471037; cv=none; b=mcic7E1MkE9gwrhJnulnr6ZrUWsr2Gn535VK539MNXHu59IRFt8Dilai84onPwtYtkp1UG2ja6BdtSJ1l3Dl3e9ixijUzkQnbKHbzdCtya8QvJeVyktcPg/2KKYqf9FcOgwhue12NZ5wy0vtAO7heKeAuLALtohYeGNvAwRR+qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717471037; c=relaxed/simple;
	bh=NZ4QDniuJ1f4Hz8A5Uegz8QmG0EmzCpkdIYexgtWV0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VgW/XobxqagUuI5Vfhg21N29p9carJwOomiB3MWrhx/x515fIi1gSfGnVRCx7f+4jvCruIsqeNJLTsoEtbTyXkU7aA3inz5jPDRaRqdtqk9rXpxYVXP3BEoOYeHyTx2T2Al9TTzPVKSOt0IKkEnWhNtd1dBP4nFAD8i8oOHbZOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=V/7+uHm2; arc=none smtp.client-ip=207.54.90.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717471036; x=1749007036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NZ4QDniuJ1f4Hz8A5Uegz8QmG0EmzCpkdIYexgtWV0s=;
  b=V/7+uHm2ZJSeJ5foKGrTdUSdmuk1DGrJ5RQq6SqiHW9ZOOCp3wM24NpH
   SmIsAP6JCMWQVwWt1y7iLJc+HvL3BEoBSYdq2erDX5WCj9xxpt98lOiEj
   HmYQlF6C5xJgC3IKUb1CWhNLvg9SrPyh5RGCEMdZabuyQn1vyKUp4ctLg
   iIpsyU2ykki4QxNe82OAmKs0pSSYPNnWuwiPhAX4taYkLPuTqeOa2MYI1
   04e1eTRkgGRsCCshemGn8wrqqeqKaHuYl1Pb2Ql/HjqeLAU41U00bvZS/
   QljM3oDZYKhNF0nvcvysIiaGNupnEuBkRvhggV0MXUknnZnqYK/kl6Z/C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="161651258"
X-IronPort-AV: E=Sophos;i="6.08,213,1712588400"; 
   d="scan'208";a="161651258"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 12:17:07 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 870CEDBCEA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:17:04 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C005FD3F15
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:17:03 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EE7320071A0B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:17:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 6E6551A000A;
	Tue,  4 Jun 2024 11:17:02 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] nvdimm: Fix devs leaks in scan_labels()
Date: Tue,  4 Jun 2024 11:16:58 +0800
Message-Id: <20240604031658.951493-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28430.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28430.004
X-TMASE-Result: 10--6.422900-10.000000
X-TMASE-MatchedRID: e6WPXQD7Ri+2mivwNK4iQN9JA2lmQRNUNte7AWpKXSvVU2WiOk7jaHls
	GJXt79WMsSE+lrQqOSP4Orn4AH8dYvvwmMFLImuh/sUSFaCjTLywFIDW25lVJqvWBS71/UX/+vE
	SF6BhDIwi+t+0AiFaYrwD/c110z9x0ywZEqbRuQSsxn4GpC3Y2rcKVIr9tQwNdE7HIe9l0mxNga
	nKV1mfzuLzNWBegCW2Nfpe10T3IsNt1O49r1VEa8RB0bsfrpPIfiAqrjYtFiT2BCQdQCcmc92/q
	b0USjoD2j/RDZHeG9mCX+Fml2XYHH7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Don't allocate devs again when it's valid pointer which has pionted to
the memory allocated above with size (count + 2 * sizeof(dev)).

A kmemleak reports:
unreferenced object 0xffff88800dda1980 (size 16):
  comm "kworker/u10:5", pid 69, jiffies 4294671781
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<00000000c5dea560>] __kmalloc+0x32c/0x470
    [<000000009ed43c83>] nd_region_register_namespaces+0x6fb/0x1120 [libnvdimm]
    [<000000000e07a65c>] nd_region_probe+0xfe/0x210 [libnvdimm]
    [<000000007b79ce5f>] nvdimm_bus_probe+0x7a/0x1e0 [libnvdimm]
    [<00000000a5f3da2e>] really_probe+0xc6/0x390
    [<00000000129e2a69>] __driver_probe_device+0x78/0x150
    [<000000002dfed28b>] driver_probe_device+0x1e/0x90
    [<00000000e7048de2>] __device_attach_driver+0x85/0x110
    [<0000000032dca295>] bus_for_each_drv+0x85/0xe0
    [<00000000391c5a7d>] __device_attach+0xbe/0x1e0
    [<0000000026dabec0>] bus_probe_device+0x94/0xb0
    [<00000000c590d936>] device_add+0x656/0x870
    [<000000003d69bfaa>] nd_async_device_register+0xe/0x50 [libnvdimm]
    [<000000003f4c52a4>] async_run_entry_fn+0x2e/0x110
    [<00000000e201f4b0>] process_one_work+0x1ee/0x600
    [<000000006d90d5a9>] worker_thread+0x183/0x350

Fixes: 1b40e09a1232 ("libnvdimm: blk labels and namespace instantiation")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 drivers/nvdimm/namespace_devs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index d6d558f94d6b..56b016dbe307 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1994,7 +1994,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
 		/* Publish a zero-sized namespace for userspace to configure. */
 		nd_mapping_free_labels(nd_mapping);
 
-		devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
+		/* devs probably has been allocated */
+		if (!devs)
+			devs = kcalloc(2, sizeof(dev), GFP_KERNEL);
 		if (!devs)
 			goto err;
 
-- 
2.29.2



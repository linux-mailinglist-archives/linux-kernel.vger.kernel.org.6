Return-Path: <linux-kernel+bounces-356161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8443995D6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D315D1C21F55
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BA4084D;
	Wed,  9 Oct 2024 01:50:45 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B6C1F957;
	Wed,  9 Oct 2024 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728438645; cv=none; b=X84qFa6XA77q5eLDjDTvhCECoN/4w55IWmwDYZTPtUN9rhlKsaCfKLwPuSOmznXdaJPWU3Mfat6F9h8z17PdJn9GUUGZHbsXE5BA37rLOeNHCzHB07pHKbJweskeYM4R/SdELGu5taOKD+nPCt4peayfbYu5HwPeqlKzD6ybb7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728438645; c=relaxed/simple;
	bh=UrVIhKGRytnTPJ7273bBkhGNkTD58+u84qrmUSUWq5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AWiFE9CuF+Cs8Bh3NB/sTXatNaADX/EdtbT2TXcgXJKIGnAhaJbWiaWFNmk9wy75H8jJVL9QFEHWhr/uNn3iMHRXvh2rT42KSTVzA1CI4kxIEKtGmebNsO+sIgcwbUwML/3UYIch0WQMJhUEOao5oQLg4Qx3dAXfwqfl10kuvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XNbRL0pBMz1SCLZ;
	Wed,  9 Oct 2024 09:49:34 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7562F1401F2;
	Wed,  9 Oct 2024 09:50:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Oct
 2024 09:50:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <davidgow@google.com>,
	<sboyd@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v2] of: Fix unbalanced of node refcount and memory leaks
Date: Wed, 9 Oct 2024 09:49:50 +0800
Message-ID: <20241009014950.1979424-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)

Got following report when doing overlay_test:

	OF: ERROR: memory leak, expected refcount 1 instead of 2,
	of_node_get()/of_node_put() unbalanced - destroy cset entry:
	attach overlay node            /kunit-test

	OF: ERROR: memory leak before free overlay changeset,  /kunit-test

In of_overlay_apply_kunit_cleanup(), the "np" will be overwritten by the
second of_find_node_by_name(), and the error message came from
kunit_cleanup(), just call of_node_put() before it to fix it.

It also fix the following memory leaks:

	unreferenced object 0xffffff80c7d22800 (size 256):
	  comm "kunit_try_catch", pid 236, jiffies 4294894764
	  hex dump (first 32 bytes):
	    d0 26 d4 c2 80 ff ff ff 00 00 00 00 00 00 00 00  .&..............
	    60 19 75 c1 80 ff ff ff 00 00 00 00 00 00 00 00  `.u.............
	  backtrace (crc ee0a471c):
	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
	    [<00000000c538ac7e>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<00000000119f34f3>] __of_node_dup+0x4c/0x328
	    [<00000000b212ca39>] build_changeset_next_level+0x2cc/0x4c0
	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000000b296be1>] kthread+0x2e8/0x374
	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c1751960 (size 16):
	  comm "kunit_try_catch", pid 236, jiffies 4294894764
	  hex dump (first 16 bytes):
	    6b 75 6e 69 74 2d 74 65 73 74 00 c1 80 ff ff ff  kunit-test......
	  backtrace (crc 18196259):
	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
	    [<0000000071006e2c>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
	    [<00000000b16ac6cb>] kstrdup+0x48/0x84
	    [<0000000050e3373b>] __of_node_dup+0x60/0x328
	    [<00000000b212ca39>] build_changeset_next_level+0x2cc/0x4c0
	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000000b296be1>] kthread+0x2e8/0x374
	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c2e96e00 (size 192):
	  comm "kunit_try_catch", pid 236, jiffies 4294894764
	  hex dump (first 32 bytes):
	    80 19 75 c1 80 ff ff ff 0b 00 00 00 00 00 00 00  ..u.............
	    a0 19 75 c1 80 ff ff ff 00 6f e9 c2 80 ff ff ff  ..u......o......
	  backtrace (crc 1924cba4):
	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
	    [<00000000c538ac7e>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000009fdd35ad>] __of_prop_dup+0x7c/0x2ec
	    [<00000000aa4e0111>] add_changeset_property+0x548/0x9e0
	    [<000000004777e25b>] build_changeset_next_level+0xd4/0x4c0
	    [<00000000a9c93f8a>] build_changeset_next_level+0x3a8/0x4c0
	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000000b296be1>] kthread+0x2e8/0x374
	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
	unreferenced object 0xffffff80c1751980 (size 16):
	  comm "kunit_try_catch", pid 236, jiffies 4294894764
	  hex dump (first 16 bytes):
	    63 6f 6d 70 61 74 69 62 6c 65 00 c1 80 ff ff ff  compatible......
	  backtrace (crc 42df3c87):
	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
	    [<0000000071006e2c>] __kmalloc_node_track_caller_noprof+0x300/0x3e0
	    [<00000000b16ac6cb>] kstrdup+0x48/0x84
	    [<00000000a8888fd8>] __of_prop_dup+0xb0/0x2ec
	    [<00000000aa4e0111>] add_changeset_property+0x548/0x9e0
	    [<000000004777e25b>] build_changeset_next_level+0xd4/0x4c0
	    [<00000000a9c93f8a>] build_changeset_next_level+0x3a8/0x4c0
	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000000b296be1>] kthread+0x2e8/0x374
	unreferenced object 0xffffff80c2e96f00 (size 192):
	  comm "kunit_try_catch", pid 236, jiffies 4294894764
	  hex dump (first 32 bytes):
	    40 f7 bb c6 80 ff ff ff 0b 00 00 00 00 00 00 00  @...............
	    c0 19 75 c1 80 ff ff ff 00 00 00 00 00 00 00 00  ..u.............
	  backtrace (crc f2f57ea7):
	    [<0000000058ea1340>] kmemleak_alloc+0x34/0x40
	    [<00000000c538ac7e>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000009fdd35ad>] __of_prop_dup+0x7c/0x2ec
	    [<00000000aa4e0111>] add_changeset_property+0x548/0x9e0
	    [<000000004777e25b>] build_changeset_next_level+0xd4/0x4c0
	    [<00000000a9c93f8a>] build_changeset_next_level+0x3a8/0x4c0
	    [<00000000eb208e87>] of_overlay_fdt_apply+0x930/0x1334
	    [<000000005bdc53a3>] of_overlay_fdt_apply_kunit+0x54/0x10c
	    [<00000000143acd5d>] of_overlay_apply_kunit_cleanup+0x12c/0x524
	    [<00000000a813abc8>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000d77ab00c>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<000000000b296be1>] kthread+0x2e8/0x374
	    [<0000000007bd1c51>] ret_from_fork+0x10/0x20
	......

How to reproduce:
	CONFIG_OF_OVERLAY_KUNIT_TEST=y, CONFIG_DEBUG_KMEMLEAK=y
	and CONFIG_DEBUG_KMEMLEAK_AUTO_SCAN=y, launch the kernel.

Fixes: 5c9dd72d8385 ("of: Add a KUnit test for overlays and test managed APIs")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add memory leak stack.
- Update the commit message.
---
 drivers/of/overlay_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay_test.c b/drivers/of/overlay_test.c
index 19a292cdeee3..e95b1152612c 100644
--- a/drivers/of/overlay_test.c
+++ b/drivers/of/overlay_test.c
@@ -73,12 +73,12 @@ static void of_overlay_apply_kunit_cleanup(struct kunit *test)
 
 	np = of_find_node_by_name(NULL, kunit_node_name);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, np);
-	of_node_put_kunit(test, np);
 
 	pdev = of_find_device_by_node(np);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, pdev);
 	put_device(&pdev->dev); /* Not derefing 'pdev' after this */
 
+	of_node_put(np);
 	/* Remove overlay */
 	kunit_cleanup(&fake);
 
-- 
2.34.1



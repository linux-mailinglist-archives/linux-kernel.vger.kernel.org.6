Return-Path: <linux-kernel+bounces-359041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB499986B3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2ED1C217EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B0C1C7B70;
	Thu, 10 Oct 2024 12:54:15 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA591C2DC0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728564855; cv=none; b=q4N31SmXlpm7yyBJRzDcef83gHFUuETaYtMxZFitoJ/mdCNqoEFIoS9GyOjhigcMVwrx9vidFVV8nCuGmWuJJPNnM6pFvrp4+hMNAm4wDc8T1NVVeNiRUq0D1h31C9PRBlVzv4o3Y7ew5/5PK9tN1JVcNGmIC9s3PM4TeEhb16U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728564855; c=relaxed/simple;
	bh=97tLnF4AS+RZyQ0ivH1Pce210sanpQtAzJD7zCqUW1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=goyjwIr2yEvIokhraXgWo5YTMClQE8HvS5HhgQmZiNMn4/UsHI/4YvDltiTSQLt97CqzrKsRWjOw5XzY7Uf2+sTTA6oxYtnAS7F3i6ryUYOXET5VJGqgq1j6jmYkpl1BW0vkzVDFER0XUZA7b0agDORS48PkFBvSXOMjjhZOIGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XPV300dX8z1HKkn;
	Thu, 10 Oct 2024 20:50:04 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 017A41400DC;
	Thu, 10 Oct 2024 20:54:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 10 Oct
 2024 20:54:10 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sj@kernel.org>, <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] mm/damon: Fix memory leak in damon_sysfs_test_add_targets()
Date: Thu, 10 Oct 2024 20:53:23 +0800
Message-ID: <20241010125323.3127187-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)

The sysfs_target->regions allocated in damon_sysfs_regions_alloc()
is not freed in damon_sysfs_test_add_targets(), which cause the following
memory leak, free it to fix it.

	unreferenced object 0xffffff80c2a8db80 (size 96):
	  comm "kunit_try_catch", pid 187, jiffies 4294894363
	  hex dump (first 32 bytes):
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
	  backtrace (crc 0):
	    [<0000000001e3714d>] kmemleak_alloc+0x34/0x40
	    [<000000008e6835c1>] __kmalloc_cache_noprof+0x26c/0x2f4
	    [<000000001286d9f8>] damon_sysfs_test_add_targets+0x1cc/0x738
	    [<0000000032ef8f77>] kunit_try_run_case+0x13c/0x3ac
	    [<00000000f3edea23>] kunit_generic_run_threadfn_adapter+0x80/0xec
	    [<00000000adf936cf>] kthread+0x2e8/0x374
	    [<0000000041bb1628>] ret_from_fork+0x10/0x20

Cc: stable@vger.kernel.org
Fixes: b8ee5575f763 ("mm/damon/sysfs-test: add a unit test for damon_sysfs_set_targets()")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 mm/damon/tests/sysfs-kunit.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/tests/sysfs-kunit.h b/mm/damon/tests/sysfs-kunit.h
index 1c9b596057a7..7b5c7b307da9 100644
--- a/mm/damon/tests/sysfs-kunit.h
+++ b/mm/damon/tests/sysfs-kunit.h
@@ -67,6 +67,7 @@ static void damon_sysfs_test_add_targets(struct kunit *test)
 	damon_destroy_ctx(ctx);
 	kfree(sysfs_targets->targets_arr);
 	kfree(sysfs_targets);
+	kfree(sysfs_target->regions);
 	kfree(sysfs_target);
 }
 
-- 
2.34.1



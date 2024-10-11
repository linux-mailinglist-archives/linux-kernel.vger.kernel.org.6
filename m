Return-Path: <linux-kernel+bounces-360511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6082999BE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 038E4B24464
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 04:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D51F473A;
	Fri, 11 Oct 2024 04:52:06 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA541C7B6A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728622326; cv=none; b=GGe1MWvgl2rDUuhZgrgpyW0rOuou1/N4GViKR9M4B9iJk80OwHoO7E3nBCgeytv9LqDJvs4sl3VLgqQPu57RLzgH0pU10Q0HslWML0f/KVeP1rLX69b+jkbF1Xq/qIiiQZWklyh0QE8DKl6RNFbe3f0iQeGLfqYZqiicrXjjAqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728622326; c=relaxed/simple;
	bh=ti83phpmi3aY9dBWUnnCvgpFqxGSis7KkuOOkGqvhes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uz3TFlNwJwFpOStxQhaXlvHS2Ym5zD9ABKBvtslUQiGh18e+9oVyBM5uwz6oAEzuoq7hB8Ct0NsOEJ+pzP48pxEvCoxcA2c4nq0Dt9+Rz7L1DKmj4JfcwYzy+8yW6etyYz6/xjlBee/D8fE5f39WzKPh7hA3BuH9tQQXkXv5bBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XPvMQ1t3DzyT2W;
	Fri, 11 Oct 2024 12:50:42 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 748C7180113;
	Fri, 11 Oct 2024 12:52:00 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemk500005.china.huawei.com
 (7.202.194.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 11 Oct
 2024 12:51:59 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] ubi: fastmap: Fix duplicate slab cache names while attaching
Date: Fri, 11 Oct 2024 12:50:02 +0800
Message-ID: <20241011045002.469595-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk500005.china.huawei.com (7.202.194.90)

Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
DEBUG_VM=y"), the duplicate slab cache names can be detected and a
kernel WARNING is thrown out.
In UBI fast attaching process, alloc_ai() could be invoked twice
with the same slab cache name 'ubi_aeb_slab_cache', which will trigger
following warning messages:
 kmem_cache of name 'ubi_aeb_slab_cache' already exists
 WARNING: CPU: 0 PID: 7519 at mm/slab_common.c:107
          __kmem_cache_create_args+0x100/0x5f0
 Modules linked in: ubi(+) nandsim [last unloaded: nandsim]
 CPU: 0 UID: 0 PID: 7519 Comm: modprobe Tainted: G 6.12.0-rc2
 RIP: 0010:__kmem_cache_create_args+0x100/0x5f0
 Call Trace:
   __kmem_cache_create_args+0x100/0x5f0
   alloc_ai+0x295/0x3f0 [ubi]
   ubi_attach+0x3c3/0xcc0 [ubi]
   ubi_attach_mtd_dev+0x17cf/0x3fa0 [ubi]
   ubi_init+0x3fb/0x800 [ubi]
   do_init_module+0x265/0x7d0
   __x64_sys_finit_module+0x7a/0xc0

The problem could be easily reproduced by loading UBI device by fastmap
with CONFIG_DEBUG_VM=y.
Fix it by using different slab names for alloc_ai() callers.

Fixes: d2158f69a7d4 ("UBI: Remove alloc_ai() slab name from parameter list")
Fixes: fdf10ed710c0 ("ubi: Rework Fastmap attach base code")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/attach.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/ubi/attach.c b/drivers/mtd/ubi/attach.c
index ae5abe492b52..adc47b87b38a 100644
--- a/drivers/mtd/ubi/attach.c
+++ b/drivers/mtd/ubi/attach.c
@@ -1447,7 +1447,7 @@ static int scan_all(struct ubi_device *ubi, struct ubi_attach_info *ai,
 	return err;
 }
 
-static struct ubi_attach_info *alloc_ai(void)
+static struct ubi_attach_info *alloc_ai(const char *slab_name)
 {
 	struct ubi_attach_info *ai;
 
@@ -1461,7 +1461,7 @@ static struct ubi_attach_info *alloc_ai(void)
 	INIT_LIST_HEAD(&ai->alien);
 	INIT_LIST_HEAD(&ai->fastmap);
 	ai->volumes = RB_ROOT;
-	ai->aeb_slab_cache = kmem_cache_create("ubi_aeb_slab_cache",
+	ai->aeb_slab_cache = kmem_cache_create(slab_name,
 					       sizeof(struct ubi_ainf_peb),
 					       0, 0, NULL);
 	if (!ai->aeb_slab_cache) {
@@ -1491,7 +1491,7 @@ static int scan_fast(struct ubi_device *ubi, struct ubi_attach_info **ai)
 
 	err = -ENOMEM;
 
-	scan_ai = alloc_ai();
+	scan_ai = alloc_ai("ubi_aeb_slab_cache_fastmap");
 	if (!scan_ai)
 		goto out;
 
@@ -1557,7 +1557,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 	int err;
 	struct ubi_attach_info *ai;
 
-	ai = alloc_ai();
+	ai = alloc_ai("ubi_aeb_slab_cache");
 	if (!ai)
 		return -ENOMEM;
 
@@ -1575,7 +1575,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 		if (err > 0 || mtd_is_eccerr(err)) {
 			if (err != UBI_NO_FASTMAP) {
 				destroy_ai(ai);
-				ai = alloc_ai();
+				ai = alloc_ai("ubi_aeb_slab_cache");
 				if (!ai)
 					return -ENOMEM;
 
@@ -1614,7 +1614,7 @@ int ubi_attach(struct ubi_device *ubi, int force_scan)
 	if (ubi->fm && ubi_dbg_chk_fastmap(ubi)) {
 		struct ubi_attach_info *scan_ai;
 
-		scan_ai = alloc_ai();
+		scan_ai = alloc_ai("ubi_aeb_slab_cache_dbg_chk_fastmap");
 		if (!scan_ai) {
 			err = -ENOMEM;
 			goto out_wl;
-- 
2.39.2



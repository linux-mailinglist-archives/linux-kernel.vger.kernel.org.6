Return-Path: <linux-kernel+bounces-360783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEFE999FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14146B21A10
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C0E20C480;
	Fri, 11 Oct 2024 09:01:32 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E320B219
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637291; cv=none; b=gc/jGvyTs/wKHTTmvthez7UhZHLFJpxUqJSoVmC4JBSK8f1YWlRA3f+oa/CBNq+staMRL9QGfPB2C9PKmj7gZKrCQ/LsR3g37avwoj40yap6DTUYRFFFTb+hnXXt79mdTS5Dih0FWIRxCl0+xC+i0t3Dbl50UWo2+1JaTy2yl+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637291; c=relaxed/simple;
	bh=KUKe3CQKjkMentvWegyWs/e57RZWQrFtoUhPekI+iw8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpeUscH3ZjS3pW4FbV1iM0SNDdTFI5mgLtiomn0VG1O8u5KKyA4N6Ikpe5B5myZYF0I90BrpBIOi5tZ2r2EEL5r67DaDb/QbC9DyUz7m9lMTE8w/sI/QttizMz3j4cZf8L/FesRUSaQ2hNiUv9or6mUucAClcL+sz3+5oCII6ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XQ0wL49SWz4f3l70
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:01:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 693F91A06DD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:01:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.107])
	by APP4 (Coremail) with SMTP id gCh0CgCXysZE6QhnXKsjDw--.46494S4;
	Fri, 11 Oct 2024 17:00:58 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	zhangxiaoxu5@huawei.com
Subject: [PATCH] f2fs: fix null-ptr-deref in f2fs_submit_page_bio()
Date: Sat, 12 Oct 2024 00:44:50 +0800
Message-Id: <20241011164450.3366215-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysZE6QhnXKsjDw--.46494S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3CrWrWF48ZryUJF15XFb_yoW5AF4fp3
	4rCryUKr4ruryUXr4kAF4rKryfCFWxZayUWrWvga4Sv3WxZ34rtF92ka4jqFyDJrW8Aa1f
	Jay5C3s0gw13JaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gc
	CE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxI
	r21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87
	Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAa
	w2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
	6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsnNVDUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

There's issue as follows when concurrently installing the f2fs.ko
module and mounting the f2fs file system:
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
RIP: 0010:__bio_alloc+0x2fb/0x6c0 [f2fs]
Call Trace:
 <TASK>
 f2fs_submit_page_bio+0x126/0x8b0 [f2fs]
 __get_meta_page+0x1d4/0x920 [f2fs]
 get_checkpoint_version.constprop.0+0x2b/0x3c0 [f2fs]
 validate_checkpoint+0xac/0x290 [f2fs]
 f2fs_get_valid_checkpoint+0x207/0x950 [f2fs]
 f2fs_fill_super+0x1007/0x39b0 [f2fs]
 mount_bdev+0x183/0x250
 legacy_get_tree+0xf4/0x1e0
 vfs_get_tree+0x88/0x340
 do_new_mount+0x283/0x5e0
 path_mount+0x2b2/0x15b0
 __x64_sys_mount+0x1fe/0x270
 do_syscall_64+0x5f/0x170
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Above issue happens as the biset of the f2fs file system is not
initialized before register "f2fs_fs_type".
To address above issue just register "f2fs_fs_type" at the last in
init_f2fs_fs(). Ensure that all f2fs file system resources are
initialized.

Fixes: f543805fcd60 ("f2fs: introduce private bioset")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/f2fs/super.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 87ab5696bd48..8d4ecb2e855e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4991,9 +4991,6 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_init_shrinker();
 	if (err)
 		goto free_sysfs;
-	err = register_filesystem(&f2fs_fs_type);
-	if (err)
-		goto free_shrinker;
 	f2fs_create_root_stats();
 	err = f2fs_init_post_read_processing();
 	if (err)
@@ -5016,7 +5013,12 @@ static int __init init_f2fs_fs(void)
 	err = f2fs_create_casefold_cache();
 	if (err)
 		goto free_compress_cache;
+	err = register_filesystem(&f2fs_fs_type);
+	if (err)
+		goto free_casefold_cache;
 	return 0;
+free_casefold_cache:
+	f2fs_destroy_casefold_cache();
 free_compress_cache:
 	f2fs_destroy_compress_cache();
 free_compress_mempool:
@@ -5031,8 +5033,6 @@ static int __init init_f2fs_fs(void)
 	f2fs_destroy_post_read_processing();
 free_root_stats:
 	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
-free_shrinker:
 	f2fs_exit_shrinker();
 free_sysfs:
 	f2fs_exit_sysfs();
@@ -5056,6 +5056,7 @@ static int __init init_f2fs_fs(void)
 
 static void __exit exit_f2fs_fs(void)
 {
+	unregister_filesystem(&f2fs_fs_type);
 	f2fs_destroy_casefold_cache();
 	f2fs_destroy_compress_cache();
 	f2fs_destroy_compress_mempool();
@@ -5064,7 +5065,6 @@ static void __exit exit_f2fs_fs(void)
 	f2fs_destroy_iostat_processing();
 	f2fs_destroy_post_read_processing();
 	f2fs_destroy_root_stats();
-	unregister_filesystem(&f2fs_fs_type);
 	f2fs_exit_shrinker();
 	f2fs_exit_sysfs();
 	f2fs_destroy_garbage_collection_cache();
-- 
2.34.1



Return-Path: <linux-kernel+bounces-444459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E79F0732
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E36E188BB2A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A11AC884;
	Fri, 13 Dec 2024 09:05:34 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB56118E377
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734080733; cv=none; b=YqiRGUToX/LGY/MCj7qtG3BAWKOhJczmAZrwKpMIEVZnb3b2Z5ELOWUpGakTqg+RyXJwpk4xHtPoDpkf7Hm2odGXU/SUKc+yw9Q9DZ0bZuZxAPk55st0RUw032qUQMhy3jgoFRWn+vOGw7c7Fv60cbxADh2iurgXY2xbBc9veYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734080733; c=relaxed/simple;
	bh=+xaoCDwOo18MCwOmAHkTVKG+EeUzHiJWt4PWovXkx9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwsCYtN83+zUgCw6nmqligmejiFe6c87dhKk8hQzorcjjaWkQAoHTh90Q3mCEsdyeUk8fvbfB/2cfHvEIKXoH8rgALS6pFXd7bZ/todzHQCjxHD6uCwpRJvbMFxyUW8nOeHhiAwyDphlV2MA+5u82r83lqWQVRKOzwjEGkYxzaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD7sXhG029034;
	Fri, 13 Dec 2024 01:05:03 -0800
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u6wq8-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 13 Dec 2024 01:05:03 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Fri, 13 Dec 2024 01:05:02 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Fri, 13 Dec 2024 01:05:01 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com>
CC: <almaz.alexandrovich@paragon-software.com>, <linux-kernel@vger.kernel.org>,
        <ntfs3@lists.linux.dev>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] ntfs3: fix deadlock in mark_as_free_ex
Date: Fri, 13 Dec 2024 17:05:00 +0800
Message-ID: <20241213090501.2053886-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <675aa04e.050a0220.17f54a.0083.GAE@google.com>
References: <675aa04e.050a0220.17f54a.0083.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=675bf8bf cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=RZcAm9yDv7YA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=EMw80oP_oC-SzKdMtYEA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: fN3hiovaqxHP7MRFG3L38nYu2tYHCXnd
X-Proofpoint-GUID: fN3hiovaqxHP7MRFG3L38nYu2tYHCXnd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_03,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412130061

syzbot reported a deadlock in mark_as_free_ex. [1]

Reset the order of mft and used locks to avoid this issue.

[1]
WARNING: possible circular locking dependency detected
6.13.0-rc2-syzkaller-00036-g231825b2e1ff #0 Not tainted
------------------------------------------------------
syz-executor149/6544 is trying to acquire lock:
ffff88807e17a270 (&wnd->rw_lock){++++}-{4:4}, at: mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484

but task is already holding lock:
ffff8880705e43c8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_truncate fs/ntfs3/file.c:505 [inline]
ffff8880705e43c8 (&ni->file.run_lock#2){++++}-{4:4}, at: ntfs_setattr+0x6d3/0xb80 fs/ntfs3/file.c:824

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->file.run_lock#2){++++}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1524
       run_unpack_ex+0x55e/0x9e0 fs/ntfs3/run.c:1119
       ntfs_read_mft fs/ntfs3/inode.c:401 [inline]
       ntfs_iget5+0x1f9a/0x37b0 fs/ntfs3/inode.c:537
       ntfs_dir_emit fs/ntfs3/dir.c:335 [inline]
       ntfs_read_hdr+0x700/0xb80 fs/ntfs3/dir.c:383
       ntfs_readdir+0x91f/0xf00 fs/ntfs3/dir.c:494
       iterate_dir+0x571/0x800 fs/readdir.c:108
       __do_sys_getdents64 fs/readdir.c:403 [inline]
       __se_sys_getdents64+0x1e2/0x4b0 fs/readdir.c:389
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&wnd->rw_lock){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       down_write_nested+0xa2/0x220 kernel/locking/rwsem.c:1693
       mark_as_free_ex+0x3e/0x390 fs/ntfs3/fsntfs.c:2484
       run_deallocate_ex+0x244/0x5f0 fs/ntfs3/attrib.c:122
       attr_set_size+0x168d/0x4300 fs/ntfs3/attrib.c:753
       ntfs_truncate fs/ntfs3/file.c:506 [inline]
       ntfs_setattr+0x7a4/0xb80 fs/ntfs3/file.c:824
       notify_change+0xbca/0xe90 fs/attr.c:552
       do_truncate+0x220/0x310 fs/open.c:65
       handle_truncate fs/namei.c:3449 [inline]
       do_open fs/namei.c:3832 [inline]
       path_openat+0x2e1e/0x3590 fs/namei.c:3987
       do_filp_open+0x27f/0x4e0 fs/namei.c:4014
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
       do_sys_open fs/open.c:1417 [inline]
       __do_sys_open fs/open.c:1425 [inline]
       __se_sys_open fs/open.c:1421 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1421
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->file.run_lock#2);
                               lock(&wnd->rw_lock);
                               lock(&ni->file.run_lock#2);
  lock(&wnd->rw_lock);

 *** DEADLOCK ***

Fixes: 5fc982fe7eca ("fs/ntfs3: Fix case when unmarked clusters intersect with zone")
Reported-by: syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
Tested-by: syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 fs/ntfs3/run.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 6e86d66197ef..fdac1f941379 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1096,9 +1096,17 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 		/* Looks like volume is corrupted. */
 		ntfs_set_state(sbi, NTFS_DIRTY_ERROR);
-
-		if (!down_write_trylock(&wnd->rw_lock))
+		struct rw_semaphore *lock =
+			is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
+					  NULL;
+		if (zone && lock)
+			down_read(lock);
+
+		if (!down_write_trylock(&wnd->rw_lock)) {
+			if (zone && lock)
+				up_read(lock);
 			continue;
+		}
 
 		if (zone) {
 			/*
@@ -1112,16 +1120,12 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		err = wnd_set_used_safe(wnd, lcn, len, &done);
 		if (zone) {
 			/* Restore zone. Lock mft run. */
-			struct rw_semaphore *lock =
-				is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
-						  NULL;
-			if (lock)
-				down_read(lock);
 			ntfs_refresh_zone(sbi);
-			if (lock)
-				up_read(lock);
 		}
 		up_write(&wnd->rw_lock);
+		if (zone && lock)
+			up_read(lock);
+
 		if (err)
 			return err;
 	}
-- 
2.43.0



Return-Path: <linux-kernel+bounces-447417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 229C59F31EB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D63CD188960D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E4E20551E;
	Mon, 16 Dec 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnB6ltlo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6D2054E1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734356780; cv=none; b=geKbe5WUVjQJ59/qgbEqArXn5PpESq6qhJ/k2ikCPm/5PDwWjIBG6Y6ELnSmhe0ej1B+znufLs3wRE85vUogzzXPecNYzx4cmyeEA5oKQFcrzdtQv2tWixuRgd+7fhr3xrnOekbAzQWH2ZSf6rYooFlOt5iiKkhg/vptfloQkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734356780; c=relaxed/simple;
	bh=h680FSarTKxAYGzHO4A3NuyVe7d878RQW85+aBBE0E8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZpOnzMq/mhgJJhFUzMQLGDj2lfEMQqhZkkUzgsHjk93znUh7sNIUpgu5XEe9u22kfeF23cKTlhm+TZHol0/eiUCE4vzZ5K0ciJD19mECKDhVyz0PKc7enuMPGTZq91Vjy6L7Y7ob3FErojz9Zj6fkbwPugvKPZcKtPo999PzrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnB6ltlo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C875C4CED0;
	Mon, 16 Dec 2024 13:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734356779;
	bh=h680FSarTKxAYGzHO4A3NuyVe7d878RQW85+aBBE0E8=;
	h=From:To:Cc:Subject:Date:From;
	b=AnB6ltlo7qAcNavqKW+JmHhmX6s4dDd+SBXIXjH1S2kTnHp+CQ6PCDgdckXDmlWm9
	 VyDOqITLxDHvqc04FDxosw4BE4mmInIcMVNWbcHPI7Kt7xZPNsnbHl0PyLlgT9i3CL
	 JKmLYJGOHArOqzHcenvz5OIVpwJCvPM2l7mbPZnEEudLlu0HQ+r5tvGHkjC4z+gZ7l
	 z0kpZ1su/jJorccnVjkFYkQC375v3PG6Bq0Oea7QHnI+NkyP4zGcrapJFLERnNT+Wm
	 88V3c4T4jQm/5qZqXy2ac77rRPvmb80j9w6W2nsSO4XZKXLDdT0SSgpHGjFeJVDFau
	 w1gE9JQsrY9Tg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	syzbot+69f5379a1717a0b982a1@syzkaller.appspotmail.com
Subject: [PATCH] f2fs: fix to do sanity check correctly on i_inline_xattr_size
Date: Mon, 16 Dec 2024 21:46:00 +0800
Message-Id: <20241216134600.8308-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported an out-of-range access issue as below:

UBSAN: array-index-out-of-bounds in fs/f2fs/f2fs.h:3292:19
index 18446744073709550491 is out of range for type '__le32[923]' (aka 'unsigned int[923]')
CPU: 0 UID: 0 PID: 5338 Comm: syz.0.0 Not tainted 6.12.0-syzkaller-10689-g7af08b57bcb9 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 read_inline_xattr+0x273/0x280
 lookup_all_xattrs fs/f2fs/xattr.c:341 [inline]
 f2fs_getxattr+0x57b/0x13b0 fs/f2fs/xattr.c:533
 vfs_getxattr_alloc+0x472/0x5c0 fs/xattr.c:393
 ima_read_xattr+0x38/0x60 security/integrity/ima/ima_appraise.c:229
 process_measurement+0x117a/0x1fb0 security/integrity/ima/ima_main.c:353
 ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2ccd/0x3590 fs/namei.c:3987
 do_file_open_root+0x3a7/0x720 fs/namei.c:4039
 file_open_root+0x247/0x2a0 fs/open.c:1382
 do_handle_open+0x85b/0x9d0 fs/fhandle.c:414
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

index: 18446744073709550491 (decimal, unsigned long long)
= 0xfffffffffffffb9b (hexadecimal) = -1125 (decimal, long long)
UBSAN detects that inline_xattr_addr() tries to access .i_addr[-1125].

w/ below testcase, it can reproduce this bug easily:
- mkfs.f2fs -f -O extra_attr,flexible_inline_xattr /dev/sdb
- mount -o inline_xattr_size=512 /dev/sdb /mnt/f2fs
- touch /mnt/f2fs/file
- umount /mnt/f2fs
- inject.f2fs --node --mb i_inline --nid 4 --val 0x1 /dev/sdb
- inject.f2fs --node --mb i_inline_xattr_size --nid 4 --val 2048 /dev/sdb
- mount /dev/sdb /mnt/f2fs
- getfattr /mnt/f2fs/file

The root cause is if metadata of filesystem and inode were fuzzed as below:
- extra_attr feature is enabled
- flexible_inline_xattr feature is enabled
- ri.i_inline_xattr_size = 2048
- F2FS_EXTRA_ATTR bit in ri.i_inline was not set

sanity_check_inode() will skip doing sanity check on fi->i_inline_xattr_size,
result in using invalid inline_xattr_size later incorrectly, fix it.

Meanwhile, let's fix to check lower boundary for .i_inline_xattr_size w/
MIN_INLINE_XATTR_SIZE like we did in parse_options().

Fixes: 6afc662e68b5 ("f2fs: support flexible inline xattr size")
Reported-by: syzbot+69f5379a1717a0b982a1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/674f4e7d.050a0220.17bd51.004f.GAE@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 282fd320bdb3..29ccc64faae9 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -302,15 +302,6 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 				  F2FS_TOTAL_EXTRA_ATTR_SIZE);
 			return false;
 		}
-		if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
-			f2fs_has_inline_xattr(inode) &&
-			(!fi->i_inline_xattr_size ||
-			fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
-			f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, max: %lu",
-				  __func__, inode->i_ino, fi->i_inline_xattr_size,
-				  MAX_INLINE_XATTR_SIZE);
-			return false;
-		}
 		if (f2fs_sb_has_compression(sbi) &&
 			fi->i_flags & F2FS_COMPR_FL &&
 			F2FS_FITS_IN_INODE(ri, fi->i_extra_isize,
@@ -320,6 +311,16 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
+	if (f2fs_sb_has_flexible_inline_xattr(sbi) &&
+		f2fs_has_inline_xattr(inode) &&
+		(fi->i_inline_xattr_size < MIN_INLINE_XATTR_SIZE ||
+		fi->i_inline_xattr_size > MAX_INLINE_XATTR_SIZE)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %u, max: %lu",
+			  __func__, inode->i_ino, fi->i_inline_xattr_size,
+			  MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
+		return false;
+	}
+
 	if (!f2fs_sb_has_extra_attr(sbi)) {
 		if (f2fs_sb_has_project_quota(sbi)) {
 			f2fs_warn(sbi, "%s: corrupted inode ino=%lx, wrong feature flag: %u, run fsck to fix.",
-- 
2.40.1



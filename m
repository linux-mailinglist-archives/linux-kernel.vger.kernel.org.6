Return-Path: <linux-kernel+bounces-557427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A550A5D8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985877A4673
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168623645D;
	Wed, 12 Mar 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt+DtEI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC61522259A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741770094; cv=none; b=LOR3ro1opZARkfei/6p94MAhIC7jiXQmuyOUCUd9S4XTV0nAf/P6f9czQjB6PDkj2IiFBydh3lE8d8OYxRvEg1cTrXgyJFCHH4/6yBbZCtNFAmkbbFh+MvRnbxEGrsPB5s8zSlDKjZsvin86t000Ew5qV0IxcmO2WCsE4Pb3jpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741770094; c=relaxed/simple;
	bh=G93hOZvkeNxGPS2XIgjqVw8Ob92awPEw3CcYOqVE6c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nTYHK8Csytz8XGnKOU0b6+7Os7SHPsI2FalEqpSidNnmApX4c8RaojLxjqt2XMb3rZoKop60JeOzgu8tqqFCTu6knGY5gj6ESbjfcGaMcCxFx9gp+vckF6/81qa+PBdtDHo88zie5+nG2Knrg9mGgKbLyIKTlBJ4aoI2X5CIfr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt+DtEI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5746C4CEE3;
	Wed, 12 Mar 2025 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741770094;
	bh=G93hOZvkeNxGPS2XIgjqVw8Ob92awPEw3CcYOqVE6c4=;
	h=From:To:Cc:Subject:Date:From;
	b=Dt+DtEI/BGMJ3YXHbQ2mwDitKcrND2sYa6535UOEieueRhYMkDGc7tDu6nYsv2XsB
	 o5KHaXLSch+srvb3f3O9uB2L4lAhU9hept0pwg0HpLR7G6u5yI0SjqDCSx8YyJ8V8P
	 ZdFvLP28XOTK3Bckmn80w6jycFp0ukM45wtWCJj7jCiMKIlE86BMGTAhCt9EMt44xK
	 h4za0Ws4pSGZQxiBcBNGJkKXI2N4h9dAC5MoxRS4Q4t9AjA9Fn+Mfxv8J8FvDMLNkS
	 c9JYAVL3Vos5JgZV+CuAKxnPNCwRisYuF7dfafGFVkEHP27IZko2uIXkwq6WsEDCpu
	 eVVjCiJ+1F7Yw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to avoid running out of free segments
Date: Wed, 12 Mar 2025 17:01:25 +0800
Message-ID: <20250312090125.4014447-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If checkpoint is disabled, GC can not reclaim any segments, we need
to detect such condition and bail out from fallocate() of a pinfile,
rather than letting allocator running out of free segment, which may
cause f2fs to be shutdown.

reproducer:
mkfs.f2fs -f /dev/vda 16777216
mount -o checkpoint=disable:10% /dev/vda /mnt/f2fs
for ((i=0;i<4096;i++)) do { dd if=/dev/zero of=/mnt/f2fs/$i bs=1M count=1; } done
sync
for ((i=0;i<4096;i+=2)) do { rm /mnt/f2fs/$i; } done
sync
touch /mnt/f2fs/pinfile
f2fs_io pinfile set /mnt/f2fs/pinfile
f2fs_io fallocate 0 0 4201644032 /mnt/f2fs/pinfile

cat /sys/kernel/debug/f2fs/status
output:
  - Free: 0 (0)

Fixes: f5a53edcf01e ("f2fs: support aligned pinned file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2ddb93d1a10c..abbcbb5865a3 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1838,6 +1838,18 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 next_alloc:
 		f2fs_down_write(&sbi->pin_sem);
 
+		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+			if (has_not_enough_free_secs(sbi, 0, 0)) {
+				f2fs_up_write(&sbi->pin_sem);
+				err = -ENOSPC;
+				f2fs_warn_ratelimited(sbi,
+					"ino:%lu, start:%lu, end:%lu, need to trigger GC to "
+					"reclaim enough free segment when checkpoint is enabled",
+					inode->i_ino, pg_start, pg_end);
+				goto out_err;
+			}
+		}
+
 		if (has_not_enough_free_secs(sbi, 0, f2fs_sb_has_blkzoned(sbi) ?
 			ZONED_PIN_SEC_REQUIRED_COUNT :
 			GET_SEC_FROM_SEG(sbi, overprovision_segments(sbi)))) {
-- 
2.48.1



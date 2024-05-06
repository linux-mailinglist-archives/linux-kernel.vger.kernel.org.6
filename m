Return-Path: <linux-kernel+bounces-169685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347A8BCC32
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E80A281B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 10:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B347143874;
	Mon,  6 May 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiOxEnJ1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72999143863
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714992134; cv=none; b=a6kTfbAixMwl9SuhJK/+eT8WqQ+mqhYoEpB4/T6bvdipWtchK9Ba1EYZNBkpfq+St3CbBMO3mnCfs4BLoLHIhoisYTN03lKDYRVrHpCC7bZnK8yivtw8TvgVvCGJOrIFTXBGcC5HPA3RxusAt3rfVtbM4xbzCpDsutdI5R/I4jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714992134; c=relaxed/simple;
	bh=h2cJ8DiDTvOHVXuqiLQoZiz/U51rJ58bz1v/ndbDMNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQ8gBMq2G70Ob+Kt+VTToyfK4OTws2TJ8i9ROyINBw4xYtJwgj8PINJd+apshoUozq4SsXqERgnBz9/hXvbpjLEVdFGR8VFZrZKbCBgtY0F4Cd45vccwBLvnriHXV1jeb9DsrLduXD00HBC1MLjJi6ay37OPDv3tN8qBWe1zLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiOxEnJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138FDC4AF66;
	Mon,  6 May 2024 10:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714992134;
	bh=h2cJ8DiDTvOHVXuqiLQoZiz/U51rJ58bz1v/ndbDMNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BiOxEnJ1khv7+Zae5sAhEAsn2ZDIc9Ye9P28fYz4pEatNLYbUaHZRWSQwOeayJsuO
	 3ON/Fn6RgX2LR295sTaNE53iuE8Wxdki7jx3y/GvNzpJRvcIFDtRCG6HH+e1pcB4s3
	 tOech77POBhS4mtwrZ/hU617xqruqq8zLlFwYyiXbh1V6YsT//8UuFKucEjLqgEa71
	 C1JGpJs4ZXt9RHyGFZErXZAHNWpBjUcvIjNTGTNSqn/CMaKWGAYSJaYurkERH5L0vX
	 WT5wBhGOi8nPKmRL2MQIHb7/F7Yv7nu7edzCPcwzCM+O7aZRoDRahlbFpK533EFzP0
	 2Hj+mvEq2JVzw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/5] f2fs: compress: fix to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
Date: Mon,  6 May 2024 18:41:39 +0800
Message-Id: <20240506104140.776986-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240506104140.776986-1-chao@kernel.org>
References: <20240506104140.776986-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to cover {reserve,release}_compress_blocks() w/ cp_rwsem lock
to avoid racing with checkpoint, otherwise, filesystem metadata including
blkaddr in dnode, inode fields and .total_valid_block_count may be
corrupted after SPO case.

Fixes: ef8d563f184e ("f2fs: introduce F2FS_IOC_RELEASE_COMPRESS_BLOCKS")
Fixes: c75488fb4d82 ("f2fs: introduce F2FS_IOC_RESERVE_COMPRESS_BLOCKS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e77e958a9f92..3f0db351e976 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3570,9 +3570,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3590,6 +3593,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3742,9 +3747,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3762,6 +3770,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
-- 
2.40.1



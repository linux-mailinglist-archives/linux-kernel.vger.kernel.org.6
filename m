Return-Path: <linux-kernel+bounces-371027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F329A3554
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5727B21991
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46781865EA;
	Fri, 18 Oct 2024 06:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8jlWh+4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12034185B68
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232810; cv=none; b=i42o37Et7JPSGjc3iFyRlGhfi5Gkum6369akK3DiVch0FqqZoNb2HKUApDIsTsOB/KCjjLnmkromdQghQ2exPn/VjIB1vYfICYcMeaC+amuE69O6jKIyR9SN19HbhfxX9cp9Fwkkfj0xk/PxyFpwmToibRPYJPgi0+YxDL6h2uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232810; c=relaxed/simple;
	bh=YDbEYfqH5QdtjigKgVD4ialWiRbwxPVZKrn1ldhPIkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SPVQMVOFxbLvKjcuIbx7lQ2m6MB80Q6TjB/1hTQNAlKodZX6lx7y+pzJKh6mLGYj0gOKfdNizhTK3XPs7dJvKj9g5CsQAs3CaMYaF0Rxyye1iZuStndoyovh4e4c48/o24hAHgVutlHlNqynmDi2yMVFLIrQ8+7HRfYBmO1i9OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8jlWh+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B60AC4CECF;
	Fri, 18 Oct 2024 06:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729232809;
	bh=YDbEYfqH5QdtjigKgVD4ialWiRbwxPVZKrn1ldhPIkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K8jlWh+44XiVhSGiHFKsH8jsPXnXCnFNl4ojrKKfU8rPpQK8KWLVaq7ZyM2mESb7a
	 T2l33YpKCdAqrgMO78A8mkqq9/epz38zcQdkKWER5s5k1RZbclnYWjNqshCarShtgc
	 2STOsuK8jGm/bSfAP9mCg9aBW5vL6xnn7TuHimBq7PqKYoYnLMRHsZOjHunhz8QbFU
	 5Vy4rx2uzM95z2lDKxPo1Ghot2tHozVK9yrCzwWNdJ83rxT+FyFQCrla6prY0/LWsu
	 p6Yt3w6ArJFj/E4Y5xtN1jYgvqSVviFlzJnVkuOXA6DVnGU6iQpgyQ33GSHN57MNiu
	 3cjW37nI5IF7Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: zone: allow IPU for regular file in regular block device
Date: Fri, 18 Oct 2024 14:26:37 +0800
Message-Id: <20241018062638.2619214-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241018062638.2619214-1-chao@kernel.org>
References: <20241018062638.2619214-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blkzoned feature enables lfs mode by default, for data updates from
regular file, it only allow to use OPU, this patch changes to allow
to use IPU if regular file's data block locates in regular block
device, if data block locates in zoned block device, it still uses
OPU.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 12 ++++++++++--
 fs/f2fs/f2fs.h |  5 +++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 949b6bb957c7..c6d0e4aa12e3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2648,8 +2648,16 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return false;
 	if (fio && is_sbi_flag_set(sbi, SBI_NEED_FSCK))
 		return true;
-	if (f2fs_lfs_mode(sbi))
-		return true;
+	if (f2fs_lfs_mode(sbi)) {
+		/* no regular block device in mainarea */
+		if (!f2fs_blkzoned_has_regular_section(sbi))
+			return true;
+		/* blkaddr locates in sequential zone */
+		if (fio && __is_valid_data_blkaddr(fio->old_blkaddr) &&
+			GET_SEGNO(sbi, fio->old_blkaddr) >=
+					sbi->first_zoned_segno)
+			return true;
+	}
 	if (S_ISDIR(inode->i_mode))
 		return true;
 	if (IS_NOQUOTA(inode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 55bcd411257a..6781b4fab43f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4790,6 +4790,11 @@ static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
 	f2fs_invalidate_compress_page(sbi, blkaddr);
 }
 
+static inline bool f2fs_blkzoned_has_regular_section(struct f2fs_sb_info *sbi)
+{
+	return f2fs_sb_has_blkzoned(sbi) && sbi->first_zoned_segno;
+}
+
 #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
 #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
 
-- 
2.40.1



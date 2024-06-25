Return-Path: <linux-kernel+bounces-228241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0E7915D34
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254661C2125B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9577044C73;
	Tue, 25 Jun 2024 03:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As17zSnO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD24261FE6
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285247; cv=none; b=nXMDM28AbJ1E8y9GzQjXTnK3iSusZA9oa8Sgybb4GkGvcE9rQj6YQyd4rqeovhAUSW3En62EO7HLgcrugVKgq21Mq/xmd9Tu6cgFRclMRH8sfFDFBwk4jOFMn4LbiAJcW/+nfDolcDfUefx69BFf6dcopjmKd4eNqntF8avsaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285247; c=relaxed/simple;
	bh=xmtO96A+N055YtD+3waXk7KlXygllEUWidyxOMqx4xI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eMhWSFQPkDfpvYrL8BzrmqjeSegwvKBMOv5pmnWD0/EmA7PlQ7obI3LndyK/m4nHq+qkXtnppOmdMbbFlZc/ewvC8MLommup8N5ucn/YEV0NRkGW2n83GB77JQPP14wsUpU+630CtzAJkMgRz3mSLKSTlxANl2skN7UeSO4xTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As17zSnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CF7C4AF09;
	Tue, 25 Jun 2024 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719285247;
	bh=xmtO96A+N055YtD+3waXk7KlXygllEUWidyxOMqx4xI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=As17zSnO0H4YoH+VEVrP911ZuxvwpgRbdBTze0ZpkNW/ELFc5oFf3HykaV5PANk7V
	 2ab/7PRTOjsr6r8s93ABFdevstCei9Equ9lwnzbWYj1q5ETshXq2OnFghqFDsYetV1
	 Cde/ANAIZobA0uB4A09LUfECsCiwkmMdt3OW8WYqBlPQyRuSoNfvV/HYYSNknt6EPn
	 P+LmSyn3ekDO+OGnl3c9P0GY+b3aoDdWe5ijfWLYOGBwW2xUP+oEaIkr0p5a5e6iD4
	 akbjT990sIF+LS/A7BewqCDY92BD8N15JmuelcQLhk3z1FnqQL/qKl/J329434dGdF
	 yGpMuq1R6GzIA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] f2fs: atomic: fix to forbid dio in atomic_file
Date: Tue, 25 Jun 2024 11:13:51 +0800
Message-Id: <20240625031351.3586955-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240625031351.3586955-1-chao@kernel.org>
References: <20240625031351.3586955-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atomic write can only be used via buffered IO, let's fail direct IO on
atomic_file and return -EOPNOTSUPP.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0355cb054521..a527de1e7a2f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2150,6 +2150,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		goto out;
 
 	f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+	f2fs_down_write(&fi->i_gc_rwsem[READ]);
 
 	/*
 	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
@@ -2209,6 +2210,7 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 	}
 	f2fs_i_size_write(fi->cow_inode, isize);
 
+	f2fs_up_write(&fi->i_gc_rwsem[READ]);
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	f2fs_update_time(sbi, REQ_TIME);
@@ -4537,6 +4539,13 @@ static ssize_t f2fs_dio_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		f2fs_down_read(&fi->i_gc_rwsem[READ]);
 	}
 
+	/* dio is not compatible w/ atomic file */
+	if (f2fs_is_atomic_file(inode)) {
+		f2fs_up_read(&fi->i_gc_rwsem[READ]);
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/*
 	 * We have to use __iomap_dio_rw() and iomap_dio_complete() instead of
 	 * the higher-level function iomap_dio_rw() in order to ensure that the
@@ -4948,6 +4957,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	/* Determine whether we will do a direct write or a buffered write. */
 	dio = f2fs_should_use_dio(inode, iocb, from);
 
+	/* dio is not compatible w/ atomic write */
+	if (dio && f2fs_is_atomic_file(inode)) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock;
+	}
+
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
-- 
2.40.1



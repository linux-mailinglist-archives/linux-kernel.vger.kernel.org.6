Return-Path: <linux-kernel+bounces-229047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F43916A30
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A41C1F21BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCF916C684;
	Tue, 25 Jun 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2R/5hMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D1D15AD8B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719325520; cv=none; b=dmqDfWd6ihvbQ3rXQtkCbqVSgkOipMkw6Nyuo8Nr6eR3krlArtug1GzFhzg6z9DFWTAOOaEUAsGD2WcdQnVI19mwXY9lBYePRDhui9tiokDap98vg8+K6LRo+iXQ40RfC8hp3Q2RBXH0BX727Tk+1GyDs/oMY6/YiLr1mfYFjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719325520; c=relaxed/simple;
	bh=KCiRHdEYUu5KhYIjzP1/grjHbsL7+5UhfKsfbxFLVBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jI+26ZsIzOD2Ppj//78xTuZWB/v+FHqaZglk14oBizztSI7cqsXoWE++QE8AmviNEfxhr5Ny4Ent4ZoKXzJKETG4Gh7F8ANprNS9FVyGC23fn3nf39W9dhINX+MLZh8tZzGMmxosKN/pjRLQn1vuieeM91iUPPPsU65685b6Eig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2R/5hMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D219CC32786;
	Tue, 25 Jun 2024 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719325520;
	bh=KCiRHdEYUu5KhYIjzP1/grjHbsL7+5UhfKsfbxFLVBM=;
	h=From:To:Cc:Subject:Date:From;
	b=R2R/5hMO+8nyXlR2C1cnBmTaeuCpRGBVUp7sW/IVnPrWbxcbjA7EFBQ7XLRF3VD8Q
	 vaXyPyotbIEjoMEsuzvkLTYieLSG3U35uTQ2/ywoIk9WcnWC9EUh5AAyvi1cZBAOAR
	 wLXGKheFw4bwHjwaMqS7HcPBCfobqB1l56iYt/0gWZ7dMgJmwhsU64Oro57FJlekph
	 a0JVFGLtZx1+FYctUwzZzaOcwC7MS+vP/FQf7PtRu+mOGbIWYDV+mQQxw+w1U4rlRR
	 7FC55fYrIB+y5e0ikHJkl7/gjaQ3y2ulU7iN6muDj0GCdkIpxKsmwCYW7LwGNT/BLC
	 U8vscqIKtDRkQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs: fix to avoid racing in between read and OPU dio write
Date: Tue, 25 Jun 2024 22:25:12 +0800
Message-Id: <20240625142512.3916063-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If lfs mode is on, buffered read may race w/ OPU dio write as below,
it may cause buffered read hits unwritten data unexpectly, and for
dio read, the race condition exists as well.

Thread A			Thread B
- f2fs_file_write_iter
 - f2fs_dio_write_iter
  - __iomap_dio_rw
   - f2fs_iomap_begin
    - f2fs_map_blocks
     - __allocate_data_block
      - allocated blkaddr #x
       - iomap_dio_submit_bio
				- f2fs_file_read_iter
				 - filemap_read
				  - f2fs_read_data_folio
				   - f2fs_mpage_readpages
				    - f2fs_map_blocks
				     : get blkaddr #x
				    - f2fs_submit_read_bio
				IRQ
				- f2fs_read_end_io
				 : read IO on blkaddr #x complete
IRQ
- iomap_dio_bio_end_io
 : direct write IO on blkaddr #x complete

In LFS mode, if there is inflight dio, let's force read to buffered
IO, this policy won't cover all race cases, however it is a tradeoff
which avoids abusing lock around IO paths.

Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 278573974db4..866f1a34e92b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -882,6 +882,10 @@ static bool f2fs_force_buffered_io(struct inode *inode, int rw)
 		return true;
 	if (is_sbi_flag_set(sbi, SBI_CP_DISABLED))
 		return true;
+	/* In LFS mode, if there is inflight dio, force read to buffered IO */
+	if (rw == READ && f2fs_lfs_mode(sbi) &&
+			atomic_read(&inode->i_dio_count))
+		return false;
 
 	return false;
 }
-- 
2.40.1



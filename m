Return-Path: <linux-kernel+bounces-231908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F791A02F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE8C2852BC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2C481D7;
	Thu, 27 Jun 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPhMUtlz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096C52F41
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719472530; cv=none; b=ejRqrf1C11s7UU1F4xFpAyk7eY/lHqRA7M/nGcGQQCRQVS96QxFGFenWig5h9fm/LIZ/5q7JeD6/ndfN2r2B0C7fqNhpXKpwZAoN5lTPHvJNUa1tqo+kbdBXbSpy+Y5nrj2oBBkoSpcy6hFEf+7MbbqsQXaLCfJb0gOyw8wplmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719472530; c=relaxed/simple;
	bh=vJTYGJ4aYXC9z7eTs4SAfiTyTPPHXRhEbhAa2JgUdbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gYM4quYAolLl194HSrkmTE6ewbrmV/pmI5XIfvFHG6aaZTDrgOGW7Sw9VjPmCJAbcQt6LyndYEzgD08SkIMe3T/YxQpPLqFUd+9N66lz7GMpeP4p8e6Cdz+tr+l9oO6p6tepFUToKcZgPdHNy5xleY+aeEUg8eAWGQdcj3tLwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPhMUtlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB8CC32786;
	Thu, 27 Jun 2024 07:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719472529;
	bh=vJTYGJ4aYXC9z7eTs4SAfiTyTPPHXRhEbhAa2JgUdbg=;
	h=From:To:Cc:Subject:Date:From;
	b=KPhMUtlzGjvaRXQjc2bknCW4E+BB67tKU3CHeehRuAUOypxQIyHEfLs9Im69pVWZz
	 B1SGYfCH7cj/X7IZO6UQKOtNXcaWlBCPNEN8+V0pG+3naTTY+S0xyrQcY77+aBW8T5
	 ueYx8VpyIryfzaC4LspGexGk49DLZ0uWy9/g2AzOg/HA6flwfpUW5P7XAaASQWp8Mz
	 VdwqByLt7DwVeXDAsGknlzhceyhWqJeWfgwWiLnK/rSr9DmxR5/VCWVrvRxHhdUbY0
	 luAjPCf1VLyny0L8yTz68iftdoeINc5O1AZ6EztR8mEKmGM+mKsd8oZ5ho2/Koe8yF
	 JLO0s9e7HUDIA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3] f2fs: fix to avoid racing in between read and OPU dio write
Date: Thu, 27 Jun 2024 15:15:21 +0800
Message-Id: <20240627071521.1557830-1-chao@kernel.org>
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

In LFS mode, if there is inflight dio, let's wait for its completion,
this policy won't cover all race cases, however it is a tradeoff which
avoids abusing lock around IO paths.

Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- wait for direct IO's completion before read IO.
 fs/f2fs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9e171e138943..76a6043caf27 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4608,6 +4608,10 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
 					iov_iter_count(to), READ);
 
+	/* In LFS mode, if there is inflight dio, wait for its completion */
+	if (f2fs_lfs_mode(F2FS_I_SB(inode)))
+		inode_dio_wait(inode);
+
 	if (f2fs_should_use_dio(inode, iocb, to)) {
 		ret = f2fs_dio_read_iter(iocb, to);
 	} else {
-- 
2.40.1



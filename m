Return-Path: <linux-kernel+bounces-323114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590C697381D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8FD61F255B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA59191F97;
	Tue, 10 Sep 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHD3uvoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2BB191F8C
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725973081; cv=none; b=KqRVuzOcr5jUt097/M8FeCmBYNCOyeZEgaOPE1YBLl8fok7rKmuCaEX5PdzctTDH5WLqWwN+Jk0Ysl8nLJ7SGY4vWd06skvQTmYVhDIYtmJRt4dMKjpTvSxeCMT6HdxcJSW8uq1cdLxa0B8JWTf2znTr7VlQ/i2+30w3jEV2J50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725973081; c=relaxed/simple;
	bh=vwQ88BpQCZ7595D2+tEmHq3Pwl2yGQtzZstSueKAOZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mc/voitHkBtywna/3GiWSU7U43RTu1hQhbjpxw/uqstTBmfj430Skx6HhaMBcqFEvSy+BqyehE2FHhjXqFjo/mpZqYXQDilCyal4VdzM6Fm5SDyGUaLm2SPBf1R/3MpZkMOXtgzdCp7zQnN8fRddKcgKv7Re0AovHtGnq580l6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHD3uvoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551E1C4CEC6;
	Tue, 10 Sep 2024 12:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725973081;
	bh=vwQ88BpQCZ7595D2+tEmHq3Pwl2yGQtzZstSueKAOZE=;
	h=From:To:Cc:Subject:Date:From;
	b=eHD3uvoJ/I8pfd67YeayNC93MTrU3OMqBOUZph4Y49FHjaZcElkbyyZ4M9+Q9PF7F
	 hNhR08toQ9Mkrnr5RezZijq2JHltsnvmV9fpOK3Nmj5dp12xCFPxIPvdwTB/iDHklY
	 IivOMtRDIoSHTMtAKpB0eHI3O4p+cpeUst0wceH8TWS3TqmySMk5NWMKeiQTtz/NfH
	 RrCA1a0KM9La9lQyOxeIQcC1ofvBq10PYdcp5kY3QBa+jqJ/wY3gGPJ8ob/aEBlNPY
	 JArEByH3QWMPu0H/T9KN7+s31qeJcSMrwtcLT7J38kO2OWorKAQO4R5c22FS2Dt3Yy
	 GeC0YR8m28dEw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to tag STATX_DIOALIGN only if inode support dio
Date: Tue, 10 Sep 2024 20:57:53 +0800
Message-Id: <20240910125753.80502-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
inode"), f2fs starts to force using buffered IO on inline_data inode.

And also, it will cause f2fs_getattr() returning invalid zeroed value on
.dio_mem_align and .dio_offset_align fields, however, STATX_DIOALIGN flag
was been tagged. User may use zeroed .stx_dio_offset_align value
since STATX_DIOALIGN was been tagged, then it causes a deadloop during
generic/465 test due to below logic:

align=stx_dio_offset_align(it equals to zero)
page_size=4096
while [ $align -le $page_size ]; do
	echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
	$AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
	align=$((align * 2))
done

Quoted from description of statx manual:

" If  a  filesystem  does  not support a field or if it has an
  unrepresentable value (for instance, a file with an exotic type),
  then the mask bit corresponding to that field will be cleared in
  stx_mask even if the user asked for it and a dummy value will be
  filled in for compatibility purposes if one is available (e.g.,
  a dummy UID and GID may be specified to mount under some
  circumstances)."

We should not set STATX_DIOALIGN flag in kstat.stx_mask if inode
does not support DIO, so that it can indicate related fields contain
dummy value, and avoid following incorrect use of them.

Fixes: c8c02272a9f7 ("f2fs: support STATX_DIOALIGN")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 99903eafa7fe..f0b8b77e93ba 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -906,14 +906,11 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
 	 * cannot represent that, so in that case we report no DIO support.
 	 */
-	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
-		unsigned int bsize = i_blocksize(inode);
-
+	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode) &&
+				!f2fs_force_buffered_io(inode, WRITE)) {
+		stat->dio_mem_align = F2FS_BLKSIZE;
+		stat->dio_offset_align = F2FS_BLKSIZE;
 		stat->result_mask |= STATX_DIOALIGN;
-		if (!f2fs_force_buffered_io(inode, WRITE)) {
-			stat->dio_mem_align = bsize;
-			stat->dio_offset_align = bsize;
-		}
 	}
 
 	flags = fi->i_flags;
-- 
2.40.1



Return-Path: <linux-kernel+bounces-360605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004B1999D22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 08:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914481F24FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAB020966C;
	Fri, 11 Oct 2024 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RYlKzdRc"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C51635
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629508; cv=none; b=DjeJQT2TsKpZBn0YWmaIQ501YSuMzMOi2zpxFLixxOh1YU9t4ixlQZq79gGKddE9duORmNxcMo9Py/fHIlHG04OSx/K4FalYKshDeIkUSD5YB6ZPVb/r6MWJ4ZyBOvN1luTsL+P9gf8VQtEg9U2DdATJwxiOaHQ9rgjQ1g6NVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629508; c=relaxed/simple;
	bh=z84KbUksL+ig752MN4+yXHP/+ziUJayhbQclHqpv+lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMZ0N0/O/JyH6k2JBIvMkd7dckE7pU5uMy+Lu+QbvVxZ+Yg2PL/0rV9bMgOM6jzfjJTB/2BkkHYIWNZLspNPsr22IcRhxFDWVz8YUWX/FlLvl8SUBb4gbtajXkUcBlVCO+Z3cwBpu8GsiXcEEG/eGhlTlOGctRpsR4YOYwR/7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RYlKzdRc; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728629503; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9Jq7WlCziE6Y2VeyCMIXiyZ4N1+DiD4cKivRAbahRII=;
	b=RYlKzdRczAWMo+DBV6GQwNI2WOnx3PcthvX41hac4boGvXq/5TXAA2KxqQK2O9ysAQ4sI7Gc51aAlTrlHeaFAgsUtsMgzeVCrSZaV1BRLSQfyqOxuWAPsk/6eG6Tq7zZ+Qro7g+18QXTpnUShDM1ROiJMM6+6Og3XXFPh15j8II=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGp69Ai_1728629490 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Oct 2024 14:51:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: add SEEK_{DATA,HOLE} support
Date: Fri, 11 Oct 2024 14:51:28 +0800
Message-ID: <20241011065128.2097377-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many userspace programs (including erofs-utils itself) uses SEEK_DATA /
SEEK_HOLE to parse hole extents in addition to FIEMAP.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/data.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 61debd799cf9..6355866220ff 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -473,8 +473,32 @@ static int erofs_file_mmap(struct file *file, struct vm_area_struct *vma)
 #define erofs_file_mmap	generic_file_readonly_mmap
 #endif
 
+static loff_t erofs_file_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+	const struct iomap_ops *ops = &erofs_iomap_ops;
+
+	if (erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout))
+#ifdef CONFIG_EROFS_FS_ZIP
+		ops = &z_erofs_iomap_report_ops;
+#else
+		return generic_file_llseek(file, offset, whence);
+#endif
+
+	if (whence == SEEK_HOLE)
+		offset = iomap_seek_hole(inode, offset, ops);
+	else if (whence == SEEK_DATA)
+		offset = iomap_seek_data(inode, offset, ops);
+	else
+		return generic_file_llseek(file, offset, whence);
+
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}
+
 const struct file_operations erofs_file_fops = {
-	.llseek		= generic_file_llseek,
+	.llseek		= erofs_file_llseek,
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
 	.get_unmapped_area = thp_get_unmapped_area,
-- 
2.43.5



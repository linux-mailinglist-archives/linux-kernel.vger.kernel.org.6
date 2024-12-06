Return-Path: <linux-kernel+bounces-435348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4E69E7662
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C638F166855
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D01CD1FB;
	Fri,  6 Dec 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="T4Cr13jn"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F26E20627F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503823; cv=none; b=D84ODmPyN3h21Q+dlsxjIFaFOMOkmQtq45yc8Br7vyDCNRs9CHldtcqAHCL8c7orRc1wFrIyoYwRIjqyy70QP0n4Iskdk7WyaorcZg3DN0yL5r5tePHmoOShB1mVjTYUt4LHHY6rcpi0LK5nqj5SghmWSe/jhFzzmjoVnu0PgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503823; c=relaxed/simple;
	bh=0D04ZDJQhhKbcCfZ0+z7XRpvmBxnzq8oculexf9LcKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aDQ7I7+JFv+q0rlVGa+9H4+a8o5srbn0DBMrgRlAQezCTQJKcTDX3QYrPPJWkhRO4ji7b9FvxdtA7PXiMnv3DzAFKPv1NfV9nFZ9a0doeiThRanW7dLTYhr6dGvPRbV8u3yRGvPHxDG1LiJWdaE/9BbAcLU2xP121F6/SuFuTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=T4Cr13jn; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-434a044dce2so26136105e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733503819; x=1734108619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/AXLN7pGOp4uRwVstDey0ey7djZ9Y/CWN5MDPVKybg=;
        b=T4Cr13jnMNyPWHF5fxKrgemBGhq6p2j1YOD+dSIhD3FlFu9u/J13eGPsfvUWeHBwKK
         hORgIbCMJdOezRn8pBhPCbpIIlkdRVTKYy4x66dllIY2nM7f+qb90GJsEYUP7L9fyYLf
         3QNw43A4OjFaOYf3qRCrPlvCPHbci2Rl7GG5s+3l2LraNnVLcrWsGlhbQYOCFxknKBxw
         eUZ554WjYb4d6fA6h86ZO0f7A2zxIjjGc/CKlgt5SSiAVTvGKk05JbRYVvXsJMsFOVDc
         1NfZ2aRrQgrcV9egsT5m5cTBcx+48t6uoZb6jaQJvwcq9zxpB4rRE5e17jGgXt0fivsU
         Ok7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733503819; x=1734108619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/AXLN7pGOp4uRwVstDey0ey7djZ9Y/CWN5MDPVKybg=;
        b=W52oEy8hBvCLkDqWpREWJvyg9+rthRUtKxpbeo7xJwT1nddG9on6CRHvDmO4fHUKwd
         gyNXYMf+lDZEeG0oULNwkICNEiJ3IolfjPMpsnRedCW5GuasO/8hOVjYsXqShDBxldDg
         aUX18S0SiSpA6IXoF1zv5NcEsoaT0xJd3NST2x7SXnxlf37iVhNMWr7DckAni5X8PCnG
         mDhldGdT6N+yxZoOOMqG7dZSBqb3P3bE6s1cc6MlWDfn8YgsWPklUEnHwwceTOiO8c5H
         pEhzYDFFiSKgK3jHiFWVDnljjKRP8WuS9WjH1mnIel+wEIkOvSHxaQX8fsMoVOcL2O81
         fOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj12GVpfSOUFKFDMdDFfsEA47oqzeH35o+orNagpCfdDOofS0UwnrpPqDA7AoSSpH8rpGhlo7RE5Ze1KI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvkU4NS6uLm4AHLURlquGVxbwQfz/Lno63LLR2grKdKK4pwX6
	5DpOjvMNuVOewUAsuAkxDl3FVRM3xhjkCr1wUjDRxrJDC2mAW2yLr8/uVLnuu5U=
X-Gm-Gg: ASbGncukgqFMj/07W9xm2/HNJdts1vlrUUPqEll6vBUqredohJU+BOp2hIU6wT38rcy
	snlgNeCvhC9T7Bscg5358HRJ1wS9I3P6SxKyokF5Gq7Us61NmeIicAXl4U7lhlcB1d7B55HqDNQ
	uSla1drEYIDJfDrsQdB8UNPEg3wpQGBPKkU4LekK9ojKTtYNSdJxoUVWZtcwtZsnUBWMRyzVRTA
	04fWJWi1v1QaCUsCBTRf3JxWG+5N4ftPIf+u792yx3NCjtRgpXk8TgfE9M67wUgXd16qBIAFpVr
	e8E0z9U9XdNMjgaYG3+zqeDFnCusLNE01NpP9sHQIEOSNUouyw==
X-Google-Smtp-Source: AGHT+IEjd0/0Bv3IEzgcclSVQbheGNRcjIl0tIIjyWpUjukGx/SAq2YeahHwGZXirAS1p0eFgY6UsA==
X-Received: by 2002:a05:600c:1c8a:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-434ddeb9b30mr44571795e9.17.1733503819398;
        Fri, 06 Dec 2024 08:50:19 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f2c8700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2c:8700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273131sm97737235e9.12.2024.12.06.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:50:19 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/io: make ceph_start_io_*() killable
Date: Fri,  6 Dec 2024 17:50:14 +0100
Message-ID: <20241206165014.165614-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows killing processes that wait for a lock when one process is
stuck waiting for the Ceph server.  This is similar to the NFS commit
38a125b31504 ("fs/nfs/io: make nfs_start_io_*() killable").

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/file.c | 22 +++++++++++++---------
 fs/ceph/io.c   | 44 +++++++++++++++++++++++++++++++++-----------
 fs/ceph/io.h   |  8 +++++---
 3 files changed, 51 insertions(+), 23 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4b8d59ebda00..d79c0774dc6e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2127,10 +2127,11 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	if (direct_lock)
-		ceph_start_io_direct(inode);
-	else
-		ceph_start_io_read(inode);
+	ret = direct_lock
+		? ceph_start_io_direct(inode)
+		: ceph_start_io_read(inode);
+	if (ret)
+		return ret;
 
 	if (!(fi->flags & CEPH_F_SYNC) && !direct_lock)
 		want |= CEPH_CAP_FILE_CACHE;
@@ -2283,7 +2284,9 @@ static ssize_t ceph_splice_read(struct file *in, loff_t *ppos,
 	    (fi->flags & CEPH_F_SYNC))
 		return copy_splice_read(in, ppos, pipe, len, flags);
 
-	ceph_start_io_read(inode);
+	ret = ceph_start_io_read(inode);
+	if (ret)
+		return ret;
 
 	want = CEPH_CAP_FILE_CACHE;
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
@@ -2362,10 +2365,11 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		direct_lock = true;
 
 retry_snap:
-	if (direct_lock)
-		ceph_start_io_direct(inode);
-	else
-		ceph_start_io_write(inode);
+	err = direct_lock
+		? ceph_start_io_direct(inode)
+		: ceph_start_io_write(inode);
+	if (err)
+		goto out_unlocked;
 
 	if (iocb->ki_flags & IOCB_APPEND) {
 		err = ceph_do_getattr(inode, CEPH_STAT_CAP_SIZE, false);
diff --git a/fs/ceph/io.c b/fs/ceph/io.c
index c456509b31c3..2735503bc479 100644
--- a/fs/ceph/io.c
+++ b/fs/ceph/io.c
@@ -47,20 +47,30 @@ static void ceph_block_o_direct(struct ceph_inode_info *ci, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
  */
-void
+int
 ceph_start_io_read(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	int err;
 
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
+
 	if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT))
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
+
 	ceph_block_o_direct(ci, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
@@ -83,11 +93,13 @@ ceph_end_io_read(struct inode *inode)
  * Declare that a buffered write operation is about to start, and ensure
  * that we block all direct I/O.
  */
-void
+int
 ceph_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
-	ceph_block_o_direct(ceph_inode(inode), inode);
+	int err = down_write_killable(&inode->i_rwsem);
+	if (!err)
+		ceph_block_o_direct(ceph_inode(inode), inode);
+	return err;
 }
 
 /**
@@ -133,20 +145,30 @@ static void ceph_block_buffered(struct ceph_inode_info *ci, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
  */
-void
+int
 ceph_start_io_direct(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	int err;
 
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
+
 	if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ODIRECT)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
+
 	ceph_block_buffered(ci, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
diff --git a/fs/ceph/io.h b/fs/ceph/io.h
index fa594cd77348..08d58253f533 100644
--- a/fs/ceph/io.h
+++ b/fs/ceph/io.h
@@ -2,11 +2,13 @@
 #ifndef _FS_CEPH_IO_H
 #define _FS_CEPH_IO_H
 
-void ceph_start_io_read(struct inode *inode);
+#include <linux/compiler_attributes.h> // for __must_check
+
+__must_check int ceph_start_io_read(struct inode *inode);
 void ceph_end_io_read(struct inode *inode);
-void ceph_start_io_write(struct inode *inode);
+__must_check int ceph_start_io_write(struct inode *inode);
 void ceph_end_io_write(struct inode *inode);
-void ceph_start_io_direct(struct inode *inode);
+__must_check int ceph_start_io_direct(struct inode *inode);
 void ceph_end_io_direct(struct inode *inode);
 
 #endif /* FS_CEPH_IO_H */
-- 
2.45.2



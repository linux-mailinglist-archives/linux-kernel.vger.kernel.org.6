Return-Path: <linux-kernel+bounces-417038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C72C9D4E25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9FEBB22BFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA731D89E3;
	Thu, 21 Nov 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="X4FqLt0r"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9F1D2F64
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732197240; cv=none; b=ijO+J4uKKGUjw6C/12yIrLpzuxtWZ00c2ibpIk4dbDTXl46EJZiAGZG25Hv3uJSFhzQBwDvFxAZzJFFFT13kI9pnOx0DMZQKgkrhcU8t+zmHrT12qfhknzBIHKvkj8frNPI5LaDRQ5fHN3l4yS2zs4Rp/N3wJNyF91CvR6oFkqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732197240; c=relaxed/simple;
	bh=y0/IGuvkvrL5BG8LKCqBwE8XTo+VVlZlf9uewaGMH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaP49XWnwaw4YsUTk9xVxSoPVicUu1VewctSDFj42SSKxUGBeP/2UmcaOawzoRjoSwCW7BzUhmGIKLzYY3zWiPdmIQilbkhqWgKgNgYwI5AwIKgtl1lm1ABO4xqNSuyh813Th4DATHzVj/H4GiTbs/MqSYuQ4rZtVefO3kEKdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=X4FqLt0r; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa1f73966a5so157467266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 05:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1732197236; x=1732802036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jl6e5D40Xi8ZKnUy8M68lwLmWTZ/IaWEGCI46p3eoW8=;
        b=X4FqLt0rRsqQv4F+I/5DOLrXZx37E8L5NldBY3+TFKfMcaKrU6wtiHZgDs81CtjMjr
         QIbGDg+DpxUvQrF+n5zPqvAek1hN0Sqs+2aWIaqdCqKJkcC89YwRVEF5S8T0tBnB1OEw
         lAb8qWrCmnPvToZ/eXj1N61STtLiNNFuML8UL1RoH9/s5dG55mY9myQZ1iA7UEKWWvMM
         Em/Kd8KzOvEhN3vJhA8K7dSllLPqvNjpIc0qU+VEvcV2Gi1rjLKY0gw7eCRSX4GgEkpc
         2PzZwIu0QZHMwbbxTIKi4pG7LdW7mWRngPe/6ory+ChejUs7IxYLl4cheVzs7MgtQWX4
         HUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732197236; x=1732802036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jl6e5D40Xi8ZKnUy8M68lwLmWTZ/IaWEGCI46p3eoW8=;
        b=ug4/N0mtpL5vxeHHyaPUWyIPd9KzddxEv+cq/xRCAgDG8XmE7o8793pBMRMlM4xCan
         BdprZkC1u8Zo7E5iQRq9x4G//vL5EJwmyzvC85Mji2wUozFA5g/QN43fKCDK66OhQAu7
         XEMGpNDd0jOtuiEy2YV9aK5crKRPXxfnYjGoVK7PWX3rp7BUHPQP5285emPOhh1nN1Y4
         zvGh4y2B4rWy/RCWQhSosZWoYTUInPcXPXirW0lBAP+JE4c8mOMmqP/Rm71l4ND+RuDU
         85AxKj/46ySF9PpjeKRq0aL/hOAm37kVUi0LpwqZ9QWvFPSd9agcPY0kYLAv7jvqj2Je
         /p5g==
X-Gm-Message-State: AOJu0YxJABCCiRHlnToNAO76N/BvLMeIovC5NKkacfNwynKWpkHuON/6
	vydIVyZZKRU6qrJhPUPlVFbZdEDM7deCkvt9xHPurSM7swP7i0FEke5kBVxmyovl4T3cxcVCMC3
	Z2+s=
X-Gm-Gg: ASbGncuLV5gh8zwMUe7+WkD5AFS2GwSa3O1O1FbstYG6RQqJfTML8Ec6tqE9wpsM+Lw
	AHIMyxwcAyiEZovFA5LK2Ktk5jJHq7ZDHy+IH931Ut38+p8y3O1oDtsGrNMCRmumT+rWicoCfb2
	hvDao620VrLB9A4pd84XePgqvzR/JSPJtrcbCp5oMrfh3vexPilmB/1RAFd4nXxNkmpc9qJQqEp
	nylfe3fZiEcuq+OPgYlkh5knzvjf5F+gSKHG8yy443s6ewduradiwgONXxpAVVwCix6RpgUzaAT
	7YPB5SBzvI5na1w9iPRmIe8cdjmCpomB/GM3wjrO/doqZT1XOg==
X-Google-Smtp-Source: AGHT+IFoAAbFshrZHtWe+t4PCem5jQ17Z3g+kEtTC10nHfI8uPR+Ni9ppuZtyWEiRFHX7Y7EgF6KVQ==
X-Received: by 2002:a17:907:dac:b0:a99:8a5c:a357 with SMTP id a640c23a62f3a-aa4dd766d81mr642437166b.58.1732197236288;
        Thu, 21 Nov 2024 05:53:56 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f12b600023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f12:b600:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4153111sm82890366b.15.2024.11.21.05.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 05:53:56 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-nfs@vger.kernel.org,
	trondmy@kernel.org,
	anna@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/nfs/io: make nfs_start_io_*() killable
Date: Thu, 21 Nov 2024 14:53:51 +0100
Message-ID: <20241121135351.1230969-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows killing processes that wait for a lock when one process is
stuck waiting for the NFS server.  This aims to complete the coverage
of NFS operations being killable, like nfs_direct_wait() does, for
example.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/nfs/direct.c   | 21 ++++++++++++++++++---
 fs/nfs/file.c     | 14 +++++++++++---
 fs/nfs/internal.h |  7 ++++---
 fs/nfs/io.c       | 44 +++++++++++++++++++++++++++++++++-----------
 4 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 90079ca134dd..b08dbe96bc57 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -454,8 +454,16 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 	if (user_backed_iter(iter))
 		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
 
-	if (!swap)
-		nfs_start_io_direct(inode);
+	if (!swap) {
+		result = nfs_start_io_direct(inode);
+		if (result) {
+			/* release the reference that would usually be
+			 * consumed by nfs_direct_read_schedule_iovec()
+			 */
+			nfs_direct_req_release(dreq);
+			goto out_release;
+		}
+	}
 
 	NFS_I(inode)->read_io += count;
 	requested = nfs_direct_read_schedule_iovec(dreq, iter, iocb->ki_pos);
@@ -1007,7 +1015,14 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
 							    FLUSH_STABLE);
 	} else {
-		nfs_start_io_direct(inode);
+		result = nfs_start_io_direct(inode);
+		if (result) {
+			/* release the reference that would usually be
+			 * consumed by nfs_direct_write_schedule_iovec()
+			 */
+			nfs_direct_req_release(dreq);
+			goto out_release;
+		}
 
 		requested = nfs_direct_write_schedule_iovec(dreq, iter, pos,
 							    FLUSH_COND_STABLE);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 6800ee92d742..1bb646752e46 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -166,7 +166,10 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 		iocb->ki_filp,
 		iov_iter_count(to), (unsigned long) iocb->ki_pos);
 
-	nfs_start_io_read(inode);
+	result = nfs_start_io_read(inode);
+	if (result)
+		return result;
+
 	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 	if (!result) {
 		result = generic_file_read_iter(iocb, to);
@@ -187,7 +190,10 @@ nfs_file_splice_read(struct file *in, loff_t *ppos, struct pipe_inode_info *pipe
 
 	dprintk("NFS: splice_read(%pD2, %zu@%llu)\n", in, len, *ppos);
 
-	nfs_start_io_read(inode);
+	result = nfs_start_io_read(inode);
+	if (result)
+		return result;
+
 	result = nfs_revalidate_mapping(inode, in->f_mapping);
 	if (!result) {
 		result = filemap_splice_read(in, ppos, pipe, len, flags);
@@ -668,7 +674,9 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	nfs_clear_invalid_mapping(file->f_mapping);
 
 	since = filemap_sample_wb_err(file->f_mapping);
-	nfs_start_io_write(inode);
+	error = nfs_start_io_write(inode);
+	if (error)
+		return error;
 	result = generic_write_checks(iocb, from);
 	if (result > 0)
 		result = generic_perform_write(iocb, from);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 430733e3eff2..f0c9c7f51e77 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -6,6 +6,7 @@
 #include "nfs4_fs.h"
 #include <linux/fs_context.h>
 #include <linux/security.h>
+#include <linux/compiler_attributes.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_page.h>
@@ -516,11 +517,11 @@ extern const struct netfs_request_ops nfs_netfs_ops;
 #endif
 
 /* io.c */
-extern void nfs_start_io_read(struct inode *inode);
+extern __must_check int nfs_start_io_read(struct inode *inode);
 extern void nfs_end_io_read(struct inode *inode);
-extern void nfs_start_io_write(struct inode *inode);
+extern  __must_check int nfs_start_io_write(struct inode *inode);
 extern void nfs_end_io_write(struct inode *inode);
-extern void nfs_start_io_direct(struct inode *inode);
+extern __must_check int nfs_start_io_direct(struct inode *inode);
 extern void nfs_end_io_direct(struct inode *inode);
 
 static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index b5551ed8f648..3388faf2acb9 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -39,19 +39,28 @@ static void nfs_block_o_direct(struct nfs_inode *nfsi, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
  */
-void
+int
 nfs_start_io_read(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int err;
+
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	nfs_block_o_direct(nfsi, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
@@ -74,11 +83,15 @@ nfs_end_io_read(struct inode *inode)
  * Declare that a buffered read operation is about to start, and ensure
  * that we block all direct I/O.
  */
-void
+int
 nfs_start_io_write(struct inode *inode)
 {
-	down_write(&inode->i_rwsem);
-	nfs_block_o_direct(NFS_I(inode), inode);
+	int err;
+
+	err = down_write_killable(&inode->i_rwsem);
+	if (!err)
+		nfs_block_o_direct(NFS_I(inode), inode);
+	return err;
 }
 
 /**
@@ -119,19 +132,28 @@ static void nfs_block_buffered(struct nfs_inode *nfsi, struct inode *inode)
  * Note that buffered writes and truncates both take a write lock on
  * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
  */
-void
+int
 nfs_start_io_direct(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int err;
+
 	/* Be an optimist! */
-	down_read(&inode->i_rwsem);
+	err = down_read_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags) != 0)
-		return;
+		return 0;
 	up_read(&inode->i_rwsem);
+
 	/* Slow path.... */
-	down_write(&inode->i_rwsem);
+	err = down_write_killable(&inode->i_rwsem);
+	if (err)
+		return err;
 	nfs_block_buffered(nfsi, inode);
 	downgrade_write(&inode->i_rwsem);
+
+	return 0;
 }
 
 /**
-- 
2.45.2



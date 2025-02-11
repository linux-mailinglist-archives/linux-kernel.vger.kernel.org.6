Return-Path: <linux-kernel+bounces-509999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C3DA3170E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064651888E12
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC2264F8D;
	Tue, 11 Feb 2025 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe1zODav"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A90264F82
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 21:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739307690; cv=none; b=XHbd7VApzO4xdZpIxplyyPi0kcmq524JYxbw64PwzPhiPH8IaHSSDznXtTfWGXeYmV2tNl6nMWBwm+Qhr+HkUaPNlwUDcStPUKHVwhuYkgUD5uICCdcVq3vRnhUU2OhlHT0MzB7+lOgd5zMOOVHVB/vKM4b27g7yJISiNpsK5ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739307690; c=relaxed/simple;
	bh=7ENrsxZCb1v/nR1J+z542z4RtAWTmp/RpcQGnsS6tmw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s71z28P6SghJVHR7gLQH72ZlciC+O3TT2CZdjtSpDPgkj0qqerOHlAZZUh6WscC99F/sxGCG+f/f02DKmh9ZLOlvzO4JFegtXxg3h3+//KBwq38HMHueUEuU4SKav9FnnnJacnpjbRblWhyl3WtojdFoMjXmUJfM+D+JP98Pv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe1zODav; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21517C4CEE2;
	Tue, 11 Feb 2025 21:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739307690;
	bh=7ENrsxZCb1v/nR1J+z542z4RtAWTmp/RpcQGnsS6tmw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=oe1zODavpuNX9trvjHkWuqrqnrKA9JeckKnVHt5ZuVsgyl/qmIDTM9Ld0f7kcC/6x
	 +nf3sYBLbu7nG8S8iPwyT3LMU7BaX2Fbmtzopl2nRvrxOh6Qg8GA6yIrytpnVkEyCo
	 ++eZcRD1mZQArOlxmcziL8W5MTdC2fTMHKzr0l3DMbrWxAjfKV9KkdLiK3VOqdR0DM
	 gRZkMwYvRkUiPNFxo0KY+Th2lsF8gGRv8ZyzYtFNUzAF3n4Ef3FLFiR2iDubtVBRL2
	 QON4aKUcOtDQk7Vpp6nXyl+am9uNyMOG2YDG/qfITJnWPR9dCmyKJEVosouc3oniB5
	 M32cRHims25zw==
Date: Tue, 11 Feb 2025 21:01:28 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: add ioctl to get IO priority hint
Message-ID: <Z6u6qN2ATQKlfmRQ@google.com>
References: <20250205214014.3270585-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205214014.3270585-1-jaegeuk@kernel.org>

This patch adds an ioctl to give a per-file priority hint to attach
REQ_PRIO.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c            |  6 ++++++
 fs/f2fs/f2fs.h            |  1 +
 fs/f2fs/file.c            | 20 ++++++++++++++++++++
 include/uapi/linux/f2fs.h |  7 +++++++
 4 files changed, 34 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 07b46b444d31..24c5cb1f5ada 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -413,6 +413,7 @@ int f2fs_target_device_index(struct f2fs_sb_info *sbi, block_t blkaddr)
 static blk_opf_t f2fs_io_flags(struct f2fs_io_info *fio)
 {
 	unsigned int temp_mask = GENMASK(NR_TEMP_TYPE - 1, 0);
+	struct folio *fio_folio = page_folio(fio->page);
 	unsigned int fua_flag, meta_flag, io_flag;
 	blk_opf_t op_flags = 0;
 
@@ -438,6 +439,11 @@ static blk_opf_t f2fs_io_flags(struct f2fs_io_info *fio)
 		op_flags |= REQ_META;
 	if (BIT(fio->temp) & fua_flag)
 		op_flags |= REQ_FUA;
+
+	if (fio->type == DATA &&
+	    F2FS_I(fio_folio->mapping->host)->ioprio_hint == F2FS_IOPRIO_WRITE)
+		op_flags |= REQ_PRIO;
+
 	return op_flags;
 }
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 493dda2d4b66..395f9d37449c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -830,6 +830,7 @@ struct f2fs_inode_info {
 
 	/* Use below internally in f2fs*/
 	unsigned long flags[BITS_TO_LONGS(FI_MAX)];	/* use to pass per-file flags */
+	unsigned int ioprio_hint;	/* hint for IO priority */
 	struct f2fs_rwsem i_sem;	/* protect fi info */
 	atomic_t dirty_pages;		/* # of dirty pages */
 	f2fs_hash_t chash;		/* hash value of given file name */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f92a9fba9991..a92c347841e6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3446,6 +3446,23 @@ static int f2fs_ioc_get_dev_alias_file(struct file *filp, unsigned long arg)
 			(u32 __user *)arg);
 }
 
+static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	__u32 level;
+
+	if (get_user(level, (__u32 __user *)arg))
+		return -EFAULT;
+
+	if (!S_ISREG(inode->i_mode) || level >= F2FS_IOPRIO_MAX)
+		return -EINVAL;
+
+	inode_lock(inode);
+	F2FS_I(inode)->ioprio_hint = level;
+	inode_unlock(inode);
+	return 0;
+}
+
 int f2fs_precache_extents(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
@@ -4547,6 +4564,8 @@ static long __f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return f2fs_ioc_compress_file(filp);
 	case F2FS_IOC_GET_DEV_ALIAS_FILE:
 		return f2fs_ioc_get_dev_alias_file(filp, arg);
+	case F2FS_IOC_IO_PRIO:
+		return f2fs_ioc_io_prio(filp, arg);
 	default:
 		return -ENOTTY;
 	}
@@ -5261,6 +5280,7 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case F2FS_IOC_DECOMPRESS_FILE:
 	case F2FS_IOC_COMPRESS_FILE:
 	case F2FS_IOC_GET_DEV_ALIAS_FILE:
+	case F2FS_IOC_IO_PRIO:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/include/uapi/linux/f2fs.h b/include/uapi/linux/f2fs.h
index f7aaf8d23e20..795e26258355 100644
--- a/include/uapi/linux/f2fs.h
+++ b/include/uapi/linux/f2fs.h
@@ -44,6 +44,7 @@
 #define F2FS_IOC_COMPRESS_FILE		_IO(F2FS_IOCTL_MAGIC, 24)
 #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
+#define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
 
 /*
  * should be same as XFS_IOC_GOINGDOWN.
@@ -63,6 +64,12 @@
 #define F2FS_TRIM_FILE_ZEROOUT		0x2	/* zero out */
 #define F2FS_TRIM_FILE_MASK		0x3
 
+/* for F2FS_IOC_IO_PRIO */
+enum {
+	F2FS_IOPRIO_WRITE = 1,	/* high write priority */
+	F2FS_IOPRIO_MAX,
+};
+
 struct f2fs_gc_range {
 	__u32 sync;
 	__u64 start;
-- 
2.48.1.601.g30ceb7b040-goog



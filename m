Return-Path: <linux-kernel+bounces-443149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF7E9EE7FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C5E18862E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 13:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C722144A8;
	Thu, 12 Dec 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pIuiuqqt"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3A28460
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 13:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011033; cv=none; b=J59i2V7xBZZg/67OVf1T9nMbRq3KnvfJ8SHmZ6dGv5eb1I+EJxiRFe6lQYURq0UxFFIhFjplvGxsjXM0trZvL4vJe3MaCcYlSz6xQNJ9saAxU+4ZmOz3KkTlGCIirRYpjeBD4hl8GHClSaW5PbOT1oKQbxDANHdX68IVinhusjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011033; c=relaxed/simple;
	bh=bhwFsAWTkYwPUT+AE/dP9JYMqw0+4K0gJEKTgtUqRLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2kErIH8l3bUMPwtq5D62q/ZVZhmP/WScULO9Xb18707SFI1gjnqUcS3J45G97b7JvLCFE5vUgrx893d5y3c1JCqpPOlRUiOo7/+OQDXagkIfiKbtCet8h3z34qFiNAYAImvBbU20mrgPozA/3OiIWFH0XhdWUxTXFN02dgWidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pIuiuqqt; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734011019; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6naHwaCsUzRRNGtTClLj5a9Gefm78mstPRD0+584zy8=;
	b=pIuiuqqtcUi6X9aIvfw4hMfE/rDpwZph2CI66IIjm7G4V++uLv2AbQmLhPeG+fSzXAFBDSrEjlTJSTS9wFcnX7Z0iMwEkUqI9Sv93WPk7VbKsj6PDtNPR7DjY3tkyGXazx52vJOvwujX/mTKFqJjMCqZtgWuiqM3bMIzB3pw6i4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLLqyiw_1734011018 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Dec 2024 21:43:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Derek McGowan <derek@mcg.dev>
Subject: [PATCH v2 4/4] erofs: use buffered I/O for file-backed mounts by default
Date: Thu, 12 Dec 2024 21:43:36 +0800
Message-ID: <20241212134336.2059899-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212133504.2047178-4-hsiangkao@linux.alibaba.com>
References: <20241212133504.2047178-4-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For many use cases (e.g. container images are just fetched from remote),
performance will be impacted if underlay page cache is up-to-date but
direct i/o flushes dirty pages first.

Instead, let's use buffered I/O by default to keep in sync with loop
devices and add a (re)mount option to explicitly enable direct I/O
if supported by the underlying files.

The container startup time is improved as below:
                                     unpack        1st run  non-1st runs
EROFS snapshotter buffered I/O file  4.586404265s  0.308s   0.198s
EROFS snapshotter direct I/O file    4.581742849s  2.238s   0.222s
EROFS snapshotter loop               4.596023152s  0.346s   0.201s
Overlayfs snapshotter                5.382851037s  0.206s   0.214s

Fixes: fb176750266a ("erofs: add file-backed mount support")
Cc: Derek McGowan <derek@mcg.dev>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20241212133504.2047178-4-hsiangkao@linux.alibaba.com
changes since v1 (obsoleted version by mistake):
 - refine commit message;
 - add `directio` in erofs_show_options() too.

 fs/erofs/fileio.c   |  7 +++++--
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 23 +++++++++++++++--------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index a61b8faec651..33f8539dda4a 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -9,6 +9,7 @@ struct erofs_fileio_rq {
 	struct bio_vec bvecs[BIO_MAX_VECS];
 	struct bio bio;
 	struct kiocb iocb;
+	struct super_block *sb;
 };
 
 struct erofs_fileio {
@@ -52,8 +53,9 @@ static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
 	rq->iocb.ki_ioprio = get_current_ioprio();
 	rq->iocb.ki_complete = erofs_fileio_ki_complete;
-	rq->iocb.ki_flags = (rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT) ?
-				IOCB_DIRECT : 0;
+	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
+	    rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT)
+		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
 		      rq->bio.bi_iter.bi_size);
 	ret = vfs_iocb_iter_read(rq->iocb.ki_filp, &rq->iocb, &iter);
@@ -68,6 +70,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 
 	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
 	rq->iocb.ki_filp = mdev->m_dif->file;
+	rq->sb = mdev->m_sb;
 	return rq;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 59e7739b7c3b..bc46000ccc6b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -177,6 +177,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
+#define EROFS_MOUNT_DIRECT_IO		0x00000100
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9044907354e1..f5956474bfde 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -364,14 +364,8 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 }
 
 enum {
-	Opt_user_xattr,
-	Opt_acl,
-	Opt_cache_strategy,
-	Opt_dax,
-	Opt_dax_enum,
-	Opt_device,
-	Opt_fsid,
-	Opt_domain_id,
+	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
 	Opt_err
 };
 
@@ -398,6 +392,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("device",	Opt_device),
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
+	fsparam_flag_no("directio",	Opt_directio),
 	{}
 };
 
@@ -511,6 +506,16 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 		break;
 #endif
+	case Opt_directio:
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+		if (result.boolean)
+			set_opt(&sbi->opt, DIRECT_IO);
+		else
+			clear_opt(&sbi->opt, DIRECT_IO);
+#else
+		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
+#endif
+		break;
 	default:
 		return -ENOPARAM;
 	}
@@ -948,6 +953,8 @@ static int erofs_show_options(struct seq_file *seq, struct dentry *root)
 		seq_puts(seq, ",dax=always");
 	if (test_opt(opt, DAX_NEVER))
 		seq_puts(seq, ",dax=never");
+	if (erofs_is_fileio_mode(sbi) && test_opt(opt, DIRECT_IO))
+		seq_puts(seq, ",directio");
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 	if (sbi->fsid)
 		seq_printf(seq, ",fsid=%s", sbi->fsid);
-- 
2.43.5



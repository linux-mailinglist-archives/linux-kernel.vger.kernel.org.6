Return-Path: <linux-kernel+bounces-447347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1F9F30F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50A61887C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2031205AA5;
	Mon, 16 Dec 2024 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="voJYOEmR"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF7F204F90
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734353606; cv=none; b=uVeqt5gotLiP2MKuizkmKVe5epLKFNPqrpAkKUh4C5U6xN5omSgw74HdktVkE3uxnwwg7aitKq9+bBHO/CqRHRW/z8LBFUfknnZRHxL80IlEzzw+ocpJVYmSNkAPzlTgD1HzZpPW1xiiCBI66mPEz17eHX9FhAB1Qftrw02xggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734353606; c=relaxed/simple;
	bh=rFL0bHQ3T/8sv2jURr5KkxOfCBP/VxW1tY9fq7HeyiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PBnGMVdd+PZPmLMkLQzwztbAJ+HXZEijGiAf5shtPD4IFEitzYG4N/LLxP3XyiObpxUg2Cl4/c7A4BPYuG/yEi24PKzUMX4YUMFO0BTHSbpIM9m5fWwURxIQnDZ4LYQ6RkVb+MgBT2cYddlYyerWfj2XQ4FPPRsNyD7FAwbhRGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=voJYOEmR; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734353600; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=O+t8H2XJafDbltXMzJkoJcKKsEcat/SyJLn+cTobu2c=;
	b=voJYOEmRTv+/ynCmOhPTnyuYbB1p2swXw2ejXgrDcBMIzhn0sHeUbsYysmhnw7umc8wlRBSydT/PcHpC6MiEViVKmk+YSijmlYmA0C8GtoXgDB7efWQuh1/BiLOJH5iHXOFMhV/0/vpjmJxDbmYF82GlZn+PZ+Jp7pzL9z+vCRo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLcksMJ_1734353599 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Dec 2024 20:53:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Derek McGowan <derek@mcg.dev>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 4/4] erofs: use buffered I/O for file-backed mounts by default
Date: Mon, 16 Dec 2024 20:53:10 +0800
Message-ID: <20241216125310.930933-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
References: <20241216125310.930933-1-hsiangkao@linux.alibaba.com>
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
devices and add a (re)mount option to explicitly give a try to use
direct I/O if supported by the underlying files.

The container startup time is improved as below:
[workload] docker.io/library/workpress:latest
                                     unpack        1st run  non-1st runs
EROFS snapshotter buffered I/O file  4.586404265s  0.308s   0.198s
EROFS snapshotter direct I/O file    4.581742849s  2.238s   0.222s
EROFS snapshotter loop               4.596023152s  0.346s   0.201s
Overlayfs snapshotter                5.382851037s  0.206s   0.214s

Fixes: fb176750266a ("erofs: add file-backed mount support")
Cc: Derek McGowan <derek@mcg.dev>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
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
index 7cc8e1be04e8..686d835eb533 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -176,6 +176,7 @@ struct erofs_sb_info {
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



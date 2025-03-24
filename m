Return-Path: <linux-kernel+bounces-573102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26436A6D310
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 03:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB3F3AAAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 02:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F013957E;
	Mon, 24 Mar 2025 02:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYT9O55F"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED27EEB5
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 02:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742783395; cv=none; b=TYgH+WTUYB6Jn6HmpLs5Mchzy+hY0OU0OOJfPC+6QAhaK/jbpssPB95klh7jMx5TnePRCs7+rd/csvOzOg7QiuMWFkgiqsv/5GUWkvpGV7oGuFlDaz5qPQlX/ryXiX/HhScFfMI5cWZtq3eKRECqEHDTpN+jkNsG3yh249sAznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742783395; c=relaxed/simple;
	bh=GXEaD+U08kj7fI3LezB+FneE7EtWigYl9XbMdzjtFvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CelcjpEDn7GflqxCXqRS/xvoAS8jBAWC/MOu1WcXzjic/8sT5qxaRuRFUbU4jTP+r9h6MJVUEtwGV6qFWuyysz+c5DQgJ19cYpvuoDdG++OHb6xw0kIlfl7b4GLctMS3Sx2X2LwlWkNdxzN59aRS2Bm2m5dwmz/OyEW9Q+cX8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYT9O55F; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3014678689aso5254745a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 19:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742783393; x=1743388193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yaM6n2XXYLmZ8n5d/I+4nSqBl3pbvcVcH3xid2ni5xk=;
        b=iYT9O55F7IQo7J4PMegfdkkj/uRMuldCrPx6UTa76NjVm97vhT4Q2VqtcFSmQ46vR2
         A9yQUHfA7SF+bZL0MDcvWcDVn2d8dhZ03jSQmwQzGcO+vvajMK7PMwzret5fh03aMj2u
         Ul7eubVmR42e1QQmSPyVHcgiNHMR91Qm5LlITDbCadeUodC/HteLlNMLYpO1qYBBSkqg
         7kLwFox8LVVruWml8kYP4T21dIMJGFZO5CK7YgX6VjBTvLoOmHdM4M9wG1LqStdpQvya
         Nc3uHw0dinyDKEC6ECPhFpZeEWTO9Z2vBIN34xkomYise9jdIMxF90ewnKqwjcksccvE
         K6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742783393; x=1743388193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaM6n2XXYLmZ8n5d/I+4nSqBl3pbvcVcH3xid2ni5xk=;
        b=ntk0Wf/2QOyfdXqSCkSfAxR3doDEzjJp6TmD7CvzKDBx7y+0Wu22uNKhNh5kJ0g8Me
         xRfCVNCDW+sh3Ibs27xmL+P9XCdb834s7vL7CylNhJi8bsCXgZLm6o+AEu1Wt4pru5AJ
         BLd9UIw8bwdrq5/wg0QEPLt4NmQw/G5dE9dNmoRyicKxe1xNqCuirHh7ugB7fCt1Zfpy
         905e9rzQ+bQ7f7PyMDJ3aumpymX2tgkBX7XCQPto+/f8cuEwJ4h5g/jphEl4YJ4fpBy0
         85zbV58ZONW58X8UTr9Fi/o5PNxr5OxKH0VGpaB+C4ZRJan5U3diIBq5wXgnroTdi8cp
         cXcQ==
X-Gm-Message-State: AOJu0YzHregxuw+kCcMxiHGfu22oaHAELvxsFEyg65rG3OESFC13yelD
	oYhY0f9YGcZn9bh2VvE/cI66zZCQROe3nVK/JJ3zOWN/lFEC7JiG
X-Gm-Gg: ASbGncuo4aXVD+CgBr32I1l5rbdH5gjwB2wf/ke+CBbo6JNanIWU2uus8rXy3+DzlzJ
	Eexo3GmxaIQqDZdmbzsVponQdYA+C+rNCwDVKw+bWVoWNFBIskUE81kuFOvFP+RYhYolHFS7Miw
	xMPboINPb9hfKUM5Shfyl55FgdSQS3MLukrRSTsfMvHj5IokT/sdZhIMwZ5uKJ56yYqCn44NXZs
	vP7eV8VQ+1ObZbXdT3cAYI+oj8Ty4EF0ZIEPk9hKafaPxWJH7tlf9qfqYea+phx0GPkT5aQdL9E
	OXiBD2Dd8gF/16dCWoXahUpkMP0TqMoJnhyKWURpfyhszWAoQ3k=
X-Google-Smtp-Source: AGHT+IEAXpsiG5tbfaOZ8P/dnIoqp2v4G8Rmy4yiyC0YGAtvYj/KSf22X/DmKW0gENF2r0rPNv2AAQ==
X-Received: by 2002:a17:90b:1d51:b0:2ee:e518:c1d8 with SMTP id 98e67ed59e1d1-3030ff046d7mr17532828a91.30.1742783393114;
        Sun, 23 Mar 2025 19:29:53 -0700 (PDT)
Received: from PC.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f807037sm6735538a91.41.2025.03.23.19.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 19:29:52 -0700 (PDT)
From: Sheng Yong <shengyong2021@gmail.com>
X-Google-Original-From: Sheng Yong <shengyong1@xiaomi.com>
To: xiang@kernel.org,
	chao@kernel.org,
	zbestahu@gmail.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong1@xiaomi.com>,
	Wang Shuai <wangshuai12@xiaomi.com>
Subject: [RFC PATCH] erofs: add start offset for file-backed mount
Date: Mon, 24 Mar 2025 10:28:49 +0800
Message-ID: <20250324022849.2715578-1-shengyong1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sheng Yong <shengyong1@xiaomi.com>

When attempting to use an archive file, such as APEX on android,
as a file-backed mount source, it fails because EROFS image within
the archive file does not start at offset 0. As a result, a loop
device is still needed to attach the image file at an appropriate
offset first.

To address this issue, this patch parses the `source' parameter in
EROFS to accept a start offset for the file-backed mount. The format
is `/path/to/archive_file:offs', where `offs' represents the start
offset. EROFS will add this offset before performing read requests.

Signed-off-by: Sheng Yong <shengyong1@xiaomi.com>
Signed-off-by: Wang Shuai <wangshuai12@xiaomi.com>
---
 fs/erofs/data.c     |  7 ++++++-
 fs/erofs/fileio.c   |  8 ++++++--
 fs/erofs/internal.h |  2 ++
 fs/erofs/super.c    | 37 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 2409d2ab0c28..957743201ef5 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -27,9 +27,12 @@ void erofs_put_metabuf(struct erofs_buf *buf)
 
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
-	pgoff_t index = offset >> PAGE_SHIFT;
+	pgoff_t index;
 	struct folio *folio = NULL;
 
+	offset += buf->fofs;
+	index = offset >> PAGE_SHIFT;
+
 	if (buf->page) {
 		folio = page_folio(buf->page);
 		if (folio_file_page(folio, index) != buf->page)
@@ -54,9 +57,11 @@ void erofs_init_metabuf(struct erofs_buf *buf, struct super_block *sb)
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 
 	buf->file = NULL;
+	buf->fofs = 0;
 	if (erofs_is_fileio_mode(sbi)) {
 		buf->file = sbi->dif0.file;	/* some fs like FUSE needs it */
 		buf->mapping = buf->file->f_mapping;
+		buf->fofs = sbi->dif0.fofs;
 	} else if (erofs_is_fscache_mode(sb))
 		buf->mapping = sbi->dif0.fscache->inode->i_mapping;
 	else
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index bec4b56b3826..62288ef19920 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -45,15 +45,19 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 
 static void erofs_fileio_rq_submit(struct erofs_fileio_rq *rq)
 {
+	struct erofs_sb_info *sbi;
 	struct iov_iter iter;
 	int ret;
 
 	if (!rq)
 		return;
-	rq->iocb.ki_pos = rq->bio.bi_iter.bi_sector << SECTOR_SHIFT;
+
+	sbi = EROFS_SB(rq->sb);
+	rq->iocb.ki_pos = sbi->dif0.fofs +
+				(rq->bio.bi_iter.bi_sector << SECTOR_SHIFT);
 	rq->iocb.ki_ioprio = get_current_ioprio();
 	rq->iocb.ki_complete = erofs_fileio_ki_complete;
-	if (test_opt(&EROFS_SB(rq->sb)->opt, DIRECT_IO) &&
+	if (test_opt(&sbi->opt, DIRECT_IO) &&
 	    rq->iocb.ki_filp->f_mode & FMODE_CAN_ODIRECT)
 		rq->iocb.ki_flags = IOCB_DIRECT;
 	iov_iter_bvec(&iter, ITER_DEST, rq->bvecs, rq->bio.bi_vcnt,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ac188d5d894..b0a752b955f6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -43,6 +43,7 @@ struct erofs_device_info {
 	char *path;
 	struct erofs_fscache *fscache;
 	struct file *file;
+	loff_t fofs;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
 
@@ -199,6 +200,7 @@ enum {
 struct erofs_buf {
 	struct address_space *mapping;
 	struct file *file;
+	loff_t fofs;
 	struct page *page;
 	void *base;
 };
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index cadec6b1b554..87ddeb327a8a 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -356,7 +356,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
-	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio,
+	Opt_device, Opt_fsid, Opt_domain_id, Opt_directio, Opt_source,
 	Opt_err
 };
 
@@ -384,6 +384,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_string("fsid",		Opt_fsid),
 	fsparam_string("domain_id",	Opt_domain_id),
 	fsparam_flag_no("directio",	Opt_directio),
+	fsparam_string("source",	Opt_source),
 	{}
 };
 
@@ -411,6 +412,31 @@ static bool erofs_fc_set_dax_mode(struct fs_context *fc, unsigned int mode)
 #endif
 }
 
+static loff_t erofs_fc_parse_source(struct fs_context *fc,
+				    struct fs_parameter *param)
+{
+	const char *devname = param->string;
+	const char *fofs_start __maybe_unused;
+	loff_t fofs = 0;
+
+	if (!devname || !*devname)
+		return invalfc(fc, "Empty source");
+
+#ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
+	fofs_start = strchr(devname, ':');
+	if (!fofs_start)
+		goto out;
+	if (kstrtoll(fofs_start + 1, 0, &fofs) < 0)
+		return invalfc(fc, "Invalid filebacked offset %s", fofs_start);
+	fc->source = kstrndup(devname, fofs_start - devname, GFP_KERNEL);
+	return fofs;
+out:
+#endif
+	fc->source = devname;
+	param->string = NULL;
+	return fofs;
+}
+
 static int erofs_fc_parse_param(struct fs_context *fc,
 				struct fs_parameter *param)
 {
@@ -507,6 +533,11 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		errorfc(fc, "%s option not supported", erofs_fs_parameters[opt].name);
 #endif
 		break;
+	case Opt_source:
+		sbi->dif0.fofs = erofs_fc_parse_source(fc, param);
+		if (sbi->dif0.fofs < 0)
+			return -EINVAL;
+		break;
 	}
 	return 0;
 }
@@ -697,6 +728,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		file = filp_open(fc->source, O_RDONLY | O_LARGEFILE, 0);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
+		if (sbi->dif0.fofs + PAGE_SIZE >= i_size_read(file_inode(file))) {
+			fput(file);
+			return invalf(fc, "Start offset too large");
+		}
 		sbi->dif0.file = file;
 
 		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-- 
2.43.0



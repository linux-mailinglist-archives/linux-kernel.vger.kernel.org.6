Return-Path: <linux-kernel+bounces-551316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB724A56AFB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5C6D3A88D7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCA821ABB5;
	Fri,  7 Mar 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJNJx59J"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D5B16EB4C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741359430; cv=none; b=a+nAre4dy5XEWrQ5PLl7+8C8yAlwZx9mDw8mVNkK1mBIM+ts7ad/6gChfQ6qFZvQz4dogu5kDvHgl/PGClIffOLR94sOK1xlCcf2r1+pOCSnSRTvXQmHwrVkNrfmU98ZZaRniKmlyTURFLGyEfbJ3uI2y6OagxGlIpd9eajbMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741359430; c=relaxed/simple;
	bh=CWOvPrUsWNSjxJGBCOQBGM3Ykx2mN7P2Ou6ShM8wu48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZpCGbCtpqwIXaKsyDFMeyAY83rIKEOm4enPk9KsIk9x7NIHb/zWAP5mBWI4v6paCsVZaUqQ9kOA1mEW31Fb/u8li4QK1TY92AK+TJ5uxy2dnPLrrqHC+diD1tqJpoQT+lt5ZVFPOqSexmIqMNgV0PG9wGLf76mZ0MxuYK3QO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJNJx59J; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feb96064e4so4033085a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 06:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741359428; x=1741964228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3/1TblqPLns6jPBBvXv/kgUjFkYTE2ZlCuQ4AlF1Mc=;
        b=aJNJx59JMhsU/b1ZPrJKOwu4ZCsWizhJzesXZheBfauwT15Tyh8sMy8dz2bLUg5SPP
         jps69ysVwyBLfrE2gxDRI+hffIUvDUmFgk/L+eNwrfuG40O+9FPSgaiFbIZH7Y5hZfW3
         1eRZIN8z0JwrIOVYBfMxkAwRR4tb4tQ8ljdlk5fbViW5fS/i96a+KVBW3dss7NMmTJuW
         Yn5cDwqYPNYyVrsAb1+gC/y+O1/m6yFwo+/lK7TmNco8suId6RRKm1jI3KtTGCPOa+8m
         KT3+HILcxTyJqzDe0wfBNECOU8ZUnY7CYt1LA6eDYGmxaNYRNU5KSs+p7q3Yn9UtaH4H
         RCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741359428; x=1741964228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3/1TblqPLns6jPBBvXv/kgUjFkYTE2ZlCuQ4AlF1Mc=;
        b=SsGFegsGr3NCb1C2nysPXbGbIPZ5n3SzB8qlwruFUzcTnaX8QBxDWlSu7w7dML51bh
         Zz2awbSH+F46a0FsdKl8O8lkFjZg8Prb65qJy6jXrz1Xf/wv4SozJzSVgbH40bIETKby
         gHQ4lmPv+4Gye7fr8CzURSXKCvRVoT2LPoI9X7+kHUsPKA9fqyt+FAv+6UHtUsrQu1fB
         N05qElf9EGgJWCCMBYpfUEDDEEE0VG+AkUNwp9HvaZwEebsK92mN14d+rMMC9iZBck0o
         TNBGMJ3sii9H68lRMz99eb2GZuV0G7v7vt2MO7T/SW69n8HNiKcKa4m13ZruF675OCar
         O8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVNvpmebk/NoD/pS7zb2WskTG6fmbK7xU4kI3EezIlOeeMOvHdolqoV8jp5AS+fW/f6BcvcQW6pcqFMxgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPJCUoduFCwdct6FcBvv8xehz6AmagoC/qLBfhwxNt2x52eOWj
	zNs9xN1tF7n7cOYca1KlI1cv18X831DbcKMX3es9Ya7zl5pSjCt3
X-Gm-Gg: ASbGncsVuOH/rwZCMMhf6npqnWWaSGz+CA+C7NB6PwTVG9WQnpo3jCQimtvYOI4HXpX
	E518/+nXwACpeC2BSsdqVRTuLknZ2RSqsYGoFOIzGviNDdfAbN9BQSCs+aURKvbGLY8LudBHsbu
	9kz3ebO7KtzXM0YycunMaQpfQyjFWoRwyqDJZVag9x4iS/BZuXHOHQjaWITseJDtq6UNR0QmO0i
	bvR2ltTBJhBoVx4nwoEUNzQjGjWnHNcOXDJ6yilGNASRMBRlDEILc8sExxCnh0gxLhEfDTeev7w
	SOhaZKhxIkQL9pdfvHX+gtTmyZzQ54oCUZcIJhdTAb/whnnRijUSVvEQT+Q+v4rV5fPvaRp12Q=
	=
X-Google-Smtp-Source: AGHT+IGBMkybK8LNpELvScIet/VbiDV1S6TPQmThy3Vq2qoHJxC3y1ofM+O+wkhBnBKHMhYfwdPVwQ==
X-Received: by 2002:a17:90b:35cd:b0:2ff:6608:78cd with SMTP id 98e67ed59e1d1-2ff7ce632a3mr6394441a91.9.1741359427882;
        Fri, 07 Mar 2025 06:57:07 -0800 (PST)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff6935339dsm3118754a91.15.2025.03.07.06.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 06:57:07 -0800 (PST)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH] f2fs: optimize f2fs DIO overwrites
Date: Fri,  7 Mar 2025 23:56:50 +0900
Message-Id: <20250307145650.568-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

this is unnecessary when we know we are overwriting already allocated
blocks and the overhead of starting a transaction can be significant
especially for multithreaded workloads doing small writes.

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 fs/f2fs/data.c | 20 ++++++++++++++++++++
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c |  5 ++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 09437dbd1b42..728630037b74 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4267,6 +4267,26 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	return 0;
 }
 
+static int f2fs_iomap_overwrite_begin(struct inode *inode, loff_t offset,
+		loff_t length, unsigned flags, struct iomap *iomap,
+		struct iomap *srcmap)
+{
+	int ret;
+
+	/*
+	 * Even for writes we don't need to allocate blocks, so just pretend
+	 * we are reading to save overhead of starting a transaction.
+	 */
+	flags &= ~IOMAP_WRITE;
+	ret = f2fs_iomap_begin(inode, offset, length, flags, iomap, srcmap);
+	WARN_ON_ONCE(!ret && iomap->type != IOMAP_MAPPED);
+	return ret;
+}
+
 const struct iomap_ops f2fs_iomap_ops = {
 	.iomap_begin	= f2fs_iomap_begin,
 };
+
+const struct iomap_ops f2fs_iomap_overwrite_ops = {
+	.iomap_begin	= f2fs_iomap_overwrite_begin,
+};
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c6cc2694f9ac..0511ab5ed42a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3936,6 +3936,7 @@ void f2fs_destroy_post_read_processing(void);
 int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
 void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
 extern const struct iomap_ops f2fs_iomap_ops;
+extern const struct iomap_ops f2fs_iomap_overwrite_ops;
 
 static inline struct page *f2fs_find_data_page(struct inode *inode,
 		pgoff_t index, pgoff_t *next_pgofs)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 82b21baf5628..bb2fe6dac9b6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4985,6 +4985,7 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	const ssize_t count = iov_iter_count(from);
 	unsigned int dio_flags;
 	struct iomap_dio *dio;
+	const struct iomap_ops *iomap_ops = &f2fs_iomap_ops;
 	ssize_t ret;
 
 	trace_f2fs_direct_IO_enter(inode, iocb, count, WRITE);
@@ -5025,7 +5026,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 	dio_flags = 0;
 	if (pos + count > inode->i_size)
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
-	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
+	else if (f2fs_overwrite_io(inode, pos, count))
+		iomap_ops = &f2fs_iomap_overwrite_ops;
+	dio = __iomap_dio_rw(iocb, from, iomap_ops,
 			     &f2fs_iomap_dio_write_ops, dio_flags, NULL, 0);
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
-- 
2.25.1



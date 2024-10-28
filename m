Return-Path: <linux-kernel+bounces-385793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641099B3BCC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 21:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B13283335
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 20:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD191EF959;
	Mon, 28 Oct 2024 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqrAKezK"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D11EE008
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147225; cv=none; b=gZd6x/bNBl6CtcduBQRclIwJls1l1Zh7UEZA8uPPwuHAX/42GEMAFX0Vzlx8V/3maysHcHaiXFODMkdhuU3ybJUfQh7e3AspYMLHBNqH7uw7Efc+YNXiahpCfQYNGWyK2lmUVaS5f++gcWBJEnAdn1I3KgbzRbGNd6qqAS+ia2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147225; c=relaxed/simple;
	bh=grKYEo6iybmanQhvP3Ncwdm0/OcpoiFKxZjBAs3B7rI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HfWZ3Owq2iW+zA97UqA1uFERZOR40vatlIVoCEJ9GRVnIYHMJu9MdF+7TIFOcXPM4QAE20DkHzvE9iwKQSFqaR6Q3eT50/N5o1NE1QJA9usan9mRYaNWubr450hyn5gpkbm0Q0GHGx+AjdRkrYW3s5nb3R2Qsbmsw5CVWmg3An8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqrAKezK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea6a4f287bso2975568a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730147223; x=1730752023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=au+hdzlr4oRvtnZHdEt21Y5mJ+6YTQcAGrv1YEkDWZw=;
        b=OqrAKezKxXcTQV2uZG9/tUPmaXWoFfQ+3Ctex0+35P0IC05BBS91nWBSRXv36rObpR
         qG19cDYK0hhjfNzRlOkAMdTUZw3A3O1ViNpeIH4FWll6p2XG9yTxg1QPqpd5HnWAbMoP
         Wl15PdEZ8FeWIl8ieEV0kjc0KvrKPvbygxk6+7zq6p2WOWr5SAa5p7pYRDg8w9fhOSxI
         2VO27/4N9kcMXJd7OeJBRBKsfJAIemJo32ToIjeFTOR+7eIn+b7as3vbhOU27Xp44ByZ
         MnxnJKk8uyphr7xHH3TMA7yxEfh5A3sWAvxc1zi9hwQRfWyzodTHW8VlwKDF4BpdqlZs
         sQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730147223; x=1730752023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au+hdzlr4oRvtnZHdEt21Y5mJ+6YTQcAGrv1YEkDWZw=;
        b=ajUzbzFzZU3wd0ZJ2sZnua5eJ4RQJt/qlkIFMTfVmC7jnQ5wHnBOd/+WpCdUR90WtN
         nKG+doWuTWZdB8WpDHGzAYP1Nb8mjjnWkd0EGgont4LZNOfwH02IAfLM0L/v27h/eMS6
         bbaESiNmnPr9/licMfeaT9mXN31mlMxYFdqFsSLu5PCBW1eDsCxa/vluGBKxD+DsC5XY
         z633WgK/uCjGpEUJ76PXgcBirtI4mzwMPs5Lp1uQr7Znfq7bhz2aLrFuJ3LIqgl2e7Ti
         oygy/qxRY9V0hy1Dv9FZdHMVOZppF7o7+TM9b39f3UlcJ4/xJ8ljC8C4M5I5TM8zK6Z/
         t4zg==
X-Forwarded-Encrypted: i=1; AJvYcCUnOtd35q/pdZTDBgeH4MpBXZDGgAKoOjKa7gvzJ0tAbu/bequ6uLdmS0LVeYlFcZWVcy+qY66T69FGhDs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzuz7u+k8sfwB/1/9SOhVYetoAu5GF/3Pg1Bt55LJthboroSTl
	d4sfqN3KBEF4tZGjHXy7awQtNlvxnScvRcGWnxIvFu6Kd1DELc4xv32xQP1TnY8=
X-Google-Smtp-Source: AGHT+IEjV1A8lDwhxVLRsHaDAsSysOMju+Sd/8ARe7HqWT8UVHdaa/cRlYkhxvWhycF9bO40taaF7w==
X-Received: by 2002:a05:6a21:3a4a:b0:1d9:782f:8c9a with SMTP id adf61e73a8af0-1d9a83f4ca3mr12582195637.21.1730147222565;
        Mon, 28 Oct 2024 13:27:02 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7205780e3f5sm6182559b3a.0.2024.10.28.13.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 13:27:02 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org (open list)
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com
Subject: [PATCH] Fix BUG: KCSAN: data-race in fat16_ent_get / fat16_ent_put
Date: Mon, 28 Oct 2024 13:26:44 -0700
Message-Id: <20241028202645.412589-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Issue is that fat_free() calls fat_get_cluster() and fat_free_clusters()
at the same time. If the same fatent gets modified, it can lead to a
race condition where fat16_ent_put() and fat16_ent_get() will read/write
conflict on fatent->u.ent16_p.

To fix: add critical sections in fat_free() on the offending function
calls so that they can't both be running at the same time. Since the
critical sections are short, a spinlock is used since the overhead is
not that high.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+3999cae1c2d59c2cc8b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3999cae1c2d59c2cc8b9
---
 fs/fat/file.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/fat/file.c b/fs/fat/file.c
index e887e9ab7..d7ae152a9 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -7,6 +7,7 @@
  *  regular file handling primitives for fat-based filesystems
  */
 
+#include "linux/spinlock.h"
 #include <linux/capability.h>
 #include <linux/module.h>
 #include <linux/compat.h>
@@ -306,6 +307,9 @@ static long fat_fallocate(struct file *file, int mode,
 	return err;
 }
 
+/* Prevent data race in fat_free. */
+static DEFINE_SPINLOCK(cluster_lock);
+
 /* Free all clusters after the skip'th cluster. */
 static int fat_free(struct inode *inode, int skip)
 {
@@ -343,7 +347,10 @@ static int fat_free(struct inode *inode, int skip)
 		struct fat_entry fatent;
 		int ret, fclus, dclus;
 
+		/* Ensure fat_get_cluster isn't called while freeing. */
+		spin_lock(&cluster_lock);
 		ret = fat_get_cluster(inode, skip - 1, &fclus, &dclus);
+		spin_unlock(&cluster_lock);
 		if (ret < 0)
 			return ret;
 		else if (ret == FAT_ENT_EOF)
@@ -373,7 +380,12 @@ static int fat_free(struct inode *inode, int skip)
 	inode->i_blocks = skip << (MSDOS_SB(sb)->cluster_bits - 9);
 
 	/* Freeing the remained cluster chain */
-	return fat_free_clusters(inode, free_start);
+	int ret;
+
+	spin_lock(&cluster_lock);
+	ret = fat_free_clusters(inode, free_start);
+	spin_unlock(&cluster_lock);
+	return ret;
 }
 
 void fat_truncate_blocks(struct inode *inode, loff_t offset)
-- 
2.39.2



Return-Path: <linux-kernel+bounces-334903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907E497DE1E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 19:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12AD1C20B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 17:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5175F2629D;
	Sat, 21 Sep 2024 17:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKXtcmf1"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5B2E636
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726941050; cv=none; b=HV6oeumOJpjTElHQGDufOfvr8OElzyKkOqpeZtnBJvfXE7OJgHw9j5ncA7BLa75ecSsMlkjBTnykTkJE1onWd6hWeAnsKo6nVRR1OaomgihvZ2x+h0eARQyZcyr2skqtWSnbZJtQeHMwXZJPhYpqDZmc5cbKrxLCDvQWOSVpWqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726941050; c=relaxed/simple;
	bh=AU0UdK29D6BvJgW5d2bqOz88BkcXagg3fHDkdBY9foE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX7qHgPN9Gfiq4DH22DRSEKKmg/pXpFbp+s0XwVm8AhG7TBdhST4dQDB9fNP7+jTbn6Ptdgfhy4bBhPmQIcYLlw9WxxRMAutdHBtVnfIa6O5C3pm5dAQeIUSwJtweXPpN6TKu/F5vfHAEJP/Fkj+gMTS/AVAxsXueYgja/3NoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKXtcmf1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-206b9455460so23561725ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 10:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726941048; x=1727545848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCNDt44G/ty2Nasp9vA9S62MfgwzCrwqOwsKSwf0Km8=;
        b=mKXtcmf1iHmGIK1yIA82NwCOV5tgheEiOcvzGsy+SOnHZoiEfWwVtrU6S9ecHZ5B2U
         vnxZE8B7IZcXVFvzrCC8hjwpDkf1dbr/Jj38N4GlxfWQjMXXnps+A/ACh5ci7uZemhzf
         XQVB3foTV8MyjtRpAflx7o9hVpOBiKwf3QvUtM2drd9WM5HvNK9w6fq5WzEQJGl+BGTm
         9ykULpT7ZyZ/yyEY5rj+om8xj/GpTHLSmq2Q4ckW+/Ze9xXht3gR+c+CMEypITXPAKw2
         UUXG/w9c+ptHzXxk3CuB3In9Ba9uMsZ7gCsTBnuNiuJ02yu2VNqd8Ovm8uy0ru6Em8I+
         gkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726941048; x=1727545848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wCNDt44G/ty2Nasp9vA9S62MfgwzCrwqOwsKSwf0Km8=;
        b=wKztiEjFN++xTtS1wGY1Yu0ZlhedHiudcn8pMsp/Wuk3TWQrOPmBMvlNMqBe0SYhaU
         BgHe6v5z9uaxG/peHLeQfHH726awVJE9CXZzXC8DB+iwQYt9KwCKpZmcJ7mA3CVH54XG
         6KKHE4gSwgSe0+mY7uHPa1HQotV2xf9Yw7DtmQnf1U/gjnvTQhEvXSJqNx8P0mFgx38l
         AYOJRU9maT2QSUUGuMUrs0YmAmVI57A824Rf0w9A4YQVyEVqU3ThvD4g7glzWk1Q0J1V
         8rh5Ly4FqtxyYTjlUYCHVOZg9OB3aXjgCuPZDoKTp0Ssm5vg5O/zU8m1zE/Vgs1QP9a2
         GO1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXN7H2jGkDMt4mjRyPeHNWdOva+weEEk4vTBCVw/Qh0bYEHpKQc+jUBSNCsvPVZ8O8vTKRzseWKKalCdYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5aXArT3eEQuqSvj5TJ0uyOjy3THd/B8ZWuf4nkoTGvYCBEjn
	te4tHkn3AZmEPb/8NoI4GXdU7l6SorVqHGyJTHfui+ComGYG0zNH
X-Google-Smtp-Source: AGHT+IERYuWYmz+RC9gPwWAf+YZZBIXnpy25ZgMeed3AxVbMtv8WfbeSHO2mNX2pCgvtRjbS7MiVvQ==
X-Received: by 2002:a17:903:2287:b0:1fd:96c7:24f5 with SMTP id d9443c01a7336-208cb895e67mr165322165ad.5.1726941048464;
        Sat, 21 Sep 2024 10:50:48 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207945da56esm111181055ad.3.2024.09.21.10.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2024 10:50:47 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: Fix deadlock in ocfs2_get_system_file_inode
Date: Sat, 21 Sep 2024 17:50:34 +0000
Message-ID: <20240921175034.11222-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot has found a possible deadlock in ocfs2_get_system_file_inode [1].

The scenario is depicted here,

	CPU0					CPU1
lock(&ocfs2_file_ip_alloc_sem_key);
                               lock(&osb->system_file_mutex);
                               lock(&ocfs2_file_ip_alloc_sem_key);
lock(&osb->system_file_mutex);

The function calls which could lead to this are:

CPU0
ocfs2_write_begin - lock(&ocfs2_file_ip_alloc_sem_key);
.
.
.
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

CPU1 -
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);
.
.
.
ocfs2_read_virt_blocks - lock(&ocfs2_file_ip_alloc_sem_key);

This issue can be resolved by making the down_read -> down_read_try
in the ocfs2_read_virt_blocks.

[1] https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd

Reported-and-tested-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 fs/ocfs2/extent_map.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 70a768b62..f83d0a3b6 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fiemap.h>
+#include <linux/delay.h>
 
 #include <cluster/masklog.h>
 
@@ -961,6 +962,8 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	int rc = 0;
 	u64 p_block, p_count;
 	int i, count, done = 0;
+	int retries, max_retries = 5;
+	int retry_delay_ms = 30;
 
 	trace_ocfs2_read_virt_blocks(
 	     inode, (unsigned long long)v_block, nr, bhs, flags,
@@ -973,7 +976,18 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	}
 
 	while (done < nr) {
-		down_read(&OCFS2_I(inode)->ip_alloc_sem);
+		retries = 0;
+		while (retries < max_retries) {
+			if (down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem))
+				break; // Lock acquired
+			msleep(retry_delay_ms);
+			retries++;
+		}
+		if (retries == max_retries) {
+			rc = -EAGAIN;
+			mlog(ML_ERROR, "Cannot acquire lock\n");
+			break;
+		}
 		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
 						 &p_block, &p_count, NULL);
 		up_read(&OCFS2_I(inode)->ip_alloc_sem);
-- 
2.46.0



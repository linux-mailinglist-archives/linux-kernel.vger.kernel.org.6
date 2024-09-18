Return-Path: <linux-kernel+bounces-332843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC72E97BF98
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15EA1C223C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DA1C9DE5;
	Wed, 18 Sep 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y04yPwYR"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE81C8FB9
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726680062; cv=none; b=hED5FSLImlCK0gjgfiNGNtL6U2DMp+35m+LR7Q/gNEnIyXZJIF86MY5UPK5k7/uOgv9m6rj5xhTxV3J9x6aGd+HN+pwPm55dRkZFZhqrDXqYkRgp9S8AreRO4pH7UEySBTSUdRSjFwcbi5V7+N327KArN3qzH56ISjWKddtAK58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726680062; c=relaxed/simple;
	bh=dLW7yMaZUHwvr8OqyqLXlmiSaDlBdSZjSstzHtIjIaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAryid4yFqxPJS+oHmj+kT/JD/tRjIwGE9kOtq6SlIZSu1Z0wcQi8oaK2Zw2POK8VE3ZfF/5PiTZODW+gHNa5ISy48pMohBJZV4/xxxNkQMLfR3U0QFyY4gjCJXi+GctKw0/5JMvUULD/lXKDEeSBHG/Lvnw4lStKLEtktEQG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y04yPwYR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7198de684a7so135271b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726680060; x=1727284860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8x33SOcOiQLrcjzIwPJ+0Uf+LjyFv78ehpo58zIPVY=;
        b=Y04yPwYRB1fP3qxRbn3kgez4YfqUW0rEqXotXKg8AnhDAngt4LXS3GIk1hb93G6daa
         +3g17xuj3JO4g0iPbqtObUUHxhjCwtWJv6xkWAXYb45cmtHPXhZ5xWm8cR6Tm6eQrvi3
         s8/MvkwcAQ3yxsD2WrCurhgCJxAqLnqrEIK+pUjVDBXpGpPtTSJLdXjL2CzvbOMz6xrs
         SVNNXqgLMe9J9ftv58Hd8aAJAmL4ID+D1epV+cWYQMkQd2TdfZtOIl7G+EOMOq4eFUPk
         GFQhYE5reJl9Mj6P/3T5f/MdJYG36gOI9r13EznlsBY7dABFZGRCxNs1I6YCsN0V65kd
         Wa8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726680060; x=1727284860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8x33SOcOiQLrcjzIwPJ+0Uf+LjyFv78ehpo58zIPVY=;
        b=qHDcn7EkcgVZfkZNPQ0O7uFvjNZ5TeqNLLkSyoJB2kybmjBKpsUXMr7yw9lKM1M6Ak
         YzSARpxqc/1qFw9uWdyd08APc77Is89fVJyxxLDIn1ouZjQTxP8Pcz6bHu1R5fp+qWd0
         CMrdEVTWZM/68TzPnVI4RQM6eyXI9rciD3RtFOJFmsCSZSI/XaFwghiWEo5Tojgrc2xR
         b0hM6LPVVrJ3Bz7BKx9NERKHgGN+YyUUEhTlVB9g/ANfQdyGOpNBIJ1Wzxtpq8AGUnj4
         I/aFnFkaA+lyvb5ZUZlet/GKXHejd+ptQk7mo/lVNEHSZbkdGPVte6XEnliXn935lrtN
         yu/g==
X-Forwarded-Encrypted: i=1; AJvYcCWlvwpYstPFkpow0ZkH72XNzNOzmrtoj7G3Tu7uXgntEhpOvR9sECr1NvUXGI0DvUDwOhmxVx5NcUOCNRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNMJilaUrPcYuc5LZeuQ/4UUfxtq8ykgoekVk8nW2Y7hmHZKck
	T8u7JrQsA38Zw+Isq6GcqJx0uZ+cpvpGicD499oLsl3U+Z0I4OPo
X-Google-Smtp-Source: AGHT+IHPfFq2ebm0eN6ynBUnxXkvTYH9W9Sr+at5r786BHZM1dzVPHVDEIKanFJrN6wz1+6c++K+Gg==
X-Received: by 2002:a05:6a00:1703:b0:706:6c38:31f3 with SMTP id d2e1a72fcca58-71926080509mr33181259b3a.8.1726680059568;
        Wed, 18 Sep 2024 10:20:59 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71944b7aeafsm7186476b3a.99.2024.09.18.10.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 10:20:58 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Subject: [PATCH 1/2] ocfs2: Fix deadlock in ocfs2_read_virt_blocks
Date: Wed, 18 Sep 2024 17:20:25 +0000
Message-ID: <20240918172026.2532-2-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
References: <20240918172026.2532-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot has found a kernel BUG in ocfs2_write_cluster_by_desc,
while the next patch in the series resolves this, another
bug has been detected due to a potential deadlock [1].

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

[1] https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6

Reported-and-tested-by: syzbot+18a87160c7d64ba2e2f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=18a87160c7d64ba2e2f6
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



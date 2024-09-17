Return-Path: <linux-kernel+bounces-331315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B4397AB32
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4981F260EE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 05:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E294D8CB;
	Tue, 17 Sep 2024 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YOavOYW6"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895A4594D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726552697; cv=none; b=chwAJ1q6vFiZ5rl0C8uLitX/IYY+edAkZFvj8HBpCOM8RoTKlECcQVH22CxguQSKQp5Gy1l8BwSasF90v/a3tjn/L0s9albmkLhD4XkV8A37GG/OjZfVwxa+MHiRMezYdA21iog5qOvaSlDuihlCvG4Ixo2O/VElN/DaE2eVUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726552697; c=relaxed/simple;
	bh=ys0JSu+vLe+IE2seOpJ0rEal88q6Zadtm80JM31c0jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K90Jgh9qeQ4H/6zRinJZCAX1kfevbrVOz8s1YO7UDfoVmBuSHswoVAIiaYUe0BO+jfZLaIsnz3KnS3CKJwBKJ0BkB1xaI9KGUiuNQh2hHxMeQt9qOjA7yY9nlpvRbfoZwBovvmd8N51frmjm90zkkv6M6gvFtVtmLVRJ1saOik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YOavOYW6; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726552687; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lRhe47Td78YjWQB6+3LEkHNp4XP2ZSdvwvLVlmd7jfo=;
	b=YOavOYW6ievlIAXM10z/EDvBuJnTyJHQsqcGaaSM7TPDrll4eJAxi+vt92+gmEXq80umc4rjEpd7+WLIFBO97GS/9fxeyZ8H7w6amIPTpBqi2tECILPPYj0Pan8LFjJL3Ftwb+HtCaUTVHv7ZWKy2BJRDGsM0ZG2C8COfZuegVA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFA5dGj_1726552682)
          by smtp.aliyun-inc.com;
          Tue, 17 Sep 2024 13:58:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Subject: [PATCH] erofs: ensure regular inodes for file-backed mounts
Date: Tue, 17 Sep 2024 13:58:00 +0800
Message-ID: <20240917055800.3655532-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <00000000000011bdde0622498ee3@google.com>
References: <00000000000011bdde0622498ee3@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Only regular inodes are allowed for file-backed mounts, not directories
(as seen in the original syzbot case) or special inodes.

Also ensure that .read_folio() is implemented on the underlying fs.

Fixes: fb176750266a ("erofs: add file-backed mount support")
Reported-by: syzbot+001306cd9c92ce0df23f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/00000000000011bdde0622498ee3@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 666873f745da..7c3467dcc5b4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -714,7 +714,10 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(sbi->fdev))
 			return PTR_ERR(sbi->fdev);
 
-		return get_tree_nodev(fc, erofs_fc_fill_super);
+		if (S_ISREG(file_inode(sbi->fdev)->i_mode) &&
+		    sbi->fdev->f_mapping->a_ops->read_folio)
+			return get_tree_nodev(fc, erofs_fc_fill_super);
+		fput(sbi->fdev);
 	}
 #endif
 	return ret;
-- 
2.43.5



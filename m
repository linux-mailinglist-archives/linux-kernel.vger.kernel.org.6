Return-Path: <linux-kernel+bounces-214154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E05C908044
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 02:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6AA5B223C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074223D6D;
	Fri, 14 Jun 2024 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwAYqGKa"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03006FB0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326178; cv=none; b=GOR9EDDPOvFIVyCGdMJGPLwDqyyGb19nwjL1GWrE7EM82zYn//lwYA9vy3wcxdhnwoS7AFz9KExVB1npsMUQqWCGVSfMtA1eQ+66N4kIXR4yfqweNMAA3Ii12rKmMoI3imMNNPsdeNDaPDYpdywSjT9kD1U+9QwfBsYQCCiYbpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326178; c=relaxed/simple;
	bh=IV70eqbbMIAeKY6gk27U9vxMJquBCicd9EJsmT1VghQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SGkOTgTGvk5sZjuDAud0pxL5HuEwfX7dbRkrKdPv5cyCBZUf479mCCPKkrcs6R9JnJ92zlL54T+8/xdIslIBVh48RVd9sYcJBr8jvS1uhVLQguGhi/hVWnE1IeW1swiwbBZkmM1Se7htQXB1bkHJPr0G9SQbZDNkRNo4jdwzCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwAYqGKa; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1f6e183f084so12895665ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718326176; x=1718930976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr9zxapFgNaER63LJwaQwrbpwLBIxQNjoba83Eu4cUw=;
        b=OwAYqGKa6ZqOgn4u+wRwFngDaHqrL46FdsrHhfpALf+6c0AmgGEBJGTpdJdurj+84I
         yZpLx9Pjg18n125GJHQzHBTZgPz6KjOwXEU+tz8DuIUj5Ez0ZVSRpOthGvXIpU2r1VHb
         oqbY0vj9N992br4sEfD7Qezh7meQvKGQzEOuRfluor41Y8LH6BYOm0F0tMd8aSOqqd/s
         pQLfvTgQxYdhqFnHeFVx6gBeYzmL9OMFvsUjqglueJQcqPg3f2Igt6IPoNJOvrqKBpi5
         PVPVKZRlhKNUksPKECEV1H0vmYBH+TqeZqnLLiTLz1VJJ+NKse5ysvIubuNQuvNVCcMU
         V9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718326176; x=1718930976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hr9zxapFgNaER63LJwaQwrbpwLBIxQNjoba83Eu4cUw=;
        b=j3b9nU7vbqWHxRtNdteBAhxo/4rtfPHUhjCCGN51AuhyBugJQHEnn/FCUNI9Ky+4IS
         a3UL31EMnxE7ItwqeHW3lfo4T22N/aqt/m1jiRr+/ooeYwqT0kX1G4GubuEjO+fUhEaB
         15gQf61uaqPeggZq8q39huqLIfYGzFwrcEvtE9tA5a11Jxs+7rB/wvXUu+nKKzSQ9Ipb
         Jr6YPToY7sSWCkvYQ/5jYsZf/btARMEQ475FUd9lbG+FyHqRDvfivjRP3pGd5RdX3lFf
         hSdhDturLk2ITYxwyx52OrwimxDjtSMcqQ/YAEJzMEFsG2qgU3nPhljrOAEC7mOmkAox
         9NQA==
X-Gm-Message-State: AOJu0Yy2kNPNd77k63jNJW8FdPHHMqXugoql5hXRQRAmXXX4lqxo4shj
	F3QVuxr+rLdydSy04jB6NHxzpT3M5o8Onjzbt+AqNrmaRTlAoNvs
X-Google-Smtp-Source: AGHT+IGZRxn+Q9QyKPSinjIbvRNnovNHhMZftvOoCKYOG2MN/PiQrhE56oC0bjzZjT7sPIWAgcDlog==
X-Received: by 2002:a17:902:c409:b0:1f7:560:ef27 with SMTP id d9443c01a7336-1f8627f731bmr16059525ad.40.1718326176175;
        Thu, 13 Jun 2024 17:49:36 -0700 (PDT)
Received: from tan.. ([222.20.95.235])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f855f17968sm20338485ad.229.2024.06.13.17.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 17:49:35 -0700 (PDT)
From: Wenjie Cheng <cwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	qwjhust@gmail.com,
	Wenjie Cheng <cwjhust@gmail.com>
Subject: [PATCH] Revert "f2fs: use flush command instead of FUA for zoned device"
Date: Fri, 14 Jun 2024 00:48:41 +0000
Message-Id: <20240614004841.103114-1-cwjhust@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1.

Commit c550e25bca660ed2554cbb48d32b82d0bb98e4b1 ("f2fs: use flush
command instead of FUA for zoned device") used additional flush
command to keep write order.

Since Commit dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 ("block:
Introduce zone write plugging") has enabled the block layer to
handle this order issue, there is no need to use flush command.

Signed-off-by: Wenjie Cheng <cwjhust@gmail.com>
---
 fs/f2fs/file.c | 3 +--
 fs/f2fs/node.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index eae2e7908072..f08e6208e183 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -372,8 +372,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
 	clear_inode_flag(inode, FI_APPEND_WRITE);
 flush_out:
-	if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER) ||
-	    (atomic && !test_opt(sbi, NOBARRIER) && f2fs_sb_has_blkzoned(sbi)))
+	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
 		ret = f2fs_issue_flush(sbi, inode->i_ino);
 	if (!ret) {
 		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 144f9f966690..c45d341dcf6e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1631,7 +1631,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 		goto redirty_out;
 	}
 
-	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
+	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
 	/* should add to global list before clearing PAGECACHE status */
-- 
2.34.1



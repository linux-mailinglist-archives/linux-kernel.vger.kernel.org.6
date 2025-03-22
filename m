Return-Path: <linux-kernel+bounces-572462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C05A6CA8A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 15:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DD17882E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86D21A43C;
	Sat, 22 Mar 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6J1UhYf"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B435F17E0
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742653316; cv=none; b=BW2X36MYAgLRRtgVo2L/1VJWDmXZGtdhSZUrvcEQ1RmvoriA9Z+mEoiOvBL8elwFygBelxSc833POCkEG4kt8KcJ/1M9YQkg9U0ZPM0ojTxIf6i3JwI9I9oea165lseVbMi6EPcuwOpsJKAz0UERfXrcHqMGlPYH9gWTX5vVZf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742653316; c=relaxed/simple;
	bh=zylf9gMtY9TZ36hq8YodEV7cPIRb1Iwy/ePAIm1AKBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Su2a1if/BnimmxJ73sqd2HHXpIL73C8YGAfWNYnoeNKr4EQ8SXY8gMACIrI4wXqGqW5zxceS/WSsUEluFAvs4Grq3LeB3eeF9pzTjN9vNTAi+VE/EQ7NK+q9IBEdFuhdbdKq8eUz8NY5rbQ3UbTimXXpH9EA0302VL3bj9fWQU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6J1UhYf; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301493f45aeso4954171a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 07:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742653314; x=1743258114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cBSQsRnQ4TfM2tTeKw5HNlKo6byh7HY//NkZMVTFY8I=;
        b=I6J1UhYfvFkb91xvVrwXos9kg6Q8BfLaK7jrjhVDlyCGYqAGtYOO9Q12ToCpFIZjfi
         rsgpuD5YW8v5dLviDaFnc4Jy/rMfJVgmtynMpFXmBuaWFjU9p/cPcrWWU2dl57TYhm9N
         fSn+SGlvbF0Q2RljjCw/xPaFJa6FgooQiraBGOfNp9y+eaolH0ZZT4z7aMLr/pMd2qic
         CY81ZTHYGTzJiM6KbF4CQU+JQ9ihQgcAoSN1PcCQD5ATtAxQhxzNszK+xK8hnln5qg9S
         lN9McF1lSGL5Qh7+fG4VFRBg4HD/2k3qJNIN7PO0VrUelOo2NDtxayGbdZLdCz4n1sLA
         ZL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742653314; x=1743258114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBSQsRnQ4TfM2tTeKw5HNlKo6byh7HY//NkZMVTFY8I=;
        b=Q4l+lBCOkeiP1q8OQuqWnr1+I47uF8sfGdBbv62JWIJNVW1HBrRxIBNlu+/lJAWLmq
         Dno3Ezj7xPzEaOR8deWn8IGvo3NuNaaOMXYfP8BM6zkl3T+bQ5NScq8unxbMm3/C3owP
         LkG+wwNS+GKtMlftXOYAUYyVBzUi90F6EaSbPgXNrLegU7k4ZDnZygAYhGjUPnKB1cYw
         i4f87ZZ4CIv/5iyaqtKlmfurlfQ1FbAjPkvikfaewiaHVVrzH8dl8XZu8V6fjNDQ1z6H
         LVGpYxvi5vDgsBpD7RdKDJvKK0kHg1YQ4c/pVogFYeqQJHvshduhrOm9ULJ1pZPzhzZS
         JV1A==
X-Forwarded-Encrypted: i=1; AJvYcCWny7xpiLo74gcNb4HSfeYfTuRkKfsnfGobjnHBkqun+otNS1rlQgzAlVeHy4dpsS30B1I5vU8ukAfPJX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ1ggh8hBGtQ9vVOHVkyc4BZxoxMwg4hlE/EAGgItHNEVOkoSw
	6NOVkjdd6ZEcM2dyWhpmXup7eNA0oryBXJe88tz1BIFMBsDNHduP
X-Gm-Gg: ASbGncsmz20vqlo8mbdBZa7G8z6B9WFa9cZnQSf7WO2kSHSBcw9QMZf8q+YkS1pJtrT
	LQXiXv1XUgXVb7YJWFRu1EeY5hkf3/MQHAqduPDgUntbVAPER5zO402WNE2JByvqIlPW5tPAYex
	ty8C47NK1L+zkL5JXp1sfsrZwXjRPBpCbgxvbCTxQLDcqCBNBhAyPdnkMH7xnNBvdluHz4BZRqO
	WMiVo9Wwfk7HdqxATquuWNLnCnKw/3IZCNE8DlD9LpWpEAMrq58iAcKi/AaOKv9CWESNYuFLlfR
	uae7vRicSOnSf4N02K+72zkpbZMWuSubLfYWFZ+vxNgY5NdOhIrqcKnOTcmsaWKjR5+ecqW1z4s
	jsSM=
X-Google-Smtp-Source: AGHT+IGws1/9iRhkXC7aE71u9g4HMMNT2JBajE79EbnG73qOrwoibxoVv6T+IuIZEpjcoyEUslDBkQ==
X-Received: by 2002:a17:90b:1d46:b0:2fa:1851:a023 with SMTP id 98e67ed59e1d1-3030ff11268mr11568556a91.35.1742653313676;
        Sat, 22 Mar 2025 07:21:53 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2409:4080:215:18d5:84f8:e760:1d0f:700b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3bbedsm36231605ad.3.2025.03.22.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 07:21:53 -0700 (PDT)
From: Purva Yeshi <purvayeshi550@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Purva Yeshi <purvayeshi550@gmail.com>,
	syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Subject: [PATCH] fs: jfs: Avoid sleeping function call in softirq
Date: Sat, 22 Mar 2025 19:51:34 +0530
Message-Id: <20250322142134.35325-1-purvayeshi550@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug detected by Syzbot:
BUG: sleeping function called from invalid context in jfs_fsync

Fix jfs_fsync() to avoid sleeping in softirq/atomic, preventing crash.
Skip execution in softirq/atomic and return -EWOULDBLOCK to prevent issues.
Correct generic_file_fsync() call to pass the required arguments properly.

Reported-by: syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=219127d0a3bce650e1b6
Tested-by: syzbot+219127d0a3bce650e1b6@syzkaller.appspotmail.com
Fixes: 5955102c9984 ("wrappers for ->i_mutex access")
Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
---
 fs/jfs/file.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 93a3e7a45b0f..fc93376eb1e6 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -19,25 +19,17 @@
 int jfs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
-	int rc = 0;
 
-	rc = file_write_and_wait_range(file, start, end);
-	if (rc)
-		return rc;
-
-	inode_lock(inode);
-	if (!(inode->i_state & I_DIRTY_ALL) ||
-		(datasync && !(inode->i_state & I_DIRTY_DATASYNC))) {
-		/* Make sure committed changes hit the disk */
-		jfs_flush_journal(JFS_SBI(inode->i_sb)->log, 1);
-		inode_unlock(inode);
-		return rc;
+	if (in_softirq() || in_atomic()) {
+		pr_warn("jfs_fsync() called in softirq/atomic context, skipping execution.\n");
+		return -EWOULDBLOCK;
 	}
 
-	rc |= jfs_commit_inode(inode, 1);
+	inode_lock(inode);
+	generic_file_fsync(file, start, end, datasync);
 	inode_unlock(inode);
 
-	return rc ? -EIO : 0;
+	return 0;
 }
 
 static int jfs_open(struct inode *inode, struct file *file)
-- 
2.34.1



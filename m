Return-Path: <linux-kernel+bounces-335901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A4197EC43
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3570B21EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA39B199E82;
	Mon, 23 Sep 2024 13:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6j5B/T6"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB3F19644B
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098154; cv=none; b=HP584fCrwyEVvsSiHaI3O5sPaIFGzP5oxYWrkN0Ks2MDCeJVpFVPkhPO0r1aGAqb6hkC/wFp7bVD5qwUPae7Robc2R6cigJZ/prMgj2A4NXH0tEJ+yhMiqPXNsA/qznZ2pkG7dEOwYjn1dnpIMgLtyJtriT+++TnRzhyHjnktVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098154; c=relaxed/simple;
	bh=fA1caZBG5nKM86v8pgROglEl/a7P1ZoaIM8TTpkv+20=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YrwSEKgH1yHKyR7Gmer66SGn8F/21fta3lnzA6unGrQYvvwfRHcscaBgr4E86oDH8BJnU2TZ92p3sch/32O6LhCQLcBq8voa34zCxK8HrGwyl4UlSkske372Xk2uZu4fD+jFSp5wJP4oL5w339lOjJwTliBUTjahzQQLaDN7Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6j5B/T6; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e0465e6bd5so1797108b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727098152; x=1727702952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZXEl1hOP9YAeajQxkxfICFrSdnHviVjv168PjTg2DCA=;
        b=L6j5B/T6awGq+8/SbRjcrOQk2Nbu7iCxSuSiXwNqyxvCTBavzQ0vGqzJddO0pri9S3
         4OtbEKSEDII7rMfY6D5hHDVcvwQZvuRe1Zg/gg1o94776iwigzb2Be97te9snvkOerqg
         zW7s83YiuGw4lwwiHf3Axodst7xhUU/NAJM1hKLl1akk2j89isyE8fyyrQqU8sclxVlS
         rH83siudiQ6Tg3Emx9B2yS/uTAW4JbSnqg57y02g+ohKaWSXZN/pRMlH98UBVEuwyJW8
         4IycHQ/K8EWSd8MMWUIPElHJ3uDgICyj8lgJBciyHPrNLVNCPwkmhN9r0g6G17bTrtju
         BZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098152; x=1727702952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZXEl1hOP9YAeajQxkxfICFrSdnHviVjv168PjTg2DCA=;
        b=ompyh0MHtwmQUx1Imn8P4c9QSDUw90HbnZRpSwgilUWfvf4lQ9vMo4foqDIIWbQh6Q
         2ufTsb6rVkzOUxasfuY2DsN1iYKG2w6GVUnBerwyINgNtZ4kynF+7TxVGyLIy719aF0c
         5L6VOczSaGU87Go9KPBm3X7ISXX2S9FLZxzJRWSi4TTmky0ApSJvb5tR1J7LXnXQYKP0
         b7F6qWzmK6byK83+sNeJiKcnLllTv663vOTF34OpQvZMs/S1CES/PfYNT2fLAT7r7iQP
         fUCWophnJ9eJhUgp9mArBEQFxzgWHMC/TgDBivbbGSose6wIIxdEWYt1VSLR70trNF+t
         dpAA==
X-Forwarded-Encrypted: i=1; AJvYcCXX48SNzbl91XCKsY7RQ5Ew5h1/vdhQoKqBQvcRH8H6+hCdlkEVAgNmfNZzp/u029zV1QRU1+r/7VhN3o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzesRXjEo0VGRDE3HI2gh7OYR1oHqYrDW+ci9CyF6Hi6Q+6gxA+
	DIGmGt5jQUjmE9ZPGsVd0/Sf+Mo8BNUYGUgA6qVoO5stR8TIWHEC
X-Google-Smtp-Source: AGHT+IEtMp1dtNK760vUQmqf5mZ8ZEYPjoY4hTHyW3phHAlm3RmlQ0e6Co508kW8A/IADca7dM7IvA==
X-Received: by 2002:a05:6808:3089:b0:3e0:515c:ff5e with SMTP id 5614622812f47-3e271b8af16mr7995854b6e.1.1727098151727;
        Mon, 23 Sep 2024 06:29:11 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7db498d9850sm15154604a12.10.2024.09.23.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 06:29:11 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Subject: [PATCH v2] ocfs2: Fix deadlock in ocfs2_get_system_file_inode
Date: Mon, 23 Sep 2024 13:28:54 +0000
Message-ID: <20240923132854.13936-1-pvmohammedanees2003@gmail.com>
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
ocfs2_mknod - lock(&ocfs2_file_ip_alloc_sem_key);
.
.
.
ocfs2_get_system_file_inode - lock(&osb->system_file_mutex);

CPU1 -
ocfs2_file_super - lock(&osb->system_file_mutex);
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
v2:
- Remove retries when doing down_read_trylock() and fail directly
---
 fs/ocfs2/extent_map.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletions(-)

diff --git a/fs/ocfs2/extent_map.c b/fs/ocfs2/extent_map.c
index 70a768b62..48919464a 100644
--- a/fs/ocfs2/extent_map.c
+++ b/fs/ocfs2/extent_map.c
@@ -973,7 +973,12 @@ int ocfs2_read_virt_blocks(struct inode *inode, u64 v_block, int nr,
 	}
 
 	while (done < nr) {
-		down_read(&OCFS2_I(inode)->ip_alloc_sem);
+		if (!down_read_trylock(&OCFS2_I(inode)->ip_alloc_sem))
+			rc = -EAGAIN;
+		if (rc) {
+			mlog(ML_ERROR, "Resource is temporarily unavailable\n");
+			break;
+		}
 		rc = ocfs2_extent_map_get_blocks(inode, v_block + done,
 						 &p_block, &p_count, NULL);
 		up_read(&OCFS2_I(inode)->ip_alloc_sem);
-- 
2.46.0


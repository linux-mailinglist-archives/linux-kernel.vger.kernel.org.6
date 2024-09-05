Return-Path: <linux-kernel+bounces-317875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB8796E4F0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 23:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E252D28A21F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDF01A76AF;
	Thu,  5 Sep 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCLB3wNx"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54551917C9
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 21:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571222; cv=none; b=CeSOETxYZC45MrHy2DnJr65+qMLUb0eBWUuoo2NsPgb1oGVBV0Ss/SP9Tsl4+1lGG2zrBF4RMnKoO+gu/WXfHDm8YXSJNg31roNNcmt5GE1/1iwh0qrzYPXN/BIH3jCji1pgOrxjzdX1WIWaf9z1tKhhCFXAknpTjpN6zEtQyUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571222; c=relaxed/simple;
	bh=W9s1b564XTkWvuIBkFOKc3oFivgiO2pPW1cWQLJBzzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vf9W9jn2skueA19FPXkfZr2fkjVCII74h4HOUDaqfah42rMchZFtNR6ozRGFH/azoVsxLD2HSLLPium7Tb0QxWiwmi0oKo/Yjjn67QpQ3ySEFi6XlDeCGujgbJGmOxGC2a4b8TXRZHop1NxuDjdNo2fWITbbIr6KBKZYuqoQQoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCLB3wNx; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-717929b671eso905975b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 14:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725571219; x=1726176019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EICMtzmuDmx4azx6nqR/Lg9QE5oH8hihUYWRQitwd5A=;
        b=SCLB3wNx2mbddu/u+ywz5UROD383fm924bHzWNXmdxHzzvh1qklwe6GDrAd5OPJsRM
         3z6bF2+dWF6xzOzqqvp0VH8zPx/zQDKQgafzVMMpRVap+FjW7kjRKNC9RimvpF2c8meP
         E4jabGFsfXg5hP9GMVuTaiUX6tNxX0VyUufYPSZ92kB71C6Wysl47SC0mHXztD3BPCLH
         drI03NuL5OzjOj/TJQBRJjojYcX+S1/cjX9sXTLSuyKOUPfRcHumHzUPSVR25EgzgqtF
         lUBsrSGQHB68xk4mpJLkl1aqgJ+F+hNgkPGDWGQNzaNc0wpDmktbDZ1tiq6tWCbRT8Jg
         zRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725571219; x=1726176019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EICMtzmuDmx4azx6nqR/Lg9QE5oH8hihUYWRQitwd5A=;
        b=QeGA9Pb4OsxT8irOneDGMd+0qRA8/KuVyV4zTFRME16Y/NTvdugnNi5hiDDzYMNENm
         vpW5dFWvI7YX+bENY6CPXIJy7FSrkd8dEu6ev+Tg8deAgH8gGuLMUUDME3M+JTNOxO4B
         YkUXUPj7ka9zuBNYGoeJXtnuLRT4OnMwON/edaOtqX4AwkPQ+wSO8j67hxD7iJfl4n1f
         +zi09zhBBqpsPGrK9V35lf4FFWiO8J1uw5wveyB3WYyE+V2PDIlkF+/Y55kUjuITXT9f
         6cmUFqwRVZyQwfeTrgT6OQOz0e2kDBKbY09I8OoEa3V7CI0bPo093Tg7lvaJJZpeZJsZ
         yWYQ==
X-Gm-Message-State: AOJu0YxDr02RHyLTJY8SI/zEV3xL/cBnGiZ5xZ1t5P1mbp3KxpBpSZfr
	TkDR4i0ou8IF7VvZpOxHORBC3o8Rr9Rqsyy/6L3wWv7+nGtLmDZf6qPohg==
X-Google-Smtp-Source: AGHT+IE0z8rby9HTebFaHQq7GTIwjaG2HsDlavFj1bKPOpMg2b6IX3pXsRGbmnFKkWwPHIyglzTh5Q==
X-Received: by 2002:a05:6a21:9101:b0:1cc:9f25:54d4 with SMTP id adf61e73a8af0-1cce10979f6mr22060086637.38.1725571219412;
        Thu, 05 Sep 2024 14:20:19 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:8558:9704:c017:560e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718d6b23ec7sm70595b3a.25.2024.09.05.14.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 14:20:19 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs-tools: fix wrong endian conversion related to i_flags
Date: Thu,  5 Sep 2024 14:20:14 -0700
Message-ID: <20240905212014.1094170-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Fixed wrong endian conversions related to i_flags.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fsck/node.c        | 2 +-
 include/f2fs_fs.h  | 2 +-
 mkfs/f2fs_format.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck/node.c b/fsck/node.c
index 7ee29ac..632151a 100644
--- a/fsck/node.c
+++ b/fsck/node.c
@@ -62,7 +62,7 @@ int f2fs_rebuild_qf_inode(struct f2fs_sb_info *sbi, int qtype)
 
 	raw_node->i.i_size = cpu_to_le64(1024 * 6);
 	raw_node->i.i_blocks = cpu_to_le64(1);
-	raw_node->i.i_flags = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	raw_node->i.i_flags = cpu_to_le32(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
 
 	if (is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 870a6e4..fdbc25b 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -986,7 +986,7 @@ static_assert(sizeof(struct node_footer) == 24, "");
 #define file_enc_name(fi)        ((fi)->i_advise & FADVISE_ENC_NAME_BIT)
 
 #define F2FS_CASEFOLD_FL	0x40000000 /* Casefolded file */
-#define IS_CASEFOLDED(dir)     ((dir)->i_flags & F2FS_CASEFOLD_FL)
+#define IS_CASEFOLDED(dir)     ((dir)->i_flags & cpu_to_le32(F2FS_CASEFOLD_FL))
 
 /*
  * fsck i_compr_blocks counting helper
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 30d8e19..db1bc89 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1414,7 +1414,7 @@ static int f2fs_write_qf_inode(int qtype)
 
 	raw_node->i.i_size = cpu_to_le64(1024 * 6);
 	raw_node->i.i_blocks = cpu_to_le64(1 + QUOTA_DATA);
-	raw_node->i.i_flags = F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
+	raw_node->i.i_flags = cpu_to_le32(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL);
 
 	node_blkaddr = alloc_next_free_block(CURSEG_HOT_NODE);
 	F2FS_NODE_FOOTER(raw_node)->next_blkaddr = cpu_to_le32(node_blkaddr + 1);
-- 
2.46.0.469.g59c65b2a67-goog



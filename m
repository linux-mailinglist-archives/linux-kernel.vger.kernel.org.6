Return-Path: <linux-kernel+bounces-320250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 931519707FA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 16:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C0F1F227FB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD2D173332;
	Sun,  8 Sep 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="e8WaERJg"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A3A171E5A
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725804445; cv=none; b=KMw1I//eL11vyjToZvHpoNG6/j9l0q2/iHSH5I0xFrslWQJxlM3X2f9I9+tHGotQSnUTAgMKzLwvReo7qJ7Io+M8OH19UyNehdb89Hov9HzvpwuyBPizbVjUdPMgLFUCyBnqKSfkssX4DhA5SQP+Y2wMqXF5suL5smpcgLGtYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725804445; c=relaxed/simple;
	bh=VdJeHcRa81uNgktXVnAIXziYQCFEfA5cn+PUdZ+gLkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icC8XBW2fB10DIo4KeojxzU2WZbBZDLS/ggXzGVI7C/yzZANvIow/nowPF9Bdoj7pH9apHihcTkMdd9dATKqBbA9BSzhs94Z/vlLt49bcpsWf6X5l1zTRafi2a+b30Aqhkyw3v0Vjlzl+BDMGdAixYSEpeW96uLbZbptwo88apg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=e8WaERJg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb6eebfa1so271705e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725804442; x=1726409242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vR6N4fCC++oBDLKVVVJ7HiCM6XtmAM6PYHQUGBS1rhs=;
        b=e8WaERJgQ6IuO2P3WFlE7zeJAaG0/TM4iOW7XCJsNp68ELSNhzuGa/GETvbKkbUXGs
         W3+iK53K4e1cfdT5+47OlFijupW+FZ2YJrp51GQAMDCFCGw37SlI4idYHcHN8797iCGu
         u3M64y5NRrU/kRIPZqFHqBFo5VLSDdUGfTJVsZ7tlzNEcfoMF1wOWFokFq5BcuTGNbEa
         mWflKbnpgJhxCQIfUMTpcjBYxblAzLr5e9KetxzMp+y3w76PZqpZVj5ggxpLR7ZQz1Ob
         T/ZgnK63GF3y8pJnTZ1fwMW0qyo4blRTMoPG4w7vW46kPn9KttNWT26eWStG0pD1hAcA
         ZLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725804442; x=1726409242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vR6N4fCC++oBDLKVVVJ7HiCM6XtmAM6PYHQUGBS1rhs=;
        b=S4833dWheSd1LJVHAMbl6Et1f/wMf/Y8XU1+Ed7HsdJo4YuPlaO2mnp0SczwJd/wRa
         fuVXSfwjljp9JqcZUMZTD5ZkPcgbnRbSq4tEQHdUYQcN0FYd+DEYqp7LK3FKDLi6nBwT
         WWjWD3LxG41vHUEpq3vpGYdbj+ohWrRN6EPBmkDRlczKo0EJBiOZgmkVD7j4pBSosJug
         dvyH0wLZlr4uyaW9JWMSQPiO5gOh2G/hVsZdfJ2gy09/yjNNAnoYg5Arx9S3lezhRo99
         2SJJXOutwKSq2aMUl8z+ueG5bmNky6VoYMVJ/7wep4kEHbZCUW/Pdc/Ltz0nQxnj8Ixp
         ghjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI7DzLD8o0ex3yOoVTwTTFvR2N8uAOwmDT53+rKeqf0VPPK6NuBw/LNf1w1ToU25SFYDAbIFnpQuNJQEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwX2+Hxucwab97eR3kjraKRHacY2Gx5udcMEBbz3TB+wfThb7g
	0mePbOLlZMOwLgciiK+UcJfA/f/55HKk2/A2QWNOnkFANRLUgBNjxl0YpNkfmMM=
X-Google-Smtp-Source: AGHT+IEjD0/PC0WO2GOqUMpTA2/eZmSm46TAshTjVAAAEN0En/GnWtBMyhgW+2LIQa8czyBy0jD9zw==
X-Received: by 2002:a05:600c:4707:b0:426:6f48:415e with SMTP id 5b1f17b1804b1-42c9f97b9ddmr28933705e9.1.1725804441252;
        Sun, 08 Sep 2024 07:07:21 -0700 (PDT)
Received: from localhost.localdomain ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc074599sm4863371a91.31.2024.09.08.07.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 07:07:20 -0700 (PDT)
From: Heming Zhao <heming.zhao@suse.com>
To: joseph.qi@linux.alibaba.com,
	glass.su@suse.com
Cc: Heming Zhao <heming.zhao@suse.com>,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ocfs2: adjust spinlock_t ip_lock protection scope
Date: Sun,  8 Sep 2024 22:07:05 +0800
Message-Id: <20240908140705.19169-4-heming.zhao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240908140705.19169-1-heming.zhao@suse.com>
References: <20240908140705.19169-1-heming.zhao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the spinlock_t ip_lock protection scopes are incorrect and
should follow the usage in 'struct ocfs2_inode_info'.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Reviewed-by: Su Yue <glass.su@suse.com>
---
 fs/ocfs2/dlmglue.c  | 3 ++-
 fs/ocfs2/inode.c    | 5 +++--
 fs/ocfs2/resize.c   | 4 ++--
 fs/ocfs2/suballoc.c | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index da78a04d6f0b..4a5900c8dc8f 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2232,6 +2232,8 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	else
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
 
+	spin_unlock(&oi->ip_lock);
+
 	i_uid_write(inode, be32_to_cpu(lvb->lvb_iuid));
 	i_gid_write(inode, be32_to_cpu(lvb->lvb_igid));
 	inode->i_mode    = be16_to_cpu(lvb->lvb_imode);
@@ -2242,7 +2244,6 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	inode_set_mtime_to_ts(inode, ts);
 	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_ictime_packed));
 	inode_set_ctime_to_ts(inode, ts);
-	spin_unlock(&oi->ip_lock);
 	return 0;
 }
 
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 2cc5c99fe941..4af9a6dfddd2 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1348,14 +1348,15 @@ void ocfs2_refresh_inode(struct inode *inode,
 		inode->i_blocks = 0;
 	else
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
+
+	spin_unlock(&OCFS2_I(inode)->ip_lock);
+
 	inode_set_atime(inode, le64_to_cpu(fe->i_atime),
 			le32_to_cpu(fe->i_atime_nsec));
 	inode_set_mtime(inode, le64_to_cpu(fe->i_mtime),
 			le32_to_cpu(fe->i_mtime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
 			le32_to_cpu(fe->i_ctime_nsec));
-
-	spin_unlock(&OCFS2_I(inode)->ip_lock);
 }
 
 int ocfs2_validate_inode_block(struct super_block *sb,
diff --git a/fs/ocfs2/resize.c b/fs/ocfs2/resize.c
index c4a4016d3866..b29f71357d63 100644
--- a/fs/ocfs2/resize.c
+++ b/fs/ocfs2/resize.c
@@ -153,8 +153,8 @@ static int ocfs2_update_last_group_and_inode(handle_t *handle,
 
 	spin_lock(&OCFS2_I(bm_inode)->ip_lock);
 	OCFS2_I(bm_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
-	le64_add_cpu(&fe->i_size, (u64)new_clusters << osb->s_clustersize_bits);
 	spin_unlock(&OCFS2_I(bm_inode)->ip_lock);
+	le64_add_cpu(&fe->i_size, (u64)new_clusters << osb->s_clustersize_bits);
 	i_size_write(bm_inode, le64_to_cpu(fe->i_size));
 
 	ocfs2_journal_dirty(handle, bm_bh);
@@ -564,8 +564,8 @@ int ocfs2_group_add(struct inode *inode, struct ocfs2_new_group_input *input)
 
 	spin_lock(&OCFS2_I(main_bm_inode)->ip_lock);
 	OCFS2_I(main_bm_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
-	le64_add_cpu(&fe->i_size, (u64)input->clusters << osb->s_clustersize_bits);
 	spin_unlock(&OCFS2_I(main_bm_inode)->ip_lock);
+	le64_add_cpu(&fe->i_size, (u64)input->clusters << osb->s_clustersize_bits);
 	i_size_write(main_bm_inode, le64_to_cpu(fe->i_size));
 
 	ocfs2_update_super_and_backups(main_bm_inode, input->clusters);
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 9e847f59c9ef..3f91615d8702 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -798,9 +798,9 @@ static int ocfs2_block_group_alloc(struct ocfs2_super *osb,
 
 	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
 	OCFS2_I(alloc_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
+	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
 	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
 					     le32_to_cpu(fe->i_clusters)));
-	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
 	i_size_write(alloc_inode, le64_to_cpu(fe->i_size));
 	alloc_inode->i_blocks = ocfs2_inode_sector_count(alloc_inode);
 	ocfs2_update_inode_fsync_trans(handle, alloc_inode, 0);
-- 
2.35.3



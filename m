Return-Path: <linux-kernel+bounces-313436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A259696A573
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 19:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498341F253C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427F618F2FB;
	Tue,  3 Sep 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QarRXygV"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A9818F2C3
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725384725; cv=none; b=EgMX7UHGwRVyBMKzTawcbKQIb7TYYiMHYjq4lAqD4JXlTOBXMVuJ/iEAT5TO3EX8XpTc37v/pIOYr2qgCXZIbFxBBZD0NH7uFinCFjEdJZcX9a3KwLdJ5F5ijjLuCcUqzboTHtVaLdGJ1JgZpScxwhN84a/pFPLyXDpHebURkVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725384725; c=relaxed/simple;
	bh=HPO+u0eTLt71GJhNmxu0GD7sZCcpV1Q/UVKkmIdT4s8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EDbj3DPUMD/ngmTlf8N19P2AB0oWWbvqtUaDxv6WuA6K9PwaArZra0ApnzAmkpfT6fPrtV9lWoqCost+spXuoKOWqJ6UiU6RD9g/+DwfpSS5gIr4eBhdW2AsR6VICbrVpudbnWygDexJW9LomQREa/BdzZpNRKMmflnXPM+EXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QarRXygV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fee6435a34so40283735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 10:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725384723; x=1725989523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvy2llSb6mhTG2xVJeP62lrOlUSxN0dZzizut/TXj4c=;
        b=QarRXygVqgyRYjAwLwOESfIFvLnDJzvZkCIltmCSx1xn8ra9grCbG5vlBQGCWl81Ct
         DixatiLyURtuzTHoxVKfnF8j4FLVuuVcuyHobKUgAn3C2DJPVOuYe92DjAeiVA/D58SD
         b7MHam7vgddtOYlKEGmQ/aa5lshNhtDfn7PnKOWq8Rbz+GoYv2NjsG/3avFzMhHN7YYb
         rn9ceXw6jkRViGsPXZ3Cf3VEf6CMpOPLpOY4Y4ZAxmIBXKoFz/433TB4ohe9qclU3nq6
         mnWO2HEou9Gx2VQcFIhQvSoK18sH3/IZFNPoRUIpUq46DwcoAZ0x87YbjBzES6uL/yvv
         MWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725384723; x=1725989523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvy2llSb6mhTG2xVJeP62lrOlUSxN0dZzizut/TXj4c=;
        b=erJk6Vwj6opPeIbibenxNIfoMRIB7poEvgOl/Fl7PI0ece/0/jGDJJobPvGm2Zf+ow
         S277KDgXhTjSqzHj//MWrTiq5uSt+EpjWc9aMyZx4f51KIsQ1Q9MbENO8ONldh/a3BK5
         UBzUixHLumnZk7/VZcNMTEfZqJThEii6z21eHrRJp91lfXIiVuRo6WB3btyAZVuPjw3C
         kI6+Cy85TPTAbVPepJSWQXr3XCQGPbL6xvcrfUTi/reQIHCXp8TTGpakemwE4uSl2WTv
         lmF2NP0dckUsYRikqUIkYjQ26SCOKGWNQC466Teuhnm/IpE2HfLcQE23mIbcGWdsM4yw
         V6vw==
X-Gm-Message-State: AOJu0YxoW0hJcBeX1iVktsg6wnUdBFsi2kLznxPboNdOC3GJtoJ+tlDw
	oWOfcf/7M+7JZWAtGGU1YKw8ic3sk8WLK+aj7vH+nV+b2v8A2f9wuytn7Q==
X-Google-Smtp-Source: AGHT+IFIahYBPcjte+YlQCLqeChmcbFhwZ4TuJKg3HWBf6QpcGikxjLUC7Zob7C2zcJdVqnVLILNog==
X-Received: by 2002:a17:902:d2c2:b0:205:51c9:49e3 with SMTP id d9443c01a7336-20699ae7b7dmr21553735ad.15.1725384723218;
        Tue, 03 Sep 2024 10:32:03 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2a00:79e0:2e14:7:368a:4513:19e2:ed23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae951617sm1098315ad.83.2024.09.03.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 10:32:02 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] mkfs.f2fs: use correct endian conversion for writing lpf inode
Date: Tue,  3 Sep 2024 10:31:57 -0700
Message-ID: <20240903173157.602995-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

The conversion between cpu and little endian is incorrect.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 mkfs/f2fs_format.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index c9d335a..30d8e19 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -1547,8 +1547,8 @@ static int f2fs_write_lpf_inode(void)
 
 	f2fs_init_inode(sb, raw_node, c.lpf_ino, mkfs_time, 0x41c0);
 
-	raw_node->i.i_pino = le32_to_cpu(sb->root_ino);
-	raw_node->i.i_namelen = le32_to_cpu(strlen(LPF));
+	raw_node->i.i_pino = sb->root_ino;
+	raw_node->i.i_namelen = cpu_to_le32(strlen(LPF));
 	memcpy(raw_node->i.i_name, LPF, strlen(LPF));
 
 	node_blkaddr = alloc_next_free_block(CURSEG_HOT_NODE);
-- 
2.46.0.469.g59c65b2a67-goog



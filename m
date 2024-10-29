Return-Path: <linux-kernel+bounces-387046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2029B4B26
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7352283C68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636120604E;
	Tue, 29 Oct 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgUAaKIe"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705FC205E12
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730209561; cv=none; b=Hkn6MiZ708zV7/ppI8ePyIvwdPg280cYc9OqV+TUuIlytTa64UdXMdqCYBOMJBLNw2w9AsvA7l5kAjkkG0+q/XJWZFefvSw+QQcVutYgyyLlNINpv282XMDzFV0q9YprkixZ0BFMOdOjuKH7tYrwr1jxeVWfsHnaXfJJZaSKUgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730209561; c=relaxed/simple;
	bh=EkVllNyrZ0LgrCxDm0F9eT6VgtTuZEnq1kvQxRNGjAI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FF6ui5/diTr3qRkbTAyJs74+fAk3r38cTcAS5R1ibYiQIBVLOPYvkBueRwRT+/j+4BnfTxQbbKrumZxBMtoperLHAGMSfvZ7bqc8pMvKgOsP77Tk4pWQnE4DFrP1AQzaOpAtG7s+ef1TmTYtOpRfqyRt3+62afzLCnioWBhYRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgUAaKIe; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c8c50fdd9so41942185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 06:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730209559; x=1730814359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DyKlJXEr9keHaOcYBjr3auPA6keraHgOZp7hXIzFnsc=;
        b=VgUAaKIezI+0uoVAxgFXaaVSAyBgVx7wRhTvzrcBxArlB6Gdv+bu4ES84MVxkWEDRF
         QQgtpgKexbGfjByA0z8vm9ahJJN+SVfdAblefndSxzdhFtwu3XWKklXcv1NU2ZQAVp2j
         djp0CD6qJJu8pSwXE/YCD/SlZJR1AMUJZkrUXxI4Uupgtn3T6W3QzHJRQ3i1JfJwxEdh
         NmXPrbWjy5SHWvCZBlXW6oz63AXDj8GiWP+yufgGhwlK7NtQM8ebjMYPTEWbk1TQrsTI
         APdM0r/c+W7ZmdP0TZUGHpDx5JKgudbN+BRxoDPopJgvQ5HwUsrSV0u0DHjf2vk/cRuK
         AAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730209559; x=1730814359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DyKlJXEr9keHaOcYBjr3auPA6keraHgOZp7hXIzFnsc=;
        b=sDRJAgU4O1UTQlAi79Crifz93q3jrgRzamRDThhpuPfkAL+PkJBkcoZTgIG3IRt4eX
         VFrZBi2D69Sjvi5JpTFd5A3uoRvzeLpcpI4ZF9QIBtEGGUcd/7IpTSdYSCqCYcMhHt85
         0JgyNQWd2aRIAk/BUQGA7vom4tp3Qem1wXbNXPxucJ4G0ic9v6a99hLXcs+lzEFWctym
         ea0H3Bjmr+vokSG+cWKcRI9MRrgKS0IAYrCfoefgvZmwHh7MvBnwjzNXTCtjdLWP/Oq3
         kYdBbDvT4Kv54V/kW1Nh1QEVWHP+fub4AZbU+Z5y3IeLcGxLHSW43ibVE3p9/ux//az9
         v6MA==
X-Forwarded-Encrypted: i=1; AJvYcCXqeLeoZ6Nbdyo7362WO0wWpI5Wwp4pUyvPSdzvNf5Zl7CqfZqXdbVcT68hnsbkaN/Bnx4gp+JhJ5l7iHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3Zu6yxtAjLsLnzYj2NdnbAA2BA5ofPQZr9Z8vz8Assd3m4aS
	ADrFZt4ou0onmd7nD5k+Eyvv1uZw/THsqnW2N0W2elYRo+oZgET0
X-Google-Smtp-Source: AGHT+IHaQmImiSAvmwcrgTR+a9jJroqanJ509E2/ohzIrAEtDJHGJHVUWI5GqnE5pF82suQcYJIiww==
X-Received: by 2002:a17:902:d511:b0:20c:f6c5:7f6c with SMTP id d9443c01a7336-210ed09e387mr32343895ad.16.1730209558621;
        Tue, 29 Oct 2024 06:45:58 -0700 (PDT)
Received: from DESKTOP-B5TBVBT.localdomain ([175.117.51.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6dd23sm66401285ad.92.2024.10.29.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 06:45:58 -0700 (PDT)
From: Yohan Joung <jyh429@gmail.com>
X-Google-Original-From: Yohan Joung <yohan.joung@sk.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	daeho43@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yohan Joung <yohan.joung@sk.com>
Subject: [PATCH v2] mkfs.f2fs: adjust zone alignment when using convention partition with zoned one
Date: Tue, 29 Oct 2024 22:45:51 +0900
Message-Id: <20241029134551.252-1-yohan.joung@sk.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When formatting conventional partition with zoned one, we are already
aligning the starting block address of the next device to the zone size.
Therefore, we do not align the segment0 address to the zone alignment.
This reduces the wasted zone_align_start_offset.

Test result
segment0 blkaddr 389583 -> 119251
Add one additional section to main

Signed-off-by: Yohan Joung <yohan.joung@sk.com>
---
 mkfs/f2fs_format.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index a01b19e..52a1e18 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -266,6 +266,7 @@ static int f2fs_prepare_super_block(void)
 	uint32_t log_sectorsize, log_sectors_per_block;
 	uint32_t log_blocksize, log_blks_per_seg;
 	uint32_t segment_size_bytes, zone_size_bytes;
+	uint32_t alignment_bytes;
 	uint32_t sit_segments, nat_segments;
 	uint32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
 	uint32_t total_valid_blks_available;
@@ -305,10 +306,12 @@ static int f2fs_prepare_super_block(void)
 
 	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
 
+	alignment_bytes = c.zoned_mode && c.ndevs > 1 ? segment_size_bytes : zone_size_bytes;
+
 	zone_align_start_offset =
 		((uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE +
-		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
-		zone_size_bytes * zone_size_bytes -
+		2 * F2FS_BLKSIZE + alignment_bytes  - 1) /
+		alignment_bytes  * alignment_bytes  -
 		(uint64_t) c.start_sector * DEFAULT_SECTOR_SIZE;
 
 	if (c.feature & F2FS_FEATURE_RO)
@@ -327,7 +330,8 @@ static int f2fs_prepare_super_block(void)
 
 	if (c.zoned_mode && c.ndevs > 1)
 		zone_align_start_offset +=
-			(c.devices[0].total_sectors * c.sector_size) % zone_size_bytes;
+			(c.devices[0].total_sectors * c.sector_size -
+			 zone_align_start_offset) % zone_size_bytes;
 
 	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
 	sb->cp_blkaddr = sb->segment0_blkaddr;
-- 
2.25.1



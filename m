Return-Path: <linux-kernel+bounces-388476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E99B6031
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C551C2132B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1651E47AB;
	Wed, 30 Oct 2024 10:32:26 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFFD1E2848
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284346; cv=none; b=BbU9/j4saAcMrMoNfYv4rkWcqIVr6XYxSB4YVSzOWogNN7i0vFFZNgpk75PQTATOV1Bu7LwWFoLekUFord8oadVm3zNHufYZUcnGihIK0UafNyQyGfHFoCaEylrRj78XnK/c2++z89CSiie2K8zAk1eyFCTDVyhilP+gD5xdIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284346; c=relaxed/simple;
	bh=JZ286Romoe06+GRgPc3jaV6GDufMbsUVU9Tunn0/Avc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wsuvkjp1kaKVdPXqfnNespTO18ZPgDWz+JA4BemICTZuiPk+hh2d7x8ufEkWkQH/RaRkSBXv0/JFde4eYZsh0ZUNTZTC618Cob8sJRYGTu6gOl8KaSpkARLkuK5Njh9WuacZzTyQeXHWnVNHQRJBkitaxawKdYcz3s/UgcoXOXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 49UAVfg6026716;
	Wed, 30 Oct 2024 18:31:41 +0800 (+08)
	(envelope-from Yi.Sun@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Xdk1M63kyz2KSK4X;
	Wed, 30 Oct 2024 18:31:03 +0800 (CST)
Received: from tj10379pcu1.spreadtrum.com (10.5.32.15) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 30 Oct 2024 18:31:39 +0800
From: Yi Sun <yi.sun@unisoc.com>
To: <chao@kernel.org>, <jaegeuk@kernel.org>
CC: <yi.sun@unisoc.com>, <sunyibuaa@gmail.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <niuzhiguo84@gmail.com>,
        <hao_hao.wang@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH v2 1/5] f2fs: blocks need to belong to the same segment when using update_sit_entry()
Date: Wed, 30 Oct 2024 18:31:32 +0800
Message-ID: <20241030103136.2874140-2-yi.sun@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030103136.2874140-1-yi.sun@unisoc.com>
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 49UAVfg6026716

When using update_sit_entry() to release consecutive blocks,
ensure that the consecutive blocks belong to the same segment.
Because after update_sit_entry_for_realese(), @segno is still
in use in update_sit_entry().

Signed-off-by: Yi Sun <yi.sun@unisoc.com>
---
 fs/f2fs/segment.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index bb2fd98331cd..a5bd101c63a1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2424,6 +2424,10 @@ static void update_segment_mtime(struct f2fs_sb_info *sbi, block_t blkaddr,
 		SIT_I(sbi)->max_mtime = ctime;
 }
 
+/*
+ * NOTE: when updating multiple blocks at the same time, please ensure
+ * that the consecutive input blocks belong to the same segment.
+ */
 static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_entry *se,
 				block_t blkaddr, unsigned int offset, int del)
 {
@@ -2434,6 +2438,8 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 	int i;
 	int del_count = -del;
 
+	f2fs_bug_on(sbi, GET_SEGNO(sbi, blkaddr) != GET_SEGNO(sbi, blkaddr + del_count - 1));
+
 	for (i = 0; i < del_count; i++) {
 		exist = f2fs_test_and_clear_bit(offset + i, se->cur_valid_map);
 #ifdef CONFIG_F2FS_CHECK_FS
@@ -2476,6 +2482,11 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
 	return del;
 }
 
+/*
+ * If releasing blocks, this function supports updating multiple consecutive blocks
+ * at one time, but please note that these consecutive blocks need to belong to the
+ * same segment.
+ */
 static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
 {
 	struct seg_entry *se;
-- 
2.25.1



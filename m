Return-Path: <linux-kernel+bounces-396333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEA9BCBCC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4621F24544
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B91D433C;
	Tue,  5 Nov 2024 11:26:28 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1258B1D278B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805987; cv=none; b=QTD7+YrIOTTw7isFqrc2iONde8NtFXybH8MC/T6/cn7aFFMGMP7+NDskY+AR933mGU4gL6Ipdg43fu1pyiRpu5Lqq5LDiqz+M75x0AiTetr7UDK98k0TrCNkbooRaExp3UBvVaG3GYShIBSlVzMseEjzJagx0qr1vL1j5+LDRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805987; c=relaxed/simple;
	bh=znysl6BessbMmRT8GfxzzouQHjzhuK+LQlHJgj53lAQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/A82gMMNomVnBK636TOBtVOqTgcq1Xnf/3XGRQ0LOjc5eABkdnfkrfteBZrQjkvoJE1rDjchswmwPSL9VFnMUA39QI94jCqPrVUdsiw5RE6oqW6bMl9D1RkiO29dnFS4Vx5iBVzObpumRqPZUTU468oQwX81FvzWo2y9TboPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4A5BPZF4017984;
	Tue, 5 Nov 2024 19:25:35 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XjQwY3Vqfz2KGZ03;
	Tue,  5 Nov 2024 19:24:45 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 5 Nov 2024 19:25:32 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <Hao_hao.Wang@unisoc.com>
Subject: [PATCH] mkfs.f2fs: adjust zone alignment check to correct position
Date: Tue, 5 Nov 2024 19:25:05 +0800
Message-ID: <1730805905-31895-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 4A5BPZF4017984

Should check after c.devices[1].start_blkaddr is assigned
if c.ndevs > 1.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 mkfs/f2fs_format.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 52a1e18..f7cfa5e 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -339,17 +339,6 @@ static int f2fs_prepare_super_block(void)
 	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n",
 					get_sb(segment0_blkaddr));
 
-	if (c.zoned_mode &&
-		((c.ndevs == 1 &&
-			(get_sb(segment0_blkaddr) + c.start_sector /
-			DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) ||
-		(c.ndevs > 1 &&
-			c.devices[1].start_blkaddr % c.zone_blocks))) {
-		MSG(1, "\tError: Unaligned segment0 block address %u\n",
-				get_sb(segment0_blkaddr));
-		return -1;
-	}
-
 	for (i = 0; i < c.ndevs; i++) {
 		if (i == 0) {
 			c.devices[i].total_segments =
@@ -390,6 +379,18 @@ static int f2fs_prepare_super_block(void)
 
 		c.total_segments += c.devices[i].total_segments;
 	}
+
+	if (c.zoned_mode &&
+		((c.ndevs == 1 &&
+			(get_sb(segment0_blkaddr) + c.start_sector /
+			DEFAULT_SECTORS_PER_BLOCK) % c.zone_blocks) ||
+		(c.ndevs > 1 &&
+			c.devices[1].start_blkaddr % c.zone_blocks))) {
+		MSG(1, "\tError: Unaligned segment0 block address %u\n",
+				get_sb(segment0_blkaddr));
+		return -1;
+	}
+
 	set_sb(segment_count, c.total_segments);
 	set_sb(segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
 
-- 
1.9.1



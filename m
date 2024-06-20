Return-Path: <linux-kernel+bounces-222157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CBE90FDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FCFA2827F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05AC44C64;
	Thu, 20 Jun 2024 07:24:49 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5A343AD7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718868289; cv=none; b=CafBJbbSSw45bcZKnsOTPqfCEsv/2MJGDjvq76/4U8WWdGu6ZmKcE82UnHg1S2RmGDMO5rGtaLvGVmF5+grWrFBF7MidJmQJL2OiicfDdZqcUcbkAi1gP5XD3umeu6fBjvkgZLfZIh/xmfqxMKfDo/Ae/wkkUp050nrkGXC5l6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718868289; c=relaxed/simple;
	bh=IbrkkFZWWTxxP6bNNA097pRVO/TYakHzhCNen4t71Ak=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=trppWY0Gx9ppQV0ioF3TAS6Pbi8rjwMD8RGGIHiSPhKNXpeDnYW9vuuv5JLHZmcSUVkrfZg0ABbpUnkgtPJvCGnk/LZKYUmKk1uCWBAc6nm1GNHJTfF4o3Fy+FeYT8BHLJkNelqO8Kp6vXyfzZRWeogrzhPRTtEFj9C2ULRlZGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (178.205.54.237) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 20 Jun
 2024 10:24:36 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: Jan Kara <jack@suse.com>, <linux-kernel@vger.kernel.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH v2] udf: balloc: prevent integer overflow in udf_bitmap_free_blocks()
Date: Thu, 20 Jun 2024 10:24:13 +0300
Message-ID: <20240620072413.7448-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 06/20/2024 06:58:34
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 186022 [Jun 20 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	178.205.54.237:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.205.54.237
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/20/2024 07:03:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/20/2024 1:26:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

An overflow may occur if the function is called with the last
block and an offset greater than zero. It is necessary to add
a check to avoid this.

Overflow is also possible when we sum offset and
sizeof(struct spaceBitmapDesc) << 3. For this reason it
is necessary to check overflow of this too. The result is
stored in total_offset.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Suggested-by: Jan Kara <jack@suse.com>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 V1 -> V2: Overflow checks have been replaced by functions

 fs/udf/balloc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949..4bf2720111f1 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -18,6 +18,7 @@
 #include "udfdecl.h"
 
 #include <linux/bitops.h>
+#include <linux/overflow.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -133,6 +134,7 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long bit;
+	unsigned int total_offset;
 	unsigned long i;
 	int bitmap_nr;
 	unsigned long overflow;
@@ -140,17 +142,20 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	mutex_lock(&sbi->s_alloc_mutex);
 	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
 	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
+	    (bloc->logicalBlockNum + count) > partmap->s_partition_len ||
+	    check_add_overflow(offset,
+			       sizeof(struct spaceBitmapDesc) << 3, &total_offset) ||
+	    check_add_overflow(bloc->logicalBlockNum, total_offset, &block)) {
+		udf_debug("%u < %d || %u + %u > %u || %u + %zu > %u || %u + %u + %zu > %u\n",
 			  bloc->logicalBlockNum, 0,
 			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
+			  partmap->s_partition_len,
+			  offset, sizeof(struct spaceBitmapDesc) << 3, UINT_MAX,
+			  bloc->logicalBlockNum, offset,
+			  sizeof(struct spaceBitmapDesc) << 3, UINT_MAX);
 		goto error_return;
 	}
 
-	block = bloc->logicalBlockNum + offset +
-		(sizeof(struct spaceBitmapDesc) << 3);
-
 	do {
 		overflow = 0;
 		block_group = block >> (sb->s_blocksize_bits + 3);
-- 
2.34.1



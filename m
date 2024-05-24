Return-Path: <linux-kernel+bounces-188410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2E8CE1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7BCF1F22414
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7041292C3;
	Fri, 24 May 2024 07:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="X8580v1W"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE944C6E
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536489; cv=none; b=hSQxESrdOEnoJnW9D6fnAuiec2KxU2ETBw2Bp2ZG19NbSfOavCiTHrmxhhYejEiH3N5T207+GFtl8T9hSmh93umbzhP4E8SRYl0Wyd7cbeR7YDhLbuTU2PEkmiH743Rtffj15hzvqnOpZ2xznJgVvkems+zsX1hkGpq/RspxK60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536489; c=relaxed/simple;
	bh=ozll6qRziq35PAG1YBIEGMLw6nDofgS/piP4h49p9Ek=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VLzPb3A38MHoL09fBF8ZjEhsNPBBGMytUr/2E/CH0xs+R5O7RV0p6l5ylKypqrhAGrrVFYpwF9G+hIu6USWRTfeXFQTOqUaRsnVLEmmrrxR7dYslzFG3EeunDoPe5L6oDc3w1PsdNbeVD3WEhSyt/KQWJI/arFcvj5VizCsV1sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=X8580v1W; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716536483; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CVF9HV5OIB/RrlM1U638eXjEEYFYuWvTgJEt/6k4K4w=;
	b=X8580v1Wc5hUPAc4GCoRaLTw+u5pbchD4BHymuyTLLHqZ2E+4TThj30DX7KRjXx0CzBquQM6GzcpcH7fJD2iglz4Fou0riRmMSu8FCTVDklZbEvAyejK/7sycilF/wlAwHDeDKigQwCJkm8qWDTZlM/LpnvIrINJ3lUhjaEQ7s0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W761soU_1716536471;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W761soU_1716536471)
          by smtp.aliyun-inc.com;
          Fri, 24 May 2024 15:41:23 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] dm vdo indexer: Use swap() instead of open coding it
Date: Fri, 24 May 2024 15:41:09 +0800
Message-Id: <20240524074109.13433-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

/drivers/md/dm-vdo/indexer/index.c:207:43-44: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9173
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/md/dm-vdo/indexer/index.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/md/dm-vdo/indexer/index.c b/drivers/md/dm-vdo/indexer/index.c
index 1ba767144426..df4934846244 100644
--- a/drivers/md/dm-vdo/indexer/index.c
+++ b/drivers/md/dm-vdo/indexer/index.c
@@ -197,15 +197,12 @@ static int finish_previous_chapter(struct uds_index *index, u64 current_chapter_
 static int swap_open_chapter(struct index_zone *zone)
 {
 	int result;
-	struct open_chapter_zone *temporary_chapter;
 
 	result = finish_previous_chapter(zone->index, zone->newest_virtual_chapter);
 	if (result != UDS_SUCCESS)
 		return result;
 
-	temporary_chapter = zone->open_chapter;
-	zone->open_chapter = zone->writing_chapter;
-	zone->writing_chapter = temporary_chapter;
+	swap(zone->open_chapter, zone->writing_chapter);
 	return UDS_SUCCESS;
 }
 
-- 
2.20.1.7.g153144c



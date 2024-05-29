Return-Path: <linux-kernel+bounces-193349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B485A8D2AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5774A284C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 02:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CFE15AD9A;
	Wed, 29 May 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HRSdr8mM"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D4226AF3
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 02:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716948762; cv=none; b=RFTcCk39zRARsHawq7Zhs1m0iAHFJ8Pht1kqz7zi13nnudTf6DWgA6YLC7c3YfUYKvQ95Afats0ILBBFJC03mXJ7S+AdeVslViKV8AgDMXaNTm1pWFMAuDMhLz8MQo4fHO3gm4gFMhgRPZzrWFCFkHu2k9bzTkOfGlB3tJZ8z+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716948762; c=relaxed/simple;
	bh=QfND/PD5GrGnKbwK+0FJycGdhW/D1Jmpc9axx2H3JGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pl4bKONjhLoWDfU/F/QmNKWKSZbTFdRIleeJ2vELDKGZn02TBMDdiKPFzMb6ubuhGGc+KanAoeNAvRpX8FWSA177BmTmtOxshaGwyCrUi5Bu+Qy3xRkJjAw6ofc6jpqcMDQnO6nZ0Z5ag/hsOyc6B2Xs9Kq/f+a+2Yl70RKoHgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HRSdr8mM; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716948758; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=diY8Yj7pHCeARPPadn/ZK5HGSeSyGpgtjlSUI3jYyZ0=;
	b=HRSdr8mMfWr05qLRrX6BLm+pP+7kF9OE4rSYN8i5m2jXnjGNEpNxfLwuBAkPWv1Z7k43UbydWcSeolENWNBZHXvPDJpvFAOYZdErGGB4PGc1HlQbxSRaagVMCli+y5f8j5vYWfe4lVCEAeGHnqN4RudTCFD001S7STNZ1GouTp4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W7RADWX_1716948752;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W7RADWX_1716948752)
          by smtp.aliyun-inc.com;
          Wed, 29 May 2024 10:12:37 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: msakai@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH v2] dm vdo indexer: Use swap() in swap_open_chapter()
Date: Wed, 29 May 2024 10:12:31 +0800
Message-Id: <20240529021231.21043-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing swap() function rather than duplicating its implementation.

/drivers/md/dm-vdo/indexer/index.c:207:43-44: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9173
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -Amend commit message to make it more clear.

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



Return-Path: <linux-kernel+bounces-302523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447FA95FFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E109E1F22C12
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D943173;
	Tue, 27 Aug 2024 03:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3M/7EXu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5220C18AE4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724728956; cv=none; b=dd8yCm0niRp2jJZ/jY7Kp4BpA4+isBaKN3bKfkLwJgSiM1LqVJpsTbcG1m3ClairMvcpASqzHUl3Kv+UCP2egEFu4JYx5sYg3SSQ5cP8X21OsbD8rSIQ7Jrtgawd32U6iISXbsi+t3DxjYGz6gQEM1u4EqlnGAIv7z8ULkO7Ygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724728956; c=relaxed/simple;
	bh=/D2vwv/64+Wo6vRiH+gmdk/WGQELlQ8jiYn+frqm9cg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZuoBTDvIGADr+3b7kk/r7e4jXPlQLRO0tCBMXbi09urH/oaQoWCcxj8L0cvs8LhsW2hwuuEMzVJPlhrrTSw1upEaftHym1KY2aG6elILVt3viHXG1yJ6i+BWiE6YW2Oax2yjcKw45noDsCFsm1JFIaslyNjDNmzaFnM+c4HuSXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U3M/7EXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724728953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WJP8yFKVfmMC38Dqp+UxkP7D8GdYask1IZvdrXmNh4s=;
	b=U3M/7EXuqtLKM0ztAy7DkXRhQ4bI9di062D00jqiHBjj19N9tyYkSNP+eKxSkL8zjeUgdE
	0CPSq9ul52fd1aWvzCHe5k+veuFPiYVC91PMGWNZK5YveGOzQRsENZL4ZdtBHzEDq8rAuV
	2VIJpllCqXzWtOsic2ZAU2bS6Nanbtg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-chjdbgOHPlGVwVBpb2OtLg-1; Mon,
 26 Aug 2024 23:22:29 -0400
X-MC-Unique: chjdbgOHPlGVwVBpb2OtLg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01FEA1955F40;
	Tue, 27 Aug 2024 03:22:28 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10EDB3001FC3;
	Tue, 27 Aug 2024 03:22:23 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: linux-kernel@vger.kernel.org,
	ltp@lists.linux.it
Cc: Jan Stancek <jstancek@redhat.com>,
	John Garry <john.g.garry@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] loop: Increase bsize variable from unsigned short to unsigned int
Date: Tue, 27 Aug 2024 11:22:18 +0800
Message-ID: <20240827032218.34744-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This change allows the loopback driver to handle larger block sizes
and increases the consistency of data types used within the driver.
Especially to mactch the struct queue_limits.logical_block_size type.

Also, this is to get rid of the LTP/ioctl_loop06 test failure:

  12 ioctl_loop06.c:76: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
  13 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly
  ...
  18 ioctl_loop06.c:76: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
  19 ioctl_loop06.c:59: TFAIL: Set block size succeed unexpectedly

Link: https://lists.linux.it/pipermail/ltp/2024-August/039912.html
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: John Garry <john.g.garry@oracle.com>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/block/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 78a7bb28defe..86cc3b19faae 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -173,7 +173,7 @@ static loff_t get_loop_size(struct loop_device *lo, struct file *file)
 static bool lo_bdev_can_use_dio(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
-	unsigned short sb_bsize = bdev_logical_block_size(backing_bdev);
+	unsigned int sb_bsize = bdev_logical_block_size(backing_bdev);
 
 	if (queue_logical_block_size(lo->lo_queue) < sb_bsize)
 		return false;
@@ -977,7 +977,7 @@ loop_set_status_from_info(struct loop_device *lo,
 	return 0;
 }
 
-static unsigned short loop_default_blocksize(struct loop_device *lo,
+static unsigned int loop_default_blocksize(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
 	/* In case of direct I/O, match underlying block size */
@@ -986,7 +986,7 @@ static unsigned short loop_default_blocksize(struct loop_device *lo,
 	return SECTOR_SIZE;
 }
 
-static int loop_reconfigure_limits(struct loop_device *lo, unsigned short bsize)
+static int loop_reconfigure_limits(struct loop_device *lo, unsigned int bsize)
 {
 	struct file *file = lo->lo_backing_file;
 	struct inode *inode = file->f_mapping->host;
-- 
2.46.0



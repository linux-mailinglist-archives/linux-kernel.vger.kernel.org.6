Return-Path: <linux-kernel+bounces-303428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B6960BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122101C22F71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212321C2DB6;
	Tue, 27 Aug 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ag+wjooH"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A521BFDF3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765016; cv=none; b=ZMzf7jKx09XseKIyNggHu3ScLUlNygQ+gjinBCRrCYV+WxHKtVt+fQ9F22zYZVwSNpbrMNVTLteJv6nPn1wfc6UpW/TcGRxLcdhwM4PNm1Pn/NxCk4RngIAAASaeaGN06/iUQEYUY0WxS95IcZTgf1XBiq8p5J+QJ61EBOaRqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765016; c=relaxed/simple;
	bh=TElX4HxnkwI4RQCb6gi/mblVTqor6mf6ODFjQboIc8A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=craKhe6T953igeH+8dSDE2UrVN08Le2KTTIvBVL/q3Mm5TR4iESR+zUbvkNNkdl0Mwu3ca8o9bo3XaRp3+LbGRm5JzJw8whJAHZDq0UfTIAC/wQeY3tbrun+qLmB3mIDkCT21PsjUzGOred7n+1tImlBZUTfuhHWpwABPa63wPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ag+wjooH; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724765015; x=1756301015;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=62szxidneznjILbAIpV8/I7PRmxZEtb/XE12nVr2RDA=;
  b=ag+wjooHwOmxJyH/r+2tjKzr57dhpcRm2nSaH/KymEgzonw/2GH9gvCZ
   8bx3NfuaHNUWWRGr+J2rxtqmPghSAwwNbIOCXX/C72qnPbebyMP/WYUcL
   N8Y7GU9cqmmTLm/NGVbSUkEu46x17VpYpVPGtoaIoGwYVAYnh/deKoXGk
   s=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="655093382"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:23:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:30580]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.83:2525] with esmtp (Farcaster)
 id 992ff484-32b4-404e-8bfe-5b8840fc9acd; Tue, 27 Aug 2024 13:23:30 +0000 (UTC)
X-Farcaster-Flow-ID: 992ff484-32b4-404e-8bfe-5b8840fc9acd
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 13:23:29 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 27 Aug 2024 13:23:29 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 536B320A60; Tue, 27 Aug 2024 13:23:29 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>
Subject: [PATCH v2] nvme: check if the namespace supports metadata in nvme_map_user_request()
Date: Tue, 27 Aug 2024 13:23:27 +0000
Message-ID: <20240827132327.1704-1-pjy@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On an NVMe namespace that does not support metadata, it is possible to
send an IO command with metadata through io-passthru.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward.

Reject an IO command with metadata when the NVMe namespace doesn't
support it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
---
V1: https://lore.kernel.org/all/20240827121701.48792-1-pjy@amazon.com/
Changes in V2:
- Add a flag called 'has_metadata' and use it for the support check and
also for the check before calling bio_integrity_map_user()
---
 drivers/nvme/host/ioctl.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..74d963d425c4 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2017-2021 Christoph Hellwig.
  */
 #include <linux/bio-integrity.h>
+#include <linux/blk-integrity.h>
 #include <linux/ptrace.h>	/* for force_successful_syscall_return */
 #include <linux/nvme_ioctl.h>
 #include <linux/io_uring/cmd.h>
@@ -119,9 +120,13 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool has_metadata = bdev && meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	int ret;
 
+	if (has_metadata && !blk_get_integrity(bdev->bd_disk))
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -143,15 +148,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		goto out;
 
 	bio = req->bio;
-	if (bdev) {
+	if (bdev)
 		bio_set_dev(bio, bdev);
-		if (meta_buffer && meta_len) {
-			ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
-						     meta_seed);
-			if (ret)
-				goto out_unmap;
-			req->cmd_flags |= REQ_INTEGRITY;
-		}
+
+	if (has_metadata) {
+		ret = bio_integrity_map_user(bio, meta_buffer, meta_len,
+					     meta_seed);
+		if (ret)
+			goto out_unmap;
+		req->cmd_flags |= REQ_INTEGRITY;
 	}
 
 	return ret;
-- 
2.40.1



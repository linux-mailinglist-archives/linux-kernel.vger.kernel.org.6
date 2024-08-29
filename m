Return-Path: <linux-kernel+bounces-307009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25549646C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B24D280C29
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4D71AB500;
	Thu, 29 Aug 2024 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OjBWIrjm"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625C1A4ADE
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938364; cv=none; b=jIaSa3S2GFEXPutBbvlV6+5HCKEKscbJ3RvrZEnXKCIOBGcMvw44mK+HPiHSBuEpOm/KFX2RLgB2lsC0vmLAmvtqUoms5VfmLmLCpF8gLObJXp4hQv4ZjMlkF7vTMVjJdaEUT0Mc2hUW8J0jvKDZYyk0eDzB1uhLTtOUojFkHnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938364; c=relaxed/simple;
	bh=+5sQGoX5bZXTlDFYHn/Ahl4DzZDpeBVWimbRq4RLSaQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j2klhOqQLK7N59TbebRosjbrQdE4j8JyO9URbLdqFm33KX02shWF5EAVePJYbUg59bV9fbQUv5jgteLlXga4zauHSlaAMlh7heAl7zJ8lLJjHN6bOxJpdt7/wZC/4ugpXdnW/37V5U4pmq0Ud13Mlopp4ET76jiOqJbPban+nGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OjBWIrjm; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724938363; x=1756474363;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vvr7g01Sw9GYgNz0LoAAg4T3ibT+u+jm1p9VxTddzJ8=;
  b=OjBWIrjmYKi1v1rhLMyHS5wbSd7fBe/AHwLKV5HOvoH2HXd9HQ9zamct
   LiilzH8BIfhuPRj9gScvUZS5XNxDK9Iq4sX3TkJpMX95Pa4e9Py7amyWp
   OG1/f2VvSsHPes2RbF1htkTPPw3nN57Paqmmdu+3/MH1d0fKgiFnIeZzI
   I=;
X-IronPort-AV: E=Sophos;i="6.10,185,1719878400"; 
   d="scan'208";a="448725231"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:32:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:31780]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.120:2525] with esmtp (Farcaster)
 id 52e6a62b-1635-4469-8507-9256d931fde3; Thu, 29 Aug 2024 13:32:36 +0000 (UTC)
X-Farcaster-Flow-ID: 52e6a62b-1635-4469-8507-9256d931fde3
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.218) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 29 Aug 2024 13:32:36 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Thu, 29 Aug 2024 13:32:36 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 0277A20836; Thu, 29 Aug 2024 13:32:35 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>, <amazon-linux-kernel@amazon.com>
Subject: [PATCH v3] nvme: fix metadata handling in nvme-passthrough
Date: Thu, 29 Aug 2024 13:32:17 +0000
Message-ID: <20240829133217.1627-1-pjy@amazon.com>
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
send an IO command with metadata through io-passthru. This allows issues
like [1] to trigger in the completion code path.
nvme_map_user_request() doesn't check if the namespace supports metadata
before sending it forward. It also allows admin commands with metadata to
be processed as it ignores metadata when bdev == NULL and may report
success.

Reject an IO command with metadata when the NVMe namespace doesn't
support it and reject an admin command if it has metadata.

[1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Puranjay Mohan <pjy@amazon.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
---
V2: https://lore.kernel.org/all/20240827132327.1704-1-pjy@amazon.com/
Changes in V3
- Reject admin commands with metadata by also failing if there's no bdev

V1: https://lore.kernel.org/all/20240827121701.48792-1-pjy@amazon.com/
Changes in V2:
- Add a flag called 'has_metadata' and use it for the support check and
also for the check before calling bio_integrity_map_user()
---
 drivers/nvme/host/ioctl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..15c93ce07e26 100644
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
@@ -119,9 +120,14 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct request_queue *q = req->q;
 	struct nvme_ns *ns = q->queuedata;
 	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	bool supports_metadata = bdev && blk_get_integrity(bdev->bd_disk);
+	bool has_metadata = meta_buffer && meta_len;
 	struct bio *bio = NULL;
 	int ret;
 
+	if (has_metadata && !supports_metadata)
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
@@ -143,15 +149,15 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
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



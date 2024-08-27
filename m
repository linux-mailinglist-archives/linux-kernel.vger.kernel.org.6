Return-Path: <linux-kernel+bounces-303259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD599609D0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F63282965
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA01A0B16;
	Tue, 27 Aug 2024 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rzu8dZZU"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54151A0B05
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761031; cv=none; b=qg3q4iON8T9WYRRzL1Wugcg9nblRQGo121/VwR4gsKagokDpfHMMPIR5RMeiRLtoW1Rws+JFCY/wPPRtmXhQfG0FfzpDDuC60Stdb8gC1BavqSSuQYVEHuJfOsPP9+2ODGC4VGQBxpp4N+AUBSI+7ynE2BMQ3dZH+EwkrhItU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761031; c=relaxed/simple;
	bh=lGL6BVVAgZ1BC81ipDjzzBIycKNk69Qm0sP3C87QfOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uugg9/vD8DZb1fFr3+yTuEHE08p7fHoUZIMAb8dQpjTacGT0/9a61UkvD3umS58fSHzUVzikKYsjPS0FlRSD8KgJRPlkba5R3cV1rnZhT/OsMjRvMasolmw/EZopj1do+eWteEridjBeiQ+55i5HcpEw0uGkjoJZU0yjpW8LgKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rzu8dZZU; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1724761030; x=1756297030;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZafkTBMgG7yzSjlIbdpVuKXbZLWp3xe1QfVap/dPy0=;
  b=rzu8dZZUtmHeEcM0sYw1hh282b8WGBqLAzX5p4dkXIHwrE2E5K7IK5NP
   z8MJQaYFXj5V0fstbFItOeyFUh4SMqOB9k0meL3QFypQ8ja3pUwR2syHp
   NqM8ysHUOCIT+lUYuMVszuqDvKH5M9Llcygyvkw/vrqc3cnU0jDEIJfFO
   k=;
X-IronPort-AV: E=Sophos;i="6.10,180,1719878400"; 
   d="scan'208";a="419835842"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 12:17:05 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:55652]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.67:2525] with esmtp (Farcaster)
 id f7dbd5e8-420e-40fc-b1d5-d92734efcffa; Tue, 27 Aug 2024 12:17:04 +0000 (UTC)
X-Farcaster-Flow-ID: f7dbd5e8-420e-40fc-b1d5-d92734efcffa
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 27 Aug 2024 12:17:03 +0000
Received: from dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (10.15.97.110) by
 mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP Server id
 15.2.1258.34 via Frontend Transport; Tue, 27 Aug 2024 12:17:03 +0000
Received: by dev-dsk-pjy-1a-76bc80b3.eu-west-1.amazon.com (Postfix, from userid 22993570)
	id 6351F20A60; Tue, 27 Aug 2024 12:17:03 +0000 (UTC)
From: Puranjay Mohan <pjy@amazon.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<puranjay@kernel.org>
Subject: [PATCH] nvme: check if the namespace supports metadata in nvme_map_user_request()
Date: Tue, 27 Aug 2024 12:17:01 +0000
Message-ID: <20240827121701.48792-1-pjy@amazon.com>
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
 drivers/nvme/host/ioctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..4f49523b8a41 100644
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
@@ -122,6 +123,9 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 	struct bio *bio = NULL;
 	int ret;
 
+	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
+		return -EINVAL;
+
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
 
-- 
2.40.1



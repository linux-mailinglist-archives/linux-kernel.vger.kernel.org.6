Return-Path: <linux-kernel+bounces-253074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83546931C03
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 22:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0981F22A5E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 20:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED4213BAE9;
	Mon, 15 Jul 2024 20:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCU6xqaB"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1151474BA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 20:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721075697; cv=none; b=WkZBCKOqcALbF9SdGSqMDQkL6VZS1vmo8gHcoyJh8e2tv81b1BmKO83bG2OtgkNAzY3EQJTSURd+77B0KZ3yPL0BVphWwk3JuekkF4aS0OLDWmhf85BOXuAGDE15Ku5gpcMk4b3Wl/85tiASJw08RTjJk1XsDBinr922NfWqET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721075697; c=relaxed/simple;
	bh=LEmmOUa4aRbg7vp7GfbmTYy+HD/6H+0+xVgYqaxtbko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AC8ComuenvPFBTVBVhstZX+x3UQE153Ged7tAj9/OFqHyutUbhQDhxxyNjUsk8wjrGz2oG3tNzTZsjEg8P82tk+CWut/zGAfreBJ8yjMY35OPTv8SY7nCYe2jb9oBQ8Gd1+Pc8F3cy+VUeIUyTInl4M+so5jF8k+f/8BRX/gYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCU6xqaB; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ce739c2650so1440723eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 13:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721075694; x=1721680494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPy1Prb3o/wWG7uB8U3QbnRbpD5QzxAKY8DdzWegWFo=;
        b=CCU6xqaBrOk1nraBpsUvLXr4lGgC6QV+sIMjqRNDUwVpgD7MJpklEJlZ0SYSR4BfqT
         y3TsHxS4o00CPcwZ4rfKTWwri5n9gzoxV8JCfOxrByItV4KLnhiGZ/I4eJFbBKhM+lk/
         XK+97HofuT4JFX4G6TS4QJYDIBG3rQMCXcwNiIoYpbq89JEvrJCpWLv+/8+cocWRJ6DT
         8iH5Eb5IU/Vq+WawQjsIdtuWF8TtdC+hXHFlUGIp1zt1Qw2L9+pGu501LZDOFzAxWBxq
         KAaIrSG8pNSvzZJOy/oJ9DuNpGrTemLcGW5QEoImfYeauFZfMbVPztWAmo0bBq2XAvUp
         fmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721075694; x=1721680494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPy1Prb3o/wWG7uB8U3QbnRbpD5QzxAKY8DdzWegWFo=;
        b=EAO6wdKwmF8aImIXk7+Hd24X5PTdUgTXJHYVcXIBjLIVrEzeNnG0+O1C5sUhu3ZSwi
         0oaqwFEj6JoMEoig22vuKJBwry9KZfg8v4ZGDm+sYLaGC0au/hqrVxCd2EPSXY14CPJf
         9/HHArfwk05ySUMfwLe8rQpmNmcGOppF9/vjXLUMPq5zZkAb6jISRbHs4CCEJe6Svb/E
         NVRYrHnGl1hwHqbxeUPs7FEphVPMU/s6qA1sUdN/IYjB33fVkohDSVkvEIIqwtEYX6cl
         BApUk0r1BXdIpIiyJlKRhB/DBpOdSUYCeWBnvfoqXI+kKRPxrZJ/2+ThHiBm9aD+s6Ub
         X2og==
X-Gm-Message-State: AOJu0YzJdxsMf80Sa1cRJy6RnM9N6pLKEcx55oNzChhlcY19tag+Vpqn
	3CABs5P107IlF7kcDWcmVPPNVoL9c8d374paIkTeMY/P2KAYHLfwcKnYNg==
X-Google-Smtp-Source: AGHT+IE6XxAFdXsCIWG6g2uleZwXjz/PFwt6XjQ9OINa09RHACSB+Iu7+vdSuK+BT1XoIF2MZkuHXg==
X-Received: by 2002:a05:6870:8881:b0:25e:11f4:f694 with SMTP id 586e51a60fabf-25eae7f7a46mr17565601fac.21.1721075694251;
        Mon, 15 Jul 2024 13:34:54 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-260752a9036sm1099316fac.38.2024.07.15.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 13:34:53 -0700 (PDT)
From: Stuart Hayes <stuart.w.hayes@gmail.com>
To: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v3] nvme_core: scan namespaces asynchronously
Date: Mon, 15 Jul 2024 15:34:34 -0500
Message-Id: <20240715203434.20212-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use async function calls to make namespace scanning happen in parallel.

Without the patch, NVME namespaces are scanned serially, so it can take
a long time for all of a controller's namespaces to become available,
especially with a slower (TCP) interface with large number of
namespaces.

It is not uncommon to have large numbers (hundreds or thousands) of
namespaces on nvme-of with storage servers.

The time it took for all namespaces to show up after connecting (via
TCP) to a controller with 1002 namespaces was measured on one system:

network latency   without patch   with patch
     0                 6s            1s
    50ms             210s           10s
   100ms             417s           18s

Measurements taken on another system show the effect of the patch on the
time nvme_scan_work() took to complete, when connecting to a linux
nvme-of target with varying numbers of namespaces, on a network of
400us.

namespaces    without patch   with patch
     1            16ms           14ms
     2            24ms           16ms
     4            49ms           22ms
     8           101ms           33ms
    16           207ms           56ms
   100           1.4s           0.6s
  1000          12.9s           2.0s

On the same system, connecting to a local PCIe NVMe drive (a Samsung
PM1733) instead of a network target:

namespaces    without patch   with patch
     1            13ms           12ms
     2            41ms           13ms

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
changes from V2:
  * make a separate function nvme_scan_ns_async() that calls
    nvme_scan_ns(), instead of modifying nvme_scan_ns()
  * only scan asynchronously from nvme_scan_ns_list(), not from
    nvme_scan_ns_sequential()
  * provide more timing data in the commit message

changes from V1:
  * remove module param to enable/disable async scanning
  * add scan time measurements to commit message


 drivers/nvme/host/core.c | 48 +++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc1..dbf05cfea063 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -3952,6 +3953,30 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 }
 
+/*
+ * struct async_scan_info - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @next_idx:	Index of next NSID to scan in ns_list
+ * @ns_list:	Pointer to list of NSIDs to scan
+ */
+struct async_scan_info {
+	struct nvme_ctrl *ctrl;
+	atomic_t next_idx;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
+{
+	struct async_scan_info *scan_info = data;
+	int idx;
+	u32 nsid;
+
+	idx = (u32)atomic_fetch_add(1, &scan_info->next_idx);
+	nsid = le32_to_cpu(scan_info->ns_list[idx]);
+
+	nvme_scan_ns(scan_info->ctrl, nsid);
+}
+
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
@@ -3975,12 +4000,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 {
 	const int nr_entries = NVME_IDENTIFY_DATA_SIZE / sizeof(__le32);
-	__le32 *ns_list;
+	struct async_scan_info scan_info;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
 
-	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
-	if (!ns_list)
+	scan_info.ctrl = ctrl;
+	scan_info.ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
+	if (!scan_info.ns_list)
 		return -ENOMEM;
 
 	for (;;) {
@@ -3990,28 +4017,33 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			.identify.nsid		= cpu_to_le32(prev),
 		};
 
-		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd, ns_list,
-					    NVME_IDENTIFY_DATA_SIZE);
+		ret = nvme_submit_sync_cmd(ctrl->admin_q, &cmd,
+					   scan_info.ns_list,
+					   NVME_IDENTIFY_DATA_SIZE);
 		if (ret) {
 			dev_warn(ctrl->device,
 				"Identify NS List failed (status=0x%x)\n", ret);
 			goto free;
 		}
 
+		atomic_set(&scan_info.next_idx, 0);
 		for (i = 0; i < nr_entries; i++) {
-			u32 nsid = le32_to_cpu(ns_list[i]);
+			u32 nsid = le32_to_cpu(scan_info.ns_list[i]);
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			nvme_scan_ns(ctrl, nsid);
+			async_schedule_domain(nvme_scan_ns_async, &scan_info,
+						&domain);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
+		async_synchronize_full_domain(&domain);
 	}
  out:
 	nvme_remove_invalid_namespaces(ctrl, prev);
  free:
-	kfree(ns_list);
+	async_synchronize_full_domain(&domain);
+	kfree(scan_info.ns_list);
 	return ret;
 }
 
-- 
2.39.3



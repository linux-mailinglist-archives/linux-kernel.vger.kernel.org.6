Return-Path: <linux-kernel+bounces-255581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F1934276
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD07A1C212F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B8718308B;
	Wed, 17 Jul 2024 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+jrKg/1"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2810181D1C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721242563; cv=none; b=dbb01ZaEPfVtIGItmwNi/EXag8Ql3sSJB4j6BnwXeq975FlVX0jZHkO+wj85iRCR2r/UImPsp/NcAUBuLPk57CNTz5JXVsovaQ4EVodE/RIs6c0Cq4TgGNhirD77eQFyd4GNmepRdnCEYWtVXw6uKOSW9x5JxclEf3yALiuQK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721242563; c=relaxed/simple;
	bh=HSd4pktqte1GgJXiS90ILK+p73R7ttFEtUg9e8QxU8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KggJM+GKfYsfXQAOlInd+RQ62PKbm6vHkGdjy+Pxi9fcVK2PBSAI2LF/N5a9HZ+xwNqwb9x8Jl0jlZ2JjzNCbRlBNBT1ipCfno7ZQpfZIG53lUjf7gibMtDt1OWLefWsipkJWPFIYES0/IlqI+c7YCjwrwz8QDyPGxQB3CwDwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+jrKg/1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-79efd2151d9so463278185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721242561; x=1721847361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lxHl2np1Jk3+/gNwG5PlAzWq2/ygmTvCtMhCUVxRYk=;
        b=a+jrKg/1GPTRZRALoSIKPjvyBNr6Boy8aIvYPFzpl7Jhg3ee7n4lmnJa9ViSDyWj41
         jDTeHMyxukG9D5/yo6cWsHy8la97cVcP9R8vet36rgqIIYgNYzjMttUHS6JakkSqi7vt
         +AXX8I72xAGySLQwy3nRUTuFLi6grW7O9QvzOIQcZZKvtoCt2m0JZ2MMLed25zTUN8rU
         8EBhwUApmM0hXLgzd0QOAK3HcTRdiLKcfbSY0tvmWhq0rqEPava25U7tdc0eH4Qe2r/v
         jr6grR5U4aEVf95zVIlKG0sC32VXlyy5StLHRU2u3tMNRiX2TTL8dZ8yyB8wVAYivsmK
         v6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721242561; x=1721847361;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lxHl2np1Jk3+/gNwG5PlAzWq2/ygmTvCtMhCUVxRYk=;
        b=soaUiqQ4oWhEMKSinP2h7Sg9bfDEwSShxdp+0q9h5HoD8/XHe+d+tSH69nrd7BNi9a
         BPcBlJQQ0MxevPLUCcNcl31ciDoeSxbLHd2NfOuXis5LqNtoMINNcAy6hxUNNfF6fVgL
         vIsNCyCI4MLgR3+6JwX3Rkdz46NZrl4rm+thFUjSizRA1l0zlkITcErRfpIQ/xamAl5V
         njZ1xekxQCV11EhplD5D98LmV5QUwxToRgUV4ihj66UAQXHk6jzlxp5+7D4DHrSYtOA+
         wBnjTNZTUdkQPq8UuRbEFAVM7IAg/5FfXfBK8pZw+b9+mTVJVNX7lTKYjdDXjevR/2xM
         qicg==
X-Gm-Message-State: AOJu0Yy0GjAKHnETc/eJnXeXAf0ZJK4QPE96xrMi7RgLAacavhz2UyuU
	roembGYskihfp2Y89HUo88yeLg/hIdq39zcTZ8DFtBHtyMVKyz5KZa4E+g==
X-Google-Smtp-Source: AGHT+IGoc0+gXThdh0a0Sq8yiIPMuEdi0Rv91IXt00KGyTz1QiLvxPhmEU1NFjOQjUAszTxS6GBqxQ==
X-Received: by 2002:a05:620a:3954:b0:79f:502:5ac0 with SMTP id af79cd13be357-7a187504355mr268587985a.73.1721242560491;
        Wed, 17 Jul 2024 11:56:00 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b7f1f98sm51792761cf.43.2024.07.17.11.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 11:56:00 -0700 (PDT)
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
Subject: [PATCH v4] nvme_core: scan namespaces asynchronously
Date: Wed, 17 Jul 2024 13:55:50 -0500
Message-Id: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
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
changes from V3:
  * changed "next_idx" to "next_nsid" in async_scan_info (cosmetic)
  * added comments to struct async_scan_info
  * changed nvme_scan_ns_list() to use local ns_list pointer

changes from V2:
  * make a separate function nvme_scan_ns_async() that calls
    nvme_scan_ns(), instead of modifying nvme_scan_ns()
  * only scan asynchronously from nvme_scan_ns_list(), not from
    nvme_scan_ns_sequential()
  * provide more timing data in the commit message

changes from V1:
  * remove module param to enable/disable async scanning
  * add scan time measurements to commit message

 drivers/nvme/host/core.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc1..dc43146dc03d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-integrity.h>
@@ -3952,6 +3953,35 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	}
 }
 
+/*
+ * struct async_scan_info - keeps track of controller & NSIDs to scan
+ * @ctrl:	Controller on which namespaces are being scanned
+ * @next_nsid:	Index of next NSID to scan in ns_list
+ * @ns_list:	Pointer to list of NSIDs to scan
+ *
+ * Note: There is a single async_scan_info structure shared by all instances
+ * of nvme_scan_ns_async() scanning a given controller, so the atomic
+ * operations on next_nsid are critical to ensure each instance scans a unique
+ * NSID.
+ */
+struct async_scan_info {
+	struct nvme_ctrl *ctrl;
+	atomic_t next_nsid;
+	__le32 *ns_list;
+};
+
+static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
+{
+	struct async_scan_info *scan_info = data;
+	int idx;
+	u32 nsid;
+
+	idx = (u32)atomic_fetch_add(1, &scan_info->next_nsid);
+	nsid = le32_to_cpu(scan_info->ns_list[idx]);
+
+	nvme_scan_ns(scan_info->ctrl, nsid);
+}
+
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
@@ -3978,11 +4008,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	__le32 *ns_list;
 	u32 prev = 0;
 	int ret = 0, i;
+	ASYNC_DOMAIN(domain);
+	struct async_scan_info scan_info;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
+	scan_info.ctrl = ctrl;
+	scan_info.ns_list = ns_list;
 	for (;;) {
 		struct nvme_command cmd = {
 			.identify.opcode	= nvme_admin_identify,
@@ -3998,19 +4032,23 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			goto free;
 		}
 
+		atomic_set(&scan_info.next_nsid, 0);
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
 
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
+	async_synchronize_full_domain(&domain);
 	kfree(ns_list);
 	return ret;
 }
-- 
2.39.3



Return-Path: <linux-kernel+bounces-174926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A918C1788
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E091C21542
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41BF86249;
	Thu,  9 May 2024 20:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLJQnAog"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367168595A
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286596; cv=none; b=utx/eOPB1xBy/jiyvZkNnmjaRSUmMD3DMJ7Z1lXGtswDhIap+KvRpbWLVZh9J6g46F8lkE9DKZOvlOIFgy5j4thqWN6IE0GPYOgN+i0a6OImUnCio/CHkhNi3seHInd+aTLtl0rS7jmCHuro+F6tddhqh5bGF4j96rCoVVtR1rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286596; c=relaxed/simple;
	bh=3Qwxe1Cj2N8MrS2wEJQi7I+iScTtwFnw8hoOwI1Rl54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=omizaYGM77OfI7Nnq9l57p+ufazfE0AUQuD8cE1bIfTG+WhNLr4ml7cKCk0abtmEFc/1k/XUIeskUEcMWmhcEeahvxp933F7WsUjlm+YW90RMn/d32TA/o2jzcb9+U6WDY0SXtOMOvU/rCZnfqdi7tDqZWu2SV8cHyebHDNIolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLJQnAog; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715286576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sv0rpGMuqN08MvqBMJOK0G6fcLMIR6LNv/hFD3yHl4g=;
	b=OLJQnAogS8lUgJZMv4JrOxYioSkW8QNRAMQc2coRi2HjEx/TAzvwovpViKCByAF8qORysV
	YsqpF3+R6V2oJfAFxzfnLlB5hhaUag8SbIzomPXDxr0uCL1u9eqXzMDBQ4luJl6F9IuB12
	+7jXdbekUXvx0/erecPqyyeDMo0LDy0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-v9XqlrW5OCWwBoYWkLxvJw-1; Thu, 09 May 2024 16:29:34 -0400
X-MC-Unique: v9XqlrW5OCWwBoYWkLxvJw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22D098065D2;
	Thu,  9 May 2024 20:29:34 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 974B520C5674;
	Thu,  9 May 2024 20:29:33 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org,
	constg@il.ibm.com,
	aviv.coro@ibm.com
Subject: [PATCH v2 2/3] nvme: multipath: only update ctrl->nr_active when using queue-depth iopolicy
Date: Thu,  9 May 2024 16:29:28 -0400
Message-Id: <20240509202929.831680-3-jmeneghi@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
References: <20231107212331.9413-1-emilne@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

From: "Ewan D. Milne" <emilne@redhat.com>

The atomic updates of ctrl->nr_active are unnecessary when using
numa or round-robin iopolicy, so avoid that cost on a per-request basis.
Clear nr_active when changing iopolicy and do not decrement below zero.
(This handles changing the iopolicy while requests are in flight.)

Tested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 21 ++++++++++++++++++---
 drivers/nvme/host/nvme.h      |  6 ++++++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 095f59e7aa93..ffc04d65c45e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
 static LIST_HEAD(nvme_subsystems);
-static DEFINE_MUTEX(nvme_subsystems_lock);
+DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3603dd2c785f..02baadb45c82 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -133,7 +133,8 @@ void nvme_mpath_start_request(struct request *rq)
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
-	atomic_inc(&ns->ctrl->nr_active);
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
+		atomic_inc(&ns->ctrl->nr_active);
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
 						      jiffies);
@@ -147,7 +148,8 @@ void nvme_mpath_end_request(struct request *rq)
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 
-	atomic_dec(&ns->ctrl->nr_active);
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD)
+		atomic_dec_if_positive(&ns->ctrl->nr_active);
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
@@ -851,6 +853,19 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ctrl *ctrl;
+
+	WRITE_ONCE(subsys->iopolicy, iopolicy);
+
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		atomic_set(&ctrl->nr_active, 0);
+	}
+	mutex_unlock(&nvme_subsystems_lock);
+}
+
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -860,7 +875,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e23e17ab94b9..a557b4577c01 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -50,6 +50,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+extern struct mutex nvme_subsystems_lock;
+
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
@@ -963,6 +965,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1062,6 +1065,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return false;
 }
+static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 struct nvme_zone_info {
-- 
2.39.3



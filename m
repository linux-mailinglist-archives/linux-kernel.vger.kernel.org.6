Return-Path: <linux-kernel+bounces-179021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF4A8C5A99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 19:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18851F231D0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22254180A6E;
	Tue, 14 May 2024 17:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIfEsGPn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD211802B1
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709217; cv=none; b=nF2XR9PbfdqxmbrutZzlom2m0kbqwyE09UK0+jHv6pAO8PtNPU28KM9FcySyusBsjK6V4UWUhUHlAsbzEnuscQ1UUeVBjVqIZ6iv+AXnFK+nbdnHFnRBXtApOHNL+keXnsLfiLetqMzL9Jc3sVMAeqJ6YqfPiJp327Qh0W/xGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709217; c=relaxed/simple;
	bh=EiZsyI8d5/iT9mBJabkbwAVJGQIFKsERJkeDpSU8nCk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=il/PCN9kHxuRAv+UowD50Akrck1Xk3udChTl43qwppBgLXMPBEZMw1PVLr7eGG/8pJvijPSW5z8W3wkQ/SBXvqLNB/xzeRYhZY0IN8QL7pXr0oLYkOfuD6AcCc5bpnp1A0UUfCRZDGKjGKaF+uTNccCQkklxqQ6SMqoO+9ahTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIfEsGPn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6h1FkNmsvcraJuPKXwoMATWjG6B4CiSCjyJHEuznVDE=;
	b=TIfEsGPn0rwH1ZszSoLiTEzx5RKB+5Ab7ZlVVRvmb/9Gh2mJ01W+kgYyBQb1diXU8j5liw
	kHKHZ8Et/79yEqZIQRyLW/urtVNTAJmIcm1zDzbGhsflBSDY/XtOyPdMWj+BmsyRpDGiNY
	RxTGdWXnN/81A04ardesU2LxD4PXiy0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-qbfSjT5DPbmEEoR6umgCjw-1; Tue,
 14 May 2024 13:53:31 -0400
X-MC-Unique: qbfSjT5DPbmEEoR6umgCjw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBAA638000A6;
	Tue, 14 May 2024 17:53:30 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B1595400EAC;
	Tue, 14 May 2024 17:53:29 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 2/6] nvme: multipath: only update ctrl->nr_active when using queue-depth iopolicy
Date: Tue, 14 May 2024 13:53:18 -0400
Message-Id: <20240514175322.19073-3-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

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
index a066429b790d..1dd7c52293ff 100644
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
index 9e36002d0831..1e9338543ded 100644
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
@@ -850,6 +852,19 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
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
@@ -859,7 +874,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7d0a56d35d4..4e876524726a 100644
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
@@ -937,6 +939,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1036,6 +1039,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
 	return false;
 }
+static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
-- 
2.39.3



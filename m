Return-Path: <linux-kernel+bounces-186524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7608CC532
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833D2280ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B221D1420BC;
	Wed, 22 May 2024 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="izUC7NIm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6901249F9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396857; cv=none; b=cenfmoc2E2cktcqPIEvWxJ48tKiK0/jaATA9y1vbJM9wdy8AN4BSbGOHk30HcBRGVA4TFRatlJtwfEXjQB74MTuC++BgP84CTr4HQw9figcVPVgEmADgUpxItuLLZYs++PMYdHwgNAgomKhvQx0OJHNioaW4z8Ib4oF+qRGaqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396857; c=relaxed/simple;
	bh=PcN88n2HwlHm62ch0ZY6xeukWITfuC/cvapi4SrhEZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-type; b=Xk2dCidQAInTW3aONX4x+zhDhQN4s2WyQJARtLbRPo5vq/yo+6YyYUZm11fCHzVE8IYrjTBRJTXBGo2yQKiHrrenLtFzNSePzE3aqgqJJ9hAyAffsu2819f8jxPZwkP4709DvUKpVHYJ+NkqqOnrbL8A7L8rUUNWI1BPzHE7gIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=izUC7NIm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716396854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ilgSmNAuEbB+LU6BUfe5QrC2U20mtVIqUhMau/EYfak=;
	b=izUC7NImh75Lt0SP65C16N21HNCY9TWsPIUHsPtRk520FcJhxi8KqLCiHLbSEwEGydxzE+
	ycm2UMdJ3rKVuE9p/c2qUuK4NGWM9WkYMYTQkDRef+gdauhDTWW5sdOc7/dBpf1FIO+sYX
	A0oNdEx4MvAUVVRAHFhiEPbABM37DoQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-HwUj0n0gMiSqDwn1RGNmZQ-1; Wed,
 22 May 2024 12:54:11 -0400
X-MC-Unique: HwUj0n0gMiSqDwn1RGNmZQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51BC11C0513E;
	Wed, 22 May 2024 16:54:10 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C21E440C6CB6;
	Wed, 22 May 2024 16:54:09 +0000 (UTC)
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
	hare@kernel.org
Subject: [PATCH v5] nvme: multipath: Implemented new iopolicy "queue-depth"
Date: Wed, 22 May 2024 12:54:06 -0400
Message-Id: <20240522165406.702362-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: "Ewan D. Milne" <emilne@redhat.com>

The round-robin path selector is inefficient in cases where there is a
difference in latency between paths.  In the presence of one or more
high latency paths the round-robin selector continues to use the high
latency path equally. This results in a bias towards the highest latency
path and can cause a significant decrease in overall performance as IOs
pile on the highest latency path. This problem is acute with NVMe-oF
controllers.

The queue-depth policy instead sends I/O requests down the path with the
least amount of requests in its request queue. Paths with lower latency
will clear requests more quickly and have less requests in their queues
compared to higher latency paths. The goal of this path selector is to
make more use of lower latency paths which will bring down overall IO
latency and increase throughput and performance.

Signed-off-by: Thomas Song <tsong@purestorage.com>
[emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description, and
      fixed potential issue with ->current_path[] being used]
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
[jmeneghi: vairious changes and improvements, addressed review comments]
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Tested-by: Jyoti Rani <jrani@purestorage.com>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 94 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  5 ++
 3 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7706df237349..66dc676677d4 100644
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
index 1bee176fd850..96264c5c979f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
+	[NVME_IOPOLICY_QD]      = "queue-depth",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_NUMA;
 	else if (!strncmp(val, "round-robin", 11))
 		iopolicy = NVME_IOPOLICY_RR;
+	else if (!strncmp(val, "queue-depth", 11))
+		iopolicy = NVME_IOPOLICY_QD;
 	else
 		return -EINVAL;
 
@@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -128,6 +131,11 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+		atomic_inc(&ns->ctrl->nr_active);
+		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
+	}
+
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
@@ -141,6 +149,9 @@ void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
 
+	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
+		atomic_dec_if_positive(&ns->ctrl->nr_active);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -332,6 +343,43 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	return found;
 }
 
+static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
+	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
+	unsigned int depth;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		depth = atomic_read(&ns->ctrl->nr_active);
+
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			if (depth < min_depth_opt) {
+				min_depth_opt = depth;
+				best_opt = ns;
+			}
+			break;
+
+		case NVME_ANA_NONOPTIMIZED:
+			if (depth < min_depth_nonopt) {
+				min_depth_nonopt = depth;
+				best_nonopt = ns;
+			}
+			break;
+		default:
+			break;
+		}
+
+		if (min_depth_opt == 0)
+			return best_opt;
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
@@ -340,15 +388,27 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
-	int node = numa_node_id();
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
+	int node;
 	struct nvme_ns *ns;
 
+	/*
+	 * queue-depth iopolicy does not need to reference ->current_path
+	 * but round-robin needs the last path used to advance to the
+	 * next one, and numa will continue to use the last path unless
+	 * it is or has become not optimized
+	 */
+	if (iopolicy == NVME_IOPOLICY_QD)
+		return nvme_queue_depth_path(head);
+
+	node = numa_node_id();
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
 
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+	if (iopolicy == NVME_IOPOLICY_RR)
 		return nvme_round_robin_path(head, node, ns);
+
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
@@ -800,6 +860,29 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
+static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ctrl *ctrl;
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
+	if (old_iopolicy == iopolicy)
+		return;
+
+	WRITE_ONCE(subsys->iopolicy, iopolicy);
+
+	/* iopolicy changes reset the counters and clear the mpath by design */
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		atomic_set(&ctrl->nr_active, 0);
+		nvme_mpath_clear_ctrl_paths(ctrl);
+	}
+	mutex_unlock(&nvme_subsystems_lock);
+
+	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
+			subsys->subnqn);
+}
+
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -809,7 +892,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
@@ -920,6 +1003,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	/* initialize this in the identify path to cover controller resets */
+	atomic_set(&ctrl->nr_active, 0);
+
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
 		dev_err(ctrl->device,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fc31bd340a63..fa3833d88a85 100644
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
@@ -195,6 +197,7 @@ enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
+	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -359,6 +362,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -407,6 +411,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.39.3



Return-Path: <linux-kernel+bounces-221473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3590F424
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035F71C22385
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E31515442F;
	Wed, 19 Jun 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KetWO+Vw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55815382F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718814920; cv=none; b=EoQ4Eh++ycBDETHwlD7z4dRv/r+lYb/Bj5vY/OBRsKo4vEudtj5plv+o6qo8vneb5v4PkNag61Q5H8usmtTG7wYvpxGVaYhZu/26HuwY61ymg8ffFwx1SSjpxY1uJBd6cxPrkGOj2ujfMZgwf6vs7JWQ9m1zevtRxsFDW/1iu24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718814920; c=relaxed/simple;
	bh=+tPOanoOGCoQGLlph1QnjhQJbBiKTpNjjgMiGjRiwZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=GFDfNoDVsqrDV3Jgaxj4eolWZKQX1QIQ+uTXwczE2YXJ3GNbaqw3fgdJq27J7jT59b3F9A9tTtilhnZ4NZC7gP/IGdwN3hr9fKWZ3AoyjPNjWYZfiDvmjf1PP3Lk/AabdrLr2VBeMZXer/0v5HN1eXqi9pUOobFP3HciF69yquE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KetWO+Vw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718814917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wcQqdjZeMko7V+7UwUCto1LRGZ8+m+KZE2eqNJBiQc=;
	b=KetWO+VwKAbFoLMQqrkAxbz7Ui29XziEn6m0QLmq68CCFtiGZCJc02W8zjAZ7a/6K3ncDF
	vKszMkCrtOAS6K9IBrv9ze28uDW94SVlM76jcCHiEbX4aSQoa9Fo9FGlxyWUbbByJxf5ZA
	+o7MUFIkpIGRKsYuTyA8r7ovv+ERcys=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-3JrUR7Q7Ptm1pS_9mZhGOQ-1; Wed,
 19 Jun 2024 12:35:13 -0400
X-MC-Unique: 3JrUR7Q7Ptm1pS_9mZhGOQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3931819560A0;
	Wed, 19 Jun 2024 16:35:12 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.33.177])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A36619560B0;
	Wed, 19 Jun 2024 16:35:09 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org
Subject: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Date: Wed, 19 Jun 2024 12:35:03 -0400
Message-ID: <20240619163503.500844-2-jmeneghi@redhat.com>
In-Reply-To: <20240619163503.500844-1-jmeneghi@redhat.com>
References: <20240619163503.500844-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Thomas Song <tsong@purestorage.com>

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
Co-developed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
[jmeneghi: vairious changes and improvements, addressed review comments]
Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Tested-by: Jyoti Rani <jrani@purestorage.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 103 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |   5 ++
 3 files changed, 101 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7c9f91314d36..c10ff8815d82 100644
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
index 03a6868f4dbc..4e97cfe76a95 100644
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
+		WARN_ON_ONCE((atomic_dec_if_positive(&ns->ctrl->nr_active)) < 0);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -291,10 +302,14 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
 }
 
-static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
-		int node, struct nvme_ns *old)
+static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 {
-	struct nvme_ns *ns, *found = NULL;
+	struct nvme_ns *ns, *old, *found = NULL;
+	int node = numa_node_id();
+
+	old = srcu_dereference(head->current_path[node], &head->srcu);
+	if (unlikely(!old))
+		return __nvme_find_path(head, node);
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -334,13 +349,49 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
@@ -349,13 +400,24 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
 
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
-		return nvme_round_robin_path(head, node, ns);
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
 }
 
+
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+{
+	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_QD:
+		return nvme_queue_depth_path(head);
+	case NVME_IOPOLICY_RR:
+		return nvme_round_robin_path(head);
+	default:
+		return nvme_numa_path(head);
+	}
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
@@ -803,6 +865,28 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
+static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
+		int iopolicy)
+{
+	struct nvme_ctrl *ctrl;
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
+	if (old_iopolicy == iopolicy)
+		return;
+
+	WRITE_ONCE(subsys->iopolicy, iopolicy);
+
+	/* iopolicy changes clear the mpath by design */
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		nvme_mpath_clear_ctrl_paths(ctrl);
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
@@ -812,7 +896,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
@@ -923,6 +1007,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	/* initialize this in the identify path to cover controller resets */
+	atomic_set(&ctrl->nr_active, 0);
+
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
 		dev_err(ctrl->device,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 73442d3f504b..c440e4cb60f8 100644
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
+	NVME_MPATH_CNT_ACTIVE		= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -360,6 +363,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -408,6 +412,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.45.1



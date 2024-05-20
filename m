Return-Path: <linux-kernel+bounces-184149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68698CA333
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 22:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ECB1C21457
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 20:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075E51386B9;
	Mon, 20 May 2024 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkfIxrCC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C04A1AAD7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716236457; cv=none; b=upCPfvxmFvMho58LrQVS4639DIYcqzFa3I7L1LxjuLgywqOpX4o30b/62/4uWoPbVhVx7d3mjhTV4ECPrbWGaUgiD0rCVXQCHe8iCLHplgn0VkP25B4fzg1KPSTqePG3pLHXIUQ9dEvQ+Mezul/aY5+JLD+2Bak9stFqsKNeQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716236457; c=relaxed/simple;
	bh=sgU8ZCN6v6K9FgrrU2uJD/bRJotxmIfJDCr1d+X8on4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=dWchSfzlviwk+PMlZnziJ3sDWwXfc6m8QqHZrClLDDAwvysr2olMzzFFeizbfoEe5tlnu1kcNoNVIdZ0h+wVyjhRMuWBvv9OF5tbI56ssEIkB0ZWxYFuVtnzOOGuiI6yMEi9Xu3+KFd6LrbM+tCJiIx5iC1ZQcn7HryRcos3Qe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dkfIxrCC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716236454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zbe1OGz8dA2etZlIG5NOR0NRsg8w4tDR2aNCkVgtzH0=;
	b=dkfIxrCChuBvkvFqtavzj+XXdPZxP86tfw2Al4T11A1Y+MELaXnJq5f+laguQw3KkITbeh
	uu1Z7No7ovin993pAJ6lSKzjG/AP68RxZgCy+YZJPXvpGnS7JoM1x77wgQ3/3GjC0UWKYy
	i3aLgBEYoTdm6A/K1zYDSx61xc1GH1A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-wXSaFb6aPz2dTRFbxZXMgw-1; Mon,
 20 May 2024 16:20:50 -0400
X-MC-Unique: wXSaFb6aPz2dTRFbxZXMgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44D273C0C102;
	Mon, 20 May 2024 20:20:49 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BC62840C6CB6;
	Mon, 20 May 2024 20:20:48 +0000 (UTC)
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
Subject: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy "queue-depth"
Date: Mon, 20 May 2024 16:20:45 -0400
Message-Id: <20240520202045.427110-2-jmeneghi@redhat.com>
In-Reply-To: <20240520202045.427110-1-jmeneghi@redhat.com>
References: <20240520202045.427110-1-jmeneghi@redhat.com>
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
difference in latency between multiple active optimized paths.  In the
presence of one or more high latency paths the round-robin selector
continues to the high latency path equally. This results in a bias
towards the highest latency path and can cause is significant decrease
in overall performance as IOs pile on the lowest latency path. This
problem is particularly accute with NVMe-oF controllers.

The queue-depth policy instead sends I/O requests down the path with the
least amount of requests in its request queue. Paths with lower latency
will clear requests more quickly and have less requests in their queues
compared to higher latency paths. The goal of this path selector is to
make more use of lower latency paths, which will bring down overall IO
latency.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
[tsong: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description, and
      fixed potential issue with ->current_path[] being used]
Signed-off-by: Thomas Song <tsong@purestorage.com>
[jmeneghi: vairious changes and improvements, addressed review comments]
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Randy Jennings <randyj@redhat.com>
Tested-by: Jyoti Rani <jani@purestorage.com>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  9 ++++
 3 files changed, 92 insertions(+), 5 deletions(-)

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
index 5397fb428b24..0e2b6e720e95 100644
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
+	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -127,6 +130,11 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+		atomic_inc(&ns->ctrl->nr_active);
+		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
+	}
+
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
@@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
 
+	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
+		atomic_dec_if_positive(&ns->ctrl->nr_active);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
@@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
@@ -338,15 +384,27 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
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
@@ -798,6 +856,25 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ctrl *ctrl;
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
+	WRITE_ONCE(subsys->iopolicy, iopolicy);
+
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
@@ -807,7 +884,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
@@ -905,6 +982,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
 	mutex_init(&ctrl->ana_lock);
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	atomic_set(&ctrl->nr_active, 0);
 }
 
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f243a5822c2b..f5557889b244 100644
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
@@ -190,6 +192,7 @@ enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
+	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -354,6 +357,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -402,6 +406,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
@@ -935,6 +940,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1034,6 +1040,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
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



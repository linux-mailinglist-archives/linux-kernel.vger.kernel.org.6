Return-Path: <linux-kernel+bounces-228855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C2A9167CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585D51F22B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC5415F3E8;
	Tue, 25 Jun 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzmZbKTb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFFA1487C8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318383; cv=none; b=f64VFQieD0XRE6qc64F481Kag/vIymEH2ekRtjS287hgRxW1MistecSj8/fO0NRskeCejlIFW1OCvXg8Ab7BbOKqNf7wic7bmEXEIBTrcWLXRzgpLCfdq3YvrGmwFj2yb9Q10foQuyBJkJh3zAMGxmXYqIbMr1QY++D9QIhpok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318383; c=relaxed/simple;
	bh=guZsHHQVOVOBt5lx3oRI27eMZLB4UstJufnRsUmNMmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=o+pal+ECDR1ALDpVKS6fov8S18tRaXbLJp5ho60mJ6j2Mm/L0NAciQ7a1LItzMFdIkghUtDwRU6WnRcGzA+ubspORRdOnMJle0eG5BOhkyxURC5d+BDw7bLy3lU6Ow0xRsqb4eCcV6h7GG1KCOqm8HTktsXyruSuI+RrPjzUzEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MzmZbKTb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719318380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/x77jNC5b+nWk5WK9QY1MWS7t2jdbIQZTWpHmsTq+fg=;
	b=MzmZbKTbSrN9RbuZDNnCtgWMYorWoOVtKL5+L+iV8ZtrgJglccfNjwRJnUhIUPA/I3xReD
	feL8Ho5Uwq9a4G6UkQqcMkfcZJOh57LsmCk9MhoQqAUmhCeM1A/8uHPMzexvRmL858M7Bp
	DSe/l6OFdmoTOkDJYEtnK8G16312+wM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-FgpV2VtmNuOhRnckStjBSw-1; Tue,
 25 Jun 2024 08:26:19 -0400
X-MC-Unique: FgpV2VtmNuOhRnckStjBSw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DAA519560AD;
	Tue, 25 Jun 2024 12:26:17 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.34.111])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 04BC81956054;
	Tue, 25 Jun 2024 12:26:14 +0000 (UTC)
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
Subject: [PATCH v8 2/2] nvme-multipath: implement "queue-depth" iopolicy
Date: Tue, 25 Jun 2024 08:26:05 -0400
Message-ID: <20240625122605.857462-3-jmeneghi@redhat.com>
In-Reply-To: <20240625122605.857462-1-jmeneghi@redhat.com>
References: <20240625122605.857462-1-jmeneghi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Thomas Song <tsong@purestorage.com>

The round-robin path selector is inefficient in cases where there is a
difference in latency between paths.  In the presence of one or more
high latency paths the round-robin selector continues to use the high
latency path equally. This results in a bias towards the highest latency
path and can cause a significant decrease in overall performance as IOs
pile on the highest latency path. This problem is acute with NVMe-oF
controllers.

The queue-depth path selector sends I/O down the path with the lowest
number of requests in its request queue. Paths with lower latency will
clear requests more quickly and have less requests queued compared to
higher latency paths. The goal of this path selector is to make more use
of lower latency paths which will bring down overall IO latency and
increase throughput and performance.

Signed-off-by: Thomas Song <tsong@purestorage.com>
[emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description, and
      fixed potential issue with ->current_path[] being used]
Co-developed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
[jmeneghi: various changes and improvements, addressed review comments]
Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Tested-by: Jyoti Rani <jrani@purestorage.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 85 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  4 ++
 3 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8d8e7a3549c6..20e7505852ce 100644
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
index 0ade378e514b..63d1dbc3c87a 100644
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
@@ -338,6 +349,42 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
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
@@ -359,10 +406,14 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_QD:
+		return nvme_queue_depth_path(head);
+	case NVME_IOPOLICY_RR:
 		return nvme_round_robin_path(head);
-	else
+	default:
 		return nvme_numa_path(head);
+	}
 }
 
 static bool nvme_available_path(struct nvme_ns_head *head)
@@ -794,6 +845,29 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
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
+	pr_notice("subsysnqn %s iopolicy changed from %s to %s\n",
+			subsys->subnqn,
+			nvme_iopolicy_names[old_iopolicy],
+			nvme_iopolicy_names[iopolicy]);
+}
+
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -803,7 +877,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
@@ -911,6 +985,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	/* initialize this in the identify path to cover controller resets */
+	atomic_set(&ctrl->nr_active, 0);
+
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
 		dev_err(ctrl->device,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c63f2b452369..b512012b7044 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -49,6 +49,7 @@ extern unsigned int admin_timeout;
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
+extern struct mutex nvme_subsystems_lock;
 
 /*
  * List of workarounds for devices that required behavior not specified in
@@ -195,6 +196,7 @@ enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
+	NVME_MPATH_CNT_ACTIVE		= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -360,6 +362,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -408,6 +411,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.45.2



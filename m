Return-Path: <linux-kernel+bounces-174927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A6C8C178B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2F3E2877D3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D70811E6;
	Thu,  9 May 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+v94yl6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1C85C58
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286603; cv=none; b=FINTMWEOaNPNaV+9jyJR04bDOFJs2RZ7S0sNewRF2Q6ym84FanesoPExH6sQyZPD4hgFMacIOIrtEi9Ay01lVrY7F5QQsE84xFnRTYI31oHI8IMyjWzrhmNaSIG/A9tiz0KmwFaoHSVQyuf6BqA8vwjmDikUhHLySeLAR4FVJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286603; c=relaxed/simple;
	bh=eNAmxq3lHO49+/SNLedIGploRL6CnH2ikjNGrBws2iY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-type; b=C5kuK7ux8CZuySXG5LXCGTX8A6bFGWtnb4d6aTINXotHx9+i/xjPAFuAAmVek1zPtam5lte6CuVRsEXT6Skv7f5BkK4kWQBuS8WmXwGvAgDMFUqKxkqVv4pvtM9DYZV+8e8FzuEyaI344qQ6hLsf6maxOL32rCckdM8jWfJZcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+v94yl6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715286579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGxW8Mvj6Pxwb/9/pUcbbfAB9MGxQT1x04XniCRF2Dw=;
	b=E+v94yl6Q5NGJQGw95b8gJlOAQZ/t28VesD/T9BQtfK+cFRi1/W27DH34KO0NWYp1Kdm7v
	sr+lyEnbTZvzXyaP9Oa74onzrQOWOiTQHbIitTLzbz20OKCkgzR9w1A1VPwcNTw5tcQDMm
	65evKRef5yWyww6ccSFTZyLWAFlP/Iw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-s-K8c1XPNU6jPs7ghnrvMg-1; Thu, 09 May 2024 16:29:34 -0400
X-MC-Unique: s-K8c1XPNU6jPs7ghnrvMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8946B8030A6;
	Thu,  9 May 2024 20:29:33 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0861620C62D7;
	Thu,  9 May 2024 20:29:32 +0000 (UTC)
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
Subject: [PATCH v2 1/3] nvme: multipath: Implemented new iopolicy "queue-depth"
Date: Thu,  9 May 2024 16:29:27 -0400
Message-Id: <20240509202929.831680-2-jmeneghi@redhat.com>
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

The existing iopolicies are inefficient in some cases, such as
the presence of a path with high latency. The round-robin
policy would use that path equally with faster paths, which
results in sub-optimal performance.

The queue-depth policy instead sends I/O requests down the path
with the least amount of requests in its request queue. Paths
with lower latency will clear requests more quickly and have less
requests in their queues compared to "bad" paths. The aim is to
use those paths the most to bring down overall latency.

This implementation adds an atomic variable to the nvme_ctrl
struct to represent the queue depth. It is updated each time a
request specific to that controller starts or ends.

[edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description, and
      fixed potential issue with ->current_path[] being used]

Tested-by: John Meneghini <jmeneghi@redhat.com>
Co-developed-by: Thomas Song <tsong@purestorage.com>
Signed-off-by: Thomas Song <tsong@purestorage.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/multipath.c | 59 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  2 ++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d16e976ae1a4..3603dd2c785f 100644
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
@@ -130,6 +133,7 @@ void nvme_mpath_start_request(struct request *rq)
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
+	atomic_inc(&ns->ctrl->nr_active);
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
 						      jiffies);
@@ -142,6 +146,8 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+
+	atomic_dec(&ns->ctrl->nr_active);
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
@@ -331,6 +337,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
@@ -339,15 +379,27 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
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
@@ -906,6 +958,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
 	mutex_init(&ctrl->ana_lock);
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	atomic_set(&ctrl->nr_active, 0);
 }
 
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05532c281177..e23e17ab94b9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -359,6 +359,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -407,6 +408,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.39.3



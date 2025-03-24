Return-Path: <linux-kernel+bounces-573617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B29A6D9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69E417A503A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694B25C6F5;
	Mon, 24 Mar 2025 12:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJZEk1Xm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDB725EF8B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742818093; cv=none; b=kMJns3hvGV8j45UCd5o35voo7xAuIkGpzJ8R1BBo4F9UssiHUmeHXozXjEFZpO0GyQaPczvpBl4GRburgMV5ki0mdA450CKtN/5AJ4cBucxoQjDZawaBf/GDG+xSd+a4Sjq3d+EmXb400sbHfC0PnM1kLb78pzXqyWRq/nwNugo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742818093; c=relaxed/simple;
	bh=lQUzCkgG/COzR/pHntbS6EXiWn+eykoAt4Nb+HdA+EM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJNtlRmhtQitfoWnXY16/0i1Ap1+SxxWh/A0aHrI720AVRy9XPD1jWLTZKHfa2eszkqiKlQT3/uY47oybWrWJlnvEslNtvrgYSp/f0gKhyaibHP5fjq5LSmEJFCzdDk7B5/c4GZJUPoYcKIrRbWysVJ45tRMbksL6FN71tt2s98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJZEk1Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBD0C4CEDD;
	Mon, 24 Mar 2025 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742818093;
	bh=lQUzCkgG/COzR/pHntbS6EXiWn+eykoAt4Nb+HdA+EM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AJZEk1XmJh89GyNWx9VFhzXmUSRY4tcC16wczJgPmUNWl/TFU/ZWc1+EIVthB8QZj
	 4kgnQp+zCK9pkGeb8QSB0bVtxzZcdVAnXG83idm1y95ya4EzxgPpGlHJnmN1IHKZYm
	 MNiAHVNVKwK7P+jFHMMS5C3nGPyOVWAoHOQnEdttwqB4tSHlOMmydblnc1ynIC/iWd
	 dirP71mB2cSCGv5X982nfndBhM6tgfZZA+kYlUz9WFiMcS9K8wkh4SkenLvvBT+q+Q
	 pI2FCLp4MFITPgJMbVWrgk/JEIFSEHXywaYDey3pROIDL82FN/4+P2+0V9/7+YMoXG
	 /jKToq7rz5AsQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 24 Mar 2025 13:07:58 +0100
Subject: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
In-Reply-To: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 John Meneghini <jmeneghi@redhat.com>, randyj@purestorage.com, 
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

The TP4129 mendates that the failover should be delayed by CQT.  Thus when
nvme_decide_disposition returns FAILOVER do not immediately re-queue it on
the namespace level instead queue it on the ctrl's request_list and
moved later to the namespace's requeue_list.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c      | 19 ++++++++++++++++
 drivers/nvme/host/fc.c        |  4 ++++
 drivers/nvme/host/multipath.c | 52 ++++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      | 15 +++++++++++++
 drivers/nvme/host/rdma.c      |  2 ++
 drivers/nvme/host/tcp.c       |  1 +
 6 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 135045528ea1c79eac0d6d47d5f7f05a7c98acc4..f3155c7735e75e06c4359c26db8931142c067e1d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -239,6 +239,7 @@ static void nvme_do_delete_ctrl(struct nvme_ctrl *ctrl)
 
 	flush_work(&ctrl->reset_work);
 	nvme_stop_ctrl(ctrl);
+	nvme_flush_failover(ctrl);
 	nvme_remove_namespaces(ctrl);
 	ctrl->ops->delete_ctrl(ctrl);
 	nvme_uninit_ctrl(ctrl);
@@ -1310,6 +1311,19 @@ static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 	queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 }
 
+void nvme_schedule_failover(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay;
+
+	if (ctrl->cqt)
+		delay = msecs_to_jiffies(ctrl->cqt);
+	else
+		delay = ctrl->kato * HZ;
+
+	queue_delayed_work(nvme_wq, &ctrl->failover_work, delay);
+}
+EXPORT_SYMBOL_GPL(nvme_schedule_failover);
+
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 						 blk_status_t status)
 {
@@ -1336,6 +1350,8 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		dev_err(ctrl->device,
 			"failed nvme_keep_alive_end_io error=%d\n",
 				status);
+
+		nvme_schedule_failover(ctrl);
 		return RQ_END_IO_NONE;
 	}
 
@@ -4716,6 +4732,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
 
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_schedule_failover(ctrl);
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
 	nvme_stop_failfast_work(ctrl);
@@ -4842,6 +4859,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
 	INIT_DELAYED_WORK(&ctrl->failfast_work, nvme_failfast_work);
+	INIT_DELAYED_WORK(&ctrl->failover_work, nvme_failover_work);
+	INIT_LIST_HEAD(&ctrl->failover_list);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index cdc1ba277a5c23ef1afd26e6911b082f3d12b215..bd897b29cd286008b781bbcb4230e08019da6b6b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2553,6 +2553,8 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
 
+	nvme_schedule_failover(&ctrl->ctrl);
+
 	/*
 	 * if an error (io timeout, etc) while (re)connecting, the remote
 	 * port requested terminating of the association (disconnect_ls)
@@ -3378,6 +3380,8 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
+	nvme_schedule_failover(&ctrl->ctrl);
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2a7635565083046c575efe1793362ae10581defd..a14b055796b982df96609f53174a5d1334c1c0c4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -86,9 +86,11 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
 	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
 	unsigned long flags;
 	struct bio *bio;
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 
 	nvme_mpath_clear_current_path(ns);
 
@@ -121,9 +123,53 @@ void nvme_failover_req(struct request *req)
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
-	nvme_req(req)->status = 0;
-	nvme_end_req(req);
-	kblockd_schedule_work(&ns->head->requeue_work);
+	spin_lock_irqsave(&ctrl->lock, flags);
+	list_add_tail(&req->queuelist, &ctrl->failover_list);
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	if (state == NVME_CTRL_DELETING) {
+		/*
+		 * request which fail over in the DELETING state were
+		 * canceled and blk_mq_tagset_wait_completed_request will
+		 * block until they have been proceed. Though
+		 * nvme_failover_work is already stopped. Thus schedule
+		 * a failover; it's still necessary to delay these commands
+		 * by CQT.
+		 */
+		nvme_schedule_failover(ctrl);
+	}
+}
+
+void nvme_flush_failover(struct nvme_ctrl *ctrl)
+{
+	LIST_HEAD(failover_list);
+	struct request *rq;
+	bool kick = false;
+
+	spin_lock_irq(&ctrl->lock);
+	list_splice_init(&ctrl->failover_list, &failover_list);
+	spin_unlock_irq(&ctrl->lock);
+
+	while (!list_empty(&failover_list)) {
+		rq = list_entry(failover_list.next,
+				struct request, queuelist);
+		list_del_init(&rq->queuelist);
+
+		nvme_req(rq)->status = 0;
+		nvme_end_req(rq);
+		kick = true;
+	}
+
+	if (kick)
+		nvme_kick_requeue_lists(ctrl);
+}
+
+void nvme_failover_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
+					struct nvme_ctrl, failover_work);
+
+	nvme_flush_failover(ctrl);
 }
 
 void nvme_mpath_start_request(struct request *rq)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7563332b5b7b76fc6165ec8c6f2d144737d4fe85..10eb323bdaf139526959180c1e66ab4579bb145d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,9 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+
+	struct delayed_work failover_work;
+	struct list_head failover_list;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -954,6 +957,9 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
+void nvme_failover_work(struct work_struct *work);
+void nvme_schedule_failover(struct nvme_ctrl *ctrl);
+void nvme_flush_failover(struct nvme_ctrl *ctrl);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
@@ -996,6 +1002,15 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 static inline void nvme_failover_req(struct request *req)
 {
 }
+static inline void nvme_failover_work(struct work_struct *work)
+{
+}
+static inline void nvme_schedule_failover(struct nvme_ctrl *ctrl)
+{
+}
+static inline void nvme_flush_failover(struct nvme_ctrl *ctrl)
+{
+}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 86a2891d9bcc7a990cd214a7fe93fa5c55b292c7..9bee376f881b4c3ebe5502abf23a8e76829780ff 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1127,6 +1127,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
+	nvme_schedule_failover(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_unquiesce_io_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
@@ -2153,6 +2154,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
+	nvme_schedule_failover(&ctrl->ctrl);
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d0023bcfd8a79a193adf2807a24481c8c164a174..3a6c1d3febaf233996e4dcf684793327b5d1412f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2345,6 +2345,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
+	nvme_schedule_failover(ctrl);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);

-- 
2.48.1



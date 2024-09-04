Return-Path: <linux-kernel+bounces-315369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE55996C1BE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51945B220EB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B61DC1B1;
	Wed,  4 Sep 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VlSbwY+b"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490781DA2FE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462317; cv=none; b=JFjk38Usjb1DzlI3+nbZSH8/vmTciYq7BJKYwtseORWkUMvDpdifbXLA2UxVmyZMzKm5TmlWRhSUhlt8PGYtaj+fBkdI6dKgCfBVOq97PKjgkr++EFcOB/ulVCXy0cns1CPoA42bnENR3OjtkrcVGFDBSznfETD1Fb5gK0goITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462317; c=relaxed/simple;
	bh=Qz82WMMHJhgtm208/hRpQDVXvQckCENoit6Mf3U+4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0x312VBwmv9Hau7HxeUoCxSiJVACY7ouyfCbEQIOAWMLGSj28TGAZEuPLGlmD/EVRmtECiPWUgM8U1gAal8qAFWnm51b3fKnz4Ohnm8CyJ1YtqD2A2zODu1QhP4PhCMrb7xKUmiSLlLvZbX4o6QPxIjw3+ybqadwQFuylMRCao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VlSbwY+b; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725462315; x=1756998315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qz82WMMHJhgtm208/hRpQDVXvQckCENoit6Mf3U+4Os=;
  b=VlSbwY+bZOPThBVOcGNv60diUSNxxIZY/yLDzXODthe67n9KEuWau3ok
   sMNcKTVombhLbiuVPUQPIX4Z+i122/SPJ6Qku4qck0S8o6+D0JTj1Qxjb
   E/G9SplOFeOGEOmlDoiKHY1pqmBJxnN3IjE6WGwGtYX2clEZujoHWstyE
   aIUvUOowYvJvJNExRgQs2oJv+NriIRmDVZ4px9Wtb7sU9bsHnVHLq+zGj
   Y2uKdWUjtqe/DYJ53Y520Y4WO3oC+Zpu+ER6Dor5nQZ3mvPNz7rarwGef
   Bux3gMYZjW3Aty4y5Ba8d7LKnZCPbmCoDRe3x6uyaST5FoBWN4PQz+pMv
   Q==;
X-CSE-ConnectionGUID: azYHbbFyQju2XMqha7N+vA==
X-CSE-MsgGUID: J2DLUgCoRbO3ULOno5upRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34731264"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="34731264"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:05:14 -0700
X-CSE-ConnectionGUID: fhNpQt96RN2LV2zHokamow==
X-CSE-MsgGUID: tdRsXmv7S7qyfLk3zY0moQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; 
   d="scan'208";a="64963930"
Received: from sschumil-mobl2.ger.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.246.254])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 08:05:12 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: 
Cc: kbusch@kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk
Subject: [RFC PATCH] nvme-pci: Add CPU latency pm-qos handling
Date: Wed,  4 Sep 2024 18:04:47 +0300
Message-ID: <20240904150509.1830278-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for limiting CPU latency while NVME IO is running. When a
NVME IO is started, it will add a user configurable CPU latency limit
in place (if any.) The limit is removed after 3ms of inactivity.

The CPU latency limit is configurable via a sysfs parameter;
cpu_latency_us under the NVME device.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
See [1] for the initial series posted to block mailing list as an RFC.
It was proposed to move this to a lower layer, i.e. NVMe driver.

[1] https://lore.kernel.org/all/20240829075423.1345042-1-tero.kristo@linux.intel.com/

 drivers/nvme/host/pci.c | 95 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dff..ab9db4b02735 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/pm_qos.h>
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
@@ -112,6 +113,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
+#define NVME_CPU_LATENCY_TIMEOUT_MS	3
+
+struct nvme_cpu_latency_qos {
+	struct dev_pm_qos_request	req;
+	struct delayed_work		work;
+	unsigned long			active;
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -141,6 +150,8 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
 	bool hmb;
+	int cpu_latency;
+	struct nvme_cpu_latency_qos __percpu *cpu_latency_qos;
 
 	mempool_t *iod_mempool;
 
@@ -213,6 +224,7 @@ struct nvme_queue {
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
 	__le32 *dbbuf_cq_ei;
+	const struct cpumask *irq_aff_mask;
 	struct completion delete_done;
 };
 
@@ -470,6 +482,9 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
  */
 static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 {
+	struct nvme_dev *dev;
+	int cpu;
+
 	if (!write_sq) {
 		u16 next_tail = nvmeq->sq_tail + 1;
 
@@ -483,6 +498,27 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
+
+	/* Kick CPU latency while updating queue. */
+	dev = nvmeq->dev;
+	if (!dev || dev->cpu_latency < 0)
+		return;
+
+	for_each_cpu(cpu, nvmeq->irq_aff_mask) {
+		struct nvme_cpu_latency_qos *qos;
+
+		qos = per_cpu_ptr(dev->cpu_latency_qos, cpu);
+
+		qos->active = jiffies + msecs_to_jiffies(NVME_CPU_LATENCY_TIMEOUT_MS);
+
+		if (dev_pm_qos_request_active(&qos->req))
+			continue;
+
+		dev_pm_qos_add_request(get_cpu_device(cpu), &qos->req,
+				       DEV_PM_QOS_RESUME_LATENCY,
+				       dev->cpu_latency);
+		schedule_delayed_work(&qos->work, msecs_to_jiffies(NVME_CPU_LATENCY_TIMEOUT_MS));
+	}
 }
 
 static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
@@ -1563,14 +1599,19 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
+	int ret;
 
 	if (use_threaded_interrupts) {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+		ret = pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
+				      nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+		ret = pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+				      NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	}
+
+	nvmeq->irq_aff_mask = pci_irq_get_affinity(pdev, nvmeq->cq_vector);
+
+	return ret;
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -2134,6 +2175,26 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(hmb);
 
+static ssize_t cpu_latency_us_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d\n", ndev->cpu_latency);
+}
+
+static ssize_t cpu_latency_us_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	if (kstrtoint(buf, 10, &ndev->cpu_latency) < 0)
+		return -EINVAL;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cpu_latency_us);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2158,6 +2219,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_cpu_latency_us.attr,
 	NULL,
 };
 
@@ -2695,6 +2757,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
 	kfree(dev->queues);
+	free_percpu(dev->cpu_latency_qos);
 	kfree(dev);
 }
 
@@ -2934,6 +2997,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+static void nvme_cpu_latency_work(struct work_struct *work)
+{
+	struct nvme_cpu_latency_qos *qos =
+		container_of(work, struct nvme_cpu_latency_qos, work.work);
+	if (time_after(jiffies, qos->active)) {
+		dev_pm_qos_remove_request(&qos->req);
+	} else {
+		schedule_delayed_work(&qos->work, msecs_to_jiffies(NVME_CPU_LATENCY_TIMEOUT_MS));
+	}
+}
+
 static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
@@ -2941,6 +3015,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	int node = dev_to_node(&pdev->dev);
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
+	int cpu;
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
@@ -2948,13 +3023,21 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
 
+	dev->cpu_latency_qos = alloc_percpu(struct nvme_cpu_latency_qos);
+	if (!dev->cpu_latency_qos)
+		goto out_free_dev;
+	for_each_possible_cpu(cpu)
+		INIT_DELAYED_WORK(per_cpu_ptr(&dev->cpu_latency_qos->work, cpu),
+				  nvme_cpu_latency_work);
+	dev->cpu_latency = -1;
+
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 	dev->nr_allocated_queues = nvme_max_io_queues(dev) + 1;
 	dev->queues = kcalloc_node(dev->nr_allocated_queues,
 			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
-		goto out_free_dev;
+		goto out_free_pm_qos;
 
 	dev->dev = get_device(&pdev->dev);
 
@@ -3000,6 +3083,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 out_put_device:
 	put_device(dev->dev);
 	kfree(dev->queues);
+out_free_pm_qos:
+	free_percpu(dev->cpu_latency_qos);
 out_free_dev:
 	kfree(dev);
 	return ERR_PTR(ret);
-- 
2.43.1



Return-Path: <linux-kernel+bounces-328094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC912977EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F56A28926C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174381D935E;
	Fri, 13 Sep 2024 11:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdqa58mJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F61C2DCE;
	Fri, 13 Sep 2024 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726227927; cv=none; b=ieuco+2KiQFAI/KINgBMN0l7jykGQjKidcxAgxTJPmMXHkouC8brRpg0eTZ8ovFaZ6uEB+pKM/sf77xF/woVrdbOqAsu4xh2RKskR+ztr1DGp6kS8xxWs/8L/jW0mZVlv0/nTATbDt3TJ56MyU7xxskJZyfcnvJxrzQai15GkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726227927; c=relaxed/simple;
	bh=NgxG9Dq5bkPm/G8SsOBVHYC7Q+9FOlSSnoi6zrPY/Hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gf1baJJP7T0egKG5shtnbG2VqdOQRemdmFJXDLBXyNk1ucM+fYv1Jnnz1T+tx73v85KrzamjTDyCMkh/lZ1iEvtmXEoO2LfybN8q+xsUinIMMnjIsxnOMIz7jJQvIG9DqpHOEbolEQNqiYW5OFlB3xVJYHBI3jertoQaK6u5F34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdqa58mJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC58BC4CEC7;
	Fri, 13 Sep 2024 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726227927;
	bh=NgxG9Dq5bkPm/G8SsOBVHYC7Q+9FOlSSnoi6zrPY/Hc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fdqa58mJHO2kHLodggOFhVK+xPW2W5bcfPwwJRML39qI80GubFjISxW8pzZ1m+I8F
	 lPz5d5nPIBdrkD7KEO593a/xdGcHB5NaFGvKMyKVK0iIcIRjpXyPNMKMh6cJErNaX/
	 TqipyoLJTTrm7bHqU6U2e1dJnuUtxR6i2ookMv4DwPhmzCGQ66KlQ2ZwO0tkPf7CSk
	 zPKgXNw8WLXhJeFa79ctzzlFPcERpreg6ztCr5jBFviZGmqrr492hh/KeLjwK38phC
	 WlpxTuNQoemWrKAzoc7ZtkrY+fJvRq40xhORXA0M6WTxpnBNVYXH0G4PjwMv/0ncU5
	 13BqMfTNE5CFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52CFA3748;
	Fri, 13 Sep 2024 11:45:26 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 13 Sep 2024 13:44:47 +0200
Subject: [PATCH v2 1/5] iommu/vt-d: Separate page request queue from SVM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240913-jag-iopfv8-v2-1-dea01c2343bc@samsung.com>
References: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
In-Reply-To: <20240913-jag-iopfv8-v2-0-dea01c2343bc@samsung.com>
To: David Woodhouse <dwmw2@infradead.org>, 
 Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.15-dev-00a43
X-Developer-Signature: v=1; a=openpgp-sha256; l=28550;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=29Yzep/jVJSdz42kcEM/hEcTLgP//kPbGrv3GHMKTW4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGbkJdKkxdaFgRgxYKRHAC/3p3aDt7YQeMPoI
 Z/XgCLYk75euYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJm5CXSAAoJELqXzVK3
 lkFP8h8L/R6/4ylG0mReVaE9Fc1dAOdnEUCnKqcfoU271RG/kS+zeUS9DtZbZNrN9S/TKMjC3Ki
 uH9gb3I7mupT4mVkf6as2oUpW/O/toTPNakDk4+cVq7nq06h80YLDzrNDMLop5+bZMxB8X4h/Dl
 84RLWJoAlsLcc2/mjkmzfnh1SpLs0saDTmbCTjMLQc+fw26mfBuQNauUUwTE0EI3ErQPuUcdnz9
 z0aKF0gnVuC94yK44OMF/MzHjDSzMnw0TlpVLTROIl5sE88a9lacicGaiNg25crc+vc7H3pOfHo
 Z5+dO6mhRUrjkSKkdk42VIxXHvI0LZB45olQ1x6PiFg/CsMrqkQsy3o7zFgaUn8wXegfFdfOs7D
 HUay5XrvEnqQuAZHN5OBoZK6xNlQaiDCu77F4IUVQUdWkVWLKSwOLcgSHtXGZrB/rlxlRHU9WYv
 fe4TPUOwnR8tG6e4HOqn9prilURzRodIegiGrLFPWUOcN8UJ+eW73fVFvvSo5hzoBwI479vGw17
 4k=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

IO page faults are no longer dependent on CONFIG_INTEL_IOMMU_SVM. Move
all Page Request Queue (PRQ) functions that handle prq events to a new
file in drivers/iommu/intel/prq.c. The page_req_des struct is now
declared in drivers/iommu/intel/prq.c.

No functional changes are intended. This is a preparation patch to
enable the use of IO page faults outside the SVM/PASID use cases.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/iommu/intel/Makefile |   2 +-
 drivers/iommu/intel/iommu.c  |  18 +-
 drivers/iommu/intel/iommu.h  |  14 +-
 drivers/iommu/intel/prq.c    | 410 +++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/svm.c    | 397 -----------------------------------------
 5 files changed, 423 insertions(+), 418 deletions(-)

diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index c8beb0281559..d3bb0798092d 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o
+obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o nested.o cache.o prq.o
 obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
 obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4aa070cf56e7..5acc52c62e8c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1487,12 +1487,10 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
 	/* free context mapping */
 	free_context_table(iommu);
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	if (pasid_supported(iommu)) {
 		if (ecap_prs(iommu->ecap))
-			intel_svm_finish_prq(iommu);
+			intel_finish_prq(iommu);
 	}
-#endif
 }
 
 /*
@@ -2482,19 +2480,18 @@ static int __init init_dmars(void)
 
 		iommu_flush_write_buffer(iommu);
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 		if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
 			/*
 			 * Call dmar_alloc_hwirq() with dmar_global_lock held,
 			 * could cause possible lock race condition.
 			 */
 			up_write(&dmar_global_lock);
-			ret = intel_svm_enable_prq(iommu);
+			ret = intel_enable_prq(iommu);
 			down_write(&dmar_global_lock);
 			if (ret)
 				goto free_iommu;
 		}
-#endif
+
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
@@ -2924,13 +2921,12 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
 	intel_iommu_init_qi(iommu);
 	iommu_flush_write_buffer(iommu);
 
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	if (pasid_supported(iommu) && ecap_prs(iommu->ecap)) {
-		ret = intel_svm_enable_prq(iommu);
+		ret = intel_enable_prq(iommu);
 		if (ret)
 			goto disable_iommu;
 	}
-#endif
+
 	ret = dmar_set_interrupt(iommu);
 	if (ret)
 		goto disable_iommu;
@@ -4673,9 +4669,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.def_domain_type	= device_def_domain_type,
 	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
-#ifdef CONFIG_INTEL_IOMMU_SVM
-	.page_response		= intel_svm_page_response,
-#endif
+	.page_response		= intel_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= intel_iommu_attach_device,
 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index a969be2258b1..3bce514e1d88 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -719,12 +719,10 @@ struct intel_iommu {
 
 	struct iommu_flush flush;
 #endif
-#ifdef CONFIG_INTEL_IOMMU_SVM
 	struct page_req_dsc *prq;
 	unsigned char prq_name[16];    /* Name for PRQ interrupt */
 	unsigned long prq_seq_number;
 	struct completion prq_complete;
-#endif
 	struct iopf_queue *iopf_queue;
 	unsigned char iopfq_name[16];
 	/* Synchronization between fault report and iommu device release. */
@@ -1156,18 +1154,18 @@ void intel_context_flush_present(struct device_domain_info *info,
 				 struct context_entry *context,
 				 u16 did, bool affect_domains);
 
+int intel_enable_prq(struct intel_iommu *iommu);
+int intel_finish_prq(struct intel_iommu *iommu);
+void intel_page_response(struct device *dev, struct iopf_fault *evt,
+			struct iommu_page_response *msg);
+void intel_drain_pasid_prq(struct device *dev, u32 pasid);
+
 #ifdef CONFIG_INTEL_IOMMU_SVM
 void intel_svm_check(struct intel_iommu *iommu);
-int intel_svm_enable_prq(struct intel_iommu *iommu);
-int intel_svm_finish_prq(struct intel_iommu *iommu);
-void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
-			     struct iommu_page_response *msg);
 struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 					    struct mm_struct *mm);
-void intel_drain_pasid_prq(struct device *dev, u32 pasid);
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
-static inline void intel_drain_pasid_prq(struct device *dev, u32 pasid) {}
 static inline struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 							  struct mm_struct *mm)
 {
diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
new file mode 100644
index 000000000000..3376f60082b5
--- /dev/null
+++ b/drivers/iommu/intel/prq.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright © 2015 Intel Corporation.
+ *
+ * Originally split from drivers/iommu/intel/svm.c
+ */
+
+#include <linux/pci.h>
+#include <linux/pci-ats.h>
+
+#include "iommu.h"
+#include "../iommu-pages.h"
+#include "trace.h"
+
+/* Page request queue descriptor */
+struct page_req_dsc {
+	union {
+		struct {
+			u64 type:8;
+			u64 pasid_present:1;
+			u64 rsvd:7;
+			u64 rid:16;
+			u64 pasid:20;
+			u64 exe_req:1;
+			u64 pm_req:1;
+			u64 rsvd2:10;
+		};
+		u64 qw_0;
+	};
+	union {
+		struct {
+			u64 rd_req:1;
+			u64 wr_req:1;
+			u64 lpig:1;
+			u64 prg_index:9;
+			u64 addr:52;
+		};
+		u64 qw_1;
+	};
+	u64 qw_2;
+	u64 qw_3;
+};
+
+/**
+ * intel_drain_pasid_prq - Drain page requests and responses for a pasid
+ * @dev: target device
+ * @pasid: pasid for draining
+ *
+ * Drain all pending page requests and responses related to @pasid in both
+ * software and hardware. This is supposed to be called after the device
+ * driver has stopped DMA, the pasid entry has been cleared, and both IOTLB
+ * and DevTLB have been invalidated.
+ *
+ * It waits until all pending page requests for @pasid in the page fault
+ * queue are completed by the prq handling thread. Then follow the steps
+ * described in VT-d spec CH7.10 to drain all page requests and page
+ * responses pending in the hardware.
+ */
+void intel_drain_pasid_prq(struct device *dev, u32 pasid)
+{
+	struct device_domain_info *info;
+	struct dmar_domain *domain;
+	struct intel_iommu *iommu;
+	struct qi_desc desc[3];
+	struct pci_dev *pdev;
+	int head, tail;
+	u16 sid, did;
+	int qdep;
+
+	info = dev_iommu_priv_get(dev);
+	if (WARN_ON(!info || !dev_is_pci(dev)))
+		return;
+
+	if (!info->pri_enabled)
+		return;
+
+	iommu = info->iommu;
+	domain = info->domain;
+	pdev = to_pci_dev(dev);
+	sid = PCI_DEVID(info->bus, info->devfn);
+	did = domain_id_iommu(domain, iommu);
+	qdep = pci_ats_queue_depth(pdev);
+
+	/*
+	 * Check and wait until all pending page requests in the queue are
+	 * handled by the prq handling thread.
+	 */
+prq_retry:
+	reinit_completion(&iommu->prq_complete);
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	while (head != tail) {
+		struct page_req_dsc *req;
+
+		req = &iommu->prq[head / sizeof(*req)];
+		if (!req->pasid_present || req->pasid != pasid) {
+			head = (head + sizeof(*req)) & PRQ_RING_MASK;
+			continue;
+		}
+
+		wait_for_completion(&iommu->prq_complete);
+		goto prq_retry;
+	}
+
+	iopf_queue_flush_dev(dev);
+
+	/*
+	 * Perform steps described in VT-d spec CH7.10 to drain page
+	 * requests and responses in hardware.
+	 */
+	memset(desc, 0, sizeof(desc));
+	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
+			QI_IWD_FENCE |
+			QI_IWD_TYPE;
+	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
+			QI_EIOTLB_DID(did) |
+			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
+			QI_EIOTLB_TYPE;
+	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
+			QI_DEV_EIOTLB_SID(sid) |
+			QI_DEV_EIOTLB_QDEP(qdep) |
+			QI_DEIOTLB_TYPE |
+			QI_DEV_IOTLB_PFSID(info->pfsid);
+qi_retry:
+	reinit_completion(&iommu->prq_complete);
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		wait_for_completion(&iommu->prq_complete);
+		goto qi_retry;
+	}
+}
+
+
+static bool is_canonical_address(u64 addr)
+{
+	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
+	long saddr = (long) addr;
+
+	return (((saddr << shift) >> shift) == saddr);
+}
+
+static void handle_bad_prq_event(struct intel_iommu *iommu,
+				 struct page_req_dsc *req, int result)
+{
+	struct qi_desc desc = { };
+
+	pr_err("%s: Invalid page request: %08llx %08llx\n",
+	       iommu->name, ((unsigned long long *)req)[0],
+	       ((unsigned long long *)req)[1]);
+
+	if (!req->lpig)
+		return;
+
+	desc.qw0 = QI_PGRP_PASID(req->pasid) |
+			QI_PGRP_DID(req->rid) |
+			QI_PGRP_PASID_P(req->pasid_present) |
+			QI_PGRP_RESP_CODE(result) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
+			QI_PGRP_LPIG(req->lpig);
+
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
+static int prq_to_iommu_prot(struct page_req_dsc *req)
+{
+	int prot = 0;
+
+	if (req->rd_req)
+		prot |= IOMMU_FAULT_PERM_READ;
+	if (req->wr_req)
+		prot |= IOMMU_FAULT_PERM_WRITE;
+	if (req->exe_req)
+		prot |= IOMMU_FAULT_PERM_EXEC;
+	if (req->pm_req)
+		prot |= IOMMU_FAULT_PERM_PRIV;
+
+	return prot;
+}
+
+static void intel_prq_report(struct intel_iommu *iommu, struct device *dev,
+				 struct page_req_dsc *desc)
+{
+	struct iopf_fault event = { };
+
+	/* Fill in event data for device specific processing */
+	event.fault.type = IOMMU_FAULT_PAGE_REQ;
+	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
+	event.fault.prm.pasid = desc->pasid;
+	event.fault.prm.grpid = desc->prg_index;
+	event.fault.prm.perm = prq_to_iommu_prot(desc);
+
+	if (desc->lpig)
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+	if (desc->pasid_present) {
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
+	}
+
+	iommu_report_device_fault(dev, &event);
+}
+
+static irqreturn_t prq_event_thread(int irq, void *d)
+{
+	struct intel_iommu *iommu = d;
+	struct page_req_dsc *req;
+	int head, tail, handled;
+	struct device *dev;
+	u64 address;
+
+	/*
+	 * Clear PPR bit before reading head/tail registers, to ensure that
+	 * we get a new interrupt if needed.
+	 */
+	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
+
+	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+	handled = (head != tail);
+	while (head != tail) {
+		req = &iommu->prq[head / sizeof(*req)];
+		address = (u64)req->addr << VTD_PAGE_SHIFT;
+
+		if (unlikely(!req->pasid_present)) {
+			pr_err("IOMMU: %s: Page request without PASID\n",
+			       iommu->name);
+bad_req:
+			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
+			goto prq_advance;
+		}
+
+		if (unlikely(!is_canonical_address(address))) {
+			pr_err("IOMMU: %s: Address is not canonical\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
+			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		if (unlikely(req->exe_req && req->rd_req)) {
+			pr_err("IOMMU: %s: Execution request not supported\n",
+			       iommu->name);
+			goto bad_req;
+		}
+
+		/* Drop Stop Marker message. No need for a response. */
+		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
+			goto prq_advance;
+
+		/*
+		 * If prq is to be handled outside iommu driver via receiver of
+		 * the fault notifiers, we skip the page response here.
+		 */
+		mutex_lock(&iommu->iopf_lock);
+		dev = device_rbtree_find(iommu, req->rid);
+		if (!dev) {
+			mutex_unlock(&iommu->iopf_lock);
+			goto bad_req;
+		}
+
+		intel_prq_report(iommu, dev, req);
+		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
+				 req->qw_2, req->qw_3,
+				 iommu->prq_seq_number++);
+		mutex_unlock(&iommu->iopf_lock);
+prq_advance:
+		head = (head + sizeof(*req)) & PRQ_RING_MASK;
+	}
+
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
+
+	/*
+	 * Clear the page request overflow bit and wake up all threads that
+	 * are waiting for the completion of this handling.
+	 */
+	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
+		pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
+				    iommu->name);
+		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
+		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
+		if (head == tail) {
+			iopf_queue_discard_partial(iommu->iopf_queue);
+			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
+			pr_info_ratelimited("IOMMU: %s: PRQ overflow cleared",
+					    iommu->name);
+		}
+	}
+
+	if (!completion_done(&iommu->prq_complete))
+		complete(&iommu->prq_complete);
+
+	return IRQ_RETVAL(handled);
+}
+
+int intel_enable_prq(struct intel_iommu *iommu)
+{
+	struct iopf_queue *iopfq;
+	int irq, ret;
+
+	iommu->prq = iommu_alloc_pages_node(iommu->node, GFP_KERNEL, PRQ_ORDER);
+	if (!iommu->prq) {
+		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
+			iommu->name);
+		return -ENOMEM;
+	}
+
+	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
+	if (irq <= 0) {
+		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
+		       iommu->name);
+		ret = -EINVAL;
+		goto free_prq;
+	}
+	iommu->pr_irq = irq;
+
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "dmar%d-iopfq", iommu->seq_id);
+	iopfq = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iopfq) {
+		pr_err("IOMMU: %s: Failed to allocate iopf queue\n", iommu->name);
+		ret = -ENOMEM;
+		goto free_hwirq;
+	}
+	iommu->iopf_queue = iopfq;
+
+	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
+
+	ret = request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
+				   iommu->prq_name, iommu);
+	if (ret) {
+		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
+		       iommu->name);
+		goto free_iopfq;
+	}
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
+
+	init_completion(&iommu->prq_complete);
+
+	return 0;
+
+free_iopfq:
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+free_hwirq:
+	dmar_free_hwirq(irq);
+	iommu->pr_irq = 0;
+free_prq:
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
+	iommu->prq = NULL;
+
+	return ret;
+}
+
+int intel_finish_prq(struct intel_iommu *iommu)
+{
+	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
+	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
+
+	if (iommu->pr_irq) {
+		free_irq(iommu->pr_irq, iommu);
+		dmar_free_hwirq(iommu->pr_irq);
+		iommu->pr_irq = 0;
+	}
+
+	if (iommu->iopf_queue) {
+		iopf_queue_free(iommu->iopf_queue);
+		iommu->iopf_queue = NULL;
+	}
+
+	iommu_free_pages(iommu->prq, PRQ_ORDER);
+	iommu->prq = NULL;
+
+	return 0;
+}
+
+void intel_page_response(struct device *dev, struct iopf_fault *evt,
+			 struct iommu_page_response *msg)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	u8 bus = info->bus, devfn = info->devfn;
+	struct iommu_fault_page_request *prm;
+	struct qi_desc desc;
+	bool pasid_present;
+	bool last_page;
+	u16 sid;
+
+	prm = &evt->fault.prm;
+	sid = PCI_DEVID(bus, devfn);
+	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
+	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
+
+	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
+			QI_PGRP_PASID_P(pasid_present) |
+			QI_PGRP_RESP_CODE(msg->code) |
+			QI_PGRP_RESP_TYPE;
+	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
+	desc.qw2 = 0;
+	desc.qw3 = 0;
+
+	qi_submit_sync(iommu, &desc, 1, 0);
+}
+
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 0e3a9b38bef2..6ab7d9d03d3d 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -25,92 +25,6 @@
 #include "../iommu-pages.h"
 #include "trace.h"
 
-static irqreturn_t prq_event_thread(int irq, void *d);
-
-int intel_svm_enable_prq(struct intel_iommu *iommu)
-{
-	struct iopf_queue *iopfq;
-	int irq, ret;
-
-	iommu->prq = iommu_alloc_pages_node(iommu->node, GFP_KERNEL, PRQ_ORDER);
-	if (!iommu->prq) {
-		pr_warn("IOMMU: %s: Failed to allocate page request queue\n",
-			iommu->name);
-		return -ENOMEM;
-	}
-
-	irq = dmar_alloc_hwirq(IOMMU_IRQ_ID_OFFSET_PRQ + iommu->seq_id, iommu->node, iommu);
-	if (irq <= 0) {
-		pr_err("IOMMU: %s: Failed to create IRQ vector for page request queue\n",
-		       iommu->name);
-		ret = -EINVAL;
-		goto free_prq;
-	}
-	iommu->pr_irq = irq;
-
-	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
-		 "dmar%d-iopfq", iommu->seq_id);
-	iopfq = iopf_queue_alloc(iommu->iopfq_name);
-	if (!iopfq) {
-		pr_err("IOMMU: %s: Failed to allocate iopf queue\n", iommu->name);
-		ret = -ENOMEM;
-		goto free_hwirq;
-	}
-	iommu->iopf_queue = iopfq;
-
-	snprintf(iommu->prq_name, sizeof(iommu->prq_name), "dmar%d-prq", iommu->seq_id);
-
-	ret = request_threaded_irq(irq, NULL, prq_event_thread, IRQF_ONESHOT,
-				   iommu->prq_name, iommu);
-	if (ret) {
-		pr_err("IOMMU: %s: Failed to request IRQ for page request queue\n",
-		       iommu->name);
-		goto free_iopfq;
-	}
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu->prq) | PRQ_ORDER);
-
-	init_completion(&iommu->prq_complete);
-
-	return 0;
-
-free_iopfq:
-	iopf_queue_free(iommu->iopf_queue);
-	iommu->iopf_queue = NULL;
-free_hwirq:
-	dmar_free_hwirq(irq);
-	iommu->pr_irq = 0;
-free_prq:
-	iommu_free_pages(iommu->prq, PRQ_ORDER);
-	iommu->prq = NULL;
-
-	return ret;
-}
-
-int intel_svm_finish_prq(struct intel_iommu *iommu)
-{
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
-	dmar_writeq(iommu->reg + DMAR_PQA_REG, 0ULL);
-
-	if (iommu->pr_irq) {
-		free_irq(iommu->pr_irq, iommu);
-		dmar_free_hwirq(iommu->pr_irq);
-		iommu->pr_irq = 0;
-	}
-
-	if (iommu->iopf_queue) {
-		iopf_queue_free(iommu->iopf_queue);
-		iommu->iopf_queue = NULL;
-	}
-
-	iommu_free_pages(iommu->prq, PRQ_ORDER);
-	iommu->prq = NULL;
-
-	return 0;
-}
-
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -237,317 +151,6 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 	return ret;
 }
 
-/* Page request queue descriptor */
-struct page_req_dsc {
-	union {
-		struct {
-			u64 type:8;
-			u64 pasid_present:1;
-			u64 rsvd:7;
-			u64 rid:16;
-			u64 pasid:20;
-			u64 exe_req:1;
-			u64 pm_req:1;
-			u64 rsvd2:10;
-		};
-		u64 qw_0;
-	};
-	union {
-		struct {
-			u64 rd_req:1;
-			u64 wr_req:1;
-			u64 lpig:1;
-			u64 prg_index:9;
-			u64 addr:52;
-		};
-		u64 qw_1;
-	};
-	u64 qw_2;
-	u64 qw_3;
-};
-
-static bool is_canonical_address(u64 addr)
-{
-	int shift = 64 - (__VIRTUAL_MASK_SHIFT + 1);
-	long saddr = (long) addr;
-
-	return (((saddr << shift) >> shift) == saddr);
-}
-
-/**
- * intel_drain_pasid_prq - Drain page requests and responses for a pasid
- * @dev: target device
- * @pasid: pasid for draining
- *
- * Drain all pending page requests and responses related to @pasid in both
- * software and hardware. This is supposed to be called after the device
- * driver has stopped DMA, the pasid entry has been cleared, and both IOTLB
- * and DevTLB have been invalidated.
- *
- * It waits until all pending page requests for @pasid in the page fault
- * queue are completed by the prq handling thread. Then follow the steps
- * described in VT-d spec CH7.10 to drain all page requests and page
- * responses pending in the hardware.
- */
-void intel_drain_pasid_prq(struct device *dev, u32 pasid)
-{
-	struct device_domain_info *info;
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-	struct qi_desc desc[3];
-	struct pci_dev *pdev;
-	int head, tail;
-	u16 sid, did;
-	int qdep;
-
-	info = dev_iommu_priv_get(dev);
-	if (WARN_ON(!info || !dev_is_pci(dev)))
-		return;
-
-	if (!info->pri_enabled)
-		return;
-
-	iommu = info->iommu;
-	domain = info->domain;
-	pdev = to_pci_dev(dev);
-	sid = PCI_DEVID(info->bus, info->devfn);
-	did = domain_id_iommu(domain, iommu);
-	qdep = pci_ats_queue_depth(pdev);
-
-	/*
-	 * Check and wait until all pending page requests in the queue are
-	 * handled by the prq handling thread.
-	 */
-prq_retry:
-	reinit_completion(&iommu->prq_complete);
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-	while (head != tail) {
-		struct page_req_dsc *req;
-
-		req = &iommu->prq[head / sizeof(*req)];
-		if (!req->pasid_present || req->pasid != pasid) {
-			head = (head + sizeof(*req)) & PRQ_RING_MASK;
-			continue;
-		}
-
-		wait_for_completion(&iommu->prq_complete);
-		goto prq_retry;
-	}
-
-	iopf_queue_flush_dev(dev);
-
-	/*
-	 * Perform steps described in VT-d spec CH7.10 to drain page
-	 * requests and responses in hardware.
-	 */
-	memset(desc, 0, sizeof(desc));
-	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
-			QI_IWD_FENCE |
-			QI_IWD_TYPE;
-	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
-			QI_EIOTLB_DID(did) |
-			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
-			QI_EIOTLB_TYPE;
-	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
-			QI_DEV_EIOTLB_SID(sid) |
-			QI_DEV_EIOTLB_QDEP(qdep) |
-			QI_DEIOTLB_TYPE |
-			QI_DEV_IOTLB_PFSID(info->pfsid);
-qi_retry:
-	reinit_completion(&iommu->prq_complete);
-	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
-	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
-		wait_for_completion(&iommu->prq_complete);
-		goto qi_retry;
-	}
-}
-
-static int prq_to_iommu_prot(struct page_req_dsc *req)
-{
-	int prot = 0;
-
-	if (req->rd_req)
-		prot |= IOMMU_FAULT_PERM_READ;
-	if (req->wr_req)
-		prot |= IOMMU_FAULT_PERM_WRITE;
-	if (req->exe_req)
-		prot |= IOMMU_FAULT_PERM_EXEC;
-	if (req->pm_req)
-		prot |= IOMMU_FAULT_PERM_PRIV;
-
-	return prot;
-}
-
-static void intel_svm_prq_report(struct intel_iommu *iommu, struct device *dev,
-				 struct page_req_dsc *desc)
-{
-	struct iopf_fault event = { };
-
-	/* Fill in event data for device specific processing */
-	event.fault.type = IOMMU_FAULT_PAGE_REQ;
-	event.fault.prm.addr = (u64)desc->addr << VTD_PAGE_SHIFT;
-	event.fault.prm.pasid = desc->pasid;
-	event.fault.prm.grpid = desc->prg_index;
-	event.fault.prm.perm = prq_to_iommu_prot(desc);
-
-	if (desc->lpig)
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
-	if (desc->pasid_present) {
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-		event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
-	}
-
-	iommu_report_device_fault(dev, &event);
-}
-
-static void handle_bad_prq_event(struct intel_iommu *iommu,
-				 struct page_req_dsc *req, int result)
-{
-	struct qi_desc desc = { };
-
-	pr_err("%s: Invalid page request: %08llx %08llx\n",
-	       iommu->name, ((unsigned long long *)req)[0],
-	       ((unsigned long long *)req)[1]);
-
-	if (!req->lpig)
-		return;
-
-	desc.qw0 = QI_PGRP_PASID(req->pasid) |
-			QI_PGRP_DID(req->rid) |
-			QI_PGRP_PASID_P(req->pasid_present) |
-			QI_PGRP_RESP_CODE(result) |
-			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(req->prg_index) |
-			QI_PGRP_LPIG(req->lpig);
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
-static irqreturn_t prq_event_thread(int irq, void *d)
-{
-	struct intel_iommu *iommu = d;
-	struct page_req_dsc *req;
-	int head, tail, handled;
-	struct device *dev;
-	u64 address;
-
-	/*
-	 * Clear PPR bit before reading head/tail registers, to ensure that
-	 * we get a new interrupt if needed.
-	 */
-	writel(DMA_PRS_PPR, iommu->reg + DMAR_PRS_REG);
-
-	tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-	head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-	handled = (head != tail);
-	while (head != tail) {
-		req = &iommu->prq[head / sizeof(*req)];
-		address = (u64)req->addr << VTD_PAGE_SHIFT;
-
-		if (unlikely(!req->pasid_present)) {
-			pr_err("IOMMU: %s: Page request without PASID\n",
-			       iommu->name);
-bad_req:
-			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
-			goto prq_advance;
-		}
-
-		if (unlikely(!is_canonical_address(address))) {
-			pr_err("IOMMU: %s: Address is not canonical\n",
-			       iommu->name);
-			goto bad_req;
-		}
-
-		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
-			pr_err("IOMMU: %s: Page request in Privilege Mode\n",
-			       iommu->name);
-			goto bad_req;
-		}
-
-		if (unlikely(req->exe_req && req->rd_req)) {
-			pr_err("IOMMU: %s: Execution request not supported\n",
-			       iommu->name);
-			goto bad_req;
-		}
-
-		/* Drop Stop Marker message. No need for a response. */
-		if (unlikely(req->lpig && !req->rd_req && !req->wr_req))
-			goto prq_advance;
-
-		/*
-		 * If prq is to be handled outside iommu driver via receiver of
-		 * the fault notifiers, we skip the page response here.
-		 */
-		mutex_lock(&iommu->iopf_lock);
-		dev = device_rbtree_find(iommu, req->rid);
-		if (!dev) {
-			mutex_unlock(&iommu->iopf_lock);
-			goto bad_req;
-		}
-
-		intel_svm_prq_report(iommu, dev, req);
-		trace_prq_report(iommu, dev, req->qw_0, req->qw_1,
-				 req->qw_2, req->qw_3,
-				 iommu->prq_seq_number++);
-		mutex_unlock(&iommu->iopf_lock);
-prq_advance:
-		head = (head + sizeof(*req)) & PRQ_RING_MASK;
-	}
-
-	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
-
-	/*
-	 * Clear the page request overflow bit and wake up all threads that
-	 * are waiting for the completion of this handling.
-	 */
-	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
-		pr_info_ratelimited("IOMMU: %s: PRQ overflow detected\n",
-				    iommu->name);
-		head = dmar_readq(iommu->reg + DMAR_PQH_REG) & PRQ_RING_MASK;
-		tail = dmar_readq(iommu->reg + DMAR_PQT_REG) & PRQ_RING_MASK;
-		if (head == tail) {
-			iopf_queue_discard_partial(iommu->iopf_queue);
-			writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
-			pr_info_ratelimited("IOMMU: %s: PRQ overflow cleared",
-					    iommu->name);
-		}
-	}
-
-	if (!completion_done(&iommu->prq_complete))
-		complete(&iommu->prq_complete);
-
-	return IRQ_RETVAL(handled);
-}
-
-void intel_svm_page_response(struct device *dev, struct iopf_fault *evt,
-			     struct iommu_page_response *msg)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct intel_iommu *iommu = info->iommu;
-	u8 bus = info->bus, devfn = info->devfn;
-	struct iommu_fault_page_request *prm;
-	struct qi_desc desc;
-	bool pasid_present;
-	bool last_page;
-	u16 sid;
-
-	prm = &evt->fault.prm;
-	sid = PCI_DEVID(bus, devfn);
-	pasid_present = prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-	last_page = prm->flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
-
-	desc.qw0 = QI_PGRP_PASID(prm->pasid) | QI_PGRP_DID(sid) |
-			QI_PGRP_PASID_P(pasid_present) |
-			QI_PGRP_RESP_CODE(msg->code) |
-			QI_PGRP_RESP_TYPE;
-	desc.qw1 = QI_PGRP_IDX(prm->grpid) | QI_PGRP_LPIG(last_page);
-	desc.qw2 = 0;
-	desc.qw3 = 0;
-
-	qi_submit_sync(iommu, &desc, 1, 0);
-}
-
 static void intel_svm_domain_free(struct iommu_domain *domain)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);

-- 
2.43.0




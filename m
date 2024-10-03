Return-Path: <linux-kernel+bounces-348962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E761B98EE81
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CBEAB24CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41BF15B11E;
	Thu,  3 Oct 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GSMH+WzW"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB362156673
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956285; cv=none; b=CSzcJ2j+nZxy2mliwQ8alCl32AAZAiDTQAfEY8sVGBvApBQILYrdfIG/D8PZMMbNE2DpyxYWDeX5ZVBdEux8ZXksluxtV4OM0V2kuDIt8f29r2iL7+SYcXm5Tv8YoAlyxa/7chMS8t9aY0BOoPnRQPhJ6GXqs+kMBS/Xpjp/8N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956285; c=relaxed/simple;
	bh=qCePLYQWETvFswIPegn7Yq8MS5NRYyIWsn3nOtKnDAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCCgqj//movrWfRK8O+nFRFNF/+qolZVWzEFVETHWjbsDLA7kXLIt7/C7ZbbSIlvuVwmvcCGfS1Okv2HsK/WsCfUscRUGE+jwD/CAWXvQEMCmvAtMEPFYIuS4xZm/l9e9UQqWrtQh8tRCl1si1RG3Y9G2uecElYxqPsHgr/JGUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=GSMH+WzW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4932xw5b027256;
	Thu, 3 Oct 2024 04:51:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=2
	1r/pRTvu0ZWANS2NWskARcXDv9yMbMwJ3QbQtpPAkI=; b=GSMH+WzW83JoAR5DA
	drQFKT9hhqpAiEosLjLCjgZ29DK8cTEXKJNS7ouOE2skIeTgRDgO+PYGCsO9eJ2W
	06MH5iUnWjWGSKOAmX8UvcxUUoM0xDPv0iJ8/tT2kKMbDsQadMVz+WfS5QFnN5S1
	4wUPbgbr27V9wHutH2FjdiqqIrH9sngIIrWRZAbEUXqHlcKoYBbye/XrGjRDUx8v
	OBIxmF22IUtODU0Kk4Lj17o6CAzfB9TS3rmGEXf7aPSwsOMG8xgvan4fdVmABhmk
	iwnDHIjpyRgSXtcw8y0GQXEvY/dYS34bCHfaW8AMs0oalk299xyVmAc3ypdM4wsY
	GNizA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 421amr9ppr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 04:51:10 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 04:51:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 04:51:09 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id 146635B6927;
	Thu,  3 Oct 2024 04:51:06 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v3 2/4] soc: marvell: rvu-pf: Add PF to AF mailbox communication support.
Date: Thu, 3 Oct 2024 17:20:55 +0530
Message-ID: <20241003115057.2810857-3-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003115057.2810857-1-agaur@marvell.com>
References: <20241003115057.2810857-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uytMHicNkGusvVQqTDPX1zTO_AUhd8GK
X-Proofpoint-GUID: uytMHicNkGusvVQqTDPX1zTO_AUhd8GK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Resource provisioning for virtual functions (VFs) is done by RVU admin
function (AF). RVU PF and AF shares a memory region which can be used
for communication. This patch adds support for mailbox communication
between PF and AF, notification of messages is via IRQs.

Example mailbox messages types and structures can be found at
drivers/net/ethernet/marvell/octeontx2/af/mbox.h

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 265 +++++++++++++++++++++++-
 drivers/soc/marvell/rvu_gen_pf/gen_pf.h | 124 +++++++++++
 2 files changed, 388 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
index 6437916cb6d7..a03fc3f16c69 100644
--- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
@@ -16,6 +16,10 @@
 #include <rvu_trace.h>
 #include <rvu.h>
 
+ /* PCI BAR nos */
+#define PCI_CFG_REG_BAR_NUM		2
+#define PCI_MBOX_BAR_NUM		4
+
 #define DRV_NAME    "rvu_generic_pf"
 
 /* Supported devices */
@@ -46,6 +50,230 @@ static int rvu_gen_pf_check_pf_usable(struct gen_pf_dev *pfdev)
 	return 0;
 }
 
+static irqreturn_t rvu_gen_pf_pfaf_mbox_intr_handler(int irq, void *pf_irq)
+{
+	struct gen_pf_dev *pfdev = (struct gen_pf_dev *)pf_irq;
+	struct mbox *mw = &pfdev->mbox;
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	u64 mbox_data;
+
+	/* Clear the IRQ */
+	writeq(BIT_ULL(0), pfdev->reg_base + RVU_PF_INT);
+
+	mbox_data = readq(pfdev->reg_base + RVU_PF_PFAF_MBOX0);
+
+	if (mbox_data & MBOX_UP_MSG) {
+		mbox_data &= ~MBOX_UP_MSG;
+		writeq(mbox_data, pfdev->reg_base + RVU_PF_PFAF_MBOX0);
+
+		mbox = &mw->mbox_up;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(pfdev->mbox_wq, &mw->mbox_up_wrk);
+
+		trace_otx2_msg_interrupt(pfdev->pdev, "UP message from AF to PF",
+					 BIT_ULL(0));
+	}
+
+	if (mbox_data & MBOX_DOWN_MSG) {
+		mbox_data &= ~MBOX_DOWN_MSG;
+		writeq(mbox_data, pfdev->reg_base + RVU_PF_PFAF_MBOX0);
+
+		mbox = &mw->mbox;
+		mdev = &mbox->dev[0];
+		otx2_sync_mbox_bbuf(mbox, 0);
+
+		hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+		if (hdr->num_msgs)
+			queue_work(pfdev->mbox_wq, &mw->mbox_wrk);
+
+		trace_otx2_msg_interrupt(pfdev->pdev, "DOWN reply from AF to PF",
+					 BIT_ULL(0));
+	}
+	return IRQ_HANDLED;
+}
+
+static void rvu_gen_pf_disable_mbox_intr(struct gen_pf_dev *pfdev)
+{
+	int vector = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_AFPF_MBOX);
+
+	/* Disable AF => PF mailbox IRQ */
+	writeq(BIT_ULL(0), pfdev->reg_base + RVU_PF_INT_ENA_W1C);
+	free_irq(vector, pfdev);
+}
+
+static int rvu_gen_pf_register_mbox_intr(struct gen_pf_dev *pfdev)
+{
+	struct msg_req *req;
+	char *irq_name;
+	int err;
+
+	/* Register mailbox interrupt handler */
+	irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_AFPF_MBOX * NAME_SIZE];
+	snprintf(irq_name, NAME_SIZE, "Generic RVUPFAF Mbox");
+	err = request_irq(pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_AFPF_MBOX),
+			  rvu_gen_pf_pfaf_mbox_intr_handler, 0, irq_name, pfdev);
+	if (err) {
+		dev_err(pfdev->dev,
+			"GenPF: IRQ registration failed for PFAF mbox irq\n");
+		return err;
+	}
+
+	/*
+	 * Enable mailbox interrupt for msgs coming from AF.
+	 * First clear to avoid spurious interrupts, if any.
+	 */
+	writeq(BIT_ULL(0), pfdev->reg_base + RVU_PF_INT);
+	writeq(BIT_ULL(0), pfdev->reg_base + RVU_PF_INT_ENA_W1S);
+
+	/* Check mailbox communication with AF */
+	req = gen_pf_mbox_alloc_msg_ready(&pfdev->mbox);
+	if (!req) {
+		rvu_gen_pf_disable_mbox_intr(pfdev);
+		return -ENOMEM;
+	}
+	err = rvu_gen_pf_sync_mbox_msg(&pfdev->mbox);
+	if (err) {
+		dev_warn(pfdev->dev,
+			 "AF not responding to mailbox, deferring probe\n");
+		rvu_gen_pf_disable_mbox_intr(pfdev);
+		return -EPROBE_DEFER;
+	}
+	return 0;
+}
+
+static void rvu_gen_pf_pfaf_mbox_destroy(struct gen_pf_dev *pfdev)
+{
+	struct mbox *mbox = &pfdev->mbox;
+
+	if (pfdev->mbox_wq) {
+		destroy_workqueue(pfdev->mbox_wq);
+		pfdev->mbox_wq = NULL;
+	}
+
+	if (mbox->mbox.hwbase)
+		iounmap((void __iomem *)mbox->mbox.hwbase);
+
+	otx2_mbox_destroy(&mbox->mbox);
+	otx2_mbox_destroy(&mbox->mbox_up);
+}
+
+static void rvu_gen_pf_process_pfaf_mbox_msg(struct gen_pf_dev *pfdev,
+					     struct mbox_msghdr *msg)
+{
+	if (msg->id >= MBOX_MSG_MAX) {
+		dev_err(pfdev->dev,
+			"Mbox msg with unknown ID 0x%x\n", msg->id);
+		return;
+	}
+
+	if (msg->sig != OTX2_MBOX_RSP_SIG) {
+		dev_err(pfdev->dev,
+			"Mbox msg with wrong signature %x, ID 0x%x\n",
+			 msg->sig, msg->id);
+		return;
+	}
+
+	switch (msg->id) {
+	case MBOX_MSG_READY:
+		pfdev->pcifunc = msg->pcifunc;
+		break;
+	default:
+		if (msg->rc)
+			dev_err(pfdev->dev,
+				"Mbox msg response has err %d, ID 0x%x\n",
+				msg->rc, msg->id);
+		break;
+	}
+}
+
+static void rvu_gen_pf_pfaf_mbox_handler(struct work_struct *work)
+{
+	struct otx2_mbox_dev *mdev;
+	struct gen_pf_dev *pfdev;
+	struct mbox_hdr *rsp_hdr;
+	struct mbox_msghdr *msg;
+	struct otx2_mbox *mbox;
+	struct mbox *af_mbox;
+	int offset, id;
+	u16 num_msgs;
+
+	af_mbox = container_of(work, struct mbox, mbox_wrk);
+	mbox = &af_mbox->mbox;
+	mdev = &mbox->dev[0];
+	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	num_msgs = rsp_hdr->num_msgs;
+
+	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
+	pfdev = af_mbox->pfvf;
+
+	for (id = 0; id < num_msgs; id++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
+		rvu_gen_pf_process_pfaf_mbox_msg(pfdev, msg);
+		offset = mbox->rx_start + msg->next_msgoff;
+		if (mdev->msgs_acked == (num_msgs - 1))
+			__otx2_mbox_reset(mbox, 0);
+		mdev->msgs_acked++;
+	}
+}
+
+static int rvu_gen_pf_pfaf_mbox_init(struct gen_pf_dev *pfdev)
+{
+	struct mbox *mbox = &pfdev->mbox;
+	void __iomem *hwbase;
+	int err;
+
+	mbox->pfvf = pfdev;
+	pfdev->mbox_wq = alloc_ordered_workqueue("otx2_pfaf_mailbox",
+						 WQ_HIGHPRI | WQ_MEM_RECLAIM);
+
+	if (!pfdev->mbox_wq)
+		return -ENOMEM;
+
+	/*
+	 * Mailbox is a reserved memory (in RAM) region shared between
+	 * admin function (i.e AF) and this PF, shouldn't be mapped as
+	 * device memory to allow unaligned accesses.
+	 */
+
+	hwbase = ioremap_wc(pci_resource_start(pfdev->pdev, PCI_MBOX_BAR_NUM),
+			    MBOX_SIZE);
+
+	if (!hwbase) {
+		dev_err(pfdev->dev, "Unable to map PFAF mailbox region\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	err = otx2_mbox_init(&mbox->mbox, hwbase, pfdev->pdev, pfdev->reg_base,
+			     MBOX_DIR_PFAF, 1);
+	if (err)
+		goto exit;
+
+	err = otx2_mbox_init(&mbox->mbox_up, hwbase, pfdev->pdev, pfdev->reg_base,
+			     MBOX_DIR_PFAF_UP, 1);
+
+	if (err)
+		goto exit;
+
+	err = otx2_mbox_bbuf_init(mbox, pfdev->pdev);
+	if (err)
+		goto exit;
+
+	INIT_WORK(&mbox->mbox_wrk, rvu_gen_pf_pfaf_mbox_handler);
+	mutex_init(&mbox->lock);
+
+	return 0;
+exit:
+	rvu_gen_pf_pfaf_mbox_destroy(pfdev);
+	return err;
+}
+
 static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
 {
 	int ret;
@@ -91,6 +319,7 @@ static int rvu_gen_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id
 {
 	struct device *dev = &pdev->dev;
 	struct gen_pf_dev *pfdev;
+	int num_vec;
 	int err;
 
 	err = pcim_enable_device(pdev);
@@ -123,13 +352,47 @@ static int rvu_gen_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	pfdev->pdev = pdev;
 	pfdev->dev = dev;
 	pfdev->total_vfs = pci_sriov_get_totalvfs(pdev);
+	num_vec = pci_msix_vec_count(pdev);
+	pfdev->irq_name = devm_kmalloc_array(&pfdev->pdev->dev, num_vec, NAME_SIZE,
+					     GFP_KERNEL);
+
+	/* Map CSRs */
+	pfdev->reg_base = pcim_iomap(pdev, PCI_CFG_REG_BAR_NUM, 0);
+	if (!pfdev->reg_base) {
+		dev_err(dev, "Unable to map physical function CSRs, aborting\n");
+		err = -ENOMEM;
+		goto err_release_regions;
+	}
 
 	err = rvu_gen_pf_check_pf_usable(pfdev);
 	if (err)
-		goto err_release_regions;
+		goto err_pcim_iounmap;
+
+	err = pci_alloc_irq_vectors(pfdev->pdev, num_vec, num_vec, PCI_IRQ_MSIX);
+	if (err < 0) {
+		dev_err(dev, "%s: Failed to alloc %d IRQ vectors\n",
+			__func__, num_vec);
+		goto err_pcim_iounmap;
+	}
+
+	/* Init PF <=> AF mailbox stuff */
+	err = rvu_gen_pf_pfaf_mbox_init(pfdev);
+	if (err)
+		goto err_free_irq_vectors;
+
+	/* Register mailbox interrupt */
+	err = rvu_gen_pf_register_mbox_intr(pfdev);
+	if (err)
+		goto err_mbox_destroy;
 
 	return 0;
 
+err_mbox_destroy:
+	rvu_gen_pf_pfaf_mbox_destroy(pfdev);
+err_free_irq_vectors:
+	pci_free_irq_vectors(pfdev->pdev);
+err_pcim_iounmap:
+	pcim_iounmap(pdev, pfdev->reg_base);
 err_release_regions:
 	pci_release_regions(pdev);
 	pci_set_drvdata(pdev, NULL);
diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
index d89b674b1a0f..2019bea10ad0 100644
--- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
@@ -5,15 +5,139 @@
  */
 #include <linux/device.h>
 #include <linux/pci.h>
+#include <rvu_trace.h>
+#include "mbox.h"
 
 #define RVU_PFFUNC(pf, func)    \
 	((((pf) & RVU_PFVF_PF_MASK) << RVU_PFVF_PF_SHIFT) | \
 	(((func) & RVU_PFVF_FUNC_MASK) << RVU_PFVF_FUNC_SHIFT))
 
+#define NAME_SIZE		32
+
+struct gen_pf_dev;
+
+struct mbox {
+	struct otx2_mbox	mbox;
+	struct work_struct	mbox_wrk;
+	struct otx2_mbox	mbox_up;
+	struct work_struct	mbox_up_wrk;
+	struct gen_pf_dev	*pfvf;
+	void			*bbuf_base; /* Bounce buffer for mbox memory */
+	struct mutex		lock;   /* serialize mailbox access */
+	int			num_msgs; /* mbox number of messages */
+	int			up_num_msgs; /* mbox_up number of messages */
+};
+
 struct gen_pf_dev {
 	struct pci_dev		*pdev;
 	struct device		*dev;
 	void __iomem		*reg_base;
+	char			*irq_name;
+	struct work_struct	mbox_wrk;
+	struct work_struct	mbox_wrk_up;
+
+	/* Mbox */
+	struct mbox		mbox;
+	struct workqueue_struct *mbox_wq;
+
 	int			pf;
+	u16			pcifunc; /* RVU PF_FUNC */
 	u8			total_vfs;
 };
+
+/* Mbox APIs */
+static inline int rvu_gen_pf_sync_mbox_msg(struct mbox *mbox)
+{
+	int err;
+
+	if (!otx2_mbox_nonempty(&mbox->mbox, 0))
+		return 0;
+	otx2_mbox_msg_send(&mbox->mbox, 0);
+	err = otx2_mbox_wait_for_rsp(&mbox->mbox, 0);
+	if (err)
+		return err;
+
+	return otx2_mbox_check_rsp_msgs(&mbox->mbox, 0);
+}
+
+static inline int rvu_gen_pf_sync_mbox_up_msg(struct mbox *mbox, int devid)
+{
+	int err;
+
+	if (!otx2_mbox_nonempty(&mbox->mbox_up, devid))
+		return 0;
+	otx2_mbox_msg_send_up(&mbox->mbox_up, devid);
+	err = otx2_mbox_wait_for_rsp(&mbox->mbox_up, devid);
+	if (err)
+		return err;
+
+	return otx2_mbox_check_rsp_msgs(&mbox->mbox_up, devid);
+}
+
+#define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
+static struct _req_type __maybe_unused					\
+*gen_pf_mbox_alloc_msg_ ## _fn_name(struct mbox *mbox)			\
+{									\
+	struct _req_type *req;						\
+	u16 id = _id;							\
+									\
+	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
+		&mbox->mbox, 0, sizeof(struct _req_type),		\
+		sizeof(struct _rsp_type));				\
+	if (!req)							\
+		return NULL;						\
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
+	req->hdr.id = id;						\
+	trace_otx2_msg_alloc(mbox->mbox.pdev, id, sizeof(*req));	\
+	return req;							\
+}
+
+MBOX_MESSAGES
+#undef M
+
+/* Mbox bounce buffer APIs */
+static inline int otx2_mbox_bbuf_init(struct mbox *mbox, struct pci_dev *pdev)
+{
+	struct otx2_mbox *otx2_mbox;
+	struct otx2_mbox_dev *mdev;
+
+	mbox->bbuf_base = devm_kmalloc(&pdev->dev, MBOX_SIZE, GFP_KERNEL);
+
+	if (!mbox->bbuf_base)
+		return -ENOMEM;
+
+	/* Overwrite mbox mbase to point to bounce buffer, so that PF/VF
+	 * prepare all mbox messages in bounce buffer instead of directly
+	 * in hw mbox memory.
+	 */
+	otx2_mbox = &mbox->mbox;
+	mdev = &otx2_mbox->dev[0];
+	mdev->mbase = mbox->bbuf_base;
+
+	otx2_mbox = &mbox->mbox_up;
+	mdev = &otx2_mbox->dev[0];
+	mdev->mbase = mbox->bbuf_base;
+	return 0;
+}
+
+static inline void otx2_sync_mbox_bbuf(struct otx2_mbox *mbox, int devid)
+{
+	u16 msgs_offset = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	void *hw_mbase = mbox->hwbase + (devid * MBOX_SIZE);
+	struct otx2_mbox_dev *mdev = &mbox->dev[devid];
+	struct mbox_hdr *hdr;
+	u64 msg_size;
+
+	if (mdev->mbase == hw_mbase)
+		return;
+
+	hdr = hw_mbase + mbox->rx_start;
+	msg_size = hdr->msg_size;
+
+	if (msg_size > mbox->rx_size - msgs_offset)
+		msg_size = mbox->rx_size - msgs_offset;
+
+	/* Copy mbox messages from mbox memory to bounce buffer */
+	memcpy(mdev->mbase + mbox->rx_start,
+	       hw_mbase + mbox->rx_start, msg_size + msgs_offset);
+}
-- 
2.25.1



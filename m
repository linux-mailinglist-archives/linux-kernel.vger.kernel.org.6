Return-Path: <linux-kernel+bounces-348963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283B98EE82
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4081F266FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867EC16F0C1;
	Thu,  3 Oct 2024 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bx/GKXKQ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A91474C5
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956286; cv=none; b=ek4CdnAWe4d2/2SBcJybA04OOXha8P9buB84rdsUkJVVCCsaG9ThW2a4Kp/lr8n8WNx9aaP4pyhWBfUdqNq5uxE45DobCl1vmr85jOSKguDG8YKTVvUBUdPLZOAEv2joiL5PoaosiHXHvY447EJaYe38DHQ5rMe1DLgEY8B1F/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956286; c=relaxed/simple;
	bh=74f4isoWZyyE2mXKXkkGm1XHQ9OfWL5qHqvSNASgViE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6EBUWPytRZT9d2TEjtDQqUCEdKLRZz/t1pRn8Aml1nPflSs0lV5WHrocNuw97NJy/zzku2DKaJ5H+FvZHJD0uRJTD4tbMnmHr9hdj/dAuuLAAzJEvh7Q+CvM31GzGS2T6acoC+JFvGzGzP2ZGvLb9GpXZKXIrDmoB8Wrl+xiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bx/GKXKQ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49351SAq023029;
	Thu, 3 Oct 2024 04:51:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	566T+bKYSeaqQnGjxMG55wiA7qY16JdZtotsTxO0KY=; b=bx/GKXKQnMQQeu88Q
	Aj9PyZwrR+HJ53kr9VXb4vnXTfq148lGp+620pq2UXK5GAl80z1EmLpkN9hC5wlu
	psfP6LC3/N6vV2RktI0PBjHwntUAVz2fK/VpaFeM5h+7abiAV40BkVJ+evF0OZhG
	a9eDCADV3wDT8hgbDug5g8iDZouP1bwCooxfs+ifGWI5m3679Yj+LgeSf04/oea8
	Rw0r2y2xMDWdZm4fpzoP1xgrciAZni4zsRYrzc4bK8+TA9A02A3fYMAGEVpwxeix
	LtVqbikzlkmhMvwmlEGNj/8LBzuVwRJm20kR0KCdtcccwM8fy6R5G4sVihu0rcDQ
	9NZ6g==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 421amr9ppt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 04:51:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 04:51:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 04:51:16 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id 8102F5B6935;
	Thu,  3 Oct 2024 04:51:13 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v3 4/4] soc: marvell: rvu-pf: Handle function level reset (FLR) IRQs for VFs
Date: Thu, 3 Oct 2024 17:20:57 +0530
Message-ID: <20241003115057.2810857-5-agaur@marvell.com>
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
X-Proofpoint-ORIG-GUID: PMw93Tad8CvCVCOWUNt3Im0q_YRiOTqz
X-Proofpoint-GUID: PMw93Tad8CvCVCOWUNt3Im0q_YRiOTqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Added PCIe FLR interrupt handler for VFs. When FLR is triggered for VFs,
parent PF gets an interrupt. PF creates a mbox message and sends it to
RVU Admin function (AF). AF cleans up all the resources attached to that
specific VF and acks the PF that FLR is handled.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 232 +++++++++++++++++++++++-
 drivers/soc/marvell/rvu_gen_pf/gen_pf.h |   7 +
 2 files changed, 238 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
index 027d54c182a5..d99f0064aaf8 100644
--- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
@@ -626,6 +626,15 @@ static void rvu_gen_pf_queue_vf_work(struct mbox *mw, struct workqueue_struct *m
 	}
 }
 
+static void rvu_gen_pf_flr_wq_destroy(struct gen_pf_dev *pfdev)
+{
+	if (!pfdev->flr_wq)
+		return;
+	destroy_workqueue(pfdev->flr_wq);
+	pfdev->flr_wq = NULL;
+	devm_kfree(pfdev->dev, pfdev->flr_wrk);
+}
+
 static irqreturn_t rvu_gen_pf_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 {
 	struct gen_pf_dev *pfdev = (struct gen_pf_dev *)(pf_irq);
@@ -699,6 +708,211 @@ static int rvu_gen_pf_register_pfvf_mbox_intr(struct gen_pf_dev *pfdev, int numv
 	return 0;
 }
 
+static void rvu_gen_pf_flr_handler(struct work_struct *work)
+{
+	struct flr_work *flrwork = container_of(work, struct flr_work, work);
+	struct gen_pf_dev *pfdev = flrwork->pfdev;
+	struct mbox *mbox = &pfdev->mbox;
+	struct msg_req *req;
+	int vf, reg = 0;
+
+	vf = flrwork - pfdev->flr_wrk;
+
+	mutex_lock(&mbox->lock);
+	req = gen_pf_mbox_alloc_msg_vf_flr(mbox);
+	if (!req) {
+		mutex_unlock(&mbox->lock);
+		return;
+	}
+	req->hdr.pcifunc &= ~RVU_PFVF_FUNC_MASK;
+	req->hdr.pcifunc |= (vf + 1) & RVU_PFVF_FUNC_MASK;
+
+	if (!rvu_gen_pf_sync_mbox_msg(&pfdev->mbox)) {
+		if (vf >= 64) {
+			reg = 1;
+			vf = vf - 64;
+		}
+		/* clear transcation pending bit */
+		writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFTRPENDX(reg));
+		writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1SX(reg));
+	}
+
+	mutex_unlock(&mbox->lock);
+}
+
+static irqreturn_t rvu_gen_pf_me_intr_handler(int irq, void *pf_irq)
+{
+	struct gen_pf_dev *pfdev = (struct gen_pf_dev *)pf_irq;
+	int vf, reg, num_reg = 1;
+	u64 intr;
+
+	if (pfdev->total_vfs > 64)
+		num_reg = 2;
+
+	for (reg = 0; reg < num_reg; reg++) {
+		intr = readq(pfdev->reg_base + RVU_PF_VFME_INTX(reg));
+		if (!intr)
+			continue;
+		for (vf = 0; vf < 64; vf++) {
+			if (!(intr & BIT_ULL(vf)))
+				continue;
+			/* clear trpend bit */
+			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFTRPENDX(reg));
+			/* clear interrupt */
+			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFME_INTX(reg));
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rvu_gen_pf_flr_intr_handler(int irq, void *pf_irq)
+{
+	struct gen_pf_dev *pfdev = (struct gen_pf_dev *)pf_irq;
+	int reg, dev, vf, start_vf, num_reg = 1;
+	u64 intr;
+
+	if (pfdev->total_vfs > 64)
+		num_reg = 2;
+
+	for (reg = 0; reg < num_reg; reg++) {
+		intr = readq(pfdev->reg_base + RVU_PF_VFFLR_INTX(reg));
+		if (!intr)
+			continue;
+		start_vf = 64 * reg;
+		for (vf = 0; vf < 64; vf++) {
+			if (!(intr & BIT_ULL(vf)))
+				continue;
+			dev = vf + start_vf;
+			queue_work(pfdev->flr_wq, &pfdev->flr_wrk[dev].work);
+			/* Clear interrupt */
+			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFFLR_INTX(reg));
+			/* Disable the interrupt */
+			writeq(BIT_ULL(vf), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1CX(reg));
+		}
+	}
+	return IRQ_HANDLED;
+}
+
+static int rvu_gen_pf_register_flr_me_intr(struct gen_pf_dev *pfdev, int numvfs)
+{
+	char *irq_name;
+	int ret;
+
+	/* Register ME interrupt handler*/
+	irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_VFME0 * NAME_SIZE];
+	snprintf(irq_name, NAME_SIZE, "Generic RVUPF%d_ME0", rvu_get_pf(pfdev->pcifunc));
+	ret = request_irq(pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFME0),
+			  rvu_gen_pf_me_intr_handler, 0, irq_name, pfdev);
+
+	if (ret) {
+		dev_err(pfdev->dev,
+			"Generic RVUPF: IRQ registration failed for ME0\n");
+	}
+
+	/* Register FLR interrupt handler */
+	irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_VFFLR0 * NAME_SIZE];
+	snprintf(irq_name, NAME_SIZE, "Generic RVUPF%d_FLR0", rvu_get_pf(pfdev->pcifunc));
+	ret = request_irq(pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFFLR0),
+			  rvu_gen_pf_flr_intr_handler, 0, irq_name, pfdev);
+	if (ret) {
+		dev_err(pfdev->dev,
+			"Generic RVUPF: IRQ registration failed for FLR0\n");
+		return ret;
+	}
+
+	if (numvfs > 64) {
+		irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_VFME1 * NAME_SIZE];
+		snprintf(irq_name, NAME_SIZE, "Generic RVUPF%d_ME1",
+			 rvu_get_pf(pfdev->pcifunc));
+		ret = request_irq(pci_irq_vector
+				  (pfdev->pdev, RVU_PF_INT_VEC_VFME1),
+				  rvu_gen_pf_me_intr_handler, 0, irq_name, pfdev);
+		if (ret) {
+			dev_err(pfdev->dev,
+				"Generic RVUPF: IRQ registration failed for ME1\n");
+		}
+		irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_VFFLR1 * NAME_SIZE];
+		snprintf(irq_name, NAME_SIZE, "Generic RVUPF%d_FLR1",
+			 rvu_get_pf(pfdev->pcifunc));
+		ret = request_irq(pci_irq_vector
+				(pfdev->pdev, RVU_PF_INT_VEC_VFFLR1),
+				rvu_gen_pf_flr_intr_handler, 0, irq_name, pfdev);
+		if (ret) {
+			dev_err(pfdev->dev,
+				"Generic RVUPF: IRQ registration failed for FLR1\n");
+			return ret;
+		}
+	}
+
+	/* Enable ME interrupt for all VFs*/
+	writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFME_INTX(0));
+	writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFME_INT_ENA_W1SX(0));
+
+	/* Enable FLR interrupt for all VFs*/
+	writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFFLR_INTX(0));
+	writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1SX(0));
+
+	if (numvfs > 64) {
+		numvfs -= 64;
+
+		writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFME_INTX(1));
+		writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFME_INT_ENA_W1SX(1));
+
+		writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFFLR_INTX(1));
+		writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1SX(1));
+	}
+	return 0;
+}
+
+static void rvu_gen_pf_disable_flr_me_intr(struct gen_pf_dev *pfdev)
+{
+	int irq, vfs = pfdev->total_vfs;
+
+	/* Disable VFs ME interrupts */
+	writeq(INTR_MASK(vfs), pfdev->reg_base + RVU_PF_VFME_INT_ENA_W1CX(0));
+	irq = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFME0);
+	free_irq(irq, pfdev);
+
+	/* Disable VFs FLR interrupts */
+	writeq(INTR_MASK(vfs), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1CX(0));
+	irq = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFFLR0);
+	free_irq(irq, pfdev);
+
+	if (vfs <= 64)
+		return;
+
+	writeq(INTR_MASK(vfs - 64), pfdev->reg_base + RVU_PF_VFME_INT_ENA_W1CX(1));
+	irq = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFME1);
+	free_irq(irq, pfdev);
+
+	writeq(INTR_MASK(vfs - 64), pfdev->reg_base + RVU_PF_VFFLR_INT_ENA_W1CX(1));
+	irq = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFFLR1);
+	free_irq(irq, pfdev);
+}
+
+static int rvu_gen_pf_flr_init(struct gen_pf_dev *pfdev, int num_vfs)
+{
+	int vf;
+
+	pfdev->flr_wq = alloc_ordered_workqueue("otx2_pf_flr_wq", WQ_HIGHPRI);
+	if (!pfdev->flr_wq)
+		return -ENOMEM;
+
+	pfdev->flr_wrk = devm_kcalloc(pfdev->dev, num_vfs,
+				      sizeof(struct flr_work), GFP_KERNEL);
+	if (!pfdev->flr_wrk) {
+		destroy_workqueue(pfdev->flr_wq);
+		return -ENOMEM;
+	}
+
+	for (vf = 0; vf < num_vfs; vf++) {
+		pfdev->flr_wrk[vf].pfdev = pfdev;
+		INIT_WORK(&pfdev->flr_wrk[vf].work, rvu_gen_pf_flr_handler);
+	}
+
+	return 0;
+}
+
 static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
 {
 	struct gen_pf_dev *pfdev = pci_get_drvdata(pdev);
@@ -713,11 +927,25 @@ static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
 	if (ret)
 		goto free_mbox;
 
+	ret = rvu_gen_pf_flr_init(pfdev, numvfs);
+	if (ret)
+		goto free_intr;
+
+	ret = rvu_gen_pf_register_flr_me_intr(pfdev, numvfs);
+	if (ret)
+		goto free_flr;
+
 	ret = pci_enable_sriov(pdev, numvfs);
 	if (ret)
-		return ret;
+		goto free_flr_intr;
 
 	return numvfs;
+free_flr_intr:
+	rvu_gen_pf_disable_flr_me_intr(pfdev);
+free_flr:
+	rvu_gen_pf_flr_wq_destroy(pfdev);
+free_intr:
+	rvu_gen_pf_disable_pfvf_mbox_intr(pfdev, numvfs);
 free_mbox:
 	rvu_gen_pf_pfvf_mbox_destroy(pfdev);
 	return ret;
@@ -733,6 +961,8 @@ static int rvu_gen_pf_sriov_disable(struct pci_dev *pdev)
 
 	pci_disable_sriov(pdev);
 
+	rvu_gen_pf_disable_flr_me_intr(pfdev);
+	rvu_gen_pf_flr_wq_destroy(pfdev);
 	rvu_gen_pf_disable_pfvf_mbox_intr(pfdev, numvfs);
 	rvu_gen_pf_pfvf_mbox_destroy(pfdev);
 
diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
index ad651b97b661..7aacb84df07a 100644
--- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
@@ -16,6 +16,11 @@
 
 struct gen_pf_dev;
 
+struct flr_work {
+	struct work_struct work;
+	struct gen_pf_dev *pfdev;
+};
+
 struct mbox {
 	struct otx2_mbox	mbox;
 	struct work_struct	mbox_wrk;
@@ -33,6 +38,8 @@ struct gen_pf_dev {
 	struct device		*dev;
 	void __iomem		*reg_base;
 	char			*irq_name;
+	struct workqueue_struct *flr_wq;
+	struct flr_work		*flr_wrk;
 	struct work_struct	mbox_wrk;
 	struct work_struct	mbox_wrk_up;
 
-- 
2.25.1



Return-Path: <linux-kernel+bounces-407563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627E39C6F24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE0FB30CE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C772022D4;
	Wed, 13 Nov 2024 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="WZYRpiuH"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50F2010F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500414; cv=none; b=NFSCyi3Tgt1v03pGx5BzCAdCArMGKZQC6H/FZlgz29lnAB5lMN5ZqciP4hAuPFSCaz1+pK54wzQbI8wX2aFHFIIX5naNEG36kSb/3ucfaSXTUa+dcavgHZo7fmMzd/VnVVHsnh6SB9BQN08eJ+9mKkAqgtSZVBn5txP8Iu4h2EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500414; c=relaxed/simple;
	bh=74f4isoWZyyE2mXKXkkGm1XHQ9OfWL5qHqvSNASgViE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA4UC+q9mBuwdgwdnav+1g2kM61+8EPKlFZ35cr2ILZLGNJUuql1z/woYWTebyhmW9MNAGJSaIAWjcWq+zxOCcPF1MirxLn5KQ4p1CtYqyWDGPfXMEhsvPbU9XwXgLwKUVX3WlxRx0y9nC+uCPa9XOW1dUm+55fBp3macPm75dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=WZYRpiuH; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9B2DC004423;
	Wed, 13 Nov 2024 04:20:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=8
	566T+bKYSeaqQnGjxMG55wiA7qY16JdZtotsTxO0KY=; b=WZYRpiuH0euiZv7Lg
	jCIoJ0I4GG7scKbaEPcCUq9cgX4VVDAzhpfH8vysFBJxqEfCvRcr6gWcZ9Q157KR
	slgGe8mNgqZW89V1+3U+Qhx5EDrEUGiju5o2wNZO8Y4e1SeiiHEpoPJo+iHQ34MB
	j5gFTW71UDGFSnoN1m+r+KuUMhpczj5TFLZuzMXy/Amn7DNyBbcbEvlM3lIn2UbG
	j/tWXfTrdx1PDeC1f06La6mD+c57uS44kOR6ehcbYmz9egC5tIb3kayX2CmgfyaL
	wq+TZMaDAX144kZf2OfwfNsScf9IT3iRS8HW8PYGn2AmeTulu8MbSZUyZUoXi714
	sMbrw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42vs8g09hs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:20:02 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 04:20:01 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 04:20:00 -0800
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id 533CC3F706B;
	Wed, 13 Nov 2024 04:19:57 -0800 (PST)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v5 4/4] soc: marvell: rvu-pf: Handle function level reset (FLR) IRQs for VFs
Date: Wed, 13 Nov 2024 17:49:41 +0530
Message-ID: <20241113121941.3372131-5-agaur@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241113121941.3372131-1-agaur@marvell.com>
References: <20241113121941.3372131-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7lDtkwF31fR7Aud1gp63dbGSvKguVMRl
X-Proofpoint-ORIG-GUID: 7lDtkwF31fR7Aud1gp63dbGSvKguVMRl
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



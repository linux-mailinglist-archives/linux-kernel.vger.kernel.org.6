Return-Path: <linux-kernel+bounces-348964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D462A98EE83
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91347282219
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3398155757;
	Thu,  3 Oct 2024 11:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Abbul7x6"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE247155330
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727956293; cv=none; b=krz2Njxr16s7fvpB8EF8MIr/cp8/ikgNtoSxNT1UCYNssQxpWIWOoSkCvm7Iecve5/wHv81zj0OVVcB2bXmtzE3fs06P8SB5u70wUbzA/Qr3SDv9lSrYFU4yrODp69yGbOc8H0gNWZox6ep7GADIg71U2jr7GmFiWsEY63EOsRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727956293; c=relaxed/simple;
	bh=2Dm6fNIoHSqvb5aUFRzM5RtTFtOC39Z7RmOLOTyP9BU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B54jXAYCvrspwO2o/uHVd9SbGS461GBczQzWmhTrcphqO4O0CVefDO2GCt/3Z2023unNqYGaIqq3vhlGlC0OfiNDWze30ZT7JiShJiAdDY19uGa0W4BH39bIaN7umK4FHVQOP8gZRlccn32DvhjlS300bSKcEECCUxcdKX5g3gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Abbul7x6; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492Hkk6o008907;
	Thu, 3 Oct 2024 04:51:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
	GN4Ec1qv1SUqGsEIoo9XKQPSmXvQeH4AOhj6rNLml8=; b=Abbul7x6FWjff7V8N
	H4gSQymPIEbJKQUsHNATDbNmhpasw4FVdCVOy4VK9Neu8CwvEaGwuuDgrXxGH2Kz
	xw66zH9dgZxr7hBObzW0kEfAysDiUcEvcOfalmzYnds6bQEdnaP5tQ01jUOkGiys
	Pca3MYmnmMLQ497TQIijYGb7Wva4LDsxBQBipTRl3DvUPNjD3m9X2I04jzEa/GlQ
	ViMginqamcQROTGufpkew7ub5OU3GEel/PW09/+jOBiIFR84vH4YKQrhR/HgHG5j
	MnSJ8UKTQApoTVrayf5ByCtlt1U/uRpbXAPGsIorKVk/4+QOy12oapMEOUKyKRM9
	D4wqw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 421avd9mef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 04:51:14 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Oct 2024 04:51:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Oct 2024 04:51:13 -0700
Received: from localhost.localdomain (unknown [10.29.37.241])
	by maili.marvell.com (Postfix) with ESMTP id 2BB1F5B6935;
	Thu,  3 Oct 2024 04:51:09 -0700 (PDT)
From: Anshumali Gaur <agaur@marvell.com>
To: <quic_bjorande@quicinc.com>, <christophe.leroy@csgroup.eu>,
        <angelogioacchino.delregno@collabora.com>, <herve.codina@bootlin.com>,
        <dmitry.baryshkov@linaro.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>
CC: Anshumali Gaur <agaur@marvell.com>
Subject: [PATCH v3 3/4] soc: marvell: rvu-pf: Add mailbox communication btw RVU VFs and PF.
Date: Thu, 3 Oct 2024 17:20:56 +0530
Message-ID: <20241003115057.2810857-4-agaur@marvell.com>
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
X-Proofpoint-GUID: kkxO3G2wF5b4z9G_MoWMnk6r3Tr_sDIC
X-Proofpoint-ORIG-GUID: kkxO3G2wF5b4z9G_MoWMnk6r3Tr_sDIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

RVU PF shares a dedicated memory region with each of it's VFs.
This memory region is used to establish communication between them.
Since Admin function (AF) handles resource management, PF doesn't
process the messages sent by VFs. It acts as an intermediary device
process the messages sent by VFs. It acts as an intermediary device.
Hardware doesn't support direct communication between AF and VFs.

Signed-off-by: Anshumali Gaur <agaur@marvell.com>
---
 drivers/soc/marvell/rvu_gen_pf/gen_pf.c | 442 ++++++++++++++++++++++++
 drivers/soc/marvell/rvu_gen_pf/gen_pf.h |   2 +
 2 files changed, 444 insertions(+)

diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
index a03fc3f16c69..027d54c182a5 100644
--- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.c
@@ -31,6 +31,11 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Marvell Octeon RVU Generic PF Driver");
 MODULE_DEVICE_TABLE(pci, rvu_gen_pf_id_table);
 
+inline int rvu_get_pf(u16 pcifunc)
+{
+	return (pcifunc >> RVU_PFVF_PF_SHIFT) & RVU_PFVF_PF_MASK;
+}
+
 static int rvu_gen_pf_check_pf_usable(struct gen_pf_dev *pfdev)
 {
 	u64 rev;
@@ -50,6 +55,120 @@ static int rvu_gen_pf_check_pf_usable(struct gen_pf_dev *pfdev)
 	return 0;
 }
 
+static void rvu_gen_pf_forward_msg_pfvf(struct otx2_mbox_dev *mdev,
+					struct otx2_mbox *pfvf_mbox, void *bbuf_base,
+					int devid)
+{
+	struct otx2_mbox_dev *src_mdev = mdev;
+	int offset;
+
+	/* Msgs are already copied, trigger VF's mbox irq */
+	smp_wmb();
+
+	otx2_mbox_wait_for_zero(pfvf_mbox, devid);
+	offset = pfvf_mbox->trigger | (devid << pfvf_mbox->tr_shift);
+	writeq(MBOX_DOWN_MSG, (void __iomem *)pfvf_mbox->reg_base + offset);
+
+	/* Restore VF's mbox bounce buffer region address */
+	src_mdev->mbase = bbuf_base;
+}
+
+static int rvu_gen_pf_forward_vf_mbox_msgs(struct gen_pf_dev *pfdev,
+					   struct otx2_mbox *src_mbox,
+					   int dir, int vf, int num_msgs)
+{
+	struct otx2_mbox_dev *src_mdev, *dst_mdev;
+	struct mbox_hdr *mbox_hdr;
+	struct mbox_hdr *req_hdr;
+	struct mbox *dst_mbox;
+	int dst_size, err;
+
+	if (dir == MBOX_DIR_PFAF) {
+		/*
+		 * Set VF's mailbox memory as PF's bounce buffer memory, so
+		 * that explicit copying of VF's msgs to PF=>AF mbox region
+		 * and AF=>PF responses to VF's mbox region can be avoided.
+		 */
+		src_mdev = &src_mbox->dev[vf];
+		mbox_hdr = src_mbox->hwbase +
+				src_mbox->rx_start + (vf * MBOX_SIZE);
+
+		dst_mbox = &pfdev->mbox;
+		dst_size = dst_mbox->mbox.tx_size -
+				ALIGN(sizeof(*mbox_hdr), MBOX_MSG_ALIGN);
+		/* Check if msgs fit into destination area and has valid size */
+		if (mbox_hdr->msg_size > dst_size || !mbox_hdr->msg_size)
+			return -EINVAL;
+
+		dst_mdev = &dst_mbox->mbox.dev[0];
+
+		mutex_lock(&pfdev->mbox.lock);
+		dst_mdev->mbase = src_mdev->mbase;
+		dst_mdev->msg_size = mbox_hdr->msg_size;
+		dst_mdev->num_msgs = num_msgs;
+		err = rvu_gen_pf_sync_mbox_msg(dst_mbox);
+		/*
+		 * Error code -EIO indicate there is a communication failure
+		 * to the AF. Rest of the error codes indicate that AF processed
+		 * VF messages and set the error codes in response messages
+		 * (if any) so simply forward responses to VF.
+		 */
+		if (err == -EIO) {
+			dev_warn(pfdev->dev,
+				 "AF not responding to VF%d messages\n", vf);
+			/* restore PF mbase and exit */
+			dst_mdev->mbase = pfdev->mbox.bbuf_base;
+			mutex_unlock(&pfdev->mbox.lock);
+			return err;
+		}
+		/*
+		 * At this point, all the VF messages sent to AF are acked
+		 * with proper responses and responses are copied to VF
+		 * mailbox hence raise interrupt to VF.
+		 */
+		req_hdr = (struct mbox_hdr *)(dst_mdev->mbase +
+					      dst_mbox->mbox.rx_start);
+		req_hdr->num_msgs = num_msgs;
+
+		rvu_gen_pf_forward_msg_pfvf(dst_mdev, &pfdev->mbox_pfvf[0].mbox,
+					    pfdev->mbox.bbuf_base, vf);
+		mutex_unlock(&pfdev->mbox.lock);
+	} else if (dir == MBOX_DIR_PFVF_UP) {
+		src_mdev = &src_mbox->dev[0];
+		mbox_hdr = src_mbox->hwbase + src_mbox->rx_start;
+		req_hdr = (struct mbox_hdr *)(src_mdev->mbase +
+					      src_mbox->rx_start);
+		req_hdr->num_msgs = num_msgs;
+
+		dst_mbox = &pfdev->mbox_pfvf[0];
+		dst_size = dst_mbox->mbox_up.tx_size -
+				ALIGN(sizeof(*mbox_hdr), MBOX_MSG_ALIGN);
+		/* Check if msgs fit into destination area */
+		if (mbox_hdr->msg_size > dst_size)
+			return -EINVAL;
+		dst_mdev = &dst_mbox->mbox_up.dev[vf];
+		dst_mdev->mbase = src_mdev->mbase;
+		dst_mdev->msg_size = mbox_hdr->msg_size;
+		dst_mdev->num_msgs = mbox_hdr->num_msgs;
+		err = rvu_gen_pf_sync_mbox_up_msg(dst_mbox, vf);
+		if (err) {
+			dev_warn(pfdev->dev,
+				 "VF%d is not responding to mailbox\n", vf);
+			return err;
+		}
+	} else if (dir == MBOX_DIR_VFPF_UP) {
+		req_hdr = (struct mbox_hdr *)(src_mbox->dev[0].mbase +
+					      src_mbox->rx_start);
+		req_hdr->num_msgs = num_msgs;
+		rvu_gen_pf_forward_msg_pfvf(&pfdev->mbox_pfvf->mbox_up.dev[vf],
+					    &pfdev->mbox.mbox_up,
+					    pfdev->mbox_pfvf[vf].bbuf_base,
+					    0);
+	}
+
+	return 0;
+}
+
 static irqreturn_t rvu_gen_pf_pfaf_mbox_intr_handler(int irq, void *pf_irq)
 {
 	struct gen_pf_dev *pfdev = (struct gen_pf_dev *)pf_irq;
@@ -192,6 +311,39 @@ static void rvu_gen_pf_process_pfaf_mbox_msg(struct gen_pf_dev *pfdev,
 	}
 }
 
+static void rvu_gen_pf_pfaf_mbox_up_handler(struct work_struct *work)
+{
+	struct mbox *af_mbox = container_of(work, struct mbox, mbox_up_wrk);
+	struct otx2_mbox *mbox = &af_mbox->mbox_up;
+	struct otx2_mbox_dev *mdev = &mbox->dev[0];
+	struct gen_pf_dev *pfdev = af_mbox->pfvf;
+	int offset, id, devid = 0;
+	struct mbox_hdr *rsp_hdr;
+	struct mbox_msghdr *msg;
+	u16 num_msgs;
+
+	rsp_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+	num_msgs = rsp_hdr->num_msgs;
+
+	offset = mbox->rx_start + ALIGN(sizeof(*rsp_hdr), MBOX_MSG_ALIGN);
+
+	for (id = 0; id < num_msgs; id++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + offset);
+
+		devid = msg->pcifunc & RVU_PFVF_FUNC_MASK;
+		offset = mbox->rx_start + msg->next_msgoff;
+	}
+	/* Forward to VF iff VFs are really present */
+	if (devid && pci_num_vf(pfdev->pdev)) {
+		rvu_gen_pf_forward_vf_mbox_msgs(pfdev, &pfdev->mbox.mbox_up,
+						MBOX_DIR_PFVF_UP, devid - 1,
+						num_msgs);
+		return;
+	}
+
+	otx2_mbox_msg_send(mbox, 0);
+}
+
 static void rvu_gen_pf_pfaf_mbox_handler(struct work_struct *work)
 {
 	struct otx2_mbox_dev *mdev;
@@ -266,6 +418,7 @@ static int rvu_gen_pf_pfaf_mbox_init(struct gen_pf_dev *pfdev)
 		goto exit;
 
 	INIT_WORK(&mbox->mbox_wrk, rvu_gen_pf_pfaf_mbox_handler);
+	INIT_WORK(&mbox->mbox_up_wrk, rvu_gen_pf_pfaf_mbox_up_handler);
 	mutex_init(&mbox->lock);
 
 	return 0;
@@ -274,19 +427,305 @@ static int rvu_gen_pf_pfaf_mbox_init(struct gen_pf_dev *pfdev)
 	return err;
 }
 
+static void rvu_gen_pf_pfvf_mbox_handler(struct work_struct *work)
+{
+	struct mbox_msghdr *msg = NULL;
+	int offset, vf_idx, id, err;
+	struct otx2_mbox_dev *mdev;
+	struct gen_pf_dev *pfdev;
+	struct mbox_hdr *req_hdr;
+	struct otx2_mbox *mbox;
+	struct mbox *vf_mbox;
+
+	vf_mbox = container_of(work, struct mbox, mbox_wrk);
+	pfdev = vf_mbox->pfvf;
+	vf_idx = vf_mbox - pfdev->mbox_pfvf;
+
+	mbox = &pfdev->mbox_pfvf[0].mbox;
+	mdev = &mbox->dev[vf_idx];
+	req_hdr = (struct mbox_hdr *)(mdev->mbase + mbox->rx_start);
+
+	offset = ALIGN(sizeof(*req_hdr), MBOX_MSG_ALIGN);
+
+	for (id = 0; id < vf_mbox->num_msgs; id++) {
+		msg = (struct mbox_msghdr *)(mdev->mbase + mbox->rx_start +
+					     offset);
+
+		if (msg->sig != OTX2_MBOX_REQ_SIG)
+			goto inval_msg;
+
+		/* Set VF's number in each of the msg */
+		msg->pcifunc &= ~RVU_PFVF_FUNC_MASK;
+		msg->pcifunc |= (vf_idx + 1) & RVU_PFVF_FUNC_MASK;
+		offset = msg->next_msgoff;
+	}
+	err = rvu_gen_pf_forward_vf_mbox_msgs(pfdev, mbox, MBOX_DIR_PFAF, vf_idx,
+					      vf_mbox->num_msgs);
+	if (err)
+		goto inval_msg;
+	return;
+
+inval_msg:
+	if (!msg)
+		return;
+
+	otx2_reply_invalid_msg(mbox, vf_idx, 0, msg->id);
+	otx2_mbox_msg_send(mbox, vf_idx);
+}
+
+static int rvu_gen_pf_pfvf_mbox_init(struct gen_pf_dev *pfdev, int numvfs)
+{
+	void __iomem *hwbase;
+	struct mbox *mbox;
+	int err, vf;
+	u64 base;
+
+	if (!numvfs)
+		return -EINVAL;
+
+	pfdev->mbox_pfvf = devm_kcalloc(&pfdev->pdev->dev, numvfs,
+					sizeof(struct mbox), GFP_KERNEL);
+
+	if (!pfdev->mbox_pfvf)
+		return -ENOMEM;
+
+	pfdev->mbox_pfvf_wq = alloc_workqueue("otx2_pfvf_mailbox",
+					      WQ_UNBOUND | WQ_HIGHPRI |
+					      WQ_MEM_RECLAIM, 0);
+	if (!pfdev->mbox_pfvf_wq)
+		return -ENOMEM;
+
+	/*
+	 * PF <-> VF mailbox region follows after
+	 * PF <-> AF mailbox region.
+	 */
+	base = pci_resource_start(pfdev->pdev, PCI_MBOX_BAR_NUM) + MBOX_SIZE;
+
+	hwbase = ioremap_wc(base, MBOX_SIZE * pfdev->total_vfs);
+	if (!hwbase) {
+		err = -ENOMEM;
+		goto free_wq;
+	}
+
+	mbox = &pfdev->mbox_pfvf[0];
+	err = otx2_mbox_init(&mbox->mbox, hwbase, pfdev->pdev, pfdev->reg_base,
+			     MBOX_DIR_PFVF, numvfs);
+	if (err)
+		goto free_iomem;
+
+	err = otx2_mbox_init(&mbox->mbox_up, hwbase, pfdev->pdev, pfdev->reg_base,
+			     MBOX_DIR_PFVF_UP, numvfs);
+	if (err)
+		goto free_iomem;
+
+	for (vf = 0; vf < numvfs; vf++) {
+		mbox->pfvf = pfdev;
+		INIT_WORK(&mbox->mbox_wrk, rvu_gen_pf_pfvf_mbox_handler);
+		mbox++;
+	}
+
+	return 0;
+
+free_iomem:
+	if (hwbase)
+		iounmap(hwbase);
+free_wq:
+	destroy_workqueue(pfdev->mbox_pfvf_wq);
+	return err;
+}
+
+static void rvu_gen_pf_pfvf_mbox_destroy(struct gen_pf_dev *pfdev)
+{
+	struct mbox *mbox = &pfdev->mbox_pfvf[0];
+
+	if (!mbox)
+		return;
+
+	if (pfdev->mbox_pfvf_wq) {
+		destroy_workqueue(pfdev->mbox_pfvf_wq);
+		pfdev->mbox_pfvf_wq = NULL;
+	}
+
+	if (mbox->mbox.hwbase)
+		iounmap((void __iomem *)mbox->mbox.hwbase);
+
+	otx2_mbox_destroy(&mbox->mbox);
+}
+
+static void rvu_gen_pf_enable_pfvf_mbox_intr(struct gen_pf_dev *pfdev, int numvfs)
+{
+	/* Clear PF <=> VF mailbox IRQ */
+	writeq(~0ull, pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(0));
+	writeq(~0ull, pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(1));
+
+	/* Enable PF <=> VF mailbox IRQ */
+	writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFPF_MBOX_INT_ENA_W1SX(0));
+	if (numvfs > 64) {
+		numvfs -= 64;
+		writeq(INTR_MASK(numvfs), pfdev->reg_base + RVU_PF_VFPF_MBOX_INT_ENA_W1SX(1));
+	}
+}
+
+static void rvu_gen_pf_disable_pfvf_mbox_intr(struct gen_pf_dev *pfdev, int numvfs)
+{
+	int vector;
+
+	/* Disable PF <=> VF mailbox IRQ */
+	writeq(~0ull, pfdev->reg_base + RVU_PF_VFPF_MBOX_INT_ENA_W1CX(0));
+	writeq(~0ull, pfdev->reg_base + RVU_PF_VFPF_MBOX_INT_ENA_W1CX(1));
+
+	writeq(~0ull, pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(0));
+	vector = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFPF_MBOX0);
+	free_irq(vector, pfdev);
+
+	if (numvfs > 64) {
+		writeq(~0ull, pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(1));
+		vector = pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFPF_MBOX1);
+		free_irq(vector, pfdev);
+	}
+}
+
+static void rvu_gen_pf_queue_vf_work(struct mbox *mw, struct workqueue_struct *mbox_wq,
+				     int first, int mdevs, u64 intr)
+{
+	struct otx2_mbox_dev *mdev;
+	struct otx2_mbox *mbox;
+	struct mbox_hdr *hdr;
+	int i;
+
+	for (i = first; i < mdevs; i++) {
+		/* start from 0 */
+		if (!(intr & BIT_ULL(i - first)))
+			continue;
+
+		mbox = &mw->mbox;
+		mdev = &mbox->dev[i];
+		hdr = mdev->mbase + mbox->rx_start;
+		/*
+		 * The hdr->num_msgs is set to zero immediately in the interrupt
+		 * handler to ensure that it holds a correct value next time
+		 * when the interrupt handler is called. pf->mw[i].num_msgs
+		 * holds the data for use in otx2_pfvf_mbox_handler and
+		 * pf->mw[i].up_num_msgs holds the data for use in
+		 * otx2_pfvf_mbox_up_handler.
+		 */
+		if (hdr->num_msgs) {
+			mw[i].num_msgs = hdr->num_msgs;
+			hdr->num_msgs = 0;
+			queue_work(mbox_wq, &mw[i].mbox_wrk);
+		}
+
+		mbox = &mw->mbox_up;
+		mdev = &mbox->dev[i];
+		hdr = mdev->mbase + mbox->rx_start;
+		if (hdr->num_msgs) {
+			mw[i].up_num_msgs = hdr->num_msgs;
+			hdr->num_msgs = 0;
+			queue_work(mbox_wq, &mw[i].mbox_up_wrk);
+		}
+	}
+}
+
+static irqreturn_t rvu_gen_pf_pfvf_mbox_intr_handler(int irq, void *pf_irq)
+{
+	struct gen_pf_dev *pfdev = (struct gen_pf_dev *)(pf_irq);
+	int vfs = pfdev->total_vfs;
+	struct mbox *mbox;
+	u64 intr;
+
+	mbox = pfdev->mbox_pfvf;
+	/* Handle VF interrupts */
+	if (vfs > 64) {
+		intr = readq(pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(1));
+		writeq(intr, pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(1));
+		rvu_gen_pf_queue_vf_work(mbox, pfdev->mbox_pfvf_wq, 64, vfs, intr);
+		if (intr)
+			trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+		vfs = 64;
+	}
+
+	intr = readq(pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(0));
+	writeq(intr, pfdev->reg_base + RVU_PF_VFPF_MBOX_INTX(0));
+
+	rvu_gen_pf_queue_vf_work(mbox, pfdev->mbox_pfvf_wq, 0, vfs, intr);
+
+	if (intr)
+		trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+
+	return IRQ_HANDLED;
+}
+
+static int rvu_gen_pf_register_pfvf_mbox_intr(struct gen_pf_dev *pfdev, int numvfs)
+{
+	char *irq_name;
+	int err;
+
+	/* Register MBOX0 interrupt handler */
+	irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_VFPF_MBOX0 * NAME_SIZE];
+	if (pfdev->pcifunc)
+		snprintf(irq_name, NAME_SIZE,
+			 "Generic RVUPF%d_VF Mbox0", rvu_get_pf(pfdev->pcifunc));
+	else
+		snprintf(irq_name, NAME_SIZE, "Generic RVUPF_VF Mbox0");
+	err = request_irq(pci_irq_vector(pfdev->pdev, RVU_PF_INT_VEC_VFPF_MBOX0),
+			  rvu_gen_pf_pfvf_mbox_intr_handler, 0, irq_name, pfdev);
+	if (err) {
+		dev_err(pfdev->dev,
+			"RVUPF: IRQ registration failed for PFVF mbox0 irq\n");
+		return err;
+	}
+
+	if (numvfs > 64) {
+		/* Register MBOX1 interrupt handler */
+		irq_name = &pfdev->irq_name[RVU_PF_INT_VEC_VFPF_MBOX1 * NAME_SIZE];
+		if (pfdev->pcifunc)
+			snprintf(irq_name, NAME_SIZE,
+				 "Generic RVUPF%d_VF Mbox1", rvu_get_pf(pfdev->pcifunc));
+		else
+			snprintf(irq_name, NAME_SIZE, "Generic RVUPF_VF Mbox1");
+		err = request_irq(pci_irq_vector(pfdev->pdev,
+						 RVU_PF_INT_VEC_VFPF_MBOX1),
+						 rvu_gen_pf_pfvf_mbox_intr_handler,
+						 0, irq_name, pfdev);
+		if (err) {
+			dev_err(pfdev->dev,
+				"RVUPF: IRQ registration failed for PFVF mbox1 irq\n");
+			return err;
+		}
+	}
+
+	rvu_gen_pf_enable_pfvf_mbox_intr(pfdev, numvfs);
+
+	return 0;
+}
+
 static int rvu_gen_pf_sriov_enable(struct pci_dev *pdev, int numvfs)
 {
+	struct gen_pf_dev *pfdev = pci_get_drvdata(pdev);
 	int ret;
 
+	/* Init PF <=> VF mailbox stuff */
+	ret = rvu_gen_pf_pfvf_mbox_init(pfdev, numvfs);
+	if (ret)
+		return ret;
+
+	ret = rvu_gen_pf_register_pfvf_mbox_intr(pfdev, numvfs);
+	if (ret)
+		goto free_mbox;
+
 	ret = pci_enable_sriov(pdev, numvfs);
 	if (ret)
 		return ret;
 
 	return numvfs;
+free_mbox:
+	rvu_gen_pf_pfvf_mbox_destroy(pfdev);
+	return ret;
 }
 
 static int rvu_gen_pf_sriov_disable(struct pci_dev *pdev)
 {
+	struct gen_pf_dev *pfdev = pci_get_drvdata(pdev);
 	int numvfs = pci_num_vf(pdev);
 
 	if (!numvfs)
@@ -294,6 +733,9 @@ static int rvu_gen_pf_sriov_disable(struct pci_dev *pdev)
 
 	pci_disable_sriov(pdev);
 
+	rvu_gen_pf_disable_pfvf_mbox_intr(pfdev, numvfs);
+	rvu_gen_pf_pfvf_mbox_destroy(pfdev);
+
 	return 0;
 }
 
diff --git a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
index 2019bea10ad0..ad651b97b661 100644
--- a/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
+++ b/drivers/soc/marvell/rvu_gen_pf/gen_pf.h
@@ -38,7 +38,9 @@ struct gen_pf_dev {
 
 	/* Mbox */
 	struct mbox		mbox;
+	struct mbox		*mbox_pfvf;
 	struct workqueue_struct *mbox_wq;
+	struct workqueue_struct *mbox_pfvf_wq;
 
 	int			pf;
 	u16			pcifunc; /* RVU PF_FUNC */
-- 
2.25.1



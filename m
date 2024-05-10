Return-Path: <linux-kernel+bounces-175873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6AD8C2682
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 16:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32141F230BF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D705416F8FF;
	Fri, 10 May 2024 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HXVHKJp5"
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755F14F9D1
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 14:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350525; cv=none; b=SwoBh/Ue3+89RFrLpc3G9YfSHko6QetdLNscNNUTTDxINbbN9UCn+8o3fxgnUvdOJ00IiKvdn7OdZwTl21wPEvwy/C+sItO1KnTq51eiu8cg0R9LlHwpdexzrtRc5i9HE3IHSRMoeMCrNFYZEVvhIbHz8yQ8Qvdty1f4aPP+tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350525; c=relaxed/simple;
	bh=t/XwIi07RRoVyHhLIho6Sjz4jssQpzDOkDVN7odc2BI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPxZhVxDRQe5SvQAzpkTHKhoqarPAOzp4eoxQCb0PtWCek/DYhD3VC8rPOR2GAQRz7af+N7daAdDrOD23Uc9TlEVgCQa0h0VV0/nMrPYZixTKOoxHtPds+It6BOd3bMgAeRSWVc/fPIJ+oteQv60WtfJbdytk2qsbqIxspARBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HXVHKJp5; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A0Pv83003998
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:15:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=Nm6THcMHLzSQGtzts3MDymgxIqVwbrbSsGjVJ9k2GdE=;
 b=HXVHKJp5AsJ00vAZSpg0krVekTXebYAxzlFwi2GBYstG2q+JkLmwFI9m3mWtDkVgBPm+
 52+IHUef+qRvZZhKowdkeZzsM+bgEmgdTZ/EG8sKk8PKetPhmBc7xOel1nVHyGmyEKhS
 8cSE5DLO/67wAw2MyuKOsDwgcNJePGAYU4sUN6iySU/ErrEIPp5JAKu4D5KwzDl2YYbT
 xlHyeA5CCrMp/xWu4pHg5ZI8vOc4RlLkomgBEI5MacUytpqcJoAPedfH0lN02iMUR7lf
 bla4e0VbA//L5ex2XWHmf+lZ6rx48r830ddEcfnih8ijwi9mxohrK/sAdoDcRO2LYqPf LQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3y16pwbkpw-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 07:15:22 -0700
Received: from twshared8926.02.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 07:15:10 -0700
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 8393F2633F53; Fri, 10 May 2024 07:15:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <hch@lst.de>, <tglx@linutronix.de>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Date: Fri, 10 May 2024 07:14:59 -0700
Message-ID: <20240510141459.3207725-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510141459.3207725-1-kbusch@meta.com>
References: <20240510141459.3207725-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wiwAO0PBfrKnV_Q1vC1wxifMsHzcW2dw
X-Proofpoint-ORIG-GUID: wiwAO0PBfrKnV_Q1vC1wxifMsHzcW2dw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_10,2024-05-10_02,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Some people _really_ want to control their interrupt affinity.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685d..4c2799c3f45f5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -63,6 +63,11 @@ MODULE_PARM_DESC(sgl_threshold,
 		"Use SGLs when average request segment size is larger or equal to "
 		"this size. Use 0 to disable SGLs.");
=20
+static bool managed_irqs =3D true;
+module_param(managed_irqs, bool, 0444);
+MODULE_PARM_DESC(managed_irqs,
+		 "set to false for user controlled irq affinity");
+
 #define NVME_PCI_MIN_QUEUE_SIZE 2
 #define NVME_PCI_MAX_QUEUE_SIZE 4095
 static int io_queue_depth_set(const char *val, const struct kernel_param=
 *kp);
@@ -456,7 +461,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set=
 *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset =3D qoff;
-		if (i !=3D HCTX_TYPE_POLL && offset)
+		if (managed_irqs && i !=3D HCTX_TYPE_POLL && offset)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
@@ -2180,6 +2185,9 @@ static void nvme_calc_irq_sets(struct irq_affinity =
*affd, unsigned int nrirqs)
 	struct nvme_dev *dev =3D affd->priv;
 	unsigned int nr_read_queues, nr_write_queues =3D dev->nr_write_queues;
=20
+	if (!nrirqs)
+		nrirqs =3D affd->post_vectors;
+
 	/*
 	 * If there is no interrupt available for queues, ensure that
 	 * the default queue is set to 1. The affinity set size is
@@ -2226,6 +2234,9 @@ static int nvme_setup_irqs(struct nvme_dev *dev, un=
signed int nr_io_queues)
 	poll_queues =3D min(dev->nr_poll_queues, nr_io_queues - 1);
 	dev->io_queues[HCTX_TYPE_POLL] =3D poll_queues;
=20
+	if (!managed_irqs)
+		affd.post_vectors =3D nr_io_queues - poll_queues;
+
 	/*
 	 * Initialize for the single interrupt case, will be updated in
 	 * nvme_calc_irq_sets().
--=20
2.43.0



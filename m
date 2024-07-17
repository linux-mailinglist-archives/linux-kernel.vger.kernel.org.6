Return-Path: <linux-kernel+bounces-254672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E2893361F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DBEB22C3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 04:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4DAB64C;
	Wed, 17 Jul 2024 04:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="XkA18HCL"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829519461
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721191964; cv=none; b=YIrRBG/ze23p8BKg1/xZVmo/DT0Ew+p6iGZauCygITCDOfYmBpAGslXN4UuvDhXZUPRpyqkYKfzwb8GXVcSSffVg4vduaWiI477mhUvBM+FUSlsRW9zbueDkVbU6g3eic6Gp1DDVBSSKMAq3cO6jNJcobF+9crNzaN9BSfpeq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721191964; c=relaxed/simple;
	bh=wHMdZBTZL1UR/RuTu4qv/TWqtn5W9MWBf1zVXLs576Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKIPnRA7JngoVZPsd3qvl+uCnqdH2RG65ShNIXQDq2tuvV2h6Ts3WWd+bpj15wUXhvlJCNqYirqV183xNKl64RmEzAteL+x/13Rm6bENJ0k0Ndga0p+BCo9pOXfJ4gXaagRYPc7GB8m5TBh2rBsV0MAAcvR/0B+YpAYK1DfB3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=XkA18HCL; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46H0WYCT031823;
	Tue, 16 Jul 2024 21:52:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=mzRmAXWYld+OjyIBw6KUrr3
	fMPJbIRCgLQqyelNDyRo=; b=XkA18HCLhiL3d1CnB/xfj4tchXjHmEcDb5io8TY
	h/K8J1BkNcNjtRqUvfOw5xPZP8Zym/haI9KDIhPmkSKU4TdlJigou+k6gCZ5hpSb
	VeV2cYDsZslJTc04WjEH2kMXUMv5nEU0pFH6MVLrunQb8hxeTzh6DdYXsgBvjd3E
	r+3LyqJp9sM6fbCEDUtuQI1YAQlIYPbSDZVpv6VRO0LbbwA67KAP0y+3/VNLqpfW
	lirpf+Cp0/B1VvDpfXT51QTzIUgpllAdZxHg6Na2shxD6Utf5+qvKQ5/i/oYfVvT
	9uaJTb1AwUG1z1WANEjeS8iKa8bbPLdLuRKDNFkiCJJkBsQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40e3g8rmvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 21:52:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 16 Jul 2024 21:52:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 16 Jul 2024 21:52:34 -0700
Received: from localhost.localdomain (unknown [10.28.36.156])
	by maili.marvell.com (Postfix) with ESMTP id 888ED3F704F;
	Tue, 16 Jul 2024 21:52:32 -0700 (PDT)
From: Vamsi Attunuru <vattunuru@marvell.com>
To: <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <nathan@kernel.org>,
        <quic_jjohnson@quicinc.com>, <vattunuru@marvell.com>
Subject: [PATCH] misc: mrvl-cn10k-dpi: resolve compilation issues on 32-bit ARM
Date: Tue, 16 Jul 2024 21:52:25 -0700
Message-ID: <20240717045225.138799-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zmpADTWFk6bKH1iledMCafMFGiycT1Rj
X-Proofpoint-GUID: zmpADTWFk6bKH1iledMCafMFGiycT1Rj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_01,2024-07-16_02,2024-05-17_01

Upon adding CONFIG_ARCH_THUNDER & CONFIG_COMPILE_TEST dependency,
compilation errors arise on 32-bit ARM with writeq() & readq() calls
which are used for accessing 64-bit values.

Patch utilizes CONFIG_64BIT checks to define appropriate calls
for accessing 64-bit values.

Fixes: a5e43e2d202d ("misc: Kconfig: add a new dependency for MARVELL_CN10K_DPI")
Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/misc/mrvl_cn10k_dpi.c | 47 ++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/mrvl_cn10k_dpi.c b/drivers/misc/mrvl_cn10k_dpi.c
index 7d5433121ff6..8d24dd6b421b 100644
--- a/drivers/misc/mrvl_cn10k_dpi.c
+++ b/drivers/misc/mrvl_cn10k_dpi.c
@@ -13,6 +13,9 @@
 #include <linux/pci.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#ifndef CONFIG_64BIT
+#include <linux/io-64-nonatomic-lo-hi.h>
+#endif
 
 #include <uapi/misc/mrvl_cn10k_dpi.h>
 
@@ -185,6 +188,8 @@ struct dpi_mbox_message {
 	uint64_t word_h;
 };
 
+#ifdef CONFIG_64BIT
+
 static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
 {
 	writeq(val, dpi->reg_base + offset);
@@ -195,6 +200,40 @@ static inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
 	return readq(dpi->reg_base + offset);
 }
 
+static inline void dpi_writeq(u64 val, void __iomem *addr)
+{
+	writeq(val, addr);
+}
+
+static inline u64 dpi_readq(const void __iomem *addr)
+{
+	return readq(addr);
+}
+
+#else
+
+static inline void dpi_reg_write(struct dpipf *dpi, u64 offset, u64 val)
+{
+	lo_hi_writeq(val, dpi->reg_base + offset);
+}
+
+static inline u64 dpi_reg_read(struct dpipf *dpi, u64 offset)
+{
+	return lo_hi_readq(dpi->reg_base + offset);
+}
+
+static inline void dpi_writeq(u64 val, void __iomem *addr)
+{
+	lo_hi_writeq(val, addr);
+}
+
+static inline u64 dpi_readq(const void __iomem *addr)
+{
+	return lo_hi_readq(addr);
+}
+
+#endif
+
 static void dpi_wqe_cs_offset(struct dpipf *dpi, u8 offset)
 {
 	u64 reg;
@@ -324,7 +363,7 @@ static void dpi_pfvf_mbox_work(struct work_struct *work)
 	memset(&msg, 0, sizeof(msg));
 
 	mutex_lock(&mbox->lock);
-	msg.word_l = readq(mbox->vf_pf_data_reg);
+	msg.word_l = dpi_readq(mbox->vf_pf_data_reg);
 	if (msg.word_l == (u64)-1)
 		goto exit;
 
@@ -333,13 +372,13 @@ static void dpi_pfvf_mbox_work(struct work_struct *work)
 		goto exit;
 
 	dpivf = &dpi->vf[vfid];
-	msg.word_h = readq(mbox->pf_vf_data_reg);
+	msg.word_h = dpi_readq(mbox->pf_vf_data_reg);
 
 	ret = queue_config(dpi, dpivf, &msg);
 	if (ret < 0)
-		writeq(DPI_MBOX_TYPE_RSP_NACK, mbox->pf_vf_data_reg);
+		dpi_writeq(DPI_MBOX_TYPE_RSP_NACK, mbox->pf_vf_data_reg);
 	else
-		writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
+		dpi_writeq(DPI_MBOX_TYPE_RSP_ACK, mbox->pf_vf_data_reg);
 exit:
 	mutex_unlock(&mbox->lock);
 }
-- 
2.25.1



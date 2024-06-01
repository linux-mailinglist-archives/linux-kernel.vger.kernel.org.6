Return-Path: <linux-kernel+bounces-197659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE58D6D94
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 04:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717CD1C2139F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 02:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F83101E2;
	Sat,  1 Jun 2024 02:52:02 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E350B67F;
	Sat,  1 Jun 2024 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717210322; cv=none; b=pOKkqj/n/o3dpe3p/O8ZLPXG50ArPyHLvQ9g9AO2nGNoXlxUtX2twkIyKIzgsgCoMMEHFe/ivcqoQ4VSvadXoFVS6CoscZ+xuKwRCobd6DkO/G3luYsFtxmwpmQ/JiYQl/pdc0lj0KhEToMUPShYixklYAOrMpACGHuC+Pio+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717210322; c=relaxed/simple;
	bh=6B63JBkd1Kbgp5QxzejuH/3W+a00kkhWko8c7claGxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqdD1eD9uF0ihEJf1smUxH3BpVE8xxkwVgZyqp3R1NTDqy4mTKAuIM54ix8xCtF1koKj0ByXEGLA/tFQZspS03uTo6Yy+6MeAFsYtJEEOTyDGPGgDssnoFjxQujbFT+bTZkcKzdNk7/HGfc4cYlK8uU0hsGsb6YWGUbwsDuVvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Vrktn3KSwz1S8qj;
	Sat,  1 Jun 2024 10:48:01 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E96F18006C;
	Sat,  1 Jun 2024 10:51:52 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 1 Jun 2024 10:51:51 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<shenyang39@huawei.com>, <liulongfang@huawei.com>, <qianweili@huawei.com>
Subject: [PATCH V3 2/2] crypto: hisilicon/zip - optimize the address offset of the reg query function
Date: Sat, 1 Jun 2024 10:51:50 +0800
Message-ID: <20240601025150.1660826-3-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240601025150.1660826-1-huangchenghai2@huawei.com>
References: <20240601025150.1660826-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500025.china.huawei.com (7.221.188.170)

Currently, the reg is queried based on the fixed address offset
array. When the number of accelerator cores changes, the system
can not flexibly respond to the change.

Therefore, the reg to be queried is calculated based on the
comp or decomp core base address.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/zip/zip_main.c | 48 +++++++++++--------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 399b681ee423..e40d1539ba1e 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -37,7 +37,7 @@
 #define HZIP_QM_IDEL_STATUS		0x3040e4
 
 #define HZIP_CORE_DFX_BASE		0x301000
-#define HZIP_CLOCK_GATED_CONTL		0X301004
+#define HZIP_CORE_DFX_DECOMP_BASE	0x304000
 #define HZIP_CORE_DFX_COMP_0		0x302000
 #define HZIP_CORE_DFX_COMP_1		0x303000
 #define HZIP_CORE_DFX_DECOMP_0		0x304000
@@ -48,6 +48,7 @@
 #define HZIP_CORE_DFX_DECOMP_5		0x309000
 #define HZIP_CORE_REGS_BASE_LEN		0xB0
 #define HZIP_CORE_REGS_DFX_LEN		0x28
+#define HZIP_CORE_ADDR_INTRVL		0x1000
 
 #define HZIP_CORE_INT_SOURCE		0x3010A0
 #define HZIP_CORE_INT_MASK_REG		0x3010A4
@@ -269,28 +270,6 @@ static const u32 zip_pre_store_caps[] = {
 	ZIP_DEV_ALG_BITMAP,
 };
 
-enum {
-	HZIP_COMP_CORE0,
-	HZIP_COMP_CORE1,
-	HZIP_DECOMP_CORE0,
-	HZIP_DECOMP_CORE1,
-	HZIP_DECOMP_CORE2,
-	HZIP_DECOMP_CORE3,
-	HZIP_DECOMP_CORE4,
-	HZIP_DECOMP_CORE5,
-};
-
-static const u64 core_offsets[] = {
-	[HZIP_COMP_CORE0]   = 0x302000,
-	[HZIP_COMP_CORE1]   = 0x303000,
-	[HZIP_DECOMP_CORE0] = 0x304000,
-	[HZIP_DECOMP_CORE1] = 0x305000,
-	[HZIP_DECOMP_CORE2] = 0x306000,
-	[HZIP_DECOMP_CORE3] = 0x307000,
-	[HZIP_DECOMP_CORE4] = 0x308000,
-	[HZIP_DECOMP_CORE5] = 0x309000,
-};
-
 static const struct debugfs_reg32 hzip_dfx_regs[] = {
 	{"HZIP_GET_BD_NUM                ",  0x00},
 	{"HZIP_GET_RIGHT_BD              ",  0x04},
@@ -807,6 +786,18 @@ static int hisi_zip_regs_show(struct seq_file *s, void *unused)
 
 DEFINE_SHOW_ATTRIBUTE(hisi_zip_regs);
 
+static void __iomem *get_zip_core_addr(struct hisi_qm *qm, int core_num)
+{
+	u32 zip_comp_core_num = qm->cap_tables.dev_cap_table[ZIP_CLUSTER_COMP_NUM_CAP_IDX].cap_val;
+
+	if (core_num < zip_comp_core_num)
+		return qm->io_base + HZIP_CORE_DFX_BASE +
+			(core_num + 1) * HZIP_CORE_ADDR_INTRVL;
+
+	return qm->io_base + HZIP_CORE_DFX_DECOMP_BASE +
+		(core_num - zip_comp_core_num) * HZIP_CORE_ADDR_INTRVL;
+}
+
 static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 {
 	u32 zip_core_num, zip_comp_core_num, i;
@@ -831,7 +822,7 @@ static int hisi_zip_core_debug_init(struct hisi_qm *qm)
 
 		regset->regs = hzip_dfx_regs;
 		regset->nregs = ARRAY_SIZE(hzip_dfx_regs);
-		regset->base = qm->io_base + core_offsets[i];
+		regset->base = get_zip_core_addr(qm, i);
 		regset->dev = dev;
 
 		tmp_d = debugfs_create_dir(buf, qm->debug.debug_root);
@@ -920,13 +911,14 @@ static int hisi_zip_debugfs_init(struct hisi_qm *qm)
 /* hisi_zip_debug_regs_clear() - clear the zip debug regs */
 static void hisi_zip_debug_regs_clear(struct hisi_qm *qm)
 {
+	u32 zip_core_num = qm->cap_tables.dev_cap_table[ZIP_CORE_NUM_CAP_IDX].cap_val;
 	size_t i, j;
 
 	/* enable register read_clear bit */
 	writel(HZIP_RD_CNT_CLR_CE_EN, qm->io_base + HZIP_SOFT_CTRL_CNT_CLR_CE);
-	for (i = 0; i < ARRAY_SIZE(core_offsets); i++)
+	for (i = 0; i < zip_core_num; i++)
 		for (j = 0; j < ARRAY_SIZE(hzip_dfx_regs); j++)
-			readl(qm->io_base + core_offsets[i] +
+			readl(get_zip_core_addr(qm, i) +
 			      hzip_dfx_regs[j].offset);
 
 	/* disable register read_clear bit */
@@ -968,7 +960,7 @@ static int hisi_zip_show_last_regs_init(struct hisi_qm *qm)
 	}
 
 	for (i = 0; i < zip_core_num; i++) {
-		io_base = qm->io_base + core_offsets[i];
+		io_base = get_zip_core_addr(qm, i);
 		for (j = 0; j < core_dfx_regs_num; j++) {
 			idx = com_dfx_regs_num + i * core_dfx_regs_num + j;
 			debug->last_words[idx] = readl_relaxed(
@@ -1019,7 +1011,7 @@ static void hisi_zip_show_last_dfx_regs(struct hisi_qm *qm)
 		else
 			scnprintf(buf, sizeof(buf), "Decomp_core-%u",
 				  i - zip_comp_core_num);
-		base = qm->io_base + core_offsets[i];
+		base = get_zip_core_addr(qm, i);
 
 		pci_info(qm->pdev, "==>%s:\n", buf);
 		/* dump last word for dfx regs during control resetting */
-- 
2.33.0



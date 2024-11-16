Return-Path: <linux-kernel+bounces-411651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1BD9CFD67
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C23AB25FC4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BB193071;
	Sat, 16 Nov 2024 08:57:56 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F814524C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731747476; cv=none; b=jiA6OvjERlmylkqu4iB/x/2ZCnl6TOmnCo1jgZ9MEIPSEXXw68teuKs3wfHQzXZVCphGrcK4qIAvcfP44EQlHn8i9CKrj/dsY79vbwrdw9IU9LPZ0hm4hHUBzDfZZpZWDRm+ZXyTXrTXTDE+TDZgkaP1ktMU2EHpg9Y+0L/YdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731747476; c=relaxed/simple;
	bh=hz7V6MyuYXBCqwa8TTJMBsyxVU7+wBZnkIbwd0AEDR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pppxcGMnVPU2S/gdxTOadAPEdWn9BoWPy4U4ZUSyLKOJdhA5zFWZnKkW/Lv2oSZVqIerTc7pqPP2OnLKwW+C0uBWPzJbSyDHR8OmejVKbf17zjUDYX5dM7Ym1LoMYKfJPDtwcxU7VU66EwBf0fcXEduRTsyjGzHHPBTEnIJmH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.49.17])
	by gateway (Coremail) with SMTP id _____8AxaeCGXjhnU0Q_AA--.38571S3;
	Sat, 16 Nov 2024 16:57:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.49.17])
	by front1 (Coremail) with SMTP id qMiowMCxPMJ_XjhnwUlYAA--.48984S2;
	Sat, 16 Nov 2024 16:57:36 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: arnd@arndb.de,
	olof@lixom.net
Cc: soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Qunqin Zhao <zhaoqunqin@loongson.cn>
Subject: [PATCH] soc: loongson: add Loongson Security Module driver
Date: Sat, 16 Nov 2024 16:57:29 +0800
Message-Id: <20241116085729.12651-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxPMJ_XjhnwUlYAA--.48984S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3uF4DCF4fCFWrAF43Zw15Jrc_yoW8Cw1Duo
	WIvFs3Zw4rJrn7ArW09r1FqrWxZa4YkayYyws3ZrZ293WUJF15tFW8Ww43GFs3uFWrtr15
	u34YqrWfuF4akrn5l-sFpf9Il3svdjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

This driver supports Loongson Security Module, which
provides the control for it's hardware encryption
acceleration child devices.

Only ACPI firmware is supported.

Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
 MAINTAINERS                        |   7 +
 drivers/soc/loongson/Kconfig       |   9 +
 drivers/soc/loongson/Makefile      |   1 +
 drivers/soc/loongson/loongson_se.c | 542 +++++++++++++++++++++++++++++
 include/soc/loongson/se.h          | 135 +++++++
 5 files changed, 694 insertions(+)
 create mode 100644 drivers/soc/loongson/loongson_se.c
 create mode 100644 include/soc/loongson/se.h

diff --git a/MAINTAINERS b/MAINTAINERS
index fdeb3d12c..85fff2eb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13379,6 +13379,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
+LOONGSON SECURITY MODULE DRIVER
+M:	Qunqin Zhao <zhaoqunqin@loongson.cn>
+L:	loongarch@lists.linux.dev
+S:	Maintained
+F:	drivers/soc/loongson/loongson_se.c
+F:	include/soc/loongson/se.h
+
 LOONGSON-2 SOC SERIES PM DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-pm@vger.kernel.org
diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
index 368344943..93ef1d205 100644
--- a/drivers/soc/loongson/Kconfig
+++ b/drivers/soc/loongson/Kconfig
@@ -27,3 +27,12 @@ config LOONGSON2_PM
 	  Disk), ACPI S5 (Soft Shutdown) and supports multiple wake-up methods
 	  (USB, GMAC, PWRBTN, etc.). This driver was to add power management
 	  controller support that base on dts for Loongson-2 series SoCs.
+
+config LOONGSON_SE
+	tristate "LOONGSON SECURITY MODULE Interface"
+	depends on LOONGARCH && ACPI
+	help
+	  The Loongson security module provides the control for hardware
+	  encryption acceleration devices. Each device uses at least one
+	  channel to interacts with security module, and each channel may
+	  has its own buffer provided by security module.
diff --git a/drivers/soc/loongson/Makefile b/drivers/soc/loongson/Makefile
index 4118f50f5..503075042 100644
--- a/drivers/soc/loongson/Makefile
+++ b/drivers/soc/loongson/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_LOONGSON2_GUTS)		+= loongson2_guts.o
 obj-$(CONFIG_LOONGSON2_PM)		+= loongson2_pm.o
+obj-$(CONFIG_LOONGSON_SE)		+= loongson_se.o
diff --git a/drivers/soc/loongson/loongson_se.c b/drivers/soc/loongson/loongson_se.c
new file mode 100644
index 000000000..d85db8423
--- /dev/null
+++ b/drivers/soc/loongson/loongson_se.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include <linux/acpi.h>
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <soc/loongson/se.h>
+
+/*
+ * The Loongson Security Module provides the control for hardware
+ * encryption acceleration child devices. The SE framework is
+ * shown as follows:
+ *
+ *                   +------------+
+ *                   |    CPU     |
+ *                   +------------+
+ *			^	^
+ *	            DMA |	| IRQ
+ *			v	v
+ *        +-----------------------------------+
+ *        |     Loongson Security Module      |
+ *        +-----------------------------------+
+ *             ^                ^
+ *    chnnel0  |       channel1 |
+ *             v                v
+ *        +-----------+    +----------+
+ *        | sub-dev0  |    | sub-dev1 |  ..... Max sub-dev31
+ *        +-----------+    +----------+
+ *
+ * The CPU cannot directly communicate with SE's sub devices,
+ * but sends commands to SE, which processes the commands and
+ * sends them to the corresponding sub devices.
+ */
+
+static inline u32 se_readl(struct loongson_se *se, u32 off)
+{
+	return readl(se->base + off);
+}
+
+static inline void se_writel(struct loongson_se *se, u32 val, u32 off)
+{
+	writel(val, se->base + off);
+}
+
+static inline bool se_ch_status(struct loongson_se *se, u32 int_bit)
+{
+	return !!(se->ch_status & int_bit);
+}
+
+static void se_enable_int(struct loongson_se *se, u32 int_bit)
+{
+	unsigned long flag;
+	u32 tmp;
+
+	if (!int_bit)
+		return;
+
+	spin_lock_irqsave(&se->dev_lock, flag);
+
+	tmp = se_readl(se, SE_S2LINT_EN);
+	tmp |= int_bit;
+	se_writel(se, tmp, SE_S2LINT_EN);
+
+	spin_unlock_irqrestore(&se->dev_lock, flag);
+}
+
+static void se_disable_int(struct loongson_se *se, u32 int_bit)
+{
+	unsigned long flag;
+	u32 tmp;
+
+	if (!int_bit)
+		return;
+
+	spin_lock_irqsave(&se->dev_lock, flag);
+
+	tmp = se_readl(se, SE_S2LINT_EN);
+	tmp &= ~(int_bit);
+	se_writel(se, tmp, SE_S2LINT_EN);
+
+	spin_unlock_irqrestore(&se->dev_lock, flag);
+}
+
+static int se_send_requeset(struct loongson_se *se, struct se_data *req)
+{
+	unsigned long flag;
+	u32 status;
+	int err = 0;
+	int i;
+
+	if (!se || !req)
+		return -EINVAL;
+
+	if (se_readl(se, SE_L2SINT_STAT) ||
+	    !(se_readl(se, SE_L2SINT_EN) & req->int_bit))
+		return -EBUSY;
+
+	spin_lock_irqsave(&se->cmd_lock, flag);
+
+	for (i = 0; i < ARRAY_SIZE(req->u.data); i++)
+		se_writel(se, req->u.data[i], SE_MAILBOX_S + i * 4);
+	se_writel(se, req->int_bit, SE_L2SINT_SET);
+	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
+						!(status & req->int_bit), 10, 10000);
+
+	spin_unlock_irqrestore(&se->cmd_lock, flag);
+
+	return err;
+}
+
+static int se_get_response(struct loongson_se *se, struct se_data *res)
+{
+	unsigned long flag;
+	int i;
+
+	if (!se || !res)
+		return -EINVAL;
+
+	if ((se_readl(se, SE_S2LINT_STAT) & res->int_bit) == 0)
+		return -EBUSY;
+
+	spin_lock_irqsave(&se->cmd_lock, flag);
+
+	for (i = 0; i < ARRAY_SIZE(res->u.data); i++)
+		res->u.data[i] = se_readl(se, SE_MAILBOX_L + i * 4);
+	se_writel(se, res->int_bit, SE_S2LINT_CL);
+
+	spin_unlock_irqrestore(&se->cmd_lock, flag);
+
+	return 0;
+}
+
+static int loongson_se_get_res(struct loongson_se *se, u32 int_bit, u32 cmd,
+			       struct se_data *res)
+{
+	int err = 0;
+
+	res->int_bit = int_bit;
+
+	if (se_get_response(se, res)) {
+		dev_err(se->dev, "Int 0x%x get response fail.\n", int_bit);
+		return -EFAULT;
+	}
+
+	/* Check response */
+	if (res->u.res.cmd == cmd)
+		err = 0;
+	else {
+		dev_err(se->dev, "Response cmd is 0x%x, not expect cmd 0x%x.\n",
+			res->u.res.cmd, cmd);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int se_send_genl_cmd(struct loongson_se *se, struct se_data *req,
+			    struct se_data *res, int retry)
+{
+	int err = 0, cnt = 0;
+
+try_again:
+	if (cnt++ >= retry) {
+		err = -ETIMEDOUT;
+		goto out;
+	}
+
+	dev_dbg(se->dev, "%d time send cmd 0x%x\n", cnt, req->u.gcmd.cmd);
+
+	err = se_send_requeset(se, req);
+	if (err)
+		goto try_again;
+
+	if (!wait_for_completion_timeout(&se->cmd_completion, HZ)) {
+		se_enable_int(se, req->int_bit);
+		goto try_again;
+	}
+	err = loongson_se_get_res(se, req->int_bit, req->u.gcmd.cmd, res);
+	if (err || res->u.res.cmd_ret) {
+		se_enable_int(se, req->int_bit);
+		goto try_again;
+	}
+
+out:
+	se_enable_int(se, req->int_bit);
+
+	return err;
+}
+
+static int loongson_se_set_msg(struct lsse_ch *ch)
+{
+	struct loongson_se *se = ch->se;
+	struct se_data req = {0};
+	struct se_data res = {0};
+	int err;
+
+	req.int_bit = SE_INT_SETUP;
+	req.u.gcmd.cmd = SE_CMD_SETMSG;
+	/* MSG off */
+	req.u.gcmd.info[0] = ch->id;
+	req.u.gcmd.info[1] = ch->smsg - se->mem_base;
+	req.u.gcmd.info[2] = ch->msg_size;
+
+	dev_dbg(se->dev, "Set Channel %d msg off 0x%x, msg size %d\n",
+		ch->id, req.u.gcmd.info[1], req.u.gcmd.info[2]);
+
+	err = se_send_genl_cmd(se, &req, &res, 5);
+	if (res.u.res.cmd_ret)
+		return res.u.res.cmd_ret;
+
+	return err;
+}
+
+static irqreturn_t se_irq(int irq, void *dev_id)
+{
+	struct loongson_se *se = (struct loongson_se *)dev_id;
+	struct lsse_ch *ch;
+	u32 int_status;
+
+	int_status = se_readl(se, SE_S2LINT_STAT);
+
+	dev_dbg(se->dev, "%s int status is 0x%x\n", __func__, int_status);
+
+	se_disable_int(se, int_status);
+
+	if (int_status & SE_INT_SETUP) {
+		complete(&se->cmd_completion);
+		int_status &= ~SE_INT_SETUP;
+	}
+
+	while (int_status) {
+		int id = __ffs(int_status);
+
+		ch = &se->chs[id];
+		if (ch->complete)
+			ch->complete(ch);
+		int_status &= ~BIT(id);
+		se_writel(se, BIT(id), SE_S2LINT_CL);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int se_init_hw(struct loongson_se *se, dma_addr_t addr, int size)
+{
+	struct se_data req;
+	struct se_data res;
+	int err, retry = 5;
+
+	se_enable_int(se, SE_INT_SETUP);
+
+	/* Start engine */
+	memset(&req, 0, sizeof(struct se_data));
+	memset(&res, 0, sizeof(struct se_data));
+	req.int_bit = SE_INT_SETUP;
+	req.u.gcmd.cmd = SE_CMD_START;
+	err = se_send_genl_cmd(se, &req, &res, retry);
+	if (err)
+		return err;
+
+	/* Get Version */
+	memset(&req, 0, sizeof(struct se_data));
+	memset(&res, 0, sizeof(struct se_data));
+	req.int_bit = SE_INT_SETUP;
+	req.u.gcmd.cmd = SE_CMD_GETVER;
+	err = se_send_genl_cmd(se, &req, &res, retry);
+	if (err)
+		return err;
+	se->version = res.u.res.info[0];
+
+	/* Set shared mem */
+	memset(&req, 0, sizeof(struct se_data));
+	memset(&res, 0, sizeof(struct se_data));
+	req.int_bit = SE_INT_SETUP;
+	req.u.gcmd.cmd = SE_CMD_SETBUF;
+	/* MMAP */
+	req.u.gcmd.info[0] = addr & 0xffffffff;
+	req.u.gcmd.info[1] = addr >> 32;
+	/* MASK */
+	req.u.gcmd.info[2] = ~(size - 1);
+	req.u.gcmd.info[3] = 0xffffffff;
+	err = se_send_genl_cmd(se, &req, &res, retry);
+	if (err)
+		return err;
+	pr_debug("Set win mmap 0x%llx, mask 0x%llx\n",
+		 ((u64)req.u.gcmd.info[1] << 32) | req.u.gcmd.info[0],
+		 ((u64)req.u.gcmd.info[3] << 32) | req.u.gcmd.info[2]);
+
+	return err;
+}
+
+static void se_disable_hw(struct loongson_se *se)
+{
+	struct se_data req = {0};
+	struct se_data res = {0};
+
+	/* Stop engine */
+	req.int_bit = SE_INT_SETUP;
+	req.u.gcmd.cmd = SE_CMD_STOP;
+	se_send_genl_cmd(se, &req, &res, 5);
+	se_disable_int(se, SE_INT_ALL);
+}
+
+/*
+ * Called by SE's child device driver.
+ */
+int se_send_ch_requeset(struct lsse_ch *ch)
+{
+	struct loongson_se *se;
+	u32 status, int_bit;
+	int err = 0;
+
+	if (!ch)
+		return -EINVAL;
+
+	se = ch->se;
+	int_bit = ch->int_bit;
+
+	if ((se_readl(se, SE_L2SINT_STAT) & int_bit) ||
+	    !(se_readl(se, SE_L2SINT_EN) & int_bit))
+		return -EBUSY;
+
+	se_enable_int(se, int_bit);
+	se_writel(se, int_bit, SE_L2SINT_SET);
+
+	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
+						!(status & int_bit), 10, 10000);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(se_send_ch_requeset);
+
+/*
+ * se_init_ch() - Init the channel used by child device.
+ *
+ * Allocate the shared memory agreed upon with SE on SE probe,
+ * and register the callback function when the data processing
+ * in this channel is completed.
+ */
+struct lsse_ch *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
+			   void *priv, void (*complete)(struct lsse_ch *se_ch))
+{
+	struct loongson_se *se = dev_get_drvdata(dev);
+	struct lsse_ch *ch;
+	unsigned long flag;
+	int data_first, data_nr;
+	int msg_first, msg_nr;
+
+	if (!se) {
+		pr_err("SE has bot been initialized\n");
+		return NULL;
+	}
+
+	if (id == 0 || id > SE_CH_MAX) {
+		dev_err(se->dev, "Channel number %d is invalid\n", id);
+		return NULL;
+	}
+
+	if (se_ch_status(se, BIT(id))) {
+		dev_err(se->dev, "Channel number %d has been initialized\n", id);
+		return NULL;
+	}
+
+	spin_lock_irqsave(&se->dev_lock, flag);
+
+	ch = &se->chs[id];
+	ch->se = se;
+	ch->id = id;
+	ch->int_bit = BIT(id);
+	se->ch_status |= BIT(id);
+
+	data_nr = round_up(data_size, PAGE_SIZE) / PAGE_SIZE;
+	data_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
+						0, data_nr, 0);
+	if (data_first >= se->mem_map_pages) {
+		dev_err(se->dev, "Insufficient memory space\n");
+		spin_unlock_irqrestore(&se->dev_lock, flag);
+		return NULL;
+	}
+
+	bitmap_set(se->mem_map, data_first, data_nr);
+	ch->data_buffer = se->mem_base + data_first * PAGE_SIZE;
+	ch->data_addr = se->mem_addr + data_first * PAGE_SIZE;
+	ch->data_size = data_size;
+
+	msg_nr = round_up(msg_size, PAGE_SIZE) / PAGE_SIZE;
+	msg_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
+					       0, msg_nr, 0);
+	if (msg_first >= se->mem_map_pages) {
+		dev_err(se->dev, "Insufficient memory space\n");
+		bitmap_clear(se->mem_map, data_first, data_nr);
+		spin_unlock_irqrestore(&se->dev_lock, flag);
+		return NULL;
+	}
+
+	bitmap_set(se->mem_map, msg_first, msg_nr);
+	ch->smsg = se->mem_base + msg_first * PAGE_SIZE;
+	ch->rmsg = ch->smsg + msg_size / 2;
+	ch->msg_size = msg_size;
+	ch->complete = complete;
+	ch->priv = priv;
+	spin_lock_init(&ch->ch_lock);
+
+	spin_unlock_irqrestore(&se->dev_lock, flag);
+
+	if (loongson_se_set_msg(ch)) {
+		dev_err(se->dev, "Channel %d setup message address failed\n", id);
+		return NULL;
+	}
+
+	se_enable_int(se, ch->int_bit);
+
+	return ch;
+}
+EXPORT_SYMBOL_GPL(se_init_ch);
+
+void se_deinit_ch(struct lsse_ch *ch)
+{
+	struct loongson_se *se = ch->se;
+	unsigned long flag;
+	int first, nr;
+	int id = ch->id;
+
+	if (!se) {
+		pr_err("SE has bot been initialized\n");
+		return;
+	}
+
+	if (id == 0 || id > SE_CH_MAX) {
+		dev_err(se->dev, "Channel number %d is invalid\n", id);
+		return;
+	}
+
+	if (!se_ch_status(se, BIT(id))) {
+		dev_err(se->dev, "Channel number %d has not been initialized\n", id);
+		return;
+	}
+
+	spin_lock_irqsave(&se->dev_lock, flag);
+
+	se->ch_status &= ~BIT(ch->id);
+
+	first = (ch->data_buffer - se->mem_base) / PAGE_SIZE;
+	nr = round_up(ch->data_size, PAGE_SIZE) / PAGE_SIZE;
+	bitmap_clear(se->mem_map, first, nr);
+
+	first = (ch->smsg - se->mem_base) / PAGE_SIZE;
+	nr = round_up(ch->msg_size, PAGE_SIZE) / PAGE_SIZE;
+	bitmap_clear(se->mem_map, first, nr);
+
+	se_disable_int(se, ch->int_bit);
+
+	spin_unlock_irqrestore(&se->dev_lock, flag);
+
+}
+EXPORT_SYMBOL_GPL(se_deinit_ch);
+
+static int loongson_se_probe(struct platform_device *pdev)
+{
+	struct loongson_se *se;
+	struct device *dev = &pdev->dev;
+	int nr_irq, irq, err, size;
+
+	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+	se->dev = dev;
+	dev_set_drvdata(dev, se);
+	init_completion(&se->cmd_completion);
+	spin_lock_init(&se->cmd_lock);
+	spin_lock_init(&se->dev_lock);
+	/* Setup DMA buffer */
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (device_property_read_u32(dev, "dmam_size", &size))
+		return -ENODEV;
+	size = roundup_pow_of_two(size);
+	se->mem_base = dmam_alloc_coherent(dev, size, &se->mem_addr, GFP_KERNEL);
+	if (!se->mem_base)
+		return -ENOMEM;
+	memset(se->mem_base, 0, size);
+	se->mem_map_pages = size / PAGE_SIZE;
+	se->mem_map = devm_bitmap_zalloc(dev, se->mem_map_pages, GFP_KERNEL);
+	if (!se->mem_map)
+		return -ENOMEM;
+
+	se->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(se->base))
+		return PTR_ERR(se->base);
+
+	nr_irq = platform_irq_count(pdev);
+	if (nr_irq <= 0)
+		return -ENODEV;
+	while (nr_irq) {
+		irq = platform_get_irq(pdev, --nr_irq);
+		if (irq < 0)
+			return -ENODEV;
+		/* Use the same interrupt handler address.
+		 * Determine which irq it is accroding
+		 * SE_S2LINT_STAT register.
+		 */
+		err = devm_request_irq(dev, irq, se_irq, 0,
+				       "loongson-se", se);
+		if (err)
+			dev_err(dev, "failed to request irq: %d\n", err);
+	}
+
+	err = se_init_hw(se, se->mem_addr, size);
+	if (err)
+		se_disable_hw(se);
+
+	return err;
+}
+
+static struct acpi_device_id loongson_se_acpi_match[] = {
+	{"LOON0011", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
+
+static struct platform_driver loongson_se_driver = {
+	.probe   = loongson_se_probe,
+	.driver  = {
+		.name  = "loongson-se",
+		.acpi_match_table = loongson_se_acpi_match,
+	},
+};
+module_platform_driver(loongson_se_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Loongson Technology Corporation");
+MODULE_DESCRIPTION("Loongson Security Module driver");
diff --git a/include/soc/loongson/se.h b/include/soc/loongson/se.h
new file mode 100644
index 000000000..bf5babf82
--- /dev/null
+++ b/include/soc/loongson/se.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2024 Loongson Technology Corporation Limited */
+
+#ifndef __LOONGSON_SE_H__
+#define __LOONGSON_SE_H__
+
+#define SE_MAILBOX_S			0x0
+#define SE_MAILBOX_L			0x20
+#define SE_S2LINT_STAT			0x88
+#define SE_S2LINT_EN			0x8c
+#define SE_S2LINT_SET			0x90
+#define SE_S2LINT_CL			0x94
+#define SE_L2SINT_STAT			0x98
+#define SE_L2SINT_EN			0x9c
+#define SE_L2SINT_SET			0xa0
+#define SE_L2SINT_CL			0xa4
+
+/* INT bit definition */
+#define SE_INT_SETUP			BIT(0)
+#define SE_INT_SM2			BIT(0)
+#define SE_INT_SM3			BIT(0)
+#define SE_INT_SM4			BIT(0)
+#define SE_INT_RNG			BIT(0)
+#define SE_INT_TPM			BIT(5)
+#define SE_INT_ALL			0xffffffff
+
+#define SE_CMD_START			0x0
+#define SE_CMD_STOP			0x1
+#define SE_CMD_GETVER			0x2
+#define SE_CMD_SETBUF			0x3
+#define SE_CMD_SETMSG			0x4
+
+#define SE_CMD_RNG			0x100
+
+#define SE_CMD_SM2_SIGN			0x200
+#define SE_CMD_SM2_VSIGN		0x201
+
+#define SE_CMD_SM3_DIGEST		0x300
+#define SE_CMD_SM3_UPDATE		0x301
+#define SE_CMD_SM3_FINISH		0x302
+
+#define SE_CMD_SM4_ECB_ENCRY		0x400
+#define SE_CMD_SM4_ECB_DECRY		0x401
+#define SE_CMD_SM4_CBC_ENCRY		0x402
+#define SE_CMD_SM4_CBC_DECRY		0x403
+#define SE_CMD_SM4_CTR			0x404
+
+#define SE_CMD_TPM			0x500
+#define SE_CMD_ZUC_INIT_READ		0x600
+#define SE_CMD_ZUC_READ			0x601
+
+#define SE_CMD_SDF			0x700
+
+#define SE_CH_MAX			32
+
+#define SE_CH_RNG			1
+#define SE_CH_SM2			2
+#define SE_CH_SM3			3
+#define SE_CH_SM4			4
+#define SE_CH_TPM			5
+#define SE_CH_ZUC			6
+#define SE_CH_SDF			7
+
+struct se_msg {
+	u32 cmd;
+	u32 data_off;
+	u32 data_len;
+	u32 info[5];
+};
+
+struct se_cmd {
+	u32 cmd;
+	u32 info[7];
+};
+
+struct se_res {
+	u32 cmd;
+	u32 cmd_ret;
+	u32 info[6];
+};
+
+struct se_data {
+	u32 int_bit;
+	union {
+		u32 data[8];
+		struct se_cmd gcmd;
+		struct se_res res;
+	} u;
+};
+
+struct lsse_ch {
+	u32 id;
+	u32 int_bit;
+	struct loongson_se *se;
+	void *priv;
+	spinlock_t ch_lock;
+	void *smsg;
+	void *rmsg;
+	int msg_size;
+	void *data_buffer;
+	dma_addr_t data_addr;
+	int data_size;
+
+	void (*complete)(struct lsse_ch *se_ch);
+};
+
+struct loongson_se {
+	struct device *dev;
+	void __iomem *base;
+	u32 version;
+	u32 ch_status;
+	spinlock_t cmd_lock;
+	spinlock_t dev_lock;
+
+	/* Interaction memory */
+	void *mem_base;
+	dma_addr_t mem_addr;
+	unsigned long *mem_map;
+	int mem_map_pages;
+	void *smsg;
+	void *rmsg;
+
+	/* Synchronous CMD */
+	struct completion cmd_completion;
+
+	/* Channel */
+	struct lsse_ch chs[SE_CH_MAX];
+};
+
+struct lsse_ch *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
+			   void *priv, void (*complete)(struct lsse_ch *se_ch));
+void se_deinit_ch(struct lsse_ch *ch);
+int se_send_ch_requeset(struct lsse_ch *ch);
+
+#endif

base-commit: daa20223dee942ebea45bc72b517480af226c370
-- 
2.43.0



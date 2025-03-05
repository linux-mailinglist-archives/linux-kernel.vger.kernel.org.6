Return-Path: <linux-kernel+bounces-546324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2ADA4F930
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4835518929BB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E181FECD5;
	Wed,  5 Mar 2025 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="F9NycHxn"
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92222155342;
	Wed,  5 Mar 2025 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741164733; cv=none; b=JNbHERYseJs9iRTGGV2jwloCMlU0S37joVAK6G1T9hKBNUk9IoHywhU5jNKBuc/BFl0SRwqD9+9O98tG6N0CqpLr+KBq++oyULr8XnGsKEa7yu9A5ezZqPm3Mzb2I2LkXUf6QRWF0ylciXBwwybVMbsH9fIw359AaO6U/VvkMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741164733; c=relaxed/simple;
	bh=tqBNR7Sf22UPA0LZEEZQIpCtbxOpfzugC9wRBsp7tYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e8BBdvIYcjJWlKL8O3mjYW/0SESADg+MudYzWb6m+WI5eSQDTXXswWQFRz8tmX5J55yeB6grNobjLAOcyXTwrUcLCtrPjdkc/mX6i19S8+SVn8v4rRgIQnDWT6yPPgluzkjYl42oKqYdoX5nl7LP9B+IhUKa9gPu8PHux8akUaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=F9NycHxn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741164691;
	bh=gosyJsr5WdWELhEjJczXeMPsXeLuAzCn9g847AHqFd8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=F9NycHxn36uBq/XLT94LU8ypxpjOd4X3APflN3ODZElkBtugOI7wPn9nDCFlm2Ym3
	 w9kYRs2C7FCgE+8QGxX9AmosQot4PHlCBngup4J0FssUqZ9CSNmKkjcNgGNmWPkoOs
	 qQVKNWPJ7uUXQzxIMirMTnT6ffKUiUZEqodZVn2Y=
X-QQ-mid: bizesmtpip3t1741164683tq1cxyl
X-QQ-Originating-IP: uRVNgixp8pGgv3f3HilwgiQA1pH2uXCkpZm+t6dyWDA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Mar 2025 16:51:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9066119859746772134
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	Xu Rao <raoxu@uniontech.com>
Subject: [PATCH V3] usb: xhci: Add debugfs support for xHCI port bandwidth
Date: Wed,  5 Mar 2025 16:51:18 +0800
Message-Id: <20250305085118.28826-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: OUwDEvzsARlM4QvxD9GMUdwGQ2MrlYGvzSDFprdUzt4Qp74lj+ljYcD1
	wzhfsJVzBAoEnpQABk7aqfJfwpAorkCE1nDtzYcxHAuedFcjHXSOsHPFzvR/gw5LPEjY2qW
	/p/hce8Ls9WPsYyFKjahmZ6Cb98nWW8i89gbbAwbKapqDmYFNEz2mBQ+7m1udZ9SNauVXnK
	VW/mJzoS9B8STxilC39lJbb76i8YUM0XVwXEC/x1FkFpBQrmcK8SA7RKKdG67qVf8a1bEmT
	hZ74qxSfnSKET8piTFgnVF+iMglrgmOiTwlcVtNPIu7duyW4f0o3M5ulXdH4R28NVPJUIPV
	yDRt9f8gfw3ajPtKWQC+Pcws/8GaJ4pAycntDA2LwFI3di3HeFu1pf1c/RRJklOMIIiiT+k
	ZFTvt0ClqUiwALIs/CQ0lfdcvgxpHUA/SX171qeQPzLaVuXSNbS05VUjTma9PitbZnL0Bz0
	N/lMyR2xZpmPOsvtHqRqAMKj9ZxHoh3T1o+QxdjidNLJGP45YOTDOWCs+Eni3OK8SEYvlg3
	q3qgCkcV/8GlbPqy4yyq+zPV1rigN6dMNELOOUuG1t6reFs5nOPVa+jZYDoDrlvLmF2yD03
	qom2/Ozt/UBun0z1zCmIiz5JJPdaH+p5jMbiCqo6wSTVNUksy8pby0RsTccPaQyggxOKT5H
	MKDBzaZtCcqznBGpW2/EjJJE5U+RS4KhwcpAdOETpP3Q3F2Bd3KGRDjdwhfgK6Z9rIUhs61
	PpiiszLONwvj9CX7FIO7neUi4MjER41cm/mY4Gj4PVQrERR3Swc9I8AjuTgBnzPIm9XetB4
	xaOVRD/SSTuqJ0KaDOESlvNRm7FHi4WGM7U3GqgFMtG1xpksmAV/cAgT33io+SozBJVsuv8
	eE5jUDbRTkP2vCccBlS7oiV5/m1nK8S0V6vM10s7FSc2gLeSE1pitfR/cOZ6dp38rZFGXXN
	/YkjEjQ6M7GPT7UFF1lu3s1Ig+7ZIXSi5Yg8J6Gt1D3PSbcSDxemalXPEoIu31GWZXqbU0O
	JKHkSYfInVDVMM+CIi9VeBszNiIHVKgI6CNfPX+NMI46W7GRisQzHhVUIxgvBlPnpouyxwL
	Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

In many projects, you need to obtain the available bandwidth of the
xhci roothub port. Refer to xhci rev1_2 and use the TRB_GET_BW
command to obtain it.

hardware tested:
03:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
(prog-if 30 [XHCI])
Subsystem: Huawei Technologies Co., Ltd. Raven USB 3.1
Flags: bus master, fast devsel, latency 0, IRQ 30
Memory at c0300000 (64-bit, non-prefetchable) [size=1M]
Capabilities: [48] Vendor Specific Information: Len=08 <?>
Capabilities: [50] Power Management version 3
Capabilities: [64] Express Endpoint, MSI 00
Capabilities: [a0] MSI: Enable- Count=1/8 Maskable- 64bit+
Capabilities: [c0] MSI-X: Enable+ Count=8 Masked-
Kernel driver in use: xhci_hcd

test progress:
1. cd /sys/kernel/debug/usb/xhci/0000:03:00.3/port_bandwidth# ls
FS_BW  HS_BW  SS_BW
2. test fs speed  device
cat FS_BW
port[1] available bw: 90%.
port[2] available bw: 90%.
port[3] available bw: 90%.
port[4] available bw: 90%.
port[5] available bw: 0%.
port[6] available bw: 0%.
port[7] available bw: 0%.
port[8] available bw: 0%.
plug in fs usb audio ID 0d8c:013c
cat FS_BW
port[1] available bw: 76%.
port[2] available bw: 76%.
port[3] available bw: 76%.
port[4] available bw: 76%.
port[5] available bw: 0%.
port[6] available bw: 0%.
port[7] available bw: 0%.
port[8] available bw: 0%.
3. test hs speed device
cat HS_BW
port[1] available bw: 79%.
port[2] available bw: 79%.
port[3] available bw: 79%.
port[4] available bw: 79%.
port[5] available bw: 0%.
port[6] available bw: 0%.
port[7] available bw: 0%.
port[8] available bw: 0%.
plug in hs usb video ID 0408:1040
cat HS_BW
port[1] available bw: 39%.
port[2] available bw: 39%.
port[3] available bw: 39%.
port[4] available bw: 39%.
port[5] available bw: 0%.
port[6] available bw: 0%.
port[7] available bw: 0%.
port[8] available bw: 0%.
4.cat SS_BW
port[1] available bw: 0%.
port[2] available bw: 0%.
port[3] available bw: 0%.
port[4] available bw: 0%.
port[5] available bw: 90%.
port[6] available bw: 90%.
port[7] available bw: 90%.
port[8] available bw: 90%.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
Changelog:
 *v1->v2: modify the patch subject no code changes.
  v2->v3: separate files in debugfs for each speed (SS HS FS).
	queue one command for each speed not queuing three commands on one file.
	print value from context not array on stack.
---
 drivers/usb/host/xhci-debugfs.c | 93 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-mem.c     |  8 +++
 drivers/usb/host/xhci-ring.c    | 14 +++++
 drivers/usb/host/xhci.c         | 28 ++++++++++
 drivers/usb/host/xhci.h         |  9 ++++
 5 files changed, 152 insertions(+)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 1f5ef174abea..5751065d199c 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -631,6 +631,97 @@ static void xhci_debugfs_create_ports(struct xhci_hcd *xhci,
 	}
 }

+static int xhci_port_bw_show(struct xhci_hcd *xhci, u8 dev_speed,
+				struct seq_file *s)
+{
+	unsigned int			num_ports;
+	unsigned int			i;
+	int				ret;
+	struct xhci_container_ctx	*ctx;
+
+	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
+	ctx = xhci->get_bw_command->in_ctx;
+
+	/* get roothub port bandwidth */
+	ret = xhci_get_port_bandwidth(xhci, dev_speed);
+	if (ret)
+		return ret;
+
+	/* print all roothub ports available bandwidth */
+	for (i = 1; i < num_ports+1; i++)
+		seq_printf(s, "port[%d] available bw: %d%%.\n", i,
+				ctx->bytes[i]);
+
+	return ret;
+}
+
+static int xhci_ss_bw_show(struct seq_file *s, void *unused)
+{
+	int ret;
+	struct xhci_hcd		*xhci = (struct xhci_hcd *)s->private;
+
+	ret = xhci_port_bw_show(xhci, USB_SPEED_SUPER, s);
+	return ret;
+}
+
+static int xhci_hs_bw_show(struct seq_file *s, void *unused)
+{
+	int ret;
+	struct xhci_hcd		*xhci = (struct xhci_hcd *)s->private;
+
+	ret = xhci_port_bw_show(xhci, USB_SPEED_HIGH, s);
+	return ret;
+}
+
+static int xhci_fs_bw_show(struct seq_file *s, void *unused)
+{
+	int ret;
+	struct xhci_hcd		*xhci = (struct xhci_hcd *)s->private;
+
+	ret = xhci_port_bw_show(xhci, USB_SPEED_FULL, s);
+	return ret;
+}
+
+static struct xhci_file_map bw_context_files[] = {
+	{"SS_BW",	xhci_ss_bw_show, },
+	{"HS_BW",	xhci_hs_bw_show, },
+	{"FS_BW",	xhci_fs_bw_show, },
+};
+
+static int bw_context_open(struct inode *inode, struct file *file)
+{
+	int			i;
+	struct xhci_file_map	*f_map;
+	const char		*file_name = file_dentry(file)->d_iname;
+
+	for (i = 0; i < ARRAY_SIZE(bw_context_files); i++) {
+		f_map = &bw_context_files[i];
+
+		if (strcmp(f_map->name, file_name) == 0)
+			break;
+	}
+
+	return single_open(file, f_map->show, inode->i_private);
+}
+
+static const struct file_operations bw_fops = {
+	.open			= bw_context_open,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static void xhci_debugfs_create_bandwidth(struct xhci_hcd *xhci,
+					struct dentry *parent)
+{
+	parent = debugfs_create_dir("port_bandwidth", parent);
+
+	xhci_debugfs_create_files(xhci, bw_context_files,
+			  ARRAY_SIZE(bw_context_files),
+			  xhci,
+			  parent, &bw_fops);
+}
+
 void xhci_debugfs_init(struct xhci_hcd *xhci)
 {
 	struct device		*dev = xhci_to_hcd(xhci)->self.controller;
@@ -681,6 +772,8 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
 	xhci->debugfs_slots = debugfs_create_dir("devices", xhci->debugfs_root);

 	xhci_debugfs_create_ports(xhci, xhci->debugfs_root);
+
+	xhci_debugfs_create_bandwidth(xhci, xhci->debugfs_root);
 }

 void xhci_debugfs_exit(struct xhci_hcd *xhci)
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 92703efda1f7..66f08a96d6f9 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1875,6 +1875,10 @@ void xhci_mem_cleanup(struct xhci_hcd *xhci)
 	}
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init, "Freed interrupters");

+	if (xhci->get_bw_command)
+		xhci_free_command(xhci, xhci->get_bw_command);
+	xhci->get_bw_command = NULL;
+
 	if (xhci->cmd_ring)
 		xhci_ring_free(xhci, xhci->cmd_ring);
 	xhci->cmd_ring = NULL;
@@ -2490,6 +2494,10 @@ int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags)
 	 */
 	xhci->cmd_ring_reserved_trbs++;

+	xhci->get_bw_command = xhci_alloc_command_with_ctx(xhci, true, flags);
+	if (!xhci->get_bw_command)
+		goto fail;
+
 	val = readl(&xhci->cap_regs->db_off);
 	val &= DBOFF_MASK;
 	xhci_dbg_trace(xhci, trace_xhci_dbg_init,
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 965bffce301e..af1cd4f8ace9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1867,6 +1867,8 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	case TRB_NEC_GET_FW:
 		xhci_handle_cmd_nec_get_fw(xhci, event);
 		break;
+	case TRB_GET_BW:
+		break;
 	default:
 		/* Skip over unknown commands on the event ring */
 		xhci_info(xhci, "INFO unknown command type %d\n", cmd_type);
@@ -4414,6 +4416,18 @@ int xhci_queue_configure_endpoint(struct xhci_hcd *xhci,
 			command_must_succeed);
 }

+/* Queue a get root hub port bandwidth command TRB */
+int xhci_queue_get_rh_port_bw(struct xhci_hcd *xhci,
+		struct xhci_command *cmd, dma_addr_t in_ctx_ptr,
+		u8 dev_speed, u32 slot_id, bool command_must_succeed)
+{
+	return queue_command(xhci, cmd, lower_32_bits(in_ctx_ptr),
+		upper_32_bits(in_ctx_ptr), 0,
+		TRB_TYPE(TRB_GET_BW) | DEV_SPEED_FOR_TRB(dev_speed) |
+		SLOT_ID_FOR_TRB(slot_id),
+		command_must_succeed);
+}
+
 /* Queue an evaluate context command TRB */
 int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 45653114ccd7..123596e85d9c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3088,6 +3088,34 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev)
 }
 EXPORT_SYMBOL_GPL(xhci_reset_bandwidth);

+/* Get the available bandwidth of the ports under the xhci roothub */
+int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 dev_speed)
+{
+	unsigned int			num_ports;
+	int				ret;
+	unsigned long			flags;
+	struct xhci_container_ctx	*ctx;
+
+	num_ports = HCS_MAX_PORTS(xhci->hcs_params1);
+	ctx = xhci->get_bw_command->in_ctx;
+
+	/* get xhci hub port bandwidth */
+	/* refer to xhci rev1_2 protocol 4.6.15*/
+	spin_lock_irqsave(&xhci->lock, flags);
+	ret = xhci_queue_get_rh_port_bw(xhci, xhci->get_bw_command, ctx->dma,
+					dev_speed, 0, false);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		return ret;
+	}
+	xhci_ring_cmd_db(xhci);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	wait_for_completion(xhci->get_bw_command->completion);
+
+	return ret;
+}
+
 static void xhci_setup_input_ctx_for_config_ep(struct xhci_hcd *xhci,
 		struct xhci_container_ctx *in_ctx,
 		struct xhci_container_ctx *out_ctx,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8c164340a2c3..a7cefa8ca7cd 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -999,6 +999,9 @@ enum xhci_setup_dev {
 /* bits 16:23 are the virtual function ID */
 /* bits 24:31 are the slot ID */

+/* bits 19:16 are the dev speed */
+#define DEV_SPEED_FOR_TRB(p)    ((p) << 16)
+
 /* Stop Endpoint TRB - ep_index to endpoint ID for this TRB */
 #define SUSPEND_PORT_FOR_TRB(p)		(((p) & 1) << 23)
 #define TRB_TO_SUSPEND_PORT(p)		(((p) & (1 << 23)) >> 23)
@@ -1549,6 +1552,8 @@ struct xhci_hcd {
 	struct xhci_virt_device	*devs[MAX_HC_SLOTS];
 	/* For keeping track of bandwidth domains per roothub. */
 	struct xhci_root_port_bw_info	*rh_bw;
+	/* For get xhci roothub port bandwidth. */
+	struct xhci_command		*get_bw_command;

 	/* DMA pools */
 	struct dma_pool	*device_pool;
@@ -1907,6 +1912,10 @@ int xhci_queue_isoc_tx_prepare(struct xhci_hcd *xhci, gfp_t mem_flags,
 int xhci_queue_configure_endpoint(struct xhci_hcd *xhci,
 		struct xhci_command *cmd, dma_addr_t in_ctx_ptr, u32 slot_id,
 		bool command_must_succeed);
+int xhci_queue_get_rh_port_bw(struct xhci_hcd *xhci,
+		struct xhci_command *cmd, dma_addr_t in_ctx_ptr,
+		u8 dev_speed, u32 slot_id, bool command_must_succeed);
+int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 dev_speed);
 int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed);
 int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
--
2.43.4



Return-Path: <linux-kernel+bounces-544764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8C5A4E48F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808B97A5432
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008AC298CD4;
	Tue,  4 Mar 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="n9cqp1MP"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448B2255245
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741102812; cv=fail; b=QqtDi42wBXunTt8Z8VxsM6DQA6dV2OXnlnb8zpeoE7NMIlPJI7Nm/99UTeBQERgMoIV0Me/tFVCIxBAmt5La18Uc6Pa1EPDl/cntoAQVyZyXOPvUhSeFVDkup4uXntfby5tXnsrWgnPkW7MZ8OSupyycAL8fYwtKt9VAtEtREnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741102812; c=relaxed/simple;
	bh=uHWAZIPnGtPJ1xzl/wHTnNv5ycuRFrLaRDER5etlkDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tIt1VGool6/33vfWRdrCFQElGEiw7EIeJAAgy2fJmo0HLCHjhlyzrYsWL+QuOLs8Cm2ecLp6s5PrODJR+uNYhElpegijphx/p+Z9zh/p4OrbC7RYaTMekWb4OzBYhqs/zlhiAlsF8OdOY5wnNs5N7gOZrI2KFcwaOL+OW21fvkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n9cqp1MP reason="signature verification failed"; arc=none smtp.client-ip=54.254.200.128; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 7C37440CFED0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:40:08 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=n9cqp1MP
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fvn0bmXzG07C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:37:57 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 774914272F; Tue,  4 Mar 2025 18:37:51 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n9cqp1MP
X-Envelope-From: <linux-kernel+bounces-541325-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n9cqp1MP
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 84409430B7
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:59:34 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id D18BA3064C13
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:59:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDB277A4D6B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A581F1906;
	Mon,  3 Mar 2025 09:59:16 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C060D1EEA27;
	Mon,  3 Mar 2025 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740995952; cv=none; b=EGAClFiqdXyeZMXlYQAwJ8ORXf5eVihsjs0JpurRJ1QiPuN1QKHZgalU6tubqwu5pEfVhKGBoGp1Kyl0VaF5AI/9CA0DfOcYeJOWUmauePByz7KyYzFGoVaZtgL5H9e94/0ICrVOjmQjBkUZH53Ki0I9Gikcy0yiBLb2dK5329Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740995952; c=relaxed/simple;
	bh=Dgx0WmiWWJVJFOYXROEjC9QhshtwPpwi2bA+QbGxJUk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ogOqapcEaVGKlY/UWUPPvIZvsi+/5lrt5wzEm4p143PEcQDDUXiaL1SdIFYMvKwDYdxqiW++2clcVQeByfMPhUcQDfVpkbc04crpaZHhgvHfyOxqegLSPB5rEYbCkM7Yex/IsrISQuiFKrgGN9TCUKXx7106xjbUsKPXolSJXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=n9cqp1MP; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1740995930;
	bh=K/zA0N8M3Fo/mbM8RcyqXqLjJSa3rFqpG7w6gFb91fI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=n9cqp1MP7doGEOtAP3WnWF0PYRuTEodYVpDiB67uy0MA84th6NqSPsUhwEpR76aYu
	 r6rwkHoFJZ8oHrjR8Bq7ZE//z46oYHmD52+0WT8kM0+QpWT/G6IWeiN8ytOwTXVRxd
	 UlKW8sG4pPv5IsCzeGxAk6oOpS/JD58GMiMtof7o=
X-QQ-mid: bizesmtpip3t1740995922t7z61pl
X-QQ-Originating-IP: LIg0Yy8e5VUzBgFCyAYWG60yUtxBWS+LuXYa5nhA61Y=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 03 Mar 2025 17:58:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1883138028751320756
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	zhanjun@uniontech.com,
	Xu Rao <raoxu@uniontech.com>
Subject: [PATCH] From: Xu Rao <raoxu@uniontech.com> Subject: [PATCH] usb: xhci: Add debugfs support for xHCI port bandwidth
Date: Mon,  3 Mar 2025 17:58:37 +0800
Message-Id: <20250303095837.16332-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: My+Y/kkztEN1lslsfqyxyrJQ7+gHxHLHtisbPtmvYATJzRQxZmsLagno
	SIgJb1OKrwBLaU0R1UV3AHUo3YlmN+cWC3t9sLoPW2J8uCMgwL9/qxQ6Q+WjUaYz8W1NZT7
	NXBvxCpo3yB/gypxdap220dUyoS5KlIUV9TMrLYrb0RnPPcOEKAptQ0N0p0ZsE7pzamlUbr
	usyF5QqbJJlTXIhwaVHqdoNLBSNnBDbOWKRJi1B62+3lLksrqlAfqKKuMgdXpfzU6GYs3z2
	K7cMPQV7BbMu4hssTlzV7nZOeFvzMSDYum8+Aro/n+ICif0hRghmN5ZrdOr0NqCzPJstXSx
	3oE4EdRzRUcObgd9aFeiDXTTwSvKlSjhA2TTCu2UBRY8u4kFePH9QnUELGGfR8u4rJzsZhY
	fV6dsLweTFYmHTw1u2wycrGdN+FQhJZAYmGfb1BjxL8Y8UyhVAC7U2Ez9G/Et2OjrfwNoyR
	3gEqqjUyEPgZlVwcOxE7rMdvAfKtcThSQrR9AhlakXQ4VLLgm85RhLmxkVGkBCRTjf5Upzk
	+m4dlbLAu4Hni5w5dQfuoO6h5VowEz0Etf/NHGdUATKrJKzEbZ+cfgqO8WUHjDd18uFe/Xr
	xYunNk+LrCntbOi3WpKzMefsWmtlQcsvFFqEzDMh+UgxIb4wkVp5oC6rdhMu17ZPpfWu0Kx
	KU3AHH2qkZhzr2eYvFhT70MXIfIH46exjJIR3ptEZA7dfsYGtH+KQT8xwoUh3HCPfeTK6oh
	NDY91D6z6c3WgY3h/mWU3NOrfJE7WsgP/fc5kQmcesKuaFgZrJszaX0EKnaJB1K2QJFNn7+
	6kz4fBMMBQhl9lpSxZJZbN4p/bFx5wMPmWpeLwzyuvzGOeLRXvZX/vrH6+HAll3JCiL4hPC
	8+akPPLJYVm9axQrcJ5MofWN/giRz3aG59Vhe2pxC0zXIMkLhb0KEROsJLcH8uSb0Kvtawl
	2FkpDCMURLfIRNq5puVLwxiX09bt4wIzK+wrFe1m9gQ/Wtx8Gfj4RmjEeBR7R8Y0F8025k2
	hjxpp9ELj2UIhz/FEWMYM9+pB+KfM=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fvn0bmXzG07C
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707497.12037@Pf9mkiUKzc6pMvhrmsLErQ
X-ITU-MailScanner-SpamCheck: not spam

From: Xu Rao <raoxu@uniontech.com>

In many projects, you need to obtain the available bandwidth of the
xhci roothub port. Refer to xhci rev1_2 and use the TRB_GET_BW
command to obtain it.

hardware tested:
03:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raven USB 3.1
(prog-if 30 [XHCI])
Subsystem: Huawei Technologies Co., Ltd. Raven USB 3.1
Flags: bus master, fast devsel, latency 0, IRQ 30
Memory at c0300000 (64-bit, non-prefetchable) [size=3D1M]
Capabilities: [48] Vendor Specific Information: Len=3D08 <?>
Capabilities: [50] Power Management version 3
Capabilities: [64] Express Endpoint, MSI 00
Capabilities: [a0] MSI: Enable- Count=3D1/8 Maskable- 64bit+
Capabilities: [c0] MSI-X: Enable+ Count=3D8 Masked-
Kernel driver in use: xhci_hcd

test progress:
1.cd /sys/kernel/debug/usb/xhci/0000:03:00.3
cat port_bandwidth
/sys/kernel/debug/usb/xhci/0000:03:00.3# cat port_bandwidth
port[1] available bw: 79%.
port[2] available bw: 79%.
port[3] available bw: 79%.
port[4] available bw: 79%.
port[5] available bw: 90%.
port[6] available bw: 90%.
port[7] available bw: 90%.
port[8] available bw: 90%.
2.plug in usb video cammer open it
cat port_bandwidth
port[1] available bw: 39%.
port[2] available bw: 39%.
port[3] available bw: 39%.
port[4] available bw: 39%.
port[5] available bw: 90%.
port[6] available bw: 90%.
port[7] available bw: 90%.
port[8] available bw: 90%.

Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/usb/host/xhci-debugfs.c | 42 +++++++++++++++++++
 drivers/usb/host/xhci-ring.c    | 14 +++++++
 drivers/usb/host/xhci.c         | 74 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci.h         |  7 ++++
 4 files changed, 137 insertions(+)

diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debu=
gfs.c
index 1f5ef174abea..573b6c25f3af 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -631,6 +631,46 @@ static void xhci_debugfs_create_ports(struct xhci_hc=
d *xhci,
 	}
 }

+static int xhci_port_bw_show(struct seq_file *s, void *unused)
+{
+	struct xhci_hcd		*xhci =3D (struct xhci_hcd *)s->private;
+	unsigned int		num_ports;
+	unsigned int		i;
+	int			ret;
+	u8			bw_table[MAX_HC_PORTS] =3D {0};
+
+	num_ports =3D HCS_MAX_PORTS(xhci->hcs_params1);
+
+	/* get roothub port bandwidth */
+	ret =3D xhci_get_port_bandwidth(xhci, bw_table);
+	if (ret)
+		return ret;
+
+	/* print all roothub ports available bandwidth */
+	for (i =3D 1; i < num_ports+1; i++)
+		seq_printf(s, "port[%d] available bw: %d%%.\n", i, bw_table[i]);
+
+	return ret;
+}
+
+static int bw_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, xhci_port_bw_show, inode->i_private);
+}
+
+static const struct file_operations bw_fops =3D {
+	.open			=3D bw_open,
+	.read			=3D seq_read,
+	.llseek			=3D seq_lseek,
+	.release		=3D single_release,
+};
+
+static void xhci_debugfs_create_bandwidth(struct xhci_hcd *xhci,
+					struct dentry *parent)
+{
+	debugfs_create_file("port_bandwidth", 0644, parent, xhci, &bw_fops);
+}
+
 void xhci_debugfs_init(struct xhci_hcd *xhci)
 {
 	struct device		*dev =3D xhci_to_hcd(xhci)->self.controller;
@@ -681,6 +721,8 @@ void xhci_debugfs_init(struct xhci_hcd *xhci)
 	xhci->debugfs_slots =3D debugfs_create_dir("devices", xhci->debugfs_roo=
t);

 	xhci_debugfs_create_ports(xhci, xhci->debugfs_root);
+
+	xhci_debugfs_create_bandwidth(xhci, xhci->debugfs_root);
 }

 void xhci_debugfs_exit(struct xhci_hcd *xhci)
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 965bffce301e..af1cd4f8ace9 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1867,6 +1867,8 @@ static void handle_cmd_completion(struct xhci_hcd *=
xhci,
 	case TRB_NEC_GET_FW:
 		xhci_handle_cmd_nec_get_fw(xhci, event);
 		break;
+	case TRB_GET_BW:
+		break;
 	default:
 		/* Skip over unknown commands on the event ring */
 		xhci_info(xhci, "INFO unknown command type %d\n", cmd_type);
@@ -4414,6 +4416,18 @@ int xhci_queue_configure_endpoint(struct xhci_hcd =
*xhci,
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
 int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_comma=
nd *cmd,
 		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 45653114ccd7..84092fe981e8 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3088,6 +3088,80 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, str=
uct usb_device *udev)
 }
 EXPORT_SYMBOL_GPL(xhci_reset_bandwidth);

+/* Get the available bandwidth of the ports under the xhci roothub,
+ * including USB 2.0 port and USB 3.0 port.
+ */
+int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 *bw_table)
+{
+	unsigned int		num_ports;
+	unsigned int		i;
+	struct xhci_command	*cmd;
+	dma_addr_t		dma_handle;
+	void			*dma_buf;
+	int			ret;
+	unsigned long		flags;
+	struct device		*dev  =3D xhci_to_hcd(xhci)->self.sysdev;
+
+	num_ports =3D HCS_MAX_PORTS(xhci->hcs_params1);
+
+	cmd =3D xhci_alloc_command(xhci, true, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	dma_buf =3D dma_alloc_coherent(dev, xhci->page_size, &dma_handle,
+					GFP_KERNEL);
+	if (!dma_buf) {
+		xhci_free_command(xhci, cmd);
+		return -ENOMEM;
+	}
+
+	/* get xhci hub usb3 port bandwidth */
+	/* refer to xhci rev1_2 protocol 4.6.15*/
+	spin_unlock_irqrestore(&xhci->lock, flags);
+	ret =3D xhci_queue_get_rh_port_bw(xhci, cmd, dma_handle, USB_SPEED_SUPE=
R,
+					0, false);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		goto out;
+	}
+	xhci_ring_cmd_db(xhci);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	wait_for_completion(cmd->completion);
+
+	/* refer to xhci rev1_2 protocol 6.2.6 , byte 0 is reserved */
+	for (i =3D 1; i < num_ports+1; i++) {
+		if (((u8 *)dma_buf)[i])
+			bw_table[i] =3D ((u8 *)dma_buf)[i];
+	}
+
+	/* get xhci hub usb2 port bandwidth */
+	/* refer to xhci rev1_2 protocol 4.6.15*/
+	spin_unlock_irqrestore(&xhci->lock, flags);
+	ret =3D xhci_queue_get_rh_port_bw(xhci, cmd, dma_handle, USB_SPEED_HIGH=
,
+					0, false);
+	if (ret < 0) {
+		spin_unlock_irqrestore(&xhci->lock, flags);
+		goto out;
+	}
+	xhci_ring_cmd_db(xhci);
+	spin_unlock_irqrestore(&xhci->lock, flags);
+
+	wait_for_completion(cmd->completion);
+
+	/* refer to xhci rev1_2 protocol 6.2.6 , byte 0 is reserved */
+	for (i =3D 1; i < num_ports+1; i++) {
+		if (((u8 *)dma_buf)[i])
+			bw_table[i] =3D ((u8 *)dma_buf)[i];
+	}
+
+out:
+	dma_free_coherent(dev, xhci->page_size, dma_buf, dma_handle);
+	xhci_free_command(xhci, cmd);
+
+	return ret;
+}
+
 static void xhci_setup_input_ctx_for_config_ep(struct xhci_hcd *xhci,
 		struct xhci_container_ctx *in_ctx,
 		struct xhci_container_ctx *out_ctx,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 8c164340a2c3..a137097b0404 100644
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
@@ -1907,6 +1910,10 @@ int xhci_queue_isoc_tx_prepare(struct xhci_hcd *xh=
ci, gfp_t mem_flags,
 int xhci_queue_configure_endpoint(struct xhci_hcd *xhci,
 		struct xhci_command *cmd, dma_addr_t in_ctx_ptr, u32 slot_id,
 		bool command_must_succeed);
+int xhci_queue_get_rh_port_bw(struct xhci_hcd *xhci,
+		struct xhci_command *cmd, dma_addr_t in_ctx_ptr,
+		u8 dev_speed, u32 slot_id, bool command_must_succeed);
+int xhci_get_port_bandwidth(struct xhci_hcd *xhci, u8 *bw_table);
 int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_comma=
nd *cmd,
 		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed);
 int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
--
2.43.4




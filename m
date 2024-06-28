Return-Path: <linux-kernel+bounces-234159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB5991C2F4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2EA1C22942
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DF01C68BB;
	Fri, 28 Jun 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ct79PK2S"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4031C2329;
	Fri, 28 Jun 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719589907; cv=none; b=MVyA1KR66Fe8E05w8ssx4mwqDJQloaiNXtT90IzpMWJqaY6klCRR9juoX9IXdi6LSO2Gngw5lnLy1Qvxr040wrvDM1qhZEG93Oy2T5XCb/Q7QGeqsGsQzwHQb/3kAt7QLUXovhFc46Y/3E8xuQM7WWEztM/mCKZiK7v/cT0tppw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719589907; c=relaxed/simple;
	bh=JZwPPIkhyFRqxAleqe5fNX8WbkaeqPpf7vUxiuYuUaI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eAIReD3Q8qm0aznA9bk8P+L2uWAgn64Qh2iwvc3izRMcEsQJVtPLbwmO+H7tZ8/X4ZuNneisdXMOMtGpfeTMahssXIRN46DG2iRYixskEGQ9tc8uizKhNc3VZtzZsNTSLsjGSALpuNBJIMKo4OqDTFkSkfEYM87ojL3Ikt5BJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ct79PK2S; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=MUygOs7rlNEqd3apO4
	imoIIi+WIT5IxawzxSj+Zc+0M=; b=ct79PK2SJNaKRJxjQD2nSYaUfF/c34APCi
	prGO71lWsXAgoKHLXpL3/gZFDpefn1ewYm3QwmNfFUtK1T//9nK7ckHrr3Yr5DOl
	igqMnDYmildnCmhQev3tNyVL/MoRud1MaWaJLAJJdsRl58GbfbWpydFeQ5xoXie3
	L/fHBtSco=
Received: from localhost.localdomain (unknown [114.92.92.233])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3n7Ly235mondeAw--.10451S2;
	Fri, 28 Jun 2024 23:51:30 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] usb: xhci: Covert to update_device callback returning void
Date: Fri, 28 Jun 2024 08:51:02 -0700
Message-Id: <20240628155103.3585-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3n7Ly235mondeAw--.10451S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryfAFyfKFWDuryfJrW5Wrg_yoW8uw15pF
	Wfua4fKrWUKr43Wr1UZr48Aa1rZw4kA345tryxG34S939Fkw4rKFyDArZ5GayfXrWDCF1a
	qF42grW5C3WUCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_7KIdUUUUU=
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiKAMMq2XAmAMSpwAAsH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

the returned value is ignored, and to improve this situation,
it is proposed to modify the return type of the xhci_update_device()
callback function to void.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/usb/host/xhci.c | 8 +++-----
 include/linux/usb/hcd.h | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 37eb37b0affa..63db4957d3af 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4507,19 +4507,19 @@ static int xhci_set_usb2_hardware_lpm(struct usb_hcd *hcd,
 	return 0;
 }
 
-static int xhci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
+static void xhci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
 {
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct xhci_port *port;
 	u32 capability;
 
 	if (hcd->speed >= HCD_USB3 || !udev->lpm_capable || !xhci->hw_lpm_support)
-		return 0;
+		return;
 
 	/* we only support lpm for non-hub device connected to root hub yet */
 	if (!udev->parent || udev->parent->parent ||
 			udev->descriptor.bDeviceClass == USB_CLASS_HUB)
-		return 0;
+		return;
 
 	port = xhci->usb2_rhub.ports[udev->portnum - 1];
 	capability = port->port_cap->protocol_caps;
@@ -4531,8 +4531,6 @@ static int xhci_update_device(struct usb_hcd *hcd, struct usb_device *udev)
 		if (capability & XHCI_BLC)
 			udev->usb2_hw_lpm_besl_capable = 1;
 	}
-
-	return 0;
 }
 
 /*---------------------- USB 3.0 Link PM functions ------------------------*/
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index ac95e7c89df5..c3fd1643ff1a 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -386,7 +386,7 @@ struct hc_driver {
 		/* Notifies the HCD after a device is connected and its
 		 * address is set
 		 */
-	int	(*update_device)(struct usb_hcd *, struct usb_device *);
+	void	(*update_device)(struct usb_hcd *, struct usb_device *);
 	int	(*set_usb2_hw_lpm)(struct usb_hcd *, struct usb_device *, int);
 	/* USB 3.0 Link Power Management */
 		/* Returns the USB3 hub-encoded value for the U1/U2 timeout. */
-- 
2.17.1



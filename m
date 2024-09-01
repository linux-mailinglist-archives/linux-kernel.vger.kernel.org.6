Return-Path: <linux-kernel+bounces-310290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A75929677E8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361641F2190E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF4A183CC2;
	Sun,  1 Sep 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WpkoZhaa"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2E2143894;
	Sun,  1 Sep 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725207932; cv=none; b=bF7Q8CURtVnR5VWkU9MeVkt8ZL/997v9ylA+cqqKAqXFH4oulzrGJ38ejxRLuPum3s9kVq1anjx6MxYPe6iHHufY4ldaEb4/RGSjmJfH+Y59Tz9cU876xYOHYDj+YmJ9iQyY052amPAmPRNPIy0//eIZoG6jrS0gb+K1yWS7XPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725207932; c=relaxed/simple;
	bh=3Mj6ijRTEP3d5AnaV0LktCCKBKb4f1wkpToEYFw8SjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eBtSTM35mOhkRH6V0SF/F1Et4TSaT+zJVj9P2/mja8/9473ZxZLEHXBRtx99tjsEyC2ALxjzbyONn+JgXMQjmMsbVPBd9txfTR9idGqBiNy7+dq1Z6uMlLdZXenlW7HJ/Onk9u7swMsYnF0QJ2dYw2OtdoXZBZOLasyTLJ+gd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WpkoZhaa; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DgpRk
	EVaxYPqJS1SPvfN+U+2xNOaGMTcZtuiECOYSgY=; b=WpkoZhaaIdOXVereO/pX1
	nSCp4eLA5rOp20stL+CxtI4OwwghATqJjeTgddmjA0184LifwCwJtYUbQW/nElDe
	h2otGD20dPDVuBmb40ZqhwW6BgG5cVA0U0JgfZa6RMcrNz5gTG9HYLiMM86HlS3J
	/kfqwoI7qLsHboIyTwiNiE=
Received: from localhost.localdomain (unknown [111.35.190.113])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wBHZhU6ldRmT8x5Kg--.41103S4;
	Mon, 02 Sep 2024 00:24:46 +0800 (CST)
From: David Wang <00107082@163.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH] usb: xhci: wait for controller ready when resume with reinit_xhc
Date: Mon,  2 Sep 2024 00:24:25 +0800
Message-Id: <20240901162425.5103-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHZhU6ldRmT8x5Kg--.41103S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF18tw17WryDAFyUtr15CFg_yoW8XF4DpF
	4akr4UGF1rta1fKF1qyay2ya4rGasIq398XFZrC34a9rZrt345WryUtrW3Ja9rWrWfGr48
	tF40qay5KF12qF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqRNNqmVOClTVCQAAs0

When resume system with reinit_xhc true, PM would report kernel
warning about device parent:

 >usb 3-1.1: reset high-speed USB device number 4 using xhci_hcd
 >..
 >ep_81: PM: parent 3-1.1:1.1 should not be sleeping

Move the code waiting for controller ready out, and make it
carry out work no matter reinit_xhc is true or false.
The error is ignored when reinit_xhc is true.

Signed-off-by: David Wang <00107082@163.com>
---
 drivers/usb/host/xhci.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index efdf4c228b8c..8aeb1b34cdbf 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1032,13 +1032,15 @@ int xhci_resume(struct xhci_hcd *xhci, pm_message_t msg)
 	if (hibernated || xhci->quirks & XHCI_RESET_ON_RESUME || xhci->broken_suspend)
 		reinit_xhc = true;
 
+	/*
+	 * Some controllers might lose power during suspend, so wait
+	 * for controller not ready bit to clear, just as in xHC init.
+	 * Ignore retval if reinit_xhc is true, since the device would
+	 * be reinited.
+	 */
+	retval = xhci_handshake(&xhci->op_regs->status,
+				STS_CNR, 0, 10 * 1000 * 1000);
 	if (!reinit_xhc) {
-		/*
-		 * Some controllers might lose power during suspend, so wait
-		 * for controller not ready bit to clear, just as in xHC init.
-		 */
-		retval = xhci_handshake(&xhci->op_regs->status,
-					STS_CNR, 0, 10 * 1000 * 1000);
 		if (retval) {
 			xhci_warn(xhci, "Controller not ready at resume %d\n",
 				  retval);
-- 
2.39.2



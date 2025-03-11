Return-Path: <linux-kernel+bounces-555662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A123EA5BAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4153AE8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C6122577E;
	Tue, 11 Mar 2025 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MAF5BcII"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD0223704;
	Tue, 11 Mar 2025 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741682521; cv=none; b=lyd9EpM+Ya73J5m52l2UVl72L2/CoZwCXsui2e2ywzYYqHv8Op+L4HyDjX0a9VYLSynBLE/7X+lMH9iLbCN9b7DCrDbkGcwYt/LJRaw2zhasBj0acahbUOQfHvFWgF9I3UyouZKifQcU/6d7Bdn7yIfntkansTM4onFWs/qZegc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741682521; c=relaxed/simple;
	bh=1nrLmnGlm1+0YYFQ6DxqrnnhJZkHgndItSvq7Q+Cjnw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MWOr0Mfq3ab4NYyq/zn9LHPX7yuB5wBOqZtAXcwiOpkNfsHQAHSv1oQe4+41A2J7l4Tg0HsoXTXyp14Frpp0Afn9p4kqKDeAW4K0xUnUtLQFOXkYzWnfugzmE3U+rLUUrsUqtaFUsTYYTtYhYARpjjPTY3eQrMSSPDSK52wBEis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MAF5BcII; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=o+FJF
	a5kaj7HLyvn685I1Z/X9V0EfvMQq597XWpW6uI=; b=MAF5BcIIFECKGLeW2TjsT
	hVoos6jT8K2WOERLHASzg6y0xVaSQSGH31p6SYJJB9CL3wUTFxeLs6w3pZcKl7MM
	Fe2ZNGenZ+8OePZH/HqjDPx1X9b4S6axlPAcjA3h23EYmJLn9fHbtvI58OEXjztH
	6h+WwdpbZsk6RPtCjrZkK8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAH3uJJ989nKrBDRA--.23607S2;
	Tue, 11 Mar 2025 16:41:47 +0800 (CST)
From: Xin Dai <daixin_tkzc@163.com>
To: stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Xin Dai <daixin_tkzc@163.com>
Subject: [PATCH] usb: storage: Fix `us->iobuf` size for BOT transmission to prevent memory overflow
Date: Tue, 11 Mar 2025 16:41:11 +0800
Message-Id: <20250311084111.322351-1-daixin_tkzc@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH3uJJ989nKrBDRA--.23607S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy7trWrtF1kAFyxGr1DAwb_yoW8tF18pF
	WYgFZ0yryDXFWS9r17Ww40vFyrXasxJry7K3ykt3s8ZFs8Ca48Wr17tFyYqa4xGr1fu3WF
	vrn09ryUWF1DXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ptjgo8UUUUU=
X-CM-SenderInfo: xgdl5xpqbwy6rf6rljoofrz/xtbB0hUN1WfP7sX50QAAs0

When the DWC2 controller detects a packet Babble Error, where a device
transmits more data over USB than the host controller anticipates for a
transaction. It follows this process:

1. The interrupt handler marks the transfer result of the URB as
   `OVERFLOW` and returns it to the USB storage driver.
2. The USB storage driver interprets the data phase transfer result of
   the BOT (Bulk-Only Transport) as `USB_STOR_XFER_LONG`.
3. The USB storage driver initiates the CSW (Command Status Wrapper)
   phase of the BOT, requests an IN transaction, and retrieves the
   execution status of the corresponding CBW (Command Block Wrapper)
   command.
4. The USB storage driver evaluates the CSW and finds it does not meet
   expectations. It marks the entire BOT transfer result as
   `USB_STOR_XFER_ERROR` and notifies the SCSI layer that a `DID_ERROR`
   has occurred during the transfer.
5. The USB storage driver requests the DWC2 controller to initiate a
   port reset, notifying the device of an issue with the previous
   transmission.
6. The SCSI layer implements a retransmission mechanism.

In step 3, the device remains unaware of the Babble Error until the
connected port is reset. We observed that the device continues to send
512 bytes of data to the host (according to the BBB Transport protocol,
it should send only 13 bytes). However, the USB storage driver
pre-allocates a default buffer size of 64 bytes for CBW/CSW, posing a
risk of memory overflow. To mitigate this risk, we have adjusted the
buffer size to 512 bytes to prevent potential errors.

Signed-off-by: Xin Dai <daixin_tkzc@163.com>
---
 drivers/usb/storage/usb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/usb.h b/drivers/usb/storage/usb.h
index 97c6196d639b..fd8dcb21137a 100644
--- a/drivers/usb/storage/usb.h
+++ b/drivers/usb/storage/usb.h
@@ -71,7 +71,7 @@ struct us_unusual_dev {
  * size we'll allocate.
  */

-#define US_IOBUF_SIZE		64	/* Size of the DMA-mapped I/O buffer */
+#define US_IOBUF_SIZE		512	/* Size of the DMA-mapped I/O buffer */
 #define US_SENSE_SIZE		18	/* Size of the autosense data buffer */

 typedef int (*trans_cmnd)(struct scsi_cmnd *, struct us_data*);
--
2.34.1



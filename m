Return-Path: <linux-kernel+bounces-289122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C54DF954244
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66FAD1F26DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD412D1F1;
	Fri, 16 Aug 2024 07:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNzz7w8O"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D599884DE0;
	Fri, 16 Aug 2024 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791753; cv=none; b=f9kfxu6ZSKX1Y98hxKzGuL5jIuk5tK+UzOh1JSLnjsG3tfggvuV16YQJRaHXkllmNrU+eDAZno9zZ5tWr1mJanV2NAzdApFNxnlN2Ra0EVvoq8EXjtYVzURikIDnj6U/Ly+kV8sp2ltDkTrfdOtY0/8LR6eyyUrL/jOTAcDvbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791753; c=relaxed/simple;
	bh=+w3tRthZvWrQuTTEoJc8T4rZ0JkdZdeQr+FlQQMqwVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KwvWeBL53YhknR8fZFKjIQjPSFG6Ilfrbc72wOu51P7lUGNPmxLdARnuSHPPw1TTRERK4UQ9TrxutRXeP6znM0JzaK9tt902jdZwUnKQVr12RXSCIz6NLYQ/bCh5PPLrI6ITo90stmP3pHCnYUZ28u6HYZvC0o2e9lOcle3GY/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNzz7w8O; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7d2a9a23d9so204651466b.3;
        Fri, 16 Aug 2024 00:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723791749; x=1724396549; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GZMDCEhoVOuknhSdiXjCTkP9a56QRYdberqLBhqK2gs=;
        b=UNzz7w8OzHMHT5fbMbIbQM+/oZFdMn6sWo3WT32KRtV2wvoYqq+CsxhtUUtGfL4FQV
         +OjTYmdgtxD5DYogX3ShCwWEOVeo+jX3F1j1O4qukjou+iIVq6bZlDYkWUXEQdxGUqVR
         Sjo32wPTw7ObMgl2tEQT6FaTOr/5z2H81WLBSTYDG7ZH5MrVTjKYbTZ845InzUFa3TLx
         i5kH7GKSk/93/bMTzYm0aDEwbCJLHA8oaiS9QQ8dbSqn65bza64ebG1gz/+V0Owi5mCK
         b6iWsjz8jxH8qGprNsfyz9BMc35W7pZzgDw+nTmkJTjAuozQP8316n7Zb960jrMpSdGl
         /Z1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723791749; x=1724396549;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZMDCEhoVOuknhSdiXjCTkP9a56QRYdberqLBhqK2gs=;
        b=WC3xfasM99ucEagiIxNXYfps3GlyOUBB6naVyFAPjiX7Po3LhZy/B7CTvahZbtF5rJ
         xUh6FL5Nwjnu5AtUeYfrpXlO0twy6kwz+uzq08Yhb1vx8v8xod1cjyIbmQD07R3m9duk
         paO7Q2pBycDGiP01M8DW7Tc2vSWdOc5zbG2hrEjdyeaoj5WpdEItXwu6LV/veJnVmme/
         RfV0DNWUGDzVtnnkqrFhw3L/OW+DziC8c1oAl+cFOApLVToVLGzh5933Op/k5QSUWRU2
         p8cGHE4xxCwzryHpLC02Uh15PqRDSNLgNyu8wPD8aYe4hEGPaFWFZKie4NJ4/IRsHi7Z
         r0OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrt3H7RpmsmZMxfUEMLXp+itMLZbMolWIEu/O2ISrar43t1KG5JEPJ/GsxYW2WVhic5jh0/Tk1cWCC9FKZK1SY9F5JKqpvK+BbJiEJVVAOc8Jvyg0qqWOkq2fv+8xn53ZnyXWqd/1v
X-Gm-Message-State: AOJu0YyUuHcuRrnrsg2saRbtOQFV0oHpJLs7tECSu7kRy7vF0Yo2GyPj
	ylYTCufR+IZob+sehxfdHG+EZUJSLIM+X6N0AQbjddAmiJbxfJcq
X-Google-Smtp-Source: AGHT+IHuKHZL6Q60fzk/5S9Wx9QG+3SjjigqZzGnpXC6yZ/4Upm7Fc6nLcw90WH0PMEILuX40qhDwQ==
X-Received: by 2002:a17:907:c7dc:b0:a6f:8265:8f2 with SMTP id a640c23a62f3a-a8392955fcemr153297166b.37.1723791748773;
        Fri, 16 Aug 2024 00:02:28 -0700 (PDT)
Received: from localhost (85.64.140.6.dynamic.barak-online.net. [85.64.140.6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839471cbsm210163166b.180.2024.08.16.00.02.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2024 00:02:28 -0700 (PDT)
From: Eli Billauer <eli.billauer@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Eli Billauer <eli.billauer@gmail.com>
Subject: [PATCH 2/2] char: xillybus: Check USB endpoints when probing device
Date: Fri, 16 Aug 2024 10:02:00 +0300
Message-Id: <20240816070200.50695-2-eli.billauer@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240816070200.50695-1-eli.billauer@gmail.com>
References: <20240816070200.50695-1-eli.billauer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Ensure, as the driver probes the device, that all endpoints that the
driver may attempt to access exist and are of the correct type.

All XillyUSB devices must have a Bulk IN and Bulk OUT endpoint at
address 1. This is verified in xillyusb_setup_base_eps().

On top of that, a XillyUSB device may have additional Bulk OUT
endpoints. The information about these endpoints' addresses is deduced
from a data structure (the IDT) that the driver fetches from the device
while probing it. These endpoints are checked in setup_channels().

A XillyUSB device never has more than one IN endpoint, as all data
towards the host is multiplexed in this single Bulk IN endpoint. This is
why setup_channels() only checks OUT endpoints.

Reported-by: syzbot+eac39cba052f2e750dbe@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/0000000000001d44a6061f7a54ee@google.com/T/
Fixes: a53d1202aef1 ("char: xillybus: Add driver for XillyUSB (Xillybus variant for USB)").
Signed-off-by: Eli Billauer <eli.billauer@gmail.com>
---
 drivers/char/xillybus/xillyusb.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
index e12d359194f8..45771b1a3716 100644
--- a/drivers/char/xillybus/xillyusb.c
+++ b/drivers/char/xillybus/xillyusb.c
@@ -1903,6 +1903,13 @@ static const struct file_operations xillyusb_fops = {
 
 static int xillyusb_setup_base_eps(struct xillyusb_dev *xdev)
 {
+	struct usb_device *udev = xdev->udev;
+
+	/* Verify that device has the two fundamental bulk in/out endpoints */
+	if (usb_pipe_type_check(udev, usb_sndbulkpipe(udev, MSG_EP_NUM)) ||
+	    usb_pipe_type_check(udev, usb_rcvbulkpipe(udev, IN_EP_NUM)))
+		return -ENODEV;
+
 	xdev->msg_ep = endpoint_alloc(xdev, MSG_EP_NUM | USB_DIR_OUT,
 				      bulk_out_work, 1, 2);
 	if (!xdev->msg_ep)
@@ -1932,14 +1939,15 @@ static int setup_channels(struct xillyusb_dev *xdev,
 			  __le16 *chandesc,
 			  int num_channels)
 {
-	struct xillyusb_channel *chan;
+	struct usb_device *udev = xdev->udev;
+	struct xillyusb_channel *chan, *new_channels;
 	int i;
 
 	chan = kcalloc(num_channels, sizeof(*chan), GFP_KERNEL);
 	if (!chan)
 		return -ENOMEM;
 
-	xdev->channels = chan;
+	new_channels = chan;
 
 	for (i = 0; i < num_channels; i++, chan++) {
 		unsigned int in_desc = le16_to_cpu(*chandesc++);
@@ -1968,6 +1976,15 @@ static int setup_channels(struct xillyusb_dev *xdev,
 		 */
 
 		if ((out_desc & 0x80) && i < 14) { /* Entry is valid */
+			if (usb_pipe_type_check(udev,
+						usb_sndbulkpipe(udev, i + 2))) {
+				dev_err(xdev->dev,
+					"Missing BULK OUT endpoint %d\n",
+					i + 2);
+				kfree(new_channels);
+				return -ENODEV;
+			}
+
 			chan->writable = 1;
 			chan->out_synchronous = !!(out_desc & 0x40);
 			chan->out_seekable = !!(out_desc & 0x20);
@@ -1977,6 +1994,7 @@ static int setup_channels(struct xillyusb_dev *xdev,
 		}
 	}
 
+	xdev->channels = new_channels;
 	return 0;
 }
 
-- 
2.17.1



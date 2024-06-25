Return-Path: <linux-kernel+bounces-228415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6544915FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441D92849E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6341494DE;
	Tue, 25 Jun 2024 07:08:30 +0000 (UTC)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE58146A61;
	Tue, 25 Jun 2024 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299309; cv=none; b=BIxIWy3WnY7SvmdQbwA+iBhhrwDinhyyepnJvew764t52XkMghOiEPvSJoiDMqBwASFlDZVts9TG8PTGyWPhSYyIFSwb+fATuntgjluP5XPOjxAnYTElo/MSuOphnVwi+LHtRoUWKPcxOp1rNLWcfFHYRuCLUVFxskAgedZRT0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299309; c=relaxed/simple;
	bh=jAhgjQFN+adi60g26UrrBz1dnQ/ZYDx4EBX/2olRQIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QUTJq1HZrjlFcc1mkcq3ssXobArjOyoTxQw9lwyXwOrCBAUxmRPgWH+RRhvvPScyM4lpAUQzwnnfCAxzbQlvyoB0B/W0hv6dk/4VNPlXG1NXkjyWShOwsnYif78hEjdkrJPfJr0+TcdO8vZrpXwEFOPdrBtoEkmMyRKnbPyGWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp81t1719299249tfmqd336
X-QQ-Originating-IP: YsTpw8TXEcRnmEuuIyqSvNkkmr5rT8eEDSQNnxCh5hw=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 25 Jun 2024 15:07:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1584190134348375892
From: tuhaowen <tuhaowen@uniontech.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	wangyuli@uniontech.com,
	tuhaowen <tuhaowen@uniontech.com>
Subject: [PATCH] drv/usb: Fix the issue with Realtek USB wireless adapter AC650
Date: Tue, 25 Jun 2024 15:07:24 +0800
Message-Id: <20240625070724.22044-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Due to the dual-mode functionality of the Realtek USB wireless
adapter AC650, it initially presents itself as a flash drive
before the driver is installed.

In Linux, multi-state devices are recognized as storage devices
on startup because the driver has not yet been loaded.

As a result, the AC650 is identified as a DISK device at boot,
preventing the use of its WLAN mode. The issue can only be
resolved by unplugging and replugging the adapter.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 drivers/usb/storage/unusual_devs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index fd68204374f2..f660d3e52436 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1487,6 +1487,12 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_WP_DETECT ),
 
+UNUSUAL_DEV(0x0bda, 0x1a2b, 0x0000, 0x9999,
+		"Realtek",
+		"USB Network Device",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE),
+
 UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x9999,
 		"Maxtor",
 		"USB to SATA",
-- 
2.20.1



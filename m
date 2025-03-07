Return-Path: <linux-kernel+bounces-551438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FDA56C63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93480165210
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6B121D58F;
	Fri,  7 Mar 2025 15:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6x5hrqv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA218DB09;
	Fri,  7 Mar 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362265; cv=none; b=UnktEPxNMDvIkv9vjla8wnAUt8o1uWKBBi1M9OnR5b/HwGcXBsRzGb14lwv85/3RnmowP2QYLi4VXbn6GgiQAyaZIfym/JxRIUKXYXHbCJv36p95MkkOFzQzuLhae/Yfx9PIAoOUrbhTC5melMDZQYWkxqY5mmZ+BZnl8EZn2uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362265; c=relaxed/simple;
	bh=4d4YhX86AxePC24DFJMicsIc618HFk7dC28ZbtPJuM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N+GysHzJb/5CIs2bDeIPMqkHHesUvTxbwWM5Aa1liYjVim6CthVhECRJVgHvYw/j2AU6bCLGyLge4fzGxjvq+wTUY28HRX34FbF1uX1ehFCXUelTxqZjGX5L59FJxFmSGgiyvGS2vXdHvva7B7K4qVsr8KSAnmGtEz3tVxH1p3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6x5hrqv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741362264; x=1772898264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4d4YhX86AxePC24DFJMicsIc618HFk7dC28ZbtPJuM4=;
  b=Z6x5hrqv+VVFVv2i5xR1pIFyPxAt1oUyAHYKy+muTCXAOu90LiGO6TRl
   8rPvO4UXWOtS0mG8o3VDCfNjlqdruVdeLmTcByPhb+2crF7zFTdseBKay
   Iz8p0l4ZMMAWlYWmG5gRlTSBC7U8Xk1ne3CQ3JjKUq+p209JXfJv0S5Io
   nT12ROG2GIhQUI+b+xzjIo7O+n32Ey4LqCwSrNfGgjsgbDMuh6XndvU4Y
   LCBOFgQuU7tUzsp2W/XQD2DfPPVyPG6BmH+FGB7xBlGo0qdyvq72IMouL
   2YRRYMhVBixoTgtnyZoG00S1Ii/aGaZ4a6ecr2tQ/wTahCd2+vp5FSQ4Q
   g==;
X-CSE-ConnectionGUID: QU4dACmITN68QB8ge7iCNQ==
X-CSE-MsgGUID: 9iQFZpCeRfa4IImYPTrRWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="59970455"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="59970455"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 07:44:23 -0800
X-CSE-ConnectionGUID: ijITPfdvTzyhioCdygfWow==
X-CSE-MsgGUID: nFHE9sfuQiWLv6tsSuMgwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="124443993"
Received: from apgcp0h572501.png.altera.com ([10.244.73.227])
  by fmviesa004.fm.intel.com with ESMTP; 07 Mar 2025 07:44:21 -0800
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v2] USB: serial: ftdi_sio: add support for Altera USB Blaster 3
Date: Fri,  7 Mar 2025 23:43:55 +0800
Message-Id: <20250307154355.30772-1-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Altera USB Blaster 3, available as both a cable and an on-board
solution, is primarily used for programming and debugging FPGAs.

It interfaces with host software such as Quartus Programmer,
System Console, SignalTap, and Nios Debugger. The device utilizes
either an FT2232 or FT4232 chip.

Enabling support for various configurations of the USB Blaster 3
by including the appropriate VID/PID pairs, allowing it to function
as a serial device via ftdi_sio. The configurations are determined
by the hardware design and include:

1) PID 0x6020, FT2232, 1 JTAG port
2) PID 0x6021, FT2232, 2 JTAG ports
3) PID 0x6022, FT2232, 1 JTAG port + Port B as UART
4) PID 0x6023, FT2232, Cable USB-Blaster 3
5) PID 0x6024, FT4232, 1 JTAG port
6) PID 0x6025, FT4232, 1 JTAG port + Port C as UART
7) PID 0x6026, FT4232, 1 JTAG port + Port C, D as UART
8) PID 0x602e, FT4232, 1 JTAG port + Port B, C, D as UART

These configurations allow for flexibility in how the
USB Blaster 3 is used, depending on the specific needs of the
hardware design.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
---
 drivers/usb/serial/ftdi_sio.c     | 14 ++++++++++++++
 drivers/usb/serial/ftdi_sio_ids.h | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index e07c5e3eb18c..9b34e23b7091 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1079,6 +1079,20 @@ static const struct usb_device_id id_table_combined[] = {
 		.driver_info = (kernel_ulong_t)&ftdi_jtag_quirk },
 	/* GMC devices */
 	{ USB_DEVICE(GMC_VID, GMC_Z216C_PID) },
+	/* Altera USB Blaster 3 */
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6022_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6025_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6026_PID, 3) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_6029_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602A_PID, 3) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602C_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602D_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 1) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 2) },
+	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 5ee60ba2a73c..52be47d684ea 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -1612,3 +1612,16 @@
  */
 #define GMC_VID				0x1cd7
 #define GMC_Z216C_PID			0x0217 /* GMC Z216C Adapter IR-USB */
+
+/*
+ *  Altera USB Blaster 3 (http://www.altera.com).
+ */
+#define ALTERA_VID			0x09fb
+#define ALTERA_UB3_6022_PID		0x6022
+#define ALTERA_UB3_6025_PID		0x6025
+#define ALTERA_UB3_6026_PID		0x6026
+#define ALTERA_UB3_6029_PID		0x6029
+#define ALTERA_UB3_602A_PID		0x602a
+#define ALTERA_UB3_602C_PID		0x602c
+#define ALTERA_UB3_602D_PID		0x602d
+#define ALTERA_UB3_602E_PID		0x602e
-- 
2.25.1



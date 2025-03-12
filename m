Return-Path: <linux-kernel+bounces-557181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64441A5D49E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAB303B87C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37519CD07;
	Wed, 12 Mar 2025 03:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NUn/17+6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630A379EA;
	Wed, 12 Mar 2025 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748806; cv=none; b=qB2ahs52Kdl6DpmfvdlZQDgzEVaP8m5abI0xCSpVdvYKErHABcTN+Wl2GzNy/9oqh3IjDBm75XrOL1mserVeXj06aFBfSuNVAVP+RcNTzeivzyA225JMPn0NspcBM0o4Hy4mWPbrtZtLwmfaSCF2MPdPX9XN29ZClJQE5rjFomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748806; c=relaxed/simple;
	bh=cE3Lg4wiMp/bYX9sJx/WM2EsltMUHJc2wAE1pJn/KRY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kch3KhSzNQ506xdnIgPgctQlQS33yU0N2GnJTdY3SXbjQyZqZvOK+8MbEC1GNZtY7+F4E3oUtnMjGu1Q5pCBGqhFVeoLFR4PoNnuytjOlGz1a6KZg4nlCSpdD83CcI9oXEZ0BrrIP3oxpyKZGHgj2xgSgX8Nz2ogwLkWGc1bAXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUn/17+6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741748804; x=1773284804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cE3Lg4wiMp/bYX9sJx/WM2EsltMUHJc2wAE1pJn/KRY=;
  b=NUn/17+6jHTyjXQgc0kkPLYsEDwP4urqUHz4DmZwhoEapPfmSc9+3Om7
   V6J17tCHcEcFmghUnvXzPqejOyKRk3DTSyEv5zAcGS3XlOsLTXwrKCDqh
   IutvWgtIJ/jy/T+pGk/Nqew/6UMAP41BDfzN4PqOFN8w+ZJ6iYpZKmuSj
   pT2DrNjag6G/mWEAbaRpktwoOwsBHARa2X1j4nk++kkcx0BKPZluW2qhx
   1mkObfscqnGfErBW6ztrYMzX95lln5EI1J0ngtb7TaipIuv8RWgkS+boy
   N/Pv5Ddgx6FcO4TRfK6EzWsygouxjB1zlCscZRJVWC+LEnJHNnNXgJw1x
   A==;
X-CSE-ConnectionGUID: 1w8Ghp/9RR2rIirHzR55vw==
X-CSE-MsgGUID: BWhQVu5ATj2+PBXHa3Xw9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43018874"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="43018874"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 20:06:43 -0700
X-CSE-ConnectionGUID: Y8TqGRjXSoOQZr7as5sCcA==
X-CSE-MsgGUID: ipu5uyMxSwKzcjv+OK3lCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120528479"
Received: from apgcp0h572501.png.altera.com ([10.244.73.227])
  by fmviesa007.fm.intel.com with ESMTP; 11 Mar 2025 20:06:42 -0700
From: Boon Khai Ng <boon.khai.ng@intel.com>
To: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
Cc: Boon Khai Ng <boon.khai.ng@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>,
	Boon Khai Ng <boon.khai.ng@intel.com>
Subject: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB Blaster 3
Date: Wed, 12 Mar 2025 11:05:44 +0800
Message-Id: <20250312030544.4967-1-boon.khai.ng@intel.com>
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

Enabling the support for various configurations of the on-board
USB Blaster 3 by including the appropriate VID/PID pairs,
allowing it to function as a serial device via ftdi_sio.

Note that this check-in does not include support for the
cable solution, as it does not support UART functionality.
The supported configurations are determined by the
hardware design and include:

1) PID 0x6022, FT2232, 1 JTAG port (Port A) + Port B as UART
2) PID 0x6025, FT4232, 1 JTAG port (Port A) + Port C as UART
3) PID 0x6026, FT4232, 1 JTAG port (Port A) + Port C, D as UART
4) PID 0x6029, FT4232, 1 JTAG port (Port B) + Port C as UART
5) PID 0x602a, FT4232, 1 JTAG port (Port B) + Port C, D as UART
6) PID 0x602c, FT4232, 1 JTAG port (Port A) + Port B as UART
7) PID 0x602d, FT4232, 1 JTAG port (Port A) + Port B, C as UART
8) PID 0x602e, FT4232, 1 JTAG port (Port A) + Port B, C, D as UART

These configurations allow for flexibility in how the USB Blaster 3 is
used, depending on the specific needs of the hardware design.

---

v3: Updated PID table.

PID table in the commit message in v2 missmatched with the PID macro
defined in the header file, updated the correct table in v3.

---

v2: Update commit message, added PID table, updated the macro name

Updated the commit message to include more information about the
background of what is this change about. Added the PID table to
clarify that the PID associated to the specific hardware configuration
Updated the macro name in header file from ALTR to ALTERA and also
the VID's macro name to ALTERA_VID

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



Return-Path: <linux-kernel+bounces-320348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C35B97092A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 20:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820461F21DF2
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 18:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49A176AAF;
	Sun,  8 Sep 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrRO9XbF"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D89165F06
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725819024; cv=none; b=KbcPCQepB5yiu28ARQuOcyDF6nizB8Yv4+FbX3BUcfa7MDv2EixvPEI5+oWSbVau2eT5EJj0zYTUVMkM+8PHaA/Q3ICrY4Z4vtuxHFefs9A0qJowauD2JriES9YX7CUeXuoP+VDRhvB422IXrpzqOlUvIuVRBfNlJ9C7PgdA9os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725819024; c=relaxed/simple;
	bh=3pkGKpnps9BRZYFTTIc/uwOCzJXREVREtCLzMWazsNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TCDpVaPb5KCapmjiNjKhkL/RldDH3yFJBnXwaoWFVRDxhZlEtjAoLvifjg3aWtGr0c+G2u6050062COQgi8BPtbVldtQ3B4RHYm9ubQTrwp2j/qtxilt23k213yj7pKJoX8tH4EbbD6BRixsaNBkZLKUgMXy1au4HQWvJAKkPxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QrRO9XbF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718d962ad64so2156837b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725819022; x=1726423822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ar6XzATEWGm9OHxBFH6LESh/+hr+qtyBbKtC4UJ6nYM=;
        b=QrRO9XbF5InAf5uKoDkOk8M+9mx7vFH3zE+vETWvuctC40kTUqqbBJfk0eVNyizh8R
         mbusOrGpVaUbFCmYUbsuWlrUxbxkPqJuy7G07MZtiZfcnZDeDYUcOO3JW6rehxLNyS6J
         acmyEcPlKIkOJ/PK4547RNV7CWaoVfRUD8x4w1gNRMAR+tbNsPBBH3K+EUXslZ0tkwU1
         /zAavrKea3iJdO3wPuaK81OL4AutAadyJ4ydimGbrOJJivqFQISkl3MBEi3JhkG4Aoh8
         G36Oi3nJ2z3+R+6ZADkbCriSR8yXfTCu9/d0ej8eVzWPemK6ffPimSG5lLQoRUFPNsLy
         H7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725819022; x=1726423822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ar6XzATEWGm9OHxBFH6LESh/+hr+qtyBbKtC4UJ6nYM=;
        b=YN3SnpSdjLTxoiYjbwx9xKkrNbK5tyYarM8bdjBz+RBklVLRNB3NpOBVvZ+UC1ZaCp
         KjMBjIarSDTWDsTr+oE6nhgTmAPpXTXalY/TMP1Hoe8RR6IP5m2x2WVbaF9vGjTsyzZS
         6sdd/3kaysF7X6kXd9cCxHVUe5PiCD+B+aNJZIn3aR85tSRgD1rBMI/5o4NuvXBQodtk
         5czbwJrz00W+YoAsi1HTNP60IEJCtIEwzx/QPULS2hY3/yQLV/hkGBwp9g+A8xbzrUkV
         oydAeQ+UqDL44atO1aftPC8fQ8rztGCRQuG1oOyHXZxmm4GoCgCp92gTN+qyZHS4aI0a
         4+nA==
X-Forwarded-Encrypted: i=1; AJvYcCUvf0dFw41bbsVum8gygWFztVXoQYwQyOLIPWbUOL3yIXMnbVQvdEa93geIA4cQOgo+aNMqsQDoUsjfQX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/K+n3B+08HSOdHqJzvWZx+aFdXB9bc8MtGhA7OXUp+4setmu
	z7it5sbKZhjGvebqSMIEaI1WyASrp7S8a/Jc/Rk4yFeQi0R/+Renwmg3GAh8zbM=
X-Google-Smtp-Source: AGHT+IFojJtbBA7n99nPrVY+xntXWkLZS3SZDBpXDq21nzUN1RbLsMOWEgz+7t+o4Zu6RIAB+RTWZw==
X-Received: by 2002:a05:6a00:b42:b0:714:2069:d90e with SMTP id d2e1a72fcca58-718d5f0839amr12084718b3a.26.1725819021981;
        Sun, 08 Sep 2024 11:10:21 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5896f19sm2278769b3a.32.2024.09.08.11.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 11:10:21 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	sayyad.abid16@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Fix tabs for indent and + in comment blocks
Date: Sun,  8 Sep 2024 23:39:03 +0530
Message-Id: <20240908180902.3196764-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the use of space instead of tabs,
removes trailing space and adds "+" each line in a comment block.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 .../staging/rtl8723bs/include/hal_pwr_seq.h   | 46 +++++++++----------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
index 5e43cc89f535..10fef1b3f393 100644
--- a/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
+++ b/drivers/staging/rtl8723bs/include/hal_pwr_seq.h
@@ -5,26 +5,26 @@
 #include "HalPwrSeqCmd.h"

 /*
-	Check document WM-20130815-JackieLau-RTL8723B_Power_Architecture v08.vsd
-	There are 6 HW Power States:
-	0: POFF--Power Off
-	1: PDN--Power Down
-	2: CARDEMU--Card Emulation
-	3: ACT--Active Mode
-	4: LPS--Low Power State
-	5: SUS--Suspend
-
-	The transition from different states are defined below
-	TRANS_CARDEMU_TO_ACT
-	TRANS_ACT_TO_CARDEMU
-	TRANS_CARDEMU_TO_SUS
-	TRANS_SUS_TO_CARDEMU
-	TRANS_CARDEMU_TO_PDN
-	TRANS_ACT_TO_LPS
-	TRANS_LPS_TO_ACT
-
-	TRANS_END
-*/
+ *	Check document WM-20130815-JackieLau-RTL8723B_Power_Architecture v08.vsd
+ *	There are 6 HW Power States:
+ *	0: POFF--Power Off
+ *	1: PDN--Power Down
+ *	2: CARDEMU--Card Emulation
+ *	3: ACT--Active Mode
+ *	4: LPS--Low Power State
+ *	5: SUS--Suspend
+ *
+ *	The transition from different states are defined below
+ *	TRANS_CARDEMU_TO_ACT
+ *	TRANS_ACT_TO_CARDEMU
+ *	TRANS_CARDEMU_TO_SUS
+ *	TRANS_SUS_TO_CARDEMU
+ *	TRANS_CARDEMU_TO_PDN
+ *	TRANS_ACT_TO_LPS
+ *	TRANS_LPS_TO_ACT
+ *
+ *	TRANS_END
+ */
 #define	RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS	26
 #define	RTL8723B_TRANS_ACT_TO_CARDEMU_STEPS	15
 #define	RTL8723B_TRANS_CARDEMU_TO_SUS_STEPS	15
@@ -101,7 +101,7 @@
 	{0x0007, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0x20}, /*0x07 = 0x20 , SOP option to disable BG/MB*/	\
 	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK|PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, BIT3}, /*0x04[12:11] = 2b'01 enable WL suspend*/	\
 	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT2, BIT2}, /*0x04[10] = 1, enable SW LPS*/	\
-        {0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 1}, /*0x48[16] = 1 to enable GPIO9 as EXT WAKEUP*/   \
+	{0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 1}, /*0x48[16] = 1 to enable GPIO9 as EXT WAKEUP*/   \
 	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, BIT4}, /*0x23[4] = 1b'1 12H LDO enter sleep mode*/   \
 	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, BIT0}, /*Set SDIO suspend local register*/	\
 	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, 0}, /*wait power state to suspend*/
@@ -112,7 +112,7 @@
 	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3 | BIT7, 0}, /*clear suspend enable and power down enable*/	\
 	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_WRITE, BIT0, 0}, /*Set SDIO suspend local register*/	\
 	{0x0086, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_SDIO, PWR_CMD_POLLING, BIT1, BIT1}, /*wait power state to suspend*/\
-        {0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0}, /*0x48[16] = 0 to disable GPIO9 as EXT WAKEUP*/   \
+	{0x004A, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_USB_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT0, 0}, /*0x48[16] = 0 to disable GPIO9 as EXT WAKEUP*/   \
 	{0x0005, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT3|BIT4, 0}, /*0x04[12:11] = 2b'01enable WL suspend*/\
 	{0x0023, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_SDIO_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, BIT4, 0}, /*0x23[4] = 1b'0 12H LDO enter normal mode*/   \
 	{0x0301, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK, PWR_BASEADDR_MAC, PWR_CMD_WRITE, 0xFF, 0},/*PCIe DMA start*/
@@ -209,7 +209,7 @@
 #define RTL8723B_TRANS_END															\
 	/* format */																\
 	/* { offset, cut_msk, fab_msk|interface_msk, base|cmd, msk, value }, comments here*/								\
-	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, 0, PWR_CMD_END, 0, 0},
+	{0xFFFF, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK, PWR_INTF_ALL_MSK, 0, PWR_CMD_END, 0, 0},


 extern struct wlan_pwr_cfg rtl8723B_power_on_flow[RTL8723B_TRANS_CARDEMU_TO_ACT_STEPS+RTL8723B_TRANS_END_STEPS];
--
2.39.2



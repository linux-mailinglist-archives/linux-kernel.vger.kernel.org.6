Return-Path: <linux-kernel+bounces-323045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB12B9736EC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B101F25E90
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D83818F2D6;
	Tue, 10 Sep 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cz8oIcrY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0D1DFE8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970357; cv=none; b=RCx8PdJSkDHcVOSuNA7lHTF/NKg2zSHOHIdi4TXbdwr+VbUar1w5psrqOwoyNPdsH3We+0Co4+4peVPjglf2OsT9EGLO7rb0E9Hht2OkOLXnjarYg/meiWvWamHIFNsshGYRDCYjZE6ksQkquMmpakZzOfIg7jkIT9IFfszWN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970357; c=relaxed/simple;
	bh=Ihh91VtsfGIHMBlHA3DMtwd1FgKUUiLwZzOZGZ53OfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TDggpA6X+S03hgnlCRhm9t8JB8IxGMC2BxBef1bRDdj+qdNjathHUrFM+vp55t7+Yxo8G5Ibor8jhJ1S72s4/8oarG4P2TQxu3XTKaU+yUTgtZUEyyRIwtq7KiydyT+YaLiRQsrJCGG1D84xyHvlemha7P2vfkhHobW7GbmmoNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cz8oIcrY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2053616fa36so8047915ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725970354; x=1726575154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFC1w8HZMIlSY+bfSQpE5aEgacwU0NrR+yRhhnZrFnU=;
        b=cz8oIcrYhnQK9jn3+W8S8DjB8xYSwFFlEpT7vj/eN56ul+nxKu847k359r6Z61t/pX
         sS4E1v0gr0cwGmimtSOYOo6f1HrPuSgTRg2RQSMGh24esj84jVAw95nkHjNctOqRKqQl
         il2MJpCJCDYmmBwWgdF9uzDWn/Bebll5RsgIN+SAsckGGi+XypTtLPZ6QVJ9PsKfCcPH
         JOpwD49VGXikmL8d2nHDI//3hAFdNkX6l03sAe9/FNe4Wy1dK3pqmBVMycpxJH/b1By/
         XESVtgU1Seh/EUxclmfzItODK9xnRs6OO9NEBCR7qJPi0OiJsr4cc6yTNLS1D0cg173L
         KmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725970354; x=1726575154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFC1w8HZMIlSY+bfSQpE5aEgacwU0NrR+yRhhnZrFnU=;
        b=CLKO278QHa9VUHR568sy0P5yTQqEE7NV2tjqGXKhB6g6TXnVOzkgWiPE2rO+9cYkx7
         O68HdIbw5t+nxZ2FCxISXHcfXNynEJjd8Z4iJoZiGrqPhaZhY7CaM3ZPwcwfx40rlTl6
         zowN98EqhMLaeMuH/JHSnG07Z2loQ/wjcSKxp/xkzwNfvVP+ORTor1VL+fQspc8xPrgv
         AuMC2bybxUc+IPePW1xnV0cebMNVOx6BsUxuaNXhWFObwNqoSCp6ktrzTuw5p9iD8j/+
         ah0y8u+d8S68JNotiwt2xyzwnuUblAc2AkCTqrZ+iy4/P7LrMD1OgphqY4WwjnaOyLVV
         Lw5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUb4Q7WcdWrs8ur94a9cpUEBgWZ848W2tR9DD5RSDS2aX4Js31azyPAhT3rGFUVkpIp8gExTlIvKpXhFZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvlh1dB9rmxWAmWrlZJemjCs9TSJy4z7x86+vZ5olFL7sZx9B
	G/BwY8YN2VSo+1KuEHz5rxOQ5aOndrLCcG0NbY1P2igCHyHyXrfAMofr5LzT6Ro=
X-Google-Smtp-Source: AGHT+IH/5qAXQhS9TIkgEOdKyxLtzMmSPB/offCaqxgUTxeoGTDPqrpNR8EhaPp77zCy5UdPhETmXw==
X-Received: by 2002:a17:902:f987:b0:205:968b:31ab with SMTP id d9443c01a7336-2074c795698mr5569245ad.58.1725970353352;
        Tue, 10 Sep 2024 05:12:33 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([2409:40c2:1160:3f27:2869:a4a6:1bc8:2b61])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f3195dsm47869175ad.263.2024.09.10.05.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:12:33 -0700 (PDT)
From: abid-sayyad <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH v2] staging: rtl8723bs: Fix coding style issues in the hal_pwr_seq.h
Date: Tue, 10 Sep 2024 17:41:44 +0530
Message-Id: <20240910121144.635348-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improving the code readability and coding style compliance of the code.
Running checkpatch.pl on the file raised coding style warnings:
-The comment block needs "*" on all lines of the block
from line 8 to 26
-Use tabs for indent
on line 103 and 115

Applying the patch fixes these coding style issues and makes the code more
readable/developer friendly.

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
changes since v1:
v2: Fix the email body, amke it more informative
link to v1:
https://lore.kernel.org/all/ca1908f3-74aa-45e7-a389-3995aba2660c@gmail.com/
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



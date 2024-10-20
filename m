Return-Path: <linux-kernel+bounces-373150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A339A5301
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1129DB2245A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34B729406;
	Sun, 20 Oct 2024 07:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KrsrX0mT"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D0520E33C;
	Sun, 20 Oct 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729409113; cv=none; b=jCgCsgcmVugDKOn5ziJzzjJ+el953UXvwXd7vIBoI22XTGp6/yCgZvf5V9V6pDlfJEJk1kKHDBkO8NSUt6INrqVHbwHcs9wkjAhwrywaTELJT4kflaAPodNMjn+7N09W0oYdk00FbCvAixMEBIk3qQQYppyEuxhXg8SPlvwxZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729409113; c=relaxed/simple;
	bh=RQ7pwXdpp5N3XNDF4l0ZT9DvdsNk+dgT5EPciOu88/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=el/k79asQbvhnAK0xg2ePtHMRas3a/Ni3CGRf8K1WJUknmXNqVfg1WhwhcZzCs07gxQ2pzhp+shPlG74BmZPqt/ZLbfP56vTqkmsBAFPcAhAu8CXLmeVA7Ue/DX+KBGVkubCiJRQe28LaZg1uI/oD54nwCdJkh3v4KRCnScfcng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KrsrX0mT; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3Vt9j
	OKkbk0VwBuWTJOwKr4gbwppQIcJn+UOHdM5dWU=; b=KrsrX0mTqqTFZMULLU0tz
	0/py5ZV6AgyTeFxssSdjVbNoUMC2Uunh95VuPVTiy2YqJRWlzbyNcfHcj4kCG2BK
	FlrjA14LUYMs2Dg3y7wglWQTG9CDqk4p1HSoGpxF1TwBo3tNUOrzREkljFXMtFHd
	RLpnFlNAeoEqkaDl94/iMw=
Received: from localhost.localdomain (unknown [114.253.22.201])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD339lAsBRnRQwEAQ--.29805S2;
	Sun, 20 Oct 2024 15:24:49 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: storage: use US_BULK_FLAG_OUT instead of constant values
Date: Sun, 20 Oct 2024 15:23:28 +0800
Message-Id: <20241020072328.26401-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024102056-yearly-caregiver-d684@gregkh>
References: <2024102056-yearly-caregiver-d684@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD339lAsBRnRQwEAQ--.29805S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4DGrWUuFy3tw48WF48JFb_yoWrXr1kpF
	WDArW5CFyrtF4Fvw15tw4UCFWrAwnYgr9rKF4Iy3s5urnxAFyUGa4qkrZ8Xw1rGr1DZFy2
	yw4qqF4jkrWFgrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnKsUUUUUU=
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbiNhV+y2cUnJW+bQAAs-

Macros with good names offer better readability.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
v1 -> v2: remove contents unrelated to the patch subject.

 drivers/usb/storage/ene_ub6250.c | 8 ++++----
 drivers/usb/storage/realtek_cr.c | 4 ++--
 drivers/usb/storage/transport.c  | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
index a4bfbecbf16c..fd46e81388d2 100644
--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -737,7 +737,7 @@ static int sd_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
 	memset(bcb, 0, sizeof(struct bulk_cb_wrap));
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 	bcb->DataTransferLength = blenByte;
-	bcb->Flags  = 0x00;
+	bcb->Flags  = US_BULK_FLAG_OUT;
 	bcb->CDB[0] = 0xF0;
 	bcb->CDB[5] = (unsigned char)(bnByte);
 	bcb->CDB[4] = (unsigned char)(bnByte>>8);
@@ -1163,7 +1163,7 @@ static int ms_read_copyblock(struct us_data *us, u16 oldphy, u16 newphy,
 	memset(bcb, 0, sizeof(struct bulk_cb_wrap));
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 	bcb->DataTransferLength = 0x200*len;
-	bcb->Flags = 0x00;
+	bcb->Flags = US_BULK_FLAG_OUT;
 	bcb->CDB[0] = 0xF0;
 	bcb->CDB[1] = 0x08;
 	bcb->CDB[4] = (unsigned char)(oldphy);
@@ -1759,7 +1759,7 @@ static int ms_scsi_write(struct us_data *us, struct scsi_cmnd *srb)
 		memset(bcb, 0, sizeof(struct bulk_cb_wrap));
 		bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 		bcb->DataTransferLength = blenByte;
-		bcb->Flags  = 0x00;
+		bcb->Flags  = US_BULK_FLAG_OUT;
 		bcb->CDB[0] = 0xF0;
 		bcb->CDB[1] = 0x04;
 		bcb->CDB[5] = (unsigned char)(bn);
@@ -1931,7 +1931,7 @@ static int ene_load_bincode(struct us_data *us, unsigned char flag)
 	memset(bcb, 0, sizeof(struct bulk_cb_wrap));
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 	bcb->DataTransferLength = sd_fw->size;
-	bcb->Flags = 0x00;
+	bcb->Flags = US_BULK_FLAG_OUT;
 	bcb->CDB[0] = 0xEF;
 
 	result = ene_send_scsi_cmd(us, FDIR_WRITE, buf, 0);
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 0c423916d7bf..54ffff86c6fa 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -212,7 +212,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 	/* set up the command wrapper */
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 	bcb->DataTransferLength = cpu_to_le32(buf_len);
-	bcb->Flags = (dir == DMA_FROM_DEVICE) ? US_BULK_FLAG_IN : 0;
+	bcb->Flags = (dir == DMA_FROM_DEVICE) ? US_BULK_FLAG_IN : US_BULK_FLAG_OUT;
 	bcb->Tag = ++us->tag;
 	bcb->Lun = lun;
 	bcb->Length = cmd_len;
@@ -301,7 +301,7 @@ static int rts51x_bulk_transport_special(struct us_data *us, u8 lun,
 	/* set up the command wrapper */
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 	bcb->DataTransferLength = cpu_to_le32(buf_len);
-	bcb->Flags = (dir == DMA_FROM_DEVICE) ? US_BULK_FLAG_IN : 0;
+	bcb->Flags = (dir == DMA_FROM_DEVICE) ? US_BULK_FLAG_IN : US_BULK_FLAG_OUT;
 	bcb->Tag = ++us->tag;
 	bcb->Lun = lun;
 	bcb->Length = cmd_len;
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 7449e379077a..9d767f6bf722 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1133,7 +1133,7 @@ int usb_stor_Bulk_transport(struct scsi_cmnd *srb, struct us_data *us)
 	bcb->Signature = cpu_to_le32(US_BULK_CB_SIGN);
 	bcb->DataTransferLength = cpu_to_le32(transfer_length);
 	bcb->Flags = srb->sc_data_direction == DMA_FROM_DEVICE ?
-		US_BULK_FLAG_IN : 0;
+		US_BULK_FLAG_IN : US_BULK_FLAG_OUT;
 	bcb->Tag = ++us->tag;
 	bcb->Lun = srb->device->lun;
 	if (us->fflags & US_FL_SCM_MULT_TARG)
-- 
2.25.1



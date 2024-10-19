Return-Path: <linux-kernel+bounces-372942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B159A4F97
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B441287666
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEB418BBA9;
	Sat, 19 Oct 2024 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KvvaeNvA"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284852F3E;
	Sat, 19 Oct 2024 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729354193; cv=none; b=j3hSYjtygvzJhqVeIcYG0WZ0dH2hu3SsV9sBpIR2DT1QNGfsAy5jimaNsCcVWVyKb2/znGaO5vShanL0y5dVY/izZdPgNIS86pJKms2XuH1cb6XEo5mAw+1p57bGBt0yDcgzTFNNEU7y/3gT62UMHolWf5WFgDUbKFtuYT8hmYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729354193; c=relaxed/simple;
	bh=Y2o35mOQRiYxgDsfAod1PSAbtNHLv+FsmzP1zrcG+U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ui7cUC416xRnlKuxNS3gUO1RQxDPlgeTWrUzW/yzGspQax7NiitvGkhZjRZvZ152x3ZU7QL7B338m2Uj5JUQNW05iTaYWr2C0ACOlypGHcX7JnGQqaSOAL30kA0OpIZ+ShDLHz96i0ueWVunhUAIKlK4QDNAVPiCxtsVezGXCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KvvaeNvA; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/nbGo
	3iWxU6M38i9I2wk5DzIIidP1/C0p11d4f3XdLo=; b=KvvaeNvA0vkVfW+4DeNHV
	UCFbe+UlxmY3OUxBEc8O6jstVibziWjSSBEyrGgLVFZmMt9pWZvF/ckY5ePoqrg5
	O6+CmKxtTAhrvXpkk8nk3xamWqKgdyMk2Vma4p/q/8xzHAmMtxRQQYEMrZypUSTT
	0/1p/gioheq0akAXLD780A=
Received: from localhost.localdomain (unknown [114.253.22.201])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCnz6a32RNn7NcBCA--.25777S2;
	Sun, 20 Oct 2024 00:09:31 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] usb: storage: use US_BULK_FLAG_OUT instead of constant values
Date: Sun, 20 Oct 2024 00:08:22 +0800
Message-Id: <20241019160822.6862-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnz6a32RNn7NcBCA--.25777S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4DGrWUuFy3uryrCFWDtwb_yoWrur4Upa
	yDA3y5CFyrKF4Fvw4DJw4UCFWrAwnYgr9rKFWfC3s5ur9xZa48GF90kFZ8Xw1rWrnrZFy2
	kr4qqF4UCryFgwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnMa8UUUUU=
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBZwp9y2cTyut26gAAsS

Macros with good names offer better readability. Besides, fix an error
in the comments. In the flags, direction is in bit 7 instead of bit 0.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/storage/ene_ub6250.c | 8 ++++----
 drivers/usb/storage/realtek_cr.c | 4 ++--
 drivers/usb/storage/transport.c  | 2 +-
 include/linux/usb/storage.h      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

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
diff --git a/include/linux/usb/storage.h b/include/linux/usb/storage.h
index 2827ce72e502..8539956bc2be 100644
--- a/include/linux/usb/storage.h
+++ b/include/linux/usb/storage.h
@@ -53,7 +53,7 @@ struct bulk_cb_wrap {
 	__le32	Signature;		/* contains 'USBC' */
 	__u32	Tag;			/* unique per command id */
 	__le32	DataTransferLength;	/* size of data */
-	__u8	Flags;			/* direction in bit 0 */
+	__u8	Flags;			/* direction in bit 7 */
 	__u8	Lun;			/* LUN normally 0 */
 	__u8	Length;			/* length of the CDB */
 	__u8	CDB[16];		/* max command */
-- 
2.25.1



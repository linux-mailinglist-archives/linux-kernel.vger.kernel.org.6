Return-Path: <linux-kernel+bounces-388334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C59FE9B5E0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85851284A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8F1E131A;
	Wed, 30 Oct 2024 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lCka1MBY"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC72E14F90;
	Wed, 30 Oct 2024 08:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730277625; cv=none; b=Eo7953bO+cHosNqCd2jHQs7bn1wCDLZlTEjcP8TZ4yY+aYx7aBiL/nOoSWrqqsAl0XjT41fJJ7UNjm7Y9aNTQHFWZu1GPPmkIqlm6HrdzrdlsbTL4Kfzx4lMz0Rf7bn/m+F35rfOeBHblaI5e5vrc1OKJTMSvpU/56WyJtuZ8jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730277625; c=relaxed/simple;
	bh=yaqg8Rnxe/N+fm8iBLzgPBDiWo6/VJYvd9F3ySBL2hA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QtyORAizNKQVf6Yrr1YVXJ1JqW8sb8j/3u91d6zil8zLRE+5l4P8XdZ1TScyDCOd9BIot2rKKG5DtTEcKNW82jMcECNUFSc1ShM4Q0v78RueGQvozmoHFwFHZu7T5EpizL8K4oQTKp4ClCX1OxD3PmUDLbxslGef/7rv+uQPoew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lCka1MBY; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=rc77A
	IZnH6tV5UZgxVycG9R3Z5ku1bY+hII0hTHlR9o=; b=lCka1MBYih2QtZjj0TN+a
	V50MDihoYg9UfUvvwugWFQlcAO76fKT/uD67mw+lVuq/zILCKGeGc6shAXZiMAaD
	XkInW0+ado6GvyNJX+1JWdOTLQN7hcdI0OthRsclqn1K+PglFu2pk8Ee+YZvVyPw
	DjnkXAcGIDxnG50k9TtXDQ=
Received: from localhost.localdomain (unknown [192.19.38.250])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCXvgzl8CFnap+qEQ--.1837S2;
	Wed, 30 Oct 2024 16:40:08 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v1] usb: storage: add a macro for the upper limit of max LUN
Date: Wed, 30 Oct 2024 16:38:58 +0800
Message-Id: <20241030083858.46907-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXvgzl8CFnap+qEQ--.1837S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw15Aw47WrykWr48JrW5Wrg_yoW5ZrW7pa
	15AFW3Ar10qrsavrWkAw4fZFyrAws7KFyUKrZrK398XFsxAFyrJr18AFZY9FW3JrW7AF4I
	vFs0gry3W3yku3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnhL8UUUUU=
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbioB+Iy2ch4afX5QABsP

The meaning of this value is already used in several places,
but with constant values and comments to explain it separately.
It's better to have a central place to do this then use the macro
in those places for better readability.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 drivers/usb/gadget/function/f_tcm.c          | 8 ++------
 drivers/usb/gadget/function/storage_common.h | 2 +-
 drivers/usb/storage/transport.c              | 8 ++------
 include/linux/usb/storage.h                  | 8 ++++++++
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 15bb3aa12aa8..e1914b20f816 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -441,14 +441,10 @@ static int usbg_bot_setup(struct usb_function *f,
 			pr_err("No LUNs configured?\n");
 			return -EINVAL;
 		}
-		/*
-		 * If 4 LUNs are present we return 3 i.e. LUN 0..3 can be
-		 * accessed. The upper limit is 0xf
-		 */
 		luns--;
-		if (luns > 0xf) {
+		if (luns > US_BULK_MAX_LUN_LIMIT) {
 			pr_info_once("Limiting the number of luns to 16\n");
-			luns = 0xf;
+			luns = US_BULK_MAX_LUN_LIMIT;
 		}
 		ret_lun = cdev->req->buf;
 		*ret_lun = luns;
diff --git a/drivers/usb/gadget/function/storage_common.h b/drivers/usb/gadget/function/storage_common.h
index ced5d2b09234..11ac785d5eee 100644
--- a/drivers/usb/gadget/function/storage_common.h
+++ b/drivers/usb/gadget/function/storage_common.h
@@ -131,7 +131,7 @@ static inline bool fsg_lun_is_open(struct fsg_lun *curlun)
 #define FSG_BUFLEN	((u32)16384)
 
 /* Maximal number of LUNs supported in mass storage function */
-#define FSG_MAX_LUNS	16
+#define FSG_MAX_LUNS	(US_BULK_MAX_LUN_LIMIT + 1)
 
 enum fsg_buffer_state {
 	BUF_STATE_SENDING = -2,
diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 9d767f6bf722..e6bc8ecaecbb 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1087,13 +1087,9 @@ int usb_stor_Bulk_max_lun(struct us_data *us)
 	usb_stor_dbg(us, "GetMaxLUN command result is %d, data is %d\n",
 		     result, us->iobuf[0]);
 
-	/*
-	 * If we have a successful request, return the result if valid. The
-	 * CBW LUN field is 4 bits wide, so the value reported by the device
-	 * should fit into that.
-	 */
+	/* If we have a successful request, return the result if valid. */
 	if (result > 0) {
-		if (us->iobuf[0] < 16) {
+		if (us->iobuf[0] <= US_BULK_MAX_LUN_LIMIT) {
 			return us->iobuf[0];
 		} else {
 			dev_info(&us->pusb_intf->dev,
diff --git a/include/linux/usb/storage.h b/include/linux/usb/storage.h
index 8539956bc2be..51be3bb8fccb 100644
--- a/include/linux/usb/storage.h
+++ b/include/linux/usb/storage.h
@@ -82,4 +82,12 @@ struct bulk_cs_wrap {
 #define US_BULK_RESET_REQUEST   0xff
 #define US_BULK_GET_MAX_LUN     0xfe
 
+/*
+ * If 4 LUNs are supported then the LUNs would be
+ * numbered from 0 to 3, and the return value for
+ * US_BULK_GET_MAX_LUN request would be 3. The valid
+ * LUN field is 4 bits wide, the upper limit is 0x0f.
+ */
+#define US_BULK_MAX_LUN_LIMIT   0x0f
+
 #endif
-- 
2.25.1



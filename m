Return-Path: <linux-kernel+bounces-201310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC38FBCE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59484284438
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F2314B972;
	Tue,  4 Jun 2024 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="J9MySeMh"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BDD14A095
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 19:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531197; cv=none; b=fVEVKrUqWr7DgnzNhygFHNkmkOlFNQZvlPF8hAa9ZNGi8xTU0nhTTvZODJmOx0XkBK4BzsokQx0n1B5o0P9hsxj6PoU+xIMKiOP0eQ2LyxDv/r68FngMOFT2TjZe1KVg8SvQZppLORwBMwDfiKRoc+HJBsVXvetptcCTmwC2kys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531197; c=relaxed/simple;
	bh=JPVqcBnQD3aHrY72+28tQWBCzAMn00Jq9480vsSITUI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LksTvNa4h9zgzbO8TisVGZ/jB2qlmqjO1bSxE6i2lE/TcI4nNQ0ZqV1aOtsUw650xKpyYzylJUKz2alXknhnrNTekgZR+OKKyWcqYyMevaI4I7QAtwshvWSrZbdgfeLt8eSPpMs6eHRTv8CuWOPZy52hOq5zkVu9rUrDoRnmitM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=J9MySeMh; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 8B389100003;
	Tue,  4 Jun 2024 22:59:32 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1717531172; bh=Xa0FPXrUOXBU3ve6V1WmTlyM5t7Kgm0yAn6+UeTYo6E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=J9MySeMhlZt1d5imLtzETd9dEZNfncxTcuVQM+sI2g5eYATlpLoadu5Gm/OOLHwXo
	 yKlj7l90VgpgfgDg0mwiJKJrtwFb8+aaKnMAub4SR3xFwGRyc+fWFamxOyEA505y1t
	 SMNBNZIaVYc4B1G4roHzQ0i8pKIMBz3W445SPIgqSlusExZQ7K8z7vtVSUQM+BEFfB
	 Zwt/nv+76Mgp+Gn1/CBoRfpI+ZmvccK7oCW9kZ7sc+wNtrKOEtQ28+mL6w5Be23PzU
	 u8Ym8nWzh/jA0hEu/7Gt2XaGF7QD8iGtIzcY2HU2mimlTkLp7wK6WAXIyaRNbH06OV
	 +HPVw8BlJAotA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  4 Jun 2024 22:58:47 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 22:58:27 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Jakob Koschel <jakobkoschel@gmail.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Scott Branden
	<scott.branden@broadcom.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] misc: bcm-vk: Fix NULL pointer dereference in case of buffer is not big enough in bcm_vk_read()
Date: Tue, 4 Jun 2024 22:58:20 +0300
Message-ID: <20240604195820.29426-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185716 [Jun 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/04 19:35:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/04 15:09:00 #25437733
X-KSMG-AntiVirus-Status: Clean, skipped

In case of entry is found but buffer is not big enough in bcm_vk_read()
found entry pointer remaining unset, but later dereferenced. This will lead
to NULL pointer dereference.
Fix this bug by moving pointer setting and correcting the conditions.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 88517757a829 ("misc: bcm-vk: replace usage of found with dedicated list iterator variable")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/misc/bcm-vk/bcm_vk_msg.c | 38 +++++++++++++++++---------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/bcm-vk/bcm_vk_msg.c b/drivers/misc/bcm-vk/bcm_vk_msg.c
index 1f42d1d5a630..566bb055fcf7 100644
--- a/drivers/misc/bcm-vk/bcm_vk_msg.c
+++ b/drivers/misc/bcm-vk/bcm_vk_msg.c
@@ -1031,11 +1031,11 @@ ssize_t bcm_vk_read(struct file *p_file,
 				    (iter->to_h_blks * VK_MSGQ_BLK_SIZE)) {
 					list_del(&iter->node);
 					atomic_dec(&ctx->pend_cnt);
-					entry = iter;
 				} else {
 					/* buffer not big enough */
 					rc = -EMSGSIZE;
 				}
+				entry = iter;
 				goto read_loop_exit;
 			}
 		}
@@ -1044,25 +1044,27 @@ ssize_t bcm_vk_read(struct file *p_file,
 	spin_unlock(&chan->pendq_lock);
 
 	if (entry) {
-		/* retrieve the passed down msg_id */
-		set_msg_id(&entry->to_h_msg[0], entry->usr_msg_id);
-		rsp_length = entry->to_h_blks * VK_MSGQ_BLK_SIZE;
-		if (copy_to_user(buf, entry->to_h_msg, rsp_length) == 0)
-			rc = rsp_length;
+		if (rc != -EMSGSIZE) {
+			/* retrieve the passed down msg_id */
+			set_msg_id(&entry->to_h_msg[0], entry->usr_msg_id);
+			rsp_length = entry->to_h_blks * VK_MSGQ_BLK_SIZE;
+			if (copy_to_user(buf, entry->to_h_msg, rsp_length) == 0)
+				rc = rsp_length;
 
-		bcm_vk_free_wkent(dev, entry);
-	} else if (rc == -EMSGSIZE) {
-		struct vk_msg_blk tmp_msg = entry->to_h_msg[0];
+			bcm_vk_free_wkent(dev, entry);
+		} else {
+			struct vk_msg_blk tmp_msg = entry->to_h_msg[0];
 
-		/*
-		 * in this case, return just the first block, so
-		 * that app knows what size it is looking for.
-		 */
-		set_msg_id(&tmp_msg, entry->usr_msg_id);
-		tmp_msg.size = entry->to_h_blks - 1;
-		if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
-			dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
-			rc = -EFAULT;
+			/*
+			 * in this case, return just the first block, so
+			 * that app knows what size it is looking for.
+			 */
+			set_msg_id(&tmp_msg, entry->usr_msg_id);
+			tmp_msg.size = entry->to_h_blks - 1;
+			if (copy_to_user(buf, &tmp_msg, VK_MSGQ_BLK_SIZE) != 0) {
+				dev_err(dev, "Error return 1st block in -EMSGSIZE\n");
+				rc = -EFAULT;
+			}
 		}
 	}
 	return rc;
-- 
2.30.2



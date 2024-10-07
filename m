Return-Path: <linux-kernel+bounces-354179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCDA9938CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 23:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76442841A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247001DE4E9;
	Mon,  7 Oct 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+vWUbJa"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D7189BBD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 21:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728335493; cv=none; b=rMWu8UJAB99effFWIptXttktxTXkL0JeWYZpz0hxcIvKBMvdwFDCPC/+aCCSDo8KogtwTXTC8gSSxGKhb3CvIbB+QgAnDUpkoidTiA/haDbaa6t1IEu23tqmWQyneH4QjYrzIMye2ACDSjUFDrZ0vajuvu5szs/9TnA/vRjsd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728335493; c=relaxed/simple;
	bh=sz9DDKWT1VHETLFCqbVPq131ZqhABGh0WxE2TKhoAn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FSDQg4USAWE2AD43UHkSdYiMT97omT874WefXBpmpwtwx5BvARYkeFDzkB7shNVFEnr7SQfHPffaBo5ClxdpKGmfq6JM8GwXYwjW5fEaOfVB8M+vVbvwp7zymydYiioBo+JbF9HzFBoCbHdPT8/lDREpP3iEVT/g0WxoNQxQdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+vWUbJa; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e0cd1f3b6so740121b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 14:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728335490; x=1728940290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5yP7B01LD6qkNHPFXhz3CUcBt6crcfzQgzq/u+GQhFQ=;
        b=A+vWUbJazpx7dn0p51pl9GtagnAwqOJ8XQG4PFixQZnqkWfkGwMiB6gDBOxKH/GluC
         fD56ID6C0AXd49BWt9aOCHXcTxc0B6s84w0DJps+5412K4p8Sf1vVXTWGQHU/eRPvWXz
         GfSj7TYZjBKy+gbjdqnpfK4JrAda8/9Pp4I95941GG5NSUgDDr+wqdZK3Scsmk0ek37M
         O5gACyY6ZD+MBYrZc+fgnVBgEtmSAbWIVR4L9fBSHqaZrvM5KLIy/mftsWR5OQW0tMlj
         Trj44pLm1AEMBKMv+nU86qW0H26dESLpJKjsQJp4X+ES/yIHCjvdW7Yd7USUGLdFT5JW
         XVtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728335490; x=1728940290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yP7B01LD6qkNHPFXhz3CUcBt6crcfzQgzq/u+GQhFQ=;
        b=MX1wZkcd7pfSE3jnoqEqyedbZUUDZlRaN1F7JlmBWuBSGPShCDzb/mggUxIVa4X9a0
         D45V2OCFejM7irstM5UwAxBj3kTf3ydKBV8b58P2e0dkSkMCPCPnNksDwkf8qNbhw6EJ
         MohYjH/rfuGcyI0CotnzOU0/4p6q/z+wGCZlPnHhKP0mTB+hNRsFtvR1yr3QPuiCp+jB
         3osSM/tkHZI3OAoJuLQTzvEpQKJaqEpctt3aT2h9F5d2P4bSYTL0BsqqaYq0Ah2lGfdO
         Jye508ajIQxZZaqE3PuiCfBV9lYvlJ2qfeHIyjcJ22fOhZuwG8IXQh82jYScRuxnZovl
         sIWg==
X-Forwarded-Encrypted: i=1; AJvYcCXlooYJxzlUDlR03PL/++vGEYOo6zuoz80zAcU69zlM5xPL0o/EUDYmI4ESG4G2x+5ZEjEkRpGeF5CqTWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRUtXe9+LNDK2eRUwJKvJlkFQOzqMyBkPIzIu3TsBINMAUcFtN
	KDCBrmu2tiVgvAQrDGcjUbph+ol2y+Kl8gi9jK/3/V6f4nC/IsmS
X-Google-Smtp-Source: AGHT+IH1UetA9aKyQtikclFIZtNCTgkLFOvfZ75fc4oZ3DIZYFDnTMjqaquTnyik04QM3lOoWxKcSg==
X-Received: by 2002:a05:6a00:3a14:b0:717:9768:a4f0 with SMTP id d2e1a72fcca58-71de22eb62bmr22422672b3a.0.1728335490010;
        Mon, 07 Oct 2024 14:11:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:81ec:3f:c655:c818:c41d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4adeasm4638192a12.84.2024.10.07.14.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:11:29 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jonathankim@gctsemi.com,
	deanahn@gctsemi.com,
	gregkh@linuxfoundation.org
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: gdm724x: fix returning -1 with return equivalent errors
Date: Mon,  7 Oct 2024 18:11:24 -0300
Message-Id: <20241007211124.170540-1-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As in the TODO file, use proper error codes from PM callbacks and init.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
---
Changelog
    v2 minor changes at packet_type_to_tty_index() and gdm_usb_lte_init()
    v1 https://lore.kernel.org/linux-staging/20241004203458.6497-1-rodrigo.gobbi.7@gmail.com/T/#m258452a56ddade60b2209479f036213e72d43f02
---
 drivers/staging/gdm724x/TODO      |  1 -
 drivers/staging/gdm724x/gdm_mux.c |  6 +++---
 drivers/staging/gdm724x/gdm_usb.c | 10 ++++++----
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gdm724x/TODO b/drivers/staging/gdm724x/TODO
index b2b571ecb063..56a415b9dcbe 100644
--- a/drivers/staging/gdm724x/TODO
+++ b/drivers/staging/gdm724x/TODO
@@ -2,7 +2,6 @@ TODO:
 - Clean up coding style to meet kernel standard. (80 line limit, netdev_err)
 - Remove test for host endian
 - Remove confusing macros (endian, hci_send, sdu_send, rcv_with_cb)
-- Fixes for every instances of function returning -1
 - Check for skb->len in gdm_lte_emulate_arp()
 - Use ALIGN() macro for dummy_cnt in up_to_host()
 - Error handling in init_usb()
diff --git a/drivers/staging/gdm724x/gdm_mux.c b/drivers/staging/gdm724x/gdm_mux.c
index 9b12619671a1..82302c6266eb 100644
--- a/drivers/staging/gdm724x/gdm_mux.c
+++ b/drivers/staging/gdm724x/gdm_mux.c
@@ -47,7 +47,7 @@ static int packet_type_to_tty_index(u16 packet_type)
 			return i;
 	}
 
-	return -1;
+	return -ENOENT;
 }
 
 static struct mux_tx *alloc_mux_tx(int len)
@@ -594,7 +594,7 @@ static int gdm_mux_suspend(struct usb_interface *intf, pm_message_t pm_msg)
 
 	if (mux_dev->usb_state != PM_NORMAL) {
 		dev_err(intf->usb_dev, "usb suspend - invalid state\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	mux_dev->usb_state = PM_SUSPEND;
@@ -622,7 +622,7 @@ static int gdm_mux_resume(struct usb_interface *intf)
 
 	if (mux_dev->usb_state != PM_SUSPEND) {
 		dev_err(intf->usb_dev, "usb resume - invalid state\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	mux_dev->usb_state = PM_NORMAL;
diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index 54bdb64f52e8..f666fbeeb44c 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -916,7 +916,7 @@ static int gdm_usb_suspend(struct usb_interface *intf, pm_message_t pm_msg)
 	rx = &udev->rx;
 	if (udev->usb_state != PM_NORMAL) {
 		dev_err(intf->usb_dev, "usb suspend - invalid state\n");
-		return -1;
+		return -EINVAL;
 	}
 
 	udev->usb_state = PM_SUSPEND;
@@ -952,7 +952,7 @@ static int gdm_usb_resume(struct usb_interface *intf)
 
 	if (udev->usb_state != PM_SUSPEND) {
 		dev_err(intf->usb_dev, "usb resume - invalid state\n");
-		return -1;
+		return -EINVAL;
 	}
 	udev->usb_state = PM_NORMAL;
 
@@ -989,9 +989,11 @@ static struct usb_driver gdm_usb_lte_driver = {
 
 static int __init gdm_usb_lte_init(void)
 {
-	if (gdm_lte_event_init() < 0) {
+	int ret = gdm_lte_event_init();
+
+	if (ret < 0) {
 		pr_err("error creating event\n");
-		return -1;
+		return ret;
 	}
 
 	return usb_register(&gdm_usb_lte_driver);
-- 
2.34.1



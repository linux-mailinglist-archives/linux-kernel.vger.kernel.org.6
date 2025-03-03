Return-Path: <linux-kernel+bounces-541071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E25A4B811
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C6918904B1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9BA1E7C28;
	Mon,  3 Mar 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PMjky6qx"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA75684;
	Mon,  3 Mar 2025 07:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985268; cv=none; b=owoRtFLjss3MtIiUnW6qPReyRLaDp7ylD/rNgA0Za6jgVK97DInt4y2Bdgzyi5KrS/bh16mpVvbG3N7+UbbmnguU90PJ4DNxo4VzVBu0mIPrKodzb6JdsUazhFsmKgL39ofX7GFdDgX9cfMBT+wDAbIQ6iO80ssDbHe4+esQqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985268; c=relaxed/simple;
	bh=06/lFsI+jRiJfxa1MNxYK6jt9nzUM276nC+0ai3Lqu8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mhORt8PqHkGXnQMChVydTFBmkJ7hFQGyHvnrrlmIgoQ540+B9hcfhsUPWLGwUlYQImk/YZshgOK1ohIOMi7cGt1jJm5mvOIaTT8gtqyiUNQxJvbaiDo9nTTNLV2xxRwQK9VuNTBi89t+OXIJPxqDiDyyGUHXzDhHnEEU7vpFSX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PMjky6qx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nFsyP
	1HLyJu4C2yuVvpg4ClcQGgSmKQc6q3wf7J3EK4=; b=PMjky6qxNHQd85tZZCATp
	sl6rsUn8g34co6ZSzLtkDojlhN3ew0ELA051+snzc9AFW0JZ6cwl7AxsJD4hVYcq
	KK+P1RUW7nxu6RS5GIHH5clZvCmIRfV28L8M6mKnRpHGnILYJbA8b9Ul1GBVzDu1
	rYYzQrXghxRRpWbmABS9Fg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDn1d2kU8VnvlsCQA--.28777S2;
	Mon, 03 Mar 2025 15:00:53 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH] usb: quirks: Add DELAY_INIT and NO_LPM for Prolific PL2303 Serial Port
Date: Mon,  3 Mar 2025 15:00:47 +0800
Message-Id: <20250303070047.153591-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn1d2kU8VnvlsCQA--.28777S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyfuFyDZw4UCF15Zr15XFb_yoWDCwbEkr
	1UWa93u3W8GFZ7trn7Za1fZrZ5Kw429rykua4qqa43Ja1UCw1kJF4xArWUZr1UGry8tF4D
	Kan7u34DZr1v9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiNeO5UUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiShAFzWfFTX7fnwAAsD

From: Miao Li <limiao@kylinos.cn>

When used on Huawei hisi platforms, Prolific PL2303 Serial Port which
the VID:PID is in 067b:2731 might fail to enumerate at boot time and
doesn't work well with LPM enabled, combination quirks:
USB_QUIRK_DELAY_INIT + USB_QUIRK_NO_LPM
fixed the problems.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index dfcfc142bd5e..8aca5518e003 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
 
+	/* Prolific PL2303 Serial Port */
+	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_NO_LPM },
+
 	/* Saitek Cyborg Gold Joystick */
 	{ USB_DEVICE(0x06a3, 0x0006), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
-- 
2.25.1



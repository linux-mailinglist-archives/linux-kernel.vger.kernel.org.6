Return-Path: <linux-kernel+bounces-512663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ED3A33C42
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F771688C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B398D212D7A;
	Thu, 13 Feb 2025 10:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="G49g+7Q8"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FA9200132;
	Thu, 13 Feb 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441636; cv=none; b=ixtxwcVDH8yIUYHE01V4tJFdY1oNHtzkJVkE+tIJd1O3h+ooOlaFdBM4GAcOb1EIpOquEhDVpvy5oc2s2gm2RE6ZDMANy+GCgW9liDpXFDClvL93a20snCCrlLI2KZrmrJQEooWwG5o7+pFJcKvY6kkm0EPOHqUOjAE3zInIFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441636; c=relaxed/simple;
	bh=/farfuygZn84rBQ98uw6pZPzaCxp2Rbcw/AJkt+z6ng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iZzy10Z6/Z2s98w/1lKbY0NauFoOesjk2bZ0lHaRAt5ygbvE8yK8RYlfhThz2zeNF/NKOIK2QgH4k7Btiu+3NvTEM0xBzBWXB5EWKtdK4LrjYGTCV29SUqOZWUmudbAHsCwN44xFTEHSVbDBr2trBk0qm7HqxMq653363iZw13M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=G49g+7Q8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zEaOK
	sn1HL/M1gWJsLUEPDNN9Im0AEujYaOnWLWSZM0=; b=G49g+7Q8uMKGqiAbXgKgG
	C5FKEzxOnblct0Sl4Hi3tmhJ+EARnDGynDTQjJ9LdYP3gvGbi/Md+4+hqf5rM5bb
	5B6BZTTRSJ5+llvwYUMzqXZ/OKOkYLRSyg7i3AAOQ4SA/JkmTqbXgqYtIe6SaAKY
	9jTz0bCYs65J6MC1tLtpl0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3HxG_xa1n35x5Lw--.25413S2;
	Thu, 13 Feb 2025 18:13:20 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH] usb: quirks: Add NO_LPM quirk for Teclast disk
Date: Thu, 13 Feb 2025 18:12:59 +0800
Message-Id: <20250213101259.239530-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HxG_xa1n35x5Lw--.25413S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKry3Gw1xCF47Ar18KFyDZFb_yoWfurg_Cr
	1UWayI93W8GF97trnFva1fZr4rtwnFvryvgFWqqF1fJF4j9w1rJF47Jryvyr17GrWUJrs8
	KFsrAr1kZr1xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiNeO5UUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiERvyzWetvRe+rQAAsG

From: Miao Li <limiao@kylinos.cn>

Teclast disk which the VID:PID is in 1f75:0917 will encounter work trouble
used on Huawei hisi platforms with LPM enabled, applying NO_LPM quirk for
this device fixed the problem.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 67732c791c93..3927c7d66dac 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -525,6 +525,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Blackmagic Design UltraStudio SDI */
 	{ USB_DEVICE(0x1edb, 0xbd4f), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Teclast disk */
+	{ USB_DEVICE(0x1f75, 0x0917), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Hauppauge HVR-950q */
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
-- 
2.25.1



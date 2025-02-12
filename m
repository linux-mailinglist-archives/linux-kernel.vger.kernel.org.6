Return-Path: <linux-kernel+bounces-510828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91CA32291
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FA6164677
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF8A2066FA;
	Wed, 12 Feb 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F7MT0PNo"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B12066D9;
	Wed, 12 Feb 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353126; cv=none; b=Ry1cBuyUjzHYCIW5UipgPR3qokL7Xib/4qe1OPK55BbrUGBafQ9Ak0U1MKOmONnIIj3Ox9cMaX22L2ELfZInqvM+AbwqZm+FE9IdCEE5fHSiiaM1uu5YsXscxmjbNlGXR8WmgMobp/iEkiFo1GqVU6McNXAt0822DUD3NlublZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353126; c=relaxed/simple;
	bh=S8VIXdospXRdBtwzRyNgOFZRIjOgZsm43lgGBJuQjDo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DowLwiTWgnnfX57K+sPEowHpckRI5/Cb+P8wUNN4X6Vg+oKt2NiwChwamVNXFGE8y+wAn8MbQ1/dPI3hcRw7x5/Yh/MgRh5qZ24FPNLA2WmO9A6Nk7veekcF3vATYxrd7sPkeZcJA2NkOHmQbeVlLaTOgSmZQrdqm/bDWrzE2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F7MT0PNo; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=rXcHEM/xIJvw6XceLy
	U/deizny3qc2YfoZNHPyVdXpM=; b=F7MT0PNosun/RmQSZiUH2TIpqZuFZkPI+s
	jOCgwSc3n3ExHFLbkE4JRkV6P+3UhOnFgn64wy/eGfE7DLyWqSIST66aPAKMtrOA
	EAXAjDEYSN1Z2N3uQ3hObp17SihrEBwY4zzzx50XYAXZuoBysIMEhHPAPM4DOsXe
	srFN940YQ=
Received: from localhost.localdomain (unknown [116.128.244.169])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXo+MWbKxnCVe2Ng--.21306S2;
	Wed, 12 Feb 2025 17:38:31 +0800 (CST)
From: Lei Huang <huanglei814@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Huang <huanglei@kylinos.cn>
Subject: [PATCH] USB: quirks: add USB_QUIRK_NO_LPM quirk for Teclast dist
Date: Wed, 12 Feb 2025 17:38:29 +0800
Message-Id: <20250212093829.7379-1-huanglei814@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:QCgvCgAXo+MWbKxnCVe2Ng--.21306S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JrW5Zr4rJr15XFW5KFWxWFg_yoWfZFb_Cr
	1xWaySg3W8GF93tr42va1fZrWFk3W29F1v9ayktF13Ja17Cw1rAFW7ur90vr17GFZ7JFs8
	KF1xAr1rZr4vgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjvD7PUUUUU==
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbi7gHx9mesZk1NAAABsE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Lei Huang <huanglei@kylinos.cn>

Teclast disk used on Huawei hisi platforms doesn't work well,
losing connectivity intermittently if LPM is enabled.
Add quirk disable LPM to resolve the issue.

Signed-off-by: Lei Huang <huanglei@kylinos.cn>
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
2.17.1



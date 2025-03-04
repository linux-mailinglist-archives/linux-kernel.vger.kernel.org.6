Return-Path: <linux-kernel+bounces-543323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBA4A4D446
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320BD3A81BB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786541F5858;
	Tue,  4 Mar 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oXJsnOAX"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F216F073;
	Tue,  4 Mar 2025 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741072101; cv=none; b=FTVL3yw3lbPyxFoXauN4h3tDyaVJzCm+SEdDi7Itvb5e0qLwc//tsg2cugJITtHvX+mVDCxY13NA9qWn5Qp/A1TaYWz+4c9DJ9YGO6iv7mU7EcbTDXhzaD5ecJyUa4p9hkIeeSjmUAi4exImOCFh2OwG34oSb/j+Qe3WfDiRJNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741072101; c=relaxed/simple;
	bh=USVXMeSsekJD4VOJ1drsoFiahkXCWTLMPjYjAm3Cgkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sblBcEZLbovRD2+Mt3vMIz0uKimMlBqFEfCpO2Mvv7UqJyeLFJlbWEcJp7ITgMgDvtojkgyG833HyIbiCsbWYgxZbRAfBsdf8xmCAKL9r6ufunJKRHs7uZUfyXqA7R2Wqy5ZPTPqUH+H7RJgzLJ+e6wugTBYq7bGjOa9JQQ71Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oXJsnOAX; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2d9Zh
	TJKyQ4yvIa5T3TbMOiDeepc3m5G65R+hcVoNJw=; b=oXJsnOAX/Q/MVQ5lPsW8c
	9/RgPhNR4nCqVsAw0Xcfjr4FhskeQBylxFNl2vnmx5ZX00litKTs8+YvPx9WJyoc
	+WhkXgvbLoknO8FW6IazfF+rJ7yDPVV++/a3avGi7ZGem6hiS5jTQwlPLwxxfGlQ
	f6u/y2y8srjdVNcBU4ZqZI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAH+S7QpsZnQuqYQA--.28406S2;
	Tue, 04 Mar 2025 15:08:00 +0800 (CST)
From: Miao Li <limiao870622@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	limiao870622@163.com,
	Miao Li <limiao@kylinos.cn>
Subject: [PATCH V2] usb: quirks: Add DELAY_INIT and NO_LPM for Prolific Mass Storage Card Reader
Date: Tue,  4 Mar 2025 15:07:57 +0800
Message-Id: <20250304070757.139473-1-limiao870622@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303070047.153591-1-limiao870622@163.com>
References: <20250303070047.153591-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH+S7QpsZnQuqYQA--.28406S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFykXr1kJF4UuFW7Kw1Dtrb_yoWkXrgEkr
	1UWa93u3W8GFWktr1vva1fZrWkKw4I9ryv9Fyqqa43Ja15urs5JF4xCrWjvr1UGry8tF4D
	tF4ku345Zr1xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiAwI5UUUUU==
X-CM-SenderInfo: 5olpxtbryxiliss6il2tof0z/1tbiEQ0GzWfGYoco9QADsN

From: Miao Li <limiao@kylinos.cn>

When used on Huawei hisi platforms, Prolific Mass Storage Card Reader
which the VID:PID is in 067b:2731 might fail to enumerate at boot time
and doesn't work well with LPM enabled, combination quirks:
USB_QUIRK_DELAY_INIT + USB_QUIRK_NO_LPM
fixed the problems.

Signed-off-by: Miao Li <limiao@kylinos.cn>
---
V1 -> V2: Change device description information
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index dfcfc142bd5e..8efbacc5bc34 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -341,6 +341,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
 
+	/* Prolific Single-LUN Mass Storage Card Reader */
+	{ USB_DEVICE(0x067b, 0x2731), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_NO_LPM },
+
 	/* Saitek Cyborg Gold Joystick */
 	{ USB_DEVICE(0x06a3, 0x0006), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
-- 
2.25.1



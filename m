Return-Path: <linux-kernel+bounces-412509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0084B9D09E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 822E3B21551
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E614A619;
	Mon, 18 Nov 2024 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="CVaeUprW"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44813CA95;
	Mon, 18 Nov 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731912992; cv=none; b=klPpadWB6077mgsJDKJDd5sd4b0sv7l22kZTFk8NKHc+OLsnscHpPJaPI8wZsfsS2xsYQxqrQAXmXsB829F5cUO2TpBkqLcGaTVbWzSEMB7H9n4rNPGjiH3wof96n9IcaHybgekyxBlShBssErIDpM7nKehg6AadKeQJfL/odek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731912992; c=relaxed/simple;
	bh=Qs9duRa2WkNIoX6p67oHfQtM34fKgEVmCboEjdNFdls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZEsDK4pnoW2dq4B7pThl4+zGd2lqGIMJM4Gmxz7smi6niuhbyaOjTdsGwJv8c2JY+Sj2EsvyN6tPutt1m2CAlsqaV5RbePVjGVXL5AzgS12NaAODgW8rRXV6ET+BIghhpoBjpFLj9w4SzNDce8X6Co4q/hj9+2SyCBW59Ik8IP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=CVaeUprW; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DB86325348;
	Mon, 18 Nov 2024 07:47:57 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-DxB9MTCAHp; Mon, 18 Nov 2024 07:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1731912477; bh=Qs9duRa2WkNIoX6p67oHfQtM34fKgEVmCboEjdNFdls=;
	h=From:To:Cc:Subject:Date;
	b=CVaeUprWr85hYpzGP02fE2NxpQnq/f/E6xmjpnIypQBGQua0ALirzoKsdq7uGxkRF
	 Tw1xbvOPLCSh/WiNo4WUyMhFmquiu6N/SJZFMZW/0F+KJhWT6tEkpgjwDH9r8a9pnl
	 9oKjM/ycqY0kXwAeUbEdNLMKYal+HUilcY/GSCxNL1cNhe1dclrYcQzdnXTy3ahCA4
	 FHMoeZXtSbEfQk20bI2qUjsQ9BfCnO+ziZxVBEDeCWdunw26vBQv+SbTxAbIfrxXNv
	 /wCMPZFilFiYJuaKHL95W3/Gbc8ra3gwopvyI/63MI33DOU0oZBfhvFQzTQ7X16q8y
	 cXS7QaxuLLnmw==
From: Yao Zi <ziyao@disroot.org>
To: Kenneth Chan <kenneth.t.chan@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org (open list:PANASONIC LAPTOP ACPI EXTRAS DRIVER),
	linux-kernel@vger.kernel.org (open list),
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] platform/x86: panasonic-laptop: Return errno correctly in show callback
Date: Mon, 18 Nov 2024 06:46:39 +0000
Message-ID: <20241118064637.61832-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an error occurs in sysfs show callback, we should return the errno
directly instead of formatting it as the result, which produces
meaningless output and doesn't inform the userspace of the error.

Fixes: 468f96bfa3a0 ("platform/x86: panasonic-laptop: Add support for battery charging threshold (eco mode)")
Fixes: d5a81d8e864b ("platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/platform/x86/panasonic-laptop.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 2bf94d0ab324..22ca70eb8227 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -614,8 +614,7 @@ static ssize_t eco_mode_show(struct device *dev, struct device_attribute *attr,
 		result = 1;
 		break;
 	default:
-		result = -EIO;
-		break;
+		return -EIO;
 	}
 	return sysfs_emit(buf, "%u\n", result);
 }
@@ -761,7 +760,12 @@ static ssize_t current_brightness_store(struct device *dev, struct device_attrib
 static ssize_t cdpower_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	return sysfs_emit(buf, "%d\n", get_optd_power_state());
+	int state = get_optd_power_state();
+
+	if (state < 0)
+		return state;
+
+	return sysfs_emit(buf, "%d\n", state);
 }
 
 static ssize_t cdpower_store(struct device *dev, struct device_attribute *attr,
-- 
2.47.0



Return-Path: <linux-kernel+bounces-512575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D4A33AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017B616ACA4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F218E20D4FA;
	Thu, 13 Feb 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OVeNTmQO"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5389A20A5E1;
	Thu, 13 Feb 2025 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739438185; cv=none; b=ZHyVAGY53TKk1CAu7T1IWaZZVTsN5+EUWSH7QcEm1ToOpMmpgv0dZZX5AWkEG3Mm4OSMgiqKaIRQY2FN4hL2dsskMKVJsnVlBKDAddvhKH18f7wKBLFefxAL/ObjFS5XJ5opehvzY4DYAQvuUaEmacwDZgXeWKbkPes9cuYsXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739438185; c=relaxed/simple;
	bh=TujycZlDf27LHQSqZ01TZSVk6JIbq4JJ/a/o3Xjv8Wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uQqjXs2Vs86Qkct4aUr0I07rhzSIDarO9bE2INTnpGoUA49EbTbI+PMhPyJs1qq/BALGhAjn3HWd8OfGEfjT/Wg5EatRrDZ+LOBhRCHubye0yqPzQQvtakjw2wB0PaYJer9RpdpbDcpDCF/6AOQ4SM69f11/O8ZtH60o1uf0YG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OVeNTmQO; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=eZXyY+rIJ9uiwcgEZTwKxYAgqtlUWLn2/QpYJQwBpRw=;
	b=OVeNTmQO9dM4IS/w/kqPc1gl6uXuJobsdBdoxWbraMKFpv70PhJ5GG+y94yvK4
	veDS+8+IPAkvGMmGSjx1TDduy23OvTaoRxs4vlAri65fo8HG653R8Er0wGycfhlG
	q2UW/sTnpEf0HKQH19/QDaUnbTC0FiDfEddVzcl2SOgAM=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDn3ylLuK1n5NkFMA--.5233S2;
	Thu, 13 Feb 2025 17:15:55 +0800 (CST)
From: 412574090@163.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH] usb: fix error while OF and ACPI all config Y
Date: Thu, 13 Feb 2025 17:15:53 +0800
Message-Id: <20250213091553.198050-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn3ylLuK1n5NkFMA--.5233S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4ruFW3Xr45Gr1rtr1xAFb_yoWfCrc_K3
	Wq9rWxG34rC34jkr15Kr4Fvw1Ska1DWry8uF1Dt3sxXFW2kw4UX3Z09FyUta1UGayDJF1D
	WryFvryjkF409jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb5fH5UUUUU==
X-CM-SenderInfo: yursklauqziqqrwthudrp/1tbiPQryAGetq0vqJwAAsi

From: weiyufeng <weiyufeng@kylinos.cn>

When both OF and ACPI are configured as Y simultaneously，this may
cause error while install os with usb disk，while reading data from
the usb disk, the onboard_ hub driver will reinitialize the
hub, causing system installation exceptions.

Signed-off-by: weiyufeng <weiyufeng@kylinos.cn>
---
 drivers/usb/misc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6497c4e81e95..94e75e7adcc1 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
 
 config USB_ONBOARD_DEV
 	tristate "Onboard USB device support"
-	depends on OF
+	depends on OF && !ACPI
 	help
 	  Say Y here if you want to support discrete onboard USB devices
 	  that don't require an additional control bus for initialization,
-- 
2.25.1



Return-Path: <linux-kernel+bounces-512335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A0EA337B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 07:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C5C1686CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B233F20764E;
	Thu, 13 Feb 2025 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WHl40XVY"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34712063E2;
	Thu, 13 Feb 2025 06:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426895; cv=none; b=s6ZgpSeEi9mLrpfuaKiALxAnj3asgs42l8Muaj4FSb7lUBZvbyNkklde6isQxOXNf8XAl70AJdiH0VIT7qAw4Q/ogT/pNaPqNs3zexPrX3ul7CFO+99J4ffMEZPjmSVergEqKGYG33XgM7jAy+nFioNq5V4TfgKes2TqFJAOi7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426895; c=relaxed/simple;
	bh=ENJWjFM8DaN1Oe+BoexqycWpBPzbDudOA9qgKyPQ3Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=l0lcE0g3oUn6iBvL3EGXD8WW7NkLAl3DH+Wj1pty1npmv4lP0d4plAfzS+4akUx1lZoPgHvUCUodXJC+PAY/eA8Dh/MU9mPNtBe7BznC/0grfaVwElD+IL+i1duvJLjt7AGmoXxh4IFipMxSFzDZB6E0Ljgz94UZZ0V02xS50hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WHl40XVY; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=fCGABF2XYfIo1vC+SRUYw07lm9xs8lHUxSSE5UGqbkY=;
	b=WHl40XVYQocB74KcIJSPwsiFUaYXk3lXafwZ4XguyEx86OyfkP0KWHFtxL1w1n
	tYet5Z64b3P8Mn+T0DEmHX+uNK47xA4GFd5wqObD6CUG9VBRsnlIURCU6kYokQjG
	GIUTBmnKfsRaf0K6gj6h4nbDUYeplkRzn9IvPmCz4h3Lk=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3d3BGjK1npHxHMA--.22020S2;
	Thu, 13 Feb 2025 14:08:06 +0800 (CST)
From: 412574090@163.com
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH] usb: fix error while OF and ACPI all config Y
Date: Thu, 13 Feb 2025 14:08:04 +0800
Message-Id: <20250213060804.114558-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3d3BGjK1npHxHMA--.22020S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4ruFW3Xr45Gr1rtr1xAFb_yoWfCrX_K3
	Wq9rWxG348C34jkr15Kr4F9w1fK3WDWrWxuF1Dt3sxJFW29w47Xas09ryDta1UGayDJF1D
	WryFyryj9F1F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb5l1JUUUUU==
X-CM-SenderInfo: yursklauqziqqrwthudrp/1tbizRjyAGetg7+QHQAAsc

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
index 6497c4e81e95..9ffb51191621 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
 
 config USB_ONBOARD_DEV
 	tristate "Onboard USB device support"
-	depends on OF
+	depends on (OF && !ACPI)
 	help
 	  Say Y here if you want to support discrete onboard USB devices
 	  that don't require an additional control bus for initialization,
-- 
2.25.1



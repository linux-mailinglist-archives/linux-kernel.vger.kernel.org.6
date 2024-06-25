Return-Path: <linux-kernel+bounces-229328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5640E916E63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F621F24387
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A417622E;
	Tue, 25 Jun 2024 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l2wpGJ9p"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3A16E863;
	Tue, 25 Jun 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334049; cv=none; b=VX6cyFLrst3kvdc/1kJ2wPkrVFGFHR1WMDGMXCRye582S6G5DTM3WZLmGROzbW7FyOAHFqjhBpB1rPSX/LBIFD57iQBBDkdsZhc5Ko2TzZ146TlmOThu1NpVbQ3HyJ1WSSqDgkDqalRzNBgDq/qaL26HDOJVqmLZUbZhUfc2Fjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334049; c=relaxed/simple;
	bh=auLPFsUwMAOX84W1PHZS+Fnr/WAtAk6hqRYSvkhLEuo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=PfCfCFg9TLGOytyw+67HujMl5jnBkRhP5OfFAKCUXflF4ab/dUsdyO4+uSFaHa2sRGyfxfbDDR0ZJ7dcKaWp+GRpzxhhQwIenmsCsRQhQG4byt5m8EpgTjiJj8dSWZREWKQhZPxwIqFGMdVo+5FssTmju9fz4qzSTjuVycKr8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l2wpGJ9p; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id; bh=pD8lAwlY54XK1J8UOK
	tOe+VXizuIZB6XckcwJU5V9oE=; b=l2wpGJ9ppBIjCMChIyfUatO9DW9bhK936M
	uhCVwYkaKsCcRUFi8HmvjMIetKUWzqcjuAC6mn05jxiUPfMg2+6LfLh5dNBcE+Ma
	CSRCOkwdilRlyeSn8GTiFK4IGysxjvd+soRU3WdHw2lrj6R0+ugAaJCkelS/uNtX
	zlJZDmuo0=
Received: from localhost.localdomain (unknown [114.92.93.163])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD3nxlb9Hpm6dHMAQ--.46011S2;
	Wed, 26 Jun 2024 00:46:27 +0800 (CST)
From: Lizhe <sensor1010@163.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu,
	hgajjar@de.adit-jv.com,
	stanley_chang@realtek.com,
	ricardo.canuelo@collabora.com,
	johan+linaro@kernel.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lizhe <sensor1010@163.com>
Subject: [PATCH] USB: hub:no need to obtain usb device
Date: Tue, 25 Jun 2024 09:46:07 -0700
Message-Id: <20240625164607.3367-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:_____wD3nxlb9Hpm6dHMAQ--.46011S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw43Kr4xtrW7uF1Dtw17Awb_yoW3XFbE9a
	1Uuayxuw18tFyxKr1UZw1FvrW2kw4avrnFvFZ0qry3ZFyYqr17urWDX392yF15ArW7Cr9x
	JFyq9r15ur40vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt189JUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/1tbiEAUJq2XAlnThXgAAsP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

the usb device connected to the port has obtained.
there is no need to obtain it again.

Signed-off-by: Lizhe <sensor1010@163.com>
---
 drivers/usb/core/hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 4b93c0bd1d4b..f37b991fa86a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5358,7 +5358,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 	if (udev) {
 		if (hcd->usb_phy && !hdev->parent)
 			usb_phy_notify_disconnect(hcd->usb_phy, udev->speed);
-		usb_disconnect(&port_dev->child);
+		usb_disconnect(&udev);
 	}
 
 	/* We can forget about a "removed" device when there's a physical
-- 
2.17.1



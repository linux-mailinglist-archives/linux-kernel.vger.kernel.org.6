Return-Path: <linux-kernel+bounces-214867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61887908B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3D811F22042
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C3198851;
	Fri, 14 Jun 2024 12:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AtUsMvpw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2401192B98;
	Fri, 14 Jun 2024 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367120; cv=none; b=tceOUbNcbnYVNz8Yn5x/YQEBId67Y91J/GOAx+Fp6HymFeMJTw2nWmszcrcUTzoD+X5LW90N8ZGjZ03/1mrgvgnzlYstN+d5STBIjP2WBtUg+0E/FEJq6Ll0lznC1rTBTIvo8BpjJZCiT+qRubhF6yuoGrUdWBB2BMWVBb7FoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367120; c=relaxed/simple;
	bh=cfWpz8K6Dhi/7RRbosYXUfONYA0Zam7ELSgNheWH0eI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n1vTeMXH77slfl0Nb2TCOw7b+EpQC0915urlpVe5XBFPGb7XmrH81zxCeBb4BXBSHIYu6PfdLLWodwtsDw21ceY2CFqAC0MrwOOmsXgUVjvDpvdBGEsRl5OqHUYi0h2v359CH1gXBLxfNn2B6i3oRtw9NBzqoLRcbXdn7kyph2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AtUsMvpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7930C3277B;
	Fri, 14 Jun 2024 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718367120;
	bh=cfWpz8K6Dhi/7RRbosYXUfONYA0Zam7ELSgNheWH0eI=;
	h=From:To:Cc:Subject:Date:From;
	b=AtUsMvpw303xpZIkpsVX1syK+ppUFSw67MySIsF+YHcwG7MJFbzUEOovzjBxzRkjO
	 wiB+2EhnF5qpDNxb6W3e7Vc4CHaaEUi2KrA18f4QiMTCqGxHyz5JOePrTYP6r/oLqF
	 i7f9KYpKc4xUeQoYVi37QEPKrKcouSXQc63FZeNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Grant Grundler <grundler@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/4] USB: make to_usb_driver() use container_of_const()
Date: Fri, 14 Jun 2024 14:11:49 +0200
Message-ID: <2024061448-manly-universal-00ad@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 58
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=cfWpz8K6Dhi/7RRbosYXUfONYA0Zam7ELSgNheWH0eI=; b=owGbwMvMwCRo6H6F97bub03G02pJDGk5xq0ssWK8l2oXzT61grv3u8RLm8L5Vk0GTp9M7DcI+ qs8vHioI5aFQZCJQVZMkeXLNp6j+ysOKXoZ2p6GmcPKBDKEgYtTACZSZ8swz1RWcaX+hPnuYvEb 67sXRfnPu/swhGG+b98B35nJz/Sbl82qPlPFdv2X+6RGAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Turns out that we have some const pointers being passed to
to_usb_driver() but were not catching this.  Change the macro to
properly propagate the const-ness of the pointer so that we will notice
when we try to write to memory that we shouldn't be writing to.

This requires fixing up the usb_match_dynamic_id() function as well,
because it can handle a const * to struct usb_driver.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Grant Grundler <grundler@chromium.org>
Cc: Yajun Deng <yajun.deng@linux.dev>
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/core/driver.c | 4 ++--
 include/linux/usb.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 8e9bafcd62c6..c985a272e552 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -229,7 +229,7 @@ static void usb_free_dynids(struct usb_driver *usb_drv)
 }
 
 static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
-							struct usb_driver *drv)
+							const struct usb_driver *drv)
 {
 	struct usb_dynid *dynid;
 
@@ -880,7 +880,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 
 	} else if (is_usb_interface(dev)) {
 		struct usb_interface *intf;
-		struct usb_driver *usb_drv;
+		const struct usb_driver *usb_drv;
 		const struct usb_device_id *id;
 
 		/* device drivers never match interfaces */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 1913a13833f2..4390426973f4 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1232,7 +1232,7 @@ struct usb_driver {
 	unsigned int disable_hub_initiated_lpm:1;
 	unsigned int soft_unbind:1;
 };
-#define	to_usb_driver(d) container_of(d, struct usb_driver, driver)
+#define	to_usb_driver(d) container_of_const(d, struct usb_driver, driver)
 
 /**
  * struct usb_device_driver - identifies USB device driver to usbcore
-- 
2.45.2



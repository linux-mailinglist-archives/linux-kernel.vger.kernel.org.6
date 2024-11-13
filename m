Return-Path: <linux-kernel+bounces-407735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D6A9C747B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AECA8B29A44
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFE31F9A80;
	Wed, 13 Nov 2024 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uOvyWuzG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486901F4FC6;
	Wed, 13 Nov 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731506690; cv=none; b=ifRFFqk9vZIq9f4HcWeBfNRkqAkgULK0wzL320LKhlR2X6kmjhOrQNJizLCgCI6gOsgh5Tf6s1TYAD2pAFIhp9VTzKG1Kfy8Y1TdiU5jEKxSToLsmbKQEQi7SHlY6oxQbEcjRYjXvaVFAUvqC80IsErPn4Lv+/kNlyKnAGcEyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731506690; c=relaxed/simple;
	bh=xEIsm82Us/2uPAaz8oc2KoXxc6pXZstnJKLajTBWF3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVgSI7NoQ/u9gIlgLD6Yc6kjI6KtLQwf5flopE12JIzkpKJrMqT3UUyN+JI0gXEnK2/kcIszxkYfh9vDOdl+fEiHel8eEwjBN7Rb+FqbB0m2+eqPs6cXQ3UTndV0OPVO2PFkOsjHvFLCA2YeuRAkJnNWM5YPXKJk0Ib1qqu8xlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uOvyWuzG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CFE6C4CED2;
	Wed, 13 Nov 2024 14:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731506689;
	bh=xEIsm82Us/2uPAaz8oc2KoXxc6pXZstnJKLajTBWF3w=;
	h=From:To:Cc:Subject:Date:From;
	b=uOvyWuzGRZMZ3v8WO8IC97opH+xrf2NHI3nX2a9dd8qxplPBFinZD231V7lqkN7OB
	 j6/SSUqK2XWYSKmnPrpxfKp9x4juyh7zXg+WNdGmtgOZnALVKD1TaLFXtqe+TqnBbi
	 YAZ5QiwQ5L2zHXf3SilNlwgptxSYActnR2rr/H+A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	Grant Grundler <grundler@chromium.org>,
	Yajun Deng <yajun.deng@linux.dev>,
	Oliver Neukum <oneukum@suse.com>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 1/2] USB: make to_usb_driver() use container_of_const()
Date: Wed, 13 Nov 2024 15:04:40 +0100
Message-ID: <2024111339-shaky-goldsmith-b233@gregkh>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 60
X-Developer-Signature: v=1; a=openpgp-sha256; l=2292; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xEIsm82Us/2uPAaz8oc2KoXxc6pXZstnJKLajTBWF3w=; b=owGbwMvMwCRo6H6F97bub03G02pJDOkmG7+z/Tt2R0tJ+FKhXnzxCbMHB7Z8lJb+JTLTKcd8g 7hKSuOVjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZgIFwfD/OhtkttPJP65/eS8 p8qOWTb19rk5Sxjml/8+VfPrwuok9W9mD+b2Mj+vSPDnAgA=
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
v2: reordered patches, goes on top of series submitted at https://lore.kernel.org/r/2024111322-kindly-finalist-d247@gregkh

 drivers/usb/core/driver.c | 4 ++--
 include/linux/usb.h       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 9ea955a3d115..bc5c561bdbd5 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -228,7 +228,7 @@ static void usb_free_dynids(struct usb_driver *usb_drv)
 }
 
 static const struct usb_device_id *usb_match_dynamic_id(struct usb_interface *intf,
-							struct usb_driver *drv)
+							const struct usb_driver *drv)
 {
 	struct usb_dynid *dynid;
 
@@ -890,7 +890,7 @@ static int usb_device_match(struct device *dev, const struct device_driver *drv)
 
 	} else if (is_usb_interface(dev)) {
 		struct usb_interface *intf;
-		struct usb_driver *usb_drv;
+		const struct usb_driver *usb_drv;
 		const struct usb_device_id *id;
 
 		/* device drivers never match interfaces */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index b66b1af3e439..7a9e96f9d886 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1243,7 +1243,7 @@ struct usb_driver {
 	unsigned int disable_hub_initiated_lpm:1;
 	unsigned int soft_unbind:1;
 };
-#define	to_usb_driver(d) container_of(d, struct usb_driver, driver)
+#define	to_usb_driver(d) container_of_const(d, struct usb_driver, driver)
 
 /**
  * struct usb_device_driver - identifies USB device driver to usbcore
-- 
2.47.0



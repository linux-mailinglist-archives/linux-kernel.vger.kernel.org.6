Return-Path: <linux-kernel+bounces-343015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA99895ED
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D9C2827DE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA87017B439;
	Sun, 29 Sep 2024 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="crZkMk2L"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6FF9CB;
	Sun, 29 Sep 2024 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727619083; cv=none; b=dmfZBnSGadw/1PhdZ/CrM4kkqJd5P8OQSZw3iY+2XtGhgQ0yuyAnpmC/5ux1EbsPwnJjEV5Q/rPVASgGDnVMuMre2mnIdN7ZP8wB9+lqckxLLhYwOSGv8fjIgv00p0JUjFLN54yOv0f1uLPNOJamE+WLoFS6ewVaK4F9q65TeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727619083; c=relaxed/simple;
	bh=uknLgK7A1DeYA2/j3kMtaxg4dkD6FyaIapZEBPSNGPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFJPokqyHzcCVwvZRNjsa0yBMQ+f3ayosRnrPYSvWu7moXNeXo4IoGb8RzSwMrHXO8wSB23j/NpZMtCp5rVMAodHAowvc4WXncGkYhmcUR4p1IZJTR59VR1hdPc6D/nwqxKd5T8QYfC7yEZ5xpbE77PsSO2v0eIx+IWPRvCWaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=crZkMk2L; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=iYftW1Vl91Y6d1cv4+vfyRkeUSB2Pj+mWOxao1rPqA8=; b=crZkMk2L7gUg8VBg
	r6H+aviYOdRmCGQFlSuR0J0RsVawlqgGfThKDuzl+L3RJ4OZCwtH+rovGTt/xakBvaclUeJj2YTtx
	jzbeyZIVugI1Dzug2VMk0qGmh7k1okNMJnlQv4mRT1qAB+jH5sr5POYKym6CNE0ZlI/3fB/s14seO
	CgoCOL98RXmc2FHDClO/ZjWx+jiYRFyeO/biMYHw0LEAFa6iezOOJ3FyYtswUDQT+KOW3b6pmkgOM
	N5rxGHXfPj1h7m1Cvu4lxtteP8YG8/7FQmjF/aSu6AwFLWGd4aZ+xPOMgyFR8p9YvKzlmuzcPa5qX
	lS+v6StMJRORdqEIDA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1suudl-007pDu-1N;
	Sun, 29 Sep 2024 14:11:13 +0000
From: linux@treblig.org
To: gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	corbet@lwn.net,
	rafael@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] drivers/base: Remove unused auxiliary_find_device
Date: Sun, 29 Sep 2024 15:11:12 +0100
Message-ID: <20240929141112.69824-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

auxiliary_find_device has been unused since commit
1c5de097bea3 ("net/mlx5: Fix mlx5_get_next_dev() peer device matching")

which was the only use since it was originally added.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 Documentation/driver-api/auxiliary_bus.rst |  1 -
 drivers/base/auxiliary.c                   | 29 ----------------------
 include/linux/auxiliary_bus.h              |  4 ---
 3 files changed, 34 deletions(-)

diff --git a/Documentation/driver-api/auxiliary_bus.rst b/Documentation/driver-api/auxiliary_bus.rst
index cec84908fbc0..b236de773e1d 100644
--- a/Documentation/driver-api/auxiliary_bus.rst
+++ b/Documentation/driver-api/auxiliary_bus.rst
@@ -24,7 +24,6 @@ Auxiliary Device Creation
 
 .. kernel-doc:: drivers/base/auxiliary.c
    :identifiers: auxiliary_device_init __auxiliary_device_add
-                 auxiliary_find_device
 
 Auxiliary Device Memory Model and Lifespan
 ------------------------------------------
diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 7823888af4f6..69b7c93613d6 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -335,35 +335,6 @@ int __auxiliary_device_add(struct auxiliary_device *auxdev, const char *modname)
 }
 EXPORT_SYMBOL_GPL(__auxiliary_device_add);
 
-/**
- * auxiliary_find_device - auxiliary device iterator for locating a particular device.
- * @start: Device to begin with
- * @data: Data to pass to match function
- * @match: Callback function to check device
- *
- * This function returns a reference to a device that is 'found'
- * for later use, as determined by the @match callback.
- *
- * The reference returned should be released with put_device().
- *
- * The callback should return 0 if the device doesn't match and non-zero
- * if it does.  If the callback returns non-zero, this function will
- * return to the caller and not iterate over any more devices.
- */
-struct auxiliary_device *auxiliary_find_device(struct device *start,
-					       const void *data,
-					       device_match_t match)
-{
-	struct device *dev;
-
-	dev = bus_find_device(&auxiliary_bus_type, start, data, match);
-	if (!dev)
-		return NULL;
-
-	return to_auxiliary_dev(dev);
-}
-EXPORT_SYMBOL_GPL(auxiliary_find_device);
-
 /**
  * __auxiliary_driver_register - register a driver for auxiliary bus devices
  * @auxdrv: auxiliary_driver structure
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index 31762324bcc9..65dd7f154374 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -269,8 +269,4 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
 #define module_auxiliary_driver(__auxiliary_driver) \
 	module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
 
-struct auxiliary_device *auxiliary_find_device(struct device *start,
-					       const void *data,
-					       device_match_t match);
-
 #endif /* _AUXILIARY_BUS_H_ */
-- 
2.46.2



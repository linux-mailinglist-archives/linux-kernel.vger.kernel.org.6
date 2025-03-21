Return-Path: <linux-kernel+bounces-571675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8273A6C091
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0DB3A50D2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6372222CBD0;
	Fri, 21 Mar 2025 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve6khhgh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C04155A25;
	Fri, 21 Mar 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575796; cv=none; b=YI6L2duFqzLNhSesWK4Gab8ag9STN7IkhEtOr6pQWrK+jcG/yjO5Q3FkUAVF3LubsVgKxxZA0KpSIxUQqdZxuA9JRmgFmkP3EzDSG5sMczawBBeCOrDS6ONA4u3lg4NFvHiRcV40YzPpcuh5voSIEciND0MmJKU6EFNSL+2kRN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575796; c=relaxed/simple;
	bh=iXRT/qes364OAhYPS5CBvBhBz7tLPO070NnwuD9TcqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uX5Q6hkJ4WVuRGOn85XgcmnyxSvLc9d2cnmR1jwzaul8lSDUWnNrar2VLJjxysPOj5Hv5xuJ5AGsNVA+x4ttH2qFD0lPlVcGAywft2Woy0QE6PSo/HeOz+x1dBlMmCXd6t/Zjv+Hywy8mK9mZg1j2XXbNryI2A/X2ayIrUXkgl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ve6khhgh; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742575796; x=1774111796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iXRT/qes364OAhYPS5CBvBhBz7tLPO070NnwuD9TcqI=;
  b=Ve6khhghxj5jQn6B1dD1IZj9omNtTWR9IpbuTPHpgpb0xvYLZklz0i49
   Hss2D2POL1/yuP34OYc4Hew2dviC8HVrcK+cNYFwVOPU5vKsHAfeVQjo3
   /VH6W1LEkubgZ9qYEIR60TKysdetrB0A2m1CpMJ/BQXJjQg5Tj1hwbz+Q
   6zquq59B7Z1XbBqppgcPz8p3ZFbhroVOjYgF5N7IuN+paianZ9OFVrtUA
   N55ySJjDlkS7Er+gAoWssFJYttJmSL6I4sukZaX+g/frAIoaLUNgU1FaU
   hlX+vhNtKOUglT3F4z4tW3sJQd1u48ljtGLk8VEZ5NNGiWhfxn4PKbsvv
   A==;
X-CSE-ConnectionGUID: 4suOlnuKTnunfGpmrcTdAQ==
X-CSE-MsgGUID: 8ohNRyeMR4+J/ntj9XWoQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="66311540"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="66311540"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 09:49:55 -0700
X-CSE-ConnectionGUID: JrWYtE5jRw6RDnx3o6BG2w==
X-CSE-MsgGUID: Q3MpQSMoTfakReuZYcnBfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123416334"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa010.jf.intel.com with ESMTP; 21 Mar 2025 09:49:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 2771E14B; Fri, 21 Mar 2025 18:49:52 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 1/1] usb: Add checks for snprintf() calls in usb_alloc_dev()
Date: Fri, 21 Mar 2025 18:49:49 +0200
Message-ID: <20250321164949.423957-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When creating a device path in the driver the snprintf() takes
up to 16 characters long argument along with the additional up to
12 characters for the signed integer (as it can't see the actual limits)
and tries to pack this into 16 bytes array. GCC complains about that
when build with `make W=1`:

  drivers/usb/core/usb.c:705:25: note: ‘snprintf’ output between 3 and 28 bytes into a destination of size 16

Since everything works until now, let's just check for the potential
buffer overflow and bail out. It is most likely a never happen situation,
but at least it makes GCC happy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/core/usb.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 0b4685aad2d5..118fa4c93a79 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -695,15 +695,16 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 		device_set_of_node_from_dev(&dev->dev, bus->sysdev);
 		dev_set_name(&dev->dev, "usb%d", bus->busnum);
 	} else {
+		int n;
+
 		/* match any labeling on the hubs; it's one-based */
 		if (parent->devpath[0] == '0') {
-			snprintf(dev->devpath, sizeof dev->devpath,
-				"%d", port1);
+			n = snprintf(dev->devpath, sizeof(dev->devpath), "%d", port1);
 			/* Root ports are not counted in route string */
 			dev->route = 0;
 		} else {
-			snprintf(dev->devpath, sizeof dev->devpath,
-				"%s.%d", parent->devpath, port1);
+			n = snprintf(dev->devpath, sizeof(dev->devpath), "%s.%d",
+				     parent->devpath, port1);
 			/* Route string assumes hubs have less than 16 ports */
 			if (port1 < 15)
 				dev->route = parent->route +
@@ -712,6 +713,11 @@ struct usb_device *usb_alloc_dev(struct usb_device *parent,
 				dev->route = parent->route +
 					(15 << ((parent->level - 1)*4));
 		}
+		if (n >= sizeof(dev->devpath)) {
+			usb_put_hcd(bus_to_hcd(bus));
+			usb_put_dev(dev);
+			return NULL;
+		}
 
 		dev->dev.parent = &parent->dev;
 		dev_set_name(&dev->dev, "%d-%s", bus->busnum, dev->devpath);
-- 
2.47.2



Return-Path: <linux-kernel+bounces-250459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309BF92F817
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617441C217CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4500149DF0;
	Fri, 12 Jul 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F/rlRtEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE9374D3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777162; cv=none; b=r72fOdUhU8X+/FuCeSSHOseDcyYxZqRZpLVNImVV3d+o1nL9Tr1KGSVFNTamjE/H8qP5kjcGfk6mL3EE1DmL0jcKEn8+PKdXT0rpcyOpEx9Trp6WRGy/Zt58y4p2CJ8Phn6aV0dCwLq/dkwuHz6HrIeTmOWw2iwYe9JH3X0iy2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777162; c=relaxed/simple;
	bh=ABBFD44TlD2+CFl0N8Dv7XBTTUHJ1evLqOSfbZ3nsuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kf4BABSlVUebGGTeL4vzlaFhTDO0KIlReig5zn2+TrBFeRsw4yQodjiu+bKA1TZxWGx5G/C/0uY+kuXsbt4UtvLLCQQtDZeManOQ1yhOURYFnam35ifMRAADXG6QzKcTZR7BqfbkkoVP/k8QbKTsNnUhw+nPfevffFdh2yzYfZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F/rlRtEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7470FC32782;
	Fri, 12 Jul 2024 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720777161;
	bh=ABBFD44TlD2+CFl0N8Dv7XBTTUHJ1evLqOSfbZ3nsuE=;
	h=From:To:Cc:Subject:Date:From;
	b=F/rlRtElVtoEZ3B2O/SjnsFLnq42sKglsRTmpL8s79B+SXRcjUogcQ7RsgeP3lfyU
	 t/v0f7dj1HicIGbAsK9eIdneP/CzQMWdMTqGlnnoP5W9M1ZgCLbWzxxFq+en6CXT+p
	 i0Cm7a7HxwhZtB2NlYnvmYtrmP//hFUa323k+MUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Russell King <linux@armlinux.org.uk>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] ARM: sa1100: make match function take a const pointer
Date: Fri, 12 Jul 2024 11:39:17 +0200
Message-ID: <20240712093916.2121096-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2016; i=gregkh@linuxfoundation.org; h=from:subject; bh=ABBFD44TlD2+CFl0N8Dv7XBTTUHJ1evLqOSfbZ3nsuE=; b=owGbwMvMwCRo6H6F97bub03G02pJDGkTfh7ptXnaevlhvdvkYn7e51etrorfiHz9tOqm9Z6kj hns2dW7OmJZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAipyoZFpzIX5/yfaXwZsEL L5757L2WsHf9ziyGOZwNGz/lPE67I7/mb3KHYUJa1UlhDQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In commit d69d80484598 ("driver core: have match() callback in struct
bus_type take a const *"), the match callback for busses was changed to
take a const pointer to struct device_driver.  Unfortunately I missed
fixing up the sa1111 code, and was only noticed after-the-fact by the
kernel test robot.  Resolve this issue by properly changing the
sa111_match() function.

Cc: Russell King <linux@armlinux.org.uk>
Fixes: d69d80484598 ("driver core: have match() callback in struct bus_type take a const *")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/common/sa1111.c               | 4 ++--
 arch/arm/include/asm/hardware/sa1111.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1fbd7363cf11..550978dc3c50 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -1339,10 +1339,10 @@ EXPORT_SYMBOL_GPL(sa1111_get_irq);
  *	We model this as a regular bus type, and hang devices directly
  *	off this.
  */
-static int sa1111_match(struct device *_dev, struct device_driver *_drv)
+static int sa1111_match(struct device *_dev, const struct device_driver *_drv)
 {
 	struct sa1111_dev *dev = to_sa1111_device(_dev);
-	struct sa1111_driver *drv = SA1111_DRV(_drv);
+	const struct sa1111_driver *drv = SA1111_DRV(_drv);
 
 	return !!(dev->devid & drv->devid);
 }
diff --git a/arch/arm/include/asm/hardware/sa1111.h b/arch/arm/include/asm/hardware/sa1111.h
index d8c6f8a99dfa..a815f39b4243 100644
--- a/arch/arm/include/asm/hardware/sa1111.h
+++ b/arch/arm/include/asm/hardware/sa1111.h
@@ -404,7 +404,7 @@ struct sa1111_driver {
 	void (*remove)(struct sa1111_dev *);
 };
 
-#define SA1111_DRV(_d)	container_of((_d), struct sa1111_driver, drv)
+#define SA1111_DRV(_d)	container_of_const((_d), struct sa1111_driver, drv)
 
 #define SA1111_DRIVER_NAME(_sadev) ((_sadev)->dev.driver->name)
 
-- 
2.45.2



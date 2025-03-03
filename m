Return-Path: <linux-kernel+bounces-544985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13077A4E772
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4EF01888B81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB67283C81;
	Tue,  4 Mar 2025 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFPFIsb9"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD7828136B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106137; cv=fail; b=OPTCvDwbx5IrQpa//s45rAzZ+xnSco8jFr06BODYxckD2FkixMJsXug2GqU9mWZKCDoBBEZAsHigh+KPCQgnzSiE0gD+Vl0CUyr9Uv/OaTFO+j5crS512LOBrlMsi/Fk3RounNcSbg8ou4zh5GZiU/xeJqP9HlxOK55CFzZ328s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106137; c=relaxed/simple;
	bh=w7L16YDH0u/WeL9RVUhjupkpnWL0lacVECff9iHgGKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnMLD5q6oJDkuml28M2M9oDI1D08jCY6aov+q12/JvuHbPcH81x7OpAwowB/zUHGVkbPUo/INo71BsaHxxNrsAYpWKQMtWPh7VIXRNHQrsxsv0M3iJal6fLJw2RoS/CgzXCnPi851cm4aw/yPeQ7Vk6tAtc/WqPnwn5uNqfNnMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFPFIsb9 reason="signature verification failed"; arc=none smtp.client-ip=170.10.133.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 19B8340CECBB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:35:32 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jFPFIsb9
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6h8W0c9rzG3CL
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:34:03 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6319A42720; Tue,  4 Mar 2025 19:33:56 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFPFIsb9
X-Envelope-From: <linux-kernel+bounces-541329-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFPFIsb9
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id DDABA430B4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:01:50 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A159C3064C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:01:50 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34AD188DC49
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040FD1EDA07;
	Mon,  3 Mar 2025 10:01:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964D4C85
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996080; cv=none; b=ZG1C0vTGtj3saP4yUE9MraSpxNuOfyv/HYDLdflEmm+2+A4duCIWjytxvAbeT2y//nZpN3PtA09f9QZSpO7RbsZ1RYgYmbzEj3mvrIS7zDX/ZhRPr8EqHezyASyN7M+2t7gSQDupSFJGkSYpg6lICz8uuZptK/6XEh0e9bpGlao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996080; c=relaxed/simple;
	bh=yjRMHLlkkDlmDkfLVBwYhGiU4rRp/KbhIMJkkXPFlkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J6IzWmqxk5t9XKQ/aRYethonoSW2EATv5OiwbFr3KwyDM3Khb2PgkqGQf0boNXJHd+FlreFaFoVqvv5+66tULQNN55e9Shwrk12n5VoLkez5Fub6WmaEkLVq05CVGv0xxWb3il0VPqrjuZcaBxkjxigxwuTLAQknyJaWzNb2BvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jFPFIsb9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740996076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pU0gMi/ZoyHqCIm9QtEmaxH4IUl17rAy9Rj+6M4VtKg=;
	b=jFPFIsb9MPBwqx0Jz4Fz8VCvhTP01wht472hm7El0qOKR61qTmY3TgaSsywcReb713QAu3
	E8ANo9C2sLyf+3/61tY+WW3hYrWWwFu476u6CDImfkDUZmuCWvCVMWvHbDug9OhqnE5qwh
	p76QlRQsTLJfoeEfYlx7a7HzvenV560=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-IEHW9sWHNC6xRWjPsL-SnQ-1; Mon, 03 Mar 2025 05:01:15 -0500
X-MC-Unique: IEHW9sWHNC6xRWjPsL-SnQ-1
X-Mimecast-MFC-AGG-ID: IEHW9sWHNC6xRWjPsL-SnQ_1740996074
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-abbae81829fso586523866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 02:01:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996074; x=1741600874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU0gMi/ZoyHqCIm9QtEmaxH4IUl17rAy9Rj+6M4VtKg=;
        b=kFBpG7C3yf8OEBpIzuYl3DRnAiyed8+vygkrAQVoABqmG2yteS+7dltv/woYCed/oU
         hNlFiJz3Qk7lDVDrEy3eomY+6yTDdtqH3uC0rmSlSYW7sFHvBAH7jgcee96XgCzVLq78
         3pqBPoDoabHQCsTunX6h3ERXI5ze3n328RaetRTpfqYexTw95lPkRJn8V0QuaYfetOp7
         H+k9NEPZA7LNW8nlriY52kpWtj4qN5RonaQh1y21Fe+Ww1bDQuBd2PoC0d2eCMWYiACL
         dF15vfmuG+cn7vud0RGkeZfimrhvhigF5P3fNMf2ghpS1RsvQfaV/t16YIC2ieZA3nI/
         6+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzlvf1Kqk5iJ9GXAIGBKk6qTd3z7fcgEn0w8X/hyADrrG2VSvvVQEEg1zK2ZNaVsNqId7fOVYUUWFVnD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoXcqOhXrSxt2UV6+ilJ0zaPE1qvnl4xLKmL8wKPNmU37fqID
	cC+mOiCseJxLBcNoAcb1GXEWyRG0DISM0wGbN4emZzsc3bEB4DgSmsK8/7o3qdIJLJsaGFa1EXu
	yTDy3LjR1pYpJqUhioxHDBu5WIP6Jv9lTmPPcmRXOQmg9BnPRgGVNwnvoozYxyA==
X-Gm-Gg: ASbGncudrkpu+nSoLkO7pS8Ft96pqIcRIHdfVIH66DtCnBl9ufq4KKWqRYhipQTHAUp
	iIkjayJBFUF4JZ4kooytZJ3KDIl6fQaXN0n9e24oTecKtWgamnJ9w3w7nY0tpI6jc0vNX4gEtvJ
	p/xR4MQI0zIN8n30YwlvOXhRmAEzcTlMphZW4Z6/5ZK+zgyzyDMERnmbU8plzN8+Fm+0wAi5fsR
	sYUaJK9gllcF7rGUmlww2FytnZ+iZbPKQ5opHKEo3V+T8zhf2YWoz1SJzI3z6C0Aa97iKtMit7a
	e5fkbLy4wImq6iRNApTYvAYPdZ6JJfKC9KI00Y0pHl04Te1SK+HtFY7e1Sua50A=
X-Received: by 2002:a17:907:1048:b0:abf:5aea:a584 with SMTP id a640c23a62f3a-abf5aeaa908mr753998766b.38.1740996073402;
        Mon, 03 Mar 2025 02:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO7nc3m5Jamg1sQEOPPHtOg4kraU/Av2DMNpmxEgEQMt47ad9TG9GuNEKJ2t/3nT1mLIP2zg==
X-Received: by 2002:a17:907:1048:b0:abf:5aea:a584 with SMTP id a640c23a62f3a-abf5aeaa908mr753989566b.38.1740996071858;
        Mon, 03 Mar 2025 02:01:11 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e40:14b0:4ce1:e394:7ac0:6905])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf40a603b7sm539031366b.170.2025.03.03.02.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 02:01:11 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] mfd: remove STA2x11 mfd driver
Date: Mon,  3 Mar 2025 11:00:55 +0100
Message-ID: <20250303100055.372689-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6h8W0c9rzG3CL
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741710866.27888@WkDC25Ko+pD/Bb5iYxR7tQ
X-ITU-MailScanner-SpamCheck: not spam

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

With commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support"), the mfd
driver for STA2x11 is not needed and cannot be built anymore.

Remove the driver and its header file.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 drivers/mfd/Kconfig             |   6 -
 drivers/mfd/Makefile            |   1 -
 drivers/mfd/sta2x11-mfd.c       | 645 --------------------------------
 include/linux/mfd/sta2x11-mfd.h | 506 -------------------------
 4 files changed, 1158 deletions(-)
 delete mode 100644 drivers/mfd/sta2x11-mfd.c
 delete mode 100644 include/linux/mfd/sta2x11-mfd.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d44c69bb3dfd..b7f6b3047d56 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1495,12 +1495,6 @@ config STMPE_SPI
 	  This is used to enable SPI interface of STMPE
 endmenu
=20
-config MFD_STA2X11
-	bool "STMicroelectronics STA2X11"
-	depends on STA2X11
-	select MFD_CORE
-	select REGMAP_MMIO
-
 config MFD_SUN6I_PRCM
 	bool "Allwinner A31/A23/A33 PRCM controller"
 	depends on ARCH_SUNXI || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9220eaf7cf12..c3d3a9cf20e4 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -26,7 +26,6 @@ obj-$(CONFIG_MFD_TI_LP873X)	+=3D lp873x.o
 obj-$(CONFIG_MFD_TI_LP87565)	+=3D lp87565.o
 obj-$(CONFIG_MFD_TI_AM335X_TSCADC)	+=3D ti_am335x_tscadc.o
=20
-obj-$(CONFIG_MFD_STA2X11)	+=3D sta2x11-mfd.o
 obj-$(CONFIG_MFD_STMPE)		+=3D stmpe.o
 obj-$(CONFIG_STMPE_I2C)		+=3D stmpe-i2c.o
 obj-$(CONFIG_STMPE_SPI)		+=3D stmpe-spi.o
diff --git a/drivers/mfd/sta2x11-mfd.c b/drivers/mfd/sta2x11-mfd.c
deleted file mode 100644
index 02cc49daf2e3..000000000000
--- a/drivers/mfd/sta2x11-mfd.c
+++ /dev/null
@@ -1,645 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * STA2x11 mfd for GPIO, SCTL and APBREG
- *
- * Copyright (c) 2009-2011 Wind River Systems, Inc.
- * Copyright (c) 2011 ST Microelectronics (Alessandro Rubini, Davide Cim=
inaghi)
- */
-
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/export.h>
-#include <linux/spinlock.h>
-#include <linux/errno.h>
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/list.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
-#include <linux/pci.h>
-#include <linux/seq_file.h>
-#include <linux/platform_device.h>
-#include <linux/mfd/core.h>
-#include <linux/mfd/sta2x11-mfd.h>
-#include <linux/regmap.h>
-
-#include <asm/sta2x11.h>
-
-static inline int __reg_within_range(unsigned int r,
-				     unsigned int start,
-				     unsigned int end)
-{
-	return ((r >=3D start) && (r <=3D end));
-}
-
-/* This describes STA2X11 MFD chip for us, we may have several */
-struct sta2x11_mfd {
-	struct sta2x11_instance *instance;
-	struct regmap *regmap[sta2x11_n_mfd_plat_devs];
-	spinlock_t lock[sta2x11_n_mfd_plat_devs];
-	struct list_head list;
-	void __iomem *regs[sta2x11_n_mfd_plat_devs];
-};
-
-static LIST_HEAD(sta2x11_mfd_list);
-
-/* Three functions to act on the list */
-static struct sta2x11_mfd *sta2x11_mfd_find(struct pci_dev *pdev)
-{
-	struct sta2x11_instance *instance;
-	struct sta2x11_mfd *mfd;
-
-	if (!pdev && !list_empty(&sta2x11_mfd_list)) {
-		pr_warn("%s: Unspecified device, using first instance\n",
-			__func__);
-		return list_entry(sta2x11_mfd_list.next,
-				  struct sta2x11_mfd, list);
-	}
-
-	instance =3D sta2x11_get_instance(pdev);
-	if (!instance)
-		return NULL;
-	list_for_each_entry(mfd, &sta2x11_mfd_list, list) {
-		if (mfd->instance =3D=3D instance)
-			return mfd;
-	}
-	return NULL;
-}
-
-static int sta2x11_mfd_add(struct pci_dev *pdev, gfp_t flags)
-{
-	int i;
-	struct sta2x11_mfd *mfd =3D sta2x11_mfd_find(pdev);
-	struct sta2x11_instance *instance;
-
-	if (mfd)
-		return -EBUSY;
-	instance =3D sta2x11_get_instance(pdev);
-	if (!instance)
-		return -EINVAL;
-	mfd =3D kzalloc(sizeof(*mfd), flags);
-	if (!mfd)
-		return -ENOMEM;
-	INIT_LIST_HEAD(&mfd->list);
-	for (i =3D 0; i < ARRAY_SIZE(mfd->lock); i++)
-		spin_lock_init(&mfd->lock[i]);
-	mfd->instance =3D instance;
-	list_add(&mfd->list, &sta2x11_mfd_list);
-	return 0;
-}
-
-/* This function is exported and is not expected to fail */
-u32 __sta2x11_mfd_mask(struct pci_dev *pdev, u32 reg, u32 mask, u32 val,
-		       enum sta2x11_mfd_plat_dev index)
-{
-	struct sta2x11_mfd *mfd =3D sta2x11_mfd_find(pdev);
-	u32 r;
-	unsigned long flags;
-	void __iomem *regs;
-
-	if (!mfd) {
-		dev_warn(&pdev->dev, ": can't access sctl regs\n");
-		return 0;
-	}
-
-	regs =3D mfd->regs[index];
-	if (!regs) {
-		dev_warn(&pdev->dev, ": system ctl not initialized\n");
-		return 0;
-	}
-	spin_lock_irqsave(&mfd->lock[index], flags);
-	r =3D readl(regs + reg);
-	r &=3D ~mask;
-	r |=3D val;
-	if (mask)
-		writel(r, regs + reg);
-	spin_unlock_irqrestore(&mfd->lock[index], flags);
-	return r;
-}
-EXPORT_SYMBOL(__sta2x11_mfd_mask);
-
-int sta2x11_mfd_get_regs_data(struct platform_device *dev,
-			      enum sta2x11_mfd_plat_dev index,
-			      void __iomem **regs,
-			      spinlock_t **lock)
-{
-	struct pci_dev *pdev =3D *(struct pci_dev **)dev_get_platdata(&dev->dev=
);
-	struct sta2x11_mfd *mfd;
-
-	if (!pdev)
-		return -ENODEV;
-	mfd =3D sta2x11_mfd_find(pdev);
-	if (!mfd)
-		return -ENODEV;
-	if (index >=3D sta2x11_n_mfd_plat_devs)
-		return -ENODEV;
-	*regs =3D mfd->regs[index];
-	*lock =3D &mfd->lock[index];
-	pr_debug("%s %d *regs =3D %p\n", __func__, __LINE__, *regs);
-	return *regs ? 0 : -ENODEV;
-}
-EXPORT_SYMBOL(sta2x11_mfd_get_regs_data);
-
-/*
- * Special sta2x11-mfd regmap lock/unlock functions
- */
-
-static void sta2x11_regmap_lock(void *__lock)
-{
-	spinlock_t *lock =3D __lock;
-	spin_lock(lock);
-}
-
-static void sta2x11_regmap_unlock(void *__lock)
-{
-	spinlock_t *lock =3D __lock;
-	spin_unlock(lock);
-}
-
-/* OTP (one time programmable registers do not require locking */
-static void sta2x11_regmap_nolock(void *__lock)
-{
-}
-
-static const char *sta2x11_mfd_names[sta2x11_n_mfd_plat_devs] =3D {
-	[sta2x11_sctl] =3D STA2X11_MFD_SCTL_NAME,
-	[sta2x11_apbreg] =3D STA2X11_MFD_APBREG_NAME,
-	[sta2x11_apb_soc_regs] =3D STA2X11_MFD_APB_SOC_REGS_NAME,
-	[sta2x11_scr] =3D STA2X11_MFD_SCR_NAME,
-};
-
-static bool sta2x11_sctl_writeable_reg(struct device *dev, unsigned int =
reg)
-{
-	return !__reg_within_range(reg, SCTL_SCPCIECSBRST, SCTL_SCRSTSTA);
-}
-
-static struct regmap_config sta2x11_sctl_regmap_config =3D {
-	.reg_bits =3D 32,
-	.reg_stride =3D 4,
-	.val_bits =3D 32,
-	.lock =3D sta2x11_regmap_lock,
-	.unlock =3D sta2x11_regmap_unlock,
-	.max_register =3D SCTL_SCRSTSTA,
-	.writeable_reg =3D sta2x11_sctl_writeable_reg,
-};
-
-static bool sta2x11_scr_readable_reg(struct device *dev, unsigned int re=
g)
-{
-	return (reg =3D=3D STA2X11_SECR_CR) ||
-		__reg_within_range(reg, STA2X11_SECR_FVR0, STA2X11_SECR_FVR1);
-}
-
-static bool sta2x11_scr_writeable_reg(struct device *dev, unsigned int r=
eg)
-{
-	return false;
-}
-
-static struct regmap_config sta2x11_scr_regmap_config =3D {
-	.reg_bits =3D 32,
-	.reg_stride =3D 4,
-	.val_bits =3D 32,
-	.lock =3D sta2x11_regmap_nolock,
-	.unlock =3D sta2x11_regmap_nolock,
-	.max_register =3D STA2X11_SECR_FVR1,
-	.readable_reg =3D sta2x11_scr_readable_reg,
-	.writeable_reg =3D sta2x11_scr_writeable_reg,
-};
-
-static bool sta2x11_apbreg_readable_reg(struct device *dev, unsigned int=
 reg)
-{
-	/* Two blocks (CAN and MLB, SARAC) 0x100 bytes apart */
-	if (reg >=3D APBREG_BSR_SARAC)
-		reg -=3D APBREG_BSR_SARAC;
-	switch (reg) {
-	case APBREG_BSR:
-	case APBREG_PAER:
-	case APBREG_PWAC:
-	case APBREG_PRAC:
-	case APBREG_PCG:
-	case APBREG_PUR:
-	case APBREG_EMU_PCG:
-		return true;
-	default:
-		return false;
-	}
-}
-
-static bool sta2x11_apbreg_writeable_reg(struct device *dev, unsigned in=
t reg)
-{
-	if (reg >=3D APBREG_BSR_SARAC)
-		reg -=3D APBREG_BSR_SARAC;
-	if (!sta2x11_apbreg_readable_reg(dev, reg))
-		return false;
-	return reg !=3D APBREG_PAER;
-}
-
-static struct regmap_config sta2x11_apbreg_regmap_config =3D {
-	.reg_bits =3D 32,
-	.reg_stride =3D 4,
-	.val_bits =3D 32,
-	.lock =3D sta2x11_regmap_lock,
-	.unlock =3D sta2x11_regmap_unlock,
-	.max_register =3D APBREG_EMU_PCG_SARAC,
-	.readable_reg =3D sta2x11_apbreg_readable_reg,
-	.writeable_reg =3D sta2x11_apbreg_writeable_reg,
-};
-
-static bool sta2x11_apb_soc_regs_readable_reg(struct device *dev,
-					      unsigned int reg)
-{
-	return reg <=3D PCIE_SoC_INT_ROUTER_STATUS3_REG ||
-		__reg_within_range(reg, DMA_IP_CTRL_REG, SPARE3_RESERVED) ||
-		__reg_within_range(reg, MASTER_LOCK_REG,
-				   SYSTEM_CONFIG_STATUS_REG) ||
-		reg =3D=3D MSP_CLK_CTRL_REG ||
-		__reg_within_range(reg, COMPENSATION_REG1, TEST_CTL_REG);
-}
-
-static bool sta2x11_apb_soc_regs_writeable_reg(struct device *dev,
-					       unsigned int reg)
-{
-	if (!sta2x11_apb_soc_regs_readable_reg(dev, reg))
-		return false;
-	switch (reg) {
-	case PCIE_COMMON_CLOCK_CONFIG_0_4_0:
-	case SYSTEM_CONFIG_STATUS_REG:
-	case COMPENSATION_REG1:
-	case PCIE_SoC_INT_ROUTER_STATUS0_REG...PCIE_SoC_INT_ROUTER_STATUS3_REG:
-	case PCIE_PM_STATUS_0_PORT_0_4...PCIE_PM_STATUS_7_0_EP4:
-		return false;
-	default:
-		return true;
-	}
-}
-
-static struct regmap_config sta2x11_apb_soc_regs_regmap_config =3D {
-	.reg_bits =3D 32,
-	.reg_stride =3D 4,
-	.val_bits =3D 32,
-	.lock =3D sta2x11_regmap_lock,
-	.unlock =3D sta2x11_regmap_unlock,
-	.max_register =3D TEST_CTL_REG,
-	.readable_reg =3D sta2x11_apb_soc_regs_readable_reg,
-	.writeable_reg =3D sta2x11_apb_soc_regs_writeable_reg,
-};
-
-static struct regmap_config *
-sta2x11_mfd_regmap_configs[sta2x11_n_mfd_plat_devs] =3D {
-	[sta2x11_sctl] =3D &sta2x11_sctl_regmap_config,
-	[sta2x11_apbreg] =3D &sta2x11_apbreg_regmap_config,
-	[sta2x11_apb_soc_regs] =3D &sta2x11_apb_soc_regs_regmap_config,
-	[sta2x11_scr] =3D &sta2x11_scr_regmap_config,
-};
-
-/* Probe for the four platform devices */
-
-static int sta2x11_mfd_platform_probe(struct platform_device *dev,
-				      enum sta2x11_mfd_plat_dev index)
-{
-	struct pci_dev **pdev;
-	struct sta2x11_mfd *mfd;
-	struct resource *res;
-	const char *name =3D sta2x11_mfd_names[index];
-	struct regmap_config *regmap_config =3D sta2x11_mfd_regmap_configs[inde=
x];
-
-	pdev =3D dev_get_platdata(&dev->dev);
-	mfd =3D sta2x11_mfd_find(*pdev);
-	if (!mfd)
-		return -ENODEV;
-	if (!regmap_config)
-		return -ENODEV;
-
-	res =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENOMEM;
-
-	if (!request_mem_region(res->start, resource_size(res), name))
-		return -EBUSY;
-
-	mfd->regs[index] =3D ioremap(res->start, resource_size(res));
-	if (!mfd->regs[index]) {
-		release_mem_region(res->start, resource_size(res));
-		return -ENOMEM;
-	}
-	regmap_config->lock_arg =3D &mfd->lock;
-	/*
-	   No caching, registers could be reached both via regmap and via
-	   void __iomem *
-	*/
-	regmap_config->cache_type =3D REGCACHE_NONE;
-	mfd->regmap[index] =3D devm_regmap_init_mmio(&dev->dev, mfd->regs[index=
],
-						   regmap_config);
-	WARN_ON(IS_ERR(mfd->regmap[index]));
-
-	return 0;
-}
-
-static int sta2x11_sctl_probe(struct platform_device *dev)
-{
-	return sta2x11_mfd_platform_probe(dev, sta2x11_sctl);
-}
-
-static int sta2x11_apbreg_probe(struct platform_device *dev)
-{
-	return sta2x11_mfd_platform_probe(dev, sta2x11_apbreg);
-}
-
-static int sta2x11_apb_soc_regs_probe(struct platform_device *dev)
-{
-	return sta2x11_mfd_platform_probe(dev, sta2x11_apb_soc_regs);
-}
-
-static int sta2x11_scr_probe(struct platform_device *dev)
-{
-	return sta2x11_mfd_platform_probe(dev, sta2x11_scr);
-}
-
-/* The three platform drivers */
-static struct platform_driver sta2x11_sctl_platform_driver =3D {
-	.driver =3D {
-		.name	=3D STA2X11_MFD_SCTL_NAME,
-	},
-	.probe		=3D sta2x11_sctl_probe,
-};
-
-static struct platform_driver sta2x11_platform_driver =3D {
-	.driver =3D {
-		.name	=3D STA2X11_MFD_APBREG_NAME,
-	},
-	.probe		=3D sta2x11_apbreg_probe,
-};
-
-static struct platform_driver sta2x11_apb_soc_regs_platform_driver =3D {
-	.driver =3D {
-		.name	=3D STA2X11_MFD_APB_SOC_REGS_NAME,
-	},
-	.probe		=3D sta2x11_apb_soc_regs_probe,
-};
-
-static struct platform_driver sta2x11_scr_platform_driver =3D {
-	.driver =3D {
-		.name =3D STA2X11_MFD_SCR_NAME,
-	},
-	.probe =3D sta2x11_scr_probe,
-};
-
-static struct platform_driver * const drivers[] =3D {
-	&sta2x11_platform_driver,
-	&sta2x11_sctl_platform_driver,
-	&sta2x11_apb_soc_regs_platform_driver,
-	&sta2x11_scr_platform_driver,
-};
-
-static int __init sta2x11_drivers_init(void)
-{
-	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));
-}
-
-/*
- * What follows are the PCI devices that host the above pdevs.
- * Each logic block is 4kB and they are all consecutive: we use this inf=
o.
- */
-
-/* Mfd 0 device */
-
-/* Mfd 0, Bar 0 */
-enum mfd0_bar0_cells {
-	STA2X11_GPIO_0 =3D 0,
-	STA2X11_GPIO_1,
-	STA2X11_GPIO_2,
-	STA2X11_GPIO_3,
-	STA2X11_SCTL,
-	STA2X11_SCR,
-	STA2X11_TIME,
-};
-/* Mfd 0 , Bar 1 */
-enum mfd0_bar1_cells {
-	STA2X11_APBREG =3D 0,
-};
-#define CELL_4K(_name, _cell) { \
-		.name =3D _name, \
-		.start =3D _cell * 4096, .end =3D _cell * 4096 + 4095, \
-		.flags =3D IORESOURCE_MEM, \
-		}
-
-static const struct resource gpio_resources[] =3D {
-	{
-		/* 4 consecutive cells, 1 driver */
-		.name =3D STA2X11_MFD_GPIO_NAME,
-		.start =3D 0,
-		.end =3D (4 * 4096) - 1,
-		.flags =3D IORESOURCE_MEM,
-	}
-};
-static const struct resource sctl_resources[] =3D {
-	CELL_4K(STA2X11_MFD_SCTL_NAME, STA2X11_SCTL),
-};
-static const struct resource scr_resources[] =3D {
-	CELL_4K(STA2X11_MFD_SCR_NAME, STA2X11_SCR),
-};
-static const struct resource time_resources[] =3D {
-	CELL_4K(STA2X11_MFD_TIME_NAME, STA2X11_TIME),
-};
-
-static const struct resource apbreg_resources[] =3D {
-	CELL_4K(STA2X11_MFD_APBREG_NAME, STA2X11_APBREG),
-};
-
-#define DEV(_name, _r) \
-	{ .name =3D _name, .num_resources =3D ARRAY_SIZE(_r), .resources =3D _r=
, }
-
-static struct mfd_cell sta2x11_mfd0_bar0[] =3D {
-	/* offset 0: we add pdata later */
-	DEV(STA2X11_MFD_GPIO_NAME, gpio_resources),
-	DEV(STA2X11_MFD_SCTL_NAME, sctl_resources),
-	DEV(STA2X11_MFD_SCR_NAME,  scr_resources),
-	DEV(STA2X11_MFD_TIME_NAME, time_resources),
-};
-
-static struct mfd_cell sta2x11_mfd0_bar1[] =3D {
-	DEV(STA2X11_MFD_APBREG_NAME, apbreg_resources),
-};
-
-/* Mfd 1 devices */
-
-/* Mfd 1, Bar 0 */
-enum mfd1_bar0_cells {
-	STA2X11_VIC =3D 0,
-};
-
-/* Mfd 1, Bar 1 */
-enum mfd1_bar1_cells {
-	STA2X11_APB_SOC_REGS =3D 0,
-};
-
-static const struct resource vic_resources[] =3D {
-	CELL_4K(STA2X11_MFD_VIC_NAME, STA2X11_VIC),
-};
-
-static const struct resource apb_soc_regs_resources[] =3D {
-	CELL_4K(STA2X11_MFD_APB_SOC_REGS_NAME, STA2X11_APB_SOC_REGS),
-};
-
-static struct mfd_cell sta2x11_mfd1_bar0[] =3D {
-	DEV(STA2X11_MFD_VIC_NAME, vic_resources),
-};
-
-static struct mfd_cell sta2x11_mfd1_bar1[] =3D {
-	DEV(STA2X11_MFD_APB_SOC_REGS_NAME, apb_soc_regs_resources),
-};
-
-
-static int sta2x11_mfd_suspend(struct pci_dev *pdev, pm_message_t state)
-{
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int sta2x11_mfd_resume(struct pci_dev *pdev)
-{
-	int err;
-
-	pci_set_power_state(pdev, PCI_D0);
-	err =3D pci_enable_device(pdev);
-	if (err)
-		return err;
-	pci_restore_state(pdev);
-
-	return 0;
-}
-
-struct sta2x11_mfd_bar_setup_data {
-	struct mfd_cell *cells;
-	int ncells;
-};
-
-struct sta2x11_mfd_setup_data {
-	struct sta2x11_mfd_bar_setup_data bars[2];
-};
-
-#define STA2X11_MFD0 0
-#define STA2X11_MFD1 1
-
-static struct sta2x11_mfd_setup_data mfd_setup_data[] =3D {
-	/* Mfd 0: gpio, sctl, scr, timers / apbregs */
-	[STA2X11_MFD0] =3D {
-		.bars =3D {
-			[0] =3D {
-				.cells =3D sta2x11_mfd0_bar0,
-				.ncells =3D ARRAY_SIZE(sta2x11_mfd0_bar0),
-			},
-			[1] =3D {
-				.cells =3D sta2x11_mfd0_bar1,
-				.ncells =3D ARRAY_SIZE(sta2x11_mfd0_bar1),
-			},
-		},
-	},
-	/* Mfd 1: vic / apb-soc-regs */
-	[STA2X11_MFD1] =3D {
-		.bars =3D {
-			[0] =3D {
-				.cells =3D sta2x11_mfd1_bar0,
-				.ncells =3D ARRAY_SIZE(sta2x11_mfd1_bar0),
-			},
-			[1] =3D {
-				.cells =3D sta2x11_mfd1_bar1,
-				.ncells =3D ARRAY_SIZE(sta2x11_mfd1_bar1),
-			},
-		},
-	},
-};
-
-static void sta2x11_mfd_setup(struct pci_dev *pdev,
-			      struct sta2x11_mfd_setup_data *sd)
-{
-	int i, j;
-	for (i =3D 0; i < ARRAY_SIZE(sd->bars); i++)
-		for (j =3D 0; j < sd->bars[i].ncells; j++) {
-			sd->bars[i].cells[j].pdata_size =3D sizeof(pdev);
-			sd->bars[i].cells[j].platform_data =3D &pdev;
-		}
-}
-
-static int sta2x11_mfd_probe(struct pci_dev *pdev,
-			     const struct pci_device_id *pci_id)
-{
-	int err, i;
-	struct sta2x11_mfd_setup_data *setup_data;
-
-	dev_info(&pdev->dev, "%s\n", __func__);
-
-	err =3D pci_enable_device(pdev);
-	if (err) {
-		dev_err(&pdev->dev, "Can't enable device.\n");
-		return err;
-	}
-
-	err =3D pci_enable_msi(pdev);
-	if (err)
-		dev_info(&pdev->dev, "Enable msi failed\n");
-
-	setup_data =3D pci_id->device =3D=3D PCI_DEVICE_ID_STMICRO_GPIO ?
-		&mfd_setup_data[STA2X11_MFD0] :
-		&mfd_setup_data[STA2X11_MFD1];
-
-	/* platform data is the pci device for all of them */
-	sta2x11_mfd_setup(pdev, setup_data);
-
-	/* Record this pdev before mfd_add_devices: their probe looks for it */
-	if (!sta2x11_mfd_find(pdev))
-		sta2x11_mfd_add(pdev, GFP_KERNEL);
-
-	/* Just 2 bars for all mfd's at present */
-	for (i =3D 0; i < 2; i++) {
-		err =3D mfd_add_devices(&pdev->dev, -1,
-				      setup_data->bars[i].cells,
-				      setup_data->bars[i].ncells,
-				      &pdev->resource[i],
-				      0, NULL);
-		if (err) {
-			dev_err(&pdev->dev,
-				"mfd_add_devices[%d] failed: %d\n", i, err);
-			goto err_disable;
-		}
-	}
-
-	return 0;
-
-err_disable:
-	mfd_remove_devices(&pdev->dev);
-	pci_disable_device(pdev);
-	pci_disable_msi(pdev);
-	return err;
-}
-
-static const struct pci_device_id sta2x11_mfd_tbl[] =3D {
-	{PCI_DEVICE(PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_GPIO)},
-	{PCI_DEVICE(PCI_VENDOR_ID_STMICRO, PCI_DEVICE_ID_STMICRO_VIC)},
-	{0,},
-};
-
-static struct pci_driver sta2x11_mfd_driver =3D {
-	.name =3D		"sta2x11-mfd",
-	.id_table =3D	sta2x11_mfd_tbl,
-	.probe =3D	sta2x11_mfd_probe,
-	.suspend =3D	sta2x11_mfd_suspend,
-	.resume =3D	sta2x11_mfd_resume,
-};
-
-static int __init sta2x11_mfd_init(void)
-{
-	pr_info("%s\n", __func__);
-	return pci_register_driver(&sta2x11_mfd_driver);
-}
-
-/*
- * All of this must be ready before "normal" devices like MMCI appear.
- * But MFD (the pci device) can't be too early. The following choice
- * prepares platform drivers very early and probe the PCI device later,
- * but before other PCI devices.
- */
-subsys_initcall(sta2x11_drivers_init);
-rootfs_initcall(sta2x11_mfd_init);
diff --git a/include/linux/mfd/sta2x11-mfd.h b/include/linux/mfd/sta2x11-=
mfd.h
deleted file mode 100644
index 2001ca5c44a9..000000000000
--- a/include/linux/mfd/sta2x11-mfd.h
+++ /dev/null
@@ -1,506 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2009-2011 Wind River Systems, Inc.
- * Copyright (c) 2011 ST Microelectronics (Alessandro Rubini)
- *
- * The STMicroelectronics ConneXt (STA2X11) chip has several unrelated
- * functions in one PCI endpoint functions. This driver simply
- * registers the platform devices in this iomemregion and exports a few
- * functions to access common registers
- */
-
-#ifndef __STA2X11_MFD_H
-#define __STA2X11_MFD_H
-#include <linux/types.h>
-#include <linux/pci.h>
-
-enum sta2x11_mfd_plat_dev {
-	sta2x11_sctl =3D 0,
-	sta2x11_gpio,
-	sta2x11_scr,
-	sta2x11_time,
-	sta2x11_apbreg,
-	sta2x11_apb_soc_regs,
-	sta2x11_vic,
-	sta2x11_n_mfd_plat_devs,
-};
-
-#define STA2X11_MFD_SCTL_NAME	       "sta2x11-sctl"
-#define STA2X11_MFD_GPIO_NAME	       "sta2x11-gpio"
-#define STA2X11_MFD_SCR_NAME	       "sta2x11-scr"
-#define STA2X11_MFD_TIME_NAME	       "sta2x11-time"
-#define STA2X11_MFD_APBREG_NAME	       "sta2x11-apbreg"
-#define STA2X11_MFD_APB_SOC_REGS_NAME  "sta2x11-apb-soc-regs"
-#define STA2X11_MFD_VIC_NAME	       "sta2x11-vic"
-
-extern u32
-__sta2x11_mfd_mask(struct pci_dev *, u32, u32, u32, enum sta2x11_mfd_pla=
t_dev);
-
-/*
- * The MFD PCI block includes the GPIO peripherals and other register bl=
ocks.
- * For GPIO, we have 32*4 bits (I use "gsta" for "gpio sta2x11".)
- */
-#define GSTA_GPIO_PER_BLOCK	32
-#define GSTA_NR_BLOCKS		4
-#define GSTA_NR_GPIO		(GSTA_GPIO_PER_BLOCK * GSTA_NR_BLOCKS)
-
-/* Pinconfig is set by the board definition: altfunc, pull-up, pull-down=
 */
-struct sta2x11_gpio_pdata {
-	unsigned pinconfig[GSTA_NR_GPIO];
-};
-
-/* Macros below lifted from sh_pfc.h, with minor differences */
-#define PINMUX_TYPE_NONE		0
-#define PINMUX_TYPE_FUNCTION		1
-#define PINMUX_TYPE_OUTPUT_LOW		2
-#define PINMUX_TYPE_OUTPUT_HIGH		3
-#define PINMUX_TYPE_INPUT		4
-#define PINMUX_TYPE_INPUT_PULLUP	5
-#define PINMUX_TYPE_INPUT_PULLDOWN	6
-
-/* Give names to GPIO pins, like PXA does, taken from the manual */
-#define STA2X11_GPIO0			0
-#define STA2X11_GPIO1			1
-#define STA2X11_GPIO2			2
-#define STA2X11_GPIO3			3
-#define STA2X11_GPIO4			4
-#define STA2X11_GPIO5			5
-#define STA2X11_GPIO6			6
-#define STA2X11_GPIO7			7
-#define STA2X11_GPIO8_RGBOUT_RED7	8
-#define STA2X11_GPIO9_RGBOUT_RED6	9
-#define STA2X11_GPIO10_RGBOUT_RED5	10
-#define STA2X11_GPIO11_RGBOUT_RED4	11
-#define STA2X11_GPIO12_RGBOUT_RED3	12
-#define STA2X11_GPIO13_RGBOUT_RED2	13
-#define STA2X11_GPIO14_RGBOUT_RED1	14
-#define STA2X11_GPIO15_RGBOUT_RED0	15
-#define STA2X11_GPIO16_RGBOUT_GREEN7	16
-#define STA2X11_GPIO17_RGBOUT_GREEN6	17
-#define STA2X11_GPIO18_RGBOUT_GREEN5	18
-#define STA2X11_GPIO19_RGBOUT_GREEN4	19
-#define STA2X11_GPIO20_RGBOUT_GREEN3	20
-#define STA2X11_GPIO21_RGBOUT_GREEN2	21
-#define STA2X11_GPIO22_RGBOUT_GREEN1	22
-#define STA2X11_GPIO23_RGBOUT_GREEN0	23
-#define STA2X11_GPIO24_RGBOUT_BLUE7	24
-#define STA2X11_GPIO25_RGBOUT_BLUE6	25
-#define STA2X11_GPIO26_RGBOUT_BLUE5	26
-#define STA2X11_GPIO27_RGBOUT_BLUE4	27
-#define STA2X11_GPIO28_RGBOUT_BLUE3	28
-#define STA2X11_GPIO29_RGBOUT_BLUE2	29
-#define STA2X11_GPIO30_RGBOUT_BLUE1	30
-#define STA2X11_GPIO31_RGBOUT_BLUE0	31
-#define STA2X11_GPIO32_RGBOUT_VSYNCH	32
-#define STA2X11_GPIO33_RGBOUT_HSYNCH	33
-#define STA2X11_GPIO34_RGBOUT_DEN	34
-#define STA2X11_GPIO35_ETH_CRS_DV	35
-#define STA2X11_GPIO36_ETH_TXD1		36
-#define STA2X11_GPIO37_ETH_TXD0		37
-#define STA2X11_GPIO38_ETH_TX_EN	38
-#define STA2X11_GPIO39_MDIO		39
-#define STA2X11_GPIO40_ETH_REF_CLK	40
-#define STA2X11_GPIO41_ETH_RXD1		41
-#define STA2X11_GPIO42_ETH_RXD0		42
-#define STA2X11_GPIO43_MDC		43
-#define STA2X11_GPIO44_CAN_TX		44
-#define STA2X11_GPIO45_CAN_RX		45
-#define STA2X11_GPIO46_MLB_DAT		46
-#define STA2X11_GPIO47_MLB_SIG		47
-#define STA2X11_GPIO48_SPI0_CLK		48
-#define STA2X11_GPIO49_SPI0_TXD		49
-#define STA2X11_GPIO50_SPI0_RXD		50
-#define STA2X11_GPIO51_SPI0_FRM		51
-#define STA2X11_GPIO52_SPI1_CLK		52
-#define STA2X11_GPIO53_SPI1_TXD		53
-#define STA2X11_GPIO54_SPI1_RXD		54
-#define STA2X11_GPIO55_SPI1_FRM		55
-#define STA2X11_GPIO56_SPI2_CLK		56
-#define STA2X11_GPIO57_SPI2_TXD		57
-#define STA2X11_GPIO58_SPI2_RXD		58
-#define STA2X11_GPIO59_SPI2_FRM		59
-#define STA2X11_GPIO60_I2C0_SCL		60
-#define STA2X11_GPIO61_I2C0_SDA		61
-#define STA2X11_GPIO62_I2C1_SCL		62
-#define STA2X11_GPIO63_I2C1_SDA		63
-#define STA2X11_GPIO64_I2C2_SCL		64
-#define STA2X11_GPIO65_I2C2_SDA		65
-#define STA2X11_GPIO66_I2C3_SCL		66
-#define STA2X11_GPIO67_I2C3_SDA		67
-#define STA2X11_GPIO68_MSP0_RCK		68
-#define STA2X11_GPIO69_MSP0_RXD		69
-#define STA2X11_GPIO70_MSP0_RFS		70
-#define STA2X11_GPIO71_MSP0_TCK		71
-#define STA2X11_GPIO72_MSP0_TXD		72
-#define STA2X11_GPIO73_MSP0_TFS		73
-#define STA2X11_GPIO74_MSP0_SCK		74
-#define STA2X11_GPIO75_MSP1_CK		75
-#define STA2X11_GPIO76_MSP1_RXD		76
-#define STA2X11_GPIO77_MSP1_FS		77
-#define STA2X11_GPIO78_MSP1_TXD		78
-#define STA2X11_GPIO79_MSP2_CK		79
-#define STA2X11_GPIO80_MSP2_RXD		80
-#define STA2X11_GPIO81_MSP2_FS		81
-#define STA2X11_GPIO82_MSP2_TXD		82
-#define STA2X11_GPIO83_MSP3_CK		83
-#define STA2X11_GPIO84_MSP3_RXD		84
-#define STA2X11_GPIO85_MSP3_FS		85
-#define STA2X11_GPIO86_MSP3_TXD		86
-#define STA2X11_GPIO87_MSP4_CK		87
-#define STA2X11_GPIO88_MSP4_RXD		88
-#define STA2X11_GPIO89_MSP4_FS		89
-#define STA2X11_GPIO90_MSP4_TXD		90
-#define STA2X11_GPIO91_MSP5_CK		91
-#define STA2X11_GPIO92_MSP5_RXD		92
-#define STA2X11_GPIO93_MSP5_FS		93
-#define STA2X11_GPIO94_MSP5_TXD		94
-#define STA2X11_GPIO95_SDIO3_DAT3	95
-#define STA2X11_GPIO96_SDIO3_DAT2	96
-#define STA2X11_GPIO97_SDIO3_DAT1	97
-#define STA2X11_GPIO98_SDIO3_DAT0	98
-#define STA2X11_GPIO99_SDIO3_CLK	99
-#define STA2X11_GPIO100_SDIO3_CMD	100
-#define STA2X11_GPIO101			101
-#define STA2X11_GPIO102			102
-#define STA2X11_GPIO103			103
-#define STA2X11_GPIO104			104
-#define STA2X11_GPIO105_SDIO2_DAT3	105
-#define STA2X11_GPIO106_SDIO2_DAT2	106
-#define STA2X11_GPIO107_SDIO2_DAT1	107
-#define STA2X11_GPIO108_SDIO2_DAT0	108
-#define STA2X11_GPIO109_SDIO2_CLK	109
-#define STA2X11_GPIO110_SDIO2_CMD	110
-#define STA2X11_GPIO111			111
-#define STA2X11_GPIO112			112
-#define STA2X11_GPIO113			113
-#define STA2X11_GPIO114			114
-#define STA2X11_GPIO115_SDIO1_DAT3	115
-#define STA2X11_GPIO116_SDIO1_DAT2	116
-#define STA2X11_GPIO117_SDIO1_DAT1	117
-#define STA2X11_GPIO118_SDIO1_DAT0	118
-#define STA2X11_GPIO119_SDIO1_CLK	119
-#define STA2X11_GPIO120_SDIO1_CMD	120
-#define STA2X11_GPIO121			121
-#define STA2X11_GPIO122			122
-#define STA2X11_GPIO123			123
-#define STA2X11_GPIO124			124
-#define STA2X11_GPIO125_UART2_TXD	125
-#define STA2X11_GPIO126_UART2_RXD	126
-#define STA2X11_GPIO127_UART3_TXD	127
-
-/*
- * The APB bridge has its own registers, needed by our users as well.
- * They are accessed with the following read/mask/write function.
- */
-static inline u32
-sta2x11_apbreg_mask(struct pci_dev *pdev, u32 reg, u32 mask, u32 val)
-{
-	return __sta2x11_mfd_mask(pdev, reg, mask, val, sta2x11_apbreg);
-}
-
-/* CAN and MLB */
-#define APBREG_BSR	0x00	/* Bridge Status Reg */
-#define APBREG_PAER	0x08	/* Peripherals Address Error Reg */
-#define APBREG_PWAC	0x20	/* Peripheral Write Access Control reg */
-#define APBREG_PRAC	0x40	/* Peripheral Read Access Control reg */
-#define APBREG_PCG	0x60	/* Peripheral Clock Gating Reg */
-#define APBREG_PUR	0x80	/* Peripheral Under Reset Reg */
-#define APBREG_EMU_PCG	0xA0	/* Emulator Peripheral Clock Gating Reg */
-
-#define APBREG_CAN	(1 << 1)
-#define APBREG_MLB	(1 << 3)
-
-/* SARAC */
-#define APBREG_BSR_SARAC     0x100 /* Bridge Status Reg */
-#define APBREG_PAER_SARAC    0x108 /* Peripherals Address Error Reg */
-#define APBREG_PWAC_SARAC    0x120 /* Peripheral Write Access Control re=
g */
-#define APBREG_PRAC_SARAC    0x140 /* Peripheral Read Access Control reg=
 */
-#define APBREG_PCG_SARAC     0x160 /* Peripheral Clock Gating Reg */
-#define APBREG_PUR_SARAC     0x180 /* Peripheral Under Reset Reg */
-#define APBREG_EMU_PCG_SARAC 0x1A0 /* Emulator Peripheral Clock Gating R=
eg */
-
-#define APBREG_SARAC	(1 << 2)
-
-/*
- * The system controller has its own registers. Some of these are access=
ed
- * by out users as well, using the following read/mask/write/function
- */
-static inline
-u32 sta2x11_sctl_mask(struct pci_dev *pdev, u32 reg, u32 mask, u32 val)
-{
-	return __sta2x11_mfd_mask(pdev, reg, mask, val, sta2x11_sctl);
-}
-
-#define SCTL_SCCTL		0x00	/* System controller control register */
-#define SCTL_ARMCFG		0x04	/* ARM configuration register */
-#define SCTL_SCPLLCTL		0x08	/* PLL control status register */
-
-#define SCTL_SCPLLCTL_AUDIO_PLL_PD	     BIT(1)
-#define SCTL_SCPLLCTL_FRAC_CONTROL	     BIT(3)
-#define SCTL_SCPLLCTL_STRB_BYPASS	     BIT(6)
-#define SCTL_SCPLLCTL_STRB_INPUT	     BIT(8)
-
-#define SCTL_SCPLLFCTRL		0x0c	/* PLL frequency control register */
-
-#define SCTL_SCPLLFCTRL_AUDIO_PLL_NDIV_MASK	0xff
-#define SCTL_SCPLLFCTRL_AUDIO_PLL_NDIV_SHIFT	  10
-#define SCTL_SCPLLFCTRL_AUDIO_PLL_IDF_MASK	   7
-#define SCTL_SCPLLFCTRL_AUDIO_PLL_IDF_SHIFT	  21
-#define SCTL_SCPLLFCTRL_AUDIO_PLL_ODF_MASK	   7
-#define SCTL_SCPLLFCTRL_AUDIO_PLL_ODF_SHIFT	  18
-#define SCTL_SCPLLFCTRL_DITHER_DISABLE_MASK     0x03
-#define SCTL_SCPLLFCTRL_DITHER_DISABLE_SHIFT       4
-
-
-#define SCTL_SCRESFRACT		0x10	/* PLL fractional input register */
-
-#define SCTL_SCRESFRACT_MASK	0x0000ffff
-
-
-#define SCTL_SCRESCTRL1		0x14	/* Peripheral reset control 1 */
-#define SCTL_SCRESXTRL2		0x18	/* Peripheral reset control 2 */
-#define SCTL_SCPEREN0		0x1c	/* Peripheral clock enable register 0 */
-#define SCTL_SCPEREN1		0x20	/* Peripheral clock enable register 1 */
-#define SCTL_SCPEREN2		0x24	/* Peripheral clock enable register 2 */
-#define SCTL_SCGRST		0x28	/* Peripheral global reset */
-#define SCTL_SCPCIECSBRST       0x2c    /* PCIe PAB CSB reset status reg=
ister */
-#define SCTL_SCPCIPMCR1		0x30	/* PCI power management control 1 */
-#define SCTL_SCPCIPMCR2		0x34	/* PCI power management control 2 */
-#define SCTL_SCPCIPMSR1		0x38	/* PCI power management status 1 */
-#define SCTL_SCPCIPMSR2		0x3c	/* PCI power management status 2 */
-#define SCTL_SCPCIPMSR3		0x40	/* PCI power management status 3 */
-#define SCTL_SCINTREN		0x44	/* Interrupt enable */
-#define SCTL_SCRISR		0x48	/* RAW interrupt status */
-#define SCTL_SCCLKSTAT0		0x4c	/* Peripheral clocks status 0 */
-#define SCTL_SCCLKSTAT1		0x50	/* Peripheral clocks status 1 */
-#define SCTL_SCCLKSTAT2		0x54	/* Peripheral clocks status 2 */
-#define SCTL_SCRSTSTA		0x58	/* Reset status register */
-
-#define SCTL_SCRESCTRL1_USB_PHY_POR	(1 << 0)
-#define SCTL_SCRESCTRL1_USB_OTG	(1 << 1)
-#define SCTL_SCRESCTRL1_USB_HRST	(1 << 2)
-#define SCTL_SCRESCTRL1_USB_PHY_HOST	(1 << 3)
-#define SCTL_SCRESCTRL1_SATAII	(1 << 4)
-#define SCTL_SCRESCTRL1_VIP		(1 << 5)
-#define SCTL_SCRESCTRL1_PER_MMC0	(1 << 6)
-#define SCTL_SCRESCTRL1_PER_MMC1	(1 << 7)
-#define SCTL_SCRESCTRL1_PER_GPIO0	(1 << 8)
-#define SCTL_SCRESCTRL1_PER_GPIO1	(1 << 9)
-#define SCTL_SCRESCTRL1_PER_GPIO2	(1 << 10)
-#define SCTL_SCRESCTRL1_PER_GPIO3	(1 << 11)
-#define SCTL_SCRESCTRL1_PER_MTU0	(1 << 12)
-#define SCTL_SCRESCTRL1_KER_SPI0	(1 << 13)
-#define SCTL_SCRESCTRL1_KER_SPI1	(1 << 14)
-#define SCTL_SCRESCTRL1_KER_SPI2	(1 << 15)
-#define SCTL_SCRESCTRL1_KER_MCI0	(1 << 16)
-#define SCTL_SCRESCTRL1_KER_MCI1	(1 << 17)
-#define SCTL_SCRESCTRL1_PRE_HSI2C0	(1 << 18)
-#define SCTL_SCRESCTRL1_PER_HSI2C1	(1 << 19)
-#define SCTL_SCRESCTRL1_PER_HSI2C2	(1 << 20)
-#define SCTL_SCRESCTRL1_PER_HSI2C3	(1 << 21)
-#define SCTL_SCRESCTRL1_PER_MSP0	(1 << 22)
-#define SCTL_SCRESCTRL1_PER_MSP1	(1 << 23)
-#define SCTL_SCRESCTRL1_PER_MSP2	(1 << 24)
-#define SCTL_SCRESCTRL1_PER_MSP3	(1 << 25)
-#define SCTL_SCRESCTRL1_PER_MSP4	(1 << 26)
-#define SCTL_SCRESCTRL1_PER_MSP5	(1 << 27)
-#define SCTL_SCRESCTRL1_PER_MMC	(1 << 28)
-#define SCTL_SCRESCTRL1_KER_MSP0	(1 << 29)
-#define SCTL_SCRESCTRL1_KER_MSP1	(1 << 30)
-#define SCTL_SCRESCTRL1_KER_MSP2	(1 << 31)
-
-#define SCTL_SCPEREN0_UART0		(1 << 0)
-#define SCTL_SCPEREN0_UART1		(1 << 1)
-#define SCTL_SCPEREN0_UART2		(1 << 2)
-#define SCTL_SCPEREN0_UART3		(1 << 3)
-#define SCTL_SCPEREN0_MSP0		(1 << 4)
-#define SCTL_SCPEREN0_MSP1		(1 << 5)
-#define SCTL_SCPEREN0_MSP2		(1 << 6)
-#define SCTL_SCPEREN0_MSP3		(1 << 7)
-#define SCTL_SCPEREN0_MSP4		(1 << 8)
-#define SCTL_SCPEREN0_MSP5		(1 << 9)
-#define SCTL_SCPEREN0_SPI0		(1 << 10)
-#define SCTL_SCPEREN0_SPI1		(1 << 11)
-#define SCTL_SCPEREN0_SPI2		(1 << 12)
-#define SCTL_SCPEREN0_I2C0		(1 << 13)
-#define SCTL_SCPEREN0_I2C1		(1 << 14)
-#define SCTL_SCPEREN0_I2C2		(1 << 15)
-#define SCTL_SCPEREN0_I2C3		(1 << 16)
-#define SCTL_SCPEREN0_SVDO_LVDS		(1 << 17)
-#define SCTL_SCPEREN0_USB_HOST		(1 << 18)
-#define SCTL_SCPEREN0_USB_OTG		(1 << 19)
-#define SCTL_SCPEREN0_MCI0		(1 << 20)
-#define SCTL_SCPEREN0_MCI1		(1 << 21)
-#define SCTL_SCPEREN0_MCI2		(1 << 22)
-#define SCTL_SCPEREN0_MCI3		(1 << 23)
-#define SCTL_SCPEREN0_SATA		(1 << 24)
-#define SCTL_SCPEREN0_ETHERNET		(1 << 25)
-#define SCTL_SCPEREN0_VIC		(1 << 26)
-#define SCTL_SCPEREN0_DMA_AUDIO		(1 << 27)
-#define SCTL_SCPEREN0_DMA_SOC		(1 << 28)
-#define SCTL_SCPEREN0_RAM		(1 << 29)
-#define SCTL_SCPEREN0_VIP		(1 << 30)
-#define SCTL_SCPEREN0_ARM		(1 << 31)
-
-#define SCTL_SCPEREN1_UART0		(1 << 0)
-#define SCTL_SCPEREN1_UART1		(1 << 1)
-#define SCTL_SCPEREN1_UART2		(1 << 2)
-#define SCTL_SCPEREN1_UART3		(1 << 3)
-#define SCTL_SCPEREN1_MSP0		(1 << 4)
-#define SCTL_SCPEREN1_MSP1		(1 << 5)
-#define SCTL_SCPEREN1_MSP2		(1 << 6)
-#define SCTL_SCPEREN1_MSP3		(1 << 7)
-#define SCTL_SCPEREN1_MSP4		(1 << 8)
-#define SCTL_SCPEREN1_MSP5		(1 << 9)
-#define SCTL_SCPEREN1_SPI0		(1 << 10)
-#define SCTL_SCPEREN1_SPI1		(1 << 11)
-#define SCTL_SCPEREN1_SPI2		(1 << 12)
-#define SCTL_SCPEREN1_I2C0		(1 << 13)
-#define SCTL_SCPEREN1_I2C1		(1 << 14)
-#define SCTL_SCPEREN1_I2C2		(1 << 15)
-#define SCTL_SCPEREN1_I2C3		(1 << 16)
-#define SCTL_SCPEREN1_USB_PHY		(1 << 17)
-
-/*
- * APB-SOC registers
- */
-static inline
-u32 sta2x11_apb_soc_regs_mask(struct pci_dev *pdev, u32 reg, u32 mask, u=
32 val)
-{
-	return __sta2x11_mfd_mask(pdev, reg, mask, val, sta2x11_apb_soc_regs);
-}
-
-#define PCIE_EP1_FUNC3_0_INTR_REG	0x000
-#define PCIE_EP1_FUNC7_4_INTR_REG	0x004
-#define PCIE_EP2_FUNC3_0_INTR_REG	0x008
-#define PCIE_EP2_FUNC7_4_INTR_REG	0x00c
-#define PCIE_EP3_FUNC3_0_INTR_REG	0x010
-#define PCIE_EP3_FUNC7_4_INTR_REG	0x014
-#define PCIE_EP4_FUNC3_0_INTR_REG	0x018
-#define PCIE_EP4_FUNC7_4_INTR_REG	0x01c
-#define PCIE_INTR_ENABLE0_REG		0x020
-#define PCIE_INTR_ENABLE1_REG		0x024
-#define PCIE_EP1_FUNC_TC_REG		0x028
-#define PCIE_EP2_FUNC_TC_REG		0x02c
-#define PCIE_EP3_FUNC_TC_REG		0x030
-#define PCIE_EP4_FUNC_TC_REG		0x034
-#define PCIE_EP1_FUNC_F_REG		0x038
-#define PCIE_EP2_FUNC_F_REG		0x03c
-#define PCIE_EP3_FUNC_F_REG		0x040
-#define PCIE_EP4_FUNC_F_REG		0x044
-#define PCIE_PAB_AMBA_SW_RST_REG	0x048
-#define PCIE_PM_STATUS_0_PORT_0_4	0x04c
-#define PCIE_PM_STATUS_7_0_EP1		0x050
-#define PCIE_PM_STATUS_7_0_EP2		0x054
-#define PCIE_PM_STATUS_7_0_EP3		0x058
-#define PCIE_PM_STATUS_7_0_EP4		0x05c
-#define PCIE_DEV_ID_0_EP1_REG		0x060
-#define PCIE_CC_REV_ID_0_EP1_REG	0x064
-#define PCIE_DEV_ID_1_EP1_REG		0x068
-#define PCIE_CC_REV_ID_1_EP1_REG	0x06c
-#define PCIE_DEV_ID_2_EP1_REG		0x070
-#define PCIE_CC_REV_ID_2_EP1_REG	0x074
-#define PCIE_DEV_ID_3_EP1_REG		0x078
-#define PCIE_CC_REV_ID_3_EP1_REG	0x07c
-#define PCIE_DEV_ID_4_EP1_REG		0x080
-#define PCIE_CC_REV_ID_4_EP1_REG	0x084
-#define PCIE_DEV_ID_5_EP1_REG		0x088
-#define PCIE_CC_REV_ID_5_EP1_REG	0x08c
-#define PCIE_DEV_ID_6_EP1_REG		0x090
-#define PCIE_CC_REV_ID_6_EP1_REG	0x094
-#define PCIE_DEV_ID_7_EP1_REG		0x098
-#define PCIE_CC_REV_ID_7_EP1_REG	0x09c
-#define PCIE_DEV_ID_0_EP2_REG		0x0a0
-#define PCIE_CC_REV_ID_0_EP2_REG	0x0a4
-#define PCIE_DEV_ID_1_EP2_REG		0x0a8
-#define PCIE_CC_REV_ID_1_EP2_REG	0x0ac
-#define PCIE_DEV_ID_2_EP2_REG		0x0b0
-#define PCIE_CC_REV_ID_2_EP2_REG	0x0b4
-#define PCIE_DEV_ID_3_EP2_REG		0x0b8
-#define PCIE_CC_REV_ID_3_EP2_REG	0x0bc
-#define PCIE_DEV_ID_4_EP2_REG		0x0c0
-#define PCIE_CC_REV_ID_4_EP2_REG	0x0c4
-#define PCIE_DEV_ID_5_EP2_REG		0x0c8
-#define PCIE_CC_REV_ID_5_EP2_REG	0x0cc
-#define PCIE_DEV_ID_6_EP2_REG		0x0d0
-#define PCIE_CC_REV_ID_6_EP2_REG	0x0d4
-#define PCIE_DEV_ID_7_EP2_REG		0x0d8
-#define PCIE_CC_REV_ID_7_EP2_REG	0x0dC
-#define PCIE_DEV_ID_0_EP3_REG		0x0e0
-#define PCIE_CC_REV_ID_0_EP3_REG	0x0e4
-#define PCIE_DEV_ID_1_EP3_REG		0x0e8
-#define PCIE_CC_REV_ID_1_EP3_REG	0x0ec
-#define PCIE_DEV_ID_2_EP3_REG		0x0f0
-#define PCIE_CC_REV_ID_2_EP3_REG	0x0f4
-#define PCIE_DEV_ID_3_EP3_REG		0x0f8
-#define PCIE_CC_REV_ID_3_EP3_REG	0x0fc
-#define PCIE_DEV_ID_4_EP3_REG		0x100
-#define PCIE_CC_REV_ID_4_EP3_REG	0x104
-#define PCIE_DEV_ID_5_EP3_REG		0x108
-#define PCIE_CC_REV_ID_5_EP3_REG	0x10c
-#define PCIE_DEV_ID_6_EP3_REG		0x110
-#define PCIE_CC_REV_ID_6_EP3_REG	0x114
-#define PCIE_DEV_ID_7_EP3_REG		0x118
-#define PCIE_CC_REV_ID_7_EP3_REG	0x11c
-#define PCIE_DEV_ID_0_EP4_REG		0x120
-#define PCIE_CC_REV_ID_0_EP4_REG	0x124
-#define PCIE_DEV_ID_1_EP4_REG		0x128
-#define PCIE_CC_REV_ID_1_EP4_REG	0x12c
-#define PCIE_DEV_ID_2_EP4_REG		0x130
-#define PCIE_CC_REV_ID_2_EP4_REG	0x134
-#define PCIE_DEV_ID_3_EP4_REG		0x138
-#define PCIE_CC_REV_ID_3_EP4_REG	0x13c
-#define PCIE_DEV_ID_4_EP4_REG		0x140
-#define PCIE_CC_REV_ID_4_EP4_REG	0x144
-#define PCIE_DEV_ID_5_EP4_REG		0x148
-#define PCIE_CC_REV_ID_5_EP4_REG	0x14c
-#define PCIE_DEV_ID_6_EP4_REG		0x150
-#define PCIE_CC_REV_ID_6_EP4_REG	0x154
-#define PCIE_DEV_ID_7_EP4_REG		0x158
-#define PCIE_CC_REV_ID_7_EP4_REG	0x15c
-#define PCIE_SUBSYS_VEN_ID_REG		0x160
-#define PCIE_COMMON_CLOCK_CONFIG_0_4_0	0x164
-#define PCIE_MIPHYP_SSC_EN_REG		0x168
-#define PCIE_MIPHYP_ADDR_REG		0x16c
-#define PCIE_L1_ASPM_READY_REG		0x170
-#define PCIE_EXT_CFG_RDY_REG		0x174
-#define PCIE_SoC_INT_ROUTER_STATUS0_REG 0x178
-#define PCIE_SoC_INT_ROUTER_STATUS1_REG 0x17c
-#define PCIE_SoC_INT_ROUTER_STATUS2_REG 0x180
-#define PCIE_SoC_INT_ROUTER_STATUS3_REG 0x184
-#define DMA_IP_CTRL_REG			0x324
-#define DISP_BRIDGE_PU_PD_CTRL_REG	0x328
-#define VIP_PU_PD_CTRL_REG		0x32c
-#define USB_MLB_PU_PD_CTRL_REG		0x330
-#define SDIO_PU_PD_MISCFUNC_CTRL_REG1	0x334
-#define SDIO_PU_PD_MISCFUNC_CTRL_REG2	0x338
-#define UART_PU_PD_CTRL_REG		0x33c
-#define ARM_Lock			0x340
-#define SYS_IO_CHAR_REG1		0x344
-#define SYS_IO_CHAR_REG2		0x348
-#define SATA_CORE_ID_REG		0x34c
-#define SATA_CTRL_REG			0x350
-#define I2C_HSFIX_MISC_REG		0x354
-#define SPARE2_RESERVED			0x358
-#define SPARE3_RESERVED			0x35c
-#define MASTER_LOCK_REG			0x368
-#define SYSTEM_CONFIG_STATUS_REG	0x36c
-#define MSP_CLK_CTRL_REG		0x39c
-#define COMPENSATION_REG1		0x3c4
-#define COMPENSATION_REG2		0x3c8
-#define COMPENSATION_REG3		0x3cc
-#define TEST_CTL_REG			0x3d0
-
-/*
- * SECR (OTP) registers
- */
-#define STA2X11_SECR_CR			0x00
-#define STA2X11_SECR_FVR0		0x10
-#define STA2X11_SECR_FVR1		0x14
-
-extern int sta2x11_mfd_get_regs_data(struct platform_device *pdev,
-				     enum sta2x11_mfd_plat_dev index,
-				     void __iomem **regs,
-				     spinlock_t **lock);
-
-#endif /* __STA2X11_MFD_H */
--=20
2.48.1




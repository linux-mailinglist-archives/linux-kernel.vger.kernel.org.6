Return-Path: <linux-kernel+bounces-338330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3AF985684
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F093D1C236C2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012E15CD54;
	Wed, 25 Sep 2024 09:40:05 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5F15A842
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257205; cv=none; b=pKYU1bHfr5ZevsT5WV7mfs0ULCVYLJzz9QUq2rENF33fDkcpmFg0OV1q2Nj8GbPI37IAEJ4dyRhkh3zBuH5T6tEeZrKn2k+6F8QhGdfSubkInKNId8wPelL2DWNrrgJ37S5VnXPfAd0Bc3IaZPyEHi24ylegCe8fL8hHt0N0O3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257205; c=relaxed/simple;
	bh=27dyPNbIgSrPc6iYaew6clNdUTIZn09emFJo6d/m/NM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=twfDNuFTOcFFxpXhd1Oa6GNTD3RT0ObnkVgMc0/RyjhFISiDg9GjptV8dKMzMpvDApaedSQGhoxtdyAAPXAuylO05o+MQrfLNZbDD75BFRXPVznQQtL9WHJeVH6T8yIcypU/I/FcpTpQD6JhYXq8MQjzf4D3b2KauMopxs/COnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466f3da68079-5e970;
	Wed, 25 Sep 2024 17:39:53 +0800 (CST)
X-RM-TRANSID:2ee466f3da68079-5e970
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee866f3da67ff8-c5843;
	Wed, 25 Sep 2024 17:39:52 +0800 (CST)
X-RM-TRANSID:2ee866f3da67ff8-c5843
From: liujing <liujing@cmss.chinamobile.com>
To: arnd@arndb.de
Cc: gregkh@linuxfoundation.org,
	W_Armin@gmx.de,
	hkallweit1@gmail.com,
	jdelvare@suse.de,
	linux-kernel@vger.kernel.org,
	liujing <liujing@cmss.chinamobile.com>
Subject: [PATCH] eeprom: fix cacography of switch
Date: Sat, 21 Sep 2024 18:36:44 +0800
Message-Id: <20240921103644.14667-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
Content-Transfer-Encoding: 8bit

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index 9df12399bda3..cb1c4b8e7fd3 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -97,11 +97,11 @@ config EEPROM_DIGSY_MTC_CFG
 	  If unsure, say N.
 
 config EEPROM_IDT_89HPESX
-	tristate "IDT 89HPESx PCIe-swtiches EEPROM / CSR support"
+	tristate "IDT 89HPESx PCIe-switches EEPROM / CSR support"
 	depends on I2C && SYSFS
 	help
 	  Enable this driver to get read/write access to EEPROM / CSRs
-	  over IDT PCIe-swtich i2c-slave interface.
+	  over IDT PCIe-switch i2c-slave interface.
 
 	  This driver can also be built as a module. If so, the module
 	  will be called idt_89hpesx.
-- 
2.27.0





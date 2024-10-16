Return-Path: <linux-kernel+bounces-367845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D490A9A077D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044D51C220C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE40206E66;
	Wed, 16 Oct 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQwkM9RD"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F5205E36
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074857; cv=none; b=OlZ5+cTUayWFjYzINuhQ67X4cuBUb189jEQgUgSl/O+DX8yAICTU+4RruwrVOBLKwmoFGjwawMx1d/AIgBpNRXJR6OermSg1TA6+GTeWsi3riRGhciMLzWKT+E+vgwYII9qA6RtaBRm2TzA2qX7H8g26ZcDhlEVAmiJMwlxUPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074857; c=relaxed/simple;
	bh=UXXLyzxRETsC1bCs0BzCmf0TqtVoV4wY4aQYvxI2SWM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHUFT4hNiboV7enrZuVtOMSQUBoGY3oppB+oPbWHRJO9HpLdvbyiT5pRnS/TeFYbafWgq2w68u4eatkvbgHdQ1Xgm/JcHxBJ5ekmMNO0KsQlX9XEXNvDyoSsKiWOqhYxzeNvQp7z1SMIV2cDfRJnIFlNeeOxK22/oFbomQ5ZyWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQwkM9RD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso553194a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729074855; x=1729679655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMMW6WISxalccZ13+6+AMnKOcdO+bnf3tzViTwYWYqw=;
        b=MQwkM9RDY78I11tbqhtYY3oCzQLsKuURZyDGuiljVQDuX2wpTVcWJC0KFNgH4ONWdm
         FQvTslV8Zoshhvus05++S34du9S0W2igzqilxJpFXblUopQ+aS/oisby3R0nGl1d0gbY
         JrOJYvRRc9vWvsW0lRUFMabMAYbvNlL7YAWyHq7a/WkWlngsI0QMMMLbXnfbX7WCdw6y
         BZgzPuTOQNPiUm/SZurHNSDo37RuqECOIoUn0g4V63p2WmUr9k2RvwCex2XUd5jfNobx
         664MOHLgb9h8Ao9VG485yKY7uqTOJ+jgE8e+6NMH6M0VzWKfHUmr3mUJQ9Gg4UT8+aYc
         1IQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729074855; x=1729679655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMMW6WISxalccZ13+6+AMnKOcdO+bnf3tzViTwYWYqw=;
        b=MgkmyxZmzPA000+YNn4ukJQ3L6w1fTTiOLyp2EyzHd+u1aTBAA3762RGWiHlOSe2SB
         gzId0FJLNSD2dHBqy/XkmrMx/RGfoTYAh53Y1VDfAs66r7QtOPFMnevFVNug6UeFyZMm
         ow3dBpCV0GCP3G+wPmG8RKd0GyevP1qqqi4PwfQ5gdz2ZsvhRviUcDI5eSYWINRuLwBA
         QQSALSSMWuVvYUf+11uxm6iY/hpl8vehd6X3mB+XJXzEU95VP2vhVeY6IVGz4GM5YI7D
         gsCdPNcXQMDb439mtFi4YNeAXFxhK0dyfdEWOt+TnyHB3HOIPxMjb6TMZe/tPi88adZ0
         q9eA==
X-Forwarded-Encrypted: i=1; AJvYcCWFAhryHVMBsTyVPslsCJmyDXdkJAVu5ADU/lGunA1by5vPkX2zmerIjxEjPuJX6Vrn//4I6VtshxhtoAY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5HAgt9LLCl1hTP/9kYXYJxfOkG05lPa+ney4QINWrDZ7fk3ta
	/4Xyfsb46RWa+ne/M1DKTSNxmyULB6Xf0Sh1UPw8k3BU+A/jAvsb
X-Google-Smtp-Source: AGHT+IFoSo8yfBkITfbAWie1n/b8MsknWXue1dS3xGBRZrEpTKBwLU/aVPHqnpE8nssMoSOL6y0CRA==
X-Received: by 2002:a05:6a20:9743:b0:1d9:651:7d34 with SMTP id adf61e73a8af0-1d90651859emr4405151637.12.1729074855106;
        Wed, 16 Oct 2024 03:34:15 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e774ccfa0sm2852374b3a.177.2024.10.16.03.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 03:34:14 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH v2] staging: gpib: Replace kmalloc/memset with kzalloc.
Date: Wed, 16 Oct 2024 16:04:06 +0530
Message-Id: <20241016103406.1618448-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch replaces kmalloc + memset with kzalloc in the GPIB driver.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
Changes since v1:
 - Merge similar patches in single one
 - Make commit message concise
---
 drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 3 +--
 drivers/staging/gpib/cb7210/cb7210.c                 | 3 +--
 drivers/staging/gpib/gpio/gpib_bitbang.c             | 3 +--
 drivers/staging/gpib/hp_82335/hp82335.c              | 3 +--
 drivers/staging/gpib/hp_82341/hp_82341.c             | 3 +--
 drivers/staging/gpib/ines/ines_gpib.c                | 3 +--
 drivers/staging/gpib/tnt4882/mite.c                  | 4 +---
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c          | 3 +--
 8 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
index 1296db4d47c6..cff555447ee9 100644
--- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
+++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
@@ -518,10 +518,9 @@ void agilent_82350b_return_to_local(gpib_board_t *board)
 int agilent_82350b_allocate_private(gpib_board_t *board)
 
 {
-	board->private_data = kmalloc(sizeof(struct agilent_82350b_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct agilent_82350b_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -ENOMEM;
-	memset(board->private_data, 0, sizeof(struct agilent_82350b_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/cb7210/cb7210.c b/drivers/staging/gpib/cb7210/cb7210.c
index 59f6dde3d966..d32576c21988 100644
--- a/drivers/staging/gpib/cb7210/cb7210.c
+++ b/drivers/staging/gpib/cb7210/cb7210.c
@@ -1199,10 +1199,9 @@ static int cb_gpib_probe(struct pcmcia_device *link)
 	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/* Allocate space for private device-specific data */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
 
 	info->p_dev = link;
 	link->priv = info;
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 81a952beee0d..847e4bea2cb1 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -1105,10 +1105,9 @@ static int bb_line_status(const gpib_board_t *board)
 
 static int allocate_private(gpib_board_t *board)
 {
-	board->private_data = kmalloc(sizeof(struct bb_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct bb_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -1;
-	memset(board->private_data, 0, sizeof(struct bb_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 4e277997684b..cf92fc0b3337 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -201,10 +201,9 @@ return_to_local : hp82335_return_to_local,
 
 int hp82335_allocate_private(gpib_board_t *board)
 {
-	board->private_data = kmalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct hp82335_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -1;
-	memset(board->private_data, 0, sizeof(struct hp82335_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index d37dd8335523..8ad1c885a9fb 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -459,10 +459,9 @@ return_to_local : hp_82341_return_to_local,
 
 int hp_82341_allocate_private(gpib_board_t *board)
 {
-	board->private_data = kmalloc(sizeof(struct hp_82341_priv), GFP_KERNEL);
+	board->private_data = kzalloc(sizeof(struct hp_82341_priv), GFP_KERNEL);
 	if (!board->private_data)
 		return -ENOMEM;
-	memset(board->private_data, 0, sizeof(struct hp_82341_priv));
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index 9dbbdb048b9f..87f9d3789c5f 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -1063,10 +1063,9 @@ static int ines_gpib_probe(struct pcmcia_device *link)
 	DEBUG(0, "%s(0x%p)\n", __func__ link);
 
 	/* Allocate space for private device-specific data */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
 
 	info->p_dev = link;
 	link->priv = info;
diff --git a/drivers/staging/gpib/tnt4882/mite.c b/drivers/staging/gpib/tnt4882/mite.c
index 882cc4bc122e..0edf34d243e9 100644
--- a/drivers/staging/gpib/tnt4882/mite.c
+++ b/drivers/staging/gpib/tnt4882/mite.c
@@ -57,12 +57,10 @@ void mite_init(void)
 	for (pcidev = pci_get_device(PCI_VENDOR_ID_NATINST, PCI_ANY_ID, NULL);
 		pcidev;
 		pcidev = pci_get_device(PCI_VENDOR_ID_NATINST, PCI_ANY_ID, pcidev)) {
-		mite = kmalloc(sizeof(*mite), GFP_KERNEL);
+		mite = kzalloc(sizeof(*mite), GFP_KERNEL);
 		if (!mite)
 			return;
 
-		memset(mite, 0, sizeof(*mite));
-
 		mite->pcidev = pcidev;
 		pci_dev_get(mite->pcidev);
 		mite->next = mite_devices;
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index ef4b9ce36741..0a850926c118 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -1644,10 +1644,9 @@ static int ni_gpib_probe(struct pcmcia_device *link)
 	DEBUG(0, "%s(0x%p)\n", __func__, link);
 
 	/* Allocate space for private device-specific data */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
 
 	info->p_dev = link;
 	link->priv = info;
-- 
2.34.1



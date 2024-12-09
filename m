Return-Path: <linux-kernel+bounces-437404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BBE9E92D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEF1885A1D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DAE221DBE;
	Mon,  9 Dec 2024 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ggtNGOyP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93F221DA6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745132; cv=none; b=QZxpzVmAulEAmfFn8Ob27G+odNYJMhN8AlgK49+Kv+L4yexizYIIheoh8nZtok3U6s/UDleL8FJxvM4jHNZCLxMTzdMgsO5OgtJDMa0eHdVZijrKlHcdb3lMSKZ1q7zqxYXtmnXaiL20oS3r3HI2q92nop0FXrMKpqezYs/I9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745132; c=relaxed/simple;
	bh=zKAUbGmvAgID24Tkc2Jy8LhdxFNgsedeJPeuoBz5fSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tkVvTPg9Ya4Lpk3evgmo8dp0lFtLFAEFrppKdzHsS7hvNL93ahrmm54ub1OH9IbPdpTnNh9Lf1zhqP0loxSb0MULrUtwzYF9jEIc4XUbG/8lWQQwSfmOg3rBDUCrhiYZ3IlyKNy52oImt2fR/LihznWhWWqcxN5cfXv34uFf4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ggtNGOyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733745129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=39hwM53MEQ2TN5uIZ38P4dO6wIvfD25t892amO3OF6o=;
	b=ggtNGOyPRZyQKaGQe5GGxAnTOHsugfRr2Bg1P6u+niTpiePLQNChw4aN1F/nBaNAeeB+H1
	NL35XskXzvMP6Nbj/qPxGUhrGE53VAk1brVjaoy0sa948FGFWLud7TReKshzS1PD/pjuo6
	4NTotyovzE4+zmBV5Q4rI/e80HrciRE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-P0h9U-8LP0aN-JHEX69uzA-1; Mon, 09 Dec 2024 06:52:07 -0500
X-MC-Unique: P0h9U-8LP0aN-JHEX69uzA-1
X-Mimecast-MFC-AGG-ID: P0h9U-8LP0aN-JHEX69uzA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-434e81cad70so15708265e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745126; x=1734349926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39hwM53MEQ2TN5uIZ38P4dO6wIvfD25t892amO3OF6o=;
        b=wG2J7AVF2ftHGTwArsHcukOnrdsV1K1xqaTrw/zZ8u9s2vbJ5KNe9Tq3uwFSRrc8bo
         kRQnoPnbPL0N3IhWg6IoWJcYOaLmGpab3UCg3fHESMtZAAwLpREbKyzpEO8BLHOYiyt1
         n1J/DatUbUkGQYN1Nc9YaE+KGvSIRYX+Popds8+By3UHH+TFaPh0HYO6QBKTU1DDiL5B
         Xma7vH9RGmwMtXQWb+vNAEr5qiKXVASwvCgzcVRDjSxaJshfWEWawhpCW1u9zdqOEjYs
         s2Q0uKXg+ppd2DCHiHQW9yZ9q9yqQzOQ2JC+uoKoJKwY8dJlMqEz6kQDXym4JCL13dND
         S/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVzKO1daIbQz7nXREISUCMaYD5JGu1lARnzL7ykSz/L8E1EHBUdKQ11FifrHIp32C2JEq2XJaUbieeLeRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytmsfHraQdY+cMlsqGFLDgJ9ajuIG21/wGtsr7eIr4jenY2k80
	ECDnnaRi9J0vJcPumBZEFnjV2DVCkPNr6YjPD2VTmEoSnn1TgDVnNDUc2Fml723b8Aq0zuscQrZ
	AfEVC5+EOZvsL86634aAYlBtWuHIxcvdrOOOUZsZv4+6NyXyJ3HhkeQsZR8C+6Q==
X-Gm-Gg: ASbGncuj9bKjaVC4MxTPrhAPG5lZeWo1ehlbLhGdP8e+nejkLH6rUVKzWl9yELjHf9B
	hWOApcBzDQncFhLHAdzpkZCeLS70ZXmUW7NwF0aGvtKu2pZ5MprY7cajudtKHZveOxZ0JMTjXBr
	zmEQ6ODyErtYeIZtpNjlgulmA3U1KLv6q3TJ5gvu90TMl6G6chHIO6GJi2iz6s7g7YJw5YA2F8W
	1nOVbmy2gPO5MsSDwSW+diwbLKU4RLighMY58S1zZJM2wkHkUlIBaKp9tKD8NA7xLzHLdzlC6Eg
	Swkhskq2
X-Received: by 2002:a05:600c:4511:b0:434:9fac:b157 with SMTP id 5b1f17b1804b1-434fff3de64mr1791025e9.13.1733745125897;
        Mon, 09 Dec 2024 03:52:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF782C5lClyEB8l63P5SOhwTnc8lqniPmPy6ramG0umEAdEdY2btSYCOdTMojVMJnIZOAg22Q==
X-Received: by 2002:a05:600c:4511:b0:434:9fac:b157 with SMTP id 5b1f17b1804b1-434fff3de64mr1790775e9.13.1733745125555;
        Mon, 09 Dec 2024 03:52:05 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f9da4cd0sm29803105e9.26.2024.12.09.03.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:52:05 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vdpa: solidrun: Replace deprecated PCI functions
Date: Mon,  9 Dec 2024 12:51:18 +0100
Message-ID: <20241209115118.125940-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCI functions

	pcim_iomap_regions()
	pcim_iounmap_regions()
	pcim_iomap_table()

have been deprecated by the PCI subsystem.

Replace these functions with their successors pcim_iomap_region() and
pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
Changes in v2:
  - Fix build warning because of dead variable.
  - Make "bars_found" a boolean, since only true or false are relevant.
---
 drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++-----------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..1b9841698a1a 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,59 +556,57 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+	bool bars_found = false;
+	void __iomem *io;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
+	if (!name)
+		return -ENOMEM;
+
 	/* We don't know which BAR will be used to communicate..
 	 * We will map every bar with len > 0.
 	 *
 	 * Later, we will discover the BAR and unmap all other BARs.
 	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
+		if (pci_resource_len(pdev, i) == 0)
+			continue;
+
+		io = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(io)) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(io);
+		}
+
+		psnet->bars[i] = io;
+		bars_found = true;
 	}
 
 	/* No BAR can be used.. */
-	if (!mask) {
+	if (!bars_found) {
 		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
 		return -ENODEV;
 	}
 
-	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
-	if (!name)
-		return -ENOMEM;
-
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
-	}
-
 	return 0;
 }
 
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char *name;
-	int ret;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -656,15 +654,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	unsigned short i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.47.1



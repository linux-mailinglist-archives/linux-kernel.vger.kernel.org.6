Return-Path: <linux-kernel+bounces-427496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2729E021E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11EA8166631
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980751FE47A;
	Mon,  2 Dec 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PdK37V9W"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E701D86C4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 12:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142278; cv=none; b=XwFERE1wEauBReIz93/DzuTRurhPqdxRKoC/ut5iwezPjHy9+groCSBx7FZ+rXTN8LrLjnbKYpo2tgq7lTMr7LVfbvnDgHcoqyUT329vDgvPfuR9+6bvhdbXMRjI3XUXzyU7xd6+YH5XTQA9Llt9WAjrwsC0qBgKVCxnQJpAeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142278; c=relaxed/simple;
	bh=vypkcfmqQSQvNnGSzTrTPtN8sTgc1btYj2S2DQlsl3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F1IFkRilPG7IgpJZ4pjvoAZvvy9Xhpjy0tGGCGgIYTc8FZ/qmfjvTw3dozhieyg45viFPDjEirxfmgQ8pOwGo5kdqbKznIUfWnabSMIpYG5Djqv0KjISamrPfvb3OeaoXxSUlfBnwqx2TAj+HfDadYli6ENa+O+IFWftQ1cO7Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PdK37V9W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733142276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=//HEqIowSWTGQpyQRQeePRqHW275Z/0v15zKmzWbkGs=;
	b=PdK37V9WQfwYU6TYDc3tzdB+fpAKX3Kc1tpCJt6w9UcYPTvyznwo6F1H1cb05p5T04Pq8R
	GkIYlGTwcbMr0YFNMsIjCWB3OdO2QuZKjnCm0cUjVvt/jDz6avWjIwIVyJZBzOe8rb7rks
	pW7GDiSsUEn5lFnbUO9+qkj8dcu+pRQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-xQsz85EwOKmTjmkLvC453Q-1; Mon, 02 Dec 2024 07:24:35 -0500
X-MC-Unique: xQsz85EwOKmTjmkLvC453Q-1
X-Mimecast-MFC-AGG-ID: xQsz85EwOKmTjmkLvC453Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dc37cb3eso1708662f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 04:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733142274; x=1733747074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//HEqIowSWTGQpyQRQeePRqHW275Z/0v15zKmzWbkGs=;
        b=Htijh+BTXkYmBl1s/3aSdljPP9xz9j4WBupSV4XW1IsLYuFSi4bxfvuGNcIhD5vVCf
         Kwrjh2Mavj6xWC4L3/wAlDstYP370ze+/zMR6awCtVpPJtTBkvRu22kbDpXkmGuruYRC
         nyiyDLFGObPJxrBGv5Lgp+Op/0jiNqR37VuWbFZ9jXQm7xVnmilh22rt+bGXsRafO1Un
         PrGyrY38hQilsNsfInQVUNpsd0whOjOaHK1ENRjnMTXxhraHOY0LcvEcg+fSaRSU/GtW
         mjmcTCgEZNs+55wLX1UWW2deF90VIT0/usNKiWLHA8NG+ijBuSK8CHcRwjO2Ln6w/vcJ
         mWZA==
X-Forwarded-Encrypted: i=1; AJvYcCX84Q6nbC/tAd+iqW5vj1zJaEBWE2ZeCgX+L0UCb+zn/65Mexf09C9e2UBIfPOiPFSZppjFuQ7Cl8+1sEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUvs54lu+hCl186ZwQKIvLc9JQPfW+jHdmoA8d9a77UNirWy+6
	a+0M+9YnCMUORbsXCNfzE7LGewSkcaiND5hI3VWpZRC/VclGdscNloCEmypiX36EArmBL4dOAmd
	bjefkdMtRVegyak/XKXSpbAZh8ohEkITtSPYXQTH6V0LAyn3PxdzJQTGO8pRL2g==
X-Gm-Gg: ASbGncu9QCy/vQF14PFygRIna71rWEkjsjcNqfNuVOtwY38SUJ2r4erckehNZ4ucSlm
	ismTc14cpSIjevKrDNN1QWmPB6olvBuOjjX9464OqeM/sAEgnSvyl7aIoKdi1clsNXv5XgusghH
	/m5haM/Ef7xkx/EDXNzJ7W6gWJ0I6qggWJ/aQwPZABT5uK+8vMITDYwq8us+Lob9SG4Q1T+zzZg
	7onpNdljP/6s5e5lNJLv5repHWlbgUHXkJu5jWbPWltvbemQFU0V1yiAYV6yNU=
X-Received: by 2002:a05:6000:4918:b0:385:e2d5:cded with SMTP id ffacd0b85a97d-385e2d5cf22mr8062674f8f.20.1733142273825;
        Mon, 02 Dec 2024 04:24:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEznjBSyloh5TVy1Rv4zaou6u8fNelvxW6jc6X0JnKSCA4c3wEpM0CSdoo/UUE4ySyQjSwJIA==
X-Received: by 2002:a05:6000:4918:b0:385:e2d5:cded with SMTP id ffacd0b85a97d-385e2d5cf22mr8062648f8f.20.1733142273472;
        Mon, 02 Dec 2024 04:24:33 -0800 (PST)
Received: from eisenberg.fritz.box ([2001:16b8:3d41:300:52e4:1c77:9288:7c4c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0bb296379sm3744274a12.40.2024.12.02.04.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:24:33 -0800 (PST)
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
Subject: [PATCH] vdpa: solidrun: Replace deprecated PCI functions
Date: Mon,  2 Dec 2024 13:23:54 +0100
Message-ID: <20241202122353.9793-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
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
 drivers/vdpa/solidrun/snet_main.c | 55 ++++++++++++++-----------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..679c1c7dabf5 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,59 +556,57 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	int ret;
+	unsigned short i, bars_found = 0;
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
+		bars_found++;
 	}
 
 	/* No BAR can be used.. */
-	if (!mask) {
+	if (bars_found == 0) {
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
2.47.0



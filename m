Return-Path: <linux-kernel+bounces-441174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE879ECA96
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFADE28923B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE3720896B;
	Wed, 11 Dec 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdLBHMUb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C714239BCD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914109; cv=none; b=YyQzFJ/Jh2MlJ3Lv5BfA8KXAVqbf5xr2mC9rmstDP9C0R+7lpEg/Dm1LMh5oWIQsTEB9BqGYzx8NFE7fnQ4NQcXvlEAWaQByms9xGZH2vEJxyJSh9Rgj9TRbc/9TFaxpI8D2rhTanJ74RAihsff3ldOxCvIUTS+FRbdMOGNUdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914109; c=relaxed/simple;
	bh=egu/qf9ZXozSwLFwNngQ4Tg9AIPyu1rjBBdpZhbEih0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fvg5Pl74XvvFbnp7RkVP27kiyvBXYsm2RPJ9Bd2CtqYlUB0X1xTfzrm8ucGzWV1cDnoUlNzmTYCoCsm8vVJybBv8UoblABzbzkE6CjDdxPeDDB1qV3Oa9yB6N8xuHo3zo3eCJB457bwsIKZxPZAv5z+NIA4oBuU8K1TUsvjwoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdLBHMUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733914106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MXVy+NvGEa+lmV97Ho50kUKoiqwvV53RUh8hJ9LNZo8=;
	b=cdLBHMUbpxVB1MGEeQApIWCvM8NCZXWgD6NSos+qBX9CfICgi2oh3LCNr1x3d4AEbCTz8n
	lJjVGdCKWamT9rxj2nt5ynUdqxhMGciA6uL1Oq/A/10Ehy7pe6jVf1qHkyH8MwuEvxZ92W
	fpVjLkOpDwi2gu+W80csI4BICN+tOb0=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-yeHIctKFO1m4qVWRebQElw-1; Wed, 11 Dec 2024 05:48:25 -0500
X-MC-Unique: yeHIctKFO1m4qVWRebQElw-1
X-Mimecast-MFC-AGG-ID: yeHIctKFO1m4qVWRebQElw
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-72726ced3f3so2333478b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914104; x=1734518904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXVy+NvGEa+lmV97Ho50kUKoiqwvV53RUh8hJ9LNZo8=;
        b=eqZXK/wp3M3zA3lDsbQ4Urh0sRcI97Rac2zJ44zy34gp3Jlkkgave6yFfoJWyJ/kIm
         9xaMHlIqsyqfYDZfP0j5tJKP1uDD0WltulrsTRcbmDfD8BvBVUkt+MY2lCBI+qCD3L5g
         NyYAXWdt0eUY2hvo21CjTCLAyt+GK51f0j1W6pnGJys39YoiIDdxctMaf6C6p6ojatAI
         cQOce5et8fiDibL/t6ZasCOwIcBtbfbPXM95GuENFNuQ2rZmwHEFHfU4pP4Hi1/UTAL9
         uPWyszvZPStH1tN5UcF3WPPY88dGruD9C6NMfDmqeCnpr0XFk+SsjOCXpI92I9trpM14
         LZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWTnTyDrEAqQQiuh2GH3p9CGD+s6h+3W/rOqdbJl1ghLnPxDTq6iUlYwPevYWgllgCm/zZfW+5RQlSKU4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuPaCa0Qh0FPxn75D3fxrQfGMij9JwgmZ6VVLf/0a4sHhnk9xD
	E4tmio829VD5W9el3uOWUS+r84FmTUb34+H8zUhACAcvWBP0hGE/OdcH4yVaYSIZGfEHCdrPwF8
	2H8ALRwyL4KPN1/IGDM/r4hTgCswqrtVZvZT6Jvyn5HD8QnQSAQUtHaZJyCt6gQ==
X-Gm-Gg: ASbGnctUyK6N6zmtBBeGxUd+VmNKSrnHpcyPH1PROR+ms9OK8aJ2OU4oY17y0XQwrsI
	uD3e9XYV7R6Oo6xsAbGZJQnElU19hiaoJhjZMJKScxwgjlXWVQX9TthgAx/tdFIbZntwHMdZF1W
	Uxp9hMrdqAPZ6LTBPBAlAnhpP7LqZRWPwfUYn5v26cAXp9UwVObYoyIWXFkFdwIb9XGJpPi4gBP
	mz6OzN71H+JT0v0ckBCIQroWPDDmNYtVtA/k0svVxrvXwxWrmQDCjeo7ZY+/eSLIpgjdamjzKc9
	XcROxLcMaiBV
X-Received: by 2002:a05:6a21:6da6:b0:1e1:b60c:5bdb with SMTP id adf61e73a8af0-1e1c1368111mr4232614637.26.1733914104159;
        Wed, 11 Dec 2024 02:48:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKt022fmtoA9CLjQqNxiTi/5lRfTovEKjrPW8kGQgFEpLpzAI2XERexj2+dToCXSlaFgduIA==
X-Received: by 2002:a05:6a21:6da6:b0:1e1:b60c:5bdb with SMTP id adf61e73a8af0-1e1c1368111mr4232587637.26.1733914103787;
        Wed, 11 Dec 2024 02:48:23 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd564f6703sm3229263a12.49.2024.12.11.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:48:23 -0800 (PST)
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
Subject: [PATCH v3] vdpa: solidrun: Replace deprecated PCI functions
Date: Wed, 11 Dec 2024 11:47:05 +0100
Message-ID: <20241211104704.208354-2-pstanner@redhat.com>
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
Changes in v3:
  - Move __iomem *io declaration into the loop. (Stefano)

Changes in v2:
  - Fix build warning because of dead variable.
  - Make "bars_found" a boolean, since only true or false are relevant.
---
 drivers/vdpa/solidrun/snet_main.c | 56 ++++++++++++++-----------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index c8b74980dbd1..643e335f00f1 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,59 +556,58 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
+	unsigned short i;
+	bool bars_found = false;
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
+		void __iomem *io;
+
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
 
@@ -656,15 +655,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
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



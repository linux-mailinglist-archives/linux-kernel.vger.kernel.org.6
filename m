Return-Path: <linux-kernel+bounces-201957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0588FC5DD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555161C22173
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746B18F2E6;
	Wed,  5 Jun 2024 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PSECjhgN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1C818C33F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575383; cv=none; b=PV8geOT7tn/rkoIC1Ka2Mg0yBSpa64zNhX/uST5yqW9iGmV9NxFASbUySiIpx+jLrZThf22PJnH13/whbSy8ClaEnlKuTiGLz35GUOVKIQCTUXgiwJFNWrIgYEjpQqFUuI/6PROzAr49mmvD2jfok8fYU3zlvBWPxRdHfjzTNto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575383; c=relaxed/simple;
	bh=MUiAwXJ/IFLMsknTx0bC4h12IF78V05yZXAKWCbz8BE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLlK/022XSONt832ox4bXG2ugvAnk1OtKO80ESexudT82tq8U6vwO9qoHgtvd0bHb/4YKschCmXEY+5lyvuBENfxR8b4PTrkr9OzAeV5SdrdGyWFA9+fyERBYyXfQbn8KdIY6uJlrR8EyVBwlzyKBVgSgAP1zvo2Bf+LLrz/tUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSECjhgN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yZrCQX9R0uMZLnmEvnk0FOyHrEpxtR6m1CEijmNoZqI=;
	b=PSECjhgNKAM4I36/DkHt5n6YcMnNgyupvg2AuarPEu3hO6Mrd3rs8U92UJ3EV5Iz8tkhMu
	qD9nkMNNizGX4suzTAguiIKUHom3gwjW83M2y422ItvW6IY7eCuVmXaBRqxIQGlYuixXp/
	+xthtFu+gCe8osZmw+Fr1IXxx8EaeIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-1nRWjkrpM8aC_bHcN3XVCQ-1; Wed, 05 Jun 2024 04:16:19 -0400
X-MC-Unique: 1nRWjkrpM8aC_bHcN3XVCQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42154d5da90so1534485e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575378; x=1718180178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZrCQX9R0uMZLnmEvnk0FOyHrEpxtR6m1CEijmNoZqI=;
        b=R9jDLPl/hBIrT18lBiZrZDFZYeB+iq/NTAtPnbmyz3kG1pNxj3K/k6Ot17SPFf8e2y
         iX167nse0+b07RgvZCodttbz6lEX/f6Zd4rk3GHwnv7d+OFZLI8CO3H9XSGLSZgUQxwq
         6ZYftyS1J4ttXOpl4nW5dCrtCCFqFuzmaOPaED6Tx0DGgXywpX0lvefFBdBt7tjTyHEJ
         BiIk8Vu7XQhSvlw8LF1wvKtZOAVa+CA9vK1YORxkvHPkoNuYcdtk2b0DsnpLWKdBW75Z
         YkyFOLjcpq9NSOSTGTOowyx21bVOLmns7WfhI6dHCgdE50TobTFKxNy27zs2kTtuvtIi
         ZJGw==
X-Forwarded-Encrypted: i=1; AJvYcCXzr41xMvNbV+mobBBgZXgEomaPyEtsweLiZaY7NiSU8lYQy2CTw2f+ChnshQaKJSwaaob0wvG0VMkTZqnMn0Xi7wQmLZb3gJXcb/Gy
X-Gm-Message-State: AOJu0Yyaprzdb5JL4ZTF81uflIKhYWTCIRU65u202zSnSENrOZHHbJkK
	vRYERYJ40HnabjQW/c8+QMc24aHpLtiGx4bcPQl065+sTS4rMrkYmdvFfwgVHAbyL1gENGfUbiH
	ojhilFyjlb4g0ye5/H+yr9fnORcYgaumyvFetlIQp9WgXBKHGmR3Fiu8zB8q5oQ==
X-Received: by 2002:adf:fe0c:0:b0:355:291:19da with SMTP id ffacd0b85a97d-35e8ef7f1femr1115409f8f.5.1717575378582;
        Wed, 05 Jun 2024 01:16:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB4zVY6+VoEzLjRsWMaLUjiRNKwhy7h7Hs/HLcCXOD9gH84CvZuj8siARFwKu4gffWqGiURA==
X-Received: by 2002:adf:fe0c:0:b0:355:291:19da with SMTP id ffacd0b85a97d-35e8ef7f1femr1115390f8f.5.1717575378288;
        Wed, 05 Jun 2024 01:16:18 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:17 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	dakr@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH v7 02/13] PCI: Add devres helpers for iomap table
Date: Wed,  5 Jun 2024 10:15:54 +0200
Message-ID: <20240605081605.18769-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240605081605.18769-2-pstanner@redhat.com>
References: <20240605081605.18769-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iomap-table administrated by pcim_iomap_table() has its entries set
and unset at several places throughout devres.c using manual iterations
which are effectively code duplications.

This can be done in a centralized, reusable manner.

Providing these new functions here and using them where (already)
possible will allow for using them in subsequent cleanup steps to
simplify the PCI devres API.

Implement helper functions to add mappings to the table and to remove
them again. Use them where applicable.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 77 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index f13edd4a3873..5fc35a947b58 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -297,6 +297,52 @@ void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_iomap_table);
 
+/*
+ * Fill the legacy mapping-table, so that drivers using the old API
+ * can still get a BAR's mapping address through pcim_iomap_table().
+ */
+static int pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
+		 void __iomem *mapping, short bar)
+{
+	void __iomem **legacy_iomap_table;
+
+	if (bar >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return -ENOMEM;
+
+	/* The legacy mechanism doesn't allow for duplicate mappings. */
+	WARN_ON(legacy_iomap_table[bar]);
+
+	legacy_iomap_table[bar] = mapping;
+
+	return 0;
+}
+
+/*
+ * Removes a mapping. The table only contains whole-bar-mappings, so this will
+ * never interfere with ranged mappings.
+ */
+static void pcim_remove_mapping_from_legacy_table(struct pci_dev *pdev,
+		void __iomem *addr)
+{
+	short bar;
+	void __iomem **legacy_iomap_table;
+
+	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
+	if (!legacy_iomap_table)
+		return;
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		if (legacy_iomap_table[bar] == addr) {
+			legacy_iomap_table[bar] = NULL;
+			return;
+		}
+	}
+}
+
 /**
  * pcim_iomap - Managed pcim_iomap()
  * @pdev: PCI device to iomap for
@@ -308,16 +354,20 @@ EXPORT_SYMBOL(pcim_iomap_table);
  */
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen)
 {
-	void __iomem **tbl;
+	void __iomem *mapping;
 
-	BUG_ON(bar >= PCIM_IOMAP_MAX);
-
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	if (!tbl || tbl[bar])	/* duplicate mappings not allowed */
+	mapping = pci_iomap(pdev, bar, maxlen);
+	if (!mapping)
 		return NULL;
 
-	tbl[bar] = pci_iomap(pdev, bar, maxlen);
-	return tbl[bar];
+	if (pcim_add_mapping_to_legacy_table(pdev, mapping, bar) != 0)
+		goto err_table;
+
+	return mapping;
+
+err_table:
+	pci_iounmap(pdev, mapping);
+	return NULL;
 }
 EXPORT_SYMBOL(pcim_iomap);
 
@@ -330,20 +380,9 @@ EXPORT_SYMBOL(pcim_iomap);
  */
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr)
 {
-	void __iomem **tbl;
-	int i;
-
 	pci_iounmap(pdev, addr);
 
-	tbl = (void __iomem **)pcim_iomap_table(pdev);
-	BUG_ON(!tbl);
-
-	for (i = 0; i < PCIM_IOMAP_MAX; i++)
-		if (tbl[i] == addr) {
-			tbl[i] = NULL;
-			return;
-		}
-	WARN_ON(1);
+	pcim_remove_mapping_from_legacy_table(pdev, addr);
 }
 EXPORT_SYMBOL(pcim_iounmap);
 
-- 
2.45.0



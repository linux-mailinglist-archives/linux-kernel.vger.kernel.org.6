Return-Path: <linux-kernel+bounces-207946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2507F901E50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEFF1F20F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0807C6EB;
	Mon, 10 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0v3m+cO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737FF745E7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011934; cv=none; b=M+XclL6xmu63ghDQkhjOKXer9km5k4d+I2Tbq3ZaPNk5pQP9K08s6yQTCzfQ4qE41QWxOhg/TkSjgXP2mvrf4lvgLtJcQAtUmHS3PqZoUFV5XkSmF6hxgWQnM1aQMG0oih+zfRXyEsSbItLsMC//O+gzFvk5Jc/IE/IOChWljvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011934; c=relaxed/simple;
	bh=nOn0DRXnO8oQWYZd4giX2BtFyTmcsIi2D+kKy3al+uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEN6l3sqVcBV1zwcvI0exFDptCZFaUbofVU0B8+5l6dl5rBLQccXVDPDHINqtd67XLBbTGURG1KVvFPnPenOq92H/Feqduez+Pv6oN86fEgpBDms3gLsRZmaSKUTOtGs0ROUxsyeMaJUSbXuLCdUrdIv21Dgua8Pj+eD2/qsxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0v3m+cO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0E+yd/NqAYSK8WFgRSEHpHq5LwGzPXxKeB5ucvUWBek=;
	b=Y0v3m+cOx4XCDkhY4VGbPBfFXdkYnNQtWjBICZ8KA1uCXUPLN8uqIidWrzaDgpJkBZIALn
	prkS/XzNJWAcV3W59rlhiYYTX9mttJQxObuReYnaQYZF87V1UKxgXy9Bvbjul11qkE83Au
	s534IItx+QDkF/1DL+6X52KoD44ZQAQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-RgELuasfMrei6gPMjocXMA-1; Mon, 10 Jun 2024 05:32:10 -0400
X-MC-Unique: RgELuasfMrei6gPMjocXMA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4217f4b7355so1940525e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011929; x=1718616729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E+yd/NqAYSK8WFgRSEHpHq5LwGzPXxKeB5ucvUWBek=;
        b=JnJJf7IGnXtfN3NInSelJqlupxKfeePa20tiU4FxFpvVNoqvnkfHjxRkHzLphxUmKP
         AW2DfB4kyYNFP/8lzwT5oTJB+BkIyjeysvb3PNemL3GMofBsypzI5nMHoDt4O3QLpPn3
         nnw60XwDwz4PvO6/NyZRI8k6R/QquYh2KNmVwB6htYAwTs+dBrrrBnragNyIKeA9AyeM
         gV3s9VpFTl5aZD/tvbiWwmZLaUi2nQ2lAr4Wqx9WcCdDlirc8TyPsNGi7BLRNlcD7x2k
         iOvvV2PVHOs0DhltRn7MJyLU9/GNAvEBt8H2vhMagACzLgQ7jeknkFRVHYHXmwz2RhBu
         Mwqw==
X-Forwarded-Encrypted: i=1; AJvYcCWpjNHTxjAqexV3lQQ47Ow68nK3hnNBoEnyG6ILUKi19Wcxp4xGaS/poEmu41Jd0h3oP//gLhF+8/gEbiudHZ7Xl4+v+goNnxY9QAjj
X-Gm-Message-State: AOJu0Yzumfq5T+YjYm2pMqyJtmALWXo243TdY0Q6+qsjna/xxvVPAP4f
	+FrFvQq59Lz5hdh0PpWj44ge0FdU2vriGZuipeQLpRp37IuIQKFEqmc3vF/6LSy4bWfygiO85SR
	iKurAoAe2PM4jmVm4HUZgpo0l5BWMXaNnP2f5fSSWEpX3U3Qjvmf1WZ6v3Vawuw==
X-Received: by 2002:a5d:464b:0:b0:35f:247e:fbcb with SMTP id ffacd0b85a97d-35f247efda6mr1269297f8f.2.1718011928886;
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrZxYD3HEuC5SQMDdGziGt7mw/V9beP3O+PtWTxv0mACsmhdqWKMeo5TR1WqKS8I+N5uEZTw==
X-Received: by 2002:a5d:464b:0:b0:35f:247e:fbcb with SMTP id ffacd0b85a97d-35f247efda6mr1269289f8f.2.1718011928640;
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:08 -0700 (PDT)
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
Subject: [PATCH v8 09/13] PCI: Give pcim_set_mwi() its own devres callback
Date: Mon, 10 Jun 2024 11:31:31 +0200
Message-ID: <20240610093149.20640-10-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240610093149.20640-1-pstanner@redhat.com>
References: <20240610093149.20640-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Managing pci_set_mwi() with devres can easily be done with its own
callback, without the necessity to store any state about it in a
device-related struct.

Remove the MWI state from struct pci_devres.
Give pcim_set_mwi() a separate devres-callback.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 29 ++++++++++++++++++-----------
 drivers/pci/pci.h    |  1 -
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 2696baef5c2c..a0a59338cd92 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -366,24 +366,34 @@ void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
 }
 EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
 
+static void __pcim_clear_mwi(void *pdev_raw)
+{
+	struct pci_dev *pdev = pdev_raw;
+
+	pci_clear_mwi(pdev);
+}
+
 /**
  * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
+ * @pdev: the PCI device for which MWI is enabled
  *
  * Managed pci_set_mwi().
  *
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
-int pcim_set_mwi(struct pci_dev *dev)
+int pcim_set_mwi(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
+	int ret;
 
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, __pcim_clear_mwi, pdev);
+	if (ret != 0)
+		return ret;
+
+	ret = pci_set_mwi(pdev);
+	if (ret != 0)
+		devm_remove_action(&pdev->dev, __pcim_clear_mwi, pdev);
 
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
+	return ret;
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
@@ -397,9 +407,6 @@ static void pcim_release(struct device *gendev, void *res)
 	struct pci_dev *dev = to_pci_dev(gendev);
 	struct pci_devres *this = res;
 
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6e02ba1b5947..c355bb6a698d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 struct pci_devres {
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
-	unsigned int mwi:1;
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
-- 
2.45.0



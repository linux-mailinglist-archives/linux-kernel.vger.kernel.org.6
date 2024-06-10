Return-Path: <linux-kernel+bounces-207951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB6901E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733B61C20DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D5E80C1F;
	Mon, 10 Jun 2024 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7HMR04a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84237D41D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011939; cv=none; b=MlzDEjZyHrI+9cp6TlmGm8tRtlU6KiTWtQGAnPQSYORybxVE0LaeYm//MLiz1MPlfWH5fwLSHjjTwlPrStK+J6grWd0sHmgWYRGV3/e8Bxxqueej43cyrjtpD/r2pEGJKoqzBz4mkC2AA+VxxVqPCHiUh7KOp44991qLrF+Akx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011939; c=relaxed/simple;
	bh=60by0ZGSmu26TnhpKT16jO9iZCuapVeU+qpbrVig91Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqjYrKIpJvIPp+EaQJXuz4O/mGopgbO8fwdPNDlPIDBF5y0e5eXYb1CxW3x0wl0lmosgF2SsEHdOznthgt7oE/TNFQJDCaULatbAFOT+Sd7XAxYBQPOlrizKPFcWuSwHywfsilUQ6HnaDszFV3zC3vxKPP4ESNR5w0VS7ex/2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7HMR04a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uYVaQkWqZSrx/i/zySmVb2SXxUjFViRl1HRUPLR6DN4=;
	b=X7HMR04aHaXE2hYSalLxwtLE1fsU2PV763aO6imEcMRtMLlafjt3Ja9iyeEnB3H0SUkxrD
	UWEjNeCs0uZlO+5Gh2atQHC8QRx/ZGAjmSfaUw0DS0OlYPsSt7DX383MgkTL2BC+DPZH2Z
	ylwr/RreySFkCU9MAriFqCityJ16Ueg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-bCsRIYdmOz6udcTNIrsAZg-1; Mon, 10 Jun 2024 05:32:12 -0400
X-MC-Unique: bCsRIYdmOz6udcTNIrsAZg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42110b33fecso5730435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011931; x=1718616731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uYVaQkWqZSrx/i/zySmVb2SXxUjFViRl1HRUPLR6DN4=;
        b=pR7gV0rnuhMOq4rUeNKjcvgCPRxqYpn0iDfy8mzhY0qgWtZcipVI/rLqKyUNtnSyNk
         1R6r+Y8a04gYVuztVOKOtRJ8p2mwghHuRdqV4HO7pFc73n8TDDXj4d+VnNf+fgpy1Fsm
         gD4Az+nsdUN3kzQTZ4QSu5g8H54mpAVrRoJ7KdqpQLQADzxRis4eioDX7vhWlS8yv7KF
         M55cK3jZHontPiDm6lz+fTrx026IIEQchCpN/bZxJo7yEXZxc2+Xa5n5TQsUVMhcBvsM
         jIi1F6TgDVm8GPEA1y3mOHmUJY86DFzHlJBbrBTT9V1/OFNlx79a52GEvKdGMpO0cAG0
         W2kw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ4brmIprFiI1WaBO821w/3PH3XeFBSx43/dfRzUh+V5DyiQLVTv4LOq0cLCddx5rYlDxYiEsXc6fc52aHYBwI5H5XNP+GSDoDvYmV
X-Gm-Message-State: AOJu0YwZGyING1hwhqb86Cl1sbLKSY+1tiYFmlfvccbQ8L6zzwB+0fZg
	8wxtKds/gvuKwZyGHczXXfEajNsJh/OEbtLOWDisVvY55dh7A9PFLHLiU/P8FpszkqzhOOOrDiJ
	c6sytXVrvzvkVab4nfNpkvoj5Z1AOVwPUxf3OIKTW7dCEsnkbhFHhu2hD+74fpw==
X-Received: by 2002:a05:6000:1ac7:b0:35f:229e:9c6d with SMTP id ffacd0b85a97d-35f229e9eafmr2316700f8f.6.1718011931037;
        Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC5EISwyWHtH2eTnirfsjXBBnu5C7SW4kxtaGwTzx8vXOIkqsWX8QFdvGZWKIwJ9P9VX916w==
X-Received: by 2002:a05:6000:1ac7:b0:35f:229e:9c6d with SMTP id ffacd0b85a97d-35f229e9eafmr2316683f8f.6.1718011930743;
        Mon, 10 Jun 2024 02:32:10 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:10 -0700 (PDT)
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
Subject: [PATCH v8 11/13] PCI: Remove legacy pcim_release()
Date: Mon, 10 Jun 2024 11:31:33 +0200
Message-ID: <20240610093149.20640-12-pstanner@redhat.com>
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

Thanks to preceding cleanup steps, pcim_release() is now not needed
anymore and can be replaced by pcim_disable_device(), which is the exact
counterpart to pcim_enable_device().

This permits removing further parts of the old PCI devres implementation.

Replace pcim_release() with pcim_disable_device().
Remove the now surplus function get_pci_dr().
Remove the struct pci_devres from pci.h.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 53 +++++++++++++++++++++-----------------------
 drivers/pci/pci.h    | 16 -------------
 2 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 0bb144fdb69b..e92a8802832f 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -465,48 +465,45 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 	return 0;
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_disable_device(void *pdev_raw)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-
-	if (pci_is_enabled(dev) && !dev->pinned)
-		pci_disable_device(dev);
-}
-
-static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
-{
-	struct pci_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	if (dr)
-		return dr;
+	struct pci_dev *pdev = pdev_raw;
 
-	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
-	if (!new_dr)
-		return NULL;
-	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+	if (!pdev->pinned)
+		pci_disable_device(pdev);
 }
 
 /**
  * pcim_enable_device - Managed pci_enable_device()
  * @pdev: PCI device to be initialized
  *
- * Managed pci_enable_device().
+ * Returns: 0 on success, negative error code on failure.
+ *
+ * Managed pci_enable_device(). Device will automatically be disabled on
+ * driver detach.
  */
 int pcim_enable_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-	int rc;
+	int ret;
 
-	dr = get_pci_dr(pdev);
-	if (unlikely(!dr))
-		return -ENOMEM;
+	ret = devm_add_action(&pdev->dev, pcim_disable_device, pdev);
+	if (ret != 0)
+		return ret;
 
-	rc = pci_enable_device(pdev);
-	if (!rc)
-		pdev->is_managed = 1;
+	/*
+	 * We prefer removing the action in case of an error over
+	 * devm_add_action_or_reset() because the later could theoretically be
+	 * disturbed by users having pinned the device too soon.
+	 */
+	ret = pci_enable_device(pdev);
+	if (ret != 0) {
+		devm_remove_action(&pdev->dev, pcim_disable_device, pdev);
+		return ret;
+	}
 
-	return rc;
+	pdev->is_managed = true;
+
+	return ret;
 }
 EXPORT_SYMBOL(pcim_enable_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e87528f1157..e51e6fa79fcc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -810,22 +810,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- *
- * TODO: Struct pci_devres only needs to be here because they're used in pci.c.
- * Port or move these functions to devres.c and then remove them from here.
- */
-struct pci_devres {
-	/*
-	 * TODO:
-	 * This struct is now surplus. Remove it by refactoring pci/devres.c
-	 */
-};
-
 int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0



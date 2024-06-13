Return-Path: <linux-kernel+bounces-213142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 744C1906CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E673C1F268A7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5941494DE;
	Thu, 13 Jun 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVF7FhFw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14699148FED
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279461; cv=none; b=f03KoaXkcWhkphDm+B3PxS7toZakIkSaKwS8aG7kdCAp8ny3ERXy/6oZetUJXz71IAJa45BfHzHTIKwWICIByKqIeBgk44B32pM+Wzps6tqt0k/jsyI2hzu7mysnHhKK3aQowdpfcqeUEpp9tbWCseQzYGdDfMK03dbyCpIREVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279461; c=relaxed/simple;
	bh=r0grzUmBcSDYCaYgn9ysXFCKA4yu6vMMhBtQa+BDezY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAj+Wy8J/u6flc6jCdB/TlImb0XVHB2GLl3jqDko4eEm6Qms5I0m6udOFu9CQBIgygemaW9XtI+gUgI8hddrMdMYeP9UYjXZeF0i9KgyWl42hk9jhIfwLSgXnnlbupbf8BeylUP+KPlJ2hWlX2kyShpgfSefK2vOByGKoHik1ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVF7FhFw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DkCOJZ/wPtUvxbKR6iZK0j94vWla8EApzDXg+GJsTLg=;
	b=HVF7FhFw9OXidnm3QlIMvIgeUOdvT53c33TnYvYyfyEaN7MsNGp+q1rAPIkl9gJPDgPkV9
	Agne8n0HMabXQDpiS4UHSpir8Pf3OpQS8mQVlW18032GBL9D8sk6WgJg4q7rxLbiRvoZmh
	kS+yay74tJnOMg2XEjqczx2Mz8neTCY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-6ku1QIayMXKhF4rQbZLRUA-1; Thu, 13 Jun 2024 07:50:57 -0400
X-MC-Unique: 6ku1QIayMXKhF4rQbZLRUA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4218118d1efso1513535e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279457; x=1718884257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkCOJZ/wPtUvxbKR6iZK0j94vWla8EApzDXg+GJsTLg=;
        b=oL0C5ObBxO2C/ctzUcdV6NTM3SAhbjZeHy6piKU+pMT9R/hZAUZEXHfAd0uk0tuxC8
         YwPk4UDenUMH50FX6b7pSl0MLrimtexju5iOa7qbiHYd3RTaJfM1g2qwwxBjtYRL3Pa9
         YJJvhztr/gMEx3oyaVpZzn9Hkv/Dj+ShUt9NxpyZw4gFt+3XVzn/eiUUQ9P0xuiHq25O
         41Sm+5OvSJZG5uZSZOO0nobsE11lV3C+4cssrPOVjBOKFvPTkzrPKJMKGKT/NMnn1UGk
         FStBhD56hZSEy4ZBwZ3Z/F7PcWzk/GisE0rUVeYAt6D1x6PsvudirR0Sij+TsTSMXv10
         Q0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtyHv5YVizHuHXKl+POK9P7KDJ+6qUzq5+6JmWMnaJ0kgIay3Fc2R3fcXXC9NxKODTsRRdNOpa92waV8/5lLlonW3OXM0v9elFqDEs
X-Gm-Message-State: AOJu0YwL/NEFcLmI/0zRvC5MMWOXHQ95r9+9laVe7CeihInj2n/doX7W
	N5CvLNS8VJ1TE/tjUxX+yWuc0MkSRC1uBNDRli577Xj5EkxQrkYNB2l8bmSCKyB2FvDywPVaVmU
	oDC2H1S1x/KJ7wDTjmExSnnhNHdxhmmodAo2QJBQ5uHA/zi4JhzMTE2o7xt3K7Q==
X-Received: by 2002:a05:6000:1845:b0:35f:e38:6758 with SMTP id ffacd0b85a97d-36079a587a3mr156395f8f.7.1718279456841;
        Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2TEvywhfauVMW37zv3JfoMBzZNIERzrEKPTEghMv7QdmvZthOHWTnGztKiTfV2ZqUSTTNVg==
X-Received: by 2002:a05:6000:1845:b0:35f:e38:6758 with SMTP id ffacd0b85a97d-36079a587a3mr156374f8f.7.1718279456563;
        Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:56 -0700 (PDT)
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
Subject: [PATCH v9 11/13] PCI: Remove legacy pcim_release()
Date: Thu, 13 Jun 2024 13:50:24 +0200
Message-ID: <20240613115032.29098-12-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240613115032.29098-1-pstanner@redhat.com>
References: <20240613115032.29098-1-pstanner@redhat.com>
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
index 7b72c952a9e5..37ac8fd37291 100644
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



Return-Path: <linux-kernel+bounces-207949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7049901E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C90628629D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC080026;
	Mon, 10 Jun 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PJQv/ZsG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085747D071
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011937; cv=none; b=nPu232DsbNEGey3fIZ3zHEr2WuzrkVNpTtjv7NFrUcg3zPCAO0wJAJGww6OwkV4W2eUZalMsBx0f8BtIhdm1mkrtN9QRF/OFvsINx3s6DxgJn3PHFDOTWyQTn9PLdzbPKtrXCrq+Q1lCz4MAJY2z/veXwlNJDhCKrm3J9WW3uJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011937; c=relaxed/simple;
	bh=CFdCNeZZ6CyxrinDB0AsxWeYdDz1/5n2fdvfoFvvDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udtWFVB9JkChxMGbWg8XR9yCUL75plIclxLqOpSfmEytPOs6xvdESOPEgVFb0kUPvpMYSCzKtzr/yQtiTfLxp9ec/ZWSEGzJKWerjapyDQ7ivA/SaUlOj1sTsHU6OiPPTmCFpESR4pLy8q6nFzxKCTu56xeqFZ7El3eI0XRDIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PJQv/ZsG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmBGcmpGbvOFP1AIf55egClciELzX12rkzdK4Dy+Hd4=;
	b=PJQv/ZsGPGORL6zqAUSz8d8MMkPBuFSJPUZPZr7pbsDcKw1tUNxZO4K9GK+WKw2LgA4rF+
	+FsxSRUla4SYiWLOy4FY/DBJhGGCDnTCYw3H3AdN+ifdKGMilMNcJfTBIpjt1BVv+6Agbs
	2iGstWkdwJ+g0N/pQoP4qfCigfRkvo0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-6zxHNKvKMw6atIst8OOXVg-1; Mon, 10 Jun 2024 05:32:12 -0400
X-MC-Unique: 6zxHNKvKMw6atIst8OOXVg-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ebd69e45b3so2133691fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011930; x=1718616730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PmBGcmpGbvOFP1AIf55egClciELzX12rkzdK4Dy+Hd4=;
        b=HNtJnQmm0Zw5wW/aX8kdBrN74yOPLGiPmcD7U2/oM/hZHaLc+K8qea896C2eJw90Vw
         20tR3z6hA/5TkqMe3KVJYBeLHQGXw8K4trH2TCP/kufjiO4fpCX0spDgu1irWwYIz2Jn
         RwsdF8v5iU+0mbEfUlzxopoNnFYuXQkJM8zhWuF0xMZw8nHafO1v8OCi8I2T4pnKO84P
         xd4YvjgN7/tvHY9W0KZKaltuwh0gJs3Wyc64e4k+Sv+dmnqMZsfy/+Nl2oufGWVtfQ9L
         AkLg/mGidGX9eGb50v8BBudmA1bdU+s+ZNuOJW1HfIqRtIgTy32TF0ZtdOeV3bsWnXbu
         2vcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGDZq+6EDSRfur5028R//cpBfIkngwJ7v0t9I2gBr4rrTubEuzHmd79kfuGBya6CDzg9A/ZciD6TIxKczDfdZaDtvEWo0HD+YB46c6
X-Gm-Message-State: AOJu0YxhW3VQ+cxxz7ezG8r8NsOewX3y5aWH7WadJH0bgGQ7kFiFXNxC
	dZc26mA22gCUD3AksUleBml8X47ylD7zjKDiZgEl2+SNxewR+YJqr6gMuPn0teKHLz3v127Bx5m
	Mdp1/6/Bp/3Wef9hcSH97oMg//3o6Ta6du9eflKJT4/74au6TkOn+RmG2oDYI/A==
X-Received: by 2002:a05:6512:551:b0:52b:8325:6eed with SMTP id 2adb3069b0e04-52bb9f76f7dmr5384550e87.2.1718011930236;
        Mon, 10 Jun 2024 02:32:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgbn5PpJ3Jnv5nGP2smWEohtnvWJ0KNMfA5EI1Y5tPrYLamq+qiSktIeCn16zhQ6SoTJbiEA==
X-Received: by 2002:a05:6512:551:b0:52b:8325:6eed with SMTP id 2adb3069b0e04-52bb9f76f7dmr5384538e87.2.1718011929791;
        Mon, 10 Jun 2024 02:32:09 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:09 -0700 (PDT)
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
Subject: [PATCH v8 10/13] PCI: Give pci_intx() its own devres callback
Date: Mon, 10 Jun 2024 11:31:32 +0200
Message-ID: <20240610093149.20640-11-pstanner@redhat.com>
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

pci_intx() is one of the functions that have "hybrid mode" (i.e.,
sometimes managed, sometimes not). Providing a separate pcim_intx()
function with its own device resource and cleanup callback allows for
removing further large parts of the legacy PCI devres implementation.

As in the region-request-functions, pci_intx() has to call into its
managed counterpart for backwards compatibility.

As pci_intx() is an outdated function, pcim_intx() shall not be made
visible to drivers via a public API.

Implement pcim_intx() with its own device resource.
Make pci_intx() call pcim_intx() in the managed case.
Remove the now surplus function find_pci_dr().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 76 ++++++++++++++++++++++++++++++++++++--------
 drivers/pci/pci.c    | 21 ++++++------
 drivers/pci/pci.h    | 13 ++++----
 3 files changed, 80 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index a0a59338cd92..0bb144fdb69b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -42,6 +42,11 @@ struct pcim_iomap_devres {
 	void __iomem *table[PCI_STD_NUM_BARS];
 };
 
+/* Used to restore the old intx state on driver detach. */
+struct pcim_intx_devres {
+	int orig_intx;
+};
+
 enum pcim_addr_devres_type {
 	/* Default initializer. */
 	PCIM_ADDR_DEVRES_TYPE_INVALID,
@@ -397,32 +402,75 @@ int pcim_set_mwi(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcim_set_mwi);
 
+
 static inline bool mask_contains_bar(int mask, int bar)
 {
 	return mask & BIT(bar);
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_intx_restore(struct device *dev, void *data)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pcim_intx_devres *res = data;
 
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
+	pci_intx(pdev, res->orig_intx);
+}
 
-	if (pci_is_enabled(dev) && !dev->pinned)
-		pci_disable_device(dev);
+static struct pcim_intx_devres *get_or_create_intx_devres(struct device *dev)
+{
+	struct pcim_intx_devres *res;
+
+	res = devres_find(dev, pcim_intx_restore, NULL, NULL);
+	if (res)
+		return res;
+
+	res = devres_alloc(pcim_intx_restore, sizeof(*res), GFP_KERNEL);
+	if (res)
+		devres_add(dev, res);
+
+	return res;
 }
 
-/*
- * TODO: After the last four callers in pci.c are ported, find_pci_dr()
- * needs to be made static again.
+/**
+ * pcim_intx - managed pci_intx()
+ * @pdev: the PCI device to operate on
+ * @enable: boolean: whether to enable or disable PCI INTx
+ *
+ * Returns: 0 on success, -ENOMEM on error.
+ *
+ * Enables/disables PCI INTx for device @pdev.
+ * Restores the original state on driver detach.
  */
-struct pci_devres *find_pci_dr(struct pci_dev *pdev)
+int pcim_intx(struct pci_dev *pdev, int enable)
 {
-	if (pci_is_managed(pdev))
-		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	return NULL;
+	u16 pci_command, new;
+	struct pcim_intx_devres *res;
+
+	res = get_or_create_intx_devres(&pdev->dev);
+	if (!res)
+		return -ENOMEM;
+
+	res->orig_intx = !enable;
+
+	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
+
+	if (enable)
+		new = pci_command & ~PCI_COMMAND_INTX_DISABLE;
+	else
+		new = pci_command | PCI_COMMAND_INTX_DISABLE;
+
+	if (new != pci_command)
+		pci_write_config_word(pdev, PCI_COMMAND, new);
+
+	return 0;
+}
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+
+	if (pci_is_enabled(dev) && !dev->pinned)
+		pci_disable_device(dev);
 }
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db2cc48f3d63..1b4832a60047 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4443,6 +4443,16 @@ void pci_intx(struct pci_dev *pdev, int enable)
 {
 	u16 pci_command, new;
 
+	/*
+	 * This is done for backwards compatibility, because the old PCI devres
+	 * API had a mode in which this function became managed if the dev had
+	 * been enabled with pcim_enable_device() instead of pci_enable_device().
+	 */
+	if (pci_is_managed(pdev)) {
+		WARN_ON_ONCE(pcim_intx(pdev, enable) != 0);
+		return;
+	}
+
 	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);
 
 	if (enable)
@@ -4450,17 +4460,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
 	else
 		new = pci_command | PCI_COMMAND_INTX_DISABLE;
 
-	if (new != pci_command) {
-		struct pci_devres *dr;
-
+	if (new != pci_command)
 		pci_write_config_word(pdev, PCI_COMMAND, new);
-
-		dr = find_pci_dr(pdev);
-		if (dr && !dr->restore_intx) {
-			dr->restore_intx = 1;
-			dr->orig_intx = !enable;
-		}
-	}
 }
 EXPORT_SYMBOL_GPL(pci_intx);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c355bb6a698d..9e87528f1157 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -816,16 +816,17 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * there's no need to track it separately.  pci_devres is initialized
  * when a device is enabled using managed PCI device enable interface.
  *
- * TODO: Struct pci_devres and find_pci_dr() only need to be here because
- * they're used in pci.c.  Port or move these functions to devres.c and
- * then remove them from here.
+ * TODO: Struct pci_devres only needs to be here because they're used in pci.c.
+ * Port or move these functions to devres.c and then remove them from here.
  */
 struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
+	/*
+	 * TODO:
+	 * This struct is now surplus. Remove it by refactoring pci/devres.c
+	 */
 };
 
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0



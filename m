Return-Path: <linux-kernel+bounces-201966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54BE8FC5F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5461C21151
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A328190055;
	Wed,  5 Jun 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqsNw+hT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D6B194138
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575397; cv=none; b=Cbwxs4ynOd3JQpxFTukx5+s1NQ2sS0NYPJ/9oBseRQTqDKaN4ABxAz0ZqDIcy8ZFolWsm0R8YwmFHwRTpRInZN7qKyU0jPukWaE9e+t+WIQlPpyOEErFtnU5kKbEJa3VGux3sJRs5G+A4s/kanplbZP0ohG+ZQVUUMXeBSPzP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575397; c=relaxed/simple;
	bh=GTeBpuYLIPwI5Fq4sasuRQzg6LJKBh8wPFCl/+rcDMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/GxZSm9mYlVayuFsNL/Gn3qN00j82te3zxD5oTY+JyvCcjAxipti9Mr4f/BTPFceIDjiPccFl48iIKtkUJZSQo08nP3RL7tfY1fYobQrvEqLVtkUmZPZJO5GM9VypqNFR9zfK+XNkCN9kI217vxl3zIkurQQUG06pijo+efoIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqsNw+hT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BD+Ne3TkytD/xWKk8A40YJpqJowHiHm8wUBRIwRMhbs=;
	b=FqsNw+hTreyVugLdhs0rpC+XerMOO2F+YwKbeyevG9GtHKxKsd+U8efI1rGkEIevDiwBam
	K1aNJ0eSGu/ko33rHMo3B/CXu11CmZ9OEWJkdx/2BynwVJhH7R/ifqQAmnvM8lN6stAY0H
	sEFCBSfHVMfK6Spd7DFUDhKEL8KwVNE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-HDPL5JEVO-SDzPWuRRWBMg-1; Wed, 05 Jun 2024 04:16:28 -0400
X-MC-Unique: HDPL5JEVO-SDzPWuRRWBMg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35e0f2512ddso240541f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575387; x=1718180187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD+Ne3TkytD/xWKk8A40YJpqJowHiHm8wUBRIwRMhbs=;
        b=vEF8xBBEzxaiGU4Brfcb4kCS5r51LnttGA+6lSkOJvkOeYoxwFkwmmGUC67ERgDIfZ
         Vsai0VMtpnJx/v/YEeDaAb0qjhcsaKNkpv6AwNdbBBPsp+XOp1z7UdCJAsqWMkEI3UZ3
         YGCPbinhdeQ3YjSedw6xQ1pFitazwB7gut3XS2Ieljwt3fTxJC4bjabvFXIfkcmE5XVr
         5ib63o8sttPV63xEY/97hRIv71hsN9Q3zpdrbLfh50SC8Nro371LfGdTaJQ6ltqTAyR7
         BudpqMuaAIrbsrKEGxehNQACciIhVjlbnhzpZ6UnqWHZ1CHUqWF9rzrJsK9j60iDz2XS
         rOqA==
X-Forwarded-Encrypted: i=1; AJvYcCUhVj/oNQeIYkcPsxs4JCcGL1M0KGM0/klOzdDl6o3X3a/+8kGqJfsEZ5XkZl2EaPZo5cTQKQ/9yENRk38HnQM8jFmrXFZxXBbcKL0X
X-Gm-Message-State: AOJu0YwHgh+4Vq4Cf0iGqmBhyUe1ZtnW565XjckCbavNei6KzL6GW8kg
	EBns9OyPPi5f0MUJebqaCTdwH4YU20SsAjN5MLctruqGzdeukp5EwsVCZZ9s4J9q+4nPWNIYQ0z
	C8zuvvywCSKdnctVRtQCrQblDmvben1eSvJi71Nriy76xd5dnRGXaO5KY4cB48Q==
X-Received: by 2002:a5d:456d:0:b0:35d:cf2b:9105 with SMTP id ffacd0b85a97d-35e8ef90f08mr1063105f8f.6.1717575386863;
        Wed, 05 Jun 2024 01:16:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPnmKKMbioEu3OTnfk3Olk/HS1ljC/0uD3ilJbavzKouLbvntLOj9vIGtcz/0ZnPMjStdobg==
X-Received: by 2002:a5d:456d:0:b0:35d:cf2b:9105 with SMTP id ffacd0b85a97d-35e8ef90f08mr1063089f8f.6.1717575386552;
        Wed, 05 Jun 2024 01:16:26 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
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
Subject: [PATCH v7 10/13] PCI: Give pci(m)_intx its own devres callback
Date: Wed,  5 Jun 2024 10:16:02 +0200
Message-ID: <20240605081605.18769-12-pstanner@redhat.com>
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

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 76 ++++++++++++++++++++++++++++++++++++--------
 drivers/pci/pci.c    | 23 ++++++++------
 drivers/pci/pci.h    |  7 ++--
 3 files changed, 80 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 0bafb67e1886..9a997de280df 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -40,6 +40,11 @@ struct pcim_iomap_devres {
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
@@ -392,32 +397,75 @@ int pcim_set_mwi(struct pci_dev *pdev)
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
 
-	if (!dev->pinned)
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
+	if (!dev->pinned)
+		pci_disable_device(dev);
 }
 
 static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 04accdfab7ce..de58e77f0ee0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4444,11 +4444,23 @@ void pci_disable_parity(struct pci_dev *dev)
  * This is a "hybrid" function: It's normally unmanaged, but becomes managed
  * when pcim_enable_device() has been called in advance. This hybrid feature is
  * DEPRECATED!
+ *
+ * Use pcim_intx() if you need a managed version.
  */
 void pci_intx(struct pci_dev *pdev, int enable)
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
@@ -4456,17 +4468,8 @@ void pci_intx(struct pci_dev *pdev, int enable)
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
index dbf6772aaaaf..3aa57cd8b3e5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,11 +823,14 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
+	/*
+	 * TODO:
+	 * This struct is now surplus. Remove it by refactoring pci/devres.c
+	 */
 };
 
 struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0



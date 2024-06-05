Return-Path: <linux-kernel+bounces-201964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3C8FC5EF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E341BB224F8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39892193095;
	Wed,  5 Jun 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PifHaezX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB3B1922F1
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575393; cv=none; b=TW4Ey57cSQm0TQCHy4HiG3O6OaAwSorFVpAQM7JIeZeo/lq5hUAG3UuIhh65W6tXK517C81Rm/GOdMHN6GaUhYI8CUG0ZN5EixS/5nI3ecWshQ7X4n9pHXCARW5iUsX3p9Rf4AtKmf254noWL5HBHPZvGFMm2195MD/ZBnqdjFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575393; c=relaxed/simple;
	bh=LIhWjlBnujZsrqNrxIabQocrBEUnZjpD1itpnCtbE8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvh37jeyyBBmobxOcXw410ipVF4bnbPb2JDY4KDQRE6tEI8gwqXF9gDq44hyGlbE4TM09Ks95gu7u5BFj0tA732decQYh/ThQgrJjV+I+ZGB2puOto+9L9TRnHS7eEYfr1FhHwmywSjgsCTwkqXonFOyvNQklP3JTa2+NEBnaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PifHaezX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ieun1xthf8lb2oACtUs9qte0ySrDx5Lfq1im4lgm338=;
	b=PifHaezXt5PsYA07ooFD+ArZGZaqy1zEWWH2jdZyC4TohLEcJQNVbGpuEQQok2hQIpbGKB
	DN1h42fX4kWPX0W6xq0czUthi/oPrzJRVgAz1MZ9b2lYudWcfbCEQvwHMwnYkUvdb5uV6m
	OSU2YhIwtIjz2hztjiyW5CovszrHu+Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-Hhgx8YJSMUe82krD-s2Xqg-1; Wed, 05 Jun 2024 04:16:28 -0400
X-MC-Unique: Hhgx8YJSMUe82krD-s2Xqg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42159aeaf59so30895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575388; x=1718180188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ieun1xthf8lb2oACtUs9qte0ySrDx5Lfq1im4lgm338=;
        b=oA2WDEQYufpdbTk+h6QODThtSZ6+uWeIzmo8NyaOyJ65aw089VdTxwkS/YbHYXkpCz
         PvqQYjvqFGaPnzWZoqeyXpcWi9oz8v+AiYiqz1Ld0mrpOA3tMeWERmNt5lbDmw0xKK9s
         qAz4N8+mhWHH3iurv5fVQk836anKMzx34iqUwgVNFHW3JUpXLTkGk4WRtzEn3Cory4QU
         /OqdZBs9kpa4TvR8P0fk95hNlecK53SOZnqTd22DkpmwXlvwB2HwqKX9+4keEY2Zv20p
         Ym0QK2Y0EKi66wSnC2NAT3LQteNnmlXBh+UjlWu+b+DmGw8zabDKWcgQ1dx8LawcE/5l
         0gaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY05V9tqNLVHjLFY9wqqwwyHhU/ymrUVBQyRCcqG7L6P6Vv1RT5devhbYHtZcKjVjdJJm7zUEVkdqZrdLLYoXunp04ZXYygahbDPQ0
X-Gm-Message-State: AOJu0YzxcYOB4Lo75MZYT/1ZNbSjOEVVFr6ur2nKg7l/kB7Qd0IihkWS
	rHWZAtgyBCJgVCDkCB0U5/+6Nc7VLlt0PDJyXsy5b2ZqjJPJgyeBoDGPpFP9DBjm/UVZWFKnpXd
	qUubxj+z5+f8ZSElicdKXp3oFjBraL7tl+XJVm5pWsKHKUYmUG4Bf7Te14NVaAQ==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1107251f8f.4.1717575387786;
        Wed, 05 Jun 2024 01:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7QWZ+wzLRj89HwPmCo4cwm181tYKPOfVL2iFfJrmO0D+uX56tjbvKzLXtnA0YMX0uy5FvKA==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1107226f8f.4.1717575387480;
        Wed, 05 Jun 2024 01:16:27 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:27 -0700 (PDT)
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
Subject: [PATCH v7 11/13] PCI: Remove legacy pcim_release()
Date: Wed,  5 Jun 2024 10:16:03 +0200
Message-ID: <20240605081605.18769-13-pstanner@redhat.com>
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

Thanks to preceding cleanup steps, pcim_release() is now not needed
anymore and can be replaced by pcim_disable_device(), which is the exact
counterpart to pcim_enable_device().

This permits removing further parts of the old PCI devres implementation.

Replace pcim_release() with pcim_disable_device().
Remove the now surplus function get_pci_dr().
Remove the struct pci_devres from pci.h.
Remove the now surplus function find_pci_dr().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 53 +++++++++++++++++++++-----------------------
 drivers/pci/pci.h    | 18 ---------------
 2 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 9a997de280df..271ffd1aaf47 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -460,48 +460,45 @@ int pcim_intx(struct pci_dev *pdev, int enable)
 	return 0;
 }
 
-static void pcim_release(struct device *gendev, void *res)
+static void pcim_disable_device(void *pdev_raw)
 {
-	struct pci_dev *dev = to_pci_dev(gendev);
-
-	if (!dev->pinned)
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
index 3aa57cd8b3e5..6a9c4dd77d68 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -812,24 +812,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- *
- * TODO: Struct pci_devres and find_pci_dr() only need to be here because
- * they're used in pci.c.  Port or move these functions to devres.c and
- * then remove them from here.
- */
-struct pci_devres {
-	/*
-	 * TODO:
-	 * This struct is now surplus. Remove it by refactoring pci/devres.c
-	 */
-};
-
-struct pci_devres *find_pci_dr(struct pci_dev *pdev);
 int pcim_intx(struct pci_dev *dev, int enable);
 
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
-- 
2.45.0



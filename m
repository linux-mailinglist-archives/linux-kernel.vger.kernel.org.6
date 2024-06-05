Return-Path: <linux-kernel+bounces-201962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E426E8FC5E8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 026B51C21835
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B61922D7;
	Wed,  5 Jun 2024 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hgz8oD+R"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083F190045
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575390; cv=none; b=ongRaisnr1Mf9mm4fSDJybPgJVP4YfQxLUec0xTREOO7nPshJ93W2ZvFM1VWdD9GATwVow6GshWB5XzRrx/6xdU2JYQxvcsR3HdkQCkpESfgUhDhSmdfjk6yt8fNWgcS//q2FvyitI8AaUFHBg/c/H2jpVssm/B6RpmL263W/Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575390; c=relaxed/simple;
	bh=xl9J8hI645BO4dJlrgq+iFLF1dby15q/VE4JCvZfbaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGG9e6tKKJZCEp8sdk0lNsHX+X7HyIzKe8GMm4h8X9jIBBz5dpnBq4HS0VQlvercE9EBtSjilJU3dIO+zZiAjpi49iRZ9d+Hs6e7Lvvz0Q4vBjozahw0jE6GOJyM34d7u7oXRmukrhjVNZtKI7nW0BF94B3UbnTH4AKHq2UHUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hgz8oD+R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ADSvqA1AO3nQbqjqWDmd4LNpBLOwxbzjerhA1UP/7Ik=;
	b=Hgz8oD+RKFLss3YnHpzDmPSc5vv5+/WVDTilLt7g3rQSNZqlaYeYhRxbIvWBxqkdlasgd1
	lVN+aBGrUTqmx6W2D/L39w/34MOejhepJwv0RCTqqJ93S5IonqMX077q+trBs1F8eYWv1L
	JUgZ3W0RRdtrot10gNWrwXY9e9fa1Qw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-0wnIqw-RPguA2OqWd-f6vg-1; Wed, 05 Jun 2024 04:16:25 -0400
X-MC-Unique: 0wnIqw-RPguA2OqWd-f6vg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-354dfd4971dso300787f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575384; x=1718180184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADSvqA1AO3nQbqjqWDmd4LNpBLOwxbzjerhA1UP/7Ik=;
        b=DVXrhv1GXuo64GkdAzGS/tpEGmPq5HRJHvOg/VB9reXl5Q+ZfYFQwUmovtuvw6Gb5L
         PtqrMw5xXzIPPJRmF2wpUGupwOAZkYlN8n4lkhPL7gSeom69mhEjJPQBGFc0DJ6ILjG/
         bk8wekuflUQaDQvbjZuuZKSYHci43/9n4mcTzOMsTQpuLEPqP59jgiwKzVmolm201UEe
         W0oONtk9+Z1g2VAUvN3TO61sf4hQSQirdc9vHnYqmP8PeXVgPB6tKMFD8L2AmZuw48TQ
         HKFvO37EGQE91LQwk6Ot46JL5cJqzf+IzJZGMtvOAuM4YG6SpJR5vHDOyUy7+sOjl/8W
         jgTA==
X-Forwarded-Encrypted: i=1; AJvYcCWHd5MWAiLMFdgHa6DCF3rnuiw8sJVrtLDN+cL/vk9cQLAIYD225Y4DggEYLIrz9rKaL2Sl86jFOzTWuW8pWTUY8pLK4xoNBqSs6mj+
X-Gm-Message-State: AOJu0YzvtY9odMIEmrveY0D5iGXFQ5nSZbVAKr/UXv8W1ehA9SV6kmJa
	CT10FT2zGVx9R+7DIkUq9jomyYrroi4Uik/V9LRIUJ4e1KpxmTYoMi5Uxlfxa13zWoePrnBXe/f
	FSvCts/4gHw3rk0XMdzVfGfk/FuK9HUD6arEIkWgYicTlGU2e4kyJ3IWtRlQgtw==
X-Received: by 2002:a5d:4a8f:0:b0:354:fa0d:1423 with SMTP id ffacd0b85a97d-35e840559afmr1138376f8f.2.1717575384546;
        Wed, 05 Jun 2024 01:16:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeYXXYRwMmc/wItTwuhNim5zt2S5LTm7hN7b8qr/oaCOGVDkg9BBwyql/IirFuwik1TYGpeQ==
X-Received: by 2002:a5d:4a8f:0:b0:354:fa0d:1423 with SMTP id ffacd0b85a97d-35e840559afmr1138356f8f.2.1717575384289;
        Wed, 05 Jun 2024 01:16:24 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:23 -0700 (PDT)
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
Subject: [PATCH v7 08/13] PCI: Move pinned status bit to struct pci_dev
Date: Wed,  5 Jun 2024 10:16:00 +0200
Message-ID: <20240605081605.18769-10-pstanner@redhat.com>
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

The bit describing whether the PCI device is currently pinned is stored
in struct pci_devres. To clean up and simplify the PCI devres API, it's
better if this information is stored in struct pci_dev.

This will later permit simplifying pcim_enable_device().

Move the 'pinned' boolean bit to struct pci_dev.

Restructure bits in struct pci_dev so the pm / pme fields are next to
each other.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 14 ++++----------
 drivers/pci/pci.h    |  1 -
 include/linux/pci.h  |  5 +++--
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index ea590caf8995..936369face4b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -398,7 +398,7 @@ static void pcim_release(struct device *gendev, void *res)
 	if (this->restore_intx)
 		pci_intx(dev, this->orig_intx);
 
-	if (!this->pinned)
+	if (!dev->pinned)
 		pci_disable_device(dev);
 }
 
@@ -454,18 +454,12 @@ EXPORT_SYMBOL(pcim_enable_device);
  * pcim_pin_device - Pin managed PCI device
  * @pdev: PCI device to pin
  *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
+ * Pin managed PCI device @pdev. Pinned device won't be disabled on driver
+ * detach. @pdev must have been enabled with pcim_enable_device().
  */
 void pcim_pin_device(struct pci_dev *pdev)
 {
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !pdev->enabled);
-	if (dr)
-		dr->pinned = 1;
+	pdev->pinned = true;
 }
 EXPORT_SYMBOL(pcim_pin_device);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index e223e0f7dada..ff439dd05200 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -823,7 +823,6 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
  * then remove them from here.
  */
 struct pci_devres {
-	unsigned int pinned:1;
 	unsigned int orig_intx:1;
 	unsigned int restore_intx:1;
 	unsigned int mwi:1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 110548f00b3b..3104c0238a42 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -367,11 +367,12 @@ struct pci_dev {
 					   this is D0-D3, D0 being fully
 					   functional, and D3 being off. */
 	u8		pm_cap;		/* PM capability offset */
-	unsigned int	enabled:1;	/* Whether this dev is enabled */
-	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
 					   can be generated */
 	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
+	unsigned int	enabled:1;	/* Whether this dev is enabled */
+	unsigned int	pinned:1;	/* Whether this dev is pinned */
+	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
 	unsigned int	d1_support:1;	/* Low power state D1 is supported */
 	unsigned int	d2_support:1;	/* Low power state D2 is supported */
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
-- 
2.45.0



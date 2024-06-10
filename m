Return-Path: <linux-kernel+bounces-207942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C43C901E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C4B28666F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0E78B4E;
	Mon, 10 Jun 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UqSLvAhG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E83576410
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011930; cv=none; b=ANHU45PlPcn016yXcunGJMlnBqI/G0M6vqnD1HnzSHAvkJA5rV5pa9Q0AhE5QkKPj9EeHvWO3qrNIRkv/vDFwjp60M5MnzgZ1JYsUvPeZxfTxg26ryJik3LdnQUrV6zo7WU7d8t36mGcBxzMN0wIIB4zy9xKI+cv/NuCOfWOq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011930; c=relaxed/simple;
	bh=R+ahaaj9Z92r/qtOUZY3Zpj6x9Bj6I0WxW/a/NzXs2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKNDDu2e9ICAVM0Tt+/xwZtjCq4vX9ltEh2NOXLpXfqiClBiQJvCknd7j1jA5QVzOSOJBe8GghEQYMqa1kTTuxJOPjPcLSfe2aax74BFTVOGj8QBFWr0hYbNnuS5gwayV4WhD3CodJ9p9u2/jVHzyqdPD/VUqvwi06YNBPEaVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UqSLvAhG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZiUwSs1HtnX+QGE2Zl9KICBy9ex3+lEWzbjMxYLRGDA=;
	b=UqSLvAhGzVDocEbP8aRlcUWirw1IKUAIDjMPYO5QDOdcfAkoHRJzG0G6z37MbO/3WLX8zh
	QNVBDyD1crP/4whtIsqHE2MjnjOIcZN9YsEXWGRCQoJ9QVZipMT/RoWDD5gmt69Of3SvNx
	0lz77TkhbYjpEDiuq9+qgIPwlHynwn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-qVgwIBMmPyC56jyRm0z11A-1; Mon, 10 Jun 2024 05:32:05 -0400
X-MC-Unique: qVgwIBMmPyC56jyRm0z11A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-421920de031so1511975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011924; x=1718616724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiUwSs1HtnX+QGE2Zl9KICBy9ex3+lEWzbjMxYLRGDA=;
        b=or1/cjh8lcli/OWwqpJplKuuD7Uu7OtehjcOEtQo/FqYWNUGUVSV1Oau+ZXF4PVSUv
         pe5Ag9EvI+rh9FMf9K2++IrQ3Lu0kzaRGECgYnwzf2ei1g23BMndOd2SBGWqgbYxUmb8
         rXiy53E6FNMjw827UKMd6xHkajyZ9PHbBrOvs8dkAKXzlOd0JkJZRmqb0wo47OD+5B4j
         dvjQt2nvuvTUwqGqrdkf4/dzBXeIXhQTE318A9FyjBI0FhWOzU8/JDdt89P0nG7Ko4DL
         J4Ju4pXwXLgluih9kzuKBrDOge7q9TOAf2D7F03pIcoBGYUXJiI/G/Hyn8Tf/f9NDyQI
         sENg==
X-Forwarded-Encrypted: i=1; AJvYcCVk5yjBQeRB5MgdnL1ae8aIQ/XbZzCff7ae0iesRt2dvgEfQGFKkNfsnU79NKPi0pSiqQd7HRom/0J/Bkpq1BedqNZzWGL6ka6TLdQi
X-Gm-Message-State: AOJu0YzuRMYjrcMsUwP85Vr7vOYkwqSUVZeyCCc6a592/SVxS6zK68Vr
	4XFuty9e57yQAkP72J1Ee++HMwmLVYz7mWJtvdJtInEh0+ko1Ecy91KEM01ijLNg93cBin8zzWo
	kxjZQc2OIYdlnQ7GVoSZsNnpQyAGSRfmgr8K5BOUEWl9y54fBUGI23yr3hMCKHA==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr6464070f8f.5.1718011923975;
        Mon, 10 Jun 2024 02:32:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHVbLME23XHqqxGSb/L2UcmsZWCbVxunmo7ktVNIV+TisnX0BItNxZ6wxaQvx45l+MZoucwQ==
X-Received: by 2002:a5d:6c65:0:b0:354:fc97:e6e3 with SMTP id ffacd0b85a97d-35efee1d38fmr6464047f8f.5.1718011923677;
        Mon, 10 Jun 2024 02:32:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:03 -0700 (PDT)
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
Subject: [PATCH v8 04/13] PCI: Deprecate two surplus devres functions
Date: Mon, 10 Jun 2024 11:31:26 +0200
Message-ID: <20240610093149.20640-5-pstanner@redhat.com>
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

pcim_iomap_table() should not be used anymore because it contributed to the
PCI devres API being designed contrary to devres's design goals.

pcim_iomap_regions_request_all() is a surplus, complicated function that
can easily be replaced by using a pcim_* request function in combination
with a pcim_* mapping function.

Mark pcim_iomap_table() and pcim_iomap_regions_request_all() as deprecated
in the function documentation.

Link: https://lore.kernel.org/r/20240605081605.18769-6-pstanner@redhat.com
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/devres.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 82f71f5e164a..54b10f5433ab 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -507,7 +507,7 @@ static void pcim_iomap_release(struct device *gendev, void *res)
 }
 
 /**
- * pcim_iomap_table - access iomap allocation table
+ * pcim_iomap_table - access iomap allocation table (DEPRECATED)
  * @pdev: PCI device to access iomap table for
  *
  * Returns:
@@ -521,6 +521,11 @@ static void pcim_iomap_release(struct device *gendev, void *res)
  * This function might sleep when the table is first allocated but can
  * be safely called without context and guaranteed to succeed once
  * allocated.
+ *
+ * This function is DEPRECATED. Do not use it in new code. Instead, obtain a
+ * mapping's address directly from one of the pcim_* mapping functions. For
+ * example:
+ * void __iomem *mappy = pcim_iomap(pdev, bar, length);
  */
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev)
 {
@@ -894,6 +899,7 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 
 /**
  * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
+ *			(DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to iomap
  * @name: Name associated with the requests
@@ -904,6 +910,10 @@ static int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
  *
  * To release these resources manually, call pcim_release_region() for the
  * regions and pcim_iounmap() for the mappings.
+ *
+ * This function is DEPRECATED. Don't use it in new code. Instead, use one
+ * of the pcim_* region request functions in combination with a pcim_*
+ * mapping function.
  */
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name)
-- 
2.45.0



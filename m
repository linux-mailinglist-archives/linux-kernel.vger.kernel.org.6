Return-Path: <linux-kernel+bounces-277563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FDA94A2F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 10:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76D331C20D1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC451D0DE3;
	Wed,  7 Aug 2024 08:30:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B9618D640
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723019431; cv=none; b=agrNOWDGeYg4BrvMA7AJj2Ql0Q2w8h85GwkLdIuJnp+hYfSBuMBzu1bf8z9URUQhngmKwmZPeJd5tZhQkrHOh/4mtSjpJZ3gEd7zu40PY4l1rmfxaTxS9F0s6/0Q1crpVGfIkvXiGaqNdQnFeWrmO/wVa8eJryRyjvpdm9gdsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723019431; c=relaxed/simple;
	bh=8/IVVXD4FeMZWKFKtoNpDRSh5vex9vQC00VHkqB1wBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NUhNXoV3xdYDUHRYR+3hkQARY32b03s/mxhcben4PflcObvqlRpfQg8weOVfxUy4ULQ9sGcu29BgkLw80gwl43tNNaIi41u9emwVLgLSzOKcqBpTqnK0XOzrhuM3KFo8mjzL0X+GftLU2IsL+AzbQQnsOLlCIuekeSj6V3jPnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-qWLpXukcOvW_BQV1xJppbQ-1; Wed, 07 Aug 2024 04:30:27 -0400
X-MC-Unique: qWLpXukcOvW_BQV1xJppbQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4281d62be91so1293165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 01:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723019426; x=1723624226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfBj6lBAY4VJsMws6sBIFpxuMUursLja0EGRzFyXM78=;
        b=sJnv1uneCFMzJslpmj8b9Wa8uC21RVt/y0He8JYB/U9fkXmWoeI003vlqFr0c8MfYS
         owYtiEv1pxAybKbV1YOnjP2UFoD3zHtXuYUHErsGSFjjrMXIiI2+2uBgVc2lKNJ9lmVM
         TPzGsPM4JR7xD8viMPQmQ/sfn1+OC5Nw8xzQX3NQ98pVY5TXAXDXYFdoyD0l8DY1kwm8
         bhG8vwJOAkhNF/EcAur+U8CmRSq7EpoNkzaBuHbBFKmA9NJEPQkBjWRBEzivWZMbx26a
         nUbeudCz4HBjoC9mI3cFHSQl2IxlNDSZsnPEV9urrSdK3V9ShpITtn5pWia7VkUgXqS6
         0jAA==
X-Forwarded-Encrypted: i=1; AJvYcCXJKjFykQvTaU3Vtfc9j4gsAW/Nn/JVI1iDFkmAkrefuV2dQwLhP9E0d6VlFUHETC2LkAd+oSKe1Xu8yFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO5yp82BMyIQtadn+BRvTDAZCJP6ZVy+7sR/XKEkfaYUK5pyE0
	lzC1SSyp8xTgE9ar/HwSck4fXrtqaYR3SjxqHP9dscM3V3t1771kIB8zcqAQnZh5m7IvVE3BZGK
	yt/e+kWQja5H+cWVsvmsisLWX2vWPgoyH6/aygcmUucDN7XVbENofm9lq9PD3tA==
X-Received: by 2002:a05:600c:4591:b0:426:6f48:415e with SMTP id 5b1f17b1804b1-428e6aea795mr73821025e9.1.1723019425858;
        Wed, 07 Aug 2024 01:30:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdhIO0KlL48PS+jaZDCPIETER1vQyM9Ppq36CYnKYH6adnAP4mB8NMbC+bOkQ6YfKhAfEWRA==
X-Received: by 2002:a05:600c:4591:b0:426:6f48:415e with SMTP id 5b1f17b1804b1-428e6aea795mr73820815e9.1.1723019425354;
        Wed, 07 Aug 2024 01:30:25 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580cb80sm18544835e9.45.2024.08.07.01.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 01:30:25 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Dave Airlie <airlied@redhat.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 1/2] PCI: Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()
Date: Wed,  7 Aug 2024 10:30:18 +0200
Message-ID: <20240807083018.8734-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() is a complicated function that uses a bit mask to
determine the BARs the user wishes to request and ioremap. Almost all
users only ever set a single bit in that mask, making that mechanism
questionable.

pcim_iomap_region() is now available as a more simple replacement.

Make pcim_iomap_region() a public function.

Mark pcim_iomap_regions() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 8 ++++++--
 include/linux/pci.h  | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..89ec26ea1501 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -728,7 +728,7 @@ EXPORT_SYMBOL(pcim_iounmap);
  * Mapping and region will get automatically released on driver detach. If
  * desired, release manually only with pcim_iounmap_region().
  */
-static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 				       const char *name)
 {
 	int ret;
@@ -761,6 +761,7 @@ static void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
 
 	return IOMEM_ERR_PTR(ret);
 }
+EXPORT_SYMBOL(pcim_iomap_region);
 
 /**
  * pcim_iounmap_region - Unmap and release a PCI BAR
@@ -783,7 +784,7 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
 }
 
 /**
- * pcim_iomap_regions - Request and iomap PCI BARs
+ * pcim_iomap_regions - Request and iomap PCI BARs (DEPRECATED)
  * @pdev: PCI device to map IO resources for
  * @mask: Mask of BARs to request and iomap
  * @name: Name associated with the requests
@@ -791,6 +792,9 @@ static void pcim_iounmap_region(struct pci_dev *pdev, int bar)
  * Returns: 0 on success, negative error code on failure.
  *
  * Request and iomap regions specified by @mask.
+ *
+ * This function is DEPRECATED. Do not use it in new code.
+ * Use pcim_iomap_region() instead.
  */
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..fc30176d28ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2292,6 +2292,8 @@ static inline void pci_fixup_device(enum pci_fixup_pass pass,
 void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
+void __iomem *pcim_iomap_region(struct pci_dev *pdev, int bar,
+				       const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-- 
2.45.2



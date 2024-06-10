Return-Path: <linux-kernel+bounces-207950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA90901E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604C81C20D62
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3B980029;
	Mon, 10 Jun 2024 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+iKzw64"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F2874C1B
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011937; cv=none; b=ebIwAhM6AxKzzl89uId4rpOSZp7EsqlnzgLtL9FDIXddEWqOHWGUKXs362Eyk/jIFfN/zps0Ob3ZBacbVeXGqISZME4pWLeaLLs5LMfW7Ud89deA/1ko2oHMrGK4w1jh5TMv9HZUFYGwwZ/fyu7lGc/5MkeQNxsy4kivLVmOytU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011937; c=relaxed/simple;
	bh=39N7dQNsh6HdaHQrF4jqoIMCjCm9/18LRI3vr0xgqik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOXbKGeRg7Z5/P9O2O44uBSjlj+23YMkL6iwOxvCTIMntEwuBRG8suo0AAtpkIvOw6AbpYJ2pZMbuoRIKxaAUHB3fpRjup8vhKpheyoG71KXzgrKoeD6IypZPxO+I8AXJDBgWxjxwP/M5JNrqpMcDOiVmgmV9cIu7VQ8WwuAwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+iKzw64; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718011934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XYyS0MFkgb40Rf9CNRl6khW3DB/TwdBG9c2B8GVIp3I=;
	b=H+iKzw64zQZE+amnC154GtNsxhsWoRqXmcPId5ynQOciNuoQlnqDtZAeEUVBdyIFDcDDFX
	CR3Kups+IZDpa2IDYVpXgalWBB1Rla8JzLC4ialhspZVFEmIsc1NdpsXVKOceHEhP7/09e
	170mMCicJIcmsOMQeZ+4EFpgrpXO7oM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-VAKgIYGqMfaCjX6MZByqvg-1; Mon, 10 Jun 2024 05:32:13 -0400
X-MC-Unique: VAKgIYGqMfaCjX6MZByqvg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42180ddc0b9so1692075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011932; x=1718616732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYyS0MFkgb40Rf9CNRl6khW3DB/TwdBG9c2B8GVIp3I=;
        b=SvmT2GZcQQ6xjB+eVh7IpztilD5ftPSBcm0EFGENpQH/frDKFa3SFsB0JjZ4Ux32ZF
         Kl93dwmtS+Su/fOyqDJTCTsZj1oc4d+iKfyRsCBpQJhTnSuxiZTfUuExIX5F3VxL9ALe
         ntW6br6XEKq7K3eirMPfSvC4D8TDlrUYc+ca6aijbNZo+Lxb+hxGv5y/+RYZwbFSHB0C
         9U+MjgG0g7JBoERygIKJfkeYJ8mnguOnsbmam+qZVid4cG6zYlvQ534SCGiVMb3Wb52y
         tQK0g9PIpRcQIm452UGPIhTZ8IIqoOO4iVpagsGGt5iyEOsB3apphFgRY8A9FpHMZPkC
         EyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCULnZueACO7vDMoxFPdwhGX+GcisqBLeOlkoA6hp4T+tSUiTuSk3Ec1j3Ouw684BxSpHHUHwmphOQwdRR35D6VFQoP4kLMhg5l5bTaE
X-Gm-Message-State: AOJu0Yzp5g5Obu5LQYjcVWESjLH8kYDJXyjEeIGsP92BHuzh5J2o/ntu
	+kr6VS+YB8x0+UUV4WGrtPLuSp2U4ETnRFx3r0nOK8z4Z/oIejTjZpfus+DByiURTinBtu6ZPgb
	EYH/VSZ2TcnGVeFAWw32PX9c3z2yLB9xfmlVmS70Q38SeLZAlP3dUfk/sphuntQ==
X-Received: by 2002:a5d:526a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-35f1412fcddmr3111484f8f.1.1718011932106;
        Mon, 10 Jun 2024 02:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa4v7/IL4a5fGSrL47j3kH3zCfktetXms9w5+CrxpIYCETGQiN/XQkBtYRt2zSMtVQVzGA1A==
X-Received: by 2002:a5d:526a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-35f1412fcddmr3111472f8f.1.1718011931796;
        Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ce4b62fsm7257545f8f.80.2024.06.10.02.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:32:11 -0700 (PDT)
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
Subject: [PATCH v8 12/13] PCI: Add pcim_iomap_range()
Date: Mon, 10 Jun 2024 11:31:34 +0200
Message-ID: <20240610093149.20640-13-pstanner@redhat.com>
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

The only managed mapping function currently is pcim_iomap() which
doesn't allow for mapping an area starting at a certain offset, which
many drivers want.

Add pcim_iomap_range() as an exported function.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index e92a8802832f..96f18243742b 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1015,3 +1015,47 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
 	}
 }
 EXPORT_SYMBOL(pcim_iounmap_regions);
+
+/**
+ * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
+ * @pdev: PCI device to map IO resources for
+ * @bar: Index of the BAR
+ * @offset: Offset from the begin of the BAR
+ * @len: Length in bytes for the mapping
+ *
+ * Returns: __iomem pointer on success, an IOMEM_ERR_PTR on failure.
+ *
+ * Creates a new IO-Mapping within the specified @bar, ranging from @offset to
+ * @offset + @len.
+ *
+ * The mapping will automatically get unmapped on driver detach. If desired,
+ * release manually only with pcim_iounmap().
+ */
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+		unsigned long offset, unsigned long len)
+{
+	void __iomem *mapping;
+	struct pcim_addr_devres *res;
+
+	res = pcim_addr_devres_alloc(pdev);
+	if (!res)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	mapping = pci_iomap_range(pdev, bar, offset, len);
+	if (!mapping) {
+		pcim_addr_devres_free(res);
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	res->type = PCIM_ADDR_DEVRES_TYPE_MAPPING;
+	res->baseaddr = mapping;
+
+	/*
+	 * Ranged mappings don't get added to the legacy-table, since the table
+	 * only ever keeps track of whole BARs.
+	 */
+
+	devres_add(&pdev->dev, res);
+	return mapping;
+}
+EXPORT_SYMBOL(pcim_iomap_range);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index cc9247f78158..bee1b2754219 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2304,6 +2304,8 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.45.0



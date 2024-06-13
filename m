Return-Path: <linux-kernel+bounces-213153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEE3906DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3993C1F27D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675C3145B11;
	Thu, 13 Jun 2024 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZB91pbcG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB20145B08
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279914; cv=none; b=qi2NWESTaIJkg3eMZa5QZ3QaMqmJW6YaluMf0sc0aQGlwUjLiCml9ObmrCfWRbFQ0ECRFSw/0f1YPGUyMzWZHFmJ6Yz26fcZHJgUITHOXDxvCKi3+N9friq76ZdaXRya0RPw4em8rSsJsHabD/FSuM1W3Apq5wgkK3NYsc94neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279914; c=relaxed/simple;
	bh=XM+HU7hb6QVEb253YkrStrtEiG/dnPO/pYNia1HjcLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEynPlSNF1yFPHFVSwQiCVdlwX9LnW2aQS1f2xB5UIeh78G6YET1Tnbd5bxXprWwaAmzzmciQc3tahObuBexT5I+tnUtMsuWT1xG0Pn/7Mvl9MbLznfukKISDAsPtykioDEiHyYRELQgsDvRjs2VjoSpJJQSwcd45fKOlUGf/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZB91pbcG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718279911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=000KYz6ID2QoUMG52/WJvZNJGOa8UH1A+/S3718oumg=;
	b=ZB91pbcGaGYDXYoHox4qb0YYoXdv5LDFmcpUB60aJt96TD8leyelMpQnD7Z8grIje0l+Mb
	XGhb2+R3bS+6r7jllDRa2BHZzAAfxGZ4FdLCYaJTvaxxLmD99YkCeTyL1qPJ+g08RDRoiu
	b85Ggv52urVfV3JwerPlL8DG7uRAWqI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-JTwOMPR3OAKIYnXitB3iEA-1; Thu, 13 Jun 2024 07:58:30 -0400
X-MC-Unique: JTwOMPR3OAKIYnXitB3iEA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-57cb9286e9eso53659a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279908; x=1718884708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=000KYz6ID2QoUMG52/WJvZNJGOa8UH1A+/S3718oumg=;
        b=eZSmycbXtdQW3+7qLWhx14kfP45bis7chp7CVAvPmiU8p/o/RhdKt53NGYxNydBZBN
         Aax/pecQN/NpOHNskVzTfhvwGvba+39CpTnbwD0oK2uxul/q+568cVaQiRa/EMg0/s0L
         kt4YKsFbdT6G7v4t8r74wDDSPS/zzI98lM4gz3QnDWGmuTAtwQIU9Q4BPP3LwIWwuslZ
         wJiKumclBhBMG9oArdjO1F27hP7cZ1mZbK+dR96ZQeWqdxZj+k8pDVlZznomcOKGIcmq
         R3ZQaiqMuRBK9aab9uMZlrqRonA3tPdG8U2Woz7f+m6lTexaAFeJNvRboktdytLRwhq5
         fyhA==
X-Forwarded-Encrypted: i=1; AJvYcCWP0kLIEW4bqjt/bQjBmNpPNukxq+KV57YvFPcYsgehP9xwudZpKWAh+t7tXqBNQGDW3tiTFCwTYrnDWlAo1vTlwCj7xvcSrTR9Uo5Y
X-Gm-Message-State: AOJu0YwRJ6m1G4HBLnfBz/oq/9PQQg6Vl2peEo2/UTKZZghOrOOOBjXg
	C5qE4JvS7EQ0HyV0VdTybajWuNEwEujizqpzcZLW9B04BVfpd/7L4g6ms51SNsrp6iycwS1oC83
	3WaEb30zKiU+iecqwPVn58TKT5AqQUJNsiZ4cEUtCopVLotIceqdyMTjcuikHUpVMJhm/xw==
X-Received: by 2002:a50:aa94:0:b0:57c:61b3:bdc1 with SMTP id 4fb4d7f45d1cf-57cbc21968amr110944a12.3.1718279908538;
        Thu, 13 Jun 2024 04:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnhuJuSAKliDxcFbokg6egscMNv+7jsPTJ86B+AWP/UZU7fL3bpTZJKANl4Bt8/kMHQDmyzw==
X-Received: by 2002:a05:6512:ac3:b0:52c:9e80:387a with SMTP id 2adb3069b0e04-52ca59e9d11mr72313e87.0.1718279457545;
        Thu, 13 Jun 2024 04:50:57 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c883sm1510620f8f.29.2024.06.13.04.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:57 -0700 (PDT)
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
Subject: [PATCH v9 12/13] PCI: Add pcim_iomap_range()
Date: Thu, 13 Jun 2024 13:50:25 +0200
Message-ID: <20240613115032.29098-13-pstanner@redhat.com>
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
index 37ac8fd37291..2f0379a4e58f 100644
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
index 0c19f0717899..98893a89bb5b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2303,6 +2303,8 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.45.0



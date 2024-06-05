Return-Path: <linux-kernel+bounces-201965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A88FC5F1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E401F23CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA2F194128;
	Wed,  5 Jun 2024 08:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqAh+kbd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56918F2F4
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575393; cv=none; b=kxXKRch7V983n0ML/Dq6sJycU39JOnw1rhiXpWHemBo+vc82I7BH4zRBcU6yt2noMrCrelXWvyXNV2P8h4L3yFs6ZYh98yt7pFpNZeDJHzD2myExJEp91+9AdWJYReGt9pK0mOn2CxTv93VaCBtzhjF1wBA9oVxdG/4geJG9pi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575393; c=relaxed/simple;
	bh=JMFvIAK97CVO0WYF9x4f5zI6n4vzeleom/TOQDaGhvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGf3m+ejG7ozYRPRKzCiOUwP0TTLOgZbaV0J0yuFEPVuDezz/S1sjv0pL+ewI6eIHQjNIW4B/5j7BaKIocy8mykdepQmvZiFcy4o+6W73vnHluXy8iuLKGtueax+gyAmag3tajRsmEh0D5HdsbsWEt0wrVT4+CvQYBLfRI7BTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqAh+kbd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717575391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IEuAQpiyFkRTWU9yECucUjg03zi15bHltjbT7Mp+Diw=;
	b=JqAh+kbd2mRqMVSSEDylIENeWpKxtoeF1frMvtjPru0J0LfUxOqvrHQM0deCn0xeg8dy5q
	QD78NKr3uSFG+WxvEmK1+pPhPH2umv0bzJRCS893AYVC7+gLhsBOqyLsNpuM0Ty9I7LwRn
	DZvJ0lrR5bSP9PQNFeJwIXe/WCfyPZE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-eJXw631SONS1n37Uf0MPYQ-1; Wed, 05 Jun 2024 04:16:30 -0400
X-MC-Unique: eJXw631SONS1n37Uf0MPYQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4210e98f8d7so5392655e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 01:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717575389; x=1718180189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEuAQpiyFkRTWU9yECucUjg03zi15bHltjbT7Mp+Diw=;
        b=mzmCuSVnJElImCtTbxoqRJFKCxYAF6VrGklN3o2K+CjuTauNi6JeXgbwleDI+BZSVh
         7lqPa1vZJdhoIzPKV275piv8RRCmUg+ET54XAaFU90gNJIRgoYKG1WNoNCxNBliRwlho
         /3UrZuAyYCi6quTk1KJzymQ0u+VQGsZFtn/D96bt+FoNBYGzBKSbtyA5th/lx5zRLlgF
         40EBsSiTmrHCszTLmIZtMaJHfrEEyfJ9b8zR2g+GLsZZ5K4pxcClVtdUsCD1puJayyrV
         EIX9CrRbF8C5WCYU5US+RCGiOy1m8Ovs/kKkh7RSsws4faU8Le0T3/3sGwzhS60hwsnH
         HVaw==
X-Forwarded-Encrypted: i=1; AJvYcCWXHlHlb5poKymj15vWTBbAOtZB6FirRjmEXZcwtSR84hu68LlVisS7ZSQpDqog+0J2nazySP7p9ksdhvuaw2f3FsDy1pvrunEp9CDF
X-Gm-Message-State: AOJu0YwmziPK57/8TSuTgXshdMv7doVCLA3b7etd7djwBNvlxz6MgK5b
	DbpKX0LpY6wNHhP1uBYcbc1snSXApS4kTLTcKySPb7e7Inc25Iejpxvc5eTiM5CnVI2p9rWlFKa
	0YisorVno2+aS4MDWYZqM6e5OWIEr4ElXppHwCMYIpQfQV+mEFnzO7J+VI+Sqzw==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1107300f8f.4.1717575388874;
        Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnjANmPeJW2fIkqitgTnO6d1I0TF2FhQLz3U4Vz0ir5jlCvF+wcPqPTc7AeKCFcFuNtzjdvA==
X-Received: by 2002:a5d:49c5:0:b0:354:f768:aa00 with SMTP id ffacd0b85a97d-35e8ef8f11amr1107276f8f.4.1717575388585;
        Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.fritz.box ([2001:9e8:32e6:e600:c901:4daf:2476:80ad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd0630010sm13739163f8f.76.2024.06.05.01.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 01:16:28 -0700 (PDT)
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
Subject: [PATCH v7 12/13] PCI: Add pcim_iomap_range()
Date: Wed,  5 Jun 2024 10:16:04 +0200
Message-ID: <20240605081605.18769-14-pstanner@redhat.com>
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
index 271ffd1aaf47..5ddcfe001d08 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1007,3 +1007,47 @@ void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
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
index 3104c0238a42..f6918e49ea5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2329,6 +2329,8 @@ int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
+void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
+				unsigned long offset, unsigned long len);
 
 extern int pci_pci_problems;
 #define PCIPCI_FAIL		1	/* No PCI PCI DMA */
-- 
2.45.0



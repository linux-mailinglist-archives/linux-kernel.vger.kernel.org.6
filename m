Return-Path: <linux-kernel+bounces-521232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6991A3B97E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4723BAD5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF251D5175;
	Wed, 19 Feb 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MCZl3tqE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21F1C831A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956966; cv=none; b=rfCoaNd7eXxrzfBJkd0QZLIE9mVQTqG7bh4ZkY0LqSmvE/XRrvYF+3xt29xU5lDtPDdBeD9j8BhB0ZSoSTEn9mD9RmLjpzTJuGYIYi8w0w81m3KmKF8S/PIgobQlICUO2nmdX4rU3CbgnsyASL+9070t1Ejw9ESbEXhlNCxgI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956966; c=relaxed/simple;
	bh=CBhtCWjbsQ04UiOa3AFjnffqRHthDOcfY1FMq+mMzQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3VDzbYgrh+FbZgSCydVA8CFxR9Hb6PH9wt1wAIMEv1wixjTs3sXCX3bogXbeJPAp5qDJN2xu6wl8VTIlXdQPdz+3JjDESY2DhEnNaz9m4kplK5tfOZUSGaLP/Gw3hRlxYD7EYCKSB1/v7MltI7rpdWnvlbLS1LrrGsaMVchqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MCZl3tqE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21f61b01630so10371125ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1739956964; x=1740561764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnGtO5JguyJMDAVVd/amsK5Mk4hYl7NsHvQivQkdUR8=;
        b=MCZl3tqEJL5izV+q90DQoQ05feKL4TyefSpnFGDkamOqnRC/3GbIZHkLer+QWAR03n
         MH1X5KqtFOOyZgOBmellPkYtdq+rXDQOgfs6flsYJdGfArMpXtkxT3gj+xBzrD1YoGow
         2EsTNjWNRIeMGp+yeXRi80rsZ61bWpy7fdgm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956964; x=1740561764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnGtO5JguyJMDAVVd/amsK5Mk4hYl7NsHvQivQkdUR8=;
        b=vJO9/vu1h69v9cCrk90ycxzgaaM1HgaBBVncDr8p9br3rYK1cQQHlyXTcf8aK6IJaw
         P/vZUXVj93cHd3pmtRuWIFEefPkY/yG6NSr7P9Px+GxWFKTaL+ErwU2VCkJVtAG+K78O
         0U2utvR3SHN9f9LKzvMNg8ypnFpiLFkF78wcA2WXQ/g7npBooSPrq9b/0Gufs/Elhggo
         53VXXnq/6gSFp/jd9b+O1sIxuBgXp9XSZIOEDJd5hAkYYlH5sJEJ70fZFMHjzOxVE/GB
         avflKJ1V2qpL5Q/FkEhUUhH6F7rmDmKWlPGNPcVYp112ltOGbhcWWmYNa6a61dNAiopO
         Yc/A==
X-Gm-Message-State: AOJu0YxWdF1ViCfTN+L1SxWWTHFckNTYOhKvS52/Xu6nLb5N4Cs1OE9u
	d2ZOtR1UTSUNUTnBlzRC67kaIKWKkKxbk/N9j1okgJMWFXGoamdAU+8cPwWxdI6Tv2AEwLI5019
	L
X-Gm-Gg: ASbGncu192Sp5GHxaW/zPkrM5iMdZu9T2BK21nhTIwvSQWHdU48y3J8bFEWEiHC9VCV
	VxVjBBr/oZRzXyidl8N8ClrjP3OLmDD/9BO2EofTf7XqrAn7AWKgRimTq7d4njmhO5wR6sTh2yN
	UW7x2rrJZJlzcfJ0eUGoJsHahVTtbue5jUxFk9XAMoJF41LJFDOtYBDm+MGa+7qQpnplTljzzYG
	tuHP/0RWFEhXtriKJMtvtjBQsK6hFkE+4PRneGRyGCieGLAguhKCcrnGPS6B5+SpWvOihEkS9dJ
	/z/RnAfEQHkfGE7aUVns
X-Google-Smtp-Source: AGHT+IEyC15TnZIAvUKjVtLm/x4/Lo6Nn8PENAHDVB3FMrtCAy7HQuzopUgCjPn21zM5n19hoHeGqw==
X-Received: by 2002:a05:6a00:9297:b0:727:39a4:30cc with SMTP id d2e1a72fcca58-7329cd75fe4mr5153986b3a.1.1739956963747;
        Wed, 19 Feb 2025 01:22:43 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325b1afd0esm9030926b3a.137.2025.02.19.01.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:22:43 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag
Date: Wed, 19 Feb 2025 10:20:57 +0100
Message-ID: <20250219092059.90850-4-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250219092059.90850-1-roger.pau@citrix.com>
References: <20250219092059.90850-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both
MSI and MSI-X entries globally, regardless of the IRQ chip they are using.
Only Xen sets the pci_msi_ignore_mask when routing physical interrupts over
event channels, to prevent PCI code from attempting to toggle the maskbit,
as it's Xen that controls the bit.

However, the pci_msi_ignore_mask being global will affect devices that use
MSI interrupts but are not routing those interrupts over event channels
(not using the Xen pIRQ chip).  One example is devices behind a VMD PCI
bridge.  In that scenario the VMD bridge configures MSI(-X) using the
normal IRQ chip (the pIRQ one in the Xen case), and devices behind the
bridge configure the MSI entries using indexes into the VMD bridge MSI
table.  The VMD bridge then demultiplexes such interrupts and delivers to
the destination device(s).  Having pci_msi_ignore_mask set in that scenario
prevents (un)masking of MSI entries for devices behind the VMD bridge.

Move the signaling of no entry masking into the MSI domain flags, as that
allows setting it on a per-domain basis.  Set it for the Xen MSI domain
that uses the pIRQ chip, while leaving it unset for the rest of the
cases.

Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
with Xen dropping usage the variable is unneeded.

This fixes using devices behind a VMD bridge on Xen PV hardware domains.

Albeit Devices behind a VMD bridge are not known to Xen, that doesn't mean
Linux cannot use them.  By inhibiting the usage of
VMD_FEAT_CAN_BYPASS_MSI_REMAP and the removal of the pci_msi_ignore_mask
bodge devices behind a VMD bridge do work fine when use from a Linux Xen
hardware domain.  That's the whole point of the series.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Juergen Gross <jgross@suse.com>
---
Changes since v2:
 - Fix subject line.

Changes since v1:
 - Fix build.
 - Expand commit message.
---
 arch/x86/pci/xen.c    |  8 ++------
 drivers/pci/msi/msi.c | 37 +++++++++++++++++++++----------------
 include/linux/msi.h   |  3 ++-
 kernel/irq/msi.c      |  2 +-
 4 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 0f2fe524f60d..b8755cde2419 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -436,7 +436,8 @@ static struct msi_domain_ops xen_pci_msi_domain_ops = {
 };
 
 static struct msi_domain_info xen_pci_msi_domain_info = {
-	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
+	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS |
+				  MSI_FLAG_DEV_SYSFS | MSI_FLAG_NO_MASK,
 	.ops			= &xen_pci_msi_domain_ops,
 };
 
@@ -484,11 +485,6 @@ static __init void xen_setup_pci_msi(void)
 	 * in allocating the native domain and never use it.
 	 */
 	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
-	/*
-	 * With XEN PIRQ/Eventchannels in use PCI/MSI[-X] masking is solely
-	 * controlled by the hypervisor.
-	 */
-	pci_msi_ignore_mask = 1;
 }
 
 #else /* CONFIG_PCI_MSI */
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 2f647cac4cae..4c8c2b57b5f6 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -10,12 +10,12 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include "../pci.h"
 #include "msi.h"
 
 int pci_msi_enable = 1;
-int pci_msi_ignore_mask;
 
 /**
  * pci_msi_supported - check whether MSI may be enabled on a device
@@ -285,6 +285,8 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
 	struct msi_desc desc;
 	u16 control;
 
@@ -295,8 +297,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	/* Respect XEN's mask disabling */
-	if (pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -604,12 +605,15 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
+
 	desc->nvec_used				= 1;
 	desc->pci.msi_attrib.is_msix		= 1;
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !pci_msi_ignore_mask &&
+	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
 						  !desc->pci.msi_attrib.is_virtual;
 
 	if (desc->pci.msi_attrib.can_mask) {
@@ -659,9 +663,6 @@ static void msix_mask_all(void __iomem *base, int tsize)
 	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	int i;
 
-	if (pci_msi_ignore_mask)
-		return;
-
 	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -714,6 +715,8 @@ static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
 	int ret, tsize;
 	u16 control;
 
@@ -744,15 +747,17 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	/*
-	 * Ensure that all table entries are masked to prevent
-	 * stale entries from firing in a crash kernel.
-	 *
-	 * Done late to deal with a broken Marvell NVME device
-	 * which takes the MSI-X mask bits into account even
-	 * when MSI-X is disabled, which prevents MSI delivery.
-	 */
-	msix_mask_all(dev->msix_base, tsize);
+	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+		/*
+		 * Ensure that all table entries are masked to prevent
+		 * stale entries from firing in a crash kernel.
+		 *
+		 * Done late to deal with a broken Marvell NVME device
+		 * which takes the MSI-X mask bits into account even
+		 * when MSI-X is disabled, which prevents MSI delivery.
+		 */
+		msix_mask_all(dev->msix_base, tsize);
+	}
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..59a421fc42bf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -73,7 +73,6 @@ struct msi_msg {
 	};
 };
 
-extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
@@ -556,6 +555,8 @@ enum {
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 	/* PCI MSIs cannot be steered separately to CPU cores */
 	MSI_FLAG_NO_AFFINITY		= (1 << 21),
+	/* Inhibit usage of entry masking */
+	MSI_FLAG_NO_MASK		= (1 << 22),
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..7682c36cbccc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1143,7 +1143,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		return false;
 
 	/*
-- 
2.46.0



Return-Path: <linux-kernel+bounces-577563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE33A71ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B7316F332
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A9E253331;
	Wed, 26 Mar 2025 19:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pl1+jBgA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aB1rHemM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A41428F4
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 19:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743016101; cv=none; b=qCFs+gnlViQ8HntnTHiUpd3QsrQnI3rfxlqwITuzszC1PxtRGmzRjTaJD9OFCzO5OyTaytKdpIPfkB/DV91eKv6Rjnzv7DKRKlFxKc7vMvKgwUr4jgaOA9XYalBGXMnzFlCFge7DRDZF0Ec/bh8zKy/UpIc7uZhbsPmZo2kHCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743016101; c=relaxed/simple;
	bh=rKdARyh/7xryL4FsuGnOvUqeotsKtYkn3PCl5CZv6FI=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=Q8qWIbN0QUw1XN9k0NuiiXGdXjQHTOgbrQ5PFkBZeZ9evnplaAPZ1iTXVuzI6WlaSqDxw9IYgumU1/UgbKI20XRwaP9y5dxW0qngkC0APmigI1H1c9/Ur4w5rt6koaoB+4aXEjff3SSBT8CvkhWd4sNYmfm0XnySgC5Zd9QX62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pl1+jBgA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aB1rHemM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743016097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+IdcU6v6hXvGncvboKhgsEuWCinXYfrSAGQG0YPOv8w=;
	b=pl1+jBgAwXboMC9Tluxh2R2NbQXv1l248iaoGTC2W9JNv0I7BlCT2mVERYSnfWgEOwjpXg
	cW/AiR6hyfe4FVeXWUAIFHbM4PzzlQqNFHRFzZoyUU2kK3wa4cuqSiQvNyBzqya1sLEhvD
	wAnixdFLE78WnZgfoFP5+x/mILhhU3AzV6m3zt23WUwTsOoFusyTNSe389JyuiWNj/Nqzl
	K+2+YnPV6BAcwq2tJ8v1NtDEIzWC0ojEDxb3A00JeOWSdoXVKnKIaBSlh8uZGlyCP7FlD4
	zZU81xM6R5FRVWn5W98PwMq96K6cBA8BTvzeAMY+Cl4ROyT1frUpsHwqPnOSxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743016097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+IdcU6v6hXvGncvboKhgsEuWCinXYfrSAGQG0YPOv8w=;
	b=aB1rHemMOKycZS69dptG9Y9VWiNvMOyqyeRnXREw7zePV4jZI7NL2IAupRsHaEHFiHHek6
	PQTepRO3iVXA7xCA==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for v6.15-rc1
Message-ID: 
 <174301605628.1660948.615494869949872320.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Mar 2025 20:08:16 +0100 (CET)

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2025-=
03-26

up to:  3ece3e8e5976: PCI/MSI: Handle the NOMASK flag correctly for all PCI/M=
SI backends

A urgent fix for the XEN related PCI/MSI changes:

  XEN used a global variable to disable the masking of MSI interrupts as
  XEN handles that on the hypervisor side. This turned out to be a problem
  with VMD as the PCI devices behind a VMD bridge are not always handled
  by the hypervisor and then require masking by guest.

  To solve this the global variable was replaced by a interrupt domain
  specific flag, which is set by the generic XEN PCI/MSI domain, but not by
  VMD or any other domain in the system.

  So far, so good. But the implementation (and the reviewer) missed the
  fact, that accessing the domain flag cannot be done directly because
  there are at least two situations, where this fails. Legacy architectures
  are not providing interrupt domains at all. The new MSI parent domains do
  not require to have a domain info pointer. Both cases result in a
  unconditional NULL pointer derefence.

  The PCI/MSI code already has a function to query the MSI domain specific
  flag in a safe way, which handles all possible cases of PCI/MSI backends.

  So the fix it simply to replace the open coded checks by invoking the
  safe helper to query the flag.

Note: This is hot of the press, but has been tested and validated. As it
      affects a lot of people, I fast tracked it.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends


 drivers/pci/msi/msi.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index d74162880d83..7058d59e7c5f 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -285,8 +285,6 @@ static void pci_msi_set_enable(struct pci_dev *dev, int e=
nable)
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
-	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info =3D d->host_data;
 	struct msi_desc desc;
 	u16 control;
=20
@@ -297,7 +295,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nv=
ec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |=3D PCI_MSI_FLAGS_MASKBIT;
-	if (info->flags & MSI_FLAG_NO_MASK)
+	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
 		control &=3D ~PCI_MSI_FLAGS_MASKBIT;
=20
 	desc.nvec_used			=3D nvec;
@@ -604,20 +602,18 @@ static void __iomem *msix_map_region(struct pci_dev *de=
v,
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
-	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info =3D d->host_data;
-
 	desc->nvec_used				=3D 1;
 	desc->pci.msi_attrib.is_msix		=3D 1;
 	desc->pci.msi_attrib.is_64		=3D 1;
 	desc->pci.msi_attrib.default_irq	=3D dev->irq;
 	desc->pci.mask_base			=3D dev->msix_base;
-	desc->pci.msi_attrib.can_mask		=3D !(info->flags & MSI_FLAG_NO_MASK) &&
-						  !desc->pci.msi_attrib.is_virtual;
=20
-	if (desc->pci.msi_attrib.can_mask) {
+
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
+	    !desc->pci.msi_attrib.is_virtual) {
 		void __iomem *addr =3D pci_msix_desc_addr(desc);
=20
+		desc->pci.msi_attrib.can_mask =3D 1;
 		desc->pci.msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
@@ -715,8 +711,6 @@ static int msix_setup_interrupts(struct pci_dev *dev, str=
uct msix_entry *entries
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entr=
ies,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info =3D d->host_data;
 	int ret, tsize;
 	u16 control;
=20
@@ -747,7 +741,7 @@ static int msix_capability_init(struct pci_dev *dev, stru=
ct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
=20
-	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
 		/*
 		 * Ensure that all table entries are masked to prevent
 		 * stale entries from firing in a crash kernel.



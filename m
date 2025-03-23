Return-Path: <linux-kernel+bounces-572917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A76EA6D06D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 18:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A6188F39D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D166194A65;
	Sun, 23 Mar 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PQTdciBg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9mA4HyPI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F5F18FDDB
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 17:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742752301; cv=none; b=KekMkAnT8/ZZ3/AR+tgA+t+1IVYGhq0jxdG6t8IuC+yuKo6C7n5RGLQ9K4NTTTjNZYCsRwQR4M5C2yLM666a7cwpWM6St3dnAUqRO5o2x3WovzKZ1gbhEYq7/pMaFX0AjROTCy9fxXkvknu5kIwSgLw2LPPL8P5aYDQa5bfqlA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742752301; c=relaxed/simple;
	bh=r9cHRY5uiVTmN4Ax5pl32LnoWnQ7UaktlpclarMXMvk=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=JIETRbVXiWY+M5sFE3+AnCKBTEldNkqVGm5Lnle2ZmGKZNxuZf2ixzc8fXrrO/t/e41cbrumSs8CS5JfrGW9z/ULP+gJqdG9Dncjxz/X6LauN+AZLyUWdlHCpVlsLk9gOTOEldAuVyjG03Yd6Fpho+uSZ7+qwYMAHdHKuJwJjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PQTdciBg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9mA4HyPI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742752297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=0ZlYJbmKSDYkrMnga/SJwW52wgxL4243xgHfcc8NsMQ=;
	b=PQTdciBgP7G2NLPFaAVzP9b733sb3Iss/ObJ/1xebaSzXf6G02Fpzar2Mh8TKTXE4nNE6K
	Vt5kAAE+5jOSjZi5o9hGVrAu3/g4sc7VuERu7+6hqEnNjTaemRxVplB9QzPxfDlrgx8aXb
	lizptEAMeCMSG3898RVDVqTsKa5WZPnYFYCg6Jy3IyaEXNdZy9E9PIR2ngSprggJtgUl8S
	3IQnsP9pH2zvVNDQtU4R2gNxQXpeNiiljAqor7bOZFEFHlDT9X4s3OZ0yZKXRFY5fIBYcP
	qZ9BXaWXtKqcWLjFqdi5gIVQrOUfvB3yR/uICW0zeZPHX2VkG/lI2L+yZiirTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742752297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=0ZlYJbmKSDYkrMnga/SJwW52wgxL4243xgHfcc8NsMQ=;
	b=9mA4HyPI++Fn7YDY6bPITyzsDrDTX7/k7S+h9EYC9qwwhRf+AHTRCnvcCfHMio5CzS7gs5
	l0KHWLMEa2mh6YCg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/msi for v6.15-rc1
References: <174275225552.1561082.4969731002775597670.tglx@xen13>
Message-ID: <174275225917.1561082.11153014835496302156.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 23 Mar 2025 18:51:36 +0100 (CET)

Linus,

please pull the latest irq/msi branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2025-03-=
23

up to:  8327df405921: genirq/msi: Rename msi_[un]lock_descs()


Updates for MSI interrupts

  - Switch the MSI descriptor locking to guards

  - Replace the broken PCI/TPH implementation, which lacks any form of
    serialization against concurrent modifications with a properly
    serialized mechanism in the PCI/MSI core code.

  - Replace the MSI descriptor abuse in the SCSI/UFS Qualcom driver with
    dedicated driver internal storage.

Thanks,

	tglx

------------------>
Hans Zhang (1):
      genirq/msi: Expose MSI message data in debugfs

Thomas Gleixner (11):
      genirq/msi: Make a few functions static
      cleanup: Provide retain_ptr()
      genirq/msi: Use lock guards for MSI descriptor locking
      soc: ti: ti_sci_inta_msi: Switch MSI descriptor locking to guard()
      NTB/msi: Switch MSI descriptor locking to lock guard()
      PCI/MSI: Switch to MSI descriptor locking to guard()
      PCI: hv: Switch MSI descriptor locking to guard()
      PCI/MSI: Provide a sane mechanism for TPH
      PCI/TPH: Replace the broken MSI-X control word update
      scsi: ufs: qcom: Remove the MSI descriptor abuse
      genirq/msi: Rename msi_[un]lock_descs()


 drivers/ntb/msi.c                   |  22 ++---
 drivers/pci/controller/pci-hyperv.c |  14 +--
 drivers/pci/msi/api.c               |   6 +-
 drivers/pci/msi/msi.c               | 167 +++++++++++++++++++++------------
 drivers/pci/pci.h                   |   9 ++
 drivers/pci/tph.c                   |  44 +--------
 drivers/soc/ti/ti_sci_inta_msi.c    |  10 +-
 drivers/ufs/host/ufs-qcom.c         |  75 +++++++--------
 include/linux/cleanup.h             |  17 ++++
 include/linux/irqdomain.h           |   2 +
 include/linux/msi.h                 |  12 +--
 kernel/irq/msi.c                    | 180 +++++++++++++++-------------------=
--
 12 files changed, 271 insertions(+), 287 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 6295e55ef85e..368f6d894bba 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -106,10 +106,10 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	if (!ntb->msi)
 		return -EINVAL;
=20
-	msi_lock_descs(&ntb->pdev->dev);
-	desc =3D msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
-	addr =3D desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
-	msi_unlock_descs(&ntb->pdev->dev);
+	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
+		desc =3D msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
+		addr =3D desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+	}
=20
 	for (peer =3D 0; peer < ntb_peer_port_count(ntb); peer++) {
 		peer_widx =3D ntb_peer_highest_mw_idx(ntb, peer);
@@ -289,7 +289,7 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, ir=
q_handler_t handler,
 	if (!ntb->msi)
 		return -EINVAL;
=20
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		if (irq_has_action(entry->irq))
 			continue;
@@ -307,17 +307,11 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, =
irq_handler_t handler,
 		ret =3D ntbm_msi_setup_callback(ntb, entry, msi_desc);
 		if (ret) {
 			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			goto unlock;
+			return ret;
 		}
-
-		ret =3D entry->irq;
-		goto unlock;
+		return entry->irq;
 	}
-	ret =3D -ENODEV;
-
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
+	return -ENODEV;
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
=20
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci=
-hyperv.c
index 6084b38bdda1..715446fd26a5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3976,24 +3976,18 @@ static int hv_pci_restore_msi_msg(struct pci_dev *pde=
v, void *arg)
 {
 	struct irq_data *irq_data;
 	struct msi_desc *entry;
-	int ret =3D 0;
=20
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		return 0;
=20
-	msi_lock_descs(&pdev->dev);
+	guard(msi_descs_lock)(&pdev->dev);
 	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data =3D irq_get_irq_data(entry->irq);
-		if (WARN_ON_ONCE(!irq_data)) {
-			ret =3D -EINVAL;
-			break;
-		}
-
+		if (WARN_ON_ONCE(!irq_data))
+			return -EINVAL;
 		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
-	msi_unlock_descs(&pdev->dev);
-
-	return ret;
+	return 0;
 }
=20
 /*
diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index b956ce591f96..d89f491afdf0 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -53,10 +53,9 @@ void pci_disable_msi(struct pci_dev *dev)
 	if (!pci_msi_enabled() || !dev || !dev->msi_enabled)
 		return;
=20
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	pci_msi_shutdown(dev);
 	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msi);
=20
@@ -196,10 +195,9 @@ void pci_disable_msix(struct pci_dev *dev)
 	if (!pci_msi_enabled() || !dev || !dev->msix_enabled)
 		return;
=20
-	msi_lock_descs(&dev->dev);
+	guard(msi_descs_lock)(&dev->dev);
 	pci_msix_shutdown(dev);
 	pci_free_msi_irqs(dev);
-	msi_unlock_descs(&dev->dev);
 }
 EXPORT_SYMBOL(pci_disable_msix);
=20
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 2f647cac4cae..dc78d9d402c3 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -336,41 +336,11 @@ static int msi_verify_entries(struct pci_dev *dev)
 	return !entry ? 0 : -EIO;
 }
=20
-/**
- * msi_capability_init - configure device's MSI capability structure
- * @dev: pointer to the pci_dev data structure of MSI device function
- * @nvec: number of interrupts to allocate
- * @affd: description of automatic IRQ affinity assignments (may be %NULL)
- *
- * Setup the MSI capability structure of the device with the requested
- * number of interrupts.  A return value of zero indicates the successful
- * setup of an entry with the new MSI IRQ.  A negative return value indicates
- * an error, and a positive return value indicates the number of interrupts
- * which could have been allocated.
- */
-static int msi_capability_init(struct pci_dev *dev, int nvec,
-			       struct irq_affinity *affd)
+static int __msi_capability_init(struct pci_dev *dev, int nvec, struct irq_a=
ffinity_desc *masks)
 {
-	struct irq_affinity_desc *masks =3D NULL;
+	int ret =3D msi_setup_msi_desc(dev, nvec, masks);
 	struct msi_desc *entry, desc;
-	int ret;
=20
-	/* Reject multi-MSI early on irq domain enabled architectures */
-	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW=
_LEGACY))
-		return 1;
-
-	/*
-	 * Disable MSI during setup in the hardware, but mark it enabled
-	 * so that setup code can evaluate it.
-	 */
-	pci_msi_set_enable(dev, 0);
-	dev->msi_enabled =3D 1;
-
-	if (affd)
-		masks =3D irq_create_affinity_masks(nvec, affd);
-
-	msi_lock_descs(&dev->dev);
-	ret =3D msi_setup_msi_desc(dev, nvec, masks);
 	if (ret)
 		goto fail;
=20
@@ -399,19 +369,48 @@ static int msi_capability_init(struct pci_dev *dev, int=
 nvec,
=20
 	pcibios_free_irq(dev);
 	dev->irq =3D entry->irq;
-	goto unlock;
-
+	return 0;
 err:
 	pci_msi_unmask(&desc, msi_multi_mask(&desc));
 	pci_free_msi_irqs(dev);
 fail:
 	dev->msi_enabled =3D 0;
-unlock:
-	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
=20
+/**
+ * msi_capability_init - configure device's MSI capability structure
+ * @dev: pointer to the pci_dev data structure of MSI device function
+ * @nvec: number of interrupts to allocate
+ * @affd: description of automatic IRQ affinity assignments (may be %NULL)
+ *
+ * Setup the MSI capability structure of the device with the requested
+ * number of interrupts.  A return value of zero indicates the successful
+ * setup of an entry with the new MSI IRQ.  A negative return value indicates
+ * an error, and a positive return value indicates the number of interrupts
+ * which could have been allocated.
+ */
+static int msi_capability_init(struct pci_dev *dev, int nvec,
+			       struct irq_affinity *affd)
+{
+	/* Reject multi-MSI early on irq domain enabled architectures */
+	if (nvec > 1 && !pci_msi_domain_supports(dev, MSI_FLAG_MULTI_PCI_MSI, ALLOW=
_LEGACY))
+		return 1;
+
+	/*
+	 * Disable MSI during setup in the hardware, but mark it enabled
+	 * so that setup code can evaluate it.
+	 */
+	pci_msi_set_enable(dev, 0);
+	dev->msi_enabled =3D 1;
+
+	struct irq_affinity_desc *masks __free(kfree) =3D
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+
+	guard(msi_descs_lock)(&dev->dev);
+	return __msi_capability_init(dev, nvec, masks);
+}
+
 int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 			   struct irq_affinity *affd)
 {
@@ -666,40 +665,41 @@ static void msix_mask_all(void __iomem *base, int tsize)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
=20
-static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *ent=
ries,
-				 int nvec, struct irq_affinity *affd)
+static int __msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *e=
ntries,
+				   int nvec, struct irq_affinity_desc *masks)
 {
-	struct irq_affinity_desc *masks =3D NULL;
-	int ret;
-
-	if (affd)
-		masks =3D irq_create_affinity_masks(nvec, affd);
+	int ret =3D msix_setup_msi_descs(dev, entries, nvec, masks);
=20
-	msi_lock_descs(&dev->dev);
-	ret =3D msix_setup_msi_descs(dev, entries, nvec, masks);
 	if (ret)
-		goto out_free;
+		goto fail;
=20
 	ret =3D pci_msi_setup_msi_irqs(dev, nvec, PCI_CAP_ID_MSIX);
 	if (ret)
-		goto out_free;
+		goto fail;
=20
 	/* Check if all MSI entries honor device restrictions */
 	ret =3D msi_verify_entries(dev);
 	if (ret)
-		goto out_free;
+		goto fail;
=20
 	msix_update_entries(dev, entries);
-	goto out_unlock;
+	return 0;
=20
-out_free:
+fail:
 	pci_free_msi_irqs(dev);
-out_unlock:
-	msi_unlock_descs(&dev->dev);
-	kfree(masks);
 	return ret;
 }
=20
+static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *ent=
ries,
+				 int nvec, struct irq_affinity *affd)
+{
+	struct irq_affinity_desc *masks __free(kfree) =3D
+		affd ? irq_create_affinity_masks(nvec, affd) : NULL;
+
+	guard(msi_descs_lock)(&dev->dev);
+	return __msix_setup_interrupts(dev, entries, nvec, masks);
+}
+
 /**
  * msix_capability_init - configure device's MSI-X capability
  * @dev: pointer to the pci_dev data structure of MSI-X device function
@@ -871,13 +871,13 @@ void __pci_restore_msix_state(struct pci_dev *dev)
=20
 	write_msg =3D arch_restore_msi_irqs(dev);
=20
-	msi_lock_descs(&dev->dev);
-	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (write_msg)
-			__pci_write_msi_msg(entry, &entry->msg);
-		pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+	scoped_guard (msi_descs_lock, &dev->dev) {
+		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
+			if (write_msg)
+				__pci_write_msi_msg(entry, &entry->msg);
+			pci_msix_write_vector_ctrl(entry, entry->pci.msix_ctrl);
+		}
 	}
-	msi_unlock_descs(&dev->dev);
=20
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
@@ -916,6 +916,53 @@ void pci_free_msi_irqs(struct pci_dev *dev)
 	}
 }
=20
+#ifdef CONFIG_PCIE_TPH
+/**
+ * pci_msix_write_tph_tag - Update the TPH tag for a given MSI-X vector
+ * @pdev:	The PCIe device to update
+ * @index:	The MSI-X index to update
+ * @tag:	The tag to write
+ *
+ * Returns: 0 on success, error code on failure
+ */
+int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
+{
+	struct msi_desc *msi_desc;
+	struct irq_desc *irq_desc;
+	unsigned int virq;
+
+	if (!pdev->msix_enabled)
+		return -ENXIO;
+
+	guard(msi_descs_lock)(&pdev->dev);
+	virq =3D msi_get_virq(&pdev->dev, index);
+	if (!virq)
+		return -ENXIO;
+	/*
+	 * This is a horrible hack, but short of implementing a PCI
+	 * specific interrupt chip callback and a huge pile of
+	 * infrastructure, this is the minor nuissance. It provides the
+	 * protection against concurrent operations on this entry and keeps
+	 * the control word cache in sync.
+	 */
+	irq_desc =3D irq_to_desc(virq);
+	if (!irq_desc)
+		return -ENXIO;
+
+	guard(raw_spinlock_irq)(&irq_desc->lock);
+	msi_desc =3D irq_data_get_msi_desc(&irq_desc->irq_data);
+	if (!msi_desc || msi_desc->pci.msi_attrib.is_virtual)
+		return -ENXIO;
+
+	msi_desc->pci.msix_ctrl &=3D ~PCI_MSIX_ENTRY_CTRL_ST;
+	msi_desc->pci.msix_ctrl |=3D FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
+	pci_msix_write_vector_ctrl(msi_desc, msi_desc->pci.msix_ctrl);
+	/* Flush the write */
+	readl(pci_msix_desc_addr(msi_desc));
+	return 0;
+}
+#endif
+
 /* Misc. infrastructure */
=20
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..2e9cf26a9ee9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -989,6 +989,15 @@ int pcim_request_region_exclusive(struct pci_dev *pdev, =
int bar,
 				  const char *name);
 void pcim_release_region(struct pci_dev *pdev, int bar);
=20
+#ifdef CONFIG_PCI_MSI
+int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag=
);
+#else
+static inline int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int =
index, u16 tag)
+{
+	return -ENODEV;
+}
+#endif
+
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index 07de59ca2ebf..77fce5e1b830 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -204,48 +204,6 @@ static u8 get_rp_completer_type(struct pci_dev *pdev)
 	return FIELD_GET(PCI_EXP_DEVCAP2_TPH_COMP_MASK, reg);
 }
=20
-/* Write ST to MSI-X vector control reg - Return 0 if OK, otherwise -errno */
-static int write_tag_to_msix(struct pci_dev *pdev, int msix_idx, u16 tag)
-{
-#ifdef CONFIG_PCI_MSI
-	struct msi_desc *msi_desc =3D NULL;
-	void __iomem *vec_ctrl;
-	u32 val;
-	int err =3D 0;
-
-	msi_lock_descs(&pdev->dev);
-
-	/* Find the msi_desc entry with matching msix_idx */
-	msi_for_each_desc(msi_desc, &pdev->dev, MSI_DESC_ASSOCIATED) {
-		if (msi_desc->msi_index =3D=3D msix_idx)
-			break;
-	}
-
-	if (!msi_desc) {
-		err =3D -ENXIO;
-		goto err_out;
-	}
-
-	/* Get the vector control register (offset 0xc) pointed by msix_idx */
-	vec_ctrl =3D pdev->msix_base + msix_idx * PCI_MSIX_ENTRY_SIZE;
-	vec_ctrl +=3D PCI_MSIX_ENTRY_VECTOR_CTRL;
-
-	val =3D readl(vec_ctrl);
-	val &=3D ~PCI_MSIX_ENTRY_CTRL_ST;
-	val |=3D FIELD_PREP(PCI_MSIX_ENTRY_CTRL_ST, tag);
-	writel(val, vec_ctrl);
-
-	/* Read back to flush the update */
-	val =3D readl(vec_ctrl);
-
-err_out:
-	msi_unlock_descs(&pdev->dev);
-	return err;
-#else
-	return -ENODEV;
-#endif
-}
-
 /* Write tag to ST table - Return 0 if OK, otherwise -errno */
 static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
 {
@@ -346,7 +304,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned =
int index, u16 tag)
=20
 	switch (loc) {
 	case PCI_TPH_LOC_MSIX:
-		err =3D write_tag_to_msix(pdev, index, tag);
+		err =3D pci_msix_write_tph_tag(pdev, index, tag);
 		break;
 	case PCI_TPH_LOC_CAP:
 		err =3D write_tag_to_st_table(pdev, index, tag);
diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_ms=
i.c
index c36364522157..193266f5e3f9 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -103,19 +103,15 @@ int ti_sci_inta_msi_domain_alloc_irqs(struct device *de=
v,
 	if (ret)
 		return ret;
=20
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	nvec =3D ti_sci_inta_msi_alloc_descs(dev, res);
-	if (nvec <=3D 0) {
-		ret =3D nvec;
-		goto unlock;
-	}
+	if (nvec <=3D 0)
+		return nvec;
=20
 	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
 	ret =3D msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
 	if (ret)
 		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
-unlock:
-	msi_unlock_descs(dev);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 23b9f6efa047..2cfa1774944b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1782,15 +1782,19 @@ static void ufs_qcom_write_msi_msg(struct msi_desc *d=
esc, struct msi_msg *msg)
 	ufshcd_mcq_config_esi(hba, msg);
 }
=20
+struct ufs_qcom_irq {
+	unsigned int		irq;
+	unsigned int		idx;
+	struct ufs_hba		*hba;
+};
+
 static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 {
-	struct msi_desc *desc =3D data;
-	struct device *dev =3D msi_desc_to_dev(desc);
-	struct ufs_hba *hba =3D dev_get_drvdata(dev);
-	u32 id =3D desc->msi_index;
-	struct ufs_hw_queue *hwq =3D &hba->uhq[id];
+	struct ufs_qcom_irq *qi =3D data;
+	struct ufs_hba *hba =3D qi->hba;
+	struct ufs_hw_queue *hwq =3D &hba->uhq[qi->idx];
=20
-	ufshcd_mcq_write_cqis(hba, 0x1, id);
+	ufshcd_mcq_write_cqis(hba, 0x1, qi->idx);
 	ufshcd_mcq_poll_cqe_lock(hba, hwq);
=20
 	return IRQ_HANDLED;
@@ -1799,8 +1803,7 @@ static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, vo=
id *data)
 static int ufs_qcom_config_esi(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host =3D ufshcd_get_variant(hba);
-	struct msi_desc *desc;
-	struct msi_desc *failed_desc =3D NULL;
+	struct ufs_qcom_irq *qi;
 	int nr_irqs, ret;
=20
 	if (host->esi_enabled)
@@ -1811,47 +1814,47 @@ static int ufs_qcom_config_esi(struct ufs_hba *hba)
 	 * 2. Poll queues do not need ESI.
 	 */
 	nr_irqs =3D hba->nr_hw_queues - hba->nr_queues[HCTX_TYPE_POLL];
+	qi =3D devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi), GFP_KERNEL);
+	if (qi)
+		return -ENOMEM;
+
 	ret =3D platform_device_msi_init_and_alloc_irqs(hba->dev, nr_irqs,
 						      ufs_qcom_write_msi_msg);
 	if (ret) {
 		dev_err(hba->dev, "Failed to request Platform MSI %d\n", ret);
-		return ret;
+		goto cleanup;
 	}
=20
-	msi_lock_descs(hba->dev);
-	msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-		ret =3D devm_request_irq(hba->dev, desc->irq,
-				       ufs_qcom_mcq_esi_handler,
-				       IRQF_SHARED, "qcom-mcq-esi", desc);
+	for (int idx =3D 0; idx < nr_irqs; idx++) {
+		qi[idx].irq =3D msi_get_virq(hba->dev, idx);
+		qi[idx].idx =3D idx;
+		qi[idx].hba =3D hba;
+
+		ret =3D devm_request_irq(hba->dev, qi[idx].irq, ufs_qcom_mcq_esi_handler,
+				       IRQF_SHARED, "qcom-mcq-esi", qi + idx);
 		if (ret) {
 			dev_err(hba->dev, "%s: Fail to request IRQ for %d, err =3D %d\n",
-				__func__, desc->irq, ret);
-			failed_desc =3D desc;
-			break;
+				__func__, qi[idx].irq, ret);
+			qi[idx].irq =3D 0;
+			goto cleanup;
 		}
 	}
-	msi_unlock_descs(hba->dev);
=20
-	if (ret) {
-		/* Rewind */
-		msi_lock_descs(hba->dev);
-		msi_for_each_desc(desc, hba->dev, MSI_DESC_ALL) {
-			if (desc =3D=3D failed_desc)
-				break;
-			devm_free_irq(hba->dev, desc->irq, hba);
-		}
-		msi_unlock_descs(hba->dev);
-		platform_device_msi_free_irqs_all(hba->dev);
-	} else {
-		if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D 0 &&
-		    host->hw_ver.step =3D=3D 0)
-			ufshcd_rmwl(hba, ESI_VEC_MASK,
-				    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
-				    REG_UFS_CFG3);
-		ufshcd_mcq_enable_esi(hba);
-		host->esi_enabled =3D true;
+	if (host->hw_ver.major =3D=3D 6 && host->hw_ver.minor =3D=3D 0 &&
+	    host->hw_ver.step =3D=3D 0) {
+		ufshcd_rmwl(hba, ESI_VEC_MASK,
+			    FIELD_PREP(ESI_VEC_MASK, MAX_ESI_VEC - 1),
+			    REG_UFS_CFG3);
 	}
+	ufshcd_mcq_enable_esi(hba);
+	host->esi_enabled =3D true;
+	return 0;
=20
+cleanup:
+	for (int idx =3D 0; qi[idx].irq; idx++)
+		devm_free_irq(hba->dev, qi[idx].irq, hba);
+	platform_device_msi_free_irqs_all(hba->dev);
+	devm_kfree(hba->dev, qi);
 	return ret;
 }
=20
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index ec00e3f7af2b..6537f8dfe1bb 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,23 @@ const volatile void * __must_check_fn(const volatile voi=
d *val)
=20
 #define return_ptr(p)	return no_free_ptr(p)
=20
+/*
+ * Only for situations where an allocation is handed in to another function
+ * and consumed by that function on success.
+ *
+ *	struct foo *f __free(kfree) =3D kzalloc(sizeof(*f), GFP_KERNEL);
+ *
+ *	setup(f);
+ *	if (some_condition)
+ *		return -EINVAL;
+ *	....
+ *	ret =3D bar(f);
+ *	if (!ret)
+ *		retain_ptr(f);
+ *	return ret;
+ */
+#define retain_ptr(p)				\
+	__get_and_null(p, NULL)
=20
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e432b6a12a32..d258aa2fc022 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -281,6 +281,8 @@ static inline struct fwnode_handle *irq_domain_alloc_fwno=
de(phys_addr_t *pa)
=20
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
=20
+DEFINE_FREE(irq_domain_free_fwnode, struct fwnode_handle *, if (_T) irq_doma=
in_free_fwnode(_T))
+
 struct irq_domain_chip_generic_info;
=20
 /**
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..0c39cafaf604 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -81,7 +81,6 @@ struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
=20
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
 #else
@@ -225,8 +224,11 @@ struct msi_dev_domain {
=20
 int msi_setup_device_data(struct device *dev);
=20
-void msi_lock_descs(struct device *dev);
-void msi_unlock_descs(struct device *dev);
+void __msi_lock_descs(struct device *dev);
+void __msi_unlock_descs(struct device *dev);
+
+DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, __msi_lock_descs(_T->lock=
),
+		    __msi_unlock_descs(_T->lock));
=20
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domi=
d,
 				       enum msi_desc_filter filter);
@@ -603,8 +605,6 @@ void msi_remove_device_irq_domain(struct device *dev, uns=
igned int domid);
 bool msi_match_device_irq_domain(struct device *dev, unsigned int domid,
 				 enum irq_domain_bus_token bus_token);
=20
-int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domi=
d,
-				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_all_locked(struct device *dev, unsigned int domid,=
 int nirqs);
@@ -613,8 +613,6 @@ struct msi_map msi_domain_alloc_irq_at(struct device *dev=
, unsigned int domid, u
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_instance_cookie *cookie);
=20
-void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domi=
d,
-				       unsigned int first, unsigned int last);
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last);
 void msi_domain_free_irqs_all_locked(struct device *dev, unsigned int domid);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..ad4a85e31160 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
@@ -269,16 +270,11 @@ static int msi_domain_add_simple_msi_descs(struct devic=
e *dev, struct msi_ctrl *
 	return ret;
 }
=20
-void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
-{
-	*msg =3D entry->msg;
-}
-
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
 {
 	struct msi_desc *entry =3D irq_get_msi_desc(irq);
=20
-	__get_cached_msi_msg(entry, msg);
+	*msg =3D entry->msg;
 }
 EXPORT_SYMBOL_GPL(get_cached_msi_msg);
=20
@@ -342,26 +338,30 @@ int msi_setup_device_data(struct device *dev)
 }
=20
 /**
- * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * __msi_lock_descs - Lock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_lock_descs(struct device *dev)
+void __msi_lock_descs(struct device *dev)
 {
 	mutex_lock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_lock_descs);
+EXPORT_SYMBOL_GPL(__msi_lock_descs);
=20
 /**
- * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * __msi_unlock_descs - Unlock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_unlock_descs(struct device *dev)
+void __msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx =3D MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_unlock_descs);
+EXPORT_SYMBOL_GPL(__msi_unlock_descs);
=20
 static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned i=
nt domid,
 				      enum msi_desc_filter filter)
@@ -447,7 +447,6 @@ EXPORT_SYMBOL_GPL(msi_next_desc);
 unsigned int msi_domain_get_virq(struct device *dev, unsigned int domid, uns=
igned int index)
 {
 	struct msi_desc *desc;
-	unsigned int ret =3D 0;
 	bool pcimsi =3D false;
 	struct xarray *xa;
=20
@@ -461,7 +460,7 @@ unsigned int msi_domain_get_virq(struct device *dev, unsi=
gned int domid, unsigne
 	if (dev_is_pci(dev) && domid =3D=3D MSI_DEFAULT_DOMAIN)
 		pcimsi =3D to_pci_dev(dev)->msi_enabled;
=20
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	xa =3D &dev->msi.data->__domains[domid].store;
 	desc =3D xa_load(xa, pcimsi ? 0 : index);
 	if (desc && desc->irq) {
@@ -470,16 +469,12 @@ unsigned int msi_domain_get_virq(struct device *dev, un=
signed int domid, unsigne
 		 * PCI-MSIX and platform MSI use a descriptor per
 		 * interrupt.
 		 */
-		if (pcimsi) {
-			if (index < desc->nvec_used)
-				ret =3D desc->irq + index;
-		} else {
-			ret =3D desc->irq;
-		}
+		if (!pcimsi)
+			return desc->irq;
+		if (index < desc->nvec_used)
+			return desc->irq + index;
 	}
-
-	msi_unlock_descs(dev);
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(msi_domain_get_virq);
=20
@@ -756,12 +751,30 @@ static int msi_domain_translate(struct irq_domain *doma=
in, struct irq_fwspec *fw
 	return info->ops->msi_translate(domain, fwspec, hwirq, type);
 }
=20
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+static void msi_domain_debug_show(struct seq_file *m, struct irq_domain *d,
+				  struct irq_data *irqd, int ind)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(irqd);
+
+	if (!desc)
+		return;
+
+	seq_printf(m, "\n%*saddress_hi: 0x%08x", ind + 1, "", desc->msg.address_hi);
+	seq_printf(m, "\n%*saddress_lo: 0x%08x", ind + 1, "", desc->msg.address_lo);
+	seq_printf(m, "\n%*smsg_data:   0x%08x\n", ind + 1, "", desc->msg.data);
+}
+#endif
+
 static const struct irq_domain_ops msi_domain_ops =3D {
 	.alloc		=3D msi_domain_alloc,
 	.free		=3D msi_domain_free,
 	.activate	=3D msi_domain_activate,
 	.deactivate	=3D msi_domain_deactivate,
 	.translate	=3D msi_domain_translate,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS
+	.debug_show     =3D msi_domain_debug_show,
+#endif
 };
=20
 static irq_hw_number_t msi_domain_ops_get_hwirq(struct msi_domain_info *info,
@@ -979,9 +992,8 @@ bool msi_create_device_irq_domain(struct device *dev, uns=
igned int domid,
 				  void *chip_data)
 {
 	struct irq_domain *domain, *parent =3D dev->msi.domain;
-	struct fwnode_handle *fwnode, *fwnalloced =3D NULL;
-	struct msi_domain_template *bundle;
 	const struct msi_parent_ops *pops;
+	struct fwnode_handle *fwnode;
=20
 	if (!irq_domain_is_msi_parent(parent))
 		return false;
@@ -989,7 +1001,8 @@ bool msi_create_device_irq_domain(struct device *dev, un=
signed int domid,
 	if (domid >=3D MSI_MAX_DEVICE_IRQDOMAINS)
 		return false;
=20
-	bundle =3D kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	struct msi_domain_template *bundle __free(kfree) =3D
+		bundle =3D kmemdup(template, sizeof(*bundle), GFP_KERNEL);
 	if (!bundle)
 		return false;
=20
@@ -1012,41 +1025,36 @@ bool msi_create_device_irq_domain(struct device *dev,=
 unsigned int domid,
 	 * node as they are not guaranteed to have a fwnode. They are never
 	 * looked up and always handled in the context of the device.
 	 */
-	if (bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE)
-		fwnode =3D dev->fwnode;
+	struct fwnode_handle *fwnode_alloced __free(irq_domain_free_fwnode) =3D NUL=
L;
+
+	if (!(bundle->info.flags & MSI_FLAG_USE_DEV_FWNODE))
+		fwnode =3D fwnode_alloced =3D irq_domain_alloc_named_fwnode(bundle->name);
 	else
-		fwnode =3D fwnalloced =3D irq_domain_alloc_named_fwnode(bundle->name);
+		fwnode =3D dev->fwnode;
=20
 	if (!fwnode)
-		goto free_bundle;
+		return false;
=20
 	if (msi_setup_device_data(dev))
-		goto free_fwnode;
-
-	msi_lock_descs(dev);
+		return false;
=20
+	guard(msi_descs_lock)(dev);
 	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
-		goto fail;
+		return false;
=20
 	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
-		goto fail;
+		return false;
=20
 	domain =3D __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_M=
SI_DEVICE, parent);
 	if (!domain)
-		goto fail;
+		return false;
=20
+	/* @bundle and @fwnode_alloced are now in use. Prevent cleanup */
+	retain_ptr(bundle);
+	retain_ptr(fwnode_alloced);
 	domain->dev =3D dev;
 	dev->msi.data->__domains[domid].domain =3D domain;
-	msi_unlock_descs(dev);
 	return true;
-
-fail:
-	msi_unlock_descs(dev);
-free_fwnode:
-	irq_domain_free_fwnode(fwnalloced);
-free_bundle:
-	kfree(bundle);
-	return false;
 }
=20
 /**
@@ -1060,12 +1068,10 @@ void msi_remove_device_irq_domain(struct device *dev,=
 unsigned int domid)
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
=20
-	msi_lock_descs(dev);
-
+	guard(msi_descs_lock)(dev);
 	domain =3D msi_get_device_domain(dev, domid);
-
 	if (!domain || !irq_domain_is_msi_device(domain))
-		goto unlock;
+		return;
=20
 	dev->msi.data->__domains[domid].domain =3D NULL;
 	info =3D domain->host_data;
@@ -1074,9 +1080,6 @@ void msi_remove_device_irq_domain(struct device *dev, u=
nsigned int domid)
 	irq_domain_remove(domain);
 	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
-
-unlock:
-	msi_unlock_descs(dev);
 }
=20
 /**
@@ -1092,16 +1095,14 @@ bool msi_match_device_irq_domain(struct device *dev, =
unsigned int domid,
 {
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
-	bool ret =3D false;
=20
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	domain =3D msi_get_device_domain(dev, domid);
 	if (domain && irq_domain_is_msi_device(domain)) {
 		info =3D domain->host_data;
-		ret =3D info->bus_token =3D=3D bus_token;
+		return info->bus_token =3D=3D bus_token;
 	}
-	msi_unlock_descs(dev);
-	return ret;
+	return false;
 }
=20
 static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device =
*dev,
@@ -1333,21 +1334,17 @@ static int msi_domain_alloc_locked(struct device *dev=
, struct msi_ctrl *ctrl)
 }
=20
 /**
- * msi_domain_alloc_irqs_range_locked - Allocate interrupts from a MSI inter=
rupt domain
+ * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt do=
main
  * @dev:	Pointer to device struct of the device for which the interrupts
  *		are allocated
  * @domid:	Id of the interrupt domain to operate on
  * @first:	First index to allocate (inclusive)
  * @last:	Last index to allocate (inclusive)
  *
- * Must be invoked from within a msi_lock_descs() / msi_unlock_descs()
- * pair. Use this for MSI irqdomains which implement their own descriptor
- * allocation/free.
- *
  * Return: %0 on success or an error code.
  */
-int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domi=
d,
-				       unsigned int first, unsigned int last)
+int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
+				unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl =3D {
 		.domid	=3D domid,
@@ -1356,29 +1353,9 @@ int msi_domain_alloc_irqs_range_locked(struct device *=
dev, unsigned int domid,
 		.nirqs	=3D last + 1 - first,
 	};
=20
+	guard(msi_descs_lock)(dev);
 	return msi_domain_alloc_locked(dev, &ctrl);
 }
-
-/**
- * msi_domain_alloc_irqs_range - Allocate interrupts from a MSI interrupt do=
main
- * @dev:	Pointer to device struct of the device for which the interrupts
- *		are allocated
- * @domid:	Id of the interrupt domain to operate on
- * @first:	First index to allocate (inclusive)
- * @last:	Last index to allocate (inclusive)
- *
- * Return: %0 on success or an error code.
- */
-int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
-				unsigned int first, unsigned int last)
-{
-	int ret;
-
-	msi_lock_descs(dev);
-	ret =3D msi_domain_alloc_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
-	return ret;
-}
 EXPORT_SYMBOL_GPL(msi_domain_alloc_irqs_range);
=20
 /**
@@ -1481,12 +1458,8 @@ struct msi_map msi_domain_alloc_irq_at(struct device *=
dev, unsigned int domid, u
 				       const struct irq_affinity_desc *affdesc,
 				       union msi_instance_cookie *icookie)
 {
-	struct msi_map map;
-
-	msi_lock_descs(dev);
-	map =3D __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
-	msi_unlock_descs(dev);
-	return map;
+	guard(msi_descs_lock)(dev);
+	return __msi_domain_alloc_irq_at(dev, domid, index, affdesc, icookie);
 }
=20
 /**
@@ -1523,13 +1496,11 @@ int msi_device_domain_alloc_wired(struct irq_domain *=
domain, unsigned int hwirq,
=20
 	icookie.value =3D ((u64)type << 32) | hwirq;
=20
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid) !=3D domain))
 		map.index =3D -EINVAL;
 	else
 		map =3D __msi_domain_alloc_irq_at(dev, domid, MSI_ANY_INDEX, NULL, &icooki=
e);
-	msi_unlock_descs(dev);
-
 	return map.index >=3D 0 ? map.virq : map.index;
 }
=20
@@ -1599,8 +1570,8 @@ static void msi_domain_free_locked(struct device *dev, =
struct msi_ctrl *ctrl)
  * @first:	First index to free (inclusive)
  * @last:	Last index to free (inclusive)
  */
-void msi_domain_free_irqs_range_locked(struct device *dev, unsigned int domi=
d,
-				       unsigned int first, unsigned int last)
+static void msi_domain_free_irqs_range_locked(struct device *dev, unsigned i=
nt domid,
+					      unsigned int first, unsigned int last)
 {
 	struct msi_ctrl ctrl =3D {
 		.domid	=3D domid,
@@ -1622,9 +1593,8 @@ void msi_domain_free_irqs_range_locked(struct device *d=
ev, unsigned int domid,
 void msi_domain_free_irqs_range(struct device *dev, unsigned int domid,
 				unsigned int first, unsigned int last)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_range_locked(dev, domid, first, last);
-	msi_unlock_descs(dev);
 }
 EXPORT_SYMBOL_GPL(msi_domain_free_irqs_all);
=20
@@ -1654,9 +1624,8 @@ void msi_domain_free_irqs_all_locked(struct device *dev=
, unsigned int domid)
  */
 void msi_domain_free_irqs_all(struct device *dev, unsigned int domid)
 {
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_domain_free_irqs_all_locked(dev, domid);
-	msi_unlock_descs(dev);
 }
=20
 /**
@@ -1675,12 +1644,11 @@ void msi_device_domain_free_wired(struct irq_domain *=
domain, unsigned int virq)
 	if (WARN_ON_ONCE(!dev || !desc || domain->bus_token !=3D DOMAIN_BUS_WIRED_T=
O_MSI))
 		return;
=20
-	msi_lock_descs(dev);
-	if (!WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) !=3D domai=
n)) {
-		msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
-						  desc->msi_index);
-	}
-	msi_unlock_descs(dev);
+	guard(msi_descs_lock)(dev);
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, MSI_DEFAULT_DOMAIN) !=3D domain=
))
+		return;
+	msi_domain_free_irqs_range_locked(dev, MSI_DEFAULT_DOMAIN, desc->msi_index,
+					  desc->msi_index);
 }
=20
 /**



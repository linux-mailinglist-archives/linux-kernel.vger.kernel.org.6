Return-Path: <linux-kernel+bounces-259324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B34939432
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 21:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E271C2170A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3526171075;
	Mon, 22 Jul 2024 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UcXj76Tc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oM12UGhG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33F16F903
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676446; cv=none; b=c0qId7lzc+NKwxtPXOzEZrwZtNKH+zOXs3wWXLBfxbl5Ole9LO+boaXWlRo5Teaoidmb1829MdDWk0+rT7GxU8FE/uW9OlVwCIq5dL0fGNdvB59+Wjp3llSYTApDckGr516Wea+XqrK2p74P8d/rx2CTgrEWzgTWXidT9HruOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676446; c=relaxed/simple;
	bh=FN8RyAVmP1Gbi7eGzXIv85oYrEx3jCa8rJtJ0fLVP68=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=FVaStLlIqL7tgFIO5zI5Xz6TgFrPyp0DZANH8/in0wOvLtW+bnuxBTKhCMRdebzrHvbBBQpnAAFzIZ68utdeaVw9N1CD7qbk7z1LcPO8SVV/s6NwwVU3FJMU4z6XyVLQSf6+VsERmPd41JIwv6JckiKwK97SY9xlsHr5QmchIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UcXj76Tc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oM12UGhG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721676440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=unj4y72aXCakvqQc4mqWbp9vM/jE3du+PsyyzacaT48=;
	b=UcXj76Tcxqa960sf5RtF6XrCwXt2zMB5zbpi4NpQkHScBCTMFsoSmxYfiMWrL1swrTQJh2
	jMa3pFw6SzLItwuNOIFPBS91Q3RlnWlnGMtflSoKWBsHs9lbdXUw6xrEXRK3Pnm/AuNBA0
	nVBDLpRzCsIEONsLfLqLmOLdvgnrHzc/0B7gbUNGJmbg9g2P+IPDjVz15F5RMyi66hnt7a
	/Z83ex5A7teEZ9jF33dZ9SzpL6gHwRGU3XxbGGccPT3HxZoSNY339lF34RMeNtergp/Jyp
	SoeveOiQip3BHsnp4xW3Rb4W6GVNZotDa9qmCaxsVCItCG/V8Iek6Ca2ISREaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721676440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=unj4y72aXCakvqQc4mqWbp9vM/jE3du+PsyyzacaT48=;
	b=oM12UGhGs3JShgMtFrfhwwbPuRVLyMI1o9ImywA++PWmv25QzyLVLULHorPCo6p8EhvdmK
	vZXdkkTc+wR/heCg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/msi for v6.11-rc1
References: <172167641737.62829.15719424739961406637.tglx@xen13>
Message-ID: <172167641899.62829.14888511482116338560.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jul 2024 21:27:20 +0200 (CEST)

Linus,

please pull the latest irq/msi branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-msi-2024-07-=
22

up to:  c9b4f313f6b8: irqchip/gic-v3-its: Correctly fish out the DID for plat=
form MSI

Switch ARM/ARM64 over to the modern per device MSI domains:

  This simplifies the handling of platform MSI and wire to MSI controllers
  and removes about 500 lines of legacy code.

  Aside of that it paves the way for ARM/ARM64 to utilize the dynamic
  allocation of PCI/MSI interrupts and to support the upcoming non
  standard IMS (Interrupt Message Store) mechanism on PCIe devices

This has been split out from the original pull request and the two fixlets
from Marc which cure the issues observed by Johan have been added on top.

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (2):
      irqchip/imx-mu-msi: Fix codingstyle in imx_mu_msi_domains_init()
      irqdomain: Fix formatting irq_find_matching_fwspec() kerneldoc comment

Marc Zyngier (2):
      irqchip/gic-v3-its: Correctly honor the RID remapping
      irqchip/gic-v3-its: Correctly fish out the DID for platform MSI

Shivamurthy Shastri (1):
      PCI/MSI: Provide MSI_FLAG_PCI_MSI_MASK_PARENT

Thomas Gleixner (20):
      irqchip: Provide irq-msi-lib
      irqchip/gic-v3-its: Provide MSI parent infrastructure
      irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
      irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
      irqchip/irq-msi-lib: Prepare for DEVICE MSI to replace platform MSI
      irqchip/mbigen: Prepare for real per device MSI
      irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI
      irqchip/gic-v3-its: Switch platform MSI to MSI parent
      irqchip/mbigen: Remove platform_msi_create_device_domain() fallback
      genirq/msi: Remove platform_msi_create_device_domain()
      irqchip/gic_v3_mbi: Switch over to parent domain
      irqchip/gic-v2m: Switch to device MSI
      irqchip/imx-mu-msi: Switch to MSI parent
      irqchip/irq-mvebu-icu: Prepare for real per device MSI
      irqchip/mvebu-gicp: Switch to MSI parent
      irqchip/mvebu-odmi: Switch to parent MSI
      irqchip/irq-mvebu-sei: Switch to MSI parent
      irqchip/irq-mvebu-icu: Remove platform MSI leftovers
      genirq/msi: Remove platform MSI leftovers
      genirq/msi: Move msi_device_data to core


 drivers/base/platform-msi.c                   | 350 +-----------------------=
--
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   4 +-
 drivers/irqchip/irq-gic-common.h              |   3 +
 drivers/irqchip/irq-gic-v2m.c                 |  81 ++----
 drivers/irqchip/irq-gic-v3-its-msi-parent.c   | 210 ++++++++++++++++
 drivers/irqchip/irq-gic-v3-its-pci-msi.c      | 202 ---------------
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 163 ------------
 drivers/irqchip/irq-gic-v3-its.c              |   5 +
 drivers/irqchip/irq-gic-v3-mbi.c              | 130 ++++------
 drivers/irqchip/irq-imx-mu-msi.c              |  54 ++--
 drivers/irqchip/irq-mbigen.c                  |  96 +++----
 drivers/irqchip/irq-msi-lib.c                 | 140 +++++++++++
 drivers/irqchip/irq-msi-lib.h                 |  27 ++
 drivers/irqchip/irq-mvebu-gicp.c              |  44 ++--
 drivers/irqchip/irq-mvebu-icu.c               | 275 +++++++++-----------
 drivers/irqchip/irq-mvebu-odmi.c              |  37 ++-
 drivers/irqchip/irq-mvebu-sei.c               |  52 ++--
 drivers/pci/msi/irqdomain.c                   |  20 ++
 include/linux/msi.h                           |  52 +---
 kernel/irq/irqdomain.c                        |   3 +-
 kernel/irq/msi.c                              |  95 ++-----
 22 files changed, 747 insertions(+), 1304 deletions(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-msi-parent.c
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-pci-msi.c
 delete mode 100644 drivers/irqchip/irq-gic-v3-its-platform-msi.c
 create mode 100644 drivers/irqchip/irq-msi-lib.c
 create mode 100644 drivers/irqchip/irq-msi-lib.h

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 11f5fdf65b9e..0e60dd650b5e 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -4,346 +4,12 @@
  *
  * Copyright (C) 2015 ARM Limited, All Rights Reserved.
  * Author: Marc Zyngier <marc.zyngier@arm.com>
+ * Copyright (C) 2022 Linutronix GmbH
  */
=20
 #include <linux/device.h>
-#include <linux/idr.h>
-#include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
-#include <linux/slab.h>
-
-/* Begin of removal area. Once everything is converted over. Cleanup the inc=
ludes too! */
-
-#define DEV_ID_SHIFT	21
-#define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
-
-/*
- * Internal data structure containing a (made up, but unique) devid
- * and the callback to write the MSI message.
- */
-struct platform_msi_priv_data {
-	struct device			*dev;
-	void				*host_data;
-	msi_alloc_info_t		arg;
-	irq_write_msi_msg_t		write_msg;
-	int				devid;
-};
-
-/* The devid allocator */
-static DEFINE_IDA(platform_msi_devid_ida);
-
-#ifdef GENERIC_MSI_DOMAIN_OPS
-/*
- * Convert an msi_desc to a globaly unique identifier (per-device
- * devid + msi_desc position in the msi_list).
- */
-static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
-{
-	u32 devid =3D desc->dev->msi.data->platform_data->devid;
-
-	return (devid << (32 - DEV_ID_SHIFT)) | desc->msi_index;
-}
-
-static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
-{
-	arg->desc =3D desc;
-	arg->hwirq =3D platform_msi_calc_hwirq(desc);
-}
-
-static int platform_msi_init(struct irq_domain *domain,
-			     struct msi_domain_info *info,
-			     unsigned int virq, irq_hw_number_t hwirq,
-			     msi_alloc_info_t *arg)
-{
-	return irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					     info->chip, info->chip_data);
-}
-
-static void platform_msi_set_proxy_dev(msi_alloc_info_t *arg)
-{
-	arg->flags |=3D MSI_ALLOC_FLAGS_PROXY_DEVICE;
-}
-#else
-#define platform_msi_set_desc		NULL
-#define platform_msi_init		NULL
-#define platform_msi_set_proxy_dev(x)	do {} while(0)
-#endif
-
-static void platform_msi_update_dom_ops(struct msi_domain_info *info)
-{
-	struct msi_domain_ops *ops =3D info->ops;
-
-	BUG_ON(!ops);
-
-	if (ops->msi_init =3D=3D NULL)
-		ops->msi_init =3D platform_msi_init;
-	if (ops->set_desc =3D=3D NULL)
-		ops->set_desc =3D platform_msi_set_desc;
-}
-
-static void platform_msi_write_msg(struct irq_data *data, struct msi_msg *ms=
g)
-{
-	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
-
-	desc->dev->msi.data->platform_data->write_msg(desc, msg);
-}
-
-static void platform_msi_update_chip_ops(struct msi_domain_info *info)
-{
-	struct irq_chip *chip =3D info->chip;
-
-	BUG_ON(!chip);
-	if (!chip->irq_mask)
-		chip->irq_mask =3D irq_chip_mask_parent;
-	if (!chip->irq_unmask)
-		chip->irq_unmask =3D irq_chip_unmask_parent;
-	if (!chip->irq_eoi)
-		chip->irq_eoi =3D irq_chip_eoi_parent;
-	if (!chip->irq_set_affinity)
-		chip->irq_set_affinity =3D msi_domain_set_affinity;
-	if (!chip->irq_write_msi_msg)
-		chip->irq_write_msi_msg =3D platform_msi_write_msg;
-	if (WARN_ON((info->flags & MSI_FLAG_LEVEL_CAPABLE) &&
-		    !(chip->flags & IRQCHIP_SUPPORTS_LEVEL_MSI)))
-		info->flags &=3D ~MSI_FLAG_LEVEL_CAPABLE;
-}
-
-/**
- * platform_msi_create_irq_domain - Create a platform MSI interrupt domain
- * @fwnode:		Optional fwnode of the interrupt controller
- * @info:	MSI domain info
- * @parent:	Parent irq domain
- *
- * Updates the domain and chip ops and creates a platform MSI
- * interrupt domain.
- *
- * Returns:
- * A domain pointer or NULL in case of failure.
- */
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwno=
de,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent)
-{
-	struct irq_domain *domain;
-
-	if (info->flags & MSI_FLAG_USE_DEF_DOM_OPS)
-		platform_msi_update_dom_ops(info);
-	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
-		platform_msi_update_chip_ops(info);
-	info->flags |=3D MSI_FLAG_DEV_SYSFS | MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS |
-		       MSI_FLAG_FREE_MSI_DESCS;
-
-	domain =3D msi_create_irq_domain(fwnode, info, parent);
-	if (domain)
-		irq_domain_update_bus_token(domain, DOMAIN_BUS_PLATFORM_MSI);
-
-	return domain;
-}
-EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
-
-static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nve=
c,
-					irq_write_msi_msg_t write_msi_msg)
-{
-	struct platform_msi_priv_data *datap;
-	int err;
-
-	/*
-	 * Limit the number of interrupts to 2048 per device. Should we
-	 * need to bump this up, DEV_ID_SHIFT should be adjusted
-	 * accordingly (which would impact the max number of MSI
-	 * capable devices).
-	 */
-	if (!dev->msi.domain || !write_msi_msg || !nvec || nvec > MAX_DEV_MSIS)
-		return -EINVAL;
-
-	if (dev->msi.domain->bus_token !=3D DOMAIN_BUS_PLATFORM_MSI) {
-		dev_err(dev, "Incompatible msi_domain, giving up\n");
-		return -EINVAL;
-	}
-
-	err =3D msi_setup_device_data(dev);
-	if (err)
-		return err;
-
-	/* Already initialized? */
-	if (dev->msi.data->platform_data)
-		return -EBUSY;
-
-	datap =3D kzalloc(sizeof(*datap), GFP_KERNEL);
-	if (!datap)
-		return -ENOMEM;
-
-	datap->devid =3D ida_alloc_max(&platform_msi_devid_ida,
-				     (1 << DEV_ID_SHIFT) - 1, GFP_KERNEL);
-	if (datap->devid < 0) {
-		err =3D datap->devid;
-		kfree(datap);
-		return err;
-	}
-
-	datap->write_msg =3D write_msi_msg;
-	datap->dev =3D dev;
-	dev->msi.data->platform_data =3D datap;
-	return 0;
-}
-
-static void platform_msi_free_priv_data(struct device *dev)
-{
-	struct platform_msi_priv_data *data =3D dev->msi.data->platform_data;
-
-	dev->msi.data->platform_data =3D NULL;
-	ida_free(&platform_msi_devid_ida, data->devid);
-	kfree(data);
-}
-
-/**
- * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
- * @dev:		The device for which to allocate interrupts
- * @nvec:		The number of interrupts to allocate
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- *
- * Returns:
- * Zero for success, or an error code in case of failure
- */
-static int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int n=
vec,
-					  irq_write_msi_msg_t write_msi_msg)
-{
-	int err;
-
-	err =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (err)
-		return err;
-
-	err =3D msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
-	if (err)
-		platform_msi_free_priv_data(dev);
-
-	return err;
-}
-
-/**
- * platform_msi_get_host_data - Query the private data associated with
- *                              a platform-msi domain
- * @domain:	The platform-msi domain
- *
- * Return: The private data provided when calling
- * platform_msi_create_device_domain().
- */
-void *platform_msi_get_host_data(struct irq_domain *domain)
-{
-	struct platform_msi_priv_data *data =3D domain->host_data;
-
-	return data->host_data;
-}
-
-static struct lock_class_key platform_device_msi_lock_class;
-
-/**
- * __platform_msi_create_device_domain - Create a platform-msi device domain
- *
- * @dev:		The device generating the MSIs
- * @nvec:		The number of MSIs that need to be allocated
- * @is_tree:		flag to indicate tree hierarchy
- * @write_msi_msg:	Callback to write an interrupt message for @dev
- * @ops:		The hierarchy domain operations to use
- * @host_data:		Private data associated to this domain
- *
- * Return: An irqdomain for @nvec interrupts on success, NULL in case of err=
or.
- *
- * This is for interrupt domains which stack on a platform-msi domain
- * created by platform_msi_create_irq_domain(). @dev->msi.domain points to
- * that platform-msi domain which is the parent for the new domain.
- */
-struct irq_domain *
-__platform_msi_create_device_domain(struct device *dev,
-				    unsigned int nvec,
-				    bool is_tree,
-				    irq_write_msi_msg_t write_msi_msg,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
-{
-	struct platform_msi_priv_data *data;
-	struct irq_domain *domain;
-	int err;
-
-	err =3D platform_msi_alloc_priv_data(dev, nvec, write_msi_msg);
-	if (err)
-		return NULL;
-
-	/*
-	 * Use a separate lock class for the MSI descriptor mutex on
-	 * platform MSI device domains because the descriptor mutex nests
-	 * into the domain mutex. See alloc/free below.
-	 */
-	lockdep_set_class(&dev->msi.data->mutex, &platform_device_msi_lock_class);
-
-	data =3D dev->msi.data->platform_data;
-	data->host_data =3D host_data;
-	domain =3D irq_domain_create_hierarchy(dev->msi.domain, 0,
-					     is_tree ? 0 : nvec,
-					     dev->fwnode, ops, data);
-	if (!domain)
-		goto free_priv;
-
-	platform_msi_set_proxy_dev(&data->arg);
-	err =3D msi_domain_prepare_irqs(domain->parent, dev, nvec, &data->arg);
-	if (err)
-		goto free_domain;
-
-	return domain;
-
-free_domain:
-	irq_domain_remove(domain);
-free_priv:
-	platform_msi_free_priv_data(dev);
-	return NULL;
-}
-
-/**
- * platform_msi_device_domain_free - Free interrupts associated with a platf=
orm-msi
- *				     device domain
- *
- * @domain:	The platform-msi device domain
- * @virq:	The base irq from which to perform the free operation
- * @nr_irqs:	How many interrupts to free from @virq
- */
-void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nr_irqs)
-{
-	struct platform_msi_priv_data *data =3D domain->host_data;
-
-	msi_lock_descs(data->dev);
-	msi_domain_depopulate_descs(data->dev, virq, nr_irqs);
-	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
-	msi_unlock_descs(data->dev);
-}
-
-/**
- * platform_msi_device_domain_alloc - Allocate interrupts associated with
- *				      a platform-msi device domain
- *
- * @domain:	The platform-msi device domain
- * @virq:	The base irq from which to perform the allocate operation
- * @nr_irqs:	How many interrupts to allocate from @virq
- *
- * Return 0 on success, or an error code on failure. Must be called
- * with irq_domain_mutex held (which can only be done as part of a
- * top-level interrupt allocation).
- */
-int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nr_irqs)
-{
-	struct platform_msi_priv_data *data =3D domain->host_data;
-	struct device *dev =3D data->dev;
-
-	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->=
arg);
-}
-
-/* End of removal area */
-
-/* Real per device domain interfaces */
=20
 /*
  * This indirection can go when platform_device_msi_init_and_alloc_irqs()
@@ -357,7 +23,7 @@ static void platform_msi_write_msi_msg(struct irq_data *d,=
 struct msi_msg *msg)
 	cb(irq_data_get_msi_desc(d), msg);
 }
=20
-static void platform_msi_set_desc_byindex(msi_alloc_info_t *arg, struct msi_=
desc *desc)
+static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *de=
sc)
 {
 	arg->desc =3D desc;
 	arg->hwirq =3D desc->msi_index;
@@ -373,7 +39,7 @@ static const struct msi_domain_template platform_msi_templ=
ate =3D {
 	},
=20
 	.ops =3D {
-		.set_desc		=3D platform_msi_set_desc_byindex,
+		.set_desc		=3D platform_msi_set_desc,
 	},
=20
 	.info =3D {
@@ -408,10 +74,6 @@ int platform_device_msi_init_and_alloc_irqs(struct device=
 *dev, unsigned int nve
 	if (!domain || !write_msi_msg)
 		return -EINVAL;
=20
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
-
 	/*
 	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
 	 * The underlying domain creation mechanism will assign that
@@ -432,12 +94,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs=
);
  */
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
-	struct irq_domain *domain =3D dev->msi.domain;
-
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
-
-	/* Migration support. Will go away once everything is converted */
-	if (!irq_domain_is_msi_parent(domain))
-		platform_msi_free_priv_data(dev);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 14464716bacb..4def6dc76fa6 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -26,6 +26,7 @@ config ARM_GIC_V2M
 	bool
 	depends on PCI
 	select ARM_GIC
+	select IRQ_MSI_LIB
 	select PCI_MSI
=20
 config GIC_NON_BANKED
@@ -41,6 +42,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	default ARM_GIC_V3
=20
 config ARM_GIC_V3_ITS_PCI
@@ -74,6 +76,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
=20
+config IRQ_MSI_LIB
+	bool
+
 config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
@@ -366,6 +371,7 @@ config MSCC_OCELOT_IRQ
 	select GENERIC_IRQ_CHIP
=20
 config MVEBU_GICP
+	select IRQ_MSI_LIB
 	bool
=20
 config MVEBU_ICU
@@ -373,6 +379,7 @@ config MVEBU_ICU
=20
 config MVEBU_ODMI
 	bool
+	select IRQ_MSI_LIB
 	select GENERIC_MSI_IRQ
=20
 config MVEBU_PIC
@@ -487,6 +494,7 @@ config IMX_MU_MSI
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	help
 	  Provide a driver for the i.MX Messaging Unit block used as a
 	  CPU-to-CPU MSI controller. This requires a specially crafted DT
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d99aaa8..afc44f4709a6 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -29,10 +29,10 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+=3D spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+=3D irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+=3D irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+=3D irq-gic-realview.o
+obj-$(CONFIG_IRQ_MSI_LIB)		+=3D irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+=3D irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+=3D irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v3-its-platform-=
msi.o irq-gic-v4.o
-obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+=3D irq-gic-v3-its-pci-msi.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+=3D irq-gic-v3-its.o irq-gic-v4.o irq-gic-v3-=
its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+=3D irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+=3D irq-partition-percpu.o
 obj-$(CONFIG_HISILICON_IRQ_MBIGEN)	+=3D irq-mbigen.o
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-commo=
n.h
index f407cce9ecaa..eb4a220dd6ad 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -8,6 +8,7 @@
=20
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/irqchip/arm-gic-common.h>
=20
 struct gic_quirk {
@@ -29,6 +30,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *qu=
irks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
=20
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f2ff4387870d..51af63c046ed 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,8 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
=20
+#include "irq-msi-lib.h"
+
 /*
 * MSI_TYPER:
 *     [31:26] Reserved
@@ -72,31 +74,6 @@ struct v2m_data {
 	u32 flags;		/* v2m flags for specific implementation */
 };
=20
-static void gicv2m_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void gicv2m_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip gicv2m_msi_irq_chip =3D {
-	.name			=3D "MSI",
-	.irq_mask		=3D gicv2m_mask_msi_irq,
-	.irq_unmask		=3D gicv2m_unmask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-};
-
-static struct msi_domain_info gicv2m_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	=3D &gicv2m_msi_irq_chip,
-};
-
 static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
 {
 	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
@@ -230,6 +207,7 @@ static void gicv2m_irq_domain_free(struct irq_domain *dom=
ain,
 }
=20
 static const struct irq_domain_ops gicv2m_domain_ops =3D {
+	.select			=3D msi_lib_irq_domain_select,
 	.alloc			=3D gicv2m_irq_domain_alloc,
 	.free			=3D gicv2m_irq_domain_free,
 };
@@ -250,19 +228,6 @@ static bool is_msi_spi_valid(u32 base, u32 num)
 	return true;
 }
=20
-static struct irq_chip gicv2m_pmsi_irq_chip =3D {
-	.name			=3D "pMSI",
-};
-
-static struct msi_domain_ops gicv2m_pmsi_ops =3D {
-};
-
-static struct msi_domain_info gicv2m_pmsi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &gicv2m_pmsi_ops,
-	.chip	=3D &gicv2m_pmsi_irq_chip,
-};
-
 static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
@@ -278,9 +243,27 @@ static void __init gicv2m_teardown(void)
 	}
 }
=20
+
+#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |		\
+				    MSI_FLAG_USE_DEF_CHIP_OPS |		\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define GICV2M_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX      |	\
+				    MSI_FLAG_MULTI_PCI_MSI)
+
+static struct msi_parent_ops gicv2m_msi_parent_ops =3D {
+	.supported_flags	=3D GICV2M_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D GICV2M_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			=3D "GICv2m-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct irq_domain *inner_domain;
 	struct v2m_data *v2m;
=20
 	v2m =3D list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
@@ -295,22 +278,8 @@ static __init int gicv2m_allocate_domains(struct irq_dom=
ain *parent)
 	}
=20
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	pci_domain =3D pci_msi_create_irq_domain(v2m->fwnode,
-					       &gicv2m_msi_domain_info,
-					       inner_domain);
-	plat_domain =3D platform_msi_create_irq_domain(v2m->fwnode,
-						     &gicv2m_pmsi_domain_info,
-						     inner_domain);
-	if (!pci_domain || !plat_domain) {
-		pr_err("Failed to create MSI domains\n");
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops =3D &gicv2m_msi_parent_ops;
 	return 0;
 }
=20
@@ -511,7 +480,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		pr_info("applying Amazon Graviton quirk\n");
 		res.end =3D res.start + SZ_8K - 1;
 		flags |=3D GICV2M_GRAVITON_ADDRESS_ONLY;
-		gicv2m_msi_domain_info.flags &=3D ~MSI_FLAG_MULTI_PCI_MSI;
+		gicv2m_msi_parent_ops.supported_flags &=3D ~MSI_FLAG_MULTI_PCI_MSI;
 	}
=20
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/ir=
q-gic-v3-its-msi-parent.c
new file mode 100644
index 000000000000..e150365fbe89
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
+// Author: Marc Zyngier <marc.zyngier@arm.com>
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/acpi_iort.h>
+#include <linux/pci.h>
+
+#include "irq-gic-common.h"
+#include "irq-msi-lib.h"
+
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+#ifdef CONFIG_PCI_MSI
+static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
+{
+	int msi, msix, *count =3D data;
+
+	msi =3D max(pci_msi_vec_count(pdev), 0);
+	msix =3D max(pci_msix_vec_count(pdev), 0);
+	*count +=3D max(msi, msix);
+
+	return 0;
+}
+
+static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct pci_dev **alias_dev =3D data;
+
+	*alias_dev =3D pdev;
+
+	return 0;
+}
+
+static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *info)
+{
+	struct pci_dev *pdev, *alias_dev;
+	struct msi_domain_info *msi_info;
+	int alias_count =3D 0, minnvec =3D 1;
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev =3D to_pci_dev(dev);
+	/*
+	 * If pdev is downstream of any aliasing bridges, take an upper
+	 * bound of how many other vectors could map to the same DevID.
+	 * Also tell the ITS that the signalling will come from a proxy
+	 * device, and that special allocation rules apply.
+	 */
+	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
+	if (alias_dev !=3D pdev) {
+		if (alias_dev->subordinate)
+			pci_walk_bus(alias_dev->subordinate,
+				     its_pci_msi_vec_count, &alias_count);
+		info->flags |=3D MSI_ALLOC_FLAGS_PROXY_DEVICE;
+	}
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul =3D pci_msi_domain_get_msi_rid(domain->parent, pdev);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the
+	 * MSI[-X] domain, but vector allocation happens one by one. This
+	 * needs some thought when MSI comes into play as the size of MSI
+	 * might be unknown at domain creation time and therefore set to
+	 * MSI_MAX_INDEX.
+	 */
+	msi_info =3D msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec =3D msi_info->hwsize;
+
+	/*
+	 * Always allocate a power of 2, and special case device 0 for
+	 * broken systems where the DevID is not wired (and all devices
+	 * appear as DevID 0). For that reason, we generously allocate a
+	 * minimum of 32 MSIs for DevID 0. If you want more because all
+	 * your devices are aliasing to DevID 0, consider fixing your HW.
+	 */
+	nvec =3D max(nvec, alias_count);
+	if (!info->scratchpad[0].ul)
+		minnvec =3D 32;
+	nvec =3D max_t(int, minnvec, roundup_pow_of_two(nvec));
+
+	msi_info =3D msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
+}
+#else /* CONFIG_PCI_MSI */
+#define its_pci_msi_prepare	NULL
+#endif /* !CONFIG_PCI_MSI */
+
+static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
+				  u32 *dev_id)
+{
+	int ret, index =3D 0;
+
+	/* Suck the DeviceID out of the msi-parent property */
+	do {
+		struct of_phandle_args args;
+
+		ret =3D of_parse_phandle_with_args(dev->of_node,
+						 "msi-parent", "#msi-cells",
+						 index, &args);
+		if (args.np =3D=3D irq_domain_get_of_node(domain)) {
+			if (WARN_ON(args.args_count !=3D 1))
+				return -EINVAL;
+			*dev_id =3D args.args[0];
+			break;
+		}
+		index++;
+	} while (!ret);
+
+	return ret;
+}
+
+int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+{
+	return -1;
+}
+
+static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
+			    int nvec, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+	u32 dev_id;
+	int ret;
+
+	if (dev->of_node)
+		ret =3D of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
+	else
+		ret =3D iort_pmsi_get_dev_id(dev, &dev_id);
+	if (ret)
+		return ret;
+
+	/* ITS specific DeviceID, as the core ITS ignores dev. */
+	info->scratchpad[0].ul =3D dev_id;
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the device
+	 * domain, but vector allocation happens one by one.
+	 */
+	msi_info =3D msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec =3D msi_info->hwsize;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec =3D max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info =3D msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent,
+					  dev, nvec, info);
+}
+
+static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		/*
+		 * FIXME: This probably should be done after a (not yet
+		 * existing) post domain creation callback once to make
+		 * support for dynamic post-enable MSI-X allocations
+		 * work without having to reevaluate the domain size
+		 * over and over. It is known already at allocation
+		 * time via info->hwsize.
+		 *
+		 * That should work perfectly fine for MSI/MSI-X but needs
+		 * some thoughts for purely software managed MSI domains
+		 * where the index space is only limited artificially via
+		 * %MSI_MAX_INDEX.
+		 */
+		info->ops->msi_prepare =3D its_pci_msi_prepare;
+		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		/*
+		 * FIXME: See the above PCI prepare comment. The domain
+		 * size is also known at domain creation time.
+		 */
+		info->ops->msi_prepare =3D its_pmsi_prepare;
+		break;
+	default:
+		/* Confused. How did the lib return true? */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	return true;
+}
+
+const struct msi_parent_ops gic_v3_its_msi_parent_ops =3D {
+	.supported_flags	=3D ITS_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D ITS_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			=3D "ITS-",
+	.init_dev_msi_info	=3D its_init_dev_msi_info,
+};
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-g=
ic-v3-its-pci-msi.c
deleted file mode 100644
index 93f77a8196da..000000000000
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ /dev/null
@@ -1,202 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/pci.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-#include <linux/of_pci.h>
-
-static void its_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void its_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip its_msi_irq_chip =3D {
-	.name			=3D "ITS-MSI",
-	.irq_unmask		=3D its_unmask_msi_irq,
-	.irq_mask		=3D its_mask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-};
-
-static int its_pci_msi_vec_count(struct pci_dev *pdev, void *data)
-{
-	int msi, msix, *count =3D data;
-
-	msi =3D max(pci_msi_vec_count(pdev), 0);
-	msix =3D max(pci_msix_vec_count(pdev), 0);
-	*count +=3D max(msi, msix);
-
-	return 0;
-}
-
-static int its_get_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
-{
-	struct pci_dev **alias_dev =3D data;
-
-	*alias_dev =3D pdev;
-
-	return 0;
-}
-
-static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
-			       int nvec, msi_alloc_info_t *info)
-{
-	struct pci_dev *pdev, *alias_dev;
-	struct msi_domain_info *msi_info;
-	int alias_count =3D 0, minnvec =3D 1;
-
-	if (!dev_is_pci(dev))
-		return -EINVAL;
-
-	msi_info =3D msi_get_domain_info(domain->parent);
-
-	pdev =3D to_pci_dev(dev);
-	/*
-	 * If pdev is downstream of any aliasing bridges, take an upper
-	 * bound of how many other vectors could map to the same DevID.
-	 * Also tell the ITS that the signalling will come from a proxy
-	 * device, and that special allocation rules apply.
-	 */
-	pci_for_each_dma_alias(pdev, its_get_pci_alias, &alias_dev);
-	if (alias_dev !=3D pdev) {
-		if (alias_dev->subordinate)
-			pci_walk_bus(alias_dev->subordinate,
-				     its_pci_msi_vec_count, &alias_count);
-		info->flags |=3D MSI_ALLOC_FLAGS_PROXY_DEVICE;
-	}
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul =3D pci_msi_domain_get_msi_rid(domain, pdev);
-
-	/*
-	 * Always allocate a power of 2, and special case device 0 for
-	 * broken systems where the DevID is not wired (and all devices
-	 * appear as DevID 0). For that reason, we generously allocate a
-	 * minimum of 32 MSIs for DevID 0. If you want more because all
-	 * your devices are aliasing to DevID 0, consider fixing your HW.
-	 */
-	nvec =3D max(nvec, alias_count);
-	if (!info->scratchpad[0].ul)
-		minnvec =3D 32;
-	nvec =3D max_t(int, minnvec, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pci_msi_ops =3D {
-	.msi_prepare	=3D its_pci_msi_prepare,
-};
-
-static struct msi_domain_info its_pci_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.ops	=3D &its_pci_msi_ops,
-	.chip	=3D &its_msi_irq_chip,
-};
-
-static struct of_device_id its_device_id[] =3D {
-	{	.compatible	=3D "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
-				       const char *name)
-{
-	struct irq_domain *parent;
-
-	parent =3D irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: Unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
-				       parent)) {
-		pr_err("%s: Unable to create PCI domain\n", name);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static int __init its_pci_of_msi_init(void)
-{
-	struct device_node *np;
-
-	for (np =3D of_find_matching_node(NULL, its_device_id); np;
-	     np =3D of_find_matching_node(np, its_device_id)) {
-		if (!of_device_is_available(np))
-			continue;
-		if (!of_property_read_bool(np, "msi-controller"))
-			continue;
-
-		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
-			continue;
-
-		pr_info("PCI/MSI: %pOF domain created\n", np);
-	}
-
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-
-static int __init
-its_pci_msi_parse_madt(union acpi_subtable_headers *header,
-		       const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *dom_handle;
-	const char *node_name;
-	int err =3D -ENXIO;
-
-	its_entry =3D (struct acpi_madt_generic_translator *)header;
-	node_name =3D kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	dom_handle =3D iort_find_domain_token(its_entry->translation_id);
-	if (!dom_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err =3D its_pci_msi_init_one(dom_handle, node_name);
-	if (!err)
-		pr_info("PCI/MSI: %s domain created\n", node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static int __init its_pci_acpi_msi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pci_msi_parse_madt, 0);
-	return 0;
-}
-#else
-static int __init its_pci_acpi_msi_init(void)
-{
-	return 0;
-}
-#endif
-
-static int __init its_pci_msi_init(void)
-{
-	its_pci_of_msi_init();
-	its_pci_acpi_msi_init();
-
-	return 0;
-}
-early_initcall(its_pci_msi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/=
irq-gic-v3-its-platform-msi.c
deleted file mode 100644
index daa6d5053bc3..000000000000
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ /dev/null
@@ -1,163 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2013-2015 ARM Limited, All Rights Reserved.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/acpi_iort.h>
-#include <linux/device.h>
-#include <linux/msi.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
-
-static struct irq_chip its_pmsi_irq_chip =3D {
-	.name			=3D "ITS-pMSI",
-};
-
-static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
-				  u32 *dev_id)
-{
-	int ret, index =3D 0;
-
-	/* Suck the DeviceID out of the msi-parent property */
-	do {
-		struct of_phandle_args args;
-
-		ret =3D of_parse_phandle_with_args(dev->of_node,
-						 "msi-parent", "#msi-cells",
-						 index, &args);
-		if (args.np =3D=3D irq_domain_get_of_node(domain)) {
-			if (WARN_ON(args.args_count !=3D 1))
-				return -EINVAL;
-			*dev_id =3D args.args[0];
-			break;
-		}
-		index++;
-	} while (!ret);
-
-	return ret;
-}
-
-int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-{
-	return -1;
-}
-
-static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *info)
-{
-	struct msi_domain_info *msi_info;
-	u32 dev_id;
-	int ret;
-
-	msi_info =3D msi_get_domain_info(domain->parent);
-
-	if (dev->of_node)
-		ret =3D of_pmsi_get_dev_id(domain, dev, &dev_id);
-	else
-		ret =3D iort_pmsi_get_dev_id(dev, &dev_id);
-	if (ret)
-		return ret;
-
-	/* ITS specific DeviceID, as the core ITS ignores dev. */
-	info->scratchpad[0].ul =3D dev_id;
-
-	/* Allocate at least 32 MSIs, and always as a power of 2 */
-	nvec =3D max_t(int, 32, roundup_pow_of_two(nvec));
-	return msi_info->ops->msi_prepare(domain->parent,
-					  dev, nvec, info);
-}
-
-static struct msi_domain_ops its_pmsi_ops =3D {
-	.msi_prepare	=3D its_pmsi_prepare,
-};
-
-static struct msi_domain_info its_pmsi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &its_pmsi_ops,
-	.chip	=3D &its_pmsi_irq_chip,
-};
-
-static const struct of_device_id its_device_id[] =3D {
-	{	.compatible	=3D "arm,gic-v3-its",	},
-	{},
-};
-
-static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
-				const char *name)
-{
-	struct irq_domain *parent;
-
-	parent =3D irq_find_matching_fwnode(fwnode, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: unable to locate ITS domain\n", name);
-		return -ENXIO;
-	}
-
-	if (!platform_msi_create_irq_domain(fwnode, &its_pmsi_domain_info,
-					    parent)) {
-		pr_err("%s: unable to create platform domain\n", name);
-		return -ENXIO;
-	}
-
-	pr_info("Platform MSI: %s domain created\n", name);
-	return 0;
-}
-
-#ifdef CONFIG_ACPI
-static int __init
-its_pmsi_parse_madt(union acpi_subtable_headers *header,
-			const unsigned long end)
-{
-	struct acpi_madt_generic_translator *its_entry;
-	struct fwnode_handle *domain_handle;
-	const char *node_name;
-	int err =3D -ENXIO;
-
-	its_entry =3D (struct acpi_madt_generic_translator *)header;
-	node_name =3D kasprintf(GFP_KERNEL, "ITS@0x%lx",
-			      (long)its_entry->base_address);
-	domain_handle =3D iort_find_domain_token(its_entry->translation_id);
-	if (!domain_handle) {
-		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
-		goto out;
-	}
-
-	err =3D its_pmsi_init_one(domain_handle, node_name);
-
-out:
-	kfree(node_name);
-	return err;
-}
-
-static void __init its_pmsi_acpi_init(void)
-{
-	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
-			      its_pmsi_parse_madt, 0);
-}
-#else
-static inline void its_pmsi_acpi_init(void) { }
-#endif
-
-static void __init its_pmsi_of_init(void)
-{
-	struct device_node *np;
-
-	for (np =3D of_find_matching_node(NULL, its_device_id); np;
-	     np =3D of_find_matching_node(np, its_device_id)) {
-		if (!of_device_is_available(np))
-			continue;
-		if (!of_property_read_bool(np, "msi-controller"))
-			continue;
-
-		its_pmsi_init_one(of_node_to_fwnode(np), np->full_name);
-	}
-}
-
-static int __init its_pmsi_init(void)
-{
-	its_pmsi_of_init();
-	its_pmsi_acpi_init();
-	return 0;
-}
-early_initcall(its_pmsi_init);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-it=
s.c
index 3c755d5dad6e..d770d6aedb29 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -38,6 +38,7 @@
 #include <asm/exception.h>
=20
 #include "irq-gic-common.h"
+#include "irq-msi-lib.h"
=20
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
@@ -3688,6 +3689,7 @@ static void its_irq_domain_free(struct irq_domain *doma=
in, unsigned int virq,
 }
=20
 static const struct irq_domain_ops its_domain_ops =3D {
+	.select			=3D msi_lib_irq_domain_select,
 	.alloc			=3D its_irq_domain_alloc,
 	.free			=3D its_irq_domain_free,
 	.activate		=3D its_irq_domain_activate,
@@ -4993,6 +4995,9 @@ static int its_init_domain(struct its_node *its)
=20
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
=20
+	inner_domain->msi_parent_ops =3D &gic_v3_its_msi_parent_ops;
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mb=
i.c
index dbb8b1efda44..3fe870f8ee17 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,6 +18,8 @@
=20
 #include <linux/irqchip/arm-gic-v3.h>
=20
+#include "irq-msi-lib.h"
+
 struct mbi_range {
 	u32			spi_start;
 	u32			nr_spis;
@@ -138,6 +140,7 @@ static void mbi_irq_domain_free(struct irq_domain *domain,
 }
=20
 static const struct irq_domain_ops mbi_domain_ops =3D {
+	.select			=3D msi_lib_irq_domain_select,
 	.alloc			=3D mbi_irq_domain_alloc,
 	.free			=3D mbi_irq_domain_free,
 };
@@ -151,54 +154,6 @@ static void mbi_compose_msi_msg(struct irq_data *data, s=
truct msi_msg *msg)
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
=20
-#ifdef CONFIG_PCI_MSI
-/* PCI-specific irqchip */
-static void mbi_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void mbi_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip mbi_msi_irq_chip =3D {
-	.name			=3D "MSI",
-	.irq_mask		=3D mbi_mask_msi_irq,
-	.irq_unmask		=3D mbi_unmask_msi_irq,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_compose_msi_msg	=3D mbi_compose_msi_msg,
-};
-
-static struct msi_domain_info mbi_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	=3D &mbi_msi_irq_chip,
-};
-
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain =3D pci_msi_create_irq_domain(nexus_domain->parent->fwnode,
-						&mbi_msi_domain_info,
-						nexus_domain);
-	if (!*pci_domain)
-		return -ENOMEM;
-
-	return 0;
-}
-#else
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain =3D NULL;
-	return 0;
-}
-#endif
-
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
@@ -210,28 +165,51 @@ static void mbi_compose_mbi_msg(struct irq_data *data, =
struct msi_msg *msg)
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
 }
=20
-/* Platform-MSI specific irqchip */
-static struct irq_chip mbi_pmsi_irq_chip =3D {
-	.name			=3D "pMSI",
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_compose_msi_msg	=3D mbi_compose_mbi_msg,
-	.flags			=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
-
-static struct msi_domain_ops mbi_pmsi_ops =3D {
-};
+static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *dom=
ain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->irq_compose_msi_msg =3D mbi_compose_msi_msg;
+		return true;
+
+	case DOMAIN_BUS_DEVICE_MSI:
+		info->chip->irq_compose_msi_msg =3D mbi_compose_mbi_msg;
+		info->chip->irq_set_type =3D irq_chip_set_type_parent;
+		info->chip->flags |=3D IRQCHIP_SUPPORTS_LEVEL_MSI;
+		info->flags |=3D MSI_FLAG_LEVEL_CAPABLE;
+		return true;
+
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
=20
-static struct msi_domain_info mbi_pmsi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	=3D &mbi_pmsi_ops,
-	.chip	=3D &mbi_pmsi_irq_chip,
+#define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+#define MBI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
+
+static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops =3D {
+	.supported_flags	=3D MBI_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D MBI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			=3D "MBI-",
+	.init_dev_msi_info	=3D mbi_init_dev_msi_info,
 };
=20
-static int mbi_allocate_domains(struct irq_domain *parent)
+static int mbi_allocate_domain(struct irq_domain *parent)
 {
-	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
-	int err;
+	struct irq_domain *nexus_domain;
=20
 	nexus_domain =3D irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
 						   &mbi_domain_ops, NULL);
@@ -239,22 +217,8 @@ static int mbi_allocate_domains(struct irq_domain *paren=
t)
 		return -ENOMEM;
=20
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-
-	err =3D mbi_allocate_pci_domain(nexus_domain, &pci_domain);
-
-	plat_domain =3D platform_msi_create_irq_domain(parent->fwnode,
-						     &mbi_pmsi_domain_info,
-						     nexus_domain);
-
-	if (err || !plat_domain) {
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(nexus_domain);
-		return -ENOMEM;
-	}
-
+	nexus_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	nexus_domain->msi_parent_ops =3D &gic_v3_mbi_msi_parent_ops;
 	return 0;
 }
=20
@@ -317,7 +281,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct =
irq_domain *parent)
=20
 	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
=20
-	ret =3D mbi_allocate_domains(parent);
+	ret =3D mbi_allocate_domain(parent);
 	if (ret)
 		goto err_free_mbi;
=20
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-ms=
i.c
index 90d41c1407ac..4342a21de1eb 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,6 +24,8 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
=20
+#include "irq-msi-lib.h"
+
 #define IMX_MU_CHANS            4
=20
 enum imx_mu_xcr {
@@ -114,20 +116,6 @@ static void imx_mu_msi_parent_ack_irq(struct irq_data *d=
ata)
 	imx_mu_read(msi_data, msi_data->cfg->xRR + data->hwirq * 4);
 }
=20
-static struct irq_chip imx_mu_msi_irq_chip =3D {
-	.name =3D "MU-MSI",
-	.irq_ack =3D irq_chip_ack_parent,
-};
-
-static struct msi_domain_ops imx_mu_msi_irq_ops =3D {
-};
-
-static struct msi_domain_info imx_mu_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &imx_mu_msi_irq_ops,
-	.chip	=3D &imx_mu_msi_irq_chip,
-};
-
 static void imx_mu_msi_parent_compose_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
@@ -195,6 +183,7 @@ static void imx_mu_msi_domain_irq_free(struct irq_domain =
*domain,
 }
=20
 static const struct irq_domain_ops imx_mu_msi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D imx_mu_msi_domain_irq_alloc,
 	.free	=3D imx_mu_msi_domain_irq_free,
 };
@@ -216,35 +205,38 @@ static void imx_mu_msi_irq_handler(struct irq_desc *des=
c)
 	chained_irq_exit(chip, desc);
 }
=20
+#define IMX_MU_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+					 MSI_FLAG_USE_DEF_CHIP_OPS |	\
+					 MSI_FLAG_PARENT_PM_DEV)
+
+#define IMX_MU_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops imx_mu_msi_parent_ops =3D {
+	.supported_flags	=3D IMX_MU_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D IMX_MU_MSI_FLAGS_REQUIRED,
+	.bus_select_token       =3D DOMAIN_BUS_NEXUS,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.prefix			=3D "MU-MSI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct devic=
e *dev)
 {
 	struct fwnode_handle *fwnodes =3D dev_fwnode(dev);
 	struct irq_domain *parent;
=20
 	/* Initialize MSI domain parent */
-	parent =3D irq_domain_create_linear(fwnodes,
-					    IMX_MU_CHANS,
-					    &imx_mu_msi_domain_ops,
-					    msi_data);
+	parent =3D irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
+					  &imx_mu_msi_domain_ops, msi_data);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
=20
 	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	msi_data->msi_domain =3D platform_msi_create_irq_domain(fwnodes,
-					&imx_mu_msi_domain_info,
-					parent);
-
-	if (!msi_data->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
-
-	irq_domain_set_pm_device(msi_data->msi_domain, dev);
-
+	parent->dev =3D parent->pm_dev =3D dev;
+	parent->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	parent->msi_parent_ops =3D &imx_mu_msi_parent_ops;
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 58881d313979..093fd42893a7 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -135,24 +135,14 @@ static int mbigen_set_type(struct irq_data *data, unsig=
ned int type)
 	return 0;
 }
=20
-static struct irq_chip mbigen_irq_chip =3D {
-	.name =3D			"mbigen-v2",
-	.irq_mask =3D		irq_chip_mask_parent,
-	.irq_unmask =3D		irq_chip_unmask_parent,
-	.irq_eoi =3D		mbigen_eoi_irq,
-	.irq_set_type =3D		mbigen_set_type,
-	.irq_set_affinity =3D	irq_chip_set_affinity_parent,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
+static void mbigen_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
-	struct irq_data *d =3D irq_get_irq_data(desc->irq);
 	void __iomem *base =3D d->chip_data;
 	u32 val;
=20
 	if (!msg->address_lo && !msg->address_hi)
 		return;
-=20
+
 	base +=3D get_mbigen_vec_reg(d->hwirq);
 	val =3D readl_relaxed(base);
=20
@@ -165,10 +155,8 @@ static void mbigen_write_msg(struct msi_desc *desc, stru=
ct msi_msg *msg)
 	writel_relaxed(val, base);
 }
=20
-static int mbigen_domain_translate(struct irq_domain *d,
-				    struct irq_fwspec *fwspec,
-				    unsigned long *hwirq,
-				    unsigned int *type)
+static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *=
fwspec,
+				   unsigned long *hwirq, unsigned int *type)
 {
 	if (is_of_node(fwspec->fwnode) || is_acpi_device_node(fwspec->fwnode)) {
 		if (fwspec->param_count !=3D 2)
@@ -192,51 +180,48 @@ static int mbigen_domain_translate(struct irq_domain *d,
 	return -EINVAL;
 }
=20
-static int mbigen_irq_domain_alloc(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs,
-					void *args)
+static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *d=
esc)
 {
-	struct irq_fwspec *fwspec =3D args;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct mbigen_device *mgn_chip;
-	int i, err;
-
-	err =3D mbigen_domain_translate(domain, fwspec, &hwirq, &type);
-	if (err)
-		return err;
-
-	err =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err)
-		return err;
+	arg->desc =3D desc;
+	arg->hwirq =3D (u32)desc->data.icookie.value;
+}
=20
-	mgn_chip =3D platform_msi_get_host_data(domain);
+static const struct msi_domain_template mbigen_msi_template =3D {
+	.chip =3D {
+		.name			=3D "mbigen-v2",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_eoi		=3D mbigen_eoi_irq,
+		.irq_set_type		=3D mbigen_set_type,
+		.irq_write_msi_msg	=3D mbigen_write_msi_msg,
+	},
=20
-	for (i =3D 0; i < nr_irqs; i++)
-		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-				      &mbigen_irq_chip, mgn_chip->base);
+	.ops =3D {
+		.set_desc		=3D mbigen_domain_set_desc,
+		.msi_translate		=3D mbigen_domain_translate,
+	},
=20
-	return 0;
-}
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
=20
-static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int v=
irq,
-				   unsigned int nr_irqs)
+static bool mbigen_create_device_domain(struct device *dev, unsigned int siz=
e,
+					struct mbigen_device *mgn_chip)
 {
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
+	if (WARN_ON_ONCE(!dev->msi.domain))
+		return false;
=20
-static const struct irq_domain_ops mbigen_domain_ops =3D {
-	.translate	=3D mbigen_domain_translate,
-	.alloc		=3D mbigen_irq_domain_alloc,
-	.free		=3D mbigen_irq_domain_free,
-};
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					    &mbigen_msi_template, size,
+					    NULL, mgn_chip->base);
+}
=20
 static int mbigen_of_create_domain(struct platform_device *pdev,
 				   struct mbigen_device *mgn_chip)
 {
 	struct platform_device *child;
-	struct irq_domain *domain;
 	struct device_node *np;
 	u32 num_pins;
 	int ret =3D 0;
@@ -258,11 +243,7 @@ static int mbigen_of_create_domain(struct platform_devic=
e *pdev,
 			break;
 		}
=20
-		domain =3D platform_msi_create_device_domain(&child->dev, num_pins,
-							   mbigen_write_msg,
-							   &mbigen_domain_ops,
-							   mgn_chip);
-		if (!domain) {
+		if (!mbigen_create_device_domain(&child->dev, num_pins, mgn_chip)) {
 			ret =3D -ENOMEM;
 			break;
 		}
@@ -284,7 +265,6 @@ MODULE_DEVICE_TABLE(acpi, mbigen_acpi_match);
 static int mbigen_acpi_create_domain(struct platform_device *pdev,
 				     struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain;
 	u32 num_pins =3D 0;
 	int ret;
=20
@@ -315,11 +295,7 @@ static int mbigen_acpi_create_domain(struct platform_dev=
ice *pdev,
 	if (ret || num_pins =3D=3D 0)
 		return -EINVAL;
=20
-	domain =3D platform_msi_create_device_domain(&pdev->dev, num_pins,
-						   mbigen_write_msg,
-						   &mbigen_domain_ops,
-						   mgn_chip);
-	if (!domain)
+	if (!mbigen_create_device_domain(&pdev->dev, num_pins, mgn_chip))
 		return -ENOMEM;
=20
 	return 0;
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
new file mode 100644
index 000000000000..b5b90003311a
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/export.h>
+
+#include "irq-msi-lib.h"
+
+/**
+ * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain is created for
+ * @domain:		The domain providing this callback
+ * @real_parent:	The real parent domain of the domain to be initialized
+ *			which might be a domain built on top of @domain or
+ *			@domain itself
+ * @info:		The domain info for the domain to be initialize
+ *
+ * This function is to be used for all types of MSI domains above the root
+ * parent domain and any intermediates. The topmost parent domain specific
+ * functionality is determined via @real_parent.
+ *
+ * All intermediate domains between the root and the device domain must
+ * have either msi_parent_ops.init_dev_msi_info =3D msi_parent_init_dev_msi_=
info
+ * or invoke it down the line.
+ */
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops =3D real_parent->msi_parent_ops;
+	u32 required_flags;
+
+	/* Parent ops available? */
+	if (WARN_ON_ONCE(!pops))
+		return false;
+
+	/*
+	 * MSI parent domain specific settings. For now there is only the
+	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
+	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 */
+	if (domain->bus_token =3D=3D pops->bus_select_token) {
+		if (WARN_ON_ONCE(domain !=3D real_parent))
+			return false;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	required_flags =3D pops->required_flags;
+
+	/* Is the target domain bus token supported? */
+	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+		/*
+		 * Per device MSI should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags =3D MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
+		fallthrough;
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		/* Remove PCI specific flags */
+		required_flags &=3D ~MSI_FLAG_PCI_MSI_MASK_PARENT;
+		break;
+	default:
+		/*
+		 * This should never be reached. See
+		 * msi_lib_irq_domain_select()
+		 */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&=3D pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|=3D required_flags;
+
+	/* Chip updates for all child bus types */
+	if (!info->chip->irq_eoi)
+		info->chip->irq_eoi	=3D irq_chip_eoi_parent;
+	if (!info->chip->irq_ack)
+		info->chip->irq_ack	=3D irq_chip_ack_parent;
+
+	/*
+	 * The device MSI domain can never have a set affinity callback. It
+	 * always has to rely on the parent domain to handle affinity
+	 * settings. The device MSI domain just has to write the resulting
+	 * MSI message into the hardware which is the whole purpose of the
+	 * device MSI domain aside of mask/unmask which is provided e.g. by
+	 * PCI/MSI device domains.
+	 */
+	info->chip->irq_set_affinity	=3D msi_domain_set_affinity;
+	return true;
+}
+EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
+
+/**
+ * msi_lib_irq_domain_select - Shared select function for NEXUS domains
+ * @d:		Pointer to the irq domain on which select is invoked
+ * @fwspec:	Firmware spec describing what is searched
+ * @bus_token:	The bus token for which a matching irq domain is looked up
+ *
+ * Returns:	%0 if @d is not what is being looked for
+ *
+ *		%1 if @d is either the domain which is directly searched for or
+ *		   if @d is providing the parent MSI domain for the functionality
+ *			 requested with @bus_token.
+ */
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspe=
c,
+			      enum irq_domain_bus_token bus_token)
+{
+	const struct msi_parent_ops *ops =3D d->msi_parent_ops;
+	u32 busmask =3D BIT(bus_token);
+
+	if (fwspec->fwnode !=3D d->fwnode || fwspec->param_count !=3D 0)
+		return 0;
+
+	/* Handle pure domain searches */
+	if (bus_token =3D=3D ops->bus_select_token)
+		return 1;
+
+	return ops && !!(ops->bus_select_mask & busmask);
+}
+EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
new file mode 100644
index 000000000000..681ceabb7bc7
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+
+#include <linux/bits.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
+#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspe=
c,
+			      enum irq_domain_bus_token bus_token);
+
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gic=
p.c
index c43a345061d5..2b6183919ea4 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,6 +17,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
=20
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
 #define GICP_SETSPI_NSR_OFFSET	0x0
@@ -145,32 +147,32 @@ static void gicp_irq_domain_free(struct irq_domain *dom=
ain,
 }
=20
 static const struct irq_domain_ops gicp_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D gicp_irq_domain_alloc,
 	.free	=3D gicp_irq_domain_free,
 };
=20
-static struct irq_chip gicp_msi_irq_chip =3D {
-	.name		=3D "GICP",
-	.irq_set_type	=3D irq_chip_set_type_parent,
-	.flags		=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
+#define GICP_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
=20
-static struct msi_domain_ops gicp_msi_ops =3D {
-};
+#define GICP_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				  MSI_FLAG_LEVEL_CAPABLE)
=20
-static struct msi_domain_info gicp_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	=3D &gicp_msi_ops,
-	.chip	=3D &gicp_msi_irq_chip,
+static const struct msi_parent_ops gicp_msi_parent_ops =3D {
+	.supported_flags	=3D GICP_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D GICP_MSI_FLAGS_REQUIRED,
+	.bus_select_token       =3D DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.prefix			=3D "GICP-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int mvebu_gicp_probe(struct platform_device *pdev)
 {
-	struct mvebu_gicp *gicp;
-	struct irq_domain *inner_domain, *plat_domain, *parent_domain;
+	struct irq_domain *inner_domain, *parent_domain;
 	struct device_node *node =3D pdev->dev.of_node;
 	struct device_node *irq_parent_dn;
+	struct mvebu_gicp *gicp;
 	int ret, i;
=20
 	gicp =3D devm_kzalloc(&pdev->dev, sizeof(*gicp), GFP_KERNEL);
@@ -234,17 +236,9 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 	if (!inner_domain)
 		return -ENOMEM;
=20
-
-	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &gicp_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
-	platform_set_drvdata(pdev, gicp);
-
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops =3D &gicp_msi_parent_ops;
 	return 0;
 }
=20
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 3c77acc7ec6a..b337f6c05f18 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,6 +20,8 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
=20
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
=20
 /* ICU registers */
@@ -60,99 +62,13 @@ struct mvebu_icu_msi_data {
 	const struct mvebu_icu_subset_data *subset_data;
 };
=20
-struct mvebu_icu_irq_data {
-	struct mvebu_icu *icu;
-	unsigned int icu_group;
-	unsigned int type;
-};
-
 static DEFINE_STATIC_KEY_FALSE(legacy_bindings);
=20
-static void mvebu_icu_init(struct mvebu_icu *icu,
-			   struct mvebu_icu_msi_data *msi_data,
-			   struct msi_msg *msg)
-{
-	const struct mvebu_icu_subset_data *subset =3D msi_data->subset_data;
-
-	if (atomic_cmpxchg(&msi_data->initialized, false, true))
-		return;
-
-	/* Set 'SET' ICU SPI message address in AP */
-	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
-	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
-
-	if (subset->icu_group !=3D ICU_GRP_NSR)
-		return;
-
-	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
-	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
-	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
-}
-
-static void mvebu_icu_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	struct irq_data *d =3D irq_get_irq_data(desc->irq);
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(d->domai=
n);
-	struct mvebu_icu_irq_data *icu_irqd =3D d->chip_data;
-	struct mvebu_icu *icu =3D icu_irqd->icu;
-	unsigned int icu_int;
-
-	if (msg->address_lo || msg->address_hi) {
-		/* One off initialization per domain */
-		mvebu_icu_init(icu, msi_data, msg);
-		/* Configure the ICU with irq number & type */
-		icu_int =3D msg->data | ICU_INT_ENABLE;
-		if (icu_irqd->type & IRQ_TYPE_EDGE_RISING)
-			icu_int |=3D ICU_IS_EDGE;
-		icu_int |=3D icu_irqd->icu_group << ICU_GROUP_SHIFT;
-	} else {
-		/* De-configure the ICU */
-		icu_int =3D 0;
-	}
-
-	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
-
-	/*
-	 * The SATA unit has 2 ports, and a dedicated ICU entry per
-	 * port. The ahci sata driver supports only one irq interrupt
-	 * per SATA unit. To solve this conflict, we configure the 2
-	 * SATA wired interrupts in the south bridge into 1 GIC
-	 * interrupt in the north bridge. Even if only a single port
-	 * is enabled, if sata node is enabled, both interrupts are
-	 * configured (regardless of which port is actually in use).
-	 */
-	if (d->hwirq =3D=3D ICU_SATA0_ICU_ID || d->hwirq =3D=3D ICU_SATA1_ICU_ID) {
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
-		writel_relaxed(icu_int,
-			       icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
-	}
-}
-
-static struct irq_chip mvebu_icu_nsr_chip =3D {
-	.name			=3D "ICU-NSR",
-	.irq_mask		=3D irq_chip_mask_parent,
-	.irq_unmask		=3D irq_chip_unmask_parent,
-	.irq_eoi		=3D irq_chip_eoi_parent,
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-};
-
-static struct irq_chip mvebu_icu_sei_chip =3D {
-	.name			=3D "ICU-SEI",
-	.irq_ack		=3D irq_chip_ack_parent,
-	.irq_mask		=3D irq_chip_mask_parent,
-	.irq_unmask		=3D irq_chip_unmask_parent,
-	.irq_set_type		=3D irq_chip_set_type_parent,
-	.irq_set_affinity	=3D irq_chip_set_affinity_parent,
-};
-
-static int
-mvebu_icu_irq_domain_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
+static int mvebu_icu_translate(struct irq_domain *d, struct irq_fwspec *fwsp=
ec,
 			       unsigned long *hwirq, unsigned int *type)
 {
 	unsigned int param_count =3D static_branch_unlikely(&legacy_bindings) ? 3 :=
 2;
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(d);
+	struct mvebu_icu_msi_data *msi_data =3D d->host_data;
 	struct mvebu_icu *icu =3D msi_data->icu;
=20
 	/* Check the count of the parameters in dt */
@@ -192,81 +108,126 @@ mvebu_icu_irq_domain_translate(struct irq_domain *d, s=
truct irq_fwspec *fwspec,
 	return 0;
 }
=20
-static int
-mvebu_icu_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-			   unsigned int nr_irqs, void *args)
+static void mvebu_icu_init(struct mvebu_icu *icu,
+			   struct mvebu_icu_msi_data *msi_data,
+			   struct msi_msg *msg)
 {
-	int err;
-	unsigned long hwirq;
-	struct irq_fwspec *fwspec =3D args;
-	struct mvebu_icu_msi_data *msi_data =3D platform_msi_get_host_data(domain);
-	struct mvebu_icu *icu =3D msi_data->icu;
-	struct mvebu_icu_irq_data *icu_irqd;
-	struct irq_chip *chip =3D &mvebu_icu_nsr_chip;
+	const struct mvebu_icu_subset_data *subset =3D msi_data->subset_data;
=20
-	icu_irqd =3D kmalloc(sizeof(*icu_irqd), GFP_KERNEL);
-	if (!icu_irqd)
-		return -ENOMEM;
+	if (atomic_cmpxchg(&msi_data->initialized, false, true))
+		return;
=20
-	err =3D mvebu_icu_irq_domain_translate(domain, fwspec, &hwirq,
-					     &icu_irqd->type);
-	if (err) {
-		dev_err(icu->dev, "failed to translate ICU parameters\n");
-		goto free_irqd;
-	}
+	/* Set 'SET' ICU SPI message address in AP */
+	writel_relaxed(msg[0].address_hi, icu->base + subset->offset_set_ah);
+	writel_relaxed(msg[0].address_lo, icu->base + subset->offset_set_al);
=20
-	if (static_branch_unlikely(&legacy_bindings))
-		icu_irqd->icu_group =3D fwspec->param[0];
-	else
-		icu_irqd->icu_group =3D msi_data->subset_data->icu_group;
-	icu_irqd->icu =3D icu;
+	if (subset->icu_group !=3D ICU_GRP_NSR)
+		return;
=20
-	err =3D platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err) {
-		dev_err(icu->dev, "failed to allocate ICU interrupt in parent domain\n");
-		goto free_irqd;
-	}
+	/* Set 'CLEAR' ICU SPI message address in AP (level-MSI only) */
+	writel_relaxed(msg[1].address_hi, icu->base + subset->offset_clr_ah);
+	writel_relaxed(msg[1].address_lo, icu->base + subset->offset_clr_al);
+}
=20
-	/* Make sure there is no interrupt left pending by the firmware */
-	err =3D irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
-	if (err)
-		goto free_msi;
+static int mvebu_icu_msi_init(struct irq_domain *domain, struct msi_domain_i=
nfo *info,
+			      unsigned int virq, irq_hw_number_t hwirq, msi_alloc_info_t *arg)
+{
+	irq_domain_set_hwirq_and_chip(domain, virq, hwirq, info->chip, info->chip_d=
ata);
+	return irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);
+}
=20
-	if (icu_irqd->icu_group =3D=3D ICU_GRP_SEI)
-		chip =3D &mvebu_icu_sei_chip;
+static void mvebu_icu_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc =3D desc;
+	arg->hwirq =3D (u32)desc->data.icookie.value;
+}
=20
-	err =3D irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
-					    chip, icu_irqd);
-	if (err) {
-		dev_err(icu->dev, "failed to set the data to IRQ domain\n");
-		goto free_msi;
+static void mvebu_icu_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct mvebu_icu_msi_data *msi_data =3D d->chip_data;
+	unsigned int icu_group =3D msi_data->subset_data->icu_group;
+	struct msi_desc *desc =3D irq_data_get_msi_desc(d);
+	struct mvebu_icu *icu =3D msi_data->icu;
+	unsigned int type;
+	u32 icu_int;
+
+	if (msg->address_lo || msg->address_hi) {
+		/* One off initialization per domain */
+		mvebu_icu_init(icu, msi_data, msg);
+		/* Configure the ICU with irq number & type */
+		icu_int =3D msg->data | ICU_INT_ENABLE;
+		type =3D (unsigned int)(desc->data.icookie.value >> 32);
+		if (type & IRQ_TYPE_EDGE_RISING)
+			icu_int |=3D ICU_IS_EDGE;
+		icu_int |=3D icu_group << ICU_GROUP_SHIFT;
+	} else {
+		/* De-configure the ICU */
+		icu_int =3D 0;
 	}
=20
-	return 0;
+	writel_relaxed(icu_int, icu->base + ICU_INT_CFG(d->hwirq));
=20
-free_msi:
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-free_irqd:
-	kfree(icu_irqd);
-	return err;
+	/*
+	 * The SATA unit has 2 ports, and a dedicated ICU entry per
+	 * port. The ahci sata driver supports only one irq interrupt
+	 * per SATA unit. To solve this conflict, we configure the 2
+	 * SATA wired interrupts in the south bridge into 1 GIC
+	 * interrupt in the north bridge. Even if only a single port
+	 * is enabled, if sata node is enabled, both interrupts are
+	 * configured (regardless of which port is actually in use).
+	 */
+	if (d->hwirq =3D=3D ICU_SATA0_ICU_ID || d->hwirq =3D=3D ICU_SATA1_ICU_ID) {
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA0_ICU_ID));
+		writel_relaxed(icu_int, icu->base + ICU_INT_CFG(ICU_SATA1_ICU_ID));
+	}
 }
=20
-static void
-mvebu_icu_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-			  unsigned int nr_irqs)
-{
-	struct irq_data *d =3D irq_get_irq_data(virq);
-	struct mvebu_icu_irq_data *icu_irqd =3D d->chip_data;
+static const struct msi_domain_template mvebu_icu_nsr_msi_template =3D {
+	.chip =3D {
+		.name			=3D "ICU-NSR",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_eoi		=3D irq_chip_eoi_parent,
+		.irq_set_type		=3D irq_chip_set_type_parent,
+		.irq_write_msi_msg	=3D mvebu_icu_write_msi_msg,
+		.flags			=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
=20
-	kfree(icu_irqd);
+	.ops =3D {
+		.msi_translate		=3D mvebu_icu_translate,
+		.msi_init		=3D mvebu_icu_msi_init,
+		.set_desc		=3D mvebu_icu_set_desc,
+	},
=20
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
+};
+
+static const struct msi_domain_template mvebu_icu_sei_msi_template =3D {
+	.chip =3D {
+		.name			=3D "ICU-SEI",
+		.irq_mask		=3D irq_chip_mask_parent,
+		.irq_unmask		=3D irq_chip_unmask_parent,
+		.irq_ack		=3D irq_chip_ack_parent,
+		.irq_set_type		=3D irq_chip_set_type_parent,
+		.irq_write_msi_msg	=3D mvebu_icu_write_msi_msg,
+		.flags			=3D IRQCHIP_SUPPORTS_LEVEL_MSI,
+	},
=20
-static const struct irq_domain_ops mvebu_icu_domain_ops =3D {
-	.translate =3D mvebu_icu_irq_domain_translate,
-	.alloc     =3D mvebu_icu_irq_domain_alloc,
-	.free      =3D mvebu_icu_irq_domain_free,
+	.ops =3D {
+		.msi_translate		=3D mvebu_icu_translate,
+		.msi_init		=3D mvebu_icu_msi_init,
+		.set_desc		=3D mvebu_icu_set_desc,
+	},
+
+	.info =3D {
+		.bus_token		=3D DOMAIN_BUS_WIRED_TO_MSI,
+		.flags			=3D MSI_FLAG_LEVEL_CAPABLE |
+					  MSI_FLAG_USE_DEV_FWNODE,
+	},
 };
=20
 static const struct mvebu_icu_subset_data mvebu_icu_nsr_subset_data =3D {
@@ -297,10 +258,10 @@ static const struct of_device_id mvebu_icu_subset_of_ma=
tch[] =3D {
=20
 static int mvebu_icu_subset_probe(struct platform_device *pdev)
 {
+	const struct msi_domain_template *tmpl;
 	struct mvebu_icu_msi_data *msi_data;
-	struct device_node *msi_parent_dn;
 	struct device *dev =3D &pdev->dev;
-	struct irq_domain *irq_domain;
+	bool sei;
=20
 	msi_data =3D devm_kzalloc(dev, sizeof(*msi_data), GFP_KERNEL);
 	if (!msi_data)
@@ -314,20 +275,18 @@ static int mvebu_icu_subset_probe(struct platform_devic=
e *pdev)
 		msi_data->subset_data =3D of_device_get_match_data(dev);
 	}
=20
-	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node,
-					    DOMAIN_BUS_PLATFORM_MSI);
+	dev->msi.domain =3D of_msi_get_domain(dev, dev->of_node, DOMAIN_BUS_PLATFOR=
M_MSI);
 	if (!dev->msi.domain)
 		return -EPROBE_DEFER;
=20
-	msi_parent_dn =3D irq_domain_get_of_node(dev->msi.domain);
-	if (!msi_parent_dn)
+	if (!irq_domain_get_of_node(dev->msi.domain))
 		return -ENODEV;
=20
-	irq_domain =3D platform_msi_create_device_tree_domain(dev, ICU_MAX_IRQS,
-							    mvebu_icu_write_msg,
-							    &mvebu_icu_domain_ops,
-							    msi_data);
-	if (!irq_domain) {
+	sei =3D msi_data->subset_data->icu_group =3D=3D ICU_GRP_SEI;
+	tmpl =3D sei ? &mvebu_icu_sei_msi_template : &mvebu_icu_nsr_msi_template;
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, tmpl,
+					  ICU_MAX_IRQS, NULL, msi_data)) {
 		dev_err(dev, "Failed to create ICU MSI domain\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odm=
i.c
index 108091533e10..ff19bfd258dc 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -17,6 +17,9 @@
 #include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+
+#include "irq-msi-lib.h"
+
 #include <dt-bindings/interrupt-controller/arm-gic.h>
=20
 #define GICP_ODMIN_SET			0x40
@@ -141,27 +144,29 @@ static void odmi_irq_domain_free(struct irq_domain *dom=
ain,
 }
=20
 static const struct irq_domain_ops odmi_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D odmi_irq_domain_alloc,
 	.free	=3D odmi_irq_domain_free,
 };
=20
-static struct irq_chip odmi_msi_irq_chip =3D {
-	.name	=3D "ODMI",
-};
+#define ODMI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				  MSI_FLAG_USE_DEF_CHIP_OPS)
=20
-static struct msi_domain_ops odmi_msi_ops =3D {
-};
+#define ODMI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK)
=20
-static struct msi_domain_info odmi_msi_domain_info =3D {
-	.flags	=3D (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	=3D &odmi_msi_ops,
-	.chip	=3D &odmi_msi_irq_chip,
+static const struct msi_parent_ops odmi_msi_parent_ops =3D {
+	.supported_flags	=3D ODMI_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D ODMI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	=3D DOMAIN_BUS_GENERIC_MSI,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.prefix			=3D "ODMI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
 };
=20
 static int __init mvebu_odmi_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	struct irq_domain *parent_domain, *inner_domain, *plat_domain;
+	struct irq_domain *parent_domain, *inner_domain;
 	int ret, i;
=20
 	if (of_property_read_u32(node, "marvell,odmi-frames", &odmis_count))
@@ -208,18 +213,12 @@ static int __init mvebu_odmi_init(struct device_node *n=
ode,
 		goto err_unmap;
 	}
=20
-	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &odmi_msi_domain_info,
-						     inner_domain);
-	if (!plat_domain) {
-		ret =3D -ENOMEM;
-		goto err_remove_inner;
-	}
+	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
+	inner_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops =3D &odmi_msi_parent_ops;
=20
 	return 0;
=20
-err_remove_inner:
-	irq_domain_remove(inner_domain);
 err_unmap:
 	for (i =3D 0; i < odmis_count; i++) {
 		struct odmi_data *odmi =3D &odmis[i];
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index a48dbe91b036..f8c70f2d100a 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,6 +14,8 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
=20
+#include "irq-msi-lib.h"
+
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
 /* Mask register */
@@ -190,6 +192,7 @@ static void mvebu_sei_domain_free(struct irq_domain *doma=
in, unsigned int virq,
 }
=20
 static const struct irq_domain_ops mvebu_sei_domain_ops =3D {
+	.select	=3D msi_lib_irq_domain_select,
 	.alloc	=3D mvebu_sei_domain_alloc,
 	.free	=3D mvebu_sei_domain_free,
 };
@@ -307,21 +310,6 @@ static const struct irq_domain_ops mvebu_sei_cp_domain_o=
ps =3D {
 	.free	=3D mvebu_sei_cp_domain_free,
 };
=20
-static struct irq_chip mvebu_sei_msi_irq_chip =3D {
-	.name		=3D "SEI pMSI",
-	.irq_ack	=3D irq_chip_ack_parent,
-	.irq_set_type	=3D irq_chip_set_type_parent,
-};
-
-static struct msi_domain_ops mvebu_sei_msi_ops =3D {
-};
-
-static struct msi_domain_info mvebu_sei_msi_domain_info =3D {
-	.flags	=3D MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS,
-	.ops	=3D &mvebu_sei_msi_ops,
-	.chip	=3D &mvebu_sei_msi_irq_chip,
-};
-
 static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
 {
 	struct mvebu_sei *sei =3D irq_desc_get_handler_data(desc);
@@ -360,10 +348,23 @@ static void mvebu_sei_reset(struct mvebu_sei *sei)
 	}
 }
=20
+#define SEI_MSI_FLAGS_REQUIRED	(MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define SEI_MSI_FLAGS_SUPPORTED	(MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops sei_msi_parent_ops =3D {
+	.supported_flags	=3D SEI_MSI_FLAGS_SUPPORTED,
+	.required_flags		=3D SEI_MSI_FLAGS_REQUIRED,
+	.bus_select_mask	=3D MATCH_PLATFORM_MSI,
+	.bus_select_token	=3D DOMAIN_BUS_GENERIC_MSI,
+	.prefix			=3D "SEI-",
+	.init_dev_msi_info	=3D msi_lib_init_dev_msi_info,
+};
+
 static int mvebu_sei_probe(struct platform_device *pdev)
 {
 	struct device_node *node =3D pdev->dev.of_node;
-	struct irq_domain *plat_domain;
 	struct mvebu_sei *sei;
 	u32 parent_irq;
 	int ret;
@@ -440,33 +441,20 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	}
=20
 	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
-
-	plat_domain =3D platform_msi_create_irq_domain(of_node_to_fwnode(node),
-						     &mvebu_sei_msi_domain_info,
-						     sei->cp_domain);
-	if (!plat_domain) {
-		pr_err("Failed to create CPs MSI domain\n");
-		ret =3D -ENOMEM;
-		goto remove_cp_domain;
-	}
+	sei->cp_domain->flags |=3D IRQ_DOMAIN_FLAG_MSI_PARENT;
+	sei->cp_domain->msi_parent_ops =3D &sei_msi_parent_ops;
=20
 	mvebu_sei_reset(sei);
=20
-	irq_set_chained_handler_and_data(parent_irq,
-					 mvebu_sei_handle_cascade_irq,
-					 sei);
-
+	irq_set_chained_handler_and_data(parent_irq, mvebu_sei_handle_cascade_irq, =
sei);
 	return 0;
=20
-remove_cp_domain:
-	irq_domain_remove(sei->cp_domain);
 remove_ap_domain:
 	irq_domain_remove(sei->ap_domain);
 remove_sei_domain:
 	irq_domain_remove(sei->sei_domain);
 dispose_irq:
 	irq_dispose_mapping(parent_irq);
-
 	return ret;
 }
=20
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 03d2dd25790d..569125726b3e 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,17 +148,35 @@ static void pci_device_domain_set_desc(msi_alloc_info_t=
 *arg, struct msi_desc *d
 	arg->hwirq =3D desc->msi_index;
 }
=20
+static __always_inline void cond_mask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info =3D data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_mask_parent(data);
+}
+
+static __always_inline void cond_unmask_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info =3D data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT))
+		irq_chip_unmask_parent(data);
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
 	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
=20
+	cond_unmask_parent(data);
 	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
 }
=20
@@ -195,10 +213,12 @@ static const struct msi_domain_template pci_msi_templat=
e =3D {
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_mask_parent(data);
 }
=20
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
+	cond_unmask_parent(data);
 	pci_msix_unmask(irq_data_get_msi_desc(data));
 }
=20
diff --git a/include/linux/msi.h b/include/linux/msi.h
index dc27cf3903d5..369367ecae5e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -21,11 +21,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
-#include <linux/xarray.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
 #include <linux/irq.h>
-#include <linux/bits.h>
=20
 #include <asm/msi.h>
=20
@@ -81,7 +77,6 @@ extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
-struct platform_msi_priv_data;
 struct device_attribute;
 struct irq_domain;
 struct irq_affinity_desc;
@@ -228,22 +223,6 @@ struct msi_dev_domain {
 	struct irq_domain	*domain;
 };
=20
-/**
- * msi_device_data - MSI per device data
- * @properties:		MSI properties which are interesting to drivers
- * @platform_data:	Platform-MSI specific data
- * @mutex:		Mutex protecting the MSI descriptor store
- * @__domains:		Internal data for per device MSI domains
- * @__iter_idx:		Index to search the next entry for iterators
- */
-struct msi_device_data {
-	unsigned long			properties;
-	struct platform_msi_priv_data	*platform_data;
-	struct mutex			mutex;
-	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
-	unsigned long			__iter_idx;
-};
-
 int msi_setup_device_data(struct device *dev);
=20
 void msi_lock_descs(struct device *dev);
@@ -556,6 +535,8 @@ enum {
 	MSI_FLAG_USE_DEV_FWNODE		=3D (1 << 7),
 	/* Set parent->dev into domain->pm_dev on device domain creation */
 	MSI_FLAG_PARENT_PM_DEV		=3D (1 << 8),
+	/* Support for parent mask/unmask */
+	MSI_FLAG_PCI_MSI_MASK_PARENT	=3D (1 << 9),
=20
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),
@@ -639,35 +620,6 @@ void msi_domain_free_irqs_all(struct device *dev, unsign=
ed int domid);
=20
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
=20
-struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwno=
de,
-						  struct msi_domain_info *info,
-						  struct irq_domain *parent);
-
-/* When an MSI domain is used as an intermediate domain */
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *args);
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq, int nvec, msi_alloc_info_t *args);
-void msi_domain_depopulate_descs(struct device *dev, int virq, int nvec);
-
-struct irq_domain *
-__platform_msi_create_device_domain(struct device *dev,
-				    unsigned int nvec,
-				    bool is_tree,
-				    irq_write_msi_msg_t write_msi_msg,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
-
-#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
-	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
-#define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
-	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
-
-int platform_msi_device_domain_alloc(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nr_irqs);
-void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int=
 virq,
-				     unsigned int nvec);
-void *platform_msi_get_host_data(struct irq_domain *domain);
 /* Per device platform MSI */
 int platform_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int=
 nvec,
 					    irq_write_msi_msg_t write_msi_msg);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc8891cc16..8475b83c5519 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -438,7 +438,8 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fw=
spec *fwspec,
 	struct fwnode_handle *fwnode =3D fwspec->fwnode;
 	int rc;
=20
-	/* We might want to match the legacy controller last since
+	/*
+	 * We might want to match the legacy controller last since
 	 * it might potentially be set to match all interrupts in
 	 * the absence of a device node. This isn't a problem so far
 	 * yet though...
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2024f89baea4..5fa0547ece0c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -8,17 +8,33 @@
  * This file contains common code to support Message Signaled Interrupts for
  * PCI compatible and non PCI compatible devices.
  */
-#include <linux/types.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
=20
 #include "internals.h"
=20
+/**
+ * struct msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @__domains:		Internal data for per device MSI domains
+ * @__iter_idx:		Index to search the next entry for iterators
+ */
+struct msi_device_data {
+	unsigned long			properties;
+	struct mutex			mutex;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
+	unsigned long			__iter_idx;
+};
+
 /**
  * struct msi_ctrl - MSI internal management control structure
  * @domid:	ID of the domain on which management operations should be done
@@ -1088,8 +1104,8 @@ bool msi_match_device_irq_domain(struct device *dev, un=
signed int domid,
 	return ret;
 }
=20
-int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec, msi_alloc_info_t *arg)
+static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device =
*dev,
+				   int nvec, msi_alloc_info_t *arg)
 {
 	struct msi_domain_info *info =3D domain->host_data;
 	struct msi_domain_ops *ops =3D info->ops;
@@ -1097,77 +1113,6 @@ int msi_domain_prepare_irqs(struct irq_domain *domain,=
 struct device *dev,
 	return ops->msi_prepare(domain, dev, nvec, arg);
 }
=20
-int msi_domain_populate_irqs(struct irq_domain *domain, struct device *dev,
-			     int virq_base, int nvec, msi_alloc_info_t *arg)
-{
-	struct msi_domain_info *info =3D domain->host_data;
-	struct msi_domain_ops *ops =3D info->ops;
-	struct msi_ctrl ctrl =3D {
-		.domid	=3D MSI_DEFAULT_DOMAIN,
-		.first  =3D virq_base,
-		.last	=3D virq_base + nvec - 1,
-	};
-	struct msi_desc *desc;
-	struct xarray *xa;
-	int ret, virq;
-
-	msi_lock_descs(dev);
-
-	if (!msi_ctrl_valid(dev, &ctrl)) {
-		ret =3D -EINVAL;
-		goto unlock;
-	}
-
-	ret =3D msi_domain_add_simple_msi_descs(dev, &ctrl);
-	if (ret)
-		goto unlock;
-
-	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
-
-	for (virq =3D virq_base; virq < virq_base + nvec; virq++) {
-		desc =3D xa_load(xa, virq);
-		desc->irq =3D virq;
-
-		ops->set_desc(arg, desc);
-		ret =3D irq_domain_alloc_irqs_hierarchy(domain, virq, 1, arg);
-		if (ret)
-			goto fail;
-
-		irq_set_msi_desc(virq, desc);
-	}
-	msi_unlock_descs(dev);
-	return 0;
-
-fail:
-	for (--virq; virq >=3D virq_base; virq--) {
-		msi_domain_depopulate_descs(dev, virq, 1);
-		irq_domain_free_irqs_common(domain, virq, 1);
-	}
-	msi_domain_free_descs(dev, &ctrl);
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
-}
-
-void msi_domain_depopulate_descs(struct device *dev, int virq_base, int nvec)
-{
-	struct msi_ctrl ctrl =3D {
-		.domid	=3D MSI_DEFAULT_DOMAIN,
-		.first  =3D virq_base,
-		.last	=3D virq_base + nvec - 1,
-	};
-	struct msi_desc *desc;
-	struct xarray *xa;
-	unsigned long idx;
-
-	if (!msi_ctrl_valid(dev, &ctrl))
-		return;
-
-	xa =3D &dev->msi.data->__domains[ctrl.domid].store;
-	xa_for_each_range(xa, idx, desc, ctrl.first, ctrl.last)
-		desc->irq =3D 0;
-}
-
 /*
  * Carefully check whether the device can use reservation mode. If
  * reservation mode is enabled then the early activation will assign a



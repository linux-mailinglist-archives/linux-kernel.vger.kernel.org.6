Return-Path: <linux-kernel+bounces-333236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E96C897C5C3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7163D1F228B4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378FD1990D7;
	Thu, 19 Sep 2024 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Na84f0JA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4231198E9B
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734340; cv=none; b=bMtfjZy2QiiuY4K2lbJ8eAUNA0N8HAhiLS7UrEiomlyG1WsnBbFXY845I8aoJ0hOQ7j++1HD+US52WPf6YSbZJGlxkDN5H399hvTsmI36revyD4YDrM9yFhsKaHtkh0Aqeu354lvHShDk3WsBSsu21EtR64XUf64ahDfkSKkVgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734340; c=relaxed/simple;
	bh=I+1/h8w66Ko9V4d7rDmx7wTFUatWmAwuRoGm5l3iZa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eRuSnbIFBCwZJy42K5+n/EYsi7uHYL1oYHyND/X1GuJlogA/UZzkt1P9wIkj5fAnuhu8Of3/KJNQ02M88ENMz3CWxpo7hrmkA4ZaNAgOd/p1F5mS9Y4Gt695XlOrQoxTq5zEKpMGagkBDqbuAvLAtOZTtSH4Ew3IzBR8POs7dWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Na84f0JA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2055a3f80a4so4406295ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726734338; x=1727339138; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zv8UBzpT++2A1Z5LtWaFXxAekSrpKtHS741NZWyaGOg=;
        b=Na84f0JACrMmsMmZ6GvuQbdT+dF/sHMCXipO2pKa9KmMTJW5fO5/IiHiLTLCvUX/Qz
         TOhQnelFwnj2BeimbfIn2Epg7mlvtI1ZeTRmVdpSNE8zdt6Ut/eKdQ4pPg0gxMI2OYee
         ro4oI8Tm0comyDNKMM0+jsfLCPhx55aIlpfGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726734338; x=1727339138;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zv8UBzpT++2A1Z5LtWaFXxAekSrpKtHS741NZWyaGOg=;
        b=SgVvgfpKqqW73DrzxsqOgPQx5omPH+ojrgon0/b9paTHcrsdOvfgu01cQ1UryVeKUj
         le6n66Jv7KeWgPAJbNcE81KTiddtL2UJPpHQAWH3XwAkddSo3THGHl7/WmnnhWbp84eJ
         x27YT1SixwzDZP54XPkS7Rn2x5kZ1NsGeFa5TwdR1NuMIGa13y3nK4rFmgMACN+hBUfH
         DzxG8KwzTcZ2UH5q4HOem6dzgLZA3sS3SwCHTb20snRrd7DKnL/QwLXBaiJyrwMEd1wu
         F96B8qKscnowC2fCPqsAegyOMbNx5lZn2G6dAPDm65+hXqHTfWQPfROABbx00wotvA1q
         NO+g==
X-Gm-Message-State: AOJu0Yx+R6SbGe/2FHRdqt7t1xB4oEPnm9cPSlFyeSu2JlvYYDAMbtUI
	pP2ZyNiWt0F+bk0CPxHFBrJOGp3DNR49St9vf8yPbfq1Uc5fayV/r/DIFX1EXA==
X-Google-Smtp-Source: AGHT+IHgyUzDSi0goEAofqZhhD2vYTSY1PZMedmtnKrcsSBCiPfXALNJZGtmwtgL+T20eqkrYjhPGQ==
X-Received: by 2002:a17:902:d50a:b0:206:9caf:1e09 with SMTP id d9443c01a7336-2076e47a81amr355154595ad.61.1726734337918;
        Thu, 19 Sep 2024 01:25:37 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794735810sm75228425ad.278.2024.09.19.01.25.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:25:37 -0700 (PDT)
From: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To: linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	manivannan.sadhasivam@linaro.org,
	logang@deltatee.com
Cc: linux-kernel@vger.kernel.org,
	sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com,
	sjeaugey@nvidia.com,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH 1/2 v2] PCI/portdrv: Enable reporting inter-switch P2P links
Date: Thu, 19 Sep 2024 01:13:43 -0700
Message-Id: <1726733624-2142-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Broadcom PCI switches supports inter-switch P2P links between two
PCI-to-PCI bridges. This presents an optimal data path for data
movement. The patch exports a new sysfs entry for PCI devices that
support the inter switch P2P links and reports the B:D:F information
of the devices that are connected through this inter switch link as
shown below:

                             Host root bridge
                ---------------------------------------
                |                                     |
  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
(2c:00.0)   (2a:00.0)                             (3d:00.0)   (40:00.0)
                |                                     |
               GPU1                                  GPU2
            (2d:00.0)                             (3f:00.0)
                               SERVER 1

$ find /sys/ -name "p2p_link" | xargs grep .
/sys/devices/pci0000:29/0000:29:01.0/0000:2a:00.0/p2p_link:0000:3d:00.0
/sys/devices/pci0000:3c/0000:3c:01.0/0000:3d:00.0/p2p_link:0000:2a:00.0

Current support is added to report the P2P links available for
Broadcom switches based on the capability that is reported by the
upstream bridges through their vendor-specific capability registers.

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
---
Changes in v2:
Integrated the code into PCIe portdrv to create the sysfs entries during
probe, as suggested by Mani.

 Documentation/ABI/testing/sysfs-bus-pci |  14 +++
 drivers/pci/pcie/portdrv.c              | 131 ++++++++++++++++++++++++
 drivers/pci/pcie/portdrv.h              |  10 ++
 3 files changed, 155 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index ecf47559f495..e5d02f20655f 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -572,3 +572,17 @@ Description:
 		enclosure-specific indications "specific0" to "specific7",
 		hence the corresponding led class devices are unavailable if
 		the DSM interface is used.
+
+What:		/sys/bus/pci/devices/.../p2p_link
+Date:		September 2024
+Contact:	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
+Description:
+		This file appears on PCIe upstream ports which supports an
+		internal P2P link.
+		Reading this attribute will provide the list of other upstream
+		ports on the system which have an internal P2P link available
+		between the two ports.
+Users:
+		Userspace applications interested in determining a optimal P2P
+		link for data transfers between devices connected to the PCIe
+		switches.
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 6af5e0425872..c940b4b242fd 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -18,6 +18,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/aer.h>
+#include <linux/bitops.h>
 
 #include "../pci.h"
 #include "portdrv.h"
@@ -37,6 +38,134 @@ struct portdrv_service_data {
 	u32 service;
 };
 
+/**
+ * pcie_brcm_is_p2p_supported - Broadcom device specific handler
+ *       to check if the upstream port supports inter switch P2P.
+ *
+ * @dev: PCIe upstream port to check
+ *
+ * This function assumes the PCIe upstream port is a Broadcom
+ * PCIe device.
+ */
+static bool pcie_brcm_is_p2p_supported(struct pci_dev *dev)
+{
+	u64 dsn;
+	u16 vsec;
+	u32 vsec_data;
+
+	dsn = pci_get_dsn(dev);
+	if (!dsn) {
+		pci_dbg(dev, "DSN capability is not present\n");
+		return false;
+	}
+
+	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_LSI_LOGIC,
+					PCIE_BRCM_SW_P2P_VSEC_ID);
+	if (!vsec) {
+		pci_dbg(dev, "Failed to get VSEC capability\n");
+		return false;
+	}
+
+	pci_read_config_dword(dev, vsec + PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET,
+			      &vsec_data);
+
+	pci_dbg(dev, "Serial Number: 0x%llx VSEC 0x%x\n",
+		dsn, vsec_data);
+
+	if (!PCIE_BRCM_SW_IS_SECURE_PART(dsn))
+		return false;
+
+	if (FIELD_GET(PCIE_BRCM_SW_P2P_MODE_MASK, vsec_data) !=
+		PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK)
+		return false;
+
+	return true;
+}
+
+/**
+ * Determine if device supports Inter switch P2P links.
+ *
+ * Return value: true if inter switch P2P is supported, return false otherwise.
+ */
+static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
+{
+	/* P2P link attribute is supported on upstream ports only */
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_UPSTREAM)
+		return false;
+
+	/*
+	 * Currently Broadcom PEX switches are supported.
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_LSI_LOGIC &&
+	    (dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC ||
+	     dev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC))
+		return pcie_brcm_is_p2p_supported(dev);
+
+	return false;
+}
+
+/*
+ * Traverse list of all PCI bridges and find devices that support Inter switch P2P
+ * and have the same serial number to create report the BDF over sysfs.
+ */
+static ssize_t p2p_link_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev), *pdev_link = NULL;
+	size_t len = 0;
+	u64 dsn, dsn_link;
+
+	dsn = pci_get_dsn(pdev);
+
+	/* Traverse list of PCI bridges to determine any available P2P links */
+	while ((pdev_link = pci_get_class(PCI_CLASS_BRIDGE_PCI << 8, pdev_link))
+			!= NULL) {
+		if (pdev_link == pdev)
+			continue;
+
+		if (!pcie_port_is_p2p_supported(pdev_link))
+			continue;
+
+		dsn_link = pci_get_dsn(pdev_link);
+		if (!dsn_link)
+			continue;
+
+		if (dsn == dsn_link)
+			len += sysfs_emit_at(buf, len, "%04x:%02x:%02x.%d\n",
+					     pci_domain_nr(pdev_link->bus),
+					     pdev_link->bus->number, PCI_SLOT(pdev_link->devfn),
+					     PCI_FUNC(pdev_link->devfn));
+	}
+
+	return len;
+}
+
+/* P2P link sysfs attribute. */
+static struct device_attribute dev_attr_p2p_link =
+	__ATTR(p2p_link, 0444, p2p_link_show, NULL);
+
+static struct attribute *pcie_port_p2p_link_attrs[] = {
+	&dev_attr_p2p_link.attr,
+	NULL
+};
+
+static umode_t pcie_port_p2p_link_attrs_is_visible(struct kobject *kobj,
+						   struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	if (!pcie_port_is_p2p_supported(pdev))
+		return 0;
+
+	return a->mode;
+}
+
+const struct attribute_group pcie_port_p2p_link_attr_group = {
+	.attrs = pcie_port_p2p_link_attrs,
+	.is_visible = pcie_port_p2p_link_attrs_is_visible,
+};
+
 /**
  * release_pcie_device - free PCI Express port service device structure
  * @dev: Port service device to release
@@ -715,6 +844,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 		pm_runtime_allow(&dev->dev);
 	}
 
+	sysfs_update_group(&dev->dev.kobj, &pcie_port_p2p_link_attr_group);
+
 	return 0;
 }
 
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 12c89ea0313b..1be06cb45665 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -25,6 +25,16 @@
 
 #define PCIE_PORT_DEVICE_MAXSERVICES   5
 
+/* P2P Link supported device IDs */
+#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC	0xC030
+#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC	0xC034
+
+#define PCIE_BRCM_SW_P2P_VSEC_ID		0x1
+#define PCIE_BRCM_SW_P2P_MODE_VSEC_OFFSET	0xC
+#define PCIE_BRCM_SW_P2P_MODE_MASK		GENMASK(9, 8)
+#define PCIE_BRCM_SW_P2P_MODE_INTER_SW_LINK	0x2
+#define PCIE_BRCM_SW_IS_SECURE_PART(dsn)	((dsn) & 0x8)
+
 extern bool pcie_ports_dpc_native;
 
 #ifdef CONFIG_PCIEAER
-- 
2.43.0



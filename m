Return-Path: <linux-kernel+bounces-279909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4960194C347
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C16283194
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A12190663;
	Thu,  8 Aug 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hUbxCA2q"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C618E036
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136571; cv=none; b=YzOqGlQWLfdQ0WLPqsCHgB5Jsy7k6eF56H7aAeMmo0WSaZbmY8WuWTp5lhW5KExsLzNJLANhg+JrdluY+MbtDeIMadTjCWB4lF9SAwyTGjeOWgU00GpeopPYlRDRoLKdQxu4SIVIEFKHZZtIO1WbxD7K9Gw+L3xNDHjEWI7pxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136571; c=relaxed/simple;
	bh=Qie1VXxEbR6wPvVHaQ4xDFbr377DcfR014QfK2iKOJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qteq/JwwgjAozKeury+zCwc89eoaYLDgZ+k2T0SW3OntE3yqhQI32LF1/kvZrjIj1yiNPplDL0ulFcnifRccfjbmG5NcOLzx0t4Tqym3rv7BvGGSJvCQPMnsD988mARJi3m+gqrxI7QZqUQQgN1gpksH7Ur9UUDJWc/t53tyR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hUbxCA2q; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db1d0fca58so796508b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723136569; x=1723741369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnm4IZp9BOFX/7ai0UmZ2uPZFN91S/3iwZ4ZNMA3KWI=;
        b=hUbxCA2qn0wBGHdQ1yrHaYtOrA6nC87o4WkDnPYJCpcipZRrCdopNwOLcN7T2GO/4N
         NTUcLZfrBap3+y5VKch5ZBmUGdgUMdnEoKEb2PxKBY9CJxcZbDNZM+RrzWK1Pd0eQ/Mq
         grQZiJeDab8pfHTSfKXk2ccSOJQdO0wvGufO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723136569; x=1723741369;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnm4IZp9BOFX/7ai0UmZ2uPZFN91S/3iwZ4ZNMA3KWI=;
        b=BWVKhKUsgYAsHgrFa/DloGldP3pTxz9C8eqLBQrIPukp76T9/sadtlLnAghuSnXXi3
         mU5uhEmBTwMaxSuIiUX2C8FaflrQ9aK+QDU1j5Yvwb7YqVx8Ih2XNn8lYB/M/hFJp6oz
         8wb99D1a8iVOfV1bWlDX1jXx9I4QQVjJSEyR1VhozS9z7lBGfnTPAa/sBiIRz+DlYiGb
         Tc8ziwmLKA1uw6tTgOnCtetH4g1vc+A7YecthokKNsQEC0UZfjfq5ypTyxuG7NqlygBk
         FMeE9nrPBGa7N4nmjpllW8aUjysQ6xjh/MX6fY2ggA5MN8NzqyA1Zbha6lOGp7+W4X9u
         JLLg==
X-Forwarded-Encrypted: i=1; AJvYcCUNnJ5C71c1HZXD4kzqPMZ1Rphodhn3pCLrYPmfHZ7skn4De1qQiTTZW0yEyFvlFJuJBryHDR4zVfo6XqZtbGe20njRsZ8tZU8/w722
X-Gm-Message-State: AOJu0YyqItlGMP+LBJ84u+INwxuIIMVhFwNma5pKeHz4ExIGNFf0muvv
	LadiYt4Iij1+SJfDc+csU36Yi4NWKzG3GRYIPGWKtHTyHxMB12kkuujAMhwbxA==
X-Google-Smtp-Source: AGHT+IF9PaStG81fRUHBiHKskkVjyHYOtTPaUZ1Nb+A26EGvcb+VOEkXPa7I47PHEDnAspxrFwoZRA==
X-Received: by 2002:a05:6808:2185:b0:3d9:2b45:1585 with SMTP id 5614622812f47-3dc3b42dea6mr2373864b6e.22.1723136562244;
        Thu, 08 Aug 2024 10:02:42 -0700 (PDT)
Received: from spinny.c.googlers.com (39.119.74.34.bc.googleusercontent.com. [34.74.119.39])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-83c07df5517sm1867706241.14.2024.08.08.10.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:02:41 -0700 (PDT)
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Thu, 08 Aug 2024 17:02:16 +0000
Subject: [PATCH v2] PCI: Detect and trust built-in Thunderbolt chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-trust-tbt-fix-v2-1-2e34a05a9186@chromium.org>
X-B4-Tracking: v=1; b=H4sIABf6tGYC/3WMyw6CMBAAf4Xs2TVQykNP/ofhUMsW9gAl20I0h
 H+3cvc4k8zsEEiYAtyzHYQ2DuznBOqSgR3NPBBynxhUrnTe5jVGWUPE+Iro+I2VK8vG9TeyrYH
 ULEJJn79nl3jkEL18zv1W/Oy/01ZggU1pqHJa131lHnYUP/E6Xb0M0B3H8QViBaZrrQAAAA==
To: Bjorn Helgaas <bhelgaas@google.com>, Rajat Jain <rajatja@google.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, iommu@lists.linux.dev, 
 Lukas Wunner <lukas@wunner.de>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Esther Shimanovich <eshimanovich@chromium.org>
X-Mailer: b4 0.13.0

Some computers with CPUs that lack Thunderbolt features use discrete
Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
chips are located within the chassis; between the root port labeled
ExternalFacingPort and the USB-C port.

These Thunderbolt PCIe devices should be labeled as fixed and trusted,
as they are built into the computer. Otherwise, security policies that
rely on those flags may have unintended results, such as preventing
USB-C ports from enumerating.

Detect the above scenario through the process of elimination.

1) Integrated Thunderbolt host controllers already have Thunderbolt
   implemented, so anything outside their external facing root port is
   removable and untrusted.

   Detect them using the following properties:

     - Most integrated host controllers have the usb4-host-interface
       ACPI property, as described here:
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers

     - Integrated Thunderbolt PCIe root ports before Alder Lake do not
       have the usb4-host-interface ACPI property. Identify those with
       their PCI IDs instead.

2) If a root port does not have integrated Thunderbolt capabilities, but
   has the ExternalFacingPort ACPI property, that means the manufacturer
   has opted to use a discrete Thunderbolt host controller that is
   built into the computer.

   This host controller can be identified by virtue of being located
   directly below an external-facing root port that lacks integrated
   Thunderbolt. Label it as trusted and fixed.

   Everything downstream from it is untrusted and removable.

The ExternalFacingPort ACPI property is described here:
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Suggested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
---
While working with devices that have discrete Thunderbolt chips, I
noticed that their internal TBT chips are inaccurately labeled as
untrusted and removable.

I've observed that this issue impacts all computers with internal,
discrete Intel JHL Thunderbolt chips, such as JHL6240, JHL6340, JHL6540,
and JHL7540, across multiple device manufacturers such as Lenovo, Dell,
and HP.

This affects the execution of any downstream security policy that
relies on the "untrusted" or "removable" flags.

I initially submitted a quirk to resolve this, which was too small in
scope, and after some discussion, Mika proposed a more thorough fix:
https://lore.kernel.org/lkml/20240510052616.GC4162345@black.fi.intel.com/#r
I refactored it and am submitting as a new patch.
---
Changes in v2:
- I clarified some comments, and made minor fixins
- I also added a more detailed description of implementation into the
  commit message
- Added Cc recipients Mike recommended
- Link to v1: https://lore.kernel.org/r/20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org
---
 drivers/pci/probe.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 144 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..8a98c4ef5511 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1629,16 +1629,149 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 		dev->is_thunderbolt = 1;
 }
 
+/*
+ * Checks if pdev is part of a PCIe switch that is directly below the
+ * specified bridge.
+ */
+static bool pcie_switch_directly_under(struct pci_dev *bridge,
+				       struct pci_dev *pdev)
+{
+	struct pci_dev *parent = pci_upstream_bridge(pdev);
+
+	/* If the device doesn't have a parent, it's not under anything.*/
+	if (!parent)
+		return false;
+
+	/*
+	 * If the device has a PCIe type, check if it is below the
+	 * corresponding PCIe switch components (if applicable). Then check
+	 * if its upstream port is directly beneath the specified bridge.
+	 */
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_UPSTREAM:
+		if (parent == bridge)
+			return true;
+		break;
+
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+			parent = pci_upstream_bridge(parent);
+			if (parent == bridge)
+				return true;
+		}
+		break;
+
+	case PCI_EXP_TYPE_ENDPOINT:
+		if (pci_pcie_type(parent) == PCI_EXP_TYPE_DOWNSTREAM) {
+			parent = pci_upstream_bridge(parent);
+			if (parent && pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
+				parent = pci_upstream_bridge(parent);
+				if (parent == bridge)
+					return true;
+			}
+		}
+		break;
+	}
+
+	return false;
+}
+
+static bool pcie_has_usb4_host_interface(struct pci_dev *pdev)
+{
+	struct fwnode_handle *fwnode;
+
+	/*
+	 * For USB4, the tunneled PCIe root or downstream ports are marked
+	 * with the "usb4-host-interface" ACPI property, so we look for
+	 * that first. This should cover most cases.
+	 */
+	fwnode = fwnode_find_reference(dev_fwnode(&pdev->dev),
+				       "usb4-host-interface", 0);
+	if (!IS_ERR(fwnode)) {
+		fwnode_handle_put(fwnode);
+		return true;
+	}
+
+	/*
+	 * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
+	 * before Alder Lake do not have the "usb4-host-interface"
+	 * property so we use their PCI IDs instead. All these are
+	 * tunneled. This list is not expected to grow.
+	 */
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
+		switch (pdev->device) {
+		/* Ice Lake Thunderbolt 3 PCIe Root Ports */
+		case 0x8a1d:
+		case 0x8a1f:
+		case 0x8a21:
+		case 0x8a23:
+		/* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
+		case 0x9a23:
+		case 0x9a25:
+		case 0x9a27:
+		case 0x9a29:
+		/* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
+		case 0x9a2b:
+		case 0x9a2d:
+		case 0x9a2f:
+		case 0x9a31:
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static bool pcie_is_tunneled(struct pci_dev *pdev)
+{
+	struct pci_dev *parent, *root;
+
+	parent = pci_upstream_bridge(pdev);
+	/* If pdev doesn't have a parent, then there's no way it is tunneled.*/
+	if (!parent)
+		return false;
+
+	root = pcie_find_root_port(pdev);
+	/* If pdev doesn't have a root, then there's no way it is tunneled.*/
+	if (!root)
+		return false;
+
+	/* Internal PCIe devices are not tunneled. */
+	if (!root->external_facing)
+		return false;
+
+	/* Anything directly behind a "usb4-host-interface" is tunneled. */
+	if (pcie_has_usb4_host_interface(parent))
+		return true;
+
+	/*
+	 * Check if this is a discrete Thunderbolt/USB4 controller that is
+	 * directly behind the non-USB4 PCIe Root Port marked as
+	 * "ExternalFacingPort". These PCIe devices are used to add Thunderbolt
+	 * capabilities to CPUs that lack integrated Thunderbolt.
+	 * These are not behind a PCIe tunnel.
+	 */
+	if (pcie_switch_directly_under(root, pdev))
+		return false;
+
+	/* PCIe devices after the discrete chip are tunneled. */
+	return true;
+}
+
 static void set_pcie_untrusted(struct pci_dev *dev)
 {
-	struct pci_dev *parent;
+	struct pci_dev *parent = pci_upstream_bridge(dev);
 
+	if (!parent)
+		return;
 	/*
-	 * If the upstream bridge is untrusted we treat this device
+	 * If the upstream bridge is untrusted we treat this device as
 	 * untrusted as well.
 	 */
-	parent = pci_upstream_bridge(dev);
-	if (parent && (parent->untrusted || parent->external_facing))
+	if (parent->untrusted)
+		dev->untrusted = true;
+
+	if (pcie_is_tunneled(dev))
 		dev->untrusted = true;
 }
 
@@ -1646,8 +1779,10 @@ static void pci_set_removable(struct pci_dev *dev)
 {
 	struct pci_dev *parent = pci_upstream_bridge(dev);
 
+	if (!parent)
+		return;
 	/*
-	 * We (only) consider everything downstream from an external_facing
+	 * We (only) consider everything tunneled below an external_facing
 	 * device to be removable by the user. We're mainly concerned with
 	 * consumer platforms with user accessible thunderbolt ports that are
 	 * vulnerable to DMA attacks, and we expect those ports to be marked by
@@ -1657,8 +1792,10 @@ static void pci_set_removable(struct pci_dev *dev)
 	 * accessible to user / may not be removed by end user, and thus not
 	 * exposed as "removable" to userspace.
 	 */
-	if (parent &&
-	    (parent->external_facing || dev_is_removable(&parent->dev)))
+	if (dev_is_removable(&parent->dev))
+		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
+
+	if (pcie_is_tunneled(dev))
 		dev_set_removable(&dev->dev, DEVICE_REMOVABLE);
 }
 

---
base-commit: 3f386cb8ee9f04ff4be164ca7a1d0ef3f81f7374
change-id: 20240806-trust-tbt-fix-5f337fd9ec8a

Best regards,
-- 
Esther Shimanovich <eshimanovich@chromium.org>


